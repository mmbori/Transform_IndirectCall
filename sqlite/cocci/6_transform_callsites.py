"""
Generate a Coccinelle script that transforms function pointer return statements.
Excludes functions from remove_fn_list.txt
- If only 1 valid function: direct call without memcmp
- If 2+ valid functions: if-else chain with memcmp
"""

import argparse
import os
import sys
import re
from typing import Set

def read_remove_list(file_path: str = "remove_fn_list.txt") -> Set[str]:
    """Read functions to exclude from remove_fn_list.txt"""
    removed_functions = set()
    
    if not os.path.exists(file_path):
        print(f"[WARNING] Remove list file not found: {file_path}")
        return removed_functions
    
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith('#') and not line.startswith('//'):
                    func_name = re.sub(r'[^\w]', '', line)
                    if func_name:
                        removed_functions.add(func_name)
        
        print(f"[INFO] Loaded {len(removed_functions)} functions to exclude from {file_path}")
        return removed_functions
        
    except Exception as e:
        print(f"[ERROR] Failed to read {file_path}: {e}")
        return removed_functions

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

SKIP_SUBSTRS = ("quota", "fts5", "multiplex")
# SKIP_SUBSTRS = ("quota", "fts5", "multiplex", "amatch", "binfo", "carray", "cf", 
#                 "cidx", "cksm", "closure", "csvtab", "deltaparsevtab", "demo", "devsym", 
#                 "echo", "explain", "faultsim", "fs", "fts3", "fuzzer", "geopoly", "icu", 
#                 "intarray", "jt", "kvv", "mem", "prefixes", "qpvtab", "rbuVfs", "schema", 
#                 "spell", "tcl", "templatevtab", "testTokenizer", "testpcache", "tmp", "tvfs", 
#                 "union", "vfslog", "vstat", "vtablog", "wholenumber", "win", "wr", "writecrash")

def _coerce_name(x) -> str:
    """다양한 형태의 입력을 문자열 이름으로 변환"""
    if isinstance(x, (tuple, list)):
        if len(x) == 0:
            return ""
        cand = x[1] if len(x) > 1 and isinstance(x[1], (str, bytes)) else x[0]
        return cand.decode() if isinstance(cand, bytes) else str(cand)
    return x.decode() if isinstance(x, bytes) else str(x)

def _skip_func(name_like, removed_functions: Set[str]) -> bool:
    """함수를 제외해야 하는지 확인"""
    n = _coerce_name(name_like)
    
    # 'x'로 시작하는 함수 제외
    if n.startswith('x'):
        return True
    
    # remove_fn_list.txt에 있는 함수 제외
    if n in removed_functions:
        return True
    
    # quota, fts5, multiplex 포함 함수 제외
    return any(s in n.lower() for s in SKIP_SUBSTRS)

