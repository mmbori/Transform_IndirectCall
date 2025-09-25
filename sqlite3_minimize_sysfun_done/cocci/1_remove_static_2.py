#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Generate a Coccinelle .cocci file that removes only the `static` keyword
from definitions/declarations of functions listed in callsites.json (callee[]).

Fixed version that uses only valid Coccinelle patterns without mixing metavariables.
"""

import argparse
import json
import re
import sys
from typing import List, Set

VALID_IDENT = re.compile(r'^[A-Za-z_]\w*$')

def load_callee_set(json_path: str) -> List[str]:
    """Load and extract unique function names from callsites.json"""
    try:
        with open(json_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
    except FileNotFoundError:
        print(f"[ERROR] JSON file not found: {json_path}", file=sys.stderr)
        sys.exit(1)
    except json.JSONDecodeError as e:
        print(f"[ERROR] Invalid JSON format: {e}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"[ERROR] Failed to read JSON file: {e}", file=sys.stderr)
        sys.exit(1)

    names: Set[str] = set()
    
    if not isinstance(data, list):
        print("[ERROR] JSON root must be an array", file=sys.stderr)
        sys.exit(1)

    for i, entry in enumerate(data):
        if not isinstance(entry, dict):
            print(f"[WARN] Skipping non-object entry at index {i}", file=sys.stderr)
            continue
            
        callee_list = entry.get("callee", [])
        if not isinstance(callee_list, list):
            print(f"[WARN] Skipping invalid callee field at index {i}", file=sys.stderr)
            continue
            
        for callee in callee_list:
            if isinstance(callee, str):
                callee = callee.strip()
                if callee and VALID_IDENT.match(callee):
                    names.add(callee)
                elif callee:
                    print(f"[WARN] Skipping invalid identifier: {callee}", file=sys.stderr)
    
    return sorted(names)

def generate_cocci_rules(func: str) -> str:
    """Generate Coccinelle rules for a specific function - safe patterns only"""
    return f"""
// Rules for function: {func}

// Pattern 1: Function definition with explicit type, same line brace
@remove_static_def_sameline_{func}@
type T;
identifier F = {{ {func} }};
parameter list P;
statement list S;
@@
- static
T F(P) {{ S }}

// Pattern 2: Function definition with explicit type, next line brace  
@remove_static_def_nextline_{func}@
type T;
identifier F = {{ {func} }};
parameter list P;
statement list S;
@@
- static
T F(P)
{{ S }}

// Pattern 3: Function declaration with explicit type
@remove_static_decl_{func}@
type T;
identifier F = {{ {func} }};
parameter list P;
@@
- static
T F(P);

// Pattern 4: Inline function definition
@remove_static_inline_{func}@
type T;
identifier F = {{ {func} }};
parameter list P;
statement list S;
@@
- static
inline T F(P) {{ S }}

// Pattern 5: Static inline in different order
@remove_static_inline_alt_{func}@
type T;
identifier F = {{ {func} }};
parameter list P;
statement list S;
@@
- static inline
+ inline
T F(P) {{ S }}

// Pattern 6: Function with attributes (common in SQLite)
@remove_static_attr_{func}@
type T;
identifier F = {{ {func} }};
parameter list P;
statement list S;
attribute A;
@@
- static
A T F(P) {{ S }}

// Pattern 7: Function with const qualifier
@remove_static_const_{func}@
identifier F = {{ {func} }};
parameter list P;
statement list S;
type T;
@@
- static
const T F(P) {{ S }}

// Pattern 8: Function returning pointer
@remove_static_ptr_{func}@
type T;
identifier F = {{ {func} }};
parameter list P;
statement list S;
@@
- static
T * F(P) {{ S }}
"""

def generate_header() -> str:
    """Generate the header for the Coccinelle file"""
    return """// Auto-generated Coccinelle script to remove `static` keyword
