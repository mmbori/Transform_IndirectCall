// callsite 지정 ======================================================
// // myownprj.cpp
// // PIN 3.x (C++11)
// //
// // 기능 요약
// // 1) mod_*_plugin_init() 실행 중 plugin* p 주변 포인터 쓰기를 감시하여
// //    "매핑된 함수(간접 호출 타겟)" 테이블(addr -> {name,img}) 구축
// // 2) 실제 간접호출이 일어나는 srv-like 함수(plugins_call_fn_*) 내부의
// //    '간접 호출 인스트럭션'에만 콜백을 꽂아 정확히 callsite를 포착
// // 3) 그때 현재 srv-like를 호출한 래퍼 함수(plugins_call_handle_*)를
// //    callsite_caller로 함께 로깅
// // 4) Fini 시 callsite_list.txt(실제 callsite 목록) /
// //           callsite_caller_list.txt(래퍼 목록) 출력
// //
// // 빌드 예시(경로/옵션은 환경에 맞게 조정):
// //   g++ -std=gnu++11 -fPIC -shared
// //     -I"$PIN_ROOT/source/include/pin" -I"$PIN_ROOT/source/include/pin/gen"
// //     -o myownprj.so myownprj.cpp
// //
// // 실행 예시:
// //   $PIN_ROOT/pin -t ./myownprj.so -o trace.log -- /path/to/lighttpd -D -f /path/to/lighttpd.conf

// #include "pin.H"
// #include <iostream>
// #include <fstream>
// #include <unordered_map>
// #include <unordered_set>
// #include <set>
// #include <vector>
// #include <string>
// #include <sstream>
// #include <cstring>

// using std::string;
// using std::ofstream;
// using std::endl;

// // ---------------- CLI ----------------
// KNOB<string> KnobOut(KNOB_MODE_WRITEONCE, "pintool", "o", "lighttpd_trace.log",
//                      "output log file");

// // ---------------- Globals ----------------
// static ofstream Log;

// // 매핑된 함수 테이블: addr -> {fn_name, img}
// struct MappedInfo {
//     ADDRINT fn_addr = 0;
//     string  fn_name;
//     string  fn_img;
// };
// static std::unordered_map<ADDRINT, MappedInfo> g_mapped; // addr -> info
// static inline bool IsMapped(ADDRINT a){ return g_mapped.find(a) != g_mapped.end(); }

// // 실제 간접호출 함수(callsite)와 래퍼(callsite_caller) 유니크 집합
// static std::set<string> g_callsites;         // plugins_call_fn_* 같은 실제 callsite
// static std::set<string> g_callsite_callers;  // plugins_call_handle_* 같은 래퍼
// static PIN_LOCK gCsLock; // 두 집합 공용 락

// // ---------------- Helpers ----------------
// static inline bool starts_with(const string& s, const char* pre) {
//     size_t n = std::strlen(pre);
//     return s.size() >= n && 0 == s.compare(0, n, pre);
// }
// static inline bool ends_with(const string& s, const char* suf) {
//     size_t n = std::strlen(suf);
//     return s.size() >= n && 0 == s.compare(s.size()-n, n, suf);
// }
// static string ImgNameByAddrSafe(ADDRINT a) {
//     string s; PIN_LockClient();
//     IMG i = IMG_FindByAddress(a); if (IMG_Valid(i)) s = IMG_Name(i);
//     PIN_UnlockClient(); return s;
// }
// static string RtnNameByAddrSafe(ADDRINT a) {
//     string s; PIN_LockClient();
//     RTN r = RTN_FindByAddress(a); if (RTN_Valid(r)) s = RTN_Name(r);
//     PIN_UnlockClient(); return s;
// }
// static void SrcByAddrSafe(ADDRINT a, std::string& file, INT32& line) {
//     INT32 col = 0; file.clear(); line = 0; PIN_LockClient();
//     PIN_GetSourceLocation(a, &col, &line, &file);
//     PIN_UnlockClient();
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
// static void RecordSymbol(ADDRINT a){
//     if (!a) return;
//     (void)RtnNameByAddrSafe(a); (void)ImgNameByAddrSafe(a);
// }

// // ---------------- TLS ----------------
// struct TLS {
//     bool    in_plugin_init = false; // mod_*_plugin_init() 내부 여부
//     ADDRINT cur_init_addr  = 0;     // 현재 init 함수 주소
//     ADDRINT cur_p          = 0;     // init의 plugin* p 인자

//     // init 중 메모리 쓰기 (BEFORE→AFTER) 페어
//     ADDRINT last_write_ea  = 0;
//     UINT32  last_write_sz  = 0;

//     // srv-like 진입 컨텍스트
//     const char* cur_srv_like = nullptr; // 현재 진입해 있는 srv-like 함수명
//     string      cur_srv_caller;         // 그 srv-like를 호출한 래퍼 함수명
// };
// static TLS_KEY gTLS;
// static TLS* T(){ return static_cast<TLS*>(PIN_GetThreadData(gTLS, PIN_ThreadId())); }

// // ---------------- Mapped funcs: add/update ----------------
// static void AddOrUpdateMapped(ADDRINT fn_addr){
//     if (!fn_addr) return;
//     RecordSymbol(fn_addr);
//     string name = RtnNameByAddrSafe(fn_addr);
//     string img  = ImgNameByAddrSafe(fn_addr);
//     auto it = g_mapped.find(fn_addr);
//     if (it == g_mapped.end()){
//         MappedInfo mi; mi.fn_addr = fn_addr; mi.fn_name = name; mi.fn_img = img;
//         g_mapped.insert(std::make_pair(fn_addr, mi));
//     } else {
//         if (it->second.fn_name.empty()) it->second.fn_name = name;
//         if (it->second.fn_img.empty())  it->second.fn_img  = img;
//     }
//     Log << "[mapped.add] fn=0x" << std::hex << fn_addr << std::dec
//         << " name=" << (name.empty()?"?":name)
//         << " img="  << (img.empty() ?"?":img) << endl;
// }

// // ---------------- dlsym/dlopen (선택) ----------------
// static VOID DlsymAfter(ADDRINT ret, ADDRINT handle, ADDRINT sym_cstr){
//     std::string s = SafeCStr(sym_cstr);
//     Log << "[dlsym.after] sym=" << s
//         << " handle=0x" << std::hex << handle
//         << " rtn=0x"    << ret << std::dec;
//     if (ret){
//         RecordSymbol(ret);
//         string fn = RtnNameByAddrSafe(ret);
//         if (starts_with(fn, "mod_") && ends_with(fn, "_plugin_init")){
//             AddOrUpdateMapped(ret); // (선택) init자체도 기록
//         }
//         Log << " fn=" << fn << " img=" << ImgNameByAddrSafe(ret);
//     }
//     Log << endl;
// }
// static VOID DlopenAfter(ADDRINT ret, ADDRINT path_cstr, ADDRINT flags){
//     std::string p = SafeCStr(path_cstr);
//     Log << "[dlopen.after] path=" << p << " flags=0x" << std::hex << flags
//         << " handle=0x" << ret << std::dec << endl;
// }

// // ---------------- init enter/leave ----------------
// static VOID OnPluginInitEnter(ADDRINT init_addr, ADDRINT pptr){
//     TLS* t = T();
//     t->in_plugin_init = true; t->cur_init_addr = init_addr; t->cur_p = pptr;
//     RecordSymbol(init_addr);
//     Log << "[plugin.init.enter] init=0x" << std::hex << init_addr << std::dec
//         << " fn=" << RtnNameByAddrSafe(init_addr)
//         << " img="<< ImgNameByAddrSafe(init_addr)
//         << " p=0x" << std::hex << pptr << std::dec << endl;
// }
// static VOID OnPluginInitLeave(){
//     Log << "[plugin.init.leave]" << endl;
//     TLS* t = T();
//     t->in_plugin_init = false;
//     t->cur_init_addr = 0;
//     t->cur_p = 0;
// }

// // ---------------- init 중 포인터 쓰기 감시 → 매핑 테이블 구축 ----------------
// static VOID OnMemWriteBefore(ADDRINT ea, UINT32 size){
//     TLS* t = T(); if (!t->in_plugin_init) return;
//     t->last_write_ea = ea; t->last_write_sz = size;
// }
// static VOID OnMemWriteAfter(){
//     TLS* t = T(); if (!t->in_plugin_init) return;

//     ADDRINT ea = t->last_write_ea; UINT32 sz = t->last_write_sz;
//     if (!ea || !sz) return;
// #if defined(TARGET_IA32E)
//     if (sz != 8) return;   // 64-bit 포인터만 수집
// #else
//     if (sz != 4) return;   // 32-bit 포인터만 수집
// #endif
//     const ADDRINT p = t->cur_p; if (!p) return;
//     const size_t RANGE = 4096; // plugin 구조체 근방만 허용(노이즈 억제)
//     if (ea < p || ea >= p + RANGE) return;

