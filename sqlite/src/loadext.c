/*
** 2006 June 7
**
** The author disclaims copyright to this source code.  In place of
** a legal notice, here is a blessing:
**
**    May you do good and not evil.
**    May you find forgiveness for yourself and forgive others.
**    May you share freely, never taking more than you give.
**
*************************************************************************
** This file contains code used to dynamically load extensions into
** the SQLite library.
*/

#ifndef SQLITE_CORE
  #define SQLITE_CORE 1  /* Disable the API redefinition in sqlite3ext.h */
#endif
#include "sqlite3ext.h"
#include "sqliteInt.h"

#ifndef SQLITE_OMIT_LOAD_EXTENSION
/*
** Some API routines are omitted when various features are
** excluded from a build of SQLite.  Substitute a NULL pointer
** for any missing APIs.
*/
#ifndef SQLITE_ENABLE_COLUMN_METADATA
# define sqlite3_column_database_name   0
# define sqlite3_column_database_name16 0
# define sqlite3_column_table_name      0
# define sqlite3_column_table_name16    0
# define sqlite3_column_origin_name     0
# define sqlite3_column_origin_name16   0
#endif

#ifdef SQLITE_OMIT_AUTHORIZATION
# define sqlite3_set_authorizer         0
#endif

#ifdef SQLITE_OMIT_UTF16
# define sqlite3_bind_text16            0
# define sqlite3_collation_needed16     0
# define sqlite3_column_decltype16      0
# define sqlite3_column_name16          0
# define sqlite3_column_text16          0
# define sqlite3_complete16             0
# define sqlite3_create_collation16     0
# define sqlite3_create_function16      0
# define sqlite3_errmsg16               0
# define sqlite3_open16                 0
# define sqlite3_prepare16              0
# define sqlite3_prepare16_v2           0
# define sqlite3_prepare16_v3           0
# define sqlite3_result_error16         0
# define sqlite3_result_text16          0
# define sqlite3_result_text16be        0
# define sqlite3_result_text16le        0
# define sqlite3_value_text16           0
# define sqlite3_value_text16be         0
# define sqlite3_value_text16le         0
# define sqlite3_column_database_name16 0
# define sqlite3_column_table_name16    0
# define sqlite3_column_origin_name16   0
#endif

#ifdef SQLITE_OMIT_COMPLETE
# define sqlite3_complete 0
# define sqlite3_complete16 0
#endif

#ifdef SQLITE_OMIT_DECLTYPE
# define sqlite3_column_decltype16      0
# define sqlite3_column_decltype        0
#endif

#ifdef SQLITE_OMIT_PROGRESS_CALLBACK
# define sqlite3_progress_handler 0
#endif

#ifdef SQLITE_OMIT_VIRTUALTABLE
# define sqlite3_create_module 0
# define sqlite3_create_module_v2 0
# define sqlite3_declare_vtab 0
# define sqlite3_vtab_config 0
# define sqlite3_vtab_on_conflict 0
# define sqlite3_vtab_collation 0
#endif

#ifdef SQLITE_OMIT_SHARED_CACHE
# define sqlite3_enable_shared_cache 0
#endif

#if defined(SQLITE_OMIT_TRACE) || defined(SQLITE_OMIT_DEPRECATED)
# define sqlite3_profile       0
# define sqlite3_trace         0
#endif

#ifdef SQLITE_OMIT_GET_TABLE
# define sqlite3_free_table    0
# define sqlite3_get_table     0
#endif

#ifdef SQLITE_OMIT_INCRBLOB
#define sqlite3_bind_zeroblob  0
#define sqlite3_blob_bytes     0
#define sqlite3_blob_close     0
#define sqlite3_blob_open      0
#define sqlite3_blob_read      0
#define sqlite3_blob_write     0
#define sqlite3_blob_reopen    0
#endif

#if defined(SQLITE_OMIT_TRACE)
# define sqlite3_trace_v2      0
#endif

