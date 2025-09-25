
// myownprj_fixed.cpp — PIN 3.x (ia32e) safe instrumentation for lighttpd plugins
#include "pin.H"
#include <iostream>
#include <fstream>
#include <unordered_map>
#include <string>
#include <cstring>

using std::string;
using std::ofstream;
using std::endl;

KNOB<string> KnobOut(KNOB_MODE_WRITEONCE, "pintool", "o", "lighttpd_trace.log",
                     "output log file");

static ofstream Log;

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
static TLS* T() { return static_cast<TLS*>(PIN_GetThreadData(gTLS, PIN_ThreadId())); }

// ---------------- Safe helpers (with Client lock) ----------------
static string ImgNameByAddrSafe(ADDRINT a) {
    string s;
    PIN_LockClient();
    IMG i = IMG_FindByAddress(a);
    if (IMG_Valid(i)) s = IMG_Name(i);
    PIN_UnlockClient();
    return s;
}
static string RtnNameByAddrSafe(ADDRINT a) {
    string s;
    PIN_LockClient();
    RTN r = RTN_FindByAddress(a);
    if (RTN_Valid(r)) s = RTN_Name(r);
    PIN_UnlockClient();
    return s;
}
static void SrcByAddrSafe(ADDRINT a, std::string& file, INT32& line) {
    INT32 col = 0;
    file.clear(); line = 0;
    PIN_LockClient();
    PIN_GetSourceLocation(a, &col, &line, &file);
    PIN_UnlockClient();
}

// Safe copy C-string from app space (max 256 bytes)
static std::string SafeCStr(ADDRINT p, size_t maxlen=256) {
    if (!p) return std::string("<null>");
    char buf[256];
    size_t i = 0;
    for (; i + 1 < maxlen; ++i) {
        if (PIN_SafeCopy(&buf[i], (const void*)(p + i), 1) != 1) break;
        if (buf[i] == '\0') break;
    }
    buf[i] = '\0';
    return std::string(buf);
}

// ---------------- Symbol table (addr <-> "fn@img") ----------------
static std::unordered_map<ADDRINT,string> g_sym_by_addr; // addr -> "fn@img"
static std::unordered_map<string,ADDRINT> g_addr_by_sym; // "fn@img" -> addr

static inline bool starts_with(const string& s, const char* pre){
    size_t n = std::strlen(pre);
    return s.size()>=n && 0==s.compare(0,n,pre);
}
static inline bool ends_with(const string& s, const char* suf){
    size_t n = std::strlen(suf);
    return s.size()>=n && 0==s.compare(s.size()-n,n,suf);
}

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

// ---------------- plugin init enter/leave ----------------
static VOID OnPluginInitEnter(ADDRINT init_addr, ADDRINT pptr){
    T()->in_plugin_init = true;
    T()->cur_init_addr  = init_addr;
    T()->cur_p          = pptr;
    RecordSymbol(init_addr);
    RecordIfPluginInit(init_addr);
    Log << "[plugin.init.enter] init=0x" << std::hex << init_addr << std::dec
        << " fn=" << RtnNameByAddrSafe(init_addr)
        << " img="<< ImgNameByAddrSafe(init_addr)
        << " p=0x" << std::hex << pptr << std::dec
        << endl;
}
static VOID OnPluginInitLeave(){
    Log << "[plugin.init.leave]" << endl;
    T()->in_plugin_init = false;
    T()->cur_init_addr  = 0;
    T()->cur_p          = 0;
}

// ---------------- plugins_call_fn_srv_data ----------------
static VOID OnSrvDataEnter(INT32 e){
    T()->cur_ptype = (int)e;
    Log << "[srv.fn.enter] ptype=" << e << endl;
}
static VOID OnSrvDataLeave(){
    Log << "[srv.fn.leave]" << endl;
    T()->cur_ptype = -1;
}
static VOID OnIndirectBefore(ADDRINT target){
    if (!target) return;
    RecordSymbol(target);
    string key = g_sym_by_addr.count(target)? g_sym_by_addr[target] : "";
    string fn, img;
    if (!key.empty()){
        size_t pos = key.rfind('@');
        fn  = (pos==string::npos)? key : key.substr(0,pos);
        img = (pos==string::npos)? ""  : key.substr(pos+1);
    } else {
        fn  = RtnNameByAddrSafe(target);
        img = ImgNameByAddrSafe(target);
    }
    Log << "[srv.fn.indcall] ptype=" << T()->cur_ptype
        << " target=0x" << std::hex << target << std::dec
        << " fn=" << fn << " img=" << img << endl;
}