//     ADDRINT val = 0;
//     if (PIN_SafeCopy(&val, (const void*)ea, sz) != sz) return;
//     if (!val) return;

//     // 함수 주소로 보이면 매핑 테이블에 저장
//     AddOrUpdateMapped(val);

//     std::string src; INT32 line=0; SrcByAddrSafe(val, src, line);
//     Log << "[plugin.map.write]"
//         << " EA=0x"   << std::hex << ea << std::dec
//         << " VAL=0x"  << std::hex << val << std::dec
//         << " init_fn="<< RtnNameByAddrSafe(t->cur_init_addr)
//         << " fn="     << RtnNameByAddrSafe(val)
//         << " img="    << ImgNameByAddrSafe(val);
//     if (!src.empty()) Log << " src=" << src << ":" << line;
//     Log << endl;

//     t->last_write_ea = 0; t->last_write_sz = 0;
// }

// // ---------------- srv-like 함수 목록/계측 ----------------
// static const char* kSrvLikeList[] = {
//     "plugins_call_fn_req_data",
//     "plugins_call_fn_con_data",
//     "plugins_call_fn_srv_data",
//     "plugins_call_fn_srv_data_all",
//     // 필요 시 waitpid 파이프라인 추가 (lighttpd 버전에 따라 이름 차이 가능)
//     // "plugins_call_fn_waitpid_data",
//     // 또는 케이스에 따라: "plugins_call_handle_waitpid" (실제 간접호출 포함 시)
// };

// // srv-like 진입/이탈: caller(래퍼) 추론
// static VOID OnSrvLikeEnter(const char* name, ADDRINT callee_addr, ADDRINT sp){
//     // retaddr 읽어 caller 추정
//     ADDRINT retaddr = 0;
//     PIN_SafeCopy(&retaddr, (VOID*)sp, sizeof(ADDRINT));
//     ADDRINT caller_ip = retaddr ? (retaddr - 1) : 0;

//     TLS* t = T();
//     t->cur_srv_like = name;
//     t->cur_srv_caller = RtnNameByAddrSafe(caller_ip);  // 래퍼 함수명
//     if (t->cur_srv_caller.empty()) t->cur_srv_caller = "?";

//     Log << "[srv.like.enter]"
//         << " callee=" << name
//         << " callee_addr=0x" << std::hex << callee_addr << std::dec
//         << " caller_ret=0x"  << std::hex << retaddr << std::dec
//         << " approx_callsite=0x"   << std::hex << caller_ip << std::dec
//         << " caller_fn="     << t->cur_srv_caller
//         << " caller_img="    << ImgNameByAddrSafe(caller_ip)
//         << endl;
// }
// static VOID OnSrvLikeLeave(const char* /*name*/){
//     TLS* t = T();
//     t->cur_srv_like   = nullptr;
//     t->cur_srv_caller.clear();
// }

// // srv-like 내부의 '간접 호출' 인스트럭션 전용 콜백
// #if defined(TARGET_IA32E)
// static VOID OnSrvLikeIndirectBefore(
//     ADDRINT ip, ADDRINT target, ADDRINT mem_ea,
//     ADDRINT rdi, ADDRINT rsi, ADDRINT rdx,
//     ADDRINT rcx, ADDRINT r8,  ADDRINT r9,
//     ADDRINT rsp)
// {
//     TLS* t = T();
//     if (!t->cur_srv_like) return;       // srv-like 내부가 아니면 무시
//     if (!IsMapped(target)) return;      // 매핑된 타겟만 로깅

//     // 유니크 집합에 반영: callsite(=srv-like) / callsite_caller(=래퍼)
//     PIN_InitLock(&gCsLock); // 안전을 위해 보장(중복 초기화 무해)
//     PIN_GetLock(&gCsLock, PIN_ThreadUid());
//     if (t->cur_srv_like && t->cur_srv_like[0] != '\0')
//         g_callsites.insert(t->cur_srv_like);
//     if (!t->cur_srv_caller.empty() && t->cur_srv_caller != "?")
//         g_callsite_callers.insert(t->cur_srv_caller);
//     PIN_ReleaseLock(&gCsLock);

//     // 상세 로그
//     std::ostringstream oss;
//     oss << "[mapped.indirect.call]"
//         << " callsite="        << t->cur_srv_like
//         << " callsite_caller=" << t->cur_srv_caller
//         << " ip=0x"            << std::hex << ip << std::dec
//         << " target=0x"        << std::hex << target << std::dec
//         << " callee_fn="       << (RtnNameByAddrSafe(target).empty()? "?" : RtnNameByAddrSafe(target))
//         << " callee_img="      << (ImgNameByAddrSafe(target).empty()? "?" : ImgNameByAddrSafe(target));
//     if (mem_ea) oss << " fptr_mem_ea=0x" << std::hex << mem_ea << std::dec;

//     // 인자 스냅샷
//     oss << " arg0_rdi=0x" << std::hex << rdi << std::dec
//         << " arg1_rsi=0x" << std::hex << rsi << std::dec
//         << " arg2_rdx=0x" << std::hex << rdx << std::dec
//         << " arg3_rcx=0x" << std::hex << rcx << std::dec
//         << " arg4_r8=0x"  << std::hex << r8  << std::dec
//         << " arg5_r9=0x"  << std::hex << r9  << std::dec;

//     Log << oss.str() << endl;
// }
// #else
// // 32-bit 변형(상위 몇 개 인자만)
// static VOID OnSrvLikeIndirectBefore(
//     ADDRINT ip, ADDRINT target, ADDRINT mem_ea,
//     ADDRINT esp, ADDRINT a0, ADDRINT a1, ADDRINT a2, ADDRINT a3)
// {
//     TLS* t = T();
//     if (!t->cur_srv_like) return;
//     if (!IsMapped(target)) return;

//     PIN_InitLock(&gCsLock);
//     PIN_GetLock(&gCsLock, PIN_ThreadUid());
//     if (t->cur_srv_like && t->cur_srv_like[0] != '\0')
//         g_callsites.insert(t->cur_srv_like);
//     if (!t->cur_srv_caller.empty() && t->cur_srv_caller != "?")
//         g_callsite_callers.insert(t->cur_srv_caller);
//     PIN_ReleaseLock(&gCsLock);

//     std::ostringstream oss;
//     oss << "[mapped.indirect.call]"
//         << " callsite="        << t->cur_srv_like
//         << " callsite_caller=" << t->cur_srv_caller
//         << " ip=0x"            << std::hex << ip << std::dec
//         << " target=0x"        << std::hex << target << std::dec
//         << " callee_fn="       << (RtnNameByAddrSafe(target).empty()? "?" : RtnNameByAddrSafe(target))
//         << " callee_img="      << (ImgNameByAddrSafe(target).empty()? "?" : ImgNameByAddrSafe(target));
//     if (mem_ea) oss << " fptr_mem_ea=0x" << std::hex << mem_ea << std::dec;

//     oss << " esp=0x" << std::hex << esp << std::dec
//         << " arg0=0x" << std::hex << a0  << std::dec
//         << " arg1=0x" << std::hex << a1  << std::dec
//         << " arg2=0x" << std::hex << a2  << std::dec
//         << " arg3=0x" << std::hex << a3  << std::dec;

//     Log << oss.str() << endl;
// }
// #endif

// // srv-like RTN 하나를 찾아 열고 내부의 '간접 호출' 인스트럭션에 콜백 꽂기
// static VOID InstrumentSrvLikeRTN(IMG img, const char* name){
//     RTN r = RTN_FindByName(img, name);
//     if (!RTN_Valid(r)) return;

//     ADDRINT a  = RTN_Address(r);
//     USIZE  sz = RTN_Size(r);
//     Log << "[srv.like.rtn] name=" << name
//         << " addr=0x" << std::hex << a << std::dec
//         << " size="   << sz << endl;

//     RTN_Open(r);
// #if defined(TARGET_IA32E)
//     RTN_InsertCall(r, IPOINT_BEFORE, (AFUNPTR)OnSrvLikeEnter,
//                    IARG_PTR, name,
//                    IARG_ADDRINT, (ADDRINT)a,
//                    IARG_REG_VALUE, REG_RSP,
//                    IARG_END);
//     RTN_InsertCall(r, IPOINT_AFTER,  (AFUNPTR)OnSrvLikeLeave,
//                    IARG_PTR, name, IARG_END);
// #else
//     RTN_InsertCall(r, IPOINT_BEFORE, (AFUNPTR)OnSrvLikeEnter,
//                    IARG_PTR, name,
//                    IARG_ADDRINT, (ADDRINT)a,
//                    IARG_REG_VALUE, REG_ESP,
//                    IARG_END);
//     RTN_InsertCall(r, IPOINT_AFTER,  (AFUNPTR)OnSrvLikeLeave,
//                    IARG_PTR, name, IARG_END);
// #endif

