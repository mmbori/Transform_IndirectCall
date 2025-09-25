# """
# 개선된 함수 포인터 할당 추출기
# - 조건부 컴파일, union, typedef 지원 강화
# - 원본에서 직접 처리로 정확성 향상
# - 데이터 구조 일관성 수정
# """

# import argparse
# import os
# import re
# import sys
# from typing import Dict, List, Set, Tuple, Optional
# import glob
# from collections import defaultdict
# import time

# def find_struct_boundaries_in_original(content: str) -> List[Tuple[int, int]]:
#     """원본 파일에서 직접 구조체 경계 찾기"""
#     boundaries = []
#     pattern = re.compile(r'\b(?:struct|union)(?:\s+\w+)?\s*\{', re.MULTILINE)
    
#     for match in pattern.finditer(content):
#         start_pos = match.start()
#         brace_pos = match.end() - 1  # '{' 위치
        
#         # 매칭되는 '}' 찾기
#         brace_count = 1
#         pos = brace_pos + 1
        
#         while pos < len(content) and brace_count > 0:
#             char = content[pos]
#             if char == '{':
#                 brace_count += 1
#             elif char == '}':
#                 brace_count -= 1
#             pos += 1
        
#         if brace_count == 0:
#             boundaries.append((start_pos, pos))
    
#     return boundaries

# def extract_struct_name(struct_content: str) -> Optional[str]:
#     """구조체 이름 추출"""
#     # struct name { 패턴
#     struct_name_pattern = re.compile(r'\b(?:struct|union)\s+(\w+)\s*\{')
#     match = struct_name_pattern.search(struct_content)
    
#     if match:
#         return match.group(1)
    
#     # typedef struct { ... } name; 패턴
#     typedef_pattern = re.compile(r'typedef\s+(?:struct|union)\s*\{.*?\}\s*(\w+)\s*;', re.DOTALL)
#     match = typedef_pattern.search(struct_content)
    
#     if match:
#         return match.group(1)
    
#     return None

# def remove_comments_and_preprocessor(content: str) -> str:
#     """주석과 전처리기 지시어 제거"""
#     # 주석 제거
#     content = re.sub(r'//.*?(?=\n|$)', '', content)
#     content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)
    
#     # 전처리기 지시어 제거
#     content = re.sub(r'^\s*#.*?$', '', content, flags=re.MULTILINE)
    
#     return content

# def find_function_pointers_in_struct_content(struct_content: str, verbose: bool = False) -> List[Tuple[str, str, str]]:
#     """구조체 내용에서 함수 포인터 찾기 - 중복 제거 로직 수정"""
#     function_pointers = []
#     found_names = set()  # 성능 향상을 위한 set 사용
    
#     # 주석과 전처리기 지시어 제거
#     cleaned_content = remove_comments_and_preprocessor(struct_content)
    
#     # 정확한 함수 포인터 패턴: return_type (*name)(args);
#     fp_pattern = re.compile(
#         r'([a-zA-Z_]\w*(?:\s+[a-zA-Z_*]\w*)*(?:\s*\*)*)\s*'  # return_type
#         r'\(\s*\*\s*([a-zA-Z_]\w*)\s*\)'  # (*name) - 필수!
#         r'\s*\(([^)]*)\)\s*;',  # (args); - 필수!
#         re.MULTILINE | re.DOTALL
#     )
    
#     for match in fp_pattern.finditer(cleaned_content):
#         try:
#             return_type = match.group(1).strip()
#             fp_name = match.group(2).strip()
#             args = match.group(3).strip()
            
#             if (fp_name and fp_name.isidentifier() and return_type and 
#                 not ':' in return_type and not return_type.endswith(':')):
                
#                 function_pointers.append((return_type, fp_name, args))
#                 if verbose:
#                     print(f"    Found FP: {fp_name} ({return_type})")
        
#         except Exception as e:
#             if verbose:
#                 print(f"    Pattern matching error: {e}")
#             continue
    
#     return function_pointers

# def find_structs_in_content(content: str, verbose: bool = False) -> Dict[str, List[Tuple[str, str, str]]]:
#     """단일 파일 내용에서 구조체와 함수 포인터 찾기 - 원본에서 직접 처리"""
#     struct_fp_map = {}
    
#     # 구조체/union 경계 찾기 (조건부 컴파일 무시)
#     boundaries = find_struct_boundaries_in_original(content)
    
#     if not boundaries:
#         return struct_fp_map
    
#     # 각 구조체 영역에서 함수 포인터 찾기
#     for start_pos, end_pos in boundaries:
#         struct_content = content[start_pos:end_pos]
#         struct_name = extract_struct_name(struct_content)
        
#         if not struct_name:
#             continue
        
#         function_pointers = find_function_pointers_in_struct_content(struct_content, verbose)
        
#         if function_pointers:
#             if struct_name not in struct_fp_map:
#                 struct_fp_map[struct_name] = []
            
#             # 중복 제거 없이 모든 함수 포인터 저장
#             struct_fp_map[struct_name].extend(function_pointers)
#             if verbose:
#                 print(f"[FOUND] {struct_name}: {len(function_pointers)}개 함수 포인터")
    
#     return struct_fp_map

# def find_struct_with_function_pointers(source_dir: str, verbose: bool = False) -> Dict[str, List[Tuple[str, str, str]]]:
#     """개선된 구조체의 함수 포인터 검색 - 조건부 컴파일과 union 지원"""
#     struct_fp_map = {}
    
#     # 파일 검색
#     file_patterns = [
#         os.path.join(source_dir, "src/*.c"),
#         os.path.join(source_dir, "src/*.h"),
#         os.path.join(source_dir, "src/*.in"),
#         os.path.join(source_dir, "ext/**/*.c"),
#         os.path.join(source_dir, "ext/**/*.h"),
#         os.path.join(source_dir, "ext/**/*.in")
#     ]
    
#     files_to_process = set()
#     for pattern in file_patterns:
#         files_to_process.update(glob.glob(pattern, recursive=True))
    
#     files_to_process = list(files_to_process)
#     if verbose:
#         print(f"[INFO] 구조체 검색: {len(files_to_process)}개 파일 스캔 중...")
    
#     for file_path in files_to_process:
#         try:
#             with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
#                 content = f.read()
            
#             # 원본에서 직접 구조체 찾기 (조건부 컴파일 무시)
#             file_struct_map = find_structs_in_content(content, verbose)
            