# NEW added ==========================
def generate_return_transformation_rules_special_arrow(target_fp_names: set[str], fpnames_dir: str = "fpName", removed_functions: Set[str] = set()) -> str:
    """Generate Coccinelle rules to transform return E->fp_name(args) statements"""
    out = []
    out.append("// ===== RETURN FUNCTION POINTER TRANSFORMATION RULES (ARROW) =====\n")

    total_rules = 0
    
    for fp_name in sorted(target_fp_names):
        candi_funcs = read_functions_for_fp(fp_name, fpnames_dir)
        valid_funcs = [f for f in candi_funcs if not _skip_func(_coerce_name(f), removed_functions) and _coerce_name(f) != '0']
        
        if not valid_funcs:
            print(f"[WARNING] No candidate functions found for {fp_name}, skipping...")
            continue
        
        rule_name = f"transform_special_{fp_name}_arrow"
        total_rules += 1
        
        # 1개만 있는 경우: 직접 호출
        if len(valid_funcs) == 1 and not fp_name.startswith('x'):
            func = _coerce_name(valid_funcs[0])
            out.append(f"\n// Transform return E->{fp_name}(args) to direct call (only 1 candidate)\n")
            out.append(f"@{rule_name}@\n")
            out.append(f"expression E1, E2;\n")
            out.append(f"identifier FP_NAME = {fp_name};\n")
            out.append(f"expression list args;\n")
            out.append(f"@@\n")
            out.append(f"- E1(E2->FP_NAME(args));\n")
            if func == '0':
                out.append(f"+ E1(0);\n")
            else:
                out.append(f"+ E1({func}(args));\n")
            out.append("\n")
            continue
        
        # 2개 이상: if-else chain
        out.append(f"\n// Transform return E->{fp_name}(args) to if-chain with {len(valid_funcs)} candidates\n")
        out.append(f"@{rule_name}@\n")
        out.append(f"expression E1, E2;\n")
        out.append(f"identifier FP_NAME = {fp_name};\n")
        out.append(f"expression list args;\n")
        out.append(f"@@\n")
        out.append(f"- E1(E2->FP_NAME(args));\n")
        
        first = True
        for candi_func in candi_funcs:
            func = _coerce_name(candi_func)
            if _skip_func(func, removed_functions):
                continue
            
            if first:
                out.append(f"+ if (memcmp(E2->{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E2->{fp_name}_signature)) == 0) {{\n")
                first = False
            else:
                out.append(f"+ }}\n")
                out.append(f"+ else if (memcmp(E2->{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E2->{fp_name}_signature)) == 0) {{\n")
            
            if func == '0':
                out.append(f"+ E1(0);\n")
            else:
                out.append(f"+ E1({func}(args));\n")
        
        out.append(f"+ }}\n")
        out.append("\n")
    
    out.append(f"// Total return transformation rules generated: {total_rules}\n")
    return "".join(out)


def generate_return_transformation_rules_special(target_fp_names: set[str], fpnames_dir: str = "fpName", removed_functions: Set[str] = set()) -> str:
    """Generate Coccinelle rules to transform return E->fp_name(args) statements"""
    out = []
    out.append("// ===== RETURN FUNCTION POINTER TRANSFORMATION RULES (ARROW) =====\n")

    total_rules = 0
    
    for fp_name in sorted(target_fp_names):
        candi_funcs = read_functions_for_fp(fp_name, fpnames_dir)
        valid_funcs = [f for f in candi_funcs if not _skip_func(_coerce_name(f), removed_functions) and _coerce_name(f) != '0']
        
        if not valid_funcs:
            print(f"[WARNING] No candidate functions found for {fp_name}, skipping...")
            continue
        
        rule_name = f"transform_special_{fp_name}"
        total_rules += 1
        
        # 1개만 있는 경우: 직접 호출
        if len(valid_funcs) == 1 and not fp_name.startswith('x'):
            func = _coerce_name(valid_funcs[0])
            out.append(f"\n// Transform return E.{fp_name}(args) to direct call (only 1 candidate)\n")
            out.append(f"@{rule_name}@\n")
            out.append(f"expression E1, E2;\n")
            out.append(f"identifier FP_NAME = {fp_name};\n")
            out.append(f"expression list args;\n")
            out.append(f"@@\n")
            out.append(f"- E1(E2.FP_NAME(args));\n")
            if func == '0':
                out.append(f"+ E1(0);\n")
            else:
                out.append(f"+ E1({func}(args));\n")
            out.append("\n")
            continue
        
        # 2개 이상: if-else chain
        out.append(f"\n// Transform return E.{fp_name}(args) to if-chain with {len(valid_funcs)} candidates\n")
        out.append(f"@{rule_name}@\n")
        out.append(f"expression E1, E2;\n")
        out.append(f"identifier FP_NAME = {fp_name};\n")
        out.append(f"expression list args;\n")
        out.append(f"@@\n")
        out.append(f"- E1(E2.FP_NAME(args));\n")
        
        first = True
        for candi_func in candi_funcs:
            func = _coerce_name(candi_func)
            if _skip_func(func, removed_functions):
                continue
            
            if first:
                out.append(f"+ if (memcmp(E2.{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E2.{fp_name}_signature)) == 0) {{\n")
                first = False
            else:
                out.append(f"+ }}\n")
                out.append(f"+ else if (memcmp(E2.{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E2.{fp_name}_signature)) == 0) {{\n")
            
            if func == '0':
                out.append(f"+ E1(0);\n")
            else:
                out.append(f"+ E1({func}(args));\n")
        
        out.append(f"+ }}\n")
        out.append("\n")
    
    out.append(f"// Total return transformation rules generated: {total_rules}\n")
    return "".join(out)

