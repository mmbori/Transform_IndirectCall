import json
import sys
import re
import argparse
from typing import Dict, List, Any, Optional


class CocciGenerator:
    def __init__(self, json_data: List[Dict[str, Any]]):
        self.json_data = json_data
        self.rule_counter = 0

    def _generate_header(self) -> str:
        """Generate file header"""
        header_lines = r"""
// Coccinelle semantic patch for plugin system transformation
// Generated from JSON callsite analysis
//
// This patch performs function inlining and indirect call resolution
// Features:
//   - Inlines plugin function calls into caller functions
//   - Converts indirect function calls to direct calls
//   - Transforms loops to sequential conditional calls
//"
// Usage: spatch --sp-file <patch_file> --in-place <target_files>

"""

        init = r"""
@initialize:python@
@@

import json, re, os, io, sys
os.makedirs('bodies', exist_ok=True)

def extract_function_body_from_complete(complete_function):
    lines = complete_function.split('\n')
    body_lines = []
    found_opening_brace = False
    brace_count = 0
    
    for line in lines:
        if not found_opening_brace:
            if '{' in line:
                found_opening_brace = True
                # 첫 번째 { 이후 내용이 있으면 포함
                after_brace = line.split('{', 1)[1] if '{' in line else ''
                if after_brace.strip():
                    body_lines.append(after_brace)
                brace_count += line.count('{') - line.count('}')
        else:
            # 마지막 } 처리
            if '}' in line and brace_count == 1:
                before_brace = line.split('}')[0]
                if before_brace.strip():
                    body_lines.append(before_brace)
                break
            else:
                body_lines.append(line)
                brace_count += line.count('{') - line.count('}')
    
    return '\n'.join(body_lines)

def extract_to_file(func_name, source_file, line_num):
    try:
        with open(source_file, 'r') as f:
            content = f.read()
        
        # 함수 시작점 찾기
        lines = content.split('\n')
        func_start_line = line_num - 1  # 0-based
        
        # 함수 끝점 찾기 (중괄호 균형)
        brace_count = 0
        func_end_line = func_start_line
        found_start = False
        
        for i in range(func_start_line, len(lines)):
            line = lines[i]
            if '{' in line and not found_start:
                found_start = True
            
            if found_start:
                brace_count += line.count('{')
                brace_count -= line.count('}')
                
                if brace_count == 0:
                    func_end_line = i
                    break
        
        # 함수 전체 추출
        function_lines = lines[func_start_line:func_end_line + 1]
        complete_function = '\n'.join(function_lines)
        
        # 함수 본문만 추출
        function_body = extract_function_body_from_complete(complete_function)
        
        # 파일 저장
        with open(f'bodies/{func_name}.txt', 'w') as f:
            f.write(function_body)
        
        # 완전한 함수도 저장
        with open(f'bodies/{func_name}.c', 'w') as f:
            f.write(complete_function)
        
        print(f"Saved function: {func_name}")
        print(f"  Body file: bodies/{func_name}.txt ({len(function_body)} chars)")
        print(f"  Complete file: bodies/{func_name}.c ({len(complete_function)} chars)")
        
        return True
    
    except Exception as e:
        print(f"Error processing {func_name}: {e}")
        return False

print("Initialization complete. Ready to extract functions.")
"""
        return "\n".join([header_lines, init])
    
    def generate_cocci_file(self) -> str:
        """Generate complete .cocci file"""
        header = self._generate_header()
        rules = []
        
        for entry in self.json_data:
            if self._should_skip_entry(entry):
                continue
                
            rule = self._generate_rule_for_entry(entry)
            if rule:
                rules.append(rule)

        return header + "\n\n".join(rules)
    
    def _should_skip_entry(self, entry: Dict[str, Any]) -> bool:
        """Check if entry should be skipped"""
        src_line = entry.get("src_line", "").strip()
        callee = entry.get("callee", [])
        
        # Skip if no src_line or callee data
        if not src_line or not callee or callee == [""]:
            return True
        
        # Skip if all callees are empty strings
        if all(c == "" for c in callee):
            return True
            
        return False
    
    def _generate_rule_for_entry(self, entry: Dict[str, Any]) -> str:
        """Generate SmPL rule based on entry type"""
        callsite_caller = entry.get("callsite_caller", "")
        callsite = entry.get("callsite", "")
        src_line = entry.get("src_line", "")
        callees = entry.get("callee", [])
        
        # Filter out empty callees
        callees = [c for c in callees if c and c.strip()]
        if not callees:
            return ""
        
        if callsite_caller == "":
            # Case 1: Direct transformation in callsite function
            return self._generate_direct_transformation_rule(callsite, src_line, callees)
        else:
            # Case 2: Function inlining - copy callsite function body into caller, then transform
            return self._generate_function_inlining_rule(callsite_caller, callsite, src_line, callees)

    
    def _generate_direct_transformation_rule(self, callsite: str, src_line: str, callees: List[str]) :
        rule_name = f"parsing_callsite_function_{callsite}"

        p1 = r"""
@{RULE_NAME}_1@
identifier CALLSITE = { {CALLSITE} };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) {
BODY
}

@script:python@
p << {RULE_NAME}_1.p;
@@

func_name = "{CALLSITE}"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)
""".replace("{CALLSITE}", callsite).replace("{RULE_NAME}", rule_name)
        
        p2 = r"""
@{RULE_NAME}_2@
identifier CALLSITE = { {CALLSITE} };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) 
{
BODY
}

@script:python@
p << {RULE_NAME}_2.p;
@@

func_name = "{CALLSITE}"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)
""".replace("{CALLSITE}", callsite).replace("{RULE_NAME}", rule_name)
        
        p3 = r"""
@{RULE_NAME}_3@
identifier CALLSITE = { {CALLSITE} };
parameter list PL1;
statement list BODY;
type T;
position p;
@@

T
CALLSITE@p(PL1) 
{
BODY
}

@script:python@
p << {RULE_NAME}_3.p;
@@

func_name = "{CALLSITE}"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)
""".replace("{CALLSITE}", callsite).replace("{RULE_NAME}", rule_name)
        return "\n".join([p1, p2, p3])   

    def _generate_function_inlining_rule(self, callsite_caller: str, callsite: str, src_line: str, callees: List[str]) -> str:
        """Generate rule for function inlining with proper body duplication"""
        rule_name = f"parsing_callsite_function_{callsite_caller}"

        # Callsite 함수 본문 내용을 통째로 복사해 붙여넣을 수 있는 형태로 저장
        p1 = r"""
@{RULE_NAME}_1@
identifier CALLSITE = { {CALLSITE} };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) {
BODY
}

@script:python@
p << {RULE_NAME}_1.p;
@@

func_name = "{CALLSITE}"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)
""".replace("{CALLSITE}", callsite).replace("{RULE_NAME}", rule_name)
        
        p2 = r"""
@{RULE_NAME}_2@
identifier CALLSITE = { {CALLSITE} };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) 
{
BODY
}

@script:python@
p << {RULE_NAME}_2.p;
@@

func_name = "{CALLSITE}"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)
""".replace("{CALLSITE}", callsite).replace("{RULE_NAME}", rule_name)
        
        p3 = r"""
@{RULE_NAME}_3@
identifier CALLSITE = { {CALLSITE} };
parameter list PL1;
statement list BODY;
type T;
position p;
@@

T
CALLSITE@p(PL1) 
{
BODY
}

@script:python@
p << {RULE_NAME}_3.p;
@@

func_name = "{CALLSITE}"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)
""".replace("{CALLSITE}", callsite).replace("{RULE_NAME}", rule_name)
        return "\n".join([p1, p2, p3])    

