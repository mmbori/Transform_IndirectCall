#!/usr/bin/env python3
"""
구조체 초기화에 SIGNATURE_INIT 매크로 추가
- 구조체와 내부 함수 포인터 식별
- 구조체 초기화 부분 검색
- 각 함수 포인터에 대응되는 함수를 찾아 SIGNATURE_INIT 매크로 추가
"""

import argparse
import os
import re
import sys
from typing import Dict, List, Set, Tuple, Optional
import glob
import shutil
from collections import defaultdict

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
    """선언에서 함수 포인터 패턴 추출"""
    ptr_pattern = re.search(r'\(\s*\*\s*(\w+)\s*\)', decl)
    if not ptr_pattern:
        return None
    
    fp_name = ptr_pattern.group(1)
    
    # (*name) 이후 공백 건너뛰기
    start_pos = ptr_pattern.end()
    while start_pos < len(decl) and decl[start_pos].isspace():
        start_pos += 1
    
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
    
    return (fp_name, True)

def find_function_pointers_with_index(struct_content: str) -> List[Tuple[str, int]]:
    """구조체 내용에서 함수 포인터와 인덱스 찾기"""
    function_pointers = []
    
    brace_start = struct_content.find('{')
    brace_end = struct_content.rfind('}')
    if brace_start == -1 or brace_end == -1:
        return function_pointers
    
    body = struct_content[brace_start+1:brace_end]
    
    # 주석 제거
    body = re.sub(r'//.*?(?=\n|$)', '', body)
    body = re.sub(r'/\*.*?\*/', '', body, flags=re.DOTALL)
    
    # 세미콜론으로 멤버 선언 분리
    declarations = re.split(r';', body)
    
    # typedef 함수 포인터 패턴
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
        
        # typedef 패턴 먼저 확인
        typedef_match = typedef_pattern.search(decl)
        if typedef_match:
            fp_name = typedef_match.group(2)
            if fp_name and fp_name.isidentifier():
                function_pointers.append((fp_name, member_index))
        else:
            # 일반 함수 포인터 패턴
            result = extract_function_pointer_pattern(decl)
            if result:
                fp_name, _ = result
                if fp_name and len(fp_name) > 1 and fp_name.isidentifier():
                    function_pointers.append((fp_name, member_index))
        
        member_index += 1
    
    return function_pointers

def find_structs_with_fp(content: str) -> Dict[str, List[Tuple[str, int]]]:
    """파일 내용에서 함수 포인터를 가진 구조체 찾기"""
    struct_fp_map = {}
    
    boundaries = find_struct_boundaries_in_original(content)
    
    for start_pos, end_pos in boundaries:
        struct_content = content[start_pos:end_pos]
        
        struct_name = extract_struct_name(struct_content)
        if not struct_name:
            continue
        
        function_pointers = find_function_pointers_with_index(struct_content)
        
        if function_pointers:
            if struct_name not in struct_fp_map:
                struct_fp_map[struct_name] = []
            
            existing_fp_names = {fp[0] for fp in struct_fp_map[struct_name]}
            new_fps = [fp for fp in function_pointers if fp[0] not in existing_fp_names]
            
            if new_fps:
                struct_fp_map[struct_name].extend(new_fps)
    
    return struct_fp_map

def find_matching_brace(content: str, start_pos: int) -> int:
    """시작 위치의 { 에 매칭되는 } 찾기
    
    Args:
        content: 전체 문자열
        start_pos: '{' 문자의 위치
    
    Returns:
        매칭되는 '}' 다음 위치, 실패시 -1
    """
    if start_pos >= len(content) or content[start_pos] != '{':
        return -1
    
    depth = 1
    pos = start_pos + 1
    
    while pos < len(content) and depth > 0:
        if content[pos] == '{':
            depth += 1
        elif content[pos] == '}':
            depth -= 1
        pos += 1
    
    return pos if depth == 0 else -1