//     // 이 RTN 내부의 '간접 호출' 인스트럭션 각각에 개별 콜백 꽂기
//     for (INS ins = RTN_InsHead(r); INS_Valid(ins); ins = INS_Next(ins)) {
//         if (!INS_IsCall(ins) || !INS_IsIndirectControlFlow(ins)) continue;
//         const BOOL has_mem = INS_IsMemoryRead(ins);
// #if defined(TARGET_IA32E)
//         if (has_mem){
//             INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnSrvLikeIndirectBefore,
//                 IARG_INST_PTR, IARG_BRANCH_TARGET_ADDR, IARG_MEMORYREAD_EA,
//                 IARG_REG_VALUE, REG_RDI, IARG_REG_VALUE, REG_RSI,
//                 IARG_REG_VALUE, REG_RDX, IARG_REG_VALUE, REG_RCX,
//                 IARG_REG_VALUE, REG_R8,  IARG_REG_VALUE, REG_R9,
//                 IARG_REG_VALUE, REG_RSP, IARG_END);
//         } else {
//             INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnSrvLikeIndirectBefore,
//                 IARG_INST_PTR, IARG_BRANCH_TARGET_ADDR, IARG_ADDRINT, (ADDRINT)0,
//                 IARG_REG_VALUE, REG_RDI, IARG_REG_VALUE, REG_RSI,
//                 IARG_REG_VALUE, REG_RDX, IARG_REG_VALUE, REG_RCX,
//                 IARG_REG_VALUE, REG_R8,  IARG_REG_VALUE, REG_R9,
//                 IARG_REG_VALUE, REG_RSP, IARG_END);
//         }
// #else
//         if (has_mem){
//             INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnSrvLikeIndirectBefore,
//                 IARG_INST_PTR, IARG_BRANCH_TARGET_ADDR, IARG_MEMORYREAD_EA,
//                 IARG_REG_VALUE, REG_ESP,
//                 IARG_ADDRINT,0, IARG_ADDRINT,0, IARG_ADDRINT,0, IARG_END);
//         } else {
//             INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnSrvLikeIndirectBefore,
//                 IARG_INST_PTR, IARG_BRANCH_TARGET_ADDR, IARG_ADDRINT,(ADDRINT)0,
//                 IARG_REG_VALUE, REG_ESP,
//                 IARG_ADDRINT,0, IARG_ADDRINT,0, IARG_ADDRINT,0, IARG_END);
//         }
// #endif
//     }
//     RTN_Close(r);
// }

// // ---------------- ImageLoad: 훅 설치 ----------------
// static VOID ImageLoad(IMG img, VOID*){
//     Log << "[IMG_LOAD] " << IMG_Name(img)
//         << (IMG_IsMainExecutable(img)?" (main)":"") << endl;

//     // dlsym/dlopen (선택)
//     RTN r = RTN_FindByName(img, "dlsym");
//     if (RTN_Valid(r)){
//         RTN_Open(r);
//         RTN_InsertCall(r, IPOINT_AFTER, (AFUNPTR)DlsymAfter,
//                        IARG_FUNCRET_EXITPOINT_VALUE,
//                        IARG_FUNCARG_ENTRYPOINT_VALUE, 0,
//                        IARG_FUNCARG_ENTRYPOINT_VALUE, 1,
//                        IARG_END);
//         RTN_Close(r);
//         Log << "[hook] dlsym in " << IMG_Name(img) << endl;
//     }
//     r = RTN_FindByName(img, "dlopen");
//     if (RTN_Valid(r)){
//         RTN_Open(r);
//         RTN_InsertCall(r, IPOINT_AFTER, (AFUNPTR)DlopenAfter,
//                        IARG_FUNCRET_EXITPOINT_VALUE,
//                        IARG_FUNCARG_ENTRYPOINT_VALUE, 0,
//                        IARG_FUNCARG_ENTRYPOINT_VALUE, 1,
//                        IARG_END);
//         RTN_Close(r);
//         Log << "[hook] dlopen in " << IMG_Name(img) << endl;
//     }

//     // srv-like 전용 계측 추가: 실제 간접 호출이 발생하는 내부 함수들
//     for (auto name : kSrvLikeList) {
//         InstrumentSrvLikeRTN(img, name);
//     }

//     // mod_*_plugin_init 훅 설치 (init enter/leave와 plugin* p 추출)
//     for (SEC s = IMG_SecHead(img); SEC_Valid(s); s = SEC_Next(s)) {
//         for (RTN rr = SEC_RtnHead(s); RTN_Valid(rr); rr = RTN_Next(rr)) {
//             string rn = RTN_Name(rr);
//             if (starts_with(rn,"mod_") && ends_with(rn,"_plugin_init")){
//                 ADDRINT a = RTN_Address(rr);
//                 Log << "[plugin.init.sym] fn=" << rn
//                     << " addr=0x" << std::hex << a << std::dec
//                     << " img=" << IMG_Name(img) << endl;
//                 RTN_Open(rr);
//                 RTN_InsertCall(rr, IPOINT_BEFORE, (AFUNPTR)OnPluginInitEnter,
//                                IARG_ADDRINT, (ADDRINT)a,
//                                IARG_FUNCARG_ENTRYPOINT_VALUE, 0, // plugin* p
//                                IARG_END);
//                 RTN_InsertCall(rr, IPOINT_AFTER,  (AFUNPTR)OnPluginInitLeave, IARG_END);
//                 RTN_Close(rr);
//             }
//         }
//     }
// }

// // ---------------- Ins: init 중 포인터 쓰기만 감시 ----------------
// static VOID Ins(INS ins, VOID*){
//     // init 중 포인터 쓰기 감시(매핑 테이블 구축용)
//     if (!INS_IsMemoryWrite(ins)) return;
//     if (!INS_IsStandardMemop(ins)) return;
//     if (INS_IsCall(ins) || INS_IsBranch(ins) || INS_IsRet(ins)
//      || INS_IsSyscall(ins) || INS_IsInterrupt(ins)) return;

//     INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnMemWriteBefore,
//                    IARG_MEMORYWRITE_EA, IARG_MEMORYWRITE_SIZE, IARG_END);
//     if (INS_HasFallThrough(ins)) {
//         INS_InsertCall(ins, IPOINT_AFTER, (AFUNPTR)OnMemWriteAfter, IARG_END);
//     }
// }

// // ---------------- Thread/Fini ----------------
// static VOID ThreadStart(THREADID tid, CONTEXT*, INT32, VOID*){
//     TLS* t = new TLS(); PIN_SetThreadData(gTLS, t, tid);
// }
// static VOID ThreadFini(THREADID, const CONTEXT*, INT32, VOID*){
//     TLS* t = T(); delete t;
// }
// static VOID Fini(INT32, VOID*){
//     // callsite 목록 저장 (실제 간접호출 함수)
//     {
//         std::ofstream ofs("callsite_list.txt", std::ios::out | std::ios::trunc);
//         if (ofs.is_open()){
//             for (const auto& name : g_callsites){
//                 ofs << name << "\n";
//             }
//             ofs.close();
//             Log << "[callsite.write] wrote " << g_callsites.size()
//                 << " items -> callsite_list.txt" << endl;
//         } else {
//             Log << "[callsite.write.error] cannot open callsite_list.txt" << endl;
//         }
//     }
//     // callsite_caller 목록 저장 (래퍼)
//     {
//         std::ofstream ofs("callsite_caller_list.txt", std::ios::out | std::ios::trunc);
//         if (ofs.is_open()){
//             for (const auto& name : g_callsite_callers){
//                 ofs << name << "\n";
//             }
//             ofs.close();
//             Log << "[callsite_caller.write] wrote " << g_callsite_callers.size()
//                 << " items -> callsite_caller_list.txt" << endl;
//         } else {
//             Log << "[callsite_caller.write.error] cannot open callsite_caller_list.txt" << endl;
//         }
//     }

//     Log << "[fini]" << endl;
//     Log.close();
// }

// // ---------------- main ----------------
// int main(int argc, char* argv[]){
//     if (PIN_Init(argc, argv)) return 1;
//     Log.open(KnobOut.Value().c_str());
//     Log.setf(std::ios::unitbuf);
//     PIN_InitSymbols();
//     gTLS = PIN_CreateThreadDataKey(nullptr);

//     PIN_InitLock(&gCsLock);

//     IMG_AddInstrumentFunction(ImageLoad, nullptr);
//     INS_AddInstrumentFunction(Ins, nullptr);
//     PIN_AddThreadStartFunction(ThreadStart, nullptr);
//     PIN_AddThreadFiniFunction(ThreadFini, nullptr);
//     PIN_AddFiniFunction(Fini, nullptr);

