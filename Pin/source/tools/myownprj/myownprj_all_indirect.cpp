
// myownprj_fixed.cpp — PIN 3.x (ia32e) safe instrumentation for lighttpd plugins
#include "pin.H"
#include <iostream>
#include <fstream>
#include <unordered_map>
#include <string>
#include <cstring>
#include <unordered_set>

using std::string;
using std::ofstream;
using std::endl;

KNOB<string> KnobOut(KNOB_MODE_WRITEONCE, "pintool", "o", "lighttpd_trace.log",
                     "output log file");

static ofstream Log;

// target functions to monitor
static ADDRINT g_srv_addr    = 0, g_srv_sz    = 0; // plugins_call_fn_srv_data
static ADDRINT g_srvall_addr = 0, g_srvall_sz = 0; // plugins_call_fn_srv_data_all

// ---------------- Thread-Local ----------------
struct TLS {
    bool    in_plugin_init = false;
    ADDRINT cur_init_addr  = 0;   // address of mod_*_plugin_init
    int     cur_ptype      = -1;  // plugins_call_fn_srv_data(..., e)
    ADDRINT cur_p          = 0;   // plugin* arg during init

    // mem write capture (BEFORE -> AFTER)
    ADDRINT last_write_ea  = 0;
    UINT32  last_write_sz  = 0;
};
static TLS_KEY gTLS;
static TLS* T() { 
    return static_cast<TLS*>(PIN_GetThreadData(gTLS, PIN_ThreadId())); 
}

// ---------- Safe helpers (with Client lock) ----------
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
static inline bool starts_with(const string& s, const char* pre) {
    size_t n = std::strlen(pre);
    return s.size() >= n && 0 == s.compare(0, n, pre);
}
static inline bool ends_with(const string& s, const char* suf) {
    size_t n = std::strlen(suf);
    return s.size() >= n && 0 == s.compare(s.size()-n, n, suf);
}

// ---------------- Symbol table (addr <-> "fn@img") ----------------
static std::unordered_map<ADDRINT,string> g_sym_by_addr; // addr -> "fn@img"
static std::unordered_map<string,ADDRINT> g_addr_by_sym; // "fn@img" -> addr
static std::unordered_set<ADDRINT> g_mapped_targets; // init 중 발견된 함수 주소들


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

static void RecordIfPluginInit(ADDRINT a){
    if (!a) return;
    string fn = RtnNameByAddrSafe(a);
    if (fn.empty()) return;
    if (starts_with(fn,"mod_") && ends_with(fn,"_plugin_init")){
        RecordSymbol(a);
    }
}

// ---------------- dlsym/dlopen logging ----------------
static VOID DlsymBefore(ADDRINT handle, ADDRINT sym_cstr){
    std::string s = SafeCStr(sym_cstr);
    Log << "[dlsym.before] handle=0x" << std::hex << handle << std::dec
        << " sym=" << s << endl;
}
static VOID DlsymAfter(ADDRINT ret, ADDRINT handle, ADDRINT sym_cstr){
    std::string s = SafeCStr(sym_cstr);
    Log << "[dlsym.after] handle=0x" << std::hex << handle << std::dec
        << " sym=" << s << " rtn=0x" << std::hex << ret << std::dec;
    if (ret){
        RecordSymbol(ret);
        RecordIfPluginInit(ret);
        Log << " fn=" << RtnNameByAddrSafe(ret) << " img=" << ImgNameByAddrSafe(ret);
    }
    Log << endl;
}
static VOID DlopenBefore(ADDRINT path_cstr, ADDRINT flags){
    std::string p = SafeCStr(path_cstr);
    Log << "[dlopen.before] path=" << p << " flags=0x" << std::hex << flags << std::dec << endl;
}
static VOID DlopenAfter(ADDRINT ret, ADDRINT path_cstr, ADDRINT flags){
    std::string p = SafeCStr(path_cstr);
    Log << "[dlopen.after] path=" << p << " flags=0x" << std::hex << flags
        << " handle=0x" << ret << std::dec << endl;
}

