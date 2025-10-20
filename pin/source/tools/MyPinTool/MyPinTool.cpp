// #include "pin.H"
// #include <iostream>
// #include <fstream>
// #include <map>
// #include <string>
// #include <sstream>

// using namespace std;

// // 명령줄 옵션
// KNOB<string> KnobOutputFile(KNOB_MODE_WRITEONCE, "pintool",
//     "o", "indirect_calls.out", "output file name");

// // 전역 변수
// ofstream OutFile;
// UINT64 totalIndirectCalls = 0;
// map<ADDRINT, UINT64> indirectCallSites; // 각 호출 사이트별 카운트
// map<ADDRINT, string> symbolCache; // 심볼 캐시 (성능 개선)

// // 주소를 함수 이름으로 변환하는 헬퍼 함수
// string GetFunctionName(ADDRINT addr)
// {
//     // 캐시 확인
//     auto cached = symbolCache.find(addr);
//     if (cached != symbolCache.end())
//         return cached->second;
    
//     string result;
    
//     PIN_LockClient();
    
//     // 1. 이미지 이름 가져오기
//     string imgName;
//     IMG img = IMG_FindByAddress(addr);
//     if (IMG_Valid(img)) {
//         imgName = IMG_Name(img);
//         // 경로에서 파일명만 추출
//         size_t pos = imgName.find_last_of("/\\");
//         if (pos != string::npos)
//             imgName = imgName.substr(pos + 1);
//     }
    
//     // 2. 함수 이름 가져오기
//     string fnName;
//     RTN rtn = RTN_FindByAddress(addr);
//     if (RTN_Valid(rtn)) {
//         fnName = RTN_Name(rtn);
        
//         // 디버깅: 첫 10개만 로그
//         static int debug_count = 0;
//         if (debug_count < 10 && imgName.find("redis") != string::npos) {
//             cerr << "[DEBUG] addr=0x" << hex << addr << dec 
//                  << " img=" << imgName 
//                  << " fnName=" << (fnName.empty() ? "<empty>" : fnName) << endl;
//             debug_count++;
//         }
//     }
    
//     PIN_UnlockClient();
    
//     // 3. 결과 조합
//     if (!imgName.empty()) {
//         if (!fnName.empty()) {
//             result = imgName + ":" + fnName;
//         } else {
//             ADDRINT offset = addr - IMG_LowAddress(img);
//             ostringstream oss;
//             oss << imgName << ":+0x" << hex << offset;
//             result = oss.str();
//         }
//     } else if (!fnName.empty()) {
//         result = fnName;
//     } else {
//         result = "unknown";
//     }
    
//     // 캐시에 저장
//     symbolCache[addr] = result;
    
//     return result;
// }

// // 간접 호출이 실행될 때마다 호출되는 분석 함수
// VOID CountIndirectCall(ADDRINT callSiteAddr, ADDRINT targetAddr)
// {
//     totalIndirectCalls++;
//     indirectCallSites[callSiteAddr]++;
    
//     // 상세 로깅 + 총 횟수 표시 (함수 이름 포함)
//     string callSiteName = GetFunctionName(callSiteAddr);
//     string targetName = GetFunctionName(targetAddr);
    
//     OutFile << "[" << dec << totalIndirectCalls << "] "
//             << "Indirect call at 0x" << hex << callSiteAddr 
//             << " (" << callSiteName << ")"
//             << " -> target 0x" << targetAddr 
//             << " (" << targetName << ")" << dec << endl;
    
//     // 매 1000번마다 진행 상황 출력 (파일에만 기록)
//     if (totalIndirectCalls % 1000 == 0) {
//         OutFile << "[Progress] Total indirect calls: " << totalIndirectCalls << endl;
//         OutFile.flush();  // 즉시 파일에 쓰기
//     }
// }

// // 명령어를 검사하여 간접 호출을 계측
// VOID Instruction(INS ins, VOID *v)
// {
//     // 간접 호출 명령어 확인
//     if (INS_IsCall(ins) && !INS_IsDirectCall(ins))
//     {
//         // 간접 호출 발견
//         INS_InsertCall(
//             ins,
//             IPOINT_BEFORE,
//             (AFUNPTR)CountIndirectCall,
//             IARG_INST_PTR,                    // 호출 명령어의 주소
//             IARG_BRANCH_TARGET_ADDR,          // 타겟 주소
//             IARG_END
//         );
//     }
// }

