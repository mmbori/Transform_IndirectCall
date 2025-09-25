// myownprj_all_indirect_FIXED.cpp — PIN 3.x (ia32e) instrumentation
// - Tracks ALL indirect calls globally
// - Builds a "mapped targets" table during mod_*_plugin_init by watching pointer writes
// - Logs only those indirect calls whose callee is one of the mapped targets
// - Emits callsite / enter / call / end style logs for mapped indirect calls
//
// Build (example):
//   make obj-intel64/myownprj_all_indirect_FIXED.so
//
// Run (example):
//   $PIN_ROOT/pin -t obj-intel64/myownprj_all_indirect_FIXED.so -o lighttpd_trace.log -- <program ...>
//
#include "pin.H"
#include <iostream>
#include <fstream>
#include <unordered_map>
#include <unordered_set>
#include <vector>
#include <string>
#include <cstring>

using std::string;
using std::ofstream;
using std::endl;

// ---- knob & log ----
KNOB<string> KnobOut(KNOB_MODE_WRITEONCE, "pintool", "o", "lighttpd_trace.log",
                     "output log file");
static ofstream Log;

// ---------------- Symbol helpers (with Client lock) ----------------
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

// ---------------- Global symbol tables ----------------
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
struct TLS {
    bool    in_plugin_init = false;
    ADDRINT cur_init_addr  = 0;   // address of mod_*_plugin_init
    ADDRINT cur_p          = 0;   // plugin* arg during init

    // mem write capture (BEFORE -> AFTER)
    ADDRINT last_write_ea  = 0;
    UINT32  last_write_sz  = 0;

    struct RetWatch { 
        ADDRINT retaddr; 
        ADDRINT target; 
        const char* tag; ADDRINT call_ip; };
    std::vector<RetWatch> ret_stack;  // for matching END at our monitored callsites
};
static TLS_KEY gTLS;
static TLS* T() { return static_cast<TLS*>(PIN_GetThreadData(gTLS, PIN_ThreadId())); }

// ---------------- Plugin init detection ----------------
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
    t->last_write_ea = ea; t->last_write_sz = size;
}
static VOID OnMemWriteAfter(){
    TLS* t = T(); if (!t->in_plugin_init) return;
    ADDRINT ea = t->last_write_ea; UINT32 sz = t->last_write_sz; if (!ea || !sz) return;
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
    std::string src; INT32 line=0; SrcByAddrSafe(val, src, line);

    Log << "[plugin.map.write] EA=0x" << std::hex << ea
        << " VAL=0x" << val << std::dec
        << " init_fn=" << RtnNameByAddrSafe(t->cur_init_addr)
        << " fn=" << RtnNameByAddrSafe(val)
        << " img=" << ImgNameByAddrSafe(val);
    if (!src.empty()) Log << " src=" << src << ":" << line;
    Log << endl;

    t->last_write_ea = 0; t->last_write_sz = 0;
}

// ---------------- srv-like function enter/leave (optional) ----------------
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
static VOID OnSrvLikeLeave(const char* name){
    Log << "[srv.like.leave] callee=" << name << endl;
}

// ---------------- Indirect-call ENTER/END inside srv-like functions ----------------
static VOID OnIndirectEnter(const char* tag,
                            ADDRINT call_ip, ADDRINT retaddr,
                            ADDRINT target,
                            ADDRINT a0_srv, ADDRINT a1_data,
                            ADDRINT mem_ea){
    // ENTER log
    RecordSymbol(target);
    Log << "[srv.like.fn.call]"           // ENTER marker (kept same tag as legacy)
        << " in=" << tag
        << " call_ip=0x"  << std::hex << call_ip  << std::dec
        << " ret_to=0x"   << std::hex << retaddr << std::dec
        << " target=0x"   << std::hex << target  << std::dec
        << " fn="  << RtnNameByAddrSafe(target)
        << " img=" << ImgNameByAddrSafe(target)
#if defined(TARGET_IA32E)
        << " srv=0x"  << std::hex << a0_srv  << std::dec
        << " data=0x" << std::hex << a1_data << std::dec
#endif
        ;
    if (mem_ea) Log << " fptr_mem_ea=0x" << std::hex << mem_ea << std::dec;
    Log << endl;

    // push watch so we can emit END on return to this callsite
    TLS* t = T();
    t->ret_stack.push_back({retaddr, target, tag, call_ip});
}

static VOID OnRetBefore(ADDRINT sp){
    TLS* t = T(); if (t->ret_stack.empty()) return;
    ADDRINT retaddr = 0; PIN_SafeCopy(&retaddr, (VOID*)sp, sizeof(ADDRINT));
    if (!retaddr) return;

    // Walk from stack top to bottom (LIFO) to find matching callsite
    for (int i = (int)t->ret_stack.size()-1; i >= 0; --i){
        if (t->ret_stack[i].retaddr == retaddr){
            auto w = t->ret_stack[i];
            t->ret_stack.erase(t->ret_stack.begin()+i);
            Log << "[srv.like.fn.ret]"     // END marker
                << " in=" << (w.tag ? w.tag : "?")
                << " call_ip=0x"  << std::hex << w.call_ip  << std::dec
                << " ret_to=0x"   << std::hex << w.retaddr  << std::dec
                << " target=0x"   << std::hex << w.target   << std::dec
                << " fn="  << RtnNameByAddrSafe(w.target)
                << " img=" << ImgNameByAddrSafe(w.target)
                << endl;
            break;
        }
    }
}

