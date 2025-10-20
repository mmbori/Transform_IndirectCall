# # #!/usr/bin/env python3
# # # -*- coding: utf-8 -*-

# # """
# # Generate a Coccinelle script that:
# # 1. Uses Python to find all structs with function pointer members
# # 2. Uses Coccinelle to transform function pointer assignments to memcpy calls
# # 3. Converts: E.FP_NAME = FUNC_NAME; -> memcpy(E.FP_NAME_signature, FP_NAME_signatures[FP_NAME_FUNC_NAME_enum])

# # Usage:clear
# #   python3 fp_to_memcpy_converter.py --source-dir <source_dir> --output convert_fp_to_memcpy.cocci
# # """

# # import argparse
# # import os
# # import re
# # import sys
# # from typing import Dict, List, Set, Tuple
# # import glob

# # def read_target_fp_names(file_path: str = "target_fpNames.txt") -> Set[str]:
# #     """
# #     Read target function pointer names from target_fpNames.txt file
# #     Returns: Set of function pointer names to transform
# #     """
# #     fp_names = set()
    
# #     if not os.path.exists(file_path):
# #         print(f"[ERROR] Target file not found: {file_path}")
# #         return fp_names
    
# #     try:
# #         with open(file_path, 'r', encoding='utf-8') as f:
# #             for line in f:
# #                 line = line.strip()
# #                 if line and not line.startswith('#'):  # Skip empty lines and comments
# #                     fp_names.add(line)
        
# #         print(f"[INFO] Loaded {len(fp_names)} function pointer names from {file_path}")
# #         return fp_names
        
# #     except Exception as e:
# #         print(f"[ERROR] Failed to read {file_path}: {e}")
# #         return fp_names

# # def read_functions_for_fp(fp_name: str, fpnames_dir: str = "fpName") -> Set[str]:
# #     """
# #     Read function names for a specific function pointer from fpNames/fp_name.txt
# #     Returns: Set of function names for this function pointer
# #     """
# #     functions = set()
# #     file_path = os.path.join(fpnames_dir, f"{fp_name}.txt")
    
# #     if not os.path.exists(file_path):
# #         print(f"[WARNING] Function list file not found: {file_path}")
# #         return functions
    
# #     try:
# #         with open(file_path, 'r', encoding='utf-8') as f:
# #             for line in f:
# #                 line = line.strip()
# #                 if line and not line.startswith('#'):  # Skip empty lines and comments
# #                     functions.add(line)
        
# #         print(f"[INFO] Loaded {len(functions)} functions for {fp_name} from {file_path}")
# #         return functions
        
# #     except Exception as e:
# #         print(f"[ERROR] Failed to read {file_path}: {e}")
# #         return functions

# # def generate_memcpy_transformation_rules(target_fp_names: set[str], fpnames_dir: str = "fpName") -> str:
# #     """
# #     Transform:
# #       E.<fp> = FUNC; / E-><fp> = &FUNC;
# #     into:
# #       memcpy(E.<fp>_signature,
# #              <fp>_signatures[<fp>_<FUNC>_enum],
# #              sizeof(E.<fp>_signature));
    
# #     For each fp_name, read the corresponding functions from fpNames/fp_name.txt
# #     and generate individual rules for each function.
# #     """
# #     out = []
# #     out.append("// ===== FUNCTION POINTER ASSIGNMENT TO MEMCPY (specific functions) =====\n")

# #     total_rules = 0
    
# #     for fp_name in sorted(target_fp_names):
# #         if "multiplex" in fp_name :
# #             pass
# #         if "quota" in fp_name :
# #             pass
# #         if "fts5" in fp_name :
# #             pass
        
# #         # Read functions for this function pointer
# #         functions = read_functions_for_fp(fp_name, fpnames_dir)
        
# #         if not functions:
# #             print(f"[WARNING] No functions found for {fp_name}, skipping...")
# #             continue
            
# #         out.append(f"\n// Rules for {fp_name} ({len(functions)} functions)")
        
# #         # Generate a rule for each function
# #         for func_name in sorted(functions):
# #             rule_name = f"transform_{fp_name}_{func_name}"
# #             total_rules += 1
            
# #             out.append(f"""
# # // Rule: .{fp_name} = {func_name} ==> memcpy(...{fp_name}_signature..., {fp_name}_signatures[{fp_name}_{func_name}_enum], ...)
# # @{rule_name}@
# # expression E;
# # identifier FP_NAME = {fp_name};
# # identifier FUNC_NAME = {func_name};
# # @@
# # (
# # E.FP_NAME = FUNC_NAME;
# # + memcpy(E.{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func_name}_enum], sizeof(E.{fp_name}_signature));
# # |
# # E.FP_NAME = &FUNC_NAME;
# # + memcpy(E.{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func_name}_enum], sizeof(E.{fp_name}_signature));
# # |
# # E.FP_NAME = 0;
# # + memcpy(E.{fp_name}_signature, {fp_name}_signatures[{fp_name}_0_enum], sizeof(E.{fp_name}_signature));
# # |
# # E->FP_NAME = FUNC_NAME;
# # + memcpy(E->{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func_name}_enum], sizeof(E->{fp_name}_signature));
# # |
# # E->FP_NAME = &FUNC_NAME;
# # + memcpy(E->{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func_name}_enum], sizeof(E->{fp_name}_signature));
# # |
# # E->FP_NAME = 0;
# # + memcpy(E->{fp_name}_signature, {fp_name}_signatures[{fp_name}_0_enum], sizeof(E->{fp_name}_signature));
# # )
# # """)
    
# #     out.append(f"\n// Total transformation rules generated: {total_rules}\n")
# #     return "".join(out)