// // 프로그램 종료 시 호출되는 함수
// VOID Fini(INT32 code, VOID *v)
// {
//     OutFile << "\n========== Indirect Call Statistics ==========" << endl;
//     OutFile << "Total indirect calls: " << totalIndirectCalls << endl;
//     OutFile << "Unique call sites: " << indirectCallSites.size() << endl;
//     OutFile << "\nIndirect call sites breakdown:" << endl;
    
//     // 호출 사이트별 통계 출력 (함수 이름 포함)
//     for (auto it = indirectCallSites.begin(); it != indirectCallSites.end(); ++it)
//     {
//         string functionName = GetFunctionName(it->first);
//         OutFile << "  0x" << hex << it->first << dec 
//                 << " (" << functionName << ")"
//                 << ": " << it->second << " calls" << endl;
//     }
    
//     OutFile.close();
    
//     // 콘솔에도 요약 출력 (stderr로 출력하여 파이프 간섭 방지)
//     cerr << "\n========================================" << endl;
//     cerr << "[Indirect Call Counter] Final Results" << endl;
//     cerr << "========================================" << endl;
//     cerr << "Total indirect calls: " << totalIndirectCalls << endl;
//     cerr << "Unique call sites: " << indirectCallSites.size() << endl;
//     cerr << "Output file: " << KnobOutputFile.Value() << endl;
//     cerr << "========================================" << endl;
// }

// // 사용법 출력
// INT32 Usage()
// {
//     cerr << "This tool counts indirect calls in a program" << endl;
//     cerr << KNOB_BASE::StringKnobSummary() << endl;
//     return -1;
// }

// // 메인 함수
// int main(int argc, char *argv[])
// {
//     // Pin 초기화
//     if (PIN_Init(argc, argv)) return Usage();
    
//     // 심볼 초기화 (중요!)
//     PIN_InitSymbols();
    
//     // 출력 파일 열기
//     string fileName = KnobOutputFile.Value();
//     OutFile.open(fileName.c_str());
//     if (!OutFile.is_open())
//     {
//         cerr << "Error: Cannot open output file: " << fileName << endl;
//         return -1;
//     }
    
//     OutFile << "Indirect Call Instrumentation Log" << endl;
//     OutFile << "===================================" << endl;
    
//     // 명령어 계측 콜백 등록
//     INS_AddInstrumentFunction(Instruction, 0);
    
//     // 종료 콜백 등록
//     PIN_AddFiniFunction(Fini, 0);
    
//     // 프로그램 실행 시작
//     PIN_StartProgram();
    
//     return 0;
// }

#include "pin.H"
#include <iostream>
#include <fstream>
#include <map>
#include <string>
#include <sstream>

using namespace std;

// 명령줄 옵션
KNOB<string> KnobOutputFile(KNOB_MODE_WRITEONCE, "pintool",
    "o", "indirect_calls.out", "output file name");

// 전역 변수
ofstream OutFile;
UINT64 totalIndirectCalls = 0;
map<ADDRINT, UINT64> indirectCallSites; // 각 호출 사이트별 카운트
map<ADDRINT, string> symbolCache; // 심볼 캐시 (성능 개선)

// 주소를 함수 이름으로 변환하는 헬퍼 함수
string GetFunctionName(ADDRINT addr)
{
    // 캐시 확인
    auto cached = symbolCache.find(addr);
    if (cached != symbolCache.end())
        return cached->second;
    
    string result;
    
    PIN_LockClient();
    
    // 1. 이미지 이름 가져오기
    string imgName;
    IMG img = IMG_FindByAddress(addr);
    if (IMG_Valid(img)) {
        imgName = IMG_Name(img);
        // 경로에서 파일명만 추출
        size_t pos = imgName.find_last_of("/\\");
        if (pos != string::npos)
            imgName = imgName.substr(pos + 1);
    }
    
    // 2. 함수 이름 가져오기
    string fnName;
    RTN rtn = RTN_FindByAddress(addr);
    if (RTN_Valid(rtn)) {
        fnName = RTN_Name(rtn);
        
        // 디버깅: 첫 10개만 로그
        static int debug_count = 0;
        if (debug_count < 10 && imgName.find("redis") != string::npos) {
            cerr << "[DEBUG] addr=0x" << hex << addr << dec 
                 << " img=" << imgName 
                 << " fnName=" << (fnName.empty() ? "<empty>" : fnName) << endl;
            debug_count++;
        }
    }
    
    PIN_UnlockClient();
    
    // 3. 결과 조합
    if (!imgName.empty()) {
        if (!fnName.empty()) {
            result = imgName + ":" + fnName;
        } else {
            ADDRINT offset = addr - IMG_LowAddress(img);
            ostringstream oss;
            oss << imgName << ":+0x" << hex << offset;
            result = oss.str();
        }
    } else if (!fnName.empty()) {
        result = fnName;
    } else {
        result = "unknown";
    }
    
    // 캐시에 저장
    symbolCache[addr] = result;
    
    return result;
}