/*
** The following structure contains pointers to all SQLite API routines.
** A pointer to this structure is passed into extensions when they are
** loaded so that the extension can make calls back into the SQLite
** library.
**
** When adding new APIs, add them to the bottom of this structure
** in order to preserve backwards compatibility.
**
** Extensions that use newer APIs should first call the
** sqlite3_libversion_number() to make sure that the API they
** intend to use is supported by the library.  Extensions should
** also check to make sure that the pointer to the function is
** not NULL before calling it.
*/
static const sqlite3_api_routines sqlite3Apis = {
  sqlite3_aggregate_context,
#ifndef SQLITE_OMIT_DEPRECATED
  sqlite3_aggregate_count,
#else
  0,
#endif
  sqlite3_bind_blob,
  sqlite3_bind_double,
  sqlite3_bind_int,
  sqlite3_bind_int64,
  sqlite3_bind_null,
  sqlite3_bind_parameter_count,
  sqlite3_bind_parameter_index,
  sqlite3_bind_parameter_name,
  sqlite3_bind_text,
  sqlite3_bind_text16,
  sqlite3_bind_value,
  sqlite3_busy_handler,
  sqlite3_busy_timeout,
  sqlite3_changes,
  sqlite3_close,
  sqlite3_collation_needed,
  sqlite3_collation_needed16,
  sqlite3_column_blob,
  sqlite3_column_bytes,
  sqlite3_column_bytes16,
  sqlite3_column_count,
  sqlite3_column_database_name,
  sqlite3_column_database_name16,
  sqlite3_column_decltype,
  sqlite3_column_decltype16,
  sqlite3_column_double,
  sqlite3_column_int,
  sqlite3_column_int64,
  sqlite3_column_name,
  sqlite3_column_name16,
  sqlite3_column_origin_name,
  sqlite3_column_origin_name16,
  sqlite3_column_table_name,
  sqlite3_column_table_name16,
  sqlite3_column_text,
  sqlite3_column_text16,
  sqlite3_column_type,
  sqlite3_column_value,
  sqlite3_commit_hook,
  sqlite3_complete,
  sqlite3_complete16,
  sqlite3_create_collation,
  sqlite3_create_collation16,
  sqlite3_create_function,
  sqlite3_create_function16,
  sqlite3_create_module,
  sqlite3_data_count,
  sqlite3_db_handle,
  sqlite3_declare_vtab,
  sqlite3_enable_shared_cache,
  sqlite3_errcode,
  sqlite3_errmsg,
  sqlite3_errmsg16,
  sqlite3_exec,
#ifndef SQLITE_OMIT_DEPRECATED
  sqlite3_expired,
#else
  0,
#endif
  sqlite3_finalize,
  sqlite3_free,
  sqlite3_free_table,
  sqlite3_get_autocommit,
  sqlite3_get_auxdata,
  sqlite3_get_table,
  0,     /* Was sqlite3_global_recover(), but that function is deprecated */
  sqlite3_interrupt,
  sqlite3_last_insert_rowid,
  sqlite3_libversion,
  sqlite3_libversion_number,
  sqlite3_malloc,
  sqlite3_mprintf,
  sqlite3_open,
  sqlite3_open16,
  sqlite3_prepare,
  sqlite3_prepare16,
  sqlite3_profile,
  sqlite3_progress_handler,
  sqlite3_realloc,
  sqlite3_reset,
  sqlite3_result_blob,
  sqlite3_result_double,
  sqlite3_result_error,
  sqlite3_result_error16,
  sqlite3_result_int,
  sqlite3_result_int64,
  sqlite3_result_null,
  sqlite3_result_text,
  sqlite3_result_text16,
  sqlite3_result_text16be,
  sqlite3_result_text16le,
  sqlite3_result_value,
  sqlite3_rollback_hook,
  sqlite3_set_authorizer,
  sqlite3_set_auxdata,
  sqlite3_snprintf,
  sqlite3_step,
  sqlite3_table_column_metadata,
#ifndef SQLITE_OMIT_DEPRECATED
  sqlite3_thread_cleanup,
#else
  0,
#endif
  sqlite3_total_changes,
  sqlite3_trace,
#ifndef SQLITE_OMIT_DEPRECATED
  sqlite3_transfer_bindings,
#else
  0,
#endif
  sqlite3_update_hook,
  sqlite3_user_data,
  sqlite3_value_blob,
  sqlite3_value_bytes,
  sqlite3_value_bytes16,
  sqlite3_value_double,
  sqlite3_value_int,
  sqlite3_value_int64,
  sqlite3_value_numeric_type,
  sqlite3_value_text,
  sqlite3_value_text16,
  sqlite3_value_text16be,
  sqlite3_value_text16le,
  sqlite3_value_type,
  sqlite3_vmprintf,
  /*
  ** The original API set ends here.  All extensions can call any
  ** of the APIs above provided that the pointer is not NULL.  But
  ** before calling APIs that follow, extension should check the
  ** sqlite3_libversion_number() to make sure they are dealing with
  ** a library that is new enough to support that API.
  *************************************************************************
  */
  sqlite3_overload_function,

  /*
  ** Added after 3.3.13
  */
  sqlite3_prepare_v2,
  sqlite3_prepare16_v2,
  sqlite3_clear_bindings,

  /*
  ** Added for 3.4.1
  */
  sqlite3_create_module_v2,

  /*
  ** Added for 3.5.0
  */
  sqlite3_bind_zeroblob,
  sqlite3_blob_bytes,
  sqlite3_blob_close,
  sqlite3_blob_open,
  sqlite3_blob_read,
  sqlite3_blob_write,
  sqlite3_create_collation_v2,
  sqlite3_file_control,
  sqlite3_memory_highwater,
  sqlite3_memory_used,
#ifdef SQLITE_MUTEX_OMIT
  0, 
  0, 
  0,
  0,
  0,
#else
  sqlite3_mutex_alloc,
  sqlite3_mutex_enter,
  sqlite3_mutex_free,
  sqlite3_mutex_leave,
  sqlite3_mutex_try,
#endif
  sqlite3_open_v2,
  sqlite3_release_memory,
  sqlite3_result_error_nomem,
  sqlite3_result_error_toobig,
  sqlite3_sleep,
  sqlite3_soft_heap_limit,
  sqlite3_vfs_find,
  sqlite3_vfs_register,
  sqlite3_vfs_unregister,

  /*
  ** Added for 3.5.8
  */
  sqlite3_threadsafe,
  sqlite3_result_zeroblob,
  sqlite3_result_error_code,
  sqlite3_test_control,
  sqlite3_randomness,
  sqlite3_context_db_handle,

  /*
  ** Added for 3.6.0
  */
  sqlite3_extended_result_codes,
  sqlite3_limit,
  sqlite3_next_stmt,
  sqlite3_sql,
  sqlite3_status,

  /*
  ** Added for 3.7.4
  */
  sqlite3_backup_finish,
  sqlite3_backup_init,
  sqlite3_backup_pagecount,
  sqlite3_backup_remaining,
  sqlite3_backup_step,
#ifndef SQLITE_OMIT_COMPILEOPTION_DIAGS
  sqlite3_compileoption_get,
  sqlite3_compileoption_used,
#else
  0,
  0,
#endif
  sqlite3_create_function_v2,
  sqlite3_db_config,
  sqlite3_db_mutex,
  sqlite3_db_status,
  sqlite3_extended_errcode,
  sqlite3_log,
  sqlite3_soft_heap_limit64,
  sqlite3_sourceid,
  sqlite3_stmt_status,
  sqlite3_strnicmp,
#ifdef SQLITE_ENABLE_UNLOCK_NOTIFY
  sqlite3_unlock_notify,
#else
  0,
#endif
#ifndef SQLITE_OMIT_WAL
  sqlite3_wal_autocheckpoint,
  sqlite3_wal_checkpoint,
  sqlite3_wal_hook,
#else
  0,
  0,
  0,
#endif
  sqlite3_blob_reopen,
  sqlite3_vtab_config,
  sqlite3_vtab_on_conflict,
  sqlite3_close_v2,
  sqlite3_db_filename,
  sqlite3_db_readonly,
  sqlite3_db_release_memory,
  sqlite3_errstr,
  sqlite3_stmt_busy,
  sqlite3_stmt_readonly,
  sqlite3_stricmp,
  sqlite3_uri_boolean,
  sqlite3_uri_int64,
  sqlite3_uri_parameter,
  sqlite3_vsnprintf,
  sqlite3_wal_checkpoint_v2,
  /* Version 3.8.7 and later */
  sqlite3_auto_extension,
  sqlite3_bind_blob64,
  sqlite3_bind_text64,
  sqlite3_cancel_auto_extension,
  sqlite3_load_extension,
  sqlite3_malloc64,
  sqlite3_msize,
  sqlite3_realloc64,
  sqlite3_reset_auto_extension,
  sqlite3_result_blob64,
  sqlite3_result_text64,
  sqlite3_strglob,
  /* Version 3.8.11 and later */
  (sqlite3_value*(*)(const sqlite3_value*))sqlite3_value_dup,
  sqlite3_value_free,
  sqlite3_result_zeroblob64,
  sqlite3_bind_zeroblob64,
  /* Version 3.9.0 and later */
  sqlite3_value_subtype,
  sqlite3_result_subtype,
  /* Version 3.10.0 and later */
  sqlite3_status64,
  sqlite3_strlike,
  sqlite3_db_cacheflush,
  /* Version 3.12.0 and later */
  sqlite3_system_errno,
  /* Version 3.14.0 and later */
  sqlite3_trace_v2,
  sqlite3_expanded_sql,
  /* Version 3.18.0 and later */
  sqlite3_set_last_insert_rowid,
  /* Version 3.20.0 and later */
  sqlite3_prepare_v3,
  sqlite3_prepare16_v3,
  sqlite3_bind_pointer,
  sqlite3_result_pointer,
  sqlite3_value_pointer,
  /* Version 3.22.0 and later */
  sqlite3_vtab_nochange,
  sqlite3_value_nochange,
  sqlite3_vtab_collation,
  /* Version 3.24.0 and later */
  sqlite3_keyword_count,
  sqlite3_keyword_name,
  sqlite3_keyword_check,
  sqlite3_str_new,
  sqlite3_str_finish,
  sqlite3_str_appendf,
  sqlite3_str_vappendf,
  sqlite3_str_append,
  sqlite3_str_appendall,
  sqlite3_str_appendchar,
  sqlite3_str_reset,
  sqlite3_str_errcode,
  sqlite3_str_length,
  sqlite3_str_value,
  /* Version 3.25.0 and later */
  sqlite3_create_window_function,
  /* Version 3.26.0 and later */
#ifdef SQLITE_ENABLE_NORMALIZE
  sqlite3_normalized_sql,
#else
  0,
#endif
  /* Version 3.28.0 and later */
  sqlite3_stmt_isexplain,
  sqlite3_value_frombind,
  /* Version 3.30.0 and later */
#ifndef SQLITE_OMIT_VIRTUALTABLE
  sqlite3_drop_modules,
#else
  0,
#endif
  /* Version 3.31.0 and later */
  sqlite3_hard_heap_limit64,
  sqlite3_uri_key,
  sqlite3_filename_database,
  sqlite3_filename_journal,
  sqlite3_filename_wal,
  /* Version 3.32.0 and later */
  sqlite3_create_filename,
  sqlite3_free_filename,
  sqlite3_database_file_object,
  /* Version 3.34.0 and later */
  sqlite3_txn_state,
  /* Version 3.36.1 and later */
  sqlite3_changes64,
  sqlite3_total_changes64,
  /* Version 3.37.0 and later */
  sqlite3_autovacuum_pages,
  /* Version 3.38.0 and later */
  sqlite3_error_offset,
#ifndef SQLITE_OMIT_VIRTUALTABLE
  sqlite3_vtab_rhs_value,
  sqlite3_vtab_distinct,
  sqlite3_vtab_in,
  sqlite3_vtab_in_first,
  sqlite3_vtab_in_next,
#else
  0,
  0,
  0,
  0,
  0,
#endif
  /* Version 3.39.0 and later */
#ifndef SQLITE_OMIT_DESERIALIZE
  sqlite3_deserialize,
  sqlite3_serialize,
#else
  0,
  0,
#endif
  sqlite3_db_name,
  /* Version 3.40.0 and later */
  sqlite3_value_encoding,
  /* Version 3.41.0 and later */
  sqlite3_is_interrupted,
  /* Version 3.43.0 and later */
  sqlite3_stmt_explain,
  /* Version 3.44.0 and later */
  sqlite3_get_clientdata,
  sqlite3_set_clientdata,
  /* Version 3.50.0 and later */
  sqlite3_setlk_timeout,
  /* Version 3.51.0 and later */
  sqlite3_set_errmsg
,
  .aggregate_context_signature = aggregate_context_signatures[aggregate_context_sqlite3_aggregate_context_enum],
  .bind_int_signature = bind_int_signatures[bind_int_sqlite3_bind_double_enum],
  .bind_int64_signature = bind_int64_signatures[bind_int64_sqlite3_bind_int_enum],
  .bind_null_signature = bind_null_signatures[bind_null_sqlite3_bind_int64_enum],
  .bind_parameter_count_signature = bind_parameter_count_signatures[bind_parameter_count_sqlite3_bind_null_enum],
  .bind_parameter_index_signature = bind_parameter_index_signatures[bind_parameter_index_sqlite3_bind_parameter_count_enum],
  .bind_parameter_name_signature = bind_parameter_name_signatures[bind_parameter_name_sqlite3_bind_parameter_index_enum],
  .bind_text_signature = bind_text_signatures[bind_text_sqlite3_bind_parameter_name_enum],
  .bind_text16_signature = bind_text16_signatures[bind_text16_sqlite3_bind_text_enum],
  .bind_value_signature = bind_value_signatures[bind_value_sqlite3_bind_text16_enum],
  .busy_handler_signature = busy_handler_signatures[busy_handler_sqlite3_bind_value_enum],
  .busy_timeout_signature = busy_timeout_signatures[busy_timeout_sqlite3_busy_handler_enum],
  .changes_signature = changes_signatures[changes_sqlite3_busy_timeout_enum],
  .close_signature = close_signatures[close_sqlite3_changes_enum],
  .collation_needed_signature = collation_needed_signatures[collation_needed_sqlite3_close_enum],
  .collation_needed16_signature = collation_needed16_signatures[collation_needed16_sqlite3_collation_needed_enum],
  .column_blob_signature = column_blob_signatures[column_blob_sqlite3_collation_needed16_enum],
  .column_bytes_signature = column_bytes_signatures[column_bytes_sqlite3_column_blob_enum],
  .column_bytes16_signature = column_bytes16_signatures[column_bytes16_sqlite3_column_bytes_enum],
  .column_count_signature = column_count_signatures[column_count_sqlite3_column_bytes16_enum],
  .column_database_name_signature = column_database_name_signatures[column_database_name_sqlite3_column_count_enum],
  .column_database_name16_signature = column_database_name16_signatures[column_database_name16_sqlite3_column_database_name_enum],
  .column_decltype_signature = column_decltype_signatures[column_decltype_sqlite3_column_database_name16_enum],
  .column_decltype16_signature = column_decltype16_signatures[column_decltype16_sqlite3_column_decltype_enum],
  .column_double_signature = column_double_signatures[column_double_sqlite3_column_decltype16_enum],
  .column_int_signature = column_int_signatures[column_int_sqlite3_column_double_enum],
  .column_int64_signature = column_int64_signatures[column_int64_sqlite3_column_int_enum],
  .column_name_signature = column_name_signatures[column_name_sqlite3_column_int64_enum],
  .column_name16_signature = column_name16_signatures[column_name16_sqlite3_column_name_enum],
  .column_origin_name_signature = column_origin_name_signatures[column_origin_name_sqlite3_column_name16_enum],
  .column_origin_name16_signature = column_origin_name16_signatures[column_origin_name16_sqlite3_column_origin_name_enum],
  .column_table_name_signature = column_table_name_signatures[column_table_name_sqlite3_column_origin_name16_enum],
  .column_table_name16_signature = column_table_name16_signatures[column_table_name16_sqlite3_column_table_name_enum],
  .column_text_signature = column_text_signatures[column_text_sqlite3_column_table_name16_enum],
  .column_text16_signature = column_text16_signatures[column_text16_sqlite3_column_text_enum],
  .column_type_signature = column_type_signatures[column_type_sqlite3_column_text16_enum],
  .column_value_signature = column_value_signatures[column_value_sqlite3_column_type_enum],
  .commit_hook_signature = commit_hook_signatures[commit_hook_sqlite3_column_value_enum],
  .complete_signature = complete_signatures[complete_sqlite3_commit_hook_enum],
  .complete16_signature = complete16_signatures[complete16_sqlite3_complete_enum],
  .create_collation_signature = create_collation_signatures[create_collation_sqlite3_complete16_enum],
  .create_collation16_signature = create_collation16_signatures[create_collation16_sqlite3_create_collation_enum],
  .create_function_signature = create_function_signatures[create_function_sqlite3_create_collation16_enum],
  .create_function16_signature = create_function16_signatures[create_function16_sqlite3_create_function_enum],
  .create_module_signature = create_module_signatures[create_module_sqlite3_create_function16_enum],
  .data_count_signature = data_count_signatures[data_count_sqlite3_create_module_enum],
  .db_handle_signature = db_handle_signatures[db_handle_sqlite3_data_count_enum],
  .declare_vtab_signature = declare_vtab_signatures[declare_vtab_sqlite3_db_handle_enum],
  .enable_shared_cache_signature = enable_shared_cache_signatures[enable_shared_cache_sqlite3_declare_vtab_enum],
  .errcode_signature = errcode_signatures[errcode_sqlite3_enable_shared_cache_enum],
  .errmsg_signature = errmsg_signatures[errmsg_sqlite3_errcode_enum],
  .errmsg16_signature = errmsg16_signatures[errmsg16_sqlite3_errmsg_enum],
  .exec_signature = exec_signatures[exec_sqlite3_errmsg16_enum],
  .expired_signature = expired_signatures[expired_sqlite3_exec_enum],
  .get_autocommit_signature = get_autocommit_signatures[get_autocommit_sqlite3_free_enum],
  .get_auxdata_signature = get_auxdata_signatures[get_auxdata_sqlite3_free_table_enum],
  .get_table_signature = get_table_signatures[get_table_sqlite3_get_autocommit_enum],
  .global_recover_signature = global_recover_signatures[global_recover_sqlite3_get_auxdata_enum],
  .interruptx_signature = interruptx_signatures[interruptx_sqlite3_get_table_enum],
  .libversion_signature = libversion_signatures[libversion_sqlite3_interrupt_enum],
  .libversion_number_signature = libversion_number_signatures[libversion_number_sqlite3_last_insert_rowid_enum],
  .malloc_signature = malloc_signatures[malloc_sqlite3_libversion_enum],
  .mprintf_signature = mprintf_signatures[mprintf_sqlite3_libversion_number_enum],
  .open_signature = open_signatures[open_sqlite3_malloc_enum],
  .open16_signature = open16_signatures[open16_sqlite3_mprintf_enum],
  .prepare_signature = prepare_signatures[prepare_sqlite3_open_enum],
  .prepare16_signature = prepare16_signatures[prepare16_sqlite3_open16_enum],
  .profile_signature = profile_signatures[profile_sqlite3_prepare_enum],
  .progress_handler_signature = progress_handler_signatures[progress_handler_sqlite3_prepare16_enum],
  .realloc_signature = realloc_signatures[realloc_sqlite3_profile_enum],
  .reset_signature = reset_signatures[reset_sqlite3_progress_handler_enum],
  .result_blob_signature = result_blob_signatures[result_blob_sqlite3_realloc_enum],
  .result_double_signature = result_double_signatures[result_double_sqlite3_reset_enum],
  .result_error_signature = result_error_signatures[result_error_sqlite3_result_blob_enum],
  .result_error16_signature = result_error16_signatures[result_error16_sqlite3_result_double_enum],
  .result_int_signature = result_int_signatures[result_int_sqlite3_result_error_enum],
  .result_int64_signature = result_int64_signatures[result_int64_sqlite3_result_error16_enum],
  .result_null_signature = result_null_signatures[result_null_sqlite3_result_int_enum],
  .result_text_signature = result_text_signatures[result_text_sqlite3_result_int64_enum],
  .result_text16_signature = result_text16_signatures[result_text16_sqlite3_result_null_enum],
  .result_text16be_signature = result_text16be_signatures[result_text16be_sqlite3_result_text_enum],
  .result_text16le_signature = result_text16le_signatures[result_text16le_sqlite3_result_text16_enum],
  .result_value_signature = result_value_signatures[result_value_sqlite3_result_text16be_enum],
  .rollback_hook_signature = rollback_hook_signatures[rollback_hook_sqlite3_result_text16le_enum],
  .set_authorizer_signature = set_authorizer_signatures[set_authorizer_sqlite3_result_value_enum],
  .set_auxdata_signature = set_auxdata_signatures[set_auxdata_sqlite3_rollback_hook_enum],
  .xsnprintf_signature = xsnprintf_signatures[xsnprintf_sqlite3_set_authorizer_enum],
  .step_signature = step_signatures[step_sqlite3_set_auxdata_enum],
  .table_column_metadata_signature = table_column_metadata_signatures[table_column_metadata_sqlite3_snprintf_enum],
  .thread_cleanup_signature = thread_cleanup_signatures[thread_cleanup_sqlite3_step_enum],
  .total_changes_signature = total_changes_signatures[total_changes_sqlite3_table_column_metadata_enum],
  .user_data_signature = user_data_signatures[user_data_sqlite3_trace_enum],
  .value_double_signature = value_double_signatures[value_double_sqlite3_user_data_enum],
  .value_int_signature = value_int_signatures[value_int_sqlite3_value_blob_enum],
  .value_int64_signature = value_int64_signatures[value_int64_sqlite3_value_bytes_enum],
  .value_numeric_type_signature = value_numeric_type_signatures[value_numeric_type_sqlite3_value_bytes16_enum],
  .value_text_signature = value_text_signatures[value_text_sqlite3_value_double_enum],
  .value_text16_signature = value_text16_signatures[value_text16_sqlite3_value_int_enum],
  .value_text16be_signature = value_text16be_signatures[value_text16be_sqlite3_value_int64_enum],
  .value_text16le_signature = value_text16le_signatures[value_text16le_sqlite3_value_numeric_type_enum],
  .value_type_signature = value_type_signatures[value_type_sqlite3_value_text_enum],
  .vmprintf_signature = vmprintf_signatures[vmprintf_sqlite3_value_text16_enum],
  .overload_function_signature = overload_function_signatures[overload_function_sqlite3_value_text16be_enum],
  .prepare_v2_signature = prepare_v2_signatures[prepare_v2_sqlite3_value_text16le_enum],
  .prepare16_v2_signature = prepare16_v2_signatures[prepare16_v2_sqlite3_value_type_enum],
  .clear_bindings_signature = clear_bindings_signatures[clear_bindings_sqlite3_vmprintf_enum],
  .create_module_v2_signature = create_module_v2_signatures[create_module_v2_sqlite3_overload_function_enum],
  .bind_zeroblob_signature = bind_zeroblob_signatures[bind_zeroblob_sqlite3_prepare_v2_enum],
  .blob_bytes_signature = blob_bytes_signatures[blob_bytes_sqlite3_prepare16_v2_enum],
  .blob_close_signature = blob_close_signatures[blob_close_sqlite3_clear_bindings_enum],
  .blob_open_signature = blob_open_signatures[blob_open_sqlite3_create_module_v2_enum],
  .blob_read_signature = blob_read_signatures[blob_read_sqlite3_bind_zeroblob_enum],
  .blob_write_signature = blob_write_signatures[blob_write_sqlite3_blob_bytes_enum],
  .create_collation_v2_signature = create_collation_v2_signatures[create_collation_v2_sqlite3_blob_close_enum],
  .file_control_signature = file_control_signatures[file_control_sqlite3_blob_open_enum],
  .memory_highwater_signature = memory_highwater_signatures[memory_highwater_sqlite3_blob_read_enum],
  .memory_used_signature = memory_used_signatures[memory_used_sqlite3_blob_write_enum],
  .mutex_alloc_signature = mutex_alloc_signatures[mutex_alloc_sqlite3_create_collation_v2_enum],
  .mutex_enter_signature = mutex_enter_signatures[mutex_enter_sqlite3_file_control_enum],
  .mutex_free_signature = mutex_free_signatures[mutex_free_sqlite3_memory_highwater_enum],
  .mutex_leave_signature = mutex_leave_signatures[mutex_leave_sqlite3_memory_used_enum],
  .soft_heap_limit_signature = soft_heap_limit_signatures[soft_heap_limit_sqlite3_mutex_enter_enum],
  .vfs_find_signature = vfs_find_signatures[vfs_find_sqlite3_mutex_free_enum],
  .vfs_register_signature = vfs_register_signatures[vfs_register_sqlite3_mutex_leave_enum],
  .vfs_unregister_signature = vfs_unregister_signatures[vfs_unregister_sqlite3_mutex_try_enum],
  .result_zeroblob_signature = result_zeroblob_signatures[result_zeroblob_sqlite3_release_memory_enum],
  .result_error_code_signature = result_error_code_signatures[result_error_code_sqlite3_result_error_nomem_enum],
  .test_control_signature = test_control_signatures[test_control_sqlite3_result_error_toobig_enum],
  .randomness_signature = randomness_signatures[randomness_sqlite3_sleep_enum],
  .context_db_handle_signature = context_db_handle_signatures[context_db_handle_sqlite3_soft_heap_limit_enum],
  .extended_result_codes_signature = extended_result_codes_signatures[extended_result_codes_sqlite3_vfs_find_enum],
  .limit_signature = limit_signatures[limit_sqlite3_vfs_register_enum],
  .next_stmt_signature = next_stmt_signatures[next_stmt_sqlite3_vfs_unregister_enum],
  .sql_signature = sql_signatures[sql_sqlite3_threadsafe_enum],
  .status_signature = status_signatures[status_sqlite3_result_zeroblob_enum],
  .backup_finish_signature = backup_finish_signatures[backup_finish_sqlite3_result_error_code_enum],
  .backup_init_signature = backup_init_signatures[backup_init_sqlite3_test_control_enum],
  .backup_pagecount_signature = backup_pagecount_signatures[backup_pagecount_sqlite3_randomness_enum],
  .backup_remaining_signature = backup_remaining_signatures[backup_remaining_sqlite3_context_db_handle_enum],
  .backup_step_signature = backup_step_signatures[backup_step_sqlite3_extended_result_codes_enum],
  .compileoption_get_signature = compileoption_get_signatures[compileoption_get_sqlite3_limit_enum],
  .compileoption_used_signature = compileoption_used_signatures[compileoption_used_sqlite3_next_stmt_enum],
  .create_function_v2_signature = create_function_v2_signatures[create_function_v2_sqlite3_sql_enum],
  .db_config_signature = db_config_signatures[db_config_sqlite3_status_enum],
  .db_mutex_signature = db_mutex_signatures[db_mutex_sqlite3_backup_finish_enum],
  .db_status_signature = db_status_signatures[db_status_sqlite3_backup_init_enum],
  .extended_errcode_signature = extended_errcode_signatures[extended_errcode_sqlite3_backup_pagecount_enum],
  .log_signature = log_signatures[log_sqlite3_backup_remaining_enum],
  .soft_heap_limit64_signature = soft_heap_limit64_signatures[soft_heap_limit64_sqlite3_backup_step_enum],
  .stmt_status_signature = stmt_status_signatures[stmt_status_sqlite3_compileoption_used_enum],
  .wal_checkpoint_signature = wal_checkpoint_signatures[wal_checkpoint_sqlite3_db_config_enum],
  .wal_hook_signature = wal_hook_signatures[wal_hook_sqlite3_db_mutex_enum],
  .blob_reopen_signature = blob_reopen_signatures[blob_reopen_sqlite3_db_status_enum],
  .vtab_config_signature = vtab_config_signatures[vtab_config_sqlite3_extended_errcode_enum],
  .vtab_on_conflict_signature = vtab_on_conflict_signatures[vtab_on_conflict_sqlite3_log_enum],
  .close_v2_signature = close_v2_signatures[close_v2_sqlite3_soft_heap_limit64_enum],
  .db_filename_signature = db_filename_signatures[db_filename_sqlite3_sourceid_enum],
  .db_readonly_signature = db_readonly_signatures[db_readonly_sqlite3_stmt_status_enum],
  .db_release_memory_signature = db_release_memory_signatures[db_release_memory_sqlite3_strnicmp_enum],
  .stricmp_signature = stricmp_signatures[stricmp_sqlite3_wal_checkpoint_enum],
  .uri_boolean_signature = uri_boolean_signatures[uri_boolean_sqlite3_wal_hook_enum],
  .auto_extension_signature = auto_extension_signatures[auto_extension_sqlite3_vtab_config_enum],
  .bind_blob64_signature = bind_blob64_signatures[bind_blob64_sqlite3_vtab_on_conflict_enum],
  .bind_text64_signature = bind_text64_signatures[bind_text64_sqlite3_close_v2_enum],
  .cancel_auto_extension_signature = cancel_auto_extension_signatures[cancel_auto_extension_sqlite3_db_filename_enum],
  .load_extension_signature = load_extension_signatures[load_extension_sqlite3_db_readonly_enum],
  .malloc64_signature = malloc64_signatures[malloc64_sqlite3_db_release_memory_enum],
  .msize_signature = msize_signatures[msize_sqlite3_errstr_enum],
  .realloc64_signature = realloc64_signatures[realloc64_sqlite3_stmt_busy_enum],
  .reset_auto_extension_signature = reset_auto_extension_signatures[reset_auto_extension_sqlite3_stmt_readonly_enum],
  .result_blob64_signature = result_blob64_signatures[result_blob64_sqlite3_stricmp_enum],
  .result_text64_signature = result_text64_signatures[result_text64_sqlite3_uri_boolean_enum],
  .strglob_signature = strglob_signatures[strglob_sqlite3_uri_int64_enum],
  .value_dup_signature = value_dup_signatures[value_dup_sqlite3_uri_parameter_enum],
  .value_free_signature = value_free_signatures[value_free_sqlite3_vsnprintf_enum],
  .result_zeroblob64_signature = result_zeroblob64_signatures[result_zeroblob64_sqlite3_wal_checkpoint_v2_enum],
  .bind_zeroblob64_signature = bind_zeroblob64_signatures[bind_zeroblob64_sqlite3_auto_extension_enum],
  .value_subtype_signature = value_subtype_signatures[value_subtype_sqlite3_bind_blob64_enum],
  .result_subtype_signature = result_subtype_signatures[result_subtype_sqlite3_bind_text64_enum],
  .status64_signature = status64_signatures[status64_sqlite3_cancel_auto_extension_enum],
  .strlike_signature = strlike_signatures[strlike_sqlite3_load_extension_enum],
  .db_cacheflush_signature = db_cacheflush_signatures[db_cacheflush_sqlite3_malloc64_enum],
  .system_errno_signature = system_errno_signatures[system_errno_sqlite3_msize_enum],
  .trace_v2_signature = trace_v2_signatures[trace_v2_sqlite3_realloc64_enum],
  .expanded_sql_signature = expanded_sql_signatures[expanded_sql_sqlite3_reset_auto_extension_enum],
  .set_last_insert_rowid_signature = set_last_insert_rowid_signatures[set_last_insert_rowid_sqlite3_result_blob64_enum],
  .prepare_v3_signature = prepare_v3_signatures[prepare_v3_sqlite3_result_text64_enum],
  .prepare16_v3_signature = prepare16_v3_signatures[prepare16_v3_sqlite3_strglob_enum],
  .result_pointer_signature = result_pointer_signatures[result_pointer_sqlite3_value_free_enum],
  .value_pointer_signature = value_pointer_signatures[value_pointer_sqlite3_result_zeroblob64_enum],
  .vtab_nochange_signature = vtab_nochange_signatures[vtab_nochange_sqlite3_bind_zeroblob64_enum],
  .value_nochange_signature = value_nochange_signatures[value_nochange_sqlite3_value_subtype_enum],
  .vtab_collation_signature = vtab_collation_signatures[vtab_collation_sqlite3_result_subtype_enum],
  .keyword_count_signature = keyword_count_signatures[keyword_count_sqlite3_status64_enum],
  .keyword_name_signature = keyword_name_signatures[keyword_name_sqlite3_strlike_enum],
  .keyword_check_signature = keyword_check_signatures[keyword_check_sqlite3_db_cacheflush_enum],
  .str_new_signature = str_new_signatures[str_new_sqlite3_system_errno_enum],
  .str_finish_signature = str_finish_signatures[str_finish_sqlite3_trace_v2_enum],
  .str_appendf_signature = str_appendf_signatures[str_appendf_sqlite3_expanded_sql_enum],
  .str_vappendf_signature = str_vappendf_signatures[str_vappendf_sqlite3_set_last_insert_rowid_enum],
  .str_append_signature = str_append_signatures[str_append_sqlite3_prepare_v3_enum],
  .str_appendall_signature = str_appendall_signatures[str_appendall_sqlite3_prepare16_v3_enum],
  .str_appendchar_signature = str_appendchar_signatures[str_appendchar_sqlite3_bind_pointer_enum],
  .str_reset_signature = str_reset_signatures[str_reset_sqlite3_result_pointer_enum],
  .str_errcode_signature = str_errcode_signatures[str_errcode_sqlite3_value_pointer_enum],
  .str_length_signature = str_length_signatures[str_length_sqlite3_vtab_nochange_enum],
  .str_value_signature = str_value_signatures[str_value_sqlite3_value_nochange_enum],
  .create_window_function_signature = create_window_function_signatures[create_window_function_sqlite3_vtab_collation_enum],
  .normalized_sql_signature = normalized_sql_signatures[normalized_sql_sqlite3_keyword_count_enum],
  .stmt_isexplain_signature = stmt_isexplain_signatures[stmt_isexplain_sqlite3_keyword_name_enum],
  .value_frombind_signature = value_frombind_signatures[value_frombind_sqlite3_keyword_check_enum],
  .drop_modules_signature = drop_modules_signatures[drop_modules_sqlite3_str_new_enum],
  .hard_heap_limit64_signature = hard_heap_limit64_signatures[hard_heap_limit64_sqlite3_str_finish_enum],
  .uri_key_signature = uri_key_signatures[uri_key_sqlite3_str_appendf_enum],
  .filename_database_signature = filename_database_signatures[filename_database_sqlite3_str_vappendf_enum],
  .filename_journal_signature = filename_journal_signatures[filename_journal_sqlite3_str_append_enum],
  .filename_wal_signature = filename_wal_signatures[filename_wal_sqlite3_str_appendall_enum],
  .create_filename_signature = create_filename_signatures[create_filename_sqlite3_str_appendchar_enum],
  .free_filename_signature = free_filename_signatures[free_filename_sqlite3_str_reset_enum],
  .database_file_object_signature = database_file_object_signatures[database_file_object_sqlite3_str_errcode_enum],
  .txn_state_signature = txn_state_signatures[txn_state_sqlite3_str_length_enum],
  .changes64_signature = changes64_signatures[changes64_sqlite3_str_value_enum],
  .total_changes64_signature = total_changes64_signatures[total_changes64_sqlite3_create_window_function_enum],
  .vtab_distinct_signature = vtab_distinct_signatures[vtab_distinct_sqlite3_value_frombind_enum],
  .deserialize_signature = deserialize_signatures[deserialize_sqlite3_uri_key_enum],
  .serialize_signature = serialize_signatures[serialize_sqlite3_filename_database_enum],
  .db_name_signature = db_name_signatures[db_name_sqlite3_filename_journal_enum],
  .value_encoding_signature = value_encoding_signatures[value_encoding_sqlite3_filename_wal_enum],
  .is_interrupted_signature = is_interrupted_signatures[is_interrupted_sqlite3_create_filename_enum],
  .stmt_explain_signature = stmt_explain_signatures[stmt_explain_sqlite3_free_filename_enum],
  .get_clientdata_signature = get_clientdata_signatures[get_clientdata_sqlite3_database_file_object_enum],
  .set_clientdata_signature = set_clientdata_signatures[set_clientdata_sqlite3_txn_state_enum],
  .setlk_timeout_signature = setlk_timeout_signatures[setlk_timeout_sqlite3_changes64_enum],
  // .set_errmsg_signature = set_errmsg_signatures[set_errmsg_sqlite3_total_changes64_enum]
};

