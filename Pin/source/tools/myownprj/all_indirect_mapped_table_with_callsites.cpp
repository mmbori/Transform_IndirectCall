// myownprj_all_indirect_mapped_table_with_callsites.cpp
// PIN 3.x (C++11)
//
// 기능 요약
// 1) 전역 indirect call 감시 + init 단계에서 맵핑된 함수(target)일 때만 [mapped.indirect.call] 로깅
// 2) init 단계 포인터 쓰기에서 맵핑 테이블(addr -> {fn_name,img,observed_data_ptrs}) 구축
// 3) [중요] [mapped.indirect.call]이 발생할 때의 caller 함수 이름을 모두 수집
//    → Fini 시 "callsite_list.txt" 파일로 유니크한 함수명 목록을 정렬하여 출력
//
// 빌드 예시:
//   g++ -std=gnu++11 -fPIC -shared \
//     -I"$PIN_ROOT/source/include/pin" -I"$PIN_ROOT/source/include/pin/gen" \
//     -o myownprj_all_indirect_mapped_table_with_callsites.so \
//     myownprj_all_indirect_mapped_table_with_callsites.cpp
//
// 실행 예시:
//   $PIN_ROOT/pin -t ./myownprj_all_indirect_mapped_table_with_callsites.so -o trace.log -- \
//     /path/to/lighttpd -D -f /path/to/lighttpd.conf
//
#include "pin.H"
#include <iostream>
#include <fstream>
#include <unordered_map>
#include <unordered_set>
#include <set>
#include <string>
#include <cstring>
#include <sstream>

using std::string;
using std::ofstream;
using std::endl;

// ---------------- CLI ----------------
KNOB<string> KnobOut(KNOB_MODE_WRITEONCE, "pintool", "o", "lighttpd_trace.log",
                     "output log file");

// ---------------- Globals ----------------
static ofstream Log;

// [NEW] [mapped.indirect.call]을 발생시킨 caller 함수 이름 모음 (중복 제거, 정렬 출력)
static std::set<string> g_mapped_callsite_callers;
static PIN_LOCK gCallsiteLock;

// ---------- Safe helpers ----------
static inline bool starts_with(const string& s, const char* pre) {
    size_t n = std::strlen(pre);
    return s.size() >= n && 0 == s.compare(0, n, pre);
}
static inline bool ends_with(const string& s, const char* suf) {
    size_t n = std::strlen(suf);
    return s.size() >= n && 0 == s.compare(s.size()-n, n, suf);
}
static string ImgNameByAddrSafe(ADDRINT a) {
    string s; PIN_LockClient();
    IMG i = IMG_FindByAddress(a); if (IMG_Valid(i)) s = IMG_Name(i);
    PIN_UnlockClient(); return s;
}
static string RtnNameByAddrSafe(ADDRINT a) {
    string s; PIN_LockClient();
    RTN r = RTN_FindByAddress(a); if (RTN_Valid(r)) s = RTN_Name(r);
    PIN_UnlockClient(); return s;
}
static void SrcByAddrSafe(ADDRINT a, std::string& file, INT32& line) {
    INT32 col = 0; file.clear(); line = 0; PIN_LockClient();
    PIN_GetSourceLocation(a, &col, &line, &file);
    PIN_UnlockClient();
}
static std::string SafeCStr(ADDRINT p, size_t maxlen=256) {
    if (!p) return std::string("<null>");
    char buf[256]; size_t i = 0;
    for (; i + 1 < maxlen; ++i) {
        if (PIN_SafeCopy(&buf[i], (const void*)(p + i), 1) != 1) break;
        if (buf[i] == '\0') break;
    }
    buf[i] = '\0'; return std::string(buf);
}