# # def generate_logging_rules(target_fp_names: Set[str], fpnames_dir: str = "fpName") -> str:
# #     """Generate rules to log transformation information (after each transform)"""
# #     rules = []
# #     rules.append("// ===== LOGGING AND TRACKING RULES =====\n")

# #     for fp_name in target_fp_names:
# #         functions = read_functions_for_fp(fp_name, fpnames_dir)
        
# #         if not functions:
# #             continue
            
# #         for func_name in sorted(functions):
# #             rule_name = f"transform_{fp_name}_{func_name}"
            
# #             rules.append(f"""
# # @script:python depends on {rule_name}@
# # FUNC_NAME << {rule_name}.FUNC_NAME;
# # @@
# # import os
# # os.makedirs("memcpy_transformations", exist_ok=True)
# # with open("memcpy_transformations/{fp_name}_transformations.txt", "a") as f:
# #     f.write(f"[OK] {fp_name} = {func_name} -> memcpy({fp_name}_signature, {fp_name}_signatures[{fp_name}_{func_name}_enum])\\n")
# # print(f"[TRANSFORMED] {fp_name} = {func_name} -> memcpy({fp_name}_signature, {fp_name}_signatures[{fp_name}_{func_name}_enum])")
# # """)
# #     return "".join(rules)

# # def generate_cocci_script(target_fp_names: Set[str], fpnames_dir: str = "fpName") -> str:
# #     """Generate the complete Coccinelle script"""
    
# #     script_parts = []
    
# #     # Header
# #     script_parts.append("""// Auto-generated Coccinelle script for function pointer to memcpy conversion
# # // 
# # // This script transforms function pointer assignments to memcpy calls:
# # //   E.FP_NAME = FUNC_NAME; -> memcpy(E.FP_NAME_signature, FP_NAME_signatures[FP_NAME_FUNC_NAME_enum], sizeof(...));
# # //
# # // Usage: spatch --sp-file convert_fp_to_memcpy.cocci --dir <source_directory> --in-place

# # @initialize:python@
# # @@
# # print(">>> Starting function pointer to memcpy conversion")
# # print(">>> Transforming assignments to memcpy calls")

# # # Clean up any existing output directories
# # import os
# # import shutil
# # if os.path.exists("memcpy_transformations"):
# #     shutil.rmtree("memcpy_transformations")
# # os.makedirs("memcpy_transformations", exist_ok=True)

# # print(">>> Created output directory: memcpy_transformations/")

# # """)
    
# #     if not target_fp_names:
# #         script_parts.append("// No target function pointers specified\n")
# #         return "".join(script_parts)
    
# #     # Generate transformation rules
# #     script_parts.append(generate_memcpy_transformation_rules(target_fp_names, fpnames_dir))
    
# #     # Generate logging rules (commented out by default)
# #     # script_parts.append(generate_logging_rules(target_fp_names, fpnames_dir))
    
# #     # Footer with usage instructions
# #     script_parts.append("""
# # // ===== USAGE INSTRUCTIONS =====
# # /*
# # After running this script:

# # 1. Check memcpy_transformations/ directory for transformation logs

# # Example transformation:
# #    Before: obj.callback = my_function;
# #    After:  memcpy(obj.callback_signature, callback_signatures[callback_my_function_enum], sizeof(obj.callback_signature));

# # Note: This assumes that:
# # - FP_NAME_signatures arrays are already defined
# # - FP_NAME_FUNC_NAME_enum values are already defined
# # - Structs have FP_NAME_signature fields
# # - <string.h> is included where needed
# # */

# # """)
    
# #     return "".join(script_parts)

# # def main():
# #     parser = argparse.ArgumentParser(
# #         description="Generate Coccinelle script to convert function pointer assignments to memcpy calls"
# #     )
# #     parser.add_argument(
# #         "--source-dir",
# #         required=True,
# #         help="Directory containing source code"
# #     )
# #     parser.add_argument(
# #         "--output",
# #         default="convert_fp_to_memcpy.cocci",
# #         help="Output Coccinelle script file (default: convert_fp_to_memcpy.cocci)"
# #     )
# #     parser.add_argument(
# #         "--fpnames-dir",
# #         default="fpName",
# #         help="Directory containing function lists for each FP (default: fpName)"
# #     )
# #     parser.add_argument(
# #         "--verbose", "-v",
# #         action="store_true",
# #         help="Enable verbose output"
# #     )
# #     parser.add_argument(
# #         "--debug", "-d",
# #         action="store_true",
# #         help="Enable debug output"
# #     )
    
# #     args = parser.parse_args()
    
# #     if not os.path.exists(args.source_dir):
# #         print(f"[ERROR] Source directory not found: {args.source_dir}")
# #         sys.exit(1)
    
# #     if not os.path.exists(args.fpnames_dir):
# #         print(f"[ERROR] fpNames directory not found: {args.fpnames_dir}")
# #         print(f"[INFO] Please create {args.fpnames_dir}/ directory with function list files (e.g., xAccess.txt, xOpen.txt)")
# #         sys.exit(1)
    
# #     print(f"[INFO] Scanning source directory: {args.source_dir}")
# #     print(f"[INFO] Using fpNames directory: {args.fpnames_dir}")
    
# #     # Step 1: Read target function pointer names from file
# #     target_fp_names = read_target_fp_names("target_fpNames.txt")
    
# #     if not target_fp_names:
# #         print("[ERROR] No target function pointer names found in target_fpNames.txt")
# #         print("[INFO] Please create target_fpNames.txt with function pointer names (one per line)")
# #         sys.exit(1)
    
# #     # Step 2: Check that we have function files for each target FP
# #     missing_fp_files = []
# #     total_functions = 0
    
# #     for fp_name in target_fp_names:
# #         functions = read_functions_for_fp(fp_name, args.fpnames_dir)
# #         if not functions:
# #             missing_fp_files.append(fp_name)
# #         else:
# #             total_functions += len(functions)
    
