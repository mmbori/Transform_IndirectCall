#include "pin.H"
#include <iostream>
#include <fstream>
#include <map>
#include <set>
#include <string>
#include <unordered_map>

using namespace std;

// 출력 파일
ofstream TraceFile;

// 추적할 SQLite3 함수 포인터 이름들
set<string> sqlite_system_functions = {
    // mem1.c - sqlite3MemSetDefault에서 설정되는 함수들
    "sqlite3MemMalloc",
    "sqlite3MemFree", 
    "sqlite3MemRealloc",
    "sqlite3MemSize",
    "sqlite3MemRoundup",
    "sqlite3MemInit",
    "sqlite3MemShutdown",
    
    // pcache1.c - sqlite3PCacheSetDefault에서 설정되는 함수들
    "pcache1Init",
    "pcache1Shutdown",
    "pcache1Create",
    "pcache1Cachesize",
    "pcache1Pagecount", 
    "pcache1Fetch",
    "pcache1Unpin",
    "pcache1Rekey",
    "pcache1Truncate",
    "pcache1Destroy",
    "pcache1Shrink"
};

// func.c의 aBuiltinFunc 배열에서 추출한 모든 함수 이름들 (완전한 목록)
set<string> sqlite_builtin_functions = {
    // TEST_FUNC 매크로 함수들 (SQLITE_TESTCTRL_INTERNAL_FUNCTIONS 조건부)
    "implies_nonnull_row",
    "expr_compare",
    "expr_implies_expr", 
    "affinity",
    
    // 조건부 컴파일 함수들
    "soundex",                    // SQLITE_SOUNDEX
    "load_extension",             // !SQLITE_OMIT_LOAD_EXTENSION
    "sqlite_compileoption_used",  // !SQLITE_OMIT_COMPILEOPTION_DIAGS
    "sqlite_compileoption_get",   // !SQLITE_OMIT_COMPILEOPTION_DIAGS
    
    // INLINE_FUNC 매크로 함수들
    "unlikely",
    "likelihood", 
    "likely",
    "sqlite_offset",              // SQLITE_ENABLE_OFFSET_SQL_FUNC
    
    // 문자열 처리 함수들
    "ltrim",
    "rtrim", 
    "trim",
    
    // 집계 및 비교 함수들
    "min",
    "max",
    
    // 타입 및 메타데이터 함수들
    "typeof",
    "subtype",
    "length",
    "octet_length",
    
    // 문자열 함수들
    "instr",
    "printf",
    "format", 
    "unicode",
    "char",
    
    // 수학 함수들
    "abs",
    "round",                      // !SQLITE_OMIT_FLOATING_POINT
    
    // 디버그 함수들
    "fpdecode",                   // SQLITE_DEBUG
    "parseuri",                   // SQLITE_DEBUG
    
    // 대소문자 변환
    "upper",
    "lower",
    
    // 인코딩 함수들
    "hex",
    "unhex",
    
    // 문자열 연결 함수들
    "concat",
    "concat_ws",
    
    // 조건부 함수들
    "ifnull",
    
    // 랜덤 함수들
    "random",
    "randomblob",
    "nullif",
    
    // SQLite 메타 함수들
    "sqlite_version",
    "sqlite_source_id", 
    "sqlite_log",
    
    // 유니코드 함수들
    "unistr",
    "quote",
    "unistr_quote",
    
    // 데이터베이스 상태 함수들
    "last_insert_rowid",
    "changes",
    "total_changes",
    
    // 문자열 조작
    "replace",
    "zeroblob",
    "substr",
    "substring",
    
    // 집계 함수들 (WAGGREGATE)
    "sum",
    "total", 
    "avg",
    "count",
    "group_concat",
    "string_agg",
    
    // 패턴 매칭 함수들 (LIKEFUNC)
    "glob",
    "like",
    
    // 조건부 함수들
    "unknown",                    // SQLITE_ENABLE_UNKNOWN_SQL_FUNCTION
    
    // 수학 함수들 (SQLITE_ENABLE_MATH_FUNCTIONS)
    "ceil",
    "ceiling",
    "floor", 
    "trunc",                      // SQLITE_HAVE_C99_MATH_FUNCS
    "ln",
    "log",
    "log10",
    "log2",
    "exp",
    "pow",
    "power",
    "mod",
    "acos",
    "asin", 
    "atan",
    "atan2",
    "cos", 
    "sin",
    "tan",
    "cosh",
    "sinh",
    "tanh",
    "acosh",                      // SQLITE_HAVE_C99_MATH_FUNCS
    "asinh",                      // SQLITE_HAVE_C99_MATH_FUNCS
    "atanh",                      // SQLITE_HAVE_C99_MATH_FUNCS
    "sqrt",
    "radians",
    "degrees",
    "pi",
    
    // 기타 함수들
    "sign",
    "coalesce",
    "iif",
    "if"
};

