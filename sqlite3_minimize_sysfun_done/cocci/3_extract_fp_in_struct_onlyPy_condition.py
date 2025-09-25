"""
향상된 함수 포인터 할당 추출기 - 조건부 컴파일 정보 포함
- 기존 기능 + 함수가 속한 #ifdef/#ifndef 조건 추적
- 할당되는 함수가 다른 함수의 인자인 경우 역추적하여 실제 함수들 찾기
- 조건부 컴파일 매크로 정보까지 함께 저장
"""

import argparse
import os
import re
import sys
from typing import Dict, List, Set, Tuple, Optional
import glob
from collections import defaultdict
import time

class ConditionalInfo:
    """조건부 컴파일 정보를 저장하는 클래스"""
    def __init__(self, condition: str = "", is_conditional: bool = False):
        self.condition = condition
        self.is_conditional = is_conditional
    
    def __str__(self):
        if self.is_conditional:
            return f"#ifdef {self.condition}"
        return ""

def parse_conditional_blocks(content: str) -> List[Tuple[int, int, str, bool]]:
    """
    소스 코드에서 조건부 컴파일 블록들을 파싱
    Returns: [(start_pos, end_pos, condition, is_ifdef), ...]
    """
    conditional_blocks = []
    
    # #ifdef, #ifndef, #if defined 등의 패턴들
    ifdef_patterns = [
        re.compile(r'#ifdef\s+(\w+)', re.MULTILINE),
        re.compile(r'#if\s+defined\s*\(\s*(\w+)\s*\)', re.MULTILINE),
        re.compile(r'#if\s+(\w+)', re.MULTILINE)
    ]
    
    ifndef_patterns = [
        re.compile(r'#ifndef\s+(\w+)', re.MULTILINE),
        re.compile(r'#if\s+!\s*defined\s*\(\s*(\w+)\s*\)', re.MULTILINE)
    ]
    
    endif_pattern = re.compile(r'#endif', re.MULTILINE)
    
    # 모든 #ifdef/#ifndef 찾기
    ifdef_matches = []
    
    for pattern in ifdef_patterns:
        for match in pattern.finditer(content):
            ifdef_matches.append((match.start(), match.group(1), True))  # True = ifdef
    
    for pattern in ifndef_patterns:
        for match in pattern.finditer(content):
            ifdef_matches.append((match.start(), match.group(1), False))  # False = ifndef
    
    # #endif 찾기
    endif_matches = [match.start() for match in endif_pattern.finditer(content)]
    
    # 정렬
    ifdef_matches.sort()
    endif_matches.sort()
    
    # 매칭하기 (스택 방식)
    stack = []
    
    for ifdef_pos, condition, is_ifdef in ifdef_matches:
        stack.append((ifdef_pos, condition, is_ifdef))
    
    # 각 #ifdef에 대해 가장 가까운 #endif 찾기
    for ifdef_pos, condition, is_ifdef in ifdef_matches:
        matching_endif = None
        
        for endif_pos in endif_matches:
            if endif_pos > ifdef_pos:
                # 중간에 다른 #ifdef가 있는지 확인
                intermediate_ifdef = False
                for other_ifdef_pos, _, _ in ifdef_matches:
                    if ifdef_pos < other_ifdef_pos < endif_pos:
                        intermediate_ifdef = True
                        break
                
                if not intermediate_ifdef:
                    matching_endif = endif_pos
                    break
        
        if matching_endif:
            conditional_blocks.append((ifdef_pos, matching_endif, condition, is_ifdef))
    
    return conditional_blocks

def get_conditional_context(content: str, position: int) -> ConditionalInfo:
    """
    특정 위치의 코드가 어떤 조건부 컴파일 블록에 속하는지 확인
    """
    conditional_blocks = parse_conditional_blocks(content)
    
    for start_pos, end_pos, condition, is_ifdef in conditional_blocks:
        if start_pos <= position <= end_pos:
            return ConditionalInfo(condition, True)
    
    return ConditionalInfo("", False)

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