// ---------- plugin init enter/leave ----------
static VOID OnPluginInitEnter(ADDRINT init_addr, ADDRINT pptr){
    TLS* t = T();
    t->in_plugin_init = true; t->cur_init_addr = init_addr; t->cur_p = pptr;
    RecordSymbol(init_addr); RecordIfPluginInit(init_addr);
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

// ---------------- Memory write capture during plugin init ----------------
static VOID OnMemWriteBefore(ADDRINT ea, UINT32 size){
    TLS* t = T(); if (!t->in_plugin_init) return;
    t->last_write_ea = ea; 
    t->last_write_sz = size;
}
static VOID OnMemWriteAfter(){
    TLS* t = T(); if (!t->in_plugin_init) return;
    ADDRINT ea = t->last_write_ea;
    UINT32 sz = t->last_write_sz;
    if (!ea || !sz) return;
#if defined(TARGET_IA32E)
    if (sz != 8) return;   // 64-bit ptr
#else
    if (sz != 4) return;   // 32-bit ptr
#endif
    const ADDRINT p = t->cur_p; if (!p) return;
    const size_t RANGE = 4096; // restrict to plugin struct neighborhood
    if (ea < p || ea >= p + RANGE) return;

    ADDRINT val = 0; PIN_SafeCopy(&val, (const void*)ea, sz);
    if (!val) return;

    RecordSymbol(val);
    string fn = RtnNameByAddrSafe(val);
    string img= ImgNameByAddrSafe(val);
    std::string src; INT32 line=0; SrcByAddrSafe(val, src, line);

    Log << "[plugin.map.write] EA=0x" << std::hex << ea
        << " VAL=0x" << val << std::dec
        << " init_fn=" << RtnNameByAddrSafe(t->cur_init_addr)
        << " fn=" << fn << " img=" << img;
    if (!src.empty()) Log << " src=" << src << ":" << line;
    Log << endl;

    // [ADD] 맵핑된 함수 집합에 저장
    g_mapped_targets.insert(val);

    t->last_write_ea = 0; t->last_write_sz = 0;
}

// [ADD] 프로그램 전체의 모든 간접 호출 기록용
static VOID OnAnyIndirectCallBefore(ADDRINT ip, ADDRINT target, ADDRINT mem_ea){
    RecordSymbol(target);

    string cal_fn  = RtnNameByAddrSafe(target);
    string cal_img = ImgNameByAddrSafe(target);
    string clr_fn  = RtnNameByAddrSafe(ip);
    string clr_img = ImgNameByAddrSafe(ip);

    bool is_mapped = (g_mapped_targets.find(target) != g_mapped_targets.end());
    const char* tag = is_mapped ? "[indirect.call.MAPPED]" : "[indirect.call]";

    Log << tag
        << " caller_ip=0x"   << std::hex << ip     << std::dec
        << " caller_fn="     << (clr_fn.empty()?  "?" : clr_fn)
        << " caller_img="    << (clr_img.empty()? "?" : clr_img)
        << " callee=0x"      << std::hex << target << std::dec
        << " callee_fn="     << (cal_fn.empty()?  "?" : cal_fn)
        << " callee_img="    << (cal_img.empty()? "?" : cal_img);
    if (mem_ea) Log << " fptr_mem_ea=0x" << std::hex << mem_ea << std::dec;
    Log << endl;
}


// 함수 간접호출부 감시
// ---------- srv-like enter (caller logging) ----------
static VOID OnSrvLikeEnter(const char* name, ADDRINT callee_addr, ADDRINT rsp){
    ADDRINT retaddr = 0; PIN_SafeCopy(&retaddr, (VOID*)rsp, sizeof(ADDRINT));
    ADDRINT callsite = retaddr ? (retaddr - 1) : 0;
    Log << "[srv.like.enter]"
        << " callee=" << name
        << " callee_addr=0x" << std::hex << callee_addr << std::dec
        << " caller_ret=0x"  << std::hex << retaddr     << std::dec
        << " callsite~=0x"   << std::hex << callsite    << std::dec
        << " caller_fn="  << RtnNameByAddrSafe(callsite)
        << " caller_img=" << ImgNameByAddrSafe(callsite)
        << endl;
}

// ---------- srv-like internal indirect call logging ----------
static VOID OnSrvLikeIndirectBefore(ADDRINT target, ADDRINT a0_srv, ADDRINT a1_data, ADDRINT mem_ea){
    RecordSymbol(target);
    Log << "[srv.like.fn.call]"
        << " target=0x" << std::hex << target << std::dec
        << " fn="  << RtnNameByAddrSafe(target)
        << " img=" << ImgNameByAddrSafe(target)
#if defined(TARGET_IA32E)
        << " srv=0x"  << std::hex << a0_srv  << std::dec
        << " data=0x" << std::hex << a1_data << std::dec
#endif
        ;
    if (mem_ea) Log << " fptr_mem_ea=0x" << std::hex << mem_ea << std::dec; // only for call [mem]
    Log << endl;
}

// ---------- callsite logger for the two functions ----------
static VOID OnCallsiteToSrvLike(ADDRINT ip, ADDRINT target){
    Log << "[srv.like.callsite]"
        << " ip=0x"     << std::hex << ip     << std::dec
        << " target=0x" << std::hex << target << std::dec
        << " caller_fn=" << RtnNameByAddrSafe(ip)
        << " caller_img="<< ImgNameByAddrSafe(ip)
        << " callee_fn=" << RtnNameByAddrSafe(target)
        << " callee_img="<< ImgNameByAddrSafe(target)
        << endl;
}



// ---------------- Instrumentation ----------------
static VOID ImageLoad(IMG img, VOID*){
    Log << "[IMG_LOAD] " << IMG_Name(img) << (IMG_IsMainExecutable(img)?" (main)":"") << endl;

    // Hook dlsym
    RTN r = RTN_FindByName(img, "dlsym");
    if (RTN_Valid(r)){
        RTN_Open(r);
        RTN_InsertCall(r, IPOINT_BEFORE, (AFUNPTR)DlsymBefore,
                       IARG_FUNCARG_ENTRYPOINT_VALUE, 0, // handle
                       IARG_FUNCARG_ENTRYPOINT_VALUE, 1, // sym
                       IARG_END);
        RTN_InsertCall(r, IPOINT_AFTER, (AFUNPTR)DlsymAfter,
                       IARG_FUNCRET_EXITPOINT_VALUE,     // ret
                       IARG_FUNCARG_ENTRYPOINT_VALUE, 0, // handle
                       IARG_FUNCARG_ENTRYPOINT_VALUE, 1, // sym
                       IARG_END);
        RTN_Close(r);
        Log << "[hook] dlsym in " << IMG_Name(img) << endl;
    }

    // Hook dlopen
    r = RTN_FindByName(img, "dlopen");
    if (RTN_Valid(r)){
        RTN_Open(r);
        RTN_InsertCall(r, IPOINT_BEFORE, (AFUNPTR)DlopenBefore,
                       IARG_FUNCARG_ENTRYPOINT_VALUE, 0, // path
                       IARG_FUNCARG_ENTRYPOINT_VALUE, 1, // flags
                       IARG_END);
        RTN_InsertCall(r, IPOINT_AFTER, (AFUNPTR)DlopenAfter,
                       IARG_FUNCRET_EXITPOINT_VALUE,     // handle
                       IARG_FUNCARG_ENTRYPOINT_VALUE, 0, // path
                       IARG_FUNCARG_ENTRYPOINT_VALUE, 1, // flags
                       IARG_END);
        RTN_Close(r);
        Log << "[hook] dlopen in " << IMG_Name(img) << endl;
    }

    // Pre-scan/init hook for mod_*_plugin_init in this image
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

    // --- (A) 두 함수 주소/크기 기록 및 진입 훅 ---
    RTN r1 = RTN_FindByName(img, "plugins_call_fn_srv_data");
    if (RTN_Valid(r1)) {
        g_srv_addr = RTN_Address(r1);
        g_srv_sz   = RTN_Size(r1);
        Log << "[srv.like.register] name=plugins_call_fn_srv_data"
            << " addr=0x" << std::hex << g_srv_addr << std::dec
            << " size="   << g_srv_sz
            << " img="    << ImgNameByAddrSafe(g_srv_addr)
            << endl;

        RTN_Open(r1);
#if defined(TARGET_IA32E)
        RTN_InsertCall(r1, IPOINT_BEFORE, (AFUNPTR)OnSrvLikeEnter,
                       IARG_PTR, "plugins_call_fn_srv_data",
                       IARG_ADDRINT, g_srv_addr,
                       IARG_REG_VALUE, REG_RSP,
                       IARG_END);
#else
        RTN_InsertCall(r1, IPOINT_BEFORE, (AFUNPTR)OnSrvLikeEnter,
                       IARG_PTR, "plugins_call_fn_srv_data",
                       IARG_ADDRINT, g_srv_addr,
                       IARG_REG_VALUE, REG_ESP,
                       IARG_END);
#endif
        // (B) instrument internal indirect calls directly in this RTN
        for (INS ins = RTN_InsHead(r1); INS_Valid(ins); ins = INS_Next(ins)) {
            if (!INS_IsCall(ins) || !INS_IsIndirectControlFlow(ins)) continue;
            BOOL has_mem = INS_IsMemoryRead(ins);
#if defined(TARGET_IA32E)
            if (has_mem) {
                INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnSrvLikeIndirectBefore,
                               IARG_BRANCH_TARGET_ADDR,
                               IARG_REG_VALUE, REG_RDI,  // server *srv
                               IARG_REG_VALUE, REG_RSI,  // void *data
                               IARG_MEMORYREAD_EA, IARG_END);
            } else {
                INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnSrvLikeIndirectBefore,
                               IARG_BRANCH_TARGET_ADDR,
                               IARG_REG_VALUE, REG_RDI,
                               IARG_REG_VALUE, REG_RSI,
                               IARG_ADDRINT, (ADDRINT)0, IARG_END);
            }
#else
            // 32-bit: extend if needed
            if (has_mem) {
                INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnSrvLikeIndirectBefore,
                               IARG_BRANCH_TARGET_ADDR,
                               IARG_ADDRINT, 0, IARG_ADDRINT, 0,
                               IARG_MEMORYREAD_EA, IARG_END);
            } else {
                INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnSrvLikeIndirectBefore,
                               IARG_BRANCH_TARGET_ADDR,
                               IARG_ADDRINT, 0, IARG_ADDRINT, 0,
                               IARG_ADDRINT, (ADDRINT)0, IARG_END);
            }
