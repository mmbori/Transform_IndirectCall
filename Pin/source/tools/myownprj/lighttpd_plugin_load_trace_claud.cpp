#include "pin.H"
#include <iostream>
#include <fstream>
#include <iomanip>
#include <map>
#include <vector>
#include <string>
#include <sstream>

using namespace std;

// 출력 파일
ofstream TraceFile;

// 플러그인 정보를 저장하는 구조체
struct PluginInfo {
    string module_name;
    ADDRINT lib_base;
    ADDRINT lib_end;
    ADDRINT init_func_addr;
    string init_func_name;
    map<ADDRINT, string> mapped_functions; // 함수 주소 -> 함수 이름
};

// 함수 포인터 매핑 정보
struct FunctionMapping {
    ADDRINT func_ptr_addr;    // 함수 포인터가 저장된 주소
    ADDRINT func_addr;        // 실제 함수 주소
    string plugin_name;       // 소속 플러그인
    string handler_type;      // 핸들러 타입 (set_defaults, worker_init 등)
    int plugin_id;           // 플러그인 ID
};

// 전역 데이터 구조
map<string, PluginInfo> g_plugins;                    // 모듈명 -> 플러그인 정보
map<ADDRINT, FunctionMapping> g_function_mappings;    // 함수 주소 -> 매핑 정보
map<ADDRINT, string> g_address_to_symbol;            // 주소 -> 심볼명
vector<ADDRINT> g_plugin_slots_addresses;            // srv->plugin_slots 주소들

// 핸들러 타입 이름 배열 (plugin.c의 plugin_t enum과 동일한 순서)
const char* HANDLER_TYPES[] = {
    "HANDLE_URI_CLEAN",
    "HANDLE_DOCROOT", 
    "HANDLE_PHYSICAL",
    "HANDLE_SUBREQUEST_START",
    "HANDLE_RESPONSE_START",
    "HANDLE_REQUEST_DONE",
    "HANDLE_REQUEST_RESET",
    "HANDLE_REQUEST_ENV",
    "HANDLE_CONNECTION_ACCEPT",
    "HANDLE_CONNECTION_SHUT_WR",
    "HANDLE_CONNECTION_CLOSE",
    "HANDLE_TRIGGER",
    "HANDLE_WAITPID",
    "HANDLE_SIGHUP",
    "SET_DEFAULTS",
    "WORKER_INIT"
};

// 현재 로딩 중인 플러그인 이름 (plugins_load 컨텍스트에서 사용)
string g_current_loading_plugin;

// 유틸리티 함수: 주소에서 심볼 이름 가져오기
string GetSymbolName(ADDRINT addr) {
    if (g_address_to_symbol.find(addr) != g_address_to_symbol.end()) {
        return g_address_to_symbol[addr];
    }
    
    // PIN API를 사용하여 심볼 정보 가져오기
    PIN_LockClient();
    string name = RTN_FindNameByAddress(addr);
    PIN_UnlockClient();
    
    if (!name.empty()) {
        g_address_to_symbol[addr] = name;
        return name;
    }
    
    return "unknown";
}

// 유틸리티 함수: 주소가 어느 플러그인에 속하는지 확인
string GetPluginByAddress(ADDRINT addr) {
    for (const auto& plugin : g_plugins) {
        if (addr >= plugin.second.lib_base && addr <= plugin.second.lib_end) {
            return plugin.first;
        }
    }
    return "unknown";
}

// dlopen/LoadLibrary 후킹 - 라이브러리 로드 추적
VOID OnLibraryLoad(ADDRINT lib_handle, const string& lib_path) {
    TraceFile << "\n=== LIBRARY LOAD ===" << endl;
    TraceFile << "Library: " << lib_path << endl;
    TraceFile << "Handle: 0x" << hex << lib_handle << endl;
    
    // 모듈 이름 추출 (mod_xxx.so에서 xxx 부분)
    size_t last_slash = lib_path.find_last_of("/\\");
    string filename = (last_slash != string::npos) ? lib_path.substr(last_slash + 1) : lib_path;
    
    if (filename.find("mod_") == 0 && filename.find(".so") != string::npos) {
        string module_name = filename.substr(4); // "mod_" 제거
        size_t dot_pos = module_name.find('.');
        if (dot_pos != string::npos) {
            module_name = module_name.substr(0, dot_pos); // ".so" 제거
        }
        
        g_current_loading_plugin = module_name;
        
        // 라이브러리 주소 범위 가져오기
        PIN_LockClient();
        IMG img = IMG_FindByAddress(lib_handle);
        if (IMG_Valid(img)) {
            ADDRINT base = IMG_LowAddress(img);
            ADDRINT end = IMG_HighAddress(img);
            
            g_plugins[module_name] = {
                module_name,
                base,
                end,
                0, // init_func_addr는 나중에 설정
                "",
                {}
            };
            
            TraceFile << "Module: " << module_name << endl;
            TraceFile << "Base: 0x" << hex << base << endl;
            TraceFile << "End: 0x" << hex << end << endl;
        }
        PIN_UnlockClient();
    }
}

