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
typedef handler_t, plugin_fn_srv_data, plugin_fn_req_data, plugin_fn_con_data;
@@

handler_t

@transfer_target_callsite_transfer_plugins_call_handle_request_reset@
identifier CALLER = { plugins_call_handle_request_reset };
identifier CALLSITE = { plugins_call_fn_req_data };
expression list args;
expression target_offset;
@@

CALLER(...)
{
...
(
- CALLSITE(args, target_offset);
+ const int e = target_offset;
+ const void * const plugin_slots = r->con->plugin_slots;
+     const unsigned int offset = ((const unsigned short *)plugin_slots)[e];
+     if (0 == offset) return HANDLER_GO_ON;
+     const plugin_fn_req_data *plfd = (const plugin_fn_req_data *)
+       (((unsigned long)plugin_slots) + offset);
+     handler_t rc = HANDLER_GO_ON;
+     while (plfd->fn && (rc = plfd->fn(r, plfd->data)) == HANDLER_GO_ON)
+         ++plfd;
+     return rc;
|
- return CALLSITE(args, target_offset);
+ const int e = target_offset;
+ const void * const plugin_slots = r->con->plugin_slots;
+     const unsigned int offset = ((const unsigned short *)plugin_slots)[e];
+     if (0 == offset) return HANDLER_GO_ON;
+     const plugin_fn_req_data *plfd = (const plugin_fn_req_data *)
+       (((unsigned long)plugin_slots) + offset);
+     handler_t rc = HANDLER_GO_ON;
+     while (plfd->fn && (rc = plfd->fn(r, plfd->data)) == HANDLER_GO_ON)
+         ++plfd;
+     return rc;
)
...
}



@transfer_target_callsite_transfer_plugins_call_handle_connection_accept@
identifier CALLER = { plugins_call_handle_connection_accept };
identifier CALLSITE = { plugins_call_fn_con_data };
expression list args;
expression target_offset;
@@

CALLER(...)
{
...
(
- CALLSITE(args, target_offset);
+ const int e = target_offset;
+ const void * const plugin_slots = con->plugin_slots;
+     const unsigned int offset = ((const unsigned short *)plugin_slots)[e];
+     if (0 == offset) return HANDLER_GO_ON;
+     const plugin_fn_con_data *plfd = (const plugin_fn_con_data *)
+       (((unsigned long)plugin_slots) + offset);
+     handler_t rc = HANDLER_GO_ON;
+     while (plfd->fn && (rc = plfd->fn(con, plfd->data)) == HANDLER_GO_ON)
+         ++plfd;
+     return rc;
|
- return CALLSITE(args, target_offset);
+ const int e = target_offset;
+ const void * const plugin_slots = con->plugin_slots;
+     const unsigned int offset = ((const unsigned short *)plugin_slots)[e];
+     if (0 == offset) return HANDLER_GO_ON;
+     const plugin_fn_con_data *plfd = (const plugin_fn_con_data *)
+       (((unsigned long)plugin_slots) + offset);
+     handler_t rc = HANDLER_GO_ON;
+     while (plfd->fn && (rc = plfd->fn(con, plfd->data)) == HANDLER_GO_ON)
+         ++plfd;
+     return rc;
)
...
}



@transfer_target_callsite_transfer_plugins_call_handle_uri_clean@
identifier CALLER = { plugins_call_handle_uri_clean };
identifier CALLSITE = { plugins_call_fn_req_data };
expression list args;
expression target_offset;
@@

CALLER(...)
{
...
(
- CALLSITE(args, target_offset);
+ const int e = target_offset;
+ const void * const plugin_slots = r->con->plugin_slots;
+     const unsigned int offset = ((const unsigned short *)plugin_slots)[e];
+     if (0 == offset) return HANDLER_GO_ON;
+     const plugin_fn_req_data *plfd = (const plugin_fn_req_data *)
+       (((unsigned long)plugin_slots) + offset);
+     handler_t rc = HANDLER_GO_ON;
+     while (plfd->fn && (rc = plfd->fn(r, plfd->data)) == HANDLER_GO_ON)
+         ++plfd;
+     return rc;
|
- return CALLSITE(args, target_offset);
+ const int e = target_offset;
+ const void * const plugin_slots = r->con->plugin_slots;
+     const unsigned int offset = ((const unsigned short *)plugin_slots)[e];
+     if (0 == offset) return HANDLER_GO_ON;
+     const plugin_fn_req_data *plfd = (const plugin_fn_req_data *)
+       (((unsigned long)plugin_slots) + offset);
+     handler_t rc = HANDLER_GO_ON;
+     while (plfd->fn && (rc = plfd->fn(r, plfd->data)) == HANDLER_GO_ON)
+         ++plfd;
+     return rc;
)
...
}



