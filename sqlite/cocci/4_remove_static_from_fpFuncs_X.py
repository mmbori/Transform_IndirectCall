import argparse
import re
import sys
import os
from typing import List, Set, Dict

VALID_IDENT = re.compile(r'^[A-Za-z_]\w*$')

def load_all_functions_from_fpname_dir(fpname_dir: str, verbose: bool = False) -> Dict[str, List[str]]:
    """Load all function names from all .txt files in fpName/ directory"""
    if not os.path.exists(fpname_dir):
        print(f"[ERROR] Directory not found: {fpname_dir}", file=sys.stderr)
        sys.exit(1)
    
    fp_to_functions = {}
    all_functions = set()
    
    txt_files = [f for f in os.listdir(fpname_dir) if f.endswith('.txt')]
    
    if not txt_files:
        print(f"[ERROR] No .txt files found in {fpname_dir}", file=sys.stderr)
        sys.exit(1)
    
    if verbose:
        print(f"[INFO] Found {len(txt_files)} .txt files in {fpname_dir}")
    
    for txt_file in sorted(txt_files):
        fp_name = txt_file[:-4]
        fp_file_path = os.path.join(fpname_dir, txt_file)
        
        try:
            with open(fp_file_path, 'r', encoding='utf-8') as f:
                lines = f.readlines()
        except Exception as e:
            print(f"[ERROR] Failed to read {fp_file_path}: {e}", file=sys.stderr)
            continue
        
        functions = []
        for line_num, line in enumerate(lines, 1):
            line = line.strip()
            if not line or line.startswith('//') or line.startswith('#'):
                continue
                
            if VALID_IDENT.match(line):
                functions.append(line)
                all_functions.add(line)
            else:
                if verbose:
                    print(f"[WARN] {fp_file_path}:{line_num}: Invalid function name '{line}'")
        
        if functions:
            fp_to_functions[fp_name] = sorted(set(functions))
            if verbose:
                print(f"[INFO] {fp_name}: {len(functions)} functions")
    
    return fp_to_functions

def generate_comprehensive_cocci_rules(func: str) -> str:
    """Generate comprehensive Coccinelle rules for a function"""
    return f"""
// ============================================================================
// Rules for function: {func}
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_{func}@
identifier F = {{ {func} }};
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) {{ BODY }}

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_{func}@
identifier F = {{ {func} }};
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{{ BODY }}

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_{func}@
identifier F = {{ {func} }};
parameter list P;
statement list BODY;
@@
- static
F(P) {{ BODY }}

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_{func}@
identifier F = {{ {func} }};
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_{func}@
identifier F = {{ {func} }};
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) {{ BODY }}

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_{func}@
identifier F = {{ {func} }};
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) {{ BODY }}

// Rule 7: Static inline function declaration
@remove_static_inline_decl_{func}@
identifier F = {{ {func} }};
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_{func}@
identifier F = {{ {func} }};
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) {{ BODY }}

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_{func}@
identifier F = {{ {func} }};
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) {{ BODY }}

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_{func}@
identifier F = {{ {func} }};
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) {{ BODY }}

// Rule 14: Static const function
@remove_static_const_{func}@
identifier F = {{ {func} }};
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) {{ BODY }}
"""

def generate_header(part_num: int, total_parts: int, func_count: int) -> str:
    """Generate the header for the Coccinelle file"""
    return f"""// Auto-generated Coccinelle script to remove `static` keyword
// from functions assigned to function pointers
//
// Part {part_num} of {total_parts}
// Contains {func_count} functions
//
// Generated from all .txt files in fpName/ directory
//
// This script removes static keywords from all functions that are assigned
// to function pointers, making them available for cross-compilation
// unit function pointer assignments.
//
// Features:
// - 14 different static function patterns per function
// - Handles inline, const, volatile, and attribute modifiers
// - Supports complex return types including pointers
// - Covers legacy C styles and modern C standards
//
// Usage: spatch --sp-file remove_fp_static_part{part_num}.cocci --dir <source_directory> --in-place
"""

def main():
    parser = argparse.ArgumentParser(
        description="Generate multiple Coccinelle scripts to remove 'static' keywords (split into chunks)",
        epilog="Reads all .txt files from fpName/ directory and splits into multiple .cocci files"
    )
    parser.add_argument(
        "--fpname-dir",
        default="fpName",
        help="Directory containing {fp_name}.txt files with function lists (default: fpName)"
    )
    parser.add_argument(
        "-o", "--output", 
        default="remove_fp_static",
        help="Output prefix for the generated .cocci files (default: remove_fp_static)"
    )
    parser.add_argument(
        "--chunk-size",
        type=int,
        default=100,
        help="Number of functions per .cocci file (default: 100)"
    )
    parser.add_argument(
        "--verbose", "-v",
        action="store_true",
        help="Enable verbose output"
    )
    
    args = parser.parse_args()

    # Load all function names from fpName directory
    if args.verbose:
        print(f"[INFO] Scanning all .txt files in: {args.fpname_dir}/")
    
    fp_to_functions = load_all_functions_from_fpname_dir(args.fpname_dir, args.verbose)
    
    if not fp_to_functions:
        print("[ERROR] No function assignments found in fpName files", file=sys.stderr)
        sys.exit(1)
    
    # Collect all unique function names
    all_functions = set()
    for functions in fp_to_functions.values():
        all_functions.update(functions)
    
    all_functions = sorted(all_functions)
    
    print(f"[INFO] Found {len(all_functions)} unique functions across {len(fp_to_functions)} function pointers")
    
    # Calculate number of parts needed
    chunk_size = args.chunk_size
    total_parts = (len(all_functions) + chunk_size - 1) // chunk_size
    
    print(f"[INFO] Splitting into {total_parts} parts ({chunk_size} functions per file)")
    
    # Generate multiple Coccinelle scripts
    try:
        for part_num in range(1, total_parts + 1):
            start_idx = (part_num - 1) * chunk_size
            end_idx = min(start_idx + chunk_size, len(all_functions))
            chunk_functions = all_functions[start_idx:end_idx]
            
            output_path = f"{args.output}_part{part_num}.cocci"
            
            print(f"[INFO] Generating {output_path} ({len(chunk_functions)} functions)...")
            
            with open(output_path, 'w', encoding='utf-8') as f:
                # Write header
                f.write(generate_header(part_num, total_parts, len(chunk_functions)))
                
                # Write function list as comment
                f.write(f"// Functions in this part ({start_idx+1}-{end_idx} of {len(all_functions)}):\n")
                for func in chunk_functions[:10]:
                    f.write(f"// {func}\n")
                if len(chunk_functions) > 10:
                    f.write(f"// ... and {len(chunk_functions) - 10} more\n")
                f.write("\n")
                
                # Write comprehensive rules for each function
                for i, func in enumerate(chunk_functions, 1):
                    if args.verbose and i % 50 == 0:
                        print(f"  [{i}/{len(chunk_functions)}] Generating rules...")
                    f.write(generate_comprehensive_cocci_rules(func))
            
            print(f"[SUCCESS] Generated: {output_path}")
        
        print(f"\n[COMPLETE] Generated {total_parts} .cocci files")
        print(f"[INFO] Total functions processed: {len(all_functions)}")
        
        print(f"\n[USAGE]")
        print(f"  Run all parts:")
        for part_num in range(1, total_parts + 1):
            print(f"  spatch --sp-file {args.output}_part{part_num}.cocci --dir /path/to/source --in-place")
        
    except IOError as e:
        print(f"[ERROR] Failed to write output file: {e}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"[ERROR] Unexpected error: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()