#endif
        }
        RTN_Close(r1);
    }

    RTN r2 = RTN_FindByName(img, "plugins_call_fn_srv_data_all");
    if (RTN_Valid(r2)) {
        g_srvall_addr = RTN_Address(r2); g_srvall_sz = RTN_Size(r2);
        Log << "[srv.like.register] name=plugins_call_fn_srv_data_all"
            << " addr=0x" << std::hex << g_srvall_addr << std::dec
            << " size="   << g_srvall_sz
            << " img="    << ImgNameByAddrSafe(g_srvall_addr) << endl;

        RTN_Open(r2);
#if defined(TARGET_IA32E)
        RTN_InsertCall(r2, IPOINT_BEFORE, (AFUNPTR)OnSrvLikeEnter,
                       IARG_PTR, "plugins_call_fn_srv_data_all",
                       IARG_ADDRINT, g_srvall_addr,
                       IARG_REG_VALUE, REG_RSP, IARG_END);
#else
        RTN_InsertCall(r2, IPOINT_BEFORE, (AFUNPTR)OnSrvLikeEnter,
                       IARG_PTR, "plugins_call_fn_srv_data_all",
                       IARG_ADDRINT, g_srvall_addr,
                       IARG_REG_VALUE, REG_ESP, IARG_END);
#endif
        for (INS ins = RTN_InsHead(r2); INS_Valid(ins); ins = INS_Next(ins)) {
            if (!INS_IsCall(ins) || !INS_IsIndirectControlFlow(ins)) continue;
            BOOL has_mem = INS_IsMemoryRead(ins);
#if defined(TARGET_IA32E)
            if (has_mem) {
                INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnSrvLikeIndirectBefore,
                               IARG_BRANCH_TARGET_ADDR,
                               IARG_REG_VALUE, REG_RDI,
                               IARG_REG_VALUE, REG_RSI,
                               IARG_MEMORYREAD_EA, IARG_END);
            } else {
                INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnSrvLikeIndirectBefore,
                               IARG_BRANCH_TARGET_ADDR,
                               IARG_REG_VALUE, REG_RDI,
                               IARG_REG_VALUE, REG_RSI,
                               IARG_ADDRINT, (ADDRINT)0, IARG_END);
            }