// ---------------- Symbol cache ----------------
static std::unordered_map<ADDRINT,string> g_sym_by_addr; // addr -> "fn@img"
static std::unordered_map<string,ADDRINT> g_addr_by_sym; // "fn@img" -> addr
static void RecordSymbol(ADDRINT a){
    if (!a) return;
    if (g_sym_by_addr.find(a)!=g_sym_by_addr.end()) return;
    string fn = RtnNameByAddrSafe(a);
    string img= ImgNameByAddrSafe(a);
    if (fn.empty()) return;
    string key = fn + "@" + img;
    g_sym_by_addr[a] = key;
    g_addr_by_sym[key] = a;
    Log << "[sym.record] addr=0x" << std::hex << a << std::dec
        << " fn=" << fn << " img=" << img << endl;
}

// ---------------- Mapped function table ----------------
struct MappedInfo {
    ADDRINT fn_addr = 0;
    string  fn_name;
    string  fn_img;
    std::unordered_set<ADDRINT> observed_data_ptrs;
};
static std::unordered_map<ADDRINT, MappedInfo> g_mapped; // addr -> info
static inline bool IsMapped(ADDRINT a){ return g_mapped.find(a) != g_mapped.end(); }

static void AddOrUpdateMapped(ADDRINT fn_addr){
    if (!fn_addr) return;
    RecordSymbol(fn_addr);
    string name = RtnNameByAddrSafe(fn_addr);
    string img  = ImgNameByAddrSafe(fn_addr);
    auto it = g_mapped.find(fn_addr);
    if (it == g_mapped.end()){
        MappedInfo mi; mi.fn_addr = fn_addr; mi.fn_name = name; mi.fn_img = img;
        g_mapped.insert(std::make_pair(fn_addr, mi));
    } else {
        if (it->second.fn_name.empty()) it->second.fn_name = name;
        if (it->second.fn_img.empty())  it->second.fn_img  = img;
    }
    Log << "[mapped.add] fn=0x" << std::hex << fn_addr << std::dec
        << " name=" << (name.empty()?"?":name)
        << " img="  << (img.empty() ?"?":img) << endl;
}

// ---------------- Thread-Local ----------------
struct TLS {
    bool    in_plugin_init = false; // mod_*_plugin_init() 내부 여부
    ADDRINT cur_init_addr  = 0;     // 현재 init 함수 주소
    ADDRINT cur_p          = 0;     // init의 plugin* p 인자

    // 메모리 쓰기 (BEFORE→AFTER) 페어
    ADDRINT last_write_ea  = 0;
    UINT32  last_write_sz  = 0;
};
static TLS_KEY gTLS;
static TLS* T(){ return static_cast<TLS*>(PIN_GetThreadData(gTLS, PIN_ThreadId())); }

// ---------------- dlsym/dlopen (선택) ----------------
static VOID DlsymAfter(ADDRINT ret, ADDRINT handle, ADDRINT sym_cstr){
    std::string s = SafeCStr(sym_cstr);
    Log << "[dlsym.after] sym=" << s
        << " handle=0x" << std::hex << handle
        << " rtn=0x"    << ret << std::dec;
    if (ret){
        RecordSymbol(ret);
        string fn = RtnNameByAddrSafe(ret);
        if (starts_with(fn, "mod_") && ends_with(fn, "_plugin_init")){
            AddOrUpdateMapped(ret); // init자체도 기록(선택)
        }
        Log << " fn=" << fn << " img=" << ImgNameByAddrSafe(ret);
    }
    Log << endl;
}
static VOID DlopenAfter(ADDRINT ret, ADDRINT path_cstr, ADDRINT flags){
    std::string p = SafeCStr(path_cstr);
    Log << "[dlopen.after] path=" << p << " flags=0x" << std::hex << flags
        << " handle=0x" << ret << std::dec << endl;
}

