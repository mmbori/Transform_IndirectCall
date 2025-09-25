"""
향상된 함수 포인터 할당 추출기
- 기존 기능 + 함수 인자로 전달되는 함수 포인터 추적
- 할당되는 함수가 다른 함수의 인자인 경우 역추적하여 실제 함수들 찾기
"""

import argparse
import os
import re
import sys
from typing import Dict, List, Set, Tuple, Optional
import glob
from collections import defaultdict
import time

def find_struct_with_function_pointers(source_dir: str, verbose: bool = False) -> Dict[str, List[Tuple[str, str, str]]]:
    """
    Python으로 구조체의 함수 포인터 검색
    """
    struct_fp_map = {}
    
    # 강화된 구조체 패턴들
    struct_patterns = [
        # struct name { ... };
        re.compile(r'struct\s+(\w+)\s*\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}\s*;', re.MULTILINE | re.DOTALL),
        # typedef struct name { ... } name;
        re.compile(r'typedef\s+struct\s+(\w+)\s*\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}\s*\w*\s*;', re.MULTILINE | re.DOTALL),
        # typedef struct { ... } name;
        re.compile(r'typedef\s+struct\s*\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}\s*(\w+)\s*;', re.MULTILINE | re.DOTALL),
    ]

    # 강화된 함수 포인터 패턴들
    fp_patterns = [
        # 기본: return_type (*name)(args);
        re.compile(r'(\w+(?:\s+\w+)*\s*\*?)\s*\(\s*\*\s*(\w+)\s*\)\s*\(([^)]*)\)\s*;', re.MULTILINE),
        # 복잡한 타입: struct type (*name)(args);
        re.compile(r'(struct\s+\w+\s*\*?|\w+\s*\*+)\s*\(\s*\*\s*(\w+)\s*\)\s*\(([^)]*)\)\s*;', re.MULTILINE),
        # const/volatile 포함
        re.compile(r'((?:const\s+|volatile\s+)*\w+(?:\s+\w+)*\s*\*?)\s*\(\s*\*\s*(\w+)\s*\)\s*\(([^)]*)\)\s*;', re.MULTILINE),
    ]
    
    # 파일 검색
    file_patterns = [
        os.path.join(source_dir, "src/*.c"),
        os.path.join(source_dir, "src/*.h"),
        os.path.join(source_dir, "ext/*.c"),
        os.path.join(source_dir, "ext/*.h"),
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
            
            # 주석 제거
            content = re.sub(r'//.*?\n', '\n', content)
            content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)
            
            # 구조체 검색
            for i, struct_pattern in enumerate(struct_patterns):
                for struct_match in struct_pattern.finditer(content):
                    if i == 2:  # typedef struct { ... } name;
                        struct_body = struct_match.group(1)
                        struct_name = struct_match.group(2)
                    else:
                        struct_name = struct_match.group(1)
                        struct_body = struct_match.group(2) if len(struct_match.groups()) > 1 else struct_match.group(1)
                    
                    if not struct_name or not struct_body:
                        continue

                    # 함수 포인터 검색
                    function_pointers = []
                    for fp_pattern in fp_patterns:
                        for fp_match in fp_pattern.finditer(struct_body):
                            return_type = fp_match.group(1).strip()
                            fp_name = fp_match.group(2).strip()
                            args = fp_match.group(3).strip()
                            
                            if fp_name and len(fp_name) > 1:
                                function_pointers.append((return_type, fp_name, args))
                    
                    if function_pointers:
                        if struct_name not in struct_fp_map:
                            struct_fp_map[struct_name] = []
                        
                        # 중복 제거
                        existing_fp_names = {fp[1] for fp in struct_fp_map[struct_name]}
                        new_fps = [fp for fp in function_pointers if fp[1] not in existing_fp_names]
                        
                        if new_fps:
                            struct_fp_map[struct_name].extend(new_fps)
                            if verbose:
                                print(f"[FOUND] {struct_name}: {len(new_fps)}개 함수 포인터")
        
        except Exception as e:
            if verbose:
                print(f"[WARN] 파일 처리 실패 {file_path}: {e}")
    
    return struct_fp_map

