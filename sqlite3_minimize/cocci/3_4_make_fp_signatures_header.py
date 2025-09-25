#!/usr/bin/env python3
"""
개선된 함수 포인터 시그니처 헤더 생성기
fpName 디렉토리의 txt 파일들을 기반으로 시그니처 테이블과 enum을 생성
- "선언을 찾을 수 없음" 구문이 있는 함수 포인터 제외
- static 키워드 제거
"""

import os
import random
import re
from pathlib import Path
from typing import List, Tuple, Dict, Set

class ImprovedFunctionPointerSignatureGenerator:
    def __init__(self, fp_name_dir: str, fp_name_decl_dir: str, output_file: str = "sqlite_fp_signature_header.h"):
        self.fp_name_dir = Path(fp_name_dir)
        self.fp_name_decl_dir = Path(fp_name_decl_dir)
        self.output_file = output_file
        self.processed_fps = []
        self.excluded_fps = []
        
    def find_txt_files(self) -> List[Path]:
        """fpName 디렉토리에서 모든 txt 파일 찾기"""
        txt_files = list(self.fp_name_dir.glob("*.txt"))
        return sorted(txt_files)
    
    def check_missing_declarations(self, fp_name: str) -> bool:
        """fpNameDecl에서 "선언을 찾을 수 없음" 구문이 있는지 확인"""
        decl_file = self.fp_name_decl_dir / f"{fp_name}.txt"
        
        if not decl_file.exists():
            print(f"  선언 파일 없음: {fp_name}")
            return True  # 선언 파일이 없으면 제외
        
        try:
            with open(decl_file, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            # "선언을 찾을 수 없음" 패턴 검색
            missing_pattern = re.compile(r'// 선언을 찾을 수 없음:\s*(\w+)')
            missing_functions = missing_pattern.findall(content)
            
            if missing_functions:
                print(f"  제외: {fp_name} - {len(missing_functions)}개 함수의 선언 누락")
                return True
            
            return False
            
        except Exception as e:
            print(f"  오류: {fp_name} - {e}")
            return True  # 오류가 있으면 제외
    
    def parse_function_list(self, txt_file: Path) -> List[str]:
        """txt 파일에서 함수 목록 파싱"""
        try:
            with open(txt_file, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            # 빈 줄과 주석 제거, 함수명만 추출
            functions = []
            for line in content.split('\n'):
                line = line.strip()
                if line and not line.startswith('#') and not line.startswith('//'):
                    # 함수명만 추출 (괄호나 기타 문자 제거)
                    func_name = re.sub(r'[^\w]', '', line)
                    if func_name:
                        functions.append(func_name)
            
            return functions
            
        except Exception as e:
            print(f"파일 파싱 오류 {txt_file}: {e}")
            return []
    
    def generate_global_init_function(self, init_functions: List[str]) -> str:
        """전역 초기화 함수 생성"""
        lines = []
        lines.append("// Global initialization function for all signatures")
        lines.append("void init_all_fp_signatures(void) {")
        lines.append("    static int global_initialized = 0;")
        lines.append("    if (global_initialized) return;")
        lines.append("    global_initialized = 1;")
        lines.append("")
        lines.append("    // Seed the random number generator")
        lines.append("    srand((unsigned int)time(NULL));")
        lines.append("")
        
        for fp_name in init_functions:
            lines.append(f"    init_{fp_name}_signatures();")
        
        lines.append("}")
        lines.append("")
        
        # 각 개별 초기화 함수 선언도 추가
        lines.append("// Individual initialization function declarations")
        for fp_name in init_functions:
            lines.append(f"static void init_{fp_name}_signatures(void);")
        lines.append("")
        
        return "\n".join(lines)
    
    def generate_signature_table(self, fp_name: str, functions: List[str]) -> str:
        """시그니처 테이블 생성 (런타임 초기화 - 효율적인 바이트 채우기 방식)"""
        if not functions:
            return ""
        
        lines = []
        lines.append(f"// =============== {fp_name} ===============")
        lines.append(f"// {fp_name} function pointer signatures")
        lines.append(f"static int {fp_name}_signatures[{len(functions)}][4];")
        lines.append(f"// {fp_name} signature initialization function")
        lines.append(f"static void init_{fp_name}_signatures(void) {{")
        lines.append("    static int initialized = 0;")
        lines.append("    if (initialized) return;")
        lines.append("    initialized = 1;")
        lines.append("")
        
        # 전체 배열을 한 번에 랜덤으로 채우기
        lines.append(f"    // Fill all signatures with random data")
        lines.append(f"    unsigned char* ptr = (unsigned char*){fp_name}_signatures;")
        lines.append(f"    size_t total_size = sizeof({fp_name}_signatures);")
        lines.append(f"    for (size_t i = 0; i < total_size; i++) {{")
        lines.append(f"        ptr[i] = (unsigned char)(rand() & 0xFF);")
        lines.append(f"    }}")
        lines.append("")
        
        # 각 함수 시그니처 정보 주석으로 추가
        for i, func in enumerate(functions):
            lines.append(f"    // {fp_name}_signatures[{i}] = {func}")
        
        lines.append("}")
        lines.append("")
        
        return "\n".join(lines)
    
    def generate_enum(self, fp_name: str, functions: List[str]) -> str:
        """enum 생성"""
        if not functions:
            return ""
        
        lines = []
        lines.append(f"// {fp_name} function enumeration")
        lines.append(f"typedef enum {{")
        
        for i, func in enumerate(functions):
            comma = "," if i < len(functions) - 1 else ""
            lines.append(f"    {fp_name}_{func}_enum = {i}{comma}")
        
        lines.append(f"}} {fp_name}_enum;")
        lines.append("\n\n")
        
        return "\n".join(lines)
    
    def clean_function_declarations(self, content: str) -> str:
        """함수 선언 정리 - 조건부 컴파일 지시문 및 static 키워드 제거"""
        lines = content.split('\n')
        cleaned_lines = []
        
        for line in lines:
            stripped = line.strip()
            
            # 조건부 컴파일 지시문들 제거
            if (stripped.startswith('#ifdef') or 
                stripped.startswith('#ifndef') or 
                stripped.startswith('#endif') or 
                stripped.startswith('endif') or 
                stripped.startswith('#else') or 
                stripped.startswith('#elif') or
                stripped.startswith('#if ')):
                continue
            
            # "선언을 찾을 수 없음" 라인 제거
            if '선언을 찾을 수 없음' in line:
                continue
            
            # static 키워드 제거
            if 'static' in line:
                line = re.sub(r'\bstatic\s+', '', line)
            
            # 유효한 라인만 추가
            if stripped:
                cleaned_lines.append(line)
        
        return '\n'.join(cleaned_lines)
    
    def parse_declarations(self, fp_name: str) -> str:
        """fpNameDecl 디렉토리에서 선언부 파싱 (누락된 선언 제외)"""
        decl_file = self.fp_name_decl_dir / f"{fp_name}.txt"
        
        if not decl_file.exists():
            print(f"선언 파일 없음: {decl_file}")
            return f"// No declaration file found for {fp_name}\n"
        
        try:
            with open(decl_file, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            # 함수 선언 정리
            cleaned_content = self.clean_function_declarations(content)
            
            # 빈 줄 정리
            lines = cleaned_content.split('\n')
            cleaned_lines = []
            for line in lines:
                stripped = line.strip()
                if stripped and not stripped.startswith('//'):  # 주석 라인도 제거
                    cleaned_lines.append(line)
            
            if cleaned_lines:
                result = f"// {fp_name} function declarations\n"
                result += '\n'.join(cleaned_lines)
                result += '\n\n'
                return result
            else:
                return f"// No valid declarations found for {fp_name}\n"
                
        except Exception as e:
            print(f"선언 파일 파싱 오류 {decl_file}: {e}")
            return f"// Error parsing declarations for {fp_name}: {e}\n"
    
    def generate_header_file(self):
        """최종 헤더 파일 생성"""
        print("개선된 함수 포인터 시그니처 헤더 생성 시작...")
        
        # txt 파일들 찾기
        txt_files = self.find_txt_files()
        if not txt_files:
            print(f"오류: {self.fp_name_dir}에서 txt 파일을 찾을 수 없습니다.")
            return
        
        print(f"발견된 txt 파일: {len(txt_files)}개")
        
        # 헤더 파일 내용 생성
        header_content = []
        
        # 파일 헤더
        header_content.append(f"""#ifndef SQLITE_FP_SIGNATURE_HEADER_H
#define SQLITE_FP_SIGNATURE_HEADER_H

/*
 * SQLite Function Pointer Signatures
 * Auto-generated file - DO NOT EDIT MANUALLY
 * Generated from fpName directory: {self.fp_name_dir}
 * Excludes function pointers with missing declarations
 */

#include <stdlib.h>
#include <time.h>
#include <string.h>

""")

        # 전역 초기화 함수들 선언
        init_functions = []
        
        # 각 txt 파일 처리
        for txt_file in txt_files:
            fp_name = txt_file.stem  # 파일명에서 확장자 제거
            print(f"처리 중: {fp_name}")
            
            # 1. 선언 누락 여부 확인
            if self.check_missing_declarations(fp_name):
                self.excluded_fps.append(fp_name)
                continue
            
            # 2. 함수 목록 파싱
            functions = self.parse_function_list(txt_file)
            if not functions:
                print(f"  함수 없음: {fp_name}")
                self.excluded_fps.append(fp_name)
                continue
            
            print(f"  포함: {fp_name} - {len(functions)}개 함수")
            
            # 3. 시그니처 테이블 생성
            signature_table = self.generate_signature_table(fp_name, functions)
            header_content.append(signature_table)
            
            # 4. enum 생성
            enum_content = self.generate_enum(fp_name, functions)
            header_content.append(enum_content)
            
            # 5. 선언부 추가
            declarations = self.parse_declarations(fp_name)
            header_content.append(declarations)
            
            # 초기화 함수 목록에 추가
            init_functions.append(fp_name)
            
            self.processed_fps.append({
                'name': fp_name,
                'function_count': len(functions),
                'functions': functions
            })
        
        # 전역 초기화 함수 생성
        if init_functions:
            header_content.append(self.generate_global_init_function(init_functions))
        
        # 파일 푸터
        header_content.append("""
#endif /* SQLITE_FP_SIGNATURE_HEADER_H */
""")
        
        # 파일 저장
        try:
            with open(self.output_file, 'w', encoding='utf-8') as f:
                f.write(''.join(header_content))
            
            print(f"\n헤더 파일 생성 완료: {self.output_file}")
            self.print_statistics()
            
        except Exception as e:
            print(f"파일 저장 오류: {e}")
    
    def print_statistics(self):
        """생성 통계 출력"""
        print("\n=== 생성 통계 ===")
        print(f"처리된 함수 포인터 타입: {len(self.processed_fps)}개")
        print(f"제외된 함수 포인터 타입: {len(self.excluded_fps)}개")
        
        if self.excluded_fps:
            print(f"\n제외된 함수 포인터:")
            for fp_name in sorted(self.excluded_fps)[:10]:  # 처음 10개만 표시
                print(f"  - {fp_name}")
            if len(self.excluded_fps) > 10:
                print(f"  ... 외 {len(self.excluded_fps) - 10}개")
        
        print(f"\n포함된 함수 포인터:")
        total_functions = 0
        for fp_info in self.processed_fps:
            print(f"  {fp_info['name']}: {fp_info['function_count']}개 함수")
            total_functions += fp_info['function_count']
        
        print(f"\n총 함수 개수: {total_functions}개")
        print(f"출력 파일: {self.output_file}")
    
    def preview_files(self):
        """처리할 파일들 미리보기"""
        print("=== 파일 미리보기 ===")
        print(f"fpName 디렉토리: {self.fp_name_dir}")
        print(f"fpNameDecl 디렉토리: {self.fp_name_decl_dir}")
        
        txt_files = self.find_txt_files()
        print(f"\n발견된 txt 파일: {len(txt_files)}개")
        
        included_count = 0
        excluded_count = 0
        
        for txt_file in txt_files:
            fp_name = txt_file.stem
            functions = self.parse_function_list(txt_file)
            decl_file = self.fp_name_decl_dir / f"{fp_name}.txt"
            
            # 선언 파일 존재 여부 확인
            if not decl_file.exists():
                status = "✗ (선언파일 없음)"
                excluded_count += 1
            else:
                # "선언을 찾을 수 없음" 구문 확인
                has_missing = self.check_missing_declarations(fp_name)
                if has_missing:
                    status = "✗ (선언 누락)"
                    excluded_count += 1
                else:
                    status = "✓ (포함)"
                    included_count += 1
            
            print(f"  {fp_name}: {len(functions)}개 함수, {status}")
        
        print(f"\n요약:")
        print(f"  포함될 함수 포인터: {included_count}개")
        print(f"  제외될 함수 포인터: {excluded_count}개")

def main():
    import argparse
    
    parser = argparse.ArgumentParser(
        description='개선된 함수 포인터 시그니처 헤더 파일 생성기',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
예제 사용법:
  python script.py fpName fpNameDecl
  python script.py fpName fpNameDecl -o custom_header.h
  python script.py fpName fpNameDecl --preview

개선사항:
  - "선언을 찾을 수 없음" 구문이 있는 함수 포인터 자동 제외
  - static 키워드 자동 제거
  - 더 정확한 선언 정리
        """
    )
    
    parser.add_argument('fp_name_dir', help='함수 포인터 이름 디렉토리 (txt 파일들)')
    parser.add_argument('fp_name_decl_dir', help='함수 포인터 선언 디렉토리 (txt 파일들)')
    parser.add_argument('-o', '--output', default='sqlite_fp_signature_header.h',
                       help='출력 헤더 파일명 (기본: sqlite_fp_signature_header.h)')
    parser.add_argument('--preview', action='store_true',
                       help='실제 생성 없이 파일들만 미리보기')
    parser.add_argument('--seed', type=int, help='랜덤 시드 (재현 가능한 결과)')
    
    args = parser.parse_args()
    
    # 디렉토리 존재 확인
    if not os.path.exists(args.fp_name_dir):
        print(f"오류: fpName 디렉토리가 존재하지 않습니다: {args.fp_name_dir}")
        return
    
    if not os.path.exists(args.fp_name_decl_dir):
        print(f"오류: fpNameDecl 디렉토리가 존재하지 않습니다: {args.fp_name_decl_dir}")
        return
    
    # 랜덤 시드 설정
    if args.seed:
        random.seed(args.seed)
        print(f"랜덤 시드 설정: {args.seed}")
    
    # 생성기 초기화
    generator = ImprovedFunctionPointerSignatureGenerator(
        args.fp_name_dir,
        args.fp_name_decl_dir,
        args.output
    )
    
    if args.preview:
        generator.preview_files()
    else:
        # 확인 메시지
        print(f"헤더 파일을 생성합니다: {args.output}")
        print("주의: '선언을 찾을 수 없음' 구문이 있는 함수 포인터는 제외됩니다.")
        confirm = input("계속하시겠습니까? (y/N): ")
        if confirm.lower() in ['y', 'yes']:
            generator.generate_header_file()
        else:
            print("취소되었습니다.")

if __name__ == "__main__":
    main()