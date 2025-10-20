// Coccinelle semantic patch for plugin system transformation
// Generated from JSON callsite analysis
//
// This patch performs function inlining and indirect call resolution
// Features:
//   - Inlines plugin function calls into caller functions
//   - Converts indirect function calls to direct calls
//   - Transforms loops to sequential conditional calls
//
// Usage: spatch --sp-file <patch_file> --in-place <target_files>
//


@@
typedef handler_t, plugin_fn_srv_data, plugin_fn_req_data;
@@

handler_t

@transfer_target_for_plugins_call_init@
identifier CALLSITE = { plugins_call_init };
statement S;
@@

CALLSITE(...)
{
...
(
- for(uint32_t i = 0; i < srv->plugins.used; ++i) {
- S
- }
+ // transter start 3
+ uint32_t i = 0;
+ if (i < srv->plugins.used) {
+ S
+ }
+ ++i;
+ // transfer end
|
- for(uint32_t i = 0; i < srv->plugins.used; ++i)
- S
+ // transter start 4
+ uint32_t i = 0;
+ if (i < srv->plugins.used) {
+ S
+ }
+ ++i;
+ // transfer end
)
}

@script:python depends on transfer_target_for_plugins_call_init@
S  << transfer_target_for_plugins_call_init.S;
@@

import os
import re
os.makedirs("solve_loop/", exist_ok=True)

lines = []
lines.append("// transfer start")
lines.append("uint32_t i = 0;")
lines.append("if(i < srv->plugins.used) {")
lines.append(str(S))
lines.append("}")
lines.append("++i;")
lines.append("// transfer end")

transformed_code = "\n".join(lines)

with open("solve_loop/plugins_call_init.txt", 'w') as f:
    f.write(transformed_code)



@transfer_target_while_plugins_call_fn_srv_data@
identifier CALLSITE = { plugins_call_fn_srv_data };
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

@script:python depends on transfer_target_while_plugins_call_fn_srv_data@
S << transfer_target_while_plugins_call_fn_srv_data.S;
expression cond << ransfer_target_while_plugins_call_fn_srv_data.cond
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

with open("solve_loop/plugins_call_fn_srv_data.txt", 'w') as f:
    f.write(transformed_code)



@transfer_target_for_plugins_call_fn_srv_data_all@
identifier CALLSITE = { plugins_call_fn_srv_data_all };
statement S;
@@

CALLSITE(...)
{
...
(
- for(; plfd->fn; ++plfd) {
- S
- }
+ // transter start 3
+ ;
+ if (plfd->fn) {
+ S
+ }
+ ++plfd;
+ // transfer end
|
- for(; plfd->fn; ++plfd)
- S
+ // transter start 4
+ ;
+ if (plfd->fn) {
+ S
+ }
+ ++plfd;
+ // transfer end
)
}

@script:python depends on transfer_target_for_plugins_call_fn_srv_data_all@
S  << transfer_target_for_plugins_call_fn_srv_data_all.S;
@@

import os
import re
os.makedirs("solve_loop/", exist_ok=True)

lines = []
lines.append("// transfer start")
lines.append(";")
lines.append("if(plfd->fn) {")
lines.append(str(S))
lines.append("}")
lines.append("++plfd;")
lines.append("// transfer end")

transformed_code = "\n".join(lines)

with open("solve_loop/plugins_call_fn_srv_data_all.txt", 'w') as f:
    f.write(transformed_code)



@transfer_target_while_plugins_call_handle_request_reset@
identifier CALLSITE = { plugins_call_fn_req_data };
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

@script:python depends on transfer_target_while_plugins_call_handle_request_reset@
S << transfer_target_while_plugins_call_handle_request_reset.S;
expression cond << ransfer_target_while_plugins_call_handle_request_reset.cond
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

with open("solve_loop/plugins_call_fn_req_data.txt", 'w') as f:
    f.write(transformed_code)



@transfer_target_while_plugins_call_handle_connection_accept@
identifier CALLSITE = { plugins_call_fn_con_data };
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

@script:python depends on transfer_target_while_plugins_call_handle_connection_accept@
S << transfer_target_while_plugins_call_handle_connection_accept.S;
expression cond << ransfer_target_while_plugins_call_handle_connection_accept.cond
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

with open("solve_loop/plugins_call_fn_con_data.txt", 'w') as f:
    f.write(transformed_code)



@transfer_target_while_plugins_call_handle_uri_clean@
identifier CALLSITE = { plugins_call_fn_req_data };
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

@script:python depends on transfer_target_while_plugins_call_handle_uri_clean@
S << transfer_target_while_plugins_call_handle_uri_clean.S;
expression cond << ransfer_target_while_plugins_call_handle_uri_clean.cond
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