@transfer_target_callsite_transfer_plugins_call_handle_docroot@
identifier CALLER = { plugins_call_handle_docroot };
identifier CALLSITE = { plugins_call_fn_req_data };
expression list args;
expression target_offset;
@@

CALLER(...)
{
...
(
- CALLSITE(args, target_offset);
+ const int e = target_offset;
+ const void * const plugin_slots = r->con->plugin_slots;
+     const unsigned int offset = ((const unsigned short *)plugin_slots)[e];
+     if (0 == offset) return HANDLER_GO_ON;
+     const plugin_fn_req_data *plfd = (const plugin_fn_req_data *)
+       (((unsigned long)plugin_slots) + offset);
+     handler_t rc = HANDLER_GO_ON;
+     while (plfd->fn && (rc = plfd->fn(r, plfd->data)) == HANDLER_GO_ON)
+         ++plfd;
+     return rc;
|
- return CALLSITE(args, target_offset);
+ const int e = target_offset;
+ const void * const plugin_slots = r->con->plugin_slots;
+     const unsigned int offset = ((const unsigned short *)plugin_slots)[e];
+     if (0 == offset) return HANDLER_GO_ON;
+     const plugin_fn_req_data *plfd = (const plugin_fn_req_data *)
+       (((unsigned long)plugin_slots) + offset);
+     handler_t rc = HANDLER_GO_ON;
+     while (plfd->fn && (rc = plfd->fn(r, plfd->data)) == HANDLER_GO_ON)
+         ++plfd;
+     return rc;
)
...
}



@transfer_target_callsite_transfer_plugins_call_handle_subrequest_start@
identifier CALLER = { plugins_call_handle_subrequest_start };
identifier CALLSITE = { plugins_call_fn_req_data };
expression list args;
expression target_offset;
@@

CALLER(...)
{
...
(
- CALLSITE(args, target_offset);
+ const int e = target_offset;
+ const void * const plugin_slots = r->con->plugin_slots;
+     const unsigned int offset = ((const unsigned short *)plugin_slots)[e];
+     if (0 == offset) return HANDLER_GO_ON;
+     const plugin_fn_req_data *plfd = (const plugin_fn_req_data *)
+       (((unsigned long)plugin_slots) + offset);
+     handler_t rc = HANDLER_GO_ON;
+     while (plfd->fn && (rc = plfd->fn(r, plfd->data)) == HANDLER_GO_ON)
+         ++plfd;
+     return rc;
|
- return CALLSITE(args, target_offset);
+ const int e = target_offset;
+ const void * const plugin_slots = r->con->plugin_slots;
+     const unsigned int offset = ((const unsigned short *)plugin_slots)[e];
+     if (0 == offset) return HANDLER_GO_ON;
+     const plugin_fn_req_data *plfd = (const plugin_fn_req_data *)
+       (((unsigned long)plugin_slots) + offset);
+     handler_t rc = HANDLER_GO_ON;
+     while (plfd->fn && (rc = plfd->fn(r, plfd->data)) == HANDLER_GO_ON)
+         ++plfd;
+     return rc;
)
...
}



@transfer_target_callsite_transfer_plugins_call_handle_response_start@
identifier CALLER = { plugins_call_handle_response_start };
identifier CALLSITE = { plugins_call_fn_req_data };
expression list args;
expression target_offset;
@@

CALLER(...)
{
...
(
- CALLSITE(args, target_offset);
+ const int e = target_offset;
+ const void * const plugin_slots = r->con->plugin_slots;
+     const unsigned int offset = ((const unsigned short *)plugin_slots)[e];
+     if (0 == offset) return HANDLER_GO_ON;
+     const plugin_fn_req_data *plfd = (const plugin_fn_req_data *)
+       (((unsigned long)plugin_slots) + offset);
+     handler_t rc = HANDLER_GO_ON;
+     while (plfd->fn && (rc = plfd->fn(r, plfd->data)) == HANDLER_GO_ON)
+         ++plfd;
+     return rc;
|
- return CALLSITE(args, target_offset);
+ const int e = target_offset;
+ const void * const plugin_slots = r->con->plugin_slots;
+     const unsigned int offset = ((const unsigned short *)plugin_slots)[e];
+     if (0 == offset) return HANDLER_GO_ON;
+     const plugin_fn_req_data *plfd = (const plugin_fn_req_data *)
+       (((unsigned long)plugin_slots) + offset);
+     handler_t rc = HANDLER_GO_ON;
+     while (plfd->fn && (rc = plfd->fn(r, plfd->data)) == HANDLER_GO_ON)
+         ++plfd;
+     return rc;
)
...
}