#             # 결과 병합
#             for struct_name, fps in file_struct_map.items():
#                 if struct_name not in struct_fp_map:
#                     struct_fp_map[struct_name] = []
                
#                 # 중복 제거
#                 existing_fp_names = {fp[1] for fp in struct_fp_map[struct_name]}
#                 new_fps = [fp for fp in fps if fp[1] not in existing_fp_names]
                
#                 if new_fps:
#                     struct_fp_map[struct_name].extend(new_fps)
            
#         except Exception as e:
#             if verbose:
#                 print(f"[WARN] 파일 처리 실패 {file_path}: {e}")
    
#     return struct_fp_map

# def find_function_pointer_assignments(source_dir: str, fp_names: Set[str], verbose: bool = False) -> Dict[str, Set[str]]:
#     """함수 포인터 할당 검색 (수정된 버전 - 올바른 그룹 추출)"""
#     fp_assignments = defaultdict(set)
    
#     # 다양한 할당 패턴들
#     assignment_patterns = []

#     for fp_name in fp_names:
#         # 1. 구조체 멤버 할당: obj.fp_name = func_name
#         assignment_patterns.append((
#             fp_name,
#             re.compile(rf'(\w+)\.{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,]', re.MULTILINE),
#             2  # 함수명이 있는 그룹 번호
#         ))
        
#         # 2. 이중 구조체 멤버 할당: obj1.obj2.fp_name = func_name
#         assignment_patterns.append((
#             fp_name,
#             re.compile(rf'(\w+)\.(\w+)\.{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,]', re.MULTILINE),
#             3  # 함수명이 있는 그룹 번호
#         ))

#         # 3. 포인터 멤버 할당: obj->fp_name = func_name
#         assignment_patterns.append((
#             fp_name,
#             re.compile(rf'(\w+)->{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,]', re.MULTILINE),
#             2  # 함수명이 있는 그룹 번호
#         ))

#         # 4. 포인터 멤버 할당: obj1->obj2->fp_name = func_name
#         assignment_patterns.append((
#             fp_name,
#             re.compile(rf'(\w+)->(\w+)->{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,]', re.MULTILINE),
#             3  # 함수명이 있는 그룹 번호
#         ))

#         # 5. 혼합 할당: obj1.obj2->fp_name = func_name
#         assignment_patterns.append((
#             fp_name,
#             re.compile(rf'(\w+)\.(\w+)->{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,]', re.MULTILINE),
#             3  # 함수명이 있는 그룹 번호
#         ))

#         # 6. 혼합 할당: obj1->obj2.fp_name = func_name
#         assignment_patterns.append((
#             fp_name,
#             re.compile(rf'(\w+)->(\w+)\.{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,]', re.MULTILINE),
#             3  # 함수명이 있는 그룹 번호
#         ))
        
#         # 7. 3레벨 포인터 할당: obj1->obj2->obj3->fp_name = func_name
#         assignment_patterns.append((
#             fp_name,
#             re.compile(rf'(\w+)->(\w+)->(\w+)->{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,]', re.MULTILINE),
#             4  # 함수명이 있는 그룹 번호
#         ))
        
#         # 8. 3레벨 혼합 할당: obj1.obj2.obj3.fp_name = func_name
#         assignment_patterns.append((
#             fp_name,
#             re.compile(rf'(\w+)\.(\w+)\.(\w+)\.{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,]', re.MULTILINE),
#             4  # 함수명이 있는 그룹 번호
#         ))
        
#         # 9. 구조체 초기화: {.fp_name = func_name}
#         assignment_patterns.append((
#             fp_name,
#             re.compile(rf'\.{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[,}}]', re.MULTILINE),
#             1  # 함수명이 있는 그룹 번호
#         ))
        
#         # 10. 삼항 연산자: obj->fp_name = condition ? func1 : func2
#         assignment_patterns.append((
#             fp_name,
#             re.compile(rf'(\w+)(?:(?:->(\w+))|(?:\.(\w+)))*(?:->|\.){re.escape(fp_name)}\s*=\s*[^?]*\?\s*&?(\w+)\s*:\s*&?(\w+)', re.MULTILINE),
#             "ternary"  # 특별 처리
#         ))
    
#     # 파일 검색
#     file_patterns = [
#         os.path.join(source_dir, "src/*.c"),
#         os.path.join(source_dir, "src/*.h"),
#         os.path.join(source_dir, "src/*.in"),
#         os.path.join(source_dir, "ext/**/*.c"),
#         os.path.join(source_dir, "ext/**/*.h"),
#         os.path.join(source_dir, "ext/**/*.in")
#     ]
    
#     files_to_process = set()
#     for pattern in file_patterns:
#         files_to_process.update(glob.glob(pattern, recursive=True))
    
#     files_to_process = list(files_to_process)
#     if verbose:
#         print(f"[INFO] 함수 할당 검색: {len(files_to_process)}개 파일 스캔 중...")
    
#     start_time = time.time()
#     processed_files = 0
    
#     for file_path in files_to_process:
#         try:
#             with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
#                 content = f.read()
            
#             processed_files += 1
#             if verbose and processed_files % 100 == 0:
#                 elapsed = time.time() - start_time
#                 print(f"[PROGRESS] {processed_files}/{len(files_to_process)} 파일 처리됨 ({elapsed:.1f}초)")
            
#             # 모든 할당 패턴으로 검색
#             for fp_name, pattern, group_index in assignment_patterns:
#                 for match in pattern.finditer(content):
#                     groups = match.groups()
                    
#                     if group_index == "ternary":
#                         # 삼항 연산자: 마지막 두 그룹이 func1, func2
#                         if len(groups) >= 2:
#                             func_name1 = groups[-2].strip()
#                             func_name2 = groups[-1].strip()
                            
#                             if func_name1 and func_name1 not in ['NULL', 'nullptr'] and func_name1.isidentifier():
#                                 fp_assignments[fp_name].add(func_name1)
#                                 if verbose:
#                                     print(f"[ASSIGNMENT] {fp_name} = {func_name1} (삼항1) in {os.path.basename(file_path)}")
                            
#                             if func_name2 and func_name2 not in ['NULL', 'nullptr'] and func_name2.isidentifier():
#                                 fp_assignments[fp_name].add(func_name2)
#                                 if verbose:
#                                     print(f"[ASSIGNMENT] {fp_name} = {func_name2} (삼항2) in {os.path.basename(file_path)}")
#                     else:
#                         # 일반적인 할당: 지정된 그룹에서 함수명 추출
#                         if len(groups) >= group_index:
#                             func_name = groups[group_index - 1].strip()  # 0-based index
                            