// 추가 SQLite 시스템 함수들 (다른 파일에서 정의되는 함수들)
set<string> sqlite_additional_functions = {
    // 날짜/시간 함수들 (date.c)
    "date",
    "time", 
    "datetime",
    "julianday",
    "strftime",
    "unixepoch",
    "timediff",
    "datediff",
    
    // JSON 함수들 (json1.c)
    "json",
    "json_array",
    "json_array_length", 
    "json_extract",
    "json_insert",
    "json_object",
    "json_patch",
    "json_remove",
    "json_replace",
    "json_set",
    "json_type",
    "json_valid",
    "json_quote",
    "json_group_array",
    "json_group_object",
    "json_each",
    "json_tree",
    
    // 윈도우 함수들 (window.c)
    "row_number",
    "rank",
    "dense_rank",
    "percent_rank",
    "cume_dist",
    "ntile",
    "lag",
    "lead",
    "first_value",
    "last_value",
    "nth_value"
};

// 함수 주소와 이름 매핑
unordered_map<ADDRINT, string> function_addresses;
unordered_map<ADDRINT, string> indirect_call_sites;

// 간접 호출 카운터
map<string, int> indirect_call_counts;

// 함수 주소 등록
VOID RegisterFunctionAddress(ADDRINT addr, const string& name) {
    function_addresses[addr] = name;
    TraceFile << "[REGISTER] Function " << name << " at address: 0x" 
              << hex << addr << dec << endl;
}

// 간접 호출 분석
VOID AnalyzeIndirectCall(ADDRINT ip, ADDRINT target) {
    auto it = function_addresses.find(target);
    if (it != function_addresses.end()) {
        const string& func_name = it->second;
        indirect_call_counts[func_name]++;
        
        TraceFile << "[INDIRECT_CALL] " << func_name 
                  << " called from 0x" << hex << ip 
                  << " to 0x" << target << dec 
                  << " (count: " << indirect_call_counts[func_name] << ")" << endl;
    }
}

// 메모리 쓰기 추적 (함수 포인터 설정 감지)
VOID TraceMemoryWrite(ADDRINT ip, ADDRINT addr, ADDRINT value) {
    // 함수 포인터로 보이는 값인지 확인
    auto it = function_addresses.find(value);
    if (it != function_addresses.end()) {
        TraceFile << "[FUNC_PTR_SET] Function pointer to " << it->second 
                  << " set at address 0x" << hex << addr 
                  << " from instruction 0x" << ip << dec << endl;
    }
}

// Instruction 콜백
VOID Instruction(INS ins, VOID *v) {
    // 간접 호출 명령어 추적
    if (INS_IsIndirectControlFlow(ins)) {
        INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)AnalyzeIndirectCall,
                      IARG_INST_PTR,
                      IARG_BRANCH_TARGET_ADDR,
                      IARG_END);
    }
    
    // 메모리 쓰기 명령어 추적 (함수 포인터 설정 감지)
    if (INS_IsMemoryWrite(ins)) {
        INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)TraceMemoryWrite,
                      IARG_INST_PTR,
                      IARG_MEMORYWRITE_EA,
                      IARG_ADDRINT, 0,
                      IARG_END);
    }
}