// ---------------- init enter/leave ----------------
static VOID OnPluginInitEnter(ADDRINT init_addr, ADDRINT pptr){
    TLS* t = T();
    t->in_plugin_init = true; t->cur_init_addr = init_addr; t->cur_p = pptr;
    RecordSymbol(init_addr);
    Log << "[plugin.init.enter] init=0x" << std::hex << init_addr << std::dec
        << " fn=" << RtnNameByAddrSafe(init_addr)
        << " img="<< ImgNameByAddrSafe(init_addr)
        << " p=0x" << std::hex << pptr << std::dec << endl;
}
static VOID OnPluginInitLeave(){
    Log << "[plugin.init.leave]" << endl;
    TLS* t = T();
    t->in_plugin_init = false;
    t->cur_init_addr = 0;
    t->cur_p = 0;
}

// ---------------- init 중 포인터 쓰기 감시 → 맵핑 테이블 구축 ----------------
static VOID OnMemWriteBefore(ADDRINT ea, UINT32 size){
    TLS* t = T(); if (!t->in_plugin_init) return;
    t->last_write_ea = ea; t->last_write_sz = size;
}
static VOID OnMemWriteAfter(){
    TLS* t = T(); if (!t->in_plugin_init) return;

    ADDRINT ea = t->last_write_ea; UINT32 sz = t->last_write_sz;
    if (!ea || !sz) return;
#if defined(TARGET_IA32E)
    if (sz != 8) return;   // 64-bit 포인터만 수집
#else
    if (sz != 4) return;   // 32-bit 포인터만 수집
#endif
    const ADDRINT p = t->cur_p; if (!p) return;
    const size_t RANGE = 4096; // plugin 구조체 근방만 허용(노이즈 억제)
    if (ea < p || ea >= p + RANGE) return;

    ADDRINT val = 0;
    if (PIN_SafeCopy(&val, (const void*)ea, sz) != sz) return;
    if (!val) return;

    // 함수 주소로 보이면 맵 테이블에 저장
    AddOrUpdateMapped(val);

    std::string src; INT32 line=0; SrcByAddrSafe(val, src, line);
    Log << "[plugin.map.write]"
        << " EA=0x"   << std::hex << ea << std::dec
        << " VAL=0x"  << std::hex << val << std::dec
        << " init_fn="<< RtnNameByAddrSafe(t->cur_init_addr)
        << " fn="     << RtnNameByAddrSafe(val)
        << " img="    << ImgNameByAddrSafe(val);
    if (!src.empty()) Log << " src=" << src << ":" << line;
    Log << endl;

    t->last_write_ea = 0; t->last_write_sz = 0;
}

// ---------------- 간접 호출 로깅(맵핑 대상만) + caller 함수명 수집 ----------------
static inline void AppendArgKV(std::ostringstream& oss, const char* k, ADDRINT v){
    oss << " " << k << "=0x" << std::hex << v << std::dec;
}