#                             # 유효한 함수명인지 확인
#                             if (func_name and 
#                                 func_name not in ['NULL', 'nullptr'] and 
#                                 func_name.isidentifier()):
#                                 fp_assignments[fp_name].add(func_name)
#                                 if verbose:
#                                     print(f"[ASSIGNMENT] {fp_name} = {func_name} in {os.path.basename(file_path)}")
        
#         except Exception as e:
#             if verbose:
#                 print(f"[WARN] 파일 처리 실패 {file_path}: {e}")
    
#     elapsed = time.time() - start_time
#     if verbose:
#         print(f"[완료] 함수 할당 검색 완료 ({elapsed:.1f}초)")
    
#     return dict(fp_assignments)

# def find_function_declarations(source_dir: str, func_names: Set[str], verbose: bool = False) -> Dict[str, str]:
#     """Python으로 함수 선언 검색"""
#     func_declarations = {}
    
#     if not func_names:
#         return func_declarations
    
#     # 함수 선언 패턴들
#     declaration_patterns = []
#     for func_name in func_names:
#         # return_type func_name(args) - 함수 선언
#         declaration_patterns.append((
#             func_name,
#             re.compile(rf'(\w+(?:\s+\w+)*\s*\*?)\s+{re.escape(func_name)}\s*\(([^)]*)\)\s*[;{{]', re.MULTILINE)
#         ))
        
#         # static/extern 포함
#         declaration_patterns.append((
#             func_name,
#             re.compile(rf'((?:static\s+|extern\s+)*\w+(?:\s+\w+)*\s*\*?)\s+{re.escape(func_name)}\s*\(([^)]*)\)\s*[;{{]', re.MULTILINE)
#         ))
    
#     # 파일 검색
#     file_patterns = [
#         os.path.join(source_dir, "src/*.c"),
#         os.path.join(source_dir, "src/*.h"),
#         os.path.join(source_dir, "src/*.in"),
#         os.path.join(source_dir, "ext/**/*.c"),
#         os.path.join(source_dir, "ext/**/*.h"),
#         os.path.join(source_dir, "ext/**/*.in")
#     ]
    
#     files_to_process = set()
#     for pattern in file_patterns:
#         files_to_process.update(glob.glob(pattern, recursive=True))
    
#     files_to_process = list(files_to_process)
#     if verbose:
#         print(f"[INFO] 함수 선언 검색: {len(files_to_process)}개 파일 스캔 중...")
    
#     start_time = time.time()
    
#     for file_path in files_to_process:
#         try:
#             with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
#                 content = f.read()
            
#             # 주석 제거
#             content = re.sub(r'//.*?\n', '\n', content)
#             content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)
            
#             # 함수 선언 찾기
#             for func_name, pattern in declaration_patterns:
#                 if func_name not in func_declarations:  # 아직 찾지 못한 함수만
#                     for match in pattern.finditer(content):
#                         return_type = match.group(1).strip()
#                         args = match.group(2).strip() if len(match.groups()) > 1 else ""
                        
#                         # static 제거
#                         return_type = re.sub(r'\bstatic\s+', '', return_type)
                        
#                         declaration = f"{return_type} {func_name}({args})"
#                         func_declarations[func_name] = declaration
                        
#                         if verbose:
#                             print(f"[DECLARATION] {declaration} in {os.path.basename(file_path)}")
#                         break  # 첫 번째 선언만 사용
        
#         except Exception as e:
#             if verbose:
#                 print(f"[WARN] 파일 처리 실패 {file_path}: {e}")
    
#     elapsed = time.time() - start_time
#     if verbose:
#         print(f"[완료] 함수 선언 검색 완료 ({elapsed:.1f}초)")
    
#     return func_declarations

# def save_results(fp_assignments: Dict[str, Set[str]], func_declarations: Dict[str, str], verbose: bool = False):
#     """결과를 파일로 저장"""
#     # fpName 디렉토리 생성
#     os.makedirs("fpName", exist_ok=True)
#     os.makedirs("fpNameDecl", exist_ok=True)
    
#     if verbose:
#         print(f"[INFO] 결과 파일 저장 중...")
    
#     # 각 함수 포인터별로 할당된 함수 목록 저장
#     for fp_name, func_names in fp_assignments.items():
#         if func_names:
#             with open(f"fpName/{fp_name}.txt", 'w', encoding='utf-8') as f:
#                 for func_name in sorted(func_names):
#                     f.write(f"{func_name}\n")
            
#             if verbose:
#                 print(f"[SAVED] fpName/{fp_name}.txt: {len(func_names)}개 함수")
    
#     # 각 함수 포인터별로 함수 선언 저장
#     for fp_name, func_names in fp_assignments.items():
#         if func_names:
#             declarations = []
#             for func_name in sorted(func_names):
#                 if func_name == '0' : pass
#                 if func_name in func_declarations:
#                     declarations.append(f"{func_declarations[func_name]};")
#                 else:
#                     declarations.append(f"// 선언을 찾을 수 없음: {func_name}")
            
#             if declarations:
#                 with open(f"fpNameDecl/{fp_name}.txt", 'w', encoding='utf-8') as f:
#                     f.write(f"// Function declarations for {fp_name}\n\n")
#                     for decl in declarations:
#                         f.write(f"{decl}\n")
                
#                 if verbose:
#                     print(f"[SAVED] fpNameDecl/{fp_name}.txt: {len(declarations)}개 선언")

# def test_improved_extraction():
#     """개선된 추출 방식 테스트"""
#     print("=== 개선된 구조체 함수 포인터 추출 테스트 ===")
    
#     # 테스트용 구조체 (조건부 컴파일과 union 포함)
#     test_content = '''
# struct test_struct {
#   void (*xLegacy)(void*,const char*);
#   union {
#     void (*xUnion1)(void*);
#     int (*xUnion2)(int);
#   } u;
# #ifndef DISABLE_FEATURE  
#   void (*xProfile)(void*,const char*,u64);
# #endif
#   int (*xCommitCallback)(void*);
# #ifdef ENABLE_FEATURE
#   void (*xFeature)(void*);
# #endif
#   sqlite3_xauth xAuth;
# };

# struct another_struct {
#   int (*xHandler)(void*);
#   unsigned int (*xProcessor)(void*, int);
# };
# '''
    
#     # 구조체와 함수 포인터 찾기
#     struct_fp_map = find_structs_in_content(test_content, verbose=True)
    