# ====================================

def generate_return_transformation_rules_arrow(target_fp_names: set[str], fpnames_dir: str = "fpName", removed_functions: Set[str] = set()) -> str:
    """Generate Coccinelle rules to transform return E->fp_name(args) statements"""
    out = []
    out.append("// ===== RETURN FUNCTION POINTER TRANSFORMATION RULES (ARROW) =====\n")

    total_rules = 0
    
    for fp_name in sorted(target_fp_names):
        candi_funcs = read_functions_for_fp(fp_name, fpnames_dir)
        valid_funcs = [f for f in candi_funcs if not _skip_func(_coerce_name(f), removed_functions) and _coerce_name(f) != '0']
        
        if not valid_funcs:
            print(f"[WARNING] No candidate functions found for {fp_name}, skipping...")
            continue
        
        rule_name = f"transform_return_{fp_name}_arrow"
        total_rules += 1
        
        # 1개만 있는 경우: 직접 호출
        if len(valid_funcs) == 1 and not fp_name.startswith('x'):
            func = _coerce_name(valid_funcs[0])
            out.append(f"\n// Transform return E->{fp_name}(args) to direct call (only 1 candidate)\n")
            out.append(f"@{rule_name}@\n")
            out.append(f"expression E;\n")
            out.append(f"identifier FP_NAME = {fp_name};\n")
            out.append(f"expression list args;\n")
            out.append(f"@@\n")
            out.append(f"- return E->FP_NAME(args);\n")
            if func == '0':
                out.append(f"+ return 0;\n")
            else:
                out.append(f"+ return {func}(args);\n")
            out.append("\n")
            continue
        
        # 2개 이상: if-else chain
        out.append(f"\n// Transform return E->{fp_name}(args) to if-chain with {len(valid_funcs)} candidates\n")
        out.append(f"@{rule_name}@\n")
        out.append(f"expression E;\n")
        out.append(f"identifier FP_NAME = {fp_name};\n")
        out.append(f"expression list args;\n")
        out.append(f"@@\n")
        out.append(f"- return E->FP_NAME(args);\n")
        
        first = True
        for candi_func in candi_funcs:
            func = _coerce_name(candi_func)
            if _skip_func(func, removed_functions):
                continue
            
            if first:
                out.append(f"+ if (memcmp(E->{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E->{fp_name}_signature)) == 0) {{\n")
                first = False
            else:
                out.append(f"+ }}\n")
                out.append(f"+ else if (memcmp(E->{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E->{fp_name}_signature)) == 0) {{\n")
            
            if func == '0':
                out.append(f"+ return 0;\n")
            else:
                out.append(f"+ return {func}(args);\n")
        
        out.append(f"+ }}\n")
        out.append("\n")
    
    out.append(f"// Total return transformation rules generated: {total_rules}\n")
    return "".join(out)


