// sqliteprj.cpp  (PIN 3.x, C++11)
//
// 목적
//  - 대상 이미지(기본: 이름에 "sqlite" 포함)의 모든 RTN을 "후보"로 등록
//  - 런타임 포인터 쓰기(AFTER, TLS 사용)에서 쓰인 값이 대상 이미지 .text 내부 RTN이면 매핑
//  - 전역 간접 "호출"만 감시(간접 분기/ret 제외). 타겟이 매핑된 함수일 때만 로깅
//  - caller는 프레임포인터로 복원, callsite 소스 한 줄도 기록
//  - 자식/exec 프로세스 추적(FollowChild) + 프로세스별 로그 옵션(per_process_log)
//  - 실행 시 -follow_execv 1 권장 (exec 교체 추적)
//
// 빌드:
//   g++ -std=gnu++11 -fPIC -shared 
//     -I"$PIN_ROOT/source/include/pin" -I"$PIN_ROOT/source/include/pin/gen" 
//     -o sqliteprj.so sqliteprj.cpp
//
// 실행 예(스크립트 사용, /usr/bin/sqlite3 지정):
//   $PIN_ROOT/pin -follow_execv 1 
//     -t ./sqliteprj.so -o trace.log -img_substr sqlite -per_process_log 1 -- 
//     ./sqlite_test.sh /usr/bin/sqlite3
//
// 실행 예(직접 sqlite3 실행):
//   $PIN_ROOT/pin -follow_execv 1 
//     -t ./sqliteprj.so -o trace.log -img_substr sqlite -per_process_log 1 -- 
//     /usr/bin/sqlite3 your.sql

#include "pin.H"
#include <iostream>
#include <fstream>
#include <unordered_map>
#include <unordered_set>
#include <set>
#include <map>
#include <vector>
#include <string>
#include <sstream>
#include <cstring>

using std::string;
using std::ofstream;
using std::endl;

// ---------------- KNOBs ----------------
KNOB<string> KnobOutputFile(KNOB_MODE_WRITEONCE, "pintool", "o", "sqlite3_trace.log",
                            "base output log file name");
KNOB<string> KnobImgSubstr(KNOB_MODE_WRITEONCE, "pintool", "img_substr", "sqlite",
                            "only images whose name contains this substring are analyzed");
KNOB<BOOL>   KnobPerProc(KNOB_MODE_WRITEONCE, "pintool", "per_process_log", "0",
                            "write per-process logs: <base>.PID.log");

// ---------------- Log ----------------
static ofstream Log;
static string   gLogPath;

// ---------------- 이미지/심볼 헬퍼 ----------------
struct ImgRange { ADDRINT lo=0, hi=0; };
static std::vector<ImgRange> g_target_text; // 대상 이미지(.text) 범위들

static inline bool InTargetText(ADDRINT a){
    for (auto &r : g_target_text) if (a >= r.lo && a < r.hi) return true;
    return false;
}

// ---------------- 등록된 함수 주소(심볼명) ----------------
static std::unordered_map<ADDRINT,string> g_rtn_addr2name; // 모든 RTN(디버깅용)
static std::unordered_map<ADDRINT,string> g_candidate_fn;  // 후보 함수(대상 이미지의 모든 RTN)
static inline bool IsCandidate(ADDRINT a){ return g_candidate_fn.find(a)!=g_candidate_fn.end(); }

// ---------------- "메모리 쓰기"로 확인된 매핑 ----------------
static std::unordered_set<ADDRINT> g_mapped_targets; // 간접호출 대상(함수 주소) 집합
static std::unordered_map<ADDRINT, ADDRINT> g_slot2fn; // (슬롯 주소 -> 함수 주소)

// ---------------- 소스 한줄 캐시 ----------------
static std::unordered_map<string,std::vector<string>> g_src_cache;
static inline string GetSourceLine(const string& file, INT32 line1){
    if (file.empty() || line1 <= 0) return "?";
    auto it = g_src_cache.find(file);
    if (it==g_src_cache.end()){
        std::ifstream in(file.c_str());
        if (!in.is_open()) return "?";
        std::vector<string> lines;
        string s;
        while (std::getline(in,s)) lines.push_back(s);
        g_src_cache.emplace(file, std::move(lines));
        it = g_src_cache.find(file);
    }
    auto& L = it->second;
    size_t idx = (size_t)(line1-1);
    if (idx < L.size()) return L[idx];
    return "?";
}