#if defined(TARGET_IA32E)
// SysV x86-64: rdi,rsi,rdx,rcx,r8,r9 + stack
static VOID OnAnyIndirectCallBefore(
    ADDRINT ip, ADDRINT target, ADDRINT mem_ea,
    ADDRINT rdi, ADDRINT rsi, ADDRINT rdx,
    ADDRINT rcx, ADDRINT r8,  ADDRINT r9,
    ADDRINT rsp)
{
    if (!IsMapped(target)) return; // ★ 맵핑된 타겟만 처리

    // [NEW] caller 함수명 수집
    string caller_fn = RtnNameByAddrSafe(ip);
    if (caller_fn.empty()) caller_fn = "?";
    GetLock(&gCallsiteLock, 1);
    g_mapped_callsite_callers.insert(caller_fn);
    ReleaseLock(&gCallsiteLock);

    // 선택: 관측된 data 포인터(rsi) 테이블에 누적
    auto it = g_mapped.find(target);
    if (it != g_mapped.end()) it->second.observed_data_ptrs.insert(rsi);

    std::ostringstream oss;
    oss << "[mapped.indirect.call]"
        << " caller_ip=0x" << std::hex << ip << std::dec
        << " caller_fn="   << caller_fn
        << " caller_img="  << (ImgNameByAddrSafe(ip).empty()? "?" : ImgNameByAddrSafe(ip))
        << " callee=0x"    << std::hex << target << std::dec
        << " callee_fn="   << (RtnNameByAddrSafe(target).empty()? "?" : RtnNameByAddrSafe(target))
        << " callee_img="  << (ImgNameByAddrSafe(target).empty()? "?" : ImgNameByAddrSafe(target));
    if (mem_ea) oss << " fptr_mem_ea=0x" << std::hex << mem_ea << std::dec;

    AppendArgKV(oss, "arg0_rdi", rdi);
    AppendArgKV(oss, "arg1_rsi", rsi);
    AppendArgKV(oss, "arg2_rdx", rdx);
    AppendArgKV(oss, "arg3_rcx", rcx);
    AppendArgKV(oss, "arg4_r8",  r8);
    AppendArgKV(oss, "arg5_r9",  r9);

    // stack의 top 몇 칸 덤프(참고용)
    ADDRINT stk[4] = {};
    if (rsp) PIN_SafeCopy(stk, (VOID*)rsp, sizeof(stk));
    AppendArgKV(oss, "stack0", stk[0]);
    AppendArgKV(oss, "stack1", stk[1]);
    AppendArgKV(oss, "stack2", stk[2]);
    AppendArgKV(oss, "stack3", stk[3]);

    Log << oss.str() << endl;
}
#else
// x86-32 (cdecl/EABI 다양) — 상위 4개만 스냅샷
static VOID OnAnyIndirectCallBefore(
    ADDRINT ip, ADDRINT target, ADDRINT mem_ea,
    ADDRINT esp, ADDRINT a0, ADDRINT a1, ADDRINT a2, ADDRINT a3)
{
    if (!IsMapped(target)) return;

    string caller_fn = RtnNameByAddrSafe(ip);
    if (caller_fn.empty()) caller_fn = "?";
    GetLock(&gCallsiteLock, 1);
    g_mapped_callsite_callers.insert(caller_fn);
    ReleaseLock(&gCallsiteLock);

    auto it = g_mapped.find(target);
    if (it != g_mapped.end()) it->second.observed_data_ptrs.insert(a1); // 2번째 인자를 data로 추정

    std::ostringstream oss;
    oss << "[mapped.indirect.call]"
        << " caller_ip=0x" << std::hex << ip << std::dec
        << " caller_fn="   << caller_fn
        << " caller_img="  << (ImgNameByAddrSafe(ip).empty()? "?" : ImgNameByAddrSafe(ip))
        << " callee=0x"    << std::hex << target << std::dec
        << " callee_fn="   << (RtnNameByAddrSafe(target).empty()? "?" : RtnNameByAddrSafe(target))
        << " callee_img="  << (ImgNameByAddrSafe(target).empty()? "?" : ImgNameByAddrSafe(target));
    if (mem_ea) oss << " fptr_mem_ea=0x" << std::hex << mem_ea << std::dec;

    AppendArgKV(oss, "esp",  esp);
    AppendArgKV(oss, "arg0", a0);
    AppendArgKV(oss, "arg1", a1);
    AppendArgKV(oss, "arg2", a2);
    AppendArgKV(oss, "arg3", a3);

    Log << oss.str() << endl;
}
#endif

