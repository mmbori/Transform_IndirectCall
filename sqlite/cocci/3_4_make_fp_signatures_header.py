#!/usr/bin/env python3
"""
함수 포인터 시그니처 헤더/C 파일 생성기 (분리 버전)
- remove_fn_list.txt의 함수들을 제외
- .h 파일: 선언, enum, 전역 배열 선언
- .c 파일: 함수 정의 (init 함수들)
"""

import os
import random
import re
from pathlib import Path
from typing import List, Set


# 제외할 함수명 접두사 목록
# SKIP_SUBSTRS = ("quota", "fts5", "multiplex", "amatch", "binfo", "carray", "cf", 
#                 "cidx", "cksm", "closure", "csvtab", "deltaparsevtab", "demo", "devsym", 
#                 "echo", "explain", "faultsim", "fts3", "fuzzer", "geopoly", "icu", 
#                 "intarray", "jt", "kvv", "prefixes", "qpvtab", "rbuVfs", "schema", 
#                 "spell", "tcl", "templatevtab", "testTokenizer", "testpcache", "tmp", "tvfs", 
#                 "union", "vfslog", "vstat", "vtablog", "wholenumber", "win", "wr", "writecrash")
# SKIP_SUBSTRS = ("quota", "fts5", "multiplex")
SKIP_SUBSTRS = ("quota", "multiplex")