def modify_struct_initialization(content: str, struct_name: str, fp_list: List[Tuple[str, int]], verbose: bool = False) -> str:
    """구조체 초기화 부분에 SIGNATURE_INIT 매크로 추가"""
    fp_index_map = {idx: fp_name for fp_name, idx in fp_list}
    
    # 초기화 패턴 찾기
    init_start_pattern = re.compile(
        rf'(?:(?:const|static|extern)\s+)*(?:struct\s+)?{re.escape(struct_name)}\s+(\w+)\s*=\s*\{{',
        re.MULTILINE
    )
    
    modified_content = content
    offset = 0
    
    for match in init_start_pattern.finditer(content):
        var_name = match.group(1)
        init_start = match.start() + offset
        brace_start = match.end() - 1 + offset
        
        # 매칭되는 닫는 중괄호 찾기
        brace_end = find_matching_brace(modified_content[offset:], brace_start - offset)
        if brace_end == -1:
            continue
        
        brace_end += offset
        
        # 세미콜론까지 찾기
        semicolon_pos = modified_content.find(';', brace_end)
        if semicolon_pos == -1 or semicolon_pos - brace_end > 10:
            continue
        
        init_end = semicolon_pos + 1
        init_body = modified_content[brace_start+1:brace_end-1]
        
        # 주석 제거된 버전으로 파싱
        init_body_clean = re.sub(r'//.*?(?=\n|$)', ' ', init_body)
        init_body_clean = re.sub(r'/\*.*?\*/', ' ', init_body_clean, flags=re.DOTALL)
        
        # **핵심: 초기화 값들을 콤마로 분리하여 인덱스별로 파싱**
        values = []
        depth = 0
        current_value = []
        
        for char in init_body_clean:
            if char in '({[':
                depth += 1
                current_value.append(char)
            elif char in ')}]':
                depth -= 1
                current_value.append(char)
            elif char == ',' and depth == 0:
                val = ''.join(current_value).strip()
                values.append(val)  # 빈 값도 포함 (인덱스 유지)
                current_value = []
            else:
                current_value.append(char)
        
        val = ''.join(current_value).strip()
        values.append(val)
        
        # **함수 포인터 인덱스에 해당하는 실제 함수 이름 추출**
        fp_assignments = {}
        
        for idx, value in enumerate(values):
            if idx in fp_index_map:
                fp_name = fp_index_map[idx]
                
                # 값에서 함수 이름 추출
                value_clean = value.strip()
                
                # /* comment */ 제거
                value_clean = re.sub(r'/\*.*?\*/', '', value_clean).strip()
                
                # 함수 이름 추출 (& 제거, 식별자만)
                func_match = re.match(r'^\s*&?(\w+)\s*$', value_clean)
                if func_match:
                    func_name = func_match.group(1)
                    
                    # # 0이 아닌 유효한 함수만
                    # if func_name != '0' and func_name.isidentifier():
                    #     fp_assignments[fp_name] = func_name
        
        if not fp_assignments:
            if verbose:
                print(f"    [SKIP] {var_name}: 유효한 함수 포인터 할당 없음")
            continue
        
        # SIGNATURE_INIT 라인 생성 (fp_list 순서대로)
        signature_lines = []
        for fp_name, _ in sorted(fp_list, key=lambda x: x[1]):  # 인덱스 순서대로
            if fp_name in fp_assignments:
                func_name = fp_assignments[fp_name]
                signature_lines.append(f"  .{fp_name}_signature = {fp_name}_signatures[{fp_name}_{func_name}_enum]")
        
        if not signature_lines:
            continue
        
        # 닫는 중괄호 앞에 삽입
        before_brace = init_body.rstrip()
        
        # 마지막에 콤마가 있는지 확인
        if not before_brace.endswith(','):
            signature_text = ",\n" + ",\n".join(signature_lines) + "\n"
        else:
            signature_text = "\n" + ",\n".join(signature_lines) + "\n"
        
        new_init = modified_content[init_start:brace_end-1] + signature_text + modified_content[brace_end-1:init_end]
        
        # 교체
        modified_content = modified_content[:init_start] + new_init + modified_content[init_end:]
        offset += len(new_init) - (init_end - init_start)
        
        if verbose:
            print(f"    [MODIFY] {var_name}: {len(signature_lines)}개 SIGNATURE_INIT 추가")
            for fp_name, func_name in fp_assignments.items():
                print(f"      {fp_name} = {func_name}")
    
    return modified_content



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


def process_file(file_path: str, verbose: bool = False, dry_run: bool = False) -> bool:
    """파일 처리"""
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
        
        original_content = content
        modified = False
        
        # 구조체와 함수 포인터 찾기
        struct_fp_map = find_structs_with_fp(content)
        
        if not struct_fp_map:
            return False
        
        if verbose:
            print(f"\n  [FILE] {os.path.basename(file_path)}")
        
        # 각 구조체 처리
        for struct_name, fp_list in struct_fp_map.items():
            if verbose:
                print(f"    [STRUCT] {struct_name}: {len(fp_list)}개 함수 포인터")
            
            # 초기화 수정
            content = modify_struct_initialization(content, struct_name, fp_list, verbose)
        
        if content != original_content:
            modified = True
            
            if not dry_run:
                # 백업
                backup_path = file_path + '.bak'
                shutil.copy2(file_path, backup_path)
                
                # 저장
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                
                if verbose:
                    print(f"  [SAVED] 파일 수정 완료 (백업: {backup_path})")
        
        return modified
    
    except Exception as e:
        if verbose:
            print(f"  [ERROR] {file_path}: {e}")
        return False