# #     if missing_fp_files:
# #         print(f"[WARNING] Missing function files for: {', '.join(missing_fp_files)}")
# #         print(f"[INFO] Please create files in {args.fpnames_dir}/ directory:")
# #         for fp_name in missing_fp_files:
# #             print(f"[INFO]   {args.fpnames_dir}/{fp_name}.txt")
    
# #     if args.debug:
# #         print(f"\n[DEBUG] Target function pointer names and their functions:")
# #         for fp_name in sorted(target_fp_names):
# #             functions = read_functions_for_fp(fp_name, args.fpnames_dir)
# #             print(f"[DEBUG]   {fp_name}: {len(functions)} functions")
# #             if args.verbose:
# #                 for func_name in sorted(functions):
# #                     print(f"[DEBUG]     {func_name}")
    
# #     print(f"\n[SUMMARY] Target function pointers: {len(target_fp_names)}")
# #     print(f"[SUMMARY] Total functions to transform: {total_functions}")
    
# #     if args.verbose:
# #         for fp_name in sorted(target_fp_names):
# #             functions = read_functions_for_fp(fp_name, args.fpnames_dir)
# #             print(f"  {fp_name}: {len(functions)} functions")
    
# #     # Step 3: Generate Coccinelle script
# #     print(f"\n[INFO] Generating Coccinelle script...")
    
# #     script_content = generate_cocci_script(target_fp_names, args.fpnames_dir)
    
# #     # Write output file
# #     output_path = args.output
# #     if not output_path.endswith('.cocci'):
# #         output_path += '.cocci'
    
# #     try:
# #         with open(output_path, 'w', encoding='utf-8') as f:
# #             f.write(script_content)
        
# #         print(f"[SUCCESS] Generated Coccinelle script: {output_path}")
# #         print(f"[INFO] Target function pointers: {len(target_fp_names)}")
# #         print(f"[INFO] Total transformation rules: {total_functions}")
        
# #         print(f"\n[TRANSFORMATION] Will convert:")
# #         print(f"  E.FP_NAME = FUNC_NAME;")
# #         print(f"  ↓")
# #         print(f"  memcpy(E.FP_NAME_signature, FP_NAME_signatures[FP_NAME_FUNC_NAME_enum], sizeof(...));")
        
# #         print(f"\n[USAGE] Apply transformation:")
# #         print(f"  spatch --sp-file {output_path} --dir {args.source_dir} --in-place")
        
# #         print(f"\n[OUTPUT] After execution, check:")
# #         print(f"  memcpy_transformations/ - Transformation logs")
        
# #         print(f"\n[ASSUMPTIONS] This script assumes:")
# #         print(f"  ✓ FP_NAME_signatures arrays are already defined")
# #         print(f"  ✓ FP_NAME_FUNC_NAME_enum values are already defined")
# #         print(f"  ✓ Structs have FP_NAME_signature fields")
# #         print(f"  ✓ <string.h> is included where needed")
        
# #     except Exception as e:
# #         print(f"[ERROR] Failed to write output file: {e}")
# #         sys.exit(1)

# # if __name__ == "__main__":
# #     main()

# # # !/usr/bin/env python3
# # # -*- coding: utf-8 -*-

# #!/usr/bin/env python3
# # -*- coding: utf-8 -*-

# """
# Generate a Coccinelle script that:
# 1. Uses Python to find all structs with function pointer members
# 2. Uses Coccinelle to transform function pointer assignments to memcpy calls
# 3. Converts: E.FP_NAME = FUNC_NAME; -> memcpy(E.FP_NAME_signature, FP_NAME_signatures[FP_NAME_FUNC_NAME_enum])
# 4. Excludes functions from remove_fn_list.txt

# Usage:
#   python3 new_5_transform_fp_assigning.py --source-dir <source_dir> --output convert_fp_to_memcpy.cocci
# """

# import argparse
# import os
# import re
# import sys
# from typing import Dict, List, Set, Tuple
# import glob

# def read_remove_list(file_path: str = "remove_fn_list.txt") -> Set[str]:
#     """Read functions to exclude from remove_fn_list.txt"""
#     removed_functions = set()
    
#     if not os.path.exists(file_path):
#         print(f"[WARNING] Remove list file not found: {file_path}")
#         return removed_functions
    
#     try:
#         with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
#             for line in f:
#                 line = line.strip()
#                 if line and not line.startswith('#') and not line.startswith('//'):
#                     func_name = re.sub(r'[^\w]', '', line)
#                     if func_name:
#                         removed_functions.add(func_name)
        
#         print(f"[INFO] Loaded {len(removed_functions)} functions to exclude from {file_path}")
#         return removed_functions
        
#     except Exception as e:
#         print(f"[ERROR] Failed to read {file_path}: {e}")
#         return removed_functions

# def read_target_fp_names(file_path: str = "target_fpNames.txt") -> Set[str]:
#     """
#     Read target function pointer names from target_fpNames.txt file
#     Returns: Set of function pointer names to transform
#     """
#     fp_names = set()
    
#     if not os.path.exists(file_path):
#         print(f"[ERROR] Target file not found: {file_path}")
#         return fp_names
    
#     try:
#         with open(file_path, 'r', encoding='utf-8') as f:
#             for line in f:
#                 line = line.strip()
#                 if line and not line.startswith('#'):
#                     fp_names.add(line)
        
#         print(f"[INFO] Loaded {len(fp_names)} function pointer names from {file_path}")
#         return fp_names
        
#     except Exception as e:
#         print(f"[ERROR] Failed to read {file_path}: {e}")
#         return fp_names

