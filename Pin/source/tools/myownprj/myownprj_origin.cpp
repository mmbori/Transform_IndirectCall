// myownprj_mapped_callsites.cpp
// PIN 3.x (C++11)
//
// 기능 요약
// 1) mod_*_plugin_init() 실행 중 plugin* p 주변의 포인터 쓰기를 감시해,
//    간접 호출 대상이 되는 "매핑된 함수" 테이블(addr -> {name,img})을 구축한다.
// 2) 프로그램 전체의 모든 indirect call을 감시하되, target이 위 매핑 테이블에 있을 때만 기록한다.
// 3) 그때의 caller 함수 이름을 집합에 축적해두고, Fini 시 callsite_list.txt로 유니크 목록을 출력한다.
//
// 빌드 예시:
//   g++ -std=gnu++11 -fPIC -shared
//     -I"$PIN_ROOT/source/include/pin" -I"$PIN_ROOT/source/include/pin/gen"
//     -o myownprj_mapped_callsites.so myownprj_mapped_callsites.cpp
//
// 실행 예시:
//   $PIN_ROOT/pin -t ./myownprj_mapped_callsites.so -o trace.log -- 
//     /path/to/lighttpd -D -f /path/to/lighttpd.conf

#include "pin.H"
#include <iostream>
#include <fstream>
#include <unordered_map>
#include <unordered_set>
#include <set>
#include <string>
#include <sstream>
#include <cstring>

using std::string;
using std::ofstream;
using std::endl;

// ---------------- CLI ----------------
KNOB<string> KnobOut(KNOB_MODE_WRITEONCE, "pintool", "o", "lighttpd_trace.log",
                     "output log file");

// ---------------- Globals ----------------
static ofstream Log;

// 매핑된 함수 테이블: addr -> {fn_name, img}
struct MappedInfo {
    ADDRINT fn_addr = 0;
    string  fn_name;
    string  fn_img;
};
static std::unordered_map<ADDRINT, MappedInfo> g_mapped; // addr -> info
static inline bool IsMapped(ADDRINT a){ return g_mapped.find(a) != g_mapped.end(); }

// [NEW] 매핑된 함수로의 indirect call을 발생시킨 caller 함수 이름 집합
static std::set<string> g_mapped_callsite_callers;
static PIN_LOCK gCallsiteLock;

// ---------------- Helpers ----------------
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
static void RecordSymbol(ADDRINT a){
    if (!a) return;
    (void)RtnNameByAddrSafe(a); (void)ImgNameByAddrSafe(a); // lazy cache only
}

// ---------------- TLS ----------------
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

// ---------------- Mapped funcs: add/update ----------------
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
            AddOrUpdateMapped(ret); // (선택) init자체도 기록
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

// ---------------- init 중 포인터 쓰기 감시 → 매핑 테이블 구축 ----------------
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

    // 함수 주소로 보이면 매핑 테이블에 저장
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

// ---------------- 간접 호출 모니터링 (매핑 대상만 선별) ----------------
static inline void AppendArgKV(std::ostringstream& oss, const char* k, ADDRINT v){
    oss << " " << k << "=0x" << std::hex << v << std::dec;
}