// ---------------- Instrumentation ----------------
static VOID ImageLoad(IMG img, VOID*){
    Log << "[IMG_LOAD] " << IMG_Name(img) << (IMG_IsMainExecutable(img)?" (main)":"") << endl;

    // dlsym/dlopen 후킹 (선택)
    RTN r = RTN_FindByName(img, "dlsym");
    if (RTN_Valid(r)){
        RTN_Open(r);
        RTN_InsertCall(r, IPOINT_AFTER, (AFUNPTR)DlsymAfter,
                       IARG_FUNCRET_EXITPOINT_VALUE,
                       IARG_FUNCARG_ENTRYPOINT_VALUE, 0, // handle
                       IARG_FUNCARG_ENTRYPOINT_VALUE, 1, // sym
                       IARG_END);
        RTN_Close(r);
        Log << "[hook] dlsym in " << IMG_Name(img) << endl;
    }
    r = RTN_FindByName(img, "dlopen");
    if (RTN_Valid(r)){
        RTN_Open(r);
        RTN_InsertCall(r, IPOINT_AFTER, (AFUNPTR)DlopenAfter,
                       IARG_FUNCRET_EXITPOINT_VALUE,
                       IARG_FUNCARG_ENTRYPOINT_VALUE, 0,
                       IARG_FUNCARG_ENTRYPOINT_VALUE, 1,
                       IARG_END);
        RTN_Close(r);
        Log << "[hook] dlopen in " << IMG_Name(img) << endl;
    }

    // mod_*_plugin_init 후킹 (init enter/leave)
    for (SEC s = IMG_SecHead(img); SEC_Valid(s); s = SEC_Next(s)) {
        for (RTN rr = SEC_RtnHead(s); RTN_Valid(rr); rr = RTN_Next(rr)) {
            string rn = RTN_Name(rr);
            if (starts_with(rn,"mod_") && ends_with(rn,"_plugin_init")){
                ADDRINT a = RTN_Address(rr);
                RecordSymbol(a);
                Log << "[plugin.init.sym] fn=" << rn
                    << " addr=0x" << std::hex << a << std::dec
                    << " img=" << IMG_Name(img) << endl;

                RTN_Open(rr);
                RTN_InsertCall(rr, IPOINT_BEFORE, (AFUNPTR)OnPluginInitEnter,
                               IARG_ADDRINT, (ADDRINT)a,
                               IARG_FUNCARG_ENTRYPOINT_VALUE, 0, // plugin* p
                               IARG_END);
                RTN_InsertCall(rr, IPOINT_AFTER,  (AFUNPTR)OnPluginInitLeave, IARG_END);
                RTN_Close(rr);
            }
        }
    }
}

static VOID Ins(INS ins, VOID*){
    // 전역 indirect calls 감시 → "맵핑된 타겟"일 때만 OnAnyIndirectCallBefore가 로깅
    if (INS_IsCall(ins) && INS_IsIndirectControlFlow(ins)) {
        const BOOL has_mem = INS_IsMemoryRead(ins);
#if defined(TARGET_IA32E)
        if (has_mem){
            INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnAnyIndirectCallBefore,
                IARG_INST_PTR, IARG_BRANCH_TARGET_ADDR, IARG_MEMORYREAD_EA,
                IARG_REG_VALUE, REG_RDI, IARG_REG_VALUE, REG_RSI,
                IARG_REG_VALUE, REG_RDX, IARG_REG_VALUE, REG_RCX,
                IARG_REG_VALUE, REG_R8,  IARG_REG_VALUE, REG_R9,
                IARG_REG_VALUE, REG_RSP, IARG_END);
        } else {
            INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnAnyIndirectCallBefore,
                IARG_INST_PTR, IARG_BRANCH_TARGET_ADDR, IARG_ADDRINT, (ADDRINT)0,
                IARG_REG_VALUE, REG_RDI, IARG_REG_VALUE, REG_RSI,
                IARG_REG_VALUE, REG_RDX, IARG_REG_VALUE, REG_RCX,
                IARG_REG_VALUE, REG_R8,  IARG_REG_VALUE, REG_R9,
                IARG_REG_VALUE, REG_RSP, IARG_END);
        }