# def read_functions_for_fp(fp_name: str, fpnames_dir: str = "fpName") -> List[str]:
#     """
#     Read function names for a specific function pointer from fpNames/fp_name.txt
#     Returns: List of function names (maintaining order)
#     """
#     functions = []
#     file_path = os.path.join(fpnames_dir, f"{fp_name}.txt")
    
#     if not os.path.exists(file_path):
#         print(f"[WARNING] Function list file not found: {file_path}")
#         return functions
    
#     try:
#         with open(file_path, 'r', encoding='utf-8') as f:
#             for line in f:
#                 line = line.strip()
#                 if line and not line.startswith('#'):
#                     functions.append(line)
        
#         print(f"[INFO] Loaded {len(functions)} functions for {fp_name} from {file_path}")
#         return functions
        
#     except Exception as e:
#         print(f"[ERROR] Failed to read {file_path}: {e}")
#         return functions

# SKIP_SUBSTRS = ("quota", "fts5", "multiplex")
# # SKIP_SUBSTRS = ("quota", "fts5", "multiplex", "amatch", "binfo", "carray", "cf", 
# #                 "cidx", "cksm", "closure", "csvtab", "deltaparsevtab", "demo", "devsym", 
# #                 "echo", "explain", "faultsim", "fs", "fts3", "fuzzer", "geopoly", "icu", 
# #                 "intarray", "jt", "kvv", "mem", "prefixes", "qpvtab", "rbuVfs", "schema", 
# #                 "spell", "tcl", "templatevtab", "testTokenizer", "testpcache", "tmp", "tvfs", 
# #                 "union", "vfslog", "vstat", "vtablog", "wholenumber", "win", "wr", "writecrash")

# def _coerce_name(x) -> str:
#     """다양한 형태의 입력을 문자열 이름으로 변환"""
#     if isinstance(x, (tuple, list)):
#         if len(x) == 0:
#             return ""
#         cand = x[1] if len(x) > 1 and isinstance(x[1], (str, bytes)) else x[0]
#         return cand.decode() if isinstance(cand, bytes) else str(cand)
#     return x.decode() if isinstance(x, bytes) else str(x)

# def _skip_func(name_like, removed_functions: Set[str]) -> bool:
#     """함수를 제외해야 하는지 확인"""
#     n = _coerce_name(name_like)
    
#     # 'x'로 시작하는 함수 제외
#     if n.startswith('x'):
#         return True
    
#     # remove_fn_list.txt에 있는 함수 제외
#     if n in removed_functions:
#         return True
    
#     # quota, fts5, multiplex 포함 함수 제외
#     return any(s in n.lower() for s in SKIP_SUBSTRS)

# def generate_memcpy_transformation_rules(target_fp_names: set[str], fpnames_dir: str = "fpName", 
#                                         removed_functions: Set[str] = set()) -> str:
#     """
#     Transform:
#       E.<fp> = FUNC; / E-><fp> = &FUNC;
#     into:
#       memcpy(E.<fp>_signature,
#              <fp>_signatures[<fp>_<FUNC>_enum],
#              sizeof(E.<fp>_signature));
    
#     For each fp_name, read the corresponding functions from fpNames/fp_name.txt
#     and generate individual rules for each function (excluding removed functions).
#     """
#     out = []
#     out.append("// ===== FUNCTION POINTER ASSIGNMENT TO MEMCPY (specific functions) =====\n")

#     total_rules = 0
#     excluded_count = 0
    
#     for fp_name in sorted(target_fp_names):
#         # Read functions for this function pointer
#         functions = read_functions_for_fp(fp_name, fpnames_dir)
        
#         if not functions:
#             print(f"[WARNING] No functions found for {fp_name}, skipping...")
#             continue
        
#         # Filter out functions that should be skipped
#         valid_functions = [f for f in functions if not _skip_func(_coerce_name(f), removed_functions)]
#         excluded_count += len(functions) - len(valid_functions)
        
#         if not valid_functions:
#             print(f"[WARNING] All functions for {fp_name} are excluded, skipping...")
#             continue
            
#         out.append(f"\n// Rules for {fp_name} ({len(valid_functions)} valid functions, {len(functions) - len(valid_functions)} excluded)")
        
#         # Generate a rule for each valid function
#         for func_name in valid_functions:
#             func = _coerce_name(func_name)
#             rule_name = f"transform_{fp_name}_{func}"
#             total_rules += 1
            
#             # Handle special case for '0'
#             if func == '0':
#                 out.append(f"""
# // Rule: .{fp_name} = 0 ==> memcpy(...{fp_name}_signature..., {fp_name}_signatures[{fp_name}_0_enum], ...)
# @{rule_name}@
# expression E;
# identifier FP_NAME = {fp_name};
# @@
# (
# E.FP_NAME = 0;
# + memcpy(E.{fp_name}_signature, {fp_name}_signatures[{fp_name}_0_enum], sizeof(E.{fp_name}_signature));
# |
# E->FP_NAME = 0;
# + memcpy(E->{fp_name}_signature, {fp_name}_signatures[{fp_name}_0_enum], sizeof(E->{fp_name}_signature));
# )
# """)
#             else:
#                 out.append(f"""
# // Rule: .{fp_name} = {func} ==> memcpy(...{fp_name}_signature..., {fp_name}_signatures[{fp_name}_{func}_enum], ...)
# @{rule_name}@
# expression E;
# identifier FP_NAME = {fp_name};
# identifier FUNC_NAME = {func};
# @@
# (
# E.FP_NAME = FUNC_NAME;
# + memcpy(E.{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E.{fp_name}_signature));
# |
# E.FP_NAME = &FUNC_NAME;
# + memcpy(E.{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E.{fp_name}_signature));
# |
# E->FP_NAME = FUNC_NAME;
# + memcpy(E->{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E->{fp_name}_signature));
# |
# E->FP_NAME = &FUNC_NAME;
# + memcpy(E->{fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum], sizeof(E->{fp_name}_signature));
# )
# """)
    