//     Log << "[start] output=" << KnobOut.Value() << endl;
//     PIN_StartProgram();
//     return 0;
// }


// myownprj.cpp
// PIN 3.x (C++11)
//
// 목적
// 1) mod_*_plugin_init() 실행 중 plugin* p 주변 포인터 쓰기를 감시해
//    "매핑된 함수(간접 호출 타겟)" 테이블(addr -> {name,img}) 구축
// 2) 전역 모든 간접 호출(call/indirect)을 감시하되, target이 매핑 테이블에 있을 때만 로깅
// 3) 로깅 시 callsite(간접 호출이 일어난 함수)와 caller(callsite를 호출한 직전 함수)을 함께 기록
// 4) Fini 시 callsite_list.txt / callsite_caller_list.txt 출력
//
// 빌드 예:
//   g++ -std=gnu++11 -fPIC -shared 
//     -I"$PIN_ROOT/source/include/pin" -I"$PIN_ROOT/source/include/pin/gen" 
//     -o myownprj.so myownprj.cpp
//
// 실행 예:
//   $PIN_ROOT/pin -t ./myownprj.so -o trace.log -- /path/to/lighttpd -D -f /path/to/lighttpd.conf

// myownprj.cpp
// PIN 3.x (C++11)
//
// 목적
// 1) mod_*_plugin_init() 실행 중 plugin* p 주변 포인터 쓰기를 감시해
//    "매핑된 함수(간접 호출 타겟)" 테이블(addr -> {name,img}) 구축
// 2) 전역 모든 간접 호출(call/indirect)을 감시
//    - target이 매핑 테이블에 있으면 로깅
//    - 아니더라도 callsite(IP)가 srv-like(plugins_call_fn_*) 내부이면
//      "런타임 매핑"으로 간주해 target을 즉시 AddOrUpdateMapped() 후 로깅
// 3) 로깅 시 callsite(간접 호출 인스트럭션이 속한 함수)와
//    caller(callsite를 호출한 직전 함수; TLS 콜스택 부모)를 함께 기록
// 4) Fini 시 callsite_list.txt / callsite_caller_list.txt 출력
//
// 빌드 예:
//   g++ -std=gnu++11 -fPIC -shared 
//     -I"$PIN_ROOT/source/include/pin" -I"$PIN_ROOT/source/include/pin/gen" 
//     -o myownprj.so myownprj.cpp
//
// 실행 예:
//   $PIN_ROOT/pin -t ./myownprj.so -o trace.log -- /path/to/lighttpd -D -f /path/to/lighttpd.conf


// // 모든 indirect call logging ======================================================
// // =================================================================================

// #include "pin.H"
// #include <iostream>
// #include <fstream>
// #include <unordered_map>
// #include <set>
// #include <vector>
// #include <string>
// #include <sstream>
// #include <cstring>

// using std::string;
// using std::ofstream;
// using std::endl;

// // ---------------- CLI ----------------
// KNOB<string> KnobOut(KNOB_MODE_WRITEONCE, "pintool", "o", "lighttpd_trace.log",
//                      "output log file");

// // ---------------- Globals ----------------
// static ofstream Log;

// // 매핑된 함수 테이블: addr -> {fn_name, img}
// struct MappedInfo {
//     ADDRINT fn_addr = 0;
//     string  fn_name;
//     string  fn_img;
// };
// static std::unordered_map<ADDRINT, MappedInfo> g_mapped; // addr -> info
// static inline bool IsMapped(ADDRINT a){ return g_mapped.find(a) != g_mapped.end(); }

// // 유니크 목록: 실제 callsite / caller
// static std::set<string> g_callsites;
// static std::set<string> g_callers;
// static PIN_LOCK gSetLock;

// // srv-like 범위(plugins_call_fn_*들) 수집용
// struct SrvLike {
//     ADDRINT start, end; // [start,end)
//     string  name;
// };
// static std::vector<SrvLike> g_srv_like;

// // ---------------- Helpers ----------------
// static inline bool starts_with(const string& s, const char* pre) {
//     size_t n = std::strlen(pre);
//     return s.size() >= n && 0 == s.compare(0, n, pre);
// }
// static inline bool ends_with(const string& s, const char* suf) {
//     size_t n = std::strlen(suf);
//     return s.size() >= n && 0 == s.compare(s.size()-n, n, suf);
// }
// static string ImgNameByAddrSafe(ADDRINT a) {
//     string s; PIN_LockClient();
//     IMG i = IMG_FindByAddress(a); if (IMG_Valid(i)) s = IMG_Name(i);
//     PIN_UnlockClient(); return s;
// }
// static string RtnNameByAddrSafe(ADDRINT a) {
//     string s; PIN_LockClient();
//     RTN r = RTN_FindByAddress(a); if (RTN_Valid(r)) s = RTN_Name(r);
//     PIN_UnlockClient(); return s;
// }
// static void SrcByAddrSafe(ADDRINT a, std::string& file, INT32& line) {
//     INT32 col = 0; file.clear(); line = 0; PIN_LockClient();
//     PIN_GetSourceLocation(a, &col, &line, &file);
//     PIN_UnlockClient();
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
// static void RecordSymbol(ADDRINT a){
//     if (!a) return;
//     (void)RtnNameByAddrSafe(a); (void)ImgNameByAddrSafe(a);
// }
// static inline bool IpInSrvLike(ADDRINT ip, string* out_name=nullptr){
//     for (const auto& s : g_srv_like){
//         if (ip >= s.start && ip < s.end){
//             if (out_name) *out_name = s.name;
//             return true;
//         }
//     }
//     return false;
// }

// // ---------------- TLS ----------------
// struct TLS {
//     bool    in_plugin_init = false; // mod_*_plugin_init() 내부 여부
//     ADDRINT cur_init_addr  = 0;     // 현재 init 함수 주소
//     ADDRINT cur_p          = 0;     // init의 plugin* p 인자

//     // init 중 메모리 쓰기 (BEFORE→AFTER) 페어
//     ADDRINT last_write_ea  = 0;
//     UINT32  last_write_sz  = 0;

//     // 전역 콜스택 (RTN 기준) : callsite와 caller를 구분하기 위해 사용
//     struct Frame { ADDRINT rtn_addr; };
//     std::vector<Frame> stack;
// };
// static TLS_KEY gTLS;
// static TLS* T(){ return static_cast<TLS*>(PIN_GetThreadData(gTLS, PIN_ThreadId())); }

// // ---------------- Mapped funcs: add/update ----------------
// static void AddOrUpdateMapped(ADDRINT fn_addr){
//     if (!fn_addr) return;
//     RecordSymbol(fn_addr);
//     string name = RtnNameByAddrSafe(fn_addr);
//     string img  = ImgNameByAddrSafe(fn_addr);
//     auto it = g_mapped.find(fn_addr);
//     if (it == g_mapped.end()){
//         MappedInfo mi; mi.fn_addr = fn_addr; mi.fn_name = name; mi.fn_img = img;
//         g_mapped.insert(std::make_pair(fn_addr, mi));
//     } else {
//         if (it->second.fn_name.empty()) it->second.fn_name = name;
//         if (it->second.fn_img.empty())  it->second.fn_img  = img;
//     }
//     Log << "[mapped.add] fn=0x" << std::hex << fn_addr << std::dec
//         << " name=" << (name.empty()?"?":name)
//         << " img="  << (img.empty() ?"?":img) << endl;
// }

// // ---------------- dlsym/dlopen (선택) ----------------
// static VOID DlsymAfter(ADDRINT ret, ADDRINT handle, ADDRINT sym_cstr){
//     std::string s = SafeCStr(sym_cstr);
//     Log << "[dlsym.after] sym=" << s
//         << " handle=0x" << std::hex << handle
//         << " rtn=0x"    << ret << std::dec;
//     if (ret){
//         RecordSymbol(ret);
//         string fn = RtnNameByAddrSafe(ret);
//         if (starts_with(fn, "mod_") && ends_with(fn, "_plugin_init")){
//             AddOrUpdateMapped(ret); // (선택) init자체도 기록
//         }
//         Log << " fn=" << fn << " img=" << ImgNameByAddrSafe(ret);
//     }
//     Log << endl;
// }
// static VOID DlopenAfter(ADDRINT ret, ADDRINT path_cstr, ADDRINT flags){
//     std::string p = SafeCStr(path_cstr);
//     Log << "[dlopen.after] path=" << p << " flags=0x" << std::hex << flags
//         << " handle=0x" << ret << std::dec << endl;
// }