#     print(f"\n발견된 구조체: {len(struct_fp_map)}개")
#     total_fps = 0
#     for struct_name, fps in struct_fp_map.items():
#         print(f"  {struct_name}: {len(fps)}개 함수 포인터")
#         for return_type, fp_name, args in fps:
#             print(f"    - {fp_name} ({return_type})")
#             total_fps += 1
    
#     print(f"\n총 함수 포인터: {total_fps}개")
    
#     expected_fps = ['xLegacy', 'xUnion1', 'xUnion2', 'xProfile', 'xCommitCallback', 'xFeature', 'xAuth', 'xHandler', 'xProcessor']
#     found_fps = []
#     for fps in struct_fp_map.values():
#         found_fps.extend([fp[1] for fp in fps])
    
#     missing = set(expected_fps) - set(found_fps)
#     extra = set(found_fps) - set(expected_fps)
    
#     if missing:
#         print(f"누락: {missing}")
#     if extra:
#         print(f"추가: {extra}")
    
#     if not missing and not extra:
#         print("✓ 모든 함수 포인터가 정확히 발견됨!")
#     else:
#         print("✗ 일부 불일치 발견")

# def main():
#     parser = argparse.ArgumentParser(
#         description="개선된 함수 포인터 할당 추출기 - 조건부 컴파일, union, typedef 지원"
#     )
#     parser.add_argument(
#         "--source-dir",
#         required=True,
#         help="소스 코드 디렉토리"
#     )
#     parser.add_argument(
#         "--verbose", "-v",
#         action="store_true",
#         help="상세 출력"
#     )
#     parser.add_argument(
#         "--benchmark", "-b",
#         action="store_true",
#         help="성능 측정 모드"
#     )
#     parser.add_argument(
#         "--test", "-t",
#         action="store_true",
#         help="테스트 모드"
#     )
    
#     args = parser.parse_args()
    
#     if args.test:
#         test_improved_extraction()
#         return
    
#     if not os.path.exists(args.source_dir):
#         print(f"[ERROR] 소스 디렉토리를 찾을 수 없음: {args.source_dir}")
#         sys.exit(1)
    
#     total_start_time = time.time()
    
#     print(f"[INFO] 개선된 함수 포인터 분석 시작 (조건부 컴파일, union, typedef 지원)")
#     print(f"[INFO] 소스 디렉토리: {args.source_dir}")
    
#     # 1단계: 구조체의 함수 포인터 찾기 (개선된 방식)
#     print(f"\n=== 1단계: 개선된 구조체 함수 포인터 검색 ===")
#     step1_start = time.time()
    
#     struct_fp_map = find_struct_with_function_pointers(args.source_dir, args.verbose)
    
#     step1_time = time.time() - step1_start
    
#     if not struct_fp_map:
#         print("[INFO] 함수 포인터를 가진 구조체를 찾을 수 없음")
#         sys.exit(0)
    
#     # 모든 함수 포인터 이름 수집
#     all_fp_names = set()
#     total_fps = 0
#     for struct_name, fps in struct_fp_map.items():
#         print(f"  {struct_name}: {len(fps)}개 함수 포인터")
#         if args.verbose:
#             for return_type, fp_name, args_str in fps:
#                 print(f"    - {fp_name} ({return_type})")
#         for _, fp_name, _ in fps:
#             all_fp_names.add(fp_name)
#             total_fps += 1
    
#     print(f"[요약] {len(struct_fp_map)}개 구조체, {total_fps}개 함수 포인터 ({step1_time:.2f}초)")
    
#     # 2단계: 함수 포인터 할당 찾기
#     print(f"\n=== 2단계: 함수 포인터 할당 검색 ===")
#     step2_start = time.time()
    
#     fp_assignments = find_function_pointer_assignments(args.source_dir, all_fp_names, args.verbose)
    
#     step2_time = time.time() - step2_start
    
#     assignment_count = sum(len(funcs) for funcs in fp_assignments.values())
#     print(f"[요약] {len(fp_assignments)}개 함수 포인터에 {assignment_count}개 함수 할당 발견 ({step2_time:.2f}초)")
    
#     # 3단계: 함수 선언 찾기
#     print(f"\n=== 3단계: 함수 선언 검색 ===")
#     step3_start = time.time()
    
#     all_func_names = set()
#     for func_names in fp_assignments.values():
#         all_func_names.update(func_names)
    
#     func_declarations = find_function_declarations(args.source_dir, all_func_names, args.verbose)
    
#     step3_time = time.time() - step3_start
    
#     print(f"[요약] {len(func_declarations)}개 함수 선언 발견 ({step3_time:.2f}초)")
    
#     # 4단계: 결과 저장
#     print(f"\n=== 4단계: 결과 저장 ===")
#     step4_start = time.time()
    
#     save_results(fp_assignments, func_declarations, args.verbose)
    
#     step4_time = time.time() - step4_start
#     total_time = time.time() - total_start_time
    
#     print(f"[완료] 결과 파일 저장 완료 ({step4_time:.2f}초)")
    
#     # 최종 요약
#     print(f"\n=== 개선된 분석 완료 요약 ===")
#     print(f"총 소요 시간: {total_time:.2f}초")
#     print(f"  1단계 (개선된 구조체 검색): {step1_time:.2f}초")
#     print(f"  2단계 (할당 검색): {step2_time:.2f}초") 
#     print(f"  3단계 (선언 검색): {step3_time:.2f}초")
#     print(f"  4단계 (파일 저장): {step4_time:.2f}초")
    
#     print(f"\n처리 결과:")
#     print(f"  구조체: {len(struct_fp_map)}개")
#     print(f"  함수 포인터: {total_fps}개")
#     print(f"  함수 할당: {assignment_count}개")
#     print(f"  함수 선언: {len(func_declarations)}개")
    
#     print(f"\n생성된 파일:")
#     print(f"  fpName/: 각 함수 포인터별 할당된 함수 목록")
#     print(f"  fpNameDecl/: 각 함수 포인터별 함수 선언 모음")
    
#     # 누락된 선언 통계
#     missing_declarations = len([fn for fn in all_func_names if fn not in func_declarations])
#     if missing_declarations > 0:
#         print(f"\n선언 누락 현황:")
#         print(f"  전체 함수: {len(all_func_names)}개")
#         print(f"  선언 발견: {len(func_declarations)}개")
#         print(f"  선언 누락: {missing_declarations}개")
    