/* True if x is the directory separator character
*/
#if SQLITE_OS_WIN
# define DirSep(X)  ((X)=='/'||(X)=='\\')
#else
# define DirSep(X)  ((X)=='/')
#endif

/*
** Attempt to load an SQLite extension library contained in the file
** zFile.  The entry point is zProc.  zProc may be 0 in which case a
** default entry point name (sqlite3_extension_init) is used.  Use
** of the default name is recommended.
**
** Return SQLITE_OK on success and SQLITE_ERROR if something goes wrong.
**
** If an error occurs and pzErrMsg is not 0, then fill *pzErrMsg with 
** error message text.  The calling function should free this memory
** by calling sqlite3DbFree(db, ).
*/
static int sqlite3LoadExtension(
  sqlite3 *db,          /* Load the extension into this database connection */
  const char *zFile,    /* Name of the shared library containing extension */
  const char *zProc,    /* Entry point.  Use "sqlite3_extension_init" if 0 */
  char **pzErrMsg       /* Put error message here if not 0 */
){
  sqlite3_vfs *pVfs = db->pVfs;
  void *handle;
  sqlite3_loadext_entry xInit;
  char *zErrmsg = 0;
  const char *zEntry;
  char *zAltEntry = 0;
  void **aHandle;
  u64 nMsg = strlen(zFile);
  int ii;
  int rc;

  /* Shared library endings to try if zFile cannot be loaded as written */
  static const char *azEndings[] = {
#if SQLITE_OS_WIN
     "dll"   
#elif defined(__APPLE__)
     "dylib"
#else
     "so"
#endif
  };


  if( pzErrMsg ) *pzErrMsg = 0;

  /* Ticket #1863.  To avoid a creating security problems for older
  ** applications that relink against newer versions of SQLite, the
  ** ability to run load_extension is turned off by default.  One
  ** must call either sqlite3_enable_load_extension(db) or
  ** sqlite3_db_config(db, SQLITE_DBCONFIG_ENABLE_LOAD_EXTENSION, 1, 0)
  ** to turn on extension loading.
  */
  if( (db->flags & SQLITE_LoadExtension)==0 ){
    if( pzErrMsg ){
      *pzErrMsg = sqlite3_mprintf("not authorized");
    }
    return SQLITE_ERROR;
  }

  zEntry = zProc ? zProc : "sqlite3_extension_init";

  /* tag-20210611-1.  Some dlopen() implementations will segfault if given
  ** an oversize filename.  Most filesystems have a pathname limit of 4K,
  ** so limit the extension filename length to about twice that.
  ** https://sqlite.org/forum/forumpost/08a0d6d9bf
  **
  ** Later (2023-03-25): Save an extra 6 bytes for the filename suffix.
  ** See https://sqlite.org/forum/forumpost/24083b579d.
  */
  if( nMsg>SQLITE_MAX_PATHLEN ) goto extension_not_found;

  /* Do not allow sqlite3_load_extension() to link to a copy of the
  ** running application, by passing in an empty filename. */
  if( nMsg==0 ) goto extension_not_found;
    
  handle = sqlite3OsDlOpen(pVfs, zFile);
#if SQLITE_OS_UNIX || SQLITE_OS_WIN
  for(ii=0; ii<ArraySize(azEndings) && handle==0; ii++){
    char *zAltFile = sqlite3_mprintf("%s.%s", zFile, azEndings[ii]);
    if( zAltFile==0 ) return SQLITE_NOMEM_BKPT;
    if( nMsg+strlen(azEndings[ii])+1<=SQLITE_MAX_PATHLEN ){
      handle = sqlite3OsDlOpen(pVfs, zAltFile);
    }
    sqlite3_free(zAltFile);
  }
#endif
  if( handle==0 ) goto extension_not_found;
  xInit = (sqlite3_loadext_entry)sqlite3OsDlSym(pVfs, handle, zEntry);

  /* If no entry point was specified and the default legacy
  ** entry point name "sqlite3_extension_init" was not found, then
  ** construct an entry point name "sqlite3_X_init" where the X is
  ** replaced by the lowercase value of every ASCII alphabetic 
  ** character in the filename after the last "/" upto the first ".",
  ** and eliding the first three characters if they are "lib".  
  ** Examples:
  **
  **    /usr/local/lib/libExample5.4.3.so ==>  sqlite3_example_init
  **    C:/lib/mathfuncs.dll              ==>  sqlite3_mathfuncs_init
  */
  if( xInit==0 && zProc==0 ){
    int iFile, iEntry, c;
    int ncFile = sqlite3Strlen30(zFile);
    zAltEntry = sqlite3_malloc64(ncFile+30);
    if( zAltEntry==0 ){
      sqlite3OsDlClose(pVfs, handle);
      return SQLITE_NOMEM_BKPT;
    }
    memcpy(zAltEntry, "sqlite3_", 8);
    for(iFile=ncFile-1; iFile>=0 && !DirSep(zFile[iFile]); iFile--){}
    iFile++;
    if( sqlite3_strnicmp(zFile+iFile, "lib", 3)==0 ) iFile += 3;
    for(iEntry=8; (c = zFile[iFile])!=0 && c!='.'; iFile++){
      if( sqlite3Isalpha(c) ){
        zAltEntry[iEntry++] = (char)sqlite3UpperToLower[(unsigned)c];
      }
    }
    memcpy(zAltEntry+iEntry, "_init", 6);
    zEntry = zAltEntry;
    xInit = (sqlite3_loadext_entry)sqlite3OsDlSym(pVfs, handle, zEntry);
  }
  if( xInit==0 ){
    if( pzErrMsg ){
      nMsg += strlen(zEntry) + 300;
      *pzErrMsg = zErrmsg = sqlite3_malloc64(nMsg);
      if( zErrmsg ){
        assert( nMsg<0x7fffffff );  /* zErrmsg would be NULL if not so */
        sqlite3_snprintf((int)nMsg, zErrmsg,
            "no entry point [%s] in shared library [%s]", zEntry, zFile);
        sqlite3OsDlError(pVfs, nMsg-1, zErrmsg);
      }
    }
    sqlite3OsDlClose(pVfs, handle);
    sqlite3_free(zAltEntry);
    return SQLITE_ERROR;
  }
  sqlite3_free(zAltEntry);
  rc = xInit(db, &zErrmsg, &sqlite3Apis);
  if( rc ){
    if( rc==SQLITE_OK_LOAD_PERMANENTLY ) return SQLITE_OK;
    if( pzErrMsg ){
      *pzErrMsg = sqlite3_mprintf("error during initialization: %s", zErrmsg);
    }
    sqlite3_free(zErrmsg);
    sqlite3OsDlClose(pVfs, handle);
    return SQLITE_ERROR;
  }

  /* Append the new shared library handle to the db->aExtension array. */
  aHandle = sqlite3DbMallocZero(db, sizeof(handle)*(db->nExtension+1));
  if( aHandle==0 ){
    return SQLITE_NOMEM_BKPT;
  }
  if( db->nExtension>0 ){
    memcpy(aHandle, db->aExtension, sizeof(handle)*db->nExtension);
  }
  sqlite3DbFree(db, db->aExtension);
  db->aExtension = aHandle;

  db->aExtension[db->nExtension++] = handle;
  return SQLITE_OK;

extension_not_found:
  if( pzErrMsg ){
    nMsg += 300;
    *pzErrMsg = zErrmsg = sqlite3_malloc64(nMsg);
    if( zErrmsg ){
      assert( nMsg<0x7fffffff );  /* zErrmsg would be NULL if not so */
      sqlite3_snprintf((int)nMsg, zErrmsg,
          "unable to open shared library [%.*s]", SQLITE_MAX_PATHLEN, zFile);
      sqlite3OsDlError(pVfs, nMsg-1, zErrmsg);
    }
  }
  return SQLITE_ERROR;
}
int sqlite3_load_extension(
  sqlite3 *db,          /* Load the extension into this database connection */
  const char *zFile,    /* Name of the shared library containing extension */
  const char *zProc,    /* Entry point.  Use "sqlite3_extension_init" if 0 */
  char **pzErrMsg       /* Put error message here if not 0 */
){
  int rc;
  sqlite3_mutex_enter(db->mutex);
  rc = sqlite3LoadExtension(db, zFile, zProc, pzErrMsg);
  rc = sqlite3ApiExit(db, rc);
  sqlite3_mutex_leave(db->mutex);
  return rc;
}