// // ---------------- init enter/leave ----------------
// static VOID OnPluginInitEnter(ADDRINT init_addr, ADDRINT pptr){
//     TLS* t = T();
//     t->in_plugin_init = true; t->cur_init_addr = init_addr; t->cur_p = pptr;
//     RecordSymbol(init_addr);
//     Log << "[plugin.init.enter] init=0x" << std::hex << init_addr << std::dec
//         << " fn=" << RtnNameByAddrSafe(init_addr)
//         << " img="<< ImgNameByAddrSafe(init_addr)
//         << " p=0x" << std::hex << pptr << std::dec << endl;
// }
// static VOID OnPluginInitLeave(){
//     Log << "[plugin.init.leave]" << endl;
//     TLS* t = T();
//     t->in_plugin_init = false;
//     t->cur_init_addr = 0;
//     t->cur_p = 0;
// }

// // ---------------- init 중 포인터 쓰기 감시 → 매핑 테이블 구축 ----------------
// static VOID OnMemWriteBefore(ADDRINT ea, UINT32 size){
//     TLS* t = T(); if (!t->in_plugin_init) return;
//     t->last_write_ea = ea; t->last_write_sz = size;
// }
// static VOID OnMemWriteAfter(){
//     TLS* t = T(); if (!t->in_plugin_init) return;

//     ADDRINT ea = t->last_write_ea; UINT32 sz = t->last_write_sz;
//     if (!ea || !sz) return;
// #if defined(TARGET_IA32E)
//     if (sz != 8) return;   // 64-bit 포인터만 수집
// #else
//     if (sz != 4) return;   // 32-bit 포인터만 수집
// #endif
//     const ADDRINT p = t->cur_p; if (!p) return;
//     const size_t RANGE = 4096; // plugin 구조체 근방만 허용(노이즈 억제)
//     if (ea < p || ea >= p + RANGE) return;

//     ADDRINT val = 0;
//     if (PIN_SafeCopy(&val, (const void*)ea, sz) != sz) return;
//     if (!val) return;

//     // 함수 주소로 보이면 매핑 테이블에 저장 (코드 주소 여부는 실행 중 확인)
//     AddOrUpdateMapped(val);

//     std::string src; INT32 line=0; SrcByAddrSafe(val, src, line);
//     Log << "[plugin.map.write]"
//         << " EA=0x"   << std::hex << ea << std::dec
//         << " VAL=0x"  << std::hex << val << std::dec
//         << " init_fn="<< RtnNameByAddrSafe(t->cur_init_addr)
//         << " fn="     << RtnNameByAddrSafe(val)
//         << " img="    << ImgNameByAddrSafe(val);
//     if (!src.empty()) Log << " src=" << src << ":" << line;
//     Log << endl;

//     t->last_write_ea = 0; t->last_write_sz = 0;
// }

// // ---------------- 전역 콜스택 관리(RTN 단위) ----------------
// static VOID OnRtnEnter(ADDRINT rtn_addr){
//     TLS* t = T();
//     TLS::Frame f; f.rtn_addr = rtn_addr;
//     t->stack.push_back(f);
// }
// static VOID OnRtnLeave(ADDRINT /*rtn_addr*/){
//     TLS* t = T();
//     if (!t->stack.empty()) t->stack.pop_back();
// }

// // ---------------- 간접 호출 모니터링: 매핑 타겟 + srv-like 내부 ----------------
// static inline void AppendArgKV(std::ostringstream& oss, const char* k, ADDRINT v){
//     oss << " " << k << "=0x" << std::hex << v << std::dec;
// }

// #if defined(TARGET_IA32E)
// // x86-64 SysV: rdi,rsi,rdx,rcx,r8,r9 + rsp
// static VOID OnAnyIndirectCallBefore(
//     ADDRINT ip, ADDRINT target, ADDRINT mem_ea,
//     ADDRINT rdi, ADDRINT rsi, ADDRINT rdx,
//     ADDRINT rcx, ADDRINT r8,  ADDRINT r9,
//     ADDRINT rsp)
// {
//     // 1) 우선 target이 기존 매핑에 있나?
//     bool mapped = IsMapped(target);

//     // 2) 아니면, IP가 srv-like 안인가? (plugins_call_fn_* 내부에서 실전 관측)
//     string srvLikeName;
//     if (!mapped && IpInSrvLike(ip, &srvLikeName)) {
//         // srv-like 내부에서 본 타겟은 "런타임 매핑"으로 즉시 등록
//         AddOrUpdateMapped(target);
//         mapped = true;
//         Log << "[runtime.map.add] ip_in=" << srvLikeName
//             << " target=0x" << std::hex << target << std::dec
//             << " fn=" << RtnNameByAddrSafe(target) << endl;
//     }

//     if (!mapped) return; // 둘 다 아니면 무시

//     // callsite = ip가 속한 함수
//     string callsite_fn = RtnNameByAddrSafe(ip);
//     ADDRINT callsite_addr = 0;
//     {
//         PIN_LockClient();
//         RTN r = RTN_FindByAddress(ip);
//         if (RTN_Valid(r)) callsite_addr = RTN_Address(r);
//         PIN_UnlockClient();
//     }
//     if (callsite_fn.empty()) callsite_fn = "?";

//     // caller = TLS 콜스택의 '부모'
//     string caller_fn = "?"; ADDRINT caller_addr = 0;
//     {
//         TLS* t = T();
//         if (t && t->stack.size() >= 2){
//             caller_addr = t->stack[t->stack.size()-2].rtn_addr;
//             caller_fn   = RtnNameByAddrSafe(caller_addr);
//             if (caller_fn.empty()) caller_fn = "?";
//         }
//     }

//     // 유니크 집합 반영
//     PIN_GetLock(&gSetLock, PIN_ThreadUid());
//     if (callsite_fn != "?") g_callsites.insert(callsite_fn);
//     if (caller_fn   != "?") g_callers.insert(caller_fn);
//     PIN_ReleaseLock(&gSetLock);

//     // 상세 로깅
//     std::ostringstream oss;
//     oss << "[mapped.indirect.call]"
//         << " callsite_fn="   << callsite_fn
//         << " callsite_addr=0x" << std::hex << callsite_addr << std::dec
//         << " caller_fn="     << caller_fn
//         << " caller_addr=0x" << std::hex << caller_addr << std::dec
//         << " ip=0x"          << std::hex << ip << std::dec
//         << " target=0x"      << std::hex << target << std::dec
//         << " callee_fn="     << (RtnNameByAddrSafe(target).empty()? "?" : RtnNameByAddrSafe(target))
//         << " callee_img="    << (ImgNameByAddrSafe(target).empty()? "?" : ImgNameByAddrSafe(target));
//     if (mem_ea) oss << " fptr_mem_ea=0x" << std::hex << mem_ea << std::dec;

//     AppendArgKV(oss, "arg0_rdi", rdi);
//     AppendArgKV(oss, "arg1_rsi", rsi);
//     AppendArgKV(oss, "arg2_rdx", rdx);
//     AppendArgKV(oss, "arg3_rcx", rcx);
//     AppendArgKV(oss, "arg4_r8",  r8);
//     AppendArgKV(oss, "arg5_r9",  r9);

//     Log << oss.str() << endl;
// }
// #else
// // x86-32: esp + 상위 4개만
// static VOID OnAnyIndirectCallBefore(
//     ADDRINT ip, ADDRINT target, ADDRINT mem_ea,
//     ADDRINT esp, ADDRINT a0, ADDRINT a1, ADDRINT a2, ADDRINT a3)
// {
//     bool mapped = IsMapped(target);
//     string srvLikeName;
//     if (!mapped && IpInSrvLike(ip, &srvLikeName)) {
//         AddOrUpdateMapped(target);
//         mapped = true;
//         Log << "[runtime.map.add] ip_in=" << srvLikeName
//             << " target=0x" << std::hex << target << std::dec
//             << " fn=" << RtnNameByAddrSafe(target) << endl;
//     }
//     if (!mapped) return;

//     string callsite_fn = RtnNameByAddrSafe(ip);
//     ADDRINT callsite_addr = 0;
//     {
//         PIN_LockClient();
//         RTN r = RTN_FindByAddress(ip);
//         if (RTN_Valid(r)) callsite_addr = RTN_Address(r);
//         PIN_UnlockClient();
//     }
//     if (callsite_fn.empty()) callsite_fn = "?";

//     string caller_fn = "?"; ADDRINT caller_addr = 0;
//     {
//         TLS* t = T();
//         if (t && t->stack.size() >= 2){
//             caller_addr = t->stack[t->stack.size()-2].rtn_addr;
//             caller_fn   = RtnNameByAddrSafe(caller_addr);
//             if (caller_fn.empty()) caller_fn = "?";
//         }
//     }

