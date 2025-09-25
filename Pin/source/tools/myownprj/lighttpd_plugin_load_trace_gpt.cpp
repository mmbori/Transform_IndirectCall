// lt_plugin_end2end_trace.cpp
#include "pin.H"
#include <iostream>
#include <fstream>
#include <unordered_map>
#include <map>
#include <vector>
#include <string>
#include <sstream>

using std::string;
using std::ofstream;
using std::endl;

/* --------- 옵션: 로그 파일 경로 --------- */
KNOB<string> KnobOut(
    KNOB_MODE_WRITEONCE, "pintool", "o", "lt-plugin-end2end.log",
    "path to log file");

/* --------- 출력 --------- */
static ofstream Log;

/* --------- 유틸 --------- */
static string ImgNameByAddr(ADDRINT a){ IMG i=IMG_FindByAddress(a); return IMG_Valid(i)?IMG_Name(i):string(); }
static string RtnNameByAddr(ADDRINT a){ return RTN_FindNameByAddress(a); }
static void   SrcByAddr(ADDRINT a, string& f, INT32& l){ const char* F=nullptr; INT32 L=0,C=0; if (PIN_GetSourceLocation(a,&C,&L,&F)&&F){ f=F;l=L;} else {f.clear();l=0;} }

/* --------- 플러그인 타입 이름(순서 중요) --------- */
static const char* kPluginTypeName[] = {
    "HANDLE_URI_CLEAN","HANDLE_DOCROOT","HANDLE_PHYSICAL","HANDLE_SUBREQUEST_START",
    "HANDLE_RESPONSE_START","HANDLE_REQUEST_DONE","HANDLE_REQUEST_RESET","HANDLE_REQUEST_ENV",
    "HANDLE_CONNECTION_ACCEPT","HANDLE_CONNECTION_SHUT_WR","HANDLE_CONNECTION_CLOSE",
    "HANDLE_TRIGGER","HANDLE_WAITPID","HANDLE_SIGHUP","SET_DEFAULTS","WORKER_INIT"
};
static inline const char* PTypeStr(int e){
    return (0<=e && e<(int)(sizeof(kPluginTypeName)/sizeof(kPluginTypeName[0])))? kPluginTypeName[e] : "?";
}

/* --------- 데이터 모델(요약/연결용) --------- */
struct PluginInfo {
    string so_path;            // .so 경로
    ADDRINT low=0, high=0;     // 매핑 범위
    ADDRINT init_addr=0;       // *_plugin_init 주소
    string  init_name;         // *_plugin_init 심볼 명
    // init에서 p에 저장된 함수 포인터들: func_addr -> "rtn@img"
    std::map<ADDRINT,string> mapped_funcs;
};
static std::unordered_map<ADDRINT,string> g_func_to_module; // func_addr -> so path
static std::unordered_map<string, PluginInfo> g_plugins;     // so path -> info
static std::unordered_map<string, ADDRINT> g_sym_to_addr;    // dlsym 결과: 심볼 -> addr

/* --------- TLS --------- */
struct TLS {
    string pending_lib;    // dlopen BEFORE: filename
    int    pending_flags=0;
    string pending_sym;    // dlsym  BEFORE: symbol
    ADDRINT cur_p=0;       // *_plugin_init(plugin* p)
    string  cur_init;      // init 이름(심볼)
    int     cur_ptype=-1;  // plugins_call_fn_srv_data(srv,e)
    ADDRINT last_fptr_ea=0; // indirect call 시 fptr 메모리 EA(있으면)
    bool    last_fptr_ea_valid=false;
};
static TLS_KEY gTLS;
static TLS* T(){ return static_cast<TLS*>(PIN_GetThreadData(gTLS, PIN_ThreadId())); }