#     out.append(f"\n// Total transformation rules generated: {total_rules}\n")
#     out.append(f"// Total functions excluded: {excluded_count}\n")
#     return "".join(out)

# def generate_logging_rules(target_fp_names: Set[str], fpnames_dir: str = "fpName", 
#                           removed_functions: Set[str] = set()) -> str:
#     """Generate rules to log transformation information (after each transform)"""
#     rules = []
#     rules.append("// ===== LOGGING AND TRACKING RULES =====\n")

#     for fp_name in target_fp_names:
#         functions = read_functions_for_fp(fp_name, fpnames_dir)
        
#         if not functions:
#             continue
        
#         valid_functions = [f for f in functions if not _skip_func(_coerce_name(f), removed_functions)]
        
#         for func_name in valid_functions:
#             func = _coerce_name(func_name)
#             rule_name = f"transform_{fp_name}_{func}"
            
#             rules.append(f"""
# @script:python depends on {rule_name}@
# @@
# import os
# os.makedirs("memcpy_transformations", exist_ok=True)
# with open("memcpy_transformations/{fp_name}_transformations.txt", "a") as f:
#     f.write(f"[OK] {fp_name} = {func} -> memcpy({fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum])\\n")
# print(f"[TRANSFORMED] {fp_name} = {func} -> memcpy({fp_name}_signature, {fp_name}_signatures[{fp_name}_{func}_enum])")
# """)
#     return "".join(rules)

# def generate_cocci_script(target_fp_names: Set[str], fpnames_dir: str = "fpName", 
#                          removed_functions: Set[str] = set(), include_logging: bool = False) -> str:
#     """Generate the complete Coccinelle script"""
    
#     script_parts = []
    
#     # Header
#     script_parts.append("""// Auto-generated Coccinelle script for function pointer to memcpy conversion
# // Excludes functions from remove_fn_list.txt
# // 
# // This script transforms function pointer assignments to memcpy calls:
# //   E.FP_NAME = FUNC_NAME; -> memcpy(E.FP_NAME_signature, FP_NAME_signatures[FP_NAME_FUNC_NAME_enum], sizeof(...));
# //
# // Usage: spatch --sp-file convert_fp_to_memcpy.cocci --dir <source_directory> --in-place

# @initialize:python@
# @@
# print(">>> Starting function pointer to memcpy conversion")
# print(">>> Transforming assignments to memcpy calls (excluding remove_fn_list.txt)")

# # Clean up any existing output directories
# import os
# import shutil
# if os.path.exists("memcpy_transformations"):
#     shutil.rmtree("memcpy_transformations")
# os.makedirs("memcpy_transformations", exist_ok=True)

# print(">>> Created output directory: memcpy_transformations/")

# """)
    
#     if not target_fp_names:
#         script_parts.append("// No target function pointers specified\n")
#         return "".join(script_parts)
    
#     # Generate transformation rules
#     script_parts.append(generate_memcpy_transformation_rules(target_fp_names, fpnames_dir, removed_functions))
    
#     # Generate logging rules (optional)
#     if include_logging:
#         script_parts.append(generate_logging_rules(target_fp_names, fpnames_dir, removed_functions))
    
#     # Footer with usage instructions
#     script_parts.append("""
# // ===== USAGE INSTRUCTIONS =====
# /*
# After running this script:

# 1. Check memcpy_transformations/ directory for transformation logs

# Example transformation:
#    Before: obj.callback = my_function;
#    After:  memcpy(obj.callback_signature, callback_signatures[callback_my_function_enum], sizeof(obj.callback_signature));

# Note: This assumes that:
# - FP_NAME_signatures arrays are already defined
# - FP_NAME_FUNC_NAME_enum values are already defined
# - Structs have FP_NAME_signature fields
# - <string.h> is included where needed
# */

# """)
    
#     return "".join(script_parts)

# def main():
#     parser = argparse.ArgumentParser(
#         description="Generate Coccinelle script to convert function pointer assignments to memcpy calls (excludes remove_fn_list.txt)"
#     )
#     parser.add_argument(
#         "--source-dir",
#         required=True,
#         help="Directory containing source code"
#     )
#     parser.add_argument(
#         "--output",
#         default="convert_fp_to_memcpy.cocci",
#         help="Output Coccinelle script file (default: convert_fp_to_memcpy.cocci)"
#     )
#     parser.add_argument(
#         "--fpnames-dir",
#         default="fpName",
#         help="Directory containing function lists for each FP (default: fpName)"
#     )
#     parser.add_argument(
#         "--remove-list",
#         default="remove_fn_list.txt",
#         help="File containing functions to exclude (default: remove_fn_list.txt)"
#     )
#     parser.add_argument(
#         "--include-logging",
#         action="store_true",
#         help="Include Python logging rules (may slow down execution)"
#     )
#     parser.add_argument(
#         "--verbose", "-v",
#         action="store_true",
#         help="Enable verbose output"
#     )
#     parser.add_argument(
#         "--debug", "-d",
#         action="store_true",
#         help="Enable debug output"
#     )
    
#     args = parser.parse_args()
    
#     if not os.path.exists(args.source_dir):
#         print(f"[ERROR] Source directory not found: {args.source_dir}")
#         sys.exit(1)
    
#     if not os.path.exists(args.fpnames_dir):
#         print(f"[ERROR] fpNames directory not found: {args.fpnames_dir}")
#         print(f"[INFO] Please create {args.fpnames_dir}/ directory with function list files (e.g., xAccess.txt, xOpen.txt)")
#         sys.exit(1)
    
#     print(f"[INFO] Scanning source directory: {args.source_dir}")
#     print(f"[INFO] Using fpNames directory: {args.fpnames_dir}")
    
