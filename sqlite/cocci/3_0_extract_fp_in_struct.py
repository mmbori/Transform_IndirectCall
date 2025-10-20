#!/usr/bin/env python3
"""
함수 포인터 할당 추출 및 함수 선언부 검색
- 구조체 내 함수 포인터 인덱스 추적
- 구조체 초기화 패턴 분석
- .fpName = 패턴 분석
- 할당된 함수들의 선언부 추출
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
        brace_pos = match.end() - 1
        
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
    struct_name_pattern = re.compile(r'\b(?:struct|union)\s+(\w+)\s*\{')
    match = struct_name_pattern.search(struct_content)
    
    if match:
        return match.group(1)
    
    typedef_pattern = re.compile(r'typedef\s+(?:struct|union)\s*\{.*?\}\s*(\w+)\s*;', re.DOTALL)
    match = typedef_pattern.search(struct_content)
    
    if match:
        return match.group(1)
    
    return None

def extract_function_pointer_pattern(decl: str) -> Optional[Tuple[str, str]]:
    """선언에서 함수 포인터 패턴 추출 (중첩 괄호 대응)"""
    ptr_pattern = re.search(r'\(\s*\*\s*(\w+)\s*\)', decl)
    if not ptr_pattern:
        return None
    
    fp_name = ptr_pattern.group(1)
    start_pos = ptr_pattern.end()
    if start_pos >= len(decl) or decl[start_pos] != '(':
        return None
    
    depth = 1
    pos = start_pos + 1
    
    while pos < len(decl) and depth > 0:
        if decl[pos] == '(':
            depth += 1
        elif decl[pos] == ')':
            depth -= 1
        pos += 1
    
    if depth != 0:
        return None
    
    return_type = decl[:ptr_pattern.start()].strip()
    return (return_type, fp_name)

def find_function_pointers_with_index(struct_content: str, verbose: bool = False) -> List[Tuple[str, str, str, int]]:
    """구조체 내용에서 함수 포인터와 인덱스 찾기"""
    function_pointers = []
    
    brace_start = struct_content.find('{')
    brace_end = struct_content.rfind('}')
    if brace_start == -1 or brace_end == -1:
        return function_pointers
    
    body = struct_content[brace_start+1:brace_end]
    body = re.sub(r'//.*?(?=\n|$)', '', body)
    body = re.sub(r'/\*.*?\*/', '', body, flags=re.DOTALL)
    
    declarations = re.split(r';', body)
    typedef_pattern = re.compile(r'(sqlite3_xauth|sqlite3_callback|sqlite3_exec_callback|fts5_extension_function)\s+(\w+)')
    
    member_index = 0
    
    for decl in declarations:
        decl = decl.strip()
        
        if not decl or decl.startswith('#'):
            continue
        
        if '{' in decl or '}' in decl:
            continue
        
        is_bitfield = bool(re.search(r':\s*\d+\s*$', decl))
        if is_bitfield:
            continue
        
        typedef_match = typedef_pattern.search(decl)
        if typedef_match:
            return_type = typedef_match.group(1)
            fp_name = typedef_match.group(2)
            if fp_name and fp_name.isidentifier():
                fp_info = (return_type, fp_name, "typedef", member_index)
                if not any(existing[1] == fp_info[1] for existing in function_pointers):
                    function_pointers.append(fp_info)
        else:
            result = extract_function_pointer_pattern(decl)
            if result:
                return_type, fp_name = result
                if fp_name and len(fp_name) > 1 and fp_name.isidentifier():
                    fp_info = (return_type, fp_name, "", member_index)
                    if not any(existing[1] == fp_info[1] for existing in function_pointers):
                        function_pointers.append(fp_info)
        
        member_index += 1
    
    return function_pointers

def find_structs_in_content(content: str, verbose: bool = False) -> Dict[str, List[Tuple[str, str, str, int]]]:
    """단일 파일 내용에서 구조체와 함수 포인터 찾기"""
    struct_fp_map = {}
    boundaries = find_struct_boundaries_in_original(content)
    
    if not boundaries:
        return struct_fp_map
    
    for start_pos, end_pos in boundaries:
        struct_content = content[start_pos:end_pos]
        struct_name = extract_struct_name(struct_content)
        if not struct_name:
            continue
        
        function_pointers = find_function_pointers_with_index(struct_content, verbose)
        
        if function_pointers:
            if struct_name not in struct_fp_map:
                struct_fp_map[struct_name] = []
            
            existing_fp_names = {fp[0] for fp in struct_fp_map[struct_name]}
            new_fps = [fp for fp in function_pointers if fp[0] not in existing_fp_names]
            
            if new_fps:
                struct_fp_map[struct_name].extend(new_fps)
    
    return struct_fp_map

def find_struct_with_function_pointers(source_dir: str, verbose: bool = False) -> Dict[str, List[Tuple[str, str, str, int]]]:
    """구조체의 함수 포인터 검색"""
    struct_fp_map = {}
    
    file_patterns = [
        os.path.join(source_dir, "src/*.c"),
        os.path.join(source_dir, "src/*.h"),
        os.path.join(source_dir, "src/*.in"),
        os.path.join(source_dir, "ext/**/*.c"),
        os.path.join(source_dir, "ext/**/*.h"),
        os.path.join(source_dir, "ext/**/*.in"),
    ]
    
    files_to_process = set()
    for pattern in file_patterns:
        files_to_process.update(glob.glob(pattern, recursive=True))
    
    files_to_process = list(files_to_process)
    
    for file_path in files_to_process:
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            file_struct_map = find_structs_in_content(content, verbose)
            
            for struct_name, fps in file_struct_map.items():
                if struct_name not in struct_fp_map:
                    struct_fp_map[struct_name] = []
                
                existing_fp_names = {fp[1] for fp in struct_fp_map[struct_name]}
                new_fps = [fp for fp in fps if fp[1] not in existing_fp_names]
                
                if new_fps:
                    struct_fp_map[struct_name].extend(new_fps)
            
        except Exception as e:
            if verbose:
                print(f"[WARN] 파일 처리 실패 {file_path}: {e}")
    
    return struct_fp_map


def find_struct_initializations(source_dir: str, struct_fp_map: Dict[str, List[Tuple[str, str, str, int]]], verbose: bool = False) -> Dict[str, Set[str]]:
    """구조체 초기화 패턴에서 함수 포인터 할당 찾기 - 개선된 버전"""
    fp_assignments = defaultdict(set)
    
    struct_fp_index_map = {}
    for struct_name, fps in struct_fp_map.items():
        struct_fp_index_map[struct_name] = {idx: fp_name for _, fp_name, _, idx in fps}
    
    file_patterns = [
        os.path.join(source_dir, "src/*.c"),
        os.path.join(source_dir, "src/*.h"),
        os.path.join(source_dir, "src/*.in"),
        os.path.join(source_dir, "ext/**/*.c"),
        os.path.join(source_dir, "ext/**/*.h"),
        os.path.join(source_dir, "ext/**/*.in"),
    ]
    
    files_to_process = set()
    for pattern in file_patterns:
        files_to_process.update(glob.glob(pattern, recursive=True))
    
    files_to_process = list(files_to_process)
    
    for file_path in files_to_process:
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            # 주석 제거 (패턴 매칭용)
            content_no_comments = re.sub(r'//.*?\n', '\n', content)
            content_no_comments = re.sub(r'/\*.*?\*/', '', content_no_comments, flags=re.DOTALL)
            
            for struct_name in struct_fp_map.keys():
                # **수정: 시작 부분만 정규식으로 찾고, 중괄호는 수동 매칭**
                init_start_pattern = re.compile(
                    rf'(?:const\s+|static\s+|extern\s+)*(?:struct\s+)?{re.escape(struct_name)}\s+(\w+)\s*=\s*\{{',
                    re.MULTILINE
                )
                
                for match in init_start_pattern.finditer(content_no_comments):
                    var_name = match.group(1)
                    init_start = match.start()
                    brace_start = match.end() - 1  # '{' 위치
                    
                    # 매칭되는 '}' 찾기
                    depth = 1
                    pos = brace_start + 1
                    
                    while pos < len(content_no_comments) and depth > 0:
                        if content_no_comments[pos] == '{':
                            depth += 1
                        elif content_no_comments[pos] == '}':
                            depth -= 1
                        pos += 1
                    
                    if depth != 0:
                        continue
                    
                    brace_end = pos  # '}' 다음 위치
                    
                    # 세미콜론까지 찾기
                    semicolon_pos = content_no_comments.find(';', brace_end)
                    if semicolon_pos == -1 or semicolon_pos - brace_end > 10:
                        continue
                    
                    # 초기화 본문 추출
                    init_body = content_no_comments[brace_start+1:brace_end-1]
                    
                    # **핵심: 초기화 값들을 콤마로 분리 (빈 값도 포함)**
                    values = []
                    depth = 0
                    current_value = []
                    
                    for char in init_body:
                        if char in '({[':
                            depth += 1
                            current_value.append(char)
                        elif char in ')}]':
                            depth -= 1
                            current_value.append(char)
                        elif char == ',' and depth == 0:
                            val = ''.join(current_value).strip()
                            values.append(val)  # **빈 값도 추가 - 인덱스 유지 중요!**
                            current_value = []
                        else:
                            current_value.append(char)
                    
                    # 마지막 값 추가
                    val = ''.join(current_value).strip()
                    values.append(val)
                    
                    # 함수 포인터 인덱스에 해당하는 값 추출
                    fp_index_map = struct_fp_index_map[struct_name]
                    
                    for idx, value in enumerate(values):
                        if idx in fp_index_map:
                            fp_name = fp_index_map[idx]
                            
                            # 값 정리
                            value_clean = value.strip()
                            
                            # 주석 제거 (이미 제거됐지만 혹시 모를 잔여물)
                            value_clean = re.sub(r'/\*.*?\*/', '', value_clean).strip()
                            
                            # 함수 이름 추출 (& 제거, 식별자만)
                            func_match = re.match(r'^\s*&?(\w+)\s*$', value_clean)
                            if func_match:
                                func_name = func_match.group(1)
                                
                                # 유효한 함수만 (0도 기록)
                                if func_name.isidentifier() or func_name == '0':
                                    fp_assignments[fp_name].add(func_name)
                                    if verbose:
                                        print(f"[INIT] {struct_name}.{fp_name}[{idx}] = {func_name} in {os.path.basename(file_path)}")
        
        except Exception as e:
            if verbose:
                print(f"[WARN] 파일 처리 실패 {file_path}: {e}")
    
    return dict(fp_assignments)

def find_named_assignments(source_dir: str, fp_names: Set[str], verbose: bool = False) -> Dict[str, Set[str]]:
    """.fpName = 패턴으로 함수 포인터 할당 찾기"""
    fp_assignments = defaultdict(set)
    
    assignment_patterns = []
    
    for fp_name in fp_names:
        assignment_patterns.append((
            fp_name,
            re.compile(rf'\w+\.{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,]', re.MULTILINE)
        ))
        assignment_patterns.append((
            fp_name,
            re.compile(rf'\w+\.\w+\.{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,]', re.MULTILINE)
        ))
        assignment_patterns.append((
            fp_name,
            re.compile(rf'\w+->{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,]', re.MULTILINE)
        ))
        assignment_patterns.append((
            fp_name,
            re.compile(rf'\w+->\w+->{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[;,]', re.MULTILINE)
        ))
        assignment_patterns.append((
            fp_name,
            re.compile(rf'\.{re.escape(fp_name)}\s*=\s*&?(\w+)\s*[,}}]', re.MULTILINE)
        ))
    
    file_patterns = [
        os.path.join(source_dir, "src/*.c"),
        os.path.join(source_dir, "src/*.h"),
        os.path.join(source_dir, "src/*.in"),
        os.path.join(source_dir, "ext/**/*.c"),
        os.path.join(source_dir, "ext/**/*.h"),
        os.path.join(source_dir, "ext/**/*.in"),
    ]
    
    files_to_process = set()
    for pattern in file_patterns:
        files_to_process.update(glob.glob(pattern, recursive=True))
    
    files_to_process = list(files_to_process)
    
    for file_path in files_to_process:
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            for fp_name, pattern in assignment_patterns:
                for match in pattern.finditer(content):
                    func_name = match.group(1).strip()
                    if func_name and func_name not in ['NULL', 'nullptr'] and (func_name.isidentifier() or func_name == '0'):
                        fp_assignments[fp_name].add(func_name)
        
        except Exception as e:
            if verbose:
                print(f"[WARN] 파일 처리 실패 {file_path}: {e}")
    
    return dict(fp_assignments)

def normalize_declaration(decl: str) -> str:
    """함수 선언을 정규화 (줄바꿈 제거, 세미콜론으로 종료)"""
    # 주석 제거
    decl = re.sub(r'/\*.*?\*/', '', decl, flags=re.DOTALL)
    decl = re.sub(r'//.*?(?=\n|$)', '', decl)
    
    # 줄바꿈을 공백으로 변환
    decl = re.sub(r'\s+', ' ', decl)
    
    # 양쪽 공백 제거
    decl = decl.strip()
    
    # { 로 끝나면 세미콜론으로 변경 (정의를 선언으로 변환)
    if decl.endswith('{'):
        decl = decl[:-1].rstrip() + ';'
    
    # 세미콜론이 없으면 추가
    if not decl.endswith(';'):
        decl += ';'
    
    return decl

def find_function_declaration(source_dir: str, func_name: str, verbose: bool = False) -> Optional[str]:
    """함수 선언부 찾기 - 주석 완전 제거"""
    if func_name == '0':
        return None
    
    file_patterns = [
        os.path.join(source_dir, "src/*.c"),
        os.path.join(source_dir, "src/*.h"),
        os.path.join(source_dir, "src/*.in"),
        os.path.join(source_dir, "ext/**/*.c"),
        os.path.join(source_dir, "ext/**/*.h"),
        os.path.join(source_dir, "ext/**/*.in"),
    ]
    
    files_to_process = set()
    for pattern in file_patterns:
        files_to_process.update(glob.glob(pattern, recursive=True))
    
    func_pattern = re.compile(
        rf'\b{re.escape(func_name)}\s*\(',
        re.MULTILINE
    )
    
    for file_path in files_to_process:
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()

            # **핵심: 주석 제거 후 모든 작업 수행**
            content_no_comments = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)
            content_no_comments = re.sub(r'//.*?(?=\n|$)', '', content_no_comments)
            
            # **주석 제거된 버전에서 검색**
            for match in func_pattern.finditer(content_no_comments):
                func_pos = match.start()
                
                # **주석 제거된 content에서 역방향 스캔**
                scan_start = max(0, func_pos - 500)
                before_text = content_no_comments[scan_start:func_pos]
                
                # 선언 시작점
                last_semi = before_text.rfind(';')
                last_brace_close = before_text.rfind('}')
                last_brace_open = before_text.rfind('{')
                
                decl_start_offset = max(last_semi, last_brace_close, last_brace_open)
                
                if decl_start_offset != -1:
                    decl_start = scan_start + decl_start_offset + 1
                else:
                    decl_start = scan_start
                
                before_func = content_no_comments[decl_start:func_pos].strip()
                
                if not before_func:
                    continue
                
                # 포인터 제거 후 토큰 분리
                before_func_no_ptr = re.sub(r'\*+', ' ', before_func).strip()
                
                tokens = before_func_no_ptr.split()
                if len(tokens) == 0:
                    continue
                
                # 호출 패턴 제외
                first_token = tokens[0]
                if first_token in ['return', 'if', 'while', 'for', 'switch', 'sizeof', 'typeof']:
                    continue
                
                # 연산자로 끝나는 경우
                if re.search(r'[=+\-/&|<>!,]\s*$', before_func):
                    continue
                
                # 마지막 토큰 검증
                last_meaningful_token = tokens[-1]
                if not re.match(r'^[A-Za-z_]\w*$', last_meaningful_token):
                    continue
                
                # 괄호 매칭
                paren_count = 1
                pos = match.end()
                
                while pos < len(content_no_comments) and paren_count > 0:
                    if content_no_comments[pos] == '(':
                        paren_count += 1
                    elif content_no_comments[pos] == ')':
                        paren_count -= 1
                    pos += 1
                
                if paren_count != 0:
                    continue
                
                # ; 또는 { 까지
                while pos < len(content_no_comments) and content_no_comments[pos] not in ';{':
                    pos += 1
                
                if pos >= len(content_no_comments):
                    continue
                
                decl_end = pos + 1
                
                # **주석 제거된 content에서 선언 추출**
                declaration = content_no_comments[decl_start:decl_end].strip()
                
                # 전처리기 제외
                if declaration.startswith('#'):
                    continue
                
                # 정규화
                declaration = normalize_declaration(declaration)
                
                if verbose:
                    print(f"[DECL] {func_name} in {os.path.basename(file_path)}")
                
                return declaration
        
        except Exception as e:
            if verbose:
                print(f"[WARN] 함수 선언 검색 실패 {file_path}: {e}")
    
    return None


def save_results(fp_assignments: Dict[str, Set[str]], verbose: bool = False):
    """결과를 파일로 저장 (fpName만)"""
    os.makedirs("fpName", exist_ok=True)
    
    for fp_name, func_names in fp_assignments.items():
        if func_names:
            with open(f"fpName/{fp_name}.txt", 'w', encoding='utf-8') as f:
                for func_name in sorted(func_names):
                    f.write(f"{func_name}\n")
            
            if verbose:
                print(f"[SAVED] fpName/{fp_name}.txt: {len(func_names)}개 함수")

def save_declarations(source_dir: str, fp_assignments: Dict[str, Set[str]], verbose: bool = False):
    """함수 선언부를 파일로 저장"""
    os.makedirs("fpNameDecl", exist_ok=True)
    
    if verbose:
        print(f"\n[INFO] 함수 선언부 검색 중...")
    
    for fp_name, func_names in fp_assignments.items():
        if func_names:
            declarations = []
            
            for func_name in sorted(func_names):
                if func_name == '0':
                    continue
                
                decl = find_function_declaration(source_dir, func_name, verbose)
                if decl:
                    declarations.append(decl)
                elif verbose:
                    print(f"[WARN] {func_name}: 선언부를 찾을 수 없음")

            with open(f"fpNameDecl/{fp_name}.txt", 'w', encoding='utf-8') as f:
                if declarations:
                    for decl in declarations:
                        f.write(f"{decl}\n")
                else:
                    f.write("// 선언을 찾을 수 없음\n")
                
                if verbose:
                    print(f"[SAVED] fpNameDecl/{fp_name}.txt: {len(declarations)}개 선언")

def main():
    parser = argparse.ArgumentParser(
        description="함수 포인터 할당 추출 및 함수 선언부 검색"
    )
    parser.add_argument("--source-dir", required=True, help="소스 코드 디렉토리")
    parser.add_argument("--verbose", "-v", action="store_true", help="상세 출력")
    
    args = parser.parse_args()
    
    if not os.path.exists(args.source_dir):
        print(f"[ERROR] 소스 디렉토리를 찾을 수 없음: {args.source_dir}")
        sys.exit(1)
    
    total_start_time = time.time()
    
    print(f"[INFO] 함수 포인터 분석 시작")
    print(f"[INFO] 소스 디렉토리: {args.source_dir}")
    
    # 1단계: 구조체의 함수 포인터와 인덱스 찾기
    print(f"\n=== 1단계: 구조체 함수 포인터 검색 ===")
    step1_start = time.time()
    struct_fp_map = find_struct_with_function_pointers(args.source_dir, args.verbose)
    step1_time = time.time() - step1_start
    
    if not struct_fp_map:
        print("[INFO] 함수 포인터를 가진 구조체를 찾을 수 없음")
        sys.exit(0)
    
    all_fp_names = set()
    total_fps = 0
    for struct_name, fps in struct_fp_map.items():
        print(f"  {struct_name}: {len(fps)}개 함수 포인터")
        for _, fp_name, _, _ in fps:
            all_fp_names.add(fp_name)
            total_fps += 1
    
    print(f"[요약] {len(struct_fp_map)}개 구조체, {total_fps}개 함수 포인터 ({step1_time:.2f}초)")
    
    # 2단계: 구조체 초기화 패턴에서 할당 찾기
    print(f"\n=== 2단계: 구조체 초기화 패턴 분석 ===")
    step2_start = time.time()
    init_assignments = find_struct_initializations(args.source_dir, struct_fp_map, args.verbose)
    step2_time = time.time() - step2_start
    
    init_count = sum(len(funcs) for funcs in init_assignments.values())
    print(f"[요약] {len(init_assignments)}개 함수 포인터에 {init_count}개 함수 할당 발견 ({step2_time:.2f}초)")
    
    # 주석 해제
    # 3단계: .fpName = 패턴에서 할당 찾기
    print(f"\n=== 3단계: .fpName = 패턴 분석 ===")
    step3_start = time.time()
    named_assignments = find_named_assignments(args.source_dir, all_fp_names, args.verbose)
    step3_time = time.time() - step3_start
    
    named_count = sum(len(funcs) for funcs in named_assignments.values())
    print(f"[요약] {len(named_assignments)}개 함수 포인터에 {named_count}개 함수 할당 발견 ({step3_time:.2f}초)")
    
    # 결과 병합
    print(f"\n=== 4단계: 결과 병합 및 저장 ===")
    step4_start = time.time()
    
    all_assignments = defaultdict(set)
    for fp_name, funcs in init_assignments.items():
        all_assignments[fp_name].update(funcs)
    # 주석 해제
    for fp_name, funcs in named_assignments.items():  
        all_assignments[fp_name].update(funcs)
    
    save_results(all_assignments, args.verbose)
    step4_time = time.time() - step4_start
    
    print(f"[완료] 할당 함수 목록 저장 완료 ({step4_time:.2f}초)")
    
    # 5단계: 함수 선언부 검색 및 저장
    print(f"\n=== 5단계: 함수 선언부 검색 ===")
    step5_start = time.time()
    save_declarations(args.source_dir, all_assignments, args.verbose)
    step5_time = time.time() - step5_start
    
    print(f"[완료] 함수 선언부 저장 완료 ({step5_time:.2f}초)")
    
    total_time = time.time() - total_start_time
    
    # 최종 요약
    print(f"\n=== 분석 완료 요약 ===")
    print(f"총 소요 시간: {total_time:.2f}초")
    print(f"  1단계 (구조체 검색): {step1_time:.2f}초")
    print(f"  2단계 (초기화 분석): {step2_time:.2f}초")
    # print(f"  3단계 (.fpName 분석): {step3_time:.2f}초")
    print(f"  4단계 (결과 저장): {step4_time:.2f}초")
    print(f"  5단계 (선언부 검색): {step5_time:.2f}초")
    
    total_assignments = sum(len(funcs) for funcs in all_assignments.values())
    print(f"\n처리 결과:")
    print(f"  구조체: {len(struct_fp_map)}개")
    print(f"  함수 포인터: {total_fps}개")
    print(f"  총 함수 할당: {total_assignments}개 (중복 제거)")
    
    print(f"\n생성된 파일:")
    print(f"  fpName/: 각 함수 포인터별 할당된 함수 목록")
    print(f"  fpNameDecl/: 각 함수 포인터별 함수 선언부")

if __name__ == "__main__":
    main()