// ---------------- 유틸 ----------------
static string RtnNameByAddrSafe(ADDRINT a){
    string s; PIN_LockClient();
    RTN r = RTN_FindByAddress(a);
    if (RTN_Valid(r)) s = RTN_Name(r);
    PIN_UnlockClient();
    return s;
}
static void SrcByAddrSafe(ADDRINT a, string& file, INT32& line){
    int col=0; file.clear(); line=0; PIN_LockClient();
    PIN_GetSourceLocation(a, &col, &line, &file);
    PIN_UnlockClient();
}
static inline string Escape(const string& s){
    string out; out.reserve(s.size()+8);
    for(char c: s){
        if (c=='"') out.push_back('\'');
        else if (c=='\t') out.push_back(' ');
        else if (c=='\r'||c=='\n') {}
        else out.push_back(c);
    }
    return out;
}

// ---------------- 프레임포인터 기반 caller 복원 ----------------
static inline bool GetCallerByFP(ADDRINT fp, ADDRINT &retaddr, string &caller_fn){
    retaddr=0; caller_fn.clear();
#if defined(TARGET_IA32E)
    ADDRINT ra_addr = fp + 8;
#else
    ADDRINT ra_addr = fp + 4;
#endif
    ADDRINT tmp=0;
    if (PIN_SafeCopy(&tmp, (void const*)ra_addr, sizeof(ADDRINT)) != sizeof(ADDRINT)) return false;
    if (!tmp) return false;
    retaddr = tmp;
    caller_fn = RtnNameByAddrSafe(retaddr);
    if (caller_fn.empty()) caller_fn = "?";
    return true;
}

// ---------------- TLS (AFTER에서 메모리 EA/size/ip 사용하기 위함) ----------------
struct Tls {
    ADDRINT last_write_ea  = 0;
    UINT32  last_write_sz  = 0;
    ADDRINT last_ip        = 0;
};
static TLS_KEY gTlsKey;

static inline Tls* GetTls(){
    return static_cast<Tls*>(PIN_GetThreadData(gTlsKey, PIN_ThreadId()));
}

// ---------------- Process/App start (가시성 강화) ----------------
static VOID AppStart(VOID*){
    Log << "[APP_START] pid=" << PIN_GetPid() << endl;
}

// ---------------- IMAGE LOAD ----------------
static VOID ImageLoad(IMG img, VOID*){
    const string name = IMG_Name(img);
    Log << "[IMAGE_LOAD] pid=" << PIN_GetPid() << " img=" << name << endl;

    // 모든 RTN 등록(디버깅용)
    for (SEC s = IMG_SecHead(img); SEC_Valid(s); s=SEC_Next(s)){
        if (SEC_Type(s) == SEC_TYPE_EXEC){
            for (RTN r = SEC_RtnHead(s); RTN_Valid(r); r=RTN_Next(r)){
                g_rtn_addr2name[RTN_Address(r)] = RTN_Name(r);
            }
        }
    }

    // 이미지 이름 필터
    const string f = KnobImgSubstr.Value();
    if (!f.empty() && name.find(f)==string::npos) return;

    // 대상 이미지: .text 범위와 모든 RTN을 후보로 등록
    size_t before = g_candidate_fn.size();
    size_t rg_before = g_target_text.size();

    for (SEC s = IMG_SecHead(img); SEC_Valid(s); s=SEC_Next(s)){
        if (SEC_Type(s) == SEC_TYPE_EXEC){
            ImgRange rg{SEC_Address(s), SEC_Address(s)+SEC_Size(s)};
            g_target_text.push_back(rg);

            for (RTN rr = SEC_RtnHead(s); RTN_Valid(rr); rr=RTN_Next(rr)){
                ADDRINT a = RTN_Address(rr);
                string  rn = RTN_Name(rr);
                g_candidate_fn[a] = rn;         // 이름 없어도 주소로 동작
                g_rtn_addr2name[a] = rn;
            }
        }
    }

    Log << "[IMAGE_TARGET] pid=" << PIN_GetPid()
        << " name=" << name
        << " text_ranges+=" << (g_target_text.size()-rg_before)
        << " candidate_fns+=" << (g_candidate_fn.size()-before) << endl;
}