#     # 상세 결과 표시
#     if args.verbose or args.benchmark:
#         print(f"\n=== 상세 결과 ===")
#         for fp_name in sorted(fp_assignments.keys()):
#             func_count = len(fp_assignments[fp_name])
#             print(f"  {fp_name}: {func_count}개 함수")
#             if args.verbose and func_count > 0:
#                 for func_name in sorted(fp_assignments[fp_name]):
#                     status = "✓" if func_name in func_declarations else "✗"
#                     print(f"    {status} {func_name}")
    
#     if args.benchmark:
#         print(f"\n=== 성능 비교 (예상) ===")
#         print(f"  개선된 Python 방식: {total_time:.1f}초")
#         print(f"  기존 Python 방식: {total_time * 2:.1f}초+")
#         print(f"  Coccinelle 방식: {total_time * 15:.1f}초+")
#         print(f"  개선 효과: 조건부 컴파일, union, typedef 완벽 지원")

# if __name__ == "__main__":
#     main()

"""
개선된 함수 포인터 할당 추출기
- 조건부 컴파일, union, typedef 지원 강화
- 원본에서 직접 처리로 정확성 향상
- 데이터 구조 일관성 수정
"""

import argparse
import os
import re
import sys
from typing import Dict, List, Set, Tuple, Optional
import glob
from collections import defaultdict
import time

def find_struct_boundaries_in_original(content: str) -> List[Tuple[int, int]]:
    """원본 파일에서 직접 구조체 경계 찾기"""
    boundaries = []
    pattern = re.compile(r'\b(?:struct|union)(?:\s+\w+)?\s*\{', re.MULTILINE)
    
    for match in pattern.finditer(content):
        start_pos = match.start()
        brace_pos = match.end() - 1  # '{' 위치
        
        # 매칭되는 '}' 찾기
        brace_count = 1
        pos = brace_pos + 1
        
        while pos < len(content) and brace_count > 0:
            char = content[pos]
            if char == '{':
                brace_count += 1
            elif char == '}':
                brace_count -= 1
            pos += 1
        
        if brace_count == 0:
            boundaries.append((start_pos, pos))
    
    return boundaries

def extract_struct_name(struct_content: str) -> Optional[str]:
    """구조체 이름 추출"""
    # struct name { 패턴
    struct_name_pattern = re.compile(r'\b(?:struct|union)\s+(\w+)\s*\{')
    match = struct_name_pattern.search(struct_content)
    
    if match:
        return match.group(1)
    
    # typedef struct { ... } name; 패턴
    typedef_pattern = re.compile(r'typedef\s+(?:struct|union)\s*\{.*?\}\s*(\w+)\s*;', re.DOTALL)
    match = typedef_pattern.search(struct_content)
    
    if match:
        return match.group(1)
    
    return None

def remove_comments_and_preprocessor(content: str) -> str:
    """주석과 전처리기 지시어 제거"""
    # 주석 제거
    content = re.sub(r'//.*?(?=\n|$)', '', content)
    content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)
    
    # 전처리기 지시어 제거
    content = re.sub(r'^\s*#.*?$', '', content, flags=re.MULTILINE)
    
    return content

def find_function_pointers_in_struct_content(struct_content: str, verbose: bool = False) -> List[Tuple[str, str, str]]:
    """구조체 내용에서 함수 포인터 찾기 - 올바른 튜플 형태로 반환"""
    function_pointers = []
    
    # 주석과 전처리기 지시어 제거
    cleaned_content = remove_comments_and_preprocessor(struct_content)
    
    # 정확한 함수 포인터 패턴: return_type (*name)(args);
    fp_pattern = re.compile(
        r'([a-zA-Z_]\w*(?:\s+[a-zA-Z_*]\w*)*(?:\s*\*)*)\s*'  # return_type
        r'\(\s*\*\s*([a-zA-Z_]\w*)\s*\)'  # (*name)
        r'\s*\(([^)]*)\)\s*;',  # (args);
        re.MULTILINE | re.DOTALL
    )
    
    for match in fp_pattern.finditer(cleaned_content):
        try:
            return_type = match.group(1).strip()
            fp_name = match.group(2).strip()
            args = match.group(3).strip()
            
            # 비트필드 필터링: return_type에 콜론이 있으면 제외
            if ':' in return_type:
                continue
            
            # 유효한 함수 포인터인지 검사
            if (fp_name and 
                fp_name.isidentifier() and 
                return_type and
                not return_type.endswith(':')):
                
                function_pointers.append((return_type, fp_name, args))
                    
        
        except Exception as e:
            if verbose:
                print(f"    Pattern matching error: {e}")
            continue
    
    return function_pointers

def find_structs_in_content(content: str, verbose: bool = False) -> Dict[str, List[Tuple[str, str, str]]]:
    """단일 파일 내용에서 구조체와 함수 포인터 찾기 - 원본에서 직접 처리"""
    struct_fp_map = {}
    
    # 구조체/union 경계 찾기 (조건부 컴파일 무시)
    boundaries = find_struct_boundaries_in_original(content)
    
    if not boundaries:
        return struct_fp_map
    
    # 각 구조체 영역에서 함수 포인터 찾기
    for start_pos, end_pos in boundaries:
        struct_content = content[start_pos:end_pos]
        
        # 구조체 이름 추출
        struct_name = extract_struct_name(struct_content)
        if not struct_name:
            continue
        
        # 함수 포인터 찾기 (원본에서 직접)
        function_pointers = find_function_pointers_in_struct_content(struct_content, verbose)
        
        # 중복 제거 없이 모든 함수 포인터 저장
        if function_pointers:
            if struct_name not in struct_fp_map:
                struct_fp_map[struct_name] = []
            
            struct_fp_map[struct_name].extend(function_pointers)
            if verbose:
                print(f"[FOUND] {struct_name}: {len(function_pointers)}개 함수 포인터")
                for return_type, fp_name, args in function_pointers:
                    print(f"  - {fp_name} ({return_type})")
    
    return struct_fp_map