// ---------------- callsite logger for calls into srv-like functions ----------------
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

// ---------------- Target function registry ----------------
struct SrvLikeFn { const char* name; ADDRINT addr; USIZE size; };
static SrvLikeFn gTargets[] = {
    {"plugins_call_fn_srv_data",        0, 0},
    {"plugins_call_fn_srv_data_all",    0, 0},
    {"plugins_call_fn_req_data",        0, 0},
    {"plugins_call_fn_con_data",        0, 0},
    {"plugins_call_handle_waitpid",     0, 0},
};

static VOID InstrumentSrvLikeRTN(IMG img, SrvLikeFn& TGT){
    RTN r = RTN_FindByName(img, TGT.name);
    if (!RTN_Valid(r)) return;

    TGT.addr = RTN_Address(r); TGT.size = RTN_Size(r);
    Log << "[srv.like.register] name=" << TGT.name
        << " addr=0x" << std::hex << TGT.addr << std::dec
        << " size="   << TGT.size
        << " img="    << ImgNameByAddrSafe(TGT.addr)
        << endl;

    RTN_Open(r);
#if defined(TARGET_IA32E)
    RTN_InsertCall(r, IPOINT_BEFORE, (AFUNPTR)OnSrvLikeEnter,
                   IARG_PTR, TGT.name,
                   IARG_ADDRINT, TGT.addr,
                   IARG_REG_VALUE, REG_RSP,
                   IARG_END);
    RTN_InsertCall(r, IPOINT_AFTER, (AFUNPTR)OnSrvLikeLeave,
                   IARG_PTR, TGT.name, IARG_END);
#else
    RTN_InsertCall(r, IPOINT_BEFORE, (AFUNPTR)OnSrvLikeEnter,
                   IARG_PTR, TGT.name,
                   IARG_ADDRINT, TGT.addr,
                   IARG_REG_VALUE, REG_ESP,
                   IARG_END);
    RTN_InsertCall(r, IPOINT_AFTER, (AFUNPTR)OnSrvLikeLeave,
                   IARG_PTR, TGT.name, IARG_END);
#endif

    // Instrument *indirect* calls inside this routine
    for (INS ins = RTN_InsHead(r); INS_Valid(ins); ins = INS_Next(ins)) {
        if (!INS_IsCall(ins) || !INS_IsIndirectControlFlow(ins)) continue;
        BOOL has_mem = INS_IsMemoryRead(ins);
        ADDRINT nextIp = INS_NextAddress(ins);    // return address at this callsite
#if defined(TARGET_IA32E)
        if (has_mem) {
            INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnIndirectEnter,
                           IARG_PTR, TGT.name,
                           IARG_INST_PTR,
                           IARG_ADDRINT, nextIp,
                           IARG_BRANCH_TARGET_ADDR,
                           IARG_REG_VALUE, REG_RDI,  // server *srv
                           IARG_REG_VALUE, REG_RSI,  // void *data
                           IARG_MEMORYREAD_EA,
                           IARG_END);
        } else {
            INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnIndirectEnter,
                           IARG_PTR, TGT.name,
                           IARG_INST_PTR,
                           IARG_ADDRINT, nextIp,
                           IARG_BRANCH_TARGET_ADDR,
                           IARG_REG_VALUE, REG_RDI,
                           IARG_REG_VALUE, REG_RSI,
                           IARG_ADDRINT, (ADDRINT)0,
                           IARG_END);
        }
#else
        if (has_mem) {
            INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnIndirectEnter,
                           IARG_PTR, TGT.name,
                           IARG_INST_PTR,
                           IARG_ADDRINT, nextIp,
                           IARG_BRANCH_TARGET_ADDR,
                           IARG_ADDRINT, 0, IARG_ADDRINT, 0,
                           IARG_MEMORYREAD_EA,
                           IARG_END);
        } else {
            INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnIndirectEnter,
                           IARG_PTR, TGT.name,
                           IARG_INST_PTR,
                           IARG_ADDRINT, nextIp,
                           IARG_BRANCH_TARGET_ADDR,
                           IARG_ADDRINT, 0, IARG_ADDRINT, 0,
                           IARG_ADDRINT, (ADDRINT)0,
                           IARG_END);
        }
#endif
    }
    RTN_Close(r);
}


