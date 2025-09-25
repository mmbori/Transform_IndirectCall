# #!/usr/bin/env python3
# """
# 함수 포인터 변환기 - 수정된 버전
# """

# import os
# import re
# import glob
# from pathlib import Path
# from typing import List, Tuple, Set

# class UltimateFunctionPointerReplacer:
#     def __init__(self, backup=True, verbose=False):
#         self.backup = backup
#         self.verbose = verbose
#         self.stats = {
#             'files_processed': 0,
#             'files_modified': 0,
#             'total_replacements': 0,
#             'excluded_fps': 0
#         }
        
#         # C/C++ 파일 확장자
#         self.c_extensions = {'.c', '.h', '.in'}
        
#         # 제외할 함수 포인터 목록
#         self.non_convert_list = set()
#         self.load_non_convert_list()
    
#     def load_non_convert_list(self):
#         """fpNameDecl 디렉토리에서 제외할 함수 포인터 로드"""
#         if not os.path.exists("fpNameDecl"):
#             if self.verbose:
#                 print("[INFO] fpNameDecl 디렉토리가 없습니다.")
#             return
        
#         decl_files = glob.glob("fpNameDecl/*.txt")
#         if not decl_files:
#             if self.verbose:
#                 print("[INFO] fpNameDecl에 파일이 없습니다.")
#             return
        
#         print(f"[INFO] fpNameDecl에서 {len(decl_files)}개 파일 검사 중...")
        
#         missing_pattern = re.compile(r'// 선언을 찾을 수 없음:\s*(\w+)')
        
#         for decl_file in decl_files:
#             fp_name = os.path.splitext(os.path.basename(decl_file))[0]
            
#             try:
#                 with open(decl_file, 'r', encoding='utf-8') as f:
#                     content = f.read()
                
#                 missing_functions = missing_pattern.findall(content)
#                 if missing_functions:
#                     self.non_convert_list.add(fp_name)
#                     if self.verbose:
#                         print(f"[EXCLUDE] {fp_name}: {len(missing_functions)}개 함수의 선언 누락")
                
#             except Exception as e:
#                 if self.verbose:
#                     print(f"[WARN] 파일 읽기 실패 {decl_file}: {e}")
        
#         if self.non_convert_list:
#             print(f"[INFO] {len(self.non_convert_list)}개 함수 포인터가 변환에서 제외됩니다.")
#         else:
#             print("[INFO] 모든 함수 포인터가 변환 대상입니다.")
    
#     def find_c_files(self, directory):
#         """C/H 파일 찾기"""
#         c_files = []
#         try:
#             directory = Path(directory)
#             for ext in self.c_extensions:
#                 files = list(directory.rglob(f'*{ext}'))
#                 c_files.extend([str(f) for f in files if f.is_file()])
#         except Exception as e:
#             print(f"디렉토리 스캔 오류: {e}")
#             return []
        
#         return sorted(c_files)
    
#     def find_struct_boundaries_in_original(self, content):
#         """원본 파일에서 직접 구조체 경계 찾기"""
#         boundaries = []
        
#         # struct와 union 패턴 - 더 정확하게
#         pattern = re.compile(r'\b(?:struct|union)(?:\s+\w+)?\s*\{', re.MULTILINE)
        
#         for match in pattern.finditer(content):
#             start_pos = match.start()
#             brace_pos = match.end() - 1  # '{' 위치
            
#             # 매칭되는 '}' 찾기
#             brace_count = 1
#             pos = brace_pos + 1
            
#             while pos < len(content) and brace_count > 0:
#                 char = content[pos]
#                 if char == '{':
#                     brace_count += 1
#                 elif char == '}':
#                     brace_count -= 1
#                 pos += 1
            
#             if brace_count == 0:
#                 boundaries.append((start_pos, pos))
        
#         return boundaries
    
#     def is_inside_struct(self, position, boundaries):
#         """위치가 구조체/union 내부인지 확인"""
#         for start, end in boundaries:
#             if start <= position < end:
#                 return True
#         return False
    
#     def find_function_pointers_direct(self, content):
#         """
#         원본 파일에서 직접 함수 포인터 찾기 - 개선된 정규식 사용
#         """
#         if self.verbose:
#             print(f"    [DEBUG] 원본에서 직접 함수 포인터 검색")
        
#         # 1. 원본에서 구조체 경계 찾기
#         boundaries = self.find_struct_boundaries_in_original(content)
        
#         if not boundaries:
#             if self.verbose:
#                 print("    구조체/union 경계를 찾을 수 없습니다.")
#             return []
        
