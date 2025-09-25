#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Generate a Coccinelle .cocci file that removes only the `static` keyword
from definitions/declarations of functions listed in callsites.json (callee[]).

Enhanced with position tracking and function declaration extraction:
- Tracks positions where static keywords are removed
- Extracts function signatures and saves them to definition files
- More robust function matching patterns
- Better handling of edge cases
- Improved pointer handling for return types and parameters
"""

import argparse
import json
import re
import sys
from typing import List, Set

VALID_IDENT = re.compile(r'^[A-Za-z_]\w*$')

# Additional functions from SQLite structure definitions
SQLITE_STRUCTURE_FUNCTIONS = [
    # From sqlite3_mutex_methods sMutex
    "noopMutexInit",
    "noopMutexEnd", 
    "noopMutexAlloc",
    "noopMutexFree",
    "noopMutexEnter",
    "noopMutexTry",
    "noopMutexLeave",
    
    # From sqlite3_mem_methods defaultMethods
    "sqlite3MemMalloc",
    "sqlite3MemFree",
    "sqlite3MemRealloc",
    "sqlite3MemSize",
    "sqlite3MemRoundup", 
    "sqlite3MemInit",
    "sqlite3MemShutdown",
    
    # From sqlite3_pcache_methods2 defaultMethods
    "pcache1Init",
    "pcache1Shutdown",
    "pcache1Create",
    "pcache1Cachesize",
    "pcache1Pagecount",
    "pcache1Fetch",
    "pcache1Unpin",
    "pcache1Rekey",
    "pcache1Truncate",
    "pcache1Destroy",
    "pcache1Shrink",
    
    # From UNIXVFS structure (VFS functions)
    "unixOpen",
    "unixDelete",
    "unixAccess",
    "unixFullPathname",
    "unixDlOpen",
    "unixDlError",
    "unixDlSym",
    "unixDlClose",
    "unixRandomness",
    "unixSleep",
    "unixCurrentTime",
    "unixGetLastError",
    "unixCurrentTimeInt64",
    "unixSetSystemCall",
    "unixGetSystemCall",
    "unixNextSystemCall"
]

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

def merge_function_lists(json_functions: List[str], additional_functions: List[str], verbose: bool = False) -> List[str]:
    """Merge JSON functions with additional SQLite structure functions"""
    json_set = set(json_functions)
    additional_set = set(additional_functions)
    
    # Find new functions that are not in JSON
    new_functions = additional_set - json_set
    
    if verbose and new_functions:
        print(f"[INFO] Adding {len(new_functions)} additional SQLite structure functions:")
        for func in sorted(new_functions):
            print(f"[INFO]   + {func}")
    
    # Combine and sort
    combined_functions = sorted(json_set | additional_set)
    
    if verbose:
        print(f"[INFO] Total functions after merge: {len(combined_functions)}")
        print(f"[INFO] From JSON: {len(json_functions)}, Additional: {len(new_functions)}")
    
    return combined_functions

def clean_function_signature(signature: str) -> str:
    """
    Clean up function signature formatting with improved pointer handling
    
    Handles:
    - Return type pointers: int *func -> int *func
    - Parameter pointers: sqlite3_value** argv -> sqlite3_value **argv
    - Multiple pointer levels: sqlite3_value*** -> sqlite3_value ***
    - Mixed spacing issues
    """
    if not signature:
        return signature
    
    # Step 1: Normalize all whitespace to single spaces
    signature = re.sub(r'\s+', ' ', signature.strip())
    
    # Step 2: Handle parameter pointers - add space before ** but not after
    # Match patterns like "type**param" or "type***param" and convert to "type **param" or "type ***param"
    signature = re.sub(r'(\w)(\*+)(\w)', r'\1 \2\3', signature)
    
    # Step 3: Handle return type pointers - ensure space between type and pointer
    # Match patterns at the beginning like "int*" and convert to "int *"
    signature = re.sub(r'^(\w+)(\*+)', r'\1 \2', signature)
    
    # Step 4: Fix function pointer return types more carefully
    # Match patterns like "int*functionName(" and convert to "int *functionName("
    signature = re.sub(r'(\w)(\*+)(\w+\s*\()', r'\1 \2\3', signature)
    
    # Step 5: Clean up any double spaces that might have been introduced
    signature = re.sub(r'\s+', ' ', signature)
    
    # Step 6: Ensure no space between consecutive asterisks (keep ** not * *)
    # But allow space before the asterisk group
    signature = re.sub(r'\*\s+\*', '**', signature)
    signature = re.sub(r'\*\s+\*\s+\*', '***', signature)
    
    return signature.strip()

def generate_signature_extraction_script(rule_name: str, has_type: bool = True) -> str:
    """Generate Python script for signature extraction with improved pointer handling"""
    type_vars = "T << {0}.T;\n".format(rule_name) if has_type else ""
    type_in_signature = "{T} " if has_type else "void "
    
    return f"""
