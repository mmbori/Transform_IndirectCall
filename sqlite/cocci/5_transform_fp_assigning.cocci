// Auto-generated Coccinelle script for function pointer to direct signature assignment
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

// ===== FUNCTION POINTER ASSIGNMENT TO DIRECT SIGNATURE ASSIGNMENT (specific functions) =====

// Rules for aggregate_context (1 valid functions, 0 excluded)
// Rule: .aggregate_context = sqlite3_aggregate_context ==> .aggregate_context_signature = aggregate_context_signatures[aggregate_context_sqlite3_aggregate_context_enum];
@transform_aggregate_context_sqlite3_aggregate_context@
expression E;
identifier FP_NAME = aggregate_context;
identifier FUNC_NAME = sqlite3_aggregate_context;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.aggregate_context_signature = aggregate_context_signatures[aggregate_context_sqlite3_aggregate_context_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.aggregate_context_signature = aggregate_context_signatures[aggregate_context_sqlite3_aggregate_context_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->aggregate_context_signature = aggregate_context_signatures[aggregate_context_sqlite3_aggregate_context_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->aggregate_context_signature = aggregate_context_signatures[aggregate_context_sqlite3_aggregate_context_enum];
)

// Rules for auto_extension (1 valid functions, 0 excluded)
// Rule: .auto_extension = sqlite3_vtab_config ==> .auto_extension_signature = auto_extension_signatures[auto_extension_sqlite3_vtab_config_enum];
@transform_auto_extension_sqlite3_vtab_config@
expression E;
identifier FP_NAME = auto_extension;
identifier FUNC_NAME = sqlite3_vtab_config;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.auto_extension_signature = auto_extension_signatures[auto_extension_sqlite3_vtab_config_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.auto_extension_signature = auto_extension_signatures[auto_extension_sqlite3_vtab_config_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->auto_extension_signature = auto_extension_signatures[auto_extension_sqlite3_vtab_config_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->auto_extension_signature = auto_extension_signatures[auto_extension_sqlite3_vtab_config_enum];
)

// Rules for backup_finish (1 valid functions, 0 excluded)
// Rule: .backup_finish = sqlite3_result_error_code ==> .backup_finish_signature = backup_finish_signatures[backup_finish_sqlite3_result_error_code_enum];
@transform_backup_finish_sqlite3_result_error_code@
expression E;
identifier FP_NAME = backup_finish;
identifier FUNC_NAME = sqlite3_result_error_code;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.backup_finish_signature = backup_finish_signatures[backup_finish_sqlite3_result_error_code_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.backup_finish_signature = backup_finish_signatures[backup_finish_sqlite3_result_error_code_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->backup_finish_signature = backup_finish_signatures[backup_finish_sqlite3_result_error_code_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->backup_finish_signature = backup_finish_signatures[backup_finish_sqlite3_result_error_code_enum];
)

// Rules for backup_init (1 valid functions, 0 excluded)
// Rule: .backup_init = sqlite3_test_control ==> .backup_init_signature = backup_init_signatures[backup_init_sqlite3_test_control_enum];
@transform_backup_init_sqlite3_test_control@
expression E;
identifier FP_NAME = backup_init;
identifier FUNC_NAME = sqlite3_test_control;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.backup_init_signature = backup_init_signatures[backup_init_sqlite3_test_control_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.backup_init_signature = backup_init_signatures[backup_init_sqlite3_test_control_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->backup_init_signature = backup_init_signatures[backup_init_sqlite3_test_control_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->backup_init_signature = backup_init_signatures[backup_init_sqlite3_test_control_enum];
)

// Rules for backup_pagecount (1 valid functions, 0 excluded)
// Rule: .backup_pagecount = sqlite3_randomness ==> .backup_pagecount_signature = backup_pagecount_signatures[backup_pagecount_sqlite3_randomness_enum];
@transform_backup_pagecount_sqlite3_randomness@
expression E;
identifier FP_NAME = backup_pagecount;
identifier FUNC_NAME = sqlite3_randomness;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.backup_pagecount_signature = backup_pagecount_signatures[backup_pagecount_sqlite3_randomness_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.backup_pagecount_signature = backup_pagecount_signatures[backup_pagecount_sqlite3_randomness_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->backup_pagecount_signature = backup_pagecount_signatures[backup_pagecount_sqlite3_randomness_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->backup_pagecount_signature = backup_pagecount_signatures[backup_pagecount_sqlite3_randomness_enum];
)

// Rules for backup_remaining (1 valid functions, 0 excluded)
// Rule: .backup_remaining = sqlite3_context_db_handle ==> .backup_remaining_signature = backup_remaining_signatures[backup_remaining_sqlite3_context_db_handle_enum];
@transform_backup_remaining_sqlite3_context_db_handle@
expression E;
identifier FP_NAME = backup_remaining;
identifier FUNC_NAME = sqlite3_context_db_handle;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.backup_remaining_signature = backup_remaining_signatures[backup_remaining_sqlite3_context_db_handle_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.backup_remaining_signature = backup_remaining_signatures[backup_remaining_sqlite3_context_db_handle_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->backup_remaining_signature = backup_remaining_signatures[backup_remaining_sqlite3_context_db_handle_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->backup_remaining_signature = backup_remaining_signatures[backup_remaining_sqlite3_context_db_handle_enum];
)

// Rules for backup_step (1 valid functions, 0 excluded)
// Rule: .backup_step = sqlite3_extended_result_codes ==> .backup_step_signature = backup_step_signatures[backup_step_sqlite3_extended_result_codes_enum];
@transform_backup_step_sqlite3_extended_result_codes@
expression E;
identifier FP_NAME = backup_step;
identifier FUNC_NAME = sqlite3_extended_result_codes;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.backup_step_signature = backup_step_signatures[backup_step_sqlite3_extended_result_codes_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.backup_step_signature = backup_step_signatures[backup_step_sqlite3_extended_result_codes_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->backup_step_signature = backup_step_signatures[backup_step_sqlite3_extended_result_codes_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->backup_step_signature = backup_step_signatures[backup_step_sqlite3_extended_result_codes_enum];
)

// Rules for bind_blob64 (1 valid functions, 0 excluded)
// Rule: .bind_blob64 = sqlite3_vtab_on_conflict ==> .bind_blob64_signature = bind_blob64_signatures[bind_blob64_sqlite3_vtab_on_conflict_enum];
@transform_bind_blob64_sqlite3_vtab_on_conflict@
expression E;
identifier FP_NAME = bind_blob64;
identifier FUNC_NAME = sqlite3_vtab_on_conflict;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.bind_blob64_signature = bind_blob64_signatures[bind_blob64_sqlite3_vtab_on_conflict_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.bind_blob64_signature = bind_blob64_signatures[bind_blob64_sqlite3_vtab_on_conflict_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->bind_blob64_signature = bind_blob64_signatures[bind_blob64_sqlite3_vtab_on_conflict_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->bind_blob64_signature = bind_blob64_signatures[bind_blob64_sqlite3_vtab_on_conflict_enum];
)

// Rules for bind_int (1 valid functions, 0 excluded)
// Rule: .bind_int = sqlite3_bind_double ==> .bind_int_signature = bind_int_signatures[bind_int_sqlite3_bind_double_enum];
@transform_bind_int_sqlite3_bind_double@
expression E;
identifier FP_NAME = bind_int;
identifier FUNC_NAME = sqlite3_bind_double;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.bind_int_signature = bind_int_signatures[bind_int_sqlite3_bind_double_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.bind_int_signature = bind_int_signatures[bind_int_sqlite3_bind_double_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->bind_int_signature = bind_int_signatures[bind_int_sqlite3_bind_double_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->bind_int_signature = bind_int_signatures[bind_int_sqlite3_bind_double_enum];
)

// Rules for bind_int64 (1 valid functions, 0 excluded)
// Rule: .bind_int64 = sqlite3_bind_int ==> .bind_int64_signature = bind_int64_signatures[bind_int64_sqlite3_bind_int_enum];
@transform_bind_int64_sqlite3_bind_int@
expression E;
identifier FP_NAME = bind_int64;
identifier FUNC_NAME = sqlite3_bind_int;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.bind_int64_signature = bind_int64_signatures[bind_int64_sqlite3_bind_int_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.bind_int64_signature = bind_int64_signatures[bind_int64_sqlite3_bind_int_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->bind_int64_signature = bind_int64_signatures[bind_int64_sqlite3_bind_int_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->bind_int64_signature = bind_int64_signatures[bind_int64_sqlite3_bind_int_enum];
)

// Rules for bind_null (1 valid functions, 0 excluded)
// Rule: .bind_null = sqlite3_bind_int64 ==> .bind_null_signature = bind_null_signatures[bind_null_sqlite3_bind_int64_enum];
@transform_bind_null_sqlite3_bind_int64@
expression E;
identifier FP_NAME = bind_null;
identifier FUNC_NAME = sqlite3_bind_int64;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.bind_null_signature = bind_null_signatures[bind_null_sqlite3_bind_int64_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.bind_null_signature = bind_null_signatures[bind_null_sqlite3_bind_int64_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->bind_null_signature = bind_null_signatures[bind_null_sqlite3_bind_int64_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->bind_null_signature = bind_null_signatures[bind_null_sqlite3_bind_int64_enum];
)

// Rules for bind_parameter_count (1 valid functions, 0 excluded)
// Rule: .bind_parameter_count = sqlite3_bind_null ==> .bind_parameter_count_signature = bind_parameter_count_signatures[bind_parameter_count_sqlite3_bind_null_enum];
@transform_bind_parameter_count_sqlite3_bind_null@
expression E;
identifier FP_NAME = bind_parameter_count;
identifier FUNC_NAME = sqlite3_bind_null;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.bind_parameter_count_signature = bind_parameter_count_signatures[bind_parameter_count_sqlite3_bind_null_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.bind_parameter_count_signature = bind_parameter_count_signatures[bind_parameter_count_sqlite3_bind_null_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->bind_parameter_count_signature = bind_parameter_count_signatures[bind_parameter_count_sqlite3_bind_null_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->bind_parameter_count_signature = bind_parameter_count_signatures[bind_parameter_count_sqlite3_bind_null_enum];
)

// Rules for bind_parameter_index (1 valid functions, 0 excluded)
// Rule: .bind_parameter_index = sqlite3_bind_parameter_count ==> .bind_parameter_index_signature = bind_parameter_index_signatures[bind_parameter_index_sqlite3_bind_parameter_count_enum];
@transform_bind_parameter_index_sqlite3_bind_parameter_count@
expression E;
identifier FP_NAME = bind_parameter_index;
identifier FUNC_NAME = sqlite3_bind_parameter_count;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.bind_parameter_index_signature = bind_parameter_index_signatures[bind_parameter_index_sqlite3_bind_parameter_count_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.bind_parameter_index_signature = bind_parameter_index_signatures[bind_parameter_index_sqlite3_bind_parameter_count_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->bind_parameter_index_signature = bind_parameter_index_signatures[bind_parameter_index_sqlite3_bind_parameter_count_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->bind_parameter_index_signature = bind_parameter_index_signatures[bind_parameter_index_sqlite3_bind_parameter_count_enum];
)

// Rules for bind_parameter_name (1 valid functions, 0 excluded)
// Rule: .bind_parameter_name = sqlite3_bind_parameter_index ==> .bind_parameter_name_signature = bind_parameter_name_signatures[bind_parameter_name_sqlite3_bind_parameter_index_enum];
@transform_bind_parameter_name_sqlite3_bind_parameter_index@
expression E;
identifier FP_NAME = bind_parameter_name;
identifier FUNC_NAME = sqlite3_bind_parameter_index;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.bind_parameter_name_signature = bind_parameter_name_signatures[bind_parameter_name_sqlite3_bind_parameter_index_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.bind_parameter_name_signature = bind_parameter_name_signatures[bind_parameter_name_sqlite3_bind_parameter_index_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->bind_parameter_name_signature = bind_parameter_name_signatures[bind_parameter_name_sqlite3_bind_parameter_index_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->bind_parameter_name_signature = bind_parameter_name_signatures[bind_parameter_name_sqlite3_bind_parameter_index_enum];
)

// Rules for bind_text (1 valid functions, 0 excluded)
// Rule: .bind_text = sqlite3_bind_parameter_name ==> .bind_text_signature = bind_text_signatures[bind_text_sqlite3_bind_parameter_name_enum];
@transform_bind_text_sqlite3_bind_parameter_name@
expression E;
identifier FP_NAME = bind_text;
identifier FUNC_NAME = sqlite3_bind_parameter_name;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.bind_text_signature = bind_text_signatures[bind_text_sqlite3_bind_parameter_name_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.bind_text_signature = bind_text_signatures[bind_text_sqlite3_bind_parameter_name_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->bind_text_signature = bind_text_signatures[bind_text_sqlite3_bind_parameter_name_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->bind_text_signature = bind_text_signatures[bind_text_sqlite3_bind_parameter_name_enum];
)

// Rules for bind_text16 (1 valid functions, 0 excluded)
// Rule: .bind_text16 = sqlite3_bind_text ==> .bind_text16_signature = bind_text16_signatures[bind_text16_sqlite3_bind_text_enum];
@transform_bind_text16_sqlite3_bind_text@
expression E;
identifier FP_NAME = bind_text16;
identifier FUNC_NAME = sqlite3_bind_text;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.bind_text16_signature = bind_text16_signatures[bind_text16_sqlite3_bind_text_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.bind_text16_signature = bind_text16_signatures[bind_text16_sqlite3_bind_text_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->bind_text16_signature = bind_text16_signatures[bind_text16_sqlite3_bind_text_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->bind_text16_signature = bind_text16_signatures[bind_text16_sqlite3_bind_text_enum];
)

// Rules for bind_text64 (1 valid functions, 0 excluded)
// Rule: .bind_text64 = sqlite3_close_v2 ==> .bind_text64_signature = bind_text64_signatures[bind_text64_sqlite3_close_v2_enum];
@transform_bind_text64_sqlite3_close_v2@
expression E;
identifier FP_NAME = bind_text64;
identifier FUNC_NAME = sqlite3_close_v2;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.bind_text64_signature = bind_text64_signatures[bind_text64_sqlite3_close_v2_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.bind_text64_signature = bind_text64_signatures[bind_text64_sqlite3_close_v2_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->bind_text64_signature = bind_text64_signatures[bind_text64_sqlite3_close_v2_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->bind_text64_signature = bind_text64_signatures[bind_text64_sqlite3_close_v2_enum];
)

// Rules for bind_value (1 valid functions, 0 excluded)
// Rule: .bind_value = sqlite3_bind_text16 ==> .bind_value_signature = bind_value_signatures[bind_value_sqlite3_bind_text16_enum];
@transform_bind_value_sqlite3_bind_text16@
expression E;
identifier FP_NAME = bind_value;
identifier FUNC_NAME = sqlite3_bind_text16;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.bind_value_signature = bind_value_signatures[bind_value_sqlite3_bind_text16_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.bind_value_signature = bind_value_signatures[bind_value_sqlite3_bind_text16_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->bind_value_signature = bind_value_signatures[bind_value_sqlite3_bind_text16_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->bind_value_signature = bind_value_signatures[bind_value_sqlite3_bind_text16_enum];
)

// Rules for bind_zeroblob (1 valid functions, 0 excluded)
// Rule: .bind_zeroblob = sqlite3_prepare_v2 ==> .bind_zeroblob_signature = bind_zeroblob_signatures[bind_zeroblob_sqlite3_prepare_v2_enum];
@transform_bind_zeroblob_sqlite3_prepare_v2@
expression E;
identifier FP_NAME = bind_zeroblob;
identifier FUNC_NAME = sqlite3_prepare_v2;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.bind_zeroblob_signature = bind_zeroblob_signatures[bind_zeroblob_sqlite3_prepare_v2_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.bind_zeroblob_signature = bind_zeroblob_signatures[bind_zeroblob_sqlite3_prepare_v2_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->bind_zeroblob_signature = bind_zeroblob_signatures[bind_zeroblob_sqlite3_prepare_v2_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->bind_zeroblob_signature = bind_zeroblob_signatures[bind_zeroblob_sqlite3_prepare_v2_enum];
)

// Rules for bind_zeroblob64 (1 valid functions, 0 excluded)
// Rule: .bind_zeroblob64 = sqlite3_auto_extension ==> .bind_zeroblob64_signature = bind_zeroblob64_signatures[bind_zeroblob64_sqlite3_auto_extension_enum];
@transform_bind_zeroblob64_sqlite3_auto_extension@
expression E;
identifier FP_NAME = bind_zeroblob64;
identifier FUNC_NAME = sqlite3_auto_extension;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.bind_zeroblob64_signature = bind_zeroblob64_signatures[bind_zeroblob64_sqlite3_auto_extension_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.bind_zeroblob64_signature = bind_zeroblob64_signatures[bind_zeroblob64_sqlite3_auto_extension_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->bind_zeroblob64_signature = bind_zeroblob64_signatures[bind_zeroblob64_sqlite3_auto_extension_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->bind_zeroblob64_signature = bind_zeroblob64_signatures[bind_zeroblob64_sqlite3_auto_extension_enum];
)

// Rules for blob_bytes (1 valid functions, 0 excluded)
// Rule: .blob_bytes = sqlite3_prepare16_v2 ==> .blob_bytes_signature = blob_bytes_signatures[blob_bytes_sqlite3_prepare16_v2_enum];
@transform_blob_bytes_sqlite3_prepare16_v2@
expression E;
identifier FP_NAME = blob_bytes;
identifier FUNC_NAME = sqlite3_prepare16_v2;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.blob_bytes_signature = blob_bytes_signatures[blob_bytes_sqlite3_prepare16_v2_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.blob_bytes_signature = blob_bytes_signatures[blob_bytes_sqlite3_prepare16_v2_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->blob_bytes_signature = blob_bytes_signatures[blob_bytes_sqlite3_prepare16_v2_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->blob_bytes_signature = blob_bytes_signatures[blob_bytes_sqlite3_prepare16_v2_enum];
)

// Rules for blob_close (1 valid functions, 0 excluded)
// Rule: .blob_close = sqlite3_clear_bindings ==> .blob_close_signature = blob_close_signatures[blob_close_sqlite3_clear_bindings_enum];
@transform_blob_close_sqlite3_clear_bindings@
expression E;
identifier FP_NAME = blob_close;
identifier FUNC_NAME = sqlite3_clear_bindings;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.blob_close_signature = blob_close_signatures[blob_close_sqlite3_clear_bindings_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.blob_close_signature = blob_close_signatures[blob_close_sqlite3_clear_bindings_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->blob_close_signature = blob_close_signatures[blob_close_sqlite3_clear_bindings_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->blob_close_signature = blob_close_signatures[blob_close_sqlite3_clear_bindings_enum];
)

// Rules for blob_open (1 valid functions, 0 excluded)
// Rule: .blob_open = sqlite3_create_module_v2 ==> .blob_open_signature = blob_open_signatures[blob_open_sqlite3_create_module_v2_enum];
@transform_blob_open_sqlite3_create_module_v2@
expression E;
identifier FP_NAME = blob_open;
identifier FUNC_NAME = sqlite3_create_module_v2;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.blob_open_signature = blob_open_signatures[blob_open_sqlite3_create_module_v2_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.blob_open_signature = blob_open_signatures[blob_open_sqlite3_create_module_v2_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->blob_open_signature = blob_open_signatures[blob_open_sqlite3_create_module_v2_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->blob_open_signature = blob_open_signatures[blob_open_sqlite3_create_module_v2_enum];
)

// Rules for blob_read (1 valid functions, 0 excluded)
// Rule: .blob_read = sqlite3_bind_zeroblob ==> .blob_read_signature = blob_read_signatures[blob_read_sqlite3_bind_zeroblob_enum];
@transform_blob_read_sqlite3_bind_zeroblob@
expression E;
identifier FP_NAME = blob_read;
identifier FUNC_NAME = sqlite3_bind_zeroblob;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.blob_read_signature = blob_read_signatures[blob_read_sqlite3_bind_zeroblob_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.blob_read_signature = blob_read_signatures[blob_read_sqlite3_bind_zeroblob_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->blob_read_signature = blob_read_signatures[blob_read_sqlite3_bind_zeroblob_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->blob_read_signature = blob_read_signatures[blob_read_sqlite3_bind_zeroblob_enum];
)

// Rules for blob_reopen (1 valid functions, 0 excluded)
// Rule: .blob_reopen = sqlite3_db_status ==> .blob_reopen_signature = blob_reopen_signatures[blob_reopen_sqlite3_db_status_enum];
@transform_blob_reopen_sqlite3_db_status@
expression E;
identifier FP_NAME = blob_reopen;
identifier FUNC_NAME = sqlite3_db_status;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.blob_reopen_signature = blob_reopen_signatures[blob_reopen_sqlite3_db_status_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.blob_reopen_signature = blob_reopen_signatures[blob_reopen_sqlite3_db_status_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->blob_reopen_signature = blob_reopen_signatures[blob_reopen_sqlite3_db_status_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->blob_reopen_signature = blob_reopen_signatures[blob_reopen_sqlite3_db_status_enum];
)

// Rules for blob_write (1 valid functions, 0 excluded)
// Rule: .blob_write = sqlite3_blob_bytes ==> .blob_write_signature = blob_write_signatures[blob_write_sqlite3_blob_bytes_enum];
@transform_blob_write_sqlite3_blob_bytes@
expression E;
identifier FP_NAME = blob_write;
identifier FUNC_NAME = sqlite3_blob_bytes;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.blob_write_signature = blob_write_signatures[blob_write_sqlite3_blob_bytes_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.blob_write_signature = blob_write_signatures[blob_write_sqlite3_blob_bytes_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->blob_write_signature = blob_write_signatures[blob_write_sqlite3_blob_bytes_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->blob_write_signature = blob_write_signatures[blob_write_sqlite3_blob_bytes_enum];
)

// Rules for busy_handler (1 valid functions, 0 excluded)
// Rule: .busy_handler = sqlite3_bind_value ==> .busy_handler_signature = busy_handler_signatures[busy_handler_sqlite3_bind_value_enum];
@transform_busy_handler_sqlite3_bind_value@
expression E;
identifier FP_NAME = busy_handler;
identifier FUNC_NAME = sqlite3_bind_value;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.busy_handler_signature = busy_handler_signatures[busy_handler_sqlite3_bind_value_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.busy_handler_signature = busy_handler_signatures[busy_handler_sqlite3_bind_value_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->busy_handler_signature = busy_handler_signatures[busy_handler_sqlite3_bind_value_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->busy_handler_signature = busy_handler_signatures[busy_handler_sqlite3_bind_value_enum];
)

// Rules for busy_timeout (1 valid functions, 0 excluded)
// Rule: .busy_timeout = sqlite3_busy_handler ==> .busy_timeout_signature = busy_timeout_signatures[busy_timeout_sqlite3_busy_handler_enum];
@transform_busy_timeout_sqlite3_busy_handler@
expression E;
identifier FP_NAME = busy_timeout;
identifier FUNC_NAME = sqlite3_busy_handler;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.busy_timeout_signature = busy_timeout_signatures[busy_timeout_sqlite3_busy_handler_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.busy_timeout_signature = busy_timeout_signatures[busy_timeout_sqlite3_busy_handler_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->busy_timeout_signature = busy_timeout_signatures[busy_timeout_sqlite3_busy_handler_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->busy_timeout_signature = busy_timeout_signatures[busy_timeout_sqlite3_busy_handler_enum];
)

// Rules for cancel_auto_extension (1 valid functions, 0 excluded)
// Rule: .cancel_auto_extension = sqlite3_db_filename ==> .cancel_auto_extension_signature = cancel_auto_extension_signatures[cancel_auto_extension_sqlite3_db_filename_enum];
@transform_cancel_auto_extension_sqlite3_db_filename@
expression E;
identifier FP_NAME = cancel_auto_extension;
identifier FUNC_NAME = sqlite3_db_filename;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.cancel_auto_extension_signature = cancel_auto_extension_signatures[cancel_auto_extension_sqlite3_db_filename_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.cancel_auto_extension_signature = cancel_auto_extension_signatures[cancel_auto_extension_sqlite3_db_filename_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->cancel_auto_extension_signature = cancel_auto_extension_signatures[cancel_auto_extension_sqlite3_db_filename_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->cancel_auto_extension_signature = cancel_auto_extension_signatures[cancel_auto_extension_sqlite3_db_filename_enum];
)

// Rules for changes (1 valid functions, 0 excluded)
// Rule: .changes = sqlite3_busy_timeout ==> .changes_signature = changes_signatures[changes_sqlite3_busy_timeout_enum];
@transform_changes_sqlite3_busy_timeout@
expression E;
identifier FP_NAME = changes;
identifier FUNC_NAME = sqlite3_busy_timeout;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.changes_signature = changes_signatures[changes_sqlite3_busy_timeout_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.changes_signature = changes_signatures[changes_sqlite3_busy_timeout_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->changes_signature = changes_signatures[changes_sqlite3_busy_timeout_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->changes_signature = changes_signatures[changes_sqlite3_busy_timeout_enum];
)

// Rules for changes64 (1 valid functions, 0 excluded)
// Rule: .changes64 = sqlite3_str_value ==> .changes64_signature = changes64_signatures[changes64_sqlite3_str_value_enum];
@transform_changes64_sqlite3_str_value@
expression E;
identifier FP_NAME = changes64;
identifier FUNC_NAME = sqlite3_str_value;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.changes64_signature = changes64_signatures[changes64_sqlite3_str_value_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.changes64_signature = changes64_signatures[changes64_sqlite3_str_value_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->changes64_signature = changes64_signatures[changes64_sqlite3_str_value_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->changes64_signature = changes64_signatures[changes64_sqlite3_str_value_enum];
)

// Rules for clear_bindings (1 valid functions, 0 excluded)
// Rule: .clear_bindings = sqlite3_vmprintf ==> .clear_bindings_signature = clear_bindings_signatures[clear_bindings_sqlite3_vmprintf_enum];
@transform_clear_bindings_sqlite3_vmprintf@
expression E;
identifier FP_NAME = clear_bindings;
identifier FUNC_NAME = sqlite3_vmprintf;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.clear_bindings_signature = clear_bindings_signatures[clear_bindings_sqlite3_vmprintf_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.clear_bindings_signature = clear_bindings_signatures[clear_bindings_sqlite3_vmprintf_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->clear_bindings_signature = clear_bindings_signatures[clear_bindings_sqlite3_vmprintf_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->clear_bindings_signature = clear_bindings_signatures[clear_bindings_sqlite3_vmprintf_enum];
)

// Rules for close (1 valid functions, 0 excluded)
// Rule: .close = sqlite3_changes ==> .close_signature = close_signatures[close_sqlite3_changes_enum];
@transform_close_sqlite3_changes@
expression E;
identifier FP_NAME = close;
identifier FUNC_NAME = sqlite3_changes;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.close_signature = close_signatures[close_sqlite3_changes_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.close_signature = close_signatures[close_sqlite3_changes_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->close_signature = close_signatures[close_sqlite3_changes_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->close_signature = close_signatures[close_sqlite3_changes_enum];
)

// Rules for close_v2 (1 valid functions, 0 excluded)
// Rule: .close_v2 = sqlite3_soft_heap_limit64 ==> .close_v2_signature = close_v2_signatures[close_v2_sqlite3_soft_heap_limit64_enum];
@transform_close_v2_sqlite3_soft_heap_limit64@
expression E;
identifier FP_NAME = close_v2;
identifier FUNC_NAME = sqlite3_soft_heap_limit64;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.close_v2_signature = close_v2_signatures[close_v2_sqlite3_soft_heap_limit64_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.close_v2_signature = close_v2_signatures[close_v2_sqlite3_soft_heap_limit64_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->close_v2_signature = close_v2_signatures[close_v2_sqlite3_soft_heap_limit64_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->close_v2_signature = close_v2_signatures[close_v2_sqlite3_soft_heap_limit64_enum];
)

// Rules for collation_needed (1 valid functions, 0 excluded)
// Rule: .collation_needed = sqlite3_close ==> .collation_needed_signature = collation_needed_signatures[collation_needed_sqlite3_close_enum];
@transform_collation_needed_sqlite3_close@
expression E;
identifier FP_NAME = collation_needed;
identifier FUNC_NAME = sqlite3_close;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.collation_needed_signature = collation_needed_signatures[collation_needed_sqlite3_close_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.collation_needed_signature = collation_needed_signatures[collation_needed_sqlite3_close_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->collation_needed_signature = collation_needed_signatures[collation_needed_sqlite3_close_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->collation_needed_signature = collation_needed_signatures[collation_needed_sqlite3_close_enum];
)

// Rules for collation_needed16 (1 valid functions, 0 excluded)
// Rule: .collation_needed16 = sqlite3_collation_needed ==> .collation_needed16_signature = collation_needed16_signatures[collation_needed16_sqlite3_collation_needed_enum];
@transform_collation_needed16_sqlite3_collation_needed@
expression E;
identifier FP_NAME = collation_needed16;
identifier FUNC_NAME = sqlite3_collation_needed;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.collation_needed16_signature = collation_needed16_signatures[collation_needed16_sqlite3_collation_needed_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.collation_needed16_signature = collation_needed16_signatures[collation_needed16_sqlite3_collation_needed_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->collation_needed16_signature = collation_needed16_signatures[collation_needed16_sqlite3_collation_needed_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->collation_needed16_signature = collation_needed16_signatures[collation_needed16_sqlite3_collation_needed_enum];
)

// Rules for column_blob (1 valid functions, 0 excluded)
// Rule: .column_blob = sqlite3_collation_needed16 ==> .column_blob_signature = column_blob_signatures[column_blob_sqlite3_collation_needed16_enum];
@transform_column_blob_sqlite3_collation_needed16@
expression E;
identifier FP_NAME = column_blob;
identifier FUNC_NAME = sqlite3_collation_needed16;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.column_blob_signature = column_blob_signatures[column_blob_sqlite3_collation_needed16_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.column_blob_signature = column_blob_signatures[column_blob_sqlite3_collation_needed16_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->column_blob_signature = column_blob_signatures[column_blob_sqlite3_collation_needed16_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->column_blob_signature = column_blob_signatures[column_blob_sqlite3_collation_needed16_enum];
)

// Rules for column_bytes (1 valid functions, 0 excluded)
// Rule: .column_bytes = sqlite3_column_blob ==> .column_bytes_signature = column_bytes_signatures[column_bytes_sqlite3_column_blob_enum];
@transform_column_bytes_sqlite3_column_blob@
expression E;
identifier FP_NAME = column_bytes;
identifier FUNC_NAME = sqlite3_column_blob;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.column_bytes_signature = column_bytes_signatures[column_bytes_sqlite3_column_blob_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.column_bytes_signature = column_bytes_signatures[column_bytes_sqlite3_column_blob_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->column_bytes_signature = column_bytes_signatures[column_bytes_sqlite3_column_blob_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->column_bytes_signature = column_bytes_signatures[column_bytes_sqlite3_column_blob_enum];
)

// Rules for column_bytes16 (1 valid functions, 0 excluded)
// Rule: .column_bytes16 = sqlite3_column_bytes ==> .column_bytes16_signature = column_bytes16_signatures[column_bytes16_sqlite3_column_bytes_enum];
@transform_column_bytes16_sqlite3_column_bytes@
expression E;
identifier FP_NAME = column_bytes16;
identifier FUNC_NAME = sqlite3_column_bytes;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.column_bytes16_signature = column_bytes16_signatures[column_bytes16_sqlite3_column_bytes_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.column_bytes16_signature = column_bytes16_signatures[column_bytes16_sqlite3_column_bytes_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->column_bytes16_signature = column_bytes16_signatures[column_bytes16_sqlite3_column_bytes_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->column_bytes16_signature = column_bytes16_signatures[column_bytes16_sqlite3_column_bytes_enum];
)

// Rules for column_count (1 valid functions, 0 excluded)
// Rule: .column_count = sqlite3_column_bytes16 ==> .column_count_signature = column_count_signatures[column_count_sqlite3_column_bytes16_enum];
@transform_column_count_sqlite3_column_bytes16@
expression E;
identifier FP_NAME = column_count;
identifier FUNC_NAME = sqlite3_column_bytes16;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.column_count_signature = column_count_signatures[column_count_sqlite3_column_bytes16_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.column_count_signature = column_count_signatures[column_count_sqlite3_column_bytes16_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->column_count_signature = column_count_signatures[column_count_sqlite3_column_bytes16_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->column_count_signature = column_count_signatures[column_count_sqlite3_column_bytes16_enum];
)

// Rules for column_database_name (1 valid functions, 0 excluded)
// Rule: .column_database_name = sqlite3_column_count ==> .column_database_name_signature = column_database_name_signatures[column_database_name_sqlite3_column_count_enum];
@transform_column_database_name_sqlite3_column_count@
expression E;
identifier FP_NAME = column_database_name;
identifier FUNC_NAME = sqlite3_column_count;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.column_database_name_signature = column_database_name_signatures[column_database_name_sqlite3_column_count_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.column_database_name_signature = column_database_name_signatures[column_database_name_sqlite3_column_count_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->column_database_name_signature = column_database_name_signatures[column_database_name_sqlite3_column_count_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->column_database_name_signature = column_database_name_signatures[column_database_name_sqlite3_column_count_enum];
)

// Rules for column_database_name16 (1 valid functions, 0 excluded)
// Rule: .column_database_name16 = sqlite3_column_database_name ==> .column_database_name16_signature = column_database_name16_signatures[column_database_name16_sqlite3_column_database_name_enum];
@transform_column_database_name16_sqlite3_column_database_name@
expression E;
identifier FP_NAME = column_database_name16;
identifier FUNC_NAME = sqlite3_column_database_name;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.column_database_name16_signature = column_database_name16_signatures[column_database_name16_sqlite3_column_database_name_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.column_database_name16_signature = column_database_name16_signatures[column_database_name16_sqlite3_column_database_name_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->column_database_name16_signature = column_database_name16_signatures[column_database_name16_sqlite3_column_database_name_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->column_database_name16_signature = column_database_name16_signatures[column_database_name16_sqlite3_column_database_name_enum];
)

// Rules for column_decltype (1 valid functions, 0 excluded)
// Rule: .column_decltype = sqlite3_column_database_name16 ==> .column_decltype_signature = column_decltype_signatures[column_decltype_sqlite3_column_database_name16_enum];
@transform_column_decltype_sqlite3_column_database_name16@
expression E;
identifier FP_NAME = column_decltype;
identifier FUNC_NAME = sqlite3_column_database_name16;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.column_decltype_signature = column_decltype_signatures[column_decltype_sqlite3_column_database_name16_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.column_decltype_signature = column_decltype_signatures[column_decltype_sqlite3_column_database_name16_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->column_decltype_signature = column_decltype_signatures[column_decltype_sqlite3_column_database_name16_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->column_decltype_signature = column_decltype_signatures[column_decltype_sqlite3_column_database_name16_enum];
)

// Rules for column_decltype16 (1 valid functions, 0 excluded)
// Rule: .column_decltype16 = sqlite3_column_decltype ==> .column_decltype16_signature = column_decltype16_signatures[column_decltype16_sqlite3_column_decltype_enum];
@transform_column_decltype16_sqlite3_column_decltype@
expression E;
identifier FP_NAME = column_decltype16;
identifier FUNC_NAME = sqlite3_column_decltype;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.column_decltype16_signature = column_decltype16_signatures[column_decltype16_sqlite3_column_decltype_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.column_decltype16_signature = column_decltype16_signatures[column_decltype16_sqlite3_column_decltype_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->column_decltype16_signature = column_decltype16_signatures[column_decltype16_sqlite3_column_decltype_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->column_decltype16_signature = column_decltype16_signatures[column_decltype16_sqlite3_column_decltype_enum];
)

// Rules for column_double (1 valid functions, 0 excluded)
// Rule: .column_double = sqlite3_column_decltype16 ==> .column_double_signature = column_double_signatures[column_double_sqlite3_column_decltype16_enum];
@transform_column_double_sqlite3_column_decltype16@
expression E;
identifier FP_NAME = column_double;
identifier FUNC_NAME = sqlite3_column_decltype16;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.column_double_signature = column_double_signatures[column_double_sqlite3_column_decltype16_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.column_double_signature = column_double_signatures[column_double_sqlite3_column_decltype16_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->column_double_signature = column_double_signatures[column_double_sqlite3_column_decltype16_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->column_double_signature = column_double_signatures[column_double_sqlite3_column_decltype16_enum];
)

// Rules for column_int (1 valid functions, 0 excluded)
// Rule: .column_int = sqlite3_column_double ==> .column_int_signature = column_int_signatures[column_int_sqlite3_column_double_enum];
@transform_column_int_sqlite3_column_double@
expression E;
identifier FP_NAME = column_int;
identifier FUNC_NAME = sqlite3_column_double;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.column_int_signature = column_int_signatures[column_int_sqlite3_column_double_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.column_int_signature = column_int_signatures[column_int_sqlite3_column_double_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->column_int_signature = column_int_signatures[column_int_sqlite3_column_double_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->column_int_signature = column_int_signatures[column_int_sqlite3_column_double_enum];
)

// Rules for column_int64 (1 valid functions, 0 excluded)
// Rule: .column_int64 = sqlite3_column_int ==> .column_int64_signature = column_int64_signatures[column_int64_sqlite3_column_int_enum];
@transform_column_int64_sqlite3_column_int@
expression E;
identifier FP_NAME = column_int64;
identifier FUNC_NAME = sqlite3_column_int;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.column_int64_signature = column_int64_signatures[column_int64_sqlite3_column_int_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.column_int64_signature = column_int64_signatures[column_int64_sqlite3_column_int_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->column_int64_signature = column_int64_signatures[column_int64_sqlite3_column_int_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->column_int64_signature = column_int64_signatures[column_int64_sqlite3_column_int_enum];
)

// Rules for column_name (1 valid functions, 0 excluded)
// Rule: .column_name = sqlite3_column_int64 ==> .column_name_signature = column_name_signatures[column_name_sqlite3_column_int64_enum];
@transform_column_name_sqlite3_column_int64@
expression E;
identifier FP_NAME = column_name;
identifier FUNC_NAME = sqlite3_column_int64;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.column_name_signature = column_name_signatures[column_name_sqlite3_column_int64_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.column_name_signature = column_name_signatures[column_name_sqlite3_column_int64_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->column_name_signature = column_name_signatures[column_name_sqlite3_column_int64_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->column_name_signature = column_name_signatures[column_name_sqlite3_column_int64_enum];
)

// Rules for column_name16 (1 valid functions, 0 excluded)
// Rule: .column_name16 = sqlite3_column_name ==> .column_name16_signature = column_name16_signatures[column_name16_sqlite3_column_name_enum];
@transform_column_name16_sqlite3_column_name@
expression E;
identifier FP_NAME = column_name16;
identifier FUNC_NAME = sqlite3_column_name;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.column_name16_signature = column_name16_signatures[column_name16_sqlite3_column_name_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.column_name16_signature = column_name16_signatures[column_name16_sqlite3_column_name_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->column_name16_signature = column_name16_signatures[column_name16_sqlite3_column_name_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->column_name16_signature = column_name16_signatures[column_name16_sqlite3_column_name_enum];
)

// Rules for column_origin_name (1 valid functions, 0 excluded)
// Rule: .column_origin_name = sqlite3_column_name16 ==> .column_origin_name_signature = column_origin_name_signatures[column_origin_name_sqlite3_column_name16_enum];
@transform_column_origin_name_sqlite3_column_name16@
expression E;
identifier FP_NAME = column_origin_name;
identifier FUNC_NAME = sqlite3_column_name16;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.column_origin_name_signature = column_origin_name_signatures[column_origin_name_sqlite3_column_name16_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.column_origin_name_signature = column_origin_name_signatures[column_origin_name_sqlite3_column_name16_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->column_origin_name_signature = column_origin_name_signatures[column_origin_name_sqlite3_column_name16_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->column_origin_name_signature = column_origin_name_signatures[column_origin_name_sqlite3_column_name16_enum];
)

// Rules for column_origin_name16 (1 valid functions, 0 excluded)
// Rule: .column_origin_name16 = sqlite3_column_origin_name ==> .column_origin_name16_signature = column_origin_name16_signatures[column_origin_name16_sqlite3_column_origin_name_enum];
@transform_column_origin_name16_sqlite3_column_origin_name@
expression E;
identifier FP_NAME = column_origin_name16;
identifier FUNC_NAME = sqlite3_column_origin_name;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.column_origin_name16_signature = column_origin_name16_signatures[column_origin_name16_sqlite3_column_origin_name_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.column_origin_name16_signature = column_origin_name16_signatures[column_origin_name16_sqlite3_column_origin_name_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->column_origin_name16_signature = column_origin_name16_signatures[column_origin_name16_sqlite3_column_origin_name_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->column_origin_name16_signature = column_origin_name16_signatures[column_origin_name16_sqlite3_column_origin_name_enum];
)

// Rules for column_table_name (1 valid functions, 0 excluded)
// Rule: .column_table_name = sqlite3_column_origin_name16 ==> .column_table_name_signature = column_table_name_signatures[column_table_name_sqlite3_column_origin_name16_enum];
@transform_column_table_name_sqlite3_column_origin_name16@
expression E;
identifier FP_NAME = column_table_name;
identifier FUNC_NAME = sqlite3_column_origin_name16;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.column_table_name_signature = column_table_name_signatures[column_table_name_sqlite3_column_origin_name16_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.column_table_name_signature = column_table_name_signatures[column_table_name_sqlite3_column_origin_name16_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->column_table_name_signature = column_table_name_signatures[column_table_name_sqlite3_column_origin_name16_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->column_table_name_signature = column_table_name_signatures[column_table_name_sqlite3_column_origin_name16_enum];
)

// Rules for column_table_name16 (1 valid functions, 0 excluded)
// Rule: .column_table_name16 = sqlite3_column_table_name ==> .column_table_name16_signature = column_table_name16_signatures[column_table_name16_sqlite3_column_table_name_enum];
@transform_column_table_name16_sqlite3_column_table_name@
expression E;
identifier FP_NAME = column_table_name16;
identifier FUNC_NAME = sqlite3_column_table_name;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.column_table_name16_signature = column_table_name16_signatures[column_table_name16_sqlite3_column_table_name_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.column_table_name16_signature = column_table_name16_signatures[column_table_name16_sqlite3_column_table_name_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->column_table_name16_signature = column_table_name16_signatures[column_table_name16_sqlite3_column_table_name_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->column_table_name16_signature = column_table_name16_signatures[column_table_name16_sqlite3_column_table_name_enum];
)

// Rules for column_text (1 valid functions, 0 excluded)
// Rule: .column_text = sqlite3_column_table_name16 ==> .column_text_signature = column_text_signatures[column_text_sqlite3_column_table_name16_enum];
@transform_column_text_sqlite3_column_table_name16@
expression E;
identifier FP_NAME = column_text;
identifier FUNC_NAME = sqlite3_column_table_name16;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.column_text_signature = column_text_signatures[column_text_sqlite3_column_table_name16_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.column_text_signature = column_text_signatures[column_text_sqlite3_column_table_name16_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->column_text_signature = column_text_signatures[column_text_sqlite3_column_table_name16_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->column_text_signature = column_text_signatures[column_text_sqlite3_column_table_name16_enum];
)

// Rules for column_text16 (1 valid functions, 0 excluded)
// Rule: .column_text16 = sqlite3_column_text ==> .column_text16_signature = column_text16_signatures[column_text16_sqlite3_column_text_enum];
@transform_column_text16_sqlite3_column_text@
expression E;
identifier FP_NAME = column_text16;
identifier FUNC_NAME = sqlite3_column_text;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.column_text16_signature = column_text16_signatures[column_text16_sqlite3_column_text_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.column_text16_signature = column_text16_signatures[column_text16_sqlite3_column_text_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->column_text16_signature = column_text16_signatures[column_text16_sqlite3_column_text_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->column_text16_signature = column_text16_signatures[column_text16_sqlite3_column_text_enum];
)

// Rules for column_type (1 valid functions, 0 excluded)
// Rule: .column_type = sqlite3_column_text16 ==> .column_type_signature = column_type_signatures[column_type_sqlite3_column_text16_enum];
@transform_column_type_sqlite3_column_text16@
expression E;
identifier FP_NAME = column_type;
identifier FUNC_NAME = sqlite3_column_text16;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.column_type_signature = column_type_signatures[column_type_sqlite3_column_text16_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.column_type_signature = column_type_signatures[column_type_sqlite3_column_text16_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->column_type_signature = column_type_signatures[column_type_sqlite3_column_text16_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->column_type_signature = column_type_signatures[column_type_sqlite3_column_text16_enum];
)

// Rules for column_value (1 valid functions, 0 excluded)
// Rule: .column_value = sqlite3_column_type ==> .column_value_signature = column_value_signatures[column_value_sqlite3_column_type_enum];
@transform_column_value_sqlite3_column_type@
expression E;
identifier FP_NAME = column_value;
identifier FUNC_NAME = sqlite3_column_type;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.column_value_signature = column_value_signatures[column_value_sqlite3_column_type_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.column_value_signature = column_value_signatures[column_value_sqlite3_column_type_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->column_value_signature = column_value_signatures[column_value_sqlite3_column_type_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->column_value_signature = column_value_signatures[column_value_sqlite3_column_type_enum];
)

// Rules for commit_hook (1 valid functions, 0 excluded)
// Rule: .commit_hook = sqlite3_column_value ==> .commit_hook_signature = commit_hook_signatures[commit_hook_sqlite3_column_value_enum];
@transform_commit_hook_sqlite3_column_value@
expression E;
identifier FP_NAME = commit_hook;
identifier FUNC_NAME = sqlite3_column_value;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.commit_hook_signature = commit_hook_signatures[commit_hook_sqlite3_column_value_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.commit_hook_signature = commit_hook_signatures[commit_hook_sqlite3_column_value_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->commit_hook_signature = commit_hook_signatures[commit_hook_sqlite3_column_value_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->commit_hook_signature = commit_hook_signatures[commit_hook_sqlite3_column_value_enum];
)

// Rules for compileoption_get (1 valid functions, 0 excluded)
// Rule: .compileoption_get = sqlite3_limit ==> .compileoption_get_signature = compileoption_get_signatures[compileoption_get_sqlite3_limit_enum];
@transform_compileoption_get_sqlite3_limit@
expression E;
identifier FP_NAME = compileoption_get;
identifier FUNC_NAME = sqlite3_limit;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.compileoption_get_signature = compileoption_get_signatures[compileoption_get_sqlite3_limit_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.compileoption_get_signature = compileoption_get_signatures[compileoption_get_sqlite3_limit_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->compileoption_get_signature = compileoption_get_signatures[compileoption_get_sqlite3_limit_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->compileoption_get_signature = compileoption_get_signatures[compileoption_get_sqlite3_limit_enum];
)

// Rules for compileoption_used (1 valid functions, 0 excluded)
// Rule: .compileoption_used = sqlite3_next_stmt ==> .compileoption_used_signature = compileoption_used_signatures[compileoption_used_sqlite3_next_stmt_enum];
@transform_compileoption_used_sqlite3_next_stmt@
expression E;
identifier FP_NAME = compileoption_used;
identifier FUNC_NAME = sqlite3_next_stmt;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.compileoption_used_signature = compileoption_used_signatures[compileoption_used_sqlite3_next_stmt_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.compileoption_used_signature = compileoption_used_signatures[compileoption_used_sqlite3_next_stmt_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->compileoption_used_signature = compileoption_used_signatures[compileoption_used_sqlite3_next_stmt_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->compileoption_used_signature = compileoption_used_signatures[compileoption_used_sqlite3_next_stmt_enum];
)

// Rules for complete (1 valid functions, 0 excluded)
// Rule: .complete = sqlite3_commit_hook ==> .complete_signature = complete_signatures[complete_sqlite3_commit_hook_enum];
@transform_complete_sqlite3_commit_hook@
expression E;
identifier FP_NAME = complete;
identifier FUNC_NAME = sqlite3_commit_hook;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.complete_signature = complete_signatures[complete_sqlite3_commit_hook_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.complete_signature = complete_signatures[complete_sqlite3_commit_hook_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->complete_signature = complete_signatures[complete_sqlite3_commit_hook_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->complete_signature = complete_signatures[complete_sqlite3_commit_hook_enum];
)

// Rules for complete16 (1 valid functions, 0 excluded)
// Rule: .complete16 = sqlite3_complete ==> .complete16_signature = complete16_signatures[complete16_sqlite3_complete_enum];
@transform_complete16_sqlite3_complete@
expression E;
identifier FP_NAME = complete16;
identifier FUNC_NAME = sqlite3_complete;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.complete16_signature = complete16_signatures[complete16_sqlite3_complete_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.complete16_signature = complete16_signatures[complete16_sqlite3_complete_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->complete16_signature = complete16_signatures[complete16_sqlite3_complete_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->complete16_signature = complete16_signatures[complete16_sqlite3_complete_enum];
)

// Rules for context_db_handle (1 valid functions, 0 excluded)
// Rule: .context_db_handle = sqlite3_soft_heap_limit ==> .context_db_handle_signature = context_db_handle_signatures[context_db_handle_sqlite3_soft_heap_limit_enum];
@transform_context_db_handle_sqlite3_soft_heap_limit@
expression E;
identifier FP_NAME = context_db_handle;
identifier FUNC_NAME = sqlite3_soft_heap_limit;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.context_db_handle_signature = context_db_handle_signatures[context_db_handle_sqlite3_soft_heap_limit_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.context_db_handle_signature = context_db_handle_signatures[context_db_handle_sqlite3_soft_heap_limit_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->context_db_handle_signature = context_db_handle_signatures[context_db_handle_sqlite3_soft_heap_limit_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->context_db_handle_signature = context_db_handle_signatures[context_db_handle_sqlite3_soft_heap_limit_enum];
)

// Rules for create_collation (1 valid functions, 0 excluded)
// Rule: .create_collation = sqlite3_complete16 ==> .create_collation_signature = create_collation_signatures[create_collation_sqlite3_complete16_enum];
@transform_create_collation_sqlite3_complete16@
expression E;
identifier FP_NAME = create_collation;
identifier FUNC_NAME = sqlite3_complete16;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.create_collation_signature = create_collation_signatures[create_collation_sqlite3_complete16_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.create_collation_signature = create_collation_signatures[create_collation_sqlite3_complete16_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->create_collation_signature = create_collation_signatures[create_collation_sqlite3_complete16_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->create_collation_signature = create_collation_signatures[create_collation_sqlite3_complete16_enum];
)

// Rules for create_collation16 (1 valid functions, 0 excluded)
// Rule: .create_collation16 = sqlite3_create_collation ==> .create_collation16_signature = create_collation16_signatures[create_collation16_sqlite3_create_collation_enum];
@transform_create_collation16_sqlite3_create_collation@
expression E;
identifier FP_NAME = create_collation16;
identifier FUNC_NAME = sqlite3_create_collation;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.create_collation16_signature = create_collation16_signatures[create_collation16_sqlite3_create_collation_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.create_collation16_signature = create_collation16_signatures[create_collation16_sqlite3_create_collation_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->create_collation16_signature = create_collation16_signatures[create_collation16_sqlite3_create_collation_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->create_collation16_signature = create_collation16_signatures[create_collation16_sqlite3_create_collation_enum];
)

// Rules for create_collation_v2 (1 valid functions, 0 excluded)
// Rule: .create_collation_v2 = sqlite3_blob_close ==> .create_collation_v2_signature = create_collation_v2_signatures[create_collation_v2_sqlite3_blob_close_enum];
@transform_create_collation_v2_sqlite3_blob_close@
expression E;
identifier FP_NAME = create_collation_v2;
identifier FUNC_NAME = sqlite3_blob_close;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.create_collation_v2_signature = create_collation_v2_signatures[create_collation_v2_sqlite3_blob_close_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.create_collation_v2_signature = create_collation_v2_signatures[create_collation_v2_sqlite3_blob_close_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->create_collation_v2_signature = create_collation_v2_signatures[create_collation_v2_sqlite3_blob_close_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->create_collation_v2_signature = create_collation_v2_signatures[create_collation_v2_sqlite3_blob_close_enum];
)

// Rules for create_filename (1 valid functions, 0 excluded)
// Rule: .create_filename = sqlite3_str_appendchar ==> .create_filename_signature = create_filename_signatures[create_filename_sqlite3_str_appendchar_enum];
@transform_create_filename_sqlite3_str_appendchar@
expression E;
identifier FP_NAME = create_filename;
identifier FUNC_NAME = sqlite3_str_appendchar;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.create_filename_signature = create_filename_signatures[create_filename_sqlite3_str_appendchar_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.create_filename_signature = create_filename_signatures[create_filename_sqlite3_str_appendchar_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->create_filename_signature = create_filename_signatures[create_filename_sqlite3_str_appendchar_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->create_filename_signature = create_filename_signatures[create_filename_sqlite3_str_appendchar_enum];
)

// Rules for create_function (1 valid functions, 0 excluded)
// Rule: .create_function = sqlite3_create_collation16 ==> .create_function_signature = create_function_signatures[create_function_sqlite3_create_collation16_enum];
@transform_create_function_sqlite3_create_collation16@
expression E;
identifier FP_NAME = create_function;
identifier FUNC_NAME = sqlite3_create_collation16;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.create_function_signature = create_function_signatures[create_function_sqlite3_create_collation16_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.create_function_signature = create_function_signatures[create_function_sqlite3_create_collation16_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->create_function_signature = create_function_signatures[create_function_sqlite3_create_collation16_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->create_function_signature = create_function_signatures[create_function_sqlite3_create_collation16_enum];
)

// Rules for create_function16 (1 valid functions, 0 excluded)
// Rule: .create_function16 = sqlite3_create_function ==> .create_function16_signature = create_function16_signatures[create_function16_sqlite3_create_function_enum];
@transform_create_function16_sqlite3_create_function@
expression E;
identifier FP_NAME = create_function16;
identifier FUNC_NAME = sqlite3_create_function;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.create_function16_signature = create_function16_signatures[create_function16_sqlite3_create_function_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.create_function16_signature = create_function16_signatures[create_function16_sqlite3_create_function_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->create_function16_signature = create_function16_signatures[create_function16_sqlite3_create_function_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->create_function16_signature = create_function16_signatures[create_function16_sqlite3_create_function_enum];
)

// Rules for create_function_v2 (1 valid functions, 0 excluded)
// Rule: .create_function_v2 = sqlite3_sql ==> .create_function_v2_signature = create_function_v2_signatures[create_function_v2_sqlite3_sql_enum];
@transform_create_function_v2_sqlite3_sql@
expression E;
identifier FP_NAME = create_function_v2;
identifier FUNC_NAME = sqlite3_sql;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.create_function_v2_signature = create_function_v2_signatures[create_function_v2_sqlite3_sql_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.create_function_v2_signature = create_function_v2_signatures[create_function_v2_sqlite3_sql_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->create_function_v2_signature = create_function_v2_signatures[create_function_v2_sqlite3_sql_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->create_function_v2_signature = create_function_v2_signatures[create_function_v2_sqlite3_sql_enum];
)

// Rules for create_module (1 valid functions, 0 excluded)
// Rule: .create_module = sqlite3_create_function16 ==> .create_module_signature = create_module_signatures[create_module_sqlite3_create_function16_enum];
@transform_create_module_sqlite3_create_function16@
expression E;
identifier FP_NAME = create_module;
identifier FUNC_NAME = sqlite3_create_function16;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.create_module_signature = create_module_signatures[create_module_sqlite3_create_function16_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.create_module_signature = create_module_signatures[create_module_sqlite3_create_function16_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->create_module_signature = create_module_signatures[create_module_sqlite3_create_function16_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->create_module_signature = create_module_signatures[create_module_sqlite3_create_function16_enum];
)

// Rules for create_module_v2 (1 valid functions, 0 excluded)
// Rule: .create_module_v2 = sqlite3_overload_function ==> .create_module_v2_signature = create_module_v2_signatures[create_module_v2_sqlite3_overload_function_enum];
@transform_create_module_v2_sqlite3_overload_function@
expression E;
identifier FP_NAME = create_module_v2;
identifier FUNC_NAME = sqlite3_overload_function;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.create_module_v2_signature = create_module_v2_signatures[create_module_v2_sqlite3_overload_function_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.create_module_v2_signature = create_module_v2_signatures[create_module_v2_sqlite3_overload_function_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->create_module_v2_signature = create_module_v2_signatures[create_module_v2_sqlite3_overload_function_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->create_module_v2_signature = create_module_v2_signatures[create_module_v2_sqlite3_overload_function_enum];
)

// Rules for create_window_function (1 valid functions, 0 excluded)
// Rule: .create_window_function = sqlite3_vtab_collation ==> .create_window_function_signature = create_window_function_signatures[create_window_function_sqlite3_vtab_collation_enum];
@transform_create_window_function_sqlite3_vtab_collation@
expression E;
identifier FP_NAME = create_window_function;
identifier FUNC_NAME = sqlite3_vtab_collation;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.create_window_function_signature = create_window_function_signatures[create_window_function_sqlite3_vtab_collation_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.create_window_function_signature = create_window_function_signatures[create_window_function_sqlite3_vtab_collation_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->create_window_function_signature = create_window_function_signatures[create_window_function_sqlite3_vtab_collation_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->create_window_function_signature = create_window_function_signatures[create_window_function_sqlite3_vtab_collation_enum];
)

// Rules for data_count (1 valid functions, 0 excluded)
// Rule: .data_count = sqlite3_create_module ==> .data_count_signature = data_count_signatures[data_count_sqlite3_create_module_enum];
@transform_data_count_sqlite3_create_module@
expression E;
identifier FP_NAME = data_count;
identifier FUNC_NAME = sqlite3_create_module;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.data_count_signature = data_count_signatures[data_count_sqlite3_create_module_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.data_count_signature = data_count_signatures[data_count_sqlite3_create_module_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->data_count_signature = data_count_signatures[data_count_sqlite3_create_module_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->data_count_signature = data_count_signatures[data_count_sqlite3_create_module_enum];
)

// Rules for database_file_object (1 valid functions, 0 excluded)
// Rule: .database_file_object = sqlite3_str_errcode ==> .database_file_object_signature = database_file_object_signatures[database_file_object_sqlite3_str_errcode_enum];
@transform_database_file_object_sqlite3_str_errcode@
expression E;
identifier FP_NAME = database_file_object;
identifier FUNC_NAME = sqlite3_str_errcode;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.database_file_object_signature = database_file_object_signatures[database_file_object_sqlite3_str_errcode_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.database_file_object_signature = database_file_object_signatures[database_file_object_sqlite3_str_errcode_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->database_file_object_signature = database_file_object_signatures[database_file_object_sqlite3_str_errcode_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->database_file_object_signature = database_file_object_signatures[database_file_object_sqlite3_str_errcode_enum];
)

// Rules for db_cacheflush (1 valid functions, 0 excluded)
// Rule: .db_cacheflush = sqlite3_malloc64 ==> .db_cacheflush_signature = db_cacheflush_signatures[db_cacheflush_sqlite3_malloc64_enum];
@transform_db_cacheflush_sqlite3_malloc64@
expression E;
identifier FP_NAME = db_cacheflush;
identifier FUNC_NAME = sqlite3_malloc64;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.db_cacheflush_signature = db_cacheflush_signatures[db_cacheflush_sqlite3_malloc64_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.db_cacheflush_signature = db_cacheflush_signatures[db_cacheflush_sqlite3_malloc64_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->db_cacheflush_signature = db_cacheflush_signatures[db_cacheflush_sqlite3_malloc64_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->db_cacheflush_signature = db_cacheflush_signatures[db_cacheflush_sqlite3_malloc64_enum];
)

// Rules for db_config (1 valid functions, 0 excluded)
// Rule: .db_config = sqlite3_status ==> .db_config_signature = db_config_signatures[db_config_sqlite3_status_enum];
@transform_db_config_sqlite3_status@
expression E;
identifier FP_NAME = db_config;
identifier FUNC_NAME = sqlite3_status;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.db_config_signature = db_config_signatures[db_config_sqlite3_status_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.db_config_signature = db_config_signatures[db_config_sqlite3_status_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->db_config_signature = db_config_signatures[db_config_sqlite3_status_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->db_config_signature = db_config_signatures[db_config_sqlite3_status_enum];
)

// Rules for db_filename (1 valid functions, 0 excluded)
// Rule: .db_filename = sqlite3_sourceid ==> .db_filename_signature = db_filename_signatures[db_filename_sqlite3_sourceid_enum];
@transform_db_filename_sqlite3_sourceid@
expression E;
identifier FP_NAME = db_filename;
identifier FUNC_NAME = sqlite3_sourceid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.db_filename_signature = db_filename_signatures[db_filename_sqlite3_sourceid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.db_filename_signature = db_filename_signatures[db_filename_sqlite3_sourceid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->db_filename_signature = db_filename_signatures[db_filename_sqlite3_sourceid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->db_filename_signature = db_filename_signatures[db_filename_sqlite3_sourceid_enum];
)

// Rules for db_handle (1 valid functions, 0 excluded)
// Rule: .db_handle = sqlite3_data_count ==> .db_handle_signature = db_handle_signatures[db_handle_sqlite3_data_count_enum];
@transform_db_handle_sqlite3_data_count@
expression E;
identifier FP_NAME = db_handle;
identifier FUNC_NAME = sqlite3_data_count;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.db_handle_signature = db_handle_signatures[db_handle_sqlite3_data_count_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.db_handle_signature = db_handle_signatures[db_handle_sqlite3_data_count_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->db_handle_signature = db_handle_signatures[db_handle_sqlite3_data_count_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->db_handle_signature = db_handle_signatures[db_handle_sqlite3_data_count_enum];
)

// Rules for db_mutex (1 valid functions, 0 excluded)
// Rule: .db_mutex = sqlite3_backup_finish ==> .db_mutex_signature = db_mutex_signatures[db_mutex_sqlite3_backup_finish_enum];
@transform_db_mutex_sqlite3_backup_finish@
expression E;
identifier FP_NAME = db_mutex;
identifier FUNC_NAME = sqlite3_backup_finish;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.db_mutex_signature = db_mutex_signatures[db_mutex_sqlite3_backup_finish_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.db_mutex_signature = db_mutex_signatures[db_mutex_sqlite3_backup_finish_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->db_mutex_signature = db_mutex_signatures[db_mutex_sqlite3_backup_finish_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->db_mutex_signature = db_mutex_signatures[db_mutex_sqlite3_backup_finish_enum];
)

// Rules for db_name (1 valid functions, 0 excluded)
// Rule: .db_name = sqlite3_filename_journal ==> .db_name_signature = db_name_signatures[db_name_sqlite3_filename_journal_enum];
@transform_db_name_sqlite3_filename_journal@
expression E;
identifier FP_NAME = db_name;
identifier FUNC_NAME = sqlite3_filename_journal;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.db_name_signature = db_name_signatures[db_name_sqlite3_filename_journal_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.db_name_signature = db_name_signatures[db_name_sqlite3_filename_journal_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->db_name_signature = db_name_signatures[db_name_sqlite3_filename_journal_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->db_name_signature = db_name_signatures[db_name_sqlite3_filename_journal_enum];
)

// Rules for db_readonly (1 valid functions, 0 excluded)
// Rule: .db_readonly = sqlite3_stmt_status ==> .db_readonly_signature = db_readonly_signatures[db_readonly_sqlite3_stmt_status_enum];
@transform_db_readonly_sqlite3_stmt_status@
expression E;
identifier FP_NAME = db_readonly;
identifier FUNC_NAME = sqlite3_stmt_status;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.db_readonly_signature = db_readonly_signatures[db_readonly_sqlite3_stmt_status_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.db_readonly_signature = db_readonly_signatures[db_readonly_sqlite3_stmt_status_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->db_readonly_signature = db_readonly_signatures[db_readonly_sqlite3_stmt_status_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->db_readonly_signature = db_readonly_signatures[db_readonly_sqlite3_stmt_status_enum];
)

// Rules for db_release_memory (1 valid functions, 0 excluded)
// Rule: .db_release_memory = sqlite3_strnicmp ==> .db_release_memory_signature = db_release_memory_signatures[db_release_memory_sqlite3_strnicmp_enum];
@transform_db_release_memory_sqlite3_strnicmp@
expression E;
identifier FP_NAME = db_release_memory;
identifier FUNC_NAME = sqlite3_strnicmp;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.db_release_memory_signature = db_release_memory_signatures[db_release_memory_sqlite3_strnicmp_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.db_release_memory_signature = db_release_memory_signatures[db_release_memory_sqlite3_strnicmp_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->db_release_memory_signature = db_release_memory_signatures[db_release_memory_sqlite3_strnicmp_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->db_release_memory_signature = db_release_memory_signatures[db_release_memory_sqlite3_strnicmp_enum];
)

// Rules for db_status (1 valid functions, 0 excluded)
// Rule: .db_status = sqlite3_backup_init ==> .db_status_signature = db_status_signatures[db_status_sqlite3_backup_init_enum];
@transform_db_status_sqlite3_backup_init@
expression E;
identifier FP_NAME = db_status;
identifier FUNC_NAME = sqlite3_backup_init;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.db_status_signature = db_status_signatures[db_status_sqlite3_backup_init_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.db_status_signature = db_status_signatures[db_status_sqlite3_backup_init_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->db_status_signature = db_status_signatures[db_status_sqlite3_backup_init_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->db_status_signature = db_status_signatures[db_status_sqlite3_backup_init_enum];
)

// Rules for declare_vtab (1 valid functions, 0 excluded)
// Rule: .declare_vtab = sqlite3_db_handle ==> .declare_vtab_signature = declare_vtab_signatures[declare_vtab_sqlite3_db_handle_enum];
@transform_declare_vtab_sqlite3_db_handle@
expression E;
identifier FP_NAME = declare_vtab;
identifier FUNC_NAME = sqlite3_db_handle;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.declare_vtab_signature = declare_vtab_signatures[declare_vtab_sqlite3_db_handle_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.declare_vtab_signature = declare_vtab_signatures[declare_vtab_sqlite3_db_handle_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->declare_vtab_signature = declare_vtab_signatures[declare_vtab_sqlite3_db_handle_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->declare_vtab_signature = declare_vtab_signatures[declare_vtab_sqlite3_db_handle_enum];
)

// Rules for deserialize (1 valid functions, 0 excluded)
// Rule: .deserialize = sqlite3_uri_key ==> .deserialize_signature = deserialize_signatures[deserialize_sqlite3_uri_key_enum];
@transform_deserialize_sqlite3_uri_key@
expression E;
identifier FP_NAME = deserialize;
identifier FUNC_NAME = sqlite3_uri_key;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.deserialize_signature = deserialize_signatures[deserialize_sqlite3_uri_key_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.deserialize_signature = deserialize_signatures[deserialize_sqlite3_uri_key_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->deserialize_signature = deserialize_signatures[deserialize_sqlite3_uri_key_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->deserialize_signature = deserialize_signatures[deserialize_sqlite3_uri_key_enum];
)

// Rules for drop_modules (1 valid functions, 0 excluded)
// Rule: .drop_modules = sqlite3_str_new ==> .drop_modules_signature = drop_modules_signatures[drop_modules_sqlite3_str_new_enum];
@transform_drop_modules_sqlite3_str_new@
expression E;
identifier FP_NAME = drop_modules;
identifier FUNC_NAME = sqlite3_str_new;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.drop_modules_signature = drop_modules_signatures[drop_modules_sqlite3_str_new_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.drop_modules_signature = drop_modules_signatures[drop_modules_sqlite3_str_new_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->drop_modules_signature = drop_modules_signatures[drop_modules_sqlite3_str_new_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->drop_modules_signature = drop_modules_signatures[drop_modules_sqlite3_str_new_enum];
)

// Rules for enable_shared_cache (1 valid functions, 0 excluded)
// Rule: .enable_shared_cache = sqlite3_declare_vtab ==> .enable_shared_cache_signature = enable_shared_cache_signatures[enable_shared_cache_sqlite3_declare_vtab_enum];
@transform_enable_shared_cache_sqlite3_declare_vtab@
expression E;
identifier FP_NAME = enable_shared_cache;
identifier FUNC_NAME = sqlite3_declare_vtab;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.enable_shared_cache_signature = enable_shared_cache_signatures[enable_shared_cache_sqlite3_declare_vtab_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.enable_shared_cache_signature = enable_shared_cache_signatures[enable_shared_cache_sqlite3_declare_vtab_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->enable_shared_cache_signature = enable_shared_cache_signatures[enable_shared_cache_sqlite3_declare_vtab_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->enable_shared_cache_signature = enable_shared_cache_signatures[enable_shared_cache_sqlite3_declare_vtab_enum];
)

// Rules for errcode (1 valid functions, 0 excluded)
// Rule: .errcode = sqlite3_enable_shared_cache ==> .errcode_signature = errcode_signatures[errcode_sqlite3_enable_shared_cache_enum];
@transform_errcode_sqlite3_enable_shared_cache@
expression E;
identifier FP_NAME = errcode;
identifier FUNC_NAME = sqlite3_enable_shared_cache;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.errcode_signature = errcode_signatures[errcode_sqlite3_enable_shared_cache_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.errcode_signature = errcode_signatures[errcode_sqlite3_enable_shared_cache_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->errcode_signature = errcode_signatures[errcode_sqlite3_enable_shared_cache_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->errcode_signature = errcode_signatures[errcode_sqlite3_enable_shared_cache_enum];
)

// Rules for errmsg (1 valid functions, 0 excluded)
// Rule: .errmsg = sqlite3_errcode ==> .errmsg_signature = errmsg_signatures[errmsg_sqlite3_errcode_enum];
@transform_errmsg_sqlite3_errcode@
expression E;
identifier FP_NAME = errmsg;
identifier FUNC_NAME = sqlite3_errcode;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.errmsg_signature = errmsg_signatures[errmsg_sqlite3_errcode_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.errmsg_signature = errmsg_signatures[errmsg_sqlite3_errcode_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->errmsg_signature = errmsg_signatures[errmsg_sqlite3_errcode_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->errmsg_signature = errmsg_signatures[errmsg_sqlite3_errcode_enum];
)

// Rules for errmsg16 (1 valid functions, 0 excluded)
// Rule: .errmsg16 = sqlite3_errmsg ==> .errmsg16_signature = errmsg16_signatures[errmsg16_sqlite3_errmsg_enum];
@transform_errmsg16_sqlite3_errmsg@
expression E;
identifier FP_NAME = errmsg16;
identifier FUNC_NAME = sqlite3_errmsg;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.errmsg16_signature = errmsg16_signatures[errmsg16_sqlite3_errmsg_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.errmsg16_signature = errmsg16_signatures[errmsg16_sqlite3_errmsg_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->errmsg16_signature = errmsg16_signatures[errmsg16_sqlite3_errmsg_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->errmsg16_signature = errmsg16_signatures[errmsg16_sqlite3_errmsg_enum];
)

// Rules for exec (1 valid functions, 0 excluded)
// Rule: .exec = sqlite3_errmsg16 ==> .exec_signature = exec_signatures[exec_sqlite3_errmsg16_enum];
@transform_exec_sqlite3_errmsg16@
expression E;
identifier FP_NAME = exec;
identifier FUNC_NAME = sqlite3_errmsg16;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.exec_signature = exec_signatures[exec_sqlite3_errmsg16_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.exec_signature = exec_signatures[exec_sqlite3_errmsg16_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->exec_signature = exec_signatures[exec_sqlite3_errmsg16_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->exec_signature = exec_signatures[exec_sqlite3_errmsg16_enum];
)

// Rules for expanded_sql (1 valid functions, 0 excluded)
// Rule: .expanded_sql = sqlite3_reset_auto_extension ==> .expanded_sql_signature = expanded_sql_signatures[expanded_sql_sqlite3_reset_auto_extension_enum];
@transform_expanded_sql_sqlite3_reset_auto_extension@
expression E;
identifier FP_NAME = expanded_sql;
identifier FUNC_NAME = sqlite3_reset_auto_extension;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.expanded_sql_signature = expanded_sql_signatures[expanded_sql_sqlite3_reset_auto_extension_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.expanded_sql_signature = expanded_sql_signatures[expanded_sql_sqlite3_reset_auto_extension_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->expanded_sql_signature = expanded_sql_signatures[expanded_sql_sqlite3_reset_auto_extension_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->expanded_sql_signature = expanded_sql_signatures[expanded_sql_sqlite3_reset_auto_extension_enum];
)

// Rules for expired (2 valid functions, 0 excluded)
// Rule: .expired = 0 ==> .expired_signature = expired_signatures[expired_0_enum];
@transform_expired_0@
expression E;
identifier FP_NAME = expired;
@@
(
E.FP_NAME = 0;
+ E.expired_signature = expired_signatures[expired_0_enum];
|
E->FP_NAME = 0;
+ E->expired_signature = expired_signatures[expired_0_enum];
)

// Rule: .expired = sqlite3_exec ==> .expired_signature = expired_signatures[expired_sqlite3_exec_enum];
@transform_expired_sqlite3_exec@
expression E;
identifier FP_NAME = expired;
identifier FUNC_NAME = sqlite3_exec;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.expired_signature = expired_signatures[expired_sqlite3_exec_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.expired_signature = expired_signatures[expired_sqlite3_exec_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->expired_signature = expired_signatures[expired_sqlite3_exec_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->expired_signature = expired_signatures[expired_sqlite3_exec_enum];
)

// Rules for extended_errcode (1 valid functions, 0 excluded)
// Rule: .extended_errcode = sqlite3_backup_pagecount ==> .extended_errcode_signature = extended_errcode_signatures[extended_errcode_sqlite3_backup_pagecount_enum];
@transform_extended_errcode_sqlite3_backup_pagecount@
expression E;
identifier FP_NAME = extended_errcode;
identifier FUNC_NAME = sqlite3_backup_pagecount;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.extended_errcode_signature = extended_errcode_signatures[extended_errcode_sqlite3_backup_pagecount_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.extended_errcode_signature = extended_errcode_signatures[extended_errcode_sqlite3_backup_pagecount_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->extended_errcode_signature = extended_errcode_signatures[extended_errcode_sqlite3_backup_pagecount_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->extended_errcode_signature = extended_errcode_signatures[extended_errcode_sqlite3_backup_pagecount_enum];
)

// Rules for extended_result_codes (1 valid functions, 0 excluded)
// Rule: .extended_result_codes = sqlite3_vfs_find ==> .extended_result_codes_signature = extended_result_codes_signatures[extended_result_codes_sqlite3_vfs_find_enum];
@transform_extended_result_codes_sqlite3_vfs_find@
expression E;
identifier FP_NAME = extended_result_codes;
identifier FUNC_NAME = sqlite3_vfs_find;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.extended_result_codes_signature = extended_result_codes_signatures[extended_result_codes_sqlite3_vfs_find_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.extended_result_codes_signature = extended_result_codes_signatures[extended_result_codes_sqlite3_vfs_find_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->extended_result_codes_signature = extended_result_codes_signatures[extended_result_codes_sqlite3_vfs_find_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->extended_result_codes_signature = extended_result_codes_signatures[extended_result_codes_sqlite3_vfs_find_enum];
)

// Rules for file_control (1 valid functions, 0 excluded)
// Rule: .file_control = sqlite3_blob_open ==> .file_control_signature = file_control_signatures[file_control_sqlite3_blob_open_enum];
@transform_file_control_sqlite3_blob_open@
expression E;
identifier FP_NAME = file_control;
identifier FUNC_NAME = sqlite3_blob_open;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.file_control_signature = file_control_signatures[file_control_sqlite3_blob_open_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.file_control_signature = file_control_signatures[file_control_sqlite3_blob_open_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->file_control_signature = file_control_signatures[file_control_sqlite3_blob_open_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->file_control_signature = file_control_signatures[file_control_sqlite3_blob_open_enum];
)

// Rules for filename_database (1 valid functions, 0 excluded)
// Rule: .filename_database = sqlite3_str_vappendf ==> .filename_database_signature = filename_database_signatures[filename_database_sqlite3_str_vappendf_enum];
@transform_filename_database_sqlite3_str_vappendf@
expression E;
identifier FP_NAME = filename_database;
identifier FUNC_NAME = sqlite3_str_vappendf;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.filename_database_signature = filename_database_signatures[filename_database_sqlite3_str_vappendf_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.filename_database_signature = filename_database_signatures[filename_database_sqlite3_str_vappendf_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->filename_database_signature = filename_database_signatures[filename_database_sqlite3_str_vappendf_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->filename_database_signature = filename_database_signatures[filename_database_sqlite3_str_vappendf_enum];
)

// Rules for filename_journal (1 valid functions, 0 excluded)
// Rule: .filename_journal = sqlite3_str_append ==> .filename_journal_signature = filename_journal_signatures[filename_journal_sqlite3_str_append_enum];
@transform_filename_journal_sqlite3_str_append@
expression E;
identifier FP_NAME = filename_journal;
identifier FUNC_NAME = sqlite3_str_append;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.filename_journal_signature = filename_journal_signatures[filename_journal_sqlite3_str_append_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.filename_journal_signature = filename_journal_signatures[filename_journal_sqlite3_str_append_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->filename_journal_signature = filename_journal_signatures[filename_journal_sqlite3_str_append_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->filename_journal_signature = filename_journal_signatures[filename_journal_sqlite3_str_append_enum];
)

// Rules for filename_wal (1 valid functions, 0 excluded)
// Rule: .filename_wal = sqlite3_str_appendall ==> .filename_wal_signature = filename_wal_signatures[filename_wal_sqlite3_str_appendall_enum];
@transform_filename_wal_sqlite3_str_appendall@
expression E;
identifier FP_NAME = filename_wal;
identifier FUNC_NAME = sqlite3_str_appendall;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.filename_wal_signature = filename_wal_signatures[filename_wal_sqlite3_str_appendall_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.filename_wal_signature = filename_wal_signatures[filename_wal_sqlite3_str_appendall_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->filename_wal_signature = filename_wal_signatures[filename_wal_sqlite3_str_appendall_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->filename_wal_signature = filename_wal_signatures[filename_wal_sqlite3_str_appendall_enum];
)

// Rules for free_filename (1 valid functions, 0 excluded)
// Rule: .free_filename = sqlite3_str_reset ==> .free_filename_signature = free_filename_signatures[free_filename_sqlite3_str_reset_enum];
@transform_free_filename_sqlite3_str_reset@
expression E;
identifier FP_NAME = free_filename;
identifier FUNC_NAME = sqlite3_str_reset;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.free_filename_signature = free_filename_signatures[free_filename_sqlite3_str_reset_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.free_filename_signature = free_filename_signatures[free_filename_sqlite3_str_reset_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->free_filename_signature = free_filename_signatures[free_filename_sqlite3_str_reset_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->free_filename_signature = free_filename_signatures[free_filename_sqlite3_str_reset_enum];
)

// Rules for get_autocommit (1 valid functions, 0 excluded)
// Rule: .get_autocommit = sqlite3_free ==> .get_autocommit_signature = get_autocommit_signatures[get_autocommit_sqlite3_free_enum];
@transform_get_autocommit_sqlite3_free@
expression E;
identifier FP_NAME = get_autocommit;
identifier FUNC_NAME = sqlite3_free;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.get_autocommit_signature = get_autocommit_signatures[get_autocommit_sqlite3_free_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.get_autocommit_signature = get_autocommit_signatures[get_autocommit_sqlite3_free_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->get_autocommit_signature = get_autocommit_signatures[get_autocommit_sqlite3_free_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->get_autocommit_signature = get_autocommit_signatures[get_autocommit_sqlite3_free_enum];
)

// Rules for get_auxdata (1 valid functions, 0 excluded)
// Rule: .get_auxdata = sqlite3_free_table ==> .get_auxdata_signature = get_auxdata_signatures[get_auxdata_sqlite3_free_table_enum];
@transform_get_auxdata_sqlite3_free_table@
expression E;
identifier FP_NAME = get_auxdata;
identifier FUNC_NAME = sqlite3_free_table;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.get_auxdata_signature = get_auxdata_signatures[get_auxdata_sqlite3_free_table_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.get_auxdata_signature = get_auxdata_signatures[get_auxdata_sqlite3_free_table_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->get_auxdata_signature = get_auxdata_signatures[get_auxdata_sqlite3_free_table_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->get_auxdata_signature = get_auxdata_signatures[get_auxdata_sqlite3_free_table_enum];
)

// Rules for get_clientdata (1 valid functions, 0 excluded)
// Rule: .get_clientdata = sqlite3_database_file_object ==> .get_clientdata_signature = get_clientdata_signatures[get_clientdata_sqlite3_database_file_object_enum];
@transform_get_clientdata_sqlite3_database_file_object@
expression E;
identifier FP_NAME = get_clientdata;
identifier FUNC_NAME = sqlite3_database_file_object;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.get_clientdata_signature = get_clientdata_signatures[get_clientdata_sqlite3_database_file_object_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.get_clientdata_signature = get_clientdata_signatures[get_clientdata_sqlite3_database_file_object_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->get_clientdata_signature = get_clientdata_signatures[get_clientdata_sqlite3_database_file_object_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->get_clientdata_signature = get_clientdata_signatures[get_clientdata_sqlite3_database_file_object_enum];
)

// Rules for get_table (1 valid functions, 0 excluded)
// Rule: .get_table = sqlite3_get_autocommit ==> .get_table_signature = get_table_signatures[get_table_sqlite3_get_autocommit_enum];
@transform_get_table_sqlite3_get_autocommit@
expression E;
identifier FP_NAME = get_table;
identifier FUNC_NAME = sqlite3_get_autocommit;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.get_table_signature = get_table_signatures[get_table_sqlite3_get_autocommit_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.get_table_signature = get_table_signatures[get_table_sqlite3_get_autocommit_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->get_table_signature = get_table_signatures[get_table_sqlite3_get_autocommit_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->get_table_signature = get_table_signatures[get_table_sqlite3_get_autocommit_enum];
)

// Rules for global_recover (1 valid functions, 0 excluded)
// Rule: .global_recover = sqlite3_get_auxdata ==> .global_recover_signature = global_recover_signatures[global_recover_sqlite3_get_auxdata_enum];
@transform_global_recover_sqlite3_get_auxdata@
expression E;
identifier FP_NAME = global_recover;
identifier FUNC_NAME = sqlite3_get_auxdata;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.global_recover_signature = global_recover_signatures[global_recover_sqlite3_get_auxdata_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.global_recover_signature = global_recover_signatures[global_recover_sqlite3_get_auxdata_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->global_recover_signature = global_recover_signatures[global_recover_sqlite3_get_auxdata_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->global_recover_signature = global_recover_signatures[global_recover_sqlite3_get_auxdata_enum];
)

// Rules for hard_heap_limit64 (1 valid functions, 0 excluded)
// Rule: .hard_heap_limit64 = sqlite3_str_finish ==> .hard_heap_limit64_signature = hard_heap_limit64_signatures[hard_heap_limit64_sqlite3_str_finish_enum];
@transform_hard_heap_limit64_sqlite3_str_finish@
expression E;
identifier FP_NAME = hard_heap_limit64;
identifier FUNC_NAME = sqlite3_str_finish;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.hard_heap_limit64_signature = hard_heap_limit64_signatures[hard_heap_limit64_sqlite3_str_finish_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.hard_heap_limit64_signature = hard_heap_limit64_signatures[hard_heap_limit64_sqlite3_str_finish_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->hard_heap_limit64_signature = hard_heap_limit64_signatures[hard_heap_limit64_sqlite3_str_finish_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->hard_heap_limit64_signature = hard_heap_limit64_signatures[hard_heap_limit64_sqlite3_str_finish_enum];
)

// Rules for interruptx (1 valid functions, 0 excluded)
// Rule: .interruptx = sqlite3_get_table ==> .interruptx_signature = interruptx_signatures[interruptx_sqlite3_get_table_enum];
@transform_interruptx_sqlite3_get_table@
expression E;
identifier FP_NAME = interruptx;
identifier FUNC_NAME = sqlite3_get_table;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.interruptx_signature = interruptx_signatures[interruptx_sqlite3_get_table_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.interruptx_signature = interruptx_signatures[interruptx_sqlite3_get_table_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->interruptx_signature = interruptx_signatures[interruptx_sqlite3_get_table_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->interruptx_signature = interruptx_signatures[interruptx_sqlite3_get_table_enum];
)

// Rules for is_interrupted (1 valid functions, 0 excluded)
// Rule: .is_interrupted = sqlite3_create_filename ==> .is_interrupted_signature = is_interrupted_signatures[is_interrupted_sqlite3_create_filename_enum];
@transform_is_interrupted_sqlite3_create_filename@
expression E;
identifier FP_NAME = is_interrupted;
identifier FUNC_NAME = sqlite3_create_filename;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.is_interrupted_signature = is_interrupted_signatures[is_interrupted_sqlite3_create_filename_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.is_interrupted_signature = is_interrupted_signatures[is_interrupted_sqlite3_create_filename_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->is_interrupted_signature = is_interrupted_signatures[is_interrupted_sqlite3_create_filename_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->is_interrupted_signature = is_interrupted_signatures[is_interrupted_sqlite3_create_filename_enum];
)

// Rules for keyword_check (1 valid functions, 0 excluded)
// Rule: .keyword_check = sqlite3_db_cacheflush ==> .keyword_check_signature = keyword_check_signatures[keyword_check_sqlite3_db_cacheflush_enum];
@transform_keyword_check_sqlite3_db_cacheflush@
expression E;
identifier FP_NAME = keyword_check;
identifier FUNC_NAME = sqlite3_db_cacheflush;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.keyword_check_signature = keyword_check_signatures[keyword_check_sqlite3_db_cacheflush_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.keyword_check_signature = keyword_check_signatures[keyword_check_sqlite3_db_cacheflush_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->keyword_check_signature = keyword_check_signatures[keyword_check_sqlite3_db_cacheflush_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->keyword_check_signature = keyword_check_signatures[keyword_check_sqlite3_db_cacheflush_enum];
)

// Rules for keyword_count (1 valid functions, 0 excluded)
// Rule: .keyword_count = sqlite3_status64 ==> .keyword_count_signature = keyword_count_signatures[keyword_count_sqlite3_status64_enum];
@transform_keyword_count_sqlite3_status64@
expression E;
identifier FP_NAME = keyword_count;
identifier FUNC_NAME = sqlite3_status64;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.keyword_count_signature = keyword_count_signatures[keyword_count_sqlite3_status64_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.keyword_count_signature = keyword_count_signatures[keyword_count_sqlite3_status64_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->keyword_count_signature = keyword_count_signatures[keyword_count_sqlite3_status64_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->keyword_count_signature = keyword_count_signatures[keyword_count_sqlite3_status64_enum];
)

// Rules for keyword_name (1 valid functions, 0 excluded)
// Rule: .keyword_name = sqlite3_strlike ==> .keyword_name_signature = keyword_name_signatures[keyword_name_sqlite3_strlike_enum];
@transform_keyword_name_sqlite3_strlike@
expression E;
identifier FP_NAME = keyword_name;
identifier FUNC_NAME = sqlite3_strlike;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.keyword_name_signature = keyword_name_signatures[keyword_name_sqlite3_strlike_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.keyword_name_signature = keyword_name_signatures[keyword_name_sqlite3_strlike_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->keyword_name_signature = keyword_name_signatures[keyword_name_sqlite3_strlike_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->keyword_name_signature = keyword_name_signatures[keyword_name_sqlite3_strlike_enum];
)

// Rules for libversion (1 valid functions, 0 excluded)
// Rule: .libversion = sqlite3_interrupt ==> .libversion_signature = libversion_signatures[libversion_sqlite3_interrupt_enum];
@transform_libversion_sqlite3_interrupt@
expression E;
identifier FP_NAME = libversion;
identifier FUNC_NAME = sqlite3_interrupt;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.libversion_signature = libversion_signatures[libversion_sqlite3_interrupt_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.libversion_signature = libversion_signatures[libversion_sqlite3_interrupt_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->libversion_signature = libversion_signatures[libversion_sqlite3_interrupt_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->libversion_signature = libversion_signatures[libversion_sqlite3_interrupt_enum];
)

// Rules for libversion_number (1 valid functions, 0 excluded)
// Rule: .libversion_number = sqlite3_last_insert_rowid ==> .libversion_number_signature = libversion_number_signatures[libversion_number_sqlite3_last_insert_rowid_enum];
@transform_libversion_number_sqlite3_last_insert_rowid@
expression E;
identifier FP_NAME = libversion_number;
identifier FUNC_NAME = sqlite3_last_insert_rowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.libversion_number_signature = libversion_number_signatures[libversion_number_sqlite3_last_insert_rowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.libversion_number_signature = libversion_number_signatures[libversion_number_sqlite3_last_insert_rowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->libversion_number_signature = libversion_number_signatures[libversion_number_sqlite3_last_insert_rowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->libversion_number_signature = libversion_number_signatures[libversion_number_sqlite3_last_insert_rowid_enum];
)

// Rules for limit (1 valid functions, 0 excluded)
// Rule: .limit = sqlite3_vfs_register ==> .limit_signature = limit_signatures[limit_sqlite3_vfs_register_enum];
@transform_limit_sqlite3_vfs_register@
expression E;
identifier FP_NAME = limit;
identifier FUNC_NAME = sqlite3_vfs_register;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.limit_signature = limit_signatures[limit_sqlite3_vfs_register_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.limit_signature = limit_signatures[limit_sqlite3_vfs_register_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->limit_signature = limit_signatures[limit_sqlite3_vfs_register_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->limit_signature = limit_signatures[limit_sqlite3_vfs_register_enum];
)

// Rules for load_extension (1 valid functions, 0 excluded)
// Rule: .load_extension = sqlite3_db_readonly ==> .load_extension_signature = load_extension_signatures[load_extension_sqlite3_db_readonly_enum];
@transform_load_extension_sqlite3_db_readonly@
expression E;
identifier FP_NAME = load_extension;
identifier FUNC_NAME = sqlite3_db_readonly;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.load_extension_signature = load_extension_signatures[load_extension_sqlite3_db_readonly_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.load_extension_signature = load_extension_signatures[load_extension_sqlite3_db_readonly_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->load_extension_signature = load_extension_signatures[load_extension_sqlite3_db_readonly_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->load_extension_signature = load_extension_signatures[load_extension_sqlite3_db_readonly_enum];
)

// Rules for log (1 valid functions, 0 excluded)
// Rule: .log = sqlite3_backup_remaining ==> .log_signature = log_signatures[log_sqlite3_backup_remaining_enum];
@transform_log_sqlite3_backup_remaining@
expression E;
identifier FP_NAME = log;
identifier FUNC_NAME = sqlite3_backup_remaining;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.log_signature = log_signatures[log_sqlite3_backup_remaining_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.log_signature = log_signatures[log_sqlite3_backup_remaining_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->log_signature = log_signatures[log_sqlite3_backup_remaining_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->log_signature = log_signatures[log_sqlite3_backup_remaining_enum];
)

// Rules for malloc (1 valid functions, 0 excluded)
// Rule: .malloc = sqlite3_libversion ==> .malloc_signature = malloc_signatures[malloc_sqlite3_libversion_enum];
@transform_malloc_sqlite3_libversion@
expression E;
identifier FP_NAME = malloc;
identifier FUNC_NAME = sqlite3_libversion;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.malloc_signature = malloc_signatures[malloc_sqlite3_libversion_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.malloc_signature = malloc_signatures[malloc_sqlite3_libversion_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->malloc_signature = malloc_signatures[malloc_sqlite3_libversion_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->malloc_signature = malloc_signatures[malloc_sqlite3_libversion_enum];
)

// Rules for malloc64 (1 valid functions, 0 excluded)
// Rule: .malloc64 = sqlite3_db_release_memory ==> .malloc64_signature = malloc64_signatures[malloc64_sqlite3_db_release_memory_enum];
@transform_malloc64_sqlite3_db_release_memory@
expression E;
identifier FP_NAME = malloc64;
identifier FUNC_NAME = sqlite3_db_release_memory;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.malloc64_signature = malloc64_signatures[malloc64_sqlite3_db_release_memory_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.malloc64_signature = malloc64_signatures[malloc64_sqlite3_db_release_memory_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->malloc64_signature = malloc64_signatures[malloc64_sqlite3_db_release_memory_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->malloc64_signature = malloc64_signatures[malloc64_sqlite3_db_release_memory_enum];
)

// Rules for memory_highwater (1 valid functions, 0 excluded)
// Rule: .memory_highwater = sqlite3_blob_read ==> .memory_highwater_signature = memory_highwater_signatures[memory_highwater_sqlite3_blob_read_enum];
@transform_memory_highwater_sqlite3_blob_read@
expression E;
identifier FP_NAME = memory_highwater;
identifier FUNC_NAME = sqlite3_blob_read;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.memory_highwater_signature = memory_highwater_signatures[memory_highwater_sqlite3_blob_read_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.memory_highwater_signature = memory_highwater_signatures[memory_highwater_sqlite3_blob_read_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->memory_highwater_signature = memory_highwater_signatures[memory_highwater_sqlite3_blob_read_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->memory_highwater_signature = memory_highwater_signatures[memory_highwater_sqlite3_blob_read_enum];
)

// Rules for memory_used (1 valid functions, 0 excluded)
// Rule: .memory_used = sqlite3_blob_write ==> .memory_used_signature = memory_used_signatures[memory_used_sqlite3_blob_write_enum];
@transform_memory_used_sqlite3_blob_write@
expression E;
identifier FP_NAME = memory_used;
identifier FUNC_NAME = sqlite3_blob_write;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.memory_used_signature = memory_used_signatures[memory_used_sqlite3_blob_write_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.memory_used_signature = memory_used_signatures[memory_used_sqlite3_blob_write_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->memory_used_signature = memory_used_signatures[memory_used_sqlite3_blob_write_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->memory_used_signature = memory_used_signatures[memory_used_sqlite3_blob_write_enum];
)

// Rules for mprintf (1 valid functions, 0 excluded)
// Rule: .mprintf = sqlite3_libversion_number ==> .mprintf_signature = mprintf_signatures[mprintf_sqlite3_libversion_number_enum];
@transform_mprintf_sqlite3_libversion_number@
expression E;
identifier FP_NAME = mprintf;
identifier FUNC_NAME = sqlite3_libversion_number;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.mprintf_signature = mprintf_signatures[mprintf_sqlite3_libversion_number_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.mprintf_signature = mprintf_signatures[mprintf_sqlite3_libversion_number_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->mprintf_signature = mprintf_signatures[mprintf_sqlite3_libversion_number_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->mprintf_signature = mprintf_signatures[mprintf_sqlite3_libversion_number_enum];
)

// Rules for msize (1 valid functions, 0 excluded)
// Rule: .msize = sqlite3_errstr ==> .msize_signature = msize_signatures[msize_sqlite3_errstr_enum];
@transform_msize_sqlite3_errstr@
expression E;
identifier FP_NAME = msize;
identifier FUNC_NAME = sqlite3_errstr;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.msize_signature = msize_signatures[msize_sqlite3_errstr_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.msize_signature = msize_signatures[msize_sqlite3_errstr_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->msize_signature = msize_signatures[msize_sqlite3_errstr_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->msize_signature = msize_signatures[msize_sqlite3_errstr_enum];
)

// Rules for mutex_alloc (1 valid functions, 0 excluded)
// Rule: .mutex_alloc = sqlite3_create_collation_v2 ==> .mutex_alloc_signature = mutex_alloc_signatures[mutex_alloc_sqlite3_create_collation_v2_enum];
@transform_mutex_alloc_sqlite3_create_collation_v2@
expression E;
identifier FP_NAME = mutex_alloc;
identifier FUNC_NAME = sqlite3_create_collation_v2;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.mutex_alloc_signature = mutex_alloc_signatures[mutex_alloc_sqlite3_create_collation_v2_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.mutex_alloc_signature = mutex_alloc_signatures[mutex_alloc_sqlite3_create_collation_v2_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->mutex_alloc_signature = mutex_alloc_signatures[mutex_alloc_sqlite3_create_collation_v2_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->mutex_alloc_signature = mutex_alloc_signatures[mutex_alloc_sqlite3_create_collation_v2_enum];
)

// Rules for mutex_enter (1 valid functions, 0 excluded)
// Rule: .mutex_enter = sqlite3_file_control ==> .mutex_enter_signature = mutex_enter_signatures[mutex_enter_sqlite3_file_control_enum];
@transform_mutex_enter_sqlite3_file_control@
expression E;
identifier FP_NAME = mutex_enter;
identifier FUNC_NAME = sqlite3_file_control;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.mutex_enter_signature = mutex_enter_signatures[mutex_enter_sqlite3_file_control_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.mutex_enter_signature = mutex_enter_signatures[mutex_enter_sqlite3_file_control_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->mutex_enter_signature = mutex_enter_signatures[mutex_enter_sqlite3_file_control_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->mutex_enter_signature = mutex_enter_signatures[mutex_enter_sqlite3_file_control_enum];
)

// Rules for mutex_free (1 valid functions, 0 excluded)
// Rule: .mutex_free = sqlite3_memory_highwater ==> .mutex_free_signature = mutex_free_signatures[mutex_free_sqlite3_memory_highwater_enum];
@transform_mutex_free_sqlite3_memory_highwater@
expression E;
identifier FP_NAME = mutex_free;
identifier FUNC_NAME = sqlite3_memory_highwater;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.mutex_free_signature = mutex_free_signatures[mutex_free_sqlite3_memory_highwater_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.mutex_free_signature = mutex_free_signatures[mutex_free_sqlite3_memory_highwater_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->mutex_free_signature = mutex_free_signatures[mutex_free_sqlite3_memory_highwater_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->mutex_free_signature = mutex_free_signatures[mutex_free_sqlite3_memory_highwater_enum];
)

// Rules for mutex_leave (1 valid functions, 0 excluded)
// Rule: .mutex_leave = sqlite3_memory_used ==> .mutex_leave_signature = mutex_leave_signatures[mutex_leave_sqlite3_memory_used_enum];
@transform_mutex_leave_sqlite3_memory_used@
expression E;
identifier FP_NAME = mutex_leave;
identifier FUNC_NAME = sqlite3_memory_used;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.mutex_leave_signature = mutex_leave_signatures[mutex_leave_sqlite3_memory_used_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.mutex_leave_signature = mutex_leave_signatures[mutex_leave_sqlite3_memory_used_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->mutex_leave_signature = mutex_leave_signatures[mutex_leave_sqlite3_memory_used_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->mutex_leave_signature = mutex_leave_signatures[mutex_leave_sqlite3_memory_used_enum];
)

// Rules for next_stmt (1 valid functions, 0 excluded)
// Rule: .next_stmt = sqlite3_vfs_unregister ==> .next_stmt_signature = next_stmt_signatures[next_stmt_sqlite3_vfs_unregister_enum];
@transform_next_stmt_sqlite3_vfs_unregister@
expression E;
identifier FP_NAME = next_stmt;
identifier FUNC_NAME = sqlite3_vfs_unregister;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.next_stmt_signature = next_stmt_signatures[next_stmt_sqlite3_vfs_unregister_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.next_stmt_signature = next_stmt_signatures[next_stmt_sqlite3_vfs_unregister_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->next_stmt_signature = next_stmt_signatures[next_stmt_sqlite3_vfs_unregister_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->next_stmt_signature = next_stmt_signatures[next_stmt_sqlite3_vfs_unregister_enum];
)

// Rules for normalized_sql (1 valid functions, 0 excluded)
// Rule: .normalized_sql = sqlite3_keyword_count ==> .normalized_sql_signature = normalized_sql_signatures[normalized_sql_sqlite3_keyword_count_enum];
@transform_normalized_sql_sqlite3_keyword_count@
expression E;
identifier FP_NAME = normalized_sql;
identifier FUNC_NAME = sqlite3_keyword_count;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.normalized_sql_signature = normalized_sql_signatures[normalized_sql_sqlite3_keyword_count_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.normalized_sql_signature = normalized_sql_signatures[normalized_sql_sqlite3_keyword_count_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->normalized_sql_signature = normalized_sql_signatures[normalized_sql_sqlite3_keyword_count_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->normalized_sql_signature = normalized_sql_signatures[normalized_sql_sqlite3_keyword_count_enum];
)

// Rules for open (1 valid functions, 0 excluded)
// Rule: .open = sqlite3_malloc ==> .open_signature = open_signatures[open_sqlite3_malloc_enum];
@transform_open_sqlite3_malloc@
expression E;
identifier FP_NAME = open;
identifier FUNC_NAME = sqlite3_malloc;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.open_signature = open_signatures[open_sqlite3_malloc_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.open_signature = open_signatures[open_sqlite3_malloc_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->open_signature = open_signatures[open_sqlite3_malloc_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->open_signature = open_signatures[open_sqlite3_malloc_enum];
)

// Rules for open16 (1 valid functions, 0 excluded)
// Rule: .open16 = sqlite3_mprintf ==> .open16_signature = open16_signatures[open16_sqlite3_mprintf_enum];
@transform_open16_sqlite3_mprintf@
expression E;
identifier FP_NAME = open16;
identifier FUNC_NAME = sqlite3_mprintf;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.open16_signature = open16_signatures[open16_sqlite3_mprintf_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.open16_signature = open16_signatures[open16_sqlite3_mprintf_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->open16_signature = open16_signatures[open16_sqlite3_mprintf_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->open16_signature = open16_signatures[open16_sqlite3_mprintf_enum];
)

// Rules for overload_function (1 valid functions, 0 excluded)
// Rule: .overload_function = sqlite3_value_text16be ==> .overload_function_signature = overload_function_signatures[overload_function_sqlite3_value_text16be_enum];
@transform_overload_function_sqlite3_value_text16be@
expression E;
identifier FP_NAME = overload_function;
identifier FUNC_NAME = sqlite3_value_text16be;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.overload_function_signature = overload_function_signatures[overload_function_sqlite3_value_text16be_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.overload_function_signature = overload_function_signatures[overload_function_sqlite3_value_text16be_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->overload_function_signature = overload_function_signatures[overload_function_sqlite3_value_text16be_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->overload_function_signature = overload_function_signatures[overload_function_sqlite3_value_text16be_enum];
)

// Rules for prepare (1 valid functions, 0 excluded)
// Rule: .prepare = sqlite3_open ==> .prepare_signature = prepare_signatures[prepare_sqlite3_open_enum];
@transform_prepare_sqlite3_open@
expression E;
identifier FP_NAME = prepare;
identifier FUNC_NAME = sqlite3_open;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.prepare_signature = prepare_signatures[prepare_sqlite3_open_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.prepare_signature = prepare_signatures[prepare_sqlite3_open_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->prepare_signature = prepare_signatures[prepare_sqlite3_open_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->prepare_signature = prepare_signatures[prepare_sqlite3_open_enum];
)

// Rules for prepare16 (1 valid functions, 0 excluded)
// Rule: .prepare16 = sqlite3_open16 ==> .prepare16_signature = prepare16_signatures[prepare16_sqlite3_open16_enum];
@transform_prepare16_sqlite3_open16@
expression E;
identifier FP_NAME = prepare16;
identifier FUNC_NAME = sqlite3_open16;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.prepare16_signature = prepare16_signatures[prepare16_sqlite3_open16_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.prepare16_signature = prepare16_signatures[prepare16_sqlite3_open16_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->prepare16_signature = prepare16_signatures[prepare16_sqlite3_open16_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->prepare16_signature = prepare16_signatures[prepare16_sqlite3_open16_enum];
)

// Rules for prepare16_v2 (1 valid functions, 0 excluded)
// Rule: .prepare16_v2 = sqlite3_value_type ==> .prepare16_v2_signature = prepare16_v2_signatures[prepare16_v2_sqlite3_value_type_enum];
@transform_prepare16_v2_sqlite3_value_type@
expression E;
identifier FP_NAME = prepare16_v2;
identifier FUNC_NAME = sqlite3_value_type;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.prepare16_v2_signature = prepare16_v2_signatures[prepare16_v2_sqlite3_value_type_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.prepare16_v2_signature = prepare16_v2_signatures[prepare16_v2_sqlite3_value_type_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->prepare16_v2_signature = prepare16_v2_signatures[prepare16_v2_sqlite3_value_type_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->prepare16_v2_signature = prepare16_v2_signatures[prepare16_v2_sqlite3_value_type_enum];
)

// Rules for prepare16_v3 (1 valid functions, 0 excluded)
// Rule: .prepare16_v3 = sqlite3_strglob ==> .prepare16_v3_signature = prepare16_v3_signatures[prepare16_v3_sqlite3_strglob_enum];
@transform_prepare16_v3_sqlite3_strglob@
expression E;
identifier FP_NAME = prepare16_v3;
identifier FUNC_NAME = sqlite3_strglob;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.prepare16_v3_signature = prepare16_v3_signatures[prepare16_v3_sqlite3_strglob_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.prepare16_v3_signature = prepare16_v3_signatures[prepare16_v3_sqlite3_strglob_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->prepare16_v3_signature = prepare16_v3_signatures[prepare16_v3_sqlite3_strglob_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->prepare16_v3_signature = prepare16_v3_signatures[prepare16_v3_sqlite3_strglob_enum];
)

// Rules for prepare_v2 (1 valid functions, 0 excluded)
// Rule: .prepare_v2 = sqlite3_value_text16le ==> .prepare_v2_signature = prepare_v2_signatures[prepare_v2_sqlite3_value_text16le_enum];
@transform_prepare_v2_sqlite3_value_text16le@
expression E;
identifier FP_NAME = prepare_v2;
identifier FUNC_NAME = sqlite3_value_text16le;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.prepare_v2_signature = prepare_v2_signatures[prepare_v2_sqlite3_value_text16le_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.prepare_v2_signature = prepare_v2_signatures[prepare_v2_sqlite3_value_text16le_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->prepare_v2_signature = prepare_v2_signatures[prepare_v2_sqlite3_value_text16le_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->prepare_v2_signature = prepare_v2_signatures[prepare_v2_sqlite3_value_text16le_enum];
)

// Rules for prepare_v3 (1 valid functions, 0 excluded)
// Rule: .prepare_v3 = sqlite3_result_text64 ==> .prepare_v3_signature = prepare_v3_signatures[prepare_v3_sqlite3_result_text64_enum];
@transform_prepare_v3_sqlite3_result_text64@
expression E;
identifier FP_NAME = prepare_v3;
identifier FUNC_NAME = sqlite3_result_text64;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.prepare_v3_signature = prepare_v3_signatures[prepare_v3_sqlite3_result_text64_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.prepare_v3_signature = prepare_v3_signatures[prepare_v3_sqlite3_result_text64_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->prepare_v3_signature = prepare_v3_signatures[prepare_v3_sqlite3_result_text64_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->prepare_v3_signature = prepare_v3_signatures[prepare_v3_sqlite3_result_text64_enum];
)

// Rules for profile (1 valid functions, 0 excluded)
// Rule: .profile = sqlite3_prepare ==> .profile_signature = profile_signatures[profile_sqlite3_prepare_enum];
@transform_profile_sqlite3_prepare@
expression E;
identifier FP_NAME = profile;
identifier FUNC_NAME = sqlite3_prepare;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.profile_signature = profile_signatures[profile_sqlite3_prepare_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.profile_signature = profile_signatures[profile_sqlite3_prepare_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->profile_signature = profile_signatures[profile_sqlite3_prepare_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->profile_signature = profile_signatures[profile_sqlite3_prepare_enum];
)

// Rules for progress_handler (1 valid functions, 0 excluded)
// Rule: .progress_handler = sqlite3_prepare16 ==> .progress_handler_signature = progress_handler_signatures[progress_handler_sqlite3_prepare16_enum];
@transform_progress_handler_sqlite3_prepare16@
expression E;
identifier FP_NAME = progress_handler;
identifier FUNC_NAME = sqlite3_prepare16;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.progress_handler_signature = progress_handler_signatures[progress_handler_sqlite3_prepare16_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.progress_handler_signature = progress_handler_signatures[progress_handler_sqlite3_prepare16_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->progress_handler_signature = progress_handler_signatures[progress_handler_sqlite3_prepare16_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->progress_handler_signature = progress_handler_signatures[progress_handler_sqlite3_prepare16_enum];
)

// Rules for randomness (1 valid functions, 0 excluded)
// Rule: .randomness = sqlite3_sleep ==> .randomness_signature = randomness_signatures[randomness_sqlite3_sleep_enum];
@transform_randomness_sqlite3_sleep@
expression E;
identifier FP_NAME = randomness;
identifier FUNC_NAME = sqlite3_sleep;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.randomness_signature = randomness_signatures[randomness_sqlite3_sleep_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.randomness_signature = randomness_signatures[randomness_sqlite3_sleep_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->randomness_signature = randomness_signatures[randomness_sqlite3_sleep_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->randomness_signature = randomness_signatures[randomness_sqlite3_sleep_enum];
)

// Rules for realloc (1 valid functions, 0 excluded)
// Rule: .realloc = sqlite3_profile ==> .realloc_signature = realloc_signatures[realloc_sqlite3_profile_enum];
@transform_realloc_sqlite3_profile@
expression E;
identifier FP_NAME = realloc;
identifier FUNC_NAME = sqlite3_profile;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.realloc_signature = realloc_signatures[realloc_sqlite3_profile_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.realloc_signature = realloc_signatures[realloc_sqlite3_profile_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->realloc_signature = realloc_signatures[realloc_sqlite3_profile_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->realloc_signature = realloc_signatures[realloc_sqlite3_profile_enum];
)

// Rules for realloc64 (1 valid functions, 0 excluded)
// Rule: .realloc64 = sqlite3_stmt_busy ==> .realloc64_signature = realloc64_signatures[realloc64_sqlite3_stmt_busy_enum];
@transform_realloc64_sqlite3_stmt_busy@
expression E;
identifier FP_NAME = realloc64;
identifier FUNC_NAME = sqlite3_stmt_busy;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.realloc64_signature = realloc64_signatures[realloc64_sqlite3_stmt_busy_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.realloc64_signature = realloc64_signatures[realloc64_sqlite3_stmt_busy_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->realloc64_signature = realloc64_signatures[realloc64_sqlite3_stmt_busy_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->realloc64_signature = realloc64_signatures[realloc64_sqlite3_stmt_busy_enum];
)

// Rules for reset (1 valid functions, 0 excluded)
// Rule: .reset = sqlite3_progress_handler ==> .reset_signature = reset_signatures[reset_sqlite3_progress_handler_enum];
@transform_reset_sqlite3_progress_handler@
expression E;
identifier FP_NAME = reset;
identifier FUNC_NAME = sqlite3_progress_handler;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.reset_signature = reset_signatures[reset_sqlite3_progress_handler_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.reset_signature = reset_signatures[reset_sqlite3_progress_handler_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->reset_signature = reset_signatures[reset_sqlite3_progress_handler_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->reset_signature = reset_signatures[reset_sqlite3_progress_handler_enum];
)

// Rules for reset_auto_extension (1 valid functions, 0 excluded)
// Rule: .reset_auto_extension = sqlite3_stmt_readonly ==> .reset_auto_extension_signature = reset_auto_extension_signatures[reset_auto_extension_sqlite3_stmt_readonly_enum];
@transform_reset_auto_extension_sqlite3_stmt_readonly@
expression E;
identifier FP_NAME = reset_auto_extension;
identifier FUNC_NAME = sqlite3_stmt_readonly;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.reset_auto_extension_signature = reset_auto_extension_signatures[reset_auto_extension_sqlite3_stmt_readonly_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.reset_auto_extension_signature = reset_auto_extension_signatures[reset_auto_extension_sqlite3_stmt_readonly_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->reset_auto_extension_signature = reset_auto_extension_signatures[reset_auto_extension_sqlite3_stmt_readonly_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->reset_auto_extension_signature = reset_auto_extension_signatures[reset_auto_extension_sqlite3_stmt_readonly_enum];
)

// Rules for result_blob (1 valid functions, 0 excluded)
// Rule: .result_blob = sqlite3_realloc ==> .result_blob_signature = result_blob_signatures[result_blob_sqlite3_realloc_enum];
@transform_result_blob_sqlite3_realloc@
expression E;
identifier FP_NAME = result_blob;
identifier FUNC_NAME = sqlite3_realloc;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.result_blob_signature = result_blob_signatures[result_blob_sqlite3_realloc_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.result_blob_signature = result_blob_signatures[result_blob_sqlite3_realloc_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->result_blob_signature = result_blob_signatures[result_blob_sqlite3_realloc_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->result_blob_signature = result_blob_signatures[result_blob_sqlite3_realloc_enum];
)

// Rules for result_blob64 (1 valid functions, 0 excluded)
// Rule: .result_blob64 = sqlite3_stricmp ==> .result_blob64_signature = result_blob64_signatures[result_blob64_sqlite3_stricmp_enum];
@transform_result_blob64_sqlite3_stricmp@
expression E;
identifier FP_NAME = result_blob64;
identifier FUNC_NAME = sqlite3_stricmp;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.result_blob64_signature = result_blob64_signatures[result_blob64_sqlite3_stricmp_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.result_blob64_signature = result_blob64_signatures[result_blob64_sqlite3_stricmp_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->result_blob64_signature = result_blob64_signatures[result_blob64_sqlite3_stricmp_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->result_blob64_signature = result_blob64_signatures[result_blob64_sqlite3_stricmp_enum];
)

// Rules for result_double (1 valid functions, 0 excluded)
// Rule: .result_double = sqlite3_reset ==> .result_double_signature = result_double_signatures[result_double_sqlite3_reset_enum];
@transform_result_double_sqlite3_reset@
expression E;
identifier FP_NAME = result_double;
identifier FUNC_NAME = sqlite3_reset;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.result_double_signature = result_double_signatures[result_double_sqlite3_reset_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.result_double_signature = result_double_signatures[result_double_sqlite3_reset_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->result_double_signature = result_double_signatures[result_double_sqlite3_reset_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->result_double_signature = result_double_signatures[result_double_sqlite3_reset_enum];
)

// Rules for result_error (1 valid functions, 0 excluded)
// Rule: .result_error = sqlite3_result_blob ==> .result_error_signature = result_error_signatures[result_error_sqlite3_result_blob_enum];
@transform_result_error_sqlite3_result_blob@
expression E;
identifier FP_NAME = result_error;
identifier FUNC_NAME = sqlite3_result_blob;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.result_error_signature = result_error_signatures[result_error_sqlite3_result_blob_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.result_error_signature = result_error_signatures[result_error_sqlite3_result_blob_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->result_error_signature = result_error_signatures[result_error_sqlite3_result_blob_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->result_error_signature = result_error_signatures[result_error_sqlite3_result_blob_enum];
)

// Rules for result_error16 (1 valid functions, 0 excluded)
// Rule: .result_error16 = sqlite3_result_double ==> .result_error16_signature = result_error16_signatures[result_error16_sqlite3_result_double_enum];
@transform_result_error16_sqlite3_result_double@
expression E;
identifier FP_NAME = result_error16;
identifier FUNC_NAME = sqlite3_result_double;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.result_error16_signature = result_error16_signatures[result_error16_sqlite3_result_double_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.result_error16_signature = result_error16_signatures[result_error16_sqlite3_result_double_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->result_error16_signature = result_error16_signatures[result_error16_sqlite3_result_double_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->result_error16_signature = result_error16_signatures[result_error16_sqlite3_result_double_enum];
)

// Rules for result_error_code (1 valid functions, 0 excluded)
// Rule: .result_error_code = sqlite3_result_error_nomem ==> .result_error_code_signature = result_error_code_signatures[result_error_code_sqlite3_result_error_nomem_enum];
@transform_result_error_code_sqlite3_result_error_nomem@
expression E;
identifier FP_NAME = result_error_code;
identifier FUNC_NAME = sqlite3_result_error_nomem;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.result_error_code_signature = result_error_code_signatures[result_error_code_sqlite3_result_error_nomem_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.result_error_code_signature = result_error_code_signatures[result_error_code_sqlite3_result_error_nomem_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->result_error_code_signature = result_error_code_signatures[result_error_code_sqlite3_result_error_nomem_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->result_error_code_signature = result_error_code_signatures[result_error_code_sqlite3_result_error_nomem_enum];
)

// Rules for result_int (1 valid functions, 0 excluded)
// Rule: .result_int = sqlite3_result_error ==> .result_int_signature = result_int_signatures[result_int_sqlite3_result_error_enum];
@transform_result_int_sqlite3_result_error@
expression E;
identifier FP_NAME = result_int;
identifier FUNC_NAME = sqlite3_result_error;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.result_int_signature = result_int_signatures[result_int_sqlite3_result_error_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.result_int_signature = result_int_signatures[result_int_sqlite3_result_error_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->result_int_signature = result_int_signatures[result_int_sqlite3_result_error_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->result_int_signature = result_int_signatures[result_int_sqlite3_result_error_enum];
)

// Rules for result_int64 (1 valid functions, 0 excluded)
// Rule: .result_int64 = sqlite3_result_error16 ==> .result_int64_signature = result_int64_signatures[result_int64_sqlite3_result_error16_enum];
@transform_result_int64_sqlite3_result_error16@
expression E;
identifier FP_NAME = result_int64;
identifier FUNC_NAME = sqlite3_result_error16;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.result_int64_signature = result_int64_signatures[result_int64_sqlite3_result_error16_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.result_int64_signature = result_int64_signatures[result_int64_sqlite3_result_error16_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->result_int64_signature = result_int64_signatures[result_int64_sqlite3_result_error16_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->result_int64_signature = result_int64_signatures[result_int64_sqlite3_result_error16_enum];
)

// Rules for result_null (1 valid functions, 0 excluded)
// Rule: .result_null = sqlite3_result_int ==> .result_null_signature = result_null_signatures[result_null_sqlite3_result_int_enum];
@transform_result_null_sqlite3_result_int@
expression E;
identifier FP_NAME = result_null;
identifier FUNC_NAME = sqlite3_result_int;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.result_null_signature = result_null_signatures[result_null_sqlite3_result_int_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.result_null_signature = result_null_signatures[result_null_sqlite3_result_int_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->result_null_signature = result_null_signatures[result_null_sqlite3_result_int_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->result_null_signature = result_null_signatures[result_null_sqlite3_result_int_enum];
)

// Rules for result_pointer (1 valid functions, 0 excluded)
// Rule: .result_pointer = sqlite3_value_free ==> .result_pointer_signature = result_pointer_signatures[result_pointer_sqlite3_value_free_enum];
@transform_result_pointer_sqlite3_value_free@
expression E;
identifier FP_NAME = result_pointer;
identifier FUNC_NAME = sqlite3_value_free;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.result_pointer_signature = result_pointer_signatures[result_pointer_sqlite3_value_free_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.result_pointer_signature = result_pointer_signatures[result_pointer_sqlite3_value_free_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->result_pointer_signature = result_pointer_signatures[result_pointer_sqlite3_value_free_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->result_pointer_signature = result_pointer_signatures[result_pointer_sqlite3_value_free_enum];
)

// Rules for result_subtype (1 valid functions, 0 excluded)
// Rule: .result_subtype = sqlite3_bind_text64 ==> .result_subtype_signature = result_subtype_signatures[result_subtype_sqlite3_bind_text64_enum];
@transform_result_subtype_sqlite3_bind_text64@
expression E;
identifier FP_NAME = result_subtype;
identifier FUNC_NAME = sqlite3_bind_text64;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.result_subtype_signature = result_subtype_signatures[result_subtype_sqlite3_bind_text64_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.result_subtype_signature = result_subtype_signatures[result_subtype_sqlite3_bind_text64_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->result_subtype_signature = result_subtype_signatures[result_subtype_sqlite3_bind_text64_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->result_subtype_signature = result_subtype_signatures[result_subtype_sqlite3_bind_text64_enum];
)

// Rules for result_text (1 valid functions, 0 excluded)
// Rule: .result_text = sqlite3_result_int64 ==> .result_text_signature = result_text_signatures[result_text_sqlite3_result_int64_enum];
@transform_result_text_sqlite3_result_int64@
expression E;
identifier FP_NAME = result_text;
identifier FUNC_NAME = sqlite3_result_int64;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.result_text_signature = result_text_signatures[result_text_sqlite3_result_int64_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.result_text_signature = result_text_signatures[result_text_sqlite3_result_int64_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->result_text_signature = result_text_signatures[result_text_sqlite3_result_int64_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->result_text_signature = result_text_signatures[result_text_sqlite3_result_int64_enum];
)

// Rules for result_text16 (1 valid functions, 0 excluded)
// Rule: .result_text16 = sqlite3_result_null ==> .result_text16_signature = result_text16_signatures[result_text16_sqlite3_result_null_enum];
@transform_result_text16_sqlite3_result_null@
expression E;
identifier FP_NAME = result_text16;
identifier FUNC_NAME = sqlite3_result_null;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.result_text16_signature = result_text16_signatures[result_text16_sqlite3_result_null_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.result_text16_signature = result_text16_signatures[result_text16_sqlite3_result_null_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->result_text16_signature = result_text16_signatures[result_text16_sqlite3_result_null_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->result_text16_signature = result_text16_signatures[result_text16_sqlite3_result_null_enum];
)

// Rules for result_text16be (1 valid functions, 0 excluded)
// Rule: .result_text16be = sqlite3_result_text ==> .result_text16be_signature = result_text16be_signatures[result_text16be_sqlite3_result_text_enum];
@transform_result_text16be_sqlite3_result_text@
expression E;
identifier FP_NAME = result_text16be;
identifier FUNC_NAME = sqlite3_result_text;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.result_text16be_signature = result_text16be_signatures[result_text16be_sqlite3_result_text_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.result_text16be_signature = result_text16be_signatures[result_text16be_sqlite3_result_text_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->result_text16be_signature = result_text16be_signatures[result_text16be_sqlite3_result_text_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->result_text16be_signature = result_text16be_signatures[result_text16be_sqlite3_result_text_enum];
)

// Rules for result_text16le (1 valid functions, 0 excluded)
// Rule: .result_text16le = sqlite3_result_text16 ==> .result_text16le_signature = result_text16le_signatures[result_text16le_sqlite3_result_text16_enum];
@transform_result_text16le_sqlite3_result_text16@
expression E;
identifier FP_NAME = result_text16le;
identifier FUNC_NAME = sqlite3_result_text16;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.result_text16le_signature = result_text16le_signatures[result_text16le_sqlite3_result_text16_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.result_text16le_signature = result_text16le_signatures[result_text16le_sqlite3_result_text16_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->result_text16le_signature = result_text16le_signatures[result_text16le_sqlite3_result_text16_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->result_text16le_signature = result_text16le_signatures[result_text16le_sqlite3_result_text16_enum];
)

// Rules for result_text64 (1 valid functions, 0 excluded)
// Rule: .result_text64 = sqlite3_uri_boolean ==> .result_text64_signature = result_text64_signatures[result_text64_sqlite3_uri_boolean_enum];
@transform_result_text64_sqlite3_uri_boolean@
expression E;
identifier FP_NAME = result_text64;
identifier FUNC_NAME = sqlite3_uri_boolean;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.result_text64_signature = result_text64_signatures[result_text64_sqlite3_uri_boolean_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.result_text64_signature = result_text64_signatures[result_text64_sqlite3_uri_boolean_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->result_text64_signature = result_text64_signatures[result_text64_sqlite3_uri_boolean_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->result_text64_signature = result_text64_signatures[result_text64_sqlite3_uri_boolean_enum];
)

// Rules for result_value (1 valid functions, 0 excluded)
// Rule: .result_value = sqlite3_result_text16be ==> .result_value_signature = result_value_signatures[result_value_sqlite3_result_text16be_enum];
@transform_result_value_sqlite3_result_text16be@
expression E;
identifier FP_NAME = result_value;
identifier FUNC_NAME = sqlite3_result_text16be;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.result_value_signature = result_value_signatures[result_value_sqlite3_result_text16be_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.result_value_signature = result_value_signatures[result_value_sqlite3_result_text16be_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->result_value_signature = result_value_signatures[result_value_sqlite3_result_text16be_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->result_value_signature = result_value_signatures[result_value_sqlite3_result_text16be_enum];
)

// Rules for result_zeroblob (1 valid functions, 0 excluded)
// Rule: .result_zeroblob = sqlite3_release_memory ==> .result_zeroblob_signature = result_zeroblob_signatures[result_zeroblob_sqlite3_release_memory_enum];
@transform_result_zeroblob_sqlite3_release_memory@
expression E;
identifier FP_NAME = result_zeroblob;
identifier FUNC_NAME = sqlite3_release_memory;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.result_zeroblob_signature = result_zeroblob_signatures[result_zeroblob_sqlite3_release_memory_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.result_zeroblob_signature = result_zeroblob_signatures[result_zeroblob_sqlite3_release_memory_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->result_zeroblob_signature = result_zeroblob_signatures[result_zeroblob_sqlite3_release_memory_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->result_zeroblob_signature = result_zeroblob_signatures[result_zeroblob_sqlite3_release_memory_enum];
)

// Rules for result_zeroblob64 (1 valid functions, 0 excluded)
// Rule: .result_zeroblob64 = sqlite3_wal_checkpoint_v2 ==> .result_zeroblob64_signature = result_zeroblob64_signatures[result_zeroblob64_sqlite3_wal_checkpoint_v2_enum];
@transform_result_zeroblob64_sqlite3_wal_checkpoint_v2@
expression E;
identifier FP_NAME = result_zeroblob64;
identifier FUNC_NAME = sqlite3_wal_checkpoint_v2;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.result_zeroblob64_signature = result_zeroblob64_signatures[result_zeroblob64_sqlite3_wal_checkpoint_v2_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.result_zeroblob64_signature = result_zeroblob64_signatures[result_zeroblob64_sqlite3_wal_checkpoint_v2_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->result_zeroblob64_signature = result_zeroblob64_signatures[result_zeroblob64_sqlite3_wal_checkpoint_v2_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->result_zeroblob64_signature = result_zeroblob64_signatures[result_zeroblob64_sqlite3_wal_checkpoint_v2_enum];
)

// Rules for rollback_hook (1 valid functions, 0 excluded)
// Rule: .rollback_hook = sqlite3_result_text16le ==> .rollback_hook_signature = rollback_hook_signatures[rollback_hook_sqlite3_result_text16le_enum];
@transform_rollback_hook_sqlite3_result_text16le@
expression E;
identifier FP_NAME = rollback_hook;
identifier FUNC_NAME = sqlite3_result_text16le;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.rollback_hook_signature = rollback_hook_signatures[rollback_hook_sqlite3_result_text16le_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.rollback_hook_signature = rollback_hook_signatures[rollback_hook_sqlite3_result_text16le_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->rollback_hook_signature = rollback_hook_signatures[rollback_hook_sqlite3_result_text16le_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->rollback_hook_signature = rollback_hook_signatures[rollback_hook_sqlite3_result_text16le_enum];
)

// Rules for serialize (1 valid functions, 0 excluded)
// Rule: .serialize = sqlite3_filename_database ==> .serialize_signature = serialize_signatures[serialize_sqlite3_filename_database_enum];
@transform_serialize_sqlite3_filename_database@
expression E;
identifier FP_NAME = serialize;
identifier FUNC_NAME = sqlite3_filename_database;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.serialize_signature = serialize_signatures[serialize_sqlite3_filename_database_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.serialize_signature = serialize_signatures[serialize_sqlite3_filename_database_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->serialize_signature = serialize_signatures[serialize_sqlite3_filename_database_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->serialize_signature = serialize_signatures[serialize_sqlite3_filename_database_enum];
)

// Rules for set_authorizer (1 valid functions, 0 excluded)
// Rule: .set_authorizer = sqlite3_result_value ==> .set_authorizer_signature = set_authorizer_signatures[set_authorizer_sqlite3_result_value_enum];
@transform_set_authorizer_sqlite3_result_value@
expression E;
identifier FP_NAME = set_authorizer;
identifier FUNC_NAME = sqlite3_result_value;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.set_authorizer_signature = set_authorizer_signatures[set_authorizer_sqlite3_result_value_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.set_authorizer_signature = set_authorizer_signatures[set_authorizer_sqlite3_result_value_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->set_authorizer_signature = set_authorizer_signatures[set_authorizer_sqlite3_result_value_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->set_authorizer_signature = set_authorizer_signatures[set_authorizer_sqlite3_result_value_enum];
)

// Rules for set_auxdata (1 valid functions, 0 excluded)
// Rule: .set_auxdata = sqlite3_rollback_hook ==> .set_auxdata_signature = set_auxdata_signatures[set_auxdata_sqlite3_rollback_hook_enum];
@transform_set_auxdata_sqlite3_rollback_hook@
expression E;
identifier FP_NAME = set_auxdata;
identifier FUNC_NAME = sqlite3_rollback_hook;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.set_auxdata_signature = set_auxdata_signatures[set_auxdata_sqlite3_rollback_hook_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.set_auxdata_signature = set_auxdata_signatures[set_auxdata_sqlite3_rollback_hook_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->set_auxdata_signature = set_auxdata_signatures[set_auxdata_sqlite3_rollback_hook_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->set_auxdata_signature = set_auxdata_signatures[set_auxdata_sqlite3_rollback_hook_enum];
)

// Rules for set_clientdata (1 valid functions, 0 excluded)
// Rule: .set_clientdata = sqlite3_txn_state ==> .set_clientdata_signature = set_clientdata_signatures[set_clientdata_sqlite3_txn_state_enum];
@transform_set_clientdata_sqlite3_txn_state@
expression E;
identifier FP_NAME = set_clientdata;
identifier FUNC_NAME = sqlite3_txn_state;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.set_clientdata_signature = set_clientdata_signatures[set_clientdata_sqlite3_txn_state_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.set_clientdata_signature = set_clientdata_signatures[set_clientdata_sqlite3_txn_state_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->set_clientdata_signature = set_clientdata_signatures[set_clientdata_sqlite3_txn_state_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->set_clientdata_signature = set_clientdata_signatures[set_clientdata_sqlite3_txn_state_enum];
)

// Rules for set_last_insert_rowid (1 valid functions, 0 excluded)
// Rule: .set_last_insert_rowid = sqlite3_result_blob64 ==> .set_last_insert_rowid_signature = set_last_insert_rowid_signatures[set_last_insert_rowid_sqlite3_result_blob64_enum];
@transform_set_last_insert_rowid_sqlite3_result_blob64@
expression E;
identifier FP_NAME = set_last_insert_rowid;
identifier FUNC_NAME = sqlite3_result_blob64;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.set_last_insert_rowid_signature = set_last_insert_rowid_signatures[set_last_insert_rowid_sqlite3_result_blob64_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.set_last_insert_rowid_signature = set_last_insert_rowid_signatures[set_last_insert_rowid_sqlite3_result_blob64_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->set_last_insert_rowid_signature = set_last_insert_rowid_signatures[set_last_insert_rowid_sqlite3_result_blob64_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->set_last_insert_rowid_signature = set_last_insert_rowid_signatures[set_last_insert_rowid_sqlite3_result_blob64_enum];
)

// Rules for setlk_timeout (1 valid functions, 0 excluded)
// Rule: .setlk_timeout = sqlite3_changes64 ==> .setlk_timeout_signature = setlk_timeout_signatures[setlk_timeout_sqlite3_changes64_enum];
@transform_setlk_timeout_sqlite3_changes64@
expression E;
identifier FP_NAME = setlk_timeout;
identifier FUNC_NAME = sqlite3_changes64;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.setlk_timeout_signature = setlk_timeout_signatures[setlk_timeout_sqlite3_changes64_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.setlk_timeout_signature = setlk_timeout_signatures[setlk_timeout_sqlite3_changes64_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->setlk_timeout_signature = setlk_timeout_signatures[setlk_timeout_sqlite3_changes64_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->setlk_timeout_signature = setlk_timeout_signatures[setlk_timeout_sqlite3_changes64_enum];
)

// Rules for soft_heap_limit (1 valid functions, 0 excluded)
// Rule: .soft_heap_limit = sqlite3_mutex_enter ==> .soft_heap_limit_signature = soft_heap_limit_signatures[soft_heap_limit_sqlite3_mutex_enter_enum];
@transform_soft_heap_limit_sqlite3_mutex_enter@
expression E;
identifier FP_NAME = soft_heap_limit;
identifier FUNC_NAME = sqlite3_mutex_enter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.soft_heap_limit_signature = soft_heap_limit_signatures[soft_heap_limit_sqlite3_mutex_enter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.soft_heap_limit_signature = soft_heap_limit_signatures[soft_heap_limit_sqlite3_mutex_enter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->soft_heap_limit_signature = soft_heap_limit_signatures[soft_heap_limit_sqlite3_mutex_enter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->soft_heap_limit_signature = soft_heap_limit_signatures[soft_heap_limit_sqlite3_mutex_enter_enum];
)

// Rules for soft_heap_limit64 (1 valid functions, 0 excluded)
// Rule: .soft_heap_limit64 = sqlite3_backup_step ==> .soft_heap_limit64_signature = soft_heap_limit64_signatures[soft_heap_limit64_sqlite3_backup_step_enum];
@transform_soft_heap_limit64_sqlite3_backup_step@
expression E;
identifier FP_NAME = soft_heap_limit64;
identifier FUNC_NAME = sqlite3_backup_step;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.soft_heap_limit64_signature = soft_heap_limit64_signatures[soft_heap_limit64_sqlite3_backup_step_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.soft_heap_limit64_signature = soft_heap_limit64_signatures[soft_heap_limit64_sqlite3_backup_step_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->soft_heap_limit64_signature = soft_heap_limit64_signatures[soft_heap_limit64_sqlite3_backup_step_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->soft_heap_limit64_signature = soft_heap_limit64_signatures[soft_heap_limit64_sqlite3_backup_step_enum];
)

// Rules for sql (1 valid functions, 0 excluded)
// Rule: .sql = sqlite3_threadsafe ==> .sql_signature = sql_signatures[sql_sqlite3_threadsafe_enum];
@transform_sql_sqlite3_threadsafe@
expression E;
identifier FP_NAME = sql;
identifier FUNC_NAME = sqlite3_threadsafe;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.sql_signature = sql_signatures[sql_sqlite3_threadsafe_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.sql_signature = sql_signatures[sql_sqlite3_threadsafe_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->sql_signature = sql_signatures[sql_sqlite3_threadsafe_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->sql_signature = sql_signatures[sql_sqlite3_threadsafe_enum];
)

// Rules for status (1 valid functions, 0 excluded)
// Rule: .status = sqlite3_result_zeroblob ==> .status_signature = status_signatures[status_sqlite3_result_zeroblob_enum];
@transform_status_sqlite3_result_zeroblob@
expression E;
identifier FP_NAME = status;
identifier FUNC_NAME = sqlite3_result_zeroblob;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.status_signature = status_signatures[status_sqlite3_result_zeroblob_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.status_signature = status_signatures[status_sqlite3_result_zeroblob_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->status_signature = status_signatures[status_sqlite3_result_zeroblob_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->status_signature = status_signatures[status_sqlite3_result_zeroblob_enum];
)

// Rules for status64 (1 valid functions, 0 excluded)
// Rule: .status64 = sqlite3_cancel_auto_extension ==> .status64_signature = status64_signatures[status64_sqlite3_cancel_auto_extension_enum];
@transform_status64_sqlite3_cancel_auto_extension@
expression E;
identifier FP_NAME = status64;
identifier FUNC_NAME = sqlite3_cancel_auto_extension;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.status64_signature = status64_signatures[status64_sqlite3_cancel_auto_extension_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.status64_signature = status64_signatures[status64_sqlite3_cancel_auto_extension_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->status64_signature = status64_signatures[status64_sqlite3_cancel_auto_extension_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->status64_signature = status64_signatures[status64_sqlite3_cancel_auto_extension_enum];
)

// Rules for step (1 valid functions, 0 excluded)
// Rule: .step = sqlite3_set_auxdata ==> .step_signature = step_signatures[step_sqlite3_set_auxdata_enum];
@transform_step_sqlite3_set_auxdata@
expression E;
identifier FP_NAME = step;
identifier FUNC_NAME = sqlite3_set_auxdata;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.step_signature = step_signatures[step_sqlite3_set_auxdata_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.step_signature = step_signatures[step_sqlite3_set_auxdata_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->step_signature = step_signatures[step_sqlite3_set_auxdata_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->step_signature = step_signatures[step_sqlite3_set_auxdata_enum];
)

// Rules for stmt_explain (1 valid functions, 0 excluded)
// Rule: .stmt_explain = sqlite3_free_filename ==> .stmt_explain_signature = stmt_explain_signatures[stmt_explain_sqlite3_free_filename_enum];
@transform_stmt_explain_sqlite3_free_filename@
expression E;
identifier FP_NAME = stmt_explain;
identifier FUNC_NAME = sqlite3_free_filename;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.stmt_explain_signature = stmt_explain_signatures[stmt_explain_sqlite3_free_filename_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.stmt_explain_signature = stmt_explain_signatures[stmt_explain_sqlite3_free_filename_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->stmt_explain_signature = stmt_explain_signatures[stmt_explain_sqlite3_free_filename_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->stmt_explain_signature = stmt_explain_signatures[stmt_explain_sqlite3_free_filename_enum];
)

// Rules for stmt_isexplain (1 valid functions, 0 excluded)
// Rule: .stmt_isexplain = sqlite3_keyword_name ==> .stmt_isexplain_signature = stmt_isexplain_signatures[stmt_isexplain_sqlite3_keyword_name_enum];
@transform_stmt_isexplain_sqlite3_keyword_name@
expression E;
identifier FP_NAME = stmt_isexplain;
identifier FUNC_NAME = sqlite3_keyword_name;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.stmt_isexplain_signature = stmt_isexplain_signatures[stmt_isexplain_sqlite3_keyword_name_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.stmt_isexplain_signature = stmt_isexplain_signatures[stmt_isexplain_sqlite3_keyword_name_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->stmt_isexplain_signature = stmt_isexplain_signatures[stmt_isexplain_sqlite3_keyword_name_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->stmt_isexplain_signature = stmt_isexplain_signatures[stmt_isexplain_sqlite3_keyword_name_enum];
)

// Rules for stmt_status (1 valid functions, 0 excluded)
// Rule: .stmt_status = sqlite3_compileoption_used ==> .stmt_status_signature = stmt_status_signatures[stmt_status_sqlite3_compileoption_used_enum];
@transform_stmt_status_sqlite3_compileoption_used@
expression E;
identifier FP_NAME = stmt_status;
identifier FUNC_NAME = sqlite3_compileoption_used;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.stmt_status_signature = stmt_status_signatures[stmt_status_sqlite3_compileoption_used_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.stmt_status_signature = stmt_status_signatures[stmt_status_sqlite3_compileoption_used_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->stmt_status_signature = stmt_status_signatures[stmt_status_sqlite3_compileoption_used_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->stmt_status_signature = stmt_status_signatures[stmt_status_sqlite3_compileoption_used_enum];
)

// Rules for str_append (1 valid functions, 0 excluded)
// Rule: .str_append = sqlite3_prepare_v3 ==> .str_append_signature = str_append_signatures[str_append_sqlite3_prepare_v3_enum];
@transform_str_append_sqlite3_prepare_v3@
expression E;
identifier FP_NAME = str_append;
identifier FUNC_NAME = sqlite3_prepare_v3;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.str_append_signature = str_append_signatures[str_append_sqlite3_prepare_v3_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.str_append_signature = str_append_signatures[str_append_sqlite3_prepare_v3_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->str_append_signature = str_append_signatures[str_append_sqlite3_prepare_v3_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->str_append_signature = str_append_signatures[str_append_sqlite3_prepare_v3_enum];
)

// Rules for str_appendall (1 valid functions, 0 excluded)
// Rule: .str_appendall = sqlite3_prepare16_v3 ==> .str_appendall_signature = str_appendall_signatures[str_appendall_sqlite3_prepare16_v3_enum];
@transform_str_appendall_sqlite3_prepare16_v3@
expression E;
identifier FP_NAME = str_appendall;
identifier FUNC_NAME = sqlite3_prepare16_v3;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.str_appendall_signature = str_appendall_signatures[str_appendall_sqlite3_prepare16_v3_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.str_appendall_signature = str_appendall_signatures[str_appendall_sqlite3_prepare16_v3_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->str_appendall_signature = str_appendall_signatures[str_appendall_sqlite3_prepare16_v3_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->str_appendall_signature = str_appendall_signatures[str_appendall_sqlite3_prepare16_v3_enum];
)

// Rules for str_appendchar (1 valid functions, 0 excluded)
// Rule: .str_appendchar = sqlite3_bind_pointer ==> .str_appendchar_signature = str_appendchar_signatures[str_appendchar_sqlite3_bind_pointer_enum];
@transform_str_appendchar_sqlite3_bind_pointer@
expression E;
identifier FP_NAME = str_appendchar;
identifier FUNC_NAME = sqlite3_bind_pointer;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.str_appendchar_signature = str_appendchar_signatures[str_appendchar_sqlite3_bind_pointer_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.str_appendchar_signature = str_appendchar_signatures[str_appendchar_sqlite3_bind_pointer_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->str_appendchar_signature = str_appendchar_signatures[str_appendchar_sqlite3_bind_pointer_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->str_appendchar_signature = str_appendchar_signatures[str_appendchar_sqlite3_bind_pointer_enum];
)

// Rules for str_appendf (1 valid functions, 0 excluded)
// Rule: .str_appendf = sqlite3_expanded_sql ==> .str_appendf_signature = str_appendf_signatures[str_appendf_sqlite3_expanded_sql_enum];
@transform_str_appendf_sqlite3_expanded_sql@
expression E;
identifier FP_NAME = str_appendf;
identifier FUNC_NAME = sqlite3_expanded_sql;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.str_appendf_signature = str_appendf_signatures[str_appendf_sqlite3_expanded_sql_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.str_appendf_signature = str_appendf_signatures[str_appendf_sqlite3_expanded_sql_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->str_appendf_signature = str_appendf_signatures[str_appendf_sqlite3_expanded_sql_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->str_appendf_signature = str_appendf_signatures[str_appendf_sqlite3_expanded_sql_enum];
)

// Rules for str_errcode (1 valid functions, 0 excluded)
// Rule: .str_errcode = sqlite3_value_pointer ==> .str_errcode_signature = str_errcode_signatures[str_errcode_sqlite3_value_pointer_enum];
@transform_str_errcode_sqlite3_value_pointer@
expression E;
identifier FP_NAME = str_errcode;
identifier FUNC_NAME = sqlite3_value_pointer;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.str_errcode_signature = str_errcode_signatures[str_errcode_sqlite3_value_pointer_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.str_errcode_signature = str_errcode_signatures[str_errcode_sqlite3_value_pointer_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->str_errcode_signature = str_errcode_signatures[str_errcode_sqlite3_value_pointer_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->str_errcode_signature = str_errcode_signatures[str_errcode_sqlite3_value_pointer_enum];
)

// Rules for str_finish (1 valid functions, 0 excluded)
// Rule: .str_finish = sqlite3_trace_v2 ==> .str_finish_signature = str_finish_signatures[str_finish_sqlite3_trace_v2_enum];
@transform_str_finish_sqlite3_trace_v2@
expression E;
identifier FP_NAME = str_finish;
identifier FUNC_NAME = sqlite3_trace_v2;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.str_finish_signature = str_finish_signatures[str_finish_sqlite3_trace_v2_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.str_finish_signature = str_finish_signatures[str_finish_sqlite3_trace_v2_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->str_finish_signature = str_finish_signatures[str_finish_sqlite3_trace_v2_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->str_finish_signature = str_finish_signatures[str_finish_sqlite3_trace_v2_enum];
)

// Rules for str_length (1 valid functions, 0 excluded)
// Rule: .str_length = sqlite3_vtab_nochange ==> .str_length_signature = str_length_signatures[str_length_sqlite3_vtab_nochange_enum];
@transform_str_length_sqlite3_vtab_nochange@
expression E;
identifier FP_NAME = str_length;
identifier FUNC_NAME = sqlite3_vtab_nochange;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.str_length_signature = str_length_signatures[str_length_sqlite3_vtab_nochange_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.str_length_signature = str_length_signatures[str_length_sqlite3_vtab_nochange_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->str_length_signature = str_length_signatures[str_length_sqlite3_vtab_nochange_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->str_length_signature = str_length_signatures[str_length_sqlite3_vtab_nochange_enum];
)

// Rules for str_new (1 valid functions, 0 excluded)
// Rule: .str_new = sqlite3_system_errno ==> .str_new_signature = str_new_signatures[str_new_sqlite3_system_errno_enum];
@transform_str_new_sqlite3_system_errno@
expression E;
identifier FP_NAME = str_new;
identifier FUNC_NAME = sqlite3_system_errno;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.str_new_signature = str_new_signatures[str_new_sqlite3_system_errno_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.str_new_signature = str_new_signatures[str_new_sqlite3_system_errno_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->str_new_signature = str_new_signatures[str_new_sqlite3_system_errno_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->str_new_signature = str_new_signatures[str_new_sqlite3_system_errno_enum];
)

// Rules for str_reset (1 valid functions, 0 excluded)
// Rule: .str_reset = sqlite3_result_pointer ==> .str_reset_signature = str_reset_signatures[str_reset_sqlite3_result_pointer_enum];
@transform_str_reset_sqlite3_result_pointer@
expression E;
identifier FP_NAME = str_reset;
identifier FUNC_NAME = sqlite3_result_pointer;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.str_reset_signature = str_reset_signatures[str_reset_sqlite3_result_pointer_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.str_reset_signature = str_reset_signatures[str_reset_sqlite3_result_pointer_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->str_reset_signature = str_reset_signatures[str_reset_sqlite3_result_pointer_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->str_reset_signature = str_reset_signatures[str_reset_sqlite3_result_pointer_enum];
)

// Rules for str_value (1 valid functions, 0 excluded)
// Rule: .str_value = sqlite3_value_nochange ==> .str_value_signature = str_value_signatures[str_value_sqlite3_value_nochange_enum];
@transform_str_value_sqlite3_value_nochange@
expression E;
identifier FP_NAME = str_value;
identifier FUNC_NAME = sqlite3_value_nochange;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.str_value_signature = str_value_signatures[str_value_sqlite3_value_nochange_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.str_value_signature = str_value_signatures[str_value_sqlite3_value_nochange_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->str_value_signature = str_value_signatures[str_value_sqlite3_value_nochange_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->str_value_signature = str_value_signatures[str_value_sqlite3_value_nochange_enum];
)

// Rules for str_vappendf (1 valid functions, 0 excluded)
// Rule: .str_vappendf = sqlite3_set_last_insert_rowid ==> .str_vappendf_signature = str_vappendf_signatures[str_vappendf_sqlite3_set_last_insert_rowid_enum];
@transform_str_vappendf_sqlite3_set_last_insert_rowid@
expression E;
identifier FP_NAME = str_vappendf;
identifier FUNC_NAME = sqlite3_set_last_insert_rowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.str_vappendf_signature = str_vappendf_signatures[str_vappendf_sqlite3_set_last_insert_rowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.str_vappendf_signature = str_vappendf_signatures[str_vappendf_sqlite3_set_last_insert_rowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->str_vappendf_signature = str_vappendf_signatures[str_vappendf_sqlite3_set_last_insert_rowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->str_vappendf_signature = str_vappendf_signatures[str_vappendf_sqlite3_set_last_insert_rowid_enum];
)

// Rules for strglob (1 valid functions, 0 excluded)
// Rule: .strglob = sqlite3_uri_int64 ==> .strglob_signature = strglob_signatures[strglob_sqlite3_uri_int64_enum];
@transform_strglob_sqlite3_uri_int64@
expression E;
identifier FP_NAME = strglob;
identifier FUNC_NAME = sqlite3_uri_int64;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.strglob_signature = strglob_signatures[strglob_sqlite3_uri_int64_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.strglob_signature = strglob_signatures[strglob_sqlite3_uri_int64_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->strglob_signature = strglob_signatures[strglob_sqlite3_uri_int64_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->strglob_signature = strglob_signatures[strglob_sqlite3_uri_int64_enum];
)

// Rules for stricmp (1 valid functions, 0 excluded)
// Rule: .stricmp = sqlite3_wal_checkpoint ==> .stricmp_signature = stricmp_signatures[stricmp_sqlite3_wal_checkpoint_enum];
@transform_stricmp_sqlite3_wal_checkpoint@
expression E;
identifier FP_NAME = stricmp;
identifier FUNC_NAME = sqlite3_wal_checkpoint;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.stricmp_signature = stricmp_signatures[stricmp_sqlite3_wal_checkpoint_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.stricmp_signature = stricmp_signatures[stricmp_sqlite3_wal_checkpoint_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->stricmp_signature = stricmp_signatures[stricmp_sqlite3_wal_checkpoint_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->stricmp_signature = stricmp_signatures[stricmp_sqlite3_wal_checkpoint_enum];
)

// Rules for strlike (1 valid functions, 0 excluded)
// Rule: .strlike = sqlite3_load_extension ==> .strlike_signature = strlike_signatures[strlike_sqlite3_load_extension_enum];
@transform_strlike_sqlite3_load_extension@
expression E;
identifier FP_NAME = strlike;
identifier FUNC_NAME = sqlite3_load_extension;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.strlike_signature = strlike_signatures[strlike_sqlite3_load_extension_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.strlike_signature = strlike_signatures[strlike_sqlite3_load_extension_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->strlike_signature = strlike_signatures[strlike_sqlite3_load_extension_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->strlike_signature = strlike_signatures[strlike_sqlite3_load_extension_enum];
)

// Rules for system_errno (1 valid functions, 0 excluded)
// Rule: .system_errno = sqlite3_msize ==> .system_errno_signature = system_errno_signatures[system_errno_sqlite3_msize_enum];
@transform_system_errno_sqlite3_msize@
expression E;
identifier FP_NAME = system_errno;
identifier FUNC_NAME = sqlite3_msize;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.system_errno_signature = system_errno_signatures[system_errno_sqlite3_msize_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.system_errno_signature = system_errno_signatures[system_errno_sqlite3_msize_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->system_errno_signature = system_errno_signatures[system_errno_sqlite3_msize_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->system_errno_signature = system_errno_signatures[system_errno_sqlite3_msize_enum];
)

// Rules for table_column_metadata (1 valid functions, 0 excluded)
// Rule: .table_column_metadata = sqlite3_snprintf ==> .table_column_metadata_signature = table_column_metadata_signatures[table_column_metadata_sqlite3_snprintf_enum];
@transform_table_column_metadata_sqlite3_snprintf@
expression E;
identifier FP_NAME = table_column_metadata;
identifier FUNC_NAME = sqlite3_snprintf;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.table_column_metadata_signature = table_column_metadata_signatures[table_column_metadata_sqlite3_snprintf_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.table_column_metadata_signature = table_column_metadata_signatures[table_column_metadata_sqlite3_snprintf_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->table_column_metadata_signature = table_column_metadata_signatures[table_column_metadata_sqlite3_snprintf_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->table_column_metadata_signature = table_column_metadata_signatures[table_column_metadata_sqlite3_snprintf_enum];
)

// Rules for test_control (1 valid functions, 0 excluded)
// Rule: .test_control = sqlite3_result_error_toobig ==> .test_control_signature = test_control_signatures[test_control_sqlite3_result_error_toobig_enum];
@transform_test_control_sqlite3_result_error_toobig@
expression E;
identifier FP_NAME = test_control;
identifier FUNC_NAME = sqlite3_result_error_toobig;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.test_control_signature = test_control_signatures[test_control_sqlite3_result_error_toobig_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.test_control_signature = test_control_signatures[test_control_sqlite3_result_error_toobig_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->test_control_signature = test_control_signatures[test_control_sqlite3_result_error_toobig_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->test_control_signature = test_control_signatures[test_control_sqlite3_result_error_toobig_enum];
)

// Rules for thread_cleanup (1 valid functions, 0 excluded)
// Rule: .thread_cleanup = sqlite3_step ==> .thread_cleanup_signature = thread_cleanup_signatures[thread_cleanup_sqlite3_step_enum];
@transform_thread_cleanup_sqlite3_step@
expression E;
identifier FP_NAME = thread_cleanup;
identifier FUNC_NAME = sqlite3_step;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.thread_cleanup_signature = thread_cleanup_signatures[thread_cleanup_sqlite3_step_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.thread_cleanup_signature = thread_cleanup_signatures[thread_cleanup_sqlite3_step_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->thread_cleanup_signature = thread_cleanup_signatures[thread_cleanup_sqlite3_step_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->thread_cleanup_signature = thread_cleanup_signatures[thread_cleanup_sqlite3_step_enum];
)

// Rules for total_changes (1 valid functions, 0 excluded)
// Rule: .total_changes = sqlite3_table_column_metadata ==> .total_changes_signature = total_changes_signatures[total_changes_sqlite3_table_column_metadata_enum];
@transform_total_changes_sqlite3_table_column_metadata@
expression E;
identifier FP_NAME = total_changes;
identifier FUNC_NAME = sqlite3_table_column_metadata;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.total_changes_signature = total_changes_signatures[total_changes_sqlite3_table_column_metadata_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.total_changes_signature = total_changes_signatures[total_changes_sqlite3_table_column_metadata_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->total_changes_signature = total_changes_signatures[total_changes_sqlite3_table_column_metadata_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->total_changes_signature = total_changes_signatures[total_changes_sqlite3_table_column_metadata_enum];
)

// Rules for total_changes64 (1 valid functions, 0 excluded)
// Rule: .total_changes64 = sqlite3_create_window_function ==> .total_changes64_signature = total_changes64_signatures[total_changes64_sqlite3_create_window_function_enum];
@transform_total_changes64_sqlite3_create_window_function@
expression E;
identifier FP_NAME = total_changes64;
identifier FUNC_NAME = sqlite3_create_window_function;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.total_changes64_signature = total_changes64_signatures[total_changes64_sqlite3_create_window_function_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.total_changes64_signature = total_changes64_signatures[total_changes64_sqlite3_create_window_function_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->total_changes64_signature = total_changes64_signatures[total_changes64_sqlite3_create_window_function_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->total_changes64_signature = total_changes64_signatures[total_changes64_sqlite3_create_window_function_enum];
)

// Rules for trace_v2 (1 valid functions, 0 excluded)
// Rule: .trace_v2 = sqlite3_realloc64 ==> .trace_v2_signature = trace_v2_signatures[trace_v2_sqlite3_realloc64_enum];
@transform_trace_v2_sqlite3_realloc64@
expression E;
identifier FP_NAME = trace_v2;
identifier FUNC_NAME = sqlite3_realloc64;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.trace_v2_signature = trace_v2_signatures[trace_v2_sqlite3_realloc64_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.trace_v2_signature = trace_v2_signatures[trace_v2_sqlite3_realloc64_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->trace_v2_signature = trace_v2_signatures[trace_v2_sqlite3_realloc64_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->trace_v2_signature = trace_v2_signatures[trace_v2_sqlite3_realloc64_enum];
)

// Rules for txn_state (1 valid functions, 0 excluded)
// Rule: .txn_state = sqlite3_str_length ==> .txn_state_signature = txn_state_signatures[txn_state_sqlite3_str_length_enum];
@transform_txn_state_sqlite3_str_length@
expression E;
identifier FP_NAME = txn_state;
identifier FUNC_NAME = sqlite3_str_length;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.txn_state_signature = txn_state_signatures[txn_state_sqlite3_str_length_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.txn_state_signature = txn_state_signatures[txn_state_sqlite3_str_length_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->txn_state_signature = txn_state_signatures[txn_state_sqlite3_str_length_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->txn_state_signature = txn_state_signatures[txn_state_sqlite3_str_length_enum];
)

// Rules for uri_boolean (1 valid functions, 0 excluded)
// Rule: .uri_boolean = sqlite3_wal_hook ==> .uri_boolean_signature = uri_boolean_signatures[uri_boolean_sqlite3_wal_hook_enum];
@transform_uri_boolean_sqlite3_wal_hook@
expression E;
identifier FP_NAME = uri_boolean;
identifier FUNC_NAME = sqlite3_wal_hook;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.uri_boolean_signature = uri_boolean_signatures[uri_boolean_sqlite3_wal_hook_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.uri_boolean_signature = uri_boolean_signatures[uri_boolean_sqlite3_wal_hook_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->uri_boolean_signature = uri_boolean_signatures[uri_boolean_sqlite3_wal_hook_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->uri_boolean_signature = uri_boolean_signatures[uri_boolean_sqlite3_wal_hook_enum];
)

// Rules for uri_key (1 valid functions, 0 excluded)
// Rule: .uri_key = sqlite3_str_appendf ==> .uri_key_signature = uri_key_signatures[uri_key_sqlite3_str_appendf_enum];
@transform_uri_key_sqlite3_str_appendf@
expression E;
identifier FP_NAME = uri_key;
identifier FUNC_NAME = sqlite3_str_appendf;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.uri_key_signature = uri_key_signatures[uri_key_sqlite3_str_appendf_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.uri_key_signature = uri_key_signatures[uri_key_sqlite3_str_appendf_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->uri_key_signature = uri_key_signatures[uri_key_sqlite3_str_appendf_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->uri_key_signature = uri_key_signatures[uri_key_sqlite3_str_appendf_enum];
)

// Rules for user_data (1 valid functions, 0 excluded)
// Rule: .user_data = sqlite3_trace ==> .user_data_signature = user_data_signatures[user_data_sqlite3_trace_enum];
@transform_user_data_sqlite3_trace@
expression E;
identifier FP_NAME = user_data;
identifier FUNC_NAME = sqlite3_trace;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.user_data_signature = user_data_signatures[user_data_sqlite3_trace_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.user_data_signature = user_data_signatures[user_data_sqlite3_trace_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->user_data_signature = user_data_signatures[user_data_sqlite3_trace_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->user_data_signature = user_data_signatures[user_data_sqlite3_trace_enum];
)

// Rules for value_double (1 valid functions, 0 excluded)
// Rule: .value_double = sqlite3_user_data ==> .value_double_signature = value_double_signatures[value_double_sqlite3_user_data_enum];
@transform_value_double_sqlite3_user_data@
expression E;
identifier FP_NAME = value_double;
identifier FUNC_NAME = sqlite3_user_data;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.value_double_signature = value_double_signatures[value_double_sqlite3_user_data_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.value_double_signature = value_double_signatures[value_double_sqlite3_user_data_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->value_double_signature = value_double_signatures[value_double_sqlite3_user_data_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->value_double_signature = value_double_signatures[value_double_sqlite3_user_data_enum];
)

// Rules for value_dup (1 valid functions, 0 excluded)
// Rule: .value_dup = sqlite3_uri_parameter ==> .value_dup_signature = value_dup_signatures[value_dup_sqlite3_uri_parameter_enum];
@transform_value_dup_sqlite3_uri_parameter@
expression E;
identifier FP_NAME = value_dup;
identifier FUNC_NAME = sqlite3_uri_parameter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.value_dup_signature = value_dup_signatures[value_dup_sqlite3_uri_parameter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.value_dup_signature = value_dup_signatures[value_dup_sqlite3_uri_parameter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->value_dup_signature = value_dup_signatures[value_dup_sqlite3_uri_parameter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->value_dup_signature = value_dup_signatures[value_dup_sqlite3_uri_parameter_enum];
)

// Rules for value_encoding (1 valid functions, 0 excluded)
// Rule: .value_encoding = sqlite3_filename_wal ==> .value_encoding_signature = value_encoding_signatures[value_encoding_sqlite3_filename_wal_enum];
@transform_value_encoding_sqlite3_filename_wal@
expression E;
identifier FP_NAME = value_encoding;
identifier FUNC_NAME = sqlite3_filename_wal;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.value_encoding_signature = value_encoding_signatures[value_encoding_sqlite3_filename_wal_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.value_encoding_signature = value_encoding_signatures[value_encoding_sqlite3_filename_wal_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->value_encoding_signature = value_encoding_signatures[value_encoding_sqlite3_filename_wal_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->value_encoding_signature = value_encoding_signatures[value_encoding_sqlite3_filename_wal_enum];
)

// Rules for value_free (1 valid functions, 0 excluded)
// Rule: .value_free = sqlite3_vsnprintf ==> .value_free_signature = value_free_signatures[value_free_sqlite3_vsnprintf_enum];
@transform_value_free_sqlite3_vsnprintf@
expression E;
identifier FP_NAME = value_free;
identifier FUNC_NAME = sqlite3_vsnprintf;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.value_free_signature = value_free_signatures[value_free_sqlite3_vsnprintf_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.value_free_signature = value_free_signatures[value_free_sqlite3_vsnprintf_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->value_free_signature = value_free_signatures[value_free_sqlite3_vsnprintf_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->value_free_signature = value_free_signatures[value_free_sqlite3_vsnprintf_enum];
)

// Rules for value_frombind (1 valid functions, 0 excluded)
// Rule: .value_frombind = sqlite3_keyword_check ==> .value_frombind_signature = value_frombind_signatures[value_frombind_sqlite3_keyword_check_enum];
@transform_value_frombind_sqlite3_keyword_check@
expression E;
identifier FP_NAME = value_frombind;
identifier FUNC_NAME = sqlite3_keyword_check;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.value_frombind_signature = value_frombind_signatures[value_frombind_sqlite3_keyword_check_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.value_frombind_signature = value_frombind_signatures[value_frombind_sqlite3_keyword_check_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->value_frombind_signature = value_frombind_signatures[value_frombind_sqlite3_keyword_check_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->value_frombind_signature = value_frombind_signatures[value_frombind_sqlite3_keyword_check_enum];
)

// Rules for value_int (1 valid functions, 0 excluded)
// Rule: .value_int = sqlite3_value_blob ==> .value_int_signature = value_int_signatures[value_int_sqlite3_value_blob_enum];
@transform_value_int_sqlite3_value_blob@
expression E;
identifier FP_NAME = value_int;
identifier FUNC_NAME = sqlite3_value_blob;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.value_int_signature = value_int_signatures[value_int_sqlite3_value_blob_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.value_int_signature = value_int_signatures[value_int_sqlite3_value_blob_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->value_int_signature = value_int_signatures[value_int_sqlite3_value_blob_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->value_int_signature = value_int_signatures[value_int_sqlite3_value_blob_enum];
)

// Rules for value_int64 (1 valid functions, 0 excluded)
// Rule: .value_int64 = sqlite3_value_bytes ==> .value_int64_signature = value_int64_signatures[value_int64_sqlite3_value_bytes_enum];
@transform_value_int64_sqlite3_value_bytes@
expression E;
identifier FP_NAME = value_int64;
identifier FUNC_NAME = sqlite3_value_bytes;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.value_int64_signature = value_int64_signatures[value_int64_sqlite3_value_bytes_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.value_int64_signature = value_int64_signatures[value_int64_sqlite3_value_bytes_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->value_int64_signature = value_int64_signatures[value_int64_sqlite3_value_bytes_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->value_int64_signature = value_int64_signatures[value_int64_sqlite3_value_bytes_enum];
)

// Rules for value_nochange (1 valid functions, 0 excluded)
// Rule: .value_nochange = sqlite3_value_subtype ==> .value_nochange_signature = value_nochange_signatures[value_nochange_sqlite3_value_subtype_enum];
@transform_value_nochange_sqlite3_value_subtype@
expression E;
identifier FP_NAME = value_nochange;
identifier FUNC_NAME = sqlite3_value_subtype;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.value_nochange_signature = value_nochange_signatures[value_nochange_sqlite3_value_subtype_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.value_nochange_signature = value_nochange_signatures[value_nochange_sqlite3_value_subtype_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->value_nochange_signature = value_nochange_signatures[value_nochange_sqlite3_value_subtype_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->value_nochange_signature = value_nochange_signatures[value_nochange_sqlite3_value_subtype_enum];
)

// Rules for value_numeric_type (1 valid functions, 0 excluded)
// Rule: .value_numeric_type = sqlite3_value_bytes16 ==> .value_numeric_type_signature = value_numeric_type_signatures[value_numeric_type_sqlite3_value_bytes16_enum];
@transform_value_numeric_type_sqlite3_value_bytes16@
expression E;
identifier FP_NAME = value_numeric_type;
identifier FUNC_NAME = sqlite3_value_bytes16;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.value_numeric_type_signature = value_numeric_type_signatures[value_numeric_type_sqlite3_value_bytes16_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.value_numeric_type_signature = value_numeric_type_signatures[value_numeric_type_sqlite3_value_bytes16_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->value_numeric_type_signature = value_numeric_type_signatures[value_numeric_type_sqlite3_value_bytes16_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->value_numeric_type_signature = value_numeric_type_signatures[value_numeric_type_sqlite3_value_bytes16_enum];
)

// Rules for value_pointer (1 valid functions, 0 excluded)
// Rule: .value_pointer = sqlite3_result_zeroblob64 ==> .value_pointer_signature = value_pointer_signatures[value_pointer_sqlite3_result_zeroblob64_enum];
@transform_value_pointer_sqlite3_result_zeroblob64@
expression E;
identifier FP_NAME = value_pointer;
identifier FUNC_NAME = sqlite3_result_zeroblob64;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.value_pointer_signature = value_pointer_signatures[value_pointer_sqlite3_result_zeroblob64_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.value_pointer_signature = value_pointer_signatures[value_pointer_sqlite3_result_zeroblob64_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->value_pointer_signature = value_pointer_signatures[value_pointer_sqlite3_result_zeroblob64_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->value_pointer_signature = value_pointer_signatures[value_pointer_sqlite3_result_zeroblob64_enum];
)

// Rules for value_subtype (1 valid functions, 0 excluded)
// Rule: .value_subtype = sqlite3_bind_blob64 ==> .value_subtype_signature = value_subtype_signatures[value_subtype_sqlite3_bind_blob64_enum];
@transform_value_subtype_sqlite3_bind_blob64@
expression E;
identifier FP_NAME = value_subtype;
identifier FUNC_NAME = sqlite3_bind_blob64;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.value_subtype_signature = value_subtype_signatures[value_subtype_sqlite3_bind_blob64_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.value_subtype_signature = value_subtype_signatures[value_subtype_sqlite3_bind_blob64_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->value_subtype_signature = value_subtype_signatures[value_subtype_sqlite3_bind_blob64_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->value_subtype_signature = value_subtype_signatures[value_subtype_sqlite3_bind_blob64_enum];
)

// Rules for value_text (1 valid functions, 0 excluded)
// Rule: .value_text = sqlite3_value_double ==> .value_text_signature = value_text_signatures[value_text_sqlite3_value_double_enum];
@transform_value_text_sqlite3_value_double@
expression E;
identifier FP_NAME = value_text;
identifier FUNC_NAME = sqlite3_value_double;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.value_text_signature = value_text_signatures[value_text_sqlite3_value_double_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.value_text_signature = value_text_signatures[value_text_sqlite3_value_double_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->value_text_signature = value_text_signatures[value_text_sqlite3_value_double_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->value_text_signature = value_text_signatures[value_text_sqlite3_value_double_enum];
)

// Rules for value_text16 (1 valid functions, 0 excluded)
// Rule: .value_text16 = sqlite3_value_int ==> .value_text16_signature = value_text16_signatures[value_text16_sqlite3_value_int_enum];
@transform_value_text16_sqlite3_value_int@
expression E;
identifier FP_NAME = value_text16;
identifier FUNC_NAME = sqlite3_value_int;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.value_text16_signature = value_text16_signatures[value_text16_sqlite3_value_int_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.value_text16_signature = value_text16_signatures[value_text16_sqlite3_value_int_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->value_text16_signature = value_text16_signatures[value_text16_sqlite3_value_int_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->value_text16_signature = value_text16_signatures[value_text16_sqlite3_value_int_enum];
)

// Rules for value_text16be (1 valid functions, 0 excluded)
// Rule: .value_text16be = sqlite3_value_int64 ==> .value_text16be_signature = value_text16be_signatures[value_text16be_sqlite3_value_int64_enum];
@transform_value_text16be_sqlite3_value_int64@
expression E;
identifier FP_NAME = value_text16be;
identifier FUNC_NAME = sqlite3_value_int64;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.value_text16be_signature = value_text16be_signatures[value_text16be_sqlite3_value_int64_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.value_text16be_signature = value_text16be_signatures[value_text16be_sqlite3_value_int64_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->value_text16be_signature = value_text16be_signatures[value_text16be_sqlite3_value_int64_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->value_text16be_signature = value_text16be_signatures[value_text16be_sqlite3_value_int64_enum];
)

// Rules for value_text16le (1 valid functions, 0 excluded)
// Rule: .value_text16le = sqlite3_value_numeric_type ==> .value_text16le_signature = value_text16le_signatures[value_text16le_sqlite3_value_numeric_type_enum];
@transform_value_text16le_sqlite3_value_numeric_type@
expression E;
identifier FP_NAME = value_text16le;
identifier FUNC_NAME = sqlite3_value_numeric_type;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.value_text16le_signature = value_text16le_signatures[value_text16le_sqlite3_value_numeric_type_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.value_text16le_signature = value_text16le_signatures[value_text16le_sqlite3_value_numeric_type_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->value_text16le_signature = value_text16le_signatures[value_text16le_sqlite3_value_numeric_type_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->value_text16le_signature = value_text16le_signatures[value_text16le_sqlite3_value_numeric_type_enum];
)

// Rules for value_type (1 valid functions, 0 excluded)
// Rule: .value_type = sqlite3_value_text ==> .value_type_signature = value_type_signatures[value_type_sqlite3_value_text_enum];
@transform_value_type_sqlite3_value_text@
expression E;
identifier FP_NAME = value_type;
identifier FUNC_NAME = sqlite3_value_text;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.value_type_signature = value_type_signatures[value_type_sqlite3_value_text_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.value_type_signature = value_type_signatures[value_type_sqlite3_value_text_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->value_type_signature = value_type_signatures[value_type_sqlite3_value_text_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->value_type_signature = value_type_signatures[value_type_sqlite3_value_text_enum];
)

// Rules for vfs_find (1 valid functions, 0 excluded)
// Rule: .vfs_find = sqlite3_mutex_free ==> .vfs_find_signature = vfs_find_signatures[vfs_find_sqlite3_mutex_free_enum];
@transform_vfs_find_sqlite3_mutex_free@
expression E;
identifier FP_NAME = vfs_find;
identifier FUNC_NAME = sqlite3_mutex_free;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.vfs_find_signature = vfs_find_signatures[vfs_find_sqlite3_mutex_free_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.vfs_find_signature = vfs_find_signatures[vfs_find_sqlite3_mutex_free_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->vfs_find_signature = vfs_find_signatures[vfs_find_sqlite3_mutex_free_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->vfs_find_signature = vfs_find_signatures[vfs_find_sqlite3_mutex_free_enum];
)

// Rules for vfs_register (1 valid functions, 0 excluded)
// Rule: .vfs_register = sqlite3_mutex_leave ==> .vfs_register_signature = vfs_register_signatures[vfs_register_sqlite3_mutex_leave_enum];
@transform_vfs_register_sqlite3_mutex_leave@
expression E;
identifier FP_NAME = vfs_register;
identifier FUNC_NAME = sqlite3_mutex_leave;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.vfs_register_signature = vfs_register_signatures[vfs_register_sqlite3_mutex_leave_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.vfs_register_signature = vfs_register_signatures[vfs_register_sqlite3_mutex_leave_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->vfs_register_signature = vfs_register_signatures[vfs_register_sqlite3_mutex_leave_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->vfs_register_signature = vfs_register_signatures[vfs_register_sqlite3_mutex_leave_enum];
)

// Rules for vfs_unregister (1 valid functions, 0 excluded)
// Rule: .vfs_unregister = sqlite3_mutex_try ==> .vfs_unregister_signature = vfs_unregister_signatures[vfs_unregister_sqlite3_mutex_try_enum];
@transform_vfs_unregister_sqlite3_mutex_try@
expression E;
identifier FP_NAME = vfs_unregister;
identifier FUNC_NAME = sqlite3_mutex_try;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.vfs_unregister_signature = vfs_unregister_signatures[vfs_unregister_sqlite3_mutex_try_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.vfs_unregister_signature = vfs_unregister_signatures[vfs_unregister_sqlite3_mutex_try_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->vfs_unregister_signature = vfs_unregister_signatures[vfs_unregister_sqlite3_mutex_try_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->vfs_unregister_signature = vfs_unregister_signatures[vfs_unregister_sqlite3_mutex_try_enum];
)

// Rules for vmprintf (1 valid functions, 0 excluded)
// Rule: .vmprintf = sqlite3_value_text16 ==> .vmprintf_signature = vmprintf_signatures[vmprintf_sqlite3_value_text16_enum];
@transform_vmprintf_sqlite3_value_text16@
expression E;
identifier FP_NAME = vmprintf;
identifier FUNC_NAME = sqlite3_value_text16;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.vmprintf_signature = vmprintf_signatures[vmprintf_sqlite3_value_text16_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.vmprintf_signature = vmprintf_signatures[vmprintf_sqlite3_value_text16_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->vmprintf_signature = vmprintf_signatures[vmprintf_sqlite3_value_text16_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->vmprintf_signature = vmprintf_signatures[vmprintf_sqlite3_value_text16_enum];
)

// Rules for vtab_collation (1 valid functions, 0 excluded)
// Rule: .vtab_collation = sqlite3_result_subtype ==> .vtab_collation_signature = vtab_collation_signatures[vtab_collation_sqlite3_result_subtype_enum];
@transform_vtab_collation_sqlite3_result_subtype@
expression E;
identifier FP_NAME = vtab_collation;
identifier FUNC_NAME = sqlite3_result_subtype;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.vtab_collation_signature = vtab_collation_signatures[vtab_collation_sqlite3_result_subtype_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.vtab_collation_signature = vtab_collation_signatures[vtab_collation_sqlite3_result_subtype_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->vtab_collation_signature = vtab_collation_signatures[vtab_collation_sqlite3_result_subtype_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->vtab_collation_signature = vtab_collation_signatures[vtab_collation_sqlite3_result_subtype_enum];
)

// Rules for vtab_config (1 valid functions, 0 excluded)
// Rule: .vtab_config = sqlite3_extended_errcode ==> .vtab_config_signature = vtab_config_signatures[vtab_config_sqlite3_extended_errcode_enum];
@transform_vtab_config_sqlite3_extended_errcode@
expression E;
identifier FP_NAME = vtab_config;
identifier FUNC_NAME = sqlite3_extended_errcode;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.vtab_config_signature = vtab_config_signatures[vtab_config_sqlite3_extended_errcode_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.vtab_config_signature = vtab_config_signatures[vtab_config_sqlite3_extended_errcode_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->vtab_config_signature = vtab_config_signatures[vtab_config_sqlite3_extended_errcode_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->vtab_config_signature = vtab_config_signatures[vtab_config_sqlite3_extended_errcode_enum];
)

// Rules for vtab_distinct (1 valid functions, 0 excluded)
// Rule: .vtab_distinct = sqlite3_value_frombind ==> .vtab_distinct_signature = vtab_distinct_signatures[vtab_distinct_sqlite3_value_frombind_enum];
@transform_vtab_distinct_sqlite3_value_frombind@
expression E;
identifier FP_NAME = vtab_distinct;
identifier FUNC_NAME = sqlite3_value_frombind;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.vtab_distinct_signature = vtab_distinct_signatures[vtab_distinct_sqlite3_value_frombind_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.vtab_distinct_signature = vtab_distinct_signatures[vtab_distinct_sqlite3_value_frombind_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->vtab_distinct_signature = vtab_distinct_signatures[vtab_distinct_sqlite3_value_frombind_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->vtab_distinct_signature = vtab_distinct_signatures[vtab_distinct_sqlite3_value_frombind_enum];
)

// Rules for vtab_nochange (1 valid functions, 0 excluded)
// Rule: .vtab_nochange = sqlite3_bind_zeroblob64 ==> .vtab_nochange_signature = vtab_nochange_signatures[vtab_nochange_sqlite3_bind_zeroblob64_enum];
@transform_vtab_nochange_sqlite3_bind_zeroblob64@
expression E;
identifier FP_NAME = vtab_nochange;
identifier FUNC_NAME = sqlite3_bind_zeroblob64;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.vtab_nochange_signature = vtab_nochange_signatures[vtab_nochange_sqlite3_bind_zeroblob64_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.vtab_nochange_signature = vtab_nochange_signatures[vtab_nochange_sqlite3_bind_zeroblob64_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->vtab_nochange_signature = vtab_nochange_signatures[vtab_nochange_sqlite3_bind_zeroblob64_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->vtab_nochange_signature = vtab_nochange_signatures[vtab_nochange_sqlite3_bind_zeroblob64_enum];
)

// Rules for vtab_on_conflict (1 valid functions, 0 excluded)
// Rule: .vtab_on_conflict = sqlite3_log ==> .vtab_on_conflict_signature = vtab_on_conflict_signatures[vtab_on_conflict_sqlite3_log_enum];
@transform_vtab_on_conflict_sqlite3_log@
expression E;
identifier FP_NAME = vtab_on_conflict;
identifier FUNC_NAME = sqlite3_log;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.vtab_on_conflict_signature = vtab_on_conflict_signatures[vtab_on_conflict_sqlite3_log_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.vtab_on_conflict_signature = vtab_on_conflict_signatures[vtab_on_conflict_sqlite3_log_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->vtab_on_conflict_signature = vtab_on_conflict_signatures[vtab_on_conflict_sqlite3_log_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->vtab_on_conflict_signature = vtab_on_conflict_signatures[vtab_on_conflict_sqlite3_log_enum];
)

// Rules for wal_checkpoint (1 valid functions, 0 excluded)
// Rule: .wal_checkpoint = sqlite3_db_config ==> .wal_checkpoint_signature = wal_checkpoint_signatures[wal_checkpoint_sqlite3_db_config_enum];
@transform_wal_checkpoint_sqlite3_db_config@
expression E;
identifier FP_NAME = wal_checkpoint;
identifier FUNC_NAME = sqlite3_db_config;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.wal_checkpoint_signature = wal_checkpoint_signatures[wal_checkpoint_sqlite3_db_config_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.wal_checkpoint_signature = wal_checkpoint_signatures[wal_checkpoint_sqlite3_db_config_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->wal_checkpoint_signature = wal_checkpoint_signatures[wal_checkpoint_sqlite3_db_config_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->wal_checkpoint_signature = wal_checkpoint_signatures[wal_checkpoint_sqlite3_db_config_enum];
)

// Rules for wal_hook (1 valid functions, 0 excluded)
// Rule: .wal_hook = sqlite3_db_mutex ==> .wal_hook_signature = wal_hook_signatures[wal_hook_sqlite3_db_mutex_enum];
@transform_wal_hook_sqlite3_db_mutex@
expression E;
identifier FP_NAME = wal_hook;
identifier FUNC_NAME = sqlite3_db_mutex;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.wal_hook_signature = wal_hook_signatures[wal_hook_sqlite3_db_mutex_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.wal_hook_signature = wal_hook_signatures[wal_hook_sqlite3_db_mutex_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->wal_hook_signature = wal_hook_signatures[wal_hook_sqlite3_db_mutex_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->wal_hook_signature = wal_hook_signatures[wal_hook_sqlite3_db_mutex_enum];
)

// Rules for xAccess (4 valid functions, 12 excluded)
// Rule: .xAccess = apndAccess ==> .xAccess_signature = xAccess_signatures[xAccess_apndAccess_enum];
@transform_xAccess_apndAccess@
expression E;
identifier FP_NAME = xAccess;
identifier FUNC_NAME = apndAccess;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xAccess_signature = xAccess_signatures[xAccess_apndAccess_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xAccess_signature = xAccess_signatures[xAccess_apndAccess_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xAccess_signature = xAccess_signatures[xAccess_apndAccess_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xAccess_signature = xAccess_signatures[xAccess_apndAccess_enum];
)

// Rule: .xAccess = memdbAccess ==> .xAccess_signature = xAccess_signatures[xAccess_memdbAccess_enum];
@transform_xAccess_memdbAccess@
expression E;
identifier FP_NAME = xAccess;
identifier FUNC_NAME = memdbAccess;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xAccess_signature = xAccess_signatures[xAccess_memdbAccess_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xAccess_signature = xAccess_signatures[xAccess_memdbAccess_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xAccess_signature = xAccess_signatures[xAccess_memdbAccess_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xAccess_signature = xAccess_signatures[xAccess_memdbAccess_enum];
)

// Rule: .xAccess = vfstraceAccess ==> .xAccess_signature = xAccess_signatures[xAccess_vfstraceAccess_enum];
@transform_xAccess_vfstraceAccess@
expression E;
identifier FP_NAME = xAccess;
identifier FUNC_NAME = vfstraceAccess;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xAccess_signature = xAccess_signatures[xAccess_vfstraceAccess_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xAccess_signature = xAccess_signatures[xAccess_vfstraceAccess_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xAccess_signature = xAccess_signatures[xAccess_vfstraceAccess_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xAccess_signature = xAccess_signatures[xAccess_vfstraceAccess_enum];
)

// Rule: .xAccess = unixAccess ==> .xAccess_signature = xAccess_signatures[xAccess_unixAccess_enum];
@transform_xAccess_unixAccess@
expression E;
identifier FP_NAME = xAccess;
identifier FUNC_NAME = unixAccess;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xAccess_signature = xAccess_signatures[xAccess_unixAccess_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xAccess_signature = xAccess_signatures[xAccess_unixAccess_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xAccess_signature = xAccess_signatures[xAccess_unixAccess_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xAccess_signature = xAccess_signatures[xAccess_unixAccess_enum];
)

// Rules for xBegin (5 valid functions, 3 excluded)
// Rule: .xBegin = 0 ==> .xBegin_signature = xBegin_signatures[xBegin_0_enum];
@transform_xBegin_0@
expression E;
identifier FP_NAME = xBegin;
@@
(
E.FP_NAME = 0;
+ E.xBegin_signature = xBegin_signatures[xBegin_0_enum];
|
E->FP_NAME = 0;
+ E->xBegin_signature = xBegin_signatures[xBegin_0_enum];
)

// Rule: .xBegin = dbpageBegin ==> .xBegin_signature = xBegin_signatures[xBegin_dbpageBegin_enum];
@transform_xBegin_dbpageBegin@
expression E;
identifier FP_NAME = xBegin;
identifier FUNC_NAME = dbpageBegin;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xBegin_signature = xBegin_signatures[xBegin_dbpageBegin_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xBegin_signature = xBegin_signatures[xBegin_dbpageBegin_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xBegin_signature = xBegin_signatures[xBegin_dbpageBegin_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xBegin_signature = xBegin_signatures[xBegin_dbpageBegin_enum];
)

// Rule: .xBegin = fts3BeginMethod ==> .xBegin_signature = xBegin_signatures[xBegin_fts3BeginMethod_enum];
@transform_xBegin_fts3BeginMethod@
expression E;
identifier FP_NAME = xBegin;
identifier FUNC_NAME = fts3BeginMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xBegin_signature = xBegin_signatures[xBegin_fts3BeginMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xBegin_signature = xBegin_signatures[xBegin_fts3BeginMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xBegin_signature = xBegin_signatures[xBegin_fts3BeginMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xBegin_signature = xBegin_signatures[xBegin_fts3BeginMethod_enum];
)

// Rule: .xBegin = rtreeBeginTransaction ==> .xBegin_signature = xBegin_signatures[xBegin_rtreeBeginTransaction_enum];
@transform_xBegin_rtreeBeginTransaction@
expression E;
identifier FP_NAME = xBegin;
identifier FUNC_NAME = rtreeBeginTransaction;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xBegin_signature = xBegin_signatures[xBegin_rtreeBeginTransaction_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xBegin_signature = xBegin_signatures[xBegin_rtreeBeginTransaction_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xBegin_signature = xBegin_signatures[xBegin_rtreeBeginTransaction_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xBegin_signature = xBegin_signatures[xBegin_rtreeBeginTransaction_enum];
)

// Rule: .xBegin = zipfileBegin ==> .xBegin_signature = xBegin_signatures[xBegin_zipfileBegin_enum];
@transform_xBegin_zipfileBegin@
expression E;
identifier FP_NAME = xBegin;
identifier FUNC_NAME = zipfileBegin;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xBegin_signature = xBegin_signatures[xBegin_zipfileBegin_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xBegin_signature = xBegin_signatures[xBegin_zipfileBegin_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xBegin_signature = xBegin_signatures[xBegin_zipfileBegin_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xBegin_signature = xBegin_signatures[xBegin_zipfileBegin_enum];
)

// Rules for xBestIndex (16 valid functions, 32 excluded)
// Rule: .xBestIndex = bytecodevtabBestIndex ==> .xBestIndex_signature = xBestIndex_signatures[xBestIndex_bytecodevtabBestIndex_enum];
@transform_xBestIndex_bytecodevtabBestIndex@
expression E;
identifier FP_NAME = xBestIndex;
identifier FUNC_NAME = bytecodevtabBestIndex;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_bytecodevtabBestIndex_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_bytecodevtabBestIndex_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_bytecodevtabBestIndex_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_bytecodevtabBestIndex_enum];
)

// Rule: .xBestIndex = completionBestIndex ==> .xBestIndex_signature = xBestIndex_signatures[xBestIndex_completionBestIndex_enum];
@transform_xBestIndex_completionBestIndex@
expression E;
identifier FP_NAME = xBestIndex;
identifier FUNC_NAME = completionBestIndex;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_completionBestIndex_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_completionBestIndex_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_completionBestIndex_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_completionBestIndex_enum];
)

// Rule: .xBestIndex = dbdataBestIndex ==> .xBestIndex_signature = xBestIndex_signatures[xBestIndex_dbdataBestIndex_enum];
@transform_xBestIndex_dbdataBestIndex@
expression E;
identifier FP_NAME = xBestIndex;
identifier FUNC_NAME = dbdataBestIndex;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_dbdataBestIndex_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_dbdataBestIndex_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_dbdataBestIndex_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_dbdataBestIndex_enum];
)

// Rule: .xBestIndex = dbpageBestIndex ==> .xBestIndex_signature = xBestIndex_signatures[xBestIndex_dbpageBestIndex_enum];
@transform_xBestIndex_dbpageBestIndex@
expression E;
identifier FP_NAME = xBestIndex;
identifier FUNC_NAME = dbpageBestIndex;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_dbpageBestIndex_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_dbpageBestIndex_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_dbpageBestIndex_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_dbpageBestIndex_enum];
)

// Rule: .xBestIndex = expertBestIndex ==> .xBestIndex_signature = xBestIndex_signatures[xBestIndex_expertBestIndex_enum];
@transform_xBestIndex_expertBestIndex@
expression E;
identifier FP_NAME = xBestIndex;
identifier FUNC_NAME = expertBestIndex;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_expertBestIndex_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_expertBestIndex_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_expertBestIndex_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_expertBestIndex_enum];
)

// Rule: .xBestIndex = fsdirBestIndex ==> .xBestIndex_signature = xBestIndex_signatures[xBestIndex_fsdirBestIndex_enum];
@transform_xBestIndex_fsdirBestIndex@
expression E;
identifier FP_NAME = xBestIndex;
identifier FUNC_NAME = fsdirBestIndex;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_fsdirBestIndex_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_fsdirBestIndex_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_fsdirBestIndex_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_fsdirBestIndex_enum];
)

// Rule: .xBestIndex = fts3BestIndexMethod ==> .xBestIndex_signature = xBestIndex_signatures[xBestIndex_fts3BestIndexMethod_enum];
@transform_xBestIndex_fts3BestIndexMethod@
expression E;
identifier FP_NAME = xBestIndex;
identifier FUNC_NAME = fts3BestIndexMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_fts3BestIndexMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_fts3BestIndexMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_fts3BestIndexMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_fts3BestIndexMethod_enum];
)

// Rule: .xBestIndex = fts3auxBestIndexMethod ==> .xBestIndex_signature = xBestIndex_signatures[xBestIndex_fts3auxBestIndexMethod_enum];
@transform_xBestIndex_fts3auxBestIndexMethod@
expression E;
identifier FP_NAME = xBestIndex;
identifier FUNC_NAME = fts3auxBestIndexMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_fts3auxBestIndexMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_fts3auxBestIndexMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_fts3auxBestIndexMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_fts3auxBestIndexMethod_enum];
)

// Rule: .xBestIndex = fts3tokBestIndexMethod ==> .xBestIndex_signature = xBestIndex_signatures[xBestIndex_fts3tokBestIndexMethod_enum];
@transform_xBestIndex_fts3tokBestIndexMethod@
expression E;
identifier FP_NAME = xBestIndex;
identifier FUNC_NAME = fts3tokBestIndexMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_fts3tokBestIndexMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_fts3tokBestIndexMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_fts3tokBestIndexMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_fts3tokBestIndexMethod_enum];
)

// Rule: .xBestIndex = jsonEachBestIndex ==> .xBestIndex_signature = xBestIndex_signatures[xBestIndex_jsonEachBestIndex_enum];
@transform_xBestIndex_jsonEachBestIndex@
expression E;
identifier FP_NAME = xBestIndex;
identifier FUNC_NAME = jsonEachBestIndex;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_jsonEachBestIndex_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_jsonEachBestIndex_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_jsonEachBestIndex_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_jsonEachBestIndex_enum];
)

// Rule: .xBestIndex = pragmaVtabBestIndex ==> .xBestIndex_signature = xBestIndex_signatures[xBestIndex_pragmaVtabBestIndex_enum];
@transform_xBestIndex_pragmaVtabBestIndex@
expression E;
identifier FP_NAME = xBestIndex;
identifier FUNC_NAME = pragmaVtabBestIndex;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_pragmaVtabBestIndex_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_pragmaVtabBestIndex_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_pragmaVtabBestIndex_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_pragmaVtabBestIndex_enum];
)

// Rule: .xBestIndex = rtreeBestIndex ==> .xBestIndex_signature = xBestIndex_signatures[xBestIndex_rtreeBestIndex_enum];
@transform_xBestIndex_rtreeBestIndex@
expression E;
identifier FP_NAME = xBestIndex;
identifier FUNC_NAME = rtreeBestIndex;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_rtreeBestIndex_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_rtreeBestIndex_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_rtreeBestIndex_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_rtreeBestIndex_enum];
)

// Rule: .xBestIndex = seriesBestIndex ==> .xBestIndex_signature = xBestIndex_signatures[xBestIndex_seriesBestIndex_enum];
@transform_xBestIndex_seriesBestIndex@
expression E;
identifier FP_NAME = xBestIndex;
identifier FUNC_NAME = seriesBestIndex;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_seriesBestIndex_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_seriesBestIndex_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_seriesBestIndex_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_seriesBestIndex_enum];
)

// Rule: .xBestIndex = statBestIndex ==> .xBestIndex_signature = xBestIndex_signatures[xBestIndex_statBestIndex_enum];
@transform_xBestIndex_statBestIndex@
expression E;
identifier FP_NAME = xBestIndex;
identifier FUNC_NAME = statBestIndex;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_statBestIndex_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_statBestIndex_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_statBestIndex_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_statBestIndex_enum];
)

// Rule: .xBestIndex = stmtBestIndex ==> .xBestIndex_signature = xBestIndex_signatures[xBestIndex_stmtBestIndex_enum];
@transform_xBestIndex_stmtBestIndex@
expression E;
identifier FP_NAME = xBestIndex;
identifier FUNC_NAME = stmtBestIndex;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_stmtBestIndex_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_stmtBestIndex_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_stmtBestIndex_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_stmtBestIndex_enum];
)

// Rule: .xBestIndex = zipfileBestIndex ==> .xBestIndex_signature = xBestIndex_signatures[xBestIndex_zipfileBestIndex_enum];
@transform_xBestIndex_zipfileBestIndex@
expression E;
identifier FP_NAME = xBestIndex;
identifier FUNC_NAME = zipfileBestIndex;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_zipfileBestIndex_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xBestIndex_signature = xBestIndex_signatures[xBestIndex_zipfileBestIndex_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_zipfileBestIndex_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xBestIndex_signature = xBestIndex_signatures[xBestIndex_zipfileBestIndex_enum];
)

// Rules for xBusy (1 valid functions, 1 excluded)
// Rule: .xBusy = 0 ==> .xBusy_signature = xBusy_signatures[xBusy_0_enum];
@transform_xBusy_0@
expression E;
identifier FP_NAME = xBusy;
@@
(
E.FP_NAME = 0;
+ E.xBusy_signature = xBusy_signatures[xBusy_0_enum];
|
E->FP_NAME = 0;
+ E->xBusy_signature = xBusy_signatures[xBusy_0_enum];
)

// Rules for xBusyHandler (1 valid functions, 2 excluded)
// Rule: .xBusyHandler = 0 ==> .xBusyHandler_signature = xBusyHandler_signatures[xBusyHandler_0_enum];
@transform_xBusyHandler_0@
expression E;
identifier FP_NAME = xBusyHandler;
@@
(
E.FP_NAME = 0;
+ E.xBusyHandler_signature = xBusyHandler_signatures[xBusyHandler_0_enum];
|
E->FP_NAME = 0;
+ E->xBusyHandler_signature = xBusyHandler_signatures[xBusyHandler_0_enum];
)

// Rules for xCachesize (2 valid functions, 2 excluded)
// Rule: .xCachesize = pcache1Cachesize ==> .xCachesize_signature = xCachesize_signatures[xCachesize_pcache1Cachesize_enum];
@transform_xCachesize_pcache1Cachesize@
expression E;
identifier FP_NAME = xCachesize;
identifier FUNC_NAME = pcache1Cachesize;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCachesize_signature = xCachesize_signatures[xCachesize_pcache1Cachesize_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCachesize_signature = xCachesize_signatures[xCachesize_pcache1Cachesize_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCachesize_signature = xCachesize_signatures[xCachesize_pcache1Cachesize_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCachesize_signature = xCachesize_signatures[xCachesize_pcache1Cachesize_enum];
)

// Rule: .xCachesize = pcachetraceCachesize ==> .xCachesize_signature = xCachesize_signatures[xCachesize_pcachetraceCachesize_enum];
@transform_xCachesize_pcachetraceCachesize@
expression E;
identifier FP_NAME = xCachesize;
identifier FUNC_NAME = pcachetraceCachesize;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCachesize_signature = xCachesize_signatures[xCachesize_pcachetraceCachesize_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCachesize_signature = xCachesize_signatures[xCachesize_pcachetraceCachesize_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCachesize_signature = xCachesize_signatures[xCachesize_pcachetraceCachesize_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCachesize_signature = xCachesize_signatures[xCachesize_pcachetraceCachesize_enum];
)

// Rules for xCellSize (4 valid functions, 0 excluded)
// Rule: .xCellSize = cellSizePtr ==> .xCellSize_signature = xCellSize_signatures[xCellSize_cellSizePtr_enum];
@transform_xCellSize_cellSizePtr@
expression E;
identifier FP_NAME = xCellSize;
identifier FUNC_NAME = cellSizePtr;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCellSize_signature = xCellSize_signatures[xCellSize_cellSizePtr_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCellSize_signature = xCellSize_signatures[xCellSize_cellSizePtr_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCellSize_signature = xCellSize_signatures[xCellSize_cellSizePtr_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCellSize_signature = xCellSize_signatures[xCellSize_cellSizePtr_enum];
)

// Rule: .xCellSize = cellSizePtrIdxLeaf ==> .xCellSize_signature = xCellSize_signatures[xCellSize_cellSizePtrIdxLeaf_enum];
@transform_xCellSize_cellSizePtrIdxLeaf@
expression E;
identifier FP_NAME = xCellSize;
identifier FUNC_NAME = cellSizePtrIdxLeaf;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCellSize_signature = xCellSize_signatures[xCellSize_cellSizePtrIdxLeaf_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCellSize_signature = xCellSize_signatures[xCellSize_cellSizePtrIdxLeaf_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCellSize_signature = xCellSize_signatures[xCellSize_cellSizePtrIdxLeaf_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCellSize_signature = xCellSize_signatures[xCellSize_cellSizePtrIdxLeaf_enum];
)

// Rule: .xCellSize = cellSizePtrNoPayload ==> .xCellSize_signature = xCellSize_signatures[xCellSize_cellSizePtrNoPayload_enum];
@transform_xCellSize_cellSizePtrNoPayload@
expression E;
identifier FP_NAME = xCellSize;
identifier FUNC_NAME = cellSizePtrNoPayload;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCellSize_signature = xCellSize_signatures[xCellSize_cellSizePtrNoPayload_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCellSize_signature = xCellSize_signatures[xCellSize_cellSizePtrNoPayload_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCellSize_signature = xCellSize_signatures[xCellSize_cellSizePtrNoPayload_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCellSize_signature = xCellSize_signatures[xCellSize_cellSizePtrNoPayload_enum];
)

// Rule: .xCellSize = cellSizePtrTableLeaf ==> .xCellSize_signature = xCellSize_signatures[xCellSize_cellSizePtrTableLeaf_enum];
@transform_xCellSize_cellSizePtrTableLeaf@
expression E;
identifier FP_NAME = xCellSize;
identifier FUNC_NAME = cellSizePtrTableLeaf;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCellSize_signature = xCellSize_signatures[xCellSize_cellSizePtrTableLeaf_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCellSize_signature = xCellSize_signatures[xCellSize_cellSizePtrTableLeaf_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCellSize_signature = xCellSize_signatures[xCellSize_cellSizePtrTableLeaf_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCellSize_signature = xCellSize_signatures[xCellSize_cellSizePtrTableLeaf_enum];
)

// Rules for xCheckReservedLock (7 valid functions, 22 excluded)
// Rule: .xCheckReservedLock = 0 ==> .xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_0_enum];
@transform_xCheckReservedLock_0@
expression E;
identifier FP_NAME = xCheckReservedLock;
@@
(
E.FP_NAME = 0;
+ E.xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_0_enum];
|
E->FP_NAME = 0;
+ E->xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_0_enum];
)

// Rule: .xCheckReservedLock = apndCheckReservedLock ==> .xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_apndCheckReservedLock_enum];
@transform_xCheckReservedLock_apndCheckReservedLock@
expression E;
identifier FP_NAME = xCheckReservedLock;
identifier FUNC_NAME = apndCheckReservedLock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_apndCheckReservedLock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_apndCheckReservedLock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_apndCheckReservedLock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_apndCheckReservedLock_enum];
)

// Rule: .xCheckReservedLock = recoverVfsCheckReservedLock ==> .xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_recoverVfsCheckReservedLock_enum];
@transform_xCheckReservedLock_recoverVfsCheckReservedLock@
expression E;
identifier FP_NAME = xCheckReservedLock;
identifier FUNC_NAME = recoverVfsCheckReservedLock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_recoverVfsCheckReservedLock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_recoverVfsCheckReservedLock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_recoverVfsCheckReservedLock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_recoverVfsCheckReservedLock_enum];
)

// Rule: .xCheckReservedLock = vfstraceCheckReservedLock ==> .xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_vfstraceCheckReservedLock_enum];
@transform_xCheckReservedLock_vfstraceCheckReservedLock@
expression E;
identifier FP_NAME = xCheckReservedLock;
identifier FUNC_NAME = vfstraceCheckReservedLock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_vfstraceCheckReservedLock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_vfstraceCheckReservedLock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_vfstraceCheckReservedLock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_vfstraceCheckReservedLock_enum];
)

// Rule: .xCheckReservedLock = unixCheckReservedLock ==> .xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_unixCheckReservedLock_enum];
@transform_xCheckReservedLock_unixCheckReservedLock@
expression E;
identifier FP_NAME = xCheckReservedLock;
identifier FUNC_NAME = unixCheckReservedLock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_unixCheckReservedLock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_unixCheckReservedLock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_unixCheckReservedLock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_unixCheckReservedLock_enum];
)

// Rule: .xCheckReservedLock = nolockCheckReservedLock ==> .xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_nolockCheckReservedLock_enum];
@transform_xCheckReservedLock_nolockCheckReservedLock@
expression E;
identifier FP_NAME = xCheckReservedLock;
identifier FUNC_NAME = nolockCheckReservedLock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_nolockCheckReservedLock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_nolockCheckReservedLock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_nolockCheckReservedLock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_nolockCheckReservedLock_enum];
)

// Rule: .xCheckReservedLock = dotlockCheckReservedLock ==> .xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_dotlockCheckReservedLock_enum];
@transform_xCheckReservedLock_dotlockCheckReservedLock@
expression E;
identifier FP_NAME = xCheckReservedLock;
identifier FUNC_NAME = dotlockCheckReservedLock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_dotlockCheckReservedLock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_dotlockCheckReservedLock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_dotlockCheckReservedLock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_dotlockCheckReservedLock_enum];
)

// Rules for xClose (27 valid functions, 52 excluded)
// Rule: .xClose = apndClose ==> .xClose_signature = xClose_signatures[xClose_apndClose_enum];
@transform_xClose_apndClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = apndClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_apndClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_apndClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_apndClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_apndClose_enum];
)

// Rule: .xClose = bytecodevtabClose ==> .xClose_signature = xClose_signatures[xClose_bytecodevtabClose_enum];
@transform_xClose_bytecodevtabClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = bytecodevtabClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_bytecodevtabClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_bytecodevtabClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_bytecodevtabClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_bytecodevtabClose_enum];
)

// Rule: .xClose = completionClose ==> .xClose_signature = xClose_signatures[xClose_completionClose_enum];
@transform_xClose_completionClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = completionClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_completionClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_completionClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_completionClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_completionClose_enum];
)

// Rule: .xClose = dbdataClose ==> .xClose_signature = xClose_signatures[xClose_dbdataClose_enum];
@transform_xClose_dbdataClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = dbdataClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_dbdataClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_dbdataClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_dbdataClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_dbdataClose_enum];
)

// Rule: .xClose = dbpageClose ==> .xClose_signature = xClose_signatures[xClose_dbpageClose_enum];
@transform_xClose_dbpageClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = dbpageClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_dbpageClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_dbpageClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_dbpageClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_dbpageClose_enum];
)

// Rule: .xClose = expertClose ==> .xClose_signature = xClose_signatures[xClose_expertClose_enum];
@transform_xClose_expertClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = expertClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_expertClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_expertClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_expertClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_expertClose_enum];
)

// Rule: .xClose = fsdirClose ==> .xClose_signature = xClose_signatures[xClose_fsdirClose_enum];
@transform_xClose_fsdirClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = fsdirClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_fsdirClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_fsdirClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_fsdirClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_fsdirClose_enum];
)

// Rule: .xClose = fts3CloseMethod ==> .xClose_signature = xClose_signatures[xClose_fts3CloseMethod_enum];
@transform_xClose_fts3CloseMethod@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = fts3CloseMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_fts3CloseMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_fts3CloseMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_fts3CloseMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_fts3CloseMethod_enum];
)

// Rule: .xClose = fts3auxCloseMethod ==> .xClose_signature = xClose_signatures[xClose_fts3auxCloseMethod_enum];
@transform_xClose_fts3auxCloseMethod@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = fts3auxCloseMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_fts3auxCloseMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_fts3auxCloseMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_fts3auxCloseMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_fts3auxCloseMethod_enum];
)

// Rule: .xClose = fts3tokCloseMethod ==> .xClose_signature = xClose_signatures[xClose_fts3tokCloseMethod_enum];
@transform_xClose_fts3tokCloseMethod@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = fts3tokCloseMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_fts3tokCloseMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_fts3tokCloseMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_fts3tokCloseMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_fts3tokCloseMethod_enum];
)

// Rule: .xClose = jsonEachClose ==> .xClose_signature = xClose_signatures[xClose_jsonEachClose_enum];
@transform_xClose_jsonEachClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = jsonEachClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_jsonEachClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_jsonEachClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_jsonEachClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_jsonEachClose_enum];
)

// Rule: .xClose = memdbClose ==> .xClose_signature = xClose_signatures[xClose_memdbClose_enum];
@transform_xClose_memdbClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = memdbClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_memdbClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_memdbClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_memdbClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_memdbClose_enum];
)

// Rule: .xClose = memjrnlClose ==> .xClose_signature = xClose_signatures[xClose_memjrnlClose_enum];
@transform_xClose_memjrnlClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = memjrnlClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_memjrnlClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_memjrnlClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_memjrnlClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_memjrnlClose_enum];
)

// Rule: .xClose = porterClose ==> .xClose_signature = xClose_signatures[xClose_porterClose_enum];
@transform_xClose_porterClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = porterClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_porterClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_porterClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_porterClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_porterClose_enum];
)

// Rule: .xClose = pragmaVtabClose ==> .xClose_signature = xClose_signatures[xClose_pragmaVtabClose_enum];
@transform_xClose_pragmaVtabClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = pragmaVtabClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_pragmaVtabClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_pragmaVtabClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_pragmaVtabClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_pragmaVtabClose_enum];
)

// Rule: .xClose = recoverVfsClose ==> .xClose_signature = xClose_signatures[xClose_recoverVfsClose_enum];
@transform_xClose_recoverVfsClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = recoverVfsClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_recoverVfsClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_recoverVfsClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_recoverVfsClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_recoverVfsClose_enum];
)

// Rule: .xClose = rtreeClose ==> .xClose_signature = xClose_signatures[xClose_rtreeClose_enum];
@transform_xClose_rtreeClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = rtreeClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_rtreeClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_rtreeClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_rtreeClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_rtreeClose_enum];
)

// Rule: .xClose = seriesClose ==> .xClose_signature = xClose_signatures[xClose_seriesClose_enum];
@transform_xClose_seriesClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = seriesClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_seriesClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_seriesClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_seriesClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_seriesClose_enum];
)

// Rule: .xClose = simpleClose ==> .xClose_signature = xClose_signatures[xClose_simpleClose_enum];
@transform_xClose_simpleClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = simpleClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_simpleClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_simpleClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_simpleClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_simpleClose_enum];
)

// Rule: .xClose = statClose ==> .xClose_signature = xClose_signatures[xClose_statClose_enum];
@transform_xClose_statClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = statClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_statClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_statClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_statClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_statClose_enum];
)

// Rule: .xClose = stmtClose ==> .xClose_signature = xClose_signatures[xClose_stmtClose_enum];
@transform_xClose_stmtClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = stmtClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_stmtClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_stmtClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_stmtClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_stmtClose_enum];
)

// Rule: .xClose = unicodeClose ==> .xClose_signature = xClose_signatures[xClose_unicodeClose_enum];
@transform_xClose_unicodeClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = unicodeClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_unicodeClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_unicodeClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_unicodeClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_unicodeClose_enum];
)

// Rule: .xClose = vfstraceClose ==> .xClose_signature = xClose_signatures[xClose_vfstraceClose_enum];
@transform_xClose_vfstraceClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = vfstraceClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_vfstraceClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_vfstraceClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_vfstraceClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_vfstraceClose_enum];
)

// Rule: .xClose = zipfileClose ==> .xClose_signature = xClose_signatures[xClose_zipfileClose_enum];
@transform_xClose_zipfileClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = zipfileClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_zipfileClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_zipfileClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_zipfileClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_zipfileClose_enum];
)

// Rule: .xClose = unixClose ==> .xClose_signature = xClose_signatures[xClose_unixClose_enum];
@transform_xClose_unixClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = unixClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_unixClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_unixClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_unixClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_unixClose_enum];
)

// Rule: .xClose = nolockClose ==> .xClose_signature = xClose_signatures[xClose_nolockClose_enum];
@transform_xClose_nolockClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = nolockClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_nolockClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_nolockClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_nolockClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_nolockClose_enum];
)

// Rule: .xClose = dotlockClose ==> .xClose_signature = xClose_signatures[xClose_dotlockClose_enum];
@transform_xClose_dotlockClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = dotlockClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_dotlockClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xClose_signature = xClose_signatures[xClose_dotlockClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_dotlockClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xClose_signature = xClose_signatures[xClose_dotlockClose_enum];
)

// Rules for xColumn (44 valid functions, 4 excluded)
// Rule: .xColumn = amatchColumn ==> .xColumn_signature = xColumn_signatures[xColumn_amatchColumn_enum];
@transform_xColumn_amatchColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = amatchColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_amatchColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_amatchColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_amatchColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_amatchColumn_enum];
)

// Rule: .xColumn = binfoColumn ==> .xColumn_signature = xColumn_signatures[xColumn_binfoColumn_enum];
@transform_xColumn_binfoColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = binfoColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_binfoColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_binfoColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_binfoColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_binfoColumn_enum];
)

// Rule: .xColumn = bytecodevtabColumn ==> .xColumn_signature = xColumn_signatures[xColumn_bytecodevtabColumn_enum];
@transform_xColumn_bytecodevtabColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = bytecodevtabColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_bytecodevtabColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_bytecodevtabColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_bytecodevtabColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_bytecodevtabColumn_enum];
)

// Rule: .xColumn = carrayColumn ==> .xColumn_signature = xColumn_signatures[xColumn_carrayColumn_enum];
@transform_xColumn_carrayColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = carrayColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_carrayColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_carrayColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_carrayColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_carrayColumn_enum];
)

// Rule: .xColumn = cidxColumn ==> .xColumn_signature = xColumn_signatures[xColumn_cidxColumn_enum];
@transform_xColumn_cidxColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = cidxColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_cidxColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_cidxColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_cidxColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_cidxColumn_enum];
)

// Rule: .xColumn = closureColumn ==> .xColumn_signature = xColumn_signatures[xColumn_closureColumn_enum];
@transform_xColumn_closureColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = closureColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_closureColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_closureColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_closureColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_closureColumn_enum];
)

// Rule: .xColumn = completionColumn ==> .xColumn_signature = xColumn_signatures[xColumn_completionColumn_enum];
@transform_xColumn_completionColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = completionColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_completionColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_completionColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_completionColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_completionColumn_enum];
)

// Rule: .xColumn = csvtabColumn ==> .xColumn_signature = xColumn_signatures[xColumn_csvtabColumn_enum];
@transform_xColumn_csvtabColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = csvtabColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_csvtabColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_csvtabColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_csvtabColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_csvtabColumn_enum];
)

// Rule: .xColumn = dbdataColumn ==> .xColumn_signature = xColumn_signatures[xColumn_dbdataColumn_enum];
@transform_xColumn_dbdataColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = dbdataColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_dbdataColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_dbdataColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_dbdataColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_dbdataColumn_enum];
)

// Rule: .xColumn = dbpageColumn ==> .xColumn_signature = xColumn_signatures[xColumn_dbpageColumn_enum];
@transform_xColumn_dbpageColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = dbpageColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_dbpageColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_dbpageColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_dbpageColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_dbpageColumn_enum];
)

// Rule: .xColumn = deltaparsevtabColumn ==> .xColumn_signature = xColumn_signatures[xColumn_deltaparsevtabColumn_enum];
@transform_xColumn_deltaparsevtabColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = deltaparsevtabColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_deltaparsevtabColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_deltaparsevtabColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_deltaparsevtabColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_deltaparsevtabColumn_enum];
)

// Rule: .xColumn = echoColumn ==> .xColumn_signature = xColumn_signatures[xColumn_echoColumn_enum];
@transform_xColumn_echoColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = echoColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_echoColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_echoColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_echoColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_echoColumn_enum];
)

// Rule: .xColumn = expertColumn ==> .xColumn_signature = xColumn_signatures[xColumn_expertColumn_enum];
@transform_xColumn_expertColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = expertColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_expertColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_expertColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_expertColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_expertColumn_enum];
)

// Rule: .xColumn = explainColumn ==> .xColumn_signature = xColumn_signatures[xColumn_explainColumn_enum];
@transform_xColumn_explainColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = explainColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_explainColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_explainColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_explainColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_explainColumn_enum];
)

// Rule: .xColumn = fsColumn ==> .xColumn_signature = xColumn_signatures[xColumn_fsColumn_enum];
@transform_xColumn_fsColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = fsColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_fsColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_fsColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_fsColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_fsColumn_enum];
)

// Rule: .xColumn = fsdirColumn ==> .xColumn_signature = xColumn_signatures[xColumn_fsdirColumn_enum];
@transform_xColumn_fsdirColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = fsdirColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_fsdirColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_fsdirColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_fsdirColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_fsdirColumn_enum];
)

// Rule: .xColumn = fstreeColumn ==> .xColumn_signature = xColumn_signatures[xColumn_fstreeColumn_enum];
@transform_xColumn_fstreeColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = fstreeColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_fstreeColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_fstreeColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_fstreeColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_fstreeColumn_enum];
)

// Rule: .xColumn = fts3ColumnMethod ==> .xColumn_signature = xColumn_signatures[xColumn_fts3ColumnMethod_enum];
@transform_xColumn_fts3ColumnMethod@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = fts3ColumnMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_fts3ColumnMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_fts3ColumnMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_fts3ColumnMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_fts3ColumnMethod_enum];
)

// Rule: .xColumn = fts3auxColumnMethod ==> .xColumn_signature = xColumn_signatures[xColumn_fts3auxColumnMethod_enum];
@transform_xColumn_fts3auxColumnMethod@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = fts3auxColumnMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_fts3auxColumnMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_fts3auxColumnMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_fts3auxColumnMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_fts3auxColumnMethod_enum];
)

// Rule: .xColumn = fts3termColumnMethod ==> .xColumn_signature = xColumn_signatures[xColumn_fts3termColumnMethod_enum];
@transform_xColumn_fts3termColumnMethod@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = fts3termColumnMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_fts3termColumnMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_fts3termColumnMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_fts3termColumnMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_fts3termColumnMethod_enum];
)

// Rule: .xColumn = fts3tokColumnMethod ==> .xColumn_signature = xColumn_signatures[xColumn_fts3tokColumnMethod_enum];
@transform_xColumn_fts3tokColumnMethod@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = fts3tokColumnMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_fts3tokColumnMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_fts3tokColumnMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_fts3tokColumnMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_fts3tokColumnMethod_enum];
)

// Rule: .xColumn = fuzzerColumn ==> .xColumn_signature = xColumn_signatures[xColumn_fuzzerColumn_enum];
@transform_xColumn_fuzzerColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = fuzzerColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_fuzzerColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_fuzzerColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_fuzzerColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_fuzzerColumn_enum];
)

// Rule: .xColumn = geopolyColumn ==> .xColumn_signature = xColumn_signatures[xColumn_geopolyColumn_enum];
@transform_xColumn_geopolyColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = geopolyColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_geopolyColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_geopolyColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_geopolyColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_geopolyColumn_enum];
)

// Rule: .xColumn = intarrayColumn ==> .xColumn_signature = xColumn_signatures[xColumn_intarrayColumn_enum];
@transform_xColumn_intarrayColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = intarrayColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_intarrayColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_intarrayColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_intarrayColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_intarrayColumn_enum];
)

// Rule: .xColumn = jsonEachColumn ==> .xColumn_signature = xColumn_signatures[xColumn_jsonEachColumn_enum];
@transform_xColumn_jsonEachColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = jsonEachColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_jsonEachColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_jsonEachColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_jsonEachColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_jsonEachColumn_enum];
)

// Rule: .xColumn = memstatColumn ==> .xColumn_signature = xColumn_signatures[xColumn_memstatColumn_enum];
@transform_xColumn_memstatColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = memstatColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_memstatColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_memstatColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_memstatColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_memstatColumn_enum];
)

// Rule: .xColumn = pragmaVtabColumn ==> .xColumn_signature = xColumn_signatures[xColumn_pragmaVtabColumn_enum];
@transform_xColumn_pragmaVtabColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = pragmaVtabColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_pragmaVtabColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_pragmaVtabColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_pragmaVtabColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_pragmaVtabColumn_enum];
)

// Rule: .xColumn = prefixesColumn ==> .xColumn_signature = xColumn_signatures[xColumn_prefixesColumn_enum];
@transform_xColumn_prefixesColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = prefixesColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_prefixesColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_prefixesColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_prefixesColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_prefixesColumn_enum];
)

// Rule: .xColumn = qpvtabColumn ==> .xColumn_signature = xColumn_signatures[xColumn_qpvtabColumn_enum];
@transform_xColumn_qpvtabColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = qpvtabColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_qpvtabColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_qpvtabColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_qpvtabColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_qpvtabColumn_enum];
)

// Rule: .xColumn = rtreeColumn ==> .xColumn_signature = xColumn_signatures[xColumn_rtreeColumn_enum];
@transform_xColumn_rtreeColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = rtreeColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_rtreeColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_rtreeColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_rtreeColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_rtreeColumn_enum];
)

// Rule: .xColumn = schemaColumn ==> .xColumn_signature = xColumn_signatures[xColumn_schemaColumn_enum];
@transform_xColumn_schemaColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = schemaColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_schemaColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_schemaColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_schemaColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_schemaColumn_enum];
)

// Rule: .xColumn = seriesColumn ==> .xColumn_signature = xColumn_signatures[xColumn_seriesColumn_enum];
@transform_xColumn_seriesColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = seriesColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_seriesColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_seriesColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_seriesColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_seriesColumn_enum];
)

// Rule: .xColumn = spellfix1Column ==> .xColumn_signature = xColumn_signatures[xColumn_spellfix1Column_enum];
@transform_xColumn_spellfix1Column@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = spellfix1Column;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_spellfix1Column_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_spellfix1Column_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_spellfix1Column_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_spellfix1Column_enum];
)

// Rule: .xColumn = statColumn ==> .xColumn_signature = xColumn_signatures[xColumn_statColumn_enum];
@transform_xColumn_statColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = statColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_statColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_statColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_statColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_statColumn_enum];
)

// Rule: .xColumn = stmtColumn ==> .xColumn_signature = xColumn_signatures[xColumn_stmtColumn_enum];
@transform_xColumn_stmtColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = stmtColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_stmtColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_stmtColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_stmtColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_stmtColumn_enum];
)

// Rule: .xColumn = tclColumn ==> .xColumn_signature = xColumn_signatures[xColumn_tclColumn_enum];
@transform_xColumn_tclColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = tclColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_tclColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_tclColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_tclColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_tclColumn_enum];
)

// Rule: .xColumn = tclvarColumn ==> .xColumn_signature = xColumn_signatures[xColumn_tclvarColumn_enum];
@transform_xColumn_tclvarColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = tclvarColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_tclvarColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_tclvarColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_tclvarColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_tclvarColumn_enum];
)

// Rule: .xColumn = templatevtabColumn ==> .xColumn_signature = xColumn_signatures[xColumn_templatevtabColumn_enum];
@transform_xColumn_templatevtabColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = templatevtabColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_templatevtabColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_templatevtabColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_templatevtabColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_templatevtabColumn_enum];
)

// Rule: .xColumn = unionColumn ==> .xColumn_signature = xColumn_signatures[xColumn_unionColumn_enum];
@transform_xColumn_unionColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = unionColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_unionColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_unionColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_unionColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_unionColumn_enum];
)

// Rule: .xColumn = vlogColumn ==> .xColumn_signature = xColumn_signatures[xColumn_vlogColumn_enum];
@transform_xColumn_vlogColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = vlogColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_vlogColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_vlogColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_vlogColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_vlogColumn_enum];
)

// Rule: .xColumn = vstattabColumn ==> .xColumn_signature = xColumn_signatures[xColumn_vstattabColumn_enum];
@transform_xColumn_vstattabColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = vstattabColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_vstattabColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_vstattabColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_vstattabColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_vstattabColumn_enum];
)

// Rule: .xColumn = vtablogColumn ==> .xColumn_signature = xColumn_signatures[xColumn_vtablogColumn_enum];
@transform_xColumn_vtablogColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = vtablogColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_vtablogColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_vtablogColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_vtablogColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_vtablogColumn_enum];
)

// Rule: .xColumn = wholenumberColumn ==> .xColumn_signature = xColumn_signatures[xColumn_wholenumberColumn_enum];
@transform_xColumn_wholenumberColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = wholenumberColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_wholenumberColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_wholenumberColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_wholenumberColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_wholenumberColumn_enum];
)

// Rule: .xColumn = zipfileColumn ==> .xColumn_signature = xColumn_signatures[xColumn_zipfileColumn_enum];
@transform_xColumn_zipfileColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME = zipfileColumn;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_zipfileColumn_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xColumn_signature = xColumn_signatures[xColumn_zipfileColumn_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_zipfileColumn_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xColumn_signature = xColumn_signatures[xColumn_zipfileColumn_enum];
)

// Rules for xCommit (6 valid functions, 1 excluded)
// Rule: .xCommit = 0 ==> .xCommit_signature = xCommit_signatures[xCommit_0_enum];
@transform_xCommit_0@
expression E;
identifier FP_NAME = xCommit;
@@
(
E.FP_NAME = 0;
+ E.xCommit_signature = xCommit_signatures[xCommit_0_enum];
|
E->FP_NAME = 0;
+ E->xCommit_signature = xCommit_signatures[xCommit_0_enum];
)

// Rule: .xCommit = echoCommit ==> .xCommit_signature = xCommit_signatures[xCommit_echoCommit_enum];
@transform_xCommit_echoCommit@
expression E;
identifier FP_NAME = xCommit;
identifier FUNC_NAME = echoCommit;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCommit_signature = xCommit_signatures[xCommit_echoCommit_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCommit_signature = xCommit_signatures[xCommit_echoCommit_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCommit_signature = xCommit_signatures[xCommit_echoCommit_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCommit_signature = xCommit_signatures[xCommit_echoCommit_enum];
)

// Rule: .xCommit = fts3CommitMethod ==> .xCommit_signature = xCommit_signatures[xCommit_fts3CommitMethod_enum];
@transform_xCommit_fts3CommitMethod@
expression E;
identifier FP_NAME = xCommit;
identifier FUNC_NAME = fts3CommitMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCommit_signature = xCommit_signatures[xCommit_fts3CommitMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCommit_signature = xCommit_signatures[xCommit_fts3CommitMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCommit_signature = xCommit_signatures[xCommit_fts3CommitMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCommit_signature = xCommit_signatures[xCommit_fts3CommitMethod_enum];
)

// Rule: .xCommit = rtreeEndTransaction ==> .xCommit_signature = xCommit_signatures[xCommit_rtreeEndTransaction_enum];
@transform_xCommit_rtreeEndTransaction@
expression E;
identifier FP_NAME = xCommit;
identifier FUNC_NAME = rtreeEndTransaction;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCommit_signature = xCommit_signatures[xCommit_rtreeEndTransaction_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCommit_signature = xCommit_signatures[xCommit_rtreeEndTransaction_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCommit_signature = xCommit_signatures[xCommit_rtreeEndTransaction_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCommit_signature = xCommit_signatures[xCommit_rtreeEndTransaction_enum];
)

// Rule: .xCommit = vtablogCommit ==> .xCommit_signature = xCommit_signatures[xCommit_vtablogCommit_enum];
@transform_xCommit_vtablogCommit@
expression E;
identifier FP_NAME = xCommit;
identifier FUNC_NAME = vtablogCommit;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCommit_signature = xCommit_signatures[xCommit_vtablogCommit_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCommit_signature = xCommit_signatures[xCommit_vtablogCommit_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCommit_signature = xCommit_signatures[xCommit_vtablogCommit_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCommit_signature = xCommit_signatures[xCommit_vtablogCommit_enum];
)

// Rule: .xCommit = zipfileCommit ==> .xCommit_signature = xCommit_signatures[xCommit_zipfileCommit_enum];
@transform_xCommit_zipfileCommit@
expression E;
identifier FP_NAME = xCommit;
identifier FUNC_NAME = zipfileCommit;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCommit_signature = xCommit_signatures[xCommit_zipfileCommit_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCommit_signature = xCommit_signatures[xCommit_zipfileCommit_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCommit_signature = xCommit_signatures[xCommit_zipfileCommit_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCommit_signature = xCommit_signatures[xCommit_zipfileCommit_enum];
)

// Rules for xConnect (44 valid functions, 4 excluded)
// Rule: .xConnect = amatchConnect ==> .xConnect_signature = xConnect_signatures[xConnect_amatchConnect_enum];
@transform_xConnect_amatchConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = amatchConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_amatchConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_amatchConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_amatchConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_amatchConnect_enum];
)

// Rule: .xConnect = binfoConnect ==> .xConnect_signature = xConnect_signatures[xConnect_binfoConnect_enum];
@transform_xConnect_binfoConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = binfoConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_binfoConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_binfoConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_binfoConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_binfoConnect_enum];
)

// Rule: .xConnect = bytecodevtabConnect ==> .xConnect_signature = xConnect_signatures[xConnect_bytecodevtabConnect_enum];
@transform_xConnect_bytecodevtabConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = bytecodevtabConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_bytecodevtabConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_bytecodevtabConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_bytecodevtabConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_bytecodevtabConnect_enum];
)

// Rule: .xConnect = carrayConnect ==> .xConnect_signature = xConnect_signatures[xConnect_carrayConnect_enum];
@transform_xConnect_carrayConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = carrayConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_carrayConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_carrayConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_carrayConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_carrayConnect_enum];
)

// Rule: .xConnect = cidxConnect ==> .xConnect_signature = xConnect_signatures[xConnect_cidxConnect_enum];
@transform_xConnect_cidxConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = cidxConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_cidxConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_cidxConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_cidxConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_cidxConnect_enum];
)

// Rule: .xConnect = closureConnect ==> .xConnect_signature = xConnect_signatures[xConnect_closureConnect_enum];
@transform_xConnect_closureConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = closureConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_closureConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_closureConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_closureConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_closureConnect_enum];
)

// Rule: .xConnect = completionConnect ==> .xConnect_signature = xConnect_signatures[xConnect_completionConnect_enum];
@transform_xConnect_completionConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = completionConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_completionConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_completionConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_completionConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_completionConnect_enum];
)

// Rule: .xConnect = csvtabConnect ==> .xConnect_signature = xConnect_signatures[xConnect_csvtabConnect_enum];
@transform_xConnect_csvtabConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = csvtabConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_csvtabConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_csvtabConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_csvtabConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_csvtabConnect_enum];
)

// Rule: .xConnect = dbdataConnect ==> .xConnect_signature = xConnect_signatures[xConnect_dbdataConnect_enum];
@transform_xConnect_dbdataConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = dbdataConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_dbdataConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_dbdataConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_dbdataConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_dbdataConnect_enum];
)

// Rule: .xConnect = dbpageConnect ==> .xConnect_signature = xConnect_signatures[xConnect_dbpageConnect_enum];
@transform_xConnect_dbpageConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = dbpageConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_dbpageConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_dbpageConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_dbpageConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_dbpageConnect_enum];
)

// Rule: .xConnect = deltaparsevtabConnect ==> .xConnect_signature = xConnect_signatures[xConnect_deltaparsevtabConnect_enum];
@transform_xConnect_deltaparsevtabConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = deltaparsevtabConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_deltaparsevtabConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_deltaparsevtabConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_deltaparsevtabConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_deltaparsevtabConnect_enum];
)

// Rule: .xConnect = echoConnect ==> .xConnect_signature = xConnect_signatures[xConnect_echoConnect_enum];
@transform_xConnect_echoConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = echoConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_echoConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_echoConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_echoConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_echoConnect_enum];
)

// Rule: .xConnect = expertConnect ==> .xConnect_signature = xConnect_signatures[xConnect_expertConnect_enum];
@transform_xConnect_expertConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = expertConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_expertConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_expertConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_expertConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_expertConnect_enum];
)

// Rule: .xConnect = explainConnect ==> .xConnect_signature = xConnect_signatures[xConnect_explainConnect_enum];
@transform_xConnect_explainConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = explainConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_explainConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_explainConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_explainConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_explainConnect_enum];
)

// Rule: .xConnect = fsConnect ==> .xConnect_signature = xConnect_signatures[xConnect_fsConnect_enum];
@transform_xConnect_fsConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = fsConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_fsConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_fsConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_fsConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_fsConnect_enum];
)

// Rule: .xConnect = fsdirConnect ==> .xConnect_signature = xConnect_signatures[xConnect_fsdirConnect_enum];
@transform_xConnect_fsdirConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = fsdirConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_fsdirConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_fsdirConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_fsdirConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_fsdirConnect_enum];
)

// Rule: .xConnect = fstreeConnect ==> .xConnect_signature = xConnect_signatures[xConnect_fstreeConnect_enum];
@transform_xConnect_fstreeConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = fstreeConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_fstreeConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_fstreeConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_fstreeConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_fstreeConnect_enum];
)

// Rule: .xConnect = fts3ConnectMethod ==> .xConnect_signature = xConnect_signatures[xConnect_fts3ConnectMethod_enum];
@transform_xConnect_fts3ConnectMethod@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = fts3ConnectMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_fts3ConnectMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_fts3ConnectMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_fts3ConnectMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_fts3ConnectMethod_enum];
)

// Rule: .xConnect = fts3auxConnectMethod ==> .xConnect_signature = xConnect_signatures[xConnect_fts3auxConnectMethod_enum];
@transform_xConnect_fts3auxConnectMethod@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = fts3auxConnectMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_fts3auxConnectMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_fts3auxConnectMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_fts3auxConnectMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_fts3auxConnectMethod_enum];
)

// Rule: .xConnect = fts3termConnectMethod ==> .xConnect_signature = xConnect_signatures[xConnect_fts3termConnectMethod_enum];
@transform_xConnect_fts3termConnectMethod@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = fts3termConnectMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_fts3termConnectMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_fts3termConnectMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_fts3termConnectMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_fts3termConnectMethod_enum];
)

// Rule: .xConnect = fts3tokConnectMethod ==> .xConnect_signature = xConnect_signatures[xConnect_fts3tokConnectMethod_enum];
@transform_xConnect_fts3tokConnectMethod@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = fts3tokConnectMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_fts3tokConnectMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_fts3tokConnectMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_fts3tokConnectMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_fts3tokConnectMethod_enum];
)

// Rule: .xConnect = fuzzerConnect ==> .xConnect_signature = xConnect_signatures[xConnect_fuzzerConnect_enum];
@transform_xConnect_fuzzerConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = fuzzerConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_fuzzerConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_fuzzerConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_fuzzerConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_fuzzerConnect_enum];
)

// Rule: .xConnect = geopolyConnect ==> .xConnect_signature = xConnect_signatures[xConnect_geopolyConnect_enum];
@transform_xConnect_geopolyConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = geopolyConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_geopolyConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_geopolyConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_geopolyConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_geopolyConnect_enum];
)

// Rule: .xConnect = intarrayCreate ==> .xConnect_signature = xConnect_signatures[xConnect_intarrayCreate_enum];
@transform_xConnect_intarrayCreate@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = intarrayCreate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_intarrayCreate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_intarrayCreate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_intarrayCreate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_intarrayCreate_enum];
)

// Rule: .xConnect = jsonEachConnect ==> .xConnect_signature = xConnect_signatures[xConnect_jsonEachConnect_enum];
@transform_xConnect_jsonEachConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = jsonEachConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_jsonEachConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_jsonEachConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_jsonEachConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_jsonEachConnect_enum];
)

// Rule: .xConnect = memstatConnect ==> .xConnect_signature = xConnect_signatures[xConnect_memstatConnect_enum];
@transform_xConnect_memstatConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = memstatConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_memstatConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_memstatConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_memstatConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_memstatConnect_enum];
)

// Rule: .xConnect = pragmaVtabConnect ==> .xConnect_signature = xConnect_signatures[xConnect_pragmaVtabConnect_enum];
@transform_xConnect_pragmaVtabConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = pragmaVtabConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_pragmaVtabConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_pragmaVtabConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_pragmaVtabConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_pragmaVtabConnect_enum];
)

// Rule: .xConnect = prefixesConnect ==> .xConnect_signature = xConnect_signatures[xConnect_prefixesConnect_enum];
@transform_xConnect_prefixesConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = prefixesConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_prefixesConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_prefixesConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_prefixesConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_prefixesConnect_enum];
)

// Rule: .xConnect = qpvtabConnect ==> .xConnect_signature = xConnect_signatures[xConnect_qpvtabConnect_enum];
@transform_xConnect_qpvtabConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = qpvtabConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_qpvtabConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_qpvtabConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_qpvtabConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_qpvtabConnect_enum];
)

// Rule: .xConnect = rtreeConnect ==> .xConnect_signature = xConnect_signatures[xConnect_rtreeConnect_enum];
@transform_xConnect_rtreeConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = rtreeConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_rtreeConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_rtreeConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_rtreeConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_rtreeConnect_enum];
)

// Rule: .xConnect = schemaCreate ==> .xConnect_signature = xConnect_signatures[xConnect_schemaCreate_enum];
@transform_xConnect_schemaCreate@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = schemaCreate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_schemaCreate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_schemaCreate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_schemaCreate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_schemaCreate_enum];
)

// Rule: .xConnect = seriesConnect ==> .xConnect_signature = xConnect_signatures[xConnect_seriesConnect_enum];
@transform_xConnect_seriesConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = seriesConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_seriesConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_seriesConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_seriesConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_seriesConnect_enum];
)

// Rule: .xConnect = spellfix1Connect ==> .xConnect_signature = xConnect_signatures[xConnect_spellfix1Connect_enum];
@transform_xConnect_spellfix1Connect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = spellfix1Connect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_spellfix1Connect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_spellfix1Connect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_spellfix1Connect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_spellfix1Connect_enum];
)

// Rule: .xConnect = statConnect ==> .xConnect_signature = xConnect_signatures[xConnect_statConnect_enum];
@transform_xConnect_statConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = statConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_statConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_statConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_statConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_statConnect_enum];
)

// Rule: .xConnect = stmtConnect ==> .xConnect_signature = xConnect_signatures[xConnect_stmtConnect_enum];
@transform_xConnect_stmtConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = stmtConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_stmtConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_stmtConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_stmtConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_stmtConnect_enum];
)

// Rule: .xConnect = tclConnect ==> .xConnect_signature = xConnect_signatures[xConnect_tclConnect_enum];
@transform_xConnect_tclConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = tclConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_tclConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_tclConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_tclConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_tclConnect_enum];
)

// Rule: .xConnect = tclvarConnect ==> .xConnect_signature = xConnect_signatures[xConnect_tclvarConnect_enum];
@transform_xConnect_tclvarConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = tclvarConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_tclvarConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_tclvarConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_tclvarConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_tclvarConnect_enum];
)

// Rule: .xConnect = templatevtabConnect ==> .xConnect_signature = xConnect_signatures[xConnect_templatevtabConnect_enum];
@transform_xConnect_templatevtabConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = templatevtabConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_templatevtabConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_templatevtabConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_templatevtabConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_templatevtabConnect_enum];
)

// Rule: .xConnect = unionConnect ==> .xConnect_signature = xConnect_signatures[xConnect_unionConnect_enum];
@transform_xConnect_unionConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = unionConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_unionConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_unionConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_unionConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_unionConnect_enum];
)

// Rule: .xConnect = vlogConnect ==> .xConnect_signature = xConnect_signatures[xConnect_vlogConnect_enum];
@transform_xConnect_vlogConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = vlogConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_vlogConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_vlogConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_vlogConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_vlogConnect_enum];
)

// Rule: .xConnect = vstattabConnect ==> .xConnect_signature = xConnect_signatures[xConnect_vstattabConnect_enum];
@transform_xConnect_vstattabConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = vstattabConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_vstattabConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_vstattabConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_vstattabConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_vstattabConnect_enum];
)

// Rule: .xConnect = vtablogConnect ==> .xConnect_signature = xConnect_signatures[xConnect_vtablogConnect_enum];
@transform_xConnect_vtablogConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = vtablogConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_vtablogConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_vtablogConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_vtablogConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_vtablogConnect_enum];
)

// Rule: .xConnect = wholenumberConnect ==> .xConnect_signature = xConnect_signatures[xConnect_wholenumberConnect_enum];
@transform_xConnect_wholenumberConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = wholenumberConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_wholenumberConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_wholenumberConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_wholenumberConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_wholenumberConnect_enum];
)

// Rule: .xConnect = zipfileConnect ==> .xConnect_signature = xConnect_signatures[xConnect_zipfileConnect_enum];
@transform_xConnect_zipfileConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME = zipfileConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_zipfileConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xConnect_signature = xConnect_signatures[xConnect_zipfileConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_zipfileConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xConnect_signature = xConnect_signatures[xConnect_zipfileConnect_enum];
)

// Rules for xCount (3 valid functions, 0 excluded)
// Rule: .xCount = sessionDiffCount ==> .xCount_signature = xCount_signatures[xCount_sessionDiffCount_enum];
@transform_xCount_sessionDiffCount@
expression E;
identifier FP_NAME = xCount;
identifier FUNC_NAME = sessionDiffCount;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCount_signature = xCount_signatures[xCount_sessionDiffCount_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCount_signature = xCount_signatures[xCount_sessionDiffCount_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCount_signature = xCount_signatures[xCount_sessionDiffCount_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCount_signature = xCount_signatures[xCount_sessionDiffCount_enum];
)

// Rule: .xCount = sessionPreupdateCount ==> .xCount_signature = xCount_signatures[xCount_sessionPreupdateCount_enum];
@transform_xCount_sessionPreupdateCount@
expression E;
identifier FP_NAME = xCount;
identifier FUNC_NAME = sessionPreupdateCount;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCount_signature = xCount_signatures[xCount_sessionPreupdateCount_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCount_signature = xCount_signatures[xCount_sessionPreupdateCount_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCount_signature = xCount_signatures[xCount_sessionPreupdateCount_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCount_signature = xCount_signatures[xCount_sessionPreupdateCount_enum];
)

// Rule: .xCount = sessionStat1Count ==> .xCount_signature = xCount_signatures[xCount_sessionStat1Count_enum];
@transform_xCount_sessionStat1Count@
expression E;
identifier FP_NAME = xCount;
identifier FUNC_NAME = sessionStat1Count;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCount_signature = xCount_signatures[xCount_sessionStat1Count_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCount_signature = xCount_signatures[xCount_sessionStat1Count_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCount_signature = xCount_signatures[xCount_sessionStat1Count_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCount_signature = xCount_signatures[xCount_sessionStat1Count_enum];
)

// Rules for xCreate (35 valid functions, 9 excluded)
// Rule: .xCreate = 0 ==> .xCreate_signature = xCreate_signatures[xCreate_0_enum];
@transform_xCreate_0@
expression E;
identifier FP_NAME = xCreate;
@@
(
E.FP_NAME = 0;
+ E.xCreate_signature = xCreate_signatures[xCreate_0_enum];
|
E->FP_NAME = 0;
+ E->xCreate_signature = xCreate_signatures[xCreate_0_enum];
)

// Rule: .xCreate = amatchConnect ==> .xCreate_signature = xCreate_signatures[xCreate_amatchConnect_enum];
@transform_xCreate_amatchConnect@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = amatchConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_amatchConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_amatchConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_amatchConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_amatchConnect_enum];
)

// Rule: .xCreate = closureConnect ==> .xCreate_signature = xCreate_signatures[xCreate_closureConnect_enum];
@transform_xCreate_closureConnect@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = closureConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_closureConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_closureConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_closureConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_closureConnect_enum];
)

// Rule: .xCreate = csvtabCreate ==> .xCreate_signature = xCreate_signatures[xCreate_csvtabCreate_enum];
@transform_xCreate_csvtabCreate@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = csvtabCreate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_csvtabCreate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_csvtabCreate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_csvtabCreate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_csvtabCreate_enum];
)

// Rule: .xCreate = dbpageConnect ==> .xCreate_signature = xCreate_signatures[xCreate_dbpageConnect_enum];
@transform_xCreate_dbpageConnect@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = dbpageConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_dbpageConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_dbpageConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_dbpageConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_dbpageConnect_enum];
)

// Rule: .xCreate = echoCreate ==> .xCreate_signature = xCreate_signatures[xCreate_echoCreate_enum];
@transform_xCreate_echoCreate@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = echoCreate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_echoCreate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_echoCreate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_echoCreate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_echoCreate_enum];
)

// Rule: .xCreate = expertConnect ==> .xCreate_signature = xCreate_signatures[xCreate_expertConnect_enum];
@transform_xCreate_expertConnect@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = expertConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_expertConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_expertConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_expertConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_expertConnect_enum];
)

// Rule: .xCreate = f5tOrigintextCreate ==> .xCreate_signature = xCreate_signatures[xCreate_f5tOrigintextCreate_enum];
@transform_xCreate_f5tOrigintextCreate@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = f5tOrigintextCreate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_f5tOrigintextCreate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_f5tOrigintextCreate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_f5tOrigintextCreate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_f5tOrigintextCreate_enum];
)

// Rule: .xCreate = f5tTokenizerCreate ==> .xCreate_signature = xCreate_signatures[xCreate_f5tTokenizerCreate_enum];
@transform_xCreate_f5tTokenizerCreate@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = f5tTokenizerCreate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_f5tTokenizerCreate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_f5tTokenizerCreate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_f5tTokenizerCreate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_f5tTokenizerCreate_enum];
)

// Rule: .xCreate = fsConnect ==> .xCreate_signature = xCreate_signatures[xCreate_fsConnect_enum];
@transform_xCreate_fsConnect@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = fsConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_fsConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_fsConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_fsConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_fsConnect_enum];
)

// Rule: .xCreate = fsdirConnect ==> .xCreate_signature = xCreate_signatures[xCreate_fsdirConnect_enum];
@transform_xCreate_fsdirConnect@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = fsdirConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_fsdirConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_fsdirConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_fsdirConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_fsdirConnect_enum];
)

// Rule: .xCreate = fstreeConnect ==> .xCreate_signature = xCreate_signatures[xCreate_fstreeConnect_enum];
@transform_xCreate_fstreeConnect@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = fstreeConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_fstreeConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_fstreeConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_fstreeConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_fstreeConnect_enum];
)

// Rule: .xCreate = fts3CreateMethod ==> .xCreate_signature = xCreate_signatures[xCreate_fts3CreateMethod_enum];
@transform_xCreate_fts3CreateMethod@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = fts3CreateMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_fts3CreateMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_fts3CreateMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_fts3CreateMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_fts3CreateMethod_enum];
)

// Rule: .xCreate = fts3auxConnectMethod ==> .xCreate_signature = xCreate_signatures[xCreate_fts3auxConnectMethod_enum];
@transform_xCreate_fts3auxConnectMethod@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = fts3auxConnectMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_fts3auxConnectMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_fts3auxConnectMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_fts3auxConnectMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_fts3auxConnectMethod_enum];
)

// Rule: .xCreate = fts3termConnectMethod ==> .xCreate_signature = xCreate_signatures[xCreate_fts3termConnectMethod_enum];
@transform_xCreate_fts3termConnectMethod@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = fts3termConnectMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_fts3termConnectMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_fts3termConnectMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_fts3termConnectMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_fts3termConnectMethod_enum];
)

// Rule: .xCreate = fts3tokConnectMethod ==> .xCreate_signature = xCreate_signatures[xCreate_fts3tokConnectMethod_enum];
@transform_xCreate_fts3tokConnectMethod@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = fts3tokConnectMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_fts3tokConnectMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_fts3tokConnectMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_fts3tokConnectMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_fts3tokConnectMethod_enum];
)

// Rule: .xCreate = fuzzerConnect ==> .xCreate_signature = xCreate_signatures[xCreate_fuzzerConnect_enum];
@transform_xCreate_fuzzerConnect@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = fuzzerConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_fuzzerConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_fuzzerConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_fuzzerConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_fuzzerConnect_enum];
)

// Rule: .xCreate = geopolyCreate ==> .xCreate_signature = xCreate_signatures[xCreate_geopolyCreate_enum];
@transform_xCreate_geopolyCreate@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = geopolyCreate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_geopolyCreate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_geopolyCreate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_geopolyCreate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_geopolyCreate_enum];
)

// Rule: .xCreate = intarrayCreate ==> .xCreate_signature = xCreate_signatures[xCreate_intarrayCreate_enum];
@transform_xCreate_intarrayCreate@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = intarrayCreate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_intarrayCreate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_intarrayCreate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_intarrayCreate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_intarrayCreate_enum];
)

// Rule: .xCreate = pcache1Create ==> .xCreate_signature = xCreate_signatures[xCreate_pcache1Create_enum];
@transform_xCreate_pcache1Create@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = pcache1Create;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_pcache1Create_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_pcache1Create_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_pcache1Create_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_pcache1Create_enum];
)

// Rule: .xCreate = pcachetraceCreate ==> .xCreate_signature = xCreate_signatures[xCreate_pcachetraceCreate_enum];
@transform_xCreate_pcachetraceCreate@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = pcachetraceCreate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_pcachetraceCreate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_pcachetraceCreate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_pcachetraceCreate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_pcachetraceCreate_enum];
)

// Rule: .xCreate = porterCreate ==> .xCreate_signature = xCreate_signatures[xCreate_porterCreate_enum];
@transform_xCreate_porterCreate@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = porterCreate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_porterCreate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_porterCreate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_porterCreate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_porterCreate_enum];
)

// Rule: .xCreate = rtreeCreate ==> .xCreate_signature = xCreate_signatures[xCreate_rtreeCreate_enum];
@transform_xCreate_rtreeCreate@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = rtreeCreate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_rtreeCreate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_rtreeCreate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_rtreeCreate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_rtreeCreate_enum];
)

// Rule: .xCreate = schemaCreate ==> .xCreate_signature = xCreate_signatures[xCreate_schemaCreate_enum];
@transform_xCreate_schemaCreate@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = schemaCreate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_schemaCreate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_schemaCreate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_schemaCreate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_schemaCreate_enum];
)

// Rule: .xCreate = simpleCreate ==> .xCreate_signature = xCreate_signatures[xCreate_simpleCreate_enum];
@transform_xCreate_simpleCreate@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = simpleCreate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_simpleCreate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_simpleCreate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_simpleCreate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_simpleCreate_enum];
)

// Rule: .xCreate = spellfix1Create ==> .xCreate_signature = xCreate_signatures[xCreate_spellfix1Create_enum];
@transform_xCreate_spellfix1Create@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = spellfix1Create;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_spellfix1Create_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_spellfix1Create_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_spellfix1Create_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_spellfix1Create_enum];
)

// Rule: .xCreate = statConnect ==> .xCreate_signature = xCreate_signatures[xCreate_statConnect_enum];
@transform_xCreate_statConnect@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = statConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_statConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_statConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_statConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_statConnect_enum];
)

// Rule: .xCreate = tclConnect ==> .xCreate_signature = xCreate_signatures[xCreate_tclConnect_enum];
@transform_xCreate_tclConnect@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = tclConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_tclConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_tclConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_tclConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_tclConnect_enum];
)

// Rule: .xCreate = tclvarConnect ==> .xCreate_signature = xCreate_signatures[xCreate_tclvarConnect_enum];
@transform_xCreate_tclvarConnect@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = tclvarConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_tclvarConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_tclvarConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_tclvarConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_tclvarConnect_enum];
)

// Rule: .xCreate = unicodeCreate ==> .xCreate_signature = xCreate_signatures[xCreate_unicodeCreate_enum];
@transform_xCreate_unicodeCreate@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = unicodeCreate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_unicodeCreate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_unicodeCreate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_unicodeCreate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_unicodeCreate_enum];
)

// Rule: .xCreate = unionConnect ==> .xCreate_signature = xCreate_signatures[xCreate_unionConnect_enum];
@transform_xCreate_unionConnect@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = unionConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_unionConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_unionConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_unionConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_unionConnect_enum];
)

// Rule: .xCreate = vlogConnect ==> .xCreate_signature = xCreate_signatures[xCreate_vlogConnect_enum];
@transform_xCreate_vlogConnect@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = vlogConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_vlogConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_vlogConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_vlogConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_vlogConnect_enum];
)

// Rule: .xCreate = vtablogCreate ==> .xCreate_signature = xCreate_signatures[xCreate_vtablogCreate_enum];
@transform_xCreate_vtablogCreate@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = vtablogCreate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_vtablogCreate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_vtablogCreate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_vtablogCreate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_vtablogCreate_enum];
)

// Rule: .xCreate = wholenumberConnect ==> .xCreate_signature = xCreate_signatures[xCreate_wholenumberConnect_enum];
@transform_xCreate_wholenumberConnect@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = wholenumberConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_wholenumberConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_wholenumberConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_wholenumberConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_wholenumberConnect_enum];
)

// Rule: .xCreate = zipfileConnect ==> .xCreate_signature = xCreate_signatures[xCreate_zipfileConnect_enum];
@transform_xCreate_zipfileConnect@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = zipfileConnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_zipfileConnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCreate_signature = xCreate_signatures[xCreate_zipfileConnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_zipfileConnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCreate_signature = xCreate_signatures[xCreate_zipfileConnect_enum];
)

// Rules for xCurrentTime (4 valid functions, 9 excluded)
// Rule: .xCurrentTime = 0 ==> .xCurrentTime_signature = xCurrentTime_signatures[xCurrentTime_0_enum];
@transform_xCurrentTime_0@
expression E;
identifier FP_NAME = xCurrentTime;
@@
(
E.FP_NAME = 0;
+ E.xCurrentTime_signature = xCurrentTime_signatures[xCurrentTime_0_enum];
|
E->FP_NAME = 0;
+ E->xCurrentTime_signature = xCurrentTime_signatures[xCurrentTime_0_enum];
)

// Rule: .xCurrentTime = apndCurrentTime ==> .xCurrentTime_signature = xCurrentTime_signatures[xCurrentTime_apndCurrentTime_enum];
@transform_xCurrentTime_apndCurrentTime@
expression E;
identifier FP_NAME = xCurrentTime;
identifier FUNC_NAME = apndCurrentTime;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCurrentTime_signature = xCurrentTime_signatures[xCurrentTime_apndCurrentTime_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCurrentTime_signature = xCurrentTime_signatures[xCurrentTime_apndCurrentTime_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCurrentTime_signature = xCurrentTime_signatures[xCurrentTime_apndCurrentTime_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCurrentTime_signature = xCurrentTime_signatures[xCurrentTime_apndCurrentTime_enum];
)

// Rule: .xCurrentTime = vfstraceCurrentTime ==> .xCurrentTime_signature = xCurrentTime_signatures[xCurrentTime_vfstraceCurrentTime_enum];
@transform_xCurrentTime_vfstraceCurrentTime@
expression E;
identifier FP_NAME = xCurrentTime;
identifier FUNC_NAME = vfstraceCurrentTime;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCurrentTime_signature = xCurrentTime_signatures[xCurrentTime_vfstraceCurrentTime_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCurrentTime_signature = xCurrentTime_signatures[xCurrentTime_vfstraceCurrentTime_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCurrentTime_signature = xCurrentTime_signatures[xCurrentTime_vfstraceCurrentTime_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCurrentTime_signature = xCurrentTime_signatures[xCurrentTime_vfstraceCurrentTime_enum];
)

// Rule: .xCurrentTime = unixCurrentTime ==> .xCurrentTime_signature = xCurrentTime_signatures[xCurrentTime_unixCurrentTime_enum];
@transform_xCurrentTime_unixCurrentTime@
expression E;
identifier FP_NAME = xCurrentTime;
identifier FUNC_NAME = unixCurrentTime;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCurrentTime_signature = xCurrentTime_signatures[xCurrentTime_unixCurrentTime_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCurrentTime_signature = xCurrentTime_signatures[xCurrentTime_unixCurrentTime_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCurrentTime_signature = xCurrentTime_signatures[xCurrentTime_unixCurrentTime_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCurrentTime_signature = xCurrentTime_signatures[xCurrentTime_unixCurrentTime_enum];
)

// Rules for xCurrentTimeInt64 (4 valid functions, 7 excluded)
// Rule: .xCurrentTimeInt64 = 0 ==> .xCurrentTimeInt64_signature = xCurrentTimeInt64_signatures[xCurrentTimeInt64_0_enum];
@transform_xCurrentTimeInt64_0@
expression E;
identifier FP_NAME = xCurrentTimeInt64;
@@
(
E.FP_NAME = 0;
+ E.xCurrentTimeInt64_signature = xCurrentTimeInt64_signatures[xCurrentTimeInt64_0_enum];
|
E->FP_NAME = 0;
+ E->xCurrentTimeInt64_signature = xCurrentTimeInt64_signatures[xCurrentTimeInt64_0_enum];
)

// Rule: .xCurrentTimeInt64 = apndCurrentTimeInt64 ==> .xCurrentTimeInt64_signature = xCurrentTimeInt64_signatures[xCurrentTimeInt64_apndCurrentTimeInt64_enum];
@transform_xCurrentTimeInt64_apndCurrentTimeInt64@
expression E;
identifier FP_NAME = xCurrentTimeInt64;
identifier FUNC_NAME = apndCurrentTimeInt64;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCurrentTimeInt64_signature = xCurrentTimeInt64_signatures[xCurrentTimeInt64_apndCurrentTimeInt64_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCurrentTimeInt64_signature = xCurrentTimeInt64_signatures[xCurrentTimeInt64_apndCurrentTimeInt64_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCurrentTimeInt64_signature = xCurrentTimeInt64_signatures[xCurrentTimeInt64_apndCurrentTimeInt64_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCurrentTimeInt64_signature = xCurrentTimeInt64_signatures[xCurrentTimeInt64_apndCurrentTimeInt64_enum];
)

// Rule: .xCurrentTimeInt64 = memdbCurrentTimeInt64 ==> .xCurrentTimeInt64_signature = xCurrentTimeInt64_signatures[xCurrentTimeInt64_memdbCurrentTimeInt64_enum];
@transform_xCurrentTimeInt64_memdbCurrentTimeInt64@
expression E;
identifier FP_NAME = xCurrentTimeInt64;
identifier FUNC_NAME = memdbCurrentTimeInt64;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCurrentTimeInt64_signature = xCurrentTimeInt64_signatures[xCurrentTimeInt64_memdbCurrentTimeInt64_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCurrentTimeInt64_signature = xCurrentTimeInt64_signatures[xCurrentTimeInt64_memdbCurrentTimeInt64_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCurrentTimeInt64_signature = xCurrentTimeInt64_signatures[xCurrentTimeInt64_memdbCurrentTimeInt64_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCurrentTimeInt64_signature = xCurrentTimeInt64_signatures[xCurrentTimeInt64_memdbCurrentTimeInt64_enum];
)

// Rule: .xCurrentTimeInt64 = unixCurrentTimeInt64 ==> .xCurrentTimeInt64_signature = xCurrentTimeInt64_signatures[xCurrentTimeInt64_unixCurrentTimeInt64_enum];
@transform_xCurrentTimeInt64_unixCurrentTimeInt64@
expression E;
identifier FP_NAME = xCurrentTimeInt64;
identifier FUNC_NAME = unixCurrentTimeInt64;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xCurrentTimeInt64_signature = xCurrentTimeInt64_signatures[xCurrentTimeInt64_unixCurrentTimeInt64_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xCurrentTimeInt64_signature = xCurrentTimeInt64_signatures[xCurrentTimeInt64_unixCurrentTimeInt64_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xCurrentTimeInt64_signature = xCurrentTimeInt64_signatures[xCurrentTimeInt64_unixCurrentTimeInt64_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xCurrentTimeInt64_signature = xCurrentTimeInt64_signatures[xCurrentTimeInt64_unixCurrentTimeInt64_enum];
)

// Rules for xDel (4 valid functions, 2 excluded)
// Rule: .xDel = 0 ==> .xDel_signature = xDel_signatures[xDel_0_enum];
@transform_xDel_0@
expression E;
identifier FP_NAME = xDel;
@@
(
E.FP_NAME = 0;
+ E.xDel_signature = xDel_signatures[xDel_0_enum];
|
E->FP_NAME = 0;
+ E->xDel_signature = xDel_signatures[xDel_0_enum];
)

// Rule: .xDel = sqlite3RowSetDelete ==> .xDel_signature = xDel_signatures[xDel_sqlite3RowSetDelete_enum];
@transform_xDel_sqlite3RowSetDelete@
expression E;
identifier FP_NAME = xDel;
identifier FUNC_NAME = sqlite3RowSetDelete;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDel_signature = xDel_signatures[xDel_sqlite3RowSetDelete_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDel_signature = xDel_signatures[xDel_sqlite3RowSetDelete_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDel_signature = xDel_signatures[xDel_sqlite3RowSetDelete_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDel_signature = xDel_signatures[xDel_sqlite3RowSetDelete_enum];
)

// Rule: .xDel = sqlite3VdbeFrameMemDel ==> .xDel_signature = xDel_signatures[xDel_sqlite3VdbeFrameMemDel_enum];
@transform_xDel_sqlite3VdbeFrameMemDel@
expression E;
identifier FP_NAME = xDel;
identifier FUNC_NAME = sqlite3VdbeFrameMemDel;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDel_signature = xDel_signatures[xDel_sqlite3VdbeFrameMemDel_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDel_signature = xDel_signatures[xDel_sqlite3VdbeFrameMemDel_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDel_signature = xDel_signatures[xDel_sqlite3VdbeFrameMemDel_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDel_signature = xDel_signatures[xDel_sqlite3VdbeFrameMemDel_enum];
)

// Rule: .xDel = sqlite3_free ==> .xDel_signature = xDel_signatures[xDel_sqlite3_free_enum];
@transform_xDel_sqlite3_free@
expression E;
identifier FP_NAME = xDel;
identifier FUNC_NAME = sqlite3_free;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDel_signature = xDel_signatures[xDel_sqlite3_free_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDel_signature = xDel_signatures[xDel_sqlite3_free_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDel_signature = xDel_signatures[xDel_sqlite3_free_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDel_signature = xDel_signatures[xDel_sqlite3_free_enum];
)

// Rules for xDelete (7 valid functions, 15 excluded)
// Rule: .xDelete = 0 ==> .xDelete_signature = xDelete_signatures[xDelete_0_enum];
@transform_xDelete_0@
expression E;
identifier FP_NAME = xDelete;
@@
(
E.FP_NAME = 0;
+ E.xDelete_signature = xDelete_signatures[xDelete_0_enum];
|
E->FP_NAME = 0;
+ E->xDelete_signature = xDelete_signatures[xDelete_0_enum];
)

// Rule: .xDelete = apndDelete ==> .xDelete_signature = xDelete_signatures[xDelete_apndDelete_enum];
@transform_xDelete_apndDelete@
expression E;
identifier FP_NAME = xDelete;
identifier FUNC_NAME = apndDelete;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDelete_signature = xDelete_signatures[xDelete_apndDelete_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDelete_signature = xDelete_signatures[xDelete_apndDelete_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDelete_signature = xDelete_signatures[xDelete_apndDelete_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDelete_signature = xDelete_signatures[xDelete_apndDelete_enum];
)

// Rule: .xDelete = f5tOrigintextDelete ==> .xDelete_signature = xDelete_signatures[xDelete_f5tOrigintextDelete_enum];
@transform_xDelete_f5tOrigintextDelete@
expression E;
identifier FP_NAME = xDelete;
identifier FUNC_NAME = f5tOrigintextDelete;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDelete_signature = xDelete_signatures[xDelete_f5tOrigintextDelete_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDelete_signature = xDelete_signatures[xDelete_f5tOrigintextDelete_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDelete_signature = xDelete_signatures[xDelete_f5tOrigintextDelete_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDelete_signature = xDelete_signatures[xDelete_f5tOrigintextDelete_enum];
)

// Rule: .xDelete = f5tTokenizerDelete ==> .xDelete_signature = xDelete_signatures[xDelete_f5tTokenizerDelete_enum];
@transform_xDelete_f5tTokenizerDelete@
expression E;
identifier FP_NAME = xDelete;
identifier FUNC_NAME = f5tTokenizerDelete;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDelete_signature = xDelete_signatures[xDelete_f5tTokenizerDelete_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDelete_signature = xDelete_signatures[xDelete_f5tTokenizerDelete_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDelete_signature = xDelete_signatures[xDelete_f5tTokenizerDelete_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDelete_signature = xDelete_signatures[xDelete_f5tTokenizerDelete_enum];
)

// Rule: .xDelete = kvstorageDelete ==> .xDelete_signature = xDelete_signatures[xDelete_kvstorageDelete_enum];
@transform_xDelete_kvstorageDelete@
expression E;
identifier FP_NAME = xDelete;
identifier FUNC_NAME = kvstorageDelete;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDelete_signature = xDelete_signatures[xDelete_kvstorageDelete_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDelete_signature = xDelete_signatures[xDelete_kvstorageDelete_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDelete_signature = xDelete_signatures[xDelete_kvstorageDelete_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDelete_signature = xDelete_signatures[xDelete_kvstorageDelete_enum];
)

// Rule: .xDelete = vfstraceDelete ==> .xDelete_signature = xDelete_signatures[xDelete_vfstraceDelete_enum];
@transform_xDelete_vfstraceDelete@
expression E;
identifier FP_NAME = xDelete;
identifier FUNC_NAME = vfstraceDelete;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDelete_signature = xDelete_signatures[xDelete_vfstraceDelete_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDelete_signature = xDelete_signatures[xDelete_vfstraceDelete_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDelete_signature = xDelete_signatures[xDelete_vfstraceDelete_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDelete_signature = xDelete_signatures[xDelete_vfstraceDelete_enum];
)

// Rule: .xDelete = unixDelete ==> .xDelete_signature = xDelete_signatures[xDelete_unixDelete_enum];
@transform_xDelete_unixDelete@
expression E;
identifier FP_NAME = xDelete;
identifier FUNC_NAME = unixDelete;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDelete_signature = xDelete_signatures[xDelete_unixDelete_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDelete_signature = xDelete_signatures[xDelete_unixDelete_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDelete_signature = xDelete_signatures[xDelete_unixDelete_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDelete_signature = xDelete_signatures[xDelete_unixDelete_enum];
)

// Rules for xDepth (3 valid functions, 0 excluded)
// Rule: .xDepth = sessionDiffDepth ==> .xDepth_signature = xDepth_signatures[xDepth_sessionDiffDepth_enum];
@transform_xDepth_sessionDiffDepth@
expression E;
identifier FP_NAME = xDepth;
identifier FUNC_NAME = sessionDiffDepth;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDepth_signature = xDepth_signatures[xDepth_sessionDiffDepth_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDepth_signature = xDepth_signatures[xDepth_sessionDiffDepth_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDepth_signature = xDepth_signatures[xDepth_sessionDiffDepth_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDepth_signature = xDepth_signatures[xDepth_sessionDiffDepth_enum];
)

// Rule: .xDepth = sessionPreupdateDepth ==> .xDepth_signature = xDepth_signatures[xDepth_sessionPreupdateDepth_enum];
@transform_xDepth_sessionPreupdateDepth@
expression E;
identifier FP_NAME = xDepth;
identifier FUNC_NAME = sessionPreupdateDepth;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDepth_signature = xDepth_signatures[xDepth_sessionPreupdateDepth_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDepth_signature = xDepth_signatures[xDepth_sessionPreupdateDepth_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDepth_signature = xDepth_signatures[xDepth_sessionPreupdateDepth_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDepth_signature = xDepth_signatures[xDepth_sessionPreupdateDepth_enum];
)

// Rule: .xDepth = sessionStat1Depth ==> .xDepth_signature = xDepth_signatures[xDepth_sessionStat1Depth_enum];
@transform_xDepth_sessionStat1Depth@
expression E;
identifier FP_NAME = xDepth;
identifier FUNC_NAME = sessionStat1Depth;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDepth_signature = xDepth_signatures[xDepth_sessionStat1Depth_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDepth_signature = xDepth_signatures[xDepth_sessionStat1Depth_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDepth_signature = xDepth_signatures[xDepth_sessionStat1Depth_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDepth_signature = xDepth_signatures[xDepth_sessionStat1Depth_enum];
)

// Rules for xDestroy (15 valid functions, 25 excluded)
// Rule: .xDestroy = 0 ==> .xDestroy_signature = xDestroy_signatures[xDestroy_0_enum];
@transform_xDestroy_0@
expression E;
identifier FP_NAME = xDestroy;
@@
(
E.FP_NAME = 0;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_0_enum];
|
E->FP_NAME = 0;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_0_enum];
)

// Rule: .xDestroy = dbpageDisconnect ==> .xDestroy_signature = xDestroy_signatures[xDestroy_dbpageDisconnect_enum];
@transform_xDestroy_dbpageDisconnect@
expression E;
identifier FP_NAME = xDestroy;
identifier FUNC_NAME = dbpageDisconnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_dbpageDisconnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_dbpageDisconnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_dbpageDisconnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_dbpageDisconnect_enum];
)

// Rule: .xDestroy = expertDisconnect ==> .xDestroy_signature = xDestroy_signatures[xDestroy_expertDisconnect_enum];
@transform_xDestroy_expertDisconnect@
expression E;
identifier FP_NAME = xDestroy;
identifier FUNC_NAME = expertDisconnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_expertDisconnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_expertDisconnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_expertDisconnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_expertDisconnect_enum];
)

// Rule: .xDestroy = fsdirDisconnect ==> .xDestroy_signature = xDestroy_signatures[xDestroy_fsdirDisconnect_enum];
@transform_xDestroy_fsdirDisconnect@
expression E;
identifier FP_NAME = xDestroy;
identifier FUNC_NAME = fsdirDisconnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_fsdirDisconnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_fsdirDisconnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_fsdirDisconnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_fsdirDisconnect_enum];
)

// Rule: .xDestroy = fts3DestroyMethod ==> .xDestroy_signature = xDestroy_signatures[xDestroy_fts3DestroyMethod_enum];
@transform_xDestroy_fts3DestroyMethod@
expression E;
identifier FP_NAME = xDestroy;
identifier FUNC_NAME = fts3DestroyMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_fts3DestroyMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_fts3DestroyMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_fts3DestroyMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_fts3DestroyMethod_enum];
)

// Rule: .xDestroy = fts3auxDisconnectMethod ==> .xDestroy_signature = xDestroy_signatures[xDestroy_fts3auxDisconnectMethod_enum];
@transform_xDestroy_fts3auxDisconnectMethod@
expression E;
identifier FP_NAME = xDestroy;
identifier FUNC_NAME = fts3auxDisconnectMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_fts3auxDisconnectMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_fts3auxDisconnectMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_fts3auxDisconnectMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_fts3auxDisconnectMethod_enum];
)

// Rule: .xDestroy = fts3tokDisconnectMethod ==> .xDestroy_signature = xDestroy_signatures[xDestroy_fts3tokDisconnectMethod_enum];
@transform_xDestroy_fts3tokDisconnectMethod@
expression E;
identifier FP_NAME = xDestroy;
identifier FUNC_NAME = fts3tokDisconnectMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_fts3tokDisconnectMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_fts3tokDisconnectMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_fts3tokDisconnectMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_fts3tokDisconnectMethod_enum];
)

// Rule: .xDestroy = pcache1Destroy ==> .xDestroy_signature = xDestroy_signatures[xDestroy_pcache1Destroy_enum];
@transform_xDestroy_pcache1Destroy@
expression E;
identifier FP_NAME = xDestroy;
identifier FUNC_NAME = pcache1Destroy;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_pcache1Destroy_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_pcache1Destroy_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_pcache1Destroy_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_pcache1Destroy_enum];
)

// Rule: .xDestroy = pcachetraceDestroy ==> .xDestroy_signature = xDestroy_signatures[xDestroy_pcachetraceDestroy_enum];
@transform_xDestroy_pcachetraceDestroy@
expression E;
identifier FP_NAME = xDestroy;
identifier FUNC_NAME = pcachetraceDestroy;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_pcachetraceDestroy_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_pcachetraceDestroy_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_pcachetraceDestroy_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_pcachetraceDestroy_enum];
)

// Rule: .xDestroy = porterDestroy ==> .xDestroy_signature = xDestroy_signatures[xDestroy_porterDestroy_enum];
@transform_xDestroy_porterDestroy@
expression E;
identifier FP_NAME = xDestroy;
identifier FUNC_NAME = porterDestroy;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_porterDestroy_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_porterDestroy_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_porterDestroy_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_porterDestroy_enum];
)

// Rule: .xDestroy = rtreeDestroy ==> .xDestroy_signature = xDestroy_signatures[xDestroy_rtreeDestroy_enum];
@transform_xDestroy_rtreeDestroy@
expression E;
identifier FP_NAME = xDestroy;
identifier FUNC_NAME = rtreeDestroy;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_rtreeDestroy_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_rtreeDestroy_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_rtreeDestroy_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_rtreeDestroy_enum];
)

// Rule: .xDestroy = simpleDestroy ==> .xDestroy_signature = xDestroy_signatures[xDestroy_simpleDestroy_enum];
@transform_xDestroy_simpleDestroy@
expression E;
identifier FP_NAME = xDestroy;
identifier FUNC_NAME = simpleDestroy;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_simpleDestroy_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_simpleDestroy_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_simpleDestroy_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_simpleDestroy_enum];
)

// Rule: .xDestroy = statDisconnect ==> .xDestroy_signature = xDestroy_signatures[xDestroy_statDisconnect_enum];
@transform_xDestroy_statDisconnect@
expression E;
identifier FP_NAME = xDestroy;
identifier FUNC_NAME = statDisconnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_statDisconnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_statDisconnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_statDisconnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_statDisconnect_enum];
)

// Rule: .xDestroy = unicodeDestroy ==> .xDestroy_signature = xDestroy_signatures[xDestroy_unicodeDestroy_enum];
@transform_xDestroy_unicodeDestroy@
expression E;
identifier FP_NAME = xDestroy;
identifier FUNC_NAME = unicodeDestroy;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_unicodeDestroy_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_unicodeDestroy_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_unicodeDestroy_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_unicodeDestroy_enum];
)

// Rule: .xDestroy = zipfileDisconnect ==> .xDestroy_signature = xDestroy_signatures[xDestroy_zipfileDisconnect_enum];
@transform_xDestroy_zipfileDisconnect@
expression E;
identifier FP_NAME = xDestroy;
identifier FUNC_NAME = zipfileDisconnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_zipfileDisconnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDestroy_signature = xDestroy_signatures[xDestroy_zipfileDisconnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_zipfileDisconnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDestroy_signature = xDestroy_signatures[xDestroy_zipfileDisconnect_enum];
)

// Rules for xDeviceCharacteristics (6 valid functions, 18 excluded)
// Rule: .xDeviceCharacteristics = 0 ==> .xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_0_enum];
@transform_xDeviceCharacteristics_0@
expression E;
identifier FP_NAME = xDeviceCharacteristics;
@@
(
E.FP_NAME = 0;
+ E.xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_0_enum];
|
E->FP_NAME = 0;
+ E->xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_0_enum];
)

// Rule: .xDeviceCharacteristics = apndDeviceCharacteristics ==> .xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_apndDeviceCharacteristics_enum];
@transform_xDeviceCharacteristics_apndDeviceCharacteristics@
expression E;
identifier FP_NAME = xDeviceCharacteristics;
identifier FUNC_NAME = apndDeviceCharacteristics;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_apndDeviceCharacteristics_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_apndDeviceCharacteristics_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_apndDeviceCharacteristics_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_apndDeviceCharacteristics_enum];
)

// Rule: .xDeviceCharacteristics = memdbDeviceCharacteristics ==> .xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_memdbDeviceCharacteristics_enum];
@transform_xDeviceCharacteristics_memdbDeviceCharacteristics@
expression E;
identifier FP_NAME = xDeviceCharacteristics;
identifier FUNC_NAME = memdbDeviceCharacteristics;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_memdbDeviceCharacteristics_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_memdbDeviceCharacteristics_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_memdbDeviceCharacteristics_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_memdbDeviceCharacteristics_enum];
)

// Rule: .xDeviceCharacteristics = recoverVfsDeviceCharacteristics ==> .xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_recoverVfsDeviceCharacteristics_enum];
@transform_xDeviceCharacteristics_recoverVfsDeviceCharacteristics@
expression E;
identifier FP_NAME = xDeviceCharacteristics;
identifier FUNC_NAME = recoverVfsDeviceCharacteristics;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_recoverVfsDeviceCharacteristics_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_recoverVfsDeviceCharacteristics_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_recoverVfsDeviceCharacteristics_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_recoverVfsDeviceCharacteristics_enum];
)

// Rule: .xDeviceCharacteristics = vfstraceDeviceCharacteristics ==> .xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_vfstraceDeviceCharacteristics_enum];
@transform_xDeviceCharacteristics_vfstraceDeviceCharacteristics@
expression E;
identifier FP_NAME = xDeviceCharacteristics;
identifier FUNC_NAME = vfstraceDeviceCharacteristics;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_vfstraceDeviceCharacteristics_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_vfstraceDeviceCharacteristics_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_vfstraceDeviceCharacteristics_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_vfstraceDeviceCharacteristics_enum];
)

// Rule: .xDeviceCharacteristics = unixDeviceCharacteristics ==> .xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_unixDeviceCharacteristics_enum];
@transform_xDeviceCharacteristics_unixDeviceCharacteristics@
expression E;
identifier FP_NAME = xDeviceCharacteristics;
identifier FUNC_NAME = unixDeviceCharacteristics;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_unixDeviceCharacteristics_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_unixDeviceCharacteristics_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_unixDeviceCharacteristics_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_unixDeviceCharacteristics_enum];
)

// Rules for xDisconnect (16 valid functions, 31 excluded)
// Rule: .xDisconnect = bytecodevtabDisconnect ==> .xDisconnect_signature = xDisconnect_signatures[xDisconnect_bytecodevtabDisconnect_enum];
@transform_xDisconnect_bytecodevtabDisconnect@
expression E;
identifier FP_NAME = xDisconnect;
identifier FUNC_NAME = bytecodevtabDisconnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_bytecodevtabDisconnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_bytecodevtabDisconnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_bytecodevtabDisconnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_bytecodevtabDisconnect_enum];
)

// Rule: .xDisconnect = completionDisconnect ==> .xDisconnect_signature = xDisconnect_signatures[xDisconnect_completionDisconnect_enum];
@transform_xDisconnect_completionDisconnect@
expression E;
identifier FP_NAME = xDisconnect;
identifier FUNC_NAME = completionDisconnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_completionDisconnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_completionDisconnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_completionDisconnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_completionDisconnect_enum];
)

// Rule: .xDisconnect = dbdataDisconnect ==> .xDisconnect_signature = xDisconnect_signatures[xDisconnect_dbdataDisconnect_enum];
@transform_xDisconnect_dbdataDisconnect@
expression E;
identifier FP_NAME = xDisconnect;
identifier FUNC_NAME = dbdataDisconnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_dbdataDisconnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_dbdataDisconnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_dbdataDisconnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_dbdataDisconnect_enum];
)

// Rule: .xDisconnect = dbpageDisconnect ==> .xDisconnect_signature = xDisconnect_signatures[xDisconnect_dbpageDisconnect_enum];
@transform_xDisconnect_dbpageDisconnect@
expression E;
identifier FP_NAME = xDisconnect;
identifier FUNC_NAME = dbpageDisconnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_dbpageDisconnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_dbpageDisconnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_dbpageDisconnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_dbpageDisconnect_enum];
)

// Rule: .xDisconnect = expertDisconnect ==> .xDisconnect_signature = xDisconnect_signatures[xDisconnect_expertDisconnect_enum];
@transform_xDisconnect_expertDisconnect@
expression E;
identifier FP_NAME = xDisconnect;
identifier FUNC_NAME = expertDisconnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_expertDisconnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_expertDisconnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_expertDisconnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_expertDisconnect_enum];
)

// Rule: .xDisconnect = fsdirDisconnect ==> .xDisconnect_signature = xDisconnect_signatures[xDisconnect_fsdirDisconnect_enum];
@transform_xDisconnect_fsdirDisconnect@
expression E;
identifier FP_NAME = xDisconnect;
identifier FUNC_NAME = fsdirDisconnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_fsdirDisconnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_fsdirDisconnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_fsdirDisconnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_fsdirDisconnect_enum];
)

// Rule: .xDisconnect = fts3DisconnectMethod ==> .xDisconnect_signature = xDisconnect_signatures[xDisconnect_fts3DisconnectMethod_enum];
@transform_xDisconnect_fts3DisconnectMethod@
expression E;
identifier FP_NAME = xDisconnect;
identifier FUNC_NAME = fts3DisconnectMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_fts3DisconnectMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_fts3DisconnectMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_fts3DisconnectMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_fts3DisconnectMethod_enum];
)

// Rule: .xDisconnect = fts3auxDisconnectMethod ==> .xDisconnect_signature = xDisconnect_signatures[xDisconnect_fts3auxDisconnectMethod_enum];
@transform_xDisconnect_fts3auxDisconnectMethod@
expression E;
identifier FP_NAME = xDisconnect;
identifier FUNC_NAME = fts3auxDisconnectMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_fts3auxDisconnectMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_fts3auxDisconnectMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_fts3auxDisconnectMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_fts3auxDisconnectMethod_enum];
)

// Rule: .xDisconnect = fts3tokDisconnectMethod ==> .xDisconnect_signature = xDisconnect_signatures[xDisconnect_fts3tokDisconnectMethod_enum];
@transform_xDisconnect_fts3tokDisconnectMethod@
expression E;
identifier FP_NAME = xDisconnect;
identifier FUNC_NAME = fts3tokDisconnectMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_fts3tokDisconnectMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_fts3tokDisconnectMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_fts3tokDisconnectMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_fts3tokDisconnectMethod_enum];
)

// Rule: .xDisconnect = jsonEachDisconnect ==> .xDisconnect_signature = xDisconnect_signatures[xDisconnect_jsonEachDisconnect_enum];
@transform_xDisconnect_jsonEachDisconnect@
expression E;
identifier FP_NAME = xDisconnect;
identifier FUNC_NAME = jsonEachDisconnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_jsonEachDisconnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_jsonEachDisconnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_jsonEachDisconnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_jsonEachDisconnect_enum];
)

// Rule: .xDisconnect = pragmaVtabDisconnect ==> .xDisconnect_signature = xDisconnect_signatures[xDisconnect_pragmaVtabDisconnect_enum];
@transform_xDisconnect_pragmaVtabDisconnect@
expression E;
identifier FP_NAME = xDisconnect;
identifier FUNC_NAME = pragmaVtabDisconnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_pragmaVtabDisconnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_pragmaVtabDisconnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_pragmaVtabDisconnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_pragmaVtabDisconnect_enum];
)

// Rule: .xDisconnect = rtreeDisconnect ==> .xDisconnect_signature = xDisconnect_signatures[xDisconnect_rtreeDisconnect_enum];
@transform_xDisconnect_rtreeDisconnect@
expression E;
identifier FP_NAME = xDisconnect;
identifier FUNC_NAME = rtreeDisconnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_rtreeDisconnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_rtreeDisconnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_rtreeDisconnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_rtreeDisconnect_enum];
)

// Rule: .xDisconnect = seriesDisconnect ==> .xDisconnect_signature = xDisconnect_signatures[xDisconnect_seriesDisconnect_enum];
@transform_xDisconnect_seriesDisconnect@
expression E;
identifier FP_NAME = xDisconnect;
identifier FUNC_NAME = seriesDisconnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_seriesDisconnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_seriesDisconnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_seriesDisconnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_seriesDisconnect_enum];
)

// Rule: .xDisconnect = statDisconnect ==> .xDisconnect_signature = xDisconnect_signatures[xDisconnect_statDisconnect_enum];
@transform_xDisconnect_statDisconnect@
expression E;
identifier FP_NAME = xDisconnect;
identifier FUNC_NAME = statDisconnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_statDisconnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_statDisconnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_statDisconnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_statDisconnect_enum];
)

// Rule: .xDisconnect = stmtDisconnect ==> .xDisconnect_signature = xDisconnect_signatures[xDisconnect_stmtDisconnect_enum];
@transform_xDisconnect_stmtDisconnect@
expression E;
identifier FP_NAME = xDisconnect;
identifier FUNC_NAME = stmtDisconnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_stmtDisconnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_stmtDisconnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_stmtDisconnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_stmtDisconnect_enum];
)

// Rule: .xDisconnect = zipfileDisconnect ==> .xDisconnect_signature = xDisconnect_signatures[xDisconnect_zipfileDisconnect_enum];
@transform_xDisconnect_zipfileDisconnect@
expression E;
identifier FP_NAME = xDisconnect;
identifier FUNC_NAME = zipfileDisconnect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_zipfileDisconnect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDisconnect_signature = xDisconnect_signatures[xDisconnect_zipfileDisconnect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_zipfileDisconnect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDisconnect_signature = xDisconnect_signatures[xDisconnect_zipfileDisconnect_enum];
)

// Rules for xDlClose (4 valid functions, 11 excluded)
// Rule: .xDlClose = 0 ==> .xDlClose_signature = xDlClose_signatures[xDlClose_0_enum];
@transform_xDlClose_0@
expression E;
identifier FP_NAME = xDlClose;
@@
(
E.FP_NAME = 0;
+ E.xDlClose_signature = xDlClose_signatures[xDlClose_0_enum];
|
E->FP_NAME = 0;
+ E->xDlClose_signature = xDlClose_signatures[xDlClose_0_enum];
)

// Rule: .xDlClose = apndDlClose ==> .xDlClose_signature = xDlClose_signatures[xDlClose_apndDlClose_enum];
@transform_xDlClose_apndDlClose@
expression E;
identifier FP_NAME = xDlClose;
identifier FUNC_NAME = apndDlClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDlClose_signature = xDlClose_signatures[xDlClose_apndDlClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDlClose_signature = xDlClose_signatures[xDlClose_apndDlClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDlClose_signature = xDlClose_signatures[xDlClose_apndDlClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDlClose_signature = xDlClose_signatures[xDlClose_apndDlClose_enum];
)

// Rule: .xDlClose = memdbDlClose ==> .xDlClose_signature = xDlClose_signatures[xDlClose_memdbDlClose_enum];
@transform_xDlClose_memdbDlClose@
expression E;
identifier FP_NAME = xDlClose;
identifier FUNC_NAME = memdbDlClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDlClose_signature = xDlClose_signatures[xDlClose_memdbDlClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDlClose_signature = xDlClose_signatures[xDlClose_memdbDlClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDlClose_signature = xDlClose_signatures[xDlClose_memdbDlClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDlClose_signature = xDlClose_signatures[xDlClose_memdbDlClose_enum];
)

// Rule: .xDlClose = unixDlClose ==> .xDlClose_signature = xDlClose_signatures[xDlClose_unixDlClose_enum];
@transform_xDlClose_unixDlClose@
expression E;
identifier FP_NAME = xDlClose;
identifier FUNC_NAME = unixDlClose;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDlClose_signature = xDlClose_signatures[xDlClose_unixDlClose_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDlClose_signature = xDlClose_signatures[xDlClose_unixDlClose_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDlClose_signature = xDlClose_signatures[xDlClose_unixDlClose_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDlClose_signature = xDlClose_signatures[xDlClose_unixDlClose_enum];
)

// Rules for xDlError (4 valid functions, 11 excluded)
// Rule: .xDlError = 0 ==> .xDlError_signature = xDlError_signatures[xDlError_0_enum];
@transform_xDlError_0@
expression E;
identifier FP_NAME = xDlError;
@@
(
E.FP_NAME = 0;
+ E.xDlError_signature = xDlError_signatures[xDlError_0_enum];
|
E->FP_NAME = 0;
+ E->xDlError_signature = xDlError_signatures[xDlError_0_enum];
)

// Rule: .xDlError = apndDlError ==> .xDlError_signature = xDlError_signatures[xDlError_apndDlError_enum];
@transform_xDlError_apndDlError@
expression E;
identifier FP_NAME = xDlError;
identifier FUNC_NAME = apndDlError;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDlError_signature = xDlError_signatures[xDlError_apndDlError_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDlError_signature = xDlError_signatures[xDlError_apndDlError_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDlError_signature = xDlError_signatures[xDlError_apndDlError_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDlError_signature = xDlError_signatures[xDlError_apndDlError_enum];
)

// Rule: .xDlError = memdbDlError ==> .xDlError_signature = xDlError_signatures[xDlError_memdbDlError_enum];
@transform_xDlError_memdbDlError@
expression E;
identifier FP_NAME = xDlError;
identifier FUNC_NAME = memdbDlError;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDlError_signature = xDlError_signatures[xDlError_memdbDlError_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDlError_signature = xDlError_signatures[xDlError_memdbDlError_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDlError_signature = xDlError_signatures[xDlError_memdbDlError_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDlError_signature = xDlError_signatures[xDlError_memdbDlError_enum];
)

// Rule: .xDlError = unixDlError ==> .xDlError_signature = xDlError_signatures[xDlError_unixDlError_enum];
@transform_xDlError_unixDlError@
expression E;
identifier FP_NAME = xDlError;
identifier FUNC_NAME = unixDlError;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDlError_signature = xDlError_signatures[xDlError_unixDlError_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDlError_signature = xDlError_signatures[xDlError_unixDlError_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDlError_signature = xDlError_signatures[xDlError_unixDlError_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDlError_signature = xDlError_signatures[xDlError_unixDlError_enum];
)

// Rules for xDlOpen (3 valid functions, 9 excluded)
// Rule: .xDlOpen = apndDlOpen ==> .xDlOpen_signature = xDlOpen_signatures[xDlOpen_apndDlOpen_enum];
@transform_xDlOpen_apndDlOpen@
expression E;
identifier FP_NAME = xDlOpen;
identifier FUNC_NAME = apndDlOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDlOpen_signature = xDlOpen_signatures[xDlOpen_apndDlOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDlOpen_signature = xDlOpen_signatures[xDlOpen_apndDlOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDlOpen_signature = xDlOpen_signatures[xDlOpen_apndDlOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDlOpen_signature = xDlOpen_signatures[xDlOpen_apndDlOpen_enum];
)

// Rule: .xDlOpen = memdbDlOpen ==> .xDlOpen_signature = xDlOpen_signatures[xDlOpen_memdbDlOpen_enum];
@transform_xDlOpen_memdbDlOpen@
expression E;
identifier FP_NAME = xDlOpen;
identifier FUNC_NAME = memdbDlOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDlOpen_signature = xDlOpen_signatures[xDlOpen_memdbDlOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDlOpen_signature = xDlOpen_signatures[xDlOpen_memdbDlOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDlOpen_signature = xDlOpen_signatures[xDlOpen_memdbDlOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDlOpen_signature = xDlOpen_signatures[xDlOpen_memdbDlOpen_enum];
)

// Rule: .xDlOpen = unixDlOpen ==> .xDlOpen_signature = xDlOpen_signatures[xDlOpen_unixDlOpen_enum];
@transform_xDlOpen_unixDlOpen@
expression E;
identifier FP_NAME = xDlOpen;
identifier FUNC_NAME = unixDlOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xDlOpen_signature = xDlOpen_signatures[xDlOpen_unixDlOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xDlOpen_signature = xDlOpen_signatures[xDlOpen_unixDlOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xDlOpen_signature = xDlOpen_signatures[xDlOpen_unixDlOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xDlOpen_signature = xDlOpen_signatures[xDlOpen_unixDlOpen_enum];
)

// Rules for xEof (43 valid functions, 4 excluded)
// Rule: .xEof = amatchEof ==> .xEof_signature = xEof_signatures[xEof_amatchEof_enum];
@transform_xEof_amatchEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = amatchEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_amatchEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_amatchEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_amatchEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_amatchEof_enum];
)

// Rule: .xEof = binfoEof ==> .xEof_signature = xEof_signatures[xEof_binfoEof_enum];
@transform_xEof_binfoEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = binfoEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_binfoEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_binfoEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_binfoEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_binfoEof_enum];
)

// Rule: .xEof = bytecodevtabEof ==> .xEof_signature = xEof_signatures[xEof_bytecodevtabEof_enum];
@transform_xEof_bytecodevtabEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = bytecodevtabEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_bytecodevtabEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_bytecodevtabEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_bytecodevtabEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_bytecodevtabEof_enum];
)

// Rule: .xEof = carrayEof ==> .xEof_signature = xEof_signatures[xEof_carrayEof_enum];
@transform_xEof_carrayEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = carrayEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_carrayEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_carrayEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_carrayEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_carrayEof_enum];
)

// Rule: .xEof = cidxEof ==> .xEof_signature = xEof_signatures[xEof_cidxEof_enum];
@transform_xEof_cidxEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = cidxEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_cidxEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_cidxEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_cidxEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_cidxEof_enum];
)

// Rule: .xEof = closureEof ==> .xEof_signature = xEof_signatures[xEof_closureEof_enum];
@transform_xEof_closureEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = closureEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_closureEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_closureEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_closureEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_closureEof_enum];
)

// Rule: .xEof = completionEof ==> .xEof_signature = xEof_signatures[xEof_completionEof_enum];
@transform_xEof_completionEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = completionEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_completionEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_completionEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_completionEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_completionEof_enum];
)

// Rule: .xEof = csvtabEof ==> .xEof_signature = xEof_signatures[xEof_csvtabEof_enum];
@transform_xEof_csvtabEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = csvtabEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_csvtabEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_csvtabEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_csvtabEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_csvtabEof_enum];
)

// Rule: .xEof = dbdataEof ==> .xEof_signature = xEof_signatures[xEof_dbdataEof_enum];
@transform_xEof_dbdataEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = dbdataEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_dbdataEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_dbdataEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_dbdataEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_dbdataEof_enum];
)

// Rule: .xEof = dbpageEof ==> .xEof_signature = xEof_signatures[xEof_dbpageEof_enum];
@transform_xEof_dbpageEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = dbpageEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_dbpageEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_dbpageEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_dbpageEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_dbpageEof_enum];
)

// Rule: .xEof = deltaparsevtabEof ==> .xEof_signature = xEof_signatures[xEof_deltaparsevtabEof_enum];
@transform_xEof_deltaparsevtabEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = deltaparsevtabEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_deltaparsevtabEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_deltaparsevtabEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_deltaparsevtabEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_deltaparsevtabEof_enum];
)

// Rule: .xEof = echoEof ==> .xEof_signature = xEof_signatures[xEof_echoEof_enum];
@transform_xEof_echoEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = echoEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_echoEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_echoEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_echoEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_echoEof_enum];
)

// Rule: .xEof = expertEof ==> .xEof_signature = xEof_signatures[xEof_expertEof_enum];
@transform_xEof_expertEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = expertEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_expertEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_expertEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_expertEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_expertEof_enum];
)

// Rule: .xEof = explainEof ==> .xEof_signature = xEof_signatures[xEof_explainEof_enum];
@transform_xEof_explainEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = explainEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_explainEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_explainEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_explainEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_explainEof_enum];
)

// Rule: .xEof = fsEof ==> .xEof_signature = xEof_signatures[xEof_fsEof_enum];
@transform_xEof_fsEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = fsEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_fsEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_fsEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_fsEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_fsEof_enum];
)

// Rule: .xEof = fsdirEof ==> .xEof_signature = xEof_signatures[xEof_fsdirEof_enum];
@transform_xEof_fsdirEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = fsdirEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_fsdirEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_fsdirEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_fsdirEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_fsdirEof_enum];
)

// Rule: .xEof = fstreeEof ==> .xEof_signature = xEof_signatures[xEof_fstreeEof_enum];
@transform_xEof_fstreeEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = fstreeEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_fstreeEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_fstreeEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_fstreeEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_fstreeEof_enum];
)

// Rule: .xEof = fts3EofMethod ==> .xEof_signature = xEof_signatures[xEof_fts3EofMethod_enum];
@transform_xEof_fts3EofMethod@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = fts3EofMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_fts3EofMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_fts3EofMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_fts3EofMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_fts3EofMethod_enum];
)

// Rule: .xEof = fts3auxEofMethod ==> .xEof_signature = xEof_signatures[xEof_fts3auxEofMethod_enum];
@transform_xEof_fts3auxEofMethod@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = fts3auxEofMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_fts3auxEofMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_fts3auxEofMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_fts3auxEofMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_fts3auxEofMethod_enum];
)

// Rule: .xEof = fts3termEofMethod ==> .xEof_signature = xEof_signatures[xEof_fts3termEofMethod_enum];
@transform_xEof_fts3termEofMethod@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = fts3termEofMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_fts3termEofMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_fts3termEofMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_fts3termEofMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_fts3termEofMethod_enum];
)

// Rule: .xEof = fts3tokEofMethod ==> .xEof_signature = xEof_signatures[xEof_fts3tokEofMethod_enum];
@transform_xEof_fts3tokEofMethod@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = fts3tokEofMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_fts3tokEofMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_fts3tokEofMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_fts3tokEofMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_fts3tokEofMethod_enum];
)

// Rule: .xEof = fuzzerEof ==> .xEof_signature = xEof_signatures[xEof_fuzzerEof_enum];
@transform_xEof_fuzzerEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = fuzzerEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_fuzzerEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_fuzzerEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_fuzzerEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_fuzzerEof_enum];
)

// Rule: .xEof = intarrayEof ==> .xEof_signature = xEof_signatures[xEof_intarrayEof_enum];
@transform_xEof_intarrayEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = intarrayEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_intarrayEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_intarrayEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_intarrayEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_intarrayEof_enum];
)

// Rule: .xEof = jsonEachEof ==> .xEof_signature = xEof_signatures[xEof_jsonEachEof_enum];
@transform_xEof_jsonEachEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = jsonEachEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_jsonEachEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_jsonEachEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_jsonEachEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_jsonEachEof_enum];
)

// Rule: .xEof = memstatEof ==> .xEof_signature = xEof_signatures[xEof_memstatEof_enum];
@transform_xEof_memstatEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = memstatEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_memstatEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_memstatEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_memstatEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_memstatEof_enum];
)

// Rule: .xEof = pragmaVtabEof ==> .xEof_signature = xEof_signatures[xEof_pragmaVtabEof_enum];
@transform_xEof_pragmaVtabEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = pragmaVtabEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_pragmaVtabEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_pragmaVtabEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_pragmaVtabEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_pragmaVtabEof_enum];
)

// Rule: .xEof = prefixesEof ==> .xEof_signature = xEof_signatures[xEof_prefixesEof_enum];
@transform_xEof_prefixesEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = prefixesEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_prefixesEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_prefixesEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_prefixesEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_prefixesEof_enum];
)

// Rule: .xEof = qpvtabEof ==> .xEof_signature = xEof_signatures[xEof_qpvtabEof_enum];
@transform_xEof_qpvtabEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = qpvtabEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_qpvtabEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_qpvtabEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_qpvtabEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_qpvtabEof_enum];
)

// Rule: .xEof = rtreeEof ==> .xEof_signature = xEof_signatures[xEof_rtreeEof_enum];
@transform_xEof_rtreeEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = rtreeEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_rtreeEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_rtreeEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_rtreeEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_rtreeEof_enum];
)

// Rule: .xEof = schemaEof ==> .xEof_signature = xEof_signatures[xEof_schemaEof_enum];
@transform_xEof_schemaEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = schemaEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_schemaEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_schemaEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_schemaEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_schemaEof_enum];
)

// Rule: .xEof = seriesEof ==> .xEof_signature = xEof_signatures[xEof_seriesEof_enum];
@transform_xEof_seriesEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = seriesEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_seriesEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_seriesEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_seriesEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_seriesEof_enum];
)

// Rule: .xEof = spellfix1Eof ==> .xEof_signature = xEof_signatures[xEof_spellfix1Eof_enum];
@transform_xEof_spellfix1Eof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = spellfix1Eof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_spellfix1Eof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_spellfix1Eof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_spellfix1Eof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_spellfix1Eof_enum];
)

// Rule: .xEof = statEof ==> .xEof_signature = xEof_signatures[xEof_statEof_enum];
@transform_xEof_statEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = statEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_statEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_statEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_statEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_statEof_enum];
)

// Rule: .xEof = stmtEof ==> .xEof_signature = xEof_signatures[xEof_stmtEof_enum];
@transform_xEof_stmtEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = stmtEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_stmtEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_stmtEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_stmtEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_stmtEof_enum];
)

// Rule: .xEof = tclEof ==> .xEof_signature = xEof_signatures[xEof_tclEof_enum];
@transform_xEof_tclEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = tclEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_tclEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_tclEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_tclEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_tclEof_enum];
)

// Rule: .xEof = tclvarEof ==> .xEof_signature = xEof_signatures[xEof_tclvarEof_enum];
@transform_xEof_tclvarEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = tclvarEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_tclvarEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_tclvarEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_tclvarEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_tclvarEof_enum];
)

// Rule: .xEof = templatevtabEof ==> .xEof_signature = xEof_signatures[xEof_templatevtabEof_enum];
@transform_xEof_templatevtabEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = templatevtabEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_templatevtabEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_templatevtabEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_templatevtabEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_templatevtabEof_enum];
)

// Rule: .xEof = unionEof ==> .xEof_signature = xEof_signatures[xEof_unionEof_enum];
@transform_xEof_unionEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = unionEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_unionEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_unionEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_unionEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_unionEof_enum];
)

// Rule: .xEof = vlogEof ==> .xEof_signature = xEof_signatures[xEof_vlogEof_enum];
@transform_xEof_vlogEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = vlogEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_vlogEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_vlogEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_vlogEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_vlogEof_enum];
)

// Rule: .xEof = vstattabEof ==> .xEof_signature = xEof_signatures[xEof_vstattabEof_enum];
@transform_xEof_vstattabEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = vstattabEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_vstattabEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_vstattabEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_vstattabEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_vstattabEof_enum];
)

// Rule: .xEof = vtablogEof ==> .xEof_signature = xEof_signatures[xEof_vtablogEof_enum];
@transform_xEof_vtablogEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = vtablogEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_vtablogEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_vtablogEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_vtablogEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_vtablogEof_enum];
)

// Rule: .xEof = wholenumberEof ==> .xEof_signature = xEof_signatures[xEof_wholenumberEof_enum];
@transform_xEof_wholenumberEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = wholenumberEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_wholenumberEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_wholenumberEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_wholenumberEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_wholenumberEof_enum];
)

// Rule: .xEof = zipfileEof ==> .xEof_signature = xEof_signatures[xEof_zipfileEof_enum];
@transform_xEof_zipfileEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME = zipfileEof;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_zipfileEof_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xEof_signature = xEof_signatures[xEof_zipfileEof_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_zipfileEof_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xEof_signature = xEof_signatures[xEof_zipfileEof_enum];
)

// Rules for xExprCallback (37 valid functions, 0 excluded)
// Rule: .xExprCallback = agginfoPersistExprCb ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_agginfoPersistExprCb_enum];
@transform_xExprCallback_agginfoPersistExprCb@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = agginfoPersistExprCb;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_agginfoPersistExprCb_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_agginfoPersistExprCb_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_agginfoPersistExprCb_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_agginfoPersistExprCb_enum];
)

// Rule: .xExprCallback = aggregateIdxEprRefToColCallback ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_aggregateIdxEprRefToColCallback_enum];
@transform_xExprCallback_aggregateIdxEprRefToColCallback@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = aggregateIdxEprRefToColCallback;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_aggregateIdxEprRefToColCallback_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_aggregateIdxEprRefToColCallback_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_aggregateIdxEprRefToColCallback_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_aggregateIdxEprRefToColCallback_enum];
)

// Rule: .xExprCallback = analyzeAggregate ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_analyzeAggregate_enum];
@transform_xExprCallback_analyzeAggregate@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = analyzeAggregate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_analyzeAggregate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_analyzeAggregate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_analyzeAggregate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_analyzeAggregate_enum];
)

// Rule: .xExprCallback = checkConstraintExprNode ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_checkConstraintExprNode_enum];
@transform_xExprCallback_checkConstraintExprNode@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = checkConstraintExprNode;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_checkConstraintExprNode_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_checkConstraintExprNode_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_checkConstraintExprNode_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_checkConstraintExprNode_enum];
)

// Rule: .xExprCallback = codeCursorHintCheckExpr ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_codeCursorHintCheckExpr_enum];
@transform_xExprCallback_codeCursorHintCheckExpr@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = codeCursorHintCheckExpr;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_codeCursorHintCheckExpr_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_codeCursorHintCheckExpr_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_codeCursorHintCheckExpr_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_codeCursorHintCheckExpr_enum];
)

// Rule: .xExprCallback = codeCursorHintFixExpr ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_codeCursorHintFixExpr_enum];
@transform_xExprCallback_codeCursorHintFixExpr@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = codeCursorHintFixExpr;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_codeCursorHintFixExpr_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_codeCursorHintFixExpr_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_codeCursorHintFixExpr_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_codeCursorHintFixExpr_enum];
)

// Rule: .xExprCallback = codeCursorHintIsOrFunction ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_codeCursorHintIsOrFunction_enum];
@transform_xExprCallback_codeCursorHintIsOrFunction@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = codeCursorHintIsOrFunction;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_codeCursorHintIsOrFunction_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_codeCursorHintIsOrFunction_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_codeCursorHintIsOrFunction_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_codeCursorHintIsOrFunction_enum];
)

// Rule: .xExprCallback = disallowAggregatesInOrderByCb ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_disallowAggregatesInOrderByCb_enum];
@transform_xExprCallback_disallowAggregatesInOrderByCb@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = disallowAggregatesInOrderByCb;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_disallowAggregatesInOrderByCb_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_disallowAggregatesInOrderByCb_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_disallowAggregatesInOrderByCb_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_disallowAggregatesInOrderByCb_enum];
)

// Rule: .xExprCallback = exprColumnFlagUnion ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprColumnFlagUnion_enum];
@transform_xExprCallback_exprColumnFlagUnion@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = exprColumnFlagUnion;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprColumnFlagUnion_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprColumnFlagUnion_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprColumnFlagUnion_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprColumnFlagUnion_enum];
)

// Rule: .xExprCallback = exprIdxCover ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprIdxCover_enum];
@transform_xExprCallback_exprIdxCover@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = exprIdxCover;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprIdxCover_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprIdxCover_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprIdxCover_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprIdxCover_enum];
)

// Rule: .xExprCallback = exprNodeCanReturnSubtype ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprNodeCanReturnSubtype_enum];
@transform_xExprCallback_exprNodeCanReturnSubtype@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = exprNodeCanReturnSubtype;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprNodeCanReturnSubtype_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprNodeCanReturnSubtype_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprNodeCanReturnSubtype_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprNodeCanReturnSubtype_enum];
)

// Rule: .xExprCallback = exprNodeIsConstant ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprNodeIsConstant_enum];
@transform_xExprCallback_exprNodeIsConstant@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = exprNodeIsConstant;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprNodeIsConstant_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprNodeIsConstant_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprNodeIsConstant_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprNodeIsConstant_enum];
)

// Rule: .xExprCallback = exprNodeIsConstantOrGroupBy ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprNodeIsConstantOrGroupBy_enum];
@transform_xExprCallback_exprNodeIsConstantOrGroupBy@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = exprNodeIsConstantOrGroupBy;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprNodeIsConstantOrGroupBy_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprNodeIsConstantOrGroupBy_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprNodeIsConstantOrGroupBy_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprNodeIsConstantOrGroupBy_enum];
)

// Rule: .xExprCallback = exprNodeIsDeterministic ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprNodeIsDeterministic_enum];
@transform_xExprCallback_exprNodeIsDeterministic@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = exprNodeIsDeterministic;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprNodeIsDeterministic_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprNodeIsDeterministic_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprNodeIsDeterministic_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprNodeIsDeterministic_enum];
)

// Rule: .xExprCallback = exprRefToSrcList ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprRefToSrcList_enum];
@transform_xExprCallback_exprRefToSrcList@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = exprRefToSrcList;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprRefToSrcList_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprRefToSrcList_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprRefToSrcList_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_exprRefToSrcList_enum];
)

// Rule: .xExprCallback = fixExprCb ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_fixExprCb_enum];
@transform_xExprCallback_fixExprCb@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = fixExprCb;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_fixExprCb_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_fixExprCb_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_fixExprCb_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_fixExprCb_enum];
)

// Rule: .xExprCallback = gatherSelectWindowsCallback ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_gatherSelectWindowsCallback_enum];
@transform_xExprCallback_gatherSelectWindowsCallback@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = gatherSelectWindowsCallback;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_gatherSelectWindowsCallback_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_gatherSelectWindowsCallback_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_gatherSelectWindowsCallback_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_gatherSelectWindowsCallback_enum];
)

// Rule: .xExprCallback = havingToWhereExprCb ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_havingToWhereExprCb_enum];
@transform_xExprCallback_havingToWhereExprCb@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = havingToWhereExprCb;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_havingToWhereExprCb_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_havingToWhereExprCb_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_havingToWhereExprCb_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_havingToWhereExprCb_enum];
)

// Rule: .xExprCallback = impliesNotNullRow ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_impliesNotNullRow_enum];
@transform_xExprCallback_impliesNotNullRow@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = impliesNotNullRow;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_impliesNotNullRow_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_impliesNotNullRow_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_impliesNotNullRow_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_impliesNotNullRow_enum];
)

// Rule: .xExprCallback = incrAggDepth ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_incrAggDepth_enum];
@transform_xExprCallback_incrAggDepth@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = incrAggDepth;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_incrAggDepth_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_incrAggDepth_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_incrAggDepth_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_incrAggDepth_enum];
)

// Rule: .xExprCallback = markImmutableExprStep ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_markImmutableExprStep_enum];
@transform_xExprCallback_markImmutableExprStep@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = markImmutableExprStep;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_markImmutableExprStep_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_markImmutableExprStep_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_markImmutableExprStep_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_markImmutableExprStep_enum];
)

// Rule: .xExprCallback = propagateConstantExprRewrite ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_propagateConstantExprRewrite_enum];
@transform_xExprCallback_propagateConstantExprRewrite@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = propagateConstantExprRewrite;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_propagateConstantExprRewrite_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_propagateConstantExprRewrite_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_propagateConstantExprRewrite_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_propagateConstantExprRewrite_enum];
)

// Rule: .xExprCallback = recomputeColumnsUsedExpr ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_recomputeColumnsUsedExpr_enum];
@transform_xExprCallback_recomputeColumnsUsedExpr@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = recomputeColumnsUsedExpr;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_recomputeColumnsUsedExpr_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_recomputeColumnsUsedExpr_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_recomputeColumnsUsedExpr_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_recomputeColumnsUsedExpr_enum];
)

// Rule: .xExprCallback = renameColumnExprCb ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_renameColumnExprCb_enum];
@transform_xExprCallback_renameColumnExprCb@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = renameColumnExprCb;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_renameColumnExprCb_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_renameColumnExprCb_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_renameColumnExprCb_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_renameColumnExprCb_enum];
)

// Rule: .xExprCallback = renameQuotefixExprCb ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_renameQuotefixExprCb_enum];
@transform_xExprCallback_renameQuotefixExprCb@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = renameQuotefixExprCb;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_renameQuotefixExprCb_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_renameQuotefixExprCb_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_renameQuotefixExprCb_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_renameQuotefixExprCb_enum];
)

// Rule: .xExprCallback = renameTableExprCb ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_renameTableExprCb_enum];
@transform_xExprCallback_renameTableExprCb@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = renameTableExprCb;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_renameTableExprCb_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_renameTableExprCb_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_renameTableExprCb_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_renameTableExprCb_enum];
)

// Rule: .xExprCallback = renameUnmapExprCb ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_renameUnmapExprCb_enum];
@transform_xExprCallback_renameUnmapExprCb@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = renameUnmapExprCb;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_renameUnmapExprCb_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_renameUnmapExprCb_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_renameUnmapExprCb_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_renameUnmapExprCb_enum];
)

// Rule: .xExprCallback = renumberCursorsCb ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_renumberCursorsCb_enum];
@transform_xExprCallback_renumberCursorsCb@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = renumberCursorsCb;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_renumberCursorsCb_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_renumberCursorsCb_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_renumberCursorsCb_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_renumberCursorsCb_enum];
)

// Rule: .xExprCallback = resolveExprStep ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_resolveExprStep_enum];
@transform_xExprCallback_resolveExprStep@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = resolveExprStep;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_resolveExprStep_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_resolveExprStep_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_resolveExprStep_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_resolveExprStep_enum];
)

// Rule: .xExprCallback = resolveRemoveWindowsCb ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_resolveRemoveWindowsCb_enum];
@transform_xExprCallback_resolveRemoveWindowsCb@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = resolveRemoveWindowsCb;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_resolveRemoveWindowsCb_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_resolveRemoveWindowsCb_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_resolveRemoveWindowsCb_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_resolveRemoveWindowsCb_enum];
)

// Rule: .xExprCallback = selectCheckOnClausesExpr ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_selectCheckOnClausesExpr_enum];
@transform_xExprCallback_selectCheckOnClausesExpr@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = selectCheckOnClausesExpr;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_selectCheckOnClausesExpr_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_selectCheckOnClausesExpr_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_selectCheckOnClausesExpr_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_selectCheckOnClausesExpr_enum];
)

// Rule: .xExprCallback = selectWindowRewriteExprCb ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_selectWindowRewriteExprCb_enum];
@transform_xExprCallback_selectWindowRewriteExprCb@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = selectWindowRewriteExprCb;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_selectWindowRewriteExprCb_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_selectWindowRewriteExprCb_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_selectWindowRewriteExprCb_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_selectWindowRewriteExprCb_enum];
)

// Rule: .xExprCallback = sqlite3CursorRangeHintExprCheck ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_sqlite3CursorRangeHintExprCheck_enum];
@transform_xExprCallback_sqlite3CursorRangeHintExprCheck@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = sqlite3CursorRangeHintExprCheck;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_sqlite3CursorRangeHintExprCheck_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_sqlite3CursorRangeHintExprCheck_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_sqlite3CursorRangeHintExprCheck_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_sqlite3CursorRangeHintExprCheck_enum];
)

// Rule: .xExprCallback = sqlite3ExprWalkNoop ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_sqlite3ExprWalkNoop_enum];
@transform_xExprCallback_sqlite3ExprWalkNoop@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = sqlite3ExprWalkNoop;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_sqlite3ExprWalkNoop_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_sqlite3ExprWalkNoop_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_sqlite3ExprWalkNoop_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_sqlite3ExprWalkNoop_enum];
)

// Rule: .xExprCallback = sqlite3ReturningSubqueryVarSelect ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_sqlite3ReturningSubqueryVarSelect_enum];
@transform_xExprCallback_sqlite3ReturningSubqueryVarSelect@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = sqlite3ReturningSubqueryVarSelect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_sqlite3ReturningSubqueryVarSelect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_sqlite3ReturningSubqueryVarSelect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_sqlite3ReturningSubqueryVarSelect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_sqlite3ReturningSubqueryVarSelect_enum];
)

// Rule: .xExprCallback = sqlite3WindowExtraAggFuncDepth ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_sqlite3WindowExtraAggFuncDepth_enum];
@transform_xExprCallback_sqlite3WindowExtraAggFuncDepth@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = sqlite3WindowExtraAggFuncDepth;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_sqlite3WindowExtraAggFuncDepth_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_sqlite3WindowExtraAggFuncDepth_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_sqlite3WindowExtraAggFuncDepth_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_sqlite3WindowExtraAggFuncDepth_enum];
)

// Rule: .xExprCallback = whereIsCoveringIndexWalkCallback ==> .xExprCallback_signature = xExprCallback_signatures[xExprCallback_whereIsCoveringIndexWalkCallback_enum];
@transform_xExprCallback_whereIsCoveringIndexWalkCallback@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = whereIsCoveringIndexWalkCallback;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_whereIsCoveringIndexWalkCallback_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xExprCallback_signature = xExprCallback_signatures[xExprCallback_whereIsCoveringIndexWalkCallback_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_whereIsCoveringIndexWalkCallback_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xExprCallback_signature = xExprCallback_signatures[xExprCallback_whereIsCoveringIndexWalkCallback_enum];
)

// Rules for xFetch (7 valid functions, 7 excluded)
// Rule: .xFetch = 0 ==> .xFetch_signature = xFetch_signatures[xFetch_0_enum];
@transform_xFetch_0@
expression E;
identifier FP_NAME = xFetch;
@@
(
E.FP_NAME = 0;
+ E.xFetch_signature = xFetch_signatures[xFetch_0_enum];
|
E->FP_NAME = 0;
+ E->xFetch_signature = xFetch_signatures[xFetch_0_enum];
)

// Rule: .xFetch = apndFetch ==> .xFetch_signature = xFetch_signatures[xFetch_apndFetch_enum];
@transform_xFetch_apndFetch@
expression E;
identifier FP_NAME = xFetch;
identifier FUNC_NAME = apndFetch;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFetch_signature = xFetch_signatures[xFetch_apndFetch_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFetch_signature = xFetch_signatures[xFetch_apndFetch_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFetch_signature = xFetch_signatures[xFetch_apndFetch_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFetch_signature = xFetch_signatures[xFetch_apndFetch_enum];
)

// Rule: .xFetch = memdbFetch ==> .xFetch_signature = xFetch_signatures[xFetch_memdbFetch_enum];
@transform_xFetch_memdbFetch@
expression E;
identifier FP_NAME = xFetch;
identifier FUNC_NAME = memdbFetch;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFetch_signature = xFetch_signatures[xFetch_memdbFetch_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFetch_signature = xFetch_signatures[xFetch_memdbFetch_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFetch_signature = xFetch_signatures[xFetch_memdbFetch_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFetch_signature = xFetch_signatures[xFetch_memdbFetch_enum];
)

// Rule: .xFetch = pcache1Fetch ==> .xFetch_signature = xFetch_signatures[xFetch_pcache1Fetch_enum];
@transform_xFetch_pcache1Fetch@
expression E;
identifier FP_NAME = xFetch;
identifier FUNC_NAME = pcache1Fetch;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFetch_signature = xFetch_signatures[xFetch_pcache1Fetch_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFetch_signature = xFetch_signatures[xFetch_pcache1Fetch_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFetch_signature = xFetch_signatures[xFetch_pcache1Fetch_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFetch_signature = xFetch_signatures[xFetch_pcache1Fetch_enum];
)

// Rule: .xFetch = pcachetraceFetch ==> .xFetch_signature = xFetch_signatures[xFetch_pcachetraceFetch_enum];
@transform_xFetch_pcachetraceFetch@
expression E;
identifier FP_NAME = xFetch;
identifier FUNC_NAME = pcachetraceFetch;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFetch_signature = xFetch_signatures[xFetch_pcachetraceFetch_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFetch_signature = xFetch_signatures[xFetch_pcachetraceFetch_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFetch_signature = xFetch_signatures[xFetch_pcachetraceFetch_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFetch_signature = xFetch_signatures[xFetch_pcachetraceFetch_enum];
)

// Rule: .xFetch = recoverVfsFetch ==> .xFetch_signature = xFetch_signatures[xFetch_recoverVfsFetch_enum];
@transform_xFetch_recoverVfsFetch@
expression E;
identifier FP_NAME = xFetch;
identifier FUNC_NAME = recoverVfsFetch;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFetch_signature = xFetch_signatures[xFetch_recoverVfsFetch_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFetch_signature = xFetch_signatures[xFetch_recoverVfsFetch_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFetch_signature = xFetch_signatures[xFetch_recoverVfsFetch_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFetch_signature = xFetch_signatures[xFetch_recoverVfsFetch_enum];
)

// Rule: .xFetch = unixFetch ==> .xFetch_signature = xFetch_signatures[xFetch_unixFetch_enum];
@transform_xFetch_unixFetch@
expression E;
identifier FP_NAME = xFetch;
identifier FUNC_NAME = unixFetch;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFetch_signature = xFetch_signatures[xFetch_unixFetch_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFetch_signature = xFetch_signatures[xFetch_unixFetch_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFetch_signature = xFetch_signatures[xFetch_unixFetch_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFetch_signature = xFetch_signatures[xFetch_unixFetch_enum];
)

// Rules for xFileControl (6 valid functions, 18 excluded)
// Rule: .xFileControl = 0 ==> .xFileControl_signature = xFileControl_signatures[xFileControl_0_enum];
@transform_xFileControl_0@
expression E;
identifier FP_NAME = xFileControl;
@@
(
E.FP_NAME = 0;
+ E.xFileControl_signature = xFileControl_signatures[xFileControl_0_enum];
|
E->FP_NAME = 0;
+ E->xFileControl_signature = xFileControl_signatures[xFileControl_0_enum];
)

// Rule: .xFileControl = apndFileControl ==> .xFileControl_signature = xFileControl_signatures[xFileControl_apndFileControl_enum];
@transform_xFileControl_apndFileControl@
expression E;
identifier FP_NAME = xFileControl;
identifier FUNC_NAME = apndFileControl;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFileControl_signature = xFileControl_signatures[xFileControl_apndFileControl_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFileControl_signature = xFileControl_signatures[xFileControl_apndFileControl_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFileControl_signature = xFileControl_signatures[xFileControl_apndFileControl_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFileControl_signature = xFileControl_signatures[xFileControl_apndFileControl_enum];
)

// Rule: .xFileControl = memdbFileControl ==> .xFileControl_signature = xFileControl_signatures[xFileControl_memdbFileControl_enum];
@transform_xFileControl_memdbFileControl@
expression E;
identifier FP_NAME = xFileControl;
identifier FUNC_NAME = memdbFileControl;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFileControl_signature = xFileControl_signatures[xFileControl_memdbFileControl_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFileControl_signature = xFileControl_signatures[xFileControl_memdbFileControl_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFileControl_signature = xFileControl_signatures[xFileControl_memdbFileControl_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFileControl_signature = xFileControl_signatures[xFileControl_memdbFileControl_enum];
)

// Rule: .xFileControl = recoverVfsFileControl ==> .xFileControl_signature = xFileControl_signatures[xFileControl_recoverVfsFileControl_enum];
@transform_xFileControl_recoverVfsFileControl@
expression E;
identifier FP_NAME = xFileControl;
identifier FUNC_NAME = recoverVfsFileControl;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFileControl_signature = xFileControl_signatures[xFileControl_recoverVfsFileControl_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFileControl_signature = xFileControl_signatures[xFileControl_recoverVfsFileControl_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFileControl_signature = xFileControl_signatures[xFileControl_recoverVfsFileControl_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFileControl_signature = xFileControl_signatures[xFileControl_recoverVfsFileControl_enum];
)

// Rule: .xFileControl = vfstraceFileControl ==> .xFileControl_signature = xFileControl_signatures[xFileControl_vfstraceFileControl_enum];
@transform_xFileControl_vfstraceFileControl@
expression E;
identifier FP_NAME = xFileControl;
identifier FUNC_NAME = vfstraceFileControl;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFileControl_signature = xFileControl_signatures[xFileControl_vfstraceFileControl_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFileControl_signature = xFileControl_signatures[xFileControl_vfstraceFileControl_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFileControl_signature = xFileControl_signatures[xFileControl_vfstraceFileControl_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFileControl_signature = xFileControl_signatures[xFileControl_vfstraceFileControl_enum];
)

// Rule: .xFileControl = unixFileControl ==> .xFileControl_signature = xFileControl_signatures[xFileControl_unixFileControl_enum];
@transform_xFileControl_unixFileControl@
expression E;
identifier FP_NAME = xFileControl;
identifier FUNC_NAME = unixFileControl;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFileControl_signature = xFileControl_signatures[xFileControl_unixFileControl_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFileControl_signature = xFileControl_signatures[xFileControl_unixFileControl_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFileControl_signature = xFileControl_signatures[xFileControl_unixFileControl_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFileControl_signature = xFileControl_signatures[xFileControl_unixFileControl_enum];
)

// Rules for xFileSize (6 valid functions, 18 excluded)
// Rule: .xFileSize = apndFileSize ==> .xFileSize_signature = xFileSize_signatures[xFileSize_apndFileSize_enum];
@transform_xFileSize_apndFileSize@
expression E;
identifier FP_NAME = xFileSize;
identifier FUNC_NAME = apndFileSize;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFileSize_signature = xFileSize_signatures[xFileSize_apndFileSize_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFileSize_signature = xFileSize_signatures[xFileSize_apndFileSize_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFileSize_signature = xFileSize_signatures[xFileSize_apndFileSize_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFileSize_signature = xFileSize_signatures[xFileSize_apndFileSize_enum];
)

// Rule: .xFileSize = memdbFileSize ==> .xFileSize_signature = xFileSize_signatures[xFileSize_memdbFileSize_enum];
@transform_xFileSize_memdbFileSize@
expression E;
identifier FP_NAME = xFileSize;
identifier FUNC_NAME = memdbFileSize;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFileSize_signature = xFileSize_signatures[xFileSize_memdbFileSize_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFileSize_signature = xFileSize_signatures[xFileSize_memdbFileSize_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFileSize_signature = xFileSize_signatures[xFileSize_memdbFileSize_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFileSize_signature = xFileSize_signatures[xFileSize_memdbFileSize_enum];
)

// Rule: .xFileSize = memjrnlFileSize ==> .xFileSize_signature = xFileSize_signatures[xFileSize_memjrnlFileSize_enum];
@transform_xFileSize_memjrnlFileSize@
expression E;
identifier FP_NAME = xFileSize;
identifier FUNC_NAME = memjrnlFileSize;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFileSize_signature = xFileSize_signatures[xFileSize_memjrnlFileSize_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFileSize_signature = xFileSize_signatures[xFileSize_memjrnlFileSize_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFileSize_signature = xFileSize_signatures[xFileSize_memjrnlFileSize_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFileSize_signature = xFileSize_signatures[xFileSize_memjrnlFileSize_enum];
)

// Rule: .xFileSize = recoverVfsFileSize ==> .xFileSize_signature = xFileSize_signatures[xFileSize_recoverVfsFileSize_enum];
@transform_xFileSize_recoverVfsFileSize@
expression E;
identifier FP_NAME = xFileSize;
identifier FUNC_NAME = recoverVfsFileSize;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFileSize_signature = xFileSize_signatures[xFileSize_recoverVfsFileSize_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFileSize_signature = xFileSize_signatures[xFileSize_recoverVfsFileSize_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFileSize_signature = xFileSize_signatures[xFileSize_recoverVfsFileSize_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFileSize_signature = xFileSize_signatures[xFileSize_recoverVfsFileSize_enum];
)

// Rule: .xFileSize = vfstraceFileSize ==> .xFileSize_signature = xFileSize_signatures[xFileSize_vfstraceFileSize_enum];
@transform_xFileSize_vfstraceFileSize@
expression E;
identifier FP_NAME = xFileSize;
identifier FUNC_NAME = vfstraceFileSize;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFileSize_signature = xFileSize_signatures[xFileSize_vfstraceFileSize_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFileSize_signature = xFileSize_signatures[xFileSize_vfstraceFileSize_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFileSize_signature = xFileSize_signatures[xFileSize_vfstraceFileSize_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFileSize_signature = xFileSize_signatures[xFileSize_vfstraceFileSize_enum];
)

// Rule: .xFileSize = unixFileSize ==> .xFileSize_signature = xFileSize_signatures[xFileSize_unixFileSize_enum];
@transform_xFileSize_unixFileSize@
expression E;
identifier FP_NAME = xFileSize;
identifier FUNC_NAME = unixFileSize;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFileSize_signature = xFileSize_signatures[xFileSize_unixFileSize_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFileSize_signature = xFileSize_signatures[xFileSize_unixFileSize_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFileSize_signature = xFileSize_signatures[xFileSize_unixFileSize_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFileSize_signature = xFileSize_signatures[xFileSize_unixFileSize_enum];
)

// Rules for xFilter (44 valid functions, 4 excluded)
// Rule: .xFilter = amatchFilter ==> .xFilter_signature = xFilter_signatures[xFilter_amatchFilter_enum];
@transform_xFilter_amatchFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = amatchFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_amatchFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_amatchFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_amatchFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_amatchFilter_enum];
)

// Rule: .xFilter = binfoFilter ==> .xFilter_signature = xFilter_signatures[xFilter_binfoFilter_enum];
@transform_xFilter_binfoFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = binfoFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_binfoFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_binfoFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_binfoFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_binfoFilter_enum];
)

// Rule: .xFilter = bytecodevtabFilter ==> .xFilter_signature = xFilter_signatures[xFilter_bytecodevtabFilter_enum];
@transform_xFilter_bytecodevtabFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = bytecodevtabFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_bytecodevtabFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_bytecodevtabFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_bytecodevtabFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_bytecodevtabFilter_enum];
)

// Rule: .xFilter = carrayFilter ==> .xFilter_signature = xFilter_signatures[xFilter_carrayFilter_enum];
@transform_xFilter_carrayFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = carrayFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_carrayFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_carrayFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_carrayFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_carrayFilter_enum];
)

// Rule: .xFilter = cidxFilter ==> .xFilter_signature = xFilter_signatures[xFilter_cidxFilter_enum];
@transform_xFilter_cidxFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = cidxFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_cidxFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_cidxFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_cidxFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_cidxFilter_enum];
)

// Rule: .xFilter = closureFilter ==> .xFilter_signature = xFilter_signatures[xFilter_closureFilter_enum];
@transform_xFilter_closureFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = closureFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_closureFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_closureFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_closureFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_closureFilter_enum];
)

// Rule: .xFilter = completionFilter ==> .xFilter_signature = xFilter_signatures[xFilter_completionFilter_enum];
@transform_xFilter_completionFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = completionFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_completionFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_completionFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_completionFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_completionFilter_enum];
)

// Rule: .xFilter = csvtabFilter ==> .xFilter_signature = xFilter_signatures[xFilter_csvtabFilter_enum];
@transform_xFilter_csvtabFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = csvtabFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_csvtabFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_csvtabFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_csvtabFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_csvtabFilter_enum];
)

// Rule: .xFilter = dbdataFilter ==> .xFilter_signature = xFilter_signatures[xFilter_dbdataFilter_enum];
@transform_xFilter_dbdataFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = dbdataFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_dbdataFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_dbdataFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_dbdataFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_dbdataFilter_enum];
)

// Rule: .xFilter = dbpageFilter ==> .xFilter_signature = xFilter_signatures[xFilter_dbpageFilter_enum];
@transform_xFilter_dbpageFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = dbpageFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_dbpageFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_dbpageFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_dbpageFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_dbpageFilter_enum];
)

// Rule: .xFilter = deltaparsevtabFilter ==> .xFilter_signature = xFilter_signatures[xFilter_deltaparsevtabFilter_enum];
@transform_xFilter_deltaparsevtabFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = deltaparsevtabFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_deltaparsevtabFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_deltaparsevtabFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_deltaparsevtabFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_deltaparsevtabFilter_enum];
)

// Rule: .xFilter = echoFilter ==> .xFilter_signature = xFilter_signatures[xFilter_echoFilter_enum];
@transform_xFilter_echoFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = echoFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_echoFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_echoFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_echoFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_echoFilter_enum];
)

// Rule: .xFilter = expertFilter ==> .xFilter_signature = xFilter_signatures[xFilter_expertFilter_enum];
@transform_xFilter_expertFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = expertFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_expertFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_expertFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_expertFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_expertFilter_enum];
)

// Rule: .xFilter = explainFilter ==> .xFilter_signature = xFilter_signatures[xFilter_explainFilter_enum];
@transform_xFilter_explainFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = explainFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_explainFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_explainFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_explainFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_explainFilter_enum];
)

// Rule: .xFilter = fsFilter ==> .xFilter_signature = xFilter_signatures[xFilter_fsFilter_enum];
@transform_xFilter_fsFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = fsFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_fsFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_fsFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_fsFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_fsFilter_enum];
)

// Rule: .xFilter = fsdirFilter ==> .xFilter_signature = xFilter_signatures[xFilter_fsdirFilter_enum];
@transform_xFilter_fsdirFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = fsdirFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_fsdirFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_fsdirFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_fsdirFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_fsdirFilter_enum];
)

// Rule: .xFilter = fstreeFilter ==> .xFilter_signature = xFilter_signatures[xFilter_fstreeFilter_enum];
@transform_xFilter_fstreeFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = fstreeFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_fstreeFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_fstreeFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_fstreeFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_fstreeFilter_enum];
)

// Rule: .xFilter = fts3FilterMethod ==> .xFilter_signature = xFilter_signatures[xFilter_fts3FilterMethod_enum];
@transform_xFilter_fts3FilterMethod@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = fts3FilterMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_fts3FilterMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_fts3FilterMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_fts3FilterMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_fts3FilterMethod_enum];
)

// Rule: .xFilter = fts3auxFilterMethod ==> .xFilter_signature = xFilter_signatures[xFilter_fts3auxFilterMethod_enum];
@transform_xFilter_fts3auxFilterMethod@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = fts3auxFilterMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_fts3auxFilterMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_fts3auxFilterMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_fts3auxFilterMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_fts3auxFilterMethod_enum];
)

// Rule: .xFilter = fts3termFilterMethod ==> .xFilter_signature = xFilter_signatures[xFilter_fts3termFilterMethod_enum];
@transform_xFilter_fts3termFilterMethod@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = fts3termFilterMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_fts3termFilterMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_fts3termFilterMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_fts3termFilterMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_fts3termFilterMethod_enum];
)

// Rule: .xFilter = fts3tokFilterMethod ==> .xFilter_signature = xFilter_signatures[xFilter_fts3tokFilterMethod_enum];
@transform_xFilter_fts3tokFilterMethod@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = fts3tokFilterMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_fts3tokFilterMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_fts3tokFilterMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_fts3tokFilterMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_fts3tokFilterMethod_enum];
)

// Rule: .xFilter = fuzzerFilter ==> .xFilter_signature = xFilter_signatures[xFilter_fuzzerFilter_enum];
@transform_xFilter_fuzzerFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = fuzzerFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_fuzzerFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_fuzzerFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_fuzzerFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_fuzzerFilter_enum];
)

// Rule: .xFilter = geopolyFilter ==> .xFilter_signature = xFilter_signatures[xFilter_geopolyFilter_enum];
@transform_xFilter_geopolyFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = geopolyFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_geopolyFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_geopolyFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_geopolyFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_geopolyFilter_enum];
)

// Rule: .xFilter = intarrayFilter ==> .xFilter_signature = xFilter_signatures[xFilter_intarrayFilter_enum];
@transform_xFilter_intarrayFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = intarrayFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_intarrayFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_intarrayFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_intarrayFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_intarrayFilter_enum];
)

// Rule: .xFilter = jsonEachFilter ==> .xFilter_signature = xFilter_signatures[xFilter_jsonEachFilter_enum];
@transform_xFilter_jsonEachFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = jsonEachFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_jsonEachFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_jsonEachFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_jsonEachFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_jsonEachFilter_enum];
)

// Rule: .xFilter = memstatFilter ==> .xFilter_signature = xFilter_signatures[xFilter_memstatFilter_enum];
@transform_xFilter_memstatFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = memstatFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_memstatFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_memstatFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_memstatFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_memstatFilter_enum];
)

// Rule: .xFilter = pragmaVtabFilter ==> .xFilter_signature = xFilter_signatures[xFilter_pragmaVtabFilter_enum];
@transform_xFilter_pragmaVtabFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = pragmaVtabFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_pragmaVtabFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_pragmaVtabFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_pragmaVtabFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_pragmaVtabFilter_enum];
)

// Rule: .xFilter = prefixesFilter ==> .xFilter_signature = xFilter_signatures[xFilter_prefixesFilter_enum];
@transform_xFilter_prefixesFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = prefixesFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_prefixesFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_prefixesFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_prefixesFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_prefixesFilter_enum];
)

// Rule: .xFilter = qpvtabFilter ==> .xFilter_signature = xFilter_signatures[xFilter_qpvtabFilter_enum];
@transform_xFilter_qpvtabFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = qpvtabFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_qpvtabFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_qpvtabFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_qpvtabFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_qpvtabFilter_enum];
)

// Rule: .xFilter = rtreeFilter ==> .xFilter_signature = xFilter_signatures[xFilter_rtreeFilter_enum];
@transform_xFilter_rtreeFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = rtreeFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_rtreeFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_rtreeFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_rtreeFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_rtreeFilter_enum];
)

// Rule: .xFilter = schemaFilter ==> .xFilter_signature = xFilter_signatures[xFilter_schemaFilter_enum];
@transform_xFilter_schemaFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = schemaFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_schemaFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_schemaFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_schemaFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_schemaFilter_enum];
)

// Rule: .xFilter = seriesFilter ==> .xFilter_signature = xFilter_signatures[xFilter_seriesFilter_enum];
@transform_xFilter_seriesFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = seriesFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_seriesFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_seriesFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_seriesFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_seriesFilter_enum];
)

// Rule: .xFilter = spellfix1Filter ==> .xFilter_signature = xFilter_signatures[xFilter_spellfix1Filter_enum];
@transform_xFilter_spellfix1Filter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = spellfix1Filter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_spellfix1Filter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_spellfix1Filter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_spellfix1Filter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_spellfix1Filter_enum];
)

// Rule: .xFilter = statFilter ==> .xFilter_signature = xFilter_signatures[xFilter_statFilter_enum];
@transform_xFilter_statFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = statFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_statFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_statFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_statFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_statFilter_enum];
)

// Rule: .xFilter = stmtFilter ==> .xFilter_signature = xFilter_signatures[xFilter_stmtFilter_enum];
@transform_xFilter_stmtFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = stmtFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_stmtFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_stmtFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_stmtFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_stmtFilter_enum];
)

// Rule: .xFilter = tclFilter ==> .xFilter_signature = xFilter_signatures[xFilter_tclFilter_enum];
@transform_xFilter_tclFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = tclFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_tclFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_tclFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_tclFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_tclFilter_enum];
)

// Rule: .xFilter = tclvarFilter ==> .xFilter_signature = xFilter_signatures[xFilter_tclvarFilter_enum];
@transform_xFilter_tclvarFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = tclvarFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_tclvarFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_tclvarFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_tclvarFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_tclvarFilter_enum];
)

// Rule: .xFilter = templatevtabFilter ==> .xFilter_signature = xFilter_signatures[xFilter_templatevtabFilter_enum];
@transform_xFilter_templatevtabFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = templatevtabFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_templatevtabFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_templatevtabFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_templatevtabFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_templatevtabFilter_enum];
)

// Rule: .xFilter = unionFilter ==> .xFilter_signature = xFilter_signatures[xFilter_unionFilter_enum];
@transform_xFilter_unionFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = unionFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_unionFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_unionFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_unionFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_unionFilter_enum];
)

// Rule: .xFilter = vlogFilter ==> .xFilter_signature = xFilter_signatures[xFilter_vlogFilter_enum];
@transform_xFilter_vlogFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = vlogFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_vlogFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_vlogFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_vlogFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_vlogFilter_enum];
)

// Rule: .xFilter = vstattabFilter ==> .xFilter_signature = xFilter_signatures[xFilter_vstattabFilter_enum];
@transform_xFilter_vstattabFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = vstattabFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_vstattabFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_vstattabFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_vstattabFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_vstattabFilter_enum];
)

// Rule: .xFilter = vtablogFilter ==> .xFilter_signature = xFilter_signatures[xFilter_vtablogFilter_enum];
@transform_xFilter_vtablogFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = vtablogFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_vtablogFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_vtablogFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_vtablogFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_vtablogFilter_enum];
)

// Rule: .xFilter = wholenumberFilter ==> .xFilter_signature = xFilter_signatures[xFilter_wholenumberFilter_enum];
@transform_xFilter_wholenumberFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = wholenumberFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_wholenumberFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_wholenumberFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_wholenumberFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_wholenumberFilter_enum];
)

// Rule: .xFilter = zipfileFilter ==> .xFilter_signature = xFilter_signatures[xFilter_zipfileFilter_enum];
@transform_xFilter_zipfileFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME = zipfileFilter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_zipfileFilter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFilter_signature = xFilter_signatures[xFilter_zipfileFilter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_zipfileFilter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFilter_signature = xFilter_signatures[xFilter_zipfileFilter_enum];
)

// Rules for xFindFunction (3 valid functions, 5 excluded)
// Rule: .xFindFunction = 0 ==> .xFindFunction_signature = xFindFunction_signatures[xFindFunction_0_enum];
@transform_xFindFunction_0@
expression E;
identifier FP_NAME = xFindFunction;
@@
(
E.FP_NAME = 0;
+ E.xFindFunction_signature = xFindFunction_signatures[xFindFunction_0_enum];
|
E->FP_NAME = 0;
+ E->xFindFunction_signature = xFindFunction_signatures[xFindFunction_0_enum];
)

// Rule: .xFindFunction = fts3FindFunctionMethod ==> .xFindFunction_signature = xFindFunction_signatures[xFindFunction_fts3FindFunctionMethod_enum];
@transform_xFindFunction_fts3FindFunctionMethod@
expression E;
identifier FP_NAME = xFindFunction;
identifier FUNC_NAME = fts3FindFunctionMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFindFunction_signature = xFindFunction_signatures[xFindFunction_fts3FindFunctionMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFindFunction_signature = xFindFunction_signatures[xFindFunction_fts3FindFunctionMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFindFunction_signature = xFindFunction_signatures[xFindFunction_fts3FindFunctionMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFindFunction_signature = xFindFunction_signatures[xFindFunction_fts3FindFunctionMethod_enum];
)

// Rule: .xFindFunction = zipfileFindFunction ==> .xFindFunction_signature = xFindFunction_signatures[xFindFunction_zipfileFindFunction_enum];
@transform_xFindFunction_zipfileFindFunction@
expression E;
identifier FP_NAME = xFindFunction;
identifier FUNC_NAME = zipfileFindFunction;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFindFunction_signature = xFindFunction_signatures[xFindFunction_zipfileFindFunction_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFindFunction_signature = xFindFunction_signatures[xFindFunction_zipfileFindFunction_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFindFunction_signature = xFindFunction_signatures[xFindFunction_zipfileFindFunction_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFindFunction_signature = xFindFunction_signatures[xFindFunction_zipfileFindFunction_enum];
)

// Rules for xFree (2 valid functions, 5 excluded)
// Rule: .xFree = memtraceFree ==> .xFree_signature = xFree_signatures[xFree_memtraceFree_enum];
@transform_xFree_memtraceFree@
expression E;
identifier FP_NAME = xFree;
identifier FUNC_NAME = memtraceFree;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFree_signature = xFree_signatures[xFree_memtraceFree_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFree_signature = xFree_signatures[xFree_memtraceFree_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFree_signature = xFree_signatures[xFree_memtraceFree_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFree_signature = xFree_signatures[xFree_memtraceFree_enum];
)

// Rule: .xFree = sqlite3MemFree ==> .xFree_signature = xFree_signatures[xFree_sqlite3MemFree_enum];
@transform_xFree_sqlite3MemFree@
expression E;
identifier FP_NAME = xFree;
identifier FUNC_NAME = sqlite3MemFree;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFree_signature = xFree_signatures[xFree_sqlite3MemFree_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFree_signature = xFree_signatures[xFree_sqlite3MemFree_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFree_signature = xFree_signatures[xFree_sqlite3MemFree_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFree_signature = xFree_signatures[xFree_sqlite3MemFree_enum];
)

// Rules for xFullPathname (4 valid functions, 12 excluded)
// Rule: .xFullPathname = apndFullPathname ==> .xFullPathname_signature = xFullPathname_signatures[xFullPathname_apndFullPathname_enum];
@transform_xFullPathname_apndFullPathname@
expression E;
identifier FP_NAME = xFullPathname;
identifier FUNC_NAME = apndFullPathname;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFullPathname_signature = xFullPathname_signatures[xFullPathname_apndFullPathname_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFullPathname_signature = xFullPathname_signatures[xFullPathname_apndFullPathname_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFullPathname_signature = xFullPathname_signatures[xFullPathname_apndFullPathname_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFullPathname_signature = xFullPathname_signatures[xFullPathname_apndFullPathname_enum];
)

// Rule: .xFullPathname = memdbFullPathname ==> .xFullPathname_signature = xFullPathname_signatures[xFullPathname_memdbFullPathname_enum];
@transform_xFullPathname_memdbFullPathname@
expression E;
identifier FP_NAME = xFullPathname;
identifier FUNC_NAME = memdbFullPathname;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFullPathname_signature = xFullPathname_signatures[xFullPathname_memdbFullPathname_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFullPathname_signature = xFullPathname_signatures[xFullPathname_memdbFullPathname_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFullPathname_signature = xFullPathname_signatures[xFullPathname_memdbFullPathname_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFullPathname_signature = xFullPathname_signatures[xFullPathname_memdbFullPathname_enum];
)

// Rule: .xFullPathname = vfstraceFullPathname ==> .xFullPathname_signature = xFullPathname_signatures[xFullPathname_vfstraceFullPathname_enum];
@transform_xFullPathname_vfstraceFullPathname@
expression E;
identifier FP_NAME = xFullPathname;
identifier FUNC_NAME = vfstraceFullPathname;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFullPathname_signature = xFullPathname_signatures[xFullPathname_vfstraceFullPathname_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFullPathname_signature = xFullPathname_signatures[xFullPathname_vfstraceFullPathname_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFullPathname_signature = xFullPathname_signatures[xFullPathname_vfstraceFullPathname_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFullPathname_signature = xFullPathname_signatures[xFullPathname_vfstraceFullPathname_enum];
)

// Rule: .xFullPathname = unixFullPathname ==> .xFullPathname_signature = xFullPathname_signatures[xFullPathname_unixFullPathname_enum];
@transform_xFullPathname_unixFullPathname@
expression E;
identifier FP_NAME = xFullPathname;
identifier FUNC_NAME = unixFullPathname;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xFullPathname_signature = xFullPathname_signatures[xFullPathname_unixFullPathname_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xFullPathname_signature = xFullPathname_signatures[xFullPathname_unixFullPathname_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xFullPathname_signature = xFullPathname_signatures[xFullPathname_unixFullPathname_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xFullPathname_signature = xFullPathname_signatures[xFullPathname_unixFullPathname_enum];
)

// Rules for xGet (3 valid functions, 0 excluded)
// Rule: .xGet = getPageError ==> .xGet_signature = xGet_signatures[xGet_getPageError_enum];
@transform_xGet_getPageError@
expression E;
identifier FP_NAME = xGet;
identifier FUNC_NAME = getPageError;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xGet_signature = xGet_signatures[xGet_getPageError_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xGet_signature = xGet_signatures[xGet_getPageError_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xGet_signature = xGet_signatures[xGet_getPageError_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xGet_signature = xGet_signatures[xGet_getPageError_enum];
)

// Rule: .xGet = getPageMMap ==> .xGet_signature = xGet_signatures[xGet_getPageMMap_enum];
@transform_xGet_getPageMMap@
expression E;
identifier FP_NAME = xGet;
identifier FUNC_NAME = getPageMMap;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xGet_signature = xGet_signatures[xGet_getPageMMap_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xGet_signature = xGet_signatures[xGet_getPageMMap_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xGet_signature = xGet_signatures[xGet_getPageMMap_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xGet_signature = xGet_signatures[xGet_getPageMMap_enum];
)

// Rule: .xGet = getPageNormal ==> .xGet_signature = xGet_signatures[xGet_getPageNormal_enum];
@transform_xGet_getPageNormal@
expression E;
identifier FP_NAME = xGet;
identifier FUNC_NAME = getPageNormal;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xGet_signature = xGet_signatures[xGet_getPageNormal_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xGet_signature = xGet_signatures[xGet_getPageNormal_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xGet_signature = xGet_signatures[xGet_getPageNormal_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xGet_signature = xGet_signatures[xGet_getPageNormal_enum];
)

// Rules for xGetLastError (4 valid functions, 7 excluded)
// Rule: .xGetLastError = 0 ==> .xGetLastError_signature = xGetLastError_signatures[xGetLastError_0_enum];
@transform_xGetLastError_0@
expression E;
identifier FP_NAME = xGetLastError;
@@
(
E.FP_NAME = 0;
+ E.xGetLastError_signature = xGetLastError_signatures[xGetLastError_0_enum];
|
E->FP_NAME = 0;
+ E->xGetLastError_signature = xGetLastError_signatures[xGetLastError_0_enum];
)

// Rule: .xGetLastError = apndGetLastError ==> .xGetLastError_signature = xGetLastError_signatures[xGetLastError_apndGetLastError_enum];
@transform_xGetLastError_apndGetLastError@
expression E;
identifier FP_NAME = xGetLastError;
identifier FUNC_NAME = apndGetLastError;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xGetLastError_signature = xGetLastError_signatures[xGetLastError_apndGetLastError_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xGetLastError_signature = xGetLastError_signatures[xGetLastError_apndGetLastError_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xGetLastError_signature = xGetLastError_signatures[xGetLastError_apndGetLastError_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xGetLastError_signature = xGetLastError_signatures[xGetLastError_apndGetLastError_enum];
)

// Rule: .xGetLastError = memdbGetLastError ==> .xGetLastError_signature = xGetLastError_signatures[xGetLastError_memdbGetLastError_enum];
@transform_xGetLastError_memdbGetLastError@
expression E;
identifier FP_NAME = xGetLastError;
identifier FUNC_NAME = memdbGetLastError;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xGetLastError_signature = xGetLastError_signatures[xGetLastError_memdbGetLastError_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xGetLastError_signature = xGetLastError_signatures[xGetLastError_memdbGetLastError_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xGetLastError_signature = xGetLastError_signatures[xGetLastError_memdbGetLastError_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xGetLastError_signature = xGetLastError_signatures[xGetLastError_memdbGetLastError_enum];
)

// Rule: .xGetLastError = unixGetLastError ==> .xGetLastError_signature = xGetLastError_signatures[xGetLastError_unixGetLastError_enum];
@transform_xGetLastError_unixGetLastError@
expression E;
identifier FP_NAME = xGetLastError;
identifier FUNC_NAME = unixGetLastError;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xGetLastError_signature = xGetLastError_signatures[xGetLastError_unixGetLastError_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xGetLastError_signature = xGetLastError_signatures[xGetLastError_unixGetLastError_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xGetLastError_signature = xGetLastError_signatures[xGetLastError_unixGetLastError_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xGetLastError_signature = xGetLastError_signatures[xGetLastError_unixGetLastError_enum];
)

// Rules for xGetSystemCall (3 valid functions, 5 excluded)
// Rule: .xGetSystemCall = 0 ==> .xGetSystemCall_signature = xGetSystemCall_signatures[xGetSystemCall_0_enum];
@transform_xGetSystemCall_0@
expression E;
identifier FP_NAME = xGetSystemCall;
@@
(
E.FP_NAME = 0;
+ E.xGetSystemCall_signature = xGetSystemCall_signatures[xGetSystemCall_0_enum];
|
E->FP_NAME = 0;
+ E->xGetSystemCall_signature = xGetSystemCall_signatures[xGetSystemCall_0_enum];
)

// Rule: .xGetSystemCall = apndGetSystemCall ==> .xGetSystemCall_signature = xGetSystemCall_signatures[xGetSystemCall_apndGetSystemCall_enum];
@transform_xGetSystemCall_apndGetSystemCall@
expression E;
identifier FP_NAME = xGetSystemCall;
identifier FUNC_NAME = apndGetSystemCall;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xGetSystemCall_signature = xGetSystemCall_signatures[xGetSystemCall_apndGetSystemCall_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xGetSystemCall_signature = xGetSystemCall_signatures[xGetSystemCall_apndGetSystemCall_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xGetSystemCall_signature = xGetSystemCall_signatures[xGetSystemCall_apndGetSystemCall_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xGetSystemCall_signature = xGetSystemCall_signatures[xGetSystemCall_apndGetSystemCall_enum];
)

// Rule: .xGetSystemCall = unixGetSystemCall ==> .xGetSystemCall_signature = xGetSystemCall_signatures[xGetSystemCall_unixGetSystemCall_enum];
@transform_xGetSystemCall_unixGetSystemCall@
expression E;
identifier FP_NAME = xGetSystemCall;
identifier FUNC_NAME = unixGetSystemCall;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xGetSystemCall_signature = xGetSystemCall_signatures[xGetSystemCall_unixGetSystemCall_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xGetSystemCall_signature = xGetSystemCall_signatures[xGetSystemCall_unixGetSystemCall_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xGetSystemCall_signature = xGetSystemCall_signatures[xGetSystemCall_unixGetSystemCall_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xGetSystemCall_signature = xGetSystemCall_signatures[xGetSystemCall_unixGetSystemCall_enum];
)

// Rules for xInit (4 valid functions, 6 excluded)
// Rule: .xInit = memtraceInit ==> .xInit_signature = xInit_signatures[xInit_memtraceInit_enum];
@transform_xInit_memtraceInit@
expression E;
identifier FP_NAME = xInit;
identifier FUNC_NAME = memtraceInit;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xInit_signature = xInit_signatures[xInit_memtraceInit_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xInit_signature = xInit_signatures[xInit_memtraceInit_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xInit_signature = xInit_signatures[xInit_memtraceInit_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xInit_signature = xInit_signatures[xInit_memtraceInit_enum];
)

// Rule: .xInit = pcache1Init ==> .xInit_signature = xInit_signatures[xInit_pcache1Init_enum];
@transform_xInit_pcache1Init@
expression E;
identifier FP_NAME = xInit;
identifier FUNC_NAME = pcache1Init;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xInit_signature = xInit_signatures[xInit_pcache1Init_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xInit_signature = xInit_signatures[xInit_pcache1Init_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xInit_signature = xInit_signatures[xInit_pcache1Init_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xInit_signature = xInit_signatures[xInit_pcache1Init_enum];
)

// Rule: .xInit = pcachetraceInit ==> .xInit_signature = xInit_signatures[xInit_pcachetraceInit_enum];
@transform_xInit_pcachetraceInit@
expression E;
identifier FP_NAME = xInit;
identifier FUNC_NAME = pcachetraceInit;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xInit_signature = xInit_signatures[xInit_pcachetraceInit_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xInit_signature = xInit_signatures[xInit_pcachetraceInit_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xInit_signature = xInit_signatures[xInit_pcachetraceInit_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xInit_signature = xInit_signatures[xInit_pcachetraceInit_enum];
)

// Rule: .xInit = sqlite3MemInit ==> .xInit_signature = xInit_signatures[xInit_sqlite3MemInit_enum];
@transform_xInit_sqlite3MemInit@
expression E;
identifier FP_NAME = xInit;
identifier FUNC_NAME = sqlite3MemInit;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xInit_signature = xInit_signatures[xInit_sqlite3MemInit_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xInit_signature = xInit_signatures[xInit_sqlite3MemInit_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xInit_signature = xInit_signatures[xInit_sqlite3MemInit_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xInit_signature = xInit_signatures[xInit_sqlite3MemInit_enum];
)

// Rules for xIntegrity (4 valid functions, 1 excluded)
// Rule: .xIntegrity = 0 ==> .xIntegrity_signature = xIntegrity_signatures[xIntegrity_0_enum];
@transform_xIntegrity_0@
expression E;
identifier FP_NAME = xIntegrity;
@@
(
E.FP_NAME = 0;
+ E.xIntegrity_signature = xIntegrity_signatures[xIntegrity_0_enum];
|
E->FP_NAME = 0;
+ E->xIntegrity_signature = xIntegrity_signatures[xIntegrity_0_enum];
)

// Rule: .xIntegrity = fts3IntegrityMethod ==> .xIntegrity_signature = xIntegrity_signatures[xIntegrity_fts3IntegrityMethod_enum];
@transform_xIntegrity_fts3IntegrityMethod@
expression E;
identifier FP_NAME = xIntegrity;
identifier FUNC_NAME = fts3IntegrityMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xIntegrity_signature = xIntegrity_signatures[xIntegrity_fts3IntegrityMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xIntegrity_signature = xIntegrity_signatures[xIntegrity_fts3IntegrityMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xIntegrity_signature = xIntegrity_signatures[xIntegrity_fts3IntegrityMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xIntegrity_signature = xIntegrity_signatures[xIntegrity_fts3IntegrityMethod_enum];
)

// Rule: .xIntegrity = rtreeIntegrity ==> .xIntegrity_signature = xIntegrity_signatures[xIntegrity_rtreeIntegrity_enum];
@transform_xIntegrity_rtreeIntegrity@
expression E;
identifier FP_NAME = xIntegrity;
identifier FUNC_NAME = rtreeIntegrity;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xIntegrity_signature = xIntegrity_signatures[xIntegrity_rtreeIntegrity_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xIntegrity_signature = xIntegrity_signatures[xIntegrity_rtreeIntegrity_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xIntegrity_signature = xIntegrity_signatures[xIntegrity_rtreeIntegrity_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xIntegrity_signature = xIntegrity_signatures[xIntegrity_rtreeIntegrity_enum];
)

// Rule: .xIntegrity = vtablogIntegrity ==> .xIntegrity_signature = xIntegrity_signatures[xIntegrity_vtablogIntegrity_enum];
@transform_xIntegrity_vtablogIntegrity@
expression E;
identifier FP_NAME = xIntegrity;
identifier FUNC_NAME = vtablogIntegrity;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xIntegrity_signature = xIntegrity_signatures[xIntegrity_vtablogIntegrity_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xIntegrity_signature = xIntegrity_signatures[xIntegrity_vtablogIntegrity_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xIntegrity_signature = xIntegrity_signatures[xIntegrity_vtablogIntegrity_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xIntegrity_signature = xIntegrity_signatures[xIntegrity_vtablogIntegrity_enum];
)

// Rules for xLanguageid (1 valid functions, 1 excluded)
// Rule: .xLanguageid = 0 ==> .xLanguageid_signature = xLanguageid_signatures[xLanguageid_0_enum];
@transform_xLanguageid_0@
expression E;
identifier FP_NAME = xLanguageid;
@@
(
E.FP_NAME = 0;
+ E.xLanguageid_signature = xLanguageid_signatures[xLanguageid_0_enum];
|
E->FP_NAME = 0;
+ E->xLanguageid_signature = xLanguageid_signatures[xLanguageid_0_enum];
)

// Rules for xLock (8 valid functions, 22 excluded)
// Rule: .xLock = 0 ==> .xLock_signature = xLock_signatures[xLock_0_enum];
@transform_xLock_0@
expression E;
identifier FP_NAME = xLock;
@@
(
E.FP_NAME = 0;
+ E.xLock_signature = xLock_signatures[xLock_0_enum];
|
E->FP_NAME = 0;
+ E->xLock_signature = xLock_signatures[xLock_0_enum];
)

// Rule: .xLock = apndLock ==> .xLock_signature = xLock_signatures[xLock_apndLock_enum];
@transform_xLock_apndLock@
expression E;
identifier FP_NAME = xLock;
identifier FUNC_NAME = apndLock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xLock_signature = xLock_signatures[xLock_apndLock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xLock_signature = xLock_signatures[xLock_apndLock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xLock_signature = xLock_signatures[xLock_apndLock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xLock_signature = xLock_signatures[xLock_apndLock_enum];
)

// Rule: .xLock = memdbLock ==> .xLock_signature = xLock_signatures[xLock_memdbLock_enum];
@transform_xLock_memdbLock@
expression E;
identifier FP_NAME = xLock;
identifier FUNC_NAME = memdbLock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xLock_signature = xLock_signatures[xLock_memdbLock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xLock_signature = xLock_signatures[xLock_memdbLock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xLock_signature = xLock_signatures[xLock_memdbLock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xLock_signature = xLock_signatures[xLock_memdbLock_enum];
)

// Rule: .xLock = recoverVfsLock ==> .xLock_signature = xLock_signatures[xLock_recoverVfsLock_enum];
@transform_xLock_recoverVfsLock@
expression E;
identifier FP_NAME = xLock;
identifier FUNC_NAME = recoverVfsLock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xLock_signature = xLock_signatures[xLock_recoverVfsLock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xLock_signature = xLock_signatures[xLock_recoverVfsLock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xLock_signature = xLock_signatures[xLock_recoverVfsLock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xLock_signature = xLock_signatures[xLock_recoverVfsLock_enum];
)

// Rule: .xLock = vfstraceLock ==> .xLock_signature = xLock_signatures[xLock_vfstraceLock_enum];
@transform_xLock_vfstraceLock@
expression E;
identifier FP_NAME = xLock;
identifier FUNC_NAME = vfstraceLock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xLock_signature = xLock_signatures[xLock_vfstraceLock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xLock_signature = xLock_signatures[xLock_vfstraceLock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xLock_signature = xLock_signatures[xLock_vfstraceLock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xLock_signature = xLock_signatures[xLock_vfstraceLock_enum];
)

// Rule: .xLock = unixLock ==> .xLock_signature = xLock_signatures[xLock_unixLock_enum];
@transform_xLock_unixLock@
expression E;
identifier FP_NAME = xLock;
identifier FUNC_NAME = unixLock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xLock_signature = xLock_signatures[xLock_unixLock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xLock_signature = xLock_signatures[xLock_unixLock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xLock_signature = xLock_signatures[xLock_unixLock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xLock_signature = xLock_signatures[xLock_unixLock_enum];
)

// Rule: .xLock = nolockLock ==> .xLock_signature = xLock_signatures[xLock_nolockLock_enum];
@transform_xLock_nolockLock@
expression E;
identifier FP_NAME = xLock;
identifier FUNC_NAME = nolockLock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xLock_signature = xLock_signatures[xLock_nolockLock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xLock_signature = xLock_signatures[xLock_nolockLock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xLock_signature = xLock_signatures[xLock_nolockLock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xLock_signature = xLock_signatures[xLock_nolockLock_enum];
)

// Rule: .xLock = dotlockLock ==> .xLock_signature = xLock_signatures[xLock_dotlockLock_enum];
@transform_xLock_dotlockLock@
expression E;
identifier FP_NAME = xLock;
identifier FUNC_NAME = dotlockLock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xLock_signature = xLock_signatures[xLock_dotlockLock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xLock_signature = xLock_signatures[xLock_dotlockLock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xLock_signature = xLock_signatures[xLock_dotlockLock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xLock_signature = xLock_signatures[xLock_dotlockLock_enum];
)

// Rules for xMalloc (2 valid functions, 5 excluded)
// Rule: .xMalloc = memtraceMalloc ==> .xMalloc_signature = xMalloc_signatures[xMalloc_memtraceMalloc_enum];
@transform_xMalloc_memtraceMalloc@
expression E;
identifier FP_NAME = xMalloc;
identifier FUNC_NAME = memtraceMalloc;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMalloc_signature = xMalloc_signatures[xMalloc_memtraceMalloc_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMalloc_signature = xMalloc_signatures[xMalloc_memtraceMalloc_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMalloc_signature = xMalloc_signatures[xMalloc_memtraceMalloc_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMalloc_signature = xMalloc_signatures[xMalloc_memtraceMalloc_enum];
)

// Rule: .xMalloc = sqlite3MemMalloc ==> .xMalloc_signature = xMalloc_signatures[xMalloc_sqlite3MemMalloc_enum];
@transform_xMalloc_sqlite3MemMalloc@
expression E;
identifier FP_NAME = xMalloc;
identifier FUNC_NAME = sqlite3MemMalloc;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMalloc_signature = xMalloc_signatures[xMalloc_sqlite3MemMalloc_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMalloc_signature = xMalloc_signatures[xMalloc_sqlite3MemMalloc_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMalloc_signature = xMalloc_signatures[xMalloc_sqlite3MemMalloc_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMalloc_signature = xMalloc_signatures[xMalloc_sqlite3MemMalloc_enum];
)

// Rules for xMutexAlloc (7 valid functions, 0 excluded)
// Rule: .xMutexAlloc = checkMutexAlloc ==> .xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_checkMutexAlloc_enum];
@transform_xMutexAlloc_checkMutexAlloc@
expression E;
identifier FP_NAME = xMutexAlloc;
identifier FUNC_NAME = checkMutexAlloc;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_checkMutexAlloc_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_checkMutexAlloc_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_checkMutexAlloc_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_checkMutexAlloc_enum];
)

// Rule: .xMutexAlloc = counterMutexAlloc ==> .xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_counterMutexAlloc_enum];
@transform_xMutexAlloc_counterMutexAlloc@
expression E;
identifier FP_NAME = xMutexAlloc;
identifier FUNC_NAME = counterMutexAlloc;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_counterMutexAlloc_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_counterMutexAlloc_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_counterMutexAlloc_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_counterMutexAlloc_enum];
)

// Rule: .xMutexAlloc = debugMutexAlloc ==> .xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_debugMutexAlloc_enum];
@transform_xMutexAlloc_debugMutexAlloc@
expression E;
identifier FP_NAME = xMutexAlloc;
identifier FUNC_NAME = debugMutexAlloc;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_debugMutexAlloc_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_debugMutexAlloc_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_debugMutexAlloc_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_debugMutexAlloc_enum];
)

// Rule: .xMutexAlloc = noopMutexAlloc ==> .xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_noopMutexAlloc_enum];
@transform_xMutexAlloc_noopMutexAlloc@
expression E;
identifier FP_NAME = xMutexAlloc;
identifier FUNC_NAME = noopMutexAlloc;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_noopMutexAlloc_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_noopMutexAlloc_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_noopMutexAlloc_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_noopMutexAlloc_enum];
)

// Rule: .xMutexAlloc = pthreadMutexAlloc ==> .xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_pthreadMutexAlloc_enum];
@transform_xMutexAlloc_pthreadMutexAlloc@
expression E;
identifier FP_NAME = xMutexAlloc;
identifier FUNC_NAME = pthreadMutexAlloc;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_pthreadMutexAlloc_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_pthreadMutexAlloc_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_pthreadMutexAlloc_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_pthreadMutexAlloc_enum];
)

// Rule: .xMutexAlloc = winMutexAlloc ==> .xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_winMutexAlloc_enum];
@transform_xMutexAlloc_winMutexAlloc@
expression E;
identifier FP_NAME = xMutexAlloc;
identifier FUNC_NAME = winMutexAlloc;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_winMutexAlloc_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_winMutexAlloc_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_winMutexAlloc_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_winMutexAlloc_enum];
)

// Rule: .xMutexAlloc = wrMutexAlloc ==> .xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_wrMutexAlloc_enum];
@transform_xMutexAlloc_wrMutexAlloc@
expression E;
identifier FP_NAME = xMutexAlloc;
identifier FUNC_NAME = wrMutexAlloc;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_wrMutexAlloc_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_wrMutexAlloc_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_wrMutexAlloc_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_wrMutexAlloc_enum];
)

// Rules for xMutexEnd (7 valid functions, 0 excluded)
// Rule: .xMutexEnd = checkMutexEnd ==> .xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_checkMutexEnd_enum];
@transform_xMutexEnd_checkMutexEnd@
expression E;
identifier FP_NAME = xMutexEnd;
identifier FUNC_NAME = checkMutexEnd;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_checkMutexEnd_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_checkMutexEnd_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_checkMutexEnd_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_checkMutexEnd_enum];
)

// Rule: .xMutexEnd = counterMutexEnd ==> .xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_counterMutexEnd_enum];
@transform_xMutexEnd_counterMutexEnd@
expression E;
identifier FP_NAME = xMutexEnd;
identifier FUNC_NAME = counterMutexEnd;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_counterMutexEnd_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_counterMutexEnd_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_counterMutexEnd_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_counterMutexEnd_enum];
)

// Rule: .xMutexEnd = debugMutexEnd ==> .xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_debugMutexEnd_enum];
@transform_xMutexEnd_debugMutexEnd@
expression E;
identifier FP_NAME = xMutexEnd;
identifier FUNC_NAME = debugMutexEnd;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_debugMutexEnd_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_debugMutexEnd_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_debugMutexEnd_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_debugMutexEnd_enum];
)

// Rule: .xMutexEnd = noopMutexEnd ==> .xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_noopMutexEnd_enum];
@transform_xMutexEnd_noopMutexEnd@
expression E;
identifier FP_NAME = xMutexEnd;
identifier FUNC_NAME = noopMutexEnd;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_noopMutexEnd_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_noopMutexEnd_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_noopMutexEnd_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_noopMutexEnd_enum];
)

// Rule: .xMutexEnd = pthreadMutexEnd ==> .xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_pthreadMutexEnd_enum];
@transform_xMutexEnd_pthreadMutexEnd@
expression E;
identifier FP_NAME = xMutexEnd;
identifier FUNC_NAME = pthreadMutexEnd;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_pthreadMutexEnd_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_pthreadMutexEnd_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_pthreadMutexEnd_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_pthreadMutexEnd_enum];
)

// Rule: .xMutexEnd = winMutexEnd ==> .xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_winMutexEnd_enum];
@transform_xMutexEnd_winMutexEnd@
expression E;
identifier FP_NAME = xMutexEnd;
identifier FUNC_NAME = winMutexEnd;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_winMutexEnd_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_winMutexEnd_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_winMutexEnd_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_winMutexEnd_enum];
)

// Rule: .xMutexEnd = wrMutexEnd ==> .xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_wrMutexEnd_enum];
@transform_xMutexEnd_wrMutexEnd@
expression E;
identifier FP_NAME = xMutexEnd;
identifier FUNC_NAME = wrMutexEnd;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_wrMutexEnd_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_wrMutexEnd_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_wrMutexEnd_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_wrMutexEnd_enum];
)

// Rules for xMutexEnter (7 valid functions, 0 excluded)
// Rule: .xMutexEnter = checkMutexEnter ==> .xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_checkMutexEnter_enum];
@transform_xMutexEnter_checkMutexEnter@
expression E;
identifier FP_NAME = xMutexEnter;
identifier FUNC_NAME = checkMutexEnter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_checkMutexEnter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_checkMutexEnter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_checkMutexEnter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_checkMutexEnter_enum];
)

// Rule: .xMutexEnter = counterMutexEnter ==> .xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_counterMutexEnter_enum];
@transform_xMutexEnter_counterMutexEnter@
expression E;
identifier FP_NAME = xMutexEnter;
identifier FUNC_NAME = counterMutexEnter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_counterMutexEnter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_counterMutexEnter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_counterMutexEnter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_counterMutexEnter_enum];
)

// Rule: .xMutexEnter = debugMutexEnter ==> .xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_debugMutexEnter_enum];
@transform_xMutexEnter_debugMutexEnter@
expression E;
identifier FP_NAME = xMutexEnter;
identifier FUNC_NAME = debugMutexEnter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_debugMutexEnter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_debugMutexEnter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_debugMutexEnter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_debugMutexEnter_enum];
)

// Rule: .xMutexEnter = noopMutexEnter ==> .xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_noopMutexEnter_enum];
@transform_xMutexEnter_noopMutexEnter@
expression E;
identifier FP_NAME = xMutexEnter;
identifier FUNC_NAME = noopMutexEnter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_noopMutexEnter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_noopMutexEnter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_noopMutexEnter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_noopMutexEnter_enum];
)

// Rule: .xMutexEnter = pthreadMutexEnter ==> .xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_pthreadMutexEnter_enum];
@transform_xMutexEnter_pthreadMutexEnter@
expression E;
identifier FP_NAME = xMutexEnter;
identifier FUNC_NAME = pthreadMutexEnter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_pthreadMutexEnter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_pthreadMutexEnter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_pthreadMutexEnter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_pthreadMutexEnter_enum];
)

// Rule: .xMutexEnter = winMutexEnter ==> .xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_winMutexEnter_enum];
@transform_xMutexEnter_winMutexEnter@
expression E;
identifier FP_NAME = xMutexEnter;
identifier FUNC_NAME = winMutexEnter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_winMutexEnter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_winMutexEnter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_winMutexEnter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_winMutexEnter_enum];
)

// Rule: .xMutexEnter = wrMutexEnter ==> .xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_wrMutexEnter_enum];
@transform_xMutexEnter_wrMutexEnter@
expression E;
identifier FP_NAME = xMutexEnter;
identifier FUNC_NAME = wrMutexEnter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_wrMutexEnter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_wrMutexEnter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_wrMutexEnter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_wrMutexEnter_enum];
)

// Rules for xMutexFree (7 valid functions, 0 excluded)
// Rule: .xMutexFree = checkMutexFree ==> .xMutexFree_signature = xMutexFree_signatures[xMutexFree_checkMutexFree_enum];
@transform_xMutexFree_checkMutexFree@
expression E;
identifier FP_NAME = xMutexFree;
identifier FUNC_NAME = checkMutexFree;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexFree_signature = xMutexFree_signatures[xMutexFree_checkMutexFree_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexFree_signature = xMutexFree_signatures[xMutexFree_checkMutexFree_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexFree_signature = xMutexFree_signatures[xMutexFree_checkMutexFree_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexFree_signature = xMutexFree_signatures[xMutexFree_checkMutexFree_enum];
)

// Rule: .xMutexFree = counterMutexFree ==> .xMutexFree_signature = xMutexFree_signatures[xMutexFree_counterMutexFree_enum];
@transform_xMutexFree_counterMutexFree@
expression E;
identifier FP_NAME = xMutexFree;
identifier FUNC_NAME = counterMutexFree;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexFree_signature = xMutexFree_signatures[xMutexFree_counterMutexFree_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexFree_signature = xMutexFree_signatures[xMutexFree_counterMutexFree_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexFree_signature = xMutexFree_signatures[xMutexFree_counterMutexFree_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexFree_signature = xMutexFree_signatures[xMutexFree_counterMutexFree_enum];
)

// Rule: .xMutexFree = debugMutexFree ==> .xMutexFree_signature = xMutexFree_signatures[xMutexFree_debugMutexFree_enum];
@transform_xMutexFree_debugMutexFree@
expression E;
identifier FP_NAME = xMutexFree;
identifier FUNC_NAME = debugMutexFree;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexFree_signature = xMutexFree_signatures[xMutexFree_debugMutexFree_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexFree_signature = xMutexFree_signatures[xMutexFree_debugMutexFree_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexFree_signature = xMutexFree_signatures[xMutexFree_debugMutexFree_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexFree_signature = xMutexFree_signatures[xMutexFree_debugMutexFree_enum];
)

// Rule: .xMutexFree = noopMutexFree ==> .xMutexFree_signature = xMutexFree_signatures[xMutexFree_noopMutexFree_enum];
@transform_xMutexFree_noopMutexFree@
expression E;
identifier FP_NAME = xMutexFree;
identifier FUNC_NAME = noopMutexFree;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexFree_signature = xMutexFree_signatures[xMutexFree_noopMutexFree_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexFree_signature = xMutexFree_signatures[xMutexFree_noopMutexFree_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexFree_signature = xMutexFree_signatures[xMutexFree_noopMutexFree_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexFree_signature = xMutexFree_signatures[xMutexFree_noopMutexFree_enum];
)

// Rule: .xMutexFree = pthreadMutexFree ==> .xMutexFree_signature = xMutexFree_signatures[xMutexFree_pthreadMutexFree_enum];
@transform_xMutexFree_pthreadMutexFree@
expression E;
identifier FP_NAME = xMutexFree;
identifier FUNC_NAME = pthreadMutexFree;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexFree_signature = xMutexFree_signatures[xMutexFree_pthreadMutexFree_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexFree_signature = xMutexFree_signatures[xMutexFree_pthreadMutexFree_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexFree_signature = xMutexFree_signatures[xMutexFree_pthreadMutexFree_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexFree_signature = xMutexFree_signatures[xMutexFree_pthreadMutexFree_enum];
)

// Rule: .xMutexFree = winMutexFree ==> .xMutexFree_signature = xMutexFree_signatures[xMutexFree_winMutexFree_enum];
@transform_xMutexFree_winMutexFree@
expression E;
identifier FP_NAME = xMutexFree;
identifier FUNC_NAME = winMutexFree;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexFree_signature = xMutexFree_signatures[xMutexFree_winMutexFree_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexFree_signature = xMutexFree_signatures[xMutexFree_winMutexFree_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexFree_signature = xMutexFree_signatures[xMutexFree_winMutexFree_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexFree_signature = xMutexFree_signatures[xMutexFree_winMutexFree_enum];
)

// Rule: .xMutexFree = wrMutexFree ==> .xMutexFree_signature = xMutexFree_signatures[xMutexFree_wrMutexFree_enum];
@transform_xMutexFree_wrMutexFree@
expression E;
identifier FP_NAME = xMutexFree;
identifier FUNC_NAME = wrMutexFree;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexFree_signature = xMutexFree_signatures[xMutexFree_wrMutexFree_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexFree_signature = xMutexFree_signatures[xMutexFree_wrMutexFree_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexFree_signature = xMutexFree_signatures[xMutexFree_wrMutexFree_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexFree_signature = xMutexFree_signatures[xMutexFree_wrMutexFree_enum];
)

// Rules for xMutexHeld (4 valid functions, 0 excluded)
// Rule: .xMutexHeld = 0 ==> .xMutexHeld_signature = xMutexHeld_signatures[xMutexHeld_0_enum];
@transform_xMutexHeld_0@
expression E;
identifier FP_NAME = xMutexHeld;
@@
(
E.FP_NAME = 0;
+ E.xMutexHeld_signature = xMutexHeld_signatures[xMutexHeld_0_enum];
|
E->FP_NAME = 0;
+ E->xMutexHeld_signature = xMutexHeld_signatures[xMutexHeld_0_enum];
)

// Rule: .xMutexHeld = counterMutexHeld ==> .xMutexHeld_signature = xMutexHeld_signatures[xMutexHeld_counterMutexHeld_enum];
@transform_xMutexHeld_counterMutexHeld@
expression E;
identifier FP_NAME = xMutexHeld;
identifier FUNC_NAME = counterMutexHeld;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexHeld_signature = xMutexHeld_signatures[xMutexHeld_counterMutexHeld_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexHeld_signature = xMutexHeld_signatures[xMutexHeld_counterMutexHeld_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexHeld_signature = xMutexHeld_signatures[xMutexHeld_counterMutexHeld_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexHeld_signature = xMutexHeld_signatures[xMutexHeld_counterMutexHeld_enum];
)

// Rule: .xMutexHeld = debugMutexHeld ==> .xMutexHeld_signature = xMutexHeld_signatures[xMutexHeld_debugMutexHeld_enum];
@transform_xMutexHeld_debugMutexHeld@
expression E;
identifier FP_NAME = xMutexHeld;
identifier FUNC_NAME = debugMutexHeld;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexHeld_signature = xMutexHeld_signatures[xMutexHeld_debugMutexHeld_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexHeld_signature = xMutexHeld_signatures[xMutexHeld_debugMutexHeld_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexHeld_signature = xMutexHeld_signatures[xMutexHeld_debugMutexHeld_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexHeld_signature = xMutexHeld_signatures[xMutexHeld_debugMutexHeld_enum];
)

// Rule: .xMutexHeld = wrMutexHeld ==> .xMutexHeld_signature = xMutexHeld_signatures[xMutexHeld_wrMutexHeld_enum];
@transform_xMutexHeld_wrMutexHeld@
expression E;
identifier FP_NAME = xMutexHeld;
identifier FUNC_NAME = wrMutexHeld;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexHeld_signature = xMutexHeld_signatures[xMutexHeld_wrMutexHeld_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexHeld_signature = xMutexHeld_signatures[xMutexHeld_wrMutexHeld_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexHeld_signature = xMutexHeld_signatures[xMutexHeld_wrMutexHeld_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexHeld_signature = xMutexHeld_signatures[xMutexHeld_wrMutexHeld_enum];
)

// Rules for xMutexInit (7 valid functions, 0 excluded)
// Rule: .xMutexInit = checkMutexInit ==> .xMutexInit_signature = xMutexInit_signatures[xMutexInit_checkMutexInit_enum];
@transform_xMutexInit_checkMutexInit@
expression E;
identifier FP_NAME = xMutexInit;
identifier FUNC_NAME = checkMutexInit;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexInit_signature = xMutexInit_signatures[xMutexInit_checkMutexInit_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexInit_signature = xMutexInit_signatures[xMutexInit_checkMutexInit_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexInit_signature = xMutexInit_signatures[xMutexInit_checkMutexInit_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexInit_signature = xMutexInit_signatures[xMutexInit_checkMutexInit_enum];
)

// Rule: .xMutexInit = counterMutexInit ==> .xMutexInit_signature = xMutexInit_signatures[xMutexInit_counterMutexInit_enum];
@transform_xMutexInit_counterMutexInit@
expression E;
identifier FP_NAME = xMutexInit;
identifier FUNC_NAME = counterMutexInit;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexInit_signature = xMutexInit_signatures[xMutexInit_counterMutexInit_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexInit_signature = xMutexInit_signatures[xMutexInit_counterMutexInit_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexInit_signature = xMutexInit_signatures[xMutexInit_counterMutexInit_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexInit_signature = xMutexInit_signatures[xMutexInit_counterMutexInit_enum];
)

// Rule: .xMutexInit = debugMutexInit ==> .xMutexInit_signature = xMutexInit_signatures[xMutexInit_debugMutexInit_enum];
@transform_xMutexInit_debugMutexInit@
expression E;
identifier FP_NAME = xMutexInit;
identifier FUNC_NAME = debugMutexInit;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexInit_signature = xMutexInit_signatures[xMutexInit_debugMutexInit_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexInit_signature = xMutexInit_signatures[xMutexInit_debugMutexInit_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexInit_signature = xMutexInit_signatures[xMutexInit_debugMutexInit_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexInit_signature = xMutexInit_signatures[xMutexInit_debugMutexInit_enum];
)

// Rule: .xMutexInit = noopMutexInit ==> .xMutexInit_signature = xMutexInit_signatures[xMutexInit_noopMutexInit_enum];
@transform_xMutexInit_noopMutexInit@
expression E;
identifier FP_NAME = xMutexInit;
identifier FUNC_NAME = noopMutexInit;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexInit_signature = xMutexInit_signatures[xMutexInit_noopMutexInit_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexInit_signature = xMutexInit_signatures[xMutexInit_noopMutexInit_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexInit_signature = xMutexInit_signatures[xMutexInit_noopMutexInit_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexInit_signature = xMutexInit_signatures[xMutexInit_noopMutexInit_enum];
)

// Rule: .xMutexInit = pthreadMutexInit ==> .xMutexInit_signature = xMutexInit_signatures[xMutexInit_pthreadMutexInit_enum];
@transform_xMutexInit_pthreadMutexInit@
expression E;
identifier FP_NAME = xMutexInit;
identifier FUNC_NAME = pthreadMutexInit;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexInit_signature = xMutexInit_signatures[xMutexInit_pthreadMutexInit_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexInit_signature = xMutexInit_signatures[xMutexInit_pthreadMutexInit_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexInit_signature = xMutexInit_signatures[xMutexInit_pthreadMutexInit_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexInit_signature = xMutexInit_signatures[xMutexInit_pthreadMutexInit_enum];
)

// Rule: .xMutexInit = winMutexInit ==> .xMutexInit_signature = xMutexInit_signatures[xMutexInit_winMutexInit_enum];
@transform_xMutexInit_winMutexInit@
expression E;
identifier FP_NAME = xMutexInit;
identifier FUNC_NAME = winMutexInit;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexInit_signature = xMutexInit_signatures[xMutexInit_winMutexInit_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexInit_signature = xMutexInit_signatures[xMutexInit_winMutexInit_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexInit_signature = xMutexInit_signatures[xMutexInit_winMutexInit_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexInit_signature = xMutexInit_signatures[xMutexInit_winMutexInit_enum];
)

// Rule: .xMutexInit = wrMutexInit ==> .xMutexInit_signature = xMutexInit_signatures[xMutexInit_wrMutexInit_enum];
@transform_xMutexInit_wrMutexInit@
expression E;
identifier FP_NAME = xMutexInit;
identifier FUNC_NAME = wrMutexInit;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexInit_signature = xMutexInit_signatures[xMutexInit_wrMutexInit_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexInit_signature = xMutexInit_signatures[xMutexInit_wrMutexInit_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexInit_signature = xMutexInit_signatures[xMutexInit_wrMutexInit_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexInit_signature = xMutexInit_signatures[xMutexInit_wrMutexInit_enum];
)

// Rules for xMutexLeave (7 valid functions, 0 excluded)
// Rule: .xMutexLeave = checkMutexLeave ==> .xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_checkMutexLeave_enum];
@transform_xMutexLeave_checkMutexLeave@
expression E;
identifier FP_NAME = xMutexLeave;
identifier FUNC_NAME = checkMutexLeave;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_checkMutexLeave_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_checkMutexLeave_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_checkMutexLeave_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_checkMutexLeave_enum];
)

// Rule: .xMutexLeave = counterMutexLeave ==> .xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_counterMutexLeave_enum];
@transform_xMutexLeave_counterMutexLeave@
expression E;
identifier FP_NAME = xMutexLeave;
identifier FUNC_NAME = counterMutexLeave;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_counterMutexLeave_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_counterMutexLeave_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_counterMutexLeave_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_counterMutexLeave_enum];
)

// Rule: .xMutexLeave = debugMutexLeave ==> .xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_debugMutexLeave_enum];
@transform_xMutexLeave_debugMutexLeave@
expression E;
identifier FP_NAME = xMutexLeave;
identifier FUNC_NAME = debugMutexLeave;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_debugMutexLeave_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_debugMutexLeave_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_debugMutexLeave_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_debugMutexLeave_enum];
)

// Rule: .xMutexLeave = noopMutexLeave ==> .xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_noopMutexLeave_enum];
@transform_xMutexLeave_noopMutexLeave@
expression E;
identifier FP_NAME = xMutexLeave;
identifier FUNC_NAME = noopMutexLeave;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_noopMutexLeave_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_noopMutexLeave_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_noopMutexLeave_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_noopMutexLeave_enum];
)

// Rule: .xMutexLeave = pthreadMutexLeave ==> .xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_pthreadMutexLeave_enum];
@transform_xMutexLeave_pthreadMutexLeave@
expression E;
identifier FP_NAME = xMutexLeave;
identifier FUNC_NAME = pthreadMutexLeave;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_pthreadMutexLeave_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_pthreadMutexLeave_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_pthreadMutexLeave_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_pthreadMutexLeave_enum];
)

// Rule: .xMutexLeave = winMutexLeave ==> .xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_winMutexLeave_enum];
@transform_xMutexLeave_winMutexLeave@
expression E;
identifier FP_NAME = xMutexLeave;
identifier FUNC_NAME = winMutexLeave;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_winMutexLeave_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_winMutexLeave_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_winMutexLeave_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_winMutexLeave_enum];
)

// Rule: .xMutexLeave = wrMutexLeave ==> .xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_wrMutexLeave_enum];
@transform_xMutexLeave_wrMutexLeave@
expression E;
identifier FP_NAME = xMutexLeave;
identifier FUNC_NAME = wrMutexLeave;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_wrMutexLeave_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_wrMutexLeave_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_wrMutexLeave_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_wrMutexLeave_enum];
)

// Rules for xMutexNotheld (4 valid functions, 0 excluded)
// Rule: .xMutexNotheld = 0 ==> .xMutexNotheld_signature = xMutexNotheld_signatures[xMutexNotheld_0_enum];
@transform_xMutexNotheld_0@
expression E;
identifier FP_NAME = xMutexNotheld;
@@
(
E.FP_NAME = 0;
+ E.xMutexNotheld_signature = xMutexNotheld_signatures[xMutexNotheld_0_enum];
|
E->FP_NAME = 0;
+ E->xMutexNotheld_signature = xMutexNotheld_signatures[xMutexNotheld_0_enum];
)

// Rule: .xMutexNotheld = counterMutexNotheld ==> .xMutexNotheld_signature = xMutexNotheld_signatures[xMutexNotheld_counterMutexNotheld_enum];
@transform_xMutexNotheld_counterMutexNotheld@
expression E;
identifier FP_NAME = xMutexNotheld;
identifier FUNC_NAME = counterMutexNotheld;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexNotheld_signature = xMutexNotheld_signatures[xMutexNotheld_counterMutexNotheld_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexNotheld_signature = xMutexNotheld_signatures[xMutexNotheld_counterMutexNotheld_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexNotheld_signature = xMutexNotheld_signatures[xMutexNotheld_counterMutexNotheld_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexNotheld_signature = xMutexNotheld_signatures[xMutexNotheld_counterMutexNotheld_enum];
)

// Rule: .xMutexNotheld = debugMutexNotheld ==> .xMutexNotheld_signature = xMutexNotheld_signatures[xMutexNotheld_debugMutexNotheld_enum];
@transform_xMutexNotheld_debugMutexNotheld@
expression E;
identifier FP_NAME = xMutexNotheld;
identifier FUNC_NAME = debugMutexNotheld;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexNotheld_signature = xMutexNotheld_signatures[xMutexNotheld_debugMutexNotheld_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexNotheld_signature = xMutexNotheld_signatures[xMutexNotheld_debugMutexNotheld_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexNotheld_signature = xMutexNotheld_signatures[xMutexNotheld_debugMutexNotheld_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexNotheld_signature = xMutexNotheld_signatures[xMutexNotheld_debugMutexNotheld_enum];
)

// Rule: .xMutexNotheld = wrMutexNotheld ==> .xMutexNotheld_signature = xMutexNotheld_signatures[xMutexNotheld_wrMutexNotheld_enum];
@transform_xMutexNotheld_wrMutexNotheld@
expression E;
identifier FP_NAME = xMutexNotheld;
identifier FUNC_NAME = wrMutexNotheld;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexNotheld_signature = xMutexNotheld_signatures[xMutexNotheld_wrMutexNotheld_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexNotheld_signature = xMutexNotheld_signatures[xMutexNotheld_wrMutexNotheld_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexNotheld_signature = xMutexNotheld_signatures[xMutexNotheld_wrMutexNotheld_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexNotheld_signature = xMutexNotheld_signatures[xMutexNotheld_wrMutexNotheld_enum];
)

// Rules for xMutexTry (7 valid functions, 0 excluded)
// Rule: .xMutexTry = checkMutexTry ==> .xMutexTry_signature = xMutexTry_signatures[xMutexTry_checkMutexTry_enum];
@transform_xMutexTry_checkMutexTry@
expression E;
identifier FP_NAME = xMutexTry;
identifier FUNC_NAME = checkMutexTry;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexTry_signature = xMutexTry_signatures[xMutexTry_checkMutexTry_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexTry_signature = xMutexTry_signatures[xMutexTry_checkMutexTry_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexTry_signature = xMutexTry_signatures[xMutexTry_checkMutexTry_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexTry_signature = xMutexTry_signatures[xMutexTry_checkMutexTry_enum];
)

// Rule: .xMutexTry = counterMutexTry ==> .xMutexTry_signature = xMutexTry_signatures[xMutexTry_counterMutexTry_enum];
@transform_xMutexTry_counterMutexTry@
expression E;
identifier FP_NAME = xMutexTry;
identifier FUNC_NAME = counterMutexTry;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexTry_signature = xMutexTry_signatures[xMutexTry_counterMutexTry_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexTry_signature = xMutexTry_signatures[xMutexTry_counterMutexTry_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexTry_signature = xMutexTry_signatures[xMutexTry_counterMutexTry_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexTry_signature = xMutexTry_signatures[xMutexTry_counterMutexTry_enum];
)

// Rule: .xMutexTry = debugMutexTry ==> .xMutexTry_signature = xMutexTry_signatures[xMutexTry_debugMutexTry_enum];
@transform_xMutexTry_debugMutexTry@
expression E;
identifier FP_NAME = xMutexTry;
identifier FUNC_NAME = debugMutexTry;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexTry_signature = xMutexTry_signatures[xMutexTry_debugMutexTry_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexTry_signature = xMutexTry_signatures[xMutexTry_debugMutexTry_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexTry_signature = xMutexTry_signatures[xMutexTry_debugMutexTry_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexTry_signature = xMutexTry_signatures[xMutexTry_debugMutexTry_enum];
)

// Rule: .xMutexTry = noopMutexTry ==> .xMutexTry_signature = xMutexTry_signatures[xMutexTry_noopMutexTry_enum];
@transform_xMutexTry_noopMutexTry@
expression E;
identifier FP_NAME = xMutexTry;
identifier FUNC_NAME = noopMutexTry;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexTry_signature = xMutexTry_signatures[xMutexTry_noopMutexTry_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexTry_signature = xMutexTry_signatures[xMutexTry_noopMutexTry_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexTry_signature = xMutexTry_signatures[xMutexTry_noopMutexTry_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexTry_signature = xMutexTry_signatures[xMutexTry_noopMutexTry_enum];
)

// Rule: .xMutexTry = pthreadMutexTry ==> .xMutexTry_signature = xMutexTry_signatures[xMutexTry_pthreadMutexTry_enum];
@transform_xMutexTry_pthreadMutexTry@
expression E;
identifier FP_NAME = xMutexTry;
identifier FUNC_NAME = pthreadMutexTry;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexTry_signature = xMutexTry_signatures[xMutexTry_pthreadMutexTry_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexTry_signature = xMutexTry_signatures[xMutexTry_pthreadMutexTry_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexTry_signature = xMutexTry_signatures[xMutexTry_pthreadMutexTry_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexTry_signature = xMutexTry_signatures[xMutexTry_pthreadMutexTry_enum];
)

// Rule: .xMutexTry = winMutexTry ==> .xMutexTry_signature = xMutexTry_signatures[xMutexTry_winMutexTry_enum];
@transform_xMutexTry_winMutexTry@
expression E;
identifier FP_NAME = xMutexTry;
identifier FUNC_NAME = winMutexTry;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexTry_signature = xMutexTry_signatures[xMutexTry_winMutexTry_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexTry_signature = xMutexTry_signatures[xMutexTry_winMutexTry_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexTry_signature = xMutexTry_signatures[xMutexTry_winMutexTry_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexTry_signature = xMutexTry_signatures[xMutexTry_winMutexTry_enum];
)

// Rule: .xMutexTry = wrMutexTry ==> .xMutexTry_signature = xMutexTry_signatures[xMutexTry_wrMutexTry_enum];
@transform_xMutexTry_wrMutexTry@
expression E;
identifier FP_NAME = xMutexTry;
identifier FUNC_NAME = wrMutexTry;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xMutexTry_signature = xMutexTry_signatures[xMutexTry_wrMutexTry_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xMutexTry_signature = xMutexTry_signatures[xMutexTry_wrMutexTry_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xMutexTry_signature = xMutexTry_signatures[xMutexTry_wrMutexTry_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xMutexTry_signature = xMutexTry_signatures[xMutexTry_wrMutexTry_enum];
)

// Rules for xNew (3 valid functions, 0 excluded)
// Rule: .xNew = sessionDiffNew ==> .xNew_signature = xNew_signatures[xNew_sessionDiffNew_enum];
@transform_xNew_sessionDiffNew@
expression E;
identifier FP_NAME = xNew;
identifier FUNC_NAME = sessionDiffNew;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNew_signature = xNew_signatures[xNew_sessionDiffNew_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNew_signature = xNew_signatures[xNew_sessionDiffNew_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNew_signature = xNew_signatures[xNew_sessionDiffNew_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNew_signature = xNew_signatures[xNew_sessionDiffNew_enum];
)

// Rule: .xNew = sessionPreupdateNew ==> .xNew_signature = xNew_signatures[xNew_sessionPreupdateNew_enum];
@transform_xNew_sessionPreupdateNew@
expression E;
identifier FP_NAME = xNew;
identifier FUNC_NAME = sessionPreupdateNew;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNew_signature = xNew_signatures[xNew_sessionPreupdateNew_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNew_signature = xNew_signatures[xNew_sessionPreupdateNew_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNew_signature = xNew_signatures[xNew_sessionPreupdateNew_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNew_signature = xNew_signatures[xNew_sessionPreupdateNew_enum];
)

// Rule: .xNew = sessionStat1New ==> .xNew_signature = xNew_signatures[xNew_sessionStat1New_enum];
@transform_xNew_sessionStat1New@
expression E;
identifier FP_NAME = xNew;
identifier FUNC_NAME = sessionStat1New;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNew_signature = xNew_signatures[xNew_sessionStat1New_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNew_signature = xNew_signatures[xNew_sessionStat1New_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNew_signature = xNew_signatures[xNew_sessionStat1New_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNew_signature = xNew_signatures[xNew_sessionStat1New_enum];
)

// Rules for xNext (47 valid functions, 14 excluded)
// Rule: .xNext = 0 ==> .xNext_signature = xNext_signatures[xNext_0_enum];
@transform_xNext_0@
expression E;
identifier FP_NAME = xNext;
@@
(
E.FP_NAME = 0;
+ E.xNext_signature = xNext_signatures[xNext_0_enum];
|
E->FP_NAME = 0;
+ E->xNext_signature = xNext_signatures[xNext_0_enum];
)

// Rule: .xNext = amatchNext ==> .xNext_signature = xNext_signatures[xNext_amatchNext_enum];
@transform_xNext_amatchNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = amatchNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_amatchNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_amatchNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_amatchNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_amatchNext_enum];
)

// Rule: .xNext = binfoNext ==> .xNext_signature = xNext_signatures[xNext_binfoNext_enum];
@transform_xNext_binfoNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = binfoNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_binfoNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_binfoNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_binfoNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_binfoNext_enum];
)

// Rule: .xNext = bytecodevtabNext ==> .xNext_signature = xNext_signatures[xNext_bytecodevtabNext_enum];
@transform_xNext_bytecodevtabNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = bytecodevtabNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_bytecodevtabNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_bytecodevtabNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_bytecodevtabNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_bytecodevtabNext_enum];
)

// Rule: .xNext = carrayNext ==> .xNext_signature = xNext_signatures[xNext_carrayNext_enum];
@transform_xNext_carrayNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = carrayNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_carrayNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_carrayNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_carrayNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_carrayNext_enum];
)

// Rule: .xNext = cidxNext ==> .xNext_signature = xNext_signatures[xNext_cidxNext_enum];
@transform_xNext_cidxNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = cidxNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_cidxNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_cidxNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_cidxNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_cidxNext_enum];
)

// Rule: .xNext = closureNext ==> .xNext_signature = xNext_signatures[xNext_closureNext_enum];
@transform_xNext_closureNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = closureNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_closureNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_closureNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_closureNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_closureNext_enum];
)

// Rule: .xNext = completionNext ==> .xNext_signature = xNext_signatures[xNext_completionNext_enum];
@transform_xNext_completionNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = completionNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_completionNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_completionNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_completionNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_completionNext_enum];
)

// Rule: .xNext = csvtabNext ==> .xNext_signature = xNext_signatures[xNext_csvtabNext_enum];
@transform_xNext_csvtabNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = csvtabNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_csvtabNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_csvtabNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_csvtabNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_csvtabNext_enum];
)

// Rule: .xNext = dbdataNext ==> .xNext_signature = xNext_signatures[xNext_dbdataNext_enum];
@transform_xNext_dbdataNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = dbdataNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_dbdataNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_dbdataNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_dbdataNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_dbdataNext_enum];
)

// Rule: .xNext = dbpageNext ==> .xNext_signature = xNext_signatures[xNext_dbpageNext_enum];
@transform_xNext_dbpageNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = dbpageNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_dbpageNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_dbpageNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_dbpageNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_dbpageNext_enum];
)

// Rule: .xNext = deltaparsevtabNext ==> .xNext_signature = xNext_signatures[xNext_deltaparsevtabNext_enum];
@transform_xNext_deltaparsevtabNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = deltaparsevtabNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_deltaparsevtabNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_deltaparsevtabNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_deltaparsevtabNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_deltaparsevtabNext_enum];
)

// Rule: .xNext = echoNext ==> .xNext_signature = xNext_signatures[xNext_echoNext_enum];
@transform_xNext_echoNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = echoNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_echoNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_echoNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_echoNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_echoNext_enum];
)

// Rule: .xNext = expertNext ==> .xNext_signature = xNext_signatures[xNext_expertNext_enum];
@transform_xNext_expertNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = expertNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_expertNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_expertNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_expertNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_expertNext_enum];
)

// Rule: .xNext = explainNext ==> .xNext_signature = xNext_signatures[xNext_explainNext_enum];
@transform_xNext_explainNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = explainNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_explainNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_explainNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_explainNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_explainNext_enum];
)

// Rule: .xNext = fsNext ==> .xNext_signature = xNext_signatures[xNext_fsNext_enum];
@transform_xNext_fsNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = fsNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_fsNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_fsNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_fsNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_fsNext_enum];
)

// Rule: .xNext = fsdirNext ==> .xNext_signature = xNext_signatures[xNext_fsdirNext_enum];
@transform_xNext_fsdirNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = fsdirNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_fsdirNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_fsdirNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_fsdirNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_fsdirNext_enum];
)

// Rule: .xNext = fstreeNext ==> .xNext_signature = xNext_signatures[xNext_fstreeNext_enum];
@transform_xNext_fstreeNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = fstreeNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_fstreeNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_fstreeNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_fstreeNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_fstreeNext_enum];
)

// Rule: .xNext = fts3NextMethod ==> .xNext_signature = xNext_signatures[xNext_fts3NextMethod_enum];
@transform_xNext_fts3NextMethod@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = fts3NextMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_fts3NextMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_fts3NextMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_fts3NextMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_fts3NextMethod_enum];
)

// Rule: .xNext = fts3auxNextMethod ==> .xNext_signature = xNext_signatures[xNext_fts3auxNextMethod_enum];
@transform_xNext_fts3auxNextMethod@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = fts3auxNextMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_fts3auxNextMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_fts3auxNextMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_fts3auxNextMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_fts3auxNextMethod_enum];
)

// Rule: .xNext = fts3termNextMethod ==> .xNext_signature = xNext_signatures[xNext_fts3termNextMethod_enum];
@transform_xNext_fts3termNextMethod@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = fts3termNextMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_fts3termNextMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_fts3termNextMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_fts3termNextMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_fts3termNextMethod_enum];
)

// Rule: .xNext = fts3tokNextMethod ==> .xNext_signature = xNext_signatures[xNext_fts3tokNextMethod_enum];
@transform_xNext_fts3tokNextMethod@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = fts3tokNextMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_fts3tokNextMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_fts3tokNextMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_fts3tokNextMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_fts3tokNextMethod_enum];
)

// Rule: .xNext = fuzzerNext ==> .xNext_signature = xNext_signatures[xNext_fuzzerNext_enum];
@transform_xNext_fuzzerNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = fuzzerNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_fuzzerNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_fuzzerNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_fuzzerNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_fuzzerNext_enum];
)

// Rule: .xNext = intarrayNext ==> .xNext_signature = xNext_signatures[xNext_intarrayNext_enum];
@transform_xNext_intarrayNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = intarrayNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_intarrayNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_intarrayNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_intarrayNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_intarrayNext_enum];
)

// Rule: .xNext = jsonEachNext ==> .xNext_signature = xNext_signatures[xNext_jsonEachNext_enum];
@transform_xNext_jsonEachNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = jsonEachNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_jsonEachNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_jsonEachNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_jsonEachNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_jsonEachNext_enum];
)

// Rule: .xNext = memstatNext ==> .xNext_signature = xNext_signatures[xNext_memstatNext_enum];
@transform_xNext_memstatNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = memstatNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_memstatNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_memstatNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_memstatNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_memstatNext_enum];
)

// Rule: .xNext = porterNext ==> .xNext_signature = xNext_signatures[xNext_porterNext_enum];
@transform_xNext_porterNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = porterNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_porterNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_porterNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_porterNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_porterNext_enum];
)

// Rule: .xNext = pragmaVtabNext ==> .xNext_signature = xNext_signatures[xNext_pragmaVtabNext_enum];
@transform_xNext_pragmaVtabNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = pragmaVtabNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_pragmaVtabNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_pragmaVtabNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_pragmaVtabNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_pragmaVtabNext_enum];
)

// Rule: .xNext = prefixesNext ==> .xNext_signature = xNext_signatures[xNext_prefixesNext_enum];
@transform_xNext_prefixesNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = prefixesNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_prefixesNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_prefixesNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_prefixesNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_prefixesNext_enum];
)

// Rule: .xNext = qpvtabNext ==> .xNext_signature = xNext_signatures[xNext_qpvtabNext_enum];
@transform_xNext_qpvtabNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = qpvtabNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_qpvtabNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_qpvtabNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_qpvtabNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_qpvtabNext_enum];
)

// Rule: .xNext = rtreeNext ==> .xNext_signature = xNext_signatures[xNext_rtreeNext_enum];
@transform_xNext_rtreeNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = rtreeNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_rtreeNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_rtreeNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_rtreeNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_rtreeNext_enum];
)

// Rule: .xNext = schemaNext ==> .xNext_signature = xNext_signatures[xNext_schemaNext_enum];
@transform_xNext_schemaNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = schemaNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_schemaNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_schemaNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_schemaNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_schemaNext_enum];
)

// Rule: .xNext = seriesNext ==> .xNext_signature = xNext_signatures[xNext_seriesNext_enum];
@transform_xNext_seriesNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = seriesNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_seriesNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_seriesNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_seriesNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_seriesNext_enum];
)

// Rule: .xNext = simpleNext ==> .xNext_signature = xNext_signatures[xNext_simpleNext_enum];
@transform_xNext_simpleNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = simpleNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_simpleNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_simpleNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_simpleNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_simpleNext_enum];
)

// Rule: .xNext = spellfix1Next ==> .xNext_signature = xNext_signatures[xNext_spellfix1Next_enum];
@transform_xNext_spellfix1Next@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = spellfix1Next;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_spellfix1Next_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_spellfix1Next_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_spellfix1Next_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_spellfix1Next_enum];
)

// Rule: .xNext = statNext ==> .xNext_signature = xNext_signatures[xNext_statNext_enum];
@transform_xNext_statNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = statNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_statNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_statNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_statNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_statNext_enum];
)

// Rule: .xNext = stmtNext ==> .xNext_signature = xNext_signatures[xNext_stmtNext_enum];
@transform_xNext_stmtNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = stmtNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_stmtNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_stmtNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_stmtNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_stmtNext_enum];
)

// Rule: .xNext = tclNext ==> .xNext_signature = xNext_signatures[xNext_tclNext_enum];
@transform_xNext_tclNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = tclNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_tclNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_tclNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_tclNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_tclNext_enum];
)

// Rule: .xNext = tclvarNext ==> .xNext_signature = xNext_signatures[xNext_tclvarNext_enum];
@transform_xNext_tclvarNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = tclvarNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_tclvarNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_tclvarNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_tclvarNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_tclvarNext_enum];
)

// Rule: .xNext = templatevtabNext ==> .xNext_signature = xNext_signatures[xNext_templatevtabNext_enum];
@transform_xNext_templatevtabNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = templatevtabNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_templatevtabNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_templatevtabNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_templatevtabNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_templatevtabNext_enum];
)

// Rule: .xNext = unicodeNext ==> .xNext_signature = xNext_signatures[xNext_unicodeNext_enum];
@transform_xNext_unicodeNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = unicodeNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_unicodeNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_unicodeNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_unicodeNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_unicodeNext_enum];
)

// Rule: .xNext = unionNext ==> .xNext_signature = xNext_signatures[xNext_unionNext_enum];
@transform_xNext_unionNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = unionNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_unionNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_unionNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_unionNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_unionNext_enum];
)

// Rule: .xNext = vlogNext ==> .xNext_signature = xNext_signatures[xNext_vlogNext_enum];
@transform_xNext_vlogNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = vlogNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_vlogNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_vlogNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_vlogNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_vlogNext_enum];
)

// Rule: .xNext = vstattabNext ==> .xNext_signature = xNext_signatures[xNext_vstattabNext_enum];
@transform_xNext_vstattabNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = vstattabNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_vstattabNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_vstattabNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_vstattabNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_vstattabNext_enum];
)

// Rule: .xNext = vtablogNext ==> .xNext_signature = xNext_signatures[xNext_vtablogNext_enum];
@transform_xNext_vtablogNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = vtablogNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_vtablogNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_vtablogNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_vtablogNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_vtablogNext_enum];
)

// Rule: .xNext = wholenumberNext ==> .xNext_signature = xNext_signatures[xNext_wholenumberNext_enum];
@transform_xNext_wholenumberNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = wholenumberNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_wholenumberNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_wholenumberNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_wholenumberNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_wholenumberNext_enum];
)

// Rule: .xNext = zipfileNext ==> .xNext_signature = xNext_signatures[xNext_zipfileNext_enum];
@transform_xNext_zipfileNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = zipfileNext;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_zipfileNext_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNext_signature = xNext_signatures[xNext_zipfileNext_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_zipfileNext_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNext_signature = xNext_signatures[xNext_zipfileNext_enum];
)

// Rules for xNextSystemCall (4 valid functions, 2 excluded)
// Rule: .xNextSystemCall = 0 ==> .xNextSystemCall_signature = xNextSystemCall_signatures[xNextSystemCall_0_enum];
@transform_xNextSystemCall_0@
expression E;
identifier FP_NAME = xNextSystemCall;
@@
(
E.FP_NAME = 0;
+ E.xNextSystemCall_signature = xNextSystemCall_signatures[xNextSystemCall_0_enum];
|
E->FP_NAME = 0;
+ E->xNextSystemCall_signature = xNextSystemCall_signatures[xNextSystemCall_0_enum];
)

// Rule: .xNextSystemCall = apndNextSystemCall ==> .xNextSystemCall_signature = xNextSystemCall_signatures[xNextSystemCall_apndNextSystemCall_enum];
@transform_xNextSystemCall_apndNextSystemCall@
expression E;
identifier FP_NAME = xNextSystemCall;
identifier FUNC_NAME = apndNextSystemCall;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNextSystemCall_signature = xNextSystemCall_signatures[xNextSystemCall_apndNextSystemCall_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNextSystemCall_signature = xNextSystemCall_signatures[xNextSystemCall_apndNextSystemCall_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNextSystemCall_signature = xNextSystemCall_signatures[xNextSystemCall_apndNextSystemCall_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNextSystemCall_signature = xNextSystemCall_signatures[xNextSystemCall_apndNextSystemCall_enum];
)

// Rule: .xNextSystemCall = rbuVfsGetLastError ==> .xNextSystemCall_signature = xNextSystemCall_signatures[xNextSystemCall_rbuVfsGetLastError_enum];
@transform_xNextSystemCall_rbuVfsGetLastError@
expression E;
identifier FP_NAME = xNextSystemCall;
identifier FUNC_NAME = rbuVfsGetLastError;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNextSystemCall_signature = xNextSystemCall_signatures[xNextSystemCall_rbuVfsGetLastError_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNextSystemCall_signature = xNextSystemCall_signatures[xNextSystemCall_rbuVfsGetLastError_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNextSystemCall_signature = xNextSystemCall_signatures[xNextSystemCall_rbuVfsGetLastError_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNextSystemCall_signature = xNextSystemCall_signatures[xNextSystemCall_rbuVfsGetLastError_enum];
)

// Rule: .xNextSystemCall = unixNextSystemCall ==> .xNextSystemCall_signature = xNextSystemCall_signatures[xNextSystemCall_unixNextSystemCall_enum];
@transform_xNextSystemCall_unixNextSystemCall@
expression E;
identifier FP_NAME = xNextSystemCall;
identifier FUNC_NAME = unixNextSystemCall;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xNextSystemCall_signature = xNextSystemCall_signatures[xNextSystemCall_unixNextSystemCall_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xNextSystemCall_signature = xNextSystemCall_signatures[xNextSystemCall_unixNextSystemCall_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xNextSystemCall_signature = xNextSystemCall_signatures[xNextSystemCall_unixNextSystemCall_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xNextSystemCall_signature = xNextSystemCall_signatures[xNextSystemCall_unixNextSystemCall_enum];
)

// Rules for xOld (3 valid functions, 0 excluded)
// Rule: .xOld = sessionDiffOld ==> .xOld_signature = xOld_signatures[xOld_sessionDiffOld_enum];
@transform_xOld_sessionDiffOld@
expression E;
identifier FP_NAME = xOld;
identifier FUNC_NAME = sessionDiffOld;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOld_signature = xOld_signatures[xOld_sessionDiffOld_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOld_signature = xOld_signatures[xOld_sessionDiffOld_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOld_signature = xOld_signatures[xOld_sessionDiffOld_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOld_signature = xOld_signatures[xOld_sessionDiffOld_enum];
)

// Rule: .xOld = sessionPreupdateOld ==> .xOld_signature = xOld_signatures[xOld_sessionPreupdateOld_enum];
@transform_xOld_sessionPreupdateOld@
expression E;
identifier FP_NAME = xOld;
identifier FUNC_NAME = sessionPreupdateOld;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOld_signature = xOld_signatures[xOld_sessionPreupdateOld_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOld_signature = xOld_signatures[xOld_sessionPreupdateOld_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOld_signature = xOld_signatures[xOld_sessionPreupdateOld_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOld_signature = xOld_signatures[xOld_sessionPreupdateOld_enum];
)

// Rule: .xOld = sessionStat1Old ==> .xOld_signature = xOld_signatures[xOld_sessionStat1Old_enum];
@transform_xOld_sessionStat1Old@
expression E;
identifier FP_NAME = xOld;
identifier FUNC_NAME = sessionStat1Old;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOld_signature = xOld_signatures[xOld_sessionStat1Old_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOld_signature = xOld_signatures[xOld_sessionStat1Old_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOld_signature = xOld_signatures[xOld_sessionStat1Old_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOld_signature = xOld_signatures[xOld_sessionStat1Old_enum];
)

// Rules for xOpen (51 valid functions, 21 excluded)
// Rule: .xOpen = amatchOpen ==> .xOpen_signature = xOpen_signatures[xOpen_amatchOpen_enum];
@transform_xOpen_amatchOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = amatchOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_amatchOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_amatchOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_amatchOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_amatchOpen_enum];
)

// Rule: .xOpen = apndOpen ==> .xOpen_signature = xOpen_signatures[xOpen_apndOpen_enum];
@transform_xOpen_apndOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = apndOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_apndOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_apndOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_apndOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_apndOpen_enum];
)

// Rule: .xOpen = binfoOpen ==> .xOpen_signature = xOpen_signatures[xOpen_binfoOpen_enum];
@transform_xOpen_binfoOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = binfoOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_binfoOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_binfoOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_binfoOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_binfoOpen_enum];
)

// Rule: .xOpen = bytecodevtabOpen ==> .xOpen_signature = xOpen_signatures[xOpen_bytecodevtabOpen_enum];
@transform_xOpen_bytecodevtabOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = bytecodevtabOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_bytecodevtabOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_bytecodevtabOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_bytecodevtabOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_bytecodevtabOpen_enum];
)

// Rule: .xOpen = carrayOpen ==> .xOpen_signature = xOpen_signatures[xOpen_carrayOpen_enum];
@transform_xOpen_carrayOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = carrayOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_carrayOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_carrayOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_carrayOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_carrayOpen_enum];
)

// Rule: .xOpen = cidxOpen ==> .xOpen_signature = xOpen_signatures[xOpen_cidxOpen_enum];
@transform_xOpen_cidxOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = cidxOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_cidxOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_cidxOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_cidxOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_cidxOpen_enum];
)

// Rule: .xOpen = closureOpen ==> .xOpen_signature = xOpen_signatures[xOpen_closureOpen_enum];
@transform_xOpen_closureOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = closureOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_closureOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_closureOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_closureOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_closureOpen_enum];
)

// Rule: .xOpen = completionOpen ==> .xOpen_signature = xOpen_signatures[xOpen_completionOpen_enum];
@transform_xOpen_completionOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = completionOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_completionOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_completionOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_completionOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_completionOpen_enum];
)

// Rule: .xOpen = csvtabOpen ==> .xOpen_signature = xOpen_signatures[xOpen_csvtabOpen_enum];
@transform_xOpen_csvtabOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = csvtabOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_csvtabOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_csvtabOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_csvtabOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_csvtabOpen_enum];
)

// Rule: .xOpen = dbdataOpen ==> .xOpen_signature = xOpen_signatures[xOpen_dbdataOpen_enum];
@transform_xOpen_dbdataOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = dbdataOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_dbdataOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_dbdataOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_dbdataOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_dbdataOpen_enum];
)

// Rule: .xOpen = dbpageOpen ==> .xOpen_signature = xOpen_signatures[xOpen_dbpageOpen_enum];
@transform_xOpen_dbpageOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = dbpageOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_dbpageOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_dbpageOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_dbpageOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_dbpageOpen_enum];
)

// Rule: .xOpen = deltaparsevtabOpen ==> .xOpen_signature = xOpen_signatures[xOpen_deltaparsevtabOpen_enum];
@transform_xOpen_deltaparsevtabOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = deltaparsevtabOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_deltaparsevtabOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_deltaparsevtabOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_deltaparsevtabOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_deltaparsevtabOpen_enum];
)

// Rule: .xOpen = echoOpen ==> .xOpen_signature = xOpen_signatures[xOpen_echoOpen_enum];
@transform_xOpen_echoOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = echoOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_echoOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_echoOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_echoOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_echoOpen_enum];
)

// Rule: .xOpen = expertOpen ==> .xOpen_signature = xOpen_signatures[xOpen_expertOpen_enum];
@transform_xOpen_expertOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = expertOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_expertOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_expertOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_expertOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_expertOpen_enum];
)

// Rule: .xOpen = explainOpen ==> .xOpen_signature = xOpen_signatures[xOpen_explainOpen_enum];
@transform_xOpen_explainOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = explainOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_explainOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_explainOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_explainOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_explainOpen_enum];
)

// Rule: .xOpen = fsOpen ==> .xOpen_signature = xOpen_signatures[xOpen_fsOpen_enum];
@transform_xOpen_fsOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = fsOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_fsOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_fsOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_fsOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_fsOpen_enum];
)

// Rule: .xOpen = fsdirOpen ==> .xOpen_signature = xOpen_signatures[xOpen_fsdirOpen_enum];
@transform_xOpen_fsdirOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = fsdirOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_fsdirOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_fsdirOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_fsdirOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_fsdirOpen_enum];
)

// Rule: .xOpen = fstreeOpen ==> .xOpen_signature = xOpen_signatures[xOpen_fstreeOpen_enum];
@transform_xOpen_fstreeOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = fstreeOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_fstreeOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_fstreeOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_fstreeOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_fstreeOpen_enum];
)

// Rule: .xOpen = fts3OpenMethod ==> .xOpen_signature = xOpen_signatures[xOpen_fts3OpenMethod_enum];
@transform_xOpen_fts3OpenMethod@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = fts3OpenMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_fts3OpenMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_fts3OpenMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_fts3OpenMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_fts3OpenMethod_enum];
)

// Rule: .xOpen = fts3auxOpenMethod ==> .xOpen_signature = xOpen_signatures[xOpen_fts3auxOpenMethod_enum];
@transform_xOpen_fts3auxOpenMethod@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = fts3auxOpenMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_fts3auxOpenMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_fts3auxOpenMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_fts3auxOpenMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_fts3auxOpenMethod_enum];
)

// Rule: .xOpen = fts3termOpenMethod ==> .xOpen_signature = xOpen_signatures[xOpen_fts3termOpenMethod_enum];
@transform_xOpen_fts3termOpenMethod@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = fts3termOpenMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_fts3termOpenMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_fts3termOpenMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_fts3termOpenMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_fts3termOpenMethod_enum];
)

// Rule: .xOpen = fts3tokOpenMethod ==> .xOpen_signature = xOpen_signatures[xOpen_fts3tokOpenMethod_enum];
@transform_xOpen_fts3tokOpenMethod@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = fts3tokOpenMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_fts3tokOpenMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_fts3tokOpenMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_fts3tokOpenMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_fts3tokOpenMethod_enum];
)

// Rule: .xOpen = fuzzerOpen ==> .xOpen_signature = xOpen_signatures[xOpen_fuzzerOpen_enum];
@transform_xOpen_fuzzerOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = fuzzerOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_fuzzerOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_fuzzerOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_fuzzerOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_fuzzerOpen_enum];
)

// Rule: .xOpen = intarrayOpen ==> .xOpen_signature = xOpen_signatures[xOpen_intarrayOpen_enum];
@transform_xOpen_intarrayOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = intarrayOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_intarrayOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_intarrayOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_intarrayOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_intarrayOpen_enum];
)

// Rule: .xOpen = jsonEachOpen ==> .xOpen_signature = xOpen_signatures[xOpen_jsonEachOpen_enum];
@transform_xOpen_jsonEachOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = jsonEachOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_jsonEachOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_jsonEachOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_jsonEachOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_jsonEachOpen_enum];
)

// Rule: .xOpen = jsonEachOpenEach ==> .xOpen_signature = xOpen_signatures[xOpen_jsonEachOpenEach_enum];
@transform_xOpen_jsonEachOpenEach@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = jsonEachOpenEach;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_jsonEachOpenEach_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_jsonEachOpenEach_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_jsonEachOpenEach_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_jsonEachOpenEach_enum];
)

// Rule: .xOpen = jsonEachOpenTree ==> .xOpen_signature = xOpen_signatures[xOpen_jsonEachOpenTree_enum];
@transform_xOpen_jsonEachOpenTree@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = jsonEachOpenTree;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_jsonEachOpenTree_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_jsonEachOpenTree_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_jsonEachOpenTree_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_jsonEachOpenTree_enum];
)

// Rule: .xOpen = memdbOpen ==> .xOpen_signature = xOpen_signatures[xOpen_memdbOpen_enum];
@transform_xOpen_memdbOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = memdbOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_memdbOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_memdbOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_memdbOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_memdbOpen_enum];
)

// Rule: .xOpen = memstatOpen ==> .xOpen_signature = xOpen_signatures[xOpen_memstatOpen_enum];
@transform_xOpen_memstatOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = memstatOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_memstatOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_memstatOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_memstatOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_memstatOpen_enum];
)

// Rule: .xOpen = porterOpen ==> .xOpen_signature = xOpen_signatures[xOpen_porterOpen_enum];
@transform_xOpen_porterOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = porterOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_porterOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_porterOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_porterOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_porterOpen_enum];
)

// Rule: .xOpen = pragmaVtabOpen ==> .xOpen_signature = xOpen_signatures[xOpen_pragmaVtabOpen_enum];
@transform_xOpen_pragmaVtabOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = pragmaVtabOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_pragmaVtabOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_pragmaVtabOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_pragmaVtabOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_pragmaVtabOpen_enum];
)

// Rule: .xOpen = prefixesOpen ==> .xOpen_signature = xOpen_signatures[xOpen_prefixesOpen_enum];
@transform_xOpen_prefixesOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = prefixesOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_prefixesOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_prefixesOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_prefixesOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_prefixesOpen_enum];
)

// Rule: .xOpen = qpvtabOpen ==> .xOpen_signature = xOpen_signatures[xOpen_qpvtabOpen_enum];
@transform_xOpen_qpvtabOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = qpvtabOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_qpvtabOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_qpvtabOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_qpvtabOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_qpvtabOpen_enum];
)

// Rule: .xOpen = rtreeOpen ==> .xOpen_signature = xOpen_signatures[xOpen_rtreeOpen_enum];
@transform_xOpen_rtreeOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = rtreeOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_rtreeOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_rtreeOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_rtreeOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_rtreeOpen_enum];
)

// Rule: .xOpen = schemaOpen ==> .xOpen_signature = xOpen_signatures[xOpen_schemaOpen_enum];
@transform_xOpen_schemaOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = schemaOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_schemaOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_schemaOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_schemaOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_schemaOpen_enum];
)

// Rule: .xOpen = seriesOpen ==> .xOpen_signature = xOpen_signatures[xOpen_seriesOpen_enum];
@transform_xOpen_seriesOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = seriesOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_seriesOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_seriesOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_seriesOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_seriesOpen_enum];
)

// Rule: .xOpen = simpleOpen ==> .xOpen_signature = xOpen_signatures[xOpen_simpleOpen_enum];
@transform_xOpen_simpleOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = simpleOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_simpleOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_simpleOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_simpleOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_simpleOpen_enum];
)

// Rule: .xOpen = spellfix1Open ==> .xOpen_signature = xOpen_signatures[xOpen_spellfix1Open_enum];
@transform_xOpen_spellfix1Open@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = spellfix1Open;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_spellfix1Open_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_spellfix1Open_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_spellfix1Open_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_spellfix1Open_enum];
)

// Rule: .xOpen = statOpen ==> .xOpen_signature = xOpen_signatures[xOpen_statOpen_enum];
@transform_xOpen_statOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = statOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_statOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_statOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_statOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_statOpen_enum];
)

// Rule: .xOpen = stmtOpen ==> .xOpen_signature = xOpen_signatures[xOpen_stmtOpen_enum];
@transform_xOpen_stmtOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = stmtOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_stmtOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_stmtOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_stmtOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_stmtOpen_enum];
)

// Rule: .xOpen = tclOpen ==> .xOpen_signature = xOpen_signatures[xOpen_tclOpen_enum];
@transform_xOpen_tclOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = tclOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_tclOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_tclOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_tclOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_tclOpen_enum];
)

// Rule: .xOpen = tclvarOpen ==> .xOpen_signature = xOpen_signatures[xOpen_tclvarOpen_enum];
@transform_xOpen_tclvarOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = tclvarOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_tclvarOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_tclvarOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_tclvarOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_tclvarOpen_enum];
)

// Rule: .xOpen = templatevtabOpen ==> .xOpen_signature = xOpen_signatures[xOpen_templatevtabOpen_enum];
@transform_xOpen_templatevtabOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = templatevtabOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_templatevtabOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_templatevtabOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_templatevtabOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_templatevtabOpen_enum];
)

// Rule: .xOpen = unicodeOpen ==> .xOpen_signature = xOpen_signatures[xOpen_unicodeOpen_enum];
@transform_xOpen_unicodeOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = unicodeOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_unicodeOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_unicodeOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_unicodeOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_unicodeOpen_enum];
)

// Rule: .xOpen = unionOpen ==> .xOpen_signature = xOpen_signatures[xOpen_unionOpen_enum];
@transform_xOpen_unionOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = unionOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_unionOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_unionOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_unionOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_unionOpen_enum];
)

// Rule: .xOpen = vfstraceOpen ==> .xOpen_signature = xOpen_signatures[xOpen_vfstraceOpen_enum];
@transform_xOpen_vfstraceOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = vfstraceOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_vfstraceOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_vfstraceOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_vfstraceOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_vfstraceOpen_enum];
)

// Rule: .xOpen = vstattabOpen ==> .xOpen_signature = xOpen_signatures[xOpen_vstattabOpen_enum];
@transform_xOpen_vstattabOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = vstattabOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_vstattabOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_vstattabOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_vstattabOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_vstattabOpen_enum];
)

// Rule: .xOpen = vtablogOpen ==> .xOpen_signature = xOpen_signatures[xOpen_vtablogOpen_enum];
@transform_xOpen_vtablogOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = vtablogOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_vtablogOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_vtablogOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_vtablogOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_vtablogOpen_enum];
)

// Rule: .xOpen = wholenumberOpen ==> .xOpen_signature = xOpen_signatures[xOpen_wholenumberOpen_enum];
@transform_xOpen_wholenumberOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = wholenumberOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_wholenumberOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_wholenumberOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_wholenumberOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_wholenumberOpen_enum];
)

// Rule: .xOpen = zipfileOpen ==> .xOpen_signature = xOpen_signatures[xOpen_zipfileOpen_enum];
@transform_xOpen_zipfileOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = zipfileOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_zipfileOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_zipfileOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_zipfileOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_zipfileOpen_enum];
)

// Rule: .xOpen = unixOpen ==> .xOpen_signature = xOpen_signatures[xOpen_unixOpen_enum];
@transform_xOpen_unixOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = unixOpen;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_unixOpen_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xOpen_signature = xOpen_signatures[xOpen_unixOpen_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_unixOpen_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xOpen_signature = xOpen_signatures[xOpen_unixOpen_enum];
)

// Rules for xPagecount (2 valid functions, 2 excluded)
// Rule: .xPagecount = pcache1Pagecount ==> .xPagecount_signature = xPagecount_signatures[xPagecount_pcache1Pagecount_enum];
@transform_xPagecount_pcache1Pagecount@
expression E;
identifier FP_NAME = xPagecount;
identifier FUNC_NAME = pcache1Pagecount;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xPagecount_signature = xPagecount_signatures[xPagecount_pcache1Pagecount_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xPagecount_signature = xPagecount_signatures[xPagecount_pcache1Pagecount_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xPagecount_signature = xPagecount_signatures[xPagecount_pcache1Pagecount_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xPagecount_signature = xPagecount_signatures[xPagecount_pcache1Pagecount_enum];
)

// Rule: .xPagecount = pcachetracePagecount ==> .xPagecount_signature = xPagecount_signatures[xPagecount_pcachetracePagecount_enum];
@transform_xPagecount_pcachetracePagecount@
expression E;
identifier FP_NAME = xPagecount;
identifier FUNC_NAME = pcachetracePagecount;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xPagecount_signature = xPagecount_signatures[xPagecount_pcachetracePagecount_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xPagecount_signature = xPagecount_signatures[xPagecount_pcachetracePagecount_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xPagecount_signature = xPagecount_signatures[xPagecount_pcachetracePagecount_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xPagecount_signature = xPagecount_signatures[xPagecount_pcachetracePagecount_enum];
)

// Rules for xParseCell (3 valid functions, 0 excluded)
// Rule: .xParseCell = btreeParseCellPtr ==> .xParseCell_signature = xParseCell_signatures[xParseCell_btreeParseCellPtr_enum];
@transform_xParseCell_btreeParseCellPtr@
expression E;
identifier FP_NAME = xParseCell;
identifier FUNC_NAME = btreeParseCellPtr;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xParseCell_signature = xParseCell_signatures[xParseCell_btreeParseCellPtr_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xParseCell_signature = xParseCell_signatures[xParseCell_btreeParseCellPtr_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xParseCell_signature = xParseCell_signatures[xParseCell_btreeParseCellPtr_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xParseCell_signature = xParseCell_signatures[xParseCell_btreeParseCellPtr_enum];
)

// Rule: .xParseCell = btreeParseCellPtrIndex ==> .xParseCell_signature = xParseCell_signatures[xParseCell_btreeParseCellPtrIndex_enum];
@transform_xParseCell_btreeParseCellPtrIndex@
expression E;
identifier FP_NAME = xParseCell;
identifier FUNC_NAME = btreeParseCellPtrIndex;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xParseCell_signature = xParseCell_signatures[xParseCell_btreeParseCellPtrIndex_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xParseCell_signature = xParseCell_signatures[xParseCell_btreeParseCellPtrIndex_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xParseCell_signature = xParseCell_signatures[xParseCell_btreeParseCellPtrIndex_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xParseCell_signature = xParseCell_signatures[xParseCell_btreeParseCellPtrIndex_enum];
)

// Rule: .xParseCell = btreeParseCellPtrNoPayload ==> .xParseCell_signature = xParseCell_signatures[xParseCell_btreeParseCellPtrNoPayload_enum];
@transform_xParseCell_btreeParseCellPtrNoPayload@
expression E;
identifier FP_NAME = xParseCell;
identifier FUNC_NAME = btreeParseCellPtrNoPayload;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xParseCell_signature = xParseCell_signatures[xParseCell_btreeParseCellPtrNoPayload_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xParseCell_signature = xParseCell_signatures[xParseCell_btreeParseCellPtrNoPayload_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xParseCell_signature = xParseCell_signatures[xParseCell_btreeParseCellPtrNoPayload_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xParseCell_signature = xParseCell_signatures[xParseCell_btreeParseCellPtrNoPayload_enum];
)

// Rules for xRandomness (4 valid functions, 9 excluded)
// Rule: .xRandomness = apndRandomness ==> .xRandomness_signature = xRandomness_signatures[xRandomness_apndRandomness_enum];
@transform_xRandomness_apndRandomness@
expression E;
identifier FP_NAME = xRandomness;
identifier FUNC_NAME = apndRandomness;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRandomness_signature = xRandomness_signatures[xRandomness_apndRandomness_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRandomness_signature = xRandomness_signatures[xRandomness_apndRandomness_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRandomness_signature = xRandomness_signatures[xRandomness_apndRandomness_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRandomness_signature = xRandomness_signatures[xRandomness_apndRandomness_enum];
)

// Rule: .xRandomness = memdbRandomness ==> .xRandomness_signature = xRandomness_signatures[xRandomness_memdbRandomness_enum];
@transform_xRandomness_memdbRandomness@
expression E;
identifier FP_NAME = xRandomness;
identifier FUNC_NAME = memdbRandomness;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRandomness_signature = xRandomness_signatures[xRandomness_memdbRandomness_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRandomness_signature = xRandomness_signatures[xRandomness_memdbRandomness_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRandomness_signature = xRandomness_signatures[xRandomness_memdbRandomness_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRandomness_signature = xRandomness_signatures[xRandomness_memdbRandomness_enum];
)

// Rule: .xRandomness = vfstraceRandomness ==> .xRandomness_signature = xRandomness_signatures[xRandomness_vfstraceRandomness_enum];
@transform_xRandomness_vfstraceRandomness@
expression E;
identifier FP_NAME = xRandomness;
identifier FUNC_NAME = vfstraceRandomness;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRandomness_signature = xRandomness_signatures[xRandomness_vfstraceRandomness_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRandomness_signature = xRandomness_signatures[xRandomness_vfstraceRandomness_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRandomness_signature = xRandomness_signatures[xRandomness_vfstraceRandomness_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRandomness_signature = xRandomness_signatures[xRandomness_vfstraceRandomness_enum];
)

// Rule: .xRandomness = unixRandomness ==> .xRandomness_signature = xRandomness_signatures[xRandomness_unixRandomness_enum];
@transform_xRandomness_unixRandomness@
expression E;
identifier FP_NAME = xRandomness;
identifier FUNC_NAME = unixRandomness;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRandomness_signature = xRandomness_signatures[xRandomness_unixRandomness_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRandomness_signature = xRandomness_signatures[xRandomness_unixRandomness_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRandomness_signature = xRandomness_signatures[xRandomness_unixRandomness_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRandomness_signature = xRandomness_signatures[xRandomness_unixRandomness_enum];
)

// Rules for xRead (6 valid functions, 19 excluded)
// Rule: .xRead = apndRead ==> .xRead_signature = xRead_signatures[xRead_apndRead_enum];
@transform_xRead_apndRead@
expression E;
identifier FP_NAME = xRead;
identifier FUNC_NAME = apndRead;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRead_signature = xRead_signatures[xRead_apndRead_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRead_signature = xRead_signatures[xRead_apndRead_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRead_signature = xRead_signatures[xRead_apndRead_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRead_signature = xRead_signatures[xRead_apndRead_enum];
)

// Rule: .xRead = memdbRead ==> .xRead_signature = xRead_signatures[xRead_memdbRead_enum];
@transform_xRead_memdbRead@
expression E;
identifier FP_NAME = xRead;
identifier FUNC_NAME = memdbRead;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRead_signature = xRead_signatures[xRead_memdbRead_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRead_signature = xRead_signatures[xRead_memdbRead_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRead_signature = xRead_signatures[xRead_memdbRead_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRead_signature = xRead_signatures[xRead_memdbRead_enum];
)

// Rule: .xRead = memjrnlRead ==> .xRead_signature = xRead_signatures[xRead_memjrnlRead_enum];
@transform_xRead_memjrnlRead@
expression E;
identifier FP_NAME = xRead;
identifier FUNC_NAME = memjrnlRead;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRead_signature = xRead_signatures[xRead_memjrnlRead_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRead_signature = xRead_signatures[xRead_memjrnlRead_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRead_signature = xRead_signatures[xRead_memjrnlRead_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRead_signature = xRead_signatures[xRead_memjrnlRead_enum];
)

// Rule: .xRead = recoverVfsRead ==> .xRead_signature = xRead_signatures[xRead_recoverVfsRead_enum];
@transform_xRead_recoverVfsRead@
expression E;
identifier FP_NAME = xRead;
identifier FUNC_NAME = recoverVfsRead;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRead_signature = xRead_signatures[xRead_recoverVfsRead_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRead_signature = xRead_signatures[xRead_recoverVfsRead_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRead_signature = xRead_signatures[xRead_recoverVfsRead_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRead_signature = xRead_signatures[xRead_recoverVfsRead_enum];
)

// Rule: .xRead = vfstraceRead ==> .xRead_signature = xRead_signatures[xRead_vfstraceRead_enum];
@transform_xRead_vfstraceRead@
expression E;
identifier FP_NAME = xRead;
identifier FUNC_NAME = vfstraceRead;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRead_signature = xRead_signatures[xRead_vfstraceRead_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRead_signature = xRead_signatures[xRead_vfstraceRead_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRead_signature = xRead_signatures[xRead_vfstraceRead_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRead_signature = xRead_signatures[xRead_vfstraceRead_enum];
)

// Rule: .xRead = unixRead ==> .xRead_signature = xRead_signatures[xRead_unixRead_enum];
@transform_xRead_unixRead@
expression E;
identifier FP_NAME = xRead;
identifier FUNC_NAME = unixRead;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRead_signature = xRead_signatures[xRead_unixRead_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRead_signature = xRead_signatures[xRead_unixRead_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRead_signature = xRead_signatures[xRead_unixRead_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRead_signature = xRead_signatures[xRead_unixRead_enum];
)

// Rules for xRealloc (2 valid functions, 5 excluded)
// Rule: .xRealloc = memtraceRealloc ==> .xRealloc_signature = xRealloc_signatures[xRealloc_memtraceRealloc_enum];
@transform_xRealloc_memtraceRealloc@
expression E;
identifier FP_NAME = xRealloc;
identifier FUNC_NAME = memtraceRealloc;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRealloc_signature = xRealloc_signatures[xRealloc_memtraceRealloc_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRealloc_signature = xRealloc_signatures[xRealloc_memtraceRealloc_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRealloc_signature = xRealloc_signatures[xRealloc_memtraceRealloc_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRealloc_signature = xRealloc_signatures[xRealloc_memtraceRealloc_enum];
)

// Rule: .xRealloc = sqlite3MemRealloc ==> .xRealloc_signature = xRealloc_signatures[xRealloc_sqlite3MemRealloc_enum];
@transform_xRealloc_sqlite3MemRealloc@
expression E;
identifier FP_NAME = xRealloc;
identifier FUNC_NAME = sqlite3MemRealloc;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRealloc_signature = xRealloc_signatures[xRealloc_sqlite3MemRealloc_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRealloc_signature = xRealloc_signatures[xRealloc_sqlite3MemRealloc_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRealloc_signature = xRealloc_signatures[xRealloc_sqlite3MemRealloc_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRealloc_signature = xRealloc_signatures[xRealloc_sqlite3MemRealloc_enum];
)

// Rules for xRekey (3 valid functions, 2 excluded)
// Rule: .xRekey = pcache1Rekey ==> .xRekey_signature = xRekey_signatures[xRekey_pcache1Rekey_enum];
@transform_xRekey_pcache1Rekey@
expression E;
identifier FP_NAME = xRekey;
identifier FUNC_NAME = pcache1Rekey;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRekey_signature = xRekey_signatures[xRekey_pcache1Rekey_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRekey_signature = xRekey_signatures[xRekey_pcache1Rekey_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRekey_signature = xRekey_signatures[xRekey_pcache1Rekey_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRekey_signature = xRekey_signatures[xRekey_pcache1Rekey_enum];
)

// Rule: .xRekey = pcachetraceRekey ==> .xRekey_signature = xRekey_signatures[xRekey_pcachetraceRekey_enum];
@transform_xRekey_pcachetraceRekey@
expression E;
identifier FP_NAME = xRekey;
identifier FUNC_NAME = pcachetraceRekey;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRekey_signature = xRekey_signatures[xRekey_pcachetraceRekey_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRekey_signature = xRekey_signatures[xRekey_pcachetraceRekey_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRekey_signature = xRekey_signatures[xRekey_pcachetraceRekey_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRekey_signature = xRekey_signatures[xRekey_pcachetraceRekey_enum];
)

// Rule: .xRekey = unixRandomness ==> .xRekey_signature = xRekey_signatures[xRekey_unixRandomness_enum];
@transform_xRekey_unixRandomness@
expression E;
identifier FP_NAME = xRekey;
identifier FUNC_NAME = unixRandomness;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRekey_signature = xRekey_signatures[xRekey_unixRandomness_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRekey_signature = xRekey_signatures[xRekey_unixRandomness_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRekey_signature = xRekey_signatures[xRekey_unixRandomness_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRekey_signature = xRekey_signatures[xRekey_unixRandomness_enum];
)

// Rules for xRelease (4 valid functions, 1 excluded)
// Rule: .xRelease = 0 ==> .xRelease_signature = xRelease_signatures[xRelease_0_enum];
@transform_xRelease_0@
expression E;
identifier FP_NAME = xRelease;
@@
(
E.FP_NAME = 0;
+ E.xRelease_signature = xRelease_signatures[xRelease_0_enum];
|
E->FP_NAME = 0;
+ E->xRelease_signature = xRelease_signatures[xRelease_0_enum];
)

// Rule: .xRelease = echoRelease ==> .xRelease_signature = xRelease_signatures[xRelease_echoRelease_enum];
@transform_xRelease_echoRelease@
expression E;
identifier FP_NAME = xRelease;
identifier FUNC_NAME = echoRelease;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRelease_signature = xRelease_signatures[xRelease_echoRelease_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRelease_signature = xRelease_signatures[xRelease_echoRelease_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRelease_signature = xRelease_signatures[xRelease_echoRelease_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRelease_signature = xRelease_signatures[xRelease_echoRelease_enum];
)

// Rule: .xRelease = fts3ReleaseMethod ==> .xRelease_signature = xRelease_signatures[xRelease_fts3ReleaseMethod_enum];
@transform_xRelease_fts3ReleaseMethod@
expression E;
identifier FP_NAME = xRelease;
identifier FUNC_NAME = fts3ReleaseMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRelease_signature = xRelease_signatures[xRelease_fts3ReleaseMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRelease_signature = xRelease_signatures[xRelease_fts3ReleaseMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRelease_signature = xRelease_signatures[xRelease_fts3ReleaseMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRelease_signature = xRelease_signatures[xRelease_fts3ReleaseMethod_enum];
)

// Rule: .xRelease = vtablogRelease ==> .xRelease_signature = xRelease_signatures[xRelease_vtablogRelease_enum];
@transform_xRelease_vtablogRelease@
expression E;
identifier FP_NAME = xRelease;
identifier FUNC_NAME = vtablogRelease;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRelease_signature = xRelease_signatures[xRelease_vtablogRelease_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRelease_signature = xRelease_signatures[xRelease_vtablogRelease_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRelease_signature = xRelease_signatures[xRelease_vtablogRelease_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRelease_signature = xRelease_signatures[xRelease_vtablogRelease_enum];
)

// Rules for xRename (6 valid functions, 3 excluded)
// Rule: .xRename = 0 ==> .xRename_signature = xRename_signatures[xRename_0_enum];
@transform_xRename_0@
expression E;
identifier FP_NAME = xRename;
@@
(
E.FP_NAME = 0;
+ E.xRename_signature = xRename_signatures[xRename_0_enum];
|
E->FP_NAME = 0;
+ E->xRename_signature = xRename_signatures[xRename_0_enum];
)

// Rule: .xRename = echoRename ==> .xRename_signature = xRename_signatures[xRename_echoRename_enum];
@transform_xRename_echoRename@
expression E;
identifier FP_NAME = xRename;
identifier FUNC_NAME = echoRename;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRename_signature = xRename_signatures[xRename_echoRename_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRename_signature = xRename_signatures[xRename_echoRename_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRename_signature = xRename_signatures[xRename_echoRename_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRename_signature = xRename_signatures[xRename_echoRename_enum];
)

// Rule: .xRename = fts3RenameMethod ==> .xRename_signature = xRename_signatures[xRename_fts3RenameMethod_enum];
@transform_xRename_fts3RenameMethod@
expression E;
identifier FP_NAME = xRename;
identifier FUNC_NAME = fts3RenameMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRename_signature = xRename_signatures[xRename_fts3RenameMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRename_signature = xRename_signatures[xRename_fts3RenameMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRename_signature = xRename_signatures[xRename_fts3RenameMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRename_signature = xRename_signatures[xRename_fts3RenameMethod_enum];
)

// Rule: .xRename = rtreeRename ==> .xRename_signature = xRename_signatures[xRename_rtreeRename_enum];
@transform_xRename_rtreeRename@
expression E;
identifier FP_NAME = xRename;
identifier FUNC_NAME = rtreeRename;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRename_signature = xRename_signatures[xRename_rtreeRename_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRename_signature = xRename_signatures[xRename_rtreeRename_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRename_signature = xRename_signatures[xRename_rtreeRename_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRename_signature = xRename_signatures[xRename_rtreeRename_enum];
)

// Rule: .xRename = spellfix1Rename ==> .xRename_signature = xRename_signatures[xRename_spellfix1Rename_enum];
@transform_xRename_spellfix1Rename@
expression E;
identifier FP_NAME = xRename;
identifier FUNC_NAME = spellfix1Rename;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRename_signature = xRename_signatures[xRename_spellfix1Rename_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRename_signature = xRename_signatures[xRename_spellfix1Rename_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRename_signature = xRename_signatures[xRename_spellfix1Rename_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRename_signature = xRename_signatures[xRename_spellfix1Rename_enum];
)

// Rule: .xRename = vtablogRename ==> .xRename_signature = xRename_signatures[xRename_vtablogRename_enum];
@transform_xRename_vtablogRename@
expression E;
identifier FP_NAME = xRename;
identifier FUNC_NAME = vtablogRename;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRename_signature = xRename_signatures[xRename_vtablogRename_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRename_signature = xRename_signatures[xRename_vtablogRename_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRename_signature = xRename_signatures[xRename_vtablogRename_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRename_signature = xRename_signatures[xRename_vtablogRename_enum];
)

// Rules for xRollback (7 valid functions, 1 excluded)
// Rule: .xRollback = 0 ==> .xRollback_signature = xRollback_signatures[xRollback_0_enum];
@transform_xRollback_0@
expression E;
identifier FP_NAME = xRollback;
@@
(
E.FP_NAME = 0;
+ E.xRollback_signature = xRollback_signatures[xRollback_0_enum];
|
E->FP_NAME = 0;
+ E->xRollback_signature = xRollback_signatures[xRollback_0_enum];
)

// Rule: .xRollback = echoRollback ==> .xRollback_signature = xRollback_signatures[xRollback_echoRollback_enum];
@transform_xRollback_echoRollback@
expression E;
identifier FP_NAME = xRollback;
identifier FUNC_NAME = echoRollback;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRollback_signature = xRollback_signatures[xRollback_echoRollback_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRollback_signature = xRollback_signatures[xRollback_echoRollback_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRollback_signature = xRollback_signatures[xRollback_echoRollback_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRollback_signature = xRollback_signatures[xRollback_echoRollback_enum];
)

// Rule: .xRollback = fts3RollbackMethod ==> .xRollback_signature = xRollback_signatures[xRollback_fts3RollbackMethod_enum];
@transform_xRollback_fts3RollbackMethod@
expression E;
identifier FP_NAME = xRollback;
identifier FUNC_NAME = fts3RollbackMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRollback_signature = xRollback_signatures[xRollback_fts3RollbackMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRollback_signature = xRollback_signatures[xRollback_fts3RollbackMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRollback_signature = xRollback_signatures[xRollback_fts3RollbackMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRollback_signature = xRollback_signatures[xRollback_fts3RollbackMethod_enum];
)

// Rule: .xRollback = rtreeEndTransaction ==> .xRollback_signature = xRollback_signatures[xRollback_rtreeEndTransaction_enum];
@transform_xRollback_rtreeEndTransaction@
expression E;
identifier FP_NAME = xRollback;
identifier FUNC_NAME = rtreeEndTransaction;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRollback_signature = xRollback_signatures[xRollback_rtreeEndTransaction_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRollback_signature = xRollback_signatures[xRollback_rtreeEndTransaction_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRollback_signature = xRollback_signatures[xRollback_rtreeEndTransaction_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRollback_signature = xRollback_signatures[xRollback_rtreeEndTransaction_enum];
)

// Rule: .xRollback = rtreeRollback ==> .xRollback_signature = xRollback_signatures[xRollback_rtreeRollback_enum];
@transform_xRollback_rtreeRollback@
expression E;
identifier FP_NAME = xRollback;
identifier FUNC_NAME = rtreeRollback;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRollback_signature = xRollback_signatures[xRollback_rtreeRollback_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRollback_signature = xRollback_signatures[xRollback_rtreeRollback_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRollback_signature = xRollback_signatures[xRollback_rtreeRollback_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRollback_signature = xRollback_signatures[xRollback_rtreeRollback_enum];
)

// Rule: .xRollback = vtablogRollback ==> .xRollback_signature = xRollback_signatures[xRollback_vtablogRollback_enum];
@transform_xRollback_vtablogRollback@
expression E;
identifier FP_NAME = xRollback;
identifier FUNC_NAME = vtablogRollback;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRollback_signature = xRollback_signatures[xRollback_vtablogRollback_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRollback_signature = xRollback_signatures[xRollback_vtablogRollback_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRollback_signature = xRollback_signatures[xRollback_vtablogRollback_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRollback_signature = xRollback_signatures[xRollback_vtablogRollback_enum];
)

// Rule: .xRollback = zipfileRollback ==> .xRollback_signature = xRollback_signatures[xRollback_zipfileRollback_enum];
@transform_xRollback_zipfileRollback@
expression E;
identifier FP_NAME = xRollback;
identifier FUNC_NAME = zipfileRollback;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRollback_signature = xRollback_signatures[xRollback_zipfileRollback_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRollback_signature = xRollback_signatures[xRollback_zipfileRollback_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRollback_signature = xRollback_signatures[xRollback_zipfileRollback_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRollback_signature = xRollback_signatures[xRollback_zipfileRollback_enum];
)

// Rules for xRollbackTo (5 valid functions, 1 excluded)
// Rule: .xRollbackTo = 0 ==> .xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_0_enum];
@transform_xRollbackTo_0@
expression E;
identifier FP_NAME = xRollbackTo;
@@
(
E.FP_NAME = 0;
+ E.xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_0_enum];
|
E->FP_NAME = 0;
+ E->xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_0_enum];
)

// Rule: .xRollbackTo = dbpageRollbackTo ==> .xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_dbpageRollbackTo_enum];
@transform_xRollbackTo_dbpageRollbackTo@
expression E;
identifier FP_NAME = xRollbackTo;
identifier FUNC_NAME = dbpageRollbackTo;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_dbpageRollbackTo_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_dbpageRollbackTo_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_dbpageRollbackTo_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_dbpageRollbackTo_enum];
)

// Rule: .xRollbackTo = echoRollbackTo ==> .xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_echoRollbackTo_enum];
@transform_xRollbackTo_echoRollbackTo@
expression E;
identifier FP_NAME = xRollbackTo;
identifier FUNC_NAME = echoRollbackTo;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_echoRollbackTo_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_echoRollbackTo_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_echoRollbackTo_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_echoRollbackTo_enum];
)

// Rule: .xRollbackTo = fts3RollbackToMethod ==> .xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_fts3RollbackToMethod_enum];
@transform_xRollbackTo_fts3RollbackToMethod@
expression E;
identifier FP_NAME = xRollbackTo;
identifier FUNC_NAME = fts3RollbackToMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_fts3RollbackToMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_fts3RollbackToMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_fts3RollbackToMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_fts3RollbackToMethod_enum];
)

// Rule: .xRollbackTo = vtablogRollbackTo ==> .xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_vtablogRollbackTo_enum];
@transform_xRollbackTo_vtablogRollbackTo@
expression E;
identifier FP_NAME = xRollbackTo;
identifier FUNC_NAME = vtablogRollbackTo;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_vtablogRollbackTo_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_vtablogRollbackTo_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_vtablogRollbackTo_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRollbackTo_signature = xRollbackTo_signatures[xRollbackTo_vtablogRollbackTo_enum];
)

// Rules for xRoundup (2 valid functions, 4 excluded)
// Rule: .xRoundup = memtraceRoundup ==> .xRoundup_signature = xRoundup_signatures[xRoundup_memtraceRoundup_enum];
@transform_xRoundup_memtraceRoundup@
expression E;
identifier FP_NAME = xRoundup;
identifier FUNC_NAME = memtraceRoundup;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRoundup_signature = xRoundup_signatures[xRoundup_memtraceRoundup_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRoundup_signature = xRoundup_signatures[xRoundup_memtraceRoundup_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRoundup_signature = xRoundup_signatures[xRoundup_memtraceRoundup_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRoundup_signature = xRoundup_signatures[xRoundup_memtraceRoundup_enum];
)

// Rule: .xRoundup = sqlite3MemRoundup ==> .xRoundup_signature = xRoundup_signatures[xRoundup_sqlite3MemRoundup_enum];
@transform_xRoundup_sqlite3MemRoundup@
expression E;
identifier FP_NAME = xRoundup;
identifier FUNC_NAME = sqlite3MemRoundup;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRoundup_signature = xRoundup_signatures[xRoundup_sqlite3MemRoundup_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRoundup_signature = xRoundup_signatures[xRoundup_sqlite3MemRoundup_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRoundup_signature = xRoundup_signatures[xRoundup_sqlite3MemRoundup_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRoundup_signature = xRoundup_signatures[xRoundup_sqlite3MemRoundup_enum];
)

// Rules for xRowid (43 valid functions, 5 excluded)
// Rule: .xRowid = 0 ==> .xRowid_signature = xRowid_signatures[xRowid_0_enum];
@transform_xRowid_0@
expression E;
identifier FP_NAME = xRowid;
@@
(
E.FP_NAME = 0;
+ E.xRowid_signature = xRowid_signatures[xRowid_0_enum];
|
E->FP_NAME = 0;
+ E->xRowid_signature = xRowid_signatures[xRowid_0_enum];
)

// Rule: .xRowid = amatchRowid ==> .xRowid_signature = xRowid_signatures[xRowid_amatchRowid_enum];
@transform_xRowid_amatchRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = amatchRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_amatchRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_amatchRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_amatchRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_amatchRowid_enum];
)

// Rule: .xRowid = binfoRowid ==> .xRowid_signature = xRowid_signatures[xRowid_binfoRowid_enum];
@transform_xRowid_binfoRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = binfoRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_binfoRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_binfoRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_binfoRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_binfoRowid_enum];
)

// Rule: .xRowid = bytecodevtabRowid ==> .xRowid_signature = xRowid_signatures[xRowid_bytecodevtabRowid_enum];
@transform_xRowid_bytecodevtabRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = bytecodevtabRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_bytecodevtabRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_bytecodevtabRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_bytecodevtabRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_bytecodevtabRowid_enum];
)

// Rule: .xRowid = carrayRowid ==> .xRowid_signature = xRowid_signatures[xRowid_carrayRowid_enum];
@transform_xRowid_carrayRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = carrayRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_carrayRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_carrayRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_carrayRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_carrayRowid_enum];
)

// Rule: .xRowid = cidxRowid ==> .xRowid_signature = xRowid_signatures[xRowid_cidxRowid_enum];
@transform_xRowid_cidxRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = cidxRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_cidxRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_cidxRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_cidxRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_cidxRowid_enum];
)

// Rule: .xRowid = closureRowid ==> .xRowid_signature = xRowid_signatures[xRowid_closureRowid_enum];
@transform_xRowid_closureRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = closureRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_closureRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_closureRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_closureRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_closureRowid_enum];
)

// Rule: .xRowid = completionRowid ==> .xRowid_signature = xRowid_signatures[xRowid_completionRowid_enum];
@transform_xRowid_completionRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = completionRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_completionRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_completionRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_completionRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_completionRowid_enum];
)

// Rule: .xRowid = csvtabRowid ==> .xRowid_signature = xRowid_signatures[xRowid_csvtabRowid_enum];
@transform_xRowid_csvtabRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = csvtabRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_csvtabRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_csvtabRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_csvtabRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_csvtabRowid_enum];
)

// Rule: .xRowid = dbdataRowid ==> .xRowid_signature = xRowid_signatures[xRowid_dbdataRowid_enum];
@transform_xRowid_dbdataRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = dbdataRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_dbdataRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_dbdataRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_dbdataRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_dbdataRowid_enum];
)

// Rule: .xRowid = dbpageRowid ==> .xRowid_signature = xRowid_signatures[xRowid_dbpageRowid_enum];
@transform_xRowid_dbpageRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = dbpageRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_dbpageRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_dbpageRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_dbpageRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_dbpageRowid_enum];
)

// Rule: .xRowid = deltaparsevtabRowid ==> .xRowid_signature = xRowid_signatures[xRowid_deltaparsevtabRowid_enum];
@transform_xRowid_deltaparsevtabRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = deltaparsevtabRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_deltaparsevtabRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_deltaparsevtabRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_deltaparsevtabRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_deltaparsevtabRowid_enum];
)

// Rule: .xRowid = echoRowid ==> .xRowid_signature = xRowid_signatures[xRowid_echoRowid_enum];
@transform_xRowid_echoRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = echoRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_echoRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_echoRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_echoRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_echoRowid_enum];
)

// Rule: .xRowid = expertRowid ==> .xRowid_signature = xRowid_signatures[xRowid_expertRowid_enum];
@transform_xRowid_expertRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = expertRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_expertRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_expertRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_expertRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_expertRowid_enum];
)

// Rule: .xRowid = explainRowid ==> .xRowid_signature = xRowid_signatures[xRowid_explainRowid_enum];
@transform_xRowid_explainRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = explainRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_explainRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_explainRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_explainRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_explainRowid_enum];
)

// Rule: .xRowid = fsRowid ==> .xRowid_signature = xRowid_signatures[xRowid_fsRowid_enum];
@transform_xRowid_fsRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = fsRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_fsRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_fsRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_fsRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_fsRowid_enum];
)

// Rule: .xRowid = fsdirRowid ==> .xRowid_signature = xRowid_signatures[xRowid_fsdirRowid_enum];
@transform_xRowid_fsdirRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = fsdirRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_fsdirRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_fsdirRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_fsdirRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_fsdirRowid_enum];
)

// Rule: .xRowid = fstreeRowid ==> .xRowid_signature = xRowid_signatures[xRowid_fstreeRowid_enum];
@transform_xRowid_fstreeRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = fstreeRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_fstreeRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_fstreeRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_fstreeRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_fstreeRowid_enum];
)

// Rule: .xRowid = fts3RowidMethod ==> .xRowid_signature = xRowid_signatures[xRowid_fts3RowidMethod_enum];
@transform_xRowid_fts3RowidMethod@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = fts3RowidMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_fts3RowidMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_fts3RowidMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_fts3RowidMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_fts3RowidMethod_enum];
)

// Rule: .xRowid = fts3auxRowidMethod ==> .xRowid_signature = xRowid_signatures[xRowid_fts3auxRowidMethod_enum];
@transform_xRowid_fts3auxRowidMethod@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = fts3auxRowidMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_fts3auxRowidMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_fts3auxRowidMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_fts3auxRowidMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_fts3auxRowidMethod_enum];
)

// Rule: .xRowid = fts3termRowidMethod ==> .xRowid_signature = xRowid_signatures[xRowid_fts3termRowidMethod_enum];
@transform_xRowid_fts3termRowidMethod@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = fts3termRowidMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_fts3termRowidMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_fts3termRowidMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_fts3termRowidMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_fts3termRowidMethod_enum];
)

// Rule: .xRowid = fts3tokRowidMethod ==> .xRowid_signature = xRowid_signatures[xRowid_fts3tokRowidMethod_enum];
@transform_xRowid_fts3tokRowidMethod@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = fts3tokRowidMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_fts3tokRowidMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_fts3tokRowidMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_fts3tokRowidMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_fts3tokRowidMethod_enum];
)

// Rule: .xRowid = fuzzerRowid ==> .xRowid_signature = xRowid_signatures[xRowid_fuzzerRowid_enum];
@transform_xRowid_fuzzerRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = fuzzerRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_fuzzerRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_fuzzerRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_fuzzerRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_fuzzerRowid_enum];
)

// Rule: .xRowid = intarrayRowid ==> .xRowid_signature = xRowid_signatures[xRowid_intarrayRowid_enum];
@transform_xRowid_intarrayRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = intarrayRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_intarrayRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_intarrayRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_intarrayRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_intarrayRowid_enum];
)

// Rule: .xRowid = jsonEachRowid ==> .xRowid_signature = xRowid_signatures[xRowid_jsonEachRowid_enum];
@transform_xRowid_jsonEachRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = jsonEachRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_jsonEachRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_jsonEachRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_jsonEachRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_jsonEachRowid_enum];
)

// Rule: .xRowid = memstatRowid ==> .xRowid_signature = xRowid_signatures[xRowid_memstatRowid_enum];
@transform_xRowid_memstatRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = memstatRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_memstatRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_memstatRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_memstatRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_memstatRowid_enum];
)

// Rule: .xRowid = pragmaVtabRowid ==> .xRowid_signature = xRowid_signatures[xRowid_pragmaVtabRowid_enum];
@transform_xRowid_pragmaVtabRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = pragmaVtabRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_pragmaVtabRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_pragmaVtabRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_pragmaVtabRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_pragmaVtabRowid_enum];
)

// Rule: .xRowid = prefixesRowid ==> .xRowid_signature = xRowid_signatures[xRowid_prefixesRowid_enum];
@transform_xRowid_prefixesRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = prefixesRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_prefixesRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_prefixesRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_prefixesRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_prefixesRowid_enum];
)

// Rule: .xRowid = qpvtabRowid ==> .xRowid_signature = xRowid_signatures[xRowid_qpvtabRowid_enum];
@transform_xRowid_qpvtabRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = qpvtabRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_qpvtabRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_qpvtabRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_qpvtabRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_qpvtabRowid_enum];
)

// Rule: .xRowid = rtreeRowid ==> .xRowid_signature = xRowid_signatures[xRowid_rtreeRowid_enum];
@transform_xRowid_rtreeRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = rtreeRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_rtreeRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_rtreeRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_rtreeRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_rtreeRowid_enum];
)

// Rule: .xRowid = schemaRowid ==> .xRowid_signature = xRowid_signatures[xRowid_schemaRowid_enum];
@transform_xRowid_schemaRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = schemaRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_schemaRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_schemaRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_schemaRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_schemaRowid_enum];
)

// Rule: .xRowid = seriesRowid ==> .xRowid_signature = xRowid_signatures[xRowid_seriesRowid_enum];
@transform_xRowid_seriesRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = seriesRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_seriesRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_seriesRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_seriesRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_seriesRowid_enum];
)

// Rule: .xRowid = spellfix1Rowid ==> .xRowid_signature = xRowid_signatures[xRowid_spellfix1Rowid_enum];
@transform_xRowid_spellfix1Rowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = spellfix1Rowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_spellfix1Rowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_spellfix1Rowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_spellfix1Rowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_spellfix1Rowid_enum];
)

// Rule: .xRowid = statRowid ==> .xRowid_signature = xRowid_signatures[xRowid_statRowid_enum];
@transform_xRowid_statRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = statRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_statRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_statRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_statRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_statRowid_enum];
)

// Rule: .xRowid = stmtRowid ==> .xRowid_signature = xRowid_signatures[xRowid_stmtRowid_enum];
@transform_xRowid_stmtRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = stmtRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_stmtRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_stmtRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_stmtRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_stmtRowid_enum];
)

// Rule: .xRowid = tclRowid ==> .xRowid_signature = xRowid_signatures[xRowid_tclRowid_enum];
@transform_xRowid_tclRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = tclRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_tclRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_tclRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_tclRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_tclRowid_enum];
)

// Rule: .xRowid = tclvarRowid ==> .xRowid_signature = xRowid_signatures[xRowid_tclvarRowid_enum];
@transform_xRowid_tclvarRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = tclvarRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_tclvarRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_tclvarRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_tclvarRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_tclvarRowid_enum];
)

// Rule: .xRowid = templatevtabRowid ==> .xRowid_signature = xRowid_signatures[xRowid_templatevtabRowid_enum];
@transform_xRowid_templatevtabRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = templatevtabRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_templatevtabRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_templatevtabRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_templatevtabRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_templatevtabRowid_enum];
)

// Rule: .xRowid = unionRowid ==> .xRowid_signature = xRowid_signatures[xRowid_unionRowid_enum];
@transform_xRowid_unionRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = unionRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_unionRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_unionRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_unionRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_unionRowid_enum];
)

// Rule: .xRowid = vlogRowid ==> .xRowid_signature = xRowid_signatures[xRowid_vlogRowid_enum];
@transform_xRowid_vlogRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = vlogRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_vlogRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_vlogRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_vlogRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_vlogRowid_enum];
)

// Rule: .xRowid = vstattabRowid ==> .xRowid_signature = xRowid_signatures[xRowid_vstattabRowid_enum];
@transform_xRowid_vstattabRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = vstattabRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_vstattabRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_vstattabRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_vstattabRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_vstattabRowid_enum];
)

// Rule: .xRowid = vtablogRowid ==> .xRowid_signature = xRowid_signatures[xRowid_vtablogRowid_enum];
@transform_xRowid_vtablogRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = vtablogRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_vtablogRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_vtablogRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_vtablogRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_vtablogRowid_enum];
)

// Rule: .xRowid = wholenumberRowid ==> .xRowid_signature = xRowid_signatures[xRowid_wholenumberRowid_enum];
@transform_xRowid_wholenumberRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME = wholenumberRowid;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_wholenumberRowid_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xRowid_signature = xRowid_signatures[xRowid_wholenumberRowid_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_wholenumberRowid_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xRowid_signature = xRowid_signatures[xRowid_wholenumberRowid_enum];
)

// Rules for xSFunc (5 valid functions, 1 excluded)
// Rule: .xSFunc = attachFunc ==> .xSFunc_signature = xSFunc_signatures[xSFunc_attachFunc_enum];
@transform_xSFunc_attachFunc@
expression E;
identifier FP_NAME = xSFunc;
identifier FUNC_NAME = attachFunc;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSFunc_signature = xSFunc_signatures[xSFunc_attachFunc_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSFunc_signature = xSFunc_signatures[xSFunc_attachFunc_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSFunc_signature = xSFunc_signatures[xSFunc_attachFunc_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSFunc_signature = xSFunc_signatures[xSFunc_attachFunc_enum];
)

// Rule: .xSFunc = detachFunc ==> .xSFunc_signature = xSFunc_signatures[xSFunc_detachFunc_enum];
@transform_xSFunc_detachFunc@
expression E;
identifier FP_NAME = xSFunc;
identifier FUNC_NAME = detachFunc;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSFunc_signature = xSFunc_signatures[xSFunc_detachFunc_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSFunc_signature = xSFunc_signatures[xSFunc_detachFunc_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSFunc_signature = xSFunc_signatures[xSFunc_detachFunc_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSFunc_signature = xSFunc_signatures[xSFunc_detachFunc_enum];
)

// Rule: .xSFunc = statGet ==> .xSFunc_signature = xSFunc_signatures[xSFunc_statGet_enum];
@transform_xSFunc_statGet@
expression E;
identifier FP_NAME = xSFunc;
identifier FUNC_NAME = statGet;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSFunc_signature = xSFunc_signatures[xSFunc_statGet_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSFunc_signature = xSFunc_signatures[xSFunc_statGet_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSFunc_signature = xSFunc_signatures[xSFunc_statGet_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSFunc_signature = xSFunc_signatures[xSFunc_statGet_enum];
)

// Rule: .xSFunc = statInit ==> .xSFunc_signature = xSFunc_signatures[xSFunc_statInit_enum];
@transform_xSFunc_statInit@
expression E;
identifier FP_NAME = xSFunc;
identifier FUNC_NAME = statInit;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSFunc_signature = xSFunc_signatures[xSFunc_statInit_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSFunc_signature = xSFunc_signatures[xSFunc_statInit_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSFunc_signature = xSFunc_signatures[xSFunc_statInit_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSFunc_signature = xSFunc_signatures[xSFunc_statInit_enum];
)

// Rule: .xSFunc = statPush ==> .xSFunc_signature = xSFunc_signatures[xSFunc_statPush_enum];
@transform_xSFunc_statPush@
expression E;
identifier FP_NAME = xSFunc;
identifier FUNC_NAME = statPush;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSFunc_signature = xSFunc_signatures[xSFunc_statPush_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSFunc_signature = xSFunc_signatures[xSFunc_statPush_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSFunc_signature = xSFunc_signatures[xSFunc_statPush_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSFunc_signature = xSFunc_signatures[xSFunc_statPush_enum];
)

// Rules for xSavepoint (3 valid functions, 3 excluded)
// Rule: .xSavepoint = 0 ==> .xSavepoint_signature = xSavepoint_signatures[xSavepoint_0_enum];
@transform_xSavepoint_0@
expression E;
identifier FP_NAME = xSavepoint;
@@
(
E.FP_NAME = 0;
+ E.xSavepoint_signature = xSavepoint_signatures[xSavepoint_0_enum];
|
E->FP_NAME = 0;
+ E->xSavepoint_signature = xSavepoint_signatures[xSavepoint_0_enum];
)

// Rule: .xSavepoint = fts3SavepointMethod ==> .xSavepoint_signature = xSavepoint_signatures[xSavepoint_fts3SavepointMethod_enum];
@transform_xSavepoint_fts3SavepointMethod@
expression E;
identifier FP_NAME = xSavepoint;
identifier FUNC_NAME = fts3SavepointMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSavepoint_signature = xSavepoint_signatures[xSavepoint_fts3SavepointMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSavepoint_signature = xSavepoint_signatures[xSavepoint_fts3SavepointMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSavepoint_signature = xSavepoint_signatures[xSavepoint_fts3SavepointMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSavepoint_signature = xSavepoint_signatures[xSavepoint_fts3SavepointMethod_enum];
)

// Rule: .xSavepoint = rtreeSavepoint ==> .xSavepoint_signature = xSavepoint_signatures[xSavepoint_rtreeSavepoint_enum];
@transform_xSavepoint_rtreeSavepoint@
expression E;
identifier FP_NAME = xSavepoint;
identifier FUNC_NAME = rtreeSavepoint;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSavepoint_signature = xSavepoint_signatures[xSavepoint_rtreeSavepoint_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSavepoint_signature = xSavepoint_signatures[xSavepoint_rtreeSavepoint_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSavepoint_signature = xSavepoint_signatures[xSavepoint_rtreeSavepoint_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSavepoint_signature = xSavepoint_signatures[xSavepoint_rtreeSavepoint_enum];
)

// Rules for xSectorSize (5 valid functions, 18 excluded)
// Rule: .xSectorSize = 0 ==> .xSectorSize_signature = xSectorSize_signatures[xSectorSize_0_enum];
@transform_xSectorSize_0@
expression E;
identifier FP_NAME = xSectorSize;
@@
(
E.FP_NAME = 0;
+ E.xSectorSize_signature = xSectorSize_signatures[xSectorSize_0_enum];
|
E->FP_NAME = 0;
+ E->xSectorSize_signature = xSectorSize_signatures[xSectorSize_0_enum];
)

// Rule: .xSectorSize = apndSectorSize ==> .xSectorSize_signature = xSectorSize_signatures[xSectorSize_apndSectorSize_enum];
@transform_xSectorSize_apndSectorSize@
expression E;
identifier FP_NAME = xSectorSize;
identifier FUNC_NAME = apndSectorSize;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSectorSize_signature = xSectorSize_signatures[xSectorSize_apndSectorSize_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSectorSize_signature = xSectorSize_signatures[xSectorSize_apndSectorSize_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSectorSize_signature = xSectorSize_signatures[xSectorSize_apndSectorSize_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSectorSize_signature = xSectorSize_signatures[xSectorSize_apndSectorSize_enum];
)

// Rule: .xSectorSize = recoverVfsSectorSize ==> .xSectorSize_signature = xSectorSize_signatures[xSectorSize_recoverVfsSectorSize_enum];
@transform_xSectorSize_recoverVfsSectorSize@
expression E;
identifier FP_NAME = xSectorSize;
identifier FUNC_NAME = recoverVfsSectorSize;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSectorSize_signature = xSectorSize_signatures[xSectorSize_recoverVfsSectorSize_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSectorSize_signature = xSectorSize_signatures[xSectorSize_recoverVfsSectorSize_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSectorSize_signature = xSectorSize_signatures[xSectorSize_recoverVfsSectorSize_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSectorSize_signature = xSectorSize_signatures[xSectorSize_recoverVfsSectorSize_enum];
)

// Rule: .xSectorSize = vfstraceSectorSize ==> .xSectorSize_signature = xSectorSize_signatures[xSectorSize_vfstraceSectorSize_enum];
@transform_xSectorSize_vfstraceSectorSize@
expression E;
identifier FP_NAME = xSectorSize;
identifier FUNC_NAME = vfstraceSectorSize;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSectorSize_signature = xSectorSize_signatures[xSectorSize_vfstraceSectorSize_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSectorSize_signature = xSectorSize_signatures[xSectorSize_vfstraceSectorSize_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSectorSize_signature = xSectorSize_signatures[xSectorSize_vfstraceSectorSize_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSectorSize_signature = xSectorSize_signatures[xSectorSize_vfstraceSectorSize_enum];
)

// Rule: .xSectorSize = unixSectorSize ==> .xSectorSize_signature = xSectorSize_signatures[xSectorSize_unixSectorSize_enum];
@transform_xSectorSize_unixSectorSize@
expression E;
identifier FP_NAME = xSectorSize;
identifier FUNC_NAME = unixSectorSize;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSectorSize_signature = xSectorSize_signatures[xSectorSize_unixSectorSize_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSectorSize_signature = xSectorSize_signatures[xSectorSize_unixSectorSize_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSectorSize_signature = xSectorSize_signatures[xSectorSize_unixSectorSize_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSectorSize_signature = xSectorSize_signatures[xSectorSize_unixSectorSize_enum];
)

// Rules for xSelectCallback (17 valid functions, 0 excluded)
// Rule: .xSelectCallback = 0 ==> .xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_0_enum];
@transform_xSelectCallback_0@
expression E;
identifier FP_NAME = xSelectCallback;
@@
(
E.FP_NAME = 0;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_0_enum];
|
E->FP_NAME = 0;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_0_enum];
)

// Rule: .xSelectCallback = convertCompoundSelectToSubquery ==> .xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_convertCompoundSelectToSubquery_enum];
@transform_xSelectCallback_convertCompoundSelectToSubquery@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = convertCompoundSelectToSubquery;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_convertCompoundSelectToSubquery_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_convertCompoundSelectToSubquery_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_convertCompoundSelectToSubquery_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_convertCompoundSelectToSubquery_enum];
)

// Rule: .xSelectCallback = exprSelectWalkTableConstant ==> .xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_exprSelectWalkTableConstant_enum];
@transform_xSelectCallback_exprSelectWalkTableConstant@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = exprSelectWalkTableConstant;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_exprSelectWalkTableConstant_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_exprSelectWalkTableConstant_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_exprSelectWalkTableConstant_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_exprSelectWalkTableConstant_enum];
)

// Rule: .xSelectCallback = fixSelectCb ==> .xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_fixSelectCb_enum];
@transform_xSelectCallback_fixSelectCb@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = fixSelectCb;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_fixSelectCb_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_fixSelectCb_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_fixSelectCb_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_fixSelectCb_enum];
)

// Rule: .xSelectCallback = gatherSelectWindowsSelectCallback ==> .xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_gatherSelectWindowsSelectCallback_enum];
@transform_xSelectCallback_gatherSelectWindowsSelectCallback@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = gatherSelectWindowsSelectCallback;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_gatherSelectWindowsSelectCallback_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_gatherSelectWindowsSelectCallback_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_gatherSelectWindowsSelectCallback_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_gatherSelectWindowsSelectCallback_enum];
)

// Rule: .xSelectCallback = renameColumnSelectCb ==> .xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_renameColumnSelectCb_enum];
@transform_xSelectCallback_renameColumnSelectCb@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = renameColumnSelectCb;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_renameColumnSelectCb_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_renameColumnSelectCb_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_renameColumnSelectCb_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_renameColumnSelectCb_enum];
)

// Rule: .xSelectCallback = renameTableSelectCb ==> .xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_renameTableSelectCb_enum];
@transform_xSelectCallback_renameTableSelectCb@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = renameTableSelectCb;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_renameTableSelectCb_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_renameTableSelectCb_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_renameTableSelectCb_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_renameTableSelectCb_enum];
)

// Rule: .xSelectCallback = renameUnmapSelectCb ==> .xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_renameUnmapSelectCb_enum];
@transform_xSelectCallback_renameUnmapSelectCb@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = renameUnmapSelectCb;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_renameUnmapSelectCb_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_renameUnmapSelectCb_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_renameUnmapSelectCb_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_renameUnmapSelectCb_enum];
)

// Rule: .xSelectCallback = resolveSelectStep ==> .xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_resolveSelectStep_enum];
@transform_xSelectCallback_resolveSelectStep@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = resolveSelectStep;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_resolveSelectStep_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_resolveSelectStep_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_resolveSelectStep_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_resolveSelectStep_enum];
)

// Rule: .xSelectCallback = selectCheckOnClausesSelect ==> .xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_selectCheckOnClausesSelect_enum];
@transform_xSelectCallback_selectCheckOnClausesSelect@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = selectCheckOnClausesSelect;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_selectCheckOnClausesSelect_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_selectCheckOnClausesSelect_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_selectCheckOnClausesSelect_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_selectCheckOnClausesSelect_enum];
)

// Rule: .xSelectCallback = selectExpander ==> .xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_selectExpander_enum];
@transform_xSelectCallback_selectExpander@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = selectExpander;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_selectExpander_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_selectExpander_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_selectExpander_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_selectExpander_enum];
)

// Rule: .xSelectCallback = selectRefEnter ==> .xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_selectRefEnter_enum];
@transform_xSelectCallback_selectRefEnter@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = selectRefEnter;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_selectRefEnter_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_selectRefEnter_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_selectRefEnter_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_selectRefEnter_enum];
)

// Rule: .xSelectCallback = selectWindowRewriteSelectCb ==> .xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_selectWindowRewriteSelectCb_enum];
@transform_xSelectCallback_selectWindowRewriteSelectCb@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = selectWindowRewriteSelectCb;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_selectWindowRewriteSelectCb_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_selectWindowRewriteSelectCb_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_selectWindowRewriteSelectCb_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_selectWindowRewriteSelectCb_enum];
)

// Rule: .xSelectCallback = sqlite3ReturningSubqueryCorrelated ==> .xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_sqlite3ReturningSubqueryCorrelated_enum];
@transform_xSelectCallback_sqlite3ReturningSubqueryCorrelated@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = sqlite3ReturningSubqueryCorrelated;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_sqlite3ReturningSubqueryCorrelated_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_sqlite3ReturningSubqueryCorrelated_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_sqlite3ReturningSubqueryCorrelated_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_sqlite3ReturningSubqueryCorrelated_enum];
)

// Rule: .xSelectCallback = sqlite3SelectWalkFail ==> .xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkFail_enum];
@transform_xSelectCallback_sqlite3SelectWalkFail@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = sqlite3SelectWalkFail;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkFail_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkFail_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkFail_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkFail_enum];
)

// Rule: .xSelectCallback = sqlite3SelectWalkNoop ==> .xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkNoop_enum];
@transform_xSelectCallback_sqlite3SelectWalkNoop@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = sqlite3SelectWalkNoop;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkNoop_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkNoop_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkNoop_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkNoop_enum];
)

// Rule: .xSelectCallback = sqlite3WalkerDepthIncrease ==> .xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_sqlite3WalkerDepthIncrease_enum];
@transform_xSelectCallback_sqlite3WalkerDepthIncrease@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = sqlite3WalkerDepthIncrease;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_sqlite3WalkerDepthIncrease_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_sqlite3WalkerDepthIncrease_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_sqlite3WalkerDepthIncrease_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSelectCallback_signature = xSelectCallback_signatures[xSelectCallback_sqlite3WalkerDepthIncrease_enum];
)

// Rules for xSelectCallback2 (6 valid functions, 1 excluded)
// Rule: .xSelectCallback2 = 0 ==> .xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_0_enum];
@transform_xSelectCallback2_0@
expression E;
identifier FP_NAME = xSelectCallback2;
@@
(
E.FP_NAME = 0;
+ E.xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_0_enum];
|
E->FP_NAME = 0;
+ E->xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_0_enum];
)

// Rule: .xSelectCallback2 = selectAddSubqueryTypeInfo ==> .xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_selectAddSubqueryTypeInfo_enum];
@transform_xSelectCallback2_selectAddSubqueryTypeInfo@
expression E;
identifier FP_NAME = xSelectCallback2;
identifier FUNC_NAME = selectAddSubqueryTypeInfo;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_selectAddSubqueryTypeInfo_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_selectAddSubqueryTypeInfo_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_selectAddSubqueryTypeInfo_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_selectAddSubqueryTypeInfo_enum];
)

// Rule: .xSelectCallback2 = selectRefLeave ==> .xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_selectRefLeave_enum];
@transform_xSelectCallback2_selectRefLeave@
expression E;
identifier FP_NAME = xSelectCallback2;
identifier FUNC_NAME = selectRefLeave;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_selectRefLeave_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_selectRefLeave_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_selectRefLeave_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_selectRefLeave_enum];
)

// Rule: .xSelectCallback2 = sqlite3SelectPopWith ==> .xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectPopWith_enum];
@transform_xSelectCallback2_sqlite3SelectPopWith@
expression E;
identifier FP_NAME = xSelectCallback2;
identifier FUNC_NAME = sqlite3SelectPopWith;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectPopWith_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectPopWith_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectPopWith_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectPopWith_enum];
)

// Rule: .xSelectCallback2 = sqlite3WalkWinDefnDummyCallback ==> .xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkWinDefnDummyCallback_enum];
@transform_xSelectCallback2_sqlite3WalkWinDefnDummyCallback@
expression E;
identifier FP_NAME = xSelectCallback2;
identifier FUNC_NAME = sqlite3WalkWinDefnDummyCallback;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkWinDefnDummyCallback_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkWinDefnDummyCallback_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkWinDefnDummyCallback_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkWinDefnDummyCallback_enum];
)

// Rule: .xSelectCallback2 = sqlite3WalkerDepthDecrease ==> .xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkerDepthDecrease_enum];
@transform_xSelectCallback2_sqlite3WalkerDepthDecrease@
expression E;
identifier FP_NAME = xSelectCallback2;
identifier FUNC_NAME = sqlite3WalkerDepthDecrease;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkerDepthDecrease_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkerDepthDecrease_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkerDepthDecrease_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSelectCallback2_signature = xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkerDepthDecrease_enum];
)

// Rules for xSetSystemCall (6 valid functions, 2 excluded)
// Rule: .xSetSystemCall = 0 ==> .xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_0_enum];
@transform_xSetSystemCall_0@
expression E;
identifier FP_NAME = xSetSystemCall;
@@
(
E.FP_NAME = 0;
+ E.xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_0_enum];
|
E->FP_NAME = 0;
+ E->xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_0_enum];
)

// Rule: .xSetSystemCall = apndSetSystemCall ==> .xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_apndSetSystemCall_enum];
@transform_xSetSystemCall_apndSetSystemCall@
expression E;
identifier FP_NAME = xSetSystemCall;
identifier FUNC_NAME = apndSetSystemCall;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_apndSetSystemCall_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_apndSetSystemCall_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_apndSetSystemCall_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_apndSetSystemCall_enum];
)

// Rule: .xSetSystemCall = devsymSleep ==> .xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_devsymSleep_enum];
@transform_xSetSystemCall_devsymSleep@
expression E;
identifier FP_NAME = xSetSystemCall;
identifier FUNC_NAME = devsymSleep;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_devsymSleep_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_devsymSleep_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_devsymSleep_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_devsymSleep_enum];
)

// Rule: .xSetSystemCall = rbuVfsSleep ==> .xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_rbuVfsSleep_enum];
@transform_xSetSystemCall_rbuVfsSleep@
expression E;
identifier FP_NAME = xSetSystemCall;
identifier FUNC_NAME = rbuVfsSleep;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_rbuVfsSleep_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_rbuVfsSleep_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_rbuVfsSleep_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_rbuVfsSleep_enum];
)

// Rule: .xSetSystemCall = tvfsSleep ==> .xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_tvfsSleep_enum];
@transform_xSetSystemCall_tvfsSleep@
expression E;
identifier FP_NAME = xSetSystemCall;
identifier FUNC_NAME = tvfsSleep;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_tvfsSleep_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_tvfsSleep_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_tvfsSleep_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_tvfsSleep_enum];
)

// Rule: .xSetSystemCall = unixSetSystemCall ==> .xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_unixSetSystemCall_enum];
@transform_xSetSystemCall_unixSetSystemCall@
expression E;
identifier FP_NAME = xSetSystemCall;
identifier FUNC_NAME = unixSetSystemCall;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_unixSetSystemCall_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_unixSetSystemCall_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_unixSetSystemCall_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_unixSetSystemCall_enum];
)

// Rules for xShadowName (3 valid functions, 2 excluded)
// Rule: .xShadowName = 0 ==> .xShadowName_signature = xShadowName_signatures[xShadowName_0_enum];
@transform_xShadowName_0@
expression E;
identifier FP_NAME = xShadowName;
@@
(
E.FP_NAME = 0;
+ E.xShadowName_signature = xShadowName_signatures[xShadowName_0_enum];
|
E->FP_NAME = 0;
+ E->xShadowName_signature = xShadowName_signatures[xShadowName_0_enum];
)

// Rule: .xShadowName = fts3ShadowName ==> .xShadowName_signature = xShadowName_signatures[xShadowName_fts3ShadowName_enum];
@transform_xShadowName_fts3ShadowName@
expression E;
identifier FP_NAME = xShadowName;
identifier FUNC_NAME = fts3ShadowName;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xShadowName_signature = xShadowName_signatures[xShadowName_fts3ShadowName_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xShadowName_signature = xShadowName_signatures[xShadowName_fts3ShadowName_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xShadowName_signature = xShadowName_signatures[xShadowName_fts3ShadowName_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xShadowName_signature = xShadowName_signatures[xShadowName_fts3ShadowName_enum];
)

// Rule: .xShadowName = rtreeShadowName ==> .xShadowName_signature = xShadowName_signatures[xShadowName_rtreeShadowName_enum];
@transform_xShadowName_rtreeShadowName@
expression E;
identifier FP_NAME = xShadowName;
identifier FUNC_NAME = rtreeShadowName;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xShadowName_signature = xShadowName_signatures[xShadowName_rtreeShadowName_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xShadowName_signature = xShadowName_signatures[xShadowName_rtreeShadowName_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xShadowName_signature = xShadowName_signatures[xShadowName_rtreeShadowName_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xShadowName_signature = xShadowName_signatures[xShadowName_rtreeShadowName_enum];
)

// Rules for xShmBarrier (4 valid functions, 11 excluded)
// Rule: .xShmBarrier = 0 ==> .xShmBarrier_signature = xShmBarrier_signatures[xShmBarrier_0_enum];
@transform_xShmBarrier_0@
expression E;
identifier FP_NAME = xShmBarrier;
@@
(
E.FP_NAME = 0;
+ E.xShmBarrier_signature = xShmBarrier_signatures[xShmBarrier_0_enum];
|
E->FP_NAME = 0;
+ E->xShmBarrier_signature = xShmBarrier_signatures[xShmBarrier_0_enum];
)

// Rule: .xShmBarrier = apndShmBarrier ==> .xShmBarrier_signature = xShmBarrier_signatures[xShmBarrier_apndShmBarrier_enum];
@transform_xShmBarrier_apndShmBarrier@
expression E;
identifier FP_NAME = xShmBarrier;
identifier FUNC_NAME = apndShmBarrier;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xShmBarrier_signature = xShmBarrier_signatures[xShmBarrier_apndShmBarrier_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xShmBarrier_signature = xShmBarrier_signatures[xShmBarrier_apndShmBarrier_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xShmBarrier_signature = xShmBarrier_signatures[xShmBarrier_apndShmBarrier_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xShmBarrier_signature = xShmBarrier_signatures[xShmBarrier_apndShmBarrier_enum];
)

// Rule: .xShmBarrier = recoverVfsShmBarrier ==> .xShmBarrier_signature = xShmBarrier_signatures[xShmBarrier_recoverVfsShmBarrier_enum];
@transform_xShmBarrier_recoverVfsShmBarrier@
expression E;
identifier FP_NAME = xShmBarrier;
identifier FUNC_NAME = recoverVfsShmBarrier;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xShmBarrier_signature = xShmBarrier_signatures[xShmBarrier_recoverVfsShmBarrier_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xShmBarrier_signature = xShmBarrier_signatures[xShmBarrier_recoverVfsShmBarrier_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xShmBarrier_signature = xShmBarrier_signatures[xShmBarrier_recoverVfsShmBarrier_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xShmBarrier_signature = xShmBarrier_signatures[xShmBarrier_recoverVfsShmBarrier_enum];
)

// Rule: .xShmBarrier = unixShmBarrier ==> .xShmBarrier_signature = xShmBarrier_signatures[xShmBarrier_unixShmBarrier_enum];
@transform_xShmBarrier_unixShmBarrier@
expression E;
identifier FP_NAME = xShmBarrier;
identifier FUNC_NAME = unixShmBarrier;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xShmBarrier_signature = xShmBarrier_signatures[xShmBarrier_unixShmBarrier_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xShmBarrier_signature = xShmBarrier_signatures[xShmBarrier_unixShmBarrier_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xShmBarrier_signature = xShmBarrier_signatures[xShmBarrier_unixShmBarrier_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xShmBarrier_signature = xShmBarrier_signatures[xShmBarrier_unixShmBarrier_enum];
)

// Rules for xShmLock (4 valid functions, 11 excluded)
// Rule: .xShmLock = 0 ==> .xShmLock_signature = xShmLock_signatures[xShmLock_0_enum];
@transform_xShmLock_0@
expression E;
identifier FP_NAME = xShmLock;
@@
(
E.FP_NAME = 0;
+ E.xShmLock_signature = xShmLock_signatures[xShmLock_0_enum];
|
E->FP_NAME = 0;
+ E->xShmLock_signature = xShmLock_signatures[xShmLock_0_enum];
)

// Rule: .xShmLock = apndShmLock ==> .xShmLock_signature = xShmLock_signatures[xShmLock_apndShmLock_enum];
@transform_xShmLock_apndShmLock@
expression E;
identifier FP_NAME = xShmLock;
identifier FUNC_NAME = apndShmLock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xShmLock_signature = xShmLock_signatures[xShmLock_apndShmLock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xShmLock_signature = xShmLock_signatures[xShmLock_apndShmLock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xShmLock_signature = xShmLock_signatures[xShmLock_apndShmLock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xShmLock_signature = xShmLock_signatures[xShmLock_apndShmLock_enum];
)

// Rule: .xShmLock = recoverVfsShmLock ==> .xShmLock_signature = xShmLock_signatures[xShmLock_recoverVfsShmLock_enum];
@transform_xShmLock_recoverVfsShmLock@
expression E;
identifier FP_NAME = xShmLock;
identifier FUNC_NAME = recoverVfsShmLock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xShmLock_signature = xShmLock_signatures[xShmLock_recoverVfsShmLock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xShmLock_signature = xShmLock_signatures[xShmLock_recoverVfsShmLock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xShmLock_signature = xShmLock_signatures[xShmLock_recoverVfsShmLock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xShmLock_signature = xShmLock_signatures[xShmLock_recoverVfsShmLock_enum];
)

// Rule: .xShmLock = unixShmLock ==> .xShmLock_signature = xShmLock_signatures[xShmLock_unixShmLock_enum];
@transform_xShmLock_unixShmLock@
expression E;
identifier FP_NAME = xShmLock;
identifier FUNC_NAME = unixShmLock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xShmLock_signature = xShmLock_signatures[xShmLock_unixShmLock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xShmLock_signature = xShmLock_signatures[xShmLock_unixShmLock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xShmLock_signature = xShmLock_signatures[xShmLock_unixShmLock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xShmLock_signature = xShmLock_signatures[xShmLock_unixShmLock_enum];
)

// Rules for xShmMap (4 valid functions, 11 excluded)
// Rule: .xShmMap = 0 ==> .xShmMap_signature = xShmMap_signatures[xShmMap_0_enum];
@transform_xShmMap_0@
expression E;
identifier FP_NAME = xShmMap;
@@
(
E.FP_NAME = 0;
+ E.xShmMap_signature = xShmMap_signatures[xShmMap_0_enum];
|
E->FP_NAME = 0;
+ E->xShmMap_signature = xShmMap_signatures[xShmMap_0_enum];
)

// Rule: .xShmMap = apndShmMap ==> .xShmMap_signature = xShmMap_signatures[xShmMap_apndShmMap_enum];
@transform_xShmMap_apndShmMap@
expression E;
identifier FP_NAME = xShmMap;
identifier FUNC_NAME = apndShmMap;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xShmMap_signature = xShmMap_signatures[xShmMap_apndShmMap_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xShmMap_signature = xShmMap_signatures[xShmMap_apndShmMap_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xShmMap_signature = xShmMap_signatures[xShmMap_apndShmMap_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xShmMap_signature = xShmMap_signatures[xShmMap_apndShmMap_enum];
)

// Rule: .xShmMap = recoverVfsShmMap ==> .xShmMap_signature = xShmMap_signatures[xShmMap_recoverVfsShmMap_enum];
@transform_xShmMap_recoverVfsShmMap@
expression E;
identifier FP_NAME = xShmMap;
identifier FUNC_NAME = recoverVfsShmMap;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xShmMap_signature = xShmMap_signatures[xShmMap_recoverVfsShmMap_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xShmMap_signature = xShmMap_signatures[xShmMap_recoverVfsShmMap_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xShmMap_signature = xShmMap_signatures[xShmMap_recoverVfsShmMap_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xShmMap_signature = xShmMap_signatures[xShmMap_recoverVfsShmMap_enum];
)

// Rule: .xShmMap = unixShmMap ==> .xShmMap_signature = xShmMap_signatures[xShmMap_unixShmMap_enum];
@transform_xShmMap_unixShmMap@
expression E;
identifier FP_NAME = xShmMap;
identifier FUNC_NAME = unixShmMap;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xShmMap_signature = xShmMap_signatures[xShmMap_unixShmMap_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xShmMap_signature = xShmMap_signatures[xShmMap_unixShmMap_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xShmMap_signature = xShmMap_signatures[xShmMap_unixShmMap_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xShmMap_signature = xShmMap_signatures[xShmMap_unixShmMap_enum];
)

// Rules for xShmUnmap (4 valid functions, 11 excluded)
// Rule: .xShmUnmap = 0 ==> .xShmUnmap_signature = xShmUnmap_signatures[xShmUnmap_0_enum];
@transform_xShmUnmap_0@
expression E;
identifier FP_NAME = xShmUnmap;
@@
(
E.FP_NAME = 0;
+ E.xShmUnmap_signature = xShmUnmap_signatures[xShmUnmap_0_enum];
|
E->FP_NAME = 0;
+ E->xShmUnmap_signature = xShmUnmap_signatures[xShmUnmap_0_enum];
)

// Rule: .xShmUnmap = apndShmUnmap ==> .xShmUnmap_signature = xShmUnmap_signatures[xShmUnmap_apndShmUnmap_enum];
@transform_xShmUnmap_apndShmUnmap@
expression E;
identifier FP_NAME = xShmUnmap;
identifier FUNC_NAME = apndShmUnmap;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xShmUnmap_signature = xShmUnmap_signatures[xShmUnmap_apndShmUnmap_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xShmUnmap_signature = xShmUnmap_signatures[xShmUnmap_apndShmUnmap_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xShmUnmap_signature = xShmUnmap_signatures[xShmUnmap_apndShmUnmap_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xShmUnmap_signature = xShmUnmap_signatures[xShmUnmap_apndShmUnmap_enum];
)

// Rule: .xShmUnmap = recoverVfsShmUnmap ==> .xShmUnmap_signature = xShmUnmap_signatures[xShmUnmap_recoverVfsShmUnmap_enum];
@transform_xShmUnmap_recoverVfsShmUnmap@
expression E;
identifier FP_NAME = xShmUnmap;
identifier FUNC_NAME = recoverVfsShmUnmap;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xShmUnmap_signature = xShmUnmap_signatures[xShmUnmap_recoverVfsShmUnmap_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xShmUnmap_signature = xShmUnmap_signatures[xShmUnmap_recoverVfsShmUnmap_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xShmUnmap_signature = xShmUnmap_signatures[xShmUnmap_recoverVfsShmUnmap_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xShmUnmap_signature = xShmUnmap_signatures[xShmUnmap_recoverVfsShmUnmap_enum];
)

// Rule: .xShmUnmap = unixShmUnmap ==> .xShmUnmap_signature = xShmUnmap_signatures[xShmUnmap_unixShmUnmap_enum];
@transform_xShmUnmap_unixShmUnmap@
expression E;
identifier FP_NAME = xShmUnmap;
identifier FUNC_NAME = unixShmUnmap;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xShmUnmap_signature = xShmUnmap_signatures[xShmUnmap_unixShmUnmap_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xShmUnmap_signature = xShmUnmap_signatures[xShmUnmap_unixShmUnmap_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xShmUnmap_signature = xShmUnmap_signatures[xShmUnmap_unixShmUnmap_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xShmUnmap_signature = xShmUnmap_signatures[xShmUnmap_unixShmUnmap_enum];
)

// Rules for xShrink (2 valid functions, 0 excluded)
// Rule: .xShrink = pcache1Shrink ==> .xShrink_signature = xShrink_signatures[xShrink_pcache1Shrink_enum];
@transform_xShrink_pcache1Shrink@
expression E;
identifier FP_NAME = xShrink;
identifier FUNC_NAME = pcache1Shrink;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xShrink_signature = xShrink_signatures[xShrink_pcache1Shrink_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xShrink_signature = xShrink_signatures[xShrink_pcache1Shrink_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xShrink_signature = xShrink_signatures[xShrink_pcache1Shrink_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xShrink_signature = xShrink_signatures[xShrink_pcache1Shrink_enum];
)

// Rule: .xShrink = pcachetraceShrink ==> .xShrink_signature = xShrink_signatures[xShrink_pcachetraceShrink_enum];
@transform_xShrink_pcachetraceShrink@
expression E;
identifier FP_NAME = xShrink;
identifier FUNC_NAME = pcachetraceShrink;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xShrink_signature = xShrink_signatures[xShrink_pcachetraceShrink_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xShrink_signature = xShrink_signatures[xShrink_pcachetraceShrink_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xShrink_signature = xShrink_signatures[xShrink_pcachetraceShrink_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xShrink_signature = xShrink_signatures[xShrink_pcachetraceShrink_enum];
)

// Rules for xShutdown (4 valid functions, 6 excluded)
// Rule: .xShutdown = memtraceShutdown ==> .xShutdown_signature = xShutdown_signatures[xShutdown_memtraceShutdown_enum];
@transform_xShutdown_memtraceShutdown@
expression E;
identifier FP_NAME = xShutdown;
identifier FUNC_NAME = memtraceShutdown;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xShutdown_signature = xShutdown_signatures[xShutdown_memtraceShutdown_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xShutdown_signature = xShutdown_signatures[xShutdown_memtraceShutdown_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xShutdown_signature = xShutdown_signatures[xShutdown_memtraceShutdown_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xShutdown_signature = xShutdown_signatures[xShutdown_memtraceShutdown_enum];
)

// Rule: .xShutdown = pcache1Shutdown ==> .xShutdown_signature = xShutdown_signatures[xShutdown_pcache1Shutdown_enum];
@transform_xShutdown_pcache1Shutdown@
expression E;
identifier FP_NAME = xShutdown;
identifier FUNC_NAME = pcache1Shutdown;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xShutdown_signature = xShutdown_signatures[xShutdown_pcache1Shutdown_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xShutdown_signature = xShutdown_signatures[xShutdown_pcache1Shutdown_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xShutdown_signature = xShutdown_signatures[xShutdown_pcache1Shutdown_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xShutdown_signature = xShutdown_signatures[xShutdown_pcache1Shutdown_enum];
)

// Rule: .xShutdown = pcachetraceShutdown ==> .xShutdown_signature = xShutdown_signatures[xShutdown_pcachetraceShutdown_enum];
@transform_xShutdown_pcachetraceShutdown@
expression E;
identifier FP_NAME = xShutdown;
identifier FUNC_NAME = pcachetraceShutdown;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xShutdown_signature = xShutdown_signatures[xShutdown_pcachetraceShutdown_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xShutdown_signature = xShutdown_signatures[xShutdown_pcachetraceShutdown_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xShutdown_signature = xShutdown_signatures[xShutdown_pcachetraceShutdown_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xShutdown_signature = xShutdown_signatures[xShutdown_pcachetraceShutdown_enum];
)

// Rule: .xShutdown = sqlite3MemShutdown ==> .xShutdown_signature = xShutdown_signatures[xShutdown_sqlite3MemShutdown_enum];
@transform_xShutdown_sqlite3MemShutdown@
expression E;
identifier FP_NAME = xShutdown;
identifier FUNC_NAME = sqlite3MemShutdown;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xShutdown_signature = xShutdown_signatures[xShutdown_sqlite3MemShutdown_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xShutdown_signature = xShutdown_signatures[xShutdown_sqlite3MemShutdown_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xShutdown_signature = xShutdown_signatures[xShutdown_sqlite3MemShutdown_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xShutdown_signature = xShutdown_signatures[xShutdown_sqlite3MemShutdown_enum];
)

// Rules for xSize (2 valid functions, 4 excluded)
// Rule: .xSize = memtraceSize ==> .xSize_signature = xSize_signatures[xSize_memtraceSize_enum];
@transform_xSize_memtraceSize@
expression E;
identifier FP_NAME = xSize;
identifier FUNC_NAME = memtraceSize;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSize_signature = xSize_signatures[xSize_memtraceSize_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSize_signature = xSize_signatures[xSize_memtraceSize_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSize_signature = xSize_signatures[xSize_memtraceSize_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSize_signature = xSize_signatures[xSize_memtraceSize_enum];
)

// Rule: .xSize = sqlite3MemSize ==> .xSize_signature = xSize_signatures[xSize_sqlite3MemSize_enum];
@transform_xSize_sqlite3MemSize@
expression E;
identifier FP_NAME = xSize;
identifier FUNC_NAME = sqlite3MemSize;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSize_signature = xSize_signatures[xSize_sqlite3MemSize_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSize_signature = xSize_signatures[xSize_sqlite3MemSize_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSize_signature = xSize_signatures[xSize_sqlite3MemSize_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSize_signature = xSize_signatures[xSize_sqlite3MemSize_enum];
)

// Rules for xSleep (5 valid functions, 9 excluded)
// Rule: .xSleep = 0 ==> .xSleep_signature = xSleep_signatures[xSleep_0_enum];
@transform_xSleep_0@
expression E;
identifier FP_NAME = xSleep;
@@
(
E.FP_NAME = 0;
+ E.xSleep_signature = xSleep_signatures[xSleep_0_enum];
|
E->FP_NAME = 0;
+ E->xSleep_signature = xSleep_signatures[xSleep_0_enum];
)

// Rule: .xSleep = apndSleep ==> .xSleep_signature = xSleep_signatures[xSleep_apndSleep_enum];
@transform_xSleep_apndSleep@
expression E;
identifier FP_NAME = xSleep;
identifier FUNC_NAME = apndSleep;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSleep_signature = xSleep_signatures[xSleep_apndSleep_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSleep_signature = xSleep_signatures[xSleep_apndSleep_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSleep_signature = xSleep_signatures[xSleep_apndSleep_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSleep_signature = xSleep_signatures[xSleep_apndSleep_enum];
)

// Rule: .xSleep = memdbSleep ==> .xSleep_signature = xSleep_signatures[xSleep_memdbSleep_enum];
@transform_xSleep_memdbSleep@
expression E;
identifier FP_NAME = xSleep;
identifier FUNC_NAME = memdbSleep;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSleep_signature = xSleep_signatures[xSleep_memdbSleep_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSleep_signature = xSleep_signatures[xSleep_memdbSleep_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSleep_signature = xSleep_signatures[xSleep_memdbSleep_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSleep_signature = xSleep_signatures[xSleep_memdbSleep_enum];
)

// Rule: .xSleep = vfstraceSleep ==> .xSleep_signature = xSleep_signatures[xSleep_vfstraceSleep_enum];
@transform_xSleep_vfstraceSleep@
expression E;
identifier FP_NAME = xSleep;
identifier FUNC_NAME = vfstraceSleep;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSleep_signature = xSleep_signatures[xSleep_vfstraceSleep_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSleep_signature = xSleep_signatures[xSleep_vfstraceSleep_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSleep_signature = xSleep_signatures[xSleep_vfstraceSleep_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSleep_signature = xSleep_signatures[xSleep_vfstraceSleep_enum];
)

// Rule: .xSleep = unixSleep ==> .xSleep_signature = xSleep_signatures[xSleep_unixSleep_enum];
@transform_xSleep_unixSleep@
expression E;
identifier FP_NAME = xSleep;
identifier FUNC_NAME = unixSleep;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSleep_signature = xSleep_signatures[xSleep_unixSleep_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSleep_signature = xSleep_signatures[xSleep_unixSleep_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSleep_signature = xSleep_signatures[xSleep_unixSleep_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSleep_signature = xSleep_signatures[xSleep_unixSleep_enum];
)

// Rules for xSync (12 valid functions, 19 excluded)
// Rule: .xSync = 0 ==> .xSync_signature = xSync_signatures[xSync_0_enum];
@transform_xSync_0@
expression E;
identifier FP_NAME = xSync;
@@
(
E.FP_NAME = 0;
+ E.xSync_signature = xSync_signatures[xSync_0_enum];
|
E->FP_NAME = 0;
+ E->xSync_signature = xSync_signatures[xSync_0_enum];
)

// Rule: .xSync = apndSync ==> .xSync_signature = xSync_signatures[xSync_apndSync_enum];
@transform_xSync_apndSync@
expression E;
identifier FP_NAME = xSync;
identifier FUNC_NAME = apndSync;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSync_signature = xSync_signatures[xSync_apndSync_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSync_signature = xSync_signatures[xSync_apndSync_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSync_signature = xSync_signatures[xSync_apndSync_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSync_signature = xSync_signatures[xSync_apndSync_enum];
)

// Rule: .xSync = dbpageSync ==> .xSync_signature = xSync_signatures[xSync_dbpageSync_enum];
@transform_xSync_dbpageSync@
expression E;
identifier FP_NAME = xSync;
identifier FUNC_NAME = dbpageSync;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSync_signature = xSync_signatures[xSync_dbpageSync_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSync_signature = xSync_signatures[xSync_dbpageSync_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSync_signature = xSync_signatures[xSync_dbpageSync_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSync_signature = xSync_signatures[xSync_dbpageSync_enum];
)

// Rule: .xSync = echoSync ==> .xSync_signature = xSync_signatures[xSync_echoSync_enum];
@transform_xSync_echoSync@
expression E;
identifier FP_NAME = xSync;
identifier FUNC_NAME = echoSync;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSync_signature = xSync_signatures[xSync_echoSync_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSync_signature = xSync_signatures[xSync_echoSync_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSync_signature = xSync_signatures[xSync_echoSync_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSync_signature = xSync_signatures[xSync_echoSync_enum];
)

// Rule: .xSync = fts3SyncMethod ==> .xSync_signature = xSync_signatures[xSync_fts3SyncMethod_enum];
@transform_xSync_fts3SyncMethod@
expression E;
identifier FP_NAME = xSync;
identifier FUNC_NAME = fts3SyncMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSync_signature = xSync_signatures[xSync_fts3SyncMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSync_signature = xSync_signatures[xSync_fts3SyncMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSync_signature = xSync_signatures[xSync_fts3SyncMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSync_signature = xSync_signatures[xSync_fts3SyncMethod_enum];
)

// Rule: .xSync = memdbSync ==> .xSync_signature = xSync_signatures[xSync_memdbSync_enum];
@transform_xSync_memdbSync@
expression E;
identifier FP_NAME = xSync;
identifier FUNC_NAME = memdbSync;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSync_signature = xSync_signatures[xSync_memdbSync_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSync_signature = xSync_signatures[xSync_memdbSync_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSync_signature = xSync_signatures[xSync_memdbSync_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSync_signature = xSync_signatures[xSync_memdbSync_enum];
)

// Rule: .xSync = memjrnlSync ==> .xSync_signature = xSync_signatures[xSync_memjrnlSync_enum];
@transform_xSync_memjrnlSync@
expression E;
identifier FP_NAME = xSync;
identifier FUNC_NAME = memjrnlSync;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSync_signature = xSync_signatures[xSync_memjrnlSync_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSync_signature = xSync_signatures[xSync_memjrnlSync_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSync_signature = xSync_signatures[xSync_memjrnlSync_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSync_signature = xSync_signatures[xSync_memjrnlSync_enum];
)

// Rule: .xSync = recoverVfsSync ==> .xSync_signature = xSync_signatures[xSync_recoverVfsSync_enum];
@transform_xSync_recoverVfsSync@
expression E;
identifier FP_NAME = xSync;
identifier FUNC_NAME = recoverVfsSync;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSync_signature = xSync_signatures[xSync_recoverVfsSync_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSync_signature = xSync_signatures[xSync_recoverVfsSync_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSync_signature = xSync_signatures[xSync_recoverVfsSync_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSync_signature = xSync_signatures[xSync_recoverVfsSync_enum];
)

// Rule: .xSync = rtreeEndTransaction ==> .xSync_signature = xSync_signatures[xSync_rtreeEndTransaction_enum];
@transform_xSync_rtreeEndTransaction@
expression E;
identifier FP_NAME = xSync;
identifier FUNC_NAME = rtreeEndTransaction;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSync_signature = xSync_signatures[xSync_rtreeEndTransaction_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSync_signature = xSync_signatures[xSync_rtreeEndTransaction_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSync_signature = xSync_signatures[xSync_rtreeEndTransaction_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSync_signature = xSync_signatures[xSync_rtreeEndTransaction_enum];
)

// Rule: .xSync = vfstraceSync ==> .xSync_signature = xSync_signatures[xSync_vfstraceSync_enum];
@transform_xSync_vfstraceSync@
expression E;
identifier FP_NAME = xSync;
identifier FUNC_NAME = vfstraceSync;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSync_signature = xSync_signatures[xSync_vfstraceSync_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSync_signature = xSync_signatures[xSync_vfstraceSync_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSync_signature = xSync_signatures[xSync_vfstraceSync_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSync_signature = xSync_signatures[xSync_vfstraceSync_enum];
)

// Rule: .xSync = vtablogSync ==> .xSync_signature = xSync_signatures[xSync_vtablogSync_enum];
@transform_xSync_vtablogSync@
expression E;
identifier FP_NAME = xSync;
identifier FUNC_NAME = vtablogSync;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSync_signature = xSync_signatures[xSync_vtablogSync_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSync_signature = xSync_signatures[xSync_vtablogSync_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSync_signature = xSync_signatures[xSync_vtablogSync_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSync_signature = xSync_signatures[xSync_vtablogSync_enum];
)

// Rule: .xSync = unixSync ==> .xSync_signature = xSync_signatures[xSync_unixSync_enum];
@transform_xSync_unixSync@
expression E;
identifier FP_NAME = xSync;
identifier FUNC_NAME = unixSync;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xSync_signature = xSync_signatures[xSync_unixSync_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xSync_signature = xSync_signatures[xSync_unixSync_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xSync_signature = xSync_signatures[xSync_unixSync_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xSync_signature = xSync_signatures[xSync_unixSync_enum];
)

// Rules for xTokenize (4 valid functions, 4 excluded)
// Rule: .xTokenize = 0 ==> .xTokenize_signature = xTokenize_signatures[xTokenize_0_enum];
@transform_xTokenize_0@
expression E;
identifier FP_NAME = xTokenize;
@@
(
E.FP_NAME = 0;
+ E.xTokenize_signature = xTokenize_signatures[xTokenize_0_enum];
|
E->FP_NAME = 0;
+ E->xTokenize_signature = xTokenize_signatures[xTokenize_0_enum];
)

// Rule: .xTokenize = f5tOrigintextTokenize ==> .xTokenize_signature = xTokenize_signatures[xTokenize_f5tOrigintextTokenize_enum];
@transform_xTokenize_f5tOrigintextTokenize@
expression E;
identifier FP_NAME = xTokenize;
identifier FUNC_NAME = f5tOrigintextTokenize;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xTokenize_signature = xTokenize_signatures[xTokenize_f5tOrigintextTokenize_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xTokenize_signature = xTokenize_signatures[xTokenize_f5tOrigintextTokenize_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xTokenize_signature = xTokenize_signatures[xTokenize_f5tOrigintextTokenize_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xTokenize_signature = xTokenize_signatures[xTokenize_f5tOrigintextTokenize_enum];
)

// Rule: .xTokenize = f5tTokenizerTokenize ==> .xTokenize_signature = xTokenize_signatures[xTokenize_f5tTokenizerTokenize_enum];
@transform_xTokenize_f5tTokenizerTokenize@
expression E;
identifier FP_NAME = xTokenize;
identifier FUNC_NAME = f5tTokenizerTokenize;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xTokenize_signature = xTokenize_signatures[xTokenize_f5tTokenizerTokenize_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xTokenize_signature = xTokenize_signatures[xTokenize_f5tTokenizerTokenize_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xTokenize_signature = xTokenize_signatures[xTokenize_f5tTokenizerTokenize_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xTokenize_signature = xTokenize_signatures[xTokenize_f5tTokenizerTokenize_enum];
)

// Rule: .xTokenize = f5tTokenizerTokenize_v2 ==> .xTokenize_signature = xTokenize_signatures[xTokenize_f5tTokenizerTokenize_v2_enum];
@transform_xTokenize_f5tTokenizerTokenize_v2@
expression E;
identifier FP_NAME = xTokenize;
identifier FUNC_NAME = f5tTokenizerTokenize_v2;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xTokenize_signature = xTokenize_signatures[xTokenize_f5tTokenizerTokenize_v2_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xTokenize_signature = xTokenize_signatures[xTokenize_f5tTokenizerTokenize_v2_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xTokenize_signature = xTokenize_signatures[xTokenize_f5tTokenizerTokenize_v2_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xTokenize_signature = xTokenize_signatures[xTokenize_f5tTokenizerTokenize_v2_enum];
)

// Rules for xTruncate (8 valid functions, 20 excluded)
// Rule: .xTruncate = apndTruncate ==> .xTruncate_signature = xTruncate_signatures[xTruncate_apndTruncate_enum];
@transform_xTruncate_apndTruncate@
expression E;
identifier FP_NAME = xTruncate;
identifier FUNC_NAME = apndTruncate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xTruncate_signature = xTruncate_signatures[xTruncate_apndTruncate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xTruncate_signature = xTruncate_signatures[xTruncate_apndTruncate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xTruncate_signature = xTruncate_signatures[xTruncate_apndTruncate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xTruncate_signature = xTruncate_signatures[xTruncate_apndTruncate_enum];
)

// Rule: .xTruncate = memdbTruncate ==> .xTruncate_signature = xTruncate_signatures[xTruncate_memdbTruncate_enum];
@transform_xTruncate_memdbTruncate@
expression E;
identifier FP_NAME = xTruncate;
identifier FUNC_NAME = memdbTruncate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xTruncate_signature = xTruncate_signatures[xTruncate_memdbTruncate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xTruncate_signature = xTruncate_signatures[xTruncate_memdbTruncate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xTruncate_signature = xTruncate_signatures[xTruncate_memdbTruncate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xTruncate_signature = xTruncate_signatures[xTruncate_memdbTruncate_enum];
)

// Rule: .xTruncate = memjrnlTruncate ==> .xTruncate_signature = xTruncate_signatures[xTruncate_memjrnlTruncate_enum];
@transform_xTruncate_memjrnlTruncate@
expression E;
identifier FP_NAME = xTruncate;
identifier FUNC_NAME = memjrnlTruncate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xTruncate_signature = xTruncate_signatures[xTruncate_memjrnlTruncate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xTruncate_signature = xTruncate_signatures[xTruncate_memjrnlTruncate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xTruncate_signature = xTruncate_signatures[xTruncate_memjrnlTruncate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xTruncate_signature = xTruncate_signatures[xTruncate_memjrnlTruncate_enum];
)

// Rule: .xTruncate = pcache1Truncate ==> .xTruncate_signature = xTruncate_signatures[xTruncate_pcache1Truncate_enum];
@transform_xTruncate_pcache1Truncate@
expression E;
identifier FP_NAME = xTruncate;
identifier FUNC_NAME = pcache1Truncate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xTruncate_signature = xTruncate_signatures[xTruncate_pcache1Truncate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xTruncate_signature = xTruncate_signatures[xTruncate_pcache1Truncate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xTruncate_signature = xTruncate_signatures[xTruncate_pcache1Truncate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xTruncate_signature = xTruncate_signatures[xTruncate_pcache1Truncate_enum];
)

// Rule: .xTruncate = pcachetraceTruncate ==> .xTruncate_signature = xTruncate_signatures[xTruncate_pcachetraceTruncate_enum];
@transform_xTruncate_pcachetraceTruncate@
expression E;
identifier FP_NAME = xTruncate;
identifier FUNC_NAME = pcachetraceTruncate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xTruncate_signature = xTruncate_signatures[xTruncate_pcachetraceTruncate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xTruncate_signature = xTruncate_signatures[xTruncate_pcachetraceTruncate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xTruncate_signature = xTruncate_signatures[xTruncate_pcachetraceTruncate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xTruncate_signature = xTruncate_signatures[xTruncate_pcachetraceTruncate_enum];
)

// Rule: .xTruncate = recoverVfsTruncate ==> .xTruncate_signature = xTruncate_signatures[xTruncate_recoverVfsTruncate_enum];
@transform_xTruncate_recoverVfsTruncate@
expression E;
identifier FP_NAME = xTruncate;
identifier FUNC_NAME = recoverVfsTruncate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xTruncate_signature = xTruncate_signatures[xTruncate_recoverVfsTruncate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xTruncate_signature = xTruncate_signatures[xTruncate_recoverVfsTruncate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xTruncate_signature = xTruncate_signatures[xTruncate_recoverVfsTruncate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xTruncate_signature = xTruncate_signatures[xTruncate_recoverVfsTruncate_enum];
)

// Rule: .xTruncate = vfstraceTruncate ==> .xTruncate_signature = xTruncate_signatures[xTruncate_vfstraceTruncate_enum];
@transform_xTruncate_vfstraceTruncate@
expression E;
identifier FP_NAME = xTruncate;
identifier FUNC_NAME = vfstraceTruncate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xTruncate_signature = xTruncate_signatures[xTruncate_vfstraceTruncate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xTruncate_signature = xTruncate_signatures[xTruncate_vfstraceTruncate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xTruncate_signature = xTruncate_signatures[xTruncate_vfstraceTruncate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xTruncate_signature = xTruncate_signatures[xTruncate_vfstraceTruncate_enum];
)

// Rule: .xTruncate = unixTruncate ==> .xTruncate_signature = xTruncate_signatures[xTruncate_unixTruncate_enum];
@transform_xTruncate_unixTruncate@
expression E;
identifier FP_NAME = xTruncate;
identifier FUNC_NAME = unixTruncate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xTruncate_signature = xTruncate_signatures[xTruncate_unixTruncate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xTruncate_signature = xTruncate_signatures[xTruncate_unixTruncate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xTruncate_signature = xTruncate_signatures[xTruncate_unixTruncate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xTruncate_signature = xTruncate_signatures[xTruncate_unixTruncate_enum];
)

// Rules for xUnfetch (5 valid functions, 5 excluded)
// Rule: .xUnfetch = 0 ==> .xUnfetch_signature = xUnfetch_signatures[xUnfetch_0_enum];
@transform_xUnfetch_0@
expression E;
identifier FP_NAME = xUnfetch;
@@
(
E.FP_NAME = 0;
+ E.xUnfetch_signature = xUnfetch_signatures[xUnfetch_0_enum];
|
E->FP_NAME = 0;
+ E->xUnfetch_signature = xUnfetch_signatures[xUnfetch_0_enum];
)

// Rule: .xUnfetch = apndUnfetch ==> .xUnfetch_signature = xUnfetch_signatures[xUnfetch_apndUnfetch_enum];
@transform_xUnfetch_apndUnfetch@
expression E;
identifier FP_NAME = xUnfetch;
identifier FUNC_NAME = apndUnfetch;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUnfetch_signature = xUnfetch_signatures[xUnfetch_apndUnfetch_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUnfetch_signature = xUnfetch_signatures[xUnfetch_apndUnfetch_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUnfetch_signature = xUnfetch_signatures[xUnfetch_apndUnfetch_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUnfetch_signature = xUnfetch_signatures[xUnfetch_apndUnfetch_enum];
)

// Rule: .xUnfetch = memdbUnfetch ==> .xUnfetch_signature = xUnfetch_signatures[xUnfetch_memdbUnfetch_enum];
@transform_xUnfetch_memdbUnfetch@
expression E;
identifier FP_NAME = xUnfetch;
identifier FUNC_NAME = memdbUnfetch;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUnfetch_signature = xUnfetch_signatures[xUnfetch_memdbUnfetch_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUnfetch_signature = xUnfetch_signatures[xUnfetch_memdbUnfetch_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUnfetch_signature = xUnfetch_signatures[xUnfetch_memdbUnfetch_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUnfetch_signature = xUnfetch_signatures[xUnfetch_memdbUnfetch_enum];
)

// Rule: .xUnfetch = recoverVfsUnfetch ==> .xUnfetch_signature = xUnfetch_signatures[xUnfetch_recoverVfsUnfetch_enum];
@transform_xUnfetch_recoverVfsUnfetch@
expression E;
identifier FP_NAME = xUnfetch;
identifier FUNC_NAME = recoverVfsUnfetch;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUnfetch_signature = xUnfetch_signatures[xUnfetch_recoverVfsUnfetch_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUnfetch_signature = xUnfetch_signatures[xUnfetch_recoverVfsUnfetch_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUnfetch_signature = xUnfetch_signatures[xUnfetch_recoverVfsUnfetch_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUnfetch_signature = xUnfetch_signatures[xUnfetch_recoverVfsUnfetch_enum];
)

// Rule: .xUnfetch = unixUnfetch ==> .xUnfetch_signature = xUnfetch_signatures[xUnfetch_unixUnfetch_enum];
@transform_xUnfetch_unixUnfetch@
expression E;
identifier FP_NAME = xUnfetch;
identifier FUNC_NAME = unixUnfetch;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUnfetch_signature = xUnfetch_signatures[xUnfetch_unixUnfetch_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUnfetch_signature = xUnfetch_signatures[xUnfetch_unixUnfetch_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUnfetch_signature = xUnfetch_signatures[xUnfetch_unixUnfetch_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUnfetch_signature = xUnfetch_signatures[xUnfetch_unixUnfetch_enum];
)

// Rules for xUnlock (8 valid functions, 23 excluded)
// Rule: .xUnlock = 0 ==> .xUnlock_signature = xUnlock_signatures[xUnlock_0_enum];
@transform_xUnlock_0@
expression E;
identifier FP_NAME = xUnlock;
@@
(
E.FP_NAME = 0;
+ E.xUnlock_signature = xUnlock_signatures[xUnlock_0_enum];
|
E->FP_NAME = 0;
+ E->xUnlock_signature = xUnlock_signatures[xUnlock_0_enum];
)

// Rule: .xUnlock = apndUnlock ==> .xUnlock_signature = xUnlock_signatures[xUnlock_apndUnlock_enum];
@transform_xUnlock_apndUnlock@
expression E;
identifier FP_NAME = xUnlock;
identifier FUNC_NAME = apndUnlock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUnlock_signature = xUnlock_signatures[xUnlock_apndUnlock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUnlock_signature = xUnlock_signatures[xUnlock_apndUnlock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUnlock_signature = xUnlock_signatures[xUnlock_apndUnlock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUnlock_signature = xUnlock_signatures[xUnlock_apndUnlock_enum];
)

// Rule: .xUnlock = memdbUnlock ==> .xUnlock_signature = xUnlock_signatures[xUnlock_memdbUnlock_enum];
@transform_xUnlock_memdbUnlock@
expression E;
identifier FP_NAME = xUnlock;
identifier FUNC_NAME = memdbUnlock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUnlock_signature = xUnlock_signatures[xUnlock_memdbUnlock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUnlock_signature = xUnlock_signatures[xUnlock_memdbUnlock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUnlock_signature = xUnlock_signatures[xUnlock_memdbUnlock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUnlock_signature = xUnlock_signatures[xUnlock_memdbUnlock_enum];
)

// Rule: .xUnlock = recoverVfsUnlock ==> .xUnlock_signature = xUnlock_signatures[xUnlock_recoverVfsUnlock_enum];
@transform_xUnlock_recoverVfsUnlock@
expression E;
identifier FP_NAME = xUnlock;
identifier FUNC_NAME = recoverVfsUnlock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUnlock_signature = xUnlock_signatures[xUnlock_recoverVfsUnlock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUnlock_signature = xUnlock_signatures[xUnlock_recoverVfsUnlock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUnlock_signature = xUnlock_signatures[xUnlock_recoverVfsUnlock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUnlock_signature = xUnlock_signatures[xUnlock_recoverVfsUnlock_enum];
)

// Rule: .xUnlock = vfstraceUnlock ==> .xUnlock_signature = xUnlock_signatures[xUnlock_vfstraceUnlock_enum];
@transform_xUnlock_vfstraceUnlock@
expression E;
identifier FP_NAME = xUnlock;
identifier FUNC_NAME = vfstraceUnlock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUnlock_signature = xUnlock_signatures[xUnlock_vfstraceUnlock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUnlock_signature = xUnlock_signatures[xUnlock_vfstraceUnlock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUnlock_signature = xUnlock_signatures[xUnlock_vfstraceUnlock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUnlock_signature = xUnlock_signatures[xUnlock_vfstraceUnlock_enum];
)

// Rule: .xUnlock = unixUnlock ==> .xUnlock_signature = xUnlock_signatures[xUnlock_unixUnlock_enum];
@transform_xUnlock_unixUnlock@
expression E;
identifier FP_NAME = xUnlock;
identifier FUNC_NAME = unixUnlock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUnlock_signature = xUnlock_signatures[xUnlock_unixUnlock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUnlock_signature = xUnlock_signatures[xUnlock_unixUnlock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUnlock_signature = xUnlock_signatures[xUnlock_unixUnlock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUnlock_signature = xUnlock_signatures[xUnlock_unixUnlock_enum];
)

// Rule: .xUnlock = nolockUnlock ==> .xUnlock_signature = xUnlock_signatures[xUnlock_nolockUnlock_enum];
@transform_xUnlock_nolockUnlock@
expression E;
identifier FP_NAME = xUnlock;
identifier FUNC_NAME = nolockUnlock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUnlock_signature = xUnlock_signatures[xUnlock_nolockUnlock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUnlock_signature = xUnlock_signatures[xUnlock_nolockUnlock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUnlock_signature = xUnlock_signatures[xUnlock_nolockUnlock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUnlock_signature = xUnlock_signatures[xUnlock_nolockUnlock_enum];
)

// Rule: .xUnlock = dotlockUnlock ==> .xUnlock_signature = xUnlock_signatures[xUnlock_dotlockUnlock_enum];
@transform_xUnlock_dotlockUnlock@
expression E;
identifier FP_NAME = xUnlock;
identifier FUNC_NAME = dotlockUnlock;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUnlock_signature = xUnlock_signatures[xUnlock_dotlockUnlock_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUnlock_signature = xUnlock_signatures[xUnlock_dotlockUnlock_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUnlock_signature = xUnlock_signatures[xUnlock_dotlockUnlock_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUnlock_signature = xUnlock_signatures[xUnlock_dotlockUnlock_enum];
)

// Rules for xUnpin (2 valid functions, 2 excluded)
// Rule: .xUnpin = pcache1Unpin ==> .xUnpin_signature = xUnpin_signatures[xUnpin_pcache1Unpin_enum];
@transform_xUnpin_pcache1Unpin@
expression E;
identifier FP_NAME = xUnpin;
identifier FUNC_NAME = pcache1Unpin;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUnpin_signature = xUnpin_signatures[xUnpin_pcache1Unpin_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUnpin_signature = xUnpin_signatures[xUnpin_pcache1Unpin_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUnpin_signature = xUnpin_signatures[xUnpin_pcache1Unpin_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUnpin_signature = xUnpin_signatures[xUnpin_pcache1Unpin_enum];
)

// Rule: .xUnpin = pcachetraceUnpin ==> .xUnpin_signature = xUnpin_signatures[xUnpin_pcachetraceUnpin_enum];
@transform_xUnpin_pcachetraceUnpin@
expression E;
identifier FP_NAME = xUnpin;
identifier FUNC_NAME = pcachetraceUnpin;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUnpin_signature = xUnpin_signatures[xUnpin_pcachetraceUnpin_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUnpin_signature = xUnpin_signatures[xUnpin_pcachetraceUnpin_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUnpin_signature = xUnpin_signatures[xUnpin_pcachetraceUnpin_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUnpin_signature = xUnpin_signatures[xUnpin_pcachetraceUnpin_enum];
)

// Rules for xUpdate (14 valid functions, 1 excluded)
// Rule: .xUpdate = 0 ==> .xUpdate_signature = xUpdate_signatures[xUpdate_0_enum];
@transform_xUpdate_0@
expression E;
identifier FP_NAME = xUpdate;
@@
(
E.FP_NAME = 0;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_0_enum];
|
E->FP_NAME = 0;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_0_enum];
)

// Rule: .xUpdate = amatchUpdate ==> .xUpdate_signature = xUpdate_signatures[xUpdate_amatchUpdate_enum];
@transform_xUpdate_amatchUpdate@
expression E;
identifier FP_NAME = xUpdate;
identifier FUNC_NAME = amatchUpdate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_amatchUpdate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_amatchUpdate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_amatchUpdate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_amatchUpdate_enum];
)

// Rule: .xUpdate = csvtabUpdate ==> .xUpdate_signature = xUpdate_signatures[xUpdate_csvtabUpdate_enum];
@transform_xUpdate_csvtabUpdate@
expression E;
identifier FP_NAME = xUpdate;
identifier FUNC_NAME = csvtabUpdate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_csvtabUpdate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_csvtabUpdate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_csvtabUpdate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_csvtabUpdate_enum];
)

// Rule: .xUpdate = dbpageUpdate ==> .xUpdate_signature = xUpdate_signatures[xUpdate_dbpageUpdate_enum];
@transform_xUpdate_dbpageUpdate@
expression E;
identifier FP_NAME = xUpdate;
identifier FUNC_NAME = dbpageUpdate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_dbpageUpdate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_dbpageUpdate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_dbpageUpdate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_dbpageUpdate_enum];
)

// Rule: .xUpdate = echoUpdate ==> .xUpdate_signature = xUpdate_signatures[xUpdate_echoUpdate_enum];
@transform_xUpdate_echoUpdate@
expression E;
identifier FP_NAME = xUpdate;
identifier FUNC_NAME = echoUpdate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_echoUpdate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_echoUpdate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_echoUpdate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_echoUpdate_enum];
)

// Rule: .xUpdate = expertUpdate ==> .xUpdate_signature = xUpdate_signatures[xUpdate_expertUpdate_enum];
@transform_xUpdate_expertUpdate@
expression E;
identifier FP_NAME = xUpdate;
identifier FUNC_NAME = expertUpdate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_expertUpdate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_expertUpdate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_expertUpdate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_expertUpdate_enum];
)

// Rule: .xUpdate = fts3UpdateMethod ==> .xUpdate_signature = xUpdate_signatures[xUpdate_fts3UpdateMethod_enum];
@transform_xUpdate_fts3UpdateMethod@
expression E;
identifier FP_NAME = xUpdate;
identifier FUNC_NAME = fts3UpdateMethod;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_fts3UpdateMethod_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_fts3UpdateMethod_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_fts3UpdateMethod_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_fts3UpdateMethod_enum];
)

// Rule: .xUpdate = geopolyUpdate ==> .xUpdate_signature = xUpdate_signatures[xUpdate_geopolyUpdate_enum];
@transform_xUpdate_geopolyUpdate@
expression E;
identifier FP_NAME = xUpdate;
identifier FUNC_NAME = geopolyUpdate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_geopolyUpdate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_geopolyUpdate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_geopolyUpdate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_geopolyUpdate_enum];
)

// Rule: .xUpdate = rtreeUpdate ==> .xUpdate_signature = xUpdate_signatures[xUpdate_rtreeUpdate_enum];
@transform_xUpdate_rtreeUpdate@
expression E;
identifier FP_NAME = xUpdate;
identifier FUNC_NAME = rtreeUpdate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_rtreeUpdate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_rtreeUpdate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_rtreeUpdate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_rtreeUpdate_enum];
)

// Rule: .xUpdate = spellfix1Update ==> .xUpdate_signature = xUpdate_signatures[xUpdate_spellfix1Update_enum];
@transform_xUpdate_spellfix1Update@
expression E;
identifier FP_NAME = xUpdate;
identifier FUNC_NAME = spellfix1Update;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_spellfix1Update_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_spellfix1Update_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_spellfix1Update_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_spellfix1Update_enum];
)

// Rule: .xUpdate = tclvarUpdate ==> .xUpdate_signature = xUpdate_signatures[xUpdate_tclvarUpdate_enum];
@transform_xUpdate_tclvarUpdate@
expression E;
identifier FP_NAME = xUpdate;
identifier FUNC_NAME = tclvarUpdate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_tclvarUpdate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_tclvarUpdate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_tclvarUpdate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_tclvarUpdate_enum];
)

// Rule: .xUpdate = vstattabUpdate ==> .xUpdate_signature = xUpdate_signatures[xUpdate_vstattabUpdate_enum];
@transform_xUpdate_vstattabUpdate@
expression E;
identifier FP_NAME = xUpdate;
identifier FUNC_NAME = vstattabUpdate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_vstattabUpdate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_vstattabUpdate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_vstattabUpdate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_vstattabUpdate_enum];
)

// Rule: .xUpdate = vtablogUpdate ==> .xUpdate_signature = xUpdate_signatures[xUpdate_vtablogUpdate_enum];
@transform_xUpdate_vtablogUpdate@
expression E;
identifier FP_NAME = xUpdate;
identifier FUNC_NAME = vtablogUpdate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_vtablogUpdate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_vtablogUpdate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_vtablogUpdate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_vtablogUpdate_enum];
)

// Rule: .xUpdate = zipfileUpdate ==> .xUpdate_signature = xUpdate_signatures[xUpdate_zipfileUpdate_enum];
@transform_xUpdate_zipfileUpdate@
expression E;
identifier FP_NAME = xUpdate;
identifier FUNC_NAME = zipfileUpdate;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_zipfileUpdate_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xUpdate_signature = xUpdate_signatures[xUpdate_zipfileUpdate_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_zipfileUpdate_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xUpdate_signature = xUpdate_signatures[xUpdate_zipfileUpdate_enum];
)

// Rules for xWrite (7 valid functions, 19 excluded)
// Rule: .xWrite = apndWrite ==> .xWrite_signature = xWrite_signatures[xWrite_apndWrite_enum];
@transform_xWrite_apndWrite@
expression E;
identifier FP_NAME = xWrite;
identifier FUNC_NAME = apndWrite;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xWrite_signature = xWrite_signatures[xWrite_apndWrite_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xWrite_signature = xWrite_signatures[xWrite_apndWrite_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xWrite_signature = xWrite_signatures[xWrite_apndWrite_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xWrite_signature = xWrite_signatures[xWrite_apndWrite_enum];
)

// Rule: .xWrite = kvstorageWrite ==> .xWrite_signature = xWrite_signatures[xWrite_kvstorageWrite_enum];
@transform_xWrite_kvstorageWrite@
expression E;
identifier FP_NAME = xWrite;
identifier FUNC_NAME = kvstorageWrite;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xWrite_signature = xWrite_signatures[xWrite_kvstorageWrite_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xWrite_signature = xWrite_signatures[xWrite_kvstorageWrite_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xWrite_signature = xWrite_signatures[xWrite_kvstorageWrite_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xWrite_signature = xWrite_signatures[xWrite_kvstorageWrite_enum];
)

// Rule: .xWrite = memdbWrite ==> .xWrite_signature = xWrite_signatures[xWrite_memdbWrite_enum];
@transform_xWrite_memdbWrite@
expression E;
identifier FP_NAME = xWrite;
identifier FUNC_NAME = memdbWrite;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xWrite_signature = xWrite_signatures[xWrite_memdbWrite_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xWrite_signature = xWrite_signatures[xWrite_memdbWrite_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xWrite_signature = xWrite_signatures[xWrite_memdbWrite_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xWrite_signature = xWrite_signatures[xWrite_memdbWrite_enum];
)

// Rule: .xWrite = memjrnlWrite ==> .xWrite_signature = xWrite_signatures[xWrite_memjrnlWrite_enum];
@transform_xWrite_memjrnlWrite@
expression E;
identifier FP_NAME = xWrite;
identifier FUNC_NAME = memjrnlWrite;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xWrite_signature = xWrite_signatures[xWrite_memjrnlWrite_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xWrite_signature = xWrite_signatures[xWrite_memjrnlWrite_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xWrite_signature = xWrite_signatures[xWrite_memjrnlWrite_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xWrite_signature = xWrite_signatures[xWrite_memjrnlWrite_enum];
)

// Rule: .xWrite = recoverVfsWrite ==> .xWrite_signature = xWrite_signatures[xWrite_recoverVfsWrite_enum];
@transform_xWrite_recoverVfsWrite@
expression E;
identifier FP_NAME = xWrite;
identifier FUNC_NAME = recoverVfsWrite;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xWrite_signature = xWrite_signatures[xWrite_recoverVfsWrite_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xWrite_signature = xWrite_signatures[xWrite_recoverVfsWrite_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xWrite_signature = xWrite_signatures[xWrite_recoverVfsWrite_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xWrite_signature = xWrite_signatures[xWrite_recoverVfsWrite_enum];
)

// Rule: .xWrite = vfstraceWrite ==> .xWrite_signature = xWrite_signatures[xWrite_vfstraceWrite_enum];
@transform_xWrite_vfstraceWrite@
expression E;
identifier FP_NAME = xWrite;
identifier FUNC_NAME = vfstraceWrite;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xWrite_signature = xWrite_signatures[xWrite_vfstraceWrite_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xWrite_signature = xWrite_signatures[xWrite_vfstraceWrite_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xWrite_signature = xWrite_signatures[xWrite_vfstraceWrite_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xWrite_signature = xWrite_signatures[xWrite_vfstraceWrite_enum];
)

// Rule: .xWrite = unixWrite ==> .xWrite_signature = xWrite_signatures[xWrite_unixWrite_enum];
@transform_xWrite_unixWrite@
expression E;
identifier FP_NAME = xWrite;
identifier FUNC_NAME = unixWrite;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xWrite_signature = xWrite_signatures[xWrite_unixWrite_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xWrite_signature = xWrite_signatures[xWrite_unixWrite_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xWrite_signature = xWrite_signatures[xWrite_unixWrite_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xWrite_signature = xWrite_signatures[xWrite_unixWrite_enum];
)

// Rules for xsnprintf (1 valid functions, 0 excluded)
// Rule: .xsnprintf = sqlite3_set_authorizer ==> .xsnprintf_signature = xsnprintf_signatures[xsnprintf_sqlite3_set_authorizer_enum];
@transform_xsnprintf_sqlite3_set_authorizer@
expression E;
identifier FP_NAME = xsnprintf;
identifier FUNC_NAME = sqlite3_set_authorizer;
@@
(
E.FP_NAME = FUNC_NAME;
+ E.xsnprintf_signature = xsnprintf_signatures[xsnprintf_sqlite3_set_authorizer_enum];
|
E.FP_NAME = &FUNC_NAME;
+ E.xsnprintf_signature = xsnprintf_signatures[xsnprintf_sqlite3_set_authorizer_enum];
|
E->FP_NAME = FUNC_NAME;
+ E->xsnprintf_signature = xsnprintf_signatures[xsnprintf_sqlite3_set_authorizer_enum];
|
E->FP_NAME = &FUNC_NAME;
+ E->xsnprintf_signature = xsnprintf_signatures[xsnprintf_sqlite3_set_authorizer_enum];
)

// Total transformation rules generated: 1070
// Total functions excluded: 720

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