#         if self.verbose:
#             print(f"    발견된 구조체 경계: {len(boundaries)}개")
        
#         # 2. 개선된 함수 포인터 패턴
#         # SQLite의 복잡한 타입들을 처리할 수 있도록 개선
#         fp_patterns = [
#             # 기본 패턴: return_type (*name)(params);
#             r'(\s*)([a-zA-Z_]\w*(?:\s*\*)*)\s*\(\s*\*\s*([a-zA-Z_]\w*)\s*\)\s*\([^;{}]*?\)\s*;',
#             # void 타입
#             r'(\s*)(void)\s*\(\s*\*\s*([a-zA-Z_]\w*)\s*\)\s*\([^;{}]*?\)\s*;',
#             # 복잡한 타입 (sqlite3_xxx 등)
#             r'(\s*)([a-zA-Z_]\w*(?:_[a-zA-Z_]\w*)*(?:\s*\*)*)\s*\(\s*\*\s*([a-zA-Z_]\w*)\s*\)\s*\([^;{}]*?\)\s*;',
#             # unsigned/signed 타입
#             r'(\s*)((?:unsigned|signed)\s+[a-zA-Z_]\w*(?:\s*\*)*)\s*\(\s*\*\s*([a-zA-Z_]\w*)\s*\)\s*\([^;{}]*?\)\s*;',
#             # const 타입
#             r'(\s*)(const\s+[a-zA-Z_]\w*(?:\s*\*)*)\s*\(\s*\*\s*([a-zA-Z_]\w*)\s*\)\s*\([^;{}]*?\)\s*;',
#         ]
        
#         found_pointers = []
        
#         for fp_pattern in fp_patterns:
#             pattern = re.compile(fp_pattern, re.DOTALL | re.MULTILINE)
            
#             for match in pattern.finditer(content):
#                 indent = match.group(1) if match.group(1) else ''
#                 return_type = match.group(2)
#                 fp_name = match.group(3)
#                 start_pos = match.start()
#                 end_pos = match.end()
#                 full_match = match.group(0)
                
#                 # 구조체 내부인지 확인
#                 if self.is_inside_struct(start_pos, boundaries):
#                     found_pointers.append((full_match, fp_name, start_pos, end_pos, indent))
                    
#                     if self.verbose:
#                         print(f"      발견: {fp_name} ({return_type}) at {start_pos}")
        
#         # 3. typedef 함수 포인터도 찾기 (sqlite3_callback 등)
#         typedef_pattern = r'(\s*)(sqlite3_\w+)\s+([a-zA-Z_]\w*)\s*;'
#         typedef_re = re.compile(typedef_pattern, re.MULTILINE)
        
#         for match in typedef_re.finditer(content):
#             indent = match.group(1) if match.group(1) else ''
#             fp_type = match.group(2)
#             fp_name = match.group(3)
#             start_pos = match.start()
#             end_pos = match.end()
#             full_match = match.group(0)
            
#             # 구조체 내부인지 확인
#             if self.is_inside_struct(start_pos, boundaries):
#                 found_pointers.append((full_match, fp_name, start_pos, end_pos, indent))
                
#                 if self.verbose:
#                     print(f"      발견 (typedef): {fp_name} ({fp_type}) at {start_pos}")
        
#         # 4. 중복 제거 (이름 기준)
#         unique_pointers = {}
#         for match_info in found_pointers:
#             fp_name = match_info[1]
#             if fp_name not in unique_pointers:
#                 unique_pointers[fp_name] = match_info
        
#         result = list(unique_pointers.values())
#         result.sort(key=lambda x: x[2])  # 위치순 정렬
        
#         if self.verbose:
#             print(f"    최종 발견: {len(result)}개 함수 포인터")
        
#         return result
    
#     def test_single_file(self, file_path):
#         """단일 파일 테스트용 메서드"""
#         try:
#             with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
#                 content = f.read()
            
#             print(f"파일 크기: {len(content)} 문자")
            
#             # 구조체 경계 찾기
#             boundaries = self.find_struct_boundaries_in_original(content)
#             print(f"발견된 구조체: {len(boundaries)}개")
            
#             if self.verbose and boundaries:
#                 for i, (start, end) in enumerate(boundaries[:5]):  # 처음 5개만 표시
#                     struct_preview = content[start:min(start+100, end)].replace('\n', ' ')
#                     print(f"  구조체 {i+1}: {struct_preview}...")
            
#             # 함수 포인터 찾기
#             function_pointers = self.find_function_pointers_direct(content)
#             print(f"발견된 함수 포인터: {len(function_pointers)}개")
            
