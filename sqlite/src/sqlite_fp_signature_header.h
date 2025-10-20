#ifndef SQLITE_FP_SIGNATURE_HEADER_H
#define SQLITE_FP_SIGNATURE_HEADER_H

/*
 * SQLite Function Pointer Signatures - Header
 * Auto-generated file - DO NOT EDIT MANUALLY
 */

#include <stdlib.h>
#include <time.h>
#include <string.h>

#include "sqliteInt.h"

typedef struct MemPage MemPage;
typedef struct BtLock BtLock;
typedef struct Btree Btree;
typedef struct BtShared BtShared;
typedef struct CellInfo CellInfo;
typedef struct BtCursor BtCursor;
typedef struct IntegrityCk IntegrityCk;
typedef struct sqlite3_tokenizer_module sqlite3_tokenizer_module;
typedef struct sqlite3_tokenizer sqlite3_tokenizer;
typedef struct sqlite3_tokenizer_cursor sqlite3_tokenizer_cursor;
typedef struct Fts5Index Fts5Index;
typedef struct Fts5Iter Fts5Iter;
typedef struct Fts5Buffer Fts5Buffer;
typedef struct Fts5Expr Fts5Expr;
typedef struct Fts5ExprNode Fts5ExprNode;
typedef struct Fts5SegIter Fts5SegIter;
typedef struct ReInput ReInput;
                              

#ifndef SIGNATURE_ASSIGN
#define SIGNATURE_ASSIGN(struct_var, fp_name, func_name) \
  do { \
    (struct_var).fp_name##_signature[0] = fp_name##_signatures[fp_name##_##func_name##_enum][0]; \
    (struct_var).fp_name##_signature[1] = fp_name##_signatures[fp_name##_##func_name##_enum][1]; \
    (struct_var).fp_name##_signature[2] = fp_name##_signatures[fp_name##_##func_name##_enum][2]; \
    (struct_var).fp_name##_signature[3] = fp_name##_signatures[fp_name##_##func_name##_enum][3]; \
  } while(0)
#endif

int vfstraceOut(const char *z, void *pArg);

// =============== aggregate_context ===============
// aggregate_context function pointer signatures (extern)
static int aggregate_context_signatures[1][4] = {0,};

// aggregate_context function enumeration
typedef enum {
    aggregate_context_sqlite3_aggregate_context_enum = 0
} aggregate_context_enum;

// aggregate_context signature initialization function
void init_aggregate_context_signatures(void);
// aggregate_context function declarations
void *sqlite3_aggregate_context(sqlite3_context *p, int nByte);

// =============== auto_extension ===============
// auto_extension function pointer signatures (extern)
static int auto_extension_signatures[1][4] = {0,};

// auto_extension function enumeration
typedef enum {
    auto_extension_sqlite3_vtab_config_enum = 0
} auto_extension_enum;

// auto_extension signature initialization function
void init_auto_extension_signatures(void);
// auto_extension function declarations
int sqlite3_vtab_config(sqlite3 *db, int op, ...);

// =============== backup_finish ===============
// backup_finish function pointer signatures (extern)
static int backup_finish_signatures[1][4] = {0,};

// backup_finish function enumeration
typedef enum {
    backup_finish_sqlite3_result_error_code_enum = 0
} backup_finish_enum;

// backup_finish signature initialization function
void init_backup_finish_signatures(void);
// backup_finish function declarations
void sqlite3_result_error_code(sqlite3_context *pCtx, int errCode);

// =============== backup_init ===============
// backup_init function pointer signatures (extern)
static int backup_init_signatures[1][4] = {0,};

// backup_init function enumeration
typedef enum {
    backup_init_sqlite3_test_control_enum = 0
} backup_init_enum;

// backup_init signature initialization function
void init_backup_init_signatures(void);
// backup_init function declarations
int sqlite3_test_control(int op, ...);

// =============== backup_pagecount ===============
// backup_pagecount function pointer signatures (extern)
static int backup_pagecount_signatures[1][4] = {0,};

// backup_pagecount function enumeration
typedef enum {
    backup_pagecount_sqlite3_randomness_enum = 0
} backup_pagecount_enum;

// backup_pagecount signature initialization function
void init_backup_pagecount_signatures(void);
// backup_pagecount function declarations
void sqlite3_randomness(int N, void *pBuf);

// =============== backup_remaining ===============
// backup_remaining function pointer signatures (extern)
static int backup_remaining_signatures[1][4] = {0,};

// backup_remaining function enumeration
typedef enum {
    backup_remaining_sqlite3_context_db_handle_enum = 0
} backup_remaining_enum;

// backup_remaining signature initialization function
void init_backup_remaining_signatures(void);
// backup_remaining function declarations
sqlite3 *sqlite3_context_db_handle(sqlite3_context *p);

// =============== backup_step ===============
// backup_step function pointer signatures (extern)
static int backup_step_signatures[1][4] = {0,};

// backup_step function enumeration
typedef enum {
    backup_step_sqlite3_extended_result_codes_enum = 0
} backup_step_enum;

// backup_step signature initialization function
void init_backup_step_signatures(void);
// backup_step function declarations
int sqlite3_extended_result_codes(sqlite3 *db, int onoff);

// =============== bind_blob64 ===============
// bind_blob64 function pointer signatures (extern)
static int bind_blob64_signatures[1][4] = {0,};

// bind_blob64 function enumeration
typedef enum {
    bind_blob64_sqlite3_vtab_on_conflict_enum = 0
} bind_blob64_enum;

// bind_blob64 signature initialization function
void init_bind_blob64_signatures(void);
// bind_blob64 function declarations
int sqlite3_vtab_on_conflict(sqlite3 *db);

// =============== bind_int ===============
// bind_int function pointer signatures (extern)
static int bind_int_signatures[1][4] = {0,};

// bind_int function enumeration
typedef enum {
    bind_int_sqlite3_bind_double_enum = 0
} bind_int_enum;

// bind_int signature initialization function
void init_bind_int_signatures(void);
// bind_int function declarations
int sqlite3_bind_double(sqlite3_stmt *pStmt, int i, double rValue);

// =============== bind_int64 ===============
// bind_int64 function pointer signatures (extern)
static int bind_int64_signatures[1][4] = {0,};

// bind_int64 function enumeration
typedef enum {
    bind_int64_sqlite3_bind_int_enum = 0
} bind_int64_enum;

// bind_int64 signature initialization function
void init_bind_int64_signatures(void);
// bind_int64 function declarations
int sqlite3_bind_int(sqlite3_stmt *p, int i, int iValue);

// =============== bind_null ===============
// bind_null function pointer signatures (extern)
static int bind_null_signatures[1][4] = {0,};

// bind_null function enumeration
typedef enum {
    bind_null_sqlite3_bind_int64_enum = 0
} bind_null_enum;

// bind_null signature initialization function
void init_bind_null_signatures(void);
// bind_null function declarations
int sqlite3_bind_int64(sqlite3_stmt *pStmt, int i, sqlite_int64 iValue);

// =============== bind_parameter_count ===============
// bind_parameter_count function pointer signatures (extern)
static int bind_parameter_count_signatures[1][4] = {0,};

// bind_parameter_count function enumeration
typedef enum {
    bind_parameter_count_sqlite3_bind_null_enum = 0
} bind_parameter_count_enum;

// bind_parameter_count signature initialization function
void init_bind_parameter_count_signatures(void);
// bind_parameter_count function declarations
int sqlite3_bind_null(sqlite3_stmt *pStmt, int i);

// =============== bind_parameter_index ===============
// bind_parameter_index function pointer signatures (extern)
static int bind_parameter_index_signatures[1][4] = {0,};

// bind_parameter_index function enumeration
typedef enum {
    bind_parameter_index_sqlite3_bind_parameter_count_enum = 0
} bind_parameter_index_enum;

// bind_parameter_index signature initialization function
void init_bind_parameter_index_signatures(void);
// bind_parameter_index function declarations
int sqlite3_bind_parameter_count(sqlite3_stmt *pStmt);

// =============== bind_parameter_name ===============
// bind_parameter_name function pointer signatures (extern)
static int bind_parameter_name_signatures[1][4] = {0,};

// bind_parameter_name function enumeration
typedef enum {
    bind_parameter_name_sqlite3_bind_parameter_index_enum = 0
} bind_parameter_name_enum;

// bind_parameter_name signature initialization function
void init_bind_parameter_name_signatures(void);
// bind_parameter_name function declarations
int sqlite3_bind_parameter_index(sqlite3_stmt *pStmt, const char *zName);

// =============== bind_text ===============
// bind_text function pointer signatures (extern)
static int bind_text_signatures[1][4] = {0,};

// bind_text function enumeration
typedef enum {
    bind_text_sqlite3_bind_parameter_name_enum = 0
} bind_text_enum;

// bind_text signature initialization function
void init_bind_text_signatures(void);
// bind_text function declarations
const char *sqlite3_bind_parameter_name(sqlite3_stmt *pStmt, int i);

// =============== bind_text16 ===============
// bind_text16 function pointer signatures (extern)
static int bind_text16_signatures[1][4] = {0,};

// bind_text16 function enumeration
typedef enum {
    bind_text16_sqlite3_bind_text_enum = 0
} bind_text16_enum;

// bind_text16 signature initialization function
void init_bind_text16_signatures(void);
// bind_text16 function declarations
int sqlite3_bind_text( sqlite3_stmt *pStmt, int i, const char *zData, int nData, void (*xDel)(void*) );

// =============== bind_text64 ===============
// bind_text64 function pointer signatures (extern)
static int bind_text64_signatures[1][4] = {0,};

// bind_text64 function enumeration
typedef enum {
    bind_text64_sqlite3_close_v2_enum = 0
} bind_text64_enum;

// bind_text64 signature initialization function
void init_bind_text64_signatures(void);
// bind_text64 function declarations
int sqlite3_close_v2(sqlite3 *db);

// =============== bind_value ===============
// bind_value function pointer signatures (extern)
static int bind_value_signatures[1][4] = {0,};

// bind_value function enumeration
typedef enum {
    bind_value_sqlite3_bind_text16_enum = 0
} bind_value_enum;

// bind_value signature initialization function
void init_bind_value_signatures(void);
// bind_value function declarations
int sqlite3_bind_text16(sqlite3_stmt*, int, const void*, int, void(*)(void*));

// =============== bind_zeroblob ===============
// bind_zeroblob function pointer signatures (extern)
static int bind_zeroblob_signatures[1][4] = {0,};

// bind_zeroblob function enumeration
typedef enum {
    bind_zeroblob_sqlite3_prepare_v2_enum = 0
} bind_zeroblob_enum;

// bind_zeroblob signature initialization function
void init_bind_zeroblob_signatures(void);
// bind_zeroblob function declarations
int sqlite3_prepare_v2( sqlite3 *db, const char *zSql, int nBytes, sqlite3_stmt **ppStmt, const char **pzTail );

// =============== bind_zeroblob64 ===============
// bind_zeroblob64 function pointer signatures (extern)
static int bind_zeroblob64_signatures[1][4] = {0,};

// bind_zeroblob64 function enumeration
typedef enum {
    bind_zeroblob64_sqlite3_auto_extension_enum = 0
} bind_zeroblob64_enum;

// bind_zeroblob64 signature initialization function
void init_bind_zeroblob64_signatures(void);
// bind_zeroblob64 function declarations
int sqlite3_auto_extension(void(*xEntryPoint)(void));

// =============== blob_bytes ===============
// blob_bytes function pointer signatures (extern)
static int blob_bytes_signatures[1][4] = {0,};

// blob_bytes function enumeration
typedef enum {
    blob_bytes_sqlite3_prepare16_v2_enum = 0
} blob_bytes_enum;

// blob_bytes signature initialization function
void init_blob_bytes_signatures(void);
// blob_bytes function declarations
int sqlite3_prepare16_v2( sqlite3 *db, const void *zSql, int nBytes, sqlite3_stmt **ppStmt, const void **pzTail );

// =============== blob_close ===============
// blob_close function pointer signatures (extern)
static int blob_close_signatures[1][4] = {0,};

// blob_close function enumeration
typedef enum {
    blob_close_sqlite3_clear_bindings_enum = 0
} blob_close_enum;

// blob_close signature initialization function
void init_blob_close_signatures(void);
// blob_close function declarations
int sqlite3_clear_bindings(sqlite3_stmt *pStmt);

// =============== blob_open ===============
// blob_open function pointer signatures (extern)
static int blob_open_signatures[1][4] = {0,};

// blob_open function enumeration
typedef enum {
    blob_open_sqlite3_create_module_v2_enum = 0
} blob_open_enum;

// blob_open signature initialization function
void init_blob_open_signatures(void);
// blob_open function declarations
int sqlite3_create_module_v2( sqlite3 *db, const char *zName, const sqlite3_module *pModule, void *pAux, void (*xDestroy)(void *) );

// =============== blob_read ===============
// blob_read function pointer signatures (extern)
static int blob_read_signatures[1][4] = {0,};

// blob_read function enumeration
typedef enum {
    blob_read_sqlite3_bind_zeroblob_enum = 0
} blob_read_enum;

// blob_read signature initialization function
void init_blob_read_signatures(void);
// blob_read function declarations
int sqlite3_bind_zeroblob(sqlite3_stmt *pStmt, int i, int n);

// =============== blob_reopen ===============
// blob_reopen function pointer signatures (extern)
static int blob_reopen_signatures[1][4] = {0,};

// blob_reopen function enumeration
typedef enum {
    blob_reopen_sqlite3_db_status_enum = 0
} blob_reopen_enum;

// blob_reopen signature initialization function
void init_blob_reopen_signatures(void);
// blob_reopen function declarations
int sqlite3_db_status( sqlite3 *db, int op, int *pCurrent, int *pHighwater, int resetFlag );

// =============== blob_write ===============
// blob_write function pointer signatures (extern)
static int blob_write_signatures[1][4] = {0,};

// blob_write function enumeration
typedef enum {
    blob_write_sqlite3_blob_bytes_enum = 0
} blob_write_enum;

// blob_write signature initialization function
void init_blob_write_signatures(void);
// blob_write function declarations
int sqlite3_blob_bytes(sqlite3_blob *);

// =============== busy_handler ===============
// busy_handler function pointer signatures (extern)
static int busy_handler_signatures[1][4] = {0,};

// busy_handler function enumeration
typedef enum {
    busy_handler_sqlite3_bind_value_enum = 0
} busy_handler_enum;

// busy_handler signature initialization function
void init_busy_handler_signatures(void);
// busy_handler function declarations
int sqlite3_bind_value(sqlite3_stmt*, int, const sqlite3_value*);

// =============== busy_timeout ===============
// busy_timeout function pointer signatures (extern)
static int busy_timeout_signatures[1][4] = {0,};

// busy_timeout function enumeration
typedef enum {
    busy_timeout_sqlite3_busy_handler_enum = 0
} busy_timeout_enum;

// busy_timeout signature initialization function
void init_busy_timeout_signatures(void);
// busy_timeout function declarations
int sqlite3_busy_handler( sqlite3 *db, int (*xBusy)(void*,int), void *pArg );

// =============== cancel_auto_extension ===============
// cancel_auto_extension function pointer signatures (extern)
static int cancel_auto_extension_signatures[1][4] = {0,};

// cancel_auto_extension function enumeration
typedef enum {
    cancel_auto_extension_sqlite3_db_filename_enum = 0
} cancel_auto_extension_enum;

// cancel_auto_extension signature initialization function
void init_cancel_auto_extension_signatures(void);
// cancel_auto_extension function declarations
const char *sqlite3_db_filename(sqlite3 *db, const char *zDbName);

// =============== changes ===============
// changes function pointer signatures (extern)
static int changes_signatures[1][4] = {0,};

// changes function enumeration
typedef enum {
    changes_sqlite3_busy_timeout_enum = 0
} changes_enum;

// changes signature initialization function
void init_changes_signatures(void);
// changes function declarations
int sqlite3_busy_timeout(sqlite3*, int ms);

// =============== changes64 ===============
// changes64 function pointer signatures (extern)
static int changes64_signatures[1][4] = {0,};

// changes64 function enumeration
typedef enum {
    changes64_sqlite3_str_value_enum = 0
} changes64_enum;

// changes64 signature initialization function
void init_changes64_signatures(void);
// changes64 function declarations
char *sqlite3_str_value(sqlite3_str *p);

// =============== clear_bindings ===============
// clear_bindings function pointer signatures (extern)
static int clear_bindings_signatures[1][4] = {0,};

// clear_bindings function enumeration
typedef enum {
    clear_bindings_sqlite3_vmprintf_enum = 0
} clear_bindings_enum;

// clear_bindings signature initialization function
void init_clear_bindings_signatures(void);
// clear_bindings function declarations
char *sqlite3_vmprintf(const char *zFormat, va_list ap);

// =============== close ===============
// close function pointer signatures (extern)
static int close_signatures[1][4] = {0,};

// close function enumeration
typedef enum {
    close_sqlite3_changes_enum = 0
} close_enum;

// close signature initialization function
void init_close_signatures(void);
// close function declarations
int sqlite3_changes(sqlite3 *db);

// =============== close_v2 ===============
// close_v2 function pointer signatures (extern)
static int close_v2_signatures[1][4] = {0,};

// close_v2 function enumeration
typedef enum {
    close_v2_sqlite3_soft_heap_limit64_enum = 0
} close_v2_enum;

// close_v2 signature initialization function
void init_close_v2_signatures(void);
// close_v2 function declarations
sqlite3_int64 sqlite3_soft_heap_limit64(sqlite3_int64 N);

// =============== collation_needed ===============
// collation_needed function pointer signatures (extern)
static int collation_needed_signatures[1][4] = {0,};

// collation_needed function enumeration
typedef enum {
    collation_needed_sqlite3_close_enum = 0
} collation_needed_enum;

// collation_needed signature initialization function
void init_collation_needed_signatures(void);
// collation_needed function declarations
int sqlite3_close(sqlite3 *db);

// =============== collation_needed16 ===============
// collation_needed16 function pointer signatures (extern)
static int collation_needed16_signatures[1][4] = {0,};

// collation_needed16 function enumeration
typedef enum {
    collation_needed16_sqlite3_collation_needed_enum = 0
} collation_needed16_enum;

// collation_needed16 signature initialization function
void init_collation_needed16_signatures(void);
// collation_needed16 function declarations
int sqlite3_collation_needed( sqlite3*, void*, void(*)(void*,sqlite3*,int eTextRep,const char*) );

// =============== column_blob ===============
// column_blob function pointer signatures (extern)
static int column_blob_signatures[1][4] = {0,};

// column_blob function enumeration
typedef enum {
    column_blob_sqlite3_collation_needed16_enum = 0
} column_blob_enum;

// column_blob signature initialization function
void init_column_blob_signatures(void);
// column_blob function declarations
int sqlite3_collation_needed16( sqlite3*, void*, void(*)(void*,sqlite3*,int eTextRep,const void*) );

// =============== column_bytes ===============
// column_bytes function pointer signatures (extern)
static int column_bytes_signatures[1][4] = {0,};

// column_bytes function enumeration
typedef enum {
    column_bytes_sqlite3_column_blob_enum = 0
} column_bytes_enum;

// column_bytes signature initialization function
void init_column_bytes_signatures(void);
// column_bytes function declarations
const void *sqlite3_column_blob(sqlite3_stmt *pStmt, int i);

// =============== column_bytes16 ===============
// column_bytes16 function pointer signatures (extern)
static int column_bytes16_signatures[1][4] = {0,};

// column_bytes16 function enumeration
typedef enum {
    column_bytes16_sqlite3_column_bytes_enum = 0
} column_bytes16_enum;

// column_bytes16 signature initialization function
void init_column_bytes16_signatures(void);
// column_bytes16 function declarations
int sqlite3_column_bytes(sqlite3_stmt *pStmt, int i);

// =============== column_count ===============
// column_count function pointer signatures (extern)
static int column_count_signatures[1][4] = {0,};

// column_count function enumeration
typedef enum {
    column_count_sqlite3_column_bytes16_enum = 0
} column_count_enum;

// column_count signature initialization function
void init_column_count_signatures(void);
// column_count function declarations
int sqlite3_column_bytes16(sqlite3_stmt *pStmt, int i);

// =============== column_database_name ===============
// column_database_name function pointer signatures (extern)
static int column_database_name_signatures[1][4] = {0,};

// column_database_name function enumeration
typedef enum {
    column_database_name_sqlite3_column_count_enum = 0
} column_database_name_enum;

// column_database_name signature initialization function
void init_column_database_name_signatures(void);
// column_database_name function declarations
int sqlite3_column_count(sqlite3_stmt *pStmt);

// =============== column_database_name16 ===============
// column_database_name16 function pointer signatures (extern)
static int column_database_name16_signatures[1][4] = {0,};

// column_database_name16 function enumeration
typedef enum {
    column_database_name16_sqlite3_column_database_name_enum = 0
} column_database_name16_enum;

// column_database_name16 signature initialization function
void init_column_database_name16_signatures(void);
// column_database_name16 function declarations
const char *sqlite3_column_database_name(sqlite3_stmt*,int);

// =============== column_decltype ===============
// column_decltype function pointer signatures (extern)
static int column_decltype_signatures[1][4] = {0,};

// column_decltype function enumeration
typedef enum {
    column_decltype_sqlite3_column_database_name16_enum = 0
} column_decltype_enum;

// column_decltype signature initialization function
void init_column_decltype_signatures(void);
// column_decltype function declarations
const void *sqlite3_column_database_name16(sqlite3_stmt*,int);

// =============== column_decltype16 ===============
// column_decltype16 function pointer signatures (extern)
static int column_decltype16_signatures[1][4] = {0,};

// column_decltype16 function enumeration
typedef enum {
    column_decltype16_sqlite3_column_decltype_enum = 0
} column_decltype16_enum;

// column_decltype16 signature initialization function
void init_column_decltype16_signatures(void);
// column_decltype16 function declarations
const char *sqlite3_column_decltype(sqlite3_stmt*,int);

// =============== column_double ===============
// column_double function pointer signatures (extern)
static int column_double_signatures[1][4] = {0,};

// column_double function enumeration
typedef enum {
    column_double_sqlite3_column_decltype16_enum = 0
} column_double_enum;

// column_double signature initialization function
void init_column_double_signatures(void);
// column_double function declarations
const void *sqlite3_column_decltype16(sqlite3_stmt*,int);

// =============== column_int ===============
// column_int function pointer signatures (extern)
static int column_int_signatures[1][4] = {0,};

// column_int function enumeration
typedef enum {
    column_int_sqlite3_column_double_enum = 0
} column_int_enum;

// column_int signature initialization function
void init_column_int_signatures(void);
// column_int function declarations
double sqlite3_column_double(sqlite3_stmt *pStmt, int i);

// =============== column_int64 ===============
// column_int64 function pointer signatures (extern)
static int column_int64_signatures[1][4] = {0,};

// column_int64 function enumeration
typedef enum {
    column_int64_sqlite3_column_int_enum = 0
} column_int64_enum;

// column_int64 signature initialization function
void init_column_int64_signatures(void);
// column_int64 function declarations
int sqlite3_column_int(sqlite3_stmt *pStmt, int i);

// =============== column_name ===============
// column_name function pointer signatures (extern)
static int column_name_signatures[1][4] = {0,};

// column_name function enumeration
typedef enum {
    column_name_sqlite3_column_int64_enum = 0
} column_name_enum;

// column_name signature initialization function
void init_column_name_signatures(void);
// column_name function declarations
sqlite_int64 sqlite3_column_int64(sqlite3_stmt *pStmt, int i);

// =============== column_name16 ===============
// column_name16 function pointer signatures (extern)
static int column_name16_signatures[1][4] = {0,};

// column_name16 function enumeration
typedef enum {
    column_name16_sqlite3_column_name_enum = 0
} column_name16_enum;

// column_name16 signature initialization function
void init_column_name16_signatures(void);
// column_name16 function declarations
const char *sqlite3_column_name(sqlite3_stmt *pStmt, int N);

// =============== column_origin_name ===============
// column_origin_name function pointer signatures (extern)
static int column_origin_name_signatures[1][4] = {0,};

// column_origin_name function enumeration
typedef enum {
    column_origin_name_sqlite3_column_name16_enum = 0
} column_origin_name_enum;

// column_origin_name signature initialization function
void init_column_origin_name_signatures(void);
// column_origin_name function declarations
const void *sqlite3_column_name16(sqlite3_stmt*, int N);

// =============== column_origin_name16 ===============
// column_origin_name16 function pointer signatures (extern)
static int column_origin_name16_signatures[1][4] = {0,};

// column_origin_name16 function enumeration
typedef enum {
    column_origin_name16_sqlite3_column_origin_name_enum = 0
} column_origin_name16_enum;

// column_origin_name16 signature initialization function
void init_column_origin_name16_signatures(void);
// column_origin_name16 function declarations
const char *sqlite3_column_origin_name(sqlite3_stmt*,int);

// =============== column_table_name ===============
// column_table_name function pointer signatures (extern)
static int column_table_name_signatures[1][4] = {0,};

// column_table_name function enumeration
typedef enum {
    column_table_name_sqlite3_column_origin_name16_enum = 0
} column_table_name_enum;

// column_table_name signature initialization function
void init_column_table_name_signatures(void);
// column_table_name function declarations
const void *sqlite3_column_origin_name16(sqlite3_stmt*,int);

// =============== column_table_name16 ===============
// column_table_name16 function pointer signatures (extern)
static int column_table_name16_signatures[1][4] = {0,};

// column_table_name16 function enumeration
typedef enum {
    column_table_name16_sqlite3_column_table_name_enum = 0
} column_table_name16_enum;

// column_table_name16 signature initialization function
void init_column_table_name16_signatures(void);
// column_table_name16 function declarations
const char *sqlite3_column_table_name(sqlite3_stmt*,int);

// =============== column_text ===============
// column_text function pointer signatures (extern)
static int column_text_signatures[1][4] = {0,};

// column_text function enumeration
typedef enum {
    column_text_sqlite3_column_table_name16_enum = 0
} column_text_enum;

// column_text signature initialization function
void init_column_text_signatures(void);
// column_text function declarations
const void *sqlite3_column_table_name16(sqlite3_stmt*,int);

// =============== column_text16 ===============
// column_text16 function pointer signatures (extern)
static int column_text16_signatures[1][4] = {0,};

// column_text16 function enumeration
typedef enum {
    column_text16_sqlite3_column_text_enum = 0
} column_text16_enum;

// column_text16 signature initialization function
void init_column_text16_signatures(void);
// column_text16 function declarations
const unsigned char *sqlite3_column_text(sqlite3_stmt *pStmt, int i);

// =============== column_type ===============
// column_type function pointer signatures (extern)
static int column_type_signatures[1][4] = {0,};

// column_type function enumeration
typedef enum {
    column_type_sqlite3_column_text16_enum = 0
} column_type_enum;

// column_type signature initialization function
void init_column_type_signatures(void);
// column_type function declarations
const void *sqlite3_column_text16(sqlite3_stmt*, int iCol);

// =============== column_value ===============
// column_value function pointer signatures (extern)
static int column_value_signatures[1][4] = {0,};

// column_value function enumeration
typedef enum {
    column_value_sqlite3_column_type_enum = 0
} column_value_enum;

// column_value signature initialization function
void init_column_value_signatures(void);
// column_value function declarations
int sqlite3_column_type(sqlite3_stmt*, int iCol);

// =============== commit_hook ===============
// commit_hook function pointer signatures (extern)
static int commit_hook_signatures[1][4] = {0,};

// commit_hook function enumeration
typedef enum {
    commit_hook_sqlite3_column_value_enum = 0
} commit_hook_enum;

// commit_hook signature initialization function
void init_commit_hook_signatures(void);
// commit_hook function declarations
sqlite3_value *sqlite3_column_value(sqlite3_stmt *pStmt, int i);

// =============== compileoption_get ===============
// compileoption_get function pointer signatures (extern)
static int compileoption_get_signatures[1][4] = {0,};

// compileoption_get function enumeration
typedef enum {
    compileoption_get_sqlite3_limit_enum = 0
} compileoption_get_enum;

// compileoption_get signature initialization function
void init_compileoption_get_signatures(void);
// compileoption_get function declarations
int sqlite3_limit(sqlite3 *db, int limitId, int newLimit);

// =============== compileoption_used ===============
// compileoption_used function pointer signatures (extern)
static int compileoption_used_signatures[1][4] = {0,};

// compileoption_used function enumeration
typedef enum {
    compileoption_used_sqlite3_next_stmt_enum = 0
} compileoption_used_enum;

// compileoption_used signature initialization function
void init_compileoption_used_signatures(void);
// compileoption_used function declarations
sqlite3_stmt *sqlite3_next_stmt(sqlite3 *pDb, sqlite3_stmt *pStmt);

// =============== complete ===============
// complete function pointer signatures (extern)
static int complete_signatures[1][4] = {0,};

// complete function enumeration
typedef enum {
    complete_sqlite3_commit_hook_enum = 0
} complete_enum;

// complete signature initialization function
void init_complete_signatures(void);
// complete function declarations
void *sqlite3_commit_hook(sqlite3*, int(*)(void*), void*);

// =============== complete16 ===============
// complete16 function pointer signatures (extern)
static int complete16_signatures[1][4] = {0,};

// complete16 function enumeration
typedef enum {
    complete16_sqlite3_complete_enum = 0
} complete16_enum;

// complete16 signature initialization function
void init_complete16_signatures(void);
// complete16 function declarations
int sqlite3_complete(const char *sql);

// =============== context_db_handle ===============
// context_db_handle function pointer signatures (extern)
static int context_db_handle_signatures[1][4] = {0,};

// context_db_handle function enumeration
typedef enum {
    context_db_handle_sqlite3_soft_heap_limit_enum = 0
} context_db_handle_enum;

// context_db_handle signature initialization function
void init_context_db_handle_signatures(void);
// context_db_handle function declarations
SQLITE_DEPRECATED void sqlite3_soft_heap_limit(int N);

// =============== create_collation ===============
// create_collation function pointer signatures (extern)
static int create_collation_signatures[1][4] = {0,};

// create_collation function enumeration
typedef enum {
    create_collation_sqlite3_complete16_enum = 0
} create_collation_enum;

// create_collation signature initialization function
void init_create_collation_signatures(void);
// create_collation function declarations
int sqlite3_complete16(const void *sql);

// =============== create_collation16 ===============
// create_collation16 function pointer signatures (extern)
static int create_collation16_signatures[1][4] = {0,};

// create_collation16 function enumeration
typedef enum {
    create_collation16_sqlite3_create_collation_enum = 0
} create_collation16_enum;

// create_collation16 signature initialization function
void init_create_collation16_signatures(void);
// create_collation16 function declarations
int sqlite3_create_collation( sqlite3*, const char *zName, int eTextRep, void *pArg, int(*xCompare)(void*,int,const void*,int,const void*) );

// =============== create_collation_v2 ===============
// create_collation_v2 function pointer signatures (extern)
static int create_collation_v2_signatures[1][4] = {0,};

// create_collation_v2 function enumeration
typedef enum {
    create_collation_v2_sqlite3_blob_close_enum = 0
} create_collation_v2_enum;

// create_collation_v2 signature initialization function
void init_create_collation_v2_signatures(void);
// create_collation_v2 function declarations
int sqlite3_blob_close(sqlite3_blob *);

// =============== create_filename ===============
// create_filename function pointer signatures (extern)
static int create_filename_signatures[1][4] = {0,};

// create_filename function enumeration
typedef enum {
    create_filename_sqlite3_str_appendchar_enum = 0
} create_filename_enum;

// create_filename signature initialization function
void init_create_filename_signatures(void);
// create_filename function declarations
void sqlite3_str_appendchar(sqlite3_str *p, int N, char c);

// =============== create_function ===============
// create_function function pointer signatures (extern)
static int create_function_signatures[1][4] = {0,};

// create_function function enumeration
typedef enum {
    create_function_sqlite3_create_collation16_enum = 0
} create_function_enum;

// create_function signature initialization function
void init_create_function_signatures(void);
// create_function function declarations
int sqlite3_create_collation16( sqlite3*, const void *zName, int eTextRep, void *pArg, int(*xCompare)(void*,int,const void*,int,const void*) );

// =============== create_function16 ===============
// create_function16 function pointer signatures (extern)
static int create_function16_signatures[1][4] = {0,};

// create_function16 function enumeration
typedef enum {
    create_function16_sqlite3_create_function_enum = 0
} create_function16_enum;

// create_function16 signature initialization function
void init_create_function16_signatures(void);
// create_function16 function declarations
int sqlite3_create_function( sqlite3 *db, const char *zFunc, int nArg, int enc, void *p, void (*xSFunc)(sqlite3_context*,int,sqlite3_value **), void (*xStep)(sqlite3_context*,int,sqlite3_value **), void (*xFinal)(sqlite3_context*) );

// =============== create_function_v2 ===============
// create_function_v2 function pointer signatures (extern)
static int create_function_v2_signatures[1][4] = {0,};

// create_function_v2 function enumeration
typedef enum {
    create_function_v2_sqlite3_sql_enum = 0
} create_function_v2_enum;