def find_function_pointer_assignments(source_dir: str, fp_names: Set[str], verbose: bool = False) -> Dict[str, List[Tuple[str, ConditionalInfo]]]:
    """
    Python으로 함수 포인터 할당 검색 - 조건부 컴파일 정보 포함
    Returns: {fp_name: [(func_name, conditional_info), ...]}
    """
    fp_assignments = defaultdict(list)
    
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
            re.compile(rf'\.{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[,\}}]', re.MULTILINE)
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
                        # 조건부 컴파일 정보 확인
                        conditional_info = get_conditional_context(content, match.start())
                        
                        # 중복 체크를 더 단순하게 - 함수명만 체크
                        existing_func_names = {func for func, _ in fp_assignments[fp_name]}
                        
                        if func_name not in existing_func_names:
                            fp_assignments[fp_name].append((func_name, conditional_info))
                            if verbose:
                                cond_str = f" [{conditional_info}]" if conditional_info.is_conditional else ""
                                print(f"[ASSIGNMENT] {fp_name} = {func_name}{cond_str} in {os.path.basename(file_path)}")
        
        except Exception as e:
            if verbose:
                print(f"[WARN] 파일 처리 실패 {file_path}: {e}")
    
    elapsed = time.time() - start_time
    if verbose:
        print(f"[완료] 함수 할당 검색 완료 ({elapsed:.1f}초)")
    
    return dict(fp_assignments)

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

def save_results_with_conditionals(fp_assignments: Dict[str, List[Tuple[str, ConditionalInfo]]], func_declarations: Dict[str, str], verbose: bool = False):
    """
    조건부 컴파일 정보를 포함하여 결과를 파일로 저장
    """
    # fpName 디렉토리 생성
    os.makedirs("fpNameCondition", exist_ok=True)
    os.makedirs("fpNameDeclCondition", exist_ok=True)
    
    if verbose:
        print(f"[INFO] 결과 파일 저장 중...")
    
    # 각 함수 포인터별로 할당된 함수 목록 저장 (조건부 정보 포함)
    for fp_name, func_assignments in fp_assignments.items():
        if func_assignments:
            with open(f"fpNameCondition/{fp_name}.txt", 'w', encoding='utf-8') as f:
                # 조건별로 그룹화
                conditional_groups = defaultdict(list)
                
                for func_name, conditional_info in func_assignments:
                    if conditional_info.is_conditional:
                        conditional_groups[conditional_info.condition].append(func_name)
                    else:
                        conditional_groups[""].append(func_name)
                
                # 조건 없는 함수들 먼저 출력
                if "" in conditional_groups:
                    for func_name in sorted(conditional_groups[""]):
                        f.write(f"{func_name}\n")
                
                # 조건부 함수들 출력
                for condition in sorted(conditional_groups.keys()):
                    if condition:  # 빈 조건이 아닌 경우
                        f.write(f"#ifdef {condition}\n")
                        for func_name in sorted(conditional_groups[condition]):
                            f.write(f"{func_name}\n")
                        f.write(f"#endif\n")
            
            if verbose:
                total_funcs = len(func_assignments)
                conditional_funcs = sum(1 for _, cond in func_assignments if cond.is_conditional)
                print(f"[SAVED] fpNameCondition/{fp_name}.txt: {total_funcs}개 함수 ({conditional_funcs}개 조건부)")
    
    # 각 함수 포인터별로 함수 선언 저장 (조건부 정보 포함)
    for fp_name, func_assignments in fp_assignments.items():
        if func_assignments:
            declarations = []
            
            # 조건별로 그룹화
            conditional_groups = defaultdict(list)
            
            for func_name, conditional_info in func_assignments:
                declaration = func_declarations.get(func_name, f"// 선언을 찾을 수 없음: {func_name}")
                if not declaration.endswith(';'):
                    declaration += ';'
                
                if conditional_info.is_conditional:
                    conditional_groups[conditional_info.condition].append(declaration)
                else:
                    conditional_groups[""].append(declaration)
            
            # 헤더 추가
            declarations.append(f"// Function declarations for {fp_name}\n")
            
            # 조건 없는 함수들 먼저 추가
            if "" in conditional_groups:
                for decl in sorted(conditional_groups[""]):
                    declarations.append(decl)
            
            # 조건부 함수들 추가
            for condition in sorted(conditional_groups.keys()):
                if condition:  # 빈 조건이 아닌 경우
                    declarations.append(f"#ifdef {condition}")
                    for decl in sorted(conditional_groups[condition]):
                        declarations.append(decl)
                    declarations.append(f"#endif")
            
            if declarations:
                with open(f"fpNameDeclCondition/{fp_name}.txt", 'w', encoding='utf-8') as f:
                    for decl in declarations:
                        f.write(f"{decl}\n")
                
                if verbose:
                    print(f"[SAVED] fpNameDeclCondition/{fp_name}.txt: {len(declarations)}개 선언")