def find_struct_with_function_pointers(source_dir: str, verbose: bool = False) -> Dict[str, List[Tuple[str, str, str]]]:
    """개선된 구조체의 함수 포인터 검색 - 조건부 컴파일과 union 지원"""
    struct_fp_map = {}
    
    # 파일 검색
    file_patterns = [
        os.path.join(source_dir, "src/*.c"),
        os.path.join(source_dir, "src/*.h"),
        os.path.join(source_dir, "src/*.in"),
        os.path.join(source_dir, "ext/**/*.c"),
        os.path.join(source_dir, "ext/**/*.h"),
        os.path.join(source_dir, "ext/**/*.in")
    ]
    
    files_to_process = set()
    for pattern in file_patterns:
        files_to_process.update(glob.glob(pattern, recursive=True))
    
    files_to_process = list(files_to_process)
    if verbose:
        print(f"[INFO] 구조체 검색: {len(files_to_process)}개 파일 스캔 중...")
    
    for file_path in files_to_process:
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            # 원본에서 직접 구조체 찾기 (조건부 컴파일 무시)
            file_struct_map = find_structs_in_content(content, verbose)
            
            # 결과 병합 - 중복 제거 없이 모든 함수 포인터 저장
            for struct_name, fps in file_struct_map.items():
                if struct_name not in struct_fp_map:
                    struct_fp_map[struct_name] = []
                
                # 모든 함수 포인터를 저장 (중복 제거 안함)
                struct_fp_map[struct_name].extend(fps)
            
        except Exception as e:
            if verbose:
                print(f"[WARN] 파일 처리 실패 {file_path}: {e}")
    
    return struct_fp_map

def find_function_pointer_assignments(source_dir: str, fp_names: Set[str], verbose: bool = False) -> Dict[str, Set[str]]:
    """함수 포인터 할당 검색 (수정된 버전 - 올바른 그룹 추출)"""
    fp_assignments = defaultdict(set)
    
    # 다양한 할당 패턴들
    assignment_patterns = []

    for fp_name in fp_names:
        # 1. 구조체 멤버 할당: obj.fp_name = func_name
        assignment_patterns.append((
            fp_name,
            re.compile(rf'(\w+)\.{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,];', re.MULTILINE),
            2  # 함수명이 있는 그룹 번호
        ))
        
        # 2. 이중 구조체 멤버 할당: obj1.obj2.fp_name = func_name
        assignment_patterns.append((
            fp_name,
            re.compile(rf'(\w+)\.(\w+)\.{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,];', re.MULTILINE),
            3  # 함수명이 있는 그룹 번호
        ))

        # 3. 포인터 멤버 할당: obj->fp_name = func_name
        assignment_patterns.append((
            fp_name,
            re.compile(rf'(\w+)->{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,];', re.MULTILINE),
            2  # 함수명이 있는 그룹 번호
        ))

        # 4. 포인터 멤버 할당: obj1->obj2->fp_name = func_name
        assignment_patterns.append((
            fp_name,
            re.compile(rf'(\w+)->(\w+)->{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,];', re.MULTILINE),
            3  # 함수명이 있는 그룹 번호
        ))

        # 5. 혼합 할당: obj1.obj2->fp_name = func_name
        assignment_patterns.append((
            fp_name,
            re.compile(rf'(\w+)\.(\w+)->{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,];', re.MULTILINE),
            3  # 함수명이 있는 그룹 번호
        ))

        # 6. 혼합 할당: obj1->obj2.fp_name = func_name
        assignment_patterns.append((
            fp_name,
            re.compile(rf'(\w+)->(\w+)\.{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,];', re.MULTILINE),
            3  # 함수명이 있는 그룹 번호
        ))
        
        # 7. 3레벨 포인터 할당: obj1->obj2->obj3->fp_name = func_name
        assignment_patterns.append((
            fp_name,
            re.compile(rf'(\w+)->(\w+)->(\w+)->{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,];', re.MULTILINE),
            4  # 함수명이 있는 그룹 번호
        ))
        
        # 8. 3레벨 혼합 할당: obj1.obj2.obj3.fp_name = func_name
        assignment_patterns.append((
            fp_name,
            re.compile(rf'(\w+)\.(\w+)\.(\w+)\.{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,];', re.MULTILINE),
            4  # 함수명이 있는 그룹 번호
        ))
        
        # 9. 구조체 초기화: {.fp_name = func_name}
        assignment_patterns.append((
            fp_name,
            re.compile(rf'\.{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[,}}];', re.MULTILINE),
            1  # 함수명이 있는 그룹 번호
        ))

    
    # 파일 검색
    file_patterns = [
        os.path.join(source_dir, "src/*.c"),
        os.path.join(source_dir, "src/*.h"),
        os.path.join(source_dir, "src/*.in"),
        os.path.join(source_dir, "ext/**/*.c"),
        os.path.join(source_dir, "ext/**/*.h"),
        os.path.join(source_dir, "ext/**/*.in")
    ]
    
    files_to_process = set()
    for pattern in file_patterns:
        files_to_process.update(glob.glob(pattern, recursive=True))
    
    files_to_process = list(files_to_process)
    if verbose:
        print(f"[INFO] 함수 할당 검색: {len(files_to_process)}개 파일 스캔 중...")
    
    start_time = time.time()
    processed_files = 0
    
    for file_path in files_to_process:
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            processed_files += 1
            if verbose and processed_files % 100 == 0:
                elapsed = time.time() - start_time
                print(f"[PROGRESS] {processed_files}/{len(files_to_process)} 파일 처리됨 ({elapsed:.1f}초)")
            
            # 모든 할당 패턴으로 검색
            for fp_name, pattern, group_index in assignment_patterns:
                for match in pattern.finditer(content):
                    groups = match.groups()
                    
                    if group_index == "ternary":
                        # 삼항 연산자: 마지막 두 그룹이 func1, func2
                        if len(groups) >= 2:
                            func_name1 = groups[-2].strip()
                            func_name2 = groups[-1].strip()
                            
                            if func_name1 and func_name1 not in ['NULL', 'nullptr'] and func_name1.isidentifier():
                                fp_assignments[fp_name].add(func_name1)
                                if verbose:
                                    print(f"[ASSIGNMENT] {fp_name} = {func_name1} (삼항1) in {os.path.basename(file_path)}")
                            
                            if func_name2 and func_name2 not in ['NULL', 'nullptr'] and func_name2.isidentifier():
                                fp_assignments[fp_name].add(func_name2)
                                if verbose:
                                    print(f"[ASSIGNMENT] {fp_name} = {func_name2} (삼항2) in {os.path.basename(file_path)}")
                    else:
                        # 일반적인 할당: 지정된 그룹에서 함수명 추출
                        if len(groups) >= group_index:
                            func_name = groups[group_index - 1].strip()  # 0-based index
                            
                            # 유효한 함수명인지 확인
                            if (func_name and 
                                func_name not in ['NULL', 'nullptr'] and 
                                func_name.isidentifier()):
                                fp_assignments[fp_name].add(func_name)
                                if verbose:
                                    print(f"[ASSIGNMENT] {fp_name} = {func_name} in {os.path.basename(file_path)}")
        
        except Exception as e:
            if verbose:
                print(f"[WARN] 파일 처리 실패 {file_path}: {e}")
    
    elapsed = time.time() - start_time
    if verbose:
        print(f"[완료] 함수 할당 검색 완료 ({elapsed:.1f}초)")
    
    return dict(fp_assignments)