#else
            if (has_mem) {
                INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnSrvLikeIndirectBefore,
                               IARG_BRANCH_TARGET_ADDR,
                               IARG_ADDRINT, 0, IARG_ADDRINT, 0,
                               IARG_MEMORYREAD_EA, IARG_END);
            } else {
                INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnSrvLikeIndirectBefore,
                               IARG_BRANCH_TARGET_ADDR,
                               IARG_ADDRINT, 0, IARG_ADDRINT, 0,
                               IARG_ADDRINT, (ADDRINT)0, IARG_END);
            }
#endif
        }
        RTN_Close(r2);
    }

    // (C) log callsites that call either function (direct/indirect)
    for (SEC s = IMG_SecHead(img); SEC_Valid(s); s = SEC_Next(s)) {
        for (RTN rr = SEC_RtnHead(s); RTN_Valid(rr); rr = RTN_Next(rr)) {
            RTN_Open(rr);
            for (INS ins = RTN_InsHead(rr); INS_Valid(ins); ins = INS_Next(ins)) {
                if (!INS_IsCall(ins)) continue;
                if (INS_IsDirectControlFlow(ins)) {
                    ADDRINT tgt = INS_DirectControlFlowTargetAddress(ins);
                    if (tgt == g_srv_addr || tgt == g_srvall_addr) {
                        INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnCallsiteToSrvLike,
                                       IARG_INST_PTR, IARG_ADDRINT, tgt, IARG_END);
                    }
                } else if (INS_IsIndirectControlFlow(ins)) {
                    INS_InsertCall(ins, IPOINT_BEFORE,
                        (AFUNPTR)+[](ADDRINT ip, ADDRINT tgt){
                            if (tgt == g_srv_addr || tgt == g_srvall_addr)
                                OnCallsiteToSrvLike(ip, tgt);
                        },
                        IARG_INST_PTR, IARG_BRANCH_TARGET_ADDR, IARG_END);
                }
            }
            RTN_Close(rr);
        }
    }
}