/*
** Call this routine when the database connection is closing in order
** to clean up loaded extensions
*/
void sqlite3CloseExtensions(sqlite3 *db){
  int i;
  assert( sqlite3_mutex_held(db->mutex) );
  for(i=0; i<db->nExtension; i++){
    sqlite3OsDlClose(db->pVfs, db->aExtension[i]);
  }
  sqlite3DbFree(db, db->aExtension);
}

/*
** Enable or disable extension loading.  Extension loading is disabled by
** default so as not to open security holes in older applications.
*/
int sqlite3_enable_load_extension(sqlite3 *db, int onoff){
#ifdef SQLITE_ENABLE_API_ARMOR
  if( !sqlite3SafetyCheckOk(db) ) return SQLITE_MISUSE_BKPT;
#endif
  sqlite3_mutex_enter(db->mutex);
  if( onoff ){
    db->flags |= SQLITE_LoadExtension|SQLITE_LoadExtFunc;
  }else{
    db->flags &= ~(u64)(SQLITE_LoadExtension|SQLITE_LoadExtFunc);
  }
  sqlite3_mutex_leave(db->mutex);
  return SQLITE_OK;
}

#endif /* !defined(SQLITE_OMIT_LOAD_EXTENSION) */

/*
** The following object holds the list of automatically loaded
** extensions.
**
** This list is shared across threads.  The SQLITE_MUTEX_STATIC_MAIN
** mutex must be held while accessing this list.
*/
typedef struct sqlite3AutoExtList sqlite3AutoExtList;
static SQLITE_WSD struct sqlite3AutoExtList {
  u32 nExt;              /* Number of entries in aExt[] */
  void (**aExt)(void);   /* Pointers to the extension init functions */
} sqlite3Autoext = { 0, 0 };