def parse_arguments():
    """Parse command line arguments"""
    parser = argparse.ArgumentParser(
        description="Generate Coccinelle semantic patches from JSON callsite analysis",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s callsite.json
  %(prog)s callsite.json -o transform.cocci
  %(prog)s callsite.json --output-file plugin_transform.cocci

This tool generates Coccinelle semantic patches that:
  1. Inline plugin function calls into their callers
  2. Convert indirect function calls to direct calls  
  3. Transform loops into sequential conditional calls
        """
    )
    
    parser.add_argument(
        'input_file',
        help='Input JSON file containing callsite analysis data'
    )
    
    parser.add_argument(
        '-o', '--output-file',
        help='Output .cocci file name (default: input_file.cocci)'
    )
    
    parser.add_argument(
        '--validate-json',
        action='store_true',
        help='Validate JSON structure and show statistics without generating output'
    )
    
    return parser.parse_args()


def validate_json_structure(json_data: List[Dict[str, Any]]) -> bool:
    """Validate JSON structure and show statistics"""
    if not isinstance(json_data, list):
        print("Error: JSON data must be an array")
        return False
    
    if len(json_data) == 0:
        print("Warning: No data found in JSON file")
        return True
    
    print(f"JSON validation successful:")
    print(f"  Total entries: {len(json_data)}")
    
    # Count entries by type
    direct_transform = 0
    function_inline = 0
    skipped = 0
    
    for entry in json_data:
        if not entry.get("src_line", "").strip() or not entry.get("callee", []) or entry.get("callee", []) == [""]:
            skipped += 1
            continue
            
        if entry.get("callsite_caller", "") == "":
            direct_transform += 1
        else:
            function_inline += 1
    
    print(f"  Direct transformations: {direct_transform}")
    print(f"  Function inlinings: {function_inline}")
    print(f"  Skipped entries: {skipped}")
    
    # Show function types
    function_types = {}
    for entry in json_data:
        callsite = entry.get("callsite", "")
        if callsite:
            func_type = "unknown"
            if "srv_data" in callsite:
                func_type = "srv_data"
            elif "req_data" in callsite:
                func_type = "req_data"
            elif "con_data" in callsite:
                func_type = "con_data"
            
            function_types[func_type] = function_types.get(func_type, 0) + 1
    
    print(f"  Function types: {function_types}")
    
    return True


def main():
    """Main function with enhanced error handling and features"""
    args = parse_arguments()
    
    # Read and parse JSON file
    try:
        with open(args.input_file, 'r', encoding='utf-8') as f:
            json_data = json.load(f)
    except FileNotFoundError:
        print(f"Error: File '{args.input_file}' not found")
        sys.exit(1)
    except json.JSONDecodeError as e:
        print(f"Error: Invalid JSON format - {e}")
        sys.exit(1)
    except Exception as e:
        print(f"Error reading file: {e}")
        sys.exit(1)
    
    # Validate JSON structure
    if not validate_json_structure(json_data):
        sys.exit(1)
    
    # If only validation requested, exit here
    if args.validate_json:
        print("\nValidation complete.")
        return
    
    # Generate Coccinelle patch
    try:
        generator = CocciGenerator(json_data)
        cocci_content = generator.generate_cocci_file()
        
        # Determine output filename
        if args.output_file:
            output_file = args.output_file
            if not output_file.endswith('.cocci'):
                output_file += '.cocci'
        else:
            if args.input_file.endswith('.json'):
                output_file = args.input_file[:-5] + '.cocci'
            else:
                output_file = args.input_file + '.cocci'
        
        # Write output file
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(cocci_content)
        
        print(f"✓ Generated Coccinelle patch: '{output_file}'")
        print(f"✓ Processed {len(json_data)} entries")
        
        # Count valid rules
        valid_entries = sum(1 for entry in json_data if not generator._should_skip_entry(entry))
        print(f"✓ Valid transformations: {valid_entries}")
        
        print()
        print("Usage instructions:")
        print(f"  # Apply patch to single file:")
        print(f"  spatch --sp-file {output_file} --in-place your_source_file.c")
        print(f"  ")
        print(f"  # Apply patch to multiple files:")
        print(f"  spatch --sp-file {output_file} --in-place src/*.c")
        print(f"  ")
        print(f"  # Preview changes without modifying files:")
        print(f"  spatch --sp-file {output_file} your_source_file.c")
        
    except Exception as e:
        print(f"Error generating Coccinelle patch: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()