#             if function_pointers:
#                 print("\n발견된 함수 포인터들:")
#                 for i, (_, fp_name, start_pos, _, _) in enumerate(function_pointers, 1):
#                     print(f"  {i:2d}. {fp_name}")
            
#             return function_pointers
            
#         except Exception as e:
#             print(f"오류: {e}")
#             return []
    
#     def create_backup(self, file_path):
#         """백업 파일 생성"""
#         backup_path = f"{file_path}.backup"
#         counter = 1
#         while os.path.exists(backup_path):
#             backup_path = f"{file_path}.backup.{counter}"
#             counter += 1
        
#         try:
#             with open(file_path, 'r', encoding='utf-8', errors='ignore') as src:
#                 with open(backup_path, 'w', encoding='utf-8') as dst:
#                     dst.write(src.read())
#             return backup_path
#         except Exception as e:
#             print(f"백업 생성 실패: {e}")
#             return None
    
#     def find_struct_end_positions(self, content, boundaries, valid_pointers):
#         """각 구조체의 끝 위치를 찾고, 해당 구조체에 속한 함수 포인터들을 그룹화"""
#         struct_groups = {}
        
#         for boundary_start, boundary_end in boundaries:
#             # 이 구조체에 속한 함수 포인터들 찾기
#             struct_fps = []
#             for fp_info in valid_pointers:
#                 _, fp_name, fp_start, _, indent = fp_info
#                 if boundary_start <= fp_start < boundary_end:
#                     struct_fps.append((fp_name, indent))
            
#             if struct_fps:
#                 # 구조체 끝 위치 찾기 (마지막 '}' 바로 앞)
#                 struct_end = boundary_end - 1  # '}' 위치
                
#                 # '}' 바로 앞의 적절한 삽입 위치 찾기
#                 insert_pos = struct_end
#                 while insert_pos > boundary_start and content[insert_pos-1] in ' \t':
#                     insert_pos -= 1
                
#                 # 마지막 줄바꿈 찾기
#                 while insert_pos > boundary_start and content[insert_pos-1] != '\n':
#                     insert_pos -= 1
                
#                 struct_groups[insert_pos] = struct_fps
        
#         return struct_groups

#     def process_file(self, file_path):
#         """개별 파일 처리 - 기존 선언 유지하고 구조체 끝에 signature 배열들 추가"""
#         try:
#             # 파일 크기 체크
#             file_size = os.path.getsize(file_path)
#             if file_size > 100 * 1024 * 1024:  # 100MB 이상
#                 if self.verbose:
#                     print(f"  대용량 파일 건너뜀: {file_path}")
#                 return {'modified': False, 'count': 0, 'skipped': True}
            
#             # 파일 읽기
#             with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
#                 content = f.read()
            
#             # 구조체 경계와 함수 포인터 찾기
#             boundaries = self.find_struct_boundaries_in_original(content)
#             function_pointers = self.find_function_pointers_direct(content)
            
#             if not function_pointers:
#                 if self.verbose:
#                     print(f"  {os.path.basename(file_path)}: 함수 포인터 없음")
#                 return {'modified': False, 'count': 0}
            
#             # 제외 목록 필터링
#             valid_pointers = []
#             excluded_count = 0
            
#             for fp_info in function_pointers:
#                 fp_name = fp_info[1]
#                 if fp_name in self.non_convert_list:
#                     excluded_count += 1
#                     self.stats['excluded_fps'] += 1
#                     if self.verbose:
#                         print(f"    [SKIP] {fp_name}: 제외 목록")
#                 else:
#                     valid_pointers.append(fp_info)
            
#             if not valid_pointers:
#                 if self.verbose:
#                     print(f"  {os.path.basename(file_path)}: 모든 함수 포인터가 제외됨")
#                 return {'modified': False, 'count': 0}
            
#             print(f"  {os.path.basename(file_path)}: {len(valid_pointers)}개 함수 포인터 발견! (제외: {excluded_count}개)")
            
#             if self.verbose:
#                 print("    변환 대상:")
#                 for _, fp_name, _, _, _ in valid_pointers:
#                     print(f"      - {fp_name}")
            
#             # 백업 생성
#             if self.backup:
#                 backup_path = self.create_backup(file_path)
#                 if not backup_path:
#                     return {'modified': False, 'count': 0, 'error': 'backup failed'}
            
#             # 구조체별로 함수 포인터 그룹화
#             struct_groups = self.find_struct_end_positions(content, boundaries, valid_pointers)
            
