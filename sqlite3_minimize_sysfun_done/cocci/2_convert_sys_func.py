#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Generate a Coccinelle script that replaces sqlite3GlobalConfig.{mutex|m|pcache2}.xFunc(args) with direct function calls

Usage:
  python3 2_convert_sys_func.py --out output.cocci
  spatch --sp-file output.cocci --dir <sqlite_src> --in-place
"""

import argparse

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

def generate_cocci_script() -> str:
    """Generate complete Coccinelle script"""
    
    script_parts = []
    
    # Header
    script_parts.append("""// Auto-generated Coccinelle script for SQLite GlobalConfig transformation
// Replaces function pointer calls with direct function calls

@initialize:python@
@@
print(">>> Starting GlobalConfig transformation")

""")

    # Generate replacement rules
    script_parts.append("// ===== FUNCTION CALL REPLACEMENTS =====\n")
    
    # Mutex replacements
    for x_method, target_func in MUTEX_FUNCTIONS.items():
        rule_name = f"replace_mutex_{x_method.lower()}"
        script_parts.append(f"""
@{rule_name}@
identifier CFG = {{ sqlite3GlobalConfig }};
expression list A;
@@
- CFG.mutex.{x_method}(A)
+ {target_func}(A)
""")

    # Memory replacements
    for x_method, target_func in MEM_FUNCTIONS.items():
        rule_name = f"replace_mem_{x_method.lower()}"
        script_parts.append(f"""
@{rule_name}@
identifier CFG = {{ sqlite3GlobalConfig }};
expression list A;
@@
- CFG.m.{x_method}(A)
+ {target_func}(A)
""")

    # Page cache replacements
    for x_method, target_func in PCACHE_FUNCTIONS.items():
        rule_name = f"replace_pcache_{x_method.lower()}"
        script_parts.append(f"""
@{rule_name}@
identifier CFG = {{ sqlite3GlobalConfig }};
expression list A;
@@
- CFG.pcache2.{x_method}(A)
+ {target_func}(A)
""")

    # Footer
    script_parts.append("""
@finalize:python@
@@
print(">>> GlobalConfig transformation complete")
""")
    
    return "".join(script_parts)

def main():
    parser = argparse.ArgumentParser(description="Generate Coccinelle script for SQLite GlobalConfig transformation")
    parser.add_argument("--out", required=True, help="Output .cocci file path")
    
    args = parser.parse_args()
    
    # Generate script content
    content = generate_cocci_script()
    
    # Write to file
    output_path = args.out
    if not output_path.endswith('.cocci'):
        output_path += '.cocci'
        
    with open(output_path, 'w') as f:
        f.write(content)
    
    print(f"Generated: {output_path}")
    print(f"Usage: spatch --sp-file {output_path} --dir <sqlite_src> --in-place")

if __name__ == "__main__":
    main()