// dlsym/GetProcAddress 후킹 - 함수 심볼 검색 추적
VOID OnSymbolLookup(const string& symbol_name, ADDRINT func_addr) {
    TraceFile << "\n=== SYMBOL LOOKUP ===" << endl;
    TraceFile << "Symbol: " << symbol_name << endl;
    TraceFile << "Address: 0x" << hex << func_addr << endl;
    
    // mod_xxx_plugin_init 함수인지 확인
    if (symbol_name.find("_plugin_init") != string::npos && !g_current_loading_plugin.empty()) {
        string expected_init = g_current_loading_plugin + "_plugin_init";
        if (symbol_name == expected_init) {
            if (g_plugins.find(g_current_loading_plugin) != g_plugins.end()) {
                g_plugins[g_current_loading_plugin].init_func_addr = func_addr;
                g_plugins[g_current_loading_plugin].init_func_name = symbol_name;
                
                TraceFile << "Found init function for plugin: " << g_current_loading_plugin << endl;
                TraceFile << "Init function address: 0x" << hex << func_addr << endl;
            }
        }
    }
    
    g_address_to_symbol[func_addr] = symbol_name;
}

// 함수 포인터 할당 추적 (struct plugin의 멤버에 함수 주소 할당)
VOID OnFunctionPointerAssignment(ADDRINT ptr_addr, ADDRINT func_addr, ADDRINT context_addr) {
    string plugin_name = GetPluginByAddress(func_addr);
    string func_name = GetSymbolName(func_addr);
    
    TraceFile << "\n=== FUNCTION POINTER ASSIGNMENT ===" << endl;
    TraceFile << "Pointer Address: 0x" << hex << ptr_addr << endl;
    TraceFile << "Function Address: 0x" << hex << func_addr << endl;
    TraceFile << "Function Name: " << func_name << endl;
    TraceFile << "Plugin: " << plugin_name << endl;
    TraceFile << "Context: 0x" << hex << context_addr << endl;
    
    if (plugin_name != "unknown") {
        g_plugins[plugin_name].mapped_functions[func_addr] = func_name;
    }
}

// srv->plugin_slots 배열 할당 추적
VOID OnPluginSlotsAllocation(ADDRINT slots_addr, size_t size) {
    TraceFile << "\n=== PLUGIN SLOTS ALLOCATION ===" << endl;
    TraceFile << "Slots Address: 0x" << hex << slots_addr << endl;
    TraceFile << "Size: " << dec << size << " bytes" << endl;
    
    g_plugin_slots_addresses.push_back(slots_addr);
}

// plugin_slots 배열에 함수 저장 추적
VOID OnPluginSlotStore(ADDRINT slot_addr, ADDRINT func_addr, int slot_index, const string& handler_type) {
    string plugin_name = GetPluginByAddress(func_addr);
    string func_name = GetSymbolName(func_addr);
    
    TraceFile << "\n=== PLUGIN SLOT STORE ===" << endl;
    TraceFile << "Slot Address: 0x" << hex << slot_addr << endl;
    TraceFile << "Slot Index: " << dec << slot_index << endl;
    TraceFile << "Handler Type: " << handler_type << endl;
    TraceFile << "Function Address: 0x" << hex << func_addr << endl;
    TraceFile << "Function Name: " << func_name << endl;
    TraceFile << "Plugin: " << plugin_name << endl;
    
    // 매핑 정보 저장
    FunctionMapping mapping = {
        slot_addr,
        func_addr,
        plugin_name,
        handler_type,
        0 // plugin_id는 나중에 설정
    };
    g_function_mappings[func_addr] = mapping;
}