#             if not struct_groups:
#                 if self.verbose:
#                     print(f"  {os.path.basename(file_path)}: 구조체 끝 위치를 찾을 수 없음")
#                 return {'modified': False, 'count': 0}
            
#             # 뒤에서부터 삽입 (위치 변화 방지)
#             modified_content = content
#             total_insertions = 0
            
#             # 삽입 위치를 역순으로 정렬
#             for insert_pos in sorted(struct_groups.keys(), reverse=True):
#                 fps_in_struct = struct_groups[insert_pos]
                
#                 # 들여쓰기 결정 (첫 번째 함수 포인터의 들여쓰기 사용)
#                 base_indent = fps_in_struct[0][1] if fps_in_struct else "  "
                
#                 # 구조체 끝에 삽입할 내용 생성
#                 signature_block = ""
#                 signature_block += f"\n{base_indent}// Function pointer signature arrays\n"
                
#                 for fp_name, indent in fps_in_struct:
#                     signature_block += f"{base_indent}int {fp_name}_signature[4];"
                
#                 # 구조체 끝에 삽입
#                 modified_content = modified_content[:insert_pos] + signature_block + modified_content[insert_pos:]
#                 total_insertions += len(fps_in_struct)
                
#                 if self.verbose:
#                     print(f"    구조체 끝에 {len(fps_in_struct)}개 signature 배열 추가:")
#                     for fp_name, _ in fps_in_struct:
#                         print(f"      + int {fp_name}_signature[4];")
#                     print(f"\n")
            
#             # 파일 저장
#             with open(file_path, 'w', encoding='utf-8') as f:
#                 f.write(modified_content)
            
#             return {'modified': True, 'count': total_insertions}
            
#         except Exception as e:
#             if self.verbose:
#                 print(f"  오류 - {file_path}: {e}")
#             return {'modified': False, 'count': 0, 'error': str(e)}
    
#     def process_directory(self, directory):
#         """디렉토리 처리"""
#         if os.path.isfile(directory):
#             # 단일 파일 처리
#             print(f"단일 파일 처리: {directory}")
#             self.stats['files_processed'] += 1
#             result = self.process_file(directory)
            
#             if result['modified']:
#                 self.stats['files_modified'] += 1
#                 self.stats['total_replacements'] += result['count']
#                 print(f"✓ {os.path.basename(directory)}: {result['count']}개 signature 배열 추가 완료!")
#             elif 'error' in result:
#                 print(f"✗ {os.path.basename(directory)}: {result['error']}")
#             else:
#                 print(f"- {os.path.basename(directory)}: 변경사항 없음")
#             return
        
#         print(f"디렉토리 스캔 중: {directory}")
        
#         c_files = self.find_c_files(directory)
#         print(f"발견된 C/H 파일: {len(c_files)}개")
        
#         if not c_files:
#             print("처리할 파일이 없습니다.")
#             return
        
#         print("\n처리 시작...")
#         print("=" * 60)
        
#         processed = 0
#         for file_path in c_files:
#             processed += 1
#             if processed % 50 == 0:
#                 print(f"진행상황: {processed}/{len(c_files)}")
            
#             self.stats['files_processed'] += 1
#             result = self.process_file(file_path)
            
#             if result['modified']:
#                 self.stats['files_modified'] += 1
#                 self.stats['total_replacements'] += result['count']
#                 print(f"✓ {os.path.basename(file_path)}: {result['count']}개 signature 배열 추가 완료!")
#             elif 'error' in result and self.verbose:
#                 print(f"✗ {os.path.basename(file_path)}: {result['error']}")
#             elif result.get('skipped') and self.verbose:
#                 print(f"- {os.path.basename(file_path)}: 건너뜀")
        
#         # 최종 통계
#         print("\n" + "=" * 60)
#         print("처리 완료:")
#         print(f"  처리된 파일: {self.stats['files_processed']}개")
#         print(f"  수정된 파일: {self.stats['files_modified']}개")
#         print(f"  추가된 signature 배열: {self.stats['total_replacements']}개")
#         print(f"  제외된 함수 포인터: {self.stats['excluded_fps']}개")
        
#         if self.stats['total_replacements'] > 0:
#             print(f"\n🎉 성공! 총 {self.stats['total_replacements']}개의 signature 배열이 추가되었습니다!")
#             print("기존 함수 포인터 선언은 유지되고, 그 아래에 signature 배열이 추가되었습니다.")

#     def preview_changes(self, directory):
#         """변경사항 미리보기"""
#         print(f"변경사항 미리보기: {directory}")
#         print(f"제외할 함수 포인터: {len(self.non_convert_list)}개")
        