// ---------------- Memory write capture during plugin init ----------------
static VOID OnMemWriteBefore(ADDRINT ea, UINT32 size){
    if (!T()->in_plugin_init) return;
    T()->last_write_ea = ea;
    T()->last_write_sz = size;
}
static VOID OnMemWriteAfter(){
    if (!T()->in_plugin_init) return;
    ADDRINT ea = T()->last_write_ea;
    UINT32  sz = T()->last_write_sz;
    if (!ea || !sz) return;
#if defined(TARGET_IA32E)
    if (sz != 8) return;
#else
    if (sz != 4) return;
#endif
    // Restrict to writes within plugin* p area to reduce noise
    const ADDRINT p = T()->cur_p;
    if (!p) return;
    const size_t RANGE = 4096;
    if (ea < p || ea >= p + RANGE) return;

    ADDRINT val = 0;
    PIN_SafeCopy(&val, (const void*)ea, sz);
    if (!val) return;

    RecordSymbol(val);
    string key = g_sym_by_addr.count(val)? g_sym_by_addr[val] : "";
    string fn, img;
    if (!key.empty()){
        size_t pos = key.rfind('@');
        fn  = (pos==string::npos)? key : key.substr(0,pos);
        img = (pos==string::npos)? ""  : key.substr(pos+1);
    } else {
        fn  = RtnNameByAddrSafe(val);
        img = ImgNameByAddrSafe(val);
    }
    std::string src; INT32 line=0; SrcByAddrSafe(val, src, line);

    Log << "[plugin.map.write] EA=0x" << std::hex << ea
        << " VAL=0x" << val << std::dec
        << " init_fn=" << RtnNameByAddrSafe(T()->cur_init_addr)
        << " fn=" << fn << " img=" << img;
    if (!src.empty()) Log << " src=" << src << ":" << line;
    Log << endl;

    // consume
    T()->last_write_ea = 0;
    T()->last_write_sz = 0;
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

    // plugins_call_fn_srv_data entry/leave + indirect calls inside its range
    RTN srv = RTN_FindByName(img, "plugins_call_fn_srv_data");
    if (RTN_Valid(srv)){
        RTN_Open(srv);
        RTN_InsertCall(srv, IPOINT_BEFORE, (AFUNPTR)OnSrvDataEnter,
                       IARG_FUNCARG_ENTRYPOINT_VALUE, 1, IARG_END);
        RTN_InsertCall(srv, IPOINT_AFTER, (AFUNPTR)OnSrvDataLeave, IARG_END);
        RTN_Close(srv);

        ADDRINT b = RTN_Address(srv);
        ADDRINT e = b + RTN_Size(srv);
        for (SEC s = IMG_SecHead(img); SEC_Valid(s); s = SEC_Next(s)) {
            for (RTN rr = SEC_RtnHead(s); RTN_Valid(rr); rr = RTN_Next(rr)) {
                ADDRINT ra = RTN_Address(rr);
                if (ra < b || ra >= e) continue;
                RTN_Open(rr);
                for (INS ins = RTN_InsHead(rr); INS_Valid(ins); ins = INS_Next(ins)) {
                    if (INS_IsCall(ins) || INS_IsBranch(ins) || INS_IsRet(ins)
                        || INS_IsSyscall(ins) || INS_IsInterrupt(ins)) {
                        continue;
                    }
                    if (INS_IsCall(ins) && INS_IsIndirectControlFlow(ins)) {
                        INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnIndirectBefore,
                                       IARG_BRANCH_TARGET_ADDR, IARG_END);
                    }
                }
                RTN_Close(rr);
            }
        }
    }
}

// instruction-level: limit mem writes during plugin init safely
static VOID Ins(INS ins, VOID*){
    // Exclude control-flow & non-standard memops for AFTER safety
    if (INS_IsCall(ins) || INS_IsBranch(ins) || INS_IsRet(ins)
        || INS_IsSyscall(ins) || INS_IsInterrupt(ins)) {
        return;
    }
    if (!INS_IsMemoryWrite(ins)) return;
    if (!INS_IsStandardMemop(ins)) return;

    INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnMemWriteBefore,
                   IARG_MEMORYWRITE_EA, IARG_MEMORYWRITE_SIZE, IARG_END);
    if (INS_HasFallThrough(ins)) {
        INS_InsertCall(ins, IPOINT_AFTER, (AFUNPTR)OnMemWriteAfter, IARG_END);
    }
}

static VOID ThreadStart(THREADID tid, CONTEXT*, INT32, VOID*){
    TLS* t = new TLS();
    PIN_SetThreadData(gTLS, t, tid);
}
static VOID ThreadFini(THREADID tid, const CONTEXT*, INT32, VOID*){
    TLS* t = T(); delete t;
}

static VOID Fini(INT32, VOID*){
    Log << "[fini]" << endl;
    Log.close();
}

int main(int argc, char* argv[]){
    if (PIN_Init(argc, argv)) return 1;
    Log.open(KnobOut.Value().c_str());
    PIN_InitSymbols(); // version-safe

    Log.setf(std::ios::unitbuf); // autoflush
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
