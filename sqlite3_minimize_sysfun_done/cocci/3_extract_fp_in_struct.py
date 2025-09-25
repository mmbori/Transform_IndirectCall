#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Generate a Coccinelle script that:
1. Uses Python to find all structs with function pointer members
2. Uses Coccinelle to transform specific structs and extract assignments
3. Saves function names and declarations to separate directories

Usage:
  python3 function_pointer_converter.py --source-dir <sqlite_src> --output convert_fp.cocci
"""

import argparse
import os
import re
import sys
from typing import Dict, List, Set, Tuple
import glob

def find_struct_with_function_pointers(source_dir: str) -> Dict[str, List[Tuple[str, str, str]]]:
    """
    Use Python to find all structs containing function pointers
    
    Returns:
        Dict[struct_name, List[Tuple[return_type, fp_name, args]]]
    """
    struct_fp_map = {}
    
    # 더 유연한 구조체 패턴 (세미콜론 선택적)
    struct_pattern = re.compile(
    r'(?:typedef\s+)?struct\s+(\w+)?\s*\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}(?:\s*(\w+))?\s*;?',
    re.MULTILINE | re.DOTALL
    )

# 더 유연한 함수 포인터 패턴들
    fp_patterns = [
    # 표준: int (*callback)(args);
    re.compile(r'(\w+(?:\s+\w+)*\s*\*?)\s*\(\s*\*\s*(\w+)\s*\)\s*\(([^)]*)\)\s*;', re.MULTILINE),
    # 복잡한 타입: int (*xCallback)(Walker*, Expr*);
    re.compile(r'(\w+(?:\s*\*)*(?:\s+\w+)*)\s*\(\s*\*\s*(\w+)\s*\)\s*\(([^)]*)\)\s*;', re.MULTILINE),
    # typedef 앞에 오는 경우
    re.compile(r'([A-Za-z_]\w*(?:\s*\*)*)\s*\(\s*\*\s*(\w+)\s*\)\s*\(([^)]*)\)\s*;', re.MULTILINE)
    ]
    
    # Search through all C/H files
    file_patterns = [
        os.path.join(source_dir, "src/*.c"),
        os.path.join(source_dir, "src/*.h"),
        os.path.join(source_dir, "tsrc/**/*.c"),
        os.path.join(source_dir, "tsrc/**/*.h"),
        os.path.join(source_dir, "ext/**/*.c"),
        os.path.join(source_dir, "ext/**/*.h")
    ]
    
    files_to_process = []
    for pattern in file_patterns:
        files_to_process.extend(glob.glob(pattern, recursive=True))
    
    print(f"[INFO] Scanning {len(files_to_process)} files for structs with function pointers...")
    
    for file_path in files_to_process:
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            # Find all struct definitions
            for struct_match in struct_pattern.finditer(content):
                struct_name = struct_match.group(1) or struct_match.group(3)
                if not struct_name : continue

                struct_body = struct_match.group(2)
                
                # Find function pointers in this struct
                function_pointers = []
                # 기존 fp_pattern 제거하고 fp_patterns 사용
                for fp_pattern in fp_patterns:
                    for fp_match in fp_pattern.finditer(struct_body):
                        return_type = fp_match.group(1).strip()
                        fp_name = fp_match.group(2).strip()
                        args = fp_match.group(3).strip()
                        
                        function_pointers.append((return_type, fp_name, args))
                
                if function_pointers:
                    if struct_name not in struct_fp_map:
                        struct_fp_map[struct_name] = []
                    struct_fp_map[struct_name].extend(function_pointers)
                    print(f"[FOUND] Struct {struct_name} in {os.path.basename(file_path)} has {len(function_pointers)} function pointers")
                    for ret_type, fp_name, args in function_pointers:
                        print(f"        {ret_type} (*{fp_name})({args})")
        
        except Exception as e:
            print(f"[WARN] Failed to process {file_path}: {e}")
    
    return struct_fp_map


def generate_assignment_detection_rules(all_fp_names: Set[str]) -> str:
    """Generate Coccinelle rules to detect function pointer assignments"""
    
    # Create a list of all function pointer names for Coccinelle
    rules = []
    for fp_name in all_fp_names :
        rules.append(f"""
// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_{fp_name}@
expression E;
identifier FP_NAME = {fp_name};
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({{.fp = function}})
@find_init_fp_assignment_{fp_name}@
identifier FP_NAME = {fp_name};
identifier FUNC_NAME;
@@
{{
.FP_NAME = FUNC_NAME,
}}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_{fp_name}@
fp_name << find_struct_fp_assignment_{fp_name}.FP_NAME;
func_name << find_struct_fp_assignment_{fp_name}.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{{fp_name}} = {{func_name}}")

