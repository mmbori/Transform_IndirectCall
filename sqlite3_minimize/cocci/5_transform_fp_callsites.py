#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Generate a Coccinelle script that transforms function pointer return statements:

Original:
  return E->fp_name(args);

Transformed to:
  if (memcmp(E->fp_name_signature, fp_name_signatures[fp_name_func1_enum], sizeof(E->fp_name_signature)) == 0) {
      return func1(args);
  }
  if (memcmp(E->fp_name_signature, fp_name_signatures[fp_name_func2_enum], sizeof(E->fp_name_signature)) == 0) {
      return func2(args);
  }
  ...

Usage:
  python3 transform_return_fp.py --source-dir <source_dir> --output transform_return_fp.cocci
"""

import argparse
import os
import sys
from typing import Set

def read_target_fp_names(file_path: str = "target_fpNames.txt") -> Set[str]:
    """Read target function pointer names from target_fpNames.txt file"""
    fp_names = set()
    
    if not os.path.exists(file_path):
        print(f"[ERROR] Target file not found: {file_path}")
        return fp_names
    
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith('#'):
                    fp_names.add(line)
        
        print(f"[INFO] Loaded {len(fp_names)} function pointer names from {file_path}")
        return fp_names
        
    except Exception as e:
        print(f"[ERROR] Failed to read {file_path}: {e}")
        return fp_names

def read_functions_for_fp(fp_name: str, fpnames_dir: str = "fpName") -> list[str]:
    """Read function names for a specific function pointer, maintaining order"""
    functions = []
    file_path = os.path.join(fpnames_dir, f"{fp_name}.txt")
    
    if not os.path.exists(file_path):
        print(f"[WARNING] Function list file not found: {file_path}")
        return functions
    
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith('#'):
                    functions.append(line)
        
        print(f"[INFO] Loaded {len(functions)} functions for {fp_name} from {file_path}")
        return functions
        
    except Exception as e:
        print(f"[ERROR] Failed to read {file_path}: {e}")
        return functions

SKIP_SUBSTRS = ("multiplex", "quota", "fts5", "vfstraceClose")

def _coerce_name(x) -> str:
    """candi_funcs 원소가 'name' 또는 (idx, 'name') 등 다양한 형태여도 항상 문자열 이름을 돌려준다."""
    # tuple/list인 경우 name 후보를 고름
    if isinstance(x, (tuple, list)):
        if len(x) == 0:
            return ""
        # (idx, name) 형태가 흔하니 2번째 우선, 아니면 1번째
        cand = x[1] if len(x) > 1 and isinstance(x[1], (str, bytes)) else x[0]
        return cand.decode() if isinstance(cand, bytes) else str(cand)
    # 그 외는 문자열/바이트/기타 → 문자열화
    return x.decode() if isinstance(x, bytes) else str(x)

def _skip_func(name_like) -> bool:
    """제외할 함수명 필터. 무엇이 들어와도 안전하게 문자열로 바꾼 뒤 검사."""
    n = _coerce_name(name_like).lower()
    return any(s in n for s in SKIP_SUBSTRS)


def generate_return_transformation_rules_arrow(target_fp_names: set[str], fpnames_dir: str = "fpName") -> str:
    """Generate Coccinelle rules to transform return E->fp_name(args) statements"""
    out = []
    out.append("// ===== RETURN FUNCTION POINTER TRANSFORMATION RULES =====\n")

    total_rules = 0
    
    for fp_name in sorted(target_fp_names):
        # Read candidate functions for this function pointer
        candi_funcs = read_functions_for_fp(fp_name, fpnames_dir)
        
        if not candi_funcs:
            print(f"[WARNING] No candidate functions found for {fp_name}, skipping...")
            continue
        
        if len(candi_funcs) < 2:
            print(f"[WARNING] Only {len(candi_funcs)} candidate function for {fp_name}, need at least 2 for if-chain")
            continue
            
        rule_name = f"transform_return_{fp_name}_arrow"
        total_rules += 1
        
        out.append(f"\n// Transform return E->{fp_name}(args) to if-chain with {len(candi_funcs)} candidates\n")
        out.append(f"@{rule_name}@\n")
        out.append(f"expression E;\n")
        out.append(f"identifier FP_NAME = {fp_name};\n")
        out.append(f"expression list args;\n")
        out.append(f"@@\n")
        # out.append(f"return E->FP_NAME(args);\n")
        out.append(f"- return E->FP_NAME(args);\n")
        
        # Generate if-else chain for all candidate functions
        for i, candi_func in enumerate(candi_funcs):
            func = _coerce_name(candi_func)     # 항상 '함수명' 문자열로
            if _skip_func(func):
                continue
            
            out.append(f"+ if (memcmp(E->{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E->{fp_name}_signature)) == 0) {{\n")
            out.append(f"+ return {candi_func}(args);\n")
            out.append(f"+ }}\n")
        out.append("\n")
    
    out.append(f"// Total return transformation rules generated: {total_rules}\n")
    return "".join(out)


def generate_return_transformation_rules(target_fp_names: set[str], fpnames_dir: str = "fpName") -> str:
    """Generate Coccinelle rules to transform return E->fp_name(args) statements"""
    out = []
    out.append("// ===== RETURN FUNCTION POINTER TRANSFORMATION RULES =====\n")

    total_rules = 0
    
    for fp_name in sorted(target_fp_names):
        # Read candidate functions for this function pointer
        candi_funcs = read_functions_for_fp(fp_name, fpnames_dir)
        
        if not candi_funcs:
            print(f"[WARNING] No candidate functions found for {fp_name}, skipping...")
            continue
        
        if len(candi_funcs) < 2:
            print(f"[WARNING] Only {len(candi_funcs)} candidate function for {fp_name}, need at least 2 for if-chain")
            continue
            
        rule_name = f"transform_return_{fp_name}"
        total_rules += 1
        
        out.append(f"\n// Transform return E->{fp_name}(args) to if-chain with {len(candi_funcs)} candidates\n")
        out.append(f"@{rule_name}@\n")
        out.append(f"expression E;\n")
        out.append(f"identifier FP_NAME = {fp_name};\n")
        out.append(f"expression list args;\n")
        out.append(f"@@\n")
        # out.append(f"return E.FP_NAME(args);\n")
        out.append(f"- return E.FP_NAME(args);\n")
        
        # Generate if-else chain for all candidate functions
        for i, candi_func in enumerate(candi_funcs):
            func = _coerce_name(candi_func)     # 항상 '함수명' 문자열로
            if _skip_func(func):
                continue

            out.append(f"+ if (memcmp(E.{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E.{fp_name}_signature)) == 0) {{\n")
            out.append(f"+ return {candi_func}(args);\n")
            out.append(f"+ }}\n")
        out.append("\n")
    
    out.append(f"// Total return transformation rules generated: {total_rules}\n")
    return "".join(out)


def generate_no_return_transformation_rules_arrow(target_fp_names: set[str], fpnames_dir: str = "fpName") -> str:
    """Generate Coccinelle rules to transform return E->fp_name(args) statements"""
    out = []
    out.append("// ===== RETURN FUNCTION POINTER TRANSFORMATION RULES =====\n")

    total_rules = 0
    
    for fp_name in sorted(target_fp_names):
        # Read candidate functions for this function pointer
        candi_funcs = read_functions_for_fp(fp_name, fpnames_dir)
        
        if not candi_funcs:
            print(f"[WARNING] No candidate functions found for {fp_name}, skipping...")
            continue
        
        if len(candi_funcs) < 2:
            print(f"[WARNING] Only {len(candi_funcs)} candidate function for {fp_name}, need at least 2 for if-chain")
            continue
            
        rule_name = f"transform_no_return_{fp_name}_arrow"
        total_rules += 1
        
        out.append(f"\n// Transform return E->{fp_name}(args) to if-chain with {len(candi_funcs)} candidates\n")
        out.append(f"@{rule_name}@\n")
        out.append(f"expression E;\n")
        out.append(f"identifier FP_NAME = {fp_name};\n")
        out.append(f"expression list args;\n")
        out.append(f"@@\n")
        # out.append(f"E->FP_NAME(args);\n")
        out.append(f"- E->FP_NAME(args);\n")
        
        # Generate if-else chain for all candidate functions
        for i, candi_func in enumerate(candi_funcs):
            func = _coerce_name(candi_func)     # 항상 '함수명' 문자열로
            if _skip_func(func):
                continue
            
            out.append(f"+ if (memcmp(E->{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E->{fp_name}_signature)) == 0) {{\n")
            out.append(f"+ {candi_func}(args);\n")
            out.append(f"+ }}\n")
        out.append("\n")

    
    out.append(f"// Total no return transformation rules generated: {total_rules}\n")
    return "".join(out)


def generate_no_return_transformation_rules(target_fp_names: set[str], fpnames_dir: str = "fpName") -> str:
    """Generate Coccinelle rules to transform return E->fp_name(args) statements"""
    out = []
    out.append("// ===== RETURN FUNCTION POINTER TRANSFORMATION RULES =====\n")

    total_rules = 0
    
    for fp_name in sorted(target_fp_names):
        # Read candidate functions for this function pointer
        candi_funcs = read_functions_for_fp(fp_name, fpnames_dir)
        
        if not candi_funcs:
            print(f"[WARNING] No candidate functions found for {fp_name}, skipping...")
            continue
        
        if len(candi_funcs) < 2:
            print(f"[WARNING] Only {len(candi_funcs)} candidate function for {fp_name}, need at least 2 for if-chain")
            continue
            
        rule_name = f"transform_no_return_{fp_name}"
        total_rules += 1
        
        out.append(f"\n// Transform return E->{fp_name}(args) to if-chain with {len(candi_funcs)} candidates\n")
        out.append(f"@{rule_name}@\n")
        out.append(f"expression E;\n")
        out.append(f"identifier FP_NAME = {fp_name};\n")
        out.append(f"expression list args;\n")
        out.append(f"@@\n")
        # out.append(f"E.FP_NAME(args);\n")
        out.append(f"- E.FP_NAME(args);\n")
        
        # Generate if-else chain for all candidate functions
        for i, candi_func in enumerate(candi_funcs):
            func = _coerce_name(candi_func)     # 항상 '함수명' 문자열로
            if _skip_func(func):
                continue
            
            out.append(f"+ if (memcmp(E.{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E.{fp_name}_signature)) == 0) {{\n")
            out.append(f"+ {candi_func}(args);\n")
            out.append(f"+ }}\n")
        # no Default
        out.append("\n")
    
    out.append(f"// Total no return transformation rules generated: {total_rules}\n")
    return "".join(out)


def generate_assignment_transformation_rules_arrow(target_fp_names: set[str], fpnames_dir: str = "fpName") -> str:
    """Generate Coccinelle rules to transform return E->fp_name(args) statements"""
    out = []
    out.append("// ===== RETURN FUNCTION POINTER TRANSFORMATION RULES =====\n")

    total_rules = 0
    
    for fp_name in sorted(target_fp_names):
        # Read candidate functions for this function pointer
        candi_funcs = read_functions_for_fp(fp_name, fpnames_dir)
        
        if not candi_funcs:
            print(f"[WARNING] No candidate functions found for {fp_name}, skipping...")
            continue
        
        if len(candi_funcs) < 2:
            print(f"[WARNING] Only {len(candi_funcs)} candidate function for {fp_name}, need at least 2 for if-chain")
            continue
            
        rule_name = f"transform_assignment_{fp_name}_arrow"
        total_rules += 1
        
        out.append(f"\n// Transform return E->{fp_name}(args) to if-chain with {len(candi_funcs)} candidates\n")
        out.append(f"@{rule_name}@\n")
        out.append(f"expression E1, E2;\n")
        out.append(f"identifier FP_NAME = {fp_name};\n")
        out.append(f"expression list args;\n")
        out.append(f"@@\n")
        # out.append(f"E1 = E2->FP_NAME(args);\n")
        out.append(f"- E1 = E2->FP_NAME(args);\n")
        
        # Generate if-else chain for all candidate functions
        for i, candi_func in enumerate(candi_funcs):
            func = _coerce_name(candi_func)     # 항상 '함수명' 문자열로
            if _skip_func(func):
                continue
            
            out.append(f"+ if (memcmp(E2->{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E2->{fp_name}_signature)) == 0) {{\n")
            out.append(f"+ E1 = {candi_func}(args);\n")
            out.append(f"+ }}\n")
        # no Default
        out.append("\n")
    
    out.append(f"// Total assignment transformation rules generated: {total_rules}\n")
    return "".join(out)


def generate_assignment_transformation_rules(target_fp_names: set[str], fpnames_dir: str = "fpName") -> str:
    """Generate Coccinelle rules to transform return E->fp_name(args) statements"""
    out = []
    out.append("// ===== RETURN FUNCTION POINTER TRANSFORMATION RULES =====\n")

    total_rules = 0
    
    for fp_name in sorted(target_fp_names):
        # Read candidate functions for this function pointer
        candi_funcs = read_functions_for_fp(fp_name, fpnames_dir)
        
        if not candi_funcs:
            print(f"[WARNING] No candidate functions found for {fp_name}, skipping...")
            continue
        
        if len(candi_funcs) < 2:
            print(f"[WARNING] Only {len(candi_funcs)} candidate function for {fp_name}, need at least 2 for if-chain")
            continue
            
        rule_name = f"transform_assignment_{fp_name}"
        total_rules += 1
        
        out.append(f"\n// Transform return E->{fp_name}(args) to if-chain with {len(candi_funcs)} candidates\n")
        out.append(f"@{rule_name}@\n")
        out.append(f"expression E1, E2;\n")
        out.append(f"identifier FP_NAME = {fp_name};\n")
        out.append(f"expression list args;\n")
        out.append(f"@@\n")
        # out.append(f"E1 = E2.FP_NAME(args);\n")
        out.append(f"- E1 = E2.FP_NAME(args);\n")
        
        # Generate if-else chain for all candidate functions
        for i, candi_func in enumerate(candi_funcs):
            func = _coerce_name(candi_func)     # 항상 '함수명' 문자열로
            if _skip_func(func):
                continue
            
            out.append(f"+ if (memcmp(E2.{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E2.{fp_name}_signature)) == 0) {{\n")
            out.append(f"+ E1 = {candi_func}(args);\n")
            out.append(f"+ }}\n")
        # no Default
        out.append("\n")
    
    out.append(f"// Total assignment transformation rules generated: {total_rules}\n")
    return "".join(out)


def generate_logging_rules(target_fp_names: Set[str]) -> str:
    """Generate logging rules for transformations"""
    rules = []
    rules.append("// ===== LOGGING RULES =====\n")

    for fp_name in sorted(target_fp_names):
        # Log return transformations
        rules.append(f"""