def generate_return_transformation_rules(target_fp_names: set[str], fpnames_dir: str = "fpName", removed_functions: Set[str] = set()) -> str:
    """Generate Coccinelle rules to transform return E.fp_name(args) statements"""
    out = []
    out.append("// ===== RETURN FUNCTION POINTER TRANSFORMATION RULES (DOT) =====\n")

    total_rules = 0
    
    for fp_name in sorted(target_fp_names):
        candi_funcs = read_functions_for_fp(fp_name, fpnames_dir)
        valid_funcs = [f for f in candi_funcs if not _skip_func(_coerce_name(f), removed_functions) and _coerce_name(f) != '0']
        
        if not valid_funcs:
            print(f"[WARNING] No candidate functions found for {fp_name}, skipping...")
            continue
        
        rule_name = f"transform_return_{fp_name}"
        total_rules += 1
        
        # 1개만 있는 경우: 직접 호출
        if len(valid_funcs) == 1 and not fp_name.startswith('x'):
            func = _coerce_name(valid_funcs[0])
            out.append(f"\n// Transform return E.{fp_name}(args) to direct call (only 1 candidate)\n")
            out.append(f"@{rule_name}@\n")
            out.append(f"expression E;\n")
            out.append(f"identifier FP_NAME = {fp_name};\n")
            out.append(f"expression list args;\n")
            out.append(f"@@\n")
            out.append(f"- return E.FP_NAME(args);\n")
            if func == '0':
                out.append(f"+ return 0;\n")
            else:
                out.append(f"+ return {func}(args);\n")
            out.append("\n")
            continue
        
        # 2개 이상: if-else chain
        out.append(f"\n// Transform return E.{fp_name}(args) to if-chain with {len(valid_funcs)} candidates\n")
        out.append(f"@{rule_name}@\n")
        out.append(f"expression E;\n")
        out.append(f"identifier FP_NAME = {fp_name};\n")
        out.append(f"expression list args;\n")
        out.append(f"@@\n")
        out.append(f"- return E.FP_NAME(args);\n")
        
        first = True
        for candi_func in candi_funcs:
            func = _coerce_name(candi_func)
            if _skip_func(func, removed_functions):
                continue

            if first:
                out.append(f"+ if (memcmp(E.{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E.{fp_name}_signature)) == 0) {{\n")
                first = False
            else:
                out.append(f"+ }}\n")
                out.append(f"+ else if (memcmp(E.{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E.{fp_name}_signature)) == 0) {{\n")
            
            if func == '0':
                out.append(f"+ return 0;\n")
            else:
                out.append(f"+ return {func}(args);\n")
        
        out.append(f"+ }}\n")
        out.append("\n")
    
    out.append(f"// Total return transformation rules generated: {total_rules}\n")
    return "".join(out)


def generate_no_return_transformation_rules_arrow(target_fp_names: set[str], fpnames_dir: str = "fpName", removed_functions: Set[str] = set()) -> str:
    """Generate Coccinelle rules to transform E->fp_name(args) statements"""
    out = []
    out.append("// ===== NO RETURN FUNCTION POINTER TRANSFORMATION RULES (ARROW) =====\n")

    total_rules = 0
    
    for fp_name in sorted(target_fp_names):
        candi_funcs = read_functions_for_fp(fp_name, fpnames_dir)
        valid_funcs = [f for f in candi_funcs if not _skip_func(_coerce_name(f), removed_functions) and _coerce_name(f) != '0']

        if not valid_funcs:
            print(f"[WARNING] No candidate functions found for {fp_name}, skipping...")
            continue
        
        rule_name = f"transform_no_return_{fp_name}_arrow"
        total_rules += 1
        
        # 1개만 있는 경우: 직접 호출
        if len(valid_funcs) == 1 and not fp_name.startswith('x'):
            func = _coerce_name(valid_funcs[0])
            out.append(f"\n// Transform E->{fp_name}(args) to direct call (only 1 candidate)\n")
            out.append(f"@{rule_name}@\n")
            out.append(f"expression E;\n")
            out.append(f"identifier FP_NAME = {fp_name};\n")
            out.append(f"expression list args;\n")
            out.append(f"@@\n")
            out.append(f"- E->FP_NAME(args);\n")
            if func == '0':
                out.append(f"+ 0;\n")
            else:
                out.append(f"+ {func}(args);\n")
            out.append("\n")
            continue
        
        # 2개 이상: if-else chain
        out.append(f"\n// Transform E->{fp_name}(args) to if-chain with {len(valid_funcs)} candidates\n")
        out.append(f"@{rule_name}@\n")
        out.append(f"expression E;\n")
        out.append(f"identifier FP_NAME = {fp_name};\n")
        out.append(f"expression list args;\n")
        out.append(f"@@\n")
        out.append(f"- E->FP_NAME(args);\n")
        
        first = True
        for candi_func in candi_funcs:
            func = _coerce_name(candi_func)
            if _skip_func(func, removed_functions):
                continue
            
            if first:
                out.append(f"+ if (memcmp(E->{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E->{fp_name}_signature)) == 0) {{\n")
                first = False
            else:
                out.append(f"+ }}\n")
                out.append(f"+ else if (memcmp(E->{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E->{fp_name}_signature)) == 0) {{\n")
            
            if func == '0':
                out.append(f"+ 0;\n")
            else:
                out.append(f"+ {func}(args);\n")
        
        out.append(f"+ }}\n")
        out.append("\n")
    
    out.append(f"// Total no return transformation rules generated: {total_rules}\n")
    return "".join(out)