// ---------------- 메모리 쓰기: BEFORE→AFTER (TLS 이용) ----------------
static VOID OnMemWriteBefore(ADDRINT ip, ADDRINT ea, UINT32 size){
    Tls* t = GetTls();
    if (!t) return;
    t->last_ip = ip;
    t->last_write_ea = ea;
    t->last_write_sz = size;
}

static VOID OnMemWriteAfter(){
    Tls* t = GetTls();
    if (!t) return;

    ADDRINT ea = t->last_write_ea;
    UINT32  size = t->last_write_sz;
    ADDRINT ip = t->last_ip;

    // reset (재진입 안전)
    t->last_write_ea = 0;
    t->last_write_sz = 0;
    t->last_ip       = 0;

    // 포인터 크기만, 쓰여진 값 읽어와서 대상 이미지 .text 내부이고 후보 함수면 매핑
    if (size != sizeof(void*)) return;
    if (!ea) return;

    ADDRINT val=0;
    if (PIN_SafeCopy(&val, (const void*)ea, size) != size) return;
    if (!val) return;
    if (!InTargetText(val)) return;     // 대상 이미지 텍스트 밖이면 무시

    auto it = g_candidate_fn.find(val);
    if (it == g_candidate_fn.end()) return;

    g_mapped_targets.insert(val);
    g_slot2fn[ea] = val;

    string file; INT32 line=0; SrcByAddrSafe(ip, file, line);
    Log << "[MAP.WRITE]"
        << " pid="      << PIN_GetPid()
        << " slot=0x"   << std::hex << ea
        << " fn=0x"     << val << std::dec
        << " name="     << (it->second.empty() ? "?" : it->second);
    if (!file.empty() && line>0){
        Log << " src=" << file << ":" << line;
    }
    Log << endl;
}

// ---------------- 간접호출: 매핑된 타겟만 로깅 ----------------
#if defined(TARGET_IA32E)
static VOID OnIndirectCall(ADDRINT ip, ADDRINT target, ADDRINT rbp){
    if (g_mapped_targets.find(target) == g_mapped_targets.end()) return;

    string callsite = RtnNameByAddrSafe(ip); if (callsite.empty()) callsite="?";
    string file; INT32 line=0; SrcByAddrSafe(ip, file, line);
    string src = (!file.empty() && line>0) ? GetSourceLine(file,line) : "?";

    ADDRINT ret=0; string caller="?"; (void)GetCallerByFP(rbp, ret, caller);
    string callee = RtnNameByAddrSafe(target); if (callee.empty()) callee="?";

    Log << "[MAPPED.INDIRECT.CALL]"
        << " pid="        << PIN_GetPid()
        << " callsite="   << callsite
        << " caller="     << caller
        << " callee="     << callee
        << " callee_addr=0x" << std::hex << target << std::dec
        << " src_line=\"" << Escape(src) << "\""
        << endl;
}
#else
static VOID OnIndirectCall(ADDRINT ip, ADDRINT target, ADDRINT ebp){
    if (g_mapped_targets.find(target) == g_mapped_targets.end()) return;

    string callsite = RtnNameByAddrSafe(ip); if (callsite.empty()) callsite="?";
    string file; INT32 line=0; SrcByAddrSafe(ip, file, line);
    string src = (!file.empty() && line>0) ? GetSourceLine(file,line) : "?";

    ADDRINT ret=0; string caller="?"; (void)GetCallerByFP(ebp, ret, caller);
    string callee = RtnNameByAddrSafe(target); if (callee.empty()) callee="?";

    Log << "[MAPPED.INDIRECT.CALL]"
        << " pid="        << PIN_GetPid()
        << " callsite="   << callsite
        << " caller="     << caller
        << " callee="     << callee
        << " callee_addr=0x" << std::hex << target << std::dec
        << " src_line=\"" << Escape(src) << "\""
        << endl;
}
#endif