#         if os.path.isfile(directory):
#             # 단일 파일 처리
#             print(f"\n단일 파일 분석: {directory}")
#             self.test_single_file(directory)
#             return
        
#         c_files = self.find_c_files(directory)
#         if len(c_files) > 10:
#             print(f"파일이 많습니다 ({len(c_files)}개). 처음 10개만 미리보기합니다.")
#             c_files = c_files[:10]
        
#         total_fps = 0
#         excluded_fps = 0
#         files_with_fps = 0
        
#         for i, file_path in enumerate(c_files):
#             print(f"\n[{i+1}/{len(c_files)}] {os.path.basename(file_path)}")
            
#             try:
#                 if os.path.getsize(file_path) > 5 * 1024 * 1024:
#                     print("  파일이 너무 큽니다. 건너뜀.")
#                     continue
                
#                 fps = self.test_single_file(file_path)
                
#                 if fps:
#                     files_with_fps += 1
#                     convert_count = 0
#                     exclude_count = 0
                    
#                     for _, fp_name, _, _, _ in fps:
#                         if fp_name in self.non_convert_list:
#                             exclude_count += 1
#                             excluded_fps += 1
#                             print(f"     [EXCLUDE] {fp_name}")
#                         else:
#                             convert_count += 1
#                             total_fps += 1
#                             print(f"     [ADD] {fp_name} -> int {fp_name}_signature[4];")
                    
#                     print(f"   추가될 signature: {convert_count}개, 제외: {exclude_count}개")
            
#             except Exception as e:
#                 print(f"  오류: {e}")
#                 continue
        
#         print(f"\n=== 요약 ===")
#         print(f"추가될 signature 배열: {total_fps}개")
#         print(f"제외 대상: {excluded_fps}개의 함수 포인터") 
#         print(f"영향 받는 파일: {files_with_fps}개")

# def main():
#     import argparse
    
#     parser = argparse.ArgumentParser(description='함수 포인터 signature 배열 추가기 (수정된 버전)')
#     parser.add_argument('directory', nargs='?', help='처리할 디렉토리 또는 파일 경로')
#     parser.add_argument('--preview', '-p', action='store_true', help='미리보기만')
#     parser.add_argument('--no-backup', action='store_true', help='백업 안함')
#     parser.add_argument('--verbose', '-v', action='store_true', help='상세 출력')
    
#     args = parser.parse_args()
    
#     if not args.directory:
#         print("디렉토리 또는 파일 경로를 지정해주세요.")
#         return
    
#     if not os.path.exists(args.directory):
#         print(f"오류: 경로가 존재하지 않습니다: {args.directory}")
#         return
    
#     replacer = UltimateFunctionPointerReplacer(
#         backup=not args.no_backup,
#         verbose=args.verbose
#     )
    
#     if args.preview:
#         replacer.preview_changes(args.directory)
#     else:
#         print("주의: 파일들에 signature 배열이 추가됩니다! (기존 함수 포인터는 유지)")
#         print(f"제외될 함수 포인터: {len(replacer.non_convert_list)}개")
#         if input("계속하시겠습니까? (y/N): ").lower() == 'y':
#             replacer.process_directory(args.directory)
#         else:
#             print("취소되었습니다.")

# if __name__ == "__main__":
#     main()

#!/usr/bin/env python3
"""
함수 포인터 변환기 - 대상 FP 제한 + 포맷 수정 버전
- target_fpNames_tmp.txt에 있는 FP 이름만 처리
- fpName/<fp>.txt 가 존재하는 FP만 유효 대상으로 간주
- .c, .h, .in 모두 검사
- 구조체 끝에 signature[4] 추가 시: 빈 줄 없이 연속, 마지막 '}' 는 다음 줄에 오도록
"""

import os
import re
import glob
from pathlib import Path
from typing import List, Tuple, Set