/* The "wsdAutoext" macro will resolve to the autoextension
** state vector.  If writable data is unsupported on the target,
** we have to locate the state vector at run-time.  In the more common
** case where writable static data is supported, wsdStat can refer directly
** to the "sqlite3Autoext" state vector declared above.
*/
#ifdef SQLITE_OMIT_WSD
# define wsdAutoextInit \
  sqlite3AutoExtList *x = &GLOBAL(sqlite3AutoExtList,sqlite3Autoext)
# define wsdAutoext x[0]
#else
# define wsdAutoextInit
# define wsdAutoext sqlite3Autoext
#endif


/*
** Register a statically linked extension that is automatically
** loaded by every new database connection.
*/
int sqlite3_auto_extension(
  void (*xInit)(void)
){
  int rc = SQLITE_OK;
#ifdef SQLITE_ENABLE_API_ARMOR
  if( xInit==0 ) return SQLITE_MISUSE_BKPT;
#endif
#ifndef SQLITE_OMIT_AUTOINIT
  rc = sqlite3_initialize();
  if( rc ){
    return rc;
  }else
#endif
  {
    u32 i;
#if SQLITE_THREADSAFE
    sqlite3_mutex *mutex = sqlite3MutexAlloc(SQLITE_MUTEX_STATIC_MAIN);
#endif
    wsdAutoextInit;
    sqlite3_mutex_enter(mutex);
    for(i=0; i<wsdAutoext.nExt; i++){
      if( wsdAutoext.aExt[i]==xInit ) break;
    }
    if( i==wsdAutoext.nExt ){
      u64 nByte = (wsdAutoext.nExt+1)*sizeof(wsdAutoext.aExt[0]);
      void (**aNew)(void);
      aNew = sqlite3_realloc64(wsdAutoext.aExt, nByte);
      if( aNew==0 ){
        rc = SQLITE_NOMEM_BKPT;
      }else{
        wsdAutoext.aExt = aNew;
        wsdAutoext.aExt[wsdAutoext.nExt] = xInit;
        wsdAutoext.nExt++;
      }
    }
    sqlite3_mutex_leave(mutex);
    assert( (rc&0xff)==rc );
    return rc;
  }
}