def process_file_with_global_map(file_path: str, global_struct_fp_map: Dict[str, List[Tuple[str, int]]], verbose: bool = False, dry_run: bool = False) -> bool:
    """전역 구조체 맵을 사용해 파일 처리"""
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
        
        original_content = content
        modified = False
        
        if verbose:
            print(f"\n  [FILE] {os.path.basename(file_path)}")
        
        # 전역 구조체 맵의 모든 구조체에 대해 초기화 수정 시도
        for struct_name, fp_list in global_struct_fp_map.items():
            content = modify_struct_initialization(content, struct_name, fp_list, verbose)
        
        if content != original_content:
            modified = True
            
            if not dry_run:
                # 백업
                backup_path = file_path + '.bak'
                shutil.copy2(file_path, backup_path)
                
                # 저장
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                
                if verbose:
                    print(f"  [SAVED] 파일 수정 완료 (백업: {backup_path})")
        
        return modified
    
    except Exception as e:
        if verbose:
            print(f"  [ERROR] {file_path}: {e}")
        return False


def main():
    parser = argparse.ArgumentParser(
        description="구조체 초기화에 SIGNATURE_INIT 매크로 추가"
    )
    parser.add_argument("--source-dir", required=True, help="소스 코드 디렉토리")
    parser.add_argument("--verbose", "-v", action="store_true", help="상세 출력")
    parser.add_argument("--dry-run", "-d", action="store_true", help="실제 수정 없이 미리보기")
    
    args = parser.parse_args()
    
    if not os.path.exists(args.source_dir):
        print(f"[ERROR] 소스 디렉토리를 찾을 수 없음: {args.source_dir}")
        sys.exit(1)
    
    print(f"[INFO] 소스 디렉토리: {args.source_dir}")
    
    if args.dry_run:
        print(f"[INFO] DRY-RUN 모드: 실제 파일은 수정되지 않습니다")
    
    # 파일 검색
    file_patterns = [
        os.path.join(args.source_dir, "src/*.c"),
        os.path.join(args.source_dir, "src/*.h"),
        os.path.join(args.source_dir, "src/*.in"),
        os.path.join(args.source_dir, "ext/**/*.c"),
        os.path.join(args.source_dir, "ext/**/*.h"),
        os.path.join(args.source_dir, "ext/**/*.in")
    ]
    
    files_to_process = set()
    for pattern in file_patterns:
        files_to_process.update(glob.glob(pattern, recursive=True))
    
    files_to_process = list(files_to_process)
    print(f"[INFO] 총 {len(files_to_process)}개 파일 발견")
    
    # ===== 1단계: 모든 파일에서 구조체와 함수 포인터 정보 수집 =====
    print(f"\n[1단계] 구조체 정보 수집 중...")
    global_struct_fp_map = {}
    
    for file_path in files_to_process:
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            # 이 파일에서 구조체 찾기
            struct_fp_map = find_structs_with_fp(content)
            
            # 전역 맵에 병합
            for struct_name, fp_list in struct_fp_map.items():
                if struct_name not in global_struct_fp_map:
                    global_struct_fp_map[struct_name] = []
                
                # 중복 제거하면서 병합
                existing_fp_names = {fp[0] for fp in global_struct_fp_map[struct_name]}
                new_fps = [fp for fp in fp_list if fp[0] not in existing_fp_names]
                
                if new_fps:
                    global_struct_fp_map[struct_name].extend(new_fps)
                    
        except Exception as e:
            if args.verbose:
                print(f"  [WARN] {file_path}: {e}")
            continue
    
    if not global_struct_fp_map:
        print("[INFO] 함수 포인터를 가진 구조체를 찾을 수 없음")
        sys.exit(0)
    
    print(f"[INFO] {len(global_struct_fp_map)}개 구조체 발견:")
    for struct_name, fp_list in global_struct_fp_map.items():
        print(f"  - {struct_name}: {len(fp_list)}개 함수 포인터")
        if args.verbose:
            for fp_name, idx in fp_list:
                print(f"      [{idx}] {fp_name}")
    
    # ===== 2단계: 각 파일에서 초기화 수정 =====
    print(f"\n[2단계] 구조체 초기화 수정 중...")
    modified_count = 0
    
    for file_path in files_to_process:
        if process_file_with_global_map(file_path, global_struct_fp_map, args.verbose, args.dry_run):
            modified_count += 1
    
    # ===== 완료 =====
    print(f"\n[완료] {modified_count}개 파일 수정됨")
    
    if args.dry_run:
        print(f"[INFO] 실제 수정하려면 --dry-run 옵션을 제거하세요")
    else:
        print(f"[INFO] 백업 파일: *.bak")


if __name__ == "__main__":
    main()