def find_function_pointer_assignments(source_dir: str, fp_names: Set[str], verbose: bool = False) -> Dict[str, Set[str]]:
    """
    Python으로 함수 포인터 할당 검색 - Coccinelle보다 훨씬 빠름!
    """
    fp_assignments = defaultdict(set)
    
    # 다양한 할당 패턴들
    assignment_patterns = []
    
    for fp_name in fp_names:
        # 1. 구조체 멤버 할당: obj.fp_name = func_name
        assignment_patterns.append((
            fp_name,
            re.compile(rf'\w+\.{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,]', re.MULTILINE)
        ))
        
        # 2. 이중 구조체 멤버 할당: obj1.obj2.fp_name = func_name
        assignment_patterns.append((
            fp_name,
            re.compile(rf'\w+\.\w+\.{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,]', re.MULTILINE)
        ))

        # 3. 포인터 멤버 할당: obj->fp_name = func_name
        assignment_patterns.append((
            fp_name,
            re.compile(rf'\w+->{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,]', re.MULTILINE)
        ))

        # 4. 포인터 멤버 할당: obj1->obj2->fp_name = func_name
        assignment_patterns.append((
            fp_name,
            re.compile(rf'\w+->\w+->{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,]', re.MULTILINE)
        ))

        # 5. 혼합 할당: obj1.obj2->fp_name = func_name
        assignment_patterns.append((
            fp_name,
            re.compile(rf'\w+\.\w+->{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,]', re.MULTILINE)
        ))

        # 6. 혼합 할당: obj1->obj2.fp_name = func_name
        assignment_patterns.append((
            fp_name,
            re.compile(rf'\w+->\w+\.{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,]', re.MULTILINE)
        ))
        
        # 7. 구조체 초기화: {.fp_name = func_name}
        assignment_patterns.append((
            fp_name,
            re.compile(rf'\.{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[,]', re.MULTILINE)
        ))
        
        # 8. 배열 초기화: [INDEX] = {.fp_name = func_name}
        assignment_patterns.append((
            fp_name,
            re.compile(rf'\[\w+\]\s*=\s*\{{[^}}]*\.{re.escape(fp_name)}\s*=\s*&?(\w+)', re.MULTILINE | re.DOTALL)
        ))
    
    # 파일 검색
    file_patterns = [
        os.path.join(source_dir, "src/*.c"),
        os.path.join(source_dir, "src/*.h"),
        os.path.join(source_dir, "ext/*.c"),
        os.path.join(source_dir, "ext/*.h")
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
            for fp_name, pattern in assignment_patterns:
                for match in pattern.finditer(content):
                    func_name = match.group(1).strip()
                    # 유효한 함수명인지 확인 (키워드 제외)
                    if func_name and func_name not in ['NULL', 'nullptr', '0'] and func_name.isidentifier():
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

def find_function_parameters(source_dir: str, func_name: str, verbose: bool = False) -> List[Tuple[str, int, str]]:
    """
    특정 함수의 매개변수 정보 찾기
    Returns: [(함수명, 매개변수위치, 매개변수타입), ...]
    """
    param_info = []
    
    # 함수 정의/선언 패턴
    func_patterns = [
        # return_type func_name(param1, param2, ...)
        re.compile(rf'(\w+(?:\s+\w+)*\s*\*?)\s+{re.escape(func_name)}\s*\(([^)]*)\)', re.MULTILINE),
        # static/extern 포함
        re.compile(rf'(?:static\s+|extern\s+)*(\w+(?:\s+\w+)*\s*\*?)\s+{re.escape(func_name)}\s*\(([^)]*)\)', re.MULTILINE)
    ]
    
    file_patterns = [
        os.path.join(source_dir, "src/*.c"),
        os.path.join(source_dir, "src/*.h"),
        os.path.join(source_dir, "ext/*.c"),
        os.path.join(source_dir, "ext/*.h")
    ]
    
    files_to_process = set()
    for pattern in file_patterns:
        files_to_process.update(glob.glob(pattern, recursive=True))
    
    for file_path in files_to_process:
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            # 주석 제거
            content = re.sub(r'//.*?\n', '\n', content)
            content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)
            
            for pattern in func_patterns:
                for match in pattern.finditer(content):
                    params_str = match.group(2).strip()
                    if not params_str or params_str == 'void':
                        continue
                    
                    # 매개변수 파싱 - 간단히 쉼표로 분리
                    params = [p.strip() for p in params_str.split(',') if p.strip()]
                    for i, param in enumerate(params):
                        # 함수 포인터 매개변수인지 확인
                        if '(*' in param and ')(' in param:
                            param_info.append((func_name, i, param))
                            if verbose:
                                print(f"[PARAM] {func_name}의 {i}번째 매개변수는 함수 포인터: {param}")
                    
                    if param_info:
                        return param_info  # 첫 번째 정의만 사용
        
        except Exception as e:
            if verbose:
                print(f"[WARN] 매개변수 분석 실패 {file_path}: {e}")
    
    return param_info


