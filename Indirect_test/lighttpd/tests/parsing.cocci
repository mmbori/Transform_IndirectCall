
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

@parsing_callsite_function_plugins_call_init_1@
identifier CALLSITE = { plugins_call_init };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) {
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_init_1.p;
@@

func_name = "plugins_call_init"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_init_2@
identifier CALLSITE = { plugins_call_init };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) 
{
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_init_2.p;
@@

func_name = "plugins_call_init"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_init_3@
identifier CALLSITE = { plugins_call_init };
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
p << parsing_callsite_function_plugins_call_init_3.p;
@@

func_name = "plugins_call_init"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)



@parsing_callsite_function_plugins_call_fn_srv_data_1@
identifier CALLSITE = { plugins_call_fn_srv_data };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) {
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_fn_srv_data_1.p;
@@

func_name = "plugins_call_fn_srv_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_fn_srv_data_2@
identifier CALLSITE = { plugins_call_fn_srv_data };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) 
{
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_fn_srv_data_2.p;
@@

func_name = "plugins_call_fn_srv_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_fn_srv_data_3@
identifier CALLSITE = { plugins_call_fn_srv_data };
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
p << parsing_callsite_function_plugins_call_fn_srv_data_3.p;
@@

func_name = "plugins_call_fn_srv_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)



@parsing_callsite_function_plugins_call_fn_srv_data_all_1@
identifier CALLSITE = { plugins_call_fn_srv_data_all };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) {
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_fn_srv_data_all_1.p;
@@

func_name = "plugins_call_fn_srv_data_all"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_fn_srv_data_all_2@
identifier CALLSITE = { plugins_call_fn_srv_data_all };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) 
{
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_fn_srv_data_all_2.p;
@@

func_name = "plugins_call_fn_srv_data_all"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_fn_srv_data_all_3@
identifier CALLSITE = { plugins_call_fn_srv_data_all };
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
p << parsing_callsite_function_plugins_call_fn_srv_data_all_3.p;
@@

func_name = "plugins_call_fn_srv_data_all"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)



@parsing_callsite_function_plugins_call_handle_request_reset_1@
identifier CALLSITE = { plugins_call_fn_req_data };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) {
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_handle_request_reset_1.p;
@@

func_name = "plugins_call_fn_req_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_handle_request_reset_2@
identifier CALLSITE = { plugins_call_fn_req_data };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) 
{
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_handle_request_reset_2.p;
@@

func_name = "plugins_call_fn_req_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_handle_request_reset_3@
identifier CALLSITE = { plugins_call_fn_req_data };
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
p << parsing_callsite_function_plugins_call_handle_request_reset_3.p;
@@

func_name = "plugins_call_fn_req_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)



@parsing_callsite_function_plugins_call_handle_connection_accept_1@
identifier CALLSITE = { plugins_call_fn_con_data };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) {
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_handle_connection_accept_1.p;
@@

func_name = "plugins_call_fn_con_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_handle_connection_accept_2@
identifier CALLSITE = { plugins_call_fn_con_data };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) 
{
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_handle_connection_accept_2.p;
@@

func_name = "plugins_call_fn_con_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_handle_connection_accept_3@
identifier CALLSITE = { plugins_call_fn_con_data };
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
p << parsing_callsite_function_plugins_call_handle_connection_accept_3.p;
@@

func_name = "plugins_call_fn_con_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)



@parsing_callsite_function_plugins_call_handle_uri_clean_1@
identifier CALLSITE = { plugins_call_fn_req_data };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) {
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_handle_uri_clean_1.p;
@@

func_name = "plugins_call_fn_req_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_handle_uri_clean_2@
identifier CALLSITE = { plugins_call_fn_req_data };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) 
{
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_handle_uri_clean_2.p;
@@

func_name = "plugins_call_fn_req_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_handle_uri_clean_3@
identifier CALLSITE = { plugins_call_fn_req_data };
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
p << parsing_callsite_function_plugins_call_handle_uri_clean_3.p;
@@

func_name = "plugins_call_fn_req_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)



@parsing_callsite_function_plugins_call_handle_docroot_1@
identifier CALLSITE = { plugins_call_fn_req_data };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) {
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_handle_docroot_1.p;
@@

func_name = "plugins_call_fn_req_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_handle_docroot_2@
identifier CALLSITE = { plugins_call_fn_req_data };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) 
{
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_handle_docroot_2.p;
@@

func_name = "plugins_call_fn_req_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_handle_docroot_3@
identifier CALLSITE = { plugins_call_fn_req_data };
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
p << parsing_callsite_function_plugins_call_handle_docroot_3.p;
@@

func_name = "plugins_call_fn_req_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)



@parsing_callsite_function_plugins_call_handle_subrequest_start_1@
identifier CALLSITE = { plugins_call_fn_req_data };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) {
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_handle_subrequest_start_1.p;
@@

func_name = "plugins_call_fn_req_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_handle_subrequest_start_2@
identifier CALLSITE = { plugins_call_fn_req_data };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) 
{
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_handle_subrequest_start_2.p;
@@

func_name = "plugins_call_fn_req_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_handle_subrequest_start_3@
identifier CALLSITE = { plugins_call_fn_req_data };
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
p << parsing_callsite_function_plugins_call_handle_subrequest_start_3.p;
@@

func_name = "plugins_call_fn_req_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)



@parsing_callsite_function_plugins_call_handle_response_start_1@
identifier CALLSITE = { plugins_call_fn_req_data };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) {
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_handle_response_start_1.p;
@@

func_name = "plugins_call_fn_req_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_handle_response_start_2@
identifier CALLSITE = { plugins_call_fn_req_data };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) 
{
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_handle_response_start_2.p;
@@

func_name = "plugins_call_fn_req_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_handle_response_start_3@
identifier CALLSITE = { plugins_call_fn_req_data };
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
p << parsing_callsite_function_plugins_call_handle_response_start_3.p;
@@

func_name = "plugins_call_fn_req_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)



@parsing_callsite_function_plugins_call_handle_request_done_1@
identifier CALLSITE = { plugins_call_fn_req_data };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) {
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_handle_request_done_1.p;
@@

func_name = "plugins_call_fn_req_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_handle_request_done_2@
identifier CALLSITE = { plugins_call_fn_req_data };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) 
{
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_handle_request_done_2.p;
@@

func_name = "plugins_call_fn_req_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_handle_request_done_3@
identifier CALLSITE = { plugins_call_fn_req_data };
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
p << parsing_callsite_function_plugins_call_handle_request_done_3.p;
@@

func_name = "plugins_call_fn_req_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)



@parsing_callsite_function_plugins_call_handle_connection_close_1@
identifier CALLSITE = { plugins_call_fn_con_data };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) {
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_handle_connection_close_1.p;
@@

func_name = "plugins_call_fn_con_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_handle_connection_close_2@
identifier CALLSITE = { plugins_call_fn_con_data };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) 
{
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_handle_connection_close_2.p;
@@

func_name = "plugins_call_fn_con_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_handle_connection_close_3@
identifier CALLSITE = { plugins_call_fn_con_data };
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
p << parsing_callsite_function_plugins_call_handle_connection_close_3.p;
@@

func_name = "plugins_call_fn_con_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)



@parsing_callsite_function_http_response_handler_1@
identifier CALLSITE = { http_response_handler };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) {
BODY
}