//     PIN_GetLock(&gSetLock, PIN_ThreadUid());
//     if (callsite_fn != "?") g_callsites.insert(callsite_fn);
//     if (caller_fn   != "?") g_callers.insert(caller_fn);
//     PIN_ReleaseLock(&gSetLock);

//     std::ostringstream oss;
//     oss << "[mapped.indirect.call]"
//         << " callsite_fn="   << callsite_fn
//         << " callsite_addr=0x" << std::hex << callsite_addr << std::dec
//         << " caller_fn="     << caller_fn
//         << " caller_addr=0x" << std::hex << caller_addr << std::dec
//         << " ip=0x"          << std::hex << ip << std::dec
//         << " target=0x"      << std::hex << target << std::dec
//         << " callee_fn="     << (RtnNameByAddrSafe(target).empty()? "?" : RtnNameByAddrSafe(target))
//         << " callee_img="    << (ImgNameByAddrSafe(target).empty()? "?" : ImgNameByAddrSafe(target));
//     if (mem_ea) oss << " fptr_mem_ea=0x" << std::hex << mem_ea << std::dec;

//     AppendArgKV(oss, "esp",  esp);
//     AppendArgKV(oss, "arg0", a0);
//     AppendArgKV(oss, "arg1", a1);
//     AppendArgKV(oss, "arg2", a2);
//     AppendArgKV(oss, "arg3", a3);

//     Log << oss.str() << endl;
// }
// #endif

// // ---------------- ImageLoad: 훅 설치 ----------------
// static VOID ImageLoad(IMG img, VOID*){
//     Log << "[IMG_LOAD] " << IMG_Name(img)
//         << (IMG_IsMainExecutable(img)?" (main)":"") << endl;

//     // dlsym/dlopen (선택)
//     RTN r = RTN_FindByName(img, "dlsym");
//     if (RTN_Valid(r)){
//         RTN_Open(r);
//         RTN_InsertCall(r, IPOINT_AFTER, (AFUNPTR)DlsymAfter,
//                        IARG_FUNCRET_EXITPOINT_VALUE,
//                        IARG_FUNCARG_ENTRYPOINT_VALUE, 0,
//                        IARG_FUNCARG_ENTRYPOINT_VALUE, 1,
//                        IARG_END);
//         RTN_Close(r);
//         Log << "[hook] dlsym in " << IMG_Name(img) << endl;
//     }
//     r = RTN_FindByName(img, "dlopen");
//     if (RTN_Valid(r)){
//         RTN_Open(r);
//         RTN_InsertCall(r, IPOINT_AFTER, (AFUNPTR)DlopenAfter,
//                        IARG_FUNCRET_EXITPOINT_VALUE,
//                        IARG_FUNCARG_ENTRYPOINT_VALUE, 0,
//                        IARG_FUNCARG_ENTRYPOINT_VALUE, 1,
//                        IARG_END);
//         RTN_Close(r);
//         Log << "[hook] dlopen in " << IMG_Name(img) << endl;
//     }

//     // 모든 RTN에 엔트리/리브 훅(콜스택 관리) + srv-like 후보 수집
//     for (SEC s = IMG_SecHead(img); SEC_Valid(s); s = SEC_Next(s)) {
//         for (RTN rr = SEC_RtnHead(s); RTN_Valid(rr); rr = RTN_Next(rr)) {
//             // 콜스택 관리용 엔트리/리브
//             RTN_Open(rr);
//             ADDRINT a = RTN_Address(rr);
//             USIZE  z = RTN_Size(rr);
//             RTN_InsertCall(rr, IPOINT_BEFORE, (AFUNPTR)OnRtnEnter,
//                            IARG_ADDRINT, (ADDRINT)a, IARG_END);
//             RTN_InsertCall(rr, IPOINT_AFTER,  (AFUNPTR)OnRtnLeave,
//                            IARG_ADDRINT, (ADDRINT)a, IARG_END);
//             RTN_Close(rr);

//             // init 훅 설치
//             string rn = RTN_Name(rr);
//             if (starts_with(rn,"mod_") && ends_with(rn,"_plugin_init")){
//                 RTN_Open(rr);
//                 RTN_InsertCall(rr, IPOINT_BEFORE, (AFUNPTR)OnPluginInitEnter,
//                                IARG_ADDRINT, (ADDRINT)a,
//                                IARG_FUNCARG_ENTRYPOINT_VALUE, 0, // plugin* p
//                                IARG_END);
//                 RTN_InsertCall(rr, IPOINT_AFTER,  (AFUNPTR)OnPluginInitLeave, IARG_END);
//                 RTN_Close(rr);
//             }

//             // ★ srv-like 함수(plugins_call_fn_*) 범위 수집
//             if (starts_with(rn, "plugins_call_fn_")){
//                 SrvLike sl{a, a + z, rn};
//                 g_srv_like.push_back(sl);
//                 Log << "[srv.like.rtn] name=" << rn
//                     << " addr=0x" << std::hex << a << std::dec
//                     << " size="   << z << endl;
//             }
//         }
//     }
// }

// // ---------------- Ins: 전역 간접 호출 + init 중 포인터 쓰기 ----------------
// static VOID Ins(INS ins, VOID*){
//     // 전역 간접 호출: 매핑 타겟 또는 srv-like 내부에서 관측된 타겟 로깅
//     if (INS_IsCall(ins) && INS_IsIndirectControlFlow(ins)) {
//         const BOOL has_mem = INS_IsMemoryRead(ins);
// #if defined(TARGET_IA32E)
//         if (has_mem){
//             INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnAnyIndirectCallBefore,
//                 IARG_INST_PTR, IARG_BRANCH_TARGET_ADDR, IARG_MEMORYREAD_EA,
//                 IARG_REG_VALUE, REG_RDI, IARG_REG_VALUE, REG_RSI,
//                 IARG_REG_VALUE, REG_RDX, IARG_REG_VALUE, REG_RCX,
//                 IARG_REG_VALUE, REG_R8,  IARG_REG_VALUE, REG_R9,
//                 IARG_REG_VALUE, REG_RSP, IARG_END);
//         } else {
//             INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnAnyIndirectCallBefore,
//                 IARG_INST_PTR, IARG_BRANCH_TARGET_ADDR, IARG_ADDRINT, (ADDRINT)0,
//                 IARG_REG_VALUE, REG_RDI, IARG_REG_VALUE, REG_RSI,
//                 IARG_REG_VALUE, REG_RDX, IARG_REG_VALUE, REG_RCX,
//                 IARG_REG_VALUE, REG_R8,  IARG_REG_VALUE, REG_R9,
//                 IARG_REG_VALUE, REG_RSP, IARG_END);
//         }
// #else
//         if (has_mem){
//             INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnAnyIndirectCallBefore,
//                 IARG_INST_PTR, IARG_BRANCH_TARGET_ADDR, IARG_MEMORYREAD_EA,
//                 IARG_REG_VALUE, REG_ESP,
//                 IARG_ADDRINT,0, IARG_ADDRINT,0, IARG_ADDRINT,0, IARG_END);
//         } else {
//             INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnAnyIndirectCallBefore,
//                 IARG_INST_PTR, IARG_BRANCH_TARGET_ADDR, IARG_ADDRINT,(ADDRINT)0,
//                 IARG_REG_VALUE, REG_ESP,
//                 IARG_ADDRINT,0, IARG_ADDRINT,0, IARG_ADDRINT,0, IARG_END);
//         }
// #endif
//     }

//     // init 중 포인터 쓰기 감시(매핑 테이블 구축)
//     if (!INS_IsMemoryWrite(ins)) return;
//     if (!INS_IsStandardMemop(ins)) return;
//     if (INS_IsCall(ins) || INS_IsBranch(ins) || INS_IsRet(ins)
//      || INS_IsSyscall(ins) || INS_IsInterrupt(ins)) return;

//     INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnMemWriteBefore,
//                    IARG_MEMORYWRITE_EA, IARG_MEMORYWRITE_SIZE, IARG_END);
//     if (INS_HasFallThrough(ins)) {
//         INS_InsertCall(ins, IPOINT_AFTER, (AFUNPTR)OnMemWriteAfter, IARG_END);
//     }
// }