// from specific functions listed in callsites.json
//
// This script uses multiple conservative patterns to handle various C function forms
// while maintaining compatibility with Coccinelle's parser.
//
// Supported patterns:
// - Standard function definitions and declarations
// - Inline functions  
// - Functions with attributes
// - Functions returning pointers
// - Different brace positioning styles
//
// Usage: spatch --sp-file remove_static.cocci --dir <source_directory> --in-place

@initialize:python@
@@
print(">>> Starting static keyword removal for specified functions")

"""

def generate_footer(func_count: int) -> str:
    """Generate the footer for the Coccinelle file"""
    return f"""
@finalize:python@
@@
print(">>> Completed processing {func_count} functions")
"""

def validate_functions(functions: List[str]) -> List[str]:
    """Validate and filter function names"""
    valid_functions = []
    for func in functions:
        if not func:
            continue
        if not VALID_IDENT.match(func):
            print(f"[WARN] Skipping invalid function name: {func}", file=sys.stderr)
            continue
        if len(func) > 64:  # Reasonable limit for function names
            print(f"[WARN] Skipping very long function name: {func[:32]}...", file=sys.stderr)
            continue
        valid_functions.append(func)
    
    return valid_functions

def main():
    parser = argparse.ArgumentParser(
        description="Generate Coccinelle script to remove 'static' keyword from specified functions",
        epilog="The generated .cocci file can be used with: spatch --sp-file output.cocci --dir /path/to/source --in-place"
    )
    parser.add_argument(
        "--json", 
        required=True, 
        help="Path to callsites.json file containing function lists"
    )
    parser.add_argument(
        "-o", "--output", 
        required=True, 
        help="Output path for the generated .cocci file"
    )
    parser.add_argument(
        "--max-functions",
        type=int,
        default=1000,
        help="Maximum number of functions to process (default: 1000)"
    )
    parser.add_argument(
        "--verbose", "-v",
        action="store_true",
        help="Enable verbose output"
    )
    
    args = parser.parse_args()

    # Load and validate functions
    if args.verbose:
        print(f"[INFO] Loading functions from: {args.json}")
    
    functions = load_callee_set(args.json)
    
    if not functions:
        print("[WARN] No valid function identifiers found in JSON file", file=sys.stderr)
        print("[INFO] Generating empty Coccinelle file with header only")
    else:
        if args.verbose:
            print(f"[INFO] Found {len(functions)} unique function names")
    
    # Validate functions
    valid_functions = validate_functions(functions)
    
    if len(valid_functions) != len(functions):
        print(f"[INFO] Filtered to {len(valid_functions)} valid functions")
    
    # Limit number of functions if requested
    if len(valid_functions) > args.max_functions:
        print(f"[WARN] Too many functions ({len(valid_functions)}), limiting to {args.max_functions}")
        valid_functions = valid_functions[:args.max_functions]
    
    # Generate output filename
    output_path = args.output
    if not output_path.endswith('.cocci'):
        output_path += '.cocci'
    
    # Generate Coccinelle script
    try:
        with open(output_path, 'w', encoding='utf-8') as f:
            # Write header
            f.write(generate_header())
            
            # Write rules for each function
            for func in valid_functions:
                if args.verbose:
                    print(f"[INFO] Generating rules for: {func}")
                f.write(generate_cocci_rules(func))
            
            # Write footer
            f.write(generate_footer(len(valid_functions)))
        
        print(f"[SUCCESS] Generated Coccinelle script: {output_path}")
        print(f"[INFO] Functions processed: {len(valid_functions)}")
        
        if valid_functions:
            print(f"[INFO] Sample functions: {', '.join(valid_functions[:5])}")
            if len(valid_functions) > 5:
                print(f"[INFO] ... and {len(valid_functions) - 5} more")
        
        print(f"\n[USAGE] Apply with: spatch --sp-file {output_path} --dir /path/to/sqlite/source --in-place")
        
    except IOError as e:
        print(f"[ERROR] Failed to write output file: {e}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"[ERROR] Unexpected error during file generation: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()