def generate_no_return_transformation_rules(target_fp_names: set[str], fpnames_dir: str = "fpName", removed_functions: Set[str] = set()) -> str:
    """Generate Coccinelle rules to transform E.fp_name(args) statements"""
    out = []
    out.append("// ===== NO RETURN FUNCTION POINTER TRANSFORMATION RULES (DOT) =====\n")

    total_rules = 0
    
    for fp_name in sorted(target_fp_names):
        candi_funcs = read_functions_for_fp(fp_name, fpnames_dir)
        valid_funcs = [f for f in candi_funcs if not _skip_func(_coerce_name(f), removed_functions) and _coerce_name(f) != '0']
        
        if not valid_funcs:
            print(f"[WARNING] No candidate functions found for {fp_name}, skipping...")
            continue
        
        rule_name = f"transform_no_return_{fp_name}"
        total_rules += 1
        
        # 1개만 있는 경우: 직접 호출
        if len(valid_funcs) == 1 and not fp_name.startswith('x'):
            func = _coerce_name(valid_funcs[0])
            out.append(f"\n// Transform E.{fp_name}(args) to direct call (only 1 candidate)\n")
            out.append(f"@{rule_name}@\n")
            out.append(f"expression E;\n")
            out.append(f"identifier FP_NAME = {fp_name};\n")
            out.append(f"expression list args;\n")
            out.append(f"@@\n")
            out.append(f"- E.FP_NAME(args);\n")
            if func == '0':
                out.append(f"+ 0;\n")
            else:
                out.append(f"+ {func}(args);\n")
            out.append("\n")
            continue
        
        # 2개 이상: if-else chain
        out.append(f"\n// Transform E.{fp_name}(args) to if-chain with {len(valid_funcs)} candidates\n")
        out.append(f"@{rule_name}@\n")
        out.append(f"expression E;\n")
        out.append(f"identifier FP_NAME = {fp_name};\n")
        out.append(f"expression list args;\n")
        out.append(f"@@\n")
        out.append(f"- E.FP_NAME(args);\n")
        
        first = True
        for candi_func in candi_funcs:
            func = _coerce_name(candi_func)
            if _skip_func(func, removed_functions):
                continue
            
            if first:
                out.append(f"+ if (memcmp(E.{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E.{fp_name}_signature)) == 0) {{\n")
                first = False
            else:
                out.append(f"+ }}\n")
                out.append(f"+ else if (memcmp(E.{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E.{fp_name}_signature)) == 0) {{\n")
            
            if func == '0':
                out.append(f"+ 0;\n")
            else:
                out.append(f"+ {func}(args);\n")
        
        out.append(f"+ }}\n")
        out.append("\n")
    
    out.append(f"// Total no return transformation rules generated: {total_rules}\n")
    return "".join(out)