#     # Read remove list
#     removed_functions = read_remove_list(args.remove_list)
    
#     # Step 1: Read target function pointer names from file
#     target_fp_names = read_target_fp_names("target_fpNames.txt")
    
#     if not target_fp_names:
#         print("[ERROR] No target function pointer names found in target_fpNames.txt")
#         print("[INFO] Please create target_fpNames.txt with function pointer names (one per line)")
#         sys.exit(1)
    
#     # Step 2: Check that we have function files for each target FP
#     missing_fp_files = []
#     total_functions = 0
#     valid_functions = 0
#     excluded_functions = 0
    
#     for fp_name in target_fp_names:
#         functions = read_functions_for_fp(fp_name, args.fpnames_dir)
#         if not functions:
#             missing_fp_files.append(fp_name)
#         else:
#             valid_funcs = [f for f in functions if not _skip_func(_coerce_name(f), removed_functions)]
#             total_functions += len(functions)
#             valid_functions += len(valid_funcs)
#             excluded_functions += len(functions) - len(valid_funcs)
    
#     if missing_fp_files:
#         print(f"[WARNING] Missing function files for: {', '.join(missing_fp_files)}")
#         print(f"[INFO] Please create files in {args.fpnames_dir}/ directory:")
#         for fp_name in missing_fp_files:
#             print(f"[INFO]   {args.fpnames_dir}/{fp_name}.txt")
    
#     if args.debug:
#         print(f"\n[DEBUG] Target function pointer names and their functions:")
#         for fp_name in sorted(target_fp_names):
#             functions = read_functions_for_fp(fp_name, args.fpnames_dir)
#             valid_funcs = [f for f in functions if not _skip_func(_coerce_name(f), removed_functions)]
#             print(f"[DEBUG]   {fp_name}: {len(valid_funcs)}/{len(functions)} valid functions")
#             if args.verbose:
#                 for func_name in valid_funcs:
#                     func = _coerce_name(func_name)
#                     print(f"[DEBUG]     ✓ {func}")
#                 excluded = [f for f in functions if _skip_func(_coerce_name(f), removed_functions)]
#                 for func_name in excluded:
#                     func = _coerce_name(func_name)
#                     print(f"[DEBUG]     ✗ {func} (excluded)")
    
#     print(f"\n[SUMMARY] Target function pointers: {len(target_fp_names)}")
#     print(f"[SUMMARY] Total functions: {total_functions}")
#     print(f"[SUMMARY] Valid functions to transform: {valid_functions}")
#     print(f"[SUMMARY] Functions excluded from remove_list: {excluded_functions}")
    
#     if args.verbose:
#         for fp_name in sorted(target_fp_names):
#             functions = read_functions_for_fp(fp_name, args.fpnames_dir)
#             valid_funcs = [f for f in functions if not _skip_func(_coerce_name(f), removed_functions)]
#             print(f"  {fp_name}: {len(valid_funcs)}/{len(functions)} valid")
    
#     # Step 3: Generate Coccinelle script
#     print(f"\n[INFO] Generating Coccinelle script...")
    
#     script_content = generate_cocci_script(target_fp_names, args.fpnames_dir, removed_functions, args.include_logging)
    
#     # Write output file
#     output_path = args.output
#     if not output_path.endswith('.cocci'):
#         output_path += '.cocci'
    
#     try:
#         with open(output_path, 'w', encoding='utf-8') as f:
#             f.write(script_content)
        
#         print(f"[SUCCESS] Generated Coccinelle script: {output_path}")
#         print(f"[INFO] Target function pointers: {len(target_fp_names)}")
#         print(f"[INFO] Total transformation rules: {valid_functions}")
        
#         print(f"\n[TRANSFORMATION] Will convert:")
#         print(f"  E.FP_NAME = FUNC_NAME;")
#         print(f"  ↓")
#         print(f"  memcpy(E.FP_NAME_signature, FP_NAME_signatures[FP_NAME_FUNC_NAME_enum], sizeof(...));")
        
#         print(f"\n[USAGE] Apply transformation:")
#         print(f"  spatch --sp-file {output_path} --dir {args.source_dir} --in-place")
        
#         print(f"\n[OUTPUT] After execution, check:")
#         print(f"  memcpy_transformations/ - Transformation logs")
        
#         print(f"\n[ASSUMPTIONS] This script assumes:")
#         print(f"  ✓ FP_NAME_signatures arrays are already defined")
#         print(f"  ✓ FP_NAME_FUNC_NAME_enum values are already defined")
#         print(f"  ✓ Structs have FP_NAME_signature fields")
#         print(f"  ✓ <string.h> is included where needed")
        
#     except Exception as e:
#         print(f"[ERROR] Failed to write output file: {e}")
#         sys.exit(1)

# if __name__ == "__main__":
#     main()

#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Generate a Coccinelle script that:
1. Uses Python to find all structs with function pointer members
2. Uses Coccinelle to transform function pointer assignments to direct signature assignments
3. Converts: E.FP_NAME = FUNC_NAME; -> E.FP_NAME_signature = FP_NAME_signatures[FP_NAME_FUNC_NAME_enum];
4. Excludes functions from remove_fn_list.txt

Usage:
  python3 new_5_transform_fp_assigning.py --source-dir <source_dir> --output convert_fp_to_memcpy.cocci