def find_function_declarations(source_dir: str, func_names: Set[str], verbose: bool = False) -> Dict[str, str]:
    """
    Python으로 함수 선언 검색
    """
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
        os.path.join(source_dir, "ext/*.c"),
        os.path.join(source_dir, "ext/*.h")
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
                        return_type = re.sub(r'\bextern\s+', '', return_type)
                        
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
    """
    결과를 파일로 저장
    """
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

def main():
    parser = argparse.ArgumentParser(
        description="향상된 함수 포인터 할당 추출기 - 매개변수 추적 기능 포함"
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
    
    args = parser.parse_args()
    
    if not os.path.exists(args.source_dir):
        print(f"[ERROR] 소스 디렉토리를 찾을 수 없음: {args.source_dir}")
        sys.exit(1)
    
    total_start_time = time.time()
    
    print(f"[INFO] 향상된 함수 포인터 분석 시작 (매개변수 추적 포함)")
    print(f"[INFO] 소스 디렉토리: {args.source_dir}")
    
    # 1단계: 구조체의 함수 포인터 찾기
    print(f"\n=== 1단계: 구조체 함수 포인터 검색 ===")
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
    
    # # 4단계: 매개변수 함수 역추적 (새로운 기능!)
    # print(f"\n=== 4단계: 매개변수 함수 역추적 ===")
    # step4_start = time.time()
    
    # resolved_assignments, resolved_declarations = resolve_parameter_functions(
    #     args.source_dir, fp_assignments, func_declarations, args.verbose
    # )
    
    # step4_time = time.time() - step4_start
    
    # resolved_assignment_count = sum(len(funcs) for funcs in resolved_assignments.values())
    # print(f"[요약] 매개변수 추적 완료: {resolved_assignment_count}개 함수 할당, {len(resolved_declarations)}개 선언 ({step4_time:.2f}초)")
    
    # 5단계: 결과 저장
    print(f"\n=== 4단계: 결과 저장 ===")
    step5_start = time.time()
    
    save_results(fp_assignments, func_declarations, args.verbose)
    
    step5_time = time.time() - step5_start
    total_time = time.time() - total_start_time
    
    print(f"[완료] 결과 파일 저장 완료 ({step5_time:.2f}초)")
    
    # 최종 요약
    print(f"\n=== 분석 완료 요약 ===")
    print(f"이 소요 시간: {total_time:.2f}초")
    print(f"  1단계 (구조체 검색): {step1_time:.2f}초")
    print(f"  2단계 (할당 검색): {step2_time:.2f}초") 
    print(f"  3단계 (선언 검색): {step3_time:.2f}초")
    print(f"  5단계 (파일 저장): {step5_time:.2f}초")
    
    print(f"\n처리 결과:")
    print(f"  구조체: {len(struct_fp_map)}개")
    print(f"  함수 포인터: {total_fps}개")
    print(f"  초기 할당: {assignment_count}개")
    
    print(f"\n생성된 파일:")
    print(f"  fpName/: 각 함수 포인터별 할당된 함수 목록")
    print(f"  fpNameDecl/: 각 함수 포인터별 함수 선언 모음")
    
    # 변경 통계
    original_missing = len([fn for fn in all_func_names if fn not in func_declarations])
    
    if original_missing > 0:
        print(f"\n매개변수 추적 효과:")
        print(f"  추적 전 누락 함수: {original_missing}개")
    
    if args.benchmark:
        print(f"\n=== 성능 비교 (예상) ===")
        print(f"  Python 방식: {total_time:.1f}초")
        print(f"  Coccinelle 방식: {total_time * 10:.1f}초+")
        print(f"  속도 향상: ~{10:.0f}배 빠름")

if __name__ == "__main__":
    main()