// create_function_v2 signature initialization function
void init_create_function_v2_signatures(void);
// create_function_v2 function declarations
const char *sqlite3_sql(sqlite3_stmt *pStmt);

// =============== create_module ===============
// create_module function pointer signatures (extern)
static int create_module_signatures[1][4] = {0,};

// create_module function enumeration
typedef enum {
    create_module_sqlite3_create_function16_enum = 0
} create_module_enum;

// create_module signature initialization function
void init_create_module_signatures(void);
// create_module function declarations
int sqlite3_create_function16( sqlite3 *db, const void *zFunctionName, int nArg, int eTextRep, void *pApp, void (*xFunc)(sqlite3_context*,int,sqlite3_value**), void (*xStep)(sqlite3_context*,int,sqlite3_value**), void (*xFinal)(sqlite3_context*) );

// =============== create_module_v2 ===============
// create_module_v2 function pointer signatures (extern)
static int create_module_v2_signatures[1][4] = {0,};

// create_module_v2 function enumeration
typedef enum {
    create_module_v2_sqlite3_overload_function_enum = 0
} create_module_v2_enum;

// create_module_v2 signature initialization function
void init_create_module_v2_signatures(void);
// create_module_v2 function declarations
int sqlite3_overload_function( sqlite3 *db, const char *zName, int nArg );

// =============== create_window_function ===============
// create_window_function function pointer signatures (extern)
static int create_window_function_signatures[1][4] = {0,};

// create_window_function function enumeration
typedef enum {
    create_window_function_sqlite3_vtab_collation_enum = 0
} create_window_function_enum;

// create_window_function signature initialization function
void init_create_window_function_signatures(void);
// create_window_function function declarations
const char *sqlite3_vtab_collation(sqlite3_index_info *pIdxInfo, int iCons);

// =============== data_count ===============
// data_count function pointer signatures (extern)
static int data_count_signatures[1][4] = {0,};

// data_count function enumeration
typedef enum {
    data_count_sqlite3_create_module_enum = 0
} data_count_enum;

// data_count signature initialization function
void init_data_count_signatures(void);
// data_count function declarations
int sqlite3_create_module( sqlite3 *db, const char *zName, const sqlite3_module *pModule, void *pAux );

// =============== database_file_object ===============
// database_file_object function pointer signatures (extern)
static int database_file_object_signatures[1][4] = {0,};

// database_file_object function enumeration
typedef enum {
    database_file_object_sqlite3_str_errcode_enum = 0
} database_file_object_enum;

// database_file_object signature initialization function
void init_database_file_object_signatures(void);
// database_file_object function declarations
int sqlite3_str_errcode(sqlite3_str *p);

// =============== db_cacheflush ===============
// db_cacheflush function pointer signatures (extern)
static int db_cacheflush_signatures[1][4] = {0,};

// db_cacheflush function enumeration
typedef enum {
    db_cacheflush_sqlite3_malloc64_enum = 0
} db_cacheflush_enum;

// db_cacheflush signature initialization function
void init_db_cacheflush_signatures(void);
// db_cacheflush function declarations
void *sqlite3_malloc64(sqlite3_uint64);

// =============== db_config ===============
// db_config function pointer signatures (extern)
static int db_config_signatures[1][4] = {0,};

// db_config function enumeration
typedef enum {
    db_config_sqlite3_status_enum = 0
} db_config_enum;

// db_config signature initialization function
void init_db_config_signatures(void);
// db_config function declarations
int sqlite3_status(int op, int *pCurrent, int *pHighwater, int resetFlag);

// =============== db_filename ===============
// db_filename function pointer signatures (extern)
static int db_filename_signatures[1][4] = {0,};

// db_filename function enumeration
typedef enum {
    db_filename_sqlite3_sourceid_enum = 0
} db_filename_enum;

// db_filename signature initialization function
void init_db_filename_signatures(void);
// db_filename function declarations
const char *sqlite3_sourceid(void);

// =============== db_handle ===============
// db_handle function pointer signatures (extern)
static int db_handle_signatures[1][4] = {0,};

// db_handle function enumeration
typedef enum {
    db_handle_sqlite3_data_count_enum = 0
} db_handle_enum;

// db_handle signature initialization function
void init_db_handle_signatures(void);
// db_handle function declarations
int sqlite3_data_count(sqlite3_stmt *pStmt);

// =============== db_mutex ===============
// db_mutex function pointer signatures (extern)
static int db_mutex_signatures[1][4] = {0,};

// db_mutex function enumeration
typedef enum {
    db_mutex_sqlite3_backup_finish_enum = 0
} db_mutex_enum;

// db_mutex signature initialization function
void init_db_mutex_signatures(void);
// db_mutex function declarations
int sqlite3_backup_finish(sqlite3_backup *p);

// =============== db_name ===============
// db_name function pointer signatures (extern)
static int db_name_signatures[1][4] = {0,};

// db_name function enumeration
typedef enum {
    db_name_sqlite3_filename_journal_enum = 0
} db_name_enum;

// db_name signature initialization function
void init_db_name_signatures(void);
// db_name function declarations
const char *sqlite3_filename_journal(const char *zFilename);

// =============== db_readonly ===============
// db_readonly function pointer signatures (extern)
static int db_readonly_signatures[1][4] = {0,};

// db_readonly function enumeration
typedef enum {
    db_readonly_sqlite3_stmt_status_enum = 0
} db_readonly_enum;

// db_readonly signature initialization function
void init_db_readonly_signatures(void);
// db_readonly function declarations
int sqlite3_stmt_status(sqlite3_stmt *pStmt, int op, int resetFlag);

// =============== db_release_memory ===============
// db_release_memory function pointer signatures (extern)
static int db_release_memory_signatures[1][4] = {0,};

// db_release_memory function enumeration
typedef enum {
    db_release_memory_sqlite3_strnicmp_enum = 0
} db_release_memory_enum;

// db_release_memory signature initialization function
void init_db_release_memory_signatures(void);
// db_release_memory function declarations
int sqlite3_strnicmp(const char *zLeft, const char *zRight, int N);

// =============== db_status ===============
// db_status function pointer signatures (extern)
static int db_status_signatures[1][4] = {0,};

// db_status function enumeration
typedef enum {
    db_status_sqlite3_backup_init_enum = 0
} db_status_enum;

// db_status signature initialization function
void init_db_status_signatures(void);
// db_status function declarations
sqlite3_backup *sqlite3_backup_init( sqlite3 *pDest, const char *zDestName, sqlite3 *pSource, const char *zSourceName );

// =============== declare_vtab ===============
// declare_vtab function pointer signatures (extern)
static int declare_vtab_signatures[1][4] = {0,};

// declare_vtab function enumeration
typedef enum {
    declare_vtab_sqlite3_db_handle_enum = 0
} declare_vtab_enum;

// declare_vtab signature initialization function
void init_declare_vtab_signatures(void);
// declare_vtab function declarations
sqlite3 *sqlite3_db_handle(sqlite3_stmt*);

// =============== deserialize ===============
// deserialize function pointer signatures (extern)
static int deserialize_signatures[1][4] = {0,};

// deserialize function enumeration
typedef enum {
    deserialize_sqlite3_uri_key_enum = 0
} deserialize_enum;

// deserialize signature initialization function
void init_deserialize_signatures(void);
// deserialize function declarations
const char *sqlite3_uri_key(const char *zFilename, int N);

// =============== drop_modules ===============
// drop_modules function pointer signatures (extern)
static int drop_modules_signatures[1][4] = {0,};

// drop_modules function enumeration
typedef enum {
    drop_modules_sqlite3_str_new_enum = 0
} drop_modules_enum;

// drop_modules signature initialization function
void init_drop_modules_signatures(void);
// drop_modules function declarations
sqlite3_str *sqlite3_str_new(sqlite3 *db);

// =============== enable_shared_cache ===============
// enable_shared_cache function pointer signatures (extern)
static int enable_shared_cache_signatures[1][4] = {0,};

// enable_shared_cache function enumeration
typedef enum {
    enable_shared_cache_sqlite3_declare_vtab_enum = 0
} enable_shared_cache_enum;

// enable_shared_cache signature initialization function
void init_enable_shared_cache_signatures(void);
// enable_shared_cache function declarations
int sqlite3_declare_vtab(sqlite3 *db, const char *zCreateTable);

// =============== errcode ===============
// errcode function pointer signatures (extern)
static int errcode_signatures[1][4] = {0,};

// errcode function enumeration
typedef enum {
    errcode_sqlite3_enable_shared_cache_enum = 0
} errcode_enum;

// errcode signature initialization function
void init_errcode_signatures(void);
// errcode function declarations
int sqlite3_enable_shared_cache(int);

// =============== errmsg ===============
// errmsg function pointer signatures (extern)
static int errmsg_signatures[1][4] = {0,};

// errmsg function enumeration
typedef enum {
    errmsg_sqlite3_errcode_enum = 0
} errmsg_enum;

// errmsg signature initialization function
void init_errmsg_signatures(void);
// errmsg function declarations
int sqlite3_errcode(sqlite3 *db);

// =============== errmsg16 ===============
// errmsg16 function pointer signatures (extern)
static int errmsg16_signatures[1][4] = {0,};

// errmsg16 function enumeration
typedef enum {
    errmsg16_sqlite3_errmsg_enum = 0
} errmsg16_enum;

// errmsg16 signature initialization function
void init_errmsg16_signatures(void);
// errmsg16 function declarations
const char *sqlite3_errmsg(sqlite3 *db);

// =============== exec ===============
// exec function pointer signatures (extern)
static int exec_signatures[1][4] = {0,};

// exec function enumeration
typedef enum {
    exec_sqlite3_errmsg16_enum = 0
} exec_enum;

// exec signature initialization function
void init_exec_signatures(void);
// exec function declarations
const void *sqlite3_errmsg16(sqlite3*);

// =============== expanded_sql ===============
// expanded_sql function pointer signatures (extern)
static int expanded_sql_signatures[1][4] = {0,};

// expanded_sql function enumeration
typedef enum {
    expanded_sql_sqlite3_reset_auto_extension_enum = 0
} expanded_sql_enum;

// expanded_sql signature initialization function
void init_expanded_sql_signatures(void);
// expanded_sql function declarations
void sqlite3_reset_auto_extension(void);

// =============== expired ===============
// expired function pointer signatures (extern)
static int expired_signatures[2][4] = {0,};

// expired function enumeration
typedef enum {
    expired_0_enum = 0,
    expired_sqlite3_exec_enum = 1
} expired_enum;

// expired signature initialization function
void init_expired_signatures(void);
// expired function declarations
int sqlite3_exec( sqlite3*, const char *sql, int (*callback)(void*,int,char**,char**), void *, char **errmsg );

// =============== extended_errcode ===============
// extended_errcode function pointer signatures (extern)
static int extended_errcode_signatures[1][4] = {0,};

// extended_errcode function enumeration
typedef enum {
    extended_errcode_sqlite3_backup_pagecount_enum = 0
} extended_errcode_enum;

// extended_errcode signature initialization function
void init_extended_errcode_signatures(void);
// extended_errcode function declarations
int sqlite3_backup_pagecount(sqlite3_backup *p);

// =============== extended_result_codes ===============
// extended_result_codes function pointer signatures (extern)
static int extended_result_codes_signatures[1][4] = {0,};

// extended_result_codes function enumeration
typedef enum {
    extended_result_codes_sqlite3_vfs_find_enum = 0
} extended_result_codes_enum;

// extended_result_codes signature initialization function
void init_extended_result_codes_signatures(void);
// extended_result_codes function declarations
sqlite3_vfs *sqlite3_vfs_find(const char *zVfsName);

// =============== file_control ===============
// file_control function pointer signatures (extern)
static int file_control_signatures[1][4] = {0,};

// file_control function enumeration
typedef enum {
    file_control_sqlite3_blob_open_enum = 0
} file_control_enum;

// file_control signature initialization function
void init_file_control_signatures(void);
// file_control function declarations
int sqlite3_blob_open( sqlite3*, const char *zDb, const char *zTable, const char *zColumn, sqlite3_int64 iRow, int flags, sqlite3_blob **ppBlob );

// =============== filename_database ===============
// filename_database function pointer signatures (extern)
static int filename_database_signatures[1][4] = {0,};

// filename_database function enumeration
typedef enum {
    filename_database_sqlite3_str_vappendf_enum = 0
} filename_database_enum;

// filename_database signature initialization function
void init_filename_database_signatures(void);
// filename_database function declarations
void sqlite3_str_vappendf(sqlite3_str*, const char *zFormat, va_list);

// =============== filename_journal ===============
// filename_journal function pointer signatures (extern)
static int filename_journal_signatures[1][4] = {0,};

// filename_journal function enumeration
typedef enum {
    filename_journal_sqlite3_str_append_enum = 0
} filename_journal_enum;

// filename_journal signature initialization function
void init_filename_journal_signatures(void);
// filename_journal function declarations
void sqlite3_str_append(sqlite3_str *p, const char *z, int N);

// =============== filename_wal ===============
// filename_wal function pointer signatures (extern)
static int filename_wal_signatures[1][4] = {0,};

// filename_wal function enumeration
typedef enum {
    filename_wal_sqlite3_str_appendall_enum = 0
} filename_wal_enum;

// filename_wal signature initialization function
void init_filename_wal_signatures(void);
// filename_wal function declarations
void sqlite3_str_appendall(sqlite3_str *p, const char *z);

// =============== free_filename ===============
// free_filename function pointer signatures (extern)
static int free_filename_signatures[1][4] = {0,};

// free_filename function enumeration
typedef enum {
    free_filename_sqlite3_str_reset_enum = 0
} free_filename_enum;

// free_filename signature initialization function
void init_free_filename_signatures(void);
// free_filename function declarations
void sqlite3_str_reset(StrAccum *p);

// =============== get_autocommit ===============
// get_autocommit function pointer signatures (extern)
static int get_autocommit_signatures[1][4] = {0,};

// get_autocommit function enumeration
typedef enum {
    get_autocommit_sqlite3_free_enum = 0
} get_autocommit_enum;

// get_autocommit signature initialization function
void init_get_autocommit_signatures(void);
// get_autocommit function declarations
void sqlite3_free(void*);

// =============== get_auxdata ===============
// get_auxdata function pointer signatures (extern)
static int get_auxdata_signatures[1][4] = {0,};

// get_auxdata function enumeration
typedef enum {
    get_auxdata_sqlite3_free_table_enum = 0
} get_auxdata_enum;

// get_auxdata signature initialization function
void init_get_auxdata_signatures(void);
// get_auxdata function declarations
void sqlite3_free_table(char **result);

// =============== get_clientdata ===============
// get_clientdata function pointer signatures (extern)
static int get_clientdata_signatures[1][4] = {0,};

// get_clientdata function enumeration
typedef enum {
    get_clientdata_sqlite3_database_file_object_enum = 0
} get_clientdata_enum;

// get_clientdata signature initialization function
void init_get_clientdata_signatures(void);
// get_clientdata function declarations
sqlite3_file *sqlite3_database_file_object(const char *zName);

// =============== get_table ===============
// get_table function pointer signatures (extern)
static int get_table_signatures[1][4] = {0,};

// get_table function enumeration
typedef enum {
    get_table_sqlite3_get_autocommit_enum = 0
} get_table_enum;

// get_table signature initialization function
void init_get_table_signatures(void);
// get_table function declarations
int sqlite3_get_autocommit(sqlite3 *db);

// =============== global_recover ===============
// global_recover function pointer signatures (extern)
static int global_recover_signatures[1][4] = {0,};

// global_recover function enumeration
typedef enum {
    global_recover_sqlite3_get_auxdata_enum = 0
} global_recover_enum;

// global_recover signature initialization function
void init_global_recover_signatures(void);
// global_recover function declarations
void *sqlite3_get_auxdata(sqlite3_context *pCtx, int iArg);

// =============== hard_heap_limit64 ===============
// hard_heap_limit64 function pointer signatures (extern)
static int hard_heap_limit64_signatures[1][4] = {0,};

// hard_heap_limit64 function enumeration
typedef enum {
    hard_heap_limit64_sqlite3_str_finish_enum = 0
} hard_heap_limit64_enum;

// hard_heap_limit64 signature initialization function
void init_hard_heap_limit64_signatures(void);
// hard_heap_limit64 function declarations
char *sqlite3_str_finish(sqlite3_str *p);

// =============== interruptx ===============
// interruptx function pointer signatures (extern)
static int interruptx_signatures[1][4] = {0,};

// interruptx function enumeration
typedef enum {
    interruptx_sqlite3_get_table_enum = 0
} interruptx_enum;

// interruptx signature initialization function
void init_interruptx_signatures(void);
// interruptx function declarations
int sqlite3_get_table( sqlite3 *db, const char *zSql, char ***pazResult, int *pnRow, int *pnColumn, char **pzErrMsg );

// =============== is_interrupted ===============
// is_interrupted function pointer signatures (extern)
static int is_interrupted_signatures[1][4] = {0,};

// is_interrupted function enumeration
typedef enum {
    is_interrupted_sqlite3_create_filename_enum = 0
} is_interrupted_enum;

// is_interrupted signature initialization function
void init_is_interrupted_signatures(void);
// is_interrupted function declarations
const char *sqlite3_create_filename( const char *zDatabase, const char *zJournal, const char *zWal, int nParam, const char **azParam );

// =============== keyword_check ===============
// keyword_check function pointer signatures (extern)
static int keyword_check_signatures[1][4] = {0,};

// keyword_check function enumeration
typedef enum {
    keyword_check_sqlite3_db_cacheflush_enum = 0
} keyword_check_enum;

// keyword_check signature initialization function
void init_keyword_check_signatures(void);
// keyword_check function declarations
int sqlite3_db_cacheflush(sqlite3 *db);

// =============== keyword_count ===============
// keyword_count function pointer signatures (extern)
static int keyword_count_signatures[1][4] = {0,};

// keyword_count function enumeration
typedef enum {
    keyword_count_sqlite3_status64_enum = 0
} keyword_count_enum;

// keyword_count signature initialization function
void init_keyword_count_signatures(void);
// keyword_count function declarations
int sqlite3_status64( int op, sqlite3_int64 *pCurrent, sqlite3_int64 *pHighwater, int resetFlag );

// =============== keyword_name ===============
// keyword_name function pointer signatures (extern)
static int keyword_name_signatures[1][4] = {0,};

// keyword_name function enumeration
typedef enum {
    keyword_name_sqlite3_strlike_enum = 0
} keyword_name_enum;

// keyword_name signature initialization function
void init_keyword_name_signatures(void);
// keyword_name function declarations
int sqlite3_strlike(const char *zPattern, const char *zStr, unsigned int esc);

// =============== libversion ===============
// libversion function pointer signatures (extern)
static int libversion_signatures[1][4] = {0,};

// libversion function enumeration
typedef enum {
    libversion_sqlite3_interrupt_enum = 0
} libversion_enum;

// libversion signature initialization function
void init_libversion_signatures(void);
// libversion function declarations
void sqlite3_interrupt(sqlite3 *db);

// =============== libversion_number ===============
// libversion_number function pointer signatures (extern)
static int libversion_number_signatures[1][4] = {0,};

// libversion_number function enumeration
typedef enum {
    libversion_number_sqlite3_last_insert_rowid_enum = 0
} libversion_number_enum;

// libversion_number signature initialization function
void init_libversion_number_signatures(void);
// libversion_number function declarations
sqlite_int64 sqlite3_last_insert_rowid(sqlite3 *db);

// =============== limit ===============
// limit function pointer signatures (extern)
static int limit_signatures[1][4] = {0,};

// limit function enumeration
typedef enum {
    limit_sqlite3_vfs_register_enum = 0
} limit_enum;

// limit signature initialization function
void init_limit_signatures(void);
// limit function declarations
int sqlite3_vfs_register(sqlite3_vfs*, int makeDflt);

// =============== load_extension ===============
// load_extension function pointer signatures (extern)
static int load_extension_signatures[1][4] = {0,};

// load_extension function enumeration
typedef enum {
    load_extension_sqlite3_db_readonly_enum = 0
} load_extension_enum;

// load_extension signature initialization function
void init_load_extension_signatures(void);
// load_extension function declarations
int sqlite3_db_readonly(sqlite3 *db, const char *zDbName);

// =============== log ===============
// log function pointer signatures (extern)
static int log_signatures[1][4] = {0,};

// log function enumeration
typedef enum {
    log_sqlite3_backup_remaining_enum = 0
} log_enum;

// log signature initialization function
void init_log_signatures(void);
// log function declarations
int sqlite3_backup_remaining(sqlite3_backup *p);

// =============== malloc ===============
// malloc function pointer signatures (extern)
static int malloc_signatures[1][4] = {0,};

// malloc function enumeration
typedef enum {
    malloc_sqlite3_libversion_enum = 0
} malloc_enum;

// malloc signature initialization function
void init_malloc_signatures(void);
// malloc function declarations
const char *sqlite3_libversion(void);

// =============== malloc64 ===============
// malloc64 function pointer signatures (extern)
static int malloc64_signatures[1][4] = {0,};

// malloc64 function enumeration
typedef enum {
    malloc64_sqlite3_db_release_memory_enum = 0
} malloc64_enum;

// malloc64 signature initialization function
void init_malloc64_signatures(void);
// malloc64 function declarations
int sqlite3_db_release_memory(sqlite3 *db);

// =============== memory_highwater ===============
// memory_highwater function pointer signatures (extern)
static int memory_highwater_signatures[1][4] = {0,};

// memory_highwater function enumeration
typedef enum {
    memory_highwater_sqlite3_blob_read_enum = 0
} memory_highwater_enum;

// memory_highwater signature initialization function
void init_memory_highwater_signatures(void);
// memory_highwater function declarations
int sqlite3_blob_read(sqlite3_blob *, void *Z, int N, int iOffset);

// =============== memory_used ===============
// memory_used function pointer signatures (extern)
static int memory_used_signatures[1][4] = {0,};

// memory_used function enumeration
typedef enum {
    memory_used_sqlite3_blob_write_enum = 0
} memory_used_enum;

// memory_used signature initialization function
void init_memory_used_signatures(void);
// memory_used function declarations
int sqlite3_blob_write(sqlite3_blob *, const void *z, int n, int iOffset);

// =============== mprintf ===============
// mprintf function pointer signatures (extern)
static int mprintf_signatures[1][4] = {0,};

// mprintf function enumeration
typedef enum {
    mprintf_sqlite3_libversion_number_enum = 0
} mprintf_enum;

// mprintf signature initialization function
void init_mprintf_signatures(void);
// mprintf function declarations
int sqlite3_libversion_number(void);

// =============== msize ===============
// msize function pointer signatures (extern)
static int msize_signatures[1][4] = {0,};

// msize function enumeration
typedef enum {
    msize_sqlite3_errstr_enum = 0
} msize_enum;

// msize signature initialization function
void init_msize_signatures(void);
// msize function declarations
const char *sqlite3_errstr(int rc);

// =============== mutex_alloc ===============
// mutex_alloc function pointer signatures (extern)
static int mutex_alloc_signatures[1][4] = {0,};

// mutex_alloc function enumeration
typedef enum {
    mutex_alloc_sqlite3_create_collation_v2_enum = 0
} mutex_alloc_enum;

// mutex_alloc signature initialization function
void init_mutex_alloc_signatures(void);
// mutex_alloc function declarations
int sqlite3_create_collation_v2( sqlite3* db, const char *zName, int enc, void* pCtx, int(*xCompare)(void*,int,const void*,int,const void*), void(*xDel)(void*) );

// =============== mutex_enter ===============
// mutex_enter function pointer signatures (extern)
static int mutex_enter_signatures[1][4] = {0,};

// mutex_enter function enumeration
typedef enum {
    mutex_enter_sqlite3_file_control_enum = 0
} mutex_enter_enum;

// mutex_enter signature initialization function
void init_mutex_enter_signatures(void);
// mutex_enter function declarations
int sqlite3_file_control(sqlite3 *db, const char *zDbName, int op, void *pArg);

// =============== mutex_free ===============
// mutex_free function pointer signatures (extern)
static int mutex_free_signatures[1][4] = {0,};

// mutex_free function enumeration
typedef enum {
    mutex_free_sqlite3_memory_highwater_enum = 0
} mutex_free_enum;

// mutex_free signature initialization function
void init_mutex_free_signatures(void);
// mutex_free function declarations
sqlite3_int64 sqlite3_memory_highwater(int resetFlag);

// =============== mutex_leave ===============
// mutex_leave function pointer signatures (extern)
static int mutex_leave_signatures[1][4] = {0,};

// mutex_leave function enumeration
typedef enum {
    mutex_leave_sqlite3_memory_used_enum = 0
} mutex_leave_enum;

// mutex_leave signature initialization function
void init_mutex_leave_signatures(void);
// mutex_leave function declarations
sqlite3_int64 sqlite3_memory_used(void);

// =============== next_stmt ===============
// next_stmt function pointer signatures (extern)
static int next_stmt_signatures[1][4] = {0,};

// next_stmt function enumeration
typedef enum {
    next_stmt_sqlite3_vfs_unregister_enum = 0
} next_stmt_enum;

// next_stmt signature initialization function
void init_next_stmt_signatures(void);
// next_stmt function declarations
int sqlite3_vfs_unregister(sqlite3_vfs*);

// =============== normalized_sql ===============
// normalized_sql function pointer signatures (extern)
static int normalized_sql_signatures[1][4] = {0,};

// normalized_sql function enumeration
typedef enum {
    normalized_sql_sqlite3_keyword_count_enum = 0
} normalized_sql_enum;

// normalized_sql signature initialization function
void init_normalized_sql_signatures(void);
// normalized_sql function declarations
SQLITE_API int sqlite3_keyword_count(void);

// =============== open ===============
// open function pointer signatures (extern)
static int open_signatures[1][4] = {0,};

// open function enumeration
typedef enum {
    open_sqlite3_malloc_enum = 0
} open_enum;

// open signature initialization function
void init_open_signatures(void);
// open function declarations
void *sqlite3_malloc(int);

// =============== open16 ===============
// open16 function pointer signatures (extern)
static int open16_signatures[1][4] = {0,};

// open16 function enumeration
typedef enum {
    open16_sqlite3_mprintf_enum = 0
} open16_enum;

// open16 signature initialization function
void init_open16_signatures(void);
// open16 function declarations
char *sqlite3_mprintf(const char *zFormat, ...);

// =============== overload_function ===============
// overload_function function pointer signatures (extern)
static int overload_function_signatures[1][4] = {0,};

// overload_function function enumeration
typedef enum {
    overload_function_sqlite3_value_text16be_enum = 0
} overload_function_enum;

// overload_function signature initialization function
void init_overload_function_signatures(void);
// overload_function function declarations
const void *sqlite3_value_text16be(sqlite3_value *pVal);

// =============== prepare ===============
// prepare function pointer signatures (extern)
static int prepare_signatures[1][4] = {0,};

// prepare function enumeration
typedef enum {
    prepare_sqlite3_open_enum = 0
} prepare_enum;

// prepare signature initialization function
void init_prepare_signatures(void);
// prepare function declarations
int sqlite3_open( const char *zFilename, sqlite3 **ppDb );

// =============== prepare16 ===============
// prepare16 function pointer signatures (extern)
static int prepare16_signatures[1][4] = {0,};

// prepare16 function enumeration
typedef enum {
    prepare16_sqlite3_open16_enum = 0
} prepare16_enum;

// prepare16 signature initialization function
void init_prepare16_signatures(void);
// prepare16 function declarations
int sqlite3_open16( const void *filename, sqlite3 **ppDb );

// =============== prepare16_v2 ===============
// prepare16_v2 function pointer signatures (extern)
static int prepare16_v2_signatures[1][4] = {0,};

// prepare16_v2 function enumeration
typedef enum {
    prepare16_v2_sqlite3_value_type_enum = 0
} prepare16_v2_enum;

// prepare16_v2 signature initialization function
void init_prepare16_v2_signatures(void);
// prepare16_v2 function declarations
int sqlite3_value_type(sqlite3_value*);

// =============== prepare16_v3 ===============
// prepare16_v3 function pointer signatures (extern)
static int prepare16_v3_signatures[1][4] = {0,};

// prepare16_v3 function enumeration
typedef enum {
    prepare16_v3_sqlite3_strglob_enum = 0
} prepare16_v3_enum;

// prepare16_v3 signature initialization function
void init_prepare16_v3_signatures(void);
// prepare16_v3 function declarations
int sqlite3_strglob(const char *zGlobPattern, const char *zString);

// =============== prepare_v2 ===============
// prepare_v2 function pointer signatures (extern)
static int prepare_v2_signatures[1][4] = {0,};

// prepare_v2 function enumeration
typedef enum {
    prepare_v2_sqlite3_value_text16le_enum = 0
} prepare_v2_enum;

// prepare_v2 signature initialization function
void init_prepare_v2_signatures(void);
// prepare_v2 function declarations
const void *sqlite3_value_text16le(sqlite3_value *pVal);

// =============== prepare_v3 ===============
// prepare_v3 function pointer signatures (extern)
static int prepare_v3_signatures[1][4] = {0,};

// prepare_v3 function enumeration
typedef enum {
    prepare_v3_sqlite3_result_text64_enum = 0
} prepare_v3_enum;

// prepare_v3 signature initialization function
void init_prepare_v3_signatures(void);
// prepare_v3 function declarations
void sqlite3_result_text64( sqlite3_context *pCtx, const char *z, sqlite3_uint64 n, void (*xDel)(void *), unsigned char enc );

// =============== profile ===============
// profile function pointer signatures (extern)
static int profile_signatures[1][4] = {0,};

// profile function enumeration
typedef enum {
    profile_sqlite3_prepare_enum = 0
} profile_enum;

// profile signature initialization function
void init_profile_signatures(void);
// profile function declarations
int sqlite3_prepare( sqlite3 *db, const char *zSql, int nBytes, sqlite3_stmt **ppStmt, const char **pzTail );

// =============== progress_handler ===============
// progress_handler function pointer signatures (extern)
static int progress_handler_signatures[1][4] = {0,};

// progress_handler function enumeration
typedef enum {
    progress_handler_sqlite3_prepare16_enum = 0
} progress_handler_enum;

// progress_handler signature initialization function
void init_progress_handler_signatures(void);
// progress_handler function declarations
int sqlite3_prepare16( sqlite3 *db, const void *zSql, int nBytes, sqlite3_stmt **ppStmt, const void **pzTail );

// =============== randomness ===============
// randomness function pointer signatures (extern)
static int randomness_signatures[1][4] = {0,};

// randomness function enumeration
typedef enum {
    randomness_sqlite3_sleep_enum = 0
} randomness_enum;

// randomness signature initialization function
void init_randomness_signatures(void);
// randomness function declarations
int sqlite3_sleep(int ms);

// =============== realloc ===============
// realloc function pointer signatures (extern)
static int realloc_signatures[1][4] = {0,};

// realloc function enumeration
typedef enum {
    realloc_sqlite3_profile_enum = 0
} realloc_enum;

// realloc signature initialization function
void init_realloc_signatures(void);
// realloc function declarations
SQLITE_DEPRECATED void *sqlite3_profile(sqlite3*, void(*xProfile)(void*,const char*,sqlite3_uint64), void*);

// =============== realloc64 ===============
// realloc64 function pointer signatures (extern)
static int realloc64_signatures[1][4] = {0,};

// realloc64 function enumeration
typedef enum {
    realloc64_sqlite3_stmt_busy_enum = 0
} realloc64_enum;

// realloc64 signature initialization function
void init_realloc64_signatures(void);
// realloc64 function declarations
int sqlite3_stmt_busy(sqlite3_stmt *pStmt);

// =============== reset ===============
// reset function pointer signatures (extern)
static int reset_signatures[1][4] = {0,};

// reset function enumeration
typedef enum {
    reset_sqlite3_progress_handler_enum = 0
} reset_enum;

// reset signature initialization function
void init_reset_signatures(void);
// reset function declarations
void sqlite3_progress_handler(sqlite3*, int, int(*)(void*), void*);

// =============== reset_auto_extension ===============
// reset_auto_extension function pointer signatures (extern)
static int reset_auto_extension_signatures[1][4] = {0,};

// reset_auto_extension function enumeration
typedef enum {
    reset_auto_extension_sqlite3_stmt_readonly_enum = 0
} reset_auto_extension_enum;

// reset_auto_extension signature initialization function
void init_reset_auto_extension_signatures(void);
// reset_auto_extension function declarations
int sqlite3_stmt_readonly(sqlite3_stmt *pStmt);

// =============== result_blob ===============
// result_blob function pointer signatures (extern)
static int result_blob_signatures[1][4] = {0,};

// result_blob function enumeration
typedef enum {
    result_blob_sqlite3_realloc_enum = 0
} result_blob_enum;

// result_blob signature initialization function
void init_result_blob_signatures(void);
// result_blob function declarations
void *sqlite3_realloc(void*, int);

// =============== result_blob64 ===============
// result_blob64 function pointer signatures (extern)
static int result_blob64_signatures[1][4] = {0,};

// result_blob64 function enumeration
typedef enum {
    result_blob64_sqlite3_stricmp_enum = 0
} result_blob64_enum;

// result_blob64 signature initialization function
void init_result_blob64_signatures(void);
// result_blob64 function declarations
int sqlite3_stricmp(const char *, const char *);