def generate_assignment_transformation_rules_arrow(target_fp_names: set[str], fpnames_dir: str = "fpName", removed_functions: Set[str] = set()) -> str:
    """Generate Coccinelle rules to transform E1 = E2->fp_name(args) statements"""
    out = []
    out.append("// ===== ASSIGNMENT FUNCTION POINTER TRANSFORMATION RULES (ARROW) =====\n")

    total_rules = 0
    
    for fp_name in sorted(target_fp_names):
        candi_funcs = read_functions_for_fp(fp_name, fpnames_dir)
        valid_funcs = [f for f in candi_funcs if not _skip_func(_coerce_name(f), removed_functions) and _coerce_name(f) != '0']
        
        if not valid_funcs:
            print(f"[WARNING] No candidate functions found for {fp_name}, skipping...")
            continue
        
        rule_name = f"transform_assignment_{fp_name}_arrow"
        total_rules += 1
        
        # 1개만 있는 경우: 직접 호출
        if len(valid_funcs) == 1 and not fp_name.startswith('x'):
            func = _coerce_name(valid_funcs[0])
            out.append(f"\n// Transform E1 = E2->{fp_name}(args) to direct call (only 1 candidate)\n")
            out.append(f"@{rule_name}@\n")
            out.append(f"expression E1, E2;\n")
            out.append(f"identifier FP_NAME = {fp_name};\n")
            out.append(f"expression list args;\n")
            out.append(f"@@\n")
            out.append(f"- E1 = E2->FP_NAME(args);\n")
            if func == '0':
                out.append(f"+ E1 = 0;\n")
            else:
                out.append(f"+ E1 = {func}(args);\n")
            out.append("\n")
            continue
        
        # 2개 이상: if-else chain
        out.append(f"\n// Transform E1 = E2->{fp_name}(args) to if-chain with {len(valid_funcs)} candidates\n")
        out.append(f"@{rule_name}@\n")
        out.append(f"expression E1, E2;\n")
        out.append(f"identifier FP_NAME = {fp_name};\n")
        out.append(f"expression list args;\n")
        out.append(f"@@\n")
        out.append(f"- E1 = E2->FP_NAME(args);\n")
        
        first = True
        for candi_func in candi_funcs:
            func = _coerce_name(candi_func)
            if _skip_func(func, removed_functions):
                continue
            
            if first:
                out.append(f"+ if (memcmp(E2->{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E2->{fp_name}_signature)) == 0) {{\n")
                first = False
            else:
                out.append(f"+ }}\n")
                out.append(f"+ else if (memcmp(E2->{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E2->{fp_name}_signature)) == 0) {{\n")
            
            if func == '0':
                out.append(f"+ E1 = 0;\n")
            else:
                out.append(f"+ E1 = {func}(args);\n")
        
        out.append(f"+ }}\n")
        out.append("\n")
    
    out.append(f"// Total assignment transformation rules generated: {total_rules}\n")
    return "".join(out)


def generate_assignment_transformation_rules(target_fp_names: set[str], fpnames_dir: str = "fpName", removed_functions: Set[str] = set()) -> str:
    """Generate Coccinelle rules to transform E1 = E2.fp_name(args) statements"""
    out = []
    out.append("// ===== ASSIGNMENT FUNCTION POINTER TRANSFORMATION RULES (DOT) =====\n")

    total_rules = 0
    
    for fp_name in sorted(target_fp_names):
        candi_funcs = read_functions_for_fp(fp_name, fpnames_dir)
        valid_funcs = [f for f in candi_funcs if not _skip_func(_coerce_name(f), removed_functions) and _coerce_name(f) != '0']
        
        if not valid_funcs:
            print(f"[WARNING] No candidate functions found for {fp_name}, skipping...")
            continue
        
        rule_name = f"transform_assignment_{fp_name}"
        total_rules += 1
        
        # 1개만 있는 경우: 직접 호출
        if len(valid_funcs) == 1 and not fp_name.startswith('x'):
            func = _coerce_name(valid_funcs[0])
            out.append(f"\n// Transform E1 = E2.{fp_name}(args) to direct call (only 1 candidate)\n")
            out.append(f"@{rule_name}@\n")
            out.append(f"expression E1, E2;\n")
            out.append(f"identifier FP_NAME = {fp_name};\n")
            out.append(f"expression list args;\n")
            out.append(f"@@\n")
            out.append(f"- E1 = E2.FP_NAME(args);\n")
            if func == '0':
                out.append(f"+ E1 = 0;\n")
            else:
                out.append(f"+ E1 = {func}(args);\n")
            out.append("\n")
            continue
        
        # 2개 이상: if-else chain
        out.append(f"\n// Transform E1 = E2.{fp_name}(args) to if-chain with {len(valid_funcs)} candidates\n")
        out.append(f"@{rule_name}@\n")
        out.append(f"expression E1, E2;\n")
        out.append(f"identifier FP_NAME = {fp_name};\n")
        out.append(f"expression list args;\n")
        out.append(f"@@\n")
        out.append(f"- E1 = E2.FP_NAME(args);\n")
        
        first = True
        for candi_func in candi_funcs:
            func = _coerce_name(candi_func)
            if _skip_func(func, removed_functions):
                continue
            
            if first:
                out.append(f"+ if (memcmp(E2.{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E2.{fp_name}_signature)) == 0) {{\n")
                first = False
            else:
                out.append(f"+ }}\n")
                out.append(f"+ else if (memcmp(E2.{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E2.{fp_name}_signature)) == 0) {{\n")
            
            if func == '0':
                out.append(f"+ E1 = 0;\n")
            else:
                out.append(f"+ E1 = {func}(args);\n")
        
        out.append(f"+ }}\n")
        out.append("\n")
    
    out.append(f"// Total assignment transformation rules generated: {total_rules}\n")
    return "".join(out)


