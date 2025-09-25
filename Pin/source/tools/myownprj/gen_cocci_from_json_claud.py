#!/usr/bin/env python3
"""
Simple JSON to Coccinelle (.cocci) Generator

This script generates Coccinelle semantic patches by:
1. Removing loops (while/for) and replacing with if statements
2. Replacing indirect calls (plfd->fn) with direct function calls
3. Keeping all other parts of the source line intact
"""

import json
import sys
import re
from typing import Dict, List, Any

class SimpleCocciGenerator:
    def __init__(self, json_data: List[Dict[str, Any]]):
        self.json_data = json_data
        
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
        src_line = entry.get("src_line", "")
        callee = entry.get("callee", [])
        
        return not src_line or not callee or callee == [""]
    
    def _generate_rule_for_entry(self, entry: Dict[str, Any]) -> str:
        """Generate SmPL rule based on entry type"""
        callsite_caller = entry.get("callsite_caller", "")
        callsite = entry.get("callsite", "")
        src_line = entry.get("src_line", "")
        callees = entry.get("callee", [])
        
        if callsite_caller == "":
            # Case 1: Direct transformation in callsite function
            return self._generate_direct_transformation_rule(callsite, src_line, callees)
        else:
            # Case 2: Function inlining
            return self._generate_function_inlining_rule(callsite_caller, callsite, src_line, callees)
    
    def _generate_direct_transformation_rule(self, callsite: str, src_line: str, callees: List[str]) -> str:
        """Generate rule for direct transformation"""
        rule_name = f"transform_{callsite}"
        
        # Check if it's a loop
        is_loop = self._is_loop_statement(src_line)
        
        # Start building the rule
        rule_parts = []
        rule_parts.append(f"@ {rule_name} @")
        rule_parts.append("@@")
        rule_parts.append("")
        rule_parts.append(f"{callsite}(...)")
        rule_parts.append("{")
        rule_parts.append("<...")
        
        if is_loop:
            # Remove loop and replace with conditional calls
            original_line = src_line.strip()
            rule_parts.append(f"- {original_line}")
            
            for callee in callees:
                # Replace plfd->fn with actual function name
                transformed_line = self._replace_indirect_call(src_line, callee)
                # Convert loop to if statement
                if_statement = self._convert_loop_to_if(transformed_line)
                rule_parts.append(f"+ {if_statement}")
        else:
            # Simple replacement for non-loop statements
            original_line = src_line.strip()
            rule_parts.append(f"- {original_line}")
            
            for callee in callees:
                transformed_line = self._replace_indirect_call(src_line, callee)
                rule_parts.append(f"+ {transformed_line.strip()}")
        
        rule_parts.append("...>")
        rule_parts.append("}")
        
        return "\n".join(rule_parts)
    
    def _generate_function_inlining_rule(self, callsite_caller: str, callsite: str, src_line: str, callees: List[str]) -> str:
        """Generate rule for function inlining"""
        rule_name = f"inline_{callsite_caller.replace('plugins_call_', '')}"
        
        is_loop = self._is_loop_statement(src_line)
        
        # Start building the rule
        rule_parts = []
        rule_parts.append(f"@ {rule_name} @")
        rule_parts.append("@@")
        rule_parts.append("")
        rule_parts.append(f"{callsite_caller}(...)")
        rule_parts.append("{")
        rule_parts.append("<...")
        rule_parts.append(f"- {callsite}(...);")
        rule_parts.append(f"+ // Inlined {callsite} implementation")
        rule_parts.append("+ {")
        
        if is_loop:
            # Unroll loop with conditional calls
            for callee in callees:
                transformed_line = self._replace_indirect_call(src_line, callee)
                if_statement = self._convert_loop_to_if(transformed_line)
                rule_parts.append(f"+     {if_statement}")
        else:
            # Simple conditional calls
            for callee in callees:
                transformed_line = self._replace_indirect_call(src_line, callee)
                rule_parts.append(f"+     {transformed_line.strip()}")
        
        rule_parts.append("+ }")
        rule_parts.append("...>")
        rule_parts.append("}")
        
        return "\n".join(rule_parts)
    
    def _is_loop_statement(self, src_line: str) -> bool:
        """Check if the source line contains a loop"""
        return bool(re.search(r'\b(while|for)\s*\(', src_line))
    
    def _replace_indirect_call(self, src_line: str, callee: str) -> str:
        """Replace plfd->fn with the actual function name"""
        # Replace plfd->fn( with callee(
        transformed = re.sub(r'plfd->fn\s*\(', f'{callee}(', src_line)
        return transformed
    
    def _convert_loop_to_if(self, src_line: str) -> str:
        """Convert while/for loop to if statement"""
        # Replace while( with if(
        transformed = re.sub(r'\bwhile\s*\(', 'if (', src_line)
        # Replace for( with if(
        transformed = re.sub(r'\bfor\s*\(', 'if (', transformed)
        
        # If it's a complex loop condition, simplify it
        # Example: while (plfd->fn && (rc = plfd->fn(...)) == HANDLER_GO_ON)
        # becomes: if (callee && (rc = callee(...)) == HANDLER_GO_ON)
        
        # Add proper block structure if needed
        if not transformed.strip().endswith('{') and not transformed.strip().endswith(';'):
            if ')' in transformed:
                # Find the closing parenthesis and add block
                paren_pos = transformed.rfind(')')
                if paren_pos != -1:
                    transformed = transformed[:paren_pos+1] + ' { ++plfd; }'
            else:
                transformed += ' { ++plfd; }'
        
        return transformed
    
    def _generate_header(self) -> str:
        """Generate file header"""
        header_lines = [
            "// Coccinelle semantic patch for plugin system transformation",
            "// Generated from JSON callsite analysis",
            "//",
            "// This patch transforms:",
            "// 1. Loop statements (while/for) to conditional statements (if)",
            "// 2. Indirect function calls (plfd->fn) to direct function calls",
            "// 3. Function inlining when callsite_caller is specified",
            "//",
            "// Usage: spatch --sp-file generated.cocci --in-place target_files.c",
            "//",
            ""
        ]
        return "\n".join(header_lines)