// 루틴(함수) 콜백
VOID Routine(RTN rtn, VOID *v) {
    const string& rtn_name = RTN_Name(rtn);
    
    // SQLite 관련 함수인지 확인
    if (sqlite_system_functions.count(rtn_name) || 
        sqlite_builtin_functions.count(rtn_name) ||
        sqlite_additional_functions.count(rtn_name) ||
        rtn_name.find("sqlite") != string::npos) {
        
        RTN_Open(rtn);
        ADDRINT rtn_addr = RTN_Address(rtn);
        RegisterFunctionAddress(rtn_addr, rtn_name);
        
        // 함수 진입점 로깅
        RTN_InsertCall(rtn, IPOINT_BEFORE, (AFUNPTR)[](const string* name) {
            TraceFile << "[FUNCTION_ENTRY] " << *name << endl;
        }, IARG_PTR, new string(rtn_name), IARG_END);
        
        RTN_Close(rtn);
    }
}

// 이미지 로드 콜백
VOID ImageLoad(IMG img, VOID *v) {
    const string& img_name = IMG_Name(img);
    TraceFile << "[IMAGE_LOAD] " << img_name << endl;
    
    // SQLite 관련 이미지인지 확인
    if (img_name.find("sqlite") != string::npos || 
        img_name.find("libsqlite3") != string::npos) {
        
        TraceFile << "[SQLITE_IMAGE] SQLite image loaded: " << img_name << endl;
        
        // 모든 섹션의 심볼 검사
        for (SEC sec = IMG_SecHead(img); SEC_Valid(sec); sec = SEC_Next(sec)) {
            for (RTN rtn = SEC_RtnHead(sec); RTN_Valid(rtn); rtn = RTN_Next(rtn)) {
                const string& rtn_name = RTN_Name(rtn);
                
                if (sqlite_system_functions.count(rtn_name) || 
                    sqlite_builtin_functions.count(rtn_name) ||
                    sqlite_additional_functions.count(rtn_name)) {
                    
                    ADDRINT rtn_addr = RTN_Address(rtn);
                    RegisterFunctionAddress(rtn_addr, rtn_name);
                }
            }
        }
    }
}

// 초기화 특별 처리
VOID TraceInitFunctions() {
    TraceFile << "[INIT] Tracing SQLite3 initialization functions:" << endl;
    TraceFile << "- sqlite3MemSetDefault (mem1.c)" << endl;
    TraceFile << "- sqlite3PCacheSetDefault (pcache1.c)" << endl;
    TraceFile << "- sqlite3RegisterBuiltinFunctions (func.c)" << endl;
    TraceFile << "- Total builtin functions tracked: " << sqlite_builtin_functions.size() << endl;
    TraceFile << "- Total system functions tracked: " << sqlite_system_functions.size() << endl;
    TraceFile << "- Total additional functions tracked: " << sqlite_additional_functions.size() << endl;
}

// 종료 시 통계 출력
VOID Fini(INT32 code, VOID *v) {
    TraceFile << "\n[STATISTICS] Indirect call counts:" << endl;
    for (const auto& pair : indirect_call_counts) {
        TraceFile << "  " << pair.first << ": " << pair.second << " calls" << endl;
    }
    
    TraceFile << "\n[TOTAL] " << function_addresses.size() 
              << " SQLite functions tracked" << endl;
    TraceFile.close();
}

// 사용법 출력
INT32 Usage() {
    cerr << "SQLite3 Function Pointer Tracer (Complete Edition)" << endl;
    cerr << "Tracks indirect calls to all SQLite3 system and builtin functions" << endl;
    cerr << "Including all functions from aBuiltinFunc array regardless of compile-time conditions" << endl;
    cerr << KNOB_BASE::StringKnobSummary() << endl;
    return -1;
}

// 메인 함수
int main(int argc, char *argv[]) {
    PIN_InitSymbols();
    
    if (PIN_Init(argc, argv)) return Usage();
    
    TraceFile.open("sqlite3_complete_trace.out");
    TraceFile << "[START] SQLite3 Complete Function Pointer Tracing Started" << endl;
    
    TraceInitFunctions();
    
    // 콜백 등록
    IMG_AddInstrumentFunction(ImageLoad, 0);
    RTN_AddInstrumentFunction(Routine, 0);
    INS_AddInstrumentFunction(Instruction, 0);
    PIN_AddFiniFunction(Fini, 0);
    
    // 실행 시작
    PIN_StartProgram();
    return 0;
}