// ---------------- Instruction instrumentation ----------------
static VOID Ins(INS ins, VOID*){
    // 간접 "호출"만 감시 (ret/간접분기 제외)
    if (INS_IsCall(ins) && INS_IsIndirectControlFlow(ins)){
#if defined(TARGET_IA32E)
        INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnIndirectCall,
                       IARG_INST_PTR, IARG_BRANCH_TARGET_ADDR,
                       IARG_REG_VALUE, REG_RBP,
                       IARG_END);
#else
        INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnIndirectCall,
                       IARG_INST_PTR, IARG_BRANCH_TARGET_ADDR,
                       IARG_REG_VALUE, REG_EBP,
                       IARG_END);
#endif
    }

    // 포인터 쓰기: BEFORE에서 EA/size/ip를 TLS에 저장 → AFTER에서 사용
    if (INS_IsMemoryWrite(ins) && INS_IsStandardMemop(ins)){
        INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnMemWriteBefore,
                       IARG_INST_PTR, IARG_MEMORYWRITE_EA, IARG_MEMORYWRITE_SIZE, IARG_END);
        if (INS_HasFallThrough(ins)){
            INS_InsertCall(ins, IPOINT_AFTER, (AFUNPTR)OnMemWriteAfter, IARG_END);
        }
    }
}

// ---------------- 자식/exec 추적 ----------------
static BOOL FollowChild(CHILD_PROCESS /*child*/, VOID*){
    // 일부 Pin 배포본에는 CHILD_PROCESS_Argument* API가 없음.
    // 여기서는 모든 자식/exec을 무조건 추적.
    Log << "[FOLLOW_CHILD] pid=" << PIN_GetPid() << " -> TRUE" << endl;
    return TRUE;
}

// ---------------- Thread lifecycle ----------------
static VOID ThreadStart(THREADID tid, CONTEXT*, INT32, VOID*){
    Tls* t = new Tls();
    PIN_SetThreadData(gTlsKey, t, tid);
}
static VOID ThreadFini(THREADID tid, const CONTEXT*, INT32, VOID*){
    Tls* t = static_cast<Tls*>(PIN_GetThreadData(gTlsKey, tid));
    delete t;
}

// ---------------- Fini ----------------
static VOID Fini(INT32, VOID*){
    Log << "[STATS] pid=" << PIN_GetPid()
        << " candidates=" << g_candidate_fn.size()
        << " mapped_targets=" << g_mapped_targets.size()
        << " slots=" << g_slot2fn.size()
        << endl;
    Log.close();
}

// ---------------- Usage ----------------
static INT32 Usage(){
    std::cerr << "SQLite indirect-call tracer\n";
    std::cerr << KNOB_BASE::StringKnobSummary() << endl;
    return -1;
}

// ---------------- main ----------------
int main(int argc, char* argv[]){
    PIN_InitSymbols();

    if (PIN_Init(argc, argv)) return Usage();

    // per-process 로그 분기
    gLogPath = KnobOutputFile.Value();
    if (KnobPerProc.Value()){
        std::ostringstream oss; oss << gLogPath << "." << PIN_GetPid() << ".log";
        gLogPath = oss.str();
    }

    Log.open(gLogPath.c_str(), std::ios::out | std::ios::trunc);
    Log.setf(std::ios::unitbuf);
    if (!Log.is_open()){
        std::cerr << "cannot open output file: " << gLogPath << "\n";
        return -1;
    }
    Log << "[START] pid=" << PIN_GetPid()
        << " output=" << gLogPath
        << " img_substr=" << KnobImgSubstr.Value()
        << " per_process_log=" << (KnobPerProc.Value()?"1":"0")
        << endl;

    gTlsKey = PIN_CreateThreadDataKey(nullptr);

    PIN_AddApplicationStartFunction(AppStart, nullptr);
    IMG_AddInstrumentFunction(ImageLoad, nullptr);
    INS_AddInstrumentFunction(Ins, nullptr);
    PIN_AddThreadStartFunction(ThreadStart, nullptr);
    PIN_AddThreadFiniFunction(ThreadFini, nullptr);

    // ★ 자식/exec 추적 활성화
    PIN_AddFollowChildProcessFunction(FollowChild, nullptr);
    // exec 교체는 실행옵션 -follow_execv 1 로 반드시 켜야 함

    PIN_AddFiniFunction(Fini, nullptr);
    PIN_StartProgram();
    return 0;
}