with open("solve_loop/plugins_call_fn_req_data.txt", 'w') as f:
    f.write(transformed_code)



@transfer_target_while_plugins_call_handle_docroot@
identifier CALLSITE = { plugins_call_fn_req_data };
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

@script:python depends on transfer_target_while_plugins_call_handle_docroot@
S << transfer_target_while_plugins_call_handle_docroot.S;
expression cond << ransfer_target_while_plugins_call_handle_docroot.cond
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

with open("solve_loop/plugins_call_fn_req_data.txt", 'w') as f:
    f.write(transformed_code)



@transfer_target_while_plugins_call_handle_subrequest_start@
identifier CALLSITE = { plugins_call_fn_req_data };
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

@script:python depends on transfer_target_while_plugins_call_handle_subrequest_start@
S << transfer_target_while_plugins_call_handle_subrequest_start.S;
expression cond << ransfer_target_while_plugins_call_handle_subrequest_start.cond
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

with open("solve_loop/plugins_call_fn_req_data.txt", 'w') as f:
    f.write(transformed_code)



@transfer_target_while_plugins_call_handle_response_start@
identifier CALLSITE = { plugins_call_fn_req_data };
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

@script:python depends on transfer_target_while_plugins_call_handle_response_start@
S << transfer_target_while_plugins_call_handle_response_start.S;
expression cond << ransfer_target_while_plugins_call_handle_response_start.cond
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

with open("solve_loop/plugins_call_fn_req_data.txt", 'w') as f:
    f.write(transformed_code)



@transfer_target_while_plugins_call_handle_request_done@
identifier CALLSITE = { plugins_call_fn_req_data };
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

@script:python depends on transfer_target_while_plugins_call_handle_request_done@
S << transfer_target_while_plugins_call_handle_request_done.S;
expression cond << ransfer_target_while_plugins_call_handle_request_done.cond
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

with open("solve_loop/plugins_call_fn_req_data.txt", 'w') as f:
    f.write(transformed_code)



@transfer_target_while_plugins_call_handle_connection_close@
identifier CALLSITE = { plugins_call_fn_con_data };
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

@script:python depends on transfer_target_while_plugins_call_handle_connection_close@
S << transfer_target_while_plugins_call_handle_connection_close.S;
expression cond << ransfer_target_while_plugins_call_handle_connection_close.cond
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

with open("solve_loop/plugins_call_fn_con_data.txt", 'w') as f:
    f.write(transformed_code)



@transfer_target_while_plugins_call_handle_request_env@
identifier CALLSITE = { plugins_call_fn_req_data };
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

@script:python depends on transfer_target_while_plugins_call_handle_request_env@
S << transfer_target_while_plugins_call_handle_request_env.S;
expression cond << ransfer_target_while_plugins_call_handle_request_env.cond
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

with open("solve_loop/plugins_call_fn_req_data.txt", 'w') as f:
    f.write(transformed_code)



@transfer_target_while_plugins_call_handle_waitpid@
identifier CALLSITE = { plugins_call_handle_waitpid };
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

@script:python depends on transfer_target_while_plugins_call_handle_waitpid@
S << transfer_target_while_plugins_call_handle_waitpid.S;
expression cond << ransfer_target_while_plugins_call_handle_waitpid.cond
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

with open("solve_loop/plugins_call_handle_waitpid.txt", 'w') as f:
    f.write(transformed_code)



@transfer_target_for_plugins_call_cleanup@
identifier CALLSITE = { plugins_call_cleanup };
statement S;
@@

CALLSITE(...)
{
...
(
- for(uint32_t i = 0; i < srv->plugins.used; ++i) {
- S
- }
+ // transter start 3
+ uint32_t i = 0;
+ if (i < srv->plugins.used) {
+ S
+ }
+ ++i;
+ // transfer end
|
- for(uint32_t i = 0; i < srv->plugins.used; ++i)
- S
+ // transter start 4
+ uint32_t i = 0;
+ if (i < srv->plugins.used) {
+ S
+ }
+ ++i;
+ // transfer end
)
}

@script:python depends on transfer_target_for_plugins_call_cleanup@
S  << transfer_target_for_plugins_call_cleanup.S;
@@

import os
import re
os.makedirs("solve_loop/", exist_ok=True)

lines = []
lines.append("// transfer start")
lines.append("uint32_t i = 0;")
lines.append("if(i < srv->plugins.used) {")
lines.append(str(S))
lines.append("}")
lines.append("++i;")
lines.append("// transfer end")

transformed_code = "\n".join(lines)

with open("solve_loop/plugins_call_cleanup.txt", 'w') as f:
    f.write(transformed_code)
