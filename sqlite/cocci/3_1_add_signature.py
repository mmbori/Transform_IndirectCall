#!/usr/bin/env python3
"""
구조체에 fp_signature 추가 (개선된 버전)
- 구조체 정의를 찾고 함수 포인터 식별
- 각 함수 포인터마다 int {fp_name}_signature[4]; 추가
- 파일별로 즉시 처리
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

def extract_function_pointer_pattern(decl: str) -> Optional[Tuple[str, bool]]:
    """선언에서 함수 포인터 패턴 추출"""
    ptr_pattern = re.search(r'\(\s*\*\s*(\w+)\s*\)', decl)
    if not ptr_pattern:
        return None
    
    fp_name = ptr_pattern.group(1)
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
    """구조체 내용에서 함수 포인터와 인덱스 찾기 - new_3_1과 동일한 로직"""
    function_pointers = []
    
    brace_start = struct_content.find('{')
    brace_end = struct_content.rfind('}')
    if brace_start == -1 or brace_end == -1:
        return function_pointers
    
    body = struct_content[brace_start+1:brace_end]
    
    # 주석 제거 (파싱용)
    body_no_comments = re.sub(r'//.*?(?=\n|$)', '', body)
    body_no_comments = re.sub(r'/\*.*?\*/', '', body_no_comments, flags=re.DOTALL)
    
    # 세미콜론으로 멤버 선언 분리
    declarations = re.split(r';', body_no_comments)
    
    # typedef 함수 포인터 패턴
    typedef_pattern = re.compile(r'(sqlite3_xauth|sqlite3_callback|sqlite3_exec_callback|fts5_extension_function)\s+(\w+)')
    
    member_index = 0
    
    for decl in declarations:
        decl = decl.strip()
        
        # 빈 선언도 인덱스를 차지하지 않음
        if not decl:
            continue
        
        # 전처리기 지시자 무시
        if decl.startswith('#'):
            continue
        
        # 중괄호만 있는 줄 무시 (내부 union/struct)
        if '{' in decl or '}' in decl:
            continue
        
        # 비트필드는 인덱스 차지함
        is_bitfield = bool(re.search(r':\s*\d+\s*$', decl))
        
        is_fp = False
        fp_name = None
        
        # 1. typedef 패턴 먼저 확인
        typedef_match = typedef_pattern.search(decl)
        if typedef_match:
            fp_name = typedef_match.group(2).strip()
            if fp_name and fp_name.isidentifier():
                is_fp = True
        else:
            # 2. 일반 함수 포인터 패턴
            result = extract_function_pointer_pattern(decl)
            if result:
                fp_name, _ = result
                if fp_name and len(fp_name) > 1 and fp_name.isidentifier():
                    is_fp = True
        
        # 함수 포인터이고 비트필드가 아닌 경우만 저장
        if is_fp and fp_name and not is_bitfield:
            function_pointers.append((fp_name, member_index))
        
        # 유효한 멤버 선언이면 인덱스 증가
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


def add_signatures_to_struct(content: str, struct_name: str, fp_list: List[Tuple[str, int]], verbose: bool = False) -> str:
    """구조체 정의 맨 아래에 int *fp_signature; 포인터 추가"""
    # 구조체 찾기
    struct_pattern = re.compile(
        rf'\b(?:struct|union)\s+{re.escape(struct_name)}\s*\{{',
        re.MULTILINE
    )
    
    match = struct_pattern.search(content)
    if not match:
        return content
    
    start_pos = match.start()
    brace_pos = match.end() - 1
    
    # 닫는 중괄호 찾기
    brace_count = 1
    pos = brace_pos + 1
    
    while pos < len(content) and brace_count > 0:
        char = content[pos]
        if char == '{':
            brace_count += 1
        elif char == '}':
            brace_count -= 1
        pos += 1
    
    if brace_count != 0:
        return content
    
    end_pos = pos
    struct_content = content[start_pos:end_pos]

    # 구조체 내 존재하는 시그니처를 전부 조사하고, "없는 것만" 추가
    existing = set()
    for fp_name, _ in fp_list:
        # 포인터 패턴으로 변경: int *fp_name_signature;
        pat = re.compile(rf'\bint\s+\*\s*{re.escape(fp_name)}_signature\s*;')
        if pat.search(struct_content):
            existing.add(fp_name)

    missing = [(fp_name, idx) for fp_name, idx in fp_list if fp_name not in existing]
    if not missing:
        if verbose:
            print(f"    [SKIP] {struct_name}: 모든 시그니처가 이미 존재")
        return content

    # 닫는 중괄호 직전 삽입 (마지막 세미콜론 뒤)
    closing_brace_pos = struct_content.rfind('}')
    last_semicolon   = struct_content.rfind(';', 0, closing_brace_pos)
    if last_semicolon == -1:
        return content

    # 포인터로 변경: int *fp_name_signature;
    signature_lines = [f"  int *{fp_name}_signature;" for fp_name, _ in missing]
    signature_text  = "\n" + "\n".join(signature_lines) + "\n"

    new_struct = struct_content[:last_semicolon+1] + signature_text + struct_content[last_semicolon+1:]

    if verbose:
        print(f"    [MODIFY] {struct_name}: 누락된 시그니처 {len(missing)}개 추가 -> "
              + ", ".join(fp for fp, _ in missing))

    return content[:start_pos] + new_struct + content[end_pos:]

def process_file(file_path: str, verbose: bool = False, dry_run: bool = False) -> bool:
    """파일별로 즉시 처리"""
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
        
        original_content = content
        
        # 이 파일에서 함수 포인터를 가진 구조체 찾기
        struct_fp_map = find_structs_with_fp(content)
        
        if not struct_fp_map:
            return False
        
        if verbose:
            print(f"\n  [FILE] {os.path.basename(file_path)}")
        
        # 각 구조체에 signature 추가
        for struct_name, fp_list in struct_fp_map.items():
            if verbose:
                print(f"    [STRUCT] {struct_name}: {len(fp_list)}개 함수 포인터")
                for fp_name, idx in fp_list:
                    print(f"      [{idx}] {fp_name}")
            
            content = add_signatures_to_struct(content, struct_name, fp_list, verbose)
        
        # 변경사항이 있으면 저장
        if content != original_content:
            if not dry_run:
                backup_path = file_path + '.bak'
                shutil.copy2(file_path, backup_path)
                
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                
                if verbose:
                    print(f"  [SAVED] 파일 수정 완료 (백업: {backup_path})")
            
            return True
        
        return False
    
    except Exception as e:
        if verbose:
            print(f"  [ERROR] {file_path}: {e}")
        return False

def main():
    parser = argparse.ArgumentParser(
        description="구조체에 fp_signature[4] 추가"
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
    print(f"[INFO] 총 {len(files_to_process)}개 파일 처리 중...")
    
    modified_count = 0
    
    for file_path in files_to_process:
        if process_file(file_path, args.verbose, args.dry_run):
            modified_count += 1
    
    print(f"\n[완료] {modified_count}개 파일 수정됨")
    
    if args.dry_run:
        print(f"[INFO] 실제 수정하려면 --dry-run 옵션을 제거하세요")
    else:
        print(f"[INFO] 백업 파일: *.bak")

if __name__ == "__main__":
    main()