// // ---------------- Thread/Fini ----------------
// static VOID ThreadStart(THREADID tid, CONTEXT*, INT32, VOID*){
//     TLS* t = new TLS(); PIN_SetThreadData(gTLS, t, tid);
// }
// static VOID ThreadFini(THREADID, const CONTEXT*, INT32, VOID*){
//     TLS* t = T(); delete t;
// }
// static VOID Fini(INT32, VOID*){
//     // callsite 목록 저장
//     {
//         std::ofstream ofs("callsite_list.txt", std::ios::out | std::ios::trunc);
//         if (ofs.is_open()){
//             for (const auto& name : g_callsites){
//                 ofs << name << "\n";
//             }
//             ofs.close();
//             Log << "[callsite.write] wrote " << g_callsites.size()
//                 << " items -> callsite_list.txt" << endl;
//         } else {
//             Log << "[callsite.write.error] cannot open callsite_list.txt" << endl;
//         }
//     }
//     // caller 목록 저장
//     {
//         std::ofstream ofs("callsite_caller_list.txt", std::ios::out | std::ios::trunc);
//         if (ofs.is_open()){
//             for (const auto& name : g_callers){
//                 ofs << name << "\n";
//             }
//             ofs.close();
//             Log << "[callsite_caller.write] wrote " << g_callers.size()
//                 << " items -> callsite_caller_list.txt" << endl;
//         } else {
//             Log << "[callsite_caller.write.error] cannot open callsite_caller_list.txt" << endl;
//         }
//     }

//     Log << "[fini]" << endl;
//     Log.close();
// }

// // ---------------- main ----------------
// int main(int argc, char* argv[]){
//     if (PIN_Init(argc, argv)) return 1;
//     Log.open(KnobOut.Value().c_str());
//     Log.setf(std::ios::unitbuf);
//     PIN_InitSymbols();
//     gTLS = PIN_CreateThreadDataKey(nullptr);
//     PIN_InitLock(&gSetLock);

//     IMG_AddInstrumentFunction(ImageLoad, nullptr);
//     INS_AddInstrumentFunction(Ins, nullptr);
//     PIN_AddThreadStartFunction(ThreadStart, nullptr);
//     PIN_AddThreadFiniFunction(ThreadFini, nullptr);
//     PIN_AddFiniFunction(Fini, nullptr);

//     Log << "[start] output=" << KnobOut.Value() << endl;
//     PIN_StartProgram();
//     return 0;
// }


// new code =========================================================
// ==================================================================

// myownprj.cpp  (PIN 3.x, C++11)
//
// 기능 요약
//   1) mod_*_plugin_init() 실행 중 plugin* p 주변 포인터 쓰기를 감시해
//      간접호출 타겟 함수 주소들을 "mapped" 테이블에 구축
//   2) 전역 모든 indirect call을 감시
//      - target이 mapped에 있으면 로깅
//      - 이때 IP가 속한 함수를 "callsite(=srv-like)"로 등록/갱신
//        (name, [start,end), callers, callees, src_code 한 줄 문자열)
//   3) srv-like로 확정된 함수에 대해서는 실행 중 [srv.like.enter]/[srv.like.end] 로깅
//   4) 종료 시 srv_like_runtime.txt 로 요약 출력
//
// 빌드 예:
//   g++ -std=gnu++11 -fPIC -shared 
//       -I"$PIN_ROOT/source/include/pin" -I"$PIN_ROOT/source/include/pin/gen" 
//       -o myownprj.so myownprj.cpp
//
// 실행 예:
//   $PIN_ROOT/pin -t ./myownprj.so -o trace.log -- /path/to/lighttpd -D -f /path/to/lighttpd.conf
//
// lighttpd는 -O0 -g -fno-omit-frame-pointer 로 빌드 권장.

#include "pin.H"
#include <iostream>
#include <fstream>
#include <unordered_map>
#include <unordered_set>
#include <set>
#include <map>
#include <vector>
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

// --------- mapped 타겟 함수 테이블: addr -> {name,img} ---------
struct MappedInfo {
    ADDRINT fn_addr = 0;
    string  fn_name;
    string  fn_img;
};
static std::unordered_map<ADDRINT, MappedInfo> g_mapped; // addr -> info
static inline bool IsMapped(ADDRINT a){ return g_mapped.find(a) != g_mapped.end(); }

// --------- 실행 중 발견한 srv-like(callsite) ---------
struct DiscoveredSrv {
    ADDRINT start = 0;  // RTN_Address
    ADDRINT end   = 0;  // start + RTN_Size
    string  name;       // RTN_Name
    string  img;        // IMG_Name
    std::set<string> callers;   // 이 callsite를 호출한 상위 함수들(유니크)
    std::set<string> callees;   // 이 callsite 내부에서 호출된 mapped 타겟 함수들(유니크)
    std::set<string> src_texts; // 이 callsite에서 관측된 간접 호출의 "소스 코드 한 줄" (유니크)
};
static std::map<string, DiscoveredSrv> g_srv;  // name -> info
static std::unordered_set<ADDRINT> g_srv_addrs; // srv-like로 확정된 RTN 시작 주소
static PIN_LOCK gSrvLock;

// --------- 소스 파일 한 줄 가져오기(캐시) ---------
static std::unordered_map<string, std::vector<string>> g_src_file_cache;

static inline string GetSourceLineText(const string& filepath, INT32 line1based){
    if (filepath.empty() || line1based <= 0) return "?";
    auto it = g_src_file_cache.find(filepath);
    if (it == g_src_file_cache.end()){
        std::ifstream in(filepath.c_str());
        if (!in.is_open()){
            return "?";
        }
        std::vector<string> lines;
        lines.reserve(2048);
        string s;
        while (std::getline(in, s)){
            lines.push_back(s);
        }
        g_src_file_cache.emplace(filepath, std::move(lines));
        it = g_src_file_cache.find(filepath);
    }
    const auto& lines = it->second;
    size_t idx = static_cast<size_t>(line1based - 1);
    if (idx < lines.size()) {
        return lines[idx]; // 개행 제외 상태
    }
    return "?";
}

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
static inline void RecordSymbol(ADDRINT a) {
    if (!a) return;
    (void)RtnNameByAddrSafe(a);
    (void)ImgNameByAddrSafe(a);
}
static inline string EscapeForLog(const string& s){
    std::string out; out.reserve(s.size()+8);
    for(char c: s){
        if (c=='"') out.push_back('\'');      // 따옴표는 ' 로 바꿈
        else if (c=='\t') out.push_back(' '); // 탭을 공백으로
        else if (c=='\r' || c=='\n') { /* skip */ }
        else out.push_back(c);
    }
    return out;
}

// ---------------- TLS ----------------
struct TLS {
    bool    in_plugin_init = false; // mod_*_plugin_init() 내부 여부
    ADDRINT cur_init_addr  = 0;     // 현재 init 함수 주소
    ADDRINT cur_p          = 0;     // init의 plugin* p 인자

    // init 중 메모리 쓰기 (BEFORE→AFTER) 페어
    ADDRINT last_write_ea  = 0;
    UINT32  last_write_sz  = 0;
};
static TLS_KEY gTLS;
static TLS* T(){ return static_cast<TLS*>(PIN_GetThreadData(gTLS, PIN_ThreadId())); }

// ---------------- mapped 타겟 추가/갱신 ----------------
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

// ---------------- init 중 포인터 쓰기 감시 → mapped 타겟 수집 ----------------
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

// ---------------- 프레임포인터 기반 caller 복원 ----------------
static inline bool GetCallerFromFramePtr(ADDRINT fp, ADDRINT &retaddr, string &caller_fn, ADDRINT &caller_rtn_addr) {
    retaddr = 0; caller_rtn_addr = 0; caller_fn.clear();
    if (!fp) return false;

#if defined(TARGET_IA32E)
    const ADDRINT ra_addr = fp + 8;   // [RBP+8] = return RIP
#else
    const ADDRINT ra_addr = fp + 4;   // [EBP+4] = return EIP
#endif
    ADDRINT tmp = 0;
    if (PIN_SafeCopy(&tmp, (const void*)ra_addr, sizeof(ADDRINT)) != sizeof(ADDRINT)) return false;
    if (!tmp) return false;

    retaddr = tmp;

    PIN_LockClient();
    RTN r = RTN_FindByAddress(retaddr);
    if (RTN_Valid(r)) {
        caller_fn = RTN_Name(r);
        caller_rtn_addr = RTN_Address(r);
    }
    PIN_UnlockClient();

    if (caller_fn.empty()) return false;
    return true;
}