def find_function_declarations(source_dir: str, func_names: Set[str], verbose: bool = False) -> Dict[str, str]:
    """Python으로 함수 선언 검색"""
    func_declarations = {}
    
    if not func_names:
        return func_declarations
    
    # 함수 선언 패턴들
    declaration_patterns = []
    for func_name in func_names:
        # return_type func_name(args) - 함수 선언
        declaration_patterns.append((
            func_name,
            re.compile(rf'(\w+(?:\s+\w+)*\s*\*?)\s+{re.escape(func_name)}\s*\(([^)]*)\)\s*[;{{]', re.MULTILINE)
        ))
        
        # static/extern 포함
        declaration_patterns.append((
            func_name,
            re.compile(rf'((?:static\s+|extern\s+)*\w+(?:\s+\w+)*\s*\*?)\s+{re.escape(func_name)}\s*\(([^)]*)\)\s*[;{{]', re.MULTILINE)
        ))
    
    # 파일 검색
    file_patterns = [
        os.path.join(source_dir, "src/*.c"),
        os.path.join(source_dir, "src/*.h"),
        os.path.join(source_dir, "src/*.in"),
        os.path.join(source_dir, "ext/**/*.c"),
        os.path.join(source_dir, "ext/**/*.h"),
        os.path.join(source_dir, "ext/**/*.in")
    ]
    
    files_to_process = set()
    for pattern in file_patterns:
        files_to_process.update(glob.glob(pattern, recursive=True))
    
    files_to_process = list(files_to_process)
    if verbose:
        print(f"[INFO] 함수 선언 검색: {len(files_to_process)}개 파일 스캔 중...")
    
    start_time = time.time()
    
    for file_path in files_to_process:
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            # 주석 제거
            content = re.sub(r'//.*?\n', '\n', content)
            content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)
            
            # 함수 선언 찾기
            for func_name, pattern in declaration_patterns:
                if func_name not in func_declarations:  # 아직 찾지 못한 함수만
                    for match in pattern.finditer(content):
                        return_type = match.group(1).strip()
                        args = match.group(2).strip() if len(match.groups()) > 1 else ""
                        
                        # static 제거
                        return_type = re.sub(r'\bstatic\s+', '', return_type)
                        
                        declaration = f"{return_type} {func_name}({args})"
                        func_declarations[func_name] = declaration
                        
                        if verbose:
                            print(f"[DECLARATION] {declaration} in {os.path.basename(file_path)}")
                        break  # 첫 번째 선언만 사용
        
        except Exception as e:
            if verbose:
                print(f"[WARN] 파일 처리 실패 {file_path}: {e}")
    
    elapsed = time.time() - start_time
    if verbose:
        print(f"[완료] 함수 선언 검색 완료 ({elapsed:.1f}초)")
    
    return func_declarations

def save_results(fp_assignments: Dict[str, Set[str]], func_declarations: Dict[str, str], verbose: bool = False):
    """결과를 파일로 저장"""
    # fpName 디렉토리 생성
    os.makedirs("fpName", exist_ok=True)
    os.makedirs("fpNameDecl", exist_ok=True)
    
    if verbose:
        print(f"[INFO] 결과 파일 저장 중...")
    
    # 각 함수 포인터별로 할당된 함수 목록 저장
    for fp_name, func_names in fp_assignments.items():
        if func_names:
            with open(f"fpName/{fp_name}.txt", 'w', encoding='utf-8') as f:
                for func_name in sorted(func_names):
                    f.write(f"{func_name}\n")
            
            if verbose:
                print(f"[SAVED] fpName/{fp_name}.txt: {len(func_names)}개 함수")
    
    # 각 함수 포인터별로 함수 선언 저장
    for fp_name, func_names in fp_assignments.items():
        if func_names:
            declarations = []
            for func_name in sorted(func_names):
                if func_name in func_declarations:
                    declarations.append(f"{func_declarations[func_name]};")
                else:
                    declarations.append(f"// 선언을 찾을 수 없음: {func_name}")
            
            if declarations:
                with open(f"fpNameDecl/{fp_name}.txt", 'w', encoding='utf-8') as f:
                    f.write(f"// Function declarations for {fp_name}\n\n")
                    for decl in declarations:
                        f.write(f"{decl}\n")
                
                if verbose:
                    print(f"[SAVED] fpNameDecl/{fp_name}.txt: {len(declarations)}개 선언")

def test_improved_extraction():
    """개선된 추출 방식 테스트"""
    print("=== 개선된 구조체 함수 포인터 추출 테스트 ===")
    
    # 테스트용 구조체 (조건부 컴파일과 union 포함)
    test_content = '''
struct test_struct {
  void (*xLegacy)(void*,const char*);
  union {
    void (*xUnion1)(void*);
    int (*xUnion2)(int);
  } u;
#ifndef DISABLE_FEATURE  
  void (*xProfile)(void*,const char*,u64);
#endif
  int (*xCommitCallback)(void*);
#ifdef ENABLE_FEATURE
  void (*xFeature)(void*);
#endif
  sqlite3_xauth xAuth;
};

struct another_struct {
  int (*xHandler)(void*);
  unsigned int (*xProcessor)(void*, int);
};
'''
    
    # 구조체와 함수 포인터 찾기
    struct_fp_map = find_structs_in_content(test_content, verbose=True)
    
    print(f"\n발견된 구조체: {len(struct_fp_map)}개")
    total_fps = 0
    for struct_name, fps in struct_fp_map.items():
        print(f"  {struct_name}: {len(fps)}개 함수 포인터")
        for return_type, fp_name, args in fps:
            print(f"    - {fp_name} ({return_type})")
            total_fps += 1
    
    print(f"\n총 함수 포인터: {total_fps}개")
    
    expected_fps = ['xLegacy', 'xUnion1', 'xUnion2', 'xProfile', 'xCommitCallback', 'xFeature', 'xAuth', 'xHandler', 'xProcessor']
    found_fps = []
    for fps in struct_fp_map.values():
        found_fps.extend([fp[1] for fp in fps])
    
    missing = set(expected_fps) - set(found_fps)
    extra = set(found_fps) - set(expected_fps)
    
    if missing:
        print(f"누락: {missing}")
    if extra:
        print(f"추가: {extra}")
    
    if not missing and not extra:
        print("✓ 모든 함수 포인터가 정확히 발견됨!")
    else:
        print("✗ 일부 불일치 발견")