@script:python depends on {rule_name}@
F << {rule_name}.F;
{type_vars}P << {rule_name}.P;
p << {rule_name}.p;
@@
import os
import re

def clean_function_signature(signature):
    '''Clean up function signature formatting with improved pointer handling'''
    if not signature:
        return signature
    
    # Step 1: Normalize all whitespace to single spaces
    signature = re.sub(r'\\s+', ' ', signature.strip())
    
    # Step 2: Remove all spaces around asterisks first to start clean
    signature = re.sub(r'\\s*\\*\\s*', '*', signature)
    
    # Step 3: Add space before asterisk groups (but not after)
    # Match patterns like "type*" or "type**" and convert to "type *" or "type **"
    signature = re.sub(r'(\\w)(\\*+)', r'\\1 \\2', signature)
    
    # Step 4: Clean up any double spaces that might have been introduced
    signature = re.sub(r'\\s+', ' ', signature)
    
    return signature.strip()

os.makedirs("definitions", exist_ok=True)
clean_signature = clean_function_signature(f"{type_in_signature}{{F}}({{P}});")
with open(f"definitions/{{F}}.txt", "w") as f:
    f.write(f"{{clean_signature}}\\n")
print(f"[EXTRACTED] {{F}} definition saved to definitions/{{F}}.txt")
"""

def generate_cocci_rules(func: str) -> str:
    """Generate Coccinelle rules for a specific function with position tracking"""
    return f"""
// Rules for function: {func}
@remove_static_def_brace_same_line_{func}@
identifier F = {{ {func} }};
type T;
parameter list P;
statement list BODY;
position p;
@@
- static@p
T F(P) {{ BODY }}

@remove_static_def_brace_next_line_{func}@
identifier F = {{ {func} }};
type T;
parameter list P;
statement list BODY;
position p;
@@
- static@p
T F(P)
{{ BODY }}

@remove_static_def_no_type_{func}@
identifier F = {{ {func} }};
parameter list P;
statement list BODY;
position p;
@@
- static@p
F(P) {{ BODY }}

@remove_static_decl_with_type_{func}@
identifier F = {{ {func} }};
type T;
parameter list P;
position p;
@@
- static@p
T F(P);

@remove_static_inline_{func}@
identifier F = {{ {func} }};
type T;
parameter list P;
statement list BODY;
position p;
@@
- static@p
inline T F(P) {{ BODY }}

{generate_signature_extraction_script(f"remove_static_def_brace_same_line_{func}", True)}

{generate_signature_extraction_script(f"remove_static_def_brace_next_line_{func}", True)}

{generate_signature_extraction_script(f"remove_static_def_no_type_{func}", False)}

{generate_signature_extraction_script(f"remove_static_decl_with_type_{func}", True)}

{generate_signature_extraction_script(f"remove_static_inline_{func}", True)}
"""

def generate_header() -> str:
    """Generate the header for the Coccinelle file"""
    return """// Auto-generated Coccinelle script to remove `static` keyword
// from specific functions listed in callsites.json and SQLite structure definitions
//
// This script uses identifier constraints to ensure precise matching
// and avoid false positives with similarly named types or variables.
//
// Enhanced features:
// - Position tracking for removed static keywords
// - Automatic extraction of function signatures to definitions/ folder
// - Support for various function declaration/definition formats
// - Improved pointer handling for return types and parameters
//
// Includes functions from:
// - callsites.json callee lists
// - sqlite3_mutex_methods structure (mutex functions)
// - sqlite3_mem_methods structure (memory functions)  
// - sqlite3_pcache_methods2 structure (page cache functions)
// - UNIXVFS structure (VFS functions)
//
// Usage: spatch --sp-file remove_static.cocci --dir <source_directory> --in-place

"""

def generate_footer(func_count: int, json_count: int, additional_count: int) -> str:
    """Generate the footer for the Coccinelle file"""
    return f"""
@finalize:python@
@@
print(">>> Completed processing {func_count} functions")
print(">>> From JSON: {json_count}, Additional SQLite structures: {additional_count}")
print(">>> Function declarations extracted to definitions/ folder")
"""

def generate_tracking_summary() -> str:
    """Generate additional tracking summary script"""
    return """