// ---------------- ImageLoad instrumentation ----------------
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

     // Instrument all target srv-like functions
    for (auto &TGT : gTargets) InstrumentSrvLikeRTN(img, TGT);

    // Log callsites that call any of the target functions (direct/indirect)
    for (SEC s = IMG_SecHead(img); SEC_Valid(s); s = SEC_Next(s)) {
        for (RTN rr = SEC_RtnHead(s); RTN_Valid(rr); rr = RTN_Next(rr)) {
            RTN_Open(rr);
            for (INS ins = RTN_InsHead(rr); INS_Valid(ins); ins = INS_Next(ins)) {
                if (!INS_IsCall(ins)) continue;
                if (INS_IsDirectControlFlow(ins)) {
                    ADDRINT tgt = INS_DirectControlFlowTargetAddress(ins);
                    for (auto &TGT : gTargets){
                        if (tgt == TGT.addr){
                            INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnCallsiteToSrvLike,
                                           IARG_INST_PTR, IARG_ADDRINT, tgt, IARG_END);
                            break;
                        }
                    }
                } else if (INS_IsIndirectControlFlow(ins)) {
                    INS_InsertCall(ins, IPOINT_BEFORE,
                        (AFUNPTR)+[](ADDRINT ip, ADDRINT tgt){
                            for (auto &TGT : gTargets) if (tgt == TGT.addr) { OnCallsiteToSrvLike(ip, tgt); break; }
                        },
                        IARG_INST_PTR, IARG_BRANCH_TARGET_ADDR, IARG_END);
                }
            }
            RTN_Close(rr);
        }
    }
}

// // ---------------- Instruction-level instrumentation ----------------
// static VOID Ins(INS ins, VOID*){
//     // 1) Global monitor of *indirect* calls (records callsite + target)
//     if (INS_IsCall(ins) && INS_IsIndirectControlFlow(ins)) {
//         const BOOL has_mem = INS_IsMemoryRead(ins);
//         const UINT32 ins_sz = INS_Size(ins);
//         const ADDRINT ip = INS_Address(ins);
//         // Mark this return as following an indirect call (used at function entry)
//         g_indirect_rets.insert(ip + ins_sz);

//         if (has_mem) {
//             INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnAnyIndirectCallBefore,
//                            IARG_INST_PTR,               // caller ip
//                            IARG_UINT32, ins_sz,         // instruction size
//                            IARG_BRANCH_TARGET_ADDR,     // callee addr (target)
//                            IARG_MEMORYREAD_EA,          // function pointer EA
//                            IARG_END);
//         } else {
//             INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnAnyIndirectCallBefore,
//                            IARG_INST_PTR,
//                            IARG_UINT32, ins_sz,
//                            IARG_BRANCH_TARGET_ADDR,
//                            IARG_ADDRINT, (ADDRINT)0,    // EA 없음
//                            IARG_END);
//         }
//     }

//     // 2) During plugin init, track pointer writes that establish mappings
//     if (!INS_IsMemoryWrite(ins)) return;
//     if (!INS_IsStandardMemop(ins)) return;
//     // control-flow instr are excluded from AFTER instrumentation
//     if (INS_IsCall(ins) || INS_IsBranch(ins) || INS_IsRet(ins)
//      || INS_IsSyscall(ins) || INS_IsInterrupt(ins)) return;

//     INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnMemWriteBefore,
//                    IARG_MEMORYWRITE_EA, IARG_MEMORYWRITE_SIZE, IARG_END);
//     if (INS_HasFallThrough(ins)) {
//         INS_InsertCall(ins, IPOINT_AFTER, (AFUNPTR)OnMemWriteAfter, IARG_END);
//     }
// }

// ---------------- Instruction-level hooks ----------------
static VOID InsMemWrites(INS ins, VOID*){
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

static VOID InsReturns(INS ins, VOID*){
    if (!INS_IsRet(ins)) return;
#if defined(TARGET_IA32E)
    INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnRetBefore,
                   IARG_REG_VALUE, REG_RSP, IARG_END);
#else
    INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnRetBefore,
                   IARG_REG_VALUE, REG_ESP, IARG_END);
#endif
}

// ---------------- Threads & fini ----------------
static VOID ThreadStart(THREADID tid, CONTEXT*, INT32, VOID*){
    TLS* t = new TLS(); PIN_SetThreadData(gTLS, t, tid);
}
static VOID ThreadFini(THREADID tid, const CONTEXT*, INT32, VOID*){
    TLS* t = T(); delete t;
}
static VOID Fini(INT32, VOID*){
    Log << "[fini]" << endl; Log.close();
}

// ---------------- main ----------------
int main(int argc, char* argv[]){
    if (PIN_Init(argc, argv)) return 1;
    Log.open(KnobOut.Value().c_str());
    Log.setf(std::ios::unitbuf);   // autoflush
    PIN_InitSymbols();             // safe symbolization
    gTLS = PIN_CreateThreadDataKey(nullptr);

    IMG_AddInstrumentFunction(ImageLoad, nullptr);
    INS_AddInstrumentFunction(InsMemWrites, nullptr); // plugin init mapping
    INS_AddInstrumentFunction(InsReturns,   nullptr); // END detection for monitored callsites

    PIN_AddThreadStartFunction(ThreadStart, nullptr);
    PIN_AddThreadFiniFunction(ThreadFini, nullptr);
    PIN_AddFiniFunction(Fini, nullptr);

    Log << "[start] output=" << KnobOut.Value() << endl;
    PIN_StartProgram();
    return 0;
}