# Save assignment info
with open("fpName/{fp_name}.txt", "a") as f:
    f.write(f"{{func_name}}\\n")

@script:python depends on find_init_fp_assignment_{fp_name}@
fp_name << find_init_fp_assignment_{fp_name}.FP_NAME;
func_name << find_init_fp_assignment_{fp_name}.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{{fp_name}} = {{func_name}}")

# Save assignment info
with open("fpName/{fp_name}.txt", "a") as f:
    f.write(f"{{func_name}}\\n")
""")
    return "".join(rules)


def generate_cocci_script(struct_fp_map: Dict[str, List[Tuple[str, str, str]]]) -> str:
    """Generate the complete Coccinelle script"""
    
    script_parts = []
    
    # Collect all function pointer names
    all_fp_names = set()
    for fps in struct_fp_map.values():
        for _, fp_name, _ in fps:
            all_fp_names.add(fp_name)
    
    # Generate assignment detection rules
    if all_fp_names:
        script_parts.append(generate_assignment_detection_rules(all_fp_names))

    
    return "".join(script_parts)

def main():
    parser = argparse.ArgumentParser(
        description="Generate Coccinelle script using hybrid Python + Coccinelle approach"
    )
    parser.add_argument(
        "--source-dir",
        required=True,
        help="Directory containing SQLite source code"
    )
    parser.add_argument(
        "--output",
        default="convert_fp.cocci",
        help="Output Coccinelle script file (default: convert_fp.cocci)"
    )
    parser.add_argument(
        "--verbose", "-v",
        action="store_true",
        help="Enable verbose output"
    )
    parser.add_argument(
    "--debug", "-d",
    action="store_true",
    help="Enable debug output (shows all structs found)"
)
    
    args = parser.parse_args()
    
    if not os.path.exists(args.source_dir):
        print(f"[ERROR] Source directory not found: {args.source_dir}")
        sys.exit(1)
    
    print(f"[INFO] Scanning source directory: {args.source_dir}")
    
    # Step 1: Use Python to find structs with function pointers
    struct_fp_map = find_struct_with_function_pointers(args.source_dir)
    
    if args.debug:
        print(f"\n[DEBUG] Structure search completed")
    
    if not struct_fp_map:
        print("[INFO] No structs with function pointers found")
        if args.debug:
            print("\n[DEBUG] Trying manual search for known SQLite structures...")
            # Let's manually search for some known SQLite structures
            known_structs = ['sqlite3_mutex_methods', 'sqlite3_mem_methods', 'sqlite3_pcache_methods2', 'sqlite3_vfs']
            for struct_name in known_structs:
                print(f"[DEBUG] Searching for: {struct_name}")
                # Add manual search here if needed
        sys.exit(0)
    
    print(f"\\n[SUMMARY] Found {len(struct_fp_map)} structs with function pointers:")
    total_fps = 0
    for struct_name, fps in struct_fp_map.items():
        print(f"  {struct_name}: {len(fps)} function pointers")
        total_fps += len(fps)
    print(f"  Total function pointers: {total_fps}")
    
    # Step 2: Generate Coccinelle script
    print(f"\\n[INFO] Generating Coccinelle script...")
    
    script_content = generate_cocci_script(struct_fp_map)
    
    # Write output file
    output_path = args.output
    if not output_path.endswith('.cocci'):
        output_path += '.cocci'
    
    try:
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(script_content)
        
        print(f"[SUCCESS] Generated Coccinelle script: {output_path}")
        print(f"[INFO] Structs to transform: {len(struct_fp_map)}")
        print(f"[INFO] Function pointers to convert: {total_fps}")
        
        print(f"\\n[APPROACH] Hybrid method:")
        print(f"  ✓ Python: Struct detection and analysis")
        print(f"  ✓ Coccinelle: Precise code transformation")
        print(f"  ✓ Coccinelle: Assignment extraction")
        print(f"  ✓ Python: Result processing and file generation")
        
        print(f"\\n[USAGE] Apply with:")
        print(f"  spatch --sp-file {output_path} --dir {args.source_dir} --in-place")
        
        print(f"\\n[OUTPUT] After execution, check:")
        print(f"  fpName/       - Function candidate lists")
        print(f"  fpNameDecl/   - Function declarations")
        
    except Exception as e:
        print(f"[ERROR] Failed to write output file: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()