/* --------- 로깅 헬퍼 --------- */
static void log_addr(const char* tag, ADDRINT a, const string& extra=""){
    string img=ImgNameByAddr(a), rtn=RtnNameByAddr(a), f; INT32 l=0; SrcByAddr(a,f,l);
    Log << tag << " addr=0x" << std::hex << a << std::dec
        << " rtn=" << (rtn.empty()?"?":rtn)
        << " img=" << (img.empty()?"?":img)
        << " src=" << (f.empty()?"?":f) << (l?":"+std::to_string(l):"")
        << (extra.empty()? "" : " "+extra) << endl;
}

/* --------- dlopen/dlsym 추적 (BEFORE/AFTER 둘 다 로그) --------- */
static VOID Dlopen_Before(CHAR* path, INT32 flags){
    T()->pending_lib   = path? string(path) : string();
    T()->pending_flags = flags;
    Log << "[dlopen.before] file=" << (T()->pending_lib.empty()?"?":T()->pending_lib)
        << " flags=" << T()->pending_flags << endl;
}
static VOID Dlopen_After(ADDRINT handle){
    std::ostringstream oss;
    oss << "file=" << (T()->pending_lib.empty()?"?":T()->pending_lib)
        << " flags=" << T()->pending_flags;
    log_addr("[dlopen.after]", handle, oss.str());
    T()->pending_lib.clear(); T()->pending_flags=0;
}
static VOID Dlsym_Before(ADDRINT /*h*/, CHAR* sym){
    T()->pending_sym = sym? string(sym) : string();
    Log << "[dlsym.before] sym=" << (T()->pending_sym.empty()?"?":T()->pending_sym) << endl;
}
static VOID Dlsym_After(ADDRINT a){
    string s = T()->pending_sym; T()->pending_sym.clear();
    g_sym_to_addr[s]=a;
    log_addr("[dlsym.after]", a, "sym="+s);
    // *_plugin_init 발견 시 플러그인 후보로 바로 표시(정확한 so 매핑은 ImageLoad로 확정)
    if (s.size()>=12 && s.rfind("_plugin_init")==s.size()-12){
        string img = ImgNameByAddr(a);
        if (!img.empty()){
            auto &pi = g_plugins[img];
            pi.so_path  = img;
            pi.init_addr= a;
            pi.init_name= s;
        }
    }
}