// 함수 포인터 실행 추적
VOID OnFunctionPointerCall(ADDRINT func_addr, ADDRINT call_site) {
    // plugin_slots에서 실행되는 함수인지 확인
    bool is_plugin_call = false;
    string handler_type = "unknown";
    string plugin_name = "unknown";
    
    if (g_function_mappings.find(func_addr) != g_function_mappings.end()) {
        is_plugin_call = true;
        const FunctionMapping& mapping = g_function_mappings[func_addr];
        handler_type = mapping.handler_type;
        plugin_name = mapping.plugin_name;
    } else {
        plugin_name = GetPluginByAddress(func_addr);
    }
    
    string func_name = GetSymbolName(func_addr);
    
    TraceFile << "\n=== FUNCTION POINTER CALL ===" << endl;
    TraceFile << "Call Site: 0x" << hex << call_site << endl;
    TraceFile << "Function Address: 0x" << hex << func_addr << endl;
    TraceFile << "Function Name: " << func_name << endl;
    TraceFile << "Plugin: " << plugin_name << endl;
    TraceFile << "Is Plugin Call: " << (is_plugin_call ? "YES" : "NO") << endl;
    if (is_plugin_call) {
        TraceFile << "Handler Type: " << handler_type << endl;
    }
    
    // 호출 스택 추적을 위한 추가 정보
    string caller_name = GetSymbolName(call_site);
    TraceFile << "Caller: " << caller_name << endl;
}

// 메모리 쓰기 후킹 (함수 포인터 할당 탐지용)
VOID OnMemoryWrite(ADDRINT addr, ADDRINT value, UINT32 size) {
    // 포인터 크기 쓰기만 추적 (일반적으로 8바이트 또는 4바이트)
    if (size != sizeof(void*)) return;
    
    // 값이 실행 가능한 주소 범위인지 확인
    if (value < 0x400000) return; // 일반적인 실행 가능 주소 범위 하한
    
    // 쓰여진 값이 알려진 함수 주소인지 확인
    string func_name = GetSymbolName(value);
    if (func_name != "unknown") {
        OnFunctionPointerAssignment(addr, value, 0);
    }
}

// 간접 호출 후킹 (함수 포인터 호출 탐지)
VOID OnIndirectCall(ADDRINT target, ADDRINT call_site) {
    OnFunctionPointerCall(target, call_site);
}

// 이미지 로드 시 후킹 설정
VOID ImageLoad(IMG img, VOID *v) {
    string img_name = IMG_Name(img);
    
    // lighttpd 메인 바이너리인 경우
    if (img_name.find("lighttpd") != string::npos) {
        TraceFile << "Main binary loaded: " << img_name << endl;
        
        // 주요 함수들에 대한 후킹 설정
        RTN rtn;
        
        // plugins_load 함수 후킹
        rtn = RTN_FindByName(img, "plugins_load");
        if (RTN_Valid(rtn)) {
            RTN_Open(rtn);
            RTN_InsertCall(rtn, IPOINT_BEFORE, (AFUNPTR)TraceFile.operator<<,
                          IARG_PTR, "\n=== PLUGINS_LOAD START ===\n", IARG_END);
            RTN_Close(rtn);
        }
        
        // plugins_call_init 함수 후킹
        rtn = RTN_FindByName(img, "plugins_call_init");
        if (RTN_Valid(rtn)) {
            RTN_Open(rtn);
            RTN_InsertCall(rtn, IPOINT_BEFORE, (AFUNPTR)TraceFile.operator<<,
                          IARG_PTR, "\n=== PLUGINS_CALL_INIT START ===\n", IARG_END);
            RTN_Close(rtn);
        }
        
        // plugins_call_fn_srv_data 함수 후킹
        rtn = RTN_FindByName(img, "plugins_call_fn_srv_data");
        if (RTN_Valid(rtn)) {
            RTN_Open(rtn);
            RTN_InsertCall(rtn, IPOINT_BEFORE, (AFUNPTR)TraceFile.operator<<,
                          IARG_PTR, "\n=== PLUGINS_CALL_FN_SRV_DATA START ===\n", IARG_END);
            RTN_Close(rtn);
        }
    }
    
    // dlopen/dlsym 후킹 설정
    RTN dlopen_rtn = RTN_FindByName(img, "dlopen");
    if (RTN_Valid(dlopen_rtn)) {
        RTN_Open(dlopen_rtn);
        RTN_InsertCall(dlopen_rtn, IPOINT_AFTER, (AFUNPTR)OnLibraryLoad,
                      IARG_FUNCRET_EXITPOINT_VALUE,
                      IARG_FUNCARG_ENTRYPOINT_VALUE, 0,
                      IARG_END);
        RTN_Close(dlopen_rtn);
    }
    
    RTN dlsym_rtn = RTN_FindByName(img, "dlsym");
    if (RTN_Valid(dlsym_rtn)) {
        RTN_Open(dlsym_rtn);
        RTN_InsertCall(dlsym_rtn, IPOINT_AFTER, (AFUNPTR)OnSymbolLookup,
                      IARG_FUNCARG_ENTRYPOINT_VALUE, 1,
                      IARG_FUNCRET_EXITPOINT_VALUE,
                      IARG_END);
        RTN_Close(dlsym_rtn);
    }
    
    // 모든 간접 호출에 대한 후킹 설정
    for (SEC sec = IMG_SecHead(img); SEC_Valid(sec); sec = SEC_Next(sec)) {
        for (RTN rtn = SEC_RtnHead(sec); RTN_Valid(rtn); rtn = RTN_Next(rtn)) {
            RTN_Open(rtn);
            
            for (INS ins = RTN_InsHead(rtn); INS_Valid(ins); ins = INS_Next(ins)) {
                // 간접 호출 명령어 후킹
                if (INS_IsIndirectBranchOrCall(ins)) {
                    INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnIndirectCall,
                                  IARG_BRANCH_TARGET_ADDR,
                                  IARG_INST_PTR,
                                  IARG_END);
                }
                
                // 메모리 쓰기 명령어 후킹 (함수 포인터 할당 탐지용)
                if (INS_IsMemoryWrite(ins)) {
                    INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnMemoryWrite,
                                  IARG_MEMORYWRITE_EA,
                                  IARG_MEMORYWRITE_VALUE,
                                  IARG_MEMORYWRITE_SIZE,
                                  IARG_END);
                }
            }
            
            RTN_Close(rtn);
        }
    }
}