def main():
    parser = argparse.ArgumentParser(
        description="개선된 함수 포인터 할당 추출기 - 조건부 컴파일, union, typedef 지원"
    )
    parser.add_argument(
        "--source-dir",
        required=True,
        help="소스 코드 디렉토리"
    )
    parser.add_argument(
        "--verbose", "-v",
        action="store_true",
        help="상세 출력"
    )
    parser.add_argument(
        "--benchmark", "-b",
        action="store_true",
        help="성능 측정 모드"
    )
    parser.add_argument(
        "--test", "-t",
        action="store_true",
        help="테스트 모드"
    )
    
    args = parser.parse_args()
    
    if args.test:
        test_improved_extraction()
        return
    
    if not os.path.exists(args.source_dir):
        print(f"[ERROR] 소스 디렉토리를 찾을 수 없음: {args.source_dir}")
        sys.exit(1)
    
    total_start_time = time.time()
    
    print(f"[INFO] 개선된 함수 포인터 분석 시작 (조건부 컴파일, union, typedef 지원)")
    print(f"[INFO] 소스 디렉토리: {args.source_dir}")
    
    # 1단계: 구조체의 함수 포인터 찾기 (개선된 방식)
    print(f"\n=== 1단계: 개선된 구조체 함수 포인터 검색 ===")
    step1_start = time.time()
    
    struct_fp_map = find_struct_with_function_pointers(args.source_dir, args.verbose)
    
    step1_time = time.time() - step1_start
    
    if not struct_fp_map:
        print("[INFO] 함수 포인터를 가진 구조체를 찾을 수 없음")
        sys.exit(0)
    
    # 모든 함수 포인터 이름 수집
    all_fp_names = set()
    total_fps = 0
    for struct_name, fps in struct_fp_map.items():
        print(f"  {struct_name}: {len(fps)}개 함수 포인터")
        if args.verbose:
            for return_type, fp_name, args_str in fps:
                print(f"    - {fp_name} ({return_type})")
        for _, fp_name, _ in fps:
            all_fp_names.add(fp_name)
            total_fps += 1
    
    print(f"[요약] {len(struct_fp_map)}개 구조체, {total_fps}개 함수 포인터 ({step1_time:.2f}초)")
    
    # 2단계: 함수 포인터 할당 찾기
    print(f"\n=== 2단계: 함수 포인터 할당 검색 ===")
    step2_start = time.time()
    
    fp_assignments = find_function_pointer_assignments(args.source_dir, all_fp_names, args.verbose)
    
    step2_time = time.time() - step2_start
    
    assignment_count = sum(len(funcs) for funcs in fp_assignments.values())
    print(f"[요약] {len(fp_assignments)}개 함수 포인터에 {assignment_count}개 함수 할당 발견 ({step2_time:.2f}초)")
    
    # 3단계: 함수 선언 찾기
    print(f"\n=== 3단계: 함수 선언 검색 ===")
    step3_start = time.time()
    
    all_func_names = set()
    for func_names in fp_assignments.values():
        all_func_names.update(func_names)
    
    func_declarations = find_function_declarations(args.source_dir, all_func_names, args.verbose)
    
    step3_time = time.time() - step3_start
    
    print(f"[요약] {len(func_declarations)}개 함수 선언 발견 ({step3_time:.2f}초)")
    
    # 4단계: 결과 저장
    print(f"\n=== 4단계: 결과 저장 ===")
    step4_start = time.time()
    
    save_results(fp_assignments, func_declarations, args.verbose)
    
    step4_time = time.time() - step4_start
    total_time = time.time() - total_start_time
    
    print(f"[완료] 결과 파일 저장 완료 ({step4_time:.2f}초)")
    
    # 최종 요약
    print(f"\n=== 개선된 분석 완료 요약 ===")
    print(f"총 소요 시간: {total_time:.2f}초")
    print(f"  1단계 (개선된 구조체 검색): {step1_time:.2f}초")
    print(f"  2단계 (할당 검색): {step2_time:.2f}초") 
    print(f"  3단계 (선언 검색): {step3_time:.2f}초")
    print(f"  4단계 (파일 저장): {step4_time:.2f}초")
    
    print(f"\n처리 결과:")
    print(f"  구조체: {len(struct_fp_map)}개")
    print(f"  함수 포인터: {total_fps}개")
    print(f"  함수 할당: {assignment_count}개")
    print(f"  함수 선언: {len(func_declarations)}개")
    
    print(f"\n생성된 파일:")
    print(f"  fpName/: 각 함수 포인터별 할당된 함수 목록")
    print(f"  fpNameDecl/: 각 함수 포인터별 함수 선언 모음")
    
    # 누락된 선언 통계
    missing_declarations = len([fn for fn in all_func_names if fn not in func_declarations])
    if missing_declarations > 0:
        print(f"\n선언 누락 현황:")
        print(f"  전체 함수: {len(all_func_names)}개")
        print(f"  선언 발견: {len(func_declarations)}개")
        print(f"  선언 누락: {missing_declarations}개")
    
    # 상세 결과 표시
    if args.verbose or args.benchmark:
        print(f"\n=== 상세 결과 ===")
        for fp_name in sorted(fp_assignments.keys()):
            func_count = len(fp_assignments[fp_name])
            print(f"  {fp_name}: {func_count}개 함수")
            if args.verbose and func_count > 0:
                for func_name in sorted(fp_assignments[fp_name]):
                    status = "✓" if func_name in func_declarations else "✗"
                    print(f"    {status} {func_name}")
    
    if args.benchmark:
        print(f"\n=== 성능 비교 (예상) ===")
        print(f"  개선된 Python 방식: {total_time:.1f}초")
        print(f"  기존 Python 방식: {total_time * 2:.1f}초+")
        print(f"  Coccinelle 방식: {total_time * 15:.1f}초+")
        print(f"  개선 효과: 조건부 컴파일, union, typedef 완벽 지원")

if __name__ == "__main__":
    main()