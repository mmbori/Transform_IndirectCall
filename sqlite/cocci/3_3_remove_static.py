#!/usr/bin/env python3
"""
fpName 디렉토리의 함수들의 선언부/정의부에서 static 제거
- x로 시작하는 함수명은 무시
- 함수 선언 및 정의 모두 처리
"""

import argparse
import os
import re
import sys
import glob
import shutil
from typing import Set, List, Tuple, Optional

def load_function_names(fpname_dir: str, verbose: bool = False) -> Set[str]:
    """fpName 디렉토리에서 모든 함수명 로드 (x로 시작하는 것 제외)"""
    func_names = set()
    
    if not os.path.exists(fpname_dir):
        print(f"[ERROR] {fpname_dir} 디렉토리가 없습니다")
        return func_names
    
    txt_files = glob.glob(os.path.join(fpname_dir, "*.txt"))
    
    for txt_file in txt_files:
        try:
            with open(txt_file, 'r', encoding='utf-8') as f:
                for line in f:
                    func_name = line.strip()
                    # x로 시작하는 함수는 제외
                    if func_name and not func_name.startswith('x') and func_name != '0':
                        func_names.add(func_name)
        except Exception as e:
            if verbose:
                print(f"[WARN] 파일 읽기 실패 {txt_file}: {e}")
    
    return func_names

def remove_static_simple(content: str, func_names: Set[str], verbose: bool = False) -> Tuple[str, int]:
    """
    간단한 패턴 매칭으로 static 제거
    - 함수 선언: ; 로 끝남
    - 함수 정의: { 로 시작
    """
    modified_content = content
    removal_count = 0
    
    for func_name in func_names:
        # 패턴: static ... func_name(...) 다음에 ; 또는 {
        # 여러 줄에 걸쳐 있을 수 있으므로 DOTALL 사용
        pattern = re.compile(
            rf'(\bstatic\s+)([^;{{]*?\b{re.escape(func_name)}\s*\([^)]*\)\s*(?:[^;{{]*?))([;{{])',
            re.DOTALL | re.MULTILINE
        )
        
        matches = list(pattern.finditer(modified_content))
        
        # 뒤에서부터 처리 (인덱스 변화 방지)
        for match in reversed(matches):
            # static 제거 (그룹 1)
            before_static = modified_content[:match.start(1)]
            after_static = modified_content[match.start(2):]
            
            modified_content = before_static + after_static
            removal_count += 1
            
            if verbose:
                end_char = match.group(3)
                decl_type = "선언" if end_char == ';' else "정의"
                print(f"    [REMOVE] static 제거 ({decl_type}): {func_name}")
    
    return modified_content, removal_count

def process_file(file_path: str, func_names: Set[str], verbose: bool = False, dry_run: bool = False) -> Tuple[bool, int]:
    """파일 처리"""
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
        
        original_content = content
        
        # static 제거
        modified_content, removal_count = remove_static_simple(content, func_names, verbose)
        
        if modified_content != original_content:
            if not dry_run:
                # 백업
                backup_path = file_path + '.bak'
                if not os.path.exists(backup_path):  # 이미 백업이 있으면 덮어쓰지 않음
                    shutil.copy2(file_path, backup_path)
                
                # 저장
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(modified_content)
                
                if verbose:
                    print(f"  [SAVED] {os.path.basename(file_path)}: {removal_count}개 수정")
            
            return True, removal_count
        
        return False, 0
    
    except Exception as e:
        if verbose:
            print(f"  [ERROR] {file_path}: {e}")
        return False, 0

def main():
    parser = argparse.ArgumentParser(
        description="함수 선언/정의에서 static 제거 (x로 시작하는 함수 제외)"
    )
    parser.add_argument("--source-dir", required=True, help="소스 코드 디렉토리")
    parser.add_argument("--fpname-dir", default="fpName", help="fpName 디렉토리 경로")
    parser.add_argument("--verbose", "-v", action="store_true", help="상세 출력")
    parser.add_argument("--dry-run", "-d", action="store_true", help="실제 수정 없이 미리보기")
    
    args = parser.parse_args()
    
    if not os.path.exists(args.source_dir):
        print(f"[ERROR] 소스 디렉토리를 찾을 수 없음: {args.source_dir}")
        sys.exit(1)
    
    print(f"[INFO] 소스 디렉토리: {args.source_dir}")
    print(f"[INFO] fpName 디렉토리: {args.fpname_dir}")
    
    if args.dry_run:
        print(f"[INFO] DRY-RUN 모드: 실제 파일은 수정되지 않습니다")
    
    # 1단계: 함수명 로드
    print(f"\n=== 1단계: 함수명 로드 ===")
    func_names = load_function_names(args.fpname_dir, args.verbose)
    
    if not func_names:
        print("[INFO] 처리할 함수가 없습니다")
        sys.exit(0)
    
    print(f"[INFO] {len(func_names)}개 함수 발견 (x로 시작하는 함수 제외)")
    if args.verbose:
        for func_name in sorted(list(func_names)[:10]):  # 처음 10개만 출력
            print(f"  - {func_name}")
        if len(func_names) > 10:
            print(f"  ... 외 {len(func_names) - 10}개")
    
    # 2단계: 파일 검색
    print(f"\n=== 2단계: 파일 처리 ===")
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
    total_removals = 0
    
    for file_path in files_to_process:
        modified, removals = process_file(file_path, func_names, args.verbose, args.dry_run)
        if modified:
            modified_count += 1
            total_removals += removals
    
    # 완료
    print(f"\n[완료] {modified_count}개 파일에서 총 {total_removals}개 static 제거")
    
    if args.dry_run:
        print(f"[INFO] 실제 수정하려면 --dry-run 옵션을 제거하세요")
    else:
        print(f"[INFO] 백업 파일: *.bak")

if __name__ == "__main__":
    main()