def generate_logging_rules(target_fp_names: Set[str]) -> str:
    """Generate logging rules for transformations"""
    rules = []
    rules.append("// ===== LOGGING RULES =====\n")

    for fp_name in sorted(target_fp_names):
        rules.append(f"""
@script:python depends on transform_return_{fp_name}@
@@
import os
os.makedirs("return_transformations", exist_ok=True)
with open("return_transformations/{fp_name}_return_transforms.txt", "a") as f:
    f.write(f"[OK] Transformed return E->{fp_name}(args)\\n")
print(f"[TRANSFORMED] return E->{fp_name}(args)")
""")
        
        rules.append(f"""
@script:python depends on transform_assignment_{fp_name}@
@@
import os
os.makedirs("return_transformations", exist_ok=True)
with open("return_transformations/{fp_name}_assignment_transforms.txt", "a") as f:
    f.write(f"[OK] Transformed E1 = E->{fp_name}(args)\\n")
print(f"[TRANSFORMED] E1 = E->{fp_name}(args)")
""")

    return "".join(rules)

def generate_cocci_script(target_fp_names: Set[str], fpnames_dir: str = "fpName", 
                         removed_functions: Set[str] = set(), include_logging: bool = False) -> str:
    """Generate the complete Coccinelle script"""
    
    script_parts = []
    
    if not target_fp_names:
        script_parts.append("// No target function pointers specified\n")
        return "".join(script_parts)
    
    script_parts.append(generate_return_transformation_rules_special_arrow(target_fp_names, fpnames_dir, removed_functions)) # new added
    script_parts.append(generate_return_transformation_rules_special(target_fp_names, fpnames_dir, removed_functions)) # new added
    script_parts.append(generate_return_transformation_rules_arrow(target_fp_names, fpnames_dir, removed_functions))
    script_parts.append(generate_return_transformation_rules(target_fp_names, fpnames_dir, removed_functions))
    script_parts.append(generate_no_return_transformation_rules_arrow(target_fp_names, fpnames_dir, removed_functions))
    script_parts.append(generate_no_return_transformation_rules(target_fp_names, fpnames_dir, removed_functions))
    script_parts.append(generate_assignment_transformation_rules_arrow(target_fp_names, fpnames_dir, removed_functions))
    script_parts.append(generate_assignment_transformation_rules(target_fp_names, fpnames_dir, removed_functions))
    
    if include_logging:
        script_parts.append(generate_logging_rules(target_fp_names))
    
    return "".join(script_parts)

