#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Analyze Coccinelle transformation results and compare with callsites.json
to determine which functions were successfully transformed and which were not.

This script parses:
1. callsites.json - to get the list of target functions
2. Coccinelle diff output - to identify successfully transformed functions
"""

import argparse
import json
import re
import sys
from typing import Set, List, Dict, Tuple
from collections import defaultdict

def load_target_functions(json_path: str) -> Set[str]:
    """Load all unique function names from callsites.json callee arrays"""
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

    functions = set()
    
    if not isinstance(data, list):
        print("[ERROR] JSON root must be an array", file=sys.stderr)
        sys.exit(1)

    for entry in data:
        if isinstance(entry, dict):
            callee_list = entry.get("callee", [])
            if isinstance(callee_list, list):
                for callee in callee_list:
                    if isinstance(callee, str) and callee.strip():
                        functions.add(callee.strip())
    
    return functions

def parse_cocci_diff(diff_path: str) -> Tuple[Set[str], Dict[str, List[str]]]:
    """
    Parse Coccinelle diff output to extract successfully transformed functions.
    
    Returns:
        - Set of successfully transformed function names
        - Dict mapping function names to their transformation details
    """
    transformed_functions = set()
    transformation_details = defaultdict(list)
    
    try:
        with open(diff_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except FileNotFoundError:
        print(f"[ERROR] Diff file not found: {diff_path}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"[ERROR] Failed to read diff file: {e}", file=sys.stderr)
        sys.exit(1)

    # Split content by file sections (marked by "--- " and "+++ ")
    file_sections = re.split(r'\n(?=--- )', content)
    
    for section in file_sections:
        if not section.strip():
            continue
            
        # Extract filename from the section header
        file_match = re.search(r'--- (.+?)(?:\n|\r\n)', section)
        if not file_match:
            continue
            
        filename = file_match.group(1).strip()
        
        # Look for static keyword removals in this file
        # Pattern: -static ... functionName(
        static_removals = re.finditer(
            r'^-static\s*\n\+\s*(.+?)\s+(\w+)\s*\(',
            section,
            re.MULTILINE
        )
        
        for match in static_removals:
            return_type = match.group(1).strip()
            func_name = match.group(2).strip()
            
            transformed_functions.add(func_name)
            transformation_details[func_name].append({
                'file': filename,
                'return_type': return_type,
                'context': match.group(0)
            })
        
        # Also look for simpler pattern: -static ... void functionName(
        simple_removals = re.finditer(
            r'^-static\s+(.+?)\s+(\w+)\s*\(',
            section,
            re.MULTILINE
        )
        
        for match in simple_removals:
            return_type = match.group(1).strip()
            func_name = match.group(2).strip()
            
            if func_name not in transformed_functions:
                transformed_functions.add(func_name)
                transformation_details[func_name].append({
                    'file': filename,
                    'return_type': return_type,
                    'context': match.group(0)
                })

    return transformed_functions, dict(transformation_details)

def generate_report(target_functions: Set[str], 
                   transformed_functions: Set[str],
                   transformation_details: Dict[str, List[str]],
                   output_path: str = None):
    """Generate detailed analysis report"""
    
    # Calculate statistics
    total_target = len(target_functions)
    total_transformed = len(transformed_functions)
    total_not_transformed = total_target - total_transformed
    success_rate = (total_transformed / total_target * 100) if total_target > 0 else 0
    
    # Identify successful and failed transformations
    successful = target_functions & transformed_functions
    failed = target_functions - transformed_functions
    unexpected = transformed_functions - target_functions  # Transformed but not in target list
    
    # Generate report
    report_lines = []
    
    # Header
    report_lines.append("=" * 80)
    report_lines.append("COCCINELLE TRANSFORMATION ANALYSIS REPORT")
    report_lines.append("=" * 80)
    report_lines.append("")
    
    # Summary statistics
    report_lines.append("SUMMARY STATISTICS:")
    report_lines.append("-" * 40)
    report_lines.append(f"Total target functions:      {total_target:>6}")
    report_lines.append(f"Successfully transformed:    {total_transformed:>6}")
    report_lines.append(f"Failed to transform:         {total_not_transformed:>6}")
    report_lines.append(f"Success rate:                {success_rate:>5.1f}%")
    report_lines.append(f"Unexpected transformations:  {len(unexpected):>6}")
    report_lines.append("")
    
    # Successful transformations
    if successful:
        report_lines.append(f"SUCCESSFULLY TRANSFORMED FUNCTIONS ({len(successful)}):")
        report_lines.append("-" * 50)
        for func in sorted(successful):
            report_lines.append(f"✓ {func}")
            if func in transformation_details:
                for detail in transformation_details[func]:
                    report_lines.append(f"    File: {detail['file']}")
                    report_lines.append(f"    Type: {detail['return_type']}")
        report_lines.append("")
    
    # Failed transformations
    if failed:
        report_lines.append(f"FAILED TO TRANSFORM ({len(failed)}):")
        report_lines.append("-" * 30)
        for func in sorted(failed):
            report_lines.append(f"✗ {func}")
        report_lines.append("")
    
    # Unexpected transformations
    if unexpected:
        report_lines.append(f"UNEXPECTED TRANSFORMATIONS ({len(unexpected)}):")
        report_lines.append("-" * 40)
        report_lines.append("(Functions transformed but not in target list)")
        for func in sorted(unexpected):
            report_lines.append(f"? {func}")
            if func in transformation_details:
                for detail in transformation_details[func]:
                    report_lines.append(f"    File: {detail['file']}")
                    report_lines.append(f"    Type: {detail['return_type']}")
        report_lines.append("")
    
    # Analysis insights
    report_lines.append("ANALYSIS INSIGHTS:")
    report_lines.append("-" * 20)
    
    if success_rate >= 90:
        report_lines.append("🎉 Excellent transformation rate! Most functions were successfully processed.")
    elif success_rate >= 70:
        report_lines.append("👍 Good transformation rate. Some functions may need manual review.")
    elif success_rate >= 50:
        report_lines.append("⚠️  Moderate transformation rate. Several functions need attention.")
    else:
        report_lines.append("❌ Low transformation rate. Manual intervention likely required.")
    
    if failed:
        report_lines.append("")
        report_lines.append("Common reasons for transformation failure:")
        report_lines.append("- Function not defined as 'static' in source code")
        report_lines.append("- Function name appears in comments or strings only")
        report_lines.append("- Complex macro definitions interfering with pattern matching")
        report_lines.append("- Function defined with unusual formatting/spacing")
        report_lines.append("- Function exists in files not processed by Coccinelle")
    
    report_lines.append("")
    report_lines.append("=" * 80)
    
    # Output report
    report_text = "\n".join(report_lines)
    
    if output_path:
        try:
            with open(output_path, 'w', encoding='utf-8') as f:
                f.write(report_text)
            print(f"[SUCCESS] Analysis report written to: {output_path}")
        except Exception as e:
            print(f"[ERROR] Failed to write report: {e}", file=sys.stderr)
            print("\n" + report_text)
    else:
        print(report_text)
    
    return {
        'total_target': total_target,
        'total_transformed': total_transformed,
        'success_rate': success_rate,
        'successful': successful,
        'failed': failed,
        'unexpected': unexpected
    }

def main():
    parser = argparse.ArgumentParser(
        description="Analyze Coccinelle transformation results against target function list",
        epilog="Example: python3 analyze_results.py --json callsites.json --diff cocci_output.txt --report analysis_report.txt"
    )
    
    parser.add_argument(
        "--json",
        required=True,
        help="Path to callsites.json file containing target functions"
    )
    
    parser.add_argument(
        "--diff", 
        required=True,
        help="Path to Coccinelle diff output file"
    )
    
    parser.add_argument(
        "--report", "-r",
        help="Output path for analysis report (default: print to stdout)"
    )
    
    parser.add_argument(
        "--list-failed", "-f",
        action="store_true",
        help="Only list failed transformations (compact output)"
    )
    
    parser.add_argument(
        "--list-successful", "-s",
        action="store_true", 
        help="Only list successful transformations (compact output)"
    )
    
    parser.add_argument(
        "--verbose", "-v",
        action="store_true",
        help="Enable verbose output"
    )
    
    args = parser.parse_args()
    
    if args.verbose:
        print("[INFO] Loading target functions from JSON...")
    
    # Load target functions
    target_functions = load_target_functions(args.json)
    
    if args.verbose:
        print(f"[INFO] Found {len(target_functions)} target functions")
        print("[INFO] Parsing Coccinelle diff output...")
    
    # Parse transformation results
    transformed_functions, transformation_details = parse_cocci_diff(args.diff)
    
    if args.verbose:
        print(f"[INFO] Found {len(transformed_functions)} transformed functions")
        print("[INFO] Generating analysis...")
    
    # Handle simple list outputs
    if args.list_failed:
        failed = target_functions - transformed_functions
        for func in sorted(failed):
            print(func)
        return
    
    if args.list_successful:
        successful = target_functions & transformed_functions
        for func in sorted(successful):
            print(func)
        return
    
    # Generate full report
    results = generate_report(
        target_functions, 
        transformed_functions, 
        transformation_details,
        args.report
    )
    
    if args.verbose:
        print(f"\n[INFO] Analysis complete:")
        print(f"  - Success rate: {results['success_rate']:.1f}%")
        print(f"  - Successful: {len(results['successful'])}")
        print(f"  - Failed: {len(results['failed'])}")

if __name__ == "__main__":
    main()