// 프로그램 종료 시 요약 정보 출력
VOID Fini(INT32 code, VOID *v) {
    TraceFile << "\n\n=== FINAL SUMMARY ===" << endl;
    
    TraceFile << "\n--- Loaded Plugins ---" << endl;
    for (const auto& plugin : g_plugins) {
        const PluginInfo& info = plugin.second;
        TraceFile << "Plugin: " << info.module_name << endl;
        TraceFile << "  Base: 0x" << hex << info.lib_base << endl;
        TraceFile << "  End: 0x" << hex << info.lib_end << endl;
        TraceFile << "  Init Function: " << info.init_func_name 
                  << " @ 0x" << hex << info.init_func_addr << endl;
        TraceFile << "  Mapped Functions:" << endl;
        for (const auto& func : info.mapped_functions) {
            TraceFile << "    0x" << hex << func.first << " -> " << func.second << endl;
        }
        TraceFile << endl;
    }
    
    TraceFile << "\n--- Function Mappings ---" << endl;
    for (const auto& mapping : g_function_mappings) {
        const FunctionMapping& info = mapping.second;
        TraceFile << "Function: 0x" << hex << mapping.first << endl;
        TraceFile << "  Plugin: " << info.plugin_name << endl;
        TraceFile << "  Handler: " << info.handler_type << endl;
        TraceFile << "  Slot Address: 0x" << hex << info.func_ptr_addr << endl;
        TraceFile << endl;
    }
    
    TraceFile.close();
}

// 사용법 출력
INT32 Usage() {
    cerr << "Lighttpd Plugin Tracer" << endl;
    cerr << KNOB_BASE::StringKnobSummary() << endl;
    return -1;
}

// 출력 파일 지정을 위한 옵션
KNOB<string> KnobOutputFile(KNOB_MODE_WRITEONCE, "pintool",
    "o", "lighttpd_plugin_trace.out", "specify output file name");

// 메인 함수
int main(int argc, char * argv[]) {
    // Pin 초기화
    if (PIN_Init(argc, argv)) return Usage();
    
    // 출력 파일 열기
    TraceFile.open(KnobOutputFile.Value().c_str());
    TraceFile << "=== Lighttpd Plugin Tracer Started ===" << endl;
    TraceFile << "PID: " << PIN_GetPid() << endl;
    TraceFile << "Output: " << KnobOutputFile.Value() << endl;
    TraceFile << "=======================================" << endl;
    
    // 이미지 로드 콜백 등록
    IMG_AddInstrumentFunction(ImageLoad, 0);
    
    // 프로그램 종료 콜백 등록
    PIN_AddFiniFunction(Fini, 0);
    
    // 프로그램 시작
    PIN_StartProgram();
    
    return 0;
}