def main():
    parser = argparse.ArgumentParser(
        description="Generate Coccinelle script to transform function pointer calls (excludes remove_fn_list.txt)"
    )
    parser.add_argument("--source-dir", required=True, help="Directory containing source code")
    parser.add_argument("--output", default="transform_return_fp.cocci", help="Output Coccinelle script file")
    parser.add_argument("--fpnames-dir", default="fpName", help="Directory containing function lists")
    parser.add_argument("--remove-list", default="remove_fn_list.txt", help="File containing functions to exclude")
    parser.add_argument("--include-logging", action="store_true", help="Include Python logging rules")
    parser.add_argument("--verbose", "-v", action="store_true", help="Enable verbose output")
    parser.add_argument("--debug", "-d", action="store_true", help="Enable debug output")
    
    args = parser.parse_args()
    
    if not os.path.exists(args.source_dir):
        print(f"[ERROR] Source directory not found: {args.source_dir}")
        sys.exit(1)
    
    if not os.path.exists(args.fpnames_dir):
        print(f"[ERROR] fpNames directory not found: {args.fpnames_dir}")
        sys.exit(1)
    
    print(f"[INFO] Scanning source directory: {args.source_dir}")
    print(f"[INFO] Using fpNames directory: {args.fpnames_dir}")
    
    # Read remove list
    removed_functions = read_remove_list(args.remove_list)
    
    # Read target function pointer names
    target_fp_names = read_target_fp_names("target_fpNames.txt")
    
    if not target_fp_names:
        print("[ERROR] No target function pointer names found in target_fpNames.txt")
        sys.exit(1)
    
    # Check function files
    missing_fp_files = []
    total_functions = 0
    valid_fps = 0
    excluded_func_count = 0
    single_func_fps = 0
    multi_func_fps = 0
    
    for fp_name in target_fp_names:
        functions = read_functions_for_fp(fp_name, args.fpnames_dir)
        if not functions:
            missing_fp_files.append(fp_name)
        else:
            valid_funcs = [f for f in functions if not _skip_func(_coerce_name(f), removed_functions) and _coerce_name(f) != '0']
            excluded_count = len(functions) - len(valid_funcs)
            excluded_func_count += excluded_count
            
            if len(valid_funcs) >= 1:
                valid_fps += 1
                total_functions += len(valid_funcs)
                if len(valid_funcs) == 1:
                    single_func_fps += 1
                else:
                    multi_func_fps += 1
            else:
                print(f"[WARNING] {fp_name} has no valid functions after exclusion")
    
    if missing_fp_files:
        print(f"[WARNING] Missing function files for: {', '.join(missing_fp_files)}")
    
    if valid_fps == 0:
        print("[ERROR] No valid function pointers found")
        sys.exit(1)
    
    print(f"\n[SUMMARY] Function pointers: {len(target_fp_names)} total, {valid_fps} valid")
    print(f"[SUMMARY]   - Single function (direct call): {single_func_fps}")
    print(f"[SUMMARY]   - Multiple functions (if-chain): {multi_func_fps}")
    print(f"[SUMMARY] Functions excluded from remove_list: {excluded_func_count}")
    print(f"[SUMMARY] Will generate {valid_fps * 6} transformation rules")
    print(f"[SUMMARY] Total valid candidate functions: {total_functions}")
    
    # Generate Coccinelle script
    print(f"\n[INFO] Generating Coccinelle script...")
    
    script_content = generate_cocci_script(target_fp_names, args.fpnames_dir, removed_functions, args.include_logging)
    
    # Write output file
    output_path = args.output
    if not output_path.endswith('.cocci'):
        output_path += '.cocci'
    
    try:
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(script_content)
        
        print(f"[SUCCESS] Generated Coccinelle script: {output_path}")
        print(f"\n[TRANSFORMATION STRATEGY]")
        print(f"  - 1 valid function: Direct call (no memcmp)")
        print(f"  - 2+ valid functions: if-else chain with memcmp")
        print(f"\n[USAGE] Apply transformation:")
        print(f"  spatch --sp-file {output_path} --dir {args.source_dir} --in-place")
        
    except Exception as e:
        print(f"[ERROR] Failed to write output file: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()