// =============== result_double ===============
// result_double function pointer signatures (extern)
static int result_double_signatures[1][4] = {0,};

// result_double function enumeration
typedef enum {
    result_double_sqlite3_reset_enum = 0
} result_double_enum;

// result_double signature initialization function
void init_result_double_signatures(void);
// result_double function declarations
int sqlite3_reset(sqlite3_stmt *pStmt);

// =============== result_error ===============
// result_error function pointer signatures (extern)
static int result_error_signatures[1][4] = {0,};

// result_error function enumeration
typedef enum {
    result_error_sqlite3_result_blob_enum = 0
} result_error_enum;

// result_error signature initialization function
void init_result_error_signatures(void);
// result_error function declarations
void sqlite3_result_blob( sqlite3_context *pCtx, const void *z, int n, void (*xDel)(void *) );

// =============== result_error16 ===============
// result_error16 function pointer signatures (extern)
static int result_error16_signatures[1][4] = {0,};

// result_error16 function enumeration
typedef enum {
    result_error16_sqlite3_result_double_enum = 0
} result_error16_enum;

// result_error16 signature initialization function
void init_result_error16_signatures(void);
// result_error16 function declarations
void sqlite3_result_double(sqlite3_context *pCtx, double rVal);

// =============== result_error_code ===============
// result_error_code function pointer signatures (extern)
static int result_error_code_signatures[1][4] = {0,};

// result_error_code function enumeration
typedef enum {
    result_error_code_sqlite3_result_error_nomem_enum = 0
} result_error_code_enum;

// result_error_code signature initialization function
void init_result_error_code_signatures(void);
// result_error_code function declarations
void sqlite3_result_error_nomem(sqlite3_context *pCtx);

// =============== result_int ===============
// result_int function pointer signatures (extern)
static int result_int_signatures[1][4] = {0,};

// result_int function enumeration
typedef enum {
    result_int_sqlite3_result_error_enum = 0
} result_int_enum;

// result_int signature initialization function
void init_result_int_signatures(void);
// result_int function declarations
void sqlite3_result_error(sqlite3_context *pCtx, const char *z, int n);

// =============== result_int64 ===============
// result_int64 function pointer signatures (extern)
static int result_int64_signatures[1][4] = {0,};

// result_int64 function enumeration
typedef enum {
    result_int64_sqlite3_result_error16_enum = 0
} result_int64_enum;

// result_int64 signature initialization function
void init_result_int64_signatures(void);
// result_int64 function declarations
void sqlite3_result_error16(sqlite3_context*, const void*, int);

// =============== result_null ===============
// result_null function pointer signatures (extern)
static int result_null_signatures[1][4] = {0,};

// result_null function enumeration
typedef enum {
    result_null_sqlite3_result_int_enum = 0
} result_null_enum;

// result_null signature initialization function
void init_result_null_signatures(void);
// result_null function declarations
void sqlite3_result_int(sqlite3_context*, int);

// =============== result_pointer ===============
// result_pointer function pointer signatures (extern)
static int result_pointer_signatures[1][4] = {0,};

// result_pointer function enumeration
typedef enum {
    result_pointer_sqlite3_value_free_enum = 0
} result_pointer_enum;

// result_pointer signature initialization function
void init_result_pointer_signatures(void);
// result_pointer function declarations
void sqlite3_value_free(sqlite3_value *pOld);

// =============== result_subtype ===============
// result_subtype function pointer signatures (extern)
static int result_subtype_signatures[1][4] = {0,};

// result_subtype function enumeration
typedef enum {
    result_subtype_sqlite3_bind_text64_enum = 0
} result_subtype_enum;

// result_subtype signature initialization function
void init_result_subtype_signatures(void);
// result_subtype function declarations
int sqlite3_bind_text64( sqlite3_stmt *pStmt, int i, const char *zData, sqlite3_uint64 nData, void (*xDel)(void*), unsigned char enc );

// =============== result_text ===============
// result_text function pointer signatures (extern)
static int result_text_signatures[1][4] = {0,};

// result_text function enumeration
typedef enum {
    result_text_sqlite3_result_int64_enum = 0
} result_text_enum;

// result_text signature initialization function
void init_result_text_signatures(void);
// result_text function declarations
void sqlite3_result_int64(sqlite3_context *pCtx, i64 iVal);

// =============== result_text16 ===============
// result_text16 function pointer signatures (extern)
static int result_text16_signatures[1][4] = {0,};

// result_text16 function enumeration
typedef enum {
    result_text16_sqlite3_result_null_enum = 0
} result_text16_enum;

// result_text16 signature initialization function
void init_result_text16_signatures(void);
// result_text16 function declarations
void sqlite3_result_null(sqlite3_context *pCtx);

// =============== result_text16be ===============
// result_text16be function pointer signatures (extern)
static int result_text16be_signatures[1][4] = {0,};

// result_text16be function enumeration
typedef enum {
    result_text16be_sqlite3_result_text_enum = 0
} result_text16be_enum;

// result_text16be signature initialization function
void init_result_text16be_signatures(void);
// result_text16be function declarations
void sqlite3_result_text( sqlite3_context *pCtx, const char *z, int n, void (*xDel)(void *) );

// =============== result_text16le ===============
// result_text16le function pointer signatures (extern)
static int result_text16le_signatures[1][4] = {0,};

// result_text16le function enumeration
typedef enum {
    result_text16le_sqlite3_result_text16_enum = 0
} result_text16le_enum;

// result_text16le signature initialization function
void init_result_text16le_signatures(void);
// result_text16le function declarations
void sqlite3_result_text16(sqlite3_context*, const void*, int, void(*)(void*));

// =============== result_text64 ===============
// result_text64 function pointer signatures (extern)
static int result_text64_signatures[1][4] = {0,};

// result_text64 function enumeration
typedef enum {
    result_text64_sqlite3_uri_boolean_enum = 0
} result_text64_enum;

// result_text64 signature initialization function
void init_result_text64_signatures(void);
// result_text64 function declarations
int sqlite3_uri_boolean(const char *zFilename, const char *zParam, int bDflt);

// =============== result_value ===============
// result_value function pointer signatures (extern)
static int result_value_signatures[1][4] = {0,};

// result_value function enumeration
typedef enum {
    result_value_sqlite3_result_text16be_enum = 0
} result_value_enum;

// result_value signature initialization function
void init_result_value_signatures(void);
// result_value function declarations
void sqlite3_result_text16be( sqlite3_context *pCtx, const void *z, int n, void (*xDel)(void *) );

// =============== result_zeroblob ===============
// result_zeroblob function pointer signatures (extern)
static int result_zeroblob_signatures[1][4] = {0,};

// result_zeroblob function enumeration
typedef enum {
    result_zeroblob_sqlite3_release_memory_enum = 0
} result_zeroblob_enum;

// result_zeroblob signature initialization function
void init_result_zeroblob_signatures(void);
// result_zeroblob function declarations
int sqlite3_release_memory(int);

// =============== result_zeroblob64 ===============
// result_zeroblob64 function pointer signatures (extern)
static int result_zeroblob64_signatures[1][4] = {0,};

// result_zeroblob64 function enumeration
typedef enum {
    result_zeroblob64_sqlite3_wal_checkpoint_v2_enum = 0
} result_zeroblob64_enum;

// result_zeroblob64 signature initialization function
void init_result_zeroblob64_signatures(void);
// result_zeroblob64 function declarations
int sqlite3_wal_checkpoint_v2( sqlite3 *db, const char *zDb, int eMode, int *pnLog, int *pnCkpt );

// =============== rollback_hook ===============
// rollback_hook function pointer signatures (extern)
static int rollback_hook_signatures[1][4] = {0,};

// rollback_hook function enumeration
typedef enum {
    rollback_hook_sqlite3_result_text16le_enum = 0
} rollback_hook_enum;

// rollback_hook signature initialization function
void init_rollback_hook_signatures(void);
// rollback_hook function declarations
void sqlite3_result_text16le( sqlite3_context *pCtx, const void *z, int n, void (*xDel)(void *) );

// =============== serialize ===============
// serialize function pointer signatures (extern)
static int serialize_signatures[1][4] = {0,};

// serialize function enumeration
typedef enum {
    serialize_sqlite3_filename_database_enum = 0
} serialize_enum;

// serialize signature initialization function
void init_serialize_signatures(void);
// serialize function declarations
const char *sqlite3_filename_database(const char *zFilename);

// =============== set_authorizer ===============
// set_authorizer function pointer signatures (extern)
static int set_authorizer_signatures[1][4] = {0,};

// set_authorizer function enumeration
typedef enum {
    set_authorizer_sqlite3_result_value_enum = 0
} set_authorizer_enum;

// set_authorizer signature initialization function
void init_set_authorizer_signatures(void);
// set_authorizer function declarations
void sqlite3_result_value(sqlite3_context*, sqlite3_value*);

// =============== set_auxdata ===============
// set_auxdata function pointer signatures (extern)
static int set_auxdata_signatures[1][4] = {0,};

// set_auxdata function enumeration
typedef enum {
    set_auxdata_sqlite3_rollback_hook_enum = 0
} set_auxdata_enum;

// set_auxdata signature initialization function
void init_set_auxdata_signatures(void);
// set_auxdata function declarations
void *sqlite3_rollback_hook( sqlite3 *db, void (*xCallback)(void*), void *pArg );

// =============== set_clientdata ===============
// set_clientdata function pointer signatures (extern)
static int set_clientdata_signatures[1][4] = {0,};

// set_clientdata function enumeration
typedef enum {
    set_clientdata_sqlite3_txn_state_enum = 0
} set_clientdata_enum;

// set_clientdata signature initialization function
void init_set_clientdata_signatures(void);
// set_clientdata function declarations
int sqlite3_txn_state(sqlite3 *db, const char *zSchema);

// =============== set_last_insert_rowid ===============
// set_last_insert_rowid function pointer signatures (extern)
static int set_last_insert_rowid_signatures[1][4] = {0,};

// set_last_insert_rowid function enumeration
typedef enum {
    set_last_insert_rowid_sqlite3_result_blob64_enum = 0
} set_last_insert_rowid_enum;

// set_last_insert_rowid signature initialization function
void init_set_last_insert_rowid_signatures(void);
// set_last_insert_rowid function declarations
void sqlite3_result_blob64( sqlite3_context *pCtx, const void *z, sqlite3_uint64 n, void (*xDel)(void *) );

// =============== setlk_timeout ===============
// setlk_timeout function pointer signatures (extern)
static int setlk_timeout_signatures[1][4] = {0,};

// setlk_timeout function enumeration
typedef enum {
    setlk_timeout_sqlite3_changes64_enum = 0
} setlk_timeout_enum;

// setlk_timeout signature initialization function
void init_setlk_timeout_signatures(void);
// setlk_timeout function declarations
sqlite3_int64 sqlite3_changes64(sqlite3 *db);

// =============== soft_heap_limit ===============
// soft_heap_limit function pointer signatures (extern)
static int soft_heap_limit_signatures[1][4] = {0,};

// soft_heap_limit function enumeration
typedef enum {
    soft_heap_limit_sqlite3_mutex_enter_enum = 0
} soft_heap_limit_enum;

// soft_heap_limit signature initialization function
void init_soft_heap_limit_signatures(void);
// soft_heap_limit function declarations
void sqlite3_mutex_enter(sqlite3_mutex *p);

// =============== soft_heap_limit64 ===============
// soft_heap_limit64 function pointer signatures (extern)
static int soft_heap_limit64_signatures[1][4] = {0,};

// soft_heap_limit64 function enumeration
typedef enum {
    soft_heap_limit64_sqlite3_backup_step_enum = 0
} soft_heap_limit64_enum;

// soft_heap_limit64 signature initialization function
void init_soft_heap_limit64_signatures(void);
// soft_heap_limit64 function declarations
int sqlite3_backup_step(sqlite3_backup *p, int nPage);

// =============== sql ===============
// sql function pointer signatures (extern)
static int sql_signatures[1][4] = {0,};

// sql function enumeration
typedef enum {
    sql_sqlite3_threadsafe_enum = 0
} sql_enum;

// sql signature initialization function
void init_sql_signatures(void);
// sql function declarations
int sqlite3_threadsafe(void);

// =============== status ===============
// status function pointer signatures (extern)
static int status_signatures[1][4] = {0,};

// status function enumeration
typedef enum {
    status_sqlite3_result_zeroblob_enum = 0
} status_enum;

// status signature initialization function
void init_status_signatures(void);
// status function declarations
void sqlite3_result_zeroblob(sqlite3_context *pCtx, int n);

// =============== status64 ===============
// status64 function pointer signatures (extern)
static int status64_signatures[1][4] = {0,};

// status64 function enumeration
typedef enum {
    status64_sqlite3_cancel_auto_extension_enum = 0
} status64_enum;

// status64 signature initialization function
void init_status64_signatures(void);
// status64 function declarations
int sqlite3_cancel_auto_extension(void(*xEntryPoint)(void));

// =============== step ===============
// step function pointer signatures (extern)
static int step_signatures[1][4] = {0,};

// step function enumeration
typedef enum {
    step_sqlite3_set_auxdata_enum = 0
} step_enum;

// step signature initialization function
void init_step_signatures(void);
// step function declarations
void sqlite3_set_auxdata( sqlite3_context *pCtx, int iArg, void *pAux, void (*xDelete)(void*) );

// =============== stmt_explain ===============
// stmt_explain function pointer signatures (extern)
static int stmt_explain_signatures[1][4] = {0,};

// stmt_explain function enumeration
typedef enum {
    stmt_explain_sqlite3_free_filename_enum = 0
} stmt_explain_enum;

// stmt_explain signature initialization function
void init_stmt_explain_signatures(void);
// stmt_explain function declarations
void sqlite3_free_filename(const char *p);

// =============== stmt_isexplain ===============
// stmt_isexplain function pointer signatures (extern)
static int stmt_isexplain_signatures[1][4] = {0,};

// stmt_isexplain function enumeration
typedef enum {
    stmt_isexplain_sqlite3_keyword_name_enum = 0
} stmt_isexplain_enum;

// stmt_isexplain signature initialization function
void init_stmt_isexplain_signatures(void);
// stmt_isexplain function declarations
int sqlite3_keyword_name(int,const char**,int*);

// =============== stmt_status ===============
// stmt_status function pointer signatures (extern)
static int stmt_status_signatures[1][4] = {0,};

// stmt_status function enumeration
typedef enum {
    stmt_status_sqlite3_compileoption_used_enum = 0
} stmt_status_enum;

// stmt_status signature initialization function
void init_stmt_status_signatures(void);
// stmt_status function declarations
int sqlite3_compileoption_used(const char *zOptName);

// =============== str_append ===============
// str_append function pointer signatures (extern)
static int str_append_signatures[1][4] = {0,};

// str_append function enumeration
typedef enum {
    str_append_sqlite3_prepare_v3_enum = 0
} str_append_enum;

// str_append signature initialization function
void init_str_append_signatures(void);
// str_append function declarations
int sqlite3_prepare_v3( sqlite3 *db, const char *zSql, int nBytes, unsigned int prepFlags, sqlite3_stmt **ppStmt, const char **pzTail );

// =============== str_appendall ===============
// str_appendall function pointer signatures (extern)
static int str_appendall_signatures[1][4] = {0,};

// str_appendall function enumeration
typedef enum {
    str_appendall_sqlite3_prepare16_v3_enum = 0
} str_appendall_enum;

// str_appendall signature initialization function
void init_str_appendall_signatures(void);
// str_appendall function declarations
int sqlite3_prepare16_v3( sqlite3 *db, const void *zSql, int nBytes, unsigned int prepFlags, sqlite3_stmt **ppStmt, const void **pzTail );

// =============== str_appendchar ===============
// str_appendchar function pointer signatures (extern)
static int str_appendchar_signatures[1][4] = {0,};

// str_appendchar function enumeration
typedef enum {
    str_appendchar_sqlite3_bind_pointer_enum = 0
} str_appendchar_enum;

// str_appendchar signature initialization function
void init_str_appendchar_signatures(void);
// str_appendchar function declarations
int sqlite3_bind_pointer( sqlite3_stmt *pStmt, int i, void *pPtr, const char *zPTtype, void (*xDestructor)(void*) );

// =============== str_appendf ===============
// str_appendf function pointer signatures (extern)
static int str_appendf_signatures[1][4] = {0,};

// str_appendf function enumeration
typedef enum {
    str_appendf_sqlite3_expanded_sql_enum = 0
} str_appendf_enum;

// str_appendf signature initialization function
void init_str_appendf_signatures(void);
// str_appendf function declarations
char *sqlite3_expanded_sql(sqlite3_stmt *pStmt);

// =============== str_errcode ===============
// str_errcode function pointer signatures (extern)
static int str_errcode_signatures[1][4] = {0,};

// str_errcode function enumeration
typedef enum {
    str_errcode_sqlite3_value_pointer_enum = 0
} str_errcode_enum;

// str_errcode signature initialization function
void init_str_errcode_signatures(void);
// str_errcode function declarations
void *sqlite3_value_pointer(sqlite3_value *pVal, const char *zPType);

// =============== str_finish ===============
// str_finish function pointer signatures (extern)
static int str_finish_signatures[1][4] = {0,};

// str_finish function enumeration
typedef enum {
    str_finish_sqlite3_trace_v2_enum = 0
} str_finish_enum;

// str_finish signature initialization function
void init_str_finish_signatures(void);
// str_finish function declarations
int sqlite3_trace_v2( sqlite3 *db, unsigned mTrace, int(*xTrace)(unsigned,void*,void*,void*), void *pArg );

// =============== str_length ===============
// str_length function pointer signatures (extern)
static int str_length_signatures[1][4] = {0,};

// str_length function enumeration
typedef enum {
    str_length_sqlite3_vtab_nochange_enum = 0
} str_length_enum;

// str_length signature initialization function
void init_str_length_signatures(void);
// str_length function declarations
int sqlite3_vtab_nochange(sqlite3_context *p);

// =============== str_new ===============
// str_new function pointer signatures (extern)
static int str_new_signatures[1][4] = {0,};

// str_new function enumeration
typedef enum {
    str_new_sqlite3_system_errno_enum = 0
} str_new_enum;

// str_new signature initialization function
void init_str_new_signatures(void);
// str_new function declarations
int sqlite3_system_errno(sqlite3 *db);

// =============== str_reset ===============
// str_reset function pointer signatures (extern)
static int str_reset_signatures[1][4] = {0,};

// str_reset function enumeration
typedef enum {
    str_reset_sqlite3_result_pointer_enum = 0
} str_reset_enum;

// str_reset signature initialization function
void init_str_reset_signatures(void);
// str_reset function declarations
void sqlite3_result_pointer( sqlite3_context *pCtx, void *pPtr, const char *zPType, void (*xDestructor)(void*) );

// =============== str_value ===============
// str_value function pointer signatures (extern)
static int str_value_signatures[1][4] = {0,};

// str_value function enumeration
typedef enum {
    str_value_sqlite3_value_nochange_enum = 0
} str_value_enum;

// str_value signature initialization function
void init_str_value_signatures(void);
// str_value function declarations
int sqlite3_value_nochange(sqlite3_value *pVal);

// =============== str_vappendf ===============
// str_vappendf function pointer signatures (extern)
static int str_vappendf_signatures[1][4] = {0,};

// str_vappendf function enumeration
typedef enum {
    str_vappendf_sqlite3_set_last_insert_rowid_enum = 0
} str_vappendf_enum;

// str_vappendf signature initialization function
void init_str_vappendf_signatures(void);
// str_vappendf function declarations
void sqlite3_set_last_insert_rowid(sqlite3 *db, sqlite3_int64 iRowid);

// =============== strglob ===============
// strglob function pointer signatures (extern)
static int strglob_signatures[1][4] = {0,};

// strglob function enumeration
typedef enum {
    strglob_sqlite3_uri_int64_enum = 0
} strglob_enum;

// strglob signature initialization function
void init_strglob_signatures(void);
// strglob function declarations
sqlite3_int64 sqlite3_uri_int64( const char *zFilename, const char *zParam, sqlite3_int64 bDflt );

// =============== stricmp ===============
// stricmp function pointer signatures (extern)
static int stricmp_signatures[1][4] = {0,};

// stricmp function enumeration
typedef enum {
    stricmp_sqlite3_wal_checkpoint_enum = 0
} stricmp_enum;

// stricmp signature initialization function
void init_stricmp_signatures(void);
// stricmp function declarations
int sqlite3_wal_checkpoint(sqlite3 *db, const char *zDb);

// =============== strlike ===============
// strlike function pointer signatures (extern)
static int strlike_signatures[1][4] = {0,};

// strlike function enumeration
typedef enum {
    strlike_sqlite3_load_extension_enum = 0
} strlike_enum;

// strlike signature initialization function
void init_strlike_signatures(void);
// strlike function declarations
int sqlite3_load_extension( sqlite3 *db, const char *zFile, const char *zProc, char **pzErrMsg );

// =============== system_errno ===============
// system_errno function pointer signatures (extern)
static int system_errno_signatures[1][4] = {0,};

// system_errno function enumeration
typedef enum {
    system_errno_sqlite3_msize_enum = 0
} system_errno_enum;

// system_errno signature initialization function
void init_system_errno_signatures(void);
// system_errno function declarations
sqlite3_uint64 sqlite3_msize(void*);

// =============== table_column_metadata ===============
// table_column_metadata function pointer signatures (extern)
static int table_column_metadata_signatures[1][4] = {0,};

// table_column_metadata function enumeration
typedef enum {
    table_column_metadata_sqlite3_snprintf_enum = 0
} table_column_metadata_enum;

// table_column_metadata signature initialization function
void init_table_column_metadata_signatures(void);
// table_column_metadata function declarations
char *sqlite3_snprintf(int n, char *zBuf, const char *zFormat, ...);

// =============== test_control ===============
// test_control function pointer signatures (extern)
static int test_control_signatures[1][4] = {0,};

// test_control function enumeration
typedef enum {
    test_control_sqlite3_result_error_toobig_enum = 0
} test_control_enum;

// test_control signature initialization function
void init_test_control_signatures(void);
// test_control function declarations
void sqlite3_result_error_toobig(sqlite3_context *pCtx);

// =============== thread_cleanup ===============
// thread_cleanup function pointer signatures (extern)
static int thread_cleanup_signatures[1][4] = {0,};

// thread_cleanup function enumeration
typedef enum {
    thread_cleanup_sqlite3_step_enum = 0
} thread_cleanup_enum;

// thread_cleanup signature initialization function
void init_thread_cleanup_signatures(void);
// thread_cleanup function declarations
int sqlite3_step(sqlite3_stmt *pStmt);

// =============== total_changes ===============
// total_changes function pointer signatures (extern)
static int total_changes_signatures[1][4] = {0,};

// total_changes function enumeration
typedef enum {
    total_changes_sqlite3_table_column_metadata_enum = 0
} total_changes_enum;

// total_changes signature initialization function
void init_total_changes_signatures(void);
// total_changes function declarations
int sqlite3_table_column_metadata( sqlite3 *db, const char *zDbName, const char *zTableName, const char *zColumnName, char const **pzDataType, char const **pzCollSeq, int *pNotNull, int *pPrimaryKey, int *pAutoinc );

// =============== total_changes64 ===============
// total_changes64 function pointer signatures (extern)
static int total_changes64_signatures[1][4] = {0,};

// total_changes64 function enumeration
typedef enum {
    total_changes64_sqlite3_create_window_function_enum = 0
} total_changes64_enum;

// total_changes64 signature initialization function
void init_total_changes64_signatures(void);
// total_changes64 function declarations
int sqlite3_create_window_function( sqlite3 *db, const char *zFunc, int nArg, int enc, void *p, void (*xStep)(sqlite3_context*,int,sqlite3_value **), void (*xFinal)(sqlite3_context*), void (*xValue)(sqlite3_context*), void (*xInverse)(sqlite3_context*,int,sqlite3_value **), void (*xDestroy)(void *) );

// =============== trace_v2 ===============
// trace_v2 function pointer signatures (extern)
static int trace_v2_signatures[1][4] = {0,};

// trace_v2 function enumeration
typedef enum {
    trace_v2_sqlite3_realloc64_enum = 0
} trace_v2_enum;

// trace_v2 signature initialization function
void init_trace_v2_signatures(void);
// trace_v2 function declarations
void *sqlite3_realloc64(void*, sqlite3_uint64);

// =============== txn_state ===============
// txn_state function pointer signatures (extern)
static int txn_state_signatures[1][4] = {0,};

// txn_state function enumeration
typedef enum {
    txn_state_sqlite3_str_length_enum = 0
} txn_state_enum;

// txn_state signature initialization function
void init_txn_state_signatures(void);
// txn_state function declarations
int sqlite3_str_length(sqlite3_str *p);

// =============== uri_boolean ===============
// uri_boolean function pointer signatures (extern)
static int uri_boolean_signatures[1][4] = {0,};

// uri_boolean function enumeration
typedef enum {
    uri_boolean_sqlite3_wal_hook_enum = 0
} uri_boolean_enum;

// uri_boolean signature initialization function
void init_uri_boolean_signatures(void);
// uri_boolean function declarations
void *sqlite3_wal_hook( sqlite3 *db, int(*xCallback)(void *, sqlite3*, const char*, int), void *pArg );

// =============== uri_key ===============
// uri_key function pointer signatures (extern)
static int uri_key_signatures[1][4] = {0,};

// uri_key function enumeration
typedef enum {
    uri_key_sqlite3_str_appendf_enum = 0
} uri_key_enum;

// uri_key signature initialization function
void init_uri_key_signatures(void);
// uri_key function declarations
void sqlite3_str_appendf(sqlite3_str*, const char *zFormat, ...);

// =============== user_data ===============
// user_data function pointer signatures (extern)
static int user_data_signatures[1][4] = {0,};

// user_data function enumeration
typedef enum {
    user_data_sqlite3_trace_enum = 0
} user_data_enum;

// user_data signature initialization function
void init_user_data_signatures(void);
// user_data function declarations
void *sqlite3_trace(sqlite3 *db, void(*xTrace)(void*,const char*), void *pArg);

// =============== value_double ===============
// value_double function pointer signatures (extern)
static int value_double_signatures[1][4] = {0,};

// value_double function enumeration
typedef enum {
    value_double_sqlite3_user_data_enum = 0
} value_double_enum;

// value_double signature initialization function
void init_value_double_signatures(void);
// value_double function declarations
void *sqlite3_user_data(sqlite3_context *p);

// =============== value_dup ===============
// value_dup function pointer signatures (extern)
static int value_dup_signatures[1][4] = {0,};

// value_dup function enumeration
typedef enum {
    value_dup_sqlite3_uri_parameter_enum = 0
} value_dup_enum;

// value_dup signature initialization function
void init_value_dup_signatures(void);
// value_dup function declarations
const char *sqlite3_uri_parameter(const char *zFilename, const char *zParam);

// =============== value_encoding ===============
// value_encoding function pointer signatures (extern)
static int value_encoding_signatures[1][4] = {0,};

// value_encoding function enumeration
typedef enum {
    value_encoding_sqlite3_filename_wal_enum = 0
} value_encoding_enum;

// value_encoding signature initialization function
void init_value_encoding_signatures(void);
// value_encoding function declarations
const char *sqlite3_filename_wal(const char *zFilename);

// =============== value_free ===============
// value_free function pointer signatures (extern)
static int value_free_signatures[1][4] = {0,};

// value_free function enumeration
typedef enum {
    value_free_sqlite3_vsnprintf_enum = 0
} value_free_enum;

// value_free signature initialization function
void init_value_free_signatures(void);
// value_free function declarations
char *sqlite3_vsnprintf(int n, char *zBuf, const char *zFormat, va_list ap);

// =============== value_frombind ===============
// value_frombind function pointer signatures (extern)
static int value_frombind_signatures[1][4] = {0,};

// value_frombind function enumeration
typedef enum {
    value_frombind_sqlite3_keyword_check_enum = 0
} value_frombind_enum;

// value_frombind signature initialization function
void init_value_frombind_signatures(void);
// value_frombind function declarations
int sqlite3_keyword_check(const char*,int);

// =============== value_int ===============
// value_int function pointer signatures (extern)
static int value_int_signatures[1][4] = {0,};

// value_int function enumeration
typedef enum {
    value_int_sqlite3_value_blob_enum = 0
} value_int_enum;

// value_int signature initialization function
void init_value_int_signatures(void);
// value_int function declarations
const void *sqlite3_value_blob(sqlite3_value *pVal);

// =============== value_int64 ===============
// value_int64 function pointer signatures (extern)
static int value_int64_signatures[1][4] = {0,};

// value_int64 function enumeration
typedef enum {
    value_int64_sqlite3_value_bytes_enum = 0
} value_int64_enum;

// value_int64 signature initialization function
void init_value_int64_signatures(void);
// value_int64 function declarations
int sqlite3_value_bytes(sqlite3_value *pVal);

// =============== value_nochange ===============
// value_nochange function pointer signatures (extern)
static int value_nochange_signatures[1][4] = {0,};

// value_nochange function enumeration
typedef enum {
    value_nochange_sqlite3_value_subtype_enum = 0
} value_nochange_enum;

// value_nochange signature initialization function
void init_value_nochange_signatures(void);
// value_nochange function declarations
unsigned int sqlite3_value_subtype(sqlite3_value *pVal);

// =============== value_numeric_type ===============
// value_numeric_type function pointer signatures (extern)
static int value_numeric_type_signatures[1][4] = {0,};

// value_numeric_type function enumeration
typedef enum {
    value_numeric_type_sqlite3_value_bytes16_enum = 0
} value_numeric_type_enum;

// value_numeric_type signature initialization function
void init_value_numeric_type_signatures(void);
// value_numeric_type function declarations
int sqlite3_value_bytes16(sqlite3_value *pVal);

// =============== value_pointer ===============
// value_pointer function pointer signatures (extern)
static int value_pointer_signatures[1][4] = {0,};

// value_pointer function enumeration
typedef enum {
    value_pointer_sqlite3_result_zeroblob64_enum = 0
} value_pointer_enum;

// value_pointer signature initialization function
void init_value_pointer_signatures(void);
// value_pointer function declarations
int sqlite3_result_zeroblob64(sqlite3_context *pCtx, u64 n);

// =============== value_subtype ===============
// value_subtype function pointer signatures (extern)
static int value_subtype_signatures[1][4] = {0,};

// value_subtype function enumeration
typedef enum {
    value_subtype_sqlite3_bind_blob64_enum = 0
} value_subtype_enum;

// value_subtype signature initialization function
void init_value_subtype_signatures(void);
// value_subtype function declarations
int sqlite3_bind_blob64( sqlite3_stmt *pStmt, int i, const void *zData, sqlite3_uint64 nData, void (*xDel)(void*) );

// =============== value_text ===============
// value_text function pointer signatures (extern)
static int value_text_signatures[1][4] = {0,};

// value_text function enumeration
typedef enum {
    value_text_sqlite3_value_double_enum = 0
} value_text_enum;

// value_text signature initialization function
void init_value_text_signatures(void);
// value_text function declarations
double sqlite3_value_double(sqlite3_value *pVal);

// =============== value_text16 ===============
// value_text16 function pointer signatures (extern)
static int value_text16_signatures[1][4] = {0,};

// value_text16 function enumeration
typedef enum {
    value_text16_sqlite3_value_int_enum = 0
} value_text16_enum;

// value_text16 signature initialization function
void init_value_text16_signatures(void);
// value_text16 function declarations
int sqlite3_value_int(sqlite3_value *pVal);

// =============== value_text16be ===============
// value_text16be function pointer signatures (extern)
static int value_text16be_signatures[1][4] = {0,};

// value_text16be function enumeration
typedef enum {
    value_text16be_sqlite3_value_int64_enum = 0
} value_text16be_enum;

// value_text16be signature initialization function
void init_value_text16be_signatures(void);
// value_text16be function declarations
sqlite_int64 sqlite3_value_int64(sqlite3_value *pVal);

// =============== value_text16le ===============
// value_text16le function pointer signatures (extern)
static int value_text16le_signatures[1][4] = {0,};

// value_text16le function enumeration
typedef enum {
    value_text16le_sqlite3_value_numeric_type_enum = 0
} value_text16le_enum;

// value_text16le signature initialization function
void init_value_text16le_signatures(void);
// value_text16le function declarations
int sqlite3_value_numeric_type(sqlite3_value*);

// =============== value_type ===============
// value_type function pointer signatures (extern)
static int value_type_signatures[1][4] = {0,};

// value_type function enumeration
typedef enum {
    value_type_sqlite3_value_text_enum = 0
} value_type_enum;

// value_type signature initialization function
void init_value_type_signatures(void);
// value_type function declarations
const unsigned char *sqlite3_value_text(sqlite3_value *pVal);

// =============== vfs_find ===============
// vfs_find function pointer signatures (extern)
static int vfs_find_signatures[1][4] = {0,};

// vfs_find function enumeration
typedef enum {
    vfs_find_sqlite3_mutex_free_enum = 0
} vfs_find_enum;

// vfs_find signature initialization function
void init_vfs_find_signatures(void);
// vfs_find function declarations
void sqlite3_mutex_free(sqlite3_mutex *p);