// ---------------- srv-like(=실행중 발견된 callsite) 등록/갱신 ----------------
static void EnsureSrvLikeFromIP(ADDRINT ip, const string& caller_fn, ADDRINT target){
    // 1) ip가 속한 RTN(함수) 정보
    ADDRINT a = 0; USIZE z = 0; string rn, img;
    PIN_LockClient();
    RTN r = RTN_FindByAddress(ip);
    if (RTN_Valid(r)) {
        a = RTN_Address(r); z = RTN_Size(r);
        rn = RTN_Name(r);
        IMG i = IMG_FindByAddress(a); if (IMG_Valid(i)) img = IMG_Name(i);
    }
    PIN_UnlockClient();
    if (rn.empty()) rn = "?";
    if (!a || !z)   return; // 주소 범위가 없으면 등록하지 않음

    // 2) 간접 호출이 일어난 소스 파일/라인 → 소스 "문자열"로 변환
    std::string file; INT32 line = 0;
    SrcByAddrSafe(ip, file, line);
    string srctext = "?";
    if (!file.empty() && line > 0){
        srctext = GetSourceLineText(file, line); // 한 줄 텍스트
        if (srctext.empty()) srctext = "?";
    }

    // 3) callee 이름
    string callee = RtnNameByAddrSafe(target);
    if (callee.empty()) callee = "?";

    // 4) srv-like 등록/갱신 + src_text/caller/callee 유니크 누적
    PIN_GetLock(&gSrvLock, PIN_ThreadUid());
    DiscoveredSrv &D = g_srv[rn];
    if (D.name.empty()) {
        D.name  = rn;
        D.start = a;
        D.end   = a + z;
        D.img   = img;
        Log << "[srv.like.discovered]"
            << " name=" << D.name
            << " img="  << D.img
            << " start=0x" << std::hex << D.start
            << " end=0x"   << D.end   << std::dec
            << endl;
    } else {
        if (a < D.start)     D.start = a;
        if (a + z > D.end)   D.end   = a + z;
    }
    if (!caller_fn.empty() && caller_fn != "?") D.callers.insert(caller_fn);
    if (!callee.empty()    && callee    != "?") D.callees.insert(callee);
    if (!srctext.empty()   && srctext   != "?") D.src_texts.insert(srctext);

    // ★ srv-like로 확정된 RTN 시작 주소 등록 (enter/end 로깅용)
    g_srv_addrs.insert(a);
    PIN_ReleaseLock(&gSrvLock);

    // 5) 이벤트 로깅
    Log << "[srv.like.runtime.call]"
        << " callsite="   << rn
        << " start=0x"    << std::hex << a
        << " end=0x"      << (a+z)    << std::dec
        << " caller="     << (caller_fn.empty()?"?":caller_fn)
        << " callee_fn="  << callee
        << " callee_addr=0x" << std::hex << target << std::dec
        << " src_code=\"" << EscapeForLog(srctext) << "\""
        << endl;
}

// ---------------- 간접 호출 모니터링: mapped 타겟만 ----------------
#if defined(TARGET_IA32E)
static VOID OnAnyIndirectCallBefore(ADDRINT ip, ADDRINT target, ADDRINT rbp)
{
    if (!IsMapped(target)) return;

    // caller = 프레임포인터 기반 복원
    ADDRINT caller_ret=0, caller_rtn_addr=0; string caller_fn="?";
    (void)GetCallerFromFramePtr(rbp, caller_ret, caller_fn, caller_rtn_addr);

    EnsureSrvLikeFromIP(ip, caller_fn, target);
}
#else
static VOID OnAnyIndirectCallBefore(ADDRINT ip, ADDRINT target, ADDRINT ebp)
{
    if (!IsMapped(target)) return;

    ADDRINT caller_ret=0, caller_rtn_addr=0; string caller_fn="?";
    (void)GetCallerFromFramePtr(ebp, caller_ret, caller_fn, caller_rtn_addr);

    EnsureSrvLikeFromIP(ip, caller_fn, target);
}
#endif

// ---------------- srv-like enter/leave 로깅 ----------------
static VOID OnAnyRtnEnterAll(ADDRINT rtn_addr){
    bool is_srv = false;
    PIN_GetLock(&gSrvLock, PIN_ThreadUid());
    is_srv = (g_srv_addrs.find(rtn_addr) != g_srv_addrs.end());
    PIN_ReleaseLock(&gSrvLock);
    if (!is_srv) return;

    string rn = RtnNameByAddrSafe(rtn_addr);
    USIZE sz = 0;
    PIN_LockClient();
    {
        RTN r = RTN_FindByAddress(rtn_addr);
        if (RTN_Valid(r)) sz = RTN_Size(r);
    }
    PIN_UnlockClient();
    ADDRINT end = rtn_addr + sz;

    Log << "[srv.like.enter]"
        << " name="  << (rn.empty()?"?":rn)
        << " start=0x" << std::hex << rtn_addr
        << " end=0x"   << end << std::dec
        << endl;
}

static VOID OnAnyRtnLeaveAll(ADDRINT rtn_addr){
    bool is_srv = false;
    PIN_GetLock(&gSrvLock, PIN_ThreadUid());
    is_srv = (g_srv_addrs.find(rtn_addr) != g_srv_addrs.end());
    PIN_ReleaseLock(&gSrvLock);
    if (!is_srv) return;

    string rn = RtnNameByAddrSafe(rtn_addr);
    USIZE sz = 0;
    PIN_LockClient();
    {
        RTN r = RTN_FindByAddress(rtn_addr);
        if (RTN_Valid(r)) sz = RTN_Size(r);
    }
    PIN_UnlockClient();
    ADDRINT end = rtn_addr + sz;

    Log << "[srv.like.end]"
        << " name="  << (rn.empty()?"?":rn)
        << " start=0x" << std::hex << rtn_addr
        << " end=0x"   << end << std::dec
        << endl;
}

// ---------------- ImageLoad: 훅 설치 ----------------
static VOID ImageLoad(IMG img, VOID*){
    Log << "[IMG_LOAD] " << IMG_Name(img)
        << (IMG_IsMainExecutable(img)?" (main)":"") << endl;

    // 모든 RTN에 대해: srv-like enter/leave 훅 + (필요시) init 훅
    for (SEC s = IMG_SecHead(img); SEC_Valid(s); s = SEC_Next(s)) {
        for (RTN rr = SEC_RtnHead(s); RTN_Valid(rr); rr = RTN_Next(rr)) {
            RTN_Open(rr);
            ADDRINT a = RTN_Address(rr);

            // (1) srv-like enter/end용 훅
            RTN_InsertCall(rr, IPOINT_BEFORE, (AFUNPTR)OnAnyRtnEnterAll,
                           IARG_ADDRINT, (ADDRINT)a, IARG_END);
            RTN_InsertCall(rr, IPOINT_AFTER,  (AFUNPTR)OnAnyRtnLeaveAll,
                           IARG_ADDRINT, (ADDRINT)a, IARG_END);
            RTN_Close(rr);

            // (2) init 훅 설치
            string rn = RTN_Name(rr);
            if (starts_with(rn,"mod_") && ends_with(rn,"_plugin_init")){
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

// ---------------- Ins: 전역 간접 호출 + init 중 포인터 쓰기 ----------------
static VOID Ins(INS ins, VOID*){
    // 전역 간접 호출: mapped 타겟만 로깅
    if (INS_IsCall(ins) && INS_IsIndirectControlFlow(ins)) {
#if defined(TARGET_IA32E)
        INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnAnyIndirectCallBefore,
                       IARG_INST_PTR, IARG_BRANCH_TARGET_ADDR,
                       IARG_REG_VALUE, REG_RBP,
                       IARG_END);
#else
        INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)OnAnyIndirectCallBefore,
                       IARG_INST_PTR, IARG_BRANCH_TARGET_ADDR,
                       IARG_REG_VALUE, REG_EBP,
                       IARG_END);
#endif
    }

    // init 중 포인터 쓰기 감시(매핑 테이블 구축)
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
    // srv-like 요약 파일: 이름, 시작~끝, callers, callees, src_texts(코드 문자열)
    {
        std::ofstream ofs("srv_like_runtime.txt", std::ios::out | std::ios::trunc);
        if (ofs.is_open()){
            for (const auto& kv : g_srv){
                const DiscoveredSrv& D = kv.second;
                ofs << "[srv.like]"
                    << " name="  << D.name
                    << " img="   << D.img
                    << " start=0x" << std::hex << D.start
                    << " end=0x"   << D.end   << std::dec;

                ofs << "\n  callers:";
                for (const auto& c : D.callers) ofs << " " << c;

                ofs << "\n  callees:";
                for (const auto& c : D.callees) ofs << " " << c;

                ofs << "\n  src_texts:";
                for (const auto& s : D.src_texts) ofs << " \"" << EscapeForLog(s) << "\"";

                ofs << "\n";
            }
            ofs.close();
            Log << "[srv.like.write] wrote " << g_srv.size()
                << " items -> srv_like_runtime.txt" << endl;
        } else {
            Log << "[srv.like.write.error] cannot open srv_like_runtime.txt" << endl;
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
    PIN_InitLock(&gSrvLock);

    IMG_AddInstrumentFunction(ImageLoad, nullptr);
    INS_AddInstrumentFunction(Ins, nullptr);
    PIN_AddThreadStartFunction(ThreadStart, nullptr);
    PIN_AddThreadFiniFunction(ThreadFini, nullptr);
    PIN_AddFiniFunction(Fini, nullptr);

    Log << "[start] output=" << KnobOut.Value() << endl;
    PIN_StartProgram();
    return 0;
}
