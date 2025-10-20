#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Collect function declarations from definitions directory based on function names
from the MUTEX_FUNCTIONS, MEM_FUNCTIONS, and PCACHE_FUNCTIONS dictionaries.

Usage:
  python3 collect_declarations.py --definitions-dir definitions --output all_declarations.txt
"""

import argparse
import os
import sys
from typing import Dict, List

# Function mappings: xMethod -> target function
MUTEX_FUNCTIONS = {
    'xMutexInit': 'noopMutexInit',
    'xMutexEnd': 'noopMutexEnd', 
    'xMutexAlloc': 'noopMutexAlloc',
    'xMutexFree': 'noopMutexFree',
    'xMutexEnter': 'noopMutexEnter',
    'xMutexTry': 'noopMutexTry',
    'xMutexLeave': 'noopMutexLeave',
}

MEM_FUNCTIONS = {
    'xMalloc': 'sqlite3MemMalloc',
    'xFree': 'sqlite3MemFree',
    'xRealloc': 'sqlite3MemRealloc',
    'xSize': 'sqlite3MemSize',
    'xRoundup': 'sqlite3MemRoundup',
    'xInit': 'sqlite3MemInit',
    'xShutdown': 'sqlite3MemShutdown',
}

PCACHE_FUNCTIONS = {
    'xInit': 'pcache1Init',
    'xShutdown': 'pcache1Shutdown',
    'xCreate': 'pcache1Create',
    'xCachesize': 'pcache1Cachesize',
    'xPagecount': 'pcache1Pagecount',
    'xFetch': 'pcache1Fetch',
    'xUnpin': 'pcache1Unpin',
    'xRekey': 'pcache1Rekey',
    'xTruncate': 'pcache1Truncate',
    'xDestroy': 'pcache1Destroy',
    'xShrink': 'pcache1Shrink',
}

def collect_all_function_names() -> List[str]:
    """Collect all unique function names from the dictionaries"""
    all_functions = set()
    
    all_functions.update(MUTEX_FUNCTIONS.values())
    all_functions.update(MEM_FUNCTIONS.values())
    all_functions.update(PCACHE_FUNCTIONS.values())
    
    return sorted(list(all_functions))

def read_function_declaration(definitions_dir: str, func_name: str) -> List[str]:
    """Read function declaration from definitions/{func_name}.txt"""
    file_path = os.path.join("./definitions/", f"{func_name}.txt")
    
    if not os.path.exists(file_path):
        print(f"[WARNING] File not found: {file_path}")
        return []
    
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            lines = f.readlines()
            # Strip whitespace and filter out empty lines
            return [line.strip() for line in lines if line.strip()]
    except Exception as e:
        print(f"[ERROR] Failed to read {file_path}: {e}")
        return []

def main():
    parser = argparse.ArgumentParser(
        description="Collect function declarations from definitions directory"
    )
    parser.add_argument(
        "--definitions-dir", 
        default="./definitions/",
        help="Directory containing function declaration files (default: definitions)"
    )
    parser.add_argument(
        "--output", 
        default="all_declarations.txt",
        help="Output file path (default: all_declarations.txt)"
    )
    parser.add_argument(
        "--verbose", 
        action="store_true",
        help="Enable verbose output"
    )
    
    args = parser.parse_args()
    
    # Check if definitions directory exists
    if not os.path.exists(args.definitions_dir):
        print(f"[ERROR] Definitions directory not found: {args.definitions_dir}")
        sys.exit(1)
    
    # Collect all function names
    function_names = collect_all_function_names()
    
    if args.verbose:
        print(f"[INFO] Found {len(function_names)} unique function names:")
        for name in function_names:
            print(f"  - {name}")
        print()
    
    # Collect all declarations
    all_declarations = []
    found_files = 0
    
    for func_name in function_names:
        if args.verbose:
            print(f"[INFO] Processing {func_name}...")
        
        declarations = read_function_declaration(args.definitions_dir, func_name)
        
        if declarations:
            found_files += 1
            # all_declarations.append(f"// === {func_name} ===")
            all_declarations.extend(declarations)
            # all_declarations.append("")  # Empty line separator
        elif args.verbose:
            print(f"[WARNING] No declarations found for {func_name}")
    
    # Write output file
    try:
        with open(args.output, 'w', encoding='utf-8') as f:
            f.write("// Auto-generated function declarations\n")
            f.write(f"// Collected from {found_files} definition files\n\n")
            
            for line in all_declarations:
                f.write(line + '\n')
        
        print(f"[SUCCESS] Wrote {len(all_declarations)} lines to {args.output}")
        print(f"[INFO] Processed {found_files}/{len(function_names)} function files")
        
    except Exception as e:
        print(f"[ERROR] Failed to write output file: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()