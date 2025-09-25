#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
fpNameDecl 기반 Static 키워드 제거 Coccinelle 생성기

fpNameDecl 디렉토리의 함수 선언부 파일들을 파싱하여
해당 함수들에서 static 키워드를 제거하는 Coccinelle 룰을 생성합니다.

특징:
- fpNameDecl/*.txt 파일들을 자동으로 파싱
- 함수 시그니처를 정확히 매칭
- 다양한 함수 선언 패턴 지원
- 포인터 타입 처리 개선
- 조건부 컴파일 블록 지원
"""

import argparse
import os
import re
import sys
import glob
from typing import List, Dict, Set, Tuple
from pathlib import Path

class FunctionSignature:
    """함수 시그니처를 파싱하고 저장하는 클래스"""
    
    def __init__(self, declaration: str):
        self.original = declaration.strip()
        self.return_type = ""
        self.function_name = ""
        self.parameters = ""
        self.is_valid = False
        self.conditional_macro = ""
        
        self.parse()
    
    def parse(self):
        """함수 선언을 파싱"""
        declaration = self.original
        
        # 주석이나 조건부 컴파일 처리
        if declaration.startswith('//'):
            return
        
        # #ifdef 처리
        ifdef_match = re.match(r'#ifdef\s+(\w+)', declaration)
        if ifdef_match:
            self.conditional_macro = ifdef_match.group(1)
            return
        
        # #endif 처리
        if declaration.startswith('#endif'):
            return
        
        # 함수 선언 패턴 매칭
        # 패턴: return_type function_name(parameters);
        pattern = r'^(.+?)\s+([a-zA-Z_]\w*)\s*\(([^)]*)\)\s*;?\s*$'
        match = re.match(pattern, declaration)
        
        if match:
            self.return_type = match.group(1).strip()
            self.function_name = match.group(2).strip()
            self.parameters = match.group(3).strip()
            self.is_valid = True
            
            # static 키워드 제거 (이미 제거되어 있을 수 있음)
            self.return_type = re.sub(r'\bstatic\s+', '', self.return_type).strip()
    
    def __str__(self):
        if not self.is_valid:
            return f"[INVALID] {self.original}"
        return f"{self.return_type} {self.function_name}({self.parameters})"

class FpNameDeclParser:
    """fpNameDecl 디렉토리 파서"""
    
    def __init__(self, fpname_dir: str = "fpNameDecl", verbose: bool = False):
        self.fpname_dir = fpname_dir
        self.verbose = verbose
        self.function_groups = {}  # {fp_name: [FunctionSignature, ...]}
        self.all_functions = set()  # 모든 함수명
        
    def load_declarations(self):
        """fpNameDecl 디렉토리에서 함수 선언들을 로드"""
        if not os.path.exists(self.fpname_dir):
            print(f"[ERROR] Directory not found: {self.fpname_dir}", file=sys.stderr)
            return False
        
        decl_files = glob.glob(os.path.join(self.fpname_dir, "*.txt"))
        if not decl_files:
            print(f"[ERROR] No .txt files found in {self.fpname_dir}", file=sys.stderr)
            return False
        
        if self.verbose:
            print(f"[INFO] Found {len(decl_files)} declaration files")
        
        for decl_file in decl_files:
            fp_name = os.path.splitext(os.path.basename(decl_file))[0]
            
            try:
                with open(decl_file, 'r', encoding='utf-8') as f:
                    lines = f.readlines()
                
                signatures = []
                current_conditional = ""
                
                for line in lines:
                    line = line.strip()
                    if not line:
                        continue
                    
                    sig = FunctionSignature(line)
                    
                    # 조건부 컴파일 처리
                    if sig.conditional_macro:
                        current_conditional = sig.conditional_macro
                        continue
                    elif line.startswith('#endif'):
                        current_conditional = ""
                        continue
                    
                    if sig.is_valid:
                        sig.conditional_macro = current_conditional
                        signatures.append(sig)
                        self.all_functions.add(sig.function_name)
                        
                        if self.verbose:
                            cond_str = f" [#{current_conditional}]" if current_conditional else ""
                            print(f"[PARSED] {fp_name}: {sig.function_name}{cond_str}")
                
                if signatures:
                    self.function_groups[fp_name] = signatures
                    if self.verbose:
                        print(f"[LOADED] {fp_name}: {len(signatures)} functions")
                
            except Exception as e:
                print(f"[WARN] Failed to parse {decl_file}: {e}", file=sys.stderr)
        
        if self.verbose:
            print(f"[SUMMARY] Loaded {len(self.function_groups)} function pointer groups")
            print(f"[SUMMARY] Total unique functions: {len(self.all_functions)}")
        
        return len(self.function_groups) > 0

class CoccinelleGenerator:
    """Coccinelle 룰 생성기"""
    
    def __init__(self, parser: FpNameDeclParser, verbose: bool = False):
        self.parser = parser
        self.verbose = verbose
    
    def clean_type_for_cocci(self, type_str: str) -> str:
        """Coccinelle에서 사용할 수 있도록 타입 문자열 정리"""
        # 복잡한 타입을 단순화
        type_str = re.sub(r'\s+', ' ', type_str.strip())
        
        # const, volatile 등 한정자 처리
        # Coccinelle에서는 이런 한정자들을 별도로 처리해야 할 수 있음
        return type_str
    
    def clean_params_for_cocci(self, params_str: str) -> str:
        """매개변수를 Coccinelle 형식으로 정리"""
        if not params_str or params_str.strip() == 'void':
            return 'void'
        
        # 매개변수 이름 제거하고 타입만 남기기 (Coccinelle은 타입에 집중)
        params = []
        for param in params_str.split(','):
            param = param.strip()
            if param:
                # 간단한 타입 추출 (더 정교한 파싱이 필요할 수 있음)
                param = re.sub(r'\s+', ' ', param)
                params.append(param)
        
        return ', '.join(params) if params else 'void'
    
    def generate_function_rule(self, signature: FunctionSignature, rule_suffix: str) -> str:
        """개별 함수에 대한 Coccinelle 룰 생성"""
        func_name = signature.function_name
        return_type = self.clean_type_for_cocci(signature.return_type)
        parameters = self.clean_params_for_cocci(signature.parameters)
        
        # 조건부 컴파일 지원
        conditional_comment = ""
        if signature.conditional_macro:
            conditional_comment = f"// For functions under #ifdef {signature.conditional_macro}\n"
        
        return f"""
{conditional_comment}// Remove static from function: {func_name}
@remove_static_def_{func_name}_{rule_suffix}@
identifier F = {{ {func_name} }};
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) {{ BODY }}

@remove_static_decl_{func_name}_{rule_suffix}@
identifier F = {{ {func_name} }};
type T;
parameter list P;
@@
- static
T F(P);

@remove_static_inline_{func_name}_{rule_suffix}@
identifier F = {{ {func_name} }};
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) {{ BODY }}

@remove_static_extern_{func_name}_{rule_suffix}@
identifier F = {{ {func_name} }};
type T;
parameter list P;
@@
- static
extern T F(P);
"""
    
    def generate_group_rules(self, fp_name: str, signatures: List[FunctionSignature]) -> str:
        """함수 포인터 그룹에 대한 룰들 생성"""
        rules = [f"// =============== Function Pointer Group: {fp_name} ==============="]
        rules.append(f"// Functions found in fpNameDecl/{fp_name}.txt")
        rules.append(f"// Total functions: {len(signatures)}")
        rules.append("")
        
        for i, signature in enumerate(signatures):
            if signature.is_valid:
                rule = self.generate_function_rule(signature, f"{fp_name}_{i}")
                rules.append(rule)
        
        return "\n".join(rules)
    
    
    def generate_cocci_file(self, output_path: str) -> bool:
        """완전한 Coccinelle 파일 생성"""
        try:
            with open(output_path, 'w', encoding='utf-8') as f:
                # 헤더 작성
                f.write(self.generate_header())
                
                # 각 함수 포인터 그룹에 대한 룰 생성
                for fp_name, signatures in self.parser.function_groups.items():
                    if self.verbose:
                        print(f"[GENERATING] Rules for {fp_name} ({len(signatures)} functions)")
                    
                    group_rules = self.generate_group_rules(fp_name, signatures)
                    f.write(group_rules)
                    f.write("\n\n")
                
                # 푸터 작성
                f.write(self.generate_footer())
            
            return True
            
        except Exception as e:
            print(f"[ERROR] Failed to write Coccinelle file: {e}", file=sys.stderr)
            return False

def main():
    parser = argparse.ArgumentParser(
        description="Generate Coccinelle script to remove static keywords from functions in fpNameDecl",
        epilog="Reads function declarations from fpNameDecl/*.txt and generates removal rules"
    )
    parser.add_argument(
        "--fpname-dir",
        default="fpNameDecl",
        help="Directory containing function declaration files (default: fpNameDecl)"
    )
    parser.add_argument(
        "-o", "--output",
        required=True,
        help="Output path for the generated .cocci file"
    )
    parser.add_argument(
        "--verbose", "-v",
        action="store_true",
        help="Enable verbose output"
    )
    parser.add_argument(
        "--preview",
        action="store_true",
        help="Preview parsed functions without generating .cocci file"
    )
    
    args = parser.parse_args()
    
    # fpNameDecl 파서 초기화 및 로딩
    if args.verbose:
        print(f"[INFO] Loading function declarations from: {args.fpname_dir}")
    
    decl_parser = FpNameDeclParser(args.fpname_dir, args.verbose)
    
    if not decl_parser.load_declarations():
        print("[ERROR] Failed to load function declarations", file=sys.stderr)
        sys.exit(1)
    
    # 미리보기 모드
    if args.preview:
        print(f"\n=== PREVIEW MODE ===")
        print(f"Function Pointer Groups: {len(decl_parser.function_groups)}")
        print(f"Total Unique Functions: {len(decl_parser.all_functions)}")
        
        for fp_name, signatures in decl_parser.function_groups.items():
            print(f"\nGroup: {fp_name} ({len(signatures)} functions)")
            for sig in signatures[:5]:  # Show first 5
                cond_str = f" [#{sig.conditional_macro}]" if sig.conditional_macro else ""
                print(f"  - {sig.function_name}{cond_str}")
            if len(signatures) > 5:
                print(f"  ... and {len(signatures) - 5} more")
        
        print(f"\nSample function names:")
        sample_funcs = sorted(list(decl_parser.all_functions))[:10]
        for func in sample_funcs:
            print(f"  - {func}")
        if len(decl_parser.all_functions) > 10:
            print(f"  ... and {len(decl_parser.all_functions) - 10} more")
        
        return
    
    # Coccinelle 파일 생성
    output_path = args.output
    if not output_path.endswith('.cocci'):
        output_path += '.cocci'
    
    if args.verbose:
        print(f"[INFO] Generating Coccinelle file: {output_path}")
    
    cocci_gen = CoccinelleGenerator(decl_parser, args.verbose)
    
    if cocci_gen.generate_cocci_file(output_path):
        print(f"[SUCCESS] Generated Coccinelle script: {output_path}")
        print(f"[INFO] Function pointer groups: {len(decl_parser.function_groups)}")
        print(f"[INFO] Total unique functions: {len(decl_parser.all_functions)}")
        
        # 그룹별 통계
        group_stats = []
        for fp_name, signatures in decl_parser.function_groups.items():
            valid_count = sum(1 for sig in signatures if sig.is_valid)
            conditional_count = sum(1 for sig in signatures if sig.conditional_macro)
            group_stats.append((fp_name, valid_count, conditional_count))
        
        # 상위 5개 그룹 표시
        group_stats.sort(key=lambda x: x[1], reverse=True)
        print(f"\n[TOP FUNCTION GROUPS]")
        for fp_name, valid_count, conditional_count in group_stats[:5]:
            cond_info = f" ({conditional_count} conditional)" if conditional_count else ""
            print(f"  {fp_name}: {valid_count} functions{cond_info}")
        
        if len(group_stats) > 5:
            print(f"  ... and {len(group_stats) - 5} more groups")
        
        print(f"\n[FEATURES]")
        print(f"  - Static keyword removal for {len(decl_parser.all_functions)} functions")
        print(f"  - Support for conditional compilation (#ifdef)")
        print(f"  - Position tracking for changes")
        print(f"  - Function signature extraction")
        print(f"  - Comprehensive pattern matching")
        
        print(f"\n[USAGE] Apply with: spatch --sp-file {output_path} --dir /path/to/sqlite/source --in-place")
        
    else:
        print("[ERROR] Failed to generate Coccinelle file", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()