"""

import argparse
import os
import re
import sys
from typing import Dict, List, Set, Tuple
import glob

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
    """
    Read target function pointer names from target_fpNames.txt file
    Returns: Set of function pointer names to transform
    """
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

def read_functions_for_fp(fp_name: str, fpnames_dir: str = "fpName") -> List[str]:
    """
    Read function names for a specific function pointer from fpNames/fp_name.txt
    Returns: List of function names (maintaining order)
    """
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

def generate_memcpy_transformation_rules(target_fp_names: set[str], fpnames_dir: str = "fpName", 
                                        removed_functions: Set[str] = set()) -> str:
    """
    Transform:
      E.<fp> = FUNC; / E-><fp> = &FUNC;
    into:
      E.<fp>_signature = <fp>_signatures[<fp>_<FUNC>_enum];
    
    For each fp_name, read the corresponding functions from fpNames/fp_name.txt
    and generate individual rules for each function (excluding removed functions).
    """
    out = []
    out.append("// ===== FUNCTION POINTER ASSIGNMENT TO DIRECT SIGNATURE ASSIGNMENT (specific functions) =====\n")

    total_rules = 0
    excluded_count = 0
    
    for fp_name in sorted(target_fp_names):
        # Read functions for this function pointer
        functions = read_functions_for_fp(fp_name, fpnames_dir)
        
        if not functions:
            print(f"[WARNING] No functions found for {fp_name}, skipping...")
            continue
        
        # Filter out functions that should be skipped
        valid_functions = [f for f in functions if not _skip_func(_coerce_name(f), removed_functions)]
        excluded_count += len(functions) - len(valid_functions)
        
        if not valid_functions:
            print(f"[WARNING] All functions for {fp_name} are excluded, skipping...")
            continue
            
        out.append(f"\n// Rules for {fp_name} ({len(valid_functions)} valid functions, {len(functions) - len(valid_functions)} excluded)")
        
        # Generate a rule for each valid function
        for func_name in valid_functions:
            func = _coerce_name(func_name)
            rule_name = f"transform_{fp_name}_{func}"
            total_rules += 1
            
            # Handle special case for '0'
            if func == '0':
                out.append(f"""
// Rule: .{fp_name} = 0 ==> .{fp_name}_signature = {fp_name}_signatures[{fp_name}_0_enum];
@{rule_name}@
expression E;
identifier FP_NAME = {fp_name};
@@
(
E.FP_NAME = 0;
+ E.{fp_name}_signature = {fp_name}_signatures[{fp_name}_0_enum];
|
E->FP_NAME = 0;
+ E->{fp_name}_signature = {fp_name}_signatures[{fp_name}_0_enum];
)
""")
            else:
                out.append(f"""