#if defined(TARGET_IA32E)
// x86-64 SysV: rdi,rsi,rdx,rcx,r8,r9 + stack
static VOID OnAnyIndirectCallBefore(
    ADDRINT ip, ADDRINT target, ADDRINT mem_ea,
    ADDRINT rdi, ADDRINT rsi, ADDRINT rdx,
    ADDRINT rcx, ADDRINT r8,  ADDRINT r9,
    ADDRINT rsp)
{
    if (!IsMapped(target)) return; // ★ 매핑된 타겟만 처리

    // caller 함수명 집합에 추가 (중복 제거; 스레드 안전)
    string caller_fn = RtnNameByAddrSafe(ip);
    if (caller_fn.empty()) caller_fn = "?";
    PIN_GetLock(&gCallsiteLock, PIN_ThreadUid());
    g_mapped_callsite_callers.insert(caller_fn);
    PIN_ReleaseLock(&gCallsiteLock);

    // 참고용 로깅 (원하면 줄여도 됨)
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

    Log << oss.str() << endl;
}
#else
// x86-32 (cdecl 등) — 상위 4개만 스냅샷
static VOID OnAnyIndirectCallBefore(
    ADDRINT ip, ADDRINT target, ADDRINT mem_ea,
    ADDRINT esp, ADDRINT a0, ADDRINT a1, ADDRINT a2, ADDRINT a3)
{
    if (!IsMapped(target)) return;

    string caller_fn = RtnNameByAddrSafe(ip);
    if (caller_fn.empty()) caller_fn = "?";
    PIN_GetLock(&gCallsiteLock, PIN_ThreadUid());
    g_mapped_callsite_callers.insert(caller_fn);
    PIN_ReleaseLock(&gCallsiteLock);

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

    // dlsym/dlopen (선택)
    RTN r = RTN_FindByName(img, "dlsym");
    if (RTN_Valid(r)){
        RTN_Open(r);
        RTN_InsertCall(r, IPOINT_AFTER, (AFUNPTR)DlsymAfter,
                       IARG_FUNCRET_EXITPOINT_VALUE,
                       IARG_FUNCARG_ENTRYPOINT_VALUE, 0,
                       IARG_FUNCARG_ENTRYPOINT_VALUE, 1,
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

    // mod_*_plugin_init 훅 (enter/leave와 plugin* p 추출)
    for (SEC s = IMG_SecHead(img); SEC_Valid(s); s = SEC_Next(s)) {
        for (RTN rr = SEC_RtnHead(s); RTN_Valid(rr); rr = RTN_Next(rr)) {
            string rn = RTN_Name(rr);
            if (starts_with(rn,"mod_") && ends_with(rn,"_plugin_init")){
                ADDRINT a = RTN_Address(rr);
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

// 간접 호출 + init 단계 포인터 쓰기 감시
static VOID Ins(INS ins, VOID*){
    // (A) 모든 간접 호출 감시 → "매핑된 타겟"일 때만 로깅 및 caller 수집
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

    // (B) init 중 포인터 쓰기 감시 → 매핑 테이블 구축
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
    // caller 함수명 목록 저장
    std::ofstream ofs("callsite_list.txt", std::ios::out | std::ios::trunc);
    Log << " callsite list : " << endl;
    if (ofs.is_open()){
        for (const auto& name : g_mapped_callsite_callers){
            if (name.empty() || name=="?") continue;
            ofs << name << "\n";
            Log << name << endl;
        }
        ofs.close();
        Log << "[callsite.write] wrote " << g_mapped_callsite_callers.size()
            << " callers -> callsite_list.txt" << endl;
    } else {
        Log << "[callsite.write.error] cannot open callsite_list.txt" << endl;
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

    // caller 집합 보호 락 초기화
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



// =================================================================
// =================================================================
// =================================================================


// #include "pin.H"
// #include <iostream>
// #include <fstream>
// #include <unordered_map>
// #include <unordered_set>
// #include <vector>
// #include <string>
// #include <sstream>
// #include <cstring>
// #include <cctype>

// using std::string;
// using std::ofstream;
// using std::endl;

// // ---------------------- CLI ----------------------
// KNOB<string> KnobOut(KNOB_MODE_WRITEONCE, "pintool", "o", "lighttpd_trace.log",
//                      "output log file");
// // [ADDED] optional source tree remap: if the DWARF path differs from local
// KNOB<string> KnobSrcRoot(KNOB_MODE_WRITEONCE, "pintool", "srcroot", "",
//                          "optional override root for source paths (e.g., /home/user/lighttpd1.4_g_opt)");

// static ofstream Log;

// // ---------------------- Helpers ----------------------
// static inline bool starts_with(const string& s, const char* pre) {
//     size_t n = std::strlen(pre); return s.size() >= n && 0 == s.compare(0, n, pre);
// }
// static inline bool ends_with(const string& s, const char* suf) {
//     size_t n = std::strlen(suf); return s.size() >= n && 0 == s.compare(s.size()-n, n, suf);
// }
// static std::string SafeCStr(ADDRINT p, size_t maxlen=256) {
//     if (!p) return std::string("<null>");
//     char buf[256]; size_t i = 0;
//     for (; i + 1 < maxlen; ++i) {
//         if (PIN_SafeCopy(&buf[i], (const void*)(p + i), 1) != 1) break;
//         if (buf[i] == '\0') break;
//     }
//     buf[i] = '\0'; return std::string(buf);
// }
// static string ImgNameByAddrSafe(ADDRINT a) {
//     string s; PIN_LockClient(); IMG i = IMG_FindByAddress(a); if (IMG_Valid(i)) s = IMG_Name(i); PIN_UnlockClient(); return s;
// }
// static string RtnNameByAddrSafe(ADDRINT a) {
//     string s; PIN_LockClient(); RTN r = RTN_FindByAddress(a); if (RTN_Valid(r)) s = RTN_Name(r); PIN_UnlockClient(); return s;
// }
// static void SrcByAddrSafe(ADDRINT a, std::string& file, INT32& line) {
//     INT32 col = 0; file.clear(); line = 0; PIN_LockClient(); PIN_GetSourceLocation(a, &col, &line, &file); PIN_UnlockClient();
// }

// // [ADDED] whitespace helpers for compact one-line printing
// static inline std::string Trim(const std::string& s){ size_t b=0,e=s.size(); while(b<e && std::isspace((unsigned char)s[b])) ++b; while(e>b && std::isspace((unsigned char)s[e-1])) --e; return s.substr(b,e-b);} 
// static inline std::string CollapseWS(std::string s){ std::string o; o.reserve(s.size()); bool insp=false; for(char c: s){ if(std::isspace((unsigned char)c)){ if(!insp){ o.push_back(' '); insp=true; } } else { o.push_back(c); insp=false; } } return o; }
// static inline std::string SanitizeForLog(std::string s){ s = CollapseWS(Trim(s)); for(char& c: s){ if(c=='\t') c=' '; if(c=='\'') c='`'; } return s; }

// // [ADDED] robust source-line reader with optional -srcroot remap
// static std::string ReadSourceLine(const std::string& orig_path, INT32 line){
//     if (orig_path.empty() || line <= 0) return std::string();
//     auto try_read = [&](const std::string& p)->std::string{
//         std::ifstream in(p.c_str()); if(!in.good()) return std::string();
//         std::string cur; for(INT32 i=1;i<=line;++i){ if(!std::getline(in, cur)) return std::string(); }
//         return SanitizeForLog(cur);
//     };
//     // 1) try the original path
//     std::string s = try_read(orig_path);
//     if (!s.empty()) return s;
//     // 2) if -srcroot is provided, try to splice tail after "/src/"
//     const std::string root = KnobSrcRoot.Value();
//     if (!root.empty()){
//         std::string tail;
//         size_t pos = orig_path.find("/src/");
//         if (pos != std::string::npos) tail = orig_path.substr(pos); // include /src/...
//         else {
//             // fallback to basename
//             size_t slash = orig_path.find_last_of('/') ;
//             tail = (slash==std::string::npos) ? orig_path : orig_path.substr(slash);
//         }
//         // ensure single slash between
//         std::string remap = root;
//         if (!remap.empty() && remap.back()=='/' && !tail.empty() && tail.front()=='/') remap.pop_back();
//         remap += tail;
//         s = try_read(remap);
//         if (!s.empty()) return s;
//     }
//     return std::string();
// }

// // [ADDED] compact disasm text (underscore spaces) to keep key=value log parsable
// static std::string ReplaceSpaces(const std::string& s){ std::string o = s; for (auto &c: o) if (c==' '||c=='\t') c = '_'; return o; }

// // [ADDED] operand pretty-printers
// static std::string FormatMemOperand(INS ins){
//     std::ostringstream oss; REG base=INS_MemoryBaseReg(ins); REG idx=INS_MemoryIndexReg(ins); INT32 sc=INS_MemoryScale(ins); ADDRDELTA disp=INS_MemoryDisplacement(ins);
//     oss << "MEM:["; bool first=true; if (base!=REG_INVALID()){oss<<REG_StringShort(base); first=false;} if (idx!=REG_INVALID()){ if(!first)oss<<"+"; oss<<REG_StringShort(idx); if(sc!=0&&sc!=1)oss<<"*"<<sc; first=false;} if(disp){ if(!first)oss<<"+"; oss<<"0x"<<std::hex<<disp<<std::dec;} oss<<"]"; return oss.str();
// }
// static std::string FormatRegOperand(INS ins){
// #if defined(TARGET_IA32) || defined(TARGET_IA32E)
//     std::ostringstream oss; UINT32 n = INS_MaxNumRRegs(ins); if(n==0) return "REG:?"; if(n==1){oss<<"REG:"<<REG_StringShort(INS_RegR(ins,0)); return oss.str();} oss<<"REGS:"; for(UINT32 i=0;i<n;i++){ if(i)oss<<","; oss<<REG_StringShort(INS_RegR(ins,i)); } return oss.str();
// #else
//     return "REG:?";
// #endif
// }

// // ---------------- Symbol tables ----------------
// static std::unordered_map<ADDRINT,string> g_sym_by_addr;
// static std::unordered_map<string,ADDRINT> g_addr_by_sym;

// static void RecordSymbol(ADDRINT a){
//     if (!a) return;
//     if (g_sym_by_addr.find(a) != g_sym_by_addr.end()) return;
//     std::string fn  = RtnNameByAddrSafe(a);
//     std::string img = ImgNameByAddrSafe(a);
//     if (fn.empty()) return;
//     std::string key = fn + "@" + img;
//     g_sym_by_addr[a]  = key;
//     g_addr_by_sym[key] = a;
//     Log << "[sym.record] addr=0x" << std::hex << a << std::dec
//         << " fn=" << fn << " img=" << img << std::endl;
// }
// static void RecordIfPluginInit(ADDRINT a){ if(!a) return; string fn=RtnNameByAddrSafe(a); if(fn.empty()) return; if(starts_with(fn,"mod_") && ends_with(fn,"_plugin_init")) RecordSymbol(a); }

// // ---------------- dlsym/dlopen ----------------
// static VOID DlsymBefore(ADDRINT handle, ADDRINT sym_cstr){ std::string s=SafeCStr(sym_cstr); Log<<"[dlsym.before] handle=0x"<<std::hex<<handle<<std::dec<<" sym="<<s<<endl; }
// static VOID DlsymAfter(ADDRINT ret, ADDRINT handle, ADDRINT sym_cstr){ std::string s=SafeCStr(sym_cstr); Log<<"[dlsym.after] handle=0x"<<std::hex<<handle<<std::dec<<" sym="<<s<<" rtn=0x"<<std::hex<<ret<<std::dec; if(ret){ RecordSymbol(ret); RecordIfPluginInit(ret); Log<<" fn="<<RtnNameByAddrSafe(ret)<<" img="<<ImgNameByAddrSafe(ret);} Log<<endl; }
// static VOID DlopenBefore(ADDRINT path_cstr, ADDRINT flags){ std::string p=SafeCStr(path_cstr); Log<<"[dlopen.before] path="<<p<<" flags=0x"<<std::hex<<flags<<std::dec<<endl; }
// static VOID DlopenAfter(ADDRINT ret, ADDRINT path_cstr, ADDRINT flags){ std::string p=SafeCStr(path_cstr); Log<<"[dlopen.after] path="<<p<<" flags=0x"<<std::hex<<flags<<" handle=0x"<<ret<<std::dec<<endl; }

// // ---------------- TLS / Ret tracking ----------------
// struct TLS {
//     bool    in_plugin_init=false; ADDRINT cur_init_addr=0; ADDRINT cur_p=0; ADDRINT last_write_ea=0; UINT32 last_write_sz=0;
//     struct RetWatch { ADDRINT retaddr; ADDRINT target; const char* tag; ADDRINT call_ip; };
//     std::vector<RetWatch> ret_stack; // match END
// };
// static TLS_KEY gTLS; static TLS* T(){ return static_cast<TLS*>(PIN_GetThreadData(gTLS, PIN_ThreadId())); }

// static VOID OnPluginInitEnter(ADDRINT init_addr, ADDRINT pptr){ TLS* t=T(); t->in_plugin_init=true; t->cur_init_addr=init_addr; t->cur_p=pptr; RecordSymbol(init_addr); RecordIfPluginInit(init_addr); Log<<"[plugin.init.enter] init=0x"<<std::hex<<init_addr<<std::dec<<" fn="<<RtnNameByAddrSafe(init_addr)<<" img="<<ImgNameByAddrSafe(init_addr)<<" p=0x"<<std::hex<<pptr<<std::dec<<endl; }
// static VOID OnPluginInitLeave(){ Log<<"[plugin.init.leave]"<<endl; TLS* t=T(); t->in_plugin_init=false; t->cur_init_addr=0; t->cur_p=0; }
// static VOID OnMemWriteBefore(ADDRINT ea, UINT32 size){ TLS* t=T(); if(!t->in_plugin_init) return; t->last_write_ea=ea; t->last_write_sz=size; }
// static VOID OnMemWriteAfter(){
//     TLS* t = T();
//     if (!t->in_plugin_init) return;
//     ADDRINT ea = t->last_write_ea;
//     UINT32  sz = t->last_write_sz;
//     if (!ea || !sz) return;
// #if defined(TARGET_IA32E)
//     if (sz != 8) return;
// #else
//     if (sz != 4) return;
// #endif
//     const ADDRINT p = t->cur_p;
//     if (!p) return;
//     const size_t RANGE = 4096;
//     if (ea < p || ea >= p + RANGE) return;

//     ADDRINT val = 0;
//     PIN_SafeCopy(&val, (const void*)ea, sz);
//     if (!val) return;
//     RecordSymbol(val);
//     std::string src; INT32 line = 0; SrcByAddrSafe(val, src, line);
//     Log << "[plugin.map.write] EA=0x" << std::hex << ea
//         << " VAL=0x" << val << std::dec
//         << " init_fn=" << RtnNameByAddrSafe(t->cur_init_addr)
//         << " fn=" << RtnNameByAddrSafe(val)
//         << " img=" << ImgNameByAddrSafe(val);
//     if (!src.empty()) Log << " src=" << src << ":" << line;
//     Log << endl;
//     t->last_write_ea = 0;
//     t->last_write_sz = 0;
// }

// // ---------------- Srv-like enter/leave ----------------
// static VOID OnSrvLikeEnter(const char* name, ADDRINT callee_addr, ADDRINT rsp){ ADDRINT retaddr=0; PIN_SafeCopy(&retaddr,(VOID*)rsp,sizeof(ADDRINT)); ADDRINT callsite = retaddr? (retaddr-1):0; Log<<"[srv.like.enter]"<<" callee="<<name<<" callee_addr=0x"<<std::hex<<callee_addr<<std::dec<<" caller_ret=0x"<<std::hex<<retaddr<<std::dec<<" callsite~=0x"<<std::hex<<callsite<<std::dec<<" caller_fn="<<RtnNameByAddrSafe(callsite)<<" caller_img="<<ImgNameByAddrSafe(callsite)<<endl; }
// static VOID OnSrvLikeLeave(const char* name){ Log<<"[srv.like.leave] callee="<<name<<endl; }

// // ---------------- Indirect call metadata ----------------
// // [CHANGED] add src_line_text to metadata and print it later
// struct IndMeta { std::string asm_clean; std::string op; std::string src_file; INT32 src_line{0}; std::string src_line_text; };
// static std::unordered_map<ADDRINT, IndMeta> g_ind_meta; // key = INS_Address (== call_ip arg)

// // ---------------- ENTER (call) / END (ret) ----------------
// static VOID OnIndirectEnter(const char* tag, ADDRINT call_ip, ADDRINT retaddr, ADDRINT target,
//                             ADDRINT a0_srv, ADDRINT a1_data, ADDRINT mem_ea){
//     RecordSymbol(target);
//     Log << "[srv.like.fn.call]" << " in=" << tag
//         << " call_ip=0x" << std::hex << call_ip << std::dec
//         << " ret_to=0x"  << std::hex << retaddr<< std::dec
//         << " target=0x"  << std::hex << target << std::dec
//         << " fn="  << RtnNameByAddrSafe(target)
//         << " img=" << ImgNameByAddrSafe(target);
// #if defined(TARGET_IA32E)
//     Log << " srv=0x" << std::hex << a0_srv  << std::dec
//         << " data=0x"<< std::hex << a1_data << std::dec;
// #endif
//     if (mem_ea) Log << " fptr_mem_ea=0x" << std::hex << mem_ea << std::dec;

//     auto it = g_ind_meta.find(call_ip);
//     if (it != g_ind_meta.end()){
//         const auto& m = it->second;
//         if (!m.asm_clean.empty()) Log << " asm=" << m.asm_clean;
//         if (!m.op.empty())        Log << " op="  << m.op;
//         if (!m.src_file.empty())  Log << " src=" << m.src_file << ":" << m.src_line;
//         if (!m.src_line_text.empty()) Log << " src_line='" << m.src_line_text << "'";
//     }
//     Log << endl;

//     TLS* t = T(); t->ret_stack.push_back({retaddr, target, tag, call_ip});
// }

// static VOID OnRetBefore(ADDRINT sp){
//     TLS* t=T(); if(t->ret_stack.empty()) return; ADDRINT retaddr=0; PIN_SafeCopy(&retaddr,(VOID*)sp,sizeof(ADDRINT)); if(!retaddr) return;
//     for(int i=(int)t->ret_stack.size()-1;i>=0;--i){
//         if(t->ret_stack[i].retaddr==retaddr){
//             auto w=t->ret_stack[i]; t->ret_stack.erase(t->ret_stack.begin()+i);
//             Log << "[srv.like.fn.ret]" << " in=" << (w.tag?w.tag:"?")
//                 << " call_ip=0x" << std::hex << w.call_ip << std::dec
//                 << " ret_to=0x"  << std::hex << w.retaddr<< std::dec
//                 << " target=0x"  << std::hex << w.target << std::dec
//                 << " fn="  << RtnNameByAddrSafe(w.target)
//                 << " img=" << ImgNameByAddrSafe(w.target);
//             auto it = g_ind_meta.find(w.call_ip);
//             if (it != g_ind_meta.end()){
//                 const auto& m = it->second;
//                 if (!m.asm_clean.empty()) Log << " asm=" << m.asm_clean;
//                 if (!m.op.empty())        Log << " op="  << m.op;
//                 if (!m.src_file.empty())  Log << " src=" << m.src_file << ":" << m.src_line;
//                 if (!m.src_line_text.empty()) Log << " src_line='" << m.src_line_text << "'";
//             }
//             Log << endl;
//             break;
//         }
//     }
// }

// // ---------------- Callsite→dispatcher logger ----------------
// static VOID OnCallsiteToSrvLike(ADDRINT ip, ADDRINT target){ Log<<"[srv.like.callsite]"<<" ip=0x"<<std::hex<<ip<<std::dec<<" target=0x"<<std::hex<<target<<std::dec<<" caller_fn="<<RtnNameByAddrSafe(ip)<<" caller_img="<<ImgNameByAddrSafe(ip)<<" callee_fn="<<RtnNameByAddrSafe(target)<<" callee_img="<<ImgNameByAddrSafe(target)<<endl; }

// // ---------------- Target registry ----------------
// struct SrvLikeFn { const char* name; ADDRINT addr; USIZE size; };
// static SrvLikeFn gTargets[] = {
//     {"plugins_call_cleanup",        0, 0},
//     {"plugins_call_fn_srv_data_all",    0, 0},
//     {"plugins_call_handle_connection_accept",        0, 0},
//     {"plugins_call_handle_connection_close",        0, 0},
//     {"plugins_call_handle_request_env",     0, 0},
//     {"plugins_call_handle_request_reset",     0, 0},
//     {"plugins_call_handle_response_start",        0, 0},
//     {"plugins_call_handle_subrequest_start",    0, 0},
//     {"plugins_call_handle_uri_clean",        0, 0},
//     {"plugins_call_handle_waitpid",        0, 0}
// };

// // ---------------- Instrumentation ----------------
// static VOID InstrumentSrvLikeRTN(IMG img, SrvLikeFn& TGT){
//     RTN r = RTN_FindByName(img, TGT.name); if(!RTN_Valid(r)) return; TGT.addr=RTN_Address(r); TGT.size=RTN_Size(r);
//     Log<<"[srv.like.register] name="<<TGT.name<<" addr=0x"<<std::hex<<TGT.addr<<std::dec<<" size="<<TGT.size<<" img="<<ImgNameByAddrSafe(TGT.addr)<<endl;

//     RTN_Open(r);
// #if defined(TARGET_IA32E)
//     RTN_InsertCall(r, IPOINT_BEFORE, (AFUNPTR)OnSrvLikeEnter,
//                    IARG_PTR, TGT.name,
//                    IARG_ADDRINT, TGT.addr,
//                    IARG_REG_VALUE, REG_RSP,
//                    IARG_END);
//     RTN_InsertCall(r, IPOINT_AFTER, (AFUNPTR)OnSrvLikeLeave,
//                    IARG_PTR, TGT.name, IARG_END);
// #else
//     RTN_InsertCall(r, IPOINT_BEFORE, (AFUNPTR)OnSrvLikeEnter,
//                    IARG_PTR, TGT.name,
//                    IARG_ADDRINT, TGT.addr,
//                    IARG_REG_VALUE, REG_ESP,
//                    IARG_END);
//     RTN_InsertCall(r, IPOINT_AFTER, (AFUNPTR)OnSrvLikeLeave,
//                    IARG_PTR, TGT.name, IARG_END);
// #endif

//     // walk instructions to find indirect calls inside the dispatcher
//     for(INS ins = RTN_InsHead(r); INS_Valid(ins); ins = INS_Next(ins)){
//         if(!INS_IsCall(ins) || !INS_IsIndirectControlFlow(ins)) continue;
//         IndMeta meta; meta.asm_clean = ReplaceSpaces(INS_Disassemble(ins));
//         if(INS_IsMemoryRead(ins)) meta.op = FormatMemOperand(ins); else meta.op = FormatRegOperand(ins);
//         std::string file; INT32 line=0;
//         PIN_LockClient(); PIN_GetSourceLocation(INS_Address(ins), nullptr, &line, &file); PIN_UnlockClient();
//         meta.src_file = file; meta.src_line = line; meta.src_line_text = ReadSourceLine(file, line);
//         g_ind_meta[INS_Address(ins)] = std::move(meta);

//         BOOL has_mem = INS_IsMemoryRead(ins); ADDRINT nextIp = INS_NextAddress(ins);
// #if defined(TARGET_IA32E)
//         if(has_mem){
//             INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnIndirectEnter,
//                            IARG_PTR, TGT.name,
//                            IARG_INST_PTR,
//                            IARG_ADDRINT, nextIp,
//                            IARG_BRANCH_TARGET_ADDR,
//                            IARG_REG_VALUE, REG_RDI,
//                            IARG_REG_VALUE, REG_RSI,
//                            IARG_MEMORYREAD_EA,
//                            IARG_END);
//         } else {
//             INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnIndirectEnter,
//                            IARG_PTR, TGT.name,
//                            IARG_INST_PTR,
//                            IARG_ADDRINT, nextIp,
//                            IARG_BRANCH_TARGET_ADDR,
//                            IARG_REG_VALUE, REG_RDI,
//                            IARG_REG_VALUE, REG_RSI,
//                            IARG_ADDRINT, (ADDRINT)0,
//                            IARG_END);
//         }
// #else
//         if(has_mem){
//             INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnIndirectEnter,
//                            IARG_PTR, TGT.name,
//                            IARG_INST_PTR,
//                            IARG_ADDRINT, nextIp,
//                            IARG_BRANCH_TARGET_ADDR,
//                            IARG_ADDRINT, 0, IARG_ADDRINT, 0,
//                            IARG_MEMORYREAD_EA,
//                            IARG_END);
//         } else {
//             INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnIndirectEnter,
//                            IARG_PTR, TGT.name,
//                            IARG_INST_PTR,
//                            IARG_ADDRINT, nextIp,
//                            IARG_BRANCH_TARGET_ADDR,
//                            IARG_ADDRINT, 0, IARG_ADDRINT, 0,
//                            IARG_ADDRINT, (ADDRINT)0,
//                            IARG_END);
//         }
// #endif
//     }
//     RTN_Close(r);
// }

// // ---------------- IMG load ----------------
// static VOID ImageLoad(IMG img, VOID*){
//     Log<<"[IMG_LOAD] "<<IMG_Name(img)<<(IMG_IsMainExecutable(img)?" (main)":"")<<endl;

//     // dlsym hook
//     RTN r = RTN_FindByName(img, "dlsym");
//     if(RTN_Valid(r)){
//         RTN_Open(r);
//         RTN_InsertCall(r, IPOINT_BEFORE, (AFUNPTR)DlsymBefore,
//                        IARG_FUNCARG_ENTRYPOINT_VALUE, 0,
//                        IARG_FUNCARG_ENTRYPOINT_VALUE, 1,
//                        IARG_END);
//         RTN_InsertCall(r, IPOINT_AFTER, (AFUNPTR)DlsymAfter,
//                        IARG_FUNCRET_EXITPOINT_VALUE,
//                        IARG_FUNCARG_ENTRYPOINT_VALUE, 0,
//                        IARG_FUNCARG_ENTRYPOINT_VALUE, 1,
//                        IARG_END);
//         RTN_Close(r);
//         Log<<"[hook] dlsym in "<<IMG_Name(img)<<endl;
//     }

//     // dlopen hook
//     r = RTN_FindByName(img, "dlopen");
//     if(RTN_Valid(r)){
//         RTN_Open(r);
//         RTN_InsertCall(r, IPOINT_BEFORE, (AFUNPTR)DlopenBefore,
//                        IARG_FUNCARG_ENTRYPOINT_VALUE, 0,
//                        IARG_FUNCARG_ENTRYPOINT_VALUE, 1,
//                        IARG_END);
//         RTN_InsertCall(r, IPOINT_AFTER, (AFUNPTR)DlopenAfter,
//                        IARG_FUNCRET_EXITPOINT_VALUE,
//                        IARG_FUNCARG_ENTRYPOINT_VALUE, 0,
//                        IARG_FUNCARG_ENTRYPOINT_VALUE, 1,
//                        IARG_END);
//         RTN_Close(r);
//         Log<<"[hook] dlopen in "<<IMG_Name(img)<<endl;
//     }

//     // pre-scan plugin init symbols
//     for(SEC s=IMG_SecHead(img); SEC_Valid(s); s=SEC_Next(s)){
//         for(RTN rr=SEC_RtnHead(s); RTN_Valid(rr); rr=RTN_Next(rr)){
//             string rn = RTN_Name(rr);
//             if(starts_with(rn,"mod_") && ends_with(rn,"_plugin_init")){
//                 ADDRINT a = RTN_Address(rr); RecordSymbol(a);
//                 Log<<"[plugin.init.sym] fn="<<rn<<" addr=0x"<<std::hex<<a<<std::dec<<" img="<<IMG_Name(img)<<endl;
//                 RTN_Open(rr);
//                 RTN_InsertCall(rr, IPOINT_BEFORE, (AFUNPTR)OnPluginInitEnter,
//                                IARG_ADDRINT, (ADDRINT)a,
//                                IARG_FUNCARG_ENTRYPOINT_VALUE, 0,
//                                IARG_END);
//                 RTN_InsertCall(rr, IPOINT_AFTER, (AFUNPTR)OnPluginInitLeave, IARG_END);
//                 RTN_Close(rr);
//             }
//         }
//     }

//     // instrument targets
//     for(auto &TGT : gTargets) InstrumentSrvLikeRTN(img, TGT);

//     // callsites that call any of target functions
//     for(SEC s=IMG_SecHead(img); SEC_Valid(s); s=SEC_Next(s)){
//         for(RTN rr=SEC_RtnHead(s); RTN_Valid(rr); rr=RTN_Next(rr)){
//             RTN_Open(rr);
//             for(INS ins=RTN_InsHead(rr); INS_Valid(ins); ins=INS_Next(ins)){
//                 if(!INS_IsCall(ins)) continue;
//                 if(INS_IsDirectControlFlow(ins)){
//                     ADDRINT tgt = INS_DirectControlFlowTargetAddress(ins);
//                     for(auto &TGT : gTargets){ if(tgt==TGT.addr){ INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnCallsiteToSrvLike, IARG_INST_PTR, IARG_ADDRINT, tgt, IARG_END); break; } }
//                 } else if (INS_IsIndirectControlFlow(ins)) {
//                     INS_InsertCall(ins, IPOINT_BEFORE,
//                         (AFUNPTR)+[](ADDRINT ip, ADDRINT tgt){ for(auto &TGT : gTargets) if(tgt==TGT.addr){ OnCallsiteToSrvLike(ip,tgt); break; } },
//                         IARG_INST_PTR, IARG_BRANCH_TARGET_ADDR, IARG_END);
//                 }
//             }
//             RTN_Close(rr);
//         }
//     }
// }

// // ---------------- Instruction-level hooks ----------------
// static VOID InsMemWrites(INS ins, VOID*){
//     if (!INS_IsMemoryWrite(ins) || !INS_IsStandardMemop(ins)) return;
//     if (INS_IsCall(ins) || INS_IsBranch(ins) || INS_IsRet(ins) || INS_IsSyscall(ins) || INS_IsInterrupt(ins)) return;
//     INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnMemWriteBefore, IARG_MEMORYWRITE_EA, IARG_MEMORYWRITE_SIZE, IARG_END);
//     if (INS_HasFallThrough(ins)) {
//         INS_InsertCall(ins, IPOINT_AFTER, (AFUNPTR)OnMemWriteAfter, IARG_END);
//     }
// }
// static VOID InsReturns(INS ins, VOID*){
//     if (!INS_IsRet(ins)) return;
// #if defined(TARGET_IA32E)
//     INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnRetBefore, IARG_REG_VALUE, REG_RSP, IARG_END);
// #else
//     INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnRetBefore, IARG_REG_VALUE, REG_ESP, IARG_END);
// #endif
// }

// // ---------------- Thread/Fini/Main ----------------
// static VOID ThreadStart(THREADID tid, CONTEXT*, INT32, VOID*){ TLS* t=new TLS(); PIN_SetThreadData(gTLS,t,tid); }
// static VOID ThreadFini(THREADID, const CONTEXT*, INT32, VOID*){ TLS* t=T(); delete t; }
// static VOID Fini(INT32, VOID*){ Log<<"[fini]"<<endl; Log.close(); }

// int main(int argc, char* argv[]){
//     if (PIN_Init(argc, argv)) return 1;
//     Log.open(KnobOut.Value().c_str()); Log.setf(std::ios::unitbuf);
//     PIN_InitSymbols();
//     gTLS = PIN_CreateThreadDataKey(nullptr);

//     IMG_AddInstrumentFunction(ImageLoad, nullptr);
//     INS_AddInstrumentFunction(InsMemWrites, nullptr);
//     INS_AddInstrumentFunction(InsReturns,   nullptr);
//     PIN_AddThreadStartFunction(ThreadStart, nullptr);
//     PIN_AddThreadFiniFunction(ThreadFini, nullptr);
//     PIN_AddFiniFunction(Fini, nullptr);

//     Log<<"[start] output="<<KnobOut.Value()<<" srcroot="<<KnobSrcRoot.Value()<<endl;
//     PIN_StartProgram();
//     return 0;
// }