@script:python@
p << parsing_callsite_function_http_response_handler_1.p;
@@

func_name = "http_response_handler"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_http_response_handler_2@
identifier CALLSITE = { http_response_handler };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) 
{
BODY
}

@script:python@
p << parsing_callsite_function_http_response_handler_2.p;
@@

func_name = "http_response_handler"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_http_response_handler_3@
identifier CALLSITE = { http_response_handler };
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
p << parsing_callsite_function_http_response_handler_3.p;
@@

func_name = "http_response_handler"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)



@parsing_callsite_function_plugins_call_handle_request_env_1@
identifier CALLSITE = { plugins_call_fn_req_data };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) {
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_handle_request_env_1.p;
@@

func_name = "plugins_call_fn_req_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_handle_request_env_2@
identifier CALLSITE = { plugins_call_fn_req_data };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) 
{
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_handle_request_env_2.p;
@@

func_name = "plugins_call_fn_req_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_handle_request_env_3@
identifier CALLSITE = { plugins_call_fn_req_data };
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
p << parsing_callsite_function_plugins_call_handle_request_env_3.p;
@@

func_name = "plugins_call_fn_req_data"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)



@parsing_callsite_function_plugins_call_handle_waitpid_1@
identifier CALLSITE = { plugins_call_handle_waitpid };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) {
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_handle_waitpid_1.p;
@@

func_name = "plugins_call_handle_waitpid"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_handle_waitpid_2@
identifier CALLSITE = { plugins_call_handle_waitpid };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) 
{
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_handle_waitpid_2.p;
@@

func_name = "plugins_call_handle_waitpid"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_handle_waitpid_3@
identifier CALLSITE = { plugins_call_handle_waitpid };
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
p << parsing_callsite_function_plugins_call_handle_waitpid_3.p;
@@

func_name = "plugins_call_handle_waitpid"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)



@parsing_callsite_function_plugins_call_cleanup_1@
identifier CALLSITE = { plugins_call_cleanup };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) {
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_cleanup_1.p;
@@

func_name = "plugins_call_cleanup"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_cleanup_2@
identifier CALLSITE = { plugins_call_cleanup };
parameter list PL1;
statement list BODY;
position p;
@@

CALLSITE@p(PL1) 
{
BODY
}

@script:python@
p << parsing_callsite_function_plugins_call_cleanup_2.p;
@@

func_name = "plugins_call_cleanup"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)


@parsing_callsite_function_plugins_call_cleanup_3@
identifier CALLSITE = { plugins_call_cleanup };
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
p << parsing_callsite_function_plugins_call_cleanup_3.p;
@@

func_name = "plugins_call_cleanup"
source_file = p[0].file
line_num = int(p[0].line)

print(f"=== Extracting {func_name} ===")
print(f"Source: {source_file}:{line_num}")
extract_to_file(func_name, source_file, line_num)