@script:python depends on transform_return_{fp_name}@
@@
import os
os.makedirs("return_transformations", exist_ok=True)
with open("return_transformations/{fp_name}_return_transforms.txt", "a") as f:
    f.write(f"[OK] Transformed return E->{fp_name}(args) to if-chain\\n")
print(f"[TRANSFORMED] return E->{fp_name}(args) -> if-chain with signature checks")
""")
        
        # Log assignment transformations
        rules.append(f"""
@script:python depends on transform_assignment_{fp_name}@
@@
import os
os.makedirs("return_transformations", exist_ok=True)
with open("return_transformations/{fp_name}_assignment_transforms.txt", "a") as f:
    f.write(f"[OK] Transformed E1 = E->{fp_name}(args) to if-chain\\n")
print(f"[TRANSFORMED] E1 = E->{fp_name}(args) -> if-chain with signature checks")
""")

    return "".join(rules)

def generate_cocci_script(target_fp_names: Set[str], fpnames_dir: str = "fpName", include_logging: bool = False) -> str:
    """Generate the complete Coccinelle script"""
    
    script_parts = []
    
    if not target_fp_names:
        script_parts.append("// No target function pointers specified\n")
        return "".join(script_parts)
    
    # Generate return transformation rules (arrow)
    script_parts.append(generate_return_transformation_rules_arrow(target_fp_names, fpnames_dir))

    # Generate return transformation rules
    script_parts.append(generate_return_transformation_rules(target_fp_names, fpnames_dir))

    # Generate no return transformation rules (arrow)
    script_parts.append(generate_no_return_transformation_rules_arrow(target_fp_names, fpnames_dir))

    # Generate no return transformation rules
    script_parts.append(generate_no_return_transformation_rules(target_fp_names, fpnames_dir))

    # Generate assignamet transformation rules (arrow)
    script_parts.append(generate_assignment_transformation_rules_arrow(target_fp_names, fpnames_dir))

    # Generate return transformation rules
    script_parts.append(generate_assignment_transformation_rules(target_fp_names, fpnames_dir))
    

    # Generate logging rules (optional)
    if include_logging:
        script_parts.append(generate_logging_rules(target_fp_names))
    
    return "".join(script_parts)

def main():
    parser = argparse.ArgumentParser(
        description="Generate Coccinelle script to transform function pointer returns/assignments to signature-based if-chains"
    )
    parser.add_argument(
        "--source-dir",
        required=True,
        help="Directory containing source code"
    )
    parser.add_argument(
        "--output",
        default="transform_return_fp.cocci",
        help="Output Coccinelle script file (default: transform_return_fp.cocci)"
    )
    parser.add_argument(
        "--fpnames-dir",
        default="fpName",
        help="Directory containing function lists for each FP (default: fpNames)"
    )
    parser.add_argument(
        "--include-logging",
        action="store_true",
        help="Include Python logging rules (may slow down execution)"
    )
    parser.add_argument(
        "--verbose", "-v",
        action="store_true",
        help="Enable verbose output"
    )
    parser.add_argument(
        "--debug", "-d",
        action="store_true",
        help="Enable debug output"
    )
    
    args = parser.parse_args()
    
    if not os.path.exists(args.source_dir):
        print(f"[ERROR] Source directory not found: {args.source_dir}")
        sys.exit(1)
    
    if not os.path.exists(args.fpnames_dir):
        print(f"[ERROR] fpNames directory not found: {args.fpnames_dir}")
        print(f"[INFO] Please create {args.fpnames_dir}/ directory with function list files")
        sys.exit(1)
    
    print(f"[INFO] Scanning source directory: {args.source_dir}")
    print(f"[INFO] Using fpNames directory: {args.fpnames_dir}")
    
    # Read target function pointer names
    target_fp_names = read_target_fp_names("target_fpNames.txt")
    
    if not target_fp_names:
        print("[ERROR] No target function pointer names found in target_fpNames.txt")
        print("[INFO] Please create target_fpNames.txt with function pointer names (one per line)")
        sys.exit(1)
    
    # Check function files and count total transformations
    missing_fp_files = []
    total_functions = 0
    valid_fps = 0
    
    for fp_name in target_fp_names:
        functions = read_functions_for_fp(fp_name, args.fpnames_dir)
        if not functions:
            missing_fp_files.append(fp_name)
        elif len(functions) >= 2:  # Need at least 2 functions for if-chain
            valid_fps += 1
            total_functions += len(functions)
        else:
            print(f"[WARNING] {fp_name} has only {len(functions)} function(s), need at least 2 for if-chain")
    
    if missing_fp_files:
        print(f"[WARNING] Missing function files for: {', '.join(missing_fp_files)}")
    
    if valid_fps == 0:
        print("[ERROR] No valid function pointers found (need at least 2 candidate functions each)")
        sys.exit(1)
    
    if args.debug:
        print(f"\n[DEBUG] Function pointer analysis:")
        for fp_name in sorted(target_fp_names):
            functions = read_functions_for_fp(fp_name, args.fpnames_dir)
            status = "✓" if len(functions) >= 2 else "✗"
            print(f"[DEBUG]   {status} {fp_name}: {len(functions)} functions")
            if args.verbose and functions:
                for i, func_name in enumerate(functions):
                    print(f"[DEBUG]     {i+1}. {func_name}")
    
    print(f"\n[SUMMARY] Function pointers: {len(target_fp_names)} total, {valid_fps} valid")
    print(f"[SUMMARY] Will generate {valid_fps * 2} transformation rules (return + assignment)")
    print(f"[SUMMARY] Total candidate functions: {total_functions}")
    
    # Generate Coccinelle script
    print(f"\n[INFO] Generating Coccinelle script...")
    
    script_content = generate_cocci_script(target_fp_names, args.fpnames_dir, args.include_logging)
    
    # Write output file
    output_path = args.output
    if not output_path.endswith('.cocci'):
        output_path += '.cocci'
    
    try:
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(script_content)
        
        print(f"[SUCCESS] Generated Coccinelle script: {output_path}")
        print(f"[INFO] Valid function pointers: {valid_fps}")
        print(f"[INFO] Transformation rules: {valid_fps * 2} (return + assignment)")
        
        print(f"\n[TRANSFORMATION] Will convert:")
        print(f"  return E->fp_name(args); -> if-chain with signature checks")
        print(f"  rc = E->fp_name(args);   -> if-else chain with signature checks")
        
        print(f"\n[USAGE] Apply transformation:")
        print(f"  spatch --sp-file {output_path} --dir {args.source_dir} --in-place")
        
        print(f"\n[ASSUMPTIONS] This script assumes:")
        print(f"  ✓ fp_name_signatures arrays are defined")
        print(f"  ✓ fp_name_func_enum values are defined")  
        print(f"  ✓ Structs have fp_name_signature fields")
        print(f"  ✓ <string.h> is included for memcmp")
        
    except Exception as e:
        print(f"[ERROR] Failed to write output file: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()