@script:python@
@@
import os
import glob

print("\\n>>> EXTRACTION SUMMARY")
def_files = glob.glob("definitions/*.txt")
print(f">>> Total function declarations extracted: {len(def_files)}")

if def_files:
    print(">>> Extracted functions:")
    for def_file in sorted(def_files):
        func_name = os.path.basename(def_file).replace('.txt', '')
        try:
            with open(def_file, 'r') as f:
                signature = f.read().strip()
            print(f">>>   {func_name}: {signature}")
        except:
            print(f">>>   {func_name}: [ERROR reading file]")

print(">>> Use these declarations when adding function prototypes")
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
        description="Generate Coccinelle script to remove 'static' keyword and extract function signatures",
        epilog="The generated .cocci file removes static keywords and saves function declarations to definitions/ folder"
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
        "--no-additional",
        action="store_true",
        help="Skip adding additional SQLite structure functions"
    )
    parser.add_argument(
        "--no-extraction",
        action="store_true",
        help="Skip function signature extraction (only remove static keywords)"
    )
    parser.add_argument(
        "--verbose", "-v",
        action="store_true",
        help="Enable verbose output"
    )
    
    args = parser.parse_args()

    # Load and validate functions from JSON
    if args.verbose:
        print(f"[INFO] Loading functions from: {args.json}")
    
    json_functions = load_callee_set(args.json)
    
    if not json_functions:
        print("[WARN] No valid function identifiers found in JSON file", file=sys.stderr)
        if args.no_additional:
            print("[INFO] Generating empty Coccinelle file with header only")
        else:
            print("[INFO] Will use only additional SQLite structure functions")
    else:
        if args.verbose:
            print(f"[INFO] Found {len(json_functions)} unique function names from JSON")
    
    # Merge with additional functions if not disabled
    if args.no_additional:
        functions = json_functions
        additional_count = 0
        if args.verbose:
            print("[INFO] Skipping additional SQLite structure functions")
    else:
        functions = merge_function_lists(json_functions, SQLITE_STRUCTURE_FUNCTIONS, args.verbose)
        additional_count = len(set(SQLITE_STRUCTURE_FUNCTIONS) - set(json_functions))
    
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
            
            # Add extraction summary if not disabled
            if not args.no_extraction:
                f.write(generate_tracking_summary())
            
            # Write footer
            f.write(generate_footer(len(valid_functions), len(json_functions), additional_count))
        
        print(f"[SUCCESS] Generated Coccinelle script: {output_path}")
        print(f"[INFO] Functions processed: {len(valid_functions)}")
        print(f"[INFO] From JSON: {len(json_functions)}")
        if not args.no_additional:
            print(f"[INFO] Additional SQLite functions: {additional_count}")
        
        if valid_functions:
            print(f"[INFO] Sample functions: {', '.join(valid_functions[:5])}")
            if len(valid_functions) > 5:
                print(f"[INFO] ... and {len(valid_functions) - 5} more")
        
        # Show breakdown by category if verbose
        if args.verbose and not args.no_additional:
            print(f"\n[FUNCTION BREAKDOWN]")
            mutex_funcs = [f for f in valid_functions if f.startswith(('noopMutex', 'debugMutex'))]
            mem_funcs = [f for f in valid_functions if f.startswith('sqlite3Mem')]
            pcache_funcs = [f for f in valid_functions if f.startswith('pcache1')]
            unix_funcs = [f for f in valid_functions if f.startswith('unix')]
            
            if mutex_funcs:
                print(f"  Mutex functions: {len(mutex_funcs)}")
            if mem_funcs:
                print(f"  Memory functions: {len(mem_funcs)}")
            if pcache_funcs:
                print(f"  Page cache functions: {len(pcache_funcs)}")
            if unix_funcs:
                print(f"  UNIX VFS functions: {len(unix_funcs)}")
        
        print(f"\n[FEATURES]")
        print(f"✓ Static keyword removal")
        if not args.no_extraction:
            print(f"✓ Function signature extraction to definitions/ folder")
        print(f"✓ Position tracking for changes")
        print(f"✓ Comprehensive pattern matching")
        print(f"✓ Enhanced pointer handling for return types and parameters")
        
        print(f"\n[USAGE] Apply with: spatch --sp-file {output_path} --dir /path/to/sqlite/source --in-place")
        
    except IOError as e:
        print(f"[ERROR] Failed to write output file: {e}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"[ERROR] Unexpected error during file generation: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