// Rule: .{fp_name} = {func} ==> .{fp_name}_signature = {fp_name}_signatures[{fp_name}_{func}_enum];
@{rule_name}@
expression E;
identifier FP_NAME = {fp_name};
identifier FUNC_NAME = {func};
@@
(
E.FP_NAME = FUNC_NAME;
+ E.{fp_name}_signature = {fp_name}_signatures[{fp_name}_{func}_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.{fp_name}_signature = {fp_name}_signatures[{fp_name}_{func}_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->{fp_name}_signature = {fp_name}_signatures[{fp_name}_{func}_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->{fp_name}_signature = {fp_name}_signatures[{fp_name}_{func}_enum];
)
""")
    
    out.append(f"\n// Total transformation rules generated: {total_rules}\n")
    out.append(f"// Total functions excluded: {excluded_count}\n")
    return "".join(out)

def generate_logging_rules(target_fp_names: Set[str], fpnames_dir: str = "fpName", 
                          removed_functions: Set[str] = set()) -> str:
    """Generate rules to log transformation information (after each transform)"""
    rules = []
    rules.append("// ===== LOGGING AND TRACKING RULES =====\n")

    for fp_name in target_fp_names:
        functions = read_functions_for_fp(fp_name, fpnames_dir)
        
        if not functions:
            continue
        
        valid_functions = [f for f in functions if not _skip_func(_coerce_name(f), removed_functions)]
        
        for func_name in valid_functions:
            func = _coerce_name(func_name)
            rule_name = f"transform_{fp_name}_{func}"
            
            rules.append(f"""
@script:python depends on {rule_name}@
@@
import os
os.makedirs("memcpy_transformations", exist_ok=True)
with open("memcpy_transformations/{fp_name}_transformations.txt", "a") as f:
    f.write(f"[OK] {fp_name} = {func} -> {fp_name}_signature = {fp_name}_signatures[{fp_name}_{func}_enum]\\n")
print(f"[TRANSFORMED] {fp_name} = {func} -> {fp_name}_signature = {fp_name}_signatures[{fp_name}_{func}_enum]")
""")
    return "".join(rules)

def generate_cocci_script(target_fp_names: Set[str], fpnames_dir: str = "fpName", 
                         removed_functions: Set[str] = set(), include_logging: bool = False) -> str:
    """Generate the complete Coccinelle script"""
    
    script_parts = []
    
    # Header
    script_parts.append("""// Auto-generated Coccinelle script for function pointer to direct signature assignment
// Excludes functions from remove_fn_list.txt
// 
// This script transforms function pointer assignments to direct signature assignments:
//   E.FP_NAME = FUNC_NAME; -> E.FP_NAME_signature = FP_NAME_signatures[FP_NAME_FUNC_NAME_enum];
//
// Usage: spatch --sp-file convert_fp_to_memcpy.cocci --dir <source_directory> --in-place

@initialize:python@
@@
print(">>> Starting function pointer to direct signature assignment conversion")
print(">>> Transforming assignments (excluding remove_fn_list.txt)")

# Clean up any existing output directories
import os
import shutil
if os.path.exists("memcpy_transformations"):
    shutil.rmtree("memcpy_transformations")
os.makedirs("memcpy_transformations", exist_ok=True)

print(">>> Created output directory: memcpy_transformations/")

""")
    
    if not target_fp_names:
        script_parts.append("// No target function pointers specified\n")
        return "".join(script_parts)
    
    # Generate transformation rules
    script_parts.append(generate_memcpy_transformation_rules(target_fp_names, fpnames_dir, removed_functions))
    
    # Generate logging rules (optional)
    if include_logging:
        script_parts.append(generate_logging_rules(target_fp_names, fpnames_dir, removed_functions))
    
    # Footer with usage instructions
    script_parts.append("""
// ===== USAGE INSTRUCTIONS =====
/*
After running this script:

1. Check memcpy_transformations/ directory for transformation logs

Example transformation:
   Before: obj.callback = my_function;
   After:  obj.callback_signature = callback_signatures[callback_my_function_enum];

Note: This assumes that:
- FP_NAME_signatures arrays are already defined
- FP_NAME_FUNC_NAME_enum values are already defined
- Structs have FP_NAME_signature fields
*/

""")
    
    return "".join(script_parts)

def main():
    parser = argparse.ArgumentParser(
        description="Generate Coccinelle script to convert function pointer assignments to direct signature assignments (excludes remove_fn_list.txt)"
    )
    parser.add_argument(
        "--source-dir",
        required=True,
        help="Directory containing source code"
    )
    parser.add_argument(
        "--output",
        default="convert_fp_to_memcpy.cocci",
        help="Output Coccinelle script file (default: convert_fp_to_memcpy.cocci)"
    )
    parser.add_argument(
        "--fpnames-dir",
        default="fpName",
        help="Directory containing function lists for each FP (default: fpName)"
    )
    parser.add_argument(
        "--remove-list",
        default="remove_fn_list.txt",
        help="File containing functions to exclude (default: remove_fn_list.txt)"
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
        print(f"[INFO] Please create {args.fpnames_dir}/ directory with function list files (e.g., xAccess.txt, xOpen.txt)")
        sys.exit(1)
    
    print(f"[INFO] Scanning source directory: {args.source_dir}")
    print(f"[INFO] Using fpNames directory: {args.fpnames_dir}")
    
    # Read remove list
    removed_functions = read_remove_list(args.remove_list)
    
    # Step 1: Read target function pointer names from file
    target_fp_names = read_target_fp_names("target_fpNames.txt")
    
    if not target_fp_names:
        print("[ERROR] No target function pointer names found in target_fpNames.txt")
        print("[INFO] Please create target_fpNames.txt with function pointer names (one per line)")
        sys.exit(1)
    
    # Step 2: Check that we have function files for each target FP
    missing_fp_files = []
    total_functions = 0
    valid_functions = 0
    excluded_functions = 0
    
    for fp_name in target_fp_names:
        functions = read_functions_for_fp(fp_name, args.fpnames_dir)
        if not functions:
            missing_fp_files.append(fp_name)
        else:
            valid_funcs = [f for f in functions if not _skip_func(_coerce_name(f), removed_functions)]
            total_functions += len(functions)
            valid_functions += len(valid_funcs)
            excluded_functions += len(functions) - len(valid_funcs)
    
    if missing_fp_files:
        print(f"[WARNING] Missing function files for: {', '.join(missing_fp_files)}")
        print(f"[INFO] Please create files in {args.fpnames_dir}/ directory:")
        for fp_name in missing_fp_files:
            print(f"[INFO]   {args.fpnames_dir}/{fp_name}.txt")
    
    if args.debug:
        print(f"\n[DEBUG] Target function pointer names and their functions:")
        for fp_name in sorted(target_fp_names):
            functions = read_functions_for_fp(fp_name, args.fpnames_dir)
            valid_funcs = [f for f in functions if not _skip_func(_coerce_name(f), removed_functions)]
            print(f"[DEBUG]   {fp_name}: {len(valid_funcs)}/{len(functions)} valid functions")
            if args.verbose:
                for func_name in valid_funcs:
                    func = _coerce_name(func_name)
                    print(f"[DEBUG]     ✓ {func}")
                excluded = [f for f in functions if _skip_func(_coerce_name(f), removed_functions)]
                for func_name in excluded:
                    func = _coerce_name(func_name)
                    print(f"[DEBUG]     ✗ {func} (excluded)")
    
    print(f"\n[SUMMARY] Target function pointers: {len(target_fp_names)}")
    print(f"[SUMMARY] Total functions: {total_functions}")
    print(f"[SUMMARY] Valid functions to transform: {valid_functions}")
    print(f"[SUMMARY] Functions excluded from remove_list: {excluded_functions}")
    
    if args.verbose:
        for fp_name in sorted(target_fp_names):
            functions = read_functions_for_fp(fp_name, args.fpnames_dir)
            valid_funcs = [f for f in functions if not _skip_func(_coerce_name(f), removed_functions)]
            print(f"  {fp_name}: {len(valid_funcs)}/{len(functions)} valid")
    
    # Step 3: Generate Coccinelle script
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
        print(f"[INFO] Target function pointers: {len(target_fp_names)}")
        print(f"[INFO] Total transformation rules: {valid_functions}")
        
        print(f"\n[TRANSFORMATION] Will convert:")
        print(f"  E.FP_NAME = FUNC_NAME;")
        print(f"  ↓")
        print(f"  E.FP_NAME_signature = FP_NAME_signatures[FP_NAME_FUNC_NAME_enum];")
        
        print(f"\n[USAGE] Apply transformation:")
        print(f"  spatch --sp-file {output_path} --dir {args.source_dir} --in-place")
        
        print(f"\n[OUTPUT] After execution, check:")
        print(f"  memcpy_transformations/ - Transformation logs")
        
        print(f"\n[ASSUMPTIONS] This script assumes:")
        print(f"  ✓ FP_NAME_signatures arrays are already defined")
        print(f"  ✓ FP_NAME_FUNC_NAME_enum values are already defined")
        print(f"  ✓ Structs have FP_NAME_signature fields")
        
    except Exception as e:
        print(f"[ERROR] Failed to write output file: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()