class UltimateFunctionPointerReplacer:
    def __init__(self, backup=True, verbose=False):
        self.backup = backup
        self.verbose = verbose
        self.stats = {
            'files_processed': 0,
            'files_modified': 0,
            'total_replacements': 0,
            'excluded_fps': 0
        }

        # 스캔할 확장자
        self.c_extensions = {'.c', '.h', '.in'}

        # 처리 대상 FP (화이트리스트)
        self.target_fp_set: Set[str] = set()
        self.load_target_fp_list()

    # -------------------- NEW: 대상 FP 리스트 --------------------
    def load_target_fp_list(self):
        """
        target_fpNames_tmp.txt 에 적힌 FP 이름만 처리.
        또한 fpName/<fp>.txt 가 존재하는 것만 최종 대상에 포함.
        """
        target_file = "target_fpNames_tmp.txt"
        if not os.path.exists(target_file):
            print("[WARN] target_fpNames_tmp.txt 가 없습니다. 대상 FP가 비어있으므로 어떤 것도 처리하지 않습니다.")
            return

        raw = []
        with open(target_file, "r", encoding="utf-8", errors="ignore") as f:
            for line in f:
                name = line.strip()
                if name:
                    raw.append(name)

        if not raw:
            print("[WARN] target_fpNames_tmp.txt 에 FP 이름이 비어 있습니다.")
            return

        # fpName/<fp>.txt 가 존재하는 항목만 채택
        valid = []
        for fp in raw:
            if os.path.exists(os.path.join("fpName_tmp", f"{fp}.txt")):
                valid.append(fp)
            else:
                if self.verbose:
                    print(f"[SKIP] fpName_tmp/{fp}.txt 없음 → 대상에서 제외")

        self.target_fp_set = set(valid)
        print(f"[INFO] 대상 FP: {len(self.target_fp_set)}개 선택 (fpName/<fp>.txt 존재 기준)")

    # -------------------- 파일 수집 --------------------
    def find_c_files(self, directory):
        """ .c .h .in 파일 찾기 """
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

    # -------------------- 구조체 경계 --------------------
    def find_struct_boundaries_in_original(self, content):
        """원본 파일에서 구조체/union 경계 찾기"""
        boundaries = []
        pattern = re.compile(r'\b(?:struct|union)(?:\s+\w+)?\s*\{', re.MULTILINE)
        for match in pattern.finditer(content):
            start_pos = match.start()
            brace_pos = match.end() - 1  # '{'
            brace_count = 1
            pos = brace_pos + 1
            while pos < len(content) and brace_count > 0:
                ch = content[pos]
                if ch == '{':
                    brace_count += 1
                elif ch == '}':
                    brace_count -= 1
                pos += 1
            if brace_count == 0:
                boundaries.append((start_pos, pos))
        return boundaries

    def is_inside_struct(self, position, boundaries):
        for start, end in boundaries:
            if start <= position < end:
                return True
        return False

    # -------------------- 함수 포인터 탐지 --------------------
    def find_function_pointers_direct(self, content):
        """
        원본에서 구조체 내부 함수 포인터 선언 탐지 (정규식)
        """
        if self.verbose:
            print(f"    [DEBUG] 원본에서 직접 함수 포인터 검색")

        boundaries = self.find_struct_boundaries_in_original(content)
        if not boundaries:
            if self.verbose:
                print("    구조체/union 경계를 찾을 수 없습니다.")
            return []

        fp_patterns = [
            r'(\s*)([a-zA-Z_]\w*(?:\s*\*)*)\s*\(\s*\*\s*([a-zA-Z_]\w*)\s*\)\s*\([^;{}]*?\)\s*;',
            r'(\s*)(void)\s*\(\s*\*\s*([a-zA-Z_]\w*)\s*\)\s*\([^;{}]*?\)\s*;',
            r'(\s*)([a-zA-Z_]\w*(?:_[a-zA-Z_]\w*)*(?:\s*\*)*)\s*\(\s*\*\s*([a-zA-Z_]\w*)\s*\)\s*\([^;{}]*?\)\s*;',
            r'(\s*)((?:unsigned|signed)\s+[a-zA-Z_]\w*(?:\s*\*)*)\s*\(\s*\*\s*([a-zA-Z_]\w*)\s*\)\s*\([^;{}]*?\)\s*;',
            r'(\s*)(const\s+[a-zA-Z_]\w*(?:\s*\*)*)\s*\(\s*\*\s*([a-zA-Z_]\w*)\s*\)\s*\([^;{}]*?\)\s*;',
        ]
        found = []
        for fp_pattern in fp_patterns:
            pattern = re.compile(fp_pattern, re.DOTALL | re.MULTILINE)
            for m in pattern.finditer(content):
                indent = m.group(1) or ''
                return_type = m.group(2)
                fp_name = m.group(3)
                start_pos = m.start()
                end_pos = m.end()
                full = m.group(0)
                if self.is_inside_struct(start_pos, boundaries):
                    found.append((full, fp_name, start_pos, end_pos, indent))

        # typedef 스타일(e.g., sqlite3_callback)
        typedef_re = re.compile(r'(\s*)(sqlite3_\w+)\s+([a-zA-Z_]\w*)\s*;', re.MULTILINE)
        for m in typedef_re.finditer(content):
            indent = m.group(1) or ''
            fp_type = m.group(2)
            fp_name = m.group(3)
            start_pos = m.start()
            end_pos = m.end()
            full = m.group(0)
            if self.is_inside_struct(start_pos, boundaries):
                found.append((full, fp_name, start_pos, end_pos, indent))

        # 이름 기준 중복 제거 및 정렬
        uniq = {}
        for info in found:
            if info[1] not in uniq:
                uniq[info[1]] = info
        result = list(uniq.values())
        result.sort(key=lambda x: x[2])
        return result

    # -------------------- 단일 파일 미리보기 --------------------
    def test_single_file(self, file_path):
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            boundaries = self.find_struct_boundaries_in_original(content)
            fps = self.find_function_pointers_direct(content)
            return fps
        except Exception:
            return []

    # -------------------- 백업 --------------------
    def create_backup(self, file_path):
        backup_path = f"{file_path}.backup"
        counter = 1
        while os.path.exists(backup_path):
            backup_path = f"{file_path}.backup.{counter}"
            counter += 1
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as src, \
                 open(backup_path, 'w', encoding='utf-8') as dst:
                dst.write(src.read())
            return backup_path
        except Exception as e:
            print(f"백업 생성 실패: {e}")
            return None

    # -------------------- 구조체별 삽입 위치 --------------------
    def find_struct_end_positions(self, content, boundaries, valid_pointers):
        """
        각 구조체의 끝(닫는 brace 직전) 위치를 찾고, 그 구조체에 속한 FP들을 묶어 반환
        """
        struct_groups = {}
        for bstart, bend in boundaries:
            fps_in = []
            for fp_full, fp_name, fp_start, _, indent in valid_pointers:
                if bstart <= fp_start < bend:
                    fps_in.append((fp_name, indent))
            if fps_in:
                struct_end = bend - 1  # '}' 위치
                insert_pos = struct_end
                # '}' 앞의 공백 제거
                while insert_pos > bstart and content[insert_pos - 1] in ' \t':
                    insert_pos -= 1
                # 마지막 줄의 시작(개행 직후)로 위치 이동 → 우리가 넣는 라인이 새 줄에서 시작
                while insert_pos > bstart and content[insert_pos - 1] != '\n':
                    insert_pos -= 1
                struct_groups[insert_pos] = fps_in
        return struct_groups

    # -------------------- 파일 처리 --------------------
    def process_file(self, file_path):
        """
        1) 구조체 내부 FP 선언 수집
        2) 대상 FP(화이트리스트)에 속하는 것만 필터
        3) 각 구조체 끝에 int <fp>_signature[4]; 라인을 빈 줄 없이 연속으로 추가
           (닫는 '}' 는 다음 줄)
        """
        try:
            if os.path.getsize(file_path) > 100 * 1024 * 1024:
                if self.verbose:
                    print(f"  대용량 파일 건너뜀: {file_path}")
                return {'modified': False, 'count': 0, 'skipped': True}

            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()

            boundaries = self.find_struct_boundaries_in_original(content)
            fps_all = self.find_function_pointers_direct(content)
            if not fps_all:
                return {'modified': False, 'count': 0}

            # ---- 대상 FP만 남긴다 (target_fp_set & fpName/<fp>.txt 존재) ----
            valid_pointers = []
            for info in fps_all:
                fp_name = info[1]
                if fp_name in self.target_fp_set and os.path.exists(os.path.join("fpName_tmp", f"{fp_name}.txt")):
                    valid_pointers.append(info)
                else:
                    self.stats['excluded_fps'] += 1
                    if self.verbose:
                        print(f"    [SKIP] {fp_name}: 대상 아님")

            if not valid_pointers:
                return {'modified': False, 'count': 0}

            # 백업
            if self.backup:
                if not self.create_backup(file_path):
                    return {'modified': False, 'count': 0, 'error': 'backup failed'}

            struct_groups = self.find_struct_end_positions(content, boundaries, valid_pointers)
            if not struct_groups:
                return {'modified': False, 'count': 0}

            modified = content
            total_insert = 0

            # 뒤에서부터 삽입
            for insert_pos in sorted(struct_groups.keys(), reverse=True):
                fps_in_struct = struct_groups[insert_pos]
                # 들여쓰기는 첫 FP 라인의 들여쓰기 사용(없으면 두 칸)
                base_indent = fps_in_struct[0][1] if fps_in_struct and fps_in_struct[0][1] else "  "
                # 요구 포맷: 빈 줄 없이 줄마다 하나씩, 그리고 닫는 '}' 는 다음 줄
                signature_block_lines = []
                for fp_name, _indent in fps_in_struct:
                    signature_block_lines.append(f"{base_indent}int {fp_name}_signature[4];")
                # 블록 문자열: 앞에 개행을 하나 넣어 새 줄 시작, 각 라인 끝에 개행
                signature_block = "\n" + "\n".join(signature_block_lines) + "\n"
                # 삽입
                modified = modified[:insert_pos] + signature_block + modified[insert_pos:]
                total_insert += len(fps_in_struct)

            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(modified)

            return {'modified': True, 'count': total_insert}

        except Exception as e:
            if self.verbose:
                print(f"  오류 - {file_path}: {e}")
            return {'modified': False, 'count': 0, 'error': str(e)}

    # -------------------- 디렉토리 처리 --------------------
    def process_directory(self, directory):
        if os.path.isfile(directory):
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
        print(f"발견된 C/H/IN 파일: {len(c_files)}개")

        if not c_files:
            print("처리할 파일이 없습니다.")
            return

        print("\n처리 시작...")
        print("=" * 60)
        for idx, file_path in enumerate(c_files, 1):
            if idx % 50 == 0:
                print(f"진행상황: {idx}/{len(c_files)}")

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

        print("\n" + "=" * 60)
        print("처리 완료:")
        print(f"  처리된 파일: {self.stats['files_processed']}개")
        print(f"  수정된 파일: {self.stats['files_modified']}개")
        print(f"  추가된 signature 배열: {self.stats['total_replacements']}개")
        print(f"  대상 외 FP(건너뜀 카운트): {self.stats['excluded_fps']}개")
        if self.stats['total_replacements'] > 0:
            print(f"\n🎉 성공! 총 {self.stats['total_replacements']}개의 signature 배열이 추가되었습니다!")

    # -------------------- 미리보기 --------------------
    def preview_changes(self, directory):
        print(f"변경사항 미리보기: {directory}")
        print(f"대상 FP 수: {len(self.target_fp_set)}개")
        if os.path.isfile(directory):
            print(f"\n단일 파일 분석: {directory}")
            self.test_single_file(directory)
            return
        c_files = self.find_c_files(directory)
        if len(c_files) > 10:
            print(f"파일이 많습니다 ({len(c_files)}개). 처음 10개만 미리보기합니다.")
            c_files = c_files[:10]
        for i, file_path in enumerate(c_files, 1):
            print(f"\n[{i}/{len(c_files)}] {os.path.basename(file_path)}")
            try:
                fps = self.test_single_file(file_path)
                if not fps:
                    print("  (함수 포인터 없음)")
                    continue
                add_list = []
                skip_list = []
                for _, fp_name, *_ in fps:
                    if fp_name in self.target_fp_set and os.path.exists(os.path.join("fpName_tmp", f"{fp_name}.txt")):
                        add_list.append(fp_name)
                    else:
                        skip_list.append(fp_name)
                print(f"  추가될 signature: {len(add_list)}개")
                for fp in sorted(set(add_list)):
                    print(f"    + int {fp}_signature[4];")
                if skip_list and self.verbose:
                    print(f"  대상 외: {len(skip_list)}개 → 건너뜀")
            except Exception as e:
                print(f"  오류: {e}")
                continue