/* --------- Image Load/Unload: 매핑 범위 확정 --------- */
static VOID OnImageLoad(IMG img, VOID*){
    if (!IMG_Valid(img)) return;
    Log << "[IMG_LOAD] " << IMG_Name(img)
        << " low=0x"  << std::hex << IMG_LowAddress(img)
        << " high=0x" << IMG_HighAddress(img) << std::dec << endl;

    // 플러그인 후보(경로에 mod_ 포함)
    if (IMG_Name(img).find("mod_") != string::npos){
        auto &pi = g_plugins[IMG_Name(img)];
        pi.so_path = IMG_Name(img);
        pi.low     = IMG_LowAddress(img);
        pi.high    = IMG_HighAddress(img);
    }

    // dlopen/dlsym 계측
    RTN r;
    r = RTN_FindByName(img, "dlopen");
    if (RTN_Valid(r)){ RTN_Open(r);
        RTN_InsertCall(r, IPOINT_BEFORE, (AFUNPTR)Dlopen_Before,
            IARG_FUNCARG_ENTRYPOINT_VALUE, 0,  // filename
            IARG_FUNCARG_ENTRYPOINT_VALUE, 1,  // flags
            IARG_END);
        RTN_InsertCall(r, IPOINT_AFTER,  (AFUNPTR)Dlopen_After,
            IARG_FUNCRET_EXITPOINT_VALUE, IARG_END);
        RTN_Close(r);
    }
    r = RTN_FindByName(img, "dlsym");
    if (RTN_Valid(r)){ RTN_Open(r);
        RTN_InsertCall(r, IPOINT_BEFORE, (AFUNPTR)Dlsym_Before,
            IARG_FUNCARG_ENTRYPOINT_VALUE, 1,  // symbol
            IARG_END);
        RTN_InsertCall(r, IPOINT_AFTER,  (AFUNPTR)Dlsym_After,
            IARG_FUNCRET_EXITPOINT_VALUE, IARG_END);
        RTN_Close(r);
    }

    // *_plugin_init 루틴 내부 store AFTER 계측 (p->field = func)
    for (SEC s=IMG_SecHead(img); SEC_Valid(s); s=SEC_Next(s)){
        for (RTN r=SEC_RtnHead(s); RTN_Valid(r); r=RTN_Next(r)){
            string rn=RTN_Name(r);
            if (rn.size()>=12 && rn.rfind("_plugin_init")==rn.size()-12){
                RTN_Open(r);
                RTN_InsertCall(r, IPOINT_BEFORE, (AFUNPTR)+[](ADDRINT p, ADDRINT entry){
                    T()->cur_p = p;
                    T()->cur_init = RtnNameByAddr(entry);
                    Log << "[plugin.init.enter] p=0x" << std::hex << p << std::dec
                        << " init=" << (T()->cur_init.empty()? string("mod_?_plugin_init"):T()->cur_init) << endl;
                }, IARG_FUNCARG_ENTRYPOINT_VALUE, 0, IARG_ADDRINT, RTN_Address(r), IARG_END);

                RTN_InsertCall(r, IPOINT_AFTER, (AFUNPTR)+[](){
                    Log << "[plugin.init.leave]" << endl;
                    T()->cur_p=0; T()->cur_init.clear();
                }, IARG_END);

                for (INS ins=RTN_InsHead(r); INS_Valid(ins); ins=INS_Next(ins)){
                    if (INS_IsMemoryWrite(ins) && INS_IsValidForIpointAfter(ins)){
                        INS_InsertCall(ins, IPOINT_AFTER, (AFUNPTR)+[](ADDRINT ea, UINT32 sz){
                            if (!T()->cur_p || sz!=sizeof(ADDRINT)) return;

                            const ADDRINT p=T()->cur_p; const size_t RANGE=2048;
                            if (ea < p || ea >= p+RANGE) return;

                            ADDRINT val=0; PIN_SafeCopy(&val,(VOID*)ea,sizeof(val));
                            IMG img=IMG_FindByAddress(val);
                            if (!IMG_Valid(img)) return;
                            string rtn=RtnNameByAddr(val); if (rtn.empty()) return;

                            string mod = IMG_Name(img);
                            g_func_to_module[val]=mod;
                            auto &pi = g_plugins[mod]; if (pi.so_path.empty()){ pi.so_path=mod; }
                            pi.mapped_funcs[val]= rtn+"@"+mod;

                            string f; INT32 l=0; SrcByAddr(val,f,l);
                            Log << "[plugin.map.write] EA=0x" << std::hex << ea
                                << " VAL=0x" << val << std::dec
                                << " fn=" << rtn << " img=" << mod
                                << " src=" << (f.empty()?"?":f) << (l?":"+std::to_string(l):"")
                                << " init=" << (T()->cur_init.empty()? "?":T()->cur_init) << endl;
                        }, IARG_MEMORYWRITE_EA, IARG_MEMORYWRITE_SIZE, IARG_END);
                    }
                }
                RTN_Close(r);
            }
        }
    }

    // plugins_call_fn_srv_data 내부의 간접호출만 추적
    RTN srv = RTN_FindByName(img, "plugins_call_fn_srv_data");
    if (RTN_Valid(srv)){
        RTN_Open(srv);
        RTN_InsertCall(srv, IPOINT_BEFORE, (AFUNPTR)+[](INT32 e){
            T()->cur_ptype=e; T()->last_fptr_ea_valid=false;
            Log << "[srv.fn.enter] e=" << e << "(" << PTypeStr(e) << ")" << endl;
        }, IARG_FUNCARG_ENTRYPOINT_VALUE, 1, IARG_END);

        for (INS ins=RTN_InsHead(srv); INS_Valid(ins); ins=INS_Next(ins)){
            if (INS_IsCall(ins) && INS_IsIndirectControlFlow(ins)){
                // 메모리 간접호출이면 fptr EA를 BEFORE에서 저장
                if (INS_IsMemoryRead(ins)){
                    INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)+[](ADDRINT ea){
                        T()->last_fptr_ea      = ea;
                        T()->last_fptr_ea_valid= true;
                    }, IARG_MEMORYREAD_EA, IARG_END);
                }
                // 실제 분기된 표적은 TAKEN_BRANCH에서 로깅
                INS_InsertCall(ins, IPOINT_TAKEN_BRANCH, (AFUNPTR)+[](ADDRINT ip, ADDRINT tgt){
                    int e = T()->cur_ptype;
                    string mod = g_func_to_module.count(tgt)? g_func_to_module[tgt] : ImgNameByAddr(tgt);
                    string rtn = RtnNameByAddr(tgt);
                    string f; INT32 l=0; SrcByAddr(tgt,f,l);
                    std::ostringstream oss;
                    oss << "ptype=" << e << "(" << PTypeStr(e) << ")"
                        << " callip=0x" << std::hex << ip << " tgt=0x" << tgt << std::dec
                        << " mod=" << (mod.empty()? "?":mod)
                        << " fn="  << (rtn.empty()? "?":rtn)
                        << " src=" << (f.empty()? "?":f) << (l?":"+std::to_string(l):"");
                    if (T()->last_fptr_ea_valid){
                        oss << " fptrEA=0x" << std::hex << T()->last_fptr_ea << std::dec;
                        T()->last_fptr_ea_valid=false;
                    }
                    Log << "[srv.fn.indcall] " << oss.str() << endl;
                }, IARG_INST_PTR, IARG_BRANCH_TARGET_ADDR, IARG_END);
            }
        }
        RTN_Close(srv);
    }
}