// =============== vfs_register ===============
// vfs_register function pointer signatures (extern)
static int vfs_register_signatures[1][4] = {0,};

// vfs_register function enumeration
typedef enum {
    vfs_register_sqlite3_mutex_leave_enum = 0
} vfs_register_enum;

// vfs_register signature initialization function
void init_vfs_register_signatures(void);
// vfs_register function declarations
void sqlite3_mutex_leave(sqlite3_mutex *p);

// =============== vfs_unregister ===============
// vfs_unregister function pointer signatures (extern)
static int vfs_unregister_signatures[1][4] = {0,};

// vfs_unregister function enumeration
typedef enum {
    vfs_unregister_sqlite3_mutex_try_enum = 0
} vfs_unregister_enum;

// vfs_unregister signature initialization function
void init_vfs_unregister_signatures(void);
// vfs_unregister function declarations
int sqlite3_mutex_try(sqlite3_mutex *p);

// =============== vmprintf ===============
// vmprintf function pointer signatures (extern)
static int vmprintf_signatures[1][4] = {0,};

// vmprintf function enumeration
typedef enum {
    vmprintf_sqlite3_value_text16_enum = 0
} vmprintf_enum;

// vmprintf signature initialization function
void init_vmprintf_signatures(void);
// vmprintf function declarations
const void *sqlite3_value_text16(sqlite3_value*);

// =============== vtab_collation ===============
// vtab_collation function pointer signatures (extern)
static int vtab_collation_signatures[1][4] = {0,};

// vtab_collation function enumeration
typedef enum {
    vtab_collation_sqlite3_result_subtype_enum = 0
} vtab_collation_enum;

// vtab_collation signature initialization function
void init_vtab_collation_signatures(void);
// vtab_collation function declarations
void sqlite3_result_subtype(sqlite3_context *pCtx, unsigned int eSubtype);

// =============== vtab_config ===============
// vtab_config function pointer signatures (extern)
static int vtab_config_signatures[1][4] = {0,};

// vtab_config function enumeration
typedef enum {
    vtab_config_sqlite3_extended_errcode_enum = 0
} vtab_config_enum;

// vtab_config signature initialization function
void init_vtab_config_signatures(void);
// vtab_config function declarations
int sqlite3_extended_errcode(sqlite3 *db);

// =============== vtab_distinct ===============
// vtab_distinct function pointer signatures (extern)
static int vtab_distinct_signatures[1][4] = {0,};

// vtab_distinct function enumeration
typedef enum {
    vtab_distinct_sqlite3_value_frombind_enum = 0
} vtab_distinct_enum;

// vtab_distinct signature initialization function
void init_vtab_distinct_signatures(void);
// vtab_distinct function declarations
int sqlite3_value_frombind(sqlite3_value *pVal);

// =============== vtab_nochange ===============
// vtab_nochange function pointer signatures (extern)
static int vtab_nochange_signatures[1][4] = {0,};

// vtab_nochange function enumeration
typedef enum {
    vtab_nochange_sqlite3_bind_zeroblob64_enum = 0
} vtab_nochange_enum;

// vtab_nochange signature initialization function
void init_vtab_nochange_signatures(void);
// vtab_nochange function declarations
int sqlite3_bind_zeroblob64(sqlite3_stmt *pStmt, int i, sqlite3_uint64 n);

// =============== vtab_on_conflict ===============
// vtab_on_conflict function pointer signatures (extern)
static int vtab_on_conflict_signatures[1][4] = {0,};

// vtab_on_conflict function enumeration
typedef enum {
    vtab_on_conflict_sqlite3_log_enum = 0
} vtab_on_conflict_enum;

// vtab_on_conflict signature initialization function
void init_vtab_on_conflict_signatures(void);
// vtab_on_conflict function declarations
void sqlite3_log(int iErrCode, const char *zFormat, ...);

// =============== wal_checkpoint ===============
// wal_checkpoint function pointer signatures (extern)
static int wal_checkpoint_signatures[1][4] = {0,};

// wal_checkpoint function enumeration
typedef enum {
    wal_checkpoint_sqlite3_db_config_enum = 0
} wal_checkpoint_enum;

// wal_checkpoint signature initialization function
void init_wal_checkpoint_signatures(void);
// wal_checkpoint function declarations
int sqlite3_db_config(sqlite3 *db, int op, ...);

// =============== wal_hook ===============
// wal_hook function pointer signatures (extern)
static int wal_hook_signatures[1][4] = {0,};

// wal_hook function enumeration
typedef enum {
    wal_hook_sqlite3_db_mutex_enum = 0
} wal_hook_enum;

// wal_hook signature initialization function
void init_wal_hook_signatures(void);
// wal_hook function declarations
sqlite3_mutex *sqlite3_db_mutex(sqlite3 *db);

// =============== xAccess ===============
// xAccess function pointer signatures (extern)
static int xAccess_signatures[4][4] = {0,};

// xAccess function enumeration
typedef enum {
    xAccess_apndAccess_enum = 0,
    xAccess_memdbAccess_enum = 1,
    xAccess_vfstraceAccess_enum = 2,
    xAccess_unixAccess_enum = 3
} xAccess_enum;

// xAccess signature initialization function
void init_xAccess_signatures(void);
// xAccess function declarations
int apndAccess(sqlite3_vfs*, const char *zName, int flags, int *);
int memdbAccess(sqlite3_vfs*, const char *zName, int flags, int *);
int multiplexAccess(sqlite3_vfs *a, const char *b, int c, int *d);
int vfstraceAccess(sqlite3_vfs*, const char *zName, int flags, int *);
int unixAccess(sqlite3_vfs *NotUsed, const char *zPath, int flags, int *pResOut);

// =============== xAppend ===============
// xAppend function pointer signatures (extern)
static int xAppend_signatures[2][4] = {0,};

// xAppend function enumeration
typedef enum {
    xAppend_fts5AppendPoslist_enum = 0,
    xAppend_fts5AppendRowid_enum = 1
} xAppend_enum;

// xAppend signature initialization function
void init_xAppend_signatures(void);
// xAppend function declarations
void fts5AppendPoslist( Fts5Index *p, u64 iDelta, Fts5Iter *pMulti, Fts5Buffer *pBuf );
void fts5AppendRowid( Fts5Index *p, u64 iDelta, Fts5Iter *pUnused, Fts5Buffer *pBuf );

// =============== xAuth ===============
// xAuth function pointer signatures (extern)
static int xAuth_signatures[9][4] = {0,};

// xAuth function enumeration
typedef enum {
    xAuth_0_enum = 0,
    xAuth_idxAuthCallback_enum = 1,
    xAuth_s3jni_xAuth_enum = 2,
    xAuth_authCallback_enum = 3,
    xAuth_safeModeAuth_enum = 4,
    xAuth_shellAuth_enum = 5,
    xAuth_sqlite3_auth_cbauth_callback_enum = 6,
    xAuth_block_troublesome_sql_enum = 7,
    xAuth_block_debug_pragmas_enum = 8
} xAuth_enum;

// xAuth signature initialization function
void init_xAuth_signatures(void);
// xAuth function declarations
int idxAuthCallback(void *pCtx, int eOp, const char *z3, const char *z4, const char *zDb, const char *zTrigger);
int authCallback(void *pClientData, int op, const char *z1, const char *z2, const char *z3, const char *z4);
int safeModeAuth(void *pClientData, int op, const char *zA1, const char *zA2, const char *zA3, const char *zA4);
int shellAuth(void *pClientData, int op, const char *zA1, const char *zA2, const char *zA3, const char *zA4);
int auth_callback(void *pArg, int code, const char *zArg1, const char *zArg2, const char *zArg3, const char *zArg4);
int block_troublesome_sql(void *pClientData, int eCode, const char *zArg1, const char *zArg2, const char *zArg3, const char *zArg4);
int block_debug_pragmas(void *Notused, int eCode, const char *zArg1, const char *zArg2, const char *zArg3, const char *zArg4);
int s3jni_xAuth(void* pState, int op,const char*z0, const char*z1, const char*z2,const char*z3);

// =============== xBegin ===============
// xBegin function pointer signatures (extern)
static int xBegin_signatures[6][4] = {0,};

// xBegin function enumeration
typedef enum {
    xBegin_0_enum = 0,
    xBegin_dbpageBegin_enum = 1,
    xBegin_fts3BeginMethod_enum = 2,
    xBegin_fts5BeginMethod_enum = 3,
    xBegin_rtreeBeginTransaction_enum = 4,
    xBegin_zipfileBegin_enum = 5
} xBegin_enum;

// xBegin signature initialization function
void init_xBegin_signatures(void);
// xBegin function declarations
int dbpageBegin(sqlite3_vtab *pVtab);
int fts3BeginMethod(sqlite3_vtab *pVtab);
int fts5BeginMethod(sqlite3_vtab *pVtab);
int rtreeBeginTransaction(sqlite3_vtab *pVtab);
int zipfileBegin(sqlite3_vtab *pVtab);

// =============== xBestIndex ===============
// xBestIndex function pointer signatures (extern)
static int xBestIndex_signatures[20][4] = {0,};

// xBestIndex function enumeration
typedef enum {
    xBestIndex_bytecodevtabBestIndex_enum = 0,
    xBestIndex_completionBestIndex_enum = 1,
    xBestIndex_dbdataBestIndex_enum = 2,
    xBestIndex_dbpageBestIndex_enum = 3,
    xBestIndex_expertBestIndex_enum = 4,
    xBestIndex_fsdirBestIndex_enum = 5,
    xBestIndex_fts3BestIndexMethod_enum = 6,
    xBestIndex_fts3auxBestIndexMethod_enum = 7,
    xBestIndex_fts3tokBestIndexMethod_enum = 8,
    xBestIndex_fts5BestIndexMethod_enum = 9,
    xBestIndex_fts5VocabBestIndexMethod_enum = 10,
    xBestIndex_fts5structBestIndexMethod_enum = 11,
    xBestIndex_fts5tokBestIndexMethod_enum = 12,
    xBestIndex_jsonEachBestIndex_enum = 13,
    xBestIndex_pragmaVtabBestIndex_enum = 14,
    xBestIndex_rtreeBestIndex_enum = 15,
    xBestIndex_seriesBestIndex_enum = 16,
    xBestIndex_statBestIndex_enum = 17,
    xBestIndex_stmtBestIndex_enum = 18,
    xBestIndex_zipfileBestIndex_enum = 19
} xBestIndex_enum;

// xBestIndex signature initialization function
void init_xBestIndex_signatures(void);
// xBestIndex function declarations
int bytecodevtabBestIndex( sqlite3_vtab *tab, sqlite3_index_info *pIdxInfo );
int completionBestIndex( sqlite3_vtab *tab, sqlite3_index_info *pIdxInfo );
int dbdataBestIndex(sqlite3_vtab *tab, sqlite3_index_info *pIdx);
int dbpageBestIndex(sqlite3_vtab *tab, sqlite3_index_info *pIdxInfo);
int expertBestIndex(sqlite3_vtab *pVtab, sqlite3_index_info *pIdxInfo);
int fsdirBestIndex(sqlite3_vtab *tab, sqlite3_index_info *pIdxInfo);
int fts3BestIndexMethod(sqlite3_vtab *pVTab, sqlite3_index_info *pInfo);
int fts3auxBestIndexMethod( sqlite3_vtab *pVTab, sqlite3_index_info *pInfo );
int fts3tokBestIndexMethod( sqlite3_vtab *pVTab, sqlite3_index_info *pInfo );
int fts5BestIndexMethod(sqlite3_vtab *pVTab, sqlite3_index_info *pInfo);
int fts5VocabBestIndexMethod( sqlite3_vtab *pUnused, sqlite3_index_info *pInfo );
int fts5structBestIndexMethod( sqlite3_vtab *tab, sqlite3_index_info *pIdxInfo );
int fts5tokBestIndexMethod( sqlite3_vtab *pVTab, sqlite3_index_info *pInfo );
int jsonEachBestIndex( sqlite3_vtab *tab, sqlite3_index_info *pIdxInfo );
int pragmaVtabBestIndex(sqlite3_vtab *tab, sqlite3_index_info *pIdxInfo);
int rtreeBestIndex(sqlite3_vtab *tab, sqlite3_index_info *pIdxInfo);
int seriesBestIndex( sqlite3_vtab *pVTab, sqlite3_index_info *pIdxInfo );
int statBestIndex(sqlite3_vtab *tab, sqlite3_index_info *pIdxInfo);
int stmtBestIndex( sqlite3_vtab *tab, sqlite3_index_info *pIdxInfo );
int zipfileBestIndex( sqlite3_vtab *tab, sqlite3_index_info *pIdxInfo );

// =============== xCachesize ===============
// xCachesize function pointer signatures (extern)
static int xCachesize_signatures[2][4] = {0,};

// xCachesize function enumeration
typedef enum {
    xCachesize_pcache1Cachesize_enum = 0,
    xCachesize_pcachetraceCachesize_enum = 1
} xCachesize_enum;

// xCachesize signature initialization function
void init_xCachesize_signatures(void);
// xCachesize function declarations
void pcache1Cachesize(sqlite3_pcache *p, int nMax);
void pcachetraceCachesize(sqlite3_pcache *p, int nCachesize);

// =============== xCellSize ===============
// xCellSize function pointer signatures (extern)
static int xCellSize_signatures[4][4] = {0,};

// xCellSize function enumeration
typedef enum {
    xCellSize_cellSizePtr_enum = 0,
    xCellSize_cellSizePtrIdxLeaf_enum = 1,
    xCellSize_cellSizePtrNoPayload_enum = 2,
    xCellSize_cellSizePtrTableLeaf_enum = 3
} xCellSize_enum;

// xCellSize signature initialization function
void init_xCellSize_signatures(void);
// xCellSize function declarations
u16 cellSizePtr(MemPage *pPage, u8 *pCell);
u16 cellSizePtrIdxLeaf(MemPage *pPage, u8 *pCell);
u16 cellSizePtrNoPayload(MemPage *pPage, u8 *pCell);
u16 cellSizePtrTableLeaf(MemPage *pPage, u8 *pCell);

// =============== xCheckReservedLock ===============
// xCheckReservedLock function pointer signatures (extern)
static int xCheckReservedLock_signatures[7][4] = {0,};

// xCheckReservedLock function enumeration
typedef enum {
    xCheckReservedLock_0_enum = 0,
    xCheckReservedLock_apndCheckReservedLock_enum = 1,
    xCheckReservedLock_recoverVfsCheckReservedLock_enum = 2,
    xCheckReservedLock_vfstraceCheckReservedLock_enum = 3,
    xCheckReservedLock_unixCheckReservedLock_enum = 4,
    xCheckReservedLock_nolockCheckReservedLock_enum = 5,
    xCheckReservedLock_dotlockCheckReservedLock_enum = 6
} xCheckReservedLock_enum;

// xCheckReservedLock signature initialization function
void init_xCheckReservedLock_signatures(void);
// xCheckReservedLock function declarations
int apndCheckReservedLock(sqlite3_file*, int *pResOut);
int multiplexCheckReservedLock(sqlite3_file *pConn, int *pResOut);
int quotaCheckReservedLock(sqlite3_file *pConn, int *pResOut);
int vfstraceCheckReservedLock(sqlite3_file*, int *);
int unixCheckReservedLock(sqlite3_file *id, int *pResOut);
int nolockCheckReservedLock(sqlite3_file *NotUsed, int *pResOut);
int dotlockCheckReservedLock(sqlite3_file *id, int *pResOut);

// =============== xClose ===============
// xClose function pointer signatures (extern)
static int xClose_signatures[31][4] = {0,};

// xClose function enumeration
typedef enum {
    xClose_apndClose_enum = 0,
    xClose_bytecodevtabClose_enum = 1,
    xClose_completionClose_enum = 2,
    xClose_dbdataClose_enum = 3,
    xClose_dbpageClose_enum = 4,
    xClose_expertClose_enum = 5,
    xClose_fsdirClose_enum = 6,
    xClose_fts3CloseMethod_enum = 7,
    xClose_fts3auxCloseMethod_enum = 8,
    xClose_fts3tokCloseMethod_enum = 9,
    xClose_fts5CloseMethod_enum = 10,
    xClose_fts5VocabCloseMethod_enum = 11,
    xClose_fts5structCloseMethod_enum = 12,
    xClose_fts5tokCloseMethod_enum = 13,
    xClose_jsonEachClose_enum = 14,
    xClose_memdbClose_enum = 15,
    xClose_memjrnlClose_enum = 16,
    xClose_porterClose_enum = 17,
    xClose_pragmaVtabClose_enum = 18,
    xClose_recoverVfsClose_enum = 19,
    xClose_rtreeClose_enum = 20,
    xClose_seriesClose_enum = 21,
    xClose_simpleClose_enum = 22,
    xClose_statClose_enum = 23,
    xClose_stmtClose_enum = 24,
    xClose_unicodeClose_enum = 25,
    xClose_vfstraceClose_enum = 26,
    xClose_zipfileClose_enum = 27,
    xClose_unixClose_enum = 28,
    xClose_nolockClose_enum = 29,
    xClose_dotlockClose_enum = 30
} xClose_enum;

// xClose signature initialization function
void init_xClose_signatures(void);
// xClose function declarations
int apndClose(sqlite3_file*);
int bytecodevtabClose(sqlite3_vtab_cursor *cur);
int completionClose(sqlite3_vtab_cursor *cur);
int dbdataClose(sqlite3_vtab_cursor *pCursor);
int dbpageClose(sqlite3_vtab_cursor *pCursor);
int expertClose(sqlite3_vtab_cursor *cur);
int fsdirClose(sqlite3_vtab_cursor *cur);
int fts3CloseMethod(sqlite3_vtab_cursor *pCursor);
int fts3auxCloseMethod(sqlite3_vtab_cursor *pCursor);
int fts3tokCloseMethod(sqlite3_vtab_cursor *pCursor);
int fts5CloseMethod(sqlite3_vtab_cursor *pCursor);
int fts5VocabCloseMethod(sqlite3_vtab_cursor *pCursor);
int fts5structCloseMethod(sqlite3_vtab_cursor *cur);
int fts5tokCloseMethod(sqlite3_vtab_cursor *pCursor);
int jsonEachClose(sqlite3_vtab_cursor *cur);
int memdbClose(sqlite3_file*);
int memjrnlClose(sqlite3_file *pJfd);
int multiplexClose(sqlite3_file *pConn);
int porterClose(sqlite3_tokenizer_cursor *pCursor);
int pragmaVtabClose(sqlite3_vtab_cursor *cur);
int quotaClose(sqlite3_file *pConn);
int rtreeClose(sqlite3_vtab_cursor *cur);
int seriesClose(sqlite3_vtab_cursor *cur);
int simpleClose(sqlite3_tokenizer_cursor *pCursor);
int statClose(sqlite3_vtab_cursor *pCursor);
int stmtClose(sqlite3_vtab_cursor *cur);
int unicodeClose(sqlite3_tokenizer_cursor *pCursor);
int vfstraceClose(sqlite3_file*);
int zipfileClose(sqlite3_vtab_cursor *cur);
int unixClose(sqlite3_file *id);
int nolockClose(sqlite3_file *id);
int dotlockClose(sqlite3_file *id);

// =============== xCollNeeded ===============
// xCollNeeded function pointer signatures (extern)
static int xCollNeeded_signatures[4][4] = {0,};

// xCollNeeded function enumeration
typedef enum {
    xCollNeeded_0_enum = 0,
    xCollNeeded_useDummyCS_enum = 1,
    xCollNeeded_anyCollNeeded_enum = 2,
    xCollNeeded_tclCollateNeeded_enum = 3
} xCollNeeded_enum;

// xCollNeeded signature initialization function
void init_xCollNeeded_signatures(void);
// xCollNeeded function declarations
void useDummyCS(void *up1, sqlite3 *db, int etr, const char *zName);
void anyCollNeeded(void *NotUsed, sqlite3 *db, int eTextRep, const char *zCollName);
void tclCollateNeeded(void *pCtx, sqlite3 *db, int enc, const char *zName);

// =============== xCollNeeded16 ===============
// xCollNeeded16 function pointer signatures (extern)
static int xCollNeeded16_signatures[3][4] = {0,};

// xCollNeeded16 function enumeration
typedef enum {
    xCollNeeded16_0_enum = 0,
    xCollNeeded16_s3jni_collation_needed_impl16_enum = 1,
    xCollNeeded16_test_collate_needed_cb_enum = 2
} xCollNeeded16_enum;

// xCollNeeded16 signature initialization function
void init_xCollNeeded16_signatures(void);
// xCollNeeded16 function declarations
void s3jni_collation_needed_impl16(void *pState, sqlite3 *pDb, int eTextRep, const void * z16Name);
void test_collate_needed_cb(void *pCtx, sqlite3 *db, int eTextRep, const void *pName);

// =============== xColumn ===============
// xColumn function pointer signatures (extern)
static int xColumn_signatures[48][4] = {0,};

// xColumn function enumeration
typedef enum {
    xColumn_amatchColumn_enum = 0,
    xColumn_binfoColumn_enum = 1,
    xColumn_bytecodevtabColumn_enum = 2,
    xColumn_carrayColumn_enum = 3,
    xColumn_cidxColumn_enum = 4,
    xColumn_closureColumn_enum = 5,
    xColumn_completionColumn_enum = 6,
    xColumn_csvtabColumn_enum = 7,
    xColumn_dbdataColumn_enum = 8,
    xColumn_dbpageColumn_enum = 9,
    xColumn_deltaparsevtabColumn_enum = 10,
    xColumn_echoColumn_enum = 11,
    xColumn_expertColumn_enum = 12,
    xColumn_explainColumn_enum = 13,
    xColumn_fsColumn_enum = 14,
    xColumn_fsdirColumn_enum = 15,
    xColumn_fstreeColumn_enum = 16,
    xColumn_fts3ColumnMethod_enum = 17,
    xColumn_fts3auxColumnMethod_enum = 18,
    xColumn_fts3termColumnMethod_enum = 19,
    xColumn_fts3tokColumnMethod_enum = 20,
    xColumn_fts5ColumnMethod_enum = 21,
    xColumn_fts5VocabColumnMethod_enum = 22,
    xColumn_fts5structColumnMethod_enum = 23,
    xColumn_fts5tokColumnMethod_enum = 24,
    xColumn_fuzzerColumn_enum = 25,
    xColumn_geopolyColumn_enum = 26,
    xColumn_intarrayColumn_enum = 27,
    xColumn_jsonEachColumn_enum = 28,
    xColumn_memstatColumn_enum = 29,
    xColumn_pragmaVtabColumn_enum = 30,
    xColumn_prefixesColumn_enum = 31,
    xColumn_qpvtabColumn_enum = 32,
    xColumn_rtreeColumn_enum = 33,
    xColumn_schemaColumn_enum = 34,
    xColumn_seriesColumn_enum = 35,
    xColumn_spellfix1Column_enum = 36,
    xColumn_statColumn_enum = 37,
    xColumn_stmtColumn_enum = 38,
    xColumn_tclColumn_enum = 39,
    xColumn_tclvarColumn_enum = 40,
    xColumn_templatevtabColumn_enum = 41,
    xColumn_unionColumn_enum = 42,
    xColumn_vlogColumn_enum = 43,
    xColumn_vstattabColumn_enum = 44,
    xColumn_vtablogColumn_enum = 45,
    xColumn_wholenumberColumn_enum = 46,
    xColumn_zipfileColumn_enum = 47
} xColumn_enum;

// xColumn signature initialization function
void init_xColumn_signatures(void);
// xColumn function declarations
int amatchColumn(sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i);
int binfoColumn( sqlite3_vtab_cursor *pCursor, sqlite3_context *ctx, int i );
int bytecodevtabColumn( sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i );
int carrayColumn( sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i );
int cidxColumn( sqlite3_vtab_cursor *pCursor, sqlite3_context *ctx, int iCol );
int closureColumn(sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i);
int completionColumn( sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i );
int csvtabColumn(sqlite3_vtab_cursor*,sqlite3_context*,int);
int dbdataColumn( sqlite3_vtab_cursor *pCursor, sqlite3_context *ctx, int i );
int dbpageColumn( sqlite3_vtab_cursor *pCursor, sqlite3_context *ctx, int i );
int deltaparsevtabColumn( sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i );
int echoColumn(sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i);
int expertColumn(sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i);
int explainColumn( sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i );
int fsColumn(sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i);
int fsdirColumn(sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i);
int fstreeColumn(sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i);
int fts3ColumnMethod( sqlite3_vtab_cursor *pCursor, sqlite3_context *pCtx, int iCol );
int fts3auxColumnMethod( sqlite3_vtab_cursor *pCursor, sqlite3_context *pCtx, int iCol );
int fts3termColumnMethod( sqlite3_vtab_cursor *pCursor, sqlite3_context *pCtx, int iCol );
int fts3tokColumnMethod( sqlite3_vtab_cursor *pCursor, sqlite3_context *pCtx, int iCol );
int fts5ColumnMethod( sqlite3_vtab_cursor *pCursor, sqlite3_context *pCtx, int iCol );
int fts5VocabColumnMethod( sqlite3_vtab_cursor *pCursor, sqlite3_context *pCtx, int iCol );
int fts5structColumnMethod( sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i );
int fts5tokColumnMethod( sqlite3_vtab_cursor *pCursor, sqlite3_context *pCtx, int iCol );
int fuzzerColumn(sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i);
int geopolyColumn(sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i);
int intarrayColumn(sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i);
int jsonEachColumn( sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int iColumn );
int memstatColumn( sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int iCol );
int pragmaVtabColumn( sqlite3_vtab_cursor *pVtabCursor, sqlite3_context *ctx, int i );
int prefixesColumn( sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i );
int qpvtabColumn( sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i );
int rtreeColumn(sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i);
int schemaColumn(sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i);
int seriesColumn( sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i );
int spellfix1Column( sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i );
int statColumn( sqlite3_vtab_cursor *pCursor, sqlite3_context *ctx, int i );
int stmtColumn( sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i );
int tclColumn( sqlite3_vtab_cursor *pVtabCursor, sqlite3_context *ctx, int i );
int tclvarColumn(sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i);
int templatevtabColumn( sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i );
int unionColumn( sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i );
int vlogColumn( sqlite3_vtab_cursor *pCursor, sqlite3_context *ctx, int i );
int vstattabColumn(sqlite3_vtab_cursor*,sqlite3_context*,int);
int vtablogColumn( sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i );
int wholenumberColumn( sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i );
int zipfileColumn( sqlite3_vtab_cursor *cur, sqlite3_context *ctx, int i );

// =============== xColumnCount ===============
// xColumnCount function pointer signatures (extern)
static int xColumnCount_signatures[1][4] = {0,};

// xColumnCount function enumeration
typedef enum {
    xColumnCount_fts5ApiColumnCount_enum = 0
} xColumnCount_enum;

// xColumnCount signature initialization function
void init_xColumnCount_signatures(void);
// xColumnCount function declarations
int fts5ApiColumnCount(Fts5Context *pCtx);

// =============== xColumnLocale ===============
// xColumnLocale function pointer signatures (extern)
static int xColumnLocale_signatures[1][4] = {0,};

// xColumnLocale function enumeration
typedef enum {
    xColumnLocale_fts5ApiColumnLocale_enum = 0
} xColumnLocale_enum;

// xColumnLocale signature initialization function
void init_xColumnLocale_signatures(void);
// xColumnLocale function declarations
int fts5ApiColumnLocale( Fts5Context *pCtx, int iCol, const char **pzLocale, int *pnLocale );

// =============== xColumnSize ===============
// xColumnSize function pointer signatures (extern)
static int xColumnSize_signatures[1][4] = {0,};

// xColumnSize function enumeration
typedef enum {
    xColumnSize_fts5ApiColumnSize_enum = 0
} xColumnSize_enum;

// xColumnSize signature initialization function
void init_xColumnSize_signatures(void);
// xColumnSize function declarations
int fts5ApiColumnSize(Fts5Context *pCtx, int iCol, int *pnToken);

// =============== xColumnText ===============
// xColumnText function pointer signatures (extern)
static int xColumnText_signatures[1][4] = {0,};

// xColumnText function enumeration
typedef enum {
    xColumnText_fts5ApiColumnText_enum = 0
} xColumnText_enum;

// xColumnText signature initialization function
void init_xColumnText_signatures(void);
// xColumnText function declarations
int fts5ApiColumnText( Fts5Context *pCtx, int iCol, const char **pz, int *pn );

// =============== xColumnTotalSize ===============
// xColumnTotalSize function pointer signatures (extern)
static int xColumnTotalSize_signatures[1][4] = {0,};

// xColumnTotalSize function enumeration
typedef enum {
    xColumnTotalSize_fts5ApiColumnTotalSize_enum = 0
} xColumnTotalSize_enum;

// xColumnTotalSize signature initialization function
void init_xColumnTotalSize_signatures(void);
// xColumnTotalSize function declarations
int fts5ApiColumnTotalSize( Fts5Context *pCtx, int iCol, sqlite3_int64 *pnToken );

// =============== xCommit ===============
// xCommit function pointer signatures (extern)
static int xCommit_signatures[7][4] = {0,};

// xCommit function enumeration
typedef enum {
    xCommit_0_enum = 0,
    xCommit_echoCommit_enum = 1,
    xCommit_fts3CommitMethod_enum = 2,
    xCommit_fts5CommitMethod_enum = 3,
    xCommit_rtreeEndTransaction_enum = 4,
    xCommit_vtablogCommit_enum = 5,
    xCommit_zipfileCommit_enum = 6
} xCommit_enum;

// xCommit signature initialization function
void init_xCommit_signatures(void);
// xCommit function declarations
int echoCommit(sqlite3_vtab *tab);
int fts3CommitMethod(sqlite3_vtab *pVtab);
int fts5CommitMethod(sqlite3_vtab *pVtab);
int rtreeEndTransaction(sqlite3_vtab *pVtab);
int vtablogCommit(sqlite3_vtab *tab);
int zipfileCommit(sqlite3_vtab *pVtab);

// =============== xConnect ===============
// xConnect function pointer signatures (extern)
static int xConnect_signatures[48][4] = {0,};

// xConnect function enumeration
typedef enum {
    xConnect_amatchConnect_enum = 0,
    xConnect_binfoConnect_enum = 1,
    xConnect_bytecodevtabConnect_enum = 2,
    xConnect_carrayConnect_enum = 3,
    xConnect_cidxConnect_enum = 4,
    xConnect_closureConnect_enum = 5,
    xConnect_completionConnect_enum = 6,
    xConnect_csvtabConnect_enum = 7,
    xConnect_dbdataConnect_enum = 8,
    xConnect_dbpageConnect_enum = 9,
    xConnect_deltaparsevtabConnect_enum = 10,
    xConnect_echoConnect_enum = 11,
    xConnect_expertConnect_enum = 12,
    xConnect_explainConnect_enum = 13,
    xConnect_fsConnect_enum = 14,
    xConnect_fsdirConnect_enum = 15,
    xConnect_fstreeConnect_enum = 16,
    xConnect_fts3ConnectMethod_enum = 17,
    xConnect_fts3auxConnectMethod_enum = 18,
    xConnect_fts3termConnectMethod_enum = 19,
    xConnect_fts3tokConnectMethod_enum = 20,
    xConnect_fts5ConnectMethod_enum = 21,
    xConnect_fts5VocabConnectMethod_enum = 22,
    xConnect_fts5structConnectMethod_enum = 23,
    xConnect_fts5tokConnectMethod_enum = 24,
    xConnect_fuzzerConnect_enum = 25,
    xConnect_geopolyConnect_enum = 26,
    xConnect_intarrayCreate_enum = 27,
    xConnect_jsonEachConnect_enum = 28,
    xConnect_memstatConnect_enum = 29,
    xConnect_pragmaVtabConnect_enum = 30,
    xConnect_prefixesConnect_enum = 31,
    xConnect_qpvtabConnect_enum = 32,
    xConnect_rtreeConnect_enum = 33,
    xConnect_schemaCreate_enum = 34,
    xConnect_seriesConnect_enum = 35,
    xConnect_spellfix1Connect_enum = 36,
    xConnect_statConnect_enum = 37,
    xConnect_stmtConnect_enum = 38,
    xConnect_tclConnect_enum = 39,
    xConnect_tclvarConnect_enum = 40,
    xConnect_templatevtabConnect_enum = 41,
    xConnect_unionConnect_enum = 42,
    xConnect_vlogConnect_enum = 43,
    xConnect_vstattabConnect_enum = 44,
    xConnect_vtablogConnect_enum = 45,
    xConnect_wholenumberConnect_enum = 46,
    xConnect_zipfileConnect_enum = 47
} xConnect_enum;