def main():
    """Main function with error handling"""
    if len(sys.argv) != 2:
        print("Usage: python3 simple_cocci_generator.py <callsite.json>")
        print()
        print("This script generates Coccinelle semantic patches from JSON callsite data.")
        print("It performs simple transformations:")
        print("  - Converts loops to conditional statements")
        print("  - Replaces indirect calls with direct function calls")
        print("  - Inlines functions when callsite_caller is specified")
        sys.exit(1)
    
    input_file = sys.argv[1]
    
    # Read and parse JSON file
    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            json_data = json.load(f)
    except FileNotFoundError:
        print(f"Error: File '{input_file}' not found")
        sys.exit(1)
    except json.JSONDecodeError as e:
        print(f"Error: Invalid JSON format - {e}")
        sys.exit(1)
    except Exception as e:
        print(f"Error reading file: {e}")
        sys.exit(1)
    
    # Validate JSON structure
    if not isinstance(json_data, list):
        print("Error: JSON data must be an array")
        sys.exit(1)
    
    if len(json_data) == 0:
        print("Warning: No data found in JSON file")
        sys.exit(0)
    
    # Generate Coccinelle patch
    try:
        generator = SimpleCocciGenerator(json_data)
        cocci_content = generator.generate_cocci_file()
        
        # Determine output filename
        if input_file.endswith('.json'):
            output_file = input_file[:-5] + '.cocci'
        else:
            output_file = input_file + '.cocci'
        
        # Write output file
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(cocci_content)
        
        print(f"Success: Generated Coccinelle patch '{output_file}'")
        print(f"Processed {len(json_data)} entries")
        
        # Count valid rules
        valid_entries = sum(1 for entry in json_data if not generator._should_skip_entry(entry))
        print(f"Valid transformations: {valid_entries}")
        
        print()
        print("To apply the patch:")
        print(f"  spatch --sp-file {output_file} --in-place your_source_files.c")
        
    except Exception as e:
        print(f"Error generating Coccinelle patch: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()