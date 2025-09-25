import json
import sys
import re
import argparse
import os
from typing import Dict, List, Any, Optional


class CocciGenerator:
    def __init__(self, json_data: List[Dict[str, Any]]):
        self.json_data = json_data
        self.rule_counter = 0

    def _generate_header(self) -> str:
        """Generate file header"""
        header_lines = [
            "// Coccinelle semantic patch for plugin system transformation",
            "// Generated from JSON callsite analysis",
            "//",
            "// This patch performs function inlining and indirect call resolution",
            "// Features:",
            "//   - Inlines plugin function calls into caller functions", 
            "//   - Converts indirect function calls to direct calls",
            "//   - Transforms loops to sequential conditional calls",
            "//",
            "// Usage: spatch --sp-file <patch_file> --in-place <target_files>",
            "//",
            ""
        ]
        header = "\n".join(header_lines)
        typedef = r"""
@@
typedef handler_t, plugin_fn_srv_data, plugin_fn_req_data, plugin_fn_con_data;
@@

handler_t
"""
        return "\n".join([header, typedef])
    
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
        if not src_line or not callee or callee == [""] or src_line == [""]:
            return True
        
        # Skip if all callees are empty strings
        if all(c == "" for c in callee):
            return True
            
        return False
    
    def _convert_fun_to_cocci(self, callsite, indent_level: int = 0) :
        try:
            with open(f'bodies/{callsite}.txt', 'r', encoding='utf-8') as f:
                content = f.read()
            
            # replace type to prevent type casting error in cocci
            content = content.replace('uint16_t', 'unsigned short')
            content = content.replace('uint32_t', 'unsigned int')
            content = content.replace('uint64_t', 'unsigned long long')
            content = content.replace('uintptr_t', 'unsigned long')
            content = content.replace('int16_t', 'short')
            content = content.replace('int32_t', 'int')
            content = content.replace('int64_t', 'long long')
            content = content.replace('size_t', 'unsigned long')
            content = content.replace('ssize_t', 'long')

            lines = content.strip().split('\n')
            base_indent = '    ' * indent_level  # 4 spaces per level
            formatted_lines = []
            for line in lines:
                cleaned_line = line.rstrip()
                if cleaned_line:
                    formatted_lines.append(f"+ {base_indent}{cleaned_line}")
                else:
                    formatted_lines.append("+ ")
            return '\n'.join(formatted_lines)
        except FileNotFoundError:
            raise FileNotFoundError(f"File not found: {callsite}.txt")
        except Exception as e:
            raise Exception(f"Error reading file {callsite}.txt: {e}")

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
        return ""

    def _generate_function_inlining_rule(self, callsite_caller: str, callsite: str, src_line: str, callees: List[str]) -> str:
        rule_name = f"callsite_transfer_{callsite_caller}"
        callsite_body = self._convert_fun_to_cocci(callsite)
        p1 = r"""
@transfer_target_{RULE_NAME}@
identifier CALLER = { {CALLER} };
identifier CALLSITE = { {CALLSITE} };
expression list args;
expression target_offset;
@@

CALLER(...)
{
...
(
- CALLSITE(args, target_offset);
+ const int e = target_offset;
{CALLSITE_BODY}
|
- return CALLSITE(args, target_offset);
+ const int e = target_offset;
{CALLSITE_BODY}
)
...
}
""".replace("{CALLSITE}", callsite).replace("{RULE_NAME}", rule_name).replace("{CALLER}", callsite_caller).replace("{CALLSITE_BODY}", callsite_body)
        return "\n".join([p1])
    

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