// xConnect signature initialization function
void init_xConnect_signatures(void);
// xConnect function declarations
int amatchConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int binfoConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int bytecodevtabConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int carrayConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int cidxConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int closureConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int completionConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int csvtabConnect(sqlite3*, void*, int, const char*const*, sqlite3_vtab**,char**);
int dbdataConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int dbpageConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int deltaparsevtabConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int echoConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int expertConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int explainConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int fsConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int fsdirConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int fstreeConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int fts3ConnectMethod( sqlite3 *db, void *pAux, int argc, const char * const *argv, sqlite3_vtab **ppVtab, char **pzErr );
int fts3auxConnectMethod( sqlite3 *db, void *pUnused, int argc, const char * const *argv, sqlite3_vtab **ppVtab, char **pzErr );
int fts3termConnectMethod( sqlite3 *db, void *pCtx, int argc, const char * const *argv, sqlite3_vtab **ppVtab, char **pzErr );
int fts3tokConnectMethod( sqlite3 *db, void *pHash, int argc, const char * const *argv, sqlite3_vtab **ppVtab, char **pzErr );
int fts5ConnectMethod( sqlite3 *db, void *pAux, int argc, const char * const *argv, sqlite3_vtab **ppVtab, char **pzErr );
int fts5VocabConnectMethod( sqlite3 *db, void *pAux, int argc, const char * const *argv, sqlite3_vtab **ppVtab, char **pzErr );
int fts5structConnectMethod( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int fts5tokConnectMethod( sqlite3 *db, void *pCtx, int argc, const char * const *argv, sqlite3_vtab **ppVtab, char **pzErr );
int fuzzerConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int geopolyConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int intarrayCreate( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int jsonEachConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int memstatConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int pragmaVtabConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int prefixesConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int qpvtabConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int rtreeConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int schemaCreate( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int seriesConnect( sqlite3 *db, void *pUnused, int argcUnused, const char *const*argvUnused, sqlite3_vtab **ppVtab, char **pzErrUnused );
int spellfix1Connect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVTab, char **pzErr );
int statConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int stmtConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int tclConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int tclvarConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int templatevtabConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int unionConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int vlogConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int vstattabConnect(sqlite3*, void*, int, const char*const*, sqlite3_vtab**,char**);
int vtablogConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int wholenumberConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int zipfileConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );

// =============== xCount ===============
// xCount function pointer signatures (extern)
static int xCount_signatures[3][4] = {0,};

// xCount function enumeration
typedef enum {
    xCount_sessionDiffCount_enum = 0,
    xCount_sessionPreupdateCount_enum = 1,
    xCount_sessionStat1Count_enum = 2
} xCount_enum;

// xCount signature initialization function
void init_xCount_signatures(void);
// xCount function declarations
int sessionDiffCount(void *pCtx);
int sessionPreupdateCount(void *pCtx);
int sessionStat1Count(void *pCtx);

// =============== xCreate ===============
// xCreate function pointer signatures (extern)
static int xCreate_signatures[40][4] = {0,};

// xCreate function enumeration
typedef enum {
    xCreate_0_enum = 0,
    xCreate_amatchConnect_enum = 1,
    xCreate_closureConnect_enum = 2,
    xCreate_csvtabCreate_enum = 3,
    xCreate_dbpageConnect_enum = 4,
    xCreate_echoCreate_enum = 5,
    xCreate_expertConnect_enum = 6,
    xCreate_f5tOrigintextCreate_enum = 7,
    xCreate_f5tTokenizerCreate_enum = 8,
    xCreate_fsConnect_enum = 9,
    xCreate_fsdirConnect_enum = 10,
    xCreate_fstreeConnect_enum = 11,
    xCreate_fts3CreateMethod_enum = 12,
    xCreate_fts3auxConnectMethod_enum = 13,
    xCreate_fts3termConnectMethod_enum = 14,
    xCreate_fts3tokConnectMethod_enum = 15,
    xCreate_fts5CreateMethod_enum = 16,
    xCreate_fts5PorterCreate_enum = 17,
    xCreate_fts5VocabCreateMethod_enum = 18,
    xCreate_fts5VtoVCreate_enum = 19,
    xCreate_fts5tokConnectMethod_enum = 20,
    xCreate_fuzzerConnect_enum = 21,
    xCreate_geopolyCreate_enum = 22,
    xCreate_intarrayCreate_enum = 23,
    xCreate_pcache1Create_enum = 24,
    xCreate_pcachetraceCreate_enum = 25,
    xCreate_porterCreate_enum = 26,
    xCreate_rtreeCreate_enum = 27,
    xCreate_schemaCreate_enum = 28,
    xCreate_simpleCreate_enum = 29,
    xCreate_spellfix1Create_enum = 30,
    xCreate_statConnect_enum = 31,
    xCreate_tclConnect_enum = 32,
    xCreate_tclvarConnect_enum = 33,
    xCreate_unicodeCreate_enum = 34,
    xCreate_unionConnect_enum = 35,
    xCreate_vlogConnect_enum = 36,
    xCreate_vtablogCreate_enum = 37,
    xCreate_wholenumberConnect_enum = 38,
    xCreate_zipfileConnect_enum = 39
} xCreate_enum;

// xCreate signature initialization function
void init_xCreate_signatures(void);
// xCreate function declarations
int amatchConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int closureConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int csvtabCreate(sqlite3*, void*, int, const char*const*, sqlite3_vtab**,char**);
int dbpageConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int echoCreate( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int expertConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int f5tOrigintextCreate( void *pCtx, const char **azArg, int nArg, Fts5Tokenizer **ppOut );
int f5tTokenizerCreate( void *pCtx, const char **azArg, int nArg, Fts5Tokenizer **ppOut );
int fsConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int fsdirConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int fstreeConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int fts3CreateMethod( sqlite3 *db, void *pAux, int argc, const char * const *argv, sqlite3_vtab **ppVtab, char **pzErr );
int fts3auxConnectMethod( sqlite3 *db, void *pUnused, int argc, const char * const *argv, sqlite3_vtab **ppVtab, char **pzErr );
int fts3termConnectMethod( sqlite3 *db, void *pCtx, int argc, const char * const *argv, sqlite3_vtab **ppVtab, char **pzErr );
int fts3tokConnectMethod( sqlite3 *db, void *pHash, int argc, const char * const *argv, sqlite3_vtab **ppVtab, char **pzErr );
int fts5CreateMethod( sqlite3 *db, void *pAux, int argc, const char * const *argv, sqlite3_vtab **ppVtab, char **pzErr );
int fts5PorterCreate( void *pCtx, const char **azArg, int nArg, Fts5Tokenizer **ppOut );
int fts5VocabCreateMethod( sqlite3 *db, void *pAux, int argc, const char * const *argv, sqlite3_vtab **ppVtab, char **pzErr );
int fts5VtoVCreate( void *pCtx, const char **azArg, int nArg, Fts5Tokenizer **ppOut );
int fts5tokConnectMethod( sqlite3 *db, void *pCtx, int argc, const char * const *argv, sqlite3_vtab **ppVtab, char **pzErr );
int fuzzerConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int geopolyCreate( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int intarrayCreate( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
sqlite3_pcache *pcache1Create(int szPage, int szExtra, int bPurgeable);
sqlite3_pcache *pcachetraceCreate(int szPage, int szExtra, int bPurge);
int porterCreate( int argc, const char * const *argv, sqlite3_tokenizer **ppTokenizer );
int rtreeCreate( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int schemaCreate( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int simpleCreate( int argc, const char * const *argv, sqlite3_tokenizer **ppTokenizer );
int spellfix1Create( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVTab, char **pzErr );
int statConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int tclConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int tclvarConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int unicodeCreate( int nArg, const char * const *azArg, sqlite3_tokenizer **pp );
int unionConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int vlogConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int vtablogCreate( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int wholenumberConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );
int zipfileConnect( sqlite3 *db, void *pAux, int argc, const char *const*argv, sqlite3_vtab **ppVtab, char **pzErr );

// =============== xCreateTokenizer ===============
// xCreateTokenizer function pointer signatures (extern)
static int xCreateTokenizer_signatures[1][4] = {0,};

// xCreateTokenizer function enumeration
typedef enum {
    xCreateTokenizer_fts5CreateTokenizer_enum = 0
} xCreateTokenizer_enum;

// xCreateTokenizer signature initialization function
void init_xCreateTokenizer_signatures(void);
// xCreateTokenizer function declarations
int fts5CreateTokenizer( fts5_api *pApi, const char *zName, void *pUserData, fts5_tokenizer *pTokenizer, void(*xDestroy)(void*) );

// =============== xCreateTokenizer_v2 ===============
// xCreateTokenizer_v2 function pointer signatures (extern)
static int xCreateTokenizer_v2_signatures[1][4] = {0,};

// xCreateTokenizer_v2 function enumeration
typedef enum {
    xCreateTokenizer_v2_fts5CreateTokenizer_v2_enum = 0
} xCreateTokenizer_v2_enum;

// xCreateTokenizer_v2 signature initialization function
void init_xCreateTokenizer_v2_signatures(void);
// xCreateTokenizer_v2 function declarations
int fts5CreateTokenizer_v2( fts5_api *pApi, const char *zName, void *pUserData, fts5_tokenizer_v2 *pTokenizer, void(*xDestroy)(void*) );

// =============== xCurrentTime ===============
// xCurrentTime function pointer signatures (extern)
static int xCurrentTime_signatures[4][4] = {0,};

// xCurrentTime function enumeration
typedef enum {
    xCurrentTime_0_enum = 0,
    xCurrentTime_apndCurrentTime_enum = 1,
    xCurrentTime_vfstraceCurrentTime_enum = 2,
    xCurrentTime_unixCurrentTime_enum = 3
} xCurrentTime_enum;

// xCurrentTime signature initialization function
void init_xCurrentTime_signatures(void);
// xCurrentTime function declarations
int apndCurrentTime(sqlite3_vfs*, double*);
int multiplexCurrentTime(sqlite3_vfs *a, double *b);
int vfstraceCurrentTime(sqlite3_vfs*, double*);
int unixCurrentTime(sqlite3_vfs *NotUsed, double *prNow);

// =============== xCurrentTimeInt64 ===============
// xCurrentTimeInt64 function pointer signatures (extern)
static int xCurrentTimeInt64_signatures[4][4] = {0,};

// xCurrentTimeInt64 function enumeration
typedef enum {
    xCurrentTimeInt64_0_enum = 0,
    xCurrentTimeInt64_apndCurrentTimeInt64_enum = 1,
    xCurrentTimeInt64_memdbCurrentTimeInt64_enum = 2,
    xCurrentTimeInt64_unixCurrentTimeInt64_enum = 3
} xCurrentTimeInt64_enum;

// xCurrentTimeInt64 signature initialization function
void init_xCurrentTimeInt64_signatures(void);
// xCurrentTimeInt64 function declarations
int apndCurrentTimeInt64(sqlite3_vfs*, sqlite3_int64*);
int memdbCurrentTimeInt64(sqlite3_vfs*, sqlite3_int64*);
int multiplexCurrentTimeInt64(sqlite3_vfs *a, sqlite3_int64 *b);
int unixCurrentTimeInt64(sqlite3_vfs *NotUsed, sqlite3_int64 *piNow);

// =============== xDel ===============
// xDel function pointer signatures (extern)
static int xDel_signatures[4][4] = {0,};

// xDel function enumeration
typedef enum {
    xDel_0_enum = 0,
    xDel_sqlite3RowSetDelete_enum = 1,
    xDel_sqlite3VdbeFrameMemDel_enum = 2,
    xDel_sqlite3_free_enum = 3
} xDel_enum;

// xDel signature initialization function
void init_xDel_signatures(void);
// xDel function declarations
void sqlite3RowSetDelete(void *pArg);
void sqlite3VdbeFrameMemDel(void *pArg);
void sqlite3_free(void*);

// =============== xDelete ===============
// xDelete function pointer signatures (extern)
static int xDelete_signatures[9][4] = {0,};

// xDelete function enumeration
typedef enum {
    xDelete_0_enum = 0,
    xDelete_apndDelete_enum = 1,
    xDelete_f5tOrigintextDelete_enum = 2,
    xDelete_f5tTokenizerDelete_enum = 3,
    xDelete_fts5PorterDelete_enum = 4,
    xDelete_fts5VtoVDelete_enum = 5,
    xDelete_kvstorageDelete_enum = 6,
    xDelete_vfstraceDelete_enum = 7,
    xDelete_unixDelete_enum = 8
} xDelete_enum;

// xDelete signature initialization function
void init_xDelete_signatures(void);
// xDelete function declarations
int apndDelete(sqlite3_vfs*, const char *zName, int syncDir);
void f5tOrigintextDelete(Fts5Tokenizer *pTokenizer);
void f5tTokenizerDelete(Fts5Tokenizer *p);
void fts5PorterDelete(Fts5Tokenizer *pTok);
void fts5VtoVDelete(Fts5Tokenizer *pTok);
int kvstorageDelete(const char*, const char *zKey);
int multiplexDelete( sqlite3_vfs *pVfs, const char *zName, int syncDir );
int quotaDelete( sqlite3_vfs *pVfs, const char *zName, int syncDir );
int vfstraceDelete(sqlite3_vfs*, const char *zName, int syncDir);
int unixDelete(sqlite3_vfs *NotUsed, const char *zPath, int dirSync);

// =============== xDepth ===============
// xDepth function pointer signatures (extern)
static int xDepth_signatures[3][4] = {0,};

// xDepth function enumeration
typedef enum {
    xDepth_sessionDiffDepth_enum = 0,
    xDepth_sessionPreupdateDepth_enum = 1,
    xDepth_sessionStat1Depth_enum = 2
} xDepth_enum;

// xDepth signature initialization function
void init_xDepth_signatures(void);
// xDepth function declarations
int sessionDiffDepth(void *pCtx);
int sessionPreupdateDepth(void *pCtx);
int sessionStat1Depth(void *pCtx);

// =============== xDestroy ===============
// xDestroy function pointer signatures (extern)
static int xDestroy_signatures[18][4] = {0,};

// xDestroy function enumeration
typedef enum {
    xDestroy_0_enum = 0,
    xDestroy_dbpageDisconnect_enum = 1,
    xDestroy_expertDisconnect_enum = 2,
    xDestroy_fsdirDisconnect_enum = 3,
    xDestroy_fts3DestroyMethod_enum = 4,
    xDestroy_fts3auxDisconnectMethod_enum = 5,
    xDestroy_fts3tokDisconnectMethod_enum = 6,
    xDestroy_fts5DestroyMethod_enum = 7,
    xDestroy_fts5VocabDestroyMethod_enum = 8,
    xDestroy_fts5tokDisconnectMethod_enum = 9,
    xDestroy_pcache1Destroy_enum = 10,
    xDestroy_pcachetraceDestroy_enum = 11,
    xDestroy_porterDestroy_enum = 12,
    xDestroy_rtreeDestroy_enum = 13,
    xDestroy_simpleDestroy_enum = 14,
    xDestroy_statDisconnect_enum = 15,
    xDestroy_unicodeDestroy_enum = 16,
    xDestroy_zipfileDisconnect_enum = 17
} xDestroy_enum;

// xDestroy signature initialization function
void init_xDestroy_signatures(void);
// xDestroy function declarations
int dbpageDisconnect(sqlite3_vtab *pVtab);
int expertDisconnect(sqlite3_vtab *pVtab);
int fsdirDisconnect(sqlite3_vtab *pVtab);
int fts3DestroyMethod(sqlite3_vtab *pVtab);
int fts3auxDisconnectMethod(sqlite3_vtab *pVtab);
int fts3tokDisconnectMethod(sqlite3_vtab *pVtab);
int fts5DestroyMethod(sqlite3_vtab *pVtab);
int fts5VocabDestroyMethod(sqlite3_vtab *pVtab);
int fts5tokDisconnectMethod(sqlite3_vtab *pVtab);
void pcache1Destroy(sqlite3_pcache *p);
void pcachetraceDestroy(sqlite3_pcache *p);
int porterDestroy(sqlite3_tokenizer *pTokenizer);
int rtreeDestroy(sqlite3_vtab *pVtab);
int simpleDestroy(sqlite3_tokenizer *pTokenizer);
int statDisconnect(sqlite3_vtab *pVtab);
int unicodeDestroy(sqlite3_tokenizer *pTokenizer);
int zipfileDisconnect(sqlite3_vtab *pVtab);

// =============== xDeviceCharacteristics ===============
// xDeviceCharacteristics function pointer signatures (extern)
static int xDeviceCharacteristics_signatures[6][4] = {0,};

// xDeviceCharacteristics function enumeration
typedef enum {
    xDeviceCharacteristics_0_enum = 0,
    xDeviceCharacteristics_apndDeviceCharacteristics_enum = 1,
    xDeviceCharacteristics_memdbDeviceCharacteristics_enum = 2,
    xDeviceCharacteristics_recoverVfsDeviceCharacteristics_enum = 3,
    xDeviceCharacteristics_vfstraceDeviceCharacteristics_enum = 4,
    xDeviceCharacteristics_unixDeviceCharacteristics_enum = 5
} xDeviceCharacteristics_enum;

// xDeviceCharacteristics signature initialization function
void init_xDeviceCharacteristics_signatures(void);
// xDeviceCharacteristics function declarations
int apndDeviceCharacteristics(sqlite3_file*);
int memdbDeviceCharacteristics(sqlite3_file*);
int multiplexDeviceCharacteristics(sqlite3_file *pConn);
int quotaDeviceCharacteristics(sqlite3_file *pConn);
int vfstraceDeviceCharacteristics(sqlite3_file*);
int unixDeviceCharacteristics(sqlite3_file *id);

// =============== xDisconnect ===============
// xDisconnect function pointer signatures (extern)
static int xDisconnect_signatures[20][4] = {0,};

// xDisconnect function enumeration
typedef enum {
    xDisconnect_bytecodevtabDisconnect_enum = 0,
    xDisconnect_completionDisconnect_enum = 1,
    xDisconnect_dbdataDisconnect_enum = 2,
    xDisconnect_dbpageDisconnect_enum = 3,
    xDisconnect_expertDisconnect_enum = 4,
    xDisconnect_fsdirDisconnect_enum = 5,
    xDisconnect_fts3DisconnectMethod_enum = 6,
    xDisconnect_fts3auxDisconnectMethod_enum = 7,
    xDisconnect_fts3tokDisconnectMethod_enum = 8,
    xDisconnect_fts5DisconnectMethod_enum = 9,
    xDisconnect_fts5VocabDisconnectMethod_enum = 10,
    xDisconnect_fts5structDisconnectMethod_enum = 11,
    xDisconnect_fts5tokDisconnectMethod_enum = 12,
    xDisconnect_jsonEachDisconnect_enum = 13,
    xDisconnect_pragmaVtabDisconnect_enum = 14,
    xDisconnect_rtreeDisconnect_enum = 15,
    xDisconnect_seriesDisconnect_enum = 16,
    xDisconnect_statDisconnect_enum = 17,
    xDisconnect_stmtDisconnect_enum = 18,
    xDisconnect_zipfileDisconnect_enum = 19
} xDisconnect_enum;

// xDisconnect signature initialization function
void init_xDisconnect_signatures(void);
// xDisconnect function declarations
int bytecodevtabDisconnect(sqlite3_vtab *pVtab);
int completionDisconnect(sqlite3_vtab *pVtab);
int dbdataDisconnect(sqlite3_vtab *pVtab);
int dbpageDisconnect(sqlite3_vtab *pVtab);
int expertDisconnect(sqlite3_vtab *pVtab);
int fsdirDisconnect(sqlite3_vtab *pVtab);
int fts3DisconnectMethod(sqlite3_vtab *pVtab);
int fts3auxDisconnectMethod(sqlite3_vtab *pVtab);
int fts3tokDisconnectMethod(sqlite3_vtab *pVtab);
int fts5DisconnectMethod(sqlite3_vtab *pVtab);
int fts5VocabDisconnectMethod(sqlite3_vtab *pVtab);
int fts5structDisconnectMethod(sqlite3_vtab *pVtab);
int fts5tokDisconnectMethod(sqlite3_vtab *pVtab);
int jsonEachDisconnect(sqlite3_vtab *pVtab);
int pragmaVtabDisconnect(sqlite3_vtab *pVtab);
int rtreeDisconnect(sqlite3_vtab *pVtab);
int seriesDisconnect(sqlite3_vtab *pVtab);
int statDisconnect(sqlite3_vtab *pVtab);
int stmtDisconnect(sqlite3_vtab *pVtab);
int zipfileDisconnect(sqlite3_vtab *pVtab);

// =============== xDlClose ===============
// xDlClose function pointer signatures (extern)
static int xDlClose_signatures[4][4] = {0,};

// xDlClose function enumeration
typedef enum {
    xDlClose_0_enum = 0,
    xDlClose_apndDlClose_enum = 1,
    xDlClose_memdbDlClose_enum = 2,
    xDlClose_unixDlClose_enum = 3
} xDlClose_enum;

// xDlClose signature initialization function
void init_xDlClose_signatures(void);
// xDlClose function declarations
void apndDlClose(sqlite3_vfs*, void*);
void memdbDlClose(sqlite3_vfs*, void*);
void multiplexDlClose(sqlite3_vfs *a, void *b);
void unixDlClose(sqlite3_vfs *NotUsed, void *pHandle);

// =============== xDlError ===============
// xDlError function pointer signatures (extern)
static int xDlError_signatures[4][4] = {0,};

// xDlError function enumeration
typedef enum {
    xDlError_0_enum = 0,
    xDlError_apndDlError_enum = 1,
    xDlError_memdbDlError_enum = 2,
    xDlError_unixDlError_enum = 3
} xDlError_enum;

// xDlError signature initialization function
void init_xDlError_signatures(void);
// xDlError function declarations
void apndDlError(sqlite3_vfs*, int nByte, char *zErrMsg);
void memdbDlError(sqlite3_vfs*, int nByte, char *zErrMsg);
void multiplexDlError(sqlite3_vfs *a, int b, char *c);
void unixDlError(sqlite3_vfs *NotUsed, int nBuf, char *zBufOut);

// =============== xDlOpen ===============
// xDlOpen function pointer signatures (extern)
static int xDlOpen_signatures[3][4] = {0,};

// xDlOpen function enumeration
typedef enum {
    xDlOpen_apndDlOpen_enum = 0,
    xDlOpen_memdbDlOpen_enum = 1,
    xDlOpen_unixDlOpen_enum = 2
} xDlOpen_enum;

// xDlOpen signature initialization function
void init_xDlOpen_signatures(void);
// xDlOpen function declarations
void *apndDlOpen(sqlite3_vfs*, const char *zFilename);
void *memdbDlOpen(sqlite3_vfs*, const char *zFilename);
void *multiplexDlOpen(sqlite3_vfs *a, const char *b);
void *unixDlOpen(sqlite3_vfs *NotUsed, const char *zFilename);

// =============== xDlSym ===============
// xDlSym function pointer signatures (extern)
static int xDlSym_signatures[14][4] = {0,};

// xDlSym function enumeration
typedef enum {
    xDlSym_0_enum = 0,
    xDlSym_apndDlSym_enum = 1,
    xDlSym_cfDlSym_enum = 2,
    xDlSym_cksmDlSym_enum = 3,
    xDlSym_demoDlSym_enum = 4,
    xDlSym_devsymDlSym_enum = 5,
    xDlSym_jtDlSym_enum = 6,
    xDlSym_memDlSym_enum = 7,
    xDlSym_memdbDlSym_enum = 8,
    xDlSym_rbuVfsDlSym_enum = 9,
    xDlSym_tvfsDlSym_enum = 10,
    xDlSym_vfslogDlSym_enum = 11,
    xDlSym_winDlSym_enum = 12,
    xDlSym_unixDlSym_enum = 13
} xDlSym_enum;

// xDlSym signature initialization function
void init_xDlSym_signatures(void);
// No valid declarations found for xDlSym
// =============== xEof ===============
// xEof function pointer signatures (extern)
static int xEof_signatures[47][4] = {0,};

// xEof function enumeration
typedef enum {
    xEof_amatchEof_enum = 0,
    xEof_binfoEof_enum = 1,
    xEof_bytecodevtabEof_enum = 2,
    xEof_carrayEof_enum = 3,
    xEof_cidxEof_enum = 4,
    xEof_closureEof_enum = 5,
    xEof_completionEof_enum = 6,
    xEof_csvtabEof_enum = 7,
    xEof_dbdataEof_enum = 8,
    xEof_dbpageEof_enum = 9,
    xEof_deltaparsevtabEof_enum = 10,
    xEof_echoEof_enum = 11,
    xEof_expertEof_enum = 12,
    xEof_explainEof_enum = 13,
    xEof_fsEof_enum = 14,
    xEof_fsdirEof_enum = 15,
    xEof_fstreeEof_enum = 16,
    xEof_fts3EofMethod_enum = 17,
    xEof_fts3auxEofMethod_enum = 18,
    xEof_fts3termEofMethod_enum = 19,
    xEof_fts3tokEofMethod_enum = 20,
    xEof_fts5EofMethod_enum = 21,
    xEof_fts5VocabEofMethod_enum = 22,
    xEof_fts5structEofMethod_enum = 23,
    xEof_fts5tokEofMethod_enum = 24,
    xEof_fuzzerEof_enum = 25,
    xEof_intarrayEof_enum = 26,
    xEof_jsonEachEof_enum = 27,
    xEof_memstatEof_enum = 28,
    xEof_pragmaVtabEof_enum = 29,
    xEof_prefixesEof_enum = 30,
    xEof_qpvtabEof_enum = 31,
    xEof_rtreeEof_enum = 32,
    xEof_schemaEof_enum = 33,
    xEof_seriesEof_enum = 34,
    xEof_spellfix1Eof_enum = 35,
    xEof_statEof_enum = 36,
    xEof_stmtEof_enum = 37,
    xEof_tclEof_enum = 38,
    xEof_tclvarEof_enum = 39,
    xEof_templatevtabEof_enum = 40,
    xEof_unionEof_enum = 41,
    xEof_vlogEof_enum = 42,
    xEof_vstattabEof_enum = 43,
    xEof_vtablogEof_enum = 44,
    xEof_wholenumberEof_enum = 45,
    xEof_zipfileEof_enum = 46
} xEof_enum;

// xEof signature initialization function
void init_xEof_signatures(void);
// xEof function declarations
int amatchEof(sqlite3_vtab_cursor *cur);
int binfoEof(sqlite3_vtab_cursor *pCursor);
int bytecodevtabEof(sqlite3_vtab_cursor *cur);
int carrayEof(sqlite3_vtab_cursor *cur);
int cidxEof(sqlite3_vtab_cursor *pCursor);
int closureEof(sqlite3_vtab_cursor *cur);
int completionEof(sqlite3_vtab_cursor *cur);
int csvtabEof(sqlite3_vtab_cursor*);
int dbdataEof(sqlite3_vtab_cursor *pCursor);
int dbpageEof(sqlite3_vtab_cursor *pCursor);
int deltaparsevtabEof(sqlite3_vtab_cursor *cur);
int echoEof(sqlite3_vtab_cursor *cur);
int expertEof(sqlite3_vtab_cursor *cur);
int explainEof(sqlite3_vtab_cursor *cur);
int fsEof(sqlite3_vtab_cursor *cur);
int fsdirEof(sqlite3_vtab_cursor *cur);
int fstreeEof(sqlite3_vtab_cursor *cur);
int fts3EofMethod(sqlite3_vtab_cursor *pCursor);
int fts3auxEofMethod(sqlite3_vtab_cursor *pCursor);
int fts3termEofMethod(sqlite3_vtab_cursor *pCursor);
int fts3tokEofMethod(sqlite3_vtab_cursor *pCursor);
int fts5EofMethod(sqlite3_vtab_cursor *pCursor);
int fts5VocabEofMethod(sqlite3_vtab_cursor *pCursor);
int fts5structEofMethod(sqlite3_vtab_cursor *cur);
int fts5tokEofMethod(sqlite3_vtab_cursor *pCursor);
int fuzzerEof(sqlite3_vtab_cursor *cur);
int intarrayEof(sqlite3_vtab_cursor *cur);
int jsonEachEof(sqlite3_vtab_cursor *cur);
int memstatEof(sqlite3_vtab_cursor *cur);
int pragmaVtabEof(sqlite3_vtab_cursor *pVtabCursor);
int prefixesEof(sqlite3_vtab_cursor *cur);
int qpvtabEof(sqlite3_vtab_cursor *cur);
int rtreeEof(sqlite3_vtab_cursor *cur);
int schemaEof(sqlite3_vtab_cursor *cur);
int seriesEof(sqlite3_vtab_cursor *cur);
int spellfix1Eof(sqlite3_vtab_cursor *cur);
int statEof(sqlite3_vtab_cursor *pCursor);
int stmtEof(sqlite3_vtab_cursor *cur);
int tclEof(sqlite3_vtab_cursor *pVtabCursor);
int tclvarEof(sqlite3_vtab_cursor *cur);
int templatevtabEof(sqlite3_vtab_cursor *cur);
int unionEof(sqlite3_vtab_cursor *cur);
int vlogEof(sqlite3_vtab_cursor *pCursor);
int vstattabEof(sqlite3_vtab_cursor*);
int vtablogEof(sqlite3_vtab_cursor *cur);
int wholenumberEof(sqlite3_vtab_cursor *cur);
int zipfileEof(sqlite3_vtab_cursor *cur);

// =============== xExprCallback ===============
// xExprCallback function pointer signatures (extern)
static int xExprCallback_signatures[37][4] = {0,};

// xExprCallback function enumeration
typedef enum {
    xExprCallback_agginfoPersistExprCb_enum = 0,
    xExprCallback_aggregateIdxEprRefToColCallback_enum = 1,
    xExprCallback_analyzeAggregate_enum = 2,
    xExprCallback_checkConstraintExprNode_enum = 3,
    xExprCallback_codeCursorHintCheckExpr_enum = 4,
    xExprCallback_codeCursorHintFixExpr_enum = 5,
    xExprCallback_codeCursorHintIsOrFunction_enum = 6,
    xExprCallback_disallowAggregatesInOrderByCb_enum = 7,
    xExprCallback_exprColumnFlagUnion_enum = 8,
    xExprCallback_exprIdxCover_enum = 9,
    xExprCallback_exprNodeCanReturnSubtype_enum = 10,
    xExprCallback_exprNodeIsConstant_enum = 11,
    xExprCallback_exprNodeIsConstantOrGroupBy_enum = 12,
    xExprCallback_exprNodeIsDeterministic_enum = 13,
    xExprCallback_exprRefToSrcList_enum = 14,
    xExprCallback_fixExprCb_enum = 15,
    xExprCallback_gatherSelectWindowsCallback_enum = 16,
    xExprCallback_havingToWhereExprCb_enum = 17,
    xExprCallback_impliesNotNullRow_enum = 18,
    xExprCallback_incrAggDepth_enum = 19,
    xExprCallback_markImmutableExprStep_enum = 20,
    xExprCallback_propagateConstantExprRewrite_enum = 21,
    xExprCallback_recomputeColumnsUsedExpr_enum = 22,
    xExprCallback_renameColumnExprCb_enum = 23,
    xExprCallback_renameQuotefixExprCb_enum = 24,
    xExprCallback_renameTableExprCb_enum = 25,
    xExprCallback_renameUnmapExprCb_enum = 26,
    xExprCallback_renumberCursorsCb_enum = 27,
    xExprCallback_resolveExprStep_enum = 28,
    xExprCallback_resolveRemoveWindowsCb_enum = 29,
    xExprCallback_selectCheckOnClausesExpr_enum = 30,
    xExprCallback_selectWindowRewriteExprCb_enum = 31,
    xExprCallback_sqlite3CursorRangeHintExprCheck_enum = 32,
    xExprCallback_sqlite3ExprWalkNoop_enum = 33,
    xExprCallback_sqlite3ReturningSubqueryVarSelect_enum = 34,
    xExprCallback_sqlite3WindowExtraAggFuncDepth_enum = 35,
    xExprCallback_whereIsCoveringIndexWalkCallback_enum = 36
} xExprCallback_enum;

// xExprCallback signature initialization function
void init_xExprCallback_signatures(void);
// xExprCallback function declarations
int agginfoPersistExprCb(Walker *pWalker, Expr *pExpr);
int aggregateIdxEprRefToColCallback(Walker *pWalker, Expr *pExpr);
int analyzeAggregate(Walker *pWalker, Expr *pExpr);
int checkConstraintExprNode(Walker *pWalker, Expr *pExpr);
int codeCursorHintCheckExpr(Walker *pWalker, Expr *pExpr);
int codeCursorHintFixExpr(Walker *pWalker, Expr *pExpr);
int codeCursorHintIsOrFunction(Walker *pWalker, Expr *pExpr);
int disallowAggregatesInOrderByCb(Walker *pWalker, Expr *pExpr);
int exprColumnFlagUnion(Walker *pWalker, Expr *pExpr);
int exprIdxCover(Walker *pWalker, Expr *pExpr);
int exprNodeCanReturnSubtype(Walker *pWalker, Expr *pExpr);
int exprNodeIsConstant(Walker *pWalker, Expr *pExpr);
int exprNodeIsConstantOrGroupBy(Walker *pWalker, Expr *pExpr);
int exprNodeIsDeterministic(Walker *pWalker, Expr *pExpr);
int exprRefToSrcList(Walker *pWalker, Expr *pExpr);
int fixExprCb(Walker *p, Expr *pExpr);
int gatherSelectWindowsCallback(Walker *pWalker, Expr *pExpr);
int havingToWhereExprCb(Walker *pWalker, Expr *pExpr);
int impliesNotNullRow(Walker *pWalker, Expr *pExpr);
int incrAggDepth(Walker *pWalker, Expr *pExpr);
int markImmutableExprStep(Walker *pWalker, Expr *pExpr);
int propagateConstantExprRewrite(Walker *pWalker, Expr *pExpr);
int recomputeColumnsUsedExpr(Walker *pWalker, Expr *pExpr);
int renameColumnExprCb(Walker *pWalker, Expr *pExpr);
int renameQuotefixExprCb(Walker *pWalker, Expr *pExpr);
int renameTableExprCb(Walker *pWalker, Expr *pExpr);
int renameUnmapExprCb(Walker *pWalker, Expr *pExpr);
int renumberCursorsCb(Walker *pWalker, Expr *pExpr);
int resolveExprStep(Walker *pWalker, Expr *pExpr);
int resolveRemoveWindowsCb(Walker *pWalker, Expr *pExpr);
int selectCheckOnClausesExpr(Walker *pWalker, Expr *pExpr);
int selectWindowRewriteExprCb(Walker *pWalker, Expr *pExpr);
int sqlite3CursorRangeHintExprCheck(Walker *pWalker, Expr *pExpr);
int sqlite3ExprWalkNoop(Walker*, Expr*);
int sqlite3ReturningSubqueryVarSelect(Walker *NotUsed, Expr *pExpr);
int sqlite3WindowExtraAggFuncDepth(Walker *pWalker, Expr *pExpr);
int whereIsCoveringIndexWalkCallback(Walker *pWalk, Expr *pExpr);

// =============== xFetch ===============
// xFetch function pointer signatures (extern)
static int xFetch_signatures[7][4] = {0,};

// xFetch function enumeration
typedef enum {
    xFetch_0_enum = 0,
    xFetch_apndFetch_enum = 1,
    xFetch_memdbFetch_enum = 2,
    xFetch_pcache1Fetch_enum = 3,
    xFetch_pcachetraceFetch_enum = 4,
    xFetch_recoverVfsFetch_enum = 5,
    xFetch_unixFetch_enum = 6
} xFetch_enum;

// xFetch signature initialization function
void init_xFetch_signatures(void);
// xFetch function declarations
int apndFetch(sqlite3_file*, sqlite3_int64 iOfst, int iAmt, void **pp);
int memdbFetch(sqlite3_file*, sqlite3_int64 iOfst, int iAmt, void **pp);
sqlite3_pcache_page *pcache1Fetch(sqlite3_pcache *p , unsigned int iKey , int createFlag);
sqlite3_pcache_page *pcachetraceFetch( sqlite3_pcache *p, unsigned key, int crFg );
int recoverVfsFetch(sqlite3_file*, sqlite3_int64, int, void**);
int unixFetch(sqlite3_file *fd, i64 iOff, int nAmt, void **pp);

// =============== xFileControl ===============
// xFileControl function pointer signatures (extern)
static int xFileControl_signatures[6][4] = {0,};

// xFileControl function enumeration
typedef enum {
    xFileControl_0_enum = 0,
    xFileControl_apndFileControl_enum = 1,
    xFileControl_memdbFileControl_enum = 2,
    xFileControl_recoverVfsFileControl_enum = 3,
    xFileControl_vfstraceFileControl_enum = 4,
    xFileControl_unixFileControl_enum = 5
} xFileControl_enum;

// xFileControl signature initialization function
void init_xFileControl_signatures(void);
// xFileControl function declarations
int apndFileControl(sqlite3_file*, int op, void *pArg);
int memdbFileControl(sqlite3_file*, int op, void *pArg);
int multiplexFileControl(sqlite3_file *pConn, int op, void *pArg);
int quotaFileControl(sqlite3_file *pConn, int op, void *pArg);
int vfstraceFileControl(sqlite3_file*, int op, void *pArg);
int unixFileControl(sqlite3_file *id, int op, void *pArg);

// =============== xFileSize ===============
// xFileSize function pointer signatures (extern)
static int xFileSize_signatures[6][4] = {0,};

// xFileSize function enumeration
typedef enum {
    xFileSize_apndFileSize_enum = 0,
    xFileSize_memdbFileSize_enum = 1,
    xFileSize_memjrnlFileSize_enum = 2,
    xFileSize_recoverVfsFileSize_enum = 3,
    xFileSize_vfstraceFileSize_enum = 4,
    xFileSize_unixFileSize_enum = 5
} xFileSize_enum;

// xFileSize signature initialization function
void init_xFileSize_signatures(void);
// xFileSize function declarations
int apndFileSize(sqlite3_file*, sqlite3_int64 *pSize);
int memdbFileSize(sqlite3_file*, sqlite3_int64 *pSize);
int memjrnlFileSize(sqlite3_file *pJfd, sqlite_int64 *pSize);
int multiplexFileSize(sqlite3_file *pConn, sqlite3_int64 *pSize);
int quotaFileSize(sqlite3_file *pConn, sqlite3_int64 *pSize);
int vfstraceFileSize(sqlite3_file*, sqlite3_int64 *pSize);
int unixFileSize(sqlite3_file *id, i64 *pSize);

// =============== xFilter ===============
// xFilter function pointer signatures (extern)
static int xFilter_signatures[48][4] = {0,};

// xFilter function enumeration
typedef enum {
    xFilter_amatchFilter_enum = 0,
    xFilter_binfoFilter_enum = 1,
    xFilter_bytecodevtabFilter_enum = 2,
    xFilter_carrayFilter_enum = 3,
    xFilter_cidxFilter_enum = 4,
    xFilter_closureFilter_enum = 5,
    xFilter_completionFilter_enum = 6,
    xFilter_csvtabFilter_enum = 7,
    xFilter_dbdataFilter_enum = 8,
    xFilter_dbpageFilter_enum = 9,
    xFilter_deltaparsevtabFilter_enum = 10,
    xFilter_echoFilter_enum = 11,
    xFilter_expertFilter_enum = 12,
    xFilter_explainFilter_enum = 13,
    xFilter_fsFilter_enum = 14,
    xFilter_fsdirFilter_enum = 15,
    xFilter_fstreeFilter_enum = 16,
    xFilter_fts3FilterMethod_enum = 17,
    xFilter_fts3auxFilterMethod_enum = 18,
    xFilter_fts3termFilterMethod_enum = 19,
    xFilter_fts3tokFilterMethod_enum = 20,
    xFilter_fts5FilterMethod_enum = 21,
    xFilter_fts5VocabFilterMethod_enum = 22,
    xFilter_fts5structFilterMethod_enum = 23,
    xFilter_fts5tokFilterMethod_enum = 24,
    xFilter_fuzzerFilter_enum = 25,
    xFilter_geopolyFilter_enum = 26,
    xFilter_intarrayFilter_enum = 27,
    xFilter_jsonEachFilter_enum = 28,
    xFilter_memstatFilter_enum = 29,
    xFilter_pragmaVtabFilter_enum = 30,
    xFilter_prefixesFilter_enum = 31,
    xFilter_qpvtabFilter_enum = 32,
    xFilter_rtreeFilter_enum = 33,
    xFilter_schemaFilter_enum = 34,
    xFilter_seriesFilter_enum = 35,
    xFilter_spellfix1Filter_enum = 36,
    xFilter_statFilter_enum = 37,
    xFilter_stmtFilter_enum = 38,
    xFilter_tclFilter_enum = 39,
    xFilter_tclvarFilter_enum = 40,
    xFilter_templatevtabFilter_enum = 41,
    xFilter_unionFilter_enum = 42,
    xFilter_vlogFilter_enum = 43,
    xFilter_vstattabFilter_enum = 44,
    xFilter_vtablogFilter_enum = 45,
    xFilter_wholenumberFilter_enum = 46,
    xFilter_zipfileFilter_enum = 47
} xFilter_enum;

// xFilter signature initialization function
void init_xFilter_signatures(void);
// xFilter function declarations
int amatchFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int binfoFilter( sqlite3_vtab_cursor *pCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int bytecodevtabFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int carrayFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int cidxFilter( sqlite3_vtab_cursor *pCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int closureFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int completionFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int csvtabFilter(sqlite3_vtab_cursor*, int idxNum, const char *idxStr, int argc, sqlite3_value **argv);
int dbdataFilter( sqlite3_vtab_cursor *pCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int dbpageFilter( sqlite3_vtab_cursor *pCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int deltaparsevtabFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int echoFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int expertFilter( sqlite3_vtab_cursor *cur, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int explainFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int fsFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int fsdirFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int fstreeFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int fts3FilterMethod( sqlite3_vtab_cursor *pCursor, int idxNum, const char *idxStr, int nVal, sqlite3_value **apVal );
int fts3auxFilterMethod( sqlite3_vtab_cursor *pCursor, int idxNum, const char *idxStr, int nVal, sqlite3_value **apVal );
int fts3termFilterMethod( sqlite3_vtab_cursor *pCursor, int idxNum, const char *idxStr, int nVal, sqlite3_value **apVal );
int fts3tokFilterMethod( sqlite3_vtab_cursor *pCursor, int idxNum, const char *idxStr, int nVal, sqlite3_value **apVal );
int fts5FilterMethod( sqlite3_vtab_cursor *pCursor, int idxNum, const char *idxStr, int nVal, sqlite3_value **apVal );
int fts5VocabFilterMethod( sqlite3_vtab_cursor *pCursor, int idxNum, const char *zUnused, int nUnused, sqlite3_value **apVal );
int fts5structFilterMethod( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int fts5tokFilterMethod( sqlite3_vtab_cursor *pCursor, int idxNum, const char *idxStr, int nVal, sqlite3_value **apVal );
int fuzzerFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int geopolyFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int intarrayFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int jsonEachFilter( sqlite3_vtab_cursor *cur, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int memstatFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int pragmaVtabFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int prefixesFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int qpvtabFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int rtreeFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int schemaFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int seriesFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStrUnused, int argc, sqlite3_value **argv );
int spellfix1Filter( sqlite3_vtab_cursor *cur, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int statFilter( sqlite3_vtab_cursor *pCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int stmtFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int tclFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int tclvarFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int templatevtabFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int unionFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int vlogFilter( sqlite3_vtab_cursor *pCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int vstattabFilter(sqlite3_vtab_cursor*, int idxNum, const char *idxStr, int argc, sqlite3_value **argv);
int vtablogFilter( sqlite3_vtab_cursor *cur, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int wholenumberFilter( sqlite3_vtab_cursor *pVtabCursor, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );
int zipfileFilter( sqlite3_vtab_cursor *cur, int idxNum, const char *idxStr, int argc, sqlite3_value **argv );

// =============== xFindFunction ===============
// xFindFunction function pointer signatures (extern)
static int xFindFunction_signatures[4][4] = {0,};

// xFindFunction function enumeration
typedef enum {
    xFindFunction_0_enum = 0,
    xFindFunction_fts3FindFunctionMethod_enum = 1,
    xFindFunction_fts5FindFunctionMethod_enum = 2,
    xFindFunction_zipfileFindFunction_enum = 3
} xFindFunction_enum;

// xFindFunction signature initialization function
void init_xFindFunction_signatures(void);
// xFindFunction function declarations
int fts3FindFunctionMethod( sqlite3_vtab *pVtab, int nArg, const char *zName, void (**pxFunc)(sqlite3_context*,int,sqlite3_value**), void **ppArg );
int fts5FindFunctionMethod( sqlite3_vtab *pVtab, int nUnused, const char *zName, void (**pxFunc)(sqlite3_context*,int,sqlite3_value**), void **ppArg );
int zipfileFindFunction( sqlite3_vtab *pVtab, int nArg, const char *zName, void (**pxFunc)(sqlite3_context*,int,sqlite3_value**), void **ppArg );

// =============== xFindTokenizer ===============
// xFindTokenizer function pointer signatures (extern)
static int xFindTokenizer_signatures[1][4] = {0,};

// xFindTokenizer function enumeration
typedef enum {
    xFindTokenizer_fts5FindTokenizer_enum = 0
} xFindTokenizer_enum;

// xFindTokenizer signature initialization function
void init_xFindTokenizer_signatures(void);
// xFindTokenizer function declarations
int fts5FindTokenizer( fts5_api *pApi, const char *zName, void **ppUserData, fts5_tokenizer *pTokenizer );

// =============== xFindTokenizer_v2 ===============
// xFindTokenizer_v2 function pointer signatures (extern)
static int xFindTokenizer_v2_signatures[1][4] = {0,};

// xFindTokenizer_v2 function enumeration
typedef enum {
    xFindTokenizer_v2_fts5FindTokenizer_v2_enum = 0
} xFindTokenizer_v2_enum;

// xFindTokenizer_v2 signature initialization function
void init_xFindTokenizer_v2_signatures(void);
// xFindTokenizer_v2 function declarations
int fts5FindTokenizer_v2( fts5_api *pApi, const char *zName, void **ppUserData, fts5_tokenizer_v2 **ppTokenizer );

// =============== xFree ===============
// xFree function pointer signatures (extern)
static int xFree_signatures[2][4] = {0,};

// xFree function enumeration
typedef enum {
    xFree_memtraceFree_enum = 0,
    xFree_sqlite3MemFree_enum = 1
} xFree_enum;

// xFree signature initialization function
void init_xFree_signatures(void);
// xFree function declarations
void memtraceFree(void *p);
void sqlite3MemFree(void *pPrior);
void xFree(void *p);

// =============== xFullPathname ===============
// xFullPathname function pointer signatures (extern)
static int xFullPathname_signatures[4][4] = {0,};

// xFullPathname function enumeration
typedef enum {
    xFullPathname_apndFullPathname_enum = 0,
    xFullPathname_memdbFullPathname_enum = 1,
    xFullPathname_vfstraceFullPathname_enum = 2,
    xFullPathname_unixFullPathname_enum = 3
} xFullPathname_enum;

// xFullPathname signature initialization function
void init_xFullPathname_signatures(void);
// xFullPathname function declarations
int apndFullPathname(sqlite3_vfs*, const char *zName, int, char *zOut);
int memdbFullPathname(sqlite3_vfs*, const char *zName, int, char *zOut);
int multiplexFullPathname(sqlite3_vfs *a, const char *b, int c, char *d);
int vfstraceFullPathname(sqlite3_vfs*, const char *zName, int, char *);
int unixFullPathname(sqlite3_vfs *pVfs, const char *zPath, int nOut, char *zOut );

// =============== xGet ===============
// xGet function pointer signatures (extern)
static int xGet_signatures[3][4] = {0,};

// xGet function enumeration
typedef enum {
    xGet_getPageError_enum = 0,
    xGet_getPageMMap_enum = 1,
    xGet_getPageNormal_enum = 2
} xGet_enum;

// xGet signature initialization function
void init_xGet_signatures(void);
// xGet function declarations
int getPageError(Pager*,Pgno,DbPage**,int);
int getPageMMap(Pager*,Pgno,DbPage**,int);
int getPageNormal( Pager *pPager, Pgno pgno, DbPage **ppPage, int flags );

// =============== xGetAuxdata ===============
// xGetAuxdata function pointer signatures (extern)
static int xGetAuxdata_signatures[1][4] = {0,};

// xGetAuxdata function enumeration
typedef enum {
    xGetAuxdata_fts5ApiGetAuxdata_enum = 0
} xGetAuxdata_enum;

// xGetAuxdata signature initialization function
void init_xGetAuxdata_signatures(void);
// xGetAuxdata function declarations
void *fts5ApiGetAuxdata(Fts5Context *pCtx, int bClear);

// =============== xGetLastError ===============
// xGetLastError function pointer signatures (extern)
static int xGetLastError_signatures[4][4] = {0,};

// xGetLastError function enumeration
typedef enum {
    xGetLastError_0_enum = 0,
    xGetLastError_apndGetLastError_enum = 1,
    xGetLastError_memdbGetLastError_enum = 2,
    xGetLastError_unixGetLastError_enum = 3
} xGetLastError_enum;

// xGetLastError signature initialization function
void init_xGetLastError_signatures(void);
// xGetLastError function declarations
int apndGetLastError(sqlite3_vfs*, int, char *);
int memdbGetLastError(sqlite3_vfs*, int, char *);
int multiplexGetLastError(sqlite3_vfs *a, int b, char *c);
int unixGetLastError(sqlite3_vfs *NotUsed, int NotUsed2, char *NotUsed3);

// =============== xGetSystemCall ===============
// xGetSystemCall function pointer signatures (extern)
static int xGetSystemCall_signatures[3][4] = {0,};

// xGetSystemCall function enumeration
typedef enum {
    xGetSystemCall_0_enum = 0,
    xGetSystemCall_apndGetSystemCall_enum = 1,
    xGetSystemCall_unixGetSystemCall_enum = 2
} xGetSystemCall_enum;

// xGetSystemCall signature initialization function
void init_xGetSystemCall_signatures(void);
// xGetSystemCall function declarations
sqlite3_syscall_ptr apndGetSystemCall(sqlite3_vfs*, const char *z);
sqlite3_syscall_ptr unixGetSystemCall(sqlite3_vfs *pNotUsed, const char *zName);

// =============== xInit ===============
// xInit function pointer signatures (extern)
static int xInit_signatures[4][4] = {0,};

// xInit function enumeration
typedef enum {
    xInit_memtraceInit_enum = 0,
    xInit_pcache1Init_enum = 1,
    xInit_pcachetraceInit_enum = 2,
    xInit_sqlite3MemInit_enum = 3
} xInit_enum;

// xInit signature initialization function
void init_xInit_signatures(void);
// xInit function declarations
int memtraceInit(void *p);
int pcache1Init(void *NotUsed);
int pcachetraceInit(void *pArg);
int sqlite3MemInit(void *NotUsed);

// =============== xInst ===============
// xInst function pointer signatures (extern)
static int xInst_signatures[1][4] = {0,};

// xInst function enumeration
typedef enum {
    xInst_fts5ApiInst_enum = 0
} xInst_enum;

// xInst signature initialization function
void init_xInst_signatures(void);
// xInst function declarations
int fts5ApiInst( Fts5Context *pCtx, int iIdx, int *piPhrase, int *piCol, int *piOff );

// =============== xInstCount ===============
// xInstCount function pointer signatures (extern)
static int xInstCount_signatures[1][4] = {0,};

// xInstCount function enumeration
typedef enum {
    xInstCount_fts5ApiInstCount_enum = 0
} xInstCount_enum;

// xInstCount signature initialization function
void init_xInstCount_signatures(void);
// xInstCount function declarations
int fts5ApiInstCount(Fts5Context *pCtx, int *pnInst);

// =============== xInstToken ===============
// xInstToken function pointer signatures (extern)
static int xInstToken_signatures[1][4] = {0,};

// xInstToken function enumeration
typedef enum {
    xInstToken_fts5ApiInstToken_enum = 0
} xInstToken_enum;

// xInstToken signature initialization function
void init_xInstToken_signatures(void);
// xInstToken function declarations
int fts5ApiInstToken( Fts5Context *pCtx, int iIdx, int iToken, const char **ppOut, int *pnOut );

// =============== xIntegrity ===============
// xIntegrity function pointer signatures (extern)
static int xIntegrity_signatures[5][4] = {0,};

// xIntegrity function enumeration
typedef enum {
    xIntegrity_0_enum = 0,
    xIntegrity_fts3IntegrityMethod_enum = 1,
    xIntegrity_fts5IntegrityMethod_enum = 2,
    xIntegrity_rtreeIntegrity_enum = 3,
    xIntegrity_vtablogIntegrity_enum = 4
} xIntegrity_enum;

// xIntegrity signature initialization function
void init_xIntegrity_signatures(void);
// xIntegrity function declarations
int fts3IntegrityMethod( sqlite3_vtab *pVtab, const char *zSchema, const char *zTabname, int isQuick, char **pzErr );
int fts5IntegrityMethod( sqlite3_vtab *pVtab, const char *zSchema, const char *zTabname, int isQuick, char **pzErr );
int rtreeIntegrity(sqlite3_vtab*, const char*, const char*, int, char**);
int vtablogIntegrity( sqlite3_vtab *tab, const char *zSchema, const char *zTabName, int mFlags, char **pzErr );

// =============== xLock ===============
// xLock function pointer signatures (extern)
static int xLock_signatures[8][4] = {0,};

// xLock function enumeration
typedef enum {
    xLock_0_enum = 0,
    xLock_apndLock_enum = 1,
    xLock_memdbLock_enum = 2,
    xLock_recoverVfsLock_enum = 3,
    xLock_vfstraceLock_enum = 4,
    xLock_unixLock_enum = 5,
    xLock_nolockLock_enum = 6,
    xLock_dotlockLock_enum = 7
} xLock_enum;

// xLock signature initialization function
void init_xLock_signatures(void);
// xLock function declarations
int apndLock(sqlite3_file*, int);
int memdbLock(sqlite3_file*, int);
int multiplexLock(sqlite3_file *pConn, int lock);
int quotaLock(sqlite3_file *pConn, int lock);
int vfstraceLock(sqlite3_file*, int);
int unixLock(sqlite3_file *id, int eFileLock);
int nolockLock(sqlite3_file *NotUsed, int NotUsed2);
int dotlockLock(sqlite3_file *id, int eFileLock);

// =============== xMalloc ===============
// xMalloc function pointer signatures (extern)
static int xMalloc_signatures[2][4] = {0,};

// xMalloc function enumeration
typedef enum {
    xMalloc_memtraceMalloc_enum = 0,
    xMalloc_sqlite3MemMalloc_enum = 1
} xMalloc_enum;

// xMalloc signature initialization function
void init_xMalloc_signatures(void);
// xMalloc function declarations
void *memtraceMalloc(int n);
void *sqlite3MemMalloc(int nByte);

// =============== xMerge ===============
// xMerge function pointer signatures (extern)
static int xMerge_signatures[2][4] = {0,};

// xMerge function enumeration
typedef enum {
    xMerge_fts5MergePrefixLists_enum = 0,
    xMerge_fts5MergeRowidLists_enum = 1
} xMerge_enum;

// xMerge signature initialization function
void init_xMerge_signatures(void);
// xMerge function declarations
void fts5MergePrefixLists( Fts5Index *p, Fts5Buffer *p1, int nBuf, Fts5Buffer *aBuf );
void fts5MergeRowidLists( Fts5Index *p, Fts5Buffer *p1, int nBuf, Fts5Buffer *aBuf );

// =============== xMutexAlloc ===============
// xMutexAlloc function pointer signatures (extern)
static int xMutexAlloc_signatures[7][4] = {0,};

// xMutexAlloc function enumeration
typedef enum {
    xMutexAlloc_checkMutexAlloc_enum = 0,
    xMutexAlloc_counterMutexAlloc_enum = 1,
    xMutexAlloc_debugMutexAlloc_enum = 2,
    xMutexAlloc_noopMutexAlloc_enum = 3,
    xMutexAlloc_pthreadMutexAlloc_enum = 4,
    xMutexAlloc_winMutexAlloc_enum = 5,
    xMutexAlloc_wrMutexAlloc_enum = 6
} xMutexAlloc_enum;

// xMutexAlloc signature initialization function
void init_xMutexAlloc_signatures(void);
// xMutexAlloc function declarations
sqlite3_mutex *checkMutexAlloc(int iType);
sqlite3_mutex *counterMutexAlloc(int eType);
sqlite3_mutex *debugMutexAlloc(int id);
sqlite3_mutex *noopMutexAlloc(int id);
sqlite3_mutex *pthreadMutexAlloc(int iType);
sqlite3_mutex *winMutexAlloc(int iType);
sqlite3_mutex *wrMutexAlloc(int e);

// =============== xMutexEnd ===============
// xMutexEnd function pointer signatures (extern)
static int xMutexEnd_signatures[7][4] = {0,};

// xMutexEnd function enumeration
typedef enum {
    xMutexEnd_checkMutexEnd_enum = 0,
    xMutexEnd_counterMutexEnd_enum = 1,
    xMutexEnd_debugMutexEnd_enum = 2,
    xMutexEnd_noopMutexEnd_enum = 3,
    xMutexEnd_pthreadMutexEnd_enum = 4,
    xMutexEnd_winMutexEnd_enum = 5,
    xMutexEnd_wrMutexEnd_enum = 6
} xMutexEnd_enum;

// xMutexEnd signature initialization function
void init_xMutexEnd_signatures(void);
// xMutexEnd function declarations
int checkMutexEnd(void);
int counterMutexEnd(void);
int debugMutexEnd(void);
int noopMutexEnd(void);
int pthreadMutexEnd(void);
int winMutexEnd(void);
int wrMutexEnd(void);

// =============== xMutexEnter ===============
// xMutexEnter function pointer signatures (extern)
static int xMutexEnter_signatures[7][4] = {0,};

// xMutexEnter function enumeration
typedef enum {
    xMutexEnter_checkMutexEnter_enum = 0,
    xMutexEnter_counterMutexEnter_enum = 1,
    xMutexEnter_debugMutexEnter_enum = 2,
    xMutexEnter_noopMutexEnter_enum = 3,
    xMutexEnter_pthreadMutexEnter_enum = 4,
    xMutexEnter_winMutexEnter_enum = 5,
    xMutexEnter_wrMutexEnter_enum = 6
} xMutexEnter_enum;

// xMutexEnter signature initialization function
void init_xMutexEnter_signatures(void);
// xMutexEnter function declarations
void checkMutexEnter(sqlite3_mutex *p);
void counterMutexEnter(sqlite3_mutex *p);
void debugMutexEnter(sqlite3_mutex *pX);
void noopMutexEnter(sqlite3_mutex *p);
void pthreadMutexEnter(sqlite3_mutex *p);
void winMutexEnter(sqlite3_mutex *p);
void wrMutexEnter(sqlite3_mutex *p);

// =============== xMutexFree ===============
// xMutexFree function pointer signatures (extern)
static int xMutexFree_signatures[7][4] = {0,};

// xMutexFree function enumeration
typedef enum {
    xMutexFree_checkMutexFree_enum = 0,
    xMutexFree_counterMutexFree_enum = 1,
    xMutexFree_debugMutexFree_enum = 2,
    xMutexFree_noopMutexFree_enum = 3,
    xMutexFree_pthreadMutexFree_enum = 4,
    xMutexFree_winMutexFree_enum = 5,
    xMutexFree_wrMutexFree_enum = 6
} xMutexFree_enum;

// xMutexFree signature initialization function
void init_xMutexFree_signatures(void);
// xMutexFree function declarations
void checkMutexFree(sqlite3_mutex *p);
void counterMutexFree(sqlite3_mutex *p);
void debugMutexFree(sqlite3_mutex *pX);
void noopMutexFree(sqlite3_mutex *p);
void pthreadMutexFree(sqlite3_mutex *p);
void winMutexFree(sqlite3_mutex *p);
void wrMutexFree(sqlite3_mutex *p);

// =============== xMutexHeld ===============
// xMutexHeld function pointer signatures (extern)
static int xMutexHeld_signatures[4][4] = {0,};

// xMutexHeld function enumeration
typedef enum {
    xMutexHeld_0_enum = 0,
    xMutexHeld_counterMutexHeld_enum = 1,
    xMutexHeld_debugMutexHeld_enum = 2,
    xMutexHeld_wrMutexHeld_enum = 3
} xMutexHeld_enum;

// xMutexHeld signature initialization function
void init_xMutexHeld_signatures(void);
// xMutexHeld function declarations
int counterMutexHeld(sqlite3_mutex *p);
int debugMutexHeld(sqlite3_mutex *pX);
int wrMutexHeld(sqlite3_mutex *p);

// =============== xMutexInit ===============
// xMutexInit function pointer signatures (extern)
static int xMutexInit_signatures[7][4] = {0,};

// xMutexInit function enumeration
typedef enum {
    xMutexInit_checkMutexInit_enum = 0,
    xMutexInit_counterMutexInit_enum = 1,
    xMutexInit_debugMutexInit_enum = 2,
    xMutexInit_noopMutexInit_enum = 3,
    xMutexInit_pthreadMutexInit_enum = 4,
    xMutexInit_winMutexInit_enum = 5,
    xMutexInit_wrMutexInit_enum = 6
} xMutexInit_enum;

// xMutexInit signature initialization function
void init_xMutexInit_signatures(void);
// xMutexInit function declarations
int checkMutexInit(void);
int counterMutexInit(void);
int debugMutexInit(void);
int noopMutexInit(void);
int pthreadMutexInit(void);
int winMutexInit(void);
int wrMutexInit(void);

// =============== xMutexLeave ===============
// xMutexLeave function pointer signatures (extern)
static int xMutexLeave_signatures[7][4] = {0,};

// xMutexLeave function enumeration
typedef enum {
    xMutexLeave_checkMutexLeave_enum = 0,
    xMutexLeave_counterMutexLeave_enum = 1,
    xMutexLeave_debugMutexLeave_enum = 2,
    xMutexLeave_noopMutexLeave_enum = 3,
    xMutexLeave_pthreadMutexLeave_enum = 4,
    xMutexLeave_winMutexLeave_enum = 5,
    xMutexLeave_wrMutexLeave_enum = 6
} xMutexLeave_enum;

// xMutexLeave signature initialization function
void init_xMutexLeave_signatures(void);
// xMutexLeave function declarations
void checkMutexLeave(sqlite3_mutex *p);
void counterMutexLeave(sqlite3_mutex *p);
void debugMutexLeave(sqlite3_mutex *pX);
void noopMutexLeave(sqlite3_mutex *p);
void pthreadMutexLeave(sqlite3_mutex *p);
void winMutexLeave(sqlite3_mutex *p);
void wrMutexLeave(sqlite3_mutex *p);

// =============== xMutexNotheld ===============
// xMutexNotheld function pointer signatures (extern)
static int xMutexNotheld_signatures[4][4] = {0,};

// xMutexNotheld function enumeration
typedef enum {
    xMutexNotheld_0_enum = 0,
    xMutexNotheld_counterMutexNotheld_enum = 1,
    xMutexNotheld_debugMutexNotheld_enum = 2,
    xMutexNotheld_wrMutexNotheld_enum = 3
} xMutexNotheld_enum;

// xMutexNotheld signature initialization function
void init_xMutexNotheld_signatures(void);
// xMutexNotheld function declarations
int counterMutexNotheld(sqlite3_mutex *p);
int debugMutexNotheld(sqlite3_mutex *pX);
int wrMutexNotheld(sqlite3_mutex *p);

// =============== xMutexTry ===============
// xMutexTry function pointer signatures (extern)
static int xMutexTry_signatures[7][4] = {0,};

// xMutexTry function enumeration
typedef enum {
    xMutexTry_checkMutexTry_enum = 0,
    xMutexTry_counterMutexTry_enum = 1,
    xMutexTry_debugMutexTry_enum = 2,
    xMutexTry_noopMutexTry_enum = 3,
    xMutexTry_pthreadMutexTry_enum = 4,
    xMutexTry_winMutexTry_enum = 5,
    xMutexTry_wrMutexTry_enum = 6
} xMutexTry_enum;

// xMutexTry signature initialization function
void init_xMutexTry_signatures(void);
// xMutexTry function declarations
int checkMutexTry(sqlite3_mutex *p);
int counterMutexTry(sqlite3_mutex *p);
int debugMutexTry(sqlite3_mutex *pX);
int noopMutexTry(sqlite3_mutex *p);
int pthreadMutexTry(sqlite3_mutex *p);
int winMutexTry(sqlite3_mutex *p);
int wrMutexTry(sqlite3_mutex *p);

// =============== xNew ===============
// xNew function pointer signatures (extern)
static int xNew_signatures[3][4] = {0,};

// xNew function enumeration
typedef enum {
    xNew_sessionDiffNew_enum = 0,
    xNew_sessionPreupdateNew_enum = 1,
    xNew_sessionStat1New_enum = 2
} xNew_enum;

// xNew signature initialization function
void init_xNew_signatures(void);
// xNew function declarations
int sessionDiffNew(void *pCtx, int iVal, sqlite3_value **ppVal);
int sessionPreupdateNew(void *pCtx, int iVal, sqlite3_value **ppVal);
int sessionStat1New(void *pCtx, int iCol, sqlite3_value **ppVal);

// =============== xNext ===============
// xNext function pointer signatures (extern)
static int xNext_signatures[59][4] = {0,};

// xNext function enumeration
typedef enum {
    xNext_0_enum = 0,
    xNext_amatchNext_enum = 1,
    xNext_binfoNext_enum = 2,
    xNext_bytecodevtabNext_enum = 3,
    xNext_carrayNext_enum = 4,
    xNext_cidxNext_enum = 5,
    xNext_closureNext_enum = 6,
    xNext_completionNext_enum = 7,
    xNext_csvtabNext_enum = 8,
    xNext_dbdataNext_enum = 9,
    xNext_dbpageNext_enum = 10,
    xNext_deltaparsevtabNext_enum = 11,
    xNext_echoNext_enum = 12,
    xNext_expertNext_enum = 13,
    xNext_explainNext_enum = 14,
    xNext_fsNext_enum = 15,
    xNext_fsdirNext_enum = 16,
    xNext_fstreeNext_enum = 17,
    xNext_fts3NextMethod_enum = 18,
    xNext_fts3auxNextMethod_enum = 19,
    xNext_fts3termNextMethod_enum = 20,
    xNext_fts3tokNextMethod_enum = 21,
    xNext_fts5ExprNodeNext_AND_enum = 22,
    xNext_fts5ExprNodeNext_NOT_enum = 23,
    xNext_fts5ExprNodeNext_OR_enum = 24,
    xNext_fts5ExprNodeNext_STRING_enum = 25,
    xNext_fts5ExprNodeNext_TERM_enum = 26,
    xNext_fts5NextMethod_enum = 27,
    xNext_fts5SegIterNext_enum = 28,
    xNext_fts5SegIterNext_None_enum = 29,
    xNext_fts5SegIterNext_Reverse_enum = 30,
    xNext_fts5VocabNextMethod_enum = 31,
    xNext_fts5structNextMethod_enum = 32,
    xNext_fts5tokNextMethod_enum = 33,
    xNext_fuzzerNext_enum = 34,
    xNext_intarrayNext_enum = 35,
    xNext_jsonEachNext_enum = 36,
    xNext_memstatNext_enum = 37,
    xNext_porterNext_enum = 38,
    xNext_pragmaVtabNext_enum = 39,
    xNext_prefixesNext_enum = 40,
    xNext_qpvtabNext_enum = 41,
    xNext_rtreeNext_enum = 42,
    xNext_schemaNext_enum = 43,
    xNext_seriesNext_enum = 44,
    xNext_simpleNext_enum = 45,
    xNext_spellfix1Next_enum = 46,
    xNext_statNext_enum = 47,
    xNext_stmtNext_enum = 48,
    xNext_tclNext_enum = 49,
    xNext_tclvarNext_enum = 50,
    xNext_templatevtabNext_enum = 51,
    xNext_unicodeNext_enum = 52,
    xNext_unionNext_enum = 53,
    xNext_vlogNext_enum = 54,
    xNext_vstattabNext_enum = 55,
    xNext_vtablogNext_enum = 56,
    xNext_wholenumberNext_enum = 57,
    xNext_zipfileNext_enum = 58
} xNext_enum;

// xNext signature initialization function
void init_xNext_signatures(void);
// xNext function declarations
int amatchNext(sqlite3_vtab_cursor *cur);
int binfoNext(sqlite3_vtab_cursor *pCursor);
int bytecodevtabNext(sqlite3_vtab_cursor *cur);
int carrayNext(sqlite3_vtab_cursor *cur);
int cidxNext(sqlite3_vtab_cursor *pCursor);
int closureNext(sqlite3_vtab_cursor *cur);
int completionNext(sqlite3_vtab_cursor *cur);
int csvtabNext(sqlite3_vtab_cursor*);
int dbdataNext(sqlite3_vtab_cursor *pCursor);
int dbpageNext(sqlite3_vtab_cursor *pCursor);
int deltaparsevtabNext(sqlite3_vtab_cursor *cur);
int echoNext(sqlite3_vtab_cursor *cur);
int expertNext(sqlite3_vtab_cursor *cur);
int explainNext(sqlite3_vtab_cursor *cur);
int fsNext(sqlite3_vtab_cursor *cur);
int fsdirNext(sqlite3_vtab_cursor *cur);
int fstreeNext(sqlite3_vtab_cursor *cur);
int fts3NextMethod(sqlite3_vtab_cursor *pCursor);
int fts3auxNextMethod(sqlite3_vtab_cursor *pCursor);
int fts3termNextMethod(sqlite3_vtab_cursor *pCursor);
int fts3tokNextMethod(sqlite3_vtab_cursor *pCursor);
int fts5ExprNodeNext_AND( Fts5Expr *pExpr, Fts5ExprNode *pNode, int bFromValid, i64 iFrom );
int fts5ExprNodeNext_NOT( Fts5Expr *pExpr, Fts5ExprNode *pNode, int bFromValid, i64 iFrom );
int fts5ExprNodeNext_OR( Fts5Expr *pExpr, Fts5ExprNode *pNode, int bFromValid, i64 iFrom );
int fts5ExprNodeNext_STRING( Fts5Expr *pExpr, Fts5ExprNode *pNode, int bFromValid, i64 iFrom );
int fts5ExprNodeNext_TERM( Fts5Expr *pExpr, Fts5ExprNode *pNode, int bFromValid, i64 iFrom );
int fts5NextMethod(sqlite3_vtab_cursor *pCursor);
void fts5SegIterNext(Fts5Index*, Fts5SegIter*, int*);
void fts5SegIterNext_None(Fts5Index*, Fts5SegIter*, int*);
void fts5SegIterNext_Reverse(Fts5Index*, Fts5SegIter*, int*);
int fts5VocabNextMethod(sqlite3_vtab_cursor *pCursor);
int fts5structNextMethod(sqlite3_vtab_cursor *cur);
int fts5tokNextMethod(sqlite3_vtab_cursor *pCursor);
int fuzzerNext(sqlite3_vtab_cursor *cur);
int intarrayNext(sqlite3_vtab_cursor *cur);
int jsonEachNext(sqlite3_vtab_cursor *cur);
int memstatNext(sqlite3_vtab_cursor *cur);
int porterNext( sqlite3_tokenizer_cursor *pCursor, const char **pzToken, int *pnBytes, int *piStartOffset, int *piEndOffset, int *piPosition );
int pragmaVtabNext(sqlite3_vtab_cursor *pVtabCursor);
int prefixesNext(sqlite3_vtab_cursor *cur);
int qpvtabNext(sqlite3_vtab_cursor *cur);
int rtreeNext(sqlite3_vtab_cursor *pVtabCursor);
int schemaNext(sqlite3_vtab_cursor *cur);
int seriesNext(sqlite3_vtab_cursor *cur);
int simpleNext( sqlite3_tokenizer_cursor *pCursor, const char **ppToken, int *pnBytes, int *piStartOffset, int *piEndOffset, int *piPosition );
int spellfix1Next(sqlite3_vtab_cursor *cur);
int statNext(sqlite3_vtab_cursor *pCursor);
int stmtNext(sqlite3_vtab_cursor *cur);
int tclNext(sqlite3_vtab_cursor *pVtabCursor);
int tclvarNext(sqlite3_vtab_cursor *cur);
int templatevtabNext(sqlite3_vtab_cursor *cur);
int unicodeNext( sqlite3_tokenizer_cursor *pC, const char **paToken, int *pnToken, int *piStart, int *piEnd, int *piPos );
int unionNext(sqlite3_vtab_cursor *cur);
int vlogNext(sqlite3_vtab_cursor *pCursor);
int vstattabNext(sqlite3_vtab_cursor*);
int vtablogNext(sqlite3_vtab_cursor *cur);
int wholenumberNext(sqlite3_vtab_cursor *cur);
int zipfileNext(sqlite3_vtab_cursor *cur);

// =============== xNextChar ===============
// xNextChar function pointer signatures (extern)
static int xNextChar_signatures[2][4] = {0,};

// xNextChar function enumeration
typedef enum {
    xNextChar_re_next_char_nocase_enum = 0,
    xNextChar_re_next_char_enum = 1
} xNextChar_enum;

// xNextChar signature initialization function
void init_xNextChar_signatures(void);
// xNextChar function declarations
unsigned re_next_char_nocase(ReInput *p);
unsigned re_next_char(ReInput *p);

// =============== xNextSystemCall ===============
// xNextSystemCall function pointer signatures (extern)
static int xNextSystemCall_signatures[4][4] = {0,};

// xNextSystemCall function enumeration
typedef enum {
    xNextSystemCall_0_enum = 0,
    xNextSystemCall_apndNextSystemCall_enum = 1,
    xNextSystemCall_rbuVfsGetLastError_enum = 2,
    xNextSystemCall_unixNextSystemCall_enum = 3
} xNextSystemCall_enum;

// xNextSystemCall signature initialization function
void init_xNextSystemCall_signatures(void);
// xNextSystemCall function declarations
const char *apndNextSystemCall(sqlite3_vfs*, const char *zName);
int rbuVfsGetLastError(sqlite3_vfs *pVfs, int a, char *b);
const char *unixNextSystemCall(sqlite3_vfs *p, const char *zName);

// =============== xOld ===============
// xOld function pointer signatures (extern)
static int xOld_signatures[3][4] = {0,};

// xOld function enumeration
typedef enum {
    xOld_sessionDiffOld_enum = 0,
    xOld_sessionPreupdateOld_enum = 1,
    xOld_sessionStat1Old_enum = 2
} xOld_enum;

// xOld signature initialization function
void init_xOld_signatures(void);
// xOld function declarations
int sessionDiffOld(void *pCtx, int iVal, sqlite3_value **ppVal);
int sessionPreupdateOld(void *pCtx, int iVal, sqlite3_value **ppVal);
int sessionStat1Old(void *pCtx, int iCol, sqlite3_value **ppVal);

// =============== xOpen ===============
// xOpen function pointer signatures (extern)
static int xOpen_signatures[55][4] = {0,};

// xOpen function enumeration
typedef enum {
    xOpen_amatchOpen_enum = 0,
    xOpen_apndOpen_enum = 1,
    xOpen_binfoOpen_enum = 2,
    xOpen_bytecodevtabOpen_enum = 3,
    xOpen_carrayOpen_enum = 4,
    xOpen_cidxOpen_enum = 5,
    xOpen_closureOpen_enum = 6,
    xOpen_completionOpen_enum = 7,
    xOpen_csvtabOpen_enum = 8,
    xOpen_dbdataOpen_enum = 9,
    xOpen_dbpageOpen_enum = 10,
    xOpen_deltaparsevtabOpen_enum = 11,
    xOpen_echoOpen_enum = 12,
    xOpen_expertOpen_enum = 13,
    xOpen_explainOpen_enum = 14,
    xOpen_fsOpen_enum = 15,
    xOpen_fsdirOpen_enum = 16,
    xOpen_fstreeOpen_enum = 17,
    xOpen_fts3OpenMethod_enum = 18,
    xOpen_fts3auxOpenMethod_enum = 19,
    xOpen_fts3termOpenMethod_enum = 20,
    xOpen_fts3tokOpenMethod_enum = 21,
    xOpen_fts5OpenMethod_enum = 22,
    xOpen_fts5VocabOpenMethod_enum = 23,
    xOpen_fts5structOpenMethod_enum = 24,
    xOpen_fts5tokOpenMethod_enum = 25,
    xOpen_fuzzerOpen_enum = 26,
    xOpen_intarrayOpen_enum = 27,
    xOpen_jsonEachOpen_enum = 28,
    xOpen_jsonEachOpenEach_enum = 29,
    xOpen_jsonEachOpenTree_enum = 30,
    xOpen_memdbOpen_enum = 31,
    xOpen_memstatOpen_enum = 32,
    xOpen_porterOpen_enum = 33,
    xOpen_pragmaVtabOpen_enum = 34,
    xOpen_prefixesOpen_enum = 35,
    xOpen_qpvtabOpen_enum = 36,
    xOpen_rtreeOpen_enum = 37,
    xOpen_schemaOpen_enum = 38,
    xOpen_seriesOpen_enum = 39,
    xOpen_simpleOpen_enum = 40,
    xOpen_spellfix1Open_enum = 41,
    xOpen_statOpen_enum = 42,
    xOpen_stmtOpen_enum = 43,
    xOpen_tclOpen_enum = 44,
    xOpen_tclvarOpen_enum = 45,
    xOpen_templatevtabOpen_enum = 46,
    xOpen_unicodeOpen_enum = 47,
    xOpen_unionOpen_enum = 48,
    xOpen_vfstraceOpen_enum = 49,
    xOpen_vstattabOpen_enum = 50,
    xOpen_vtablogOpen_enum = 51,
    xOpen_wholenumberOpen_enum = 52,
    xOpen_zipfileOpen_enum = 53,
    xOpen_unixOpen_enum = 54
} xOpen_enum;

// xOpen signature initialization function
void init_xOpen_signatures(void);
// xOpen function declarations
int amatchOpen(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCursor);
int apndOpen(sqlite3_vfs*, const char *, sqlite3_file*, int , int *);
int binfoOpen(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCursor);
int bytecodevtabOpen(sqlite3_vtab *p, sqlite3_vtab_cursor **ppCursor);
int carrayOpen(sqlite3_vtab *p, sqlite3_vtab_cursor **ppCursor);
int cidxOpen(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCursor);
int closureOpen(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCursor);
int completionOpen(sqlite3_vtab *p, sqlite3_vtab_cursor **ppCursor);
int csvtabOpen(sqlite3_vtab*, sqlite3_vtab_cursor**);
int dbdataOpen(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCursor);
int dbpageOpen(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCursor);
int deltaparsevtabOpen(sqlite3_vtab *p, sqlite3_vtab_cursor **ppCursor);
int echoOpen(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCursor);
int expertOpen(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCursor);
int explainOpen(sqlite3_vtab *p, sqlite3_vtab_cursor **ppCursor);
int fsOpen(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCursor);
int fsdirOpen(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCursor);
int fstreeOpen(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCursor);
int fts3OpenMethod(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCsr);
int fts3auxOpenMethod(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCsr);
int fts3termOpenMethod(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCsr);
int fts3tokOpenMethod(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCsr);
int fts5OpenMethod(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCsr);
int fts5VocabOpenMethod( sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCsr );
int fts5structOpenMethod(sqlite3_vtab *p, sqlite3_vtab_cursor **ppCsr);
int fts5tokOpenMethod(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCsr);
int fuzzerOpen(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCursor);
int intarrayOpen(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCursor);
int jsonEachOpen(sqlite3_vtab *p, sqlite3_vtab_cursor **ppCursor);
int jsonEachOpenEach(sqlite3_vtab *p, sqlite3_vtab_cursor **ppCursor);
int jsonEachOpenTree(sqlite3_vtab *p, sqlite3_vtab_cursor **ppCursor);
int memdbOpen(sqlite3_vfs*, const char *, sqlite3_file*, int , int *);
int memstatOpen(sqlite3_vtab *p, sqlite3_vtab_cursor **ppCursor);
int multiplexOpen( sqlite3_vfs *pVfs, const char *zName, sqlite3_file *pConn, int flags, int *pOutFlags );
int porterOpen( sqlite3_tokenizer *pTokenizer, const char *zInput, int nInput, sqlite3_tokenizer_cursor **ppCursor );
int pragmaVtabOpen(sqlite3_vtab *pVtab, sqlite3_vtab_cursor **ppCursor);
int prefixesOpen(sqlite3_vtab *p, sqlite3_vtab_cursor **ppCursor);
int qpvtabOpen(sqlite3_vtab *p, sqlite3_vtab_cursor **ppCursor);
int quotaOpen( sqlite3_vfs *pVfs, const char *zName, sqlite3_file *pConn, int flags, int *pOutFlags );
int rtreeOpen(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCursor);
int schemaOpen(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCursor);
int seriesOpen(sqlite3_vtab *pUnused, sqlite3_vtab_cursor **ppCursor);
int simpleOpen( sqlite3_tokenizer *pTokenizer, const char *pInput, int nBytes, sqlite3_tokenizer_cursor **ppCursor );
int spellfix1Open(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCursor);
int statOpen(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCursor);
int stmtOpen(sqlite3_vtab *p, sqlite3_vtab_cursor **ppCursor);
int tclOpen(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCursor);
int tclvarOpen(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCursor);
int templatevtabOpen(sqlite3_vtab *p, sqlite3_vtab_cursor **ppCursor);
int unicodeOpen( sqlite3_tokenizer *p, const char *aInput, int nInput, sqlite3_tokenizer_cursor **pp );
int unionOpen(sqlite3_vtab *p, sqlite3_vtab_cursor **ppCursor);
int vfstraceOpen(sqlite3_vfs*, const char *, sqlite3_file*, int , int *);
int vstattabOpen(sqlite3_vtab*, sqlite3_vtab_cursor**);
int vtablogOpen(sqlite3_vtab *p, sqlite3_vtab_cursor **ppCursor);
int wholenumberOpen(sqlite3_vtab *p, sqlite3_vtab_cursor **ppCursor);
int zipfileOpen(sqlite3_vtab *p, sqlite3_vtab_cursor **ppCsr);
int unixOpen(sqlite3_vfs *pVfs, const char *zPath, sqlite3_file *pFile, int flags, int *pOutFlags);

// =============== xPagecount ===============
// xPagecount function pointer signatures (extern)
static int xPagecount_signatures[2][4] = {0,};

// xPagecount function enumeration
typedef enum {
    xPagecount_pcache1Pagecount_enum = 0,
    xPagecount_pcachetracePagecount_enum = 1
} xPagecount_enum;

// xPagecount signature initialization function
void init_xPagecount_signatures(void);
// xPagecount function declarations
int pcache1Pagecount(sqlite3_pcache *p);
int pcachetracePagecount(sqlite3_pcache *p);

// =============== xParseCell ===============
// xParseCell function pointer signatures (extern)
static int xParseCell_signatures[3][4] = {0,};

// xParseCell function enumeration
typedef enum {
    xParseCell_btreeParseCellPtr_enum = 0,
    xParseCell_btreeParseCellPtrIndex_enum = 1,
    xParseCell_btreeParseCellPtrNoPayload_enum = 2
} xParseCell_enum;

// xParseCell signature initialization function
void init_xParseCell_signatures(void);
// xParseCell function declarations
void btreeParseCellPtr( MemPage *pPage, u8 *pCell, CellInfo *pInfo );
void btreeParseCellPtrIndex( MemPage *pPage, u8 *pCell, CellInfo *pInfo );
void btreeParseCellPtrNoPayload( MemPage *pPage, u8 *pCell, CellInfo *pInfo );

// =============== xPhraseCount ===============
// xPhraseCount function pointer signatures (extern)
static int xPhraseCount_signatures[1][4] = {0,};

// xPhraseCount function enumeration
typedef enum {
    xPhraseCount_fts5ApiPhraseCount_enum = 0
} xPhraseCount_enum;

// xPhraseCount signature initialization function
void init_xPhraseCount_signatures(void);
// xPhraseCount function declarations
int fts5ApiPhraseCount(Fts5Context *pCtx);

// =============== xPhraseFirst ===============
// xPhraseFirst function pointer signatures (extern)
static int xPhraseFirst_signatures[1][4] = {0,};

// xPhraseFirst function enumeration
typedef enum {
    xPhraseFirst_fts5ApiPhraseFirst_enum = 0
} xPhraseFirst_enum;

// xPhraseFirst signature initialization function
void init_xPhraseFirst_signatures(void);
// xPhraseFirst function declarations
int fts5ApiPhraseFirst( Fts5Context *pCtx, int iPhrase, Fts5PhraseIter *pIter, int *piCol, int *piOff );

// =============== xPhraseFirstColumn ===============
// xPhraseFirstColumn function pointer signatures (extern)
static int xPhraseFirstColumn_signatures[1][4] = {0,};

// xPhraseFirstColumn function enumeration
typedef enum {
    xPhraseFirstColumn_fts5ApiPhraseFirstColumn_enum = 0
} xPhraseFirstColumn_enum;

// xPhraseFirstColumn signature initialization function
void init_xPhraseFirstColumn_signatures(void);
// xPhraseFirstColumn function declarations
int fts5ApiPhraseFirstColumn( Fts5Context *pCtx, int iPhrase, Fts5PhraseIter *pIter, int *piCol );

// =============== xPhraseNext ===============
// xPhraseNext function pointer signatures (extern)
static int xPhraseNext_signatures[1][4] = {0,};

// xPhraseNext function enumeration
typedef enum {
    xPhraseNext_fts5ApiPhraseNext_enum = 0
} xPhraseNext_enum;

// xPhraseNext signature initialization function
void init_xPhraseNext_signatures(void);
// xPhraseNext function declarations
void fts5ApiPhraseNext( Fts5Context *pCtx, Fts5PhraseIter *pIter, int *piCol, int *piOff );

// =============== xPhraseNextColumn ===============
// xPhraseNextColumn function pointer signatures (extern)
static int xPhraseNextColumn_signatures[1][4] = {0,};

// xPhraseNextColumn function enumeration
typedef enum {
    xPhraseNextColumn_fts5ApiPhraseNextColumn_enum = 0
} xPhraseNextColumn_enum;

// xPhraseNextColumn signature initialization function
void init_xPhraseNextColumn_signatures(void);
// xPhraseNextColumn function declarations
void fts5ApiPhraseNextColumn( Fts5Context *pCtx, Fts5PhraseIter *pIter, int *piCol );

// =============== xPhraseSize ===============
// xPhraseSize function pointer signatures (extern)
static int xPhraseSize_signatures[1][4] = {0,};

// xPhraseSize function enumeration
typedef enum {
    xPhraseSize_fts5ApiPhraseSize_enum = 0
} xPhraseSize_enum;

// xPhraseSize signature initialization function
void init_xPhraseSize_signatures(void);
// xPhraseSize function declarations
int fts5ApiPhraseSize(Fts5Context *pCtx, int iPhrase);

// =============== xQueryPhrase ===============
// xQueryPhrase function pointer signatures (extern)
static int xQueryPhrase_signatures[1][4] = {0,};

// xQueryPhrase function enumeration
typedef enum {
    xQueryPhrase_fts5ApiQueryPhrase_enum = 0
} xQueryPhrase_enum;

// xQueryPhrase signature initialization function
void init_xQueryPhrase_signatures(void);
// xQueryPhrase function declarations
int fts5ApiQueryPhrase(Fts5Context*, int, void*, int(*)(const Fts5ExtensionApi*, Fts5Context*, void*) );

// =============== xQueryToken ===============
// xQueryToken function pointer signatures (extern)
static int xQueryToken_signatures[1][4] = {0,};

// xQueryToken function enumeration
typedef enum {
    xQueryToken_fts5ApiQueryToken_enum = 0
} xQueryToken_enum;

// xQueryToken signature initialization function
void init_xQueryToken_signatures(void);
// xQueryToken function declarations
int fts5ApiQueryToken( Fts5Context* pCtx, int iPhrase, int iToken, const char **ppOut, int *pnOut );

// =============== xRandomness ===============
// xRandomness function pointer signatures (extern)
static int xRandomness_signatures[4][4] = {0,};

// xRandomness function enumeration
typedef enum {
    xRandomness_apndRandomness_enum = 0,
    xRandomness_memdbRandomness_enum = 1,
    xRandomness_vfstraceRandomness_enum = 2,
    xRandomness_unixRandomness_enum = 3
} xRandomness_enum;

// xRandomness signature initialization function
void init_xRandomness_signatures(void);
// xRandomness function declarations
int apndRandomness(sqlite3_vfs*, int nByte, char *zOut);
int memdbRandomness(sqlite3_vfs*, int nByte, char *zOut);
int multiplexRandomness(sqlite3_vfs *a, int b, char *c);
int vfstraceRandomness(sqlite3_vfs*, int nByte, char *zOut);
int unixRandomness(sqlite3_vfs *NotUsed, int nBuf, char *zBuf);

// =============== xRead ===============
// xRead function pointer signatures (extern)
static int xRead_signatures[6][4] = {0,};

// xRead function enumeration
typedef enum {
    xRead_apndRead_enum = 0,
    xRead_memdbRead_enum = 1,
    xRead_memjrnlRead_enum = 2,
    xRead_recoverVfsRead_enum = 3,
    xRead_vfstraceRead_enum = 4,
    xRead_unixRead_enum = 5
} xRead_enum;

// xRead signature initialization function
void init_xRead_signatures(void);
// xRead function declarations
int apndRead(sqlite3_file*, void*, int iAmt, sqlite3_int64 iOfst);
int memdbRead(sqlite3_file*, void*, int iAmt, sqlite3_int64 iOfst);
int memjrnlRead( sqlite3_file *pJfd, void *zBuf, int iAmt, sqlite_int64 iOfst );
int multiplexRead( sqlite3_file *pConn, void *pBuf, int iAmt, sqlite3_int64 iOfst );
int quotaRead( sqlite3_file *pConn, void *pBuf, int iAmt, sqlite3_int64 iOfst );
int vfstraceRead(sqlite3_file*, void*, int iAmt, sqlite3_int64 iOfst);
int unixRead(sqlite3_file *id, void *pBuf, int amt,sqlite3_int64 offset);

// =============== xRealloc ===============
// xRealloc function pointer signatures (extern)
static int xRealloc_signatures[2][4] = {0,};

// xRealloc function enumeration
typedef enum {
    xRealloc_memtraceRealloc_enum = 0,
    xRealloc_sqlite3MemRealloc_enum = 1
} xRealloc_enum;

// xRealloc signature initialization function
void init_xRealloc_signatures(void);
// xRealloc function declarations
void *memtraceRealloc(void *p, int n);
void *sqlite3MemRealloc(void *pPrior , int nByte);

// =============== xRekey ===============
// xRekey function pointer signatures (extern)
static int xRekey_signatures[3][4] = {0,};

// xRekey function enumeration
typedef enum {
    xRekey_pcache1Rekey_enum = 0,
    xRekey_pcachetraceRekey_enum = 1,
    xRekey_unixRandomness_enum = 2
} xRekey_enum;

// xRekey signature initialization function
void init_xRekey_signatures(void);
// xRekey function declarations
void pcache1Rekey( sqlite3_pcache *p, sqlite3_pcache_page *pPg, unsigned int iOld, unsigned int iNew );
void pcachetraceRekey( sqlite3_pcache *p, sqlite3_pcache_page *pPg, unsigned oldKey, unsigned newKey );

// =============== xRelease ===============
// xRelease function pointer signatures (extern)
static int xRelease_signatures[5][4] = {0,};

// xRelease function enumeration
typedef enum {
    xRelease_0_enum = 0,
    xRelease_echoRelease_enum = 1,
    xRelease_fts3ReleaseMethod_enum = 2,
    xRelease_fts5ReleaseMethod_enum = 3,
    xRelease_vtablogRelease_enum = 4
} xRelease_enum;

// xRelease signature initialization function
void init_xRelease_signatures(void);
// xRelease function declarations
int echoRelease(sqlite3_vtab *pVTab, int iSavepoint);
int fts3ReleaseMethod(sqlite3_vtab *pVtab, int iSavepoint);
int fts5ReleaseMethod(sqlite3_vtab *pVtab, int iSavepoint);
int vtablogRelease(sqlite3_vtab *tab, int N);

// =============== xRename ===============
// xRename function pointer signatures (extern)
static int xRename_signatures[7][4] = {0,};

// xRename function enumeration
typedef enum {
    xRename_0_enum = 0,
    xRename_echoRename_enum = 1,
    xRename_fts3RenameMethod_enum = 2,
    xRename_fts5RenameMethod_enum = 3,
    xRename_rtreeRename_enum = 4,
    xRename_spellfix1Rename_enum = 5,
    xRename_vtablogRename_enum = 6
} xRename_enum;

// xRename signature initialization function
void init_xRename_signatures(void);
// xRename function declarations
int echoRename(sqlite3_vtab *vtab, const char *zNewName);
int fts3RenameMethod( sqlite3_vtab *pVtab, const char *zName );
int fts5RenameMethod( sqlite3_vtab *pVtab, const char *zName );
int rtreeRename(sqlite3_vtab *pVtab, const char *zNewName);
int spellfix1Rename(sqlite3_vtab *pVTab, const char *zNew);
int vtablogRename(sqlite3_vtab *tab, const char *zNew);
int xDefaultRename(void *pArg, const char *zOld, const char *zNew);

// =============== xRollback ===============
// xRollback function pointer signatures (extern)
static int xRollback_signatures[8][4] = {0,};

// xRollback function enumeration
typedef enum {
    xRollback_0_enum = 0,
    xRollback_echoRollback_enum = 1,
    xRollback_fts3RollbackMethod_enum = 2,
    xRollback_fts5RollbackMethod_enum = 3,
    xRollback_rtreeEndTransaction_enum = 4,
    xRollback_rtreeRollback_enum = 5,
    xRollback_vtablogRollback_enum = 6,
    xRollback_zipfileRollback_enum = 7
} xRollback_enum;

// xRollback signature initialization function
void init_xRollback_signatures(void);
// xRollback function declarations
int echoRollback(sqlite3_vtab *tab);
int fts3RollbackMethod(sqlite3_vtab *pVtab);
int fts5RollbackMethod(sqlite3_vtab *pVtab);
int rtreeEndTransaction(sqlite3_vtab *pVtab);
int rtreeRollback(sqlite3_vtab *pVtab);
int vtablogRollback(sqlite3_vtab *tab);
int zipfileRollback(sqlite3_vtab *pVtab);

// =============== xRollbackTo ===============
// xRollbackTo function pointer signatures (extern)
static int xRollbackTo_signatures[6][4] = {0,};

// xRollbackTo function enumeration
typedef enum {
    xRollbackTo_0_enum = 0,
    xRollbackTo_dbpageRollbackTo_enum = 1,
    xRollbackTo_echoRollbackTo_enum = 2,
    xRollbackTo_fts3RollbackToMethod_enum = 3,
    xRollbackTo_fts5RollbackToMethod_enum = 4,
    xRollbackTo_vtablogRollbackTo_enum = 5
} xRollbackTo_enum;

// xRollbackTo signature initialization function
void init_xRollbackTo_signatures(void);
// xRollbackTo function declarations
int dbpageRollbackTo(sqlite3_vtab *pVtab, int notUsed1);
int echoRollbackTo(sqlite3_vtab *pVTab, int iSavepoint);
int fts3RollbackToMethod(sqlite3_vtab *pVtab, int iSavepoint);
int fts5RollbackToMethod(sqlite3_vtab *pVtab, int iSavepoint);
int vtablogRollbackTo(sqlite3_vtab *tab, int N);

// =============== xRoundup ===============
// xRoundup function pointer signatures (extern)
static int xRoundup_signatures[2][4] = {0,};

// xRoundup function enumeration
typedef enum {
    xRoundup_memtraceRoundup_enum = 0,
    xRoundup_sqlite3MemRoundup_enum = 1
} xRoundup_enum;

// xRoundup signature initialization function
void init_xRoundup_signatures(void);
// xRoundup function declarations
int memtraceRoundup(int n);
int sqlite3MemRoundup(int n);

// =============== xRowCount ===============
// xRowCount function pointer signatures (extern)
static int xRowCount_signatures[1][4] = {0,};

// xRowCount function enumeration
typedef enum {
    xRowCount_fts5ApiRowCount_enum = 0
} xRowCount_enum;

// xRowCount signature initialization function
void init_xRowCount_signatures(void);
// xRowCount function declarations
int fts5ApiRowCount(Fts5Context *pCtx, i64 *pnRow);

// =============== xRowid ===============
// xRowid function pointer signatures (extern)
static int xRowid_signatures[48][4] = {0,};

// xRowid function enumeration
typedef enum {
    xRowid_0_enum = 0,
    xRowid_amatchRowid_enum = 1,
    xRowid_binfoRowid_enum = 2,
    xRowid_bytecodevtabRowid_enum = 3,
    xRowid_carrayRowid_enum = 4,
    xRowid_cidxRowid_enum = 5,
    xRowid_closureRowid_enum = 6,
    xRowid_completionRowid_enum = 7,
    xRowid_csvtabRowid_enum = 8,
    xRowid_dbdataRowid_enum = 9,
    xRowid_dbpageRowid_enum = 10,
    xRowid_deltaparsevtabRowid_enum = 11,
    xRowid_echoRowid_enum = 12,
    xRowid_expertRowid_enum = 13,
    xRowid_explainRowid_enum = 14,
    xRowid_fsRowid_enum = 15,
    xRowid_fsdirRowid_enum = 16,
    xRowid_fstreeRowid_enum = 17,
    xRowid_fts3RowidMethod_enum = 18,
    xRowid_fts3auxRowidMethod_enum = 19,
    xRowid_fts3termRowidMethod_enum = 20,
    xRowid_fts3tokRowidMethod_enum = 21,
    xRowid_fts5ApiRowid_enum = 22,
    xRowid_fts5RowidMethod_enum = 23,
    xRowid_fts5VocabRowidMethod_enum = 24,
    xRowid_fts5structRowidMethod_enum = 25,
    xRowid_fts5tokRowidMethod_enum = 26,
    xRowid_fuzzerRowid_enum = 27,
    xRowid_intarrayRowid_enum = 28,
    xRowid_jsonEachRowid_enum = 29,
    xRowid_memstatRowid_enum = 30,
    xRowid_pragmaVtabRowid_enum = 31,
    xRowid_prefixesRowid_enum = 32,
    xRowid_qpvtabRowid_enum = 33,
    xRowid_rtreeRowid_enum = 34,
    xRowid_schemaRowid_enum = 35,
    xRowid_seriesRowid_enum = 36,
    xRowid_spellfix1Rowid_enum = 37,
    xRowid_statRowid_enum = 38,
    xRowid_stmtRowid_enum = 39,
    xRowid_tclRowid_enum = 40,
    xRowid_tclvarRowid_enum = 41,
    xRowid_templatevtabRowid_enum = 42,
    xRowid_unionRowid_enum = 43,
    xRowid_vlogRowid_enum = 44,
    xRowid_vstattabRowid_enum = 45,
    xRowid_vtablogRowid_enum = 46,
    xRowid_wholenumberRowid_enum = 47
} xRowid_enum;

// xRowid signature initialization function
void init_xRowid_signatures(void);
// xRowid function declarations
int amatchRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int binfoRowid(sqlite3_vtab_cursor *pCursor, sqlite_int64 *pRowid);
int bytecodevtabRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int carrayRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int cidxRowid(sqlite3_vtab_cursor *pCursor, sqlite_int64 *pRowid);
int closureRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int completionRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int csvtabRowid(sqlite3_vtab_cursor*,sqlite3_int64*);
int dbdataRowid(sqlite3_vtab_cursor *pCursor, sqlite_int64 *pRowid);
int dbpageRowid(sqlite3_vtab_cursor *pCursor, sqlite_int64 *pRowid);
int deltaparsevtabRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int echoRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int expertRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int explainRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int fsRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int fsdirRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int fstreeRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int fts3RowidMethod(sqlite3_vtab_cursor *pCursor, sqlite_int64 *pRowid);
int fts3auxRowidMethod( sqlite3_vtab_cursor *pCursor, sqlite_int64 *pRowid );
int fts3termRowidMethod( sqlite3_vtab_cursor *pCursor, sqlite_int64 *pRowid );
int fts3tokRowidMethod( sqlite3_vtab_cursor *pCursor, sqlite_int64 *pRowid );
sqlite3_int64 fts5ApiRowid(Fts5Context *pCtx);
int fts5RowidMethod(sqlite3_vtab_cursor *pCursor, sqlite_int64 *pRowid);
int fts5VocabRowidMethod( sqlite3_vtab_cursor *pCursor, sqlite_int64 *pRowid );
int fts5structRowidMethod( sqlite3_vtab_cursor *cur, sqlite_int64 *piRowid );
int fts5tokRowidMethod( sqlite3_vtab_cursor *pCursor, sqlite_int64 *pRowid );
int fuzzerRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int intarrayRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int jsonEachRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int memstatRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int pragmaVtabRowid(sqlite3_vtab_cursor *pVtabCursor, sqlite_int64 *p);
int prefixesRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int qpvtabRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int rtreeRowid(sqlite3_vtab_cursor *pVtabCursor, sqlite_int64 *pRowid);
int schemaRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int seriesRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int spellfix1Rowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int statRowid(sqlite3_vtab_cursor *pCursor, sqlite_int64 *pRowid);
int stmtRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int tclRowid(sqlite3_vtab_cursor *pVtabCursor, sqlite_int64 *pRowid);
int tclvarRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int templatevtabRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int unionRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int vlogRowid(sqlite3_vtab_cursor *pCursor, sqlite_int64 *pRowid);
int vstattabRowid(sqlite3_vtab_cursor*,sqlite3_int64*);
int vtablogRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);
int wholenumberRowid(sqlite3_vtab_cursor *cur, sqlite_int64 *pRowid);

// =============== xSFunc ===============
// xSFunc function pointer signatures (extern)
static int xSFunc_signatures[5][4] = {0,};

// xSFunc function enumeration
typedef enum {
    xSFunc_attachFunc_enum = 0,
    xSFunc_detachFunc_enum = 1,
    xSFunc_statGet_enum = 2,
    xSFunc_statInit_enum = 3,
    xSFunc_statPush_enum = 4
} xSFunc_enum;

// xSFunc signature initialization function
void init_xSFunc_signatures(void);
// xSFunc function declarations
void attachFunc( sqlite3_context *context, int NotUsed, sqlite3_value **argv );
void detachFunc( sqlite3_context *context, int NotUsed, sqlite3_value **argv );
void statInit( sqlite3_context *context, int argc, sqlite3_value **argv );

// =============== xSavepoint ===============
// xSavepoint function pointer signatures (extern)
static int xSavepoint_signatures[4][4] = {0,};

// xSavepoint function enumeration
typedef enum {
    xSavepoint_0_enum = 0,
    xSavepoint_fts3SavepointMethod_enum = 1,
    xSavepoint_fts5SavepointMethod_enum = 2,
    xSavepoint_rtreeSavepoint_enum = 3
} xSavepoint_enum;

// xSavepoint signature initialization function
void init_xSavepoint_signatures(void);
// xSavepoint function declarations
int fts3SavepointMethod(sqlite3_vtab *pVtab, int iSavepoint);
int fts5SavepointMethod(sqlite3_vtab *pVtab, int iSavepoint);
int rtreeSavepoint(sqlite3_vtab *pVtab, int iSavepoint);

// =============== xSectorSize ===============
// xSectorSize function pointer signatures (extern)
static int xSectorSize_signatures[5][4] = {0,};

// xSectorSize function enumeration
typedef enum {
    xSectorSize_0_enum = 0,
    xSectorSize_apndSectorSize_enum = 1,
    xSectorSize_recoverVfsSectorSize_enum = 2,
    xSectorSize_vfstraceSectorSize_enum = 3,
    xSectorSize_unixSectorSize_enum = 4
} xSectorSize_enum;

// xSectorSize signature initialization function
void init_xSectorSize_signatures(void);
// xSectorSize function declarations
int apndSectorSize(sqlite3_file*);
int multiplexSectorSize(sqlite3_file *pConn);
int quotaSectorSize(sqlite3_file *pConn);
int vfstraceSectorSize(sqlite3_file*);
int unixSectorSize(sqlite3_file *id);

// =============== xSelectCallback ===============
// xSelectCallback function pointer signatures (extern)
static int xSelectCallback_signatures[17][4] = {0,};

// xSelectCallback function enumeration
typedef enum {
    xSelectCallback_0_enum = 0,
    xSelectCallback_convertCompoundSelectToSubquery_enum = 1,
    xSelectCallback_exprSelectWalkTableConstant_enum = 2,
    xSelectCallback_fixSelectCb_enum = 3,
    xSelectCallback_gatherSelectWindowsSelectCallback_enum = 4,
    xSelectCallback_renameColumnSelectCb_enum = 5,
    xSelectCallback_renameTableSelectCb_enum = 6,
    xSelectCallback_renameUnmapSelectCb_enum = 7,
    xSelectCallback_resolveSelectStep_enum = 8,
    xSelectCallback_selectCheckOnClausesSelect_enum = 9,
    xSelectCallback_selectExpander_enum = 10,
    xSelectCallback_selectRefEnter_enum = 11,
    xSelectCallback_selectWindowRewriteSelectCb_enum = 12,
    xSelectCallback_sqlite3ReturningSubqueryCorrelated_enum = 13,
    xSelectCallback_sqlite3SelectWalkFail_enum = 14,
    xSelectCallback_sqlite3SelectWalkNoop_enum = 15,
    xSelectCallback_sqlite3WalkerDepthIncrease_enum = 16
} xSelectCallback_enum;

// xSelectCallback signature initialization function
void init_xSelectCallback_signatures(void);
// xSelectCallback function declarations
int convertCompoundSelectToSubquery(Walker *pWalker, Select *p);
int exprSelectWalkTableConstant(Walker *pWalker, Select *pSelect);
int fixSelectCb(Walker *p, Select *pSelect);
int gatherSelectWindowsSelectCallback(Walker *pWalker, Select *p);
int renameColumnSelectCb(Walker *pWalker, Select *p);
int renameTableSelectCb(Walker *pWalker, Select *pSelect);
int renameUnmapSelectCb(Walker *pWalker, Select *p);
int resolveSelectStep(Walker *pWalker, Select *p);
int selectCheckOnClausesSelect(Walker *pWalker, Select *pSelect);
int selectExpander(Walker *pWalker, Select *p);
int selectRefEnter(Walker *pWalker, Select *pSelect);
int selectWindowRewriteSelectCb(Walker *pWalker, Select *pSelect);
int sqlite3ReturningSubqueryCorrelated(Walker *pWalker, Select *pSelect);
int sqlite3SelectWalkFail(Walker *pWalker, Select *NotUsed);
int sqlite3SelectWalkNoop(Walker*, Select*);
int sqlite3WalkerDepthIncrease(Walker*,Select*);

// =============== xSelectCallback2 ===============
// xSelectCallback2 function pointer signatures (extern)
static int xSelectCallback2_signatures[6][4] = {0,};

// xSelectCallback2 function enumeration
typedef enum {
    xSelectCallback2_0_enum = 0,
    xSelectCallback2_selectAddSubqueryTypeInfo_enum = 1,
    xSelectCallback2_selectRefLeave_enum = 2,
    xSelectCallback2_sqlite3SelectPopWith_enum = 3,
    xSelectCallback2_sqlite3WalkWinDefnDummyCallback_enum = 4,
    xSelectCallback2_sqlite3WalkerDepthDecrease_enum = 5
} xSelectCallback2_enum;

// xSelectCallback2 signature initialization function
void init_xSelectCallback2_signatures(void);
// xSelectCallback2 function declarations
void selectAddSubqueryTypeInfo(Walker *pWalker, Select *p);
void selectRefLeave(Walker *pWalker, Select *pSelect);
void sqlite3SelectPopWith(Walker *pWalker, Select *p);
void sqlite3WalkWinDefnDummyCallback(Walker*,Select*);
void sqlite3WalkerDepthDecrease(Walker*,Select*);

// =============== xSetAuxdata ===============
// xSetAuxdata function pointer signatures (extern)
static int xSetAuxdata_signatures[1][4] = {0,};

// xSetAuxdata function enumeration
typedef enum {
    xSetAuxdata_fts5ApiSetAuxdata_enum = 0
} xSetAuxdata_enum;

// xSetAuxdata signature initialization function
void init_xSetAuxdata_signatures(void);
// xSetAuxdata function declarations
int fts5ApiSetAuxdata( Fts5Context *pCtx, void *pPtr, void(*xDelete)(void*) );

// =============== xSetOutputs ===============
// xSetOutputs function pointer signatures (extern)
static int xSetOutputs_signatures[7][4] = {0,};

// xSetOutputs function enumeration
typedef enum {
    xSetOutputs_fts5IterSetOutputs_Col_enum = 0,
    xSetOutputs_fts5IterSetOutputs_Col100_enum = 1,
    xSetOutputs_fts5IterSetOutputs_Full_enum = 2,
    xSetOutputs_fts5IterSetOutputs_Nocolset_enum = 3,
    xSetOutputs_fts5IterSetOutputs_None_enum = 4,
    xSetOutputs_fts5IterSetOutputs_Noop_enum = 5,
    xSetOutputs_fts5IterSetOutputs_ZeroColset_enum = 6
} xSetOutputs_enum;

// xSetOutputs signature initialization function
void init_xSetOutputs_signatures(void);
// xSetOutputs function declarations
void fts5IterSetOutputs_Col(Fts5Iter *pIter, Fts5SegIter *pSeg);
void fts5IterSetOutputs_Col100(Fts5Iter *pIter, Fts5SegIter *pSeg);
void fts5IterSetOutputs_Full(Fts5Iter *pIter, Fts5SegIter *pSeg);
void fts5IterSetOutputs_Nocolset(Fts5Iter *pIter, Fts5SegIter *pSeg);
void fts5IterSetOutputs_None(Fts5Iter *pIter, Fts5SegIter *pSeg);
void fts5IterSetOutputs_Noop(Fts5Iter *pUnused1, Fts5SegIter *pUnused2);
void fts5IterSetOutputs_ZeroColset(Fts5Iter *pIter, Fts5SegIter *pSeg);

// =============== xSetSystemCall ===============
// xSetSystemCall function pointer signatures (extern)
static int xSetSystemCall_signatures[6][4] = {0,};

// xSetSystemCall function enumeration
typedef enum {
    xSetSystemCall_0_enum = 0,
    xSetSystemCall_apndSetSystemCall_enum = 1,
    xSetSystemCall_devsymSleep_enum = 2,
    xSetSystemCall_rbuVfsSleep_enum = 3,
    xSetSystemCall_tvfsSleep_enum = 4,
    xSetSystemCall_unixSetSystemCall_enum = 5
} xSetSystemCall_enum;

// xSetSystemCall signature initialization function
void init_xSetSystemCall_signatures(void);
// xSetSystemCall function declarations
int apndSetSystemCall(sqlite3_vfs*, const char*,sqlite3_syscall_ptr);
int devsymSleep(sqlite3_vfs*, int microseconds);
int rbuVfsSleep(sqlite3_vfs *pVfs, int nMicro);
int tvfsSleep(sqlite3_vfs*, int microseconds);
int unixSetSystemCall(sqlite3_vfs *pNotUsed, const char *zName, sqlite3_syscall_ptr pNewFunc );

// =============== xShadowName ===============
// xShadowName function pointer signatures (extern)
static int xShadowName_signatures[4][4] = {0,};

// xShadowName function enumeration
typedef enum {
    xShadowName_0_enum = 0,
    xShadowName_fts3ShadowName_enum = 1,
    xShadowName_fts5ShadowName_enum = 2,
    xShadowName_rtreeShadowName_enum = 3
} xShadowName_enum;

// xShadowName signature initialization function
void init_xShadowName_signatures(void);
// xShadowName function declarations
int fts3ShadowName(const char *zName);
int fts5ShadowName(const char *zName);
int rtreeShadowName(const char *zName);

// =============== xShmBarrier ===============
// xShmBarrier function pointer signatures (extern)
static int xShmBarrier_signatures[4][4] = {0,};

// xShmBarrier function enumeration
typedef enum {
    xShmBarrier_0_enum = 0,
    xShmBarrier_apndShmBarrier_enum = 1,
    xShmBarrier_recoverVfsShmBarrier_enum = 2,
    xShmBarrier_unixShmBarrier_enum = 3
} xShmBarrier_enum;

// xShmBarrier signature initialization function
void init_xShmBarrier_signatures(void);
// xShmBarrier function declarations
void apndShmBarrier(sqlite3_file*);
void multiplexShmBarrier(sqlite3_file *pConn);
void quotaShmBarrier(sqlite3_file *pConn);
void recoverVfsShmBarrier(sqlite3_file*);
void unixShmBarrier(sqlite3_file *fd );

// =============== xShmLock ===============
// xShmLock function pointer signatures (extern)
static int xShmLock_signatures[4][4] = {0,};

// xShmLock function enumeration
typedef enum {
    xShmLock_0_enum = 0,
    xShmLock_apndShmLock_enum = 1,
    xShmLock_recoverVfsShmLock_enum = 2,
    xShmLock_unixShmLock_enum = 3
} xShmLock_enum;

// xShmLock signature initialization function
void init_xShmLock_signatures(void);
// xShmLock function declarations
int apndShmLock(sqlite3_file*, int offset, int n, int flags);
int multiplexShmLock( sqlite3_file *pConn, int ofst, int n, int flags );
int quotaShmLock( sqlite3_file *pConn, int ofst, int n, int flags );
int recoverVfsShmLock(sqlite3_file*, int offset, int n, int flags);
int unixShmLock(sqlite3_file *fd, int ofst, int n, int flags );

// =============== xShmMap ===============
// xShmMap function pointer signatures (extern)
static int xShmMap_signatures[4][4] = {0,};

// xShmMap function enumeration
typedef enum {
    xShmMap_0_enum = 0,
    xShmMap_apndShmMap_enum = 1,
    xShmMap_recoverVfsShmMap_enum = 2,
    xShmMap_unixShmMap_enum = 3
} xShmMap_enum;

// xShmMap signature initialization function
void init_xShmMap_signatures(void);
// xShmMap function declarations
int apndShmMap(sqlite3_file*, int iPg, int pgsz, int, void volatile**);
int multiplexShmMap( sqlite3_file *pConn, int iRegion, int szRegion, int bExtend, void volatile **pp );
int quotaShmMap( sqlite3_file *pConn, int iRegion, int szRegion, int bExtend, void volatile **pp );
int recoverVfsShmMap(sqlite3_file*, int, int, int, void volatile**);
int unixShmMap(sqlite3_file *fd, int iRegion, int szRegion, int bExtend, void volatile **pp);

// =============== xShmUnmap ===============
// xShmUnmap function pointer signatures (extern)
static int xShmUnmap_signatures[4][4] = {0,};

// xShmUnmap function enumeration
typedef enum {
    xShmUnmap_0_enum = 0,
    xShmUnmap_apndShmUnmap_enum = 1,
    xShmUnmap_recoverVfsShmUnmap_enum = 2,
    xShmUnmap_unixShmUnmap_enum = 3
} xShmUnmap_enum;

// xShmUnmap signature initialization function
void init_xShmUnmap_signatures(void);
// xShmUnmap function declarations
int apndShmUnmap(sqlite3_file*, int deleteFlag);
int multiplexShmUnmap(sqlite3_file *pConn, int deleteFlag);
int quotaShmUnmap(sqlite3_file *pConn, int deleteFlag);
int recoverVfsShmUnmap(sqlite3_file*, int deleteFlag);
int unixShmUnmap(sqlite3_file *fd, int deleteFlag );

// =============== xShrink ===============
// xShrink function pointer signatures (extern)
static int xShrink_signatures[2][4] = {0,};

// xShrink function enumeration
typedef enum {
    xShrink_pcache1Shrink_enum = 0,
    xShrink_pcachetraceShrink_enum = 1
} xShrink_enum;

// xShrink signature initialization function
void init_xShrink_signatures(void);
// xShrink function declarations
void pcache1Shrink(sqlite3_pcache *p);
void pcachetraceShrink(sqlite3_pcache *p);

// =============== xShutdown ===============
// xShutdown function pointer signatures (extern)
static int xShutdown_signatures[4][4] = {0,};

// xShutdown function enumeration
typedef enum {
    xShutdown_memtraceShutdown_enum = 0,
    xShutdown_pcache1Shutdown_enum = 1,
    xShutdown_pcachetraceShutdown_enum = 2,
    xShutdown_sqlite3MemShutdown_enum = 3
} xShutdown_enum;

// xShutdown signature initialization function
void init_xShutdown_signatures(void);
// xShutdown function declarations
void memtraceShutdown(void *p);
void pcache1Shutdown(void *NotUsed);
void pcachetraceShutdown(void *pArg);
void sqlite3MemShutdown(void *NotUsed);

// =============== xSize ===============
// xSize function pointer signatures (extern)
static int xSize_signatures[2][4] = {0,};

// xSize function enumeration
typedef enum {
    xSize_memtraceSize_enum = 0,
    xSize_sqlite3MemSize_enum = 1
} xSize_enum;

// xSize signature initialization function
void init_xSize_signatures(void);
// xSize function declarations
int memtraceSize(void *p);
int sqlite3MemSize(void *pPrior);

// =============== xSleep ===============
// xSleep function pointer signatures (extern)
static int xSleep_signatures[5][4] = {0,};

// xSleep function enumeration
typedef enum {
    xSleep_0_enum = 0,
    xSleep_apndSleep_enum = 1,
    xSleep_memdbSleep_enum = 2,
    xSleep_vfstraceSleep_enum = 3,
    xSleep_unixSleep_enum = 4
} xSleep_enum;

// xSleep signature initialization function
void init_xSleep_signatures(void);
// xSleep function declarations
int apndSleep(sqlite3_vfs*, int microseconds);
int memdbSleep(sqlite3_vfs*, int microseconds);
int multiplexSleep(sqlite3_vfs *a, int b);
int vfstraceSleep(sqlite3_vfs*, int microseconds);
int unixSleep(sqlite3_vfs *NotUsed, int microseconds);

// =============== xSync ===============
// xSync function pointer signatures (extern)
static int xSync_signatures[13][4] = {0,};

// xSync function enumeration
typedef enum {
    xSync_0_enum = 0,
    xSync_apndSync_enum = 1,
    xSync_dbpageSync_enum = 2,
    xSync_echoSync_enum = 3,
    xSync_fts3SyncMethod_enum = 4,
    xSync_fts5SyncMethod_enum = 5,
    xSync_memdbSync_enum = 6,
    xSync_memjrnlSync_enum = 7,
    xSync_recoverVfsSync_enum = 8,
    xSync_rtreeEndTransaction_enum = 9,
    xSync_vfstraceSync_enum = 10,
    xSync_vtablogSync_enum = 11,
    xSync_unixSync_enum = 12
} xSync_enum;

// xSync signature initialization function
void init_xSync_signatures(void);
// xSync function declarations
int apndSync(sqlite3_file*, int flags);
int dbpageSync(sqlite3_vtab *pVtab);
int echoSync(sqlite3_vtab *tab);
int fts3SyncMethod(sqlite3_vtab *pVtab);
int fts5SyncMethod(sqlite3_vtab *pVtab);
int memdbSync(sqlite3_file*, int flags);
int memjrnlSync(sqlite3_file *pJfd, int flags);
int multiplexSync(sqlite3_file *pConn, int flags);
int quotaSync(sqlite3_file *pConn, int flags);
int rtreeEndTransaction(sqlite3_vtab *pVtab);
int vfstraceSync(sqlite3_file*, int flags);
int vtablogSync(sqlite3_vtab *tab);
int unixSync(sqlite3_file *id, int flags);

// =============== xTokenize ===============
// xTokenize function pointer signatures (extern)
static int xTokenize_signatures[8][4] = {0,};

// xTokenize function enumeration
typedef enum {
    xTokenize_0_enum = 0,
    xTokenize_f5tOrigintextTokenize_enum = 1,
    xTokenize_f5tTokenizerTokenize_enum = 2,
    xTokenize_f5tTokenizerTokenize_v2_enum = 3,
    xTokenize_fts5ApiTokenize_enum = 4,
    xTokenize_fts5PorterTokenize_enum = 5,
    xTokenize_fts5V1toV2Tokenize_enum = 6,
    xTokenize_fts5V2toV1Tokenize_enum = 7
} xTokenize_enum;

// xTokenize signature initialization function
void init_xTokenize_signatures(void);
// xTokenize function declarations
int f5tOrigintextTokenize( Fts5Tokenizer *pTokenizer, void *pCtx, int flags, const char *pText, int nText, int (*xToken)(void *, int, const char *, int, int, int) );
int f5tTokenizerTokenize( Fts5Tokenizer *p, void *pCtx, int flags, const char *pText, int nText, int (*xToken)(void*, int, const char*, int, int, int) );
int f5tTokenizerTokenize_v2( Fts5Tokenizer *p, void *pCtx, int flags, const char *pText, int nText, const char *pLoc, int nLoc, int (*xToken)(void*, int, const char*, int, int, int) );
int fts5ApiTokenize( Fts5Context *pCtx, const char *pText, int nText, void *pUserData, int (*xToken)(void*, int, const char*, int, int, int) );
int fts5PorterTokenize( Fts5Tokenizer *pTokenizer, void *pCtx, int flags, const char *pText, int nText, const char *pLoc, int nLoc, int (*xToken)(void*, int, const char*, int nToken, int iStart, int iEnd) );
int fts5V1toV2Tokenize( Fts5Tokenizer *pTok, void *pCtx, int flags, const char *pText, int nText, int (*xToken)(void*, int, const char*, int, int, int) );
int fts5V2toV1Tokenize( Fts5Tokenizer *pTok, void *pCtx, int flags, const char *pText, int nText, const char *pLocale, int nLocale, int (*xToken)(void*, int, const char*, int, int, int) );

// =============== xTokenize_v2 ===============
// xTokenize_v2 function pointer signatures (extern)
static int xTokenize_v2_signatures[1][4] = {0,};

// xTokenize_v2 function enumeration
typedef enum {
    xTokenize_v2_fts5ApiTokenize_v2_enum = 0
} xTokenize_v2_enum;

// xTokenize_v2 signature initialization function
void init_xTokenize_v2_signatures(void);
// xTokenize_v2 function declarations
int fts5ApiTokenize_v2( Fts5Context *pCtx, const char *pText, int nText, const char *pLoc, int nLoc, void *pUserData, int (*xToken)(void*, int, const char*, int, int, int) );

// =============== xTruncate ===============
// xTruncate function pointer signatures (extern)
static int xTruncate_signatures[8][4] = {0,};

// xTruncate function enumeration
typedef enum {
    xTruncate_apndTruncate_enum = 0,
    xTruncate_memdbTruncate_enum = 1,
    xTruncate_memjrnlTruncate_enum = 2,
    xTruncate_pcache1Truncate_enum = 3,
    xTruncate_pcachetraceTruncate_enum = 4,
    xTruncate_recoverVfsTruncate_enum = 5,
    xTruncate_vfstraceTruncate_enum = 6,
    xTruncate_unixTruncate_enum = 7
} xTruncate_enum;

// xTruncate signature initialization function
void init_xTruncate_signatures(void);
// xTruncate function declarations
int apndTruncate(sqlite3_file*, sqlite3_int64 size);
int memdbTruncate(sqlite3_file*, sqlite3_int64 size);
int memjrnlTruncate(sqlite3_file *pJfd, sqlite_int64 size);
int multiplexTruncate(sqlite3_file *pConn, sqlite3_int64 size);
void pcache1Truncate(sqlite3_pcache *p, unsigned int iLimit);
void pcachetraceTruncate(sqlite3_pcache *p, unsigned n);
int quotaTruncate(sqlite3_file *pConn, sqlite3_int64 size);
int vfstraceTruncate(sqlite3_file*, sqlite3_int64 size);
int unixTruncate(sqlite3_file *id, i64 nByte);

// =============== xUnfetch ===============
// xUnfetch function pointer signatures (extern)
static int xUnfetch_signatures[5][4] = {0,};

// xUnfetch function enumeration
typedef enum {
    xUnfetch_0_enum = 0,
    xUnfetch_apndUnfetch_enum = 1,
    xUnfetch_memdbUnfetch_enum = 2,
    xUnfetch_recoverVfsUnfetch_enum = 3,
    xUnfetch_unixUnfetch_enum = 4
} xUnfetch_enum;

// xUnfetch signature initialization function
void init_xUnfetch_signatures(void);
// xUnfetch function declarations
int apndUnfetch(sqlite3_file*, sqlite3_int64 iOfst, void *p);
int memdbUnfetch(sqlite3_file*, sqlite3_int64 iOfst, void *p);
int recoverVfsUnfetch(sqlite3_file *pFd, sqlite3_int64 iOff, void *p);
int unixUnfetch(sqlite3_file *fd, i64 iOff, void *p);

// =============== xUnlock ===============
// xUnlock function pointer signatures (extern)
static int xUnlock_signatures[8][4] = {0,};

// xUnlock function enumeration
typedef enum {
    xUnlock_0_enum = 0,
    xUnlock_apndUnlock_enum = 1,
    xUnlock_memdbUnlock_enum = 2,
    xUnlock_recoverVfsUnlock_enum = 3,
    xUnlock_vfstraceUnlock_enum = 4,
    xUnlock_unixUnlock_enum = 5,
    xUnlock_nolockUnlock_enum = 6,
    xUnlock_dotlockUnlock_enum = 7
} xUnlock_enum;

// xUnlock signature initialization function
void init_xUnlock_signatures(void);
// xUnlock function declarations
int apndUnlock(sqlite3_file*, int);
int memdbUnlock(sqlite3_file*, int);
int multiplexUnlock(sqlite3_file *pConn, int lock);
int quotaUnlock(sqlite3_file *pConn, int lock);
int vfstraceUnlock(sqlite3_file*, int);
int unixUnlock(sqlite3_file *id, int eFileLock);
int nolockUnlock(sqlite3_file *NotUsed, int NotUsed2);
int dotlockUnlock(sqlite3_file *id, int eFileLock);

// =============== xUnpin ===============
// xUnpin function pointer signatures (extern)
static int xUnpin_signatures[2][4] = {0,};

// xUnpin function enumeration
typedef enum {
    xUnpin_pcache1Unpin_enum = 0,
    xUnpin_pcachetraceUnpin_enum = 1
} xUnpin_enum;

// xUnpin signature initialization function
void init_xUnpin_signatures(void);
// xUnpin function declarations
void pcache1Unpin( sqlite3_pcache *p, sqlite3_pcache_page *pPg, int reuseUnlikely );
void pcachetraceUnpin( sqlite3_pcache *p, sqlite3_pcache_page *pPg, int bDiscard );

// =============== xUpdate ===============
// xUpdate function pointer signatures (extern)
static int xUpdate_signatures[15][4] = {0,};

// xUpdate function enumeration
typedef enum {
    xUpdate_0_enum = 0,
    xUpdate_amatchUpdate_enum = 1,
    xUpdate_csvtabUpdate_enum = 2,
    xUpdate_dbpageUpdate_enum = 3,
    xUpdate_echoUpdate_enum = 4,
    xUpdate_expertUpdate_enum = 5,
    xUpdate_fts3UpdateMethod_enum = 6,
    xUpdate_fts5UpdateMethod_enum = 7,
    xUpdate_geopolyUpdate_enum = 8,
    xUpdate_rtreeUpdate_enum = 9,
    xUpdate_spellfix1Update_enum = 10,
    xUpdate_tclvarUpdate_enum = 11,
    xUpdate_vstattabUpdate_enum = 12,
    xUpdate_vtablogUpdate_enum = 13,
    xUpdate_zipfileUpdate_enum = 14
} xUpdate_enum;

// xUpdate signature initialization function
void init_xUpdate_signatures(void);
// xUpdate function declarations
int amatchUpdate( sqlite3_vtab *pVTab, int argc, sqlite3_value **argv, sqlite_int64 *pRowid );
int csvtabUpdate(sqlite3_vtab *p,int n,sqlite3_value**v,sqlite3_int64*x);
int dbpageUpdate( sqlite3_vtab *pVtab, int argc, sqlite3_value **argv, sqlite_int64 *pRowid );
int echoUpdate( sqlite3_vtab *tab, int nData, sqlite3_value **apData, sqlite_int64 *pRowid );
int expertUpdate( sqlite3_vtab *pVtab, int nData, sqlite3_value **azData, sqlite_int64 *pRowid );
int fts3UpdateMethod( sqlite3_vtab *pVtab, int nArg, sqlite3_value **apVal, sqlite_int64 *pRowid );
int fts5UpdateMethod( sqlite3_vtab *pVtab, int nArg, sqlite3_value **apVal, sqlite_int64 *pRowid );
int geopolyUpdate( sqlite3_vtab *pVtab, int nData, sqlite3_value **aData, sqlite_int64 *pRowid );
int rtreeUpdate( sqlite3_vtab *pVtab, int nData, sqlite3_value **aData, sqlite_int64 *pRowid );
int spellfix1Update( sqlite3_vtab *pVTab, int argc, sqlite3_value **argv, sqlite_int64 *pRowid );
int tclvarUpdate( sqlite3_vtab *tab, int argc, sqlite3_value **argv, sqlite_int64 *pRowid );
int vstattabUpdate(sqlite3_vtab*,int,sqlite3_value**,sqlite3_int64*);
int vtablogUpdate( sqlite3_vtab *tab, int argc, sqlite3_value **argv, sqlite_int64 *pRowid );
int zipfileUpdate( sqlite3_vtab *pVtab, int nVal, sqlite3_value **apVal, sqlite_int64 *pRowid );

// =============== xUserData ===============
// xUserData function pointer signatures (extern)
static int xUserData_signatures[1][4] = {0,};

// xUserData function enumeration
typedef enum {
    xUserData_fts5ApiUserData_enum = 0
} xUserData_enum;

// xUserData signature initialization function
void init_xUserData_signatures(void);
// xUserData function declarations
void *fts5ApiUserData(Fts5Context *pCtx);

// =============== xWrite ===============
// xWrite function pointer signatures (extern)
static int xWrite_signatures[7][4] = {0,};

// xWrite function enumeration
typedef enum {
    xWrite_apndWrite_enum = 0,
    xWrite_kvstorageWrite_enum = 1,
    xWrite_memdbWrite_enum = 2,
    xWrite_memjrnlWrite_enum = 3,
    xWrite_recoverVfsWrite_enum = 4,
    xWrite_vfstraceWrite_enum = 5,
    xWrite_unixWrite_enum = 6
} xWrite_enum;

// xWrite signature initialization function
void init_xWrite_signatures(void);
// xWrite function declarations
int apndWrite(sqlite3_file*,const void*,int iAmt, sqlite3_int64 iOfst);
int kvstorageWrite( const char *zClass, const char *zKey, const char *zData );
int memdbWrite(sqlite3_file*,const void*,int iAmt, sqlite3_int64 iOfst);
int memjrnlWrite( sqlite3_file *pJfd, const void *zBuf, int iAmt, sqlite_int64 iOfst );
int multiplexWrite( sqlite3_file *pConn, const void *pBuf, int iAmt, sqlite3_int64 iOfst );
int quotaWrite( sqlite3_file *pConn, const void *pBuf, int iAmt, sqlite3_int64 iOfst );
int vfstraceWrite(sqlite3_file*,const void*,int iAmt, sqlite3_int64);
int unixWrite(sqlite3_file *id, const void *pBuf, int amt, sqlite3_int64 offset);

// =============== xsnprintf ===============
// xsnprintf function pointer signatures (extern)
static int xsnprintf_signatures[1][4] = {0,};

// xsnprintf function enumeration
typedef enum {
    xsnprintf_sqlite3_set_authorizer_enum = 0
} xsnprintf_enum;

// xsnprintf signature initialization function
void init_xsnprintf_signatures(void);
// xsnprintf function declarations
int sqlite3_set_authorizer( sqlite3*, int (*xAuth)(void*,int,const char*,const char*,const char*,const char*), void *pUserData );

// Global initialization function
static int signatures_initialized = 0;
void init_all_fp_signatures(void);

#endif /* SQLITE_FP_SIGNATURE_HEADER_H */