#else
        if (has_mem){
            INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnAnyIndirectCallBefore,
                IARG_INST_PTR, IARG_BRANCH_TARGET_ADDR, IARG_MEMORYREAD_EA,
                IARG_REG_VALUE, REG_ESP,
                IARG_ADDRINT,0, IARG_ADDRINT,0, IARG_ADDRINT,0, IARG_END);
        } else {
            INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnAnyIndirectCallBefore,
                IARG_INST_PTR, IARG_BRANCH_TARGET_ADDR, IARG_ADDRINT,(ADDRINT)0,
                IARG_REG_VALUE, REG_ESP,
                IARG_ADDRINT,0, IARG_ADDRINT,0, IARG_ADDRINT,0, IARG_END);
        }
#endif
    }

    // init 중 포인터 쓰기 감시(테이블 구축)
    if (!INS_IsMemoryWrite(ins)) return;
    if (!INS_IsStandardMemop(ins)) return;
    if (INS_IsCall(ins) || INS_IsBranch(ins) || INS_IsRet(ins)
     || INS_IsSyscall(ins) || INS_IsInterrupt(ins)) return;

    INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnMemWriteBefore,
                   IARG_MEMORYWRITE_EA, IARG_MEMORYWRITE_SIZE, IARG_END);
    if (INS_HasFallThrough(ins)) {
        INS_InsertCall(ins, IPOINT_AFTER, (AFUNPTR)OnMemWriteAfter, IARG_END);
    }
}

// ---------------- Thread/Fini ----------------
static VOID ThreadStart(THREADID tid, CONTEXT*, INT32, VOID*){
    TLS* t = new TLS(); PIN_SetThreadData(gTLS, t, tid);
}
static VOID ThreadFini(THREADID, const CONTEXT*, INT32, VOID*){
    TLS* t = T(); delete t;
}
static VOID Fini(INT32, VOID*){
    // 맵핑 테이블 요약
    Log << "[mapped.summary.begin]" << endl;
    for (auto &kv : g_mapped){
        const MappedInfo& mi = kv.second;
        Log << " fn=0x" << std::hex << mi.fn_addr << std::dec
            << " name=" << mi.fn_name
            << " img="  << mi.fn_img
            << " data_ptrs={";
        bool first=true;
        for (auto p : mi.observed_data_ptrs){
            Log << (first?"":",") << "0x" << std::hex << p << std::dec;
            first=false;
        }
        Log << "}" << endl;
    }
    Log << "[mapped.summary.end]" << endl;

    // [NEW] callsite_list.txt로 caller 함수명 목록 저장
    {
        std::ofstream ofs("callsite_list.txt", std::ios::out | std::ios::trunc);
        if (ofs.is_open()){
            for (const auto& name : g_mapped_callsite_callers){
                ofs << name << "\n";
            }
            ofs.close();
            Log << "[callsite.write] wrote " << g_mapped_callsite_callers.size()
                << " callers -> callsite_list.txt" << endl;
        } else {
            Log << "[callsite.write.error] cannot open callsite_list.txt" << endl;
        }
    }

    Log << "[fini]" << endl;
    Log.close();
}

// ---------------- main ----------------
int main(int argc, char* argv[]){
    if (PIN_Init(argc, argv)) return 1;
    Log.open(KnobOut.Value().c_str());
    Log.setf(std::ios::unitbuf);
    PIN_InitSymbols();
    gTLS = PIN_CreateThreadDataKey(nullptr);

    // [NEW] caller 집합 보호 락 초기화
    PIN_InitLock(&gCallsiteLock);

    IMG_AddInstrumentFunction(ImageLoad, nullptr);
    INS_AddInstrumentFunction(Ins, nullptr);
    PIN_AddThreadStartFunction(ThreadStart, nullptr);
    PIN_AddThreadFiniFunction(ThreadFini, nullptr);
    PIN_AddFiniFunction(Fini, nullptr);

    Log << "[start] output=" << KnobOut.Value() << endl;
    PIN_StartProgram();
    return 0;
}