/*
** Cancel a prior call to sqlite3_auto_extension.  Remove xInit from the
** set of routines that is invoked for each new database connection, if it
** is currently on the list.  If xInit is not on the list, then this
** routine is a no-op.
**
** Return 1 if xInit was found on the list and removed.  Return 0 if xInit
** was not on the list.
*/
int sqlite3_cancel_auto_extension(
  void (*xInit)(void)
){
#if SQLITE_THREADSAFE
  sqlite3_mutex *mutex = sqlite3MutexAlloc(SQLITE_MUTEX_STATIC_MAIN);
#endif
  int i;
  int n = 0;
  wsdAutoextInit;
#ifdef SQLITE_ENABLE_API_ARMOR
  if( xInit==0 ) return 0;
#endif
  sqlite3_mutex_enter(mutex);
  for(i=(int)wsdAutoext.nExt-1; i>=0; i--){
    if( wsdAutoext.aExt[i]==xInit ){
      wsdAutoext.nExt--;
      wsdAutoext.aExt[i] = wsdAutoext.aExt[wsdAutoext.nExt];
      n++;
      break;
    }
  }
  sqlite3_mutex_leave(mutex);
  return n;
}

/*
** Reset the automatic extension loading mechanism.
*/
void sqlite3_reset_auto_extension(void){
#ifndef SQLITE_OMIT_AUTOINIT
  if( sqlite3_initialize()==SQLITE_OK )
#endif
  {
#if SQLITE_THREADSAFE
    sqlite3_mutex *mutex = sqlite3MutexAlloc(SQLITE_MUTEX_STATIC_MAIN);
#endif
    wsdAutoextInit;
    sqlite3_mutex_enter(mutex);
    sqlite3_free(wsdAutoext.aExt);
    wsdAutoext.aExt = 0;
    wsdAutoext.nExt = 0;
    sqlite3_mutex_leave(mutex);
  }
}