// 간접 호출이 실행될 때마다 호출되는 분석 함수
VOID CountIndirectCall(ADDRINT callSiteAddr, ADDRINT targetAddr)
{
    totalIndirectCalls++;
    indirectCallSites[callSiteAddr]++;
    
    // 상세 로깅 + 총 횟수 표시 (함수 이름 포함)
    string callSiteName = GetFunctionName(callSiteAddr);
    string targetName = GetFunctionName(targetAddr);
    
    OutFile << "[" << dec << totalIndirectCalls << "] "
            << "Indirect call at 0x" << hex << callSiteAddr 
            << " (" << callSiteName << ")"
            << " -> target 0x" << targetAddr 
            << " (" << targetName << ")" << dec << endl;
    
    // 매 1000번마다 진행 상황 출력 (파일에만 기록)
    if (totalIndirectCalls % 1000 == 0) {
        OutFile << "[Progress] Total indirect calls: " << totalIndirectCalls << endl;
        OutFile.flush();  // 즉시 파일에 쓰기
    }
}

// 명령어를 검사하여 간접 호출을 계측
VOID Instruction(INS ins, VOID *v)
{
    // 간접 호출 명령어 확인
    if (INS_IsCall(ins) && !INS_IsDirectCall(ins))
    {
        // 간접 호출 발견
        INS_InsertCall(
            ins,
            IPOINT_BEFORE,
            (AFUNPTR)CountIndirectCall,
            IARG_INST_PTR,                    // 호출 명령어의 주소
            IARG_BRANCH_TARGET_ADDR,          // 타겟 주소
            IARG_END
        );
    }
}

// 프로그램 종료 시 호출되는 함수
VOID Fini(INT32 code, VOID *v)
{
    OutFile << "\n========== Indirect Call Statistics ==========" << endl;
    OutFile << "PID: " << PIN_GetPid() << endl;
    OutFile << "Total indirect calls: " << totalIndirectCalls << endl;
    OutFile << "Unique call sites: " << indirectCallSites.size() << endl;
    OutFile << "\nIndirect call sites breakdown:" << endl;
    
    // 호출 사이트별 통계 출력 (함수 이름 포함)
    for (auto it = indirectCallSites.begin(); it != indirectCallSites.end(); ++it)
    {
        string functionName = GetFunctionName(it->first);
        OutFile << "  0x" << hex << it->first << dec 
                << " (" << functionName << ")"
                << ": " << it->second << " calls" << endl;
    }
    
    OutFile.close();
    
    // 콘솔에도 요약 출력 (stderr로 출력하여 파이프 간섭 방지)
    cerr << "\n========================================" << endl;
    cerr << "[Indirect Call Counter] Final Results" << endl;
    cerr << "========================================" << endl;
    cerr << "PID: " << PIN_GetPid() << endl;
    cerr << "Total indirect calls: " << totalIndirectCalls << endl;
    cerr << "Unique call sites: " << indirectCallSites.size() << endl;
    cerr << "Output file: " << KnobOutputFile.Value() << "." << PIN_GetPid() << endl;
    cerr << "========================================" << endl;
}

// 사용법 출력
INT32 Usage()
{
    cerr << "This tool counts indirect calls in a program" << endl;
    cerr << KNOB_BASE::StringKnobSummary() << endl;
    return -1;
}

// 메인 함수
int main(int argc, char *argv[])
{
    // Pin 초기화
    if (PIN_Init(argc, argv)) return Usage();
    
    // 심볼 초기화 (중요!)
    PIN_InitSymbols();
    
    // 출력 파일 열기 (PID 포함)
    string baseFileName = KnobOutputFile.Value();
    ostringstream oss;
    oss << baseFileName << "." << PIN_GetPid();
    string fileName = oss.str();
    
    OutFile.open(fileName.c_str());
    if (!OutFile.is_open())
    {
        cerr << "Error: Cannot open output file: " << fileName << endl;
        return -1;
    }
    
    OutFile << "Indirect Call Instrumentation Log" << endl;
    OutFile << "PID: " << PIN_GetPid() << endl;
    OutFile << "===================================" << endl;
    
    // 명령어 계측 콜백 등록
    INS_AddInstrumentFunction(Instruction, 0);
    
    // 종료 콜백 등록
    PIN_AddFiniFunction(Fini, 0);
    
    // 프로그램 실행 시작
    PIN_StartProgram();
    
    return 0;
}