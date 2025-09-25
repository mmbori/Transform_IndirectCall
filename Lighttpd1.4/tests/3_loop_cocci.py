import json
import sys
import re
import argparse
import os
from typing import Dict, List, Any, Optional, Tuple

class ControlFlowDetector:
    def __init__(self):
        # 제어문 패턴들
        self.if_pattern = re.compile(r'\s*if\s*\([^)]*\)\s*')
        self.else_if_pattern = re.compile(r'\s*else\s+if\s*\([^)]*\)\s*')
        self.else_pattern = re.compile(r'\s*else\s*')
        self.for_pattern = re.compile(r'\s*for\s*\([^)]*\)\s*')
        self.while_pattern = re.compile(r'\s*while\s*\([^)]*\)\s*')
        
        # 주석 제거 패턴
        self.single_comment = re.compile(r'//.*$')
        self.multi_comment_start = re.compile(r'/\*')
        self.multi_comment_end = re.compile(r'\*/')
        
    def remove_comments(self, lines: List[str]) -> List[str]:
        """주석을 제거한 코드 라인들을 반환"""
        result = []
        in_multi_comment = False
        
        for line in lines:
            if in_multi_comment:
                # 멀티라인 주석 끝 찾기
                end_match = self.multi_comment_end.search(line)
                if end_match:
                    line = line[end_match.end():]
                    in_multi_comment = False
                else:
                    result.append("")  # 주석 라인은 빈 문자열로
                    continue
            
            # 멀티라인 주석 시작 찾기
            start_match = self.multi_comment_start.search(line)
            if start_match:
                before_comment = line[:start_match.start()]
                after_start = line[start_match.end():]
                
                # 같은 라인에 끝이 있는지 확인
                end_match = self.multi_comment_end.search(after_start)
                if end_match:
                    after_comment = after_start[end_match.end():]
                    line = before_comment + after_comment
                else:
                    line = before_comment
                    in_multi_comment = True
            
            # 단일라인 주석 제거
            line = self.single_comment.sub('', line)
            result.append(line)
        
        return result
    
    def find_matching_brace(self, lines: List[str], start_line: int, start_pos: int) -> Optional[int]:
        """시작 위치에서 매칭되는 닫는 중괄호의 라인 번호를 찾음"""
        brace_count = 1
        current_line = start_line
        start_position = start_pos + 1
        
        while current_line < len(lines) and brace_count > 0:
            line = lines[current_line]
            
            if current_line == start_line:
                search_part = line[start_position:]
            else:
                search_part = line
                
            # 문자열 리터럴 내부의 중괄호는 무시
            in_string = False
            escape_next = False
            
            for char in search_part:
                if escape_next:
                    escape_next = False
                    continue
                    
                if char == '\\':
                    escape_next = True
                    continue
                    
                if char == '"' and not in_string:
                    in_string = True
                    continue
                elif char == '"' and in_string:
                    in_string = False
                    continue
                    
                if not in_string:
                    if char == '{':
                        brace_count += 1
                    elif char == '}':
                        brace_count -= 1
                        if brace_count == 0:
                            return current_line
            
            current_line += 1
        
        return None
    
    def is_loop_statement(self, line: str) -> Tuple[bool, str]:
        """라인이 반복문(for, while)인지 확인하고 타입을 반환"""
        line = line.strip()
        
        if self.for_pattern.match(line):
            return True, "for"
        elif self.while_pattern.match(line):
            return True, "while"
        
        return False, ""
    
    def find_loop_blocks(self, lines: List[str]) -> List[Tuple[int, int, str]]:
        """모든 제어문 블록의 시작과 끝 라인을 찾음"""
        blocks = []
        
        for i, line in enumerate(lines):
            is_control, control_type = self.is_loop_statement(line)
            if is_control:
                # 중괄호가 있는지 확인
                brace_pos = line.find('{')
                if brace_pos != -1:
                    # 중괄호가 있는 경우
                    end_line = self.find_matching_brace(lines, i, brace_pos)
                    if end_line is not None:
                        blocks.append((i, end_line, control_type))
                else:
                    # 중괄호가 없는 경우 - 다음 세미콜론까지 또는 다음 문장까지
                    end_line = self.find_single_statement_end(lines, i)
                    if end_line is not None:
                        blocks.append((i, end_line, control_type))
        
        return blocks
    
    def find_single_statement_end(self, lines: List[str], start_line: int) -> Optional[int]:
        """중괄호 없는 제어문의 끝을 찾음"""
        current_line = start_line
        loop_header = lines[start_line].strip()
        
        # 루프 헤더 이후의 내용 확인
        paren_count = 0
        in_loop_condition = False
        
        for char in loop_header:
            if char == '(':
                paren_count += 1
                in_loop_condition = True
            elif char == ')':
                paren_count -= 1
                if paren_count == 0 and in_loop_condition:
                    break
        
        remaining = loop_header[loop_header.rfind(')'):]
        
        # 같은 라인에 문장이 있는지 확인
        if ';' in remaining:
            return start_line
        
        # 다음 라인들에서 첫 번째 문장 찾기
        for i in range(start_line + 1, len(lines)):
            line = lines[i].strip()
            if not line:  # 빈 라인 스킵
                continue
            
            # 다음 문장을 찾았으면 그 라인이 끝
            if line.endswith(';') or line.endswith('{') or self.is_simple_control_statement(line):
                return i
        
        return start_line + 1  # 기본적으로 다음 라인
    
    def is_simple_control_statement(self, line: str) -> bool:
        """제어문(for, while, etc.)인지 확인 - 반복문 검사용"""
        line = line.strip()
        control_keywords = ['for', 'while', 'do', 'switch', 'case', 'default']
        return any(line.startswith(keyword + ' ') or line.startswith(keyword + '(') 
                  for keyword in control_keywords)
    
    def find_line_by_content(self, lines: List[str], target_content: str) -> List[int]:
        """파일에서 특정 내용과 정확히 매치하는 라인들의 번호를 찾음 (전체 매치만)"""
        matches = []
        target_clean = target_content.strip()
        
        for i, line in enumerate(lines):
            line_clean = line.strip()
            
            # 정확한 매치만 (공백 제거 후)
            if target_clean == line_clean:
                matches.append(i + 1)  # 1-based 라인 번호
        
        return matches
    
    def get_loop_info(self, target_line: int, lines: List[str]) -> Tuple[str, Optional[Tuple[int, int, str]]]:
        """
        특정 라인이 어떤 반복문 내부에 있는지 확인
        가장 가까운 반복문만 반환
        반환: (반복문타입, (시작라인, 끝라인, 타입) 또는 None)
        """
        # 1-based를 0-based로 변환
        target_line_idx = target_line - 1
        
        if target_line_idx < 0 or target_line_idx >= len(lines):
            return "out_of_range", None
        
        # 주석 제거
        clean_lines = self.remove_comments(lines)
        
        # 모든 반복문 블록 찾기
        blocks = self.find_loop_blocks(clean_lines)
        
        # 타겟 라인을 포함하는 반복문들 중 가장 가까운 것 찾기
        closest_loop = None
        closest_distance = float('inf')
        
        for start, end, loop_type in blocks:
            if start < target_line_idx <= end:
                # 가장 가까운 반복문은 시작점이 타겟에 가장 가까운 것
                distance = target_line_idx - start
                if distance < closest_distance:
                    closest_distance = distance
                    closest_loop = (start, end, loop_type)
        
        if closest_loop is None:
            return "none", None
        
        return closest_loop[2], closest_loop
    
    def get_loop_info_by_content(self, target_content: str, lines: List[str]) -> Optional[Tuple[int, str, str]]:
        """
        특정 라인 내용이 어떤 반복문 내부에 있는지 확인 (전체 매치만)
        반환: (라인번호, 반복문타입, 반복문전체내용) 또는 None
        """
        # 해당 내용과 정확히 매치하는 라인들 찾기
        matching_lines = self.find_line_by_content(lines, target_content)
        
        if not matching_lines:
            return ("none", "")
        
        # 첫 번째 매치만 처리
        line_num = matching_lines[0]
        loop_type, loop_info = self.get_loop_info(line_num, lines)
        
        if loop_type == "none" or loop_info is None:
            return ("none", "")
        
        # 반복문 전체 내용을 문자열로 생성
        start, end, _ = loop_info
        loop_content = '\n'.join(lines[start:end+1])
        
        return (loop_type, loop_content)
    

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
typedef handler_t, plugin_fn_srv_data, plugin_fn_req_data;
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
        
    def _is_src_line_in_loop(self, callsite: str, src_line: str) :
        try:
            with open(f'bodies/{callsite}.txt', 'r', encoding='utf-8') as f:
                content = f.read()
        except FileNotFoundError:
            raise FileNotFoundError(f"File not found: {callsite}.txt")
        except Exception as e:
            raise Exception(f"Error reading file {callsite}.txt: {e}")
        
        # 반복문 검사기 생성
        detector = ControlFlowDetector()
        lines = content.strip().split('\n')

        return detector.get_loop_info_by_content(src_line, lines)


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
        if ('for' in src_line) :
            rule_name = f"for_{callsite}"
            E1, E2, E3 = src_line.split(";")
            E1 = E1.split("(")[-1].strip()
            E2 = E2.strip()
            E3 = E3.split(")")[0].strip()

            p1 = r"""
@transfer_target_{RULE_NAME}@
identifier CALLSITE = { {CALLSITE} };
identifier FOR_LINE = { {SRC_LINE} };
statement S;
@@

CALLSITE(...)
{
...
(
- FOR_LINE
- S
- }
+ // transter start 1
+ {E1};
+ if ({E2}) {
+ S
+ }
+ {E3};
+ // transfer end
|
- FOR_LINE
- S
+ // transter start 2
+ {E1};
+ if ({E2}) {
+ S
+ }
+ {E3};
+ // transfer end
)
}

@script:python depends on transfer_target_{RULE_NAME}@
S  << transfer_target_{RULE_NAME}.S;
@@

import os
import re
os.makedirs("solve_loop/", exist_ok=True)

lines = []
lines.append("// transfer start")
lines.append("{E1};")
lines.append("if ({E2}) {")
lines.append(str(S))
lines.append("}")
lines.append("{E3};")
lines.append("// transfer end")

transformed_code = "\n".join(lines)

with open("solve_loop/{CALLSITE}.txt", 'w') as f:
    f.write(transformed_code)
""".replace("{CALLSITE}", callsite).replace("{RULE_NAME}", rule_name).replace("{SRC_LINE}",src_line).replace("{E1}", E1).replace("{E2}", E2).replace("{E3}", E3)

            return "\n".join([p1])

        elif ('while' in src_line) : 
            rule_name = f"while_{callsite}"
            cond = src_line.strip()[7:-1]

            p1 = r"""
@transfer_target_{RULE_NAME}@
identifier CALLSITE = { {CALLSITE} };
expression cond;
statement S;
@@

CALLSITE(...)
{
...
(
- while(cond) 
- S
+ // transter start 1
+ if (cond) {
+ S
+ }
+ // transfer end
|
- while(cond) {
- S
- }
+ // transter start 2
+ if (cond) {
+ S
+ }
+ // transfer end
)
...
}

@script:python depends on transfer_target_{RULE_NAME}@
S << transfer_target_{RULE_NAME}.S;
expression cond << ransfer_target_{RULE_NAME}.cond
@@

import os
import re
os.makedirs("solve_loop/", exist_ok=True)

lines = []
lines.append("// transfer start")
lines.append("if (" + str(cond) + ") {")
lines.append(str(S))
lines.append("}")
lines.append("// transfer end")

transformed_code = "\n".join(lines)

with open("solve_loop/{CALLSITE}.txt", 'w') as f:
    f.write(transformed_code)
""".replace("{CALLSITE}", callsite).replace("{RULE_NAME}", rule_name)

        else :
            loop_type, loop_content = self._is_src_line_in_loop(callsite, src_line)
            if loop_type == "none" :
                return ""
            elif loop_type == "for" :
                for_line = loop_content.strip().split('\n')[0]
                E1, E2, E3 = for_line.split(";")
                E1 = E1.split("(")[-1].strip()
                E2 = E2.strip()
                E3 = E3.split(")")[0].strip()

                # if lines[-1].strip() == "}" : 
                #     tmp_body = []
                #     for line in lines :
                #         if line == for_line : pass
                #         tmp_body.append(f"+ {line.strip()}")
                #     body = '\n'.join(tmp_body)
                rule_name = f"for_{callsite}"
                p1 = r"""
@transfer_target_{RULE_NAME}@
identifier CALLSITE = { {CALLSITE} };
statement S;
@@

CALLSITE(...)
{
...
(
- for({E1}; {E2}; {E3}) {
- S
- }
+ // transter start 3
+ {E1};
+ if ({E2}) {
+ S
+ }
+ {E3};
+ // transfer end
|
- for({E1}; {E2}; {E3})
- S
+ // transter start 4
+ {E1};
+ if ({E2}) {
+ S
+ }
+ {E3};
+ // transfer end
)
}

@script:python depends on transfer_target_{RULE_NAME}@
S  << transfer_target_{RULE_NAME}.S;
@@

import os
import re
os.makedirs("solve_loop/", exist_ok=True)

lines = []
lines.append("// transfer start")
lines.append("{E1};")
lines.append("if({E2}) {")
lines.append(str(S))
lines.append("}")
lines.append("{E3};")
lines.append("// transfer end")

transformed_code = "\n".join(lines)

with open("solve_loop/{CALLSITE}.txt", 'w') as f:
    f.write(transformed_code)
""".replace("{CALLSITE}", callsite).replace("{RULE_NAME}", rule_name).replace("{E1}",E1).replace("{E2}",E2).replace("{E3}",E3)

            elif loop_type == "while" :
                rule_name = f"while_{callsite}"
                while_line = loop_content.strip().split('\n')[0]
                cond = while_line.strip()[7:-1]

                p1 = r"""
@transfer_target_{RULE_NAME}@
identifier CALLSITE = { {CALLSITE} };
statement S;
@@

CALLSITE(...)
{
...
(
- while({COND})
- S
+ // transter start 3
+ if ({COND}) {
+ S
+ }
+ // transfer end
|
- while({COND}) {
- S
- }
+ // transter start 4
+ if ({COND}) {
+ S
+ }
+ // transfer end
)
...
}

@script:python depends on transfer_target_{RULE_NAME}@
S << transfer_target_{RULE_NAME}.S;
@@

import os
import re
os.makedirs("solve_loop/", exist_ok=True)

lines = []
lines.append("// transfer start")
lines.append("if ({COND}) {")
lines.append(str(S))
lines.append("}")
lines.append("// transfer end")

transformed_code = "\n".join(lines)

with open("solve_loop/{CALLSITE}.txt", 'w') as f:
    f.write(transformed_code)
""".replace("{CALLSITE}", callsite).replace("{RULE_NAME}", rule_name).replace("{COND}",cond)
            
            else : 
                print(f"============== No Loop ===============  fn : {callsite}")
        
        return "\n".join([p1])
                


    def _generate_function_inlining_rule(self, callsite_caller: str, callsite: str, src_line: str, callees: List[str]) -> str:
        if ('for' in src_line) :
            rule_name = f"for_{callsite_caller}"
            E1, E2, E3 = src_line.split(";")
            E1 = E1.split("(")[-1].strip()
            E2 = E2.strip()
            E3 = E3.split(")")[0].strip()

            p1 = r"""
@transfer_target_{RULE_NAME}@
identifier CALLSITE = { {CALLSITE} };
identifier FOR_LINE = { {SRC_LINE} };
statement S;
@@

CALLSITE(...)
{
...
(
- FOR_LINE
- S
- }
+ // transter start 1
+ {E1};
+ if ({E2}) {
+ S
+ }
+ {E3};
+ // transfer end
|
- FOR_LINE
- S
+ // transter start 2
+ {E1};
+ if ({E2}) {
+ S
+ }
+ {E3};
+ // transfer end
)
}

@script:python depends on transfer_target_{RULE_NAME}@
S  << transfer_target_{RULE_NAME}.S;
@@

import os
import re
os.makedirs("solve_loop/", exist_ok=True)

lines = []
lines.append("// transfer start")
lines.append("{E1};")
lines.append("if ({E2}) {")
lines.append(str(S))
lines.append("}")
lines.append("{E3};")
lines.append("// transfer end")

transformed_code = "\n".join(lines)

with open("solve_loop/{CALLSITE}.txt", 'w') as f:
    f.write(transformed_code)
""".replace("{CALLSITE}", callsite_caller).replace("{RULE_NAME}", rule_name).replace("{SRC_LINE}",src_line).replace("{E1}", E1).replace("{E2}", E2).replace("{E3}", E3)

            return "\n".join([p1])

        elif ('while' in src_line) : 
            rule_name = f"while_{callsite_caller}"
            cond = src_line.strip()[7:-1]

            p1 = r"""
@transfer_target_{RULE_NAME}@
identifier CALLSITE = { {CALLSITE} };
expression cond;
statement S;
@@

CALLSITE(...)
{
...
(
- while(cond) 
- S
+ // transter start 1
+ if (cond) {
+ S
+ }
+ // transfer end
|
- while(cond) {
- S
- }
+ // transter start 2
+ if (cond) {
+ S
+ }
+ // transfer end
)
...
}

@script:python depends on transfer_target_{RULE_NAME}@
S << transfer_target_{RULE_NAME}.S;
expression cond << ransfer_target_{RULE_NAME}.cond
@@

import os
import re
os.makedirs("solve_loop/", exist_ok=True)

lines = []
lines.append("// transfer start")
lines.append("if (" + str(cond) + ") {")
lines.append(str(S))
lines.append("}")
lines.append("// transfer end")

transformed_code = "\n".join(lines)

with open("solve_loop/{CALLSITE}.txt", 'w') as f:
    f.write(transformed_code)
""".replace("{CALLSITE}", callsite).replace("{RULE_NAME}", rule_name)
            
        else :
            loop_type, loop_content = self._is_src_line_in_loop(callsite_caller, src_line)
            if loop_type == "none" :
                return ""
            elif loop_type == "for" :
                for_line = loop_content.strip().split('\n')[0]
                E1, E2, E3 = for_line.split(";")
                E1 = E1.split("(")[-1].strip()
                E2 = E2.strip()
                E3 = E3.split(")")[0].strip()

                # if lines[-1].strip() == "}" : 
                #     tmp_body = []
                #     for line in lines :
                #         if line == for_line : pass
                #         tmp_body.append(f"+ {line.strip()}")
                #     body = '\n'.join(tmp_body)
                rule_name = f"for_{callsite_caller}"
                p1 = r"""
@transfer_target_{RULE_NAME}@
identifier CALLSITE = { {CALLSITE} };
statement S;
@@

CALLSITE(...)
{
...
(
- for({E1}; {E2}; {E3}) {
- S
- }
+ // transter start 3
+ {E1};
+ if ({E2}) {
+ S
+ }
+ {E3};
+ // transfer end
|
- for({E1}; {E2}; {E3})
- S
+ // transter start 4
+ {E1};
+ if ({E2}) {
+ S
+ }
+ {E3};
+ // transfer end
)
}

@script:python depends on transfer_target_{RULE_NAME}@
S  << transfer_target_{RULE_NAME}.S;
@@

import os
import re
os.makedirs("solve_loop/", exist_ok=True)

lines = []
lines.append("// transfer start")
lines.append("{E1};")
lines.append("if({E2}) {")
lines.append(str(S))
lines.append("}")
lines.append("{E3};")
lines.append("// transfer end")

transformed_code = "\n".join(lines)

with open("solve_loop/{CALLSITE}.txt", 'w') as f:
    f.write(transformed_code)
""".replace("{CALLSITE}", callsite_caller).replace("{RULE_NAME}", rule_name).replace("{E1}",E1).replace("{E2}",E2).replace("{E3}",E3)

            elif loop_type == "while" :
                rule_name = f"while_{callsite_caller}"
                while_line = loop_content.strip().split('\n')[0]
                cond = while_line.strip()[7:-1]

                p1 = r"""
@transfer_target_{RULE_NAME}@
identifier CALLSITE = { {CALLSITE} };
statement S;
@@

CALLSITE(...)
{
...
(
- while({COND})
- S
+ // transter start 3
+ if ({COND}) {
+ S
+ }
+ // transfer end
|
- while({COND}) {
- S
- }
+ // transter start 4
+ if ({COND}) {
+ S
+ }
+ // transfer end
)
...
}

@script:python depends on transfer_target_{RULE_NAME}@
S << transfer_target_{RULE_NAME}.S;
@@

import os
import re
os.makedirs("solve_loop/", exist_ok=True)

lines = []
lines.append("// transfer start")
lines.append("if ({COND}) {")
lines.append(str(S))
lines.append("}")
lines.append("// transfer end")

transformed_code = "\n".join(lines)

with open("solve_loop/{CALLSITE}.txt", 'w') as f:
    f.write(transformed_code)
""".replace("{CALLSITE}", callsite_caller).replace("{RULE_NAME}", rule_name).replace("{COND}",cond)
            
            else : 
                print(f"============== No Loop ===============  fn : {callsite_caller}")
        
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