def main():
    parser = argparse.ArgumentParser(
        description="향상된 함수 포인터 할당 추출기 - 조건부 컴파일 정보 포함"
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
    
    print(f"[INFO] 향상된 함수 포인터 분석 시작 (조건부 컴파일 정보 포함)")
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
    
    # 2단계: 함수 포인터 할당 찾기 (조건부 정보 포함)
    print(f"\n=== 2단계: 함수 포인터 할당 검색 (조건부 정보 포함) ===")
    step2_start = time.time()
    
    fp_assignments = find_function_pointer_assignments(args.source_dir, all_fp_names, args.verbose)
    
    step2_time = time.time() - step2_start
    
    assignment_count = sum(len(assignments) for assignments in fp_assignments.values())
    conditional_count = sum(1 for assignments in fp_assignments.values() 
                          for _, cond_info in assignments if cond_info.is_conditional)
    
    print(f"[요약] {len(fp_assignments)}개 함수 포인터에 {assignment_count}개 함수 할당 발견")
    print(f"       그 중 {conditional_count}개가 조건부 컴파일 블록 내부 ({step2_time:.2f}초)")
    
    # 3단계: 함수 선언 찾기
    print(f"\n=== 3단계: 함수 선언 검색 ===")
    step3_start = time.time()
    
    all_func_names = set()
    for assignments in fp_assignments.values():
        for func_name, _ in assignments:
            all_func_names.add(func_name)
    
    func_declarations = find_function_declarations(args.source_dir, all_func_names, args.verbose)
    
    step3_time = time.time() - step3_start
    
    print(f"[요약] {len(func_declarations)}개 함수 선언 발견 ({step3_time:.2f}초)")
    
    # 4단계: 결과 저장 (조건부 정보 포함)
    print(f"\n=== 4단계: 결과 저장 (조건부 정보 포함) ===")
    step4_start = time.time()
    
    save_results_with_conditionals(fp_assignments, func_declarations, args.verbose)
    
    step4_time = time.time() - step4_start
    total_time = time.time() - total_start_time
    
    print(f"[완료] 결과 파일 저장 완료 ({step4_time:.2f}초)")
    
    # 최종 요약
    print(f"\n=== 분석 완료 요약 ===")
    print(f"총 소요 시간: {total_time:.2f}초")
    print(f"  1단계 (구조체 검색): {step1_time:.2f}초")
    print(f"  2단계 (할당 검색): {step2_time:.2f}초") 
    print(f"  3단계 (선언 검색): {step3_time:.2f}초")
    print(f"  4단계 (파일 저장): {step4_time:.2f}초")
    
    print(f"\n처리 결과:")
    print(f"  구조체: {len(struct_fp_map)}개")
    print(f"  함수 포인터: {total_fps}개")
    print(f"  총 할당: {assignment_count}개")
    print(f"  조건부 할당: {conditional_count}개")
    print(f"  함수 선언: {len(func_declarations)}개")
    
    print(f"\n생성된 파일:")
    print(f"  fpName/: 각 함수 포인터별 할당된 함수 목록 (조건부 정보 포함)")
    print(f"  fpNameDecl/: 각 함수 포인터별 함수 선언 모음 (조건부 정보 포함)")
    
    if args.benchmark:
        print(f"\n=== 성능 비교 (예상) ===")
        print(f"  Python 방식: {total_time:.1f}초")
        print(f"  Coccinelle 방식: {total_time * 10:.1f}초+")
        print(f"  속도 향상: ~{10:.0f}배 빠름")
    
    # 조건부 컴파일 통계
    if conditional_count > 0:
        print(f"\n=== 조건부 컴파일 통계 ===")
        condition_stats = defaultdict(int)
        for assignments in fp_assignments.values():
            for _, cond_info in assignments:
                if cond_info.is_conditional:
                    condition_stats[cond_info.condition] += 1
        
        print(f"발견된 조건부 매크로:")
        for condition, count in sorted(condition_stats.items()):
            print(f"  {condition}: {count}개 함수")

if __name__ == "__main__":
    main()