class SplitSignatureGenerator:
    def __init__(self, fp_name_dir: str, fp_name_decl_dir: str, 
                 remove_list_file: str = "remove_fn_list.txt",
                 output_header: str = "sqlite_fp_signature_header.h",
                 output_source: str = "sqlite_fp_signature_impl.c"):
        self.fp_name_dir = Path(fp_name_dir)
        self.fp_name_decl_dir = Path(fp_name_decl_dir)
        self.remove_list_file = Path(remove_list_file)
        self.output_header = output_header
        self.output_source = output_source
        self.processed_fps = []
        self.excluded_fps = []
        self.removed_functions = set()
        
        # remove_fn_list.txt 로드
        self.load_remove_list()
        
    def load_remove_list(self):
        """remove_fn_list.txt에서 제외할 함수 목록 로드"""
        if not self.remove_list_file.exists():
            print(f"경고: {self.remove_list_file} 파일이 없습니다. 제외 없이 진행합니다.")
            return
        
        try:
            with open(self.remove_list_file, 'r', encoding='utf-8', errors='ignore') as f:
                for line in f:
                    line = line.strip()
                    if line and not line.startswith('#') and not line.startswith('//'):
                        func_name = re.sub(r'[^\w]', '', line)
                        if func_name:
                            self.removed_functions.add(func_name)
            
            print(f"제외할 함수 목록 로드 완료: {len(self.removed_functions)}개")
            
        except Exception as e:
            print(f"remove_fn_list.txt 로드 오류: {e}")

    def should_skip_function(self, func_name: str) -> tuple[bool, str]:
        """
        함수를 스킵해야 하는지 확인
        Returns: (skip_flag, reason)
        """
        # x로 시작하는 함수 제외
        if func_name.startswith('x'):
            return True, "x로 시작"
        
        # remove_list에 있는 함수 제외
        if func_name in self.removed_functions:
            return True, "remove_list"
        
        # SKIP_SUBSTRS로 시작하는 함수 제외
        for skip_prefix in SKIP_SUBSTRS:
            if func_name.startswith(skip_prefix):
                return True, f"SKIP_SUBSTRS ({skip_prefix})"
        
        return False, ""
    
    def find_txt_files(self) -> List[Path]:
        """fpName 디렉토리에서 모든 txt 파일 찾기"""
        txt_files = list(self.fp_name_dir.glob("*.txt"))
        return sorted(txt_files)
    
    def parse_function_list(self, txt_file: Path) -> List[str]:
        """txt 파일에서 함수 목록 파싱 (여러 조건으로 필터링)"""
        try:
            with open(txt_file, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            functions = []
            exclusion_stats = {
                "x로 시작": 0,
                "remove_list": 0,
            }
            # SKIP_SUBSTRS 각각에 대한 카운터 초기화
            for prefix in SKIP_SUBSTRS:
                exclusion_stats[f"SKIP_SUBSTRS ({prefix})"] = 0
            
            for line in content.split('\n'):
                line = line.strip()
                if line and not line.startswith('#') and not line.startswith('//'):
                    func_name = re.sub(r'[^\w]', '', line)
                    
                    if not func_name:
                        continue
                    
                    # 함수 스킵 체크
                    should_skip, reason = self.should_skip_function(func_name)
                    if should_skip:
                        exclusion_stats[reason] += 1
                        continue
                    
                    functions.append(func_name)
            
            # 0만 남은 경우는 빈 리스트 반환
            if len(functions) == 1 and functions[0] == '0':
                print(f"  건너뜀: 0만 있음")
                return []
            
            # 제외 통계 출력
            total_excluded = sum(exclusion_stats.values())
            if total_excluded > 0:
                print(f"  제외된 함수 총 {total_excluded}개:")
                for reason, count in exclusion_stats.items():
                    if count > 0:
                        print(f"    - {reason}: {count}개")
            
            return functions
            
        except Exception as e:
            print(f"파일 파싱 오류 {txt_file}: {e}")
            return []
    
    def generate_header_content(self, fp_name: str, functions: List[str]) -> str:
        """헤더 파일 내용 생성 (선언만)"""
        if not functions:
            return ""
        
        lines = []
        lines.append(f"// =============== {fp_name} ===============")
        
        # 1. 전역 배열 선언 (extern)
        lines.append(f"// {fp_name} function pointer signatures (extern)")
        lines.append(f"static int {fp_name}_signatures[{len(functions)}][4] = {{0,}};")
        lines.append("")
        
        # 2. enum
        lines.append(f"// {fp_name} function enumeration")
        lines.append(f"typedef enum {{")
        for i, func in enumerate(functions):
            comma = "," if i < len(functions) - 1 else ""
            lines.append(f"    {fp_name}_{func}_enum = {i}{comma}")
        lines.append(f"}} {fp_name}_enum;")
        lines.append("")
        
        # 3. 초기화 함수 선언
        lines.append(f"// {fp_name} signature initialization function")
        lines.append(f"void init_{fp_name}_signatures(void);")
        lines.append("")
        
        return "\n".join(lines)
    
    def generate_source_content(self, fp_name: str, functions: List[str]) -> str:
        """C 파일 내용 생성 (정의만)"""
        if not functions:
            return ""
        
        lines = []
        lines.append(f"// =============== {fp_name} ===============")
        
        # 1. 전역 배열 정의
        lines.append(f"// {fp_name} function pointer signatures (definition)")
        # lines.append(f"int {fp_name}_signatures[{len(functions)}][4] = {{0, }};")
        lines.append("")
        
        # 2. 초기화 함수 정의
        lines.append(f"// {fp_name} signature initialization function")
        lines.append(f"void init_{fp_name}_signatures(void) {{")
        lines.append("    static int initialized = 0;")
        lines.append("    if (initialized) return;")
        lines.append("    initialized = 1;")
        lines.append("")
        lines.append(f"    // Fill all signatures with random data")
        lines.append(f"    unsigned char* ptr = (unsigned char*){fp_name}_signatures;")
        lines.append(f"    size_t total_size = sizeof({fp_name}_signatures);")
        lines.append(f"    for (size_t i = 0; i < total_size; i++) {{")
        lines.append(f"        ptr[i] = (unsigned char)(rand() & 0xFF);")
        lines.append(f"    }}")
        lines.append("")
        
        # 각 함수 시그니처 정보 주석
        for i, func in enumerate(functions):
            lines.append(f"    // {fp_name}_signatures[{i}] = {func}")
        
        lines.append("}")
        lines.append("")
        
        return "\n".join(lines)
    
    def clean_function_declarations(self, content: str) -> str:
        """함수 선언 정리"""
        lines = content.split('\n')
        cleaned_lines = []
        
        for line in lines:
            stripped = line.strip()
            
            # 조건부 컴파일 지시문 제거
            if (stripped.startswith('#ifdef') or 
                stripped.startswith('#ifndef') or 
                stripped.startswith('#endif') or 
                stripped.startswith('endif') or 
                stripped.startswith('#else') or 
                stripped.startswith('#elif') or
                stripped.startswith('#if ')):
                continue
            
            if '선언을 찾을 수 없음' in line:
                continue
            
            # static 제거
            if 'static' in line:
                line = re.sub(r'\bstatic\s+', '', line)
            
            if stripped:
                cleaned_lines.append(line)
        
        return '\n'.join(cleaned_lines)
    
    def parse_declarations(self, fp_name: str, functions: List[str]) -> str:
        """함수 선언부 파싱 (remove_list 함수들 제외)"""
        decl_file = self.fp_name_decl_dir / f"{fp_name}.txt"
        
        if not decl_file.exists():
            print(f"선언 파일 없음: {decl_file}")
            return f"// No declaration file found for {fp_name}\n"
        
        try:
            with open(decl_file, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            cleaned_content = self.clean_function_declarations(content)
            
            lines = cleaned_content.split('\n')
            cleaned_lines = []
            
            # remove_list에 있는 함수의 선언 제외
            for line in lines:
                stripped = line.strip()
                if not stripped or stripped.startswith('//'):
                    continue
                
                # 라인에 remove_list의 함수가 포함되어 있는지 확인
                should_exclude = False
                for removed_func in self.removed_functions:
                    if removed_func in line:
                        should_exclude = True
                        break
                
                if not should_exclude:
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
    
    def generate_files(self):
        """헤더 파일과 C 파일 생성"""
        print("함수 포인터 시그니처 파일 생성 시작...")
        
        txt_files = self.find_txt_files()
        if not txt_files:
            print(f"오류: {self.fp_name_dir}에서 txt 파일을 찾을 수 없습니다.")
            return
        
        print(f"발견된 txt 파일: {len(txt_files)}개")
        
        # 헤더 파일 내용
        header_content = []
        header_content.append(f"""#ifndef SQLITE_FP_SIGNATURE_HEADER_H
#define SQLITE_FP_SIGNATURE_HEADER_H

/*
 * SQLite Function Pointer Signatures - Header
 * Auto-generated file - DO NOT EDIT MANUALLY
 */

#include <stdlib.h>
#include <time.h>
#include <string.h>

#include "sqliteInt.h"

typedef struct MemPage MemPage;
typedef struct BtLock BtLock;
typedef struct Btree Btree;
typedef struct BtShared BtShared;
typedef struct CellInfo CellInfo;
typedef struct BtCursor BtCursor;
typedef struct IntegrityCk IntegrityCk;
typedef struct sqlite3_tokenizer_module sqlite3_tokenizer_module;
typedef struct sqlite3_tokenizer sqlite3_tokenizer;
typedef struct sqlite3_tokenizer_cursor sqlite3_tokenizer_cursor;
typedef struct Fts5Index Fts5Index;
typedef struct Fts5Iter Fts5Iter;
typedef struct Fts5Buffer Fts5Buffer;
typedef struct Fts5Expr Fts5Expr;
typedef struct Fts5ExprNode Fts5ExprNode;
typedef struct Fts5SegIter Fts5SegIter;
typedef struct ReInput ReInput;
                              

#ifndef SIGNATURE_ASSIGN
#define SIGNATURE_ASSIGN(struct_var, fp_name, func_name) \\
  do {{ \\
    (struct_var).fp_name##_signature[0] = fp_name##_signatures[fp_name##_##func_name##_enum][0]; \\
    (struct_var).fp_name##_signature[1] = fp_name##_signatures[fp_name##_##func_name##_enum][1]; \\
    (struct_var).fp_name##_signature[2] = fp_name##_signatures[fp_name##_##func_name##_enum][2]; \\
    (struct_var).fp_name##_signature[3] = fp_name##_signatures[fp_name##_##func_name##_enum][3]; \\
  }} while(0)
#endif

int vfstraceOut(const char *z, void *pArg)
""")
        
        # C 파일 내용
        source_content = []
        source_content.append(f"""/*
 * SQLite Function Pointer Signatures - Implementation
 * Auto-generated file - DO NOT EDIT MANUALLY
 */

#include "{self.output_header}"

""")
        
        # 각 함수 포인터 처리
        init_functions = []
        
        for txt_file in txt_files:
            fp_name = txt_file.stem
            print(f"처리 중: {fp_name}")
            
            functions = self.parse_function_list(txt_file)
            if not functions:
                print(f"  함수 없음: {fp_name}")
                self.excluded_fps.append(fp_name)
                continue
            
            print(f"  포함: {fp_name} - {len(functions)}개 함수")
            
            # 헤더에 추가
            header_content.append(self.generate_header_content(fp_name, functions))
            
            # 함수 선언 추가 (헤더)
            declarations = self.parse_declarations(fp_name, functions)
            header_content.append(declarations)
            
            # C 파일에 추가
            source_content.append(self.generate_source_content(fp_name, functions))
            
            init_functions.append(fp_name)
            self.processed_fps.append({
                'name': fp_name,
                'function_count': len(functions),
                'functions': functions
            })
        
        # 전역 초기화 함수
        if init_functions:
            # 헤더: 선언
            header_content.append("// Global initialization function\n")
            header_content.append("static int signatures_initialized = 0;\n")
            header_content.append("void init_all_fp_signatures(void);\n")
            header_content.append("")
            
            # C 파일: 정의
            source_content.append("// Global initialization function\n")
            source_content.append("void init_all_fp_signatures(void) {\n")
            source_content.append("    if(signatures_initialized) return;  // 이미 초기화됨\n")
            source_content.append("    static int global_initialized = 0;\n")
            source_content.append("    if (global_initialized) return;\n")
            source_content.append("    global_initialized = 1;\n")
            source_content.append("")
            source_content.append("    srand((unsigned int)time(NULL));\n")
            source_content.append("")
            
            for fp_name in init_functions:
                source_content.append(f"    init_{fp_name}_signatures();\n")
            source_content.append("")
            source_content.append("    signatures_initialized = 1;\n")
            
            source_content.append("}")
            source_content.append("")
        
        # 헤더 파일 푸터
        header_content.append("\n#endif /* SQLITE_FP_SIGNATURE_HEADER_H */\n")
        
        # 파일 저장
        try:
            # 헤더 파일
            with open(self.output_header, 'w', encoding='utf-8') as f:
                f.write(''.join(header_content))
            print(f"\n헤더 파일 생성 완료: {self.output_header}")
            
            # C 파일
            with open(self.output_source, 'w', encoding='utf-8') as f:
                f.write(''.join(source_content))
            print(f"C 파일 생성 완료: {self.output_source}")
            
            self.print_statistics()
            
        except Exception as e:
            print(f"파일 저장 오류: {e}")
    
    def print_statistics(self):
        """생성 통계 출력"""
        print("\n=== 생성 통계 ===")
        print(f"처리된 함수 포인터 타입: {len(self.processed_fps)}개")
        print(f"제외된 함수 포인터 타입: {len(self.excluded_fps)}개")
        print(f"remove_list에서 제외된 함수: {len(self.removed_functions)}개")
        
        print(f"\n포함된 함수 포인터:")
        total_functions = 0
        for fp_info in self.processed_fps:
            print(f"  {fp_info['name']}: {fp_info['function_count']}개 함수")
            total_functions += fp_info['function_count']
        
        print(f"\n이 함수 개수: {total_functions}개")
        print(f"헤더 파일: {self.output_header}")
        print(f"C 파일: {self.output_source}")

def main():
    import argparse
    
    parser = argparse.ArgumentParser(
        description='함수 포인터 시그니처 헤더/C 파일 생성기 (분리 버전, remove_list 지원)'
    )
    
    parser.add_argument('fp_name_dir', help='함수 포인터 이름 디렉토리')
    parser.add_argument('fp_name_decl_dir', help='함수 포인터 선언 디렉토리')
    parser.add_argument('-r', '--remove-list', default='remove_fn_list.txt',
                       help='제외할 함수 목록 파일 (기본: remove_fn_list.txt)')
    parser.add_argument('-oh', '--output-header', default='sqlite_fp_signature_header.h',
                       help='출력 헤더 파일명')
    parser.add_argument('-oc', '--output-source', default='sqlite_fp_signature_impl.c',
                       help='출력 C 파일명')
    parser.add_argument('--seed', type=int, help='랜덤 시드')
    
    args = parser.parse_args()
    
    if not os.path.exists(args.fp_name_dir):
        print(f"오류: fpName 디렉토리가 존재하지 않습니다: {args.fp_name_dir}")
        return
    
    if not os.path.exists(args.fp_name_decl_dir):
        print(f"오류: fpNameDecl 디렉토리가 존재하지 않습니다: {args.fp_name_decl_dir}")
        return
    
    if args.seed:
        random.seed(args.seed)
        print(f"랜덤 시드 설정: {args.seed}")
    
    generator = SplitSignatureGenerator(
        args.fp_name_dir,
        args.fp_name_decl_dir,
        args.remove_list,
        args.output_header,
        args.output_source
    )
    
    confirm = input("헤더 파일과 C 파일을 생성하시겠습니까? (y/N): ")
    if confirm.lower() in ['y', 'yes']:
        generator.generate_files()
    else:
        print("취소되었습니다.")

if __name__ == "__main__":
    main()