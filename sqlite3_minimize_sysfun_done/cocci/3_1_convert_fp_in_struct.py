#!/usr/bin/env python3
"""
수정된 함수 포인터 변환기 - 정확한 함수 포인터만 감지
"""

import os
import re
import glob
from pathlib import Path
from typing import List, Tuple, Set

class FixedFunctionPointerReplacer:
    def __init__(self, backup=True, verbose=False):
        self.backup = backup
        self.verbose = verbose
        self.stats = {
            'files_processed': 0,
            'files_modified': 0,
            'total_replacements': 0,
            'excluded_fps': 0
        }
        
        # C/C++ 파일 확장자
        self.c_extensions = {'.c', '.h', '.in'}
        
        # 제외할 함수 포인터 목록
        self.non_convert_list = set()
        self.load_non_convert_list()
    
    def load_non_convert_list(self):
        """fpNameDecl 디렉토리에서 제외할 함수 포인터 로드"""
        if not os.path.exists("fpNameDecl"):
            if self.verbose:
                print("[INFO] fpNameDecl 디렉토리가 없습니다.")
            return
        
        decl_files = glob.glob("fpNameDecl/*.txt")
        if not decl_files:
            if self.verbose:
                print("[INFO] fpNameDecl에 파일이 없습니다.")
            return
        
        print(f"[INFO] fpNameDecl에서 {len(decl_files)}개 파일 검사 중...")
        
        missing_pattern = re.compile(r'// 선언을 찾을 수 없음:\s*(\w+)')
        
        for decl_file in decl_files:
            fp_name = os.path.splitext(os.path.basename(decl_file))[0]
            
            try:
                with open(decl_file, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                missing_functions = missing_pattern.findall(content)
                if missing_functions:
                    self.non_convert_list.add(fp_name)
                    if self.verbose:
                        print(f"[EXCLUDE] {fp_name}: {len(missing_functions)}개 함수의 선언 누락")
                
            except Exception as e:
                if self.verbose:
                    print(f"[WARN] 파일 읽기 실패 {decl_file}: {e}")
        
        if self.non_convert_list:
            print(f"[INFO] {len(self.non_convert_list)}개 함수 포인터가 변환에서 제외됩니다.")
        else:
            print("[INFO] 모든 함수 포인터가 변환 대상입니다.")
    
    def find_c_files(self, directory):
        """C/H 파일 찾기"""
        c_files = []
        try:
            directory = Path(directory)
            for ext in self.c_extensions:
                files = list(directory.rglob(f'*{ext}'))
                c_files.extend([str(f) for f in files if f.is_file()])
        except Exception as e:
            print(f"디렉토리 스캔 오류: {e}")
            return []
        
        return sorted(c_files)
    
    def find_struct_boundaries_in_original(self, content):
        """원본 파일에서 직접 구조체 경계 찾기"""
        boundaries = []
        
        # struct와 union 패턴
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
    
    def is_inside_struct(self, position, boundaries):
        """위치가 구조체/union 내부인지 확인"""
        for start, end in boundaries:
            if start <= position < end:
                return True
        return False
    
    def find_function_pointers_direct(self, content):
        """
        원본 파일에서 직접 함수 포인터 찾기 - 정확한 패턴만 사용
        """
        if self.verbose:
            print(f"    [DEBUG] 원본에서 직접 함수 포인터 검색")
        
        # 1. 원본에서 구조체 경계 찾기
        boundaries = self.find_struct_boundaries_in_original(content)
        
        if not boundaries:
            if self.verbose:
                print("    구조체/union 경계를 찾을 수 없습니다.")
            return []
        
        if self.verbose:
            print(f"    발견된 구조체 경계: {len(boundaries)}개")
        
        found_pointers = []
        
        fp_pattern1 = r'(\s*)((?:(?:const\s+|volatile\s+|static\s+|extern\s+)*(?:unsigned\s+|signed\s+)*(?:struct\s+|union\s+|enum\s+)*[a-zA-Z_]\w*(?:\s*\*)*(?:\s+[a-zA-Z_]\w*)*\s*\**\s*)|void\s*\**\s*)\s*\(\s*\*\s*([a-zA-Z_]\w*)\s*\)\s*\([^){}]*\)\s*;'
        pattern1 = re.compile(fp_pattern1, re.MULTILINE | re.DOTALL)
        
        for match in pattern1.finditer(content):
            indent = match.group(1) if match.group(1) else ''
            return_type = match.group(2).strip()
            fp_name = match.group(3)
            start_pos = match.start()
            end_pos = match.end()
            full_match = match.group(0)
            
            # 구조체 내부인지 확인
            if self.is_inside_struct(start_pos, boundaries):
                # 함수 포인터 패턴 검증 - (* 와 )( 가 모두 있어야 함
                if '(*' in full_match and ')(' in full_match:
                    # 추가 검증: 일반 변수가 아닌지 확인
                    # 함수 포인터는 반드시 괄호가 있어야 함
                    if not re.search(r'\w+\s+' + re.escape(fp_name) + r'\s*;', full_match):
                        found_pointers.append((full_match, fp_name, start_pos, end_pos, indent))
                        
                        if self.verbose:
                            print(f"      발견 (패턴1): {fp_name} ({return_type}) at {start_pos}")
        
        # 패턴 2: 더 간단한 void 함수 포인터 (중복 방지를 위해 별도 처리)
        fp_pattern2 = r'(\s*)(void)\s*\(\s*\*\s*([a-zA-Z_]\w*)\s*\)\s*\([^){}]*\)\s*;'
        pattern2 = re.compile(fp_pattern2, re.MULTILINE)
        
        for match in pattern2.finditer(content):
            indent = match.group(1) if match.group(1) else ''
            return_type = match.group(2)
            fp_name = match.group(3)
            start_pos = match.start()
            end_pos = match.end()
            full_match = match.group(0)
            
            if self.is_inside_struct(start_pos, boundaries):
                if '(*' in full_match and ')(' in full_match:
                    # 중복 체크 (패턴1에서 이미 잡혔는지)
                    already_found = any(fp_name == existing[1] and abs(start_pos - existing[2]) < 10 
                                      for existing in found_pointers)
                    if not already_found:
                        found_pointers.append((full_match, fp_name, start_pos, end_pos, indent))
                        
                        if self.verbose:
                            print(f"      발견 (패턴2): {fp_name} ({return_type}) at {start_pos}")
        
        # 패턴 3: typedef 함수 포인터 (sqlite3_callback 등) - 매우 제한적으로
        typedef_pattern = r'(\s*)(sqlite3_\w+)\s+([a-zA-Z_]\w*)\s*;'
        typedef_re = re.compile(typedef_pattern, re.MULTILINE)
        
        for match in typedef_re.finditer(content):
            indent = match.group(1) if match.group(1) else ''
            fp_type = match.group(2)
            fp_name = match.group(3)
            start_pos = match.start()
            end_pos = match.end()
            full_match = match.group(0)
            
            # sqlite3로 시작하는 callback 타입만 허용
            if self.is_inside_struct(start_pos, boundaries) and 'callback' in fp_type.lower():
                found_pointers.append((full_match, fp_name, start_pos, end_pos, indent))
                
                if self.verbose:
                    print(f"      발견 (typedef): {fp_name} ({fp_type}) at {start_pos}")
        
        # 4. 중복 제거 (이름과 위치 기준으로 더 정확하게)
        unique_pointers = {}
        for match_info in found_pointers:
            full_match, fp_name, start_pos, end_pos, indent = match_info
            key = f"{fp_name}_{start_pos}"
            if key not in unique_pointers:
                unique_pointers[key] = match_info
        
        result = list(unique_pointers.values())
        result.sort(key=lambda x: x[2])  # 위치순 정렬
        
        if self.verbose:
            print(f"    최종 발견: {len(result)}개 함수 포인터")
            for _, fp_name, start_pos, _, _ in result:
                print(f"      - {fp_name} (at {start_pos})")
        
        return result
    
    def create_backup(self, file_path):
        """백업 파일 생성"""
        backup_path = f"{file_path}.backup"
        counter = 1
        while os.path.exists(backup_path):
            backup_path = f"{file_path}.backup.{counter}"
            counter += 1
        
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as src:
                with open(backup_path, 'w', encoding='utf-8') as dst:
                    dst.write(src.read())
            return backup_path
        except Exception as e:
            print(f"백업 생성 실패: {e}")
            return None
    
    def find_struct_end_positions(self, content, boundaries, valid_pointers):
        """각 구조체의 끝 위치를 찾고, 해당 구조체에 속한 함수 포인터들을 그룹화"""
        struct_groups = {}
        
        for boundary_start, boundary_end in boundaries:
            # 이 구조체에 속한 함수 포인터들 찾기
            struct_fps = []
            for fp_info in valid_pointers:
                _, fp_name, fp_start, _, indent = fp_info
                if boundary_start <= fp_start < boundary_end:
                    struct_fps.append((fp_name, indent))
            
            if struct_fps:
                # 구조체 끝 위치를 더 안전하게 찾기
                struct_end = boundary_end - 1  # '}' 위치
                
                # '}' 이전 줄바꿈 찾기
                insert_pos = struct_end
                while insert_pos > boundary_start and content[insert_pos-1] != '\n':
                    insert_pos -= 1
                
                # 안전성 체크
                if boundary_start < insert_pos < boundary_end:
                    # 기본 들여쓰기 설정
                    base_indent = "  "
                    if struct_fps and len(struct_fps[0]) > 1:
                        first_indent = struct_fps[0][1]
                        if first_indent and isinstance(first_indent, str):
                            base_indent = first_indent
                    
                    struct_groups[insert_pos] = (struct_fps, base_indent)
                elif self.verbose:
                    print(f"    경고: 구조체 {boundary_start}-{boundary_end}의 안전한 삽입 위치를 찾을 수 없음")
        
        return struct_groups

    def process_file(self, file_path):
        """개별 파일 처리 - 기존 선언 유지하고 구조체 끝에 signature 배열들 추가"""
        try:
            # 파일 크기 체크
            file_size = os.path.getsize(file_path)
            if file_size > 10 * 1024 * 1024:  # 10MB 이상
                if self.verbose:
                    print(f"  대용량 파일 건너뜀: {file_path}")
                return {'modified': False, 'count': 0, 'skipped': True}
            
            # 파일 읽기
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            # 구조체 경계와 함수 포인터 찾기
            boundaries = self.find_struct_boundaries_in_original(content)
            function_pointers = self.find_function_pointers_direct(content)
            
            if not function_pointers:
                if self.verbose:
                    print(f"  {os.path.basename(file_path)}: 함수 포인터 없음")
                return {'modified': False, 'count': 0}
            
            # 제외 목록 필터링
            valid_pointers = []
            excluded_count = 0
            
            for fp_info in function_pointers:
                fp_name = fp_info[1]
                if fp_name in self.non_convert_list:
                    excluded_count += 1
                    self.stats['excluded_fps'] += 1
                    if self.verbose:
                        print(f"    [SKIP] {fp_name}: 제외 목록")
                else:
                    valid_pointers.append(fp_info)
            
            if not valid_pointers:
                if self.verbose:
                    print(f"  {os.path.basename(file_path)}: 모든 함수 포인터가 제외됨")
                return {'modified': False, 'count': 0}
            
            print(f"  {os.path.basename(file_path)}: {len(valid_pointers)}개 함수 포인터 발견! (제외: {excluded_count}개)")
            
            if self.verbose:
                print("    변환 대상:")
                for _, fp_name, _, _, _ in valid_pointers:
                    print(f"      - {fp_name}")
            
            # 백업 생성
            if self.backup:
                backup_path = self.create_backup(file_path)
                if not backup_path:
                    return {'modified': False, 'count': 0, 'error': 'backup failed'}
            
            # 구조체별로 함수 포인터 그룹화
            struct_groups = self.find_struct_end_positions(content, boundaries, valid_pointers)
            
            if not struct_groups:
                if self.verbose:
                    print(f"  {os.path.basename(file_path)}: 구조체 끝 위치를 찾을 수 없음")
                return {'modified': False, 'count': 0}
            
            # 뒤에서부터 삽입 (위치 변화 방지)
            modified_content = content
            total_insertions = 0
            
            # 삽입 위치를 역순으로 정렬
            for insert_pos in sorted(struct_groups.keys(), reverse=True):
                fps_in_struct, base_indent = struct_groups[insert_pos]
                
                # 구조체 끝에 삽입할 내용 생성
                signature_lines = []
                signature_lines.append(f"{base_indent}/* Function pointer signature arrays */")
                
                for fp_name, indent in fps_in_struct:
                    signature_lines.append(f"{base_indent}int {fp_name}_signature[4];")
                
                signature_block = "\n".join(signature_lines) + "\n";
                
                # 안전성 체크
                if 0 <= insert_pos <= len(modified_content):
                    # 구조체 끝에 삽입
                    modified_content = modified_content[:insert_pos] + signature_block + modified_content[insert_pos:]
                    total_insertions += len(fps_in_struct)
                    
                    if self.verbose:
                        print(f"    구조체 끝에 {len(fps_in_struct)}개 signature 배열 추가:")
                        for fp_name, _ in fps_in_struct:
                            print(f"      + int {fp_name}_signature[4];")
                else:
                    if self.verbose:
                        print(f"    경고: 삽입 위치 {insert_pos}가 유효하지 않음")
            
            if total_insertions == 0:
                if self.verbose:
                    print(f"  {os.path.basename(file_path)}: 삽입된 signature 배열이 없음")
                return {'modified': False, 'count': 0}
            
            # 파일 저장 전 최종 검증
            if len(modified_content) < len(content):
                if self.verbose:
                    print(f"  경고: 수정된 내용이 원본보다 짧습니다.")
                return {'modified': False, 'count': 0, 'error': 'content validation failed'}
            
            # 파일 저장
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(modified_content)
            
            return {'modified': True, 'count': total_insertions}
            
        except Exception as e:
            if self.verbose:
                print(f"  오류 - {file_path}: {e}")
            return {'modified': False, 'count': 0, 'error': str(e)}
    
    def process_directory(self, directory):
        """디렉토리 처리"""
        if os.path.isfile(directory):
            # 단일 파일 처리
            print(f"단일 파일 처리: {directory}")
            self.stats['files_processed'] += 1
            result = self.process_file(directory)
            
            if result['modified']:
                self.stats['files_modified'] += 1
                self.stats['total_replacements'] += result['count']
                print(f"✓ {os.path.basename(directory)}: {result['count']}개 signature 배열 추가 완료!")
            elif 'error' in result:
                print(f"✗ {os.path.basename(directory)}: {result['error']}")
            else:
                print(f"- {os.path.basename(directory)}: 변경사항 없음")
            return
        
        print(f"디렉토리 스캔 중: {directory}")
        
        c_files = self.find_c_files(directory)
        print(f"발견된 C/H 파일: {len(c_files)}개")
        
        if not c_files:
            print("처리할 파일이 없습니다.")
            return
        
        print("\n처리 시작...")
        print("=" * 60)
        
        processed = 0
        for file_path in c_files:
            processed += 1
            if processed % 50 == 0:
                print(f"진행상황: {processed}/{len(c_files)}")
            
            self.stats['files_processed'] += 1
            result = self.process_file(file_path)
            
            if result['modified']:
                self.stats['files_modified'] += 1
                self.stats['total_replacements'] += result['count']
                print(f"✓ {os.path.basename(file_path)}: {result['count']}개 signature 배열 추가 완료!")
            elif 'error' in result and self.verbose:
                print(f"✗ {os.path.basename(file_path)}: {result['error']}")
            elif result.get('skipped') and self.verbose:
                print(f"- {os.path.basename(file_path)}: 건너뜀")
        
        # 최종 통계
        print("\n" + "=" * 60)
        print("처리 완료:")
        print(f"  처리된 파일: {self.stats['files_processed']}개")
        print(f"  수정된 파일: {self.stats['files_modified']}개")
        print(f"  추가된 signature 배열: {self.stats['total_replacements']}개")
        print(f"  제외된 함수 포인터: {self.stats['excluded_fps']}개")
        
        if self.stats['total_replacements'] > 0:
            print(f"\n성공! 이 {self.stats['total_replacements']}개의 signature 배열이 추가되었습니다!")
            print("기존 함수 포인터 선언은 유지되고, 그 아래에 signature 배열이 추가되었습니다.")
    
    def test_single_file(self, file_path):
        """단일 파일 테스트용 메서드"""
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            print(f"파일 크기: {len(content)} 문자")
            
            # 구조체 경계 찾기
            boundaries = self.find_struct_boundaries_in_original(content)
            print(f"발견된 구조체: {len(boundaries)}개")
            
            # 함수 포인터 찾기
            function_pointers = self.find_function_pointers_direct(content)
            print(f"발견된 함수 포인터: {len(function_pointers)}개")
            
            if function_pointers:
                print("\n발견된 함수 포인터들:")
                for i, (_, fp_name, start_pos, _, _) in enumerate(function_pointers, 1):
                    print(f"  {i:2d}. {fp_name}")
            
            return function_pointers
            
        except Exception as e:
            print(f"오류: {e}")
            return []
    
    def preview_changes(self, directory):
        """변경사항 미리보기"""
        print(f"변경사항 미리보기: {directory}")
        print(f"제외할 함수 포인터: {len(self.non_convert_list)}개")
        
        if os.path.isfile(directory):
            # 단일 파일 처리
            print(f"\n단일 파일 분석: {directory}")
            self.test_single_file(directory)
            return
        
        c_files = self.find_c_files(directory)
        if len(c_files) > 10:
            print(f"파일이 많습니다 ({len(c_files)}개). 처음 10개만 미리보기합니다.")
            c_files = c_files[:10]
        
        total_fps = 0
        excluded_fps = 0
        files_with_fps = 0
        
        for i, file_path in enumerate(c_files):
            print(f"\n[{i+1}/{len(c_files)}] {os.path.basename(file_path)}")
            
            try:
                if os.path.getsize(file_path) > 5 * 1024 * 1024:
                    print("  파일이 너무 큽니다. 건너뜀.")
                    continue
                
                fps = self.test_single_file(file_path)
                
                if fps:
                    files_with_fps += 1
                    convert_count = 0
                    exclude_count = 0
                    
                    for _, fp_name, _, _, _ in fps:
                        if fp_name in self.non_convert_list:
                            exclude_count += 1
                            excluded_fps += 1
                            print(f"     [EXCLUDE] {fp_name}")
                        else:
                            convert_count += 1
                            total_fps += 1
                            print(f"     [ADD] {fp_name} -> int {fp_name}_signature[4];")
                    
                    print(f"   추가될 signature: {convert_count}개, 제외: {exclude_count}개")
            
            except Exception as e:
                print(f"  오류: {e}")
                continue
        
        print(f"\n=== 요약 ===")
        print(f"추가될 signature 배열: {total_fps}개")
        print(f"제외 대상: {excluded_fps}개의 함수 포인터") 
        print(f"영향 받는 파일: {files_with_fps}개")

def main():
    import argparse
    
    parser = argparse.ArgumentParser(description='수정된 함수 포인터 signature 배열 추가기')
    parser.add_argument('directory', nargs='?', help='처리할 디렉토리 또는 파일 경로')
    parser.add_argument('--preview', '-p', action='store_true', help='미리보기만')
    parser.add_argument('--no-backup', action='store_true', help='백업 안함')
    parser.add_argument('--verbose', '-v', action='store_true', help='상세 출력')
    
    args = parser.parse_args()
    
    if not args.directory:
        print("디렉토리 또는 파일 경로를 지정해주세요.")
        return
    
    if not os.path.exists(args.directory):
        print(f"오류: 경로가 존재하지 않습니다: {args.directory}")
        return
    
    replacer = FixedFunctionPointerReplacer(
        backup=not args.no_backup,
        verbose=args.verbose
    )
    
    if args.preview:
        replacer.preview_changes(args.directory)
    else:
        print("주의: 파일들에 signature 배열이 추가됩니다! (기존 함수 포인터는 유지)")
        print(f"제외될 함수 포인터: {len(replacer.non_convert_list)}개")
        if input("계속하시겠습니까? (y/N): ").lower() == 'y':
            replacer.process_directory(args.directory)
        else:
            print("취소되었습니다.")

if __name__ == "__main__":
    main()