def main():
    import argparse
    parser = argparse.ArgumentParser(description='함수 포인터 signature 배열 추가기 (대상 FP 제한 버전)')
    parser.add_argument('directory', nargs='?', help='처리할 디렉토리 또는 파일 경로')
    parser.add_argument('--preview', '-p', action='store_true', help='미리보기만')
    parser.add_argument('--no_backup', action='store_true', help='백업 안함')
    parser.add_argument('--verbose', '-v', action='store_true', help='상세 출력')
    args = parser.parse_args()

    if not args.directory:
        print("디렉토리 또는 파일 경로를 지정해주세요.")
        return
    if not os.path.exists(args.directory):
        print(f"오류: 경로가 존재하지 않습니다: {args.directory}")
        return

    replacer = UltimateFunctionPointerReplacer(
        backup=not args.no_backup,
        verbose=args.verbose
    )

    if args.preview:
        replacer.preview_changes(args.directory)
    else:
        print("주의: 파일에 signature 배열이 추가됩니다! (기존 함수 포인터는 유지)")
        print(f"대상 FP 수: {len(replacer.target_fp_set)}개")
        if input("계속하시겠습니까? (y/N): ").lower() == 'y':
            replacer.process_directory(args.directory)
        else:
            print("취소되었습니다.")

if __name__ == "__main__":
    main()