@transfer_target_callsite_transfer_plugins_call_handle_request_done@
identifier CALLER = { plugins_call_handle_request_done };
identifier CALLSITE = { plugins_call_fn_req_data };
expression list args;
expression target_offset;
@@

CALLER(...)
{
...
(
- CALLSITE(args, target_offset);
+ const int e = target_offset;
+ const void * const plugin_slots = r->con->plugin_slots;
+     const unsigned int offset = ((const unsigned short *)plugin_slots)[e];
+     if (0 == offset) return HANDLER_GO_ON;
+     const plugin_fn_req_data *plfd = (const plugin_fn_req_data *)
+       (((unsigned long)plugin_slots) + offset);
+     handler_t rc = HANDLER_GO_ON;
+     while (plfd->fn && (rc = plfd->fn(r, plfd->data)) == HANDLER_GO_ON)
+         ++plfd;
+     return rc;
|
- return CALLSITE(args, target_offset);
+ const int e = target_offset;
+ const void * const plugin_slots = r->con->plugin_slots;
+     const unsigned int offset = ((const unsigned short *)plugin_slots)[e];
+     if (0 == offset) return HANDLER_GO_ON;
+     const plugin_fn_req_data *plfd = (const plugin_fn_req_data *)
+       (((unsigned long)plugin_slots) + offset);
+     handler_t rc = HANDLER_GO_ON;
+     while (plfd->fn && (rc = plfd->fn(r, plfd->data)) == HANDLER_GO_ON)
+         ++plfd;
+     return rc;
)
...
}



@transfer_target_callsite_transfer_plugins_call_handle_connection_close@
identifier CALLER = { plugins_call_handle_connection_close };
identifier CALLSITE = { plugins_call_fn_con_data };
expression list args;
expression target_offset;
@@

CALLER(...)
{
...
(
- CALLSITE(args, target_offset);
+ const int e = target_offset;
+ const void * const plugin_slots = con->plugin_slots;
+     const unsigned int offset = ((const unsigned short *)plugin_slots)[e];
+     if (0 == offset) return HANDLER_GO_ON;
+     const plugin_fn_con_data *plfd = (const plugin_fn_con_data *)
+       (((unsigned long)plugin_slots) + offset);
+     handler_t rc = HANDLER_GO_ON;
+     while (plfd->fn && (rc = plfd->fn(con, plfd->data)) == HANDLER_GO_ON)
+         ++plfd;
+     return rc;
|
- return CALLSITE(args, target_offset);
+ const int e = target_offset;
+ const void * const plugin_slots = con->plugin_slots;
+     const unsigned int offset = ((const unsigned short *)plugin_slots)[e];
+     if (0 == offset) return HANDLER_GO_ON;
+     const plugin_fn_con_data *plfd = (const plugin_fn_con_data *)
+       (((unsigned long)plugin_slots) + offset);
+     handler_t rc = HANDLER_GO_ON;
+     while (plfd->fn && (rc = plfd->fn(con, plfd->data)) == HANDLER_GO_ON)
+         ++plfd;
+     return rc;
)
...
}



@transfer_target_callsite_transfer_plugins_call_handle_request_env@
identifier CALLER = { plugins_call_handle_request_env };
identifier CALLSITE = { plugins_call_fn_req_data };
expression list args;
expression target_offset;
@@

CALLER(...)
{
...
(
- CALLSITE(args, target_offset);
+ const int e = target_offset;
+ const void * const plugin_slots = r->con->plugin_slots;
+     const unsigned int offset = ((const unsigned short *)plugin_slots)[e];
+     if (0 == offset) return HANDLER_GO_ON;
+     const plugin_fn_req_data *plfd = (const plugin_fn_req_data *)
+       (((unsigned long)plugin_slots) + offset);
+     handler_t rc = HANDLER_GO_ON;
+     while (plfd->fn && (rc = plfd->fn(r, plfd->data)) == HANDLER_GO_ON)
+         ++plfd;
+     return rc;
|
- return CALLSITE(args, target_offset);
+ const int e = target_offset;
+ const void * const plugin_slots = r->con->plugin_slots;
+     const unsigned int offset = ((const unsigned short *)plugin_slots)[e];
+     if (0 == offset) return HANDLER_GO_ON;
+     const plugin_fn_req_data *plfd = (const plugin_fn_req_data *)
+       (((unsigned long)plugin_slots) + offset);
+     handler_t rc = HANDLER_GO_ON;
+     while (plfd->fn && (rc = plfd->fn(r, plfd->data)) == HANDLER_GO_ON)
+         ++plfd;
+     return rc;
)
...
}