// instruction-level: limit mem writes during plugin init safely
static VOID Ins(INS ins, VOID*){
    // [ADD] 1) 전역 모든 간접 호출 로깅
    if (INS_IsCall(ins) && INS_IsIndirectControlFlow(ins)) {
        const BOOL has_mem = INS_IsMemoryRead(ins);
        if (has_mem) {
            INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnAnyIndirectCallBefore,
                           IARG_INST_PTR,               // caller ip
                           IARG_BRANCH_TARGET_ADDR,     // callee addr (target)
                           IARG_MEMORYREAD_EA,          // 함수포인터 저장 메모리 EA
                           IARG_END);
        } else {
            INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnAnyIndirectCallBefore,
                           IARG_INST_PTR,
                           IARG_BRANCH_TARGET_ADDR,
                           IARG_ADDRINT, (ADDRINT)0,    // EA 없음
                           IARG_END);
        }
    }
    
     // [KEEP] 2) init 중 포인터 매핑 write 추적 (기존 로직 유지)
    if (!INS_IsMemoryWrite(ins)) return;
    if (!INS_IsStandardMemop(ins)) return;
    // control-flow instr는 AFTER 지원이 위험하므로 제외
    if (INS_IsCall(ins) || INS_IsBranch(ins) || INS_IsRet(ins)
     || INS_IsSyscall(ins) || INS_IsInterrupt(ins)) return;

    INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnMemWriteBefore,
                   IARG_MEMORYWRITE_EA, IARG_MEMORYWRITE_SIZE, IARG_END);
    if (INS_HasFallThrough(ins)) {
        INS_InsertCall(ins, IPOINT_AFTER, (AFUNPTR)OnMemWriteAfter, IARG_END);
    }
}

// ---------- Thread / Fini ----------
static VOID ThreadStart(THREADID tid, CONTEXT*, INT32, VOID*){
    TLS* t = new TLS(); PIN_SetThreadData(gTLS, t, tid);
}
static VOID ThreadFini(THREADID tid, const CONTEXT*, INT32, VOID*){
    TLS* t = T(); delete t;
}
static VOID Fini(INT32, VOID*){
    Log << "[fini]" << endl; Log.close();
}

// ---------- main ----------
int main(int argc, char* argv[]){
    if (PIN_Init(argc, argv)) return 1;
    Log.open(KnobOut.Value().c_str());
    Log.setf(std::ios::unitbuf);   // autoflush
    PIN_InitSymbols();             // safe symbolization
    gTLS = PIN_CreateThreadDataKey(nullptr);

    IMG_AddInstrumentFunction(ImageLoad, nullptr);
    INS_AddInstrumentFunction(Ins, nullptr);
    PIN_AddThreadStartFunction(ThreadStart, nullptr);
    PIN_AddThreadFiniFunction(ThreadFini, nullptr);
    PIN_AddFiniFunction(Fini, nullptr);

    Log << "[start] output=" << KnobOut.Value() << endl;
    PIN_StartProgram();
    return 0;
}