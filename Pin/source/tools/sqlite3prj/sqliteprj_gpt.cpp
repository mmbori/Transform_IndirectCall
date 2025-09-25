// mypin_sqlite.cpp
#include "pin.H"
#include <iostream>
#include <fstream>
#include <string>
#include <unordered_set>
#include <unordered_map>
#include <vector>
#include <mutex>
#include <cstring>

using std::cerr;
using std::endl;
using std::hex;
using std::ofstream;
using std::string;
using std::unordered_map;
using std::unordered_set;

static ofstream Log;
static KNOB<string> KnobOutput(KNOB_MODE_WRITEONCE, "pintool",
                               "o", "sqlite_indirect.log",
                               "output log file");

static std::mutex g_mu;

// sqlite 모듈 한정 필터링을 위해, 로드된 이미지 별 이름/범위 관리
struct ImgRange { ADDRINT low, high; string name; };
static std::vector<ImgRange> g_sqliteImgs;

// 분류 태그용 사전
static unordered_set<string> g_memMethodNames = {
    // mem1.c 기본 구현 함수들 (파일 근거: mem1.c) :contentReference[oaicite:7]{index=7}
    "sqlite3MemMalloc", "sqlite3MemFree", "sqlite3MemRealloc",
    "sqlite3MemSize", "sqlite3MemRoundup", "sqlite3MemInit",
    "sqlite3MemShutdown" // 일부 버전에서 존재
};
static unordered_set<string> g_pcacheHintNames = {
    // pcache1.c 관련 심볼 추정(버전/빌드에 따라 다를 수 있음) :contentReference[oaicite:8]{index=8}
    // pcache1 내부 심볼들은 'pcache1' 프리픽스를 자주 가짐
    "pcache1Fetch", "pcache1Unpin", "pcache1Rekey", "pcache1Truncate",
    "pcache1Destroy", "pcache1Init", "pcache1Shutdown",
    "sqlite3PCacheBufferSetup", "sqlite3PcacheInitialize",
    "sqlite3PcacheShutdown"
};

// builtin SQL 함수: func.c에서 많은 함수들이 ...Func 네이밍을 가짐 :contentReference[oaicite:9]{index=9}
static bool IsBuiltinSqlFuncName(const string &sym) {
    // 널리 쓰이는 규칙: ~Func로 끝나는 함수명 (예: minmaxFunc, typeofFunc, absFunc, instrFunc, printfFunc, substrFunc, upperFunc, lowerFunc 등)
    size_t n = sym.size();
    return n >= 4 && sym.compare(n-4, 4, "Func") == 0;
}

// 주소→함수명 캐시
static unordered_map<ADDRINT, string> g_symCache;

static inline bool AddrInImg(ADDRINT a, const ImgRange &r) {
    return (a >= r.low && a < r.high);
}
static bool IsFromSqliteModule(ADDRINT a) {
    for (auto &r : g_sqliteImgs) {
        if (AddrInImg(a, r)) return true;
    }
    return false;
}

static string SafeRtnName(ADDRINT a) {
    auto it = g_symCache.find(a);
    if (it != g_symCache.end()) return it->second;

    RTN rtn = RTN_FindByAddress(a);
    string name;
    if (RTN_Valid(rtn)) {
        name = RTN_Name(rtn);
    } else {
        // RTN이 없으면 섹션/IMG로 보조
        IMG img = IMG_FindByAddress(a);
        if (IMG_Valid(img)) {
            // 주소 오프셋 표시
            std::ostringstream oss;
            oss << IMG_Name(img) << "!+0x" << std::hex << (a - IMG_LowAddress(img));
            name = oss.str();
        } else {
            std::ostringstream oss;
            oss << "0x" << std::hex << a;
            name = oss.str();
        }
    }
    g_symCache[a] = name;
    return name;
}

static string ClassifyCallee(const string &sym) {
    if (g_memMethodNames.count(sym)) return "[mem.methods]";
    if (g_pcacheHintNames.count(sym) || sym.find("pcache1") != string::npos || sym.find("Pcache") != string::npos)
        return "[pcache.methods]";
    if (IsBuiltinSqlFuncName(sym)) return "[builtin.sqlfunc]";
    return "";
}

static VOID LogIndirectCall(ADDRINT ip, ADDRINT target) {
    // sqlite 모듈 내 간접호출만 관심
    if (!IsFromSqliteModule(ip) && !IsFromSqliteModule(target)) return;

    string caller = SafeRtnName(ip);
    string callee = SafeRtnName(target);
    string tag = ClassifyCallee(callee);

    std::lock_guard<std::mutex> lk(g_mu);
    Log << "[indirect.call] caller=" << caller
        << " callee=" << callee
        << " " << std::hex << (void*)target
        << (tag.empty() ? "" : ("  " + tag))
        << "\n";
}

// 모든 간접 CALL 지점에 훅킹
static VOID Instruction(INS ins, VOID *v) {
    if (INS_IsCall(ins) && INS_IsIndirectControlFlow(ins)) {
        INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)LogIndirectCall,
                       IARG_ADDRINT, INS_Address(ins),
                       IARG_BRANCH_TARGET_ADDR,
                       IARG_END);
    }
}

// 이미지 로드시 sqlite 모듈 판정 및 심볼 캐시 일부 선구축
static VOID ImageLoad(IMG img, VOID *v) {
    string iname = IMG_Name(img);
    // heuristic: 파일명에 sqlite가 포함되면 sqlite 모듈로 본다(필요시 조정)
    bool isSqlite = (iname.find("sqlite") != string::npos || iname.find("libsqlite") != string::npos);
    if (isSqlite) {
        ImgRange r{ IMG_LowAddress(img), IMG_HighAddress(img), iname };
        g_sqliteImgs.push_back(r);
    }

    // 성능을 위해 몇몇 관심 심볼을 미리 캐시
    if (isSqlite) {
        // mem methods
        for (auto &nm : g_memMethodNames) {
            RTN r = RTN_FindByName(img, nm.c_str());
            if (RTN_Valid(r)) g_symCache[RTN_Address(r)] = nm;
        }
        // pcache 힌트
        for (auto &nm : g_pcacheHintNames) {
            RTN r = RTN_FindByName(img, nm.c_str());
            if (RTN_Valid(r)) g_symCache[RTN_Address(r)] = nm;
        }
        // builtin SQL 함수 후보: 이름이 ...Func로 끝나는 모든 심볼을 한 번 훑어 캐시
        for (SEC sec = IMG_SecHead(img); SEC_Valid(sec); sec = SEC_Next(sec)) {
            for (RTN rtn = SEC_RtnHead(sec); RTN_Valid(rtn); rtn = RTN_Next(rtn)) {
                string nm = RTN_Name(rtn);
                if (IsBuiltinSqlFuncName(nm))
                    g_symCache[RTN_Address(rtn)] = nm;
            }
        }
    }
}

static VOID Fini(INT32 code, VOID *v) {
    std::lock_guard<std::mutex> lk(g_mu);
    Log.flush();
    Log.close();
}

int main(int argc, char *argv[]) {
    if (PIN_Init(argc, argv)) {
        cerr << "PIN_Init failed" << endl;
        return 1;
    }
    Log.open(KnobOutput.Value().c_str());
    if (!Log.is_open()) {
        cerr << "Cannot open log file\n";
        return 1;
    }

    IMG_AddInstrumentFunction(ImageLoad, 0);
    INS_AddInstrumentFunction(Instruction, 0);
    PIN_AddFiniFunction(Fini, 0);

    PIN_StartProgram();
    return 0;
}
