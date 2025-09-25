#!/usr/bin/env python3
"""
디버깅용 함수 포인터 분석기 - 실제 파일에서 왜 못 찾는지 분석
"""

import os
import re
import glob
from pathlib import Path

class DebugFunctionPointerAnalyzer:
    def __init__(self, verbose=True):
        self.verbose = verbose
    
    def analyze_file(self, file_path):
        """파일을 상세 분석"""
        print(f"\n{'='*80}")
        print(f"파일 분석: {file_path}")
        print(f"{'='*80}")
        
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            print(f"파일 크기: {len(content):,} 문자")
            print(f"라인 수: {len(content.split(chr(10)))} 라인")
            
            # 1. 원본에서 구조체/union 찾기
            self.analyze_structures(content, "원본")
            
            # 2. 전처리 후 구조체/union 찾기
            processed = self.preprocess_content(content)
            self.analyze_structures(processed, "전처리 후")
            
            # 3. 함수 포인터 패턴 매칭 비교
            self.analyze_function_pointers(content, processed)
            
            # 4. 조건부 컴파일 블록 분석
            self.analyze_conditional_blocks(content)
            
            # 5. union 블록 분석
            self.analyze_union_blocks(content)
            
        except Exception as e:
            print(f"파일 읽기 오류: {e}")
    
    def preprocess_content(self, content):
        """조건부 컴파일 제거 및 정규화"""
        print(f"\n--- 전처리 과정 ---")
        
        # 1. 조건부 컴파일 제거 전
        conditional_lines = len(re.findall(r'#\s*(?:if|ifdef|ifndef|else|elif|endif)', content))
        print(f"조건부 컴파일 지시자: {conditional_lines}개")
        
        # 2. 조건부 컴파일 제거
        processed = re.sub(r'#\s*(?:if|ifdef|ifndef|else|elif|endif).*?$', '', content, flags=re.MULTILINE)
        
        # 3. 주석 제거
        comment_blocks = len(re.findall(r'/\*.*?\*/', processed, flags=re.DOTALL))
        line_comments = len(re.findall(r'//.*?$', processed, flags=re.MULTILINE))
        print(f"블록 주석: {comment_blocks}개, 라인 주석: {line_comments}개")
        
        processed = re.sub(r'/\*.*?\*/', ' ', processed, flags=re.DOTALL)
        processed = re.sub(r'//.*?$', '', processed, flags=re.MULTILINE)
        
        # 4. 공백 정규화
        processed = re.sub(r'\s+', ' ', processed)
        processed = re.sub(r'\s*;\s*', ';', processed)
        
        print(f"전처리 후 크기: {len(processed):,} 문자 (압축률: {len(processed)/len(content)*100:.1f}%)")
        
        return processed
    
    def analyze_structures(self, content, label):
        """구조체/union 구조 분석"""
        print(f"\n--- {label} 구조체/Union 분석 ---")
        
        # struct 찾기
        struct_pattern = re.compile(r'\bstruct\s+(\w+)\s*\{', re.MULTILINE)
        struct_matches = list(struct_pattern.finditer(content))
        print(f"struct 선언: {len(struct_matches)}개")
        
        for i, match in enumerate(struct_matches):
            struct_name = match.group(1)
            start_pos = match.start()
            print(f"  {i+1}. struct {struct_name} at position {start_pos}")
        
        # union 찾기
        union_pattern = re.compile(r'\bunion\s*\{', re.MULTILINE)
        union_matches = list(union_pattern.finditer(content))
        print(f"union 선언: {len(union_matches)}개")
        
        for i, match in enumerate(union_matches):
            start_pos = match.start()
            print(f"  {i+1}. union at position {start_pos}")
        
        # 구조체 경계 계산
        boundaries = self.find_struct_boundaries(content)
        print(f"구조체 경계: {len(boundaries)}개")
        
        for i, (start, end) in enumerate(boundaries):
            print(f"  {i+1}. {start} ~ {end} (길이: {end-start})")
    
    def find_struct_boundaries(self, content):
        """구조체 경계 찾기"""
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
    
    def is_inside_struct(self, position, boundaries):
        """위치가 구조체 내부인지 확인"""
        for start, end in boundaries:
            if start <= position < end:
                return True
        return False
    
    def analyze_function_pointers(self, original, processed):
        """함수 포인터 패턴 분석"""
        print(f"\n--- 함수 포인터 패턴 분석 ---")
        
        # 기본 함수 포인터 패턴
        fp_pattern = r'(\s*)(\w+(?:\s*\*)*|void|unsigned\s+\w+|signed\s+\w+|const\s+\w+(?:\s*\*)*|volatile\s+\w+)\s*\(\s*\*\s*(\w+)\s*\)\s*\([^;{}]*?\)\s*;'
        
        # 원본에서 검색
        original_matches = list(re.finditer(fp_pattern, original, re.DOTALL | re.MULTILINE))
        print(f"원본에서 함수 포인터 패턴: {len(original_matches)}개")
        
        original_boundaries = self.find_struct_boundaries(original)
        original_inside = 0
        
        for match in original_matches:
            fp_name = match.group(3)
            position = match.start()
            is_inside = self.is_inside_struct(position, original_boundaries)
            
            if is_inside:
                original_inside += 1
                print(f"  ✓ {fp_name} (원본, 구조체 내부)")
            else:
                print(f"  ✗ {fp_name} (원본, 구조체 외부)")
        
        print(f"원본에서 구조체 내부: {original_inside}개")
        
        # 전처리된 코드에서 검색
        processed_matches = list(re.finditer(fp_pattern, processed, re.DOTALL | re.MULTILINE))
        print(f"전처리 후 함수 포인터 패턴: {len(processed_matches)}개")
        
        processed_boundaries = self.find_struct_boundaries(processed)
        processed_inside = 0
        
        for match in processed_matches:
            fp_name = match.group(3)
            position = match.start()
            is_inside = self.is_inside_struct(position, processed_boundaries)
            
            if is_inside:
                processed_inside += 1
                print(f"  ✓ {fp_name} (전처리, 구조체 내부)")
            else:
                print(f"  ✗ {fp_name} (전처리, 구조체 외부)")
        
        print(f"전처리 후 구조체 내부: {processed_inside}개")
        
        # typedef 패턴도 확인
        typedef_pattern = r'(sqlite3_xauth|sqlite3_callback|sqlite3_exec_callback)\s+(\w+)\s*;'
        typedef_matches = list(re.finditer(typedef_pattern, original))
        print(f"typedef 함수 포인터: {len(typedef_matches)}개")
        
        for match in typedef_matches:
            fp_type = match.group(1)
            fp_name = match.group(2)
            print(f"  - {fp_name} ({fp_type})")
    
    def analyze_conditional_blocks(self, content):
        """조건부 컴파일 블록 내부 함수 포인터 분석"""
        print(f"\n--- 조건부 컴파일 블록 분석 ---")
        
        # #ifdef/#ifndef 블록 찾기
        conditional_pattern = r'#\s*(?:ifdef|ifndef|if)\s+([^\r\n]*?)$(.*?)#\s*endif'
        
        blocks = re.findall(conditional_pattern, content, re.DOTALL | re.MULTILINE)
        print(f"조건부 컴파일 블록: {len(blocks)}개")
        
        fp_pattern = r'(\w+(?:\s*\*)*|void|unsigned\s+\w+)\s*\(\s*\*\s*(\w+)\s*\)\s*\([^;{}]*?\)\s*;'
        
        total_fps_in_blocks = 0
        for i, (condition, block_content) in enumerate(blocks):
            fps_in_block = re.findall(fp_pattern, block_content, re.DOTALL)
            if fps_in_block:
                total_fps_in_blocks += len(fps_in_block)
                print(f"  블록 {i+1} ({condition.strip()}): {len(fps_in_block)}개 함수 포인터")
                for return_type, fp_name in fps_in_block:
                    print(f"    - {fp_name} ({return_type})")
        
        print(f"조건부 블록 내 총 함수 포인터: {total_fps_in_blocks}개")
    
    def analyze_union_blocks(self, content):
        """union 블록 내부 함수 포인터 분석"""
        print(f"\n--- Union 블록 분석 ---")
        
        # union { ... } 블록 찾기
        union_pattern = r'union\s*\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}'
        
        union_blocks = re.findall(union_pattern, content, re.DOTALL)
        print(f"union 블록: {len(union_blocks)}개")
        
        fp_pattern = r'(\w+(?:\s*\*)*|void|unsigned\s+\w+)\s*\(\s*\*\s*(\w+)\s*\)\s*\([^;{}]*?\)\s*;'
        
        total_fps_in_unions = 0
        for i, union_content in enumerate(union_blocks):
            fps_in_union = re.findall(fp_pattern, union_content, re.DOTALL)
            if fps_in_union:
                total_fps_in_unions += len(fps_in_union)
                print(f"  Union {i+1}: {len(fps_in_union)}개 함수 포인터")
                for return_type, fp_name in fps_in_union:
                    print(f"    - {fp_name} ({return_type})")
        
        print(f"Union 내 총 함수 포인터: {total_fps_in_unions}개")
    
    def find_c_files(self, directory):
        """C/H 파일 찾기"""
        c_files = []
        try:
            directory = Path(directory)
            for ext in ['.c', '.h']:
                files = list(directory.rglob(f'*{ext}'))
                c_files.extend([str(f) for f in files if f.is_file()])
        except Exception as e:
            print(f"디렉토리 스캔 오류: {e}")
            return []
        
        return sorted(c_files)
    
    def analyze_directory(self, directory):
        """디렉토리의 C 파일들을 분석"""
        print(f"디렉토리 분석: {directory}")
        
        c_files = self.find_c_files(directory)
        print(f"발견된 C/H 파일: {len(c_files)}개")
        
        if not c_files:
            print("C/H 파일이 없습니다.")
            return
        
        # SQLite3 관련 파일 찾기
        sqlite_files = [f for f in c_files if 'sqlite' in f.lower()]
        if sqlite_files:
            print(f"\nSQLite 관련 파일: {len(sqlite_files)}개")
            for f in sqlite_files[:5]:  # 처음 5개만
                print(f"  - {os.path.basename(f)}")
        
        # 첫 번째 파일 상세 분석
        if c_files:
            self.analyze_file(c_files[0])
        
        # 함수 포인터가 있는 파일들 찾기
        files_with_fps = []
        
        print(f"\n{'='*60}")
        print("전체 파일 스캔 (함수 포인터 포함 파일 찾기)")
        print(f"{'='*60}")
        
        fp_pattern = r'(\w+(?:\s*\*)*|void|unsigned\s+\w+)\s*\(\s*\*\s*(\w+)\s*\)\s*\([^;{}]*?\)\s*;'
        
        for i, file_path in enumerate(c_files[:20]):  # 처음 20개만
            try:
                with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                    content = f.read()
                
                fps = re.findall(fp_pattern, content, re.DOTALL)
                if fps:
                    files_with_fps.append((file_path, len(fps)))
                    print(f"  {os.path.basename(file_path)}: {len(fps)}개 함수 포인터")
                    
                    # 처음 몇 개 함수 포인터 이름 표시
                    for return_type, fp_name in fps[:3]:
                        print(f"    - {fp_name}")
                    if len(fps) > 3:
                        print(f"    ... 외 {len(fps)-3}개")
            
            except Exception as e:
                continue
        
        print(f"\n함수 포인터가 있는 파일: {len(files_with_fps)}개")

def main():
    import argparse
    
    parser = argparse.ArgumentParser(description='함수 포인터 디버깅 분석기')
    parser.add_argument('target', help='분석할 디렉토리 또는 파일 경로')
    parser.add_argument('--file', action='store_true', help='단일 파일 분석')
    
    args = parser.parse_args()
    
    if not os.path.exists(args.target):
        print(f"오류: 경로가 존재하지 않습니다: {args.target}")
        return
    
    analyzer = DebugFunctionPointerAnalyzer()
    
    if args.file or os.path.isfile(args.target):
        analyzer.analyze_file(args.target)
    else:
        analyzer.analyze_directory(args.target)

if __name__ == "__main__":
    main()