static VOID OnImageUnload(IMG img, VOID*){
    Log << "[IMG_UNLOAD] " << IMG_Name(img) << endl;
}

/* --------- 스레드/마무리 --------- */
static VOID ThreadStart(THREADID, CONTEXT*, INT32, VOID*){ PIN_SetThreadData(gTLS, new TLS(), PIN_ThreadId()); }
static VOID ThreadFini (THREADID, const CONTEXT*, INT32, VOID*){ auto* t=T(); delete t; }
static VOID Fini(INT32 code, VOID*) {
    Log << "\n=== SUMMARY ===\n";
    for (auto &kv : g_plugins){
        const auto &p = kv.second;
        if (p.so_path.empty()) continue;
        Log << "PLUGIN: " << p.so_path << "\n";
        if (p.low || p.high) Log << "  map=[0x" << std::hex << p.low << ",0x" << p.high << std::dec << "]\n";
        if (p.init_addr)     Log << "  init: " << p.init_name << " @0x" << std::hex << p.init_addr << std::dec << "\n";
        if (!p.mapped_funcs.empty()){
            Log << "  handlers:\n";
            for (auto &mf : p.mapped_funcs){
                Log << "    0x" << std::hex << mf.first << std::dec << " -> " << mf.second << "\n";
            }
        }
    }
    Log << "[fini] code=" << code << endl;
    Log.close();
}

/* --------- main --------- */
int main(int argc, char* argv[]){
    PIN_InitSymbols(); // 심볼/소스 사용
    if (PIN_Init(argc, argv)) return 1;

    Log.open(KnobOut.Value().c_str());
    Log.setf(std::ios::unitbuf);
    Log << "[tool.start] lt_plugin_end2end_trace starting" << endl;

    gTLS = PIN_CreateThreadDataKey(nullptr);
    PIN_AddThreadStartFunction(ThreadStart,nullptr);
    PIN_AddThreadFiniFunction(ThreadFini,nullptr);

    IMG_AddInstrumentFunction(OnImageLoad,nullptr);
    IMG_AddUnloadFunction(OnImageUnload,nullptr);
    PIN_AddFiniFunction(Fini,nullptr);

    PIN_StartProgram();
    return 0;
}