/*
** Load all automatic extensions.
**
** If anything goes wrong, set an error in the database connection.
*/
void sqlite3AutoLoadExtensions(sqlite3 *db){
  u32 i;
  int go = 1;
  int rc;
  sqlite3_loadext_entry xInit;

  wsdAutoextInit;
  if( wsdAutoext.nExt==0 ){
    /* Common case: early out without every having to acquire a mutex */
    return;
  }
  for(i=0; go; i++){
    char *zErrmsg;
#if SQLITE_THREADSAFE
    sqlite3_mutex *mutex = sqlite3MutexAlloc(SQLITE_MUTEX_STATIC_MAIN);
#endif
#ifdef SQLITE_OMIT_LOAD_EXTENSION
    const sqlite3_api_routines *pThunk = 0;
#else
    const sqlite3_api_routines *pThunk = &sqlite3Apis;
#endif
    sqlite3_mutex_enter(mutex);
    if( i>=wsdAutoext.nExt ){
      xInit = 0;
      go = 0;
    }else{
      xInit = (sqlite3_loadext_entry)wsdAutoext.aExt[i];
    }
    sqlite3_mutex_leave(mutex);
    zErrmsg = 0;
    int rc = xInit(db, &zErrmsg, pThunk);
    if( xInit && rc!=0 ){
      sqlite3ErrorWithMsg(db, rc,
            "automatic extension loading failed: %s", zErrmsg);
      go = 0;
    }
    // if( xInit && (rc = xInit(db, &zErrmsg, pThunk))!=0 ){
    //   sqlite3ErrorWithMsg(db, rc,
    //         "automatic extension loading failed: %s", zErrmsg);
    //   go = 0;
    // }
    sqlite3_free(zErrmsg);
  }
}
