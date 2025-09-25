// Auto-generated Coccinelle script for function pointer to ID conversion
// 
// This script:
// 1. Uses Python to identify structs with function pointers
// 2. Uses Coccinelle to transform specific structs
// 3. Extracts function pointer assignments with Coccinelle
// 4. Saves results to fpName/ and fpNameDecl/ directories
//
// Usage: spatch --sp-file convert_fp.cocci --dir <source_directory> --in-place

@initialize:python@
@@
print(">>> Starting function pointer to ID conversion")
print(">>> Using hybrid Python + Coccinelle approach")

# Clean up any existing temporary files
import os
for temp_file in ["fp_assignments.txt", "function_definitions.txt", "function_declarations.txt"]:
    if os.path.exists(temp_file):
        os.remove(temp_file)

// ===== STRUCT TRANSFORMATIONS =====\n// Struct: sqlite3_io_methods\n
@transform_sqlite3_io_methods@
identifier S = {sqlite3_io_methods};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: sqlite3_vfs\n
@transform_sqlite3_vfs@
identifier S = {sqlite3_vfs};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: sqlite3_mem_methods\n
@transform_sqlite3_mem_methods@
identifier S = {sqlite3_mem_methods};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: sqlite3_module\n
@transform_sqlite3_module@
identifier S = {sqlite3_module};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: sqlite3_mutex_methods\n
@transform_sqlite3_mutex_methods@
identifier S = {sqlite3_mutex_methods};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: sqlite3_pcache_methods2\n
@transform_sqlite3_pcache_methods2@
identifier S = {sqlite3_pcache_methods2};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: sqlite3_pcache_methods\n
@transform_sqlite3_pcache_methods@
identifier S = {sqlite3_pcache_methods};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: sqlite3_rtree_geometry\n
@transform_sqlite3_rtree_geometry@
identifier S = {sqlite3_rtree_geometry};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: sqlite3_rtree_query_info\n
@transform_sqlite3_rtree_query_info@
identifier S = {sqlite3_rtree_query_info};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: Fts5ExtensionApi\n
@transform_Fts5ExtensionApi@
identifier S = {Fts5ExtensionApi};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: fts5_tokenizer_v2\n
@transform_fts5_tokenizer_v2@
identifier S = {fts5_tokenizer_v2};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: fts5_tokenizer\n
@transform_fts5_tokenizer@
identifier S = {fts5_tokenizer};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: fts5_api\n
@transform_fts5_api@
identifier S = {fts5_api};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: BusyHandler\n
@transform_BusyHandler@
identifier S = {BusyHandler};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: sqlite3\n
@transform_sqlite3@
identifier S = {sqlite3};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: FuncDef\n
@transform_FuncDef@
identifier S = {FuncDef};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: FuncDestructor\n
@transform_FuncDestructor@
identifier S = {FuncDestructor};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: Module\n
@transform_Module@
identifier S = {Module};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: CollSeq\n
@transform_CollSeq@
identifier S = {CollSeq};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: ParseCleanup\n
@transform_ParseCleanup@
identifier S = {ParseCleanup};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: Sqlite3Config\n
@transform_Sqlite3Config@
identifier S = {Sqlite3Config};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: Walker\n
@transform_Walker@
identifier S = {Walker};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: DbClientData\n
@transform_DbClientData@
identifier S = {DbClientData};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: sqlite3_value\n
@transform_sqlite3_value@
identifier S = {sqlite3_value};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: AuxData\n
@transform_AuxData@
identifier S = {AuxData};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: BenignMallocHooks\n
@transform_BenignMallocHooks@
identifier S = {BenignMallocHooks};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: mem\n
@transform_mem@
identifier S = {mem};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: SQLiteThread\n
@transform_SQLiteThread@
identifier S = {SQLiteThread};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: sqlite3_kvvfs_methods\n
@transform_sqlite3_kvvfs_methods@
identifier S = {sqlite3_kvvfs_methods};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: PCache\n
@transform_PCache@
identifier S = {PCache};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: Pager\n
@transform_Pager@
identifier S = {Pager};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: MemPage\n
@transform_MemPage@
identifier S = {MemPage};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: BtShared\n
@transform_BtShared@
identifier S = {BtShared};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: sqlite3_api_routines\n
@transform_sqlite3_api_routines@
identifier S = {sqlite3_api_routines};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: sqlite3_tokenizer_module\n
@transform_sqlite3_tokenizer_module@
identifier S = {sqlite3_tokenizer_module};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: Overloaded\n
@transform_Overloaded@
identifier S = {Overloaded};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: RtreeConstraint\n
@transform_RtreeConstraint@
identifier S = {RtreeConstraint};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: RtreeGeomCallback\n
@transform_RtreeGeomCallback@
identifier S = {RtreeGeomCallback};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: aFunc\n
@transform_aFunc@
identifier S = {aFunc};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: aAgg\n
@transform_aAgg@
identifier S = {aAgg};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: IcuScalar\n
@transform_IcuScalar@
identifier S = {IcuScalar};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: sqlite3rbu\n
@transform_sqlite3rbu@
identifier S = {sqlite3rbu};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: SessionHook\n
@transform_SessionHook@
identifier S = {SessionHook};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: sqlite3_session\n
@transform_sqlite3_session@
identifier S = {sqlite3_session};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: SessionInput\n
@transform_SessionInput@
identifier S = {SessionInput};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: Builtin\n
@transform_Builtin@
identifier S = {Builtin};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: Fts5ExprNode\n
@transform_Fts5ExprNode@
identifier S = {Fts5ExprNode};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: Fts5ExprFunc\n
@transform_Fts5ExprFunc@
identifier S = {Fts5ExprFunc};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: Fts5SegIter\n
@transform_Fts5SegIter@
identifier S = {Fts5SegIter};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: Fts5Iter\n
@transform_Fts5Iter@
identifier S = {Fts5Iter};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: PrefixSetupCtx\n
@transform_PrefixSetupCtx@
identifier S = {PrefixSetupCtx};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: Fts5Auxiliary\n
@transform_Fts5Auxiliary@
identifier S = {Fts5Auxiliary};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: Fts5TokenizerModule\n
@transform_Fts5TokenizerModule@
identifier S = {Fts5TokenizerModule};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: Fts5Auxdata\n
@transform_Fts5Auxdata@
identifier S = {Fts5Auxdata};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: PorterContext\n
@transform_PorterContext@
identifier S = {PorterContext};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: PorterRule\n
@transform_PorterRule@
identifier S = {PorterRule};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: ReCompiled\n
@transform_ReCompiled@
identifier S = {ReCompiled};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: vfstrace_info\n
@transform_vfstrace_info@
identifier S = {vfstrace_info};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: sqlite3_recover\n
@transform_sqlite3_recover@
identifier S = {sqlite3_recover};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: Func\n
@transform_Func@
identifier S = {Func};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: Jim_HashTableType\n
@transform_Jim_HashTableType@
identifier S = {Jim_HashTableType};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: Jim_Interp\n
@transform_Jim_Interp@
identifier S = {Jim_Interp};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: JimAioFopsType\n
@transform_JimAioFopsType@
identifier S = {JimAioFopsType};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: lsort_info\n
@transform_lsort_info@
identifier S = {lsort_info};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: Jim_ExprOperator\n
@transform_Jim_ExprOperator@
identifier S = {Jim_ExprOperator};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: quotaGroup\n
@transform_quotaGroup@
identifier S = {quotaGroup};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: sqlite3_intarray\n
@transform_sqlite3_intarray@
identifier S = {sqlite3_intarray};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: aFuncs\n
@transform_aFuncs@
identifier S = {aFuncs};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: aExtension\n
@transform_aExtension@
identifier S = {aExtension};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: TclCmd\n
@transform_TclCmd@
identifier S = {TclCmd};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: Thread\n
@transform_Thread@
identifier S = {Thread};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: SuperlockBusy\n
@transform_SuperlockBusy@
identifier S = {SuperlockBusy};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: WasmTestStruct\n
@transform_WasmTestStruct@
identifier S = {WasmTestStruct};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: vtshim_aux\n
@transform_vtshim_aux@
identifier S = {vtshim_aux};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: DState\n
@transform_DState@
identifier S = {DState};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: carray_bind\n
@transform_carray_bind@
identifier S = {carray_bind};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: F5tTokenizerContext\n
@transform_F5tTokenizerContext@
identifier S = {F5tTokenizerContext};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: CallbackCtx\n
@transform_CallbackCtx@
identifier S = {CallbackCtx};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: OriginTextCb\n
@transform_OriginTextCb@
identifier S = {OriginTextCb};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: Stress2Ctx\n
@transform_Stress2Ctx@
identifier S = {Stress2Ctx};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: Stress2Task\n
@transform_Stress2Task@
identifier S = {Stress2Task};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};
// Struct: ThreadTest\n
@transform_ThreadTest@
identifier S = {ThreadTest};
type T;
identifier FP_NAME;
parameter list PARAMS;
@@
struct S {
- T (*FP_NAME)(PARAMS);
+ int FP_NAME_signature[4];
};

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xthreadsafe@
expression E;
identifier FP_NAME = xthreadsafe;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xthreadsafe@
identifier FP_NAME = xthreadsafe;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xthreadsafe@
fp_name << find_struct_fp_assignment_xthreadsafe.FP_NAME;
func_name << find_struct_fp_assignment_xthreadsafe.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xthreadsafe.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xthreadsafe@
fp_name << find_init_fp_assignment_xthreadsafe.FP_NAME;
func_name << find_init_fp_assignment_xthreadsafe.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xthreadsafe.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_db_filename@
expression E;
identifier FP_NAME = db_filename;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_db_filename@
identifier FP_NAME = db_filename;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_db_filename@
fp_name << find_struct_fp_assignment_db_filename.FP_NAME;
func_name << find_struct_fp_assignment_db_filename.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/db_filename.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_db_filename@
fp_name << find_init_fp_assignment_db_filename.FP_NAME;
func_name << find_init_fp_assignment_db_filename.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/db_filename.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xCollNeeded@
expression E;
identifier FP_NAME = xCollNeeded;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xCollNeeded@
identifier FP_NAME = xCollNeeded;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xCollNeeded@
fp_name << find_struct_fp_assignment_xCollNeeded.FP_NAME;
func_name << find_struct_fp_assignment_xCollNeeded.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCollNeeded.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xCollNeeded@
fp_name << find_init_fp_assignment_xCollNeeded.FP_NAME;
func_name << find_init_fp_assignment_xCollNeeded.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCollNeeded.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xSleep@
expression E;
identifier FP_NAME = xSleep;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xSleep@
identifier FP_NAME = xSleep;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xSleep@
fp_name << find_struct_fp_assignment_xSleep.FP_NAME;
func_name << find_struct_fp_assignment_xSleep.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSleep.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xSleep@
fp_name << find_init_fp_assignment_xSleep.FP_NAME;
func_name << find_init_fp_assignment_xSleep.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSleep.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_vtab_distinct@
expression E;
identifier FP_NAME = vtab_distinct;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_vtab_distinct@
identifier FP_NAME = vtab_distinct;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_vtab_distinct@
fp_name << find_struct_fp_assignment_vtab_distinct.FP_NAME;
func_name << find_struct_fp_assignment_vtab_distinct.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vtab_distinct.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_vtab_distinct@
fp_name << find_init_fp_assignment_vtab_distinct.FP_NAME;
func_name << find_init_fp_assignment_vtab_distinct.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vtab_distinct.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xTask@
expression E;
identifier FP_NAME = xTask;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xTask@
identifier FP_NAME = xTask;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xTask@
fp_name << find_struct_fp_assignment_xTask.FP_NAME;
func_name << find_struct_fp_assignment_xTask.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xTask.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xTask@
fp_name << find_init_fp_assignment_xTask.FP_NAME;
func_name << find_init_fp_assignment_xTask.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xTask.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_bind_parameter_count@
expression E;
identifier FP_NAME = bind_parameter_count;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_bind_parameter_count@
identifier FP_NAME = bind_parameter_count;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_bind_parameter_count@
fp_name << find_struct_fp_assignment_bind_parameter_count.FP_NAME;
func_name << find_struct_fp_assignment_bind_parameter_count.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/bind_parameter_count.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_bind_parameter_count@
fp_name << find_init_fp_assignment_bind_parameter_count.FP_NAME;
func_name << find_init_fp_assignment_bind_parameter_count.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/bind_parameter_count.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xMutexHeld@
expression E;
identifier FP_NAME = xMutexHeld;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xMutexHeld@
identifier FP_NAME = xMutexHeld;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xMutexHeld@
fp_name << find_struct_fp_assignment_xMutexHeld.FP_NAME;
func_name << find_struct_fp_assignment_xMutexHeld.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xMutexHeld.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xMutexHeld@
fp_name << find_init_fp_assignment_xMutexHeld.FP_NAME;
func_name << find_init_fp_assignment_xMutexHeld.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xMutexHeld.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xShmLock@
expression E;
identifier FP_NAME = xShmLock;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xShmLock@
identifier FP_NAME = xShmLock;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xShmLock@
fp_name << find_struct_fp_assignment_xShmLock.FP_NAME;
func_name << find_struct_fp_assignment_xShmLock.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xShmLock.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xShmLock@
fp_name << find_init_fp_assignment_xShmLock.FP_NAME;
func_name << find_init_fp_assignment_xShmLock.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xShmLock.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xBusyHandler@
expression E;
identifier FP_NAME = xBusyHandler;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xBusyHandler@
identifier FP_NAME = xBusyHandler;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xBusyHandler@
fp_name << find_struct_fp_assignment_xBusyHandler.FP_NAME;
func_name << find_struct_fp_assignment_xBusyHandler.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xBusyHandler.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xBusyHandler@
fp_name << find_init_fp_assignment_xBusyHandler.FP_NAME;
func_name << find_init_fp_assignment_xBusyHandler.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xBusyHandler.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_txn_state@
expression E;
identifier FP_NAME = txn_state;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_txn_state@
identifier FP_NAME = txn_state;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_txn_state@
fp_name << find_struct_fp_assignment_txn_state.FP_NAME;
func_name << find_struct_fp_assignment_txn_state.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/txn_state.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_txn_state@
fp_name << find_init_fp_assignment_txn_state.FP_NAME;
func_name << find_init_fp_assignment_txn_state.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/txn_state.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_column_value@
expression E;
identifier FP_NAME = column_value;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_column_value@
identifier FP_NAME = column_value;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_column_value@
fp_name << find_struct_fp_assignment_column_value.FP_NAME;
func_name << find_struct_fp_assignment_column_value.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_value.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_column_value@
fp_name << find_init_fp_assignment_column_value.FP_NAME;
func_name << find_init_fp_assignment_column_value.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_value.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xColumnTotalSize@
expression E;
identifier FP_NAME = xColumnTotalSize;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xColumnTotalSize@
identifier FP_NAME = xColumnTotalSize;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xColumnTotalSize@
fp_name << find_struct_fp_assignment_xColumnTotalSize.FP_NAME;
func_name << find_struct_fp_assignment_xColumnTotalSize.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xColumnTotalSize.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xColumnTotalSize@
fp_name << find_init_fp_assignment_xColumnTotalSize.FP_NAME;
func_name << find_init_fp_assignment_xColumnTotalSize.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xColumnTotalSize.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_close@
expression E;
identifier FP_NAME = close;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_close@
identifier FP_NAME = close;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_close@
fp_name << find_struct_fp_assignment_close.FP_NAME;
func_name << find_struct_fp_assignment_close.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/close.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_close@
fp_name << find_init_fp_assignment_close.FP_NAME;
func_name << find_init_fp_assignment_close.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/close.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_bind_int@
expression E;
identifier FP_NAME = bind_int;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_bind_int@
identifier FP_NAME = bind_int;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_bind_int@
fp_name << find_struct_fp_assignment_bind_int.FP_NAME;
func_name << find_struct_fp_assignment_bind_int.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/bind_int.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_bind_int@
fp_name << find_init_fp_assignment_bind_int.FP_NAME;
func_name << find_init_fp_assignment_bind_int.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/bind_int.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_wal_autocheckpoint@
expression E;
identifier FP_NAME = wal_autocheckpoint;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_wal_autocheckpoint@
identifier FP_NAME = wal_autocheckpoint;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_wal_autocheckpoint@
fp_name << find_struct_fp_assignment_wal_autocheckpoint.FP_NAME;
func_name << find_struct_fp_assignment_wal_autocheckpoint.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/wal_autocheckpoint.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_wal_autocheckpoint@
fp_name << find_init_fp_assignment_wal_autocheckpoint.FP_NAME;
func_name << find_init_fp_assignment_wal_autocheckpoint.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/wal_autocheckpoint.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_get_auxdata@
expression E;
identifier FP_NAME = get_auxdata;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_get_auxdata@
identifier FP_NAME = get_auxdata;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_get_auxdata@
fp_name << find_struct_fp_assignment_get_auxdata.FP_NAME;
func_name << find_struct_fp_assignment_get_auxdata.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/get_auxdata.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_get_auxdata@
fp_name << find_init_fp_assignment_get_auxdata.FP_NAME;
func_name << find_init_fp_assignment_get_auxdata.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/get_auxdata.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xDlClose@
expression E;
identifier FP_NAME = xDlClose;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xDlClose@
identifier FP_NAME = xDlClose;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xDlClose@
fp_name << find_struct_fp_assignment_xDlClose.FP_NAME;
func_name << find_struct_fp_assignment_xDlClose.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDlClose.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xDlClose@
fp_name << find_init_fp_assignment_xDlClose.FP_NAME;
func_name << find_init_fp_assignment_xDlClose.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDlClose.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xInst@
expression E;
identifier FP_NAME = xInst;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xInst@
identifier FP_NAME = xInst;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xInst@
fp_name << find_struct_fp_assignment_xInst.FP_NAME;
func_name << find_struct_fp_assignment_xInst.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xInst.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xInst@
fp_name << find_init_fp_assignment_xInst.FP_NAME;
func_name << find_init_fp_assignment_xInst.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xInst.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_str_errcode@
expression E;
identifier FP_NAME = str_errcode;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_str_errcode@
identifier FP_NAME = str_errcode;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_str_errcode@
fp_name << find_struct_fp_assignment_str_errcode.FP_NAME;
func_name << find_struct_fp_assignment_str_errcode.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/str_errcode.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_str_errcode@
fp_name << find_init_fp_assignment_str_errcode.FP_NAME;
func_name << find_init_fp_assignment_str_errcode.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/str_errcode.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_column_double@
expression E;
identifier FP_NAME = column_double;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_column_double@
identifier FP_NAME = column_double;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_column_double@
fp_name << find_struct_fp_assignment_column_double.FP_NAME;
func_name << find_struct_fp_assignment_column_double.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_double.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_column_double@
fp_name << find_init_fp_assignment_column_double.FP_NAME;
func_name << find_init_fp_assignment_column_double.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_double.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_backup_remaining@
expression E;
identifier FP_NAME = backup_remaining;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_backup_remaining@
identifier FP_NAME = backup_remaining;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_backup_remaining@
fp_name << find_struct_fp_assignment_backup_remaining.FP_NAME;
func_name << find_struct_fp_assignment_backup_remaining.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/backup_remaining.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_backup_remaining@
fp_name << find_init_fp_assignment_backup_remaining.FP_NAME;
func_name << find_init_fp_assignment_backup_remaining.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/backup_remaining.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_writer@
expression E;
identifier FP_NAME = writer;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_writer@
identifier FP_NAME = writer;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_writer@
fp_name << find_struct_fp_assignment_writer.FP_NAME;
func_name << find_struct_fp_assignment_writer.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/writer.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_writer@
fp_name << find_init_fp_assignment_writer.FP_NAME;
func_name << find_init_fp_assignment_writer.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/writer.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xRename@
expression E;
identifier FP_NAME = xRename;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xRename@
identifier FP_NAME = xRename;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xRename@
fp_name << find_struct_fp_assignment_xRename.FP_NAME;
func_name << find_struct_fp_assignment_xRename.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRename.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xRename@
fp_name << find_init_fp_assignment_xRename.FP_NAME;
func_name << find_init_fp_assignment_xRename.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRename.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xRollbackCallback@
expression E;
identifier FP_NAME = xRollbackCallback;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xRollbackCallback@
identifier FP_NAME = xRollbackCallback;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xRollbackCallback@
fp_name << find_struct_fp_assignment_xRollbackCallback.FP_NAME;
func_name << find_struct_fp_assignment_xRollbackCallback.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRollbackCallback.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xRollbackCallback@
fp_name << find_init_fp_assignment_xRollbackCallback.FP_NAME;
func_name << find_init_fp_assignment_xRollbackCallback.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRollbackCallback.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_aggregate_context@
expression E;
identifier FP_NAME = aggregate_context;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_aggregate_context@
identifier FP_NAME = aggregate_context;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_aggregate_context@
fp_name << find_struct_fp_assignment_aggregate_context.FP_NAME;
func_name << find_struct_fp_assignment_aggregate_context.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/aggregate_context.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_aggregate_context@
fp_name << find_init_fp_assignment_aggregate_context.FP_NAME;
func_name << find_init_fp_assignment_aggregate_context.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/aggregate_context.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_column_name@
expression E;
identifier FP_NAME = column_name;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_column_name@
identifier FP_NAME = column_name;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_column_name@
fp_name << find_struct_fp_assignment_column_name.FP_NAME;
func_name << find_struct_fp_assignment_column_name.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_name.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_column_name@
fp_name << find_init_fp_assignment_column_name.FP_NAME;
func_name << find_init_fp_assignment_column_name.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_name.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_mutex_free@
expression E;
identifier FP_NAME = mutex_free;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_mutex_free@
identifier FP_NAME = mutex_free;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_mutex_free@
fp_name << find_struct_fp_assignment_mutex_free.FP_NAME;
func_name << find_struct_fp_assignment_mutex_free.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/mutex_free.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_mutex_free@
fp_name << find_init_fp_assignment_mutex_free.FP_NAME;
func_name << find_init_fp_assignment_mutex_free.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/mutex_free.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_busy_timeout@
expression E;
identifier FP_NAME = busy_timeout;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_busy_timeout@
identifier FP_NAME = busy_timeout;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_busy_timeout@
fp_name << find_struct_fp_assignment_busy_timeout.FP_NAME;
func_name << find_struct_fp_assignment_busy_timeout.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/busy_timeout.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_busy_timeout@
fp_name << find_init_fp_assignment_busy_timeout.FP_NAME;
func_name << find_init_fp_assignment_busy_timeout.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/busy_timeout.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_column_type@
expression E;
identifier FP_NAME = column_type;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_column_type@
identifier FP_NAME = column_type;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_column_type@
fp_name << find_struct_fp_assignment_column_type.FP_NAME;
func_name << find_struct_fp_assignment_column_type.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_type.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_column_type@
fp_name << find_init_fp_assignment_column_type.FP_NAME;
func_name << find_init_fp_assignment_column_type.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_type.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xFullPathname@
expression E;
identifier FP_NAME = xFullPathname;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xFullPathname@
identifier FP_NAME = xFullPathname;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xFullPathname@
fp_name << find_struct_fp_assignment_xFullPathname.FP_NAME;
func_name << find_struct_fp_assignment_xFullPathname.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFullPathname.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xFullPathname@
fp_name << find_init_fp_assignment_xFullPathname.FP_NAME;
func_name << find_init_fp_assignment_xFullPathname.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFullPathname.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_get_clientdata@
expression E;
identifier FP_NAME = get_clientdata;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_get_clientdata@
identifier FP_NAME = get_clientdata;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_get_clientdata@
fp_name << find_struct_fp_assignment_get_clientdata.FP_NAME;
func_name << find_struct_fp_assignment_get_clientdata.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/get_clientdata.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_get_clientdata@
fp_name << find_init_fp_assignment_get_clientdata.FP_NAME;
func_name << find_init_fp_assignment_get_clientdata.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/get_clientdata.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_mutex_leave@
expression E;
identifier FP_NAME = mutex_leave;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_mutex_leave@
identifier FP_NAME = mutex_leave;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_mutex_leave@
fp_name << find_struct_fp_assignment_mutex_leave.FP_NAME;
func_name << find_struct_fp_assignment_mutex_leave.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/mutex_leave.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_mutex_leave@
fp_name << find_init_fp_assignment_mutex_leave.FP_NAME;
func_name << find_init_fp_assignment_mutex_leave.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/mutex_leave.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_mutex_enter@
expression E;
identifier FP_NAME = mutex_enter;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_mutex_enter@
identifier FP_NAME = mutex_enter;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_mutex_enter@
fp_name << find_struct_fp_assignment_mutex_enter.FP_NAME;
func_name << find_struct_fp_assignment_mutex_enter.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/mutex_enter.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_mutex_enter@
fp_name << find_init_fp_assignment_mutex_enter.FP_NAME;
func_name << find_init_fp_assignment_mutex_enter.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/mutex_enter.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_realloc64@
expression E;
identifier FP_NAME = realloc64;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_realloc64@
identifier FP_NAME = realloc64;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_realloc64@
fp_name << find_struct_fp_assignment_realloc64.FP_NAME;
func_name << find_struct_fp_assignment_realloc64.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/realloc64.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_realloc64@
fp_name << find_init_fp_assignment_realloc64.FP_NAME;
func_name << find_init_fp_assignment_realloc64.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/realloc64.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_str_reset@
expression E;
identifier FP_NAME = str_reset;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_str_reset@
identifier FP_NAME = str_reset;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_str_reset@
fp_name << find_struct_fp_assignment_str_reset.FP_NAME;
func_name << find_struct_fp_assignment_str_reset.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/str_reset.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_str_reset@
fp_name << find_init_fp_assignment_str_reset.FP_NAME;
func_name << find_init_fp_assignment_str_reset.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/str_reset.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xCreate@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xCreate@
identifier FP_NAME = xCreate;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xCreate@
fp_name << find_struct_fp_assignment_xCreate.FP_NAME;
func_name << find_struct_fp_assignment_xCreate.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCreate.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xCreate@
fp_name << find_init_fp_assignment_xCreate.FP_NAME;
func_name << find_init_fp_assignment_xCreate.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCreate.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_column_text16@
expression E;
identifier FP_NAME = column_text16;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_column_text16@
identifier FP_NAME = column_text16;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_column_text16@
fp_name << find_struct_fp_assignment_column_text16.FP_NAME;
func_name << find_struct_fp_assignment_column_text16.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_text16.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_column_text16@
fp_name << find_init_fp_assignment_column_text16.FP_NAME;
func_name << find_init_fp_assignment_column_text16.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_text16.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xCachesize@
expression E;
identifier FP_NAME = xCachesize;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xCachesize@
identifier FP_NAME = xCachesize;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xCachesize@
fp_name << find_struct_fp_assignment_xCachesize.FP_NAME;
func_name << find_struct_fp_assignment_xCachesize.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCachesize.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xCachesize@
fp_name << find_init_fp_assignment_xCachesize.FP_NAME;
func_name << find_init_fp_assignment_xCachesize.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCachesize.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xLog@
expression E;
identifier FP_NAME = xLog;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xLog@
identifier FP_NAME = xLog;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xLog@
fp_name << find_struct_fp_assignment_xLog.FP_NAME;
func_name << find_struct_fp_assignment_xLog.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xLog.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xLog@
fp_name << find_init_fp_assignment_xLog.FP_NAME;
func_name << find_init_fp_assignment_xLog.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xLog.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xShrink@
expression E;
identifier FP_NAME = xShrink;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xShrink@
identifier FP_NAME = xShrink;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xShrink@
fp_name << find_struct_fp_assignment_xShrink.FP_NAME;
func_name << find_struct_fp_assignment_xShrink.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xShrink.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xShrink@
fp_name << find_init_fp_assignment_xShrink.FP_NAME;
func_name << find_init_fp_assignment_xShrink.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xShrink.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xFunc@
expression E;
identifier FP_NAME = xFunc;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xFunc@
identifier FP_NAME = xFunc;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xFunc@
fp_name << find_struct_fp_assignment_xFunc.FP_NAME;
func_name << find_struct_fp_assignment_xFunc.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFunc.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xFunc@
fp_name << find_init_fp_assignment_xFunc.FP_NAME;
func_name << find_init_fp_assignment_xFunc.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFunc.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_db_config@
expression E;
identifier FP_NAME = db_config;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_db_config@
identifier FP_NAME = db_config;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_db_config@
fp_name << find_struct_fp_assignment_db_config.FP_NAME;
func_name << find_struct_fp_assignment_db_config.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/db_config.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_db_config@
fp_name << find_init_fp_assignment_db_config.FP_NAME;
func_name << find_init_fp_assignment_db_config.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/db_config.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_release_memory@
expression E;
identifier FP_NAME = release_memory;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_release_memory@
identifier FP_NAME = release_memory;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_release_memory@
fp_name << find_struct_fp_assignment_release_memory.FP_NAME;
func_name << find_struct_fp_assignment_release_memory.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/release_memory.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_release_memory@
fp_name << find_init_fp_assignment_release_memory.FP_NAME;
func_name << find_init_fp_assignment_release_memory.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/release_memory.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_malloc@
expression E;
identifier FP_NAME = malloc;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_malloc@
identifier FP_NAME = malloc;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_malloc@
fp_name << find_struct_fp_assignment_malloc.FP_NAME;
func_name << find_struct_fp_assignment_malloc.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/malloc.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_malloc@
fp_name << find_init_fp_assignment_malloc.FP_NAME;
func_name << find_init_fp_assignment_malloc.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/malloc.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_backup_finish@
expression E;
identifier FP_NAME = backup_finish;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_backup_finish@
identifier FP_NAME = backup_finish;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_backup_finish@
fp_name << find_struct_fp_assignment_backup_finish.FP_NAME;
func_name << find_struct_fp_assignment_backup_finish.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/backup_finish.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_backup_finish@
fp_name << find_init_fp_assignment_backup_finish.FP_NAME;
func_name << find_init_fp_assignment_backup_finish.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/backup_finish.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_mutex_alloc@
expression E;
identifier FP_NAME = mutex_alloc;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_mutex_alloc@
identifier FP_NAME = mutex_alloc;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_mutex_alloc@
fp_name << find_struct_fp_assignment_mutex_alloc.FP_NAME;
func_name << find_struct_fp_assignment_mutex_alloc.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/mutex_alloc.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_mutex_alloc@
fp_name << find_init_fp_assignment_mutex_alloc.FP_NAME;
func_name << find_init_fp_assignment_mutex_alloc.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/mutex_alloc.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_db_readonly@
expression E;
identifier FP_NAME = db_readonly;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_db_readonly@
identifier FP_NAME = db_readonly;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_db_readonly@
fp_name << find_struct_fp_assignment_db_readonly.FP_NAME;
func_name << find_struct_fp_assignment_db_readonly.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/db_readonly.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_db_readonly@
fp_name << find_init_fp_assignment_db_readonly.FP_NAME;
func_name << find_init_fp_assignment_db_readonly.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/db_readonly.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xAutovacPages@
expression E;
identifier FP_NAME = xAutovacPages;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xAutovacPages@
identifier FP_NAME = xAutovacPages;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xAutovacPages@
fp_name << find_struct_fp_assignment_xAutovacPages.FP_NAME;
func_name << find_struct_fp_assignment_xAutovacPages.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xAutovacPages.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xAutovacPages@
fp_name << find_init_fp_assignment_xAutovacPages.FP_NAME;
func_name << find_init_fp_assignment_xAutovacPages.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xAutovacPages.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xsnprintf@
expression E;
identifier FP_NAME = xsnprintf;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xsnprintf@
identifier FP_NAME = xsnprintf;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xsnprintf@
fp_name << find_struct_fp_assignment_xsnprintf.FP_NAME;
func_name << find_struct_fp_assignment_xsnprintf.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xsnprintf.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xsnprintf@
fp_name << find_init_fp_assignment_xsnprintf.FP_NAME;
func_name << find_init_fp_assignment_xsnprintf.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xsnprintf.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_changes64@
expression E;
identifier FP_NAME = changes64;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_changes64@
identifier FP_NAME = changes64;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_changes64@
fp_name << find_struct_fp_assignment_changes64.FP_NAME;
func_name << find_struct_fp_assignment_changes64.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/changes64.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_changes64@
fp_name << find_init_fp_assignment_changes64.FP_NAME;
func_name << find_init_fp_assignment_changes64.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/changes64.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_prepare_v2@
expression E;
identifier FP_NAME = prepare_v2;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_prepare_v2@
identifier FP_NAME = prepare_v2;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_prepare_v2@
fp_name << find_struct_fp_assignment_prepare_v2.FP_NAME;
func_name << find_struct_fp_assignment_prepare_v2.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/prepare_v2.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_prepare_v2@
fp_name << find_init_fp_assignment_prepare_v2.FP_NAME;
func_name << find_init_fp_assignment_prepare_v2.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/prepare_v2.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_column_decltype@
expression E;
identifier FP_NAME = column_decltype;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_column_decltype@
identifier FP_NAME = column_decltype;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_column_decltype@
fp_name << find_struct_fp_assignment_column_decltype.FP_NAME;
func_name << find_struct_fp_assignment_column_decltype.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_decltype.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_column_decltype@
fp_name << find_init_fp_assignment_column_decltype.FP_NAME;
func_name << find_init_fp_assignment_column_decltype.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_decltype.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_open@
expression E;
identifier FP_NAME = open;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_open@
identifier FP_NAME = open;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_open@
fp_name << find_struct_fp_assignment_open.FP_NAME;
func_name << find_struct_fp_assignment_open.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/open.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_open@
fp_name << find_init_fp_assignment_open.FP_NAME;
func_name << find_init_fp_assignment_open.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/open.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xBusy@
expression E;
identifier FP_NAME = xBusy;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xBusy@
identifier FP_NAME = xBusy;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xBusy@
fp_name << find_struct_fp_assignment_xBusy.FP_NAME;
func_name << find_struct_fp_assignment_xBusy.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xBusy.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xBusy@
fp_name << find_init_fp_assignment_xBusy.FP_NAME;
func_name << find_init_fp_assignment_xBusy.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xBusy.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xBegin@
expression E;
identifier FP_NAME = xBegin;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xBegin@
identifier FP_NAME = xBegin;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xBegin@
fp_name << find_struct_fp_assignment_xBegin.FP_NAME;
func_name << find_struct_fp_assignment_xBegin.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xBegin.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xBegin@
fp_name << find_init_fp_assignment_xBegin.FP_NAME;
func_name << find_init_fp_assignment_xBegin.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xBegin.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_complete@
expression E;
identifier FP_NAME = complete;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_complete@
identifier FP_NAME = complete;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_complete@
fp_name << find_struct_fp_assignment_complete.FP_NAME;
func_name << find_struct_fp_assignment_complete.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/complete.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_complete@
fp_name << find_init_fp_assignment_complete.FP_NAME;
func_name << find_init_fp_assignment_complete.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/complete.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_compileoption_get@
expression E;
identifier FP_NAME = compileoption_get;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_compileoption_get@
identifier FP_NAME = compileoption_get;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_compileoption_get@
fp_name << find_struct_fp_assignment_compileoption_get.FP_NAME;
func_name << find_struct_fp_assignment_compileoption_get.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/compileoption_get.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_compileoption_get@
fp_name << find_init_fp_assignment_compileoption_get.FP_NAME;
func_name << find_init_fp_assignment_compileoption_get.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/compileoption_get.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xOld@
expression E;
identifier FP_NAME = xOld;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xOld@
identifier FP_NAME = xOld;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xOld@
fp_name << find_struct_fp_assignment_xOld.FP_NAME;
func_name << find_struct_fp_assignment_xOld.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xOld.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xOld@
fp_name << find_init_fp_assignment_xOld.FP_NAME;
func_name << find_init_fp_assignment_xOld.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xOld.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_vfs_register@
expression E;
identifier FP_NAME = vfs_register;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_vfs_register@
identifier FP_NAME = vfs_register;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_vfs_register@
fp_name << find_struct_fp_assignment_vfs_register.FP_NAME;
func_name << find_struct_fp_assignment_vfs_register.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vfs_register.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_vfs_register@
fp_name << find_init_fp_assignment_vfs_register.FP_NAME;
func_name << find_init_fp_assignment_vfs_register.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vfs_register.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_db_status@
expression E;
identifier FP_NAME = db_status;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_db_status@
identifier FP_NAME = db_status;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_db_status@
fp_name << find_struct_fp_assignment_db_status.FP_NAME;
func_name << find_struct_fp_assignment_db_status.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/db_status.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_db_status@
fp_name << find_init_fp_assignment_db_status.FP_NAME;
func_name << find_init_fp_assignment_db_status.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/db_status.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_blob_write@
expression E;
identifier FP_NAME = blob_write;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_blob_write@
identifier FP_NAME = blob_write;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_blob_write@
fp_name << find_struct_fp_assignment_blob_write.FP_NAME;
func_name << find_struct_fp_assignment_blob_write.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/blob_write.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_blob_write@
fp_name << find_init_fp_assignment_blob_write.FP_NAME;
func_name << find_init_fp_assignment_blob_write.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/blob_write.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xCount@
expression E;
identifier FP_NAME = xCount;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xCount@
identifier FP_NAME = xCount;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xCount@
fp_name << find_struct_fp_assignment_xCount.FP_NAME;
func_name << find_struct_fp_assignment_xCount.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCount.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xCount@
fp_name << find_init_fp_assignment_xCount.FP_NAME;
func_name << find_init_fp_assignment_xCount.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCount.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xChildDestroy@
expression E;
identifier FP_NAME = xChildDestroy;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xChildDestroy@
identifier FP_NAME = xChildDestroy;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xChildDestroy@
fp_name << find_struct_fp_assignment_xChildDestroy.FP_NAME;
func_name << find_struct_fp_assignment_xChildDestroy.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xChildDestroy.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xChildDestroy@
fp_name << find_init_fp_assignment_xChildDestroy.FP_NAME;
func_name << find_init_fp_assignment_xChildDestroy.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xChildDestroy.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_strnicmp@
expression E;
identifier FP_NAME = strnicmp;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_strnicmp@
identifier FP_NAME = strnicmp;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_strnicmp@
fp_name << find_struct_fp_assignment_strnicmp.FP_NAME;
func_name << find_struct_fp_assignment_strnicmp.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/strnicmp.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_strnicmp@
fp_name << find_init_fp_assignment_strnicmp.FP_NAME;
func_name << find_init_fp_assignment_strnicmp.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/strnicmp.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xOpen@
identifier FP_NAME = xOpen;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xOpen@
fp_name << find_struct_fp_assignment_xOpen.FP_NAME;
func_name << find_struct_fp_assignment_xOpen.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xOpen.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xOpen@
fp_name << find_init_fp_assignment_xOpen.FP_NAME;
func_name << find_init_fp_assignment_xOpen.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xOpen.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xProfile@
expression E;
identifier FP_NAME = xProfile;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xProfile@
identifier FP_NAME = xProfile;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xProfile@
fp_name << find_struct_fp_assignment_xProfile.FP_NAME;
func_name << find_struct_fp_assignment_xProfile.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xProfile.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xProfile@
fp_name << find_init_fp_assignment_xProfile.FP_NAME;
func_name << find_init_fp_assignment_xProfile.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xProfile.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_memory_highwater@
expression E;
identifier FP_NAME = memory_highwater;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_memory_highwater@
identifier FP_NAME = memory_highwater;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_memory_highwater@
fp_name << find_struct_fp_assignment_memory_highwater.FP_NAME;
func_name << find_struct_fp_assignment_memory_highwater.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/memory_highwater.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_memory_highwater@
fp_name << find_init_fp_assignment_memory_highwater.FP_NAME;
func_name << find_init_fp_assignment_memory_highwater.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/memory_highwater.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_malloc64@
expression E;
identifier FP_NAME = malloc64;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_malloc64@
identifier FP_NAME = malloc64;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_malloc64@
fp_name << find_struct_fp_assignment_malloc64.FP_NAME;
func_name << find_struct_fp_assignment_malloc64.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/malloc64.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_malloc64@
fp_name << find_init_fp_assignment_malloc64.FP_NAME;
func_name << find_init_fp_assignment_malloc64.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/malloc64.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xDlError@
expression E;
identifier FP_NAME = xDlError;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xDlError@
identifier FP_NAME = xDlError;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xDlError@
fp_name << find_struct_fp_assignment_xDlError.FP_NAME;
func_name << find_struct_fp_assignment_xDlError.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDlError.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xDlError@
fp_name << find_init_fp_assignment_xDlError.FP_NAME;
func_name << find_init_fp_assignment_xDlError.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDlError.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_set_last_insert_rowid@
expression E;
identifier FP_NAME = set_last_insert_rowid;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_set_last_insert_rowid@
identifier FP_NAME = set_last_insert_rowid;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_set_last_insert_rowid@
fp_name << find_struct_fp_assignment_set_last_insert_rowid.FP_NAME;
func_name << find_struct_fp_assignment_set_last_insert_rowid.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/set_last_insert_rowid.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_set_last_insert_rowid@
fp_name << find_init_fp_assignment_set_last_insert_rowid.FP_NAME;
func_name << find_init_fp_assignment_set_last_insert_rowid.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/set_last_insert_rowid.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_value_dup@
expression E;
identifier FP_NAME = value_dup;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_value_dup@
identifier FP_NAME = value_dup;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_value_dup@
fp_name << find_struct_fp_assignment_value_dup.FP_NAME;
func_name << find_struct_fp_assignment_value_dup.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_dup.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_value_dup@
fp_name << find_init_fp_assignment_value_dup.FP_NAME;
func_name << find_init_fp_assignment_value_dup.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_dup.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xOp@
expression E;
identifier FP_NAME = xOp;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xOp@
identifier FP_NAME = xOp;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xOp@
fp_name << find_struct_fp_assignment_xOp.FP_NAME;
func_name << find_struct_fp_assignment_xOp.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xOp.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xOp@
fp_name << find_init_fp_assignment_xOp.FP_NAME;
func_name << find_init_fp_assignment_xOp.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xOp.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_value_text16@
expression E;
identifier FP_NAME = value_text16;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_value_text16@
identifier FP_NAME = value_text16;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_value_text16@
fp_name << find_struct_fp_assignment_value_text16.FP_NAME;
func_name << find_struct_fp_assignment_value_text16.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_text16.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_value_text16@
fp_name << find_init_fp_assignment_value_text16.FP_NAME;
func_name << find_init_fp_assignment_value_text16.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_text16.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_blob_reopen@
expression E;
identifier FP_NAME = blob_reopen;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_blob_reopen@
identifier FP_NAME = blob_reopen;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_blob_reopen@
fp_name << find_struct_fp_assignment_blob_reopen.FP_NAME;
func_name << find_struct_fp_assignment_blob_reopen.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/blob_reopen.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_blob_reopen@
fp_name << find_init_fp_assignment_blob_reopen.FP_NAME;
func_name << find_init_fp_assignment_blob_reopen.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/blob_reopen.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_column_origin_name16@
expression E;
identifier FP_NAME = column_origin_name16;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_column_origin_name16@
identifier FP_NAME = column_origin_name16;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_column_origin_name16@
fp_name << find_struct_fp_assignment_column_origin_name16.FP_NAME;
func_name << find_struct_fp_assignment_column_origin_name16.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_origin_name16.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_column_origin_name16@
fp_name << find_init_fp_assignment_column_origin_name16.FP_NAME;
func_name << find_init_fp_assignment_column_origin_name16.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_origin_name16.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xLegacy@
expression E;
identifier FP_NAME = xLegacy;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xLegacy@
identifier FP_NAME = xLegacy;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xLegacy@
fp_name << find_struct_fp_assignment_xLegacy.FP_NAME;
func_name << find_struct_fp_assignment_xLegacy.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xLegacy.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xLegacy@
fp_name << find_init_fp_assignment_xLegacy.FP_NAME;
func_name << find_init_fp_assignment_xLegacy.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xLegacy.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_last_insert_rowid@
expression E;
identifier FP_NAME = last_insert_rowid;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_last_insert_rowid@
identifier FP_NAME = last_insert_rowid;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_last_insert_rowid@
fp_name << find_struct_fp_assignment_last_insert_rowid.FP_NAME;
func_name << find_struct_fp_assignment_last_insert_rowid.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/last_insert_rowid.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_last_insert_rowid@
fp_name << find_init_fp_assignment_last_insert_rowid.FP_NAME;
func_name << find_init_fp_assignment_last_insert_rowid.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/last_insert_rowid.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xGetAuxdata@
expression E;
identifier FP_NAME = xGetAuxdata;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xGetAuxdata@
identifier FP_NAME = xGetAuxdata;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xGetAuxdata@
fp_name << find_struct_fp_assignment_xGetAuxdata.FP_NAME;
func_name << find_struct_fp_assignment_xGetAuxdata.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xGetAuxdata.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xGetAuxdata@
fp_name << find_init_fp_assignment_xGetAuxdata.FP_NAME;
func_name << find_init_fp_assignment_xGetAuxdata.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xGetAuxdata.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xDestroy@
expression E;
identifier FP_NAME = xDestroy;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xDestroy@
identifier FP_NAME = xDestroy;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xDestroy@
fp_name << find_struct_fp_assignment_xDestroy.FP_NAME;
func_name << find_struct_fp_assignment_xDestroy.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDestroy.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xDestroy@
fp_name << find_init_fp_assignment_xDestroy.FP_NAME;
func_name << find_init_fp_assignment_xDestroy.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDestroy.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_result_error@
expression E;
identifier FP_NAME = result_error;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_result_error@
identifier FP_NAME = result_error;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_result_error@
fp_name << find_struct_fp_assignment_result_error.FP_NAME;
func_name << find_struct_fp_assignment_result_error.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_error.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_result_error@
fp_name << find_init_fp_assignment_result_error.FP_NAME;
func_name << find_init_fp_assignment_result_error.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_error.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xReiniter@
expression E;
identifier FP_NAME = xReiniter;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xReiniter@
identifier FP_NAME = xReiniter;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xReiniter@
fp_name << find_struct_fp_assignment_xReiniter.FP_NAME;
func_name << find_struct_fp_assignment_xReiniter.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xReiniter.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xReiniter@
fp_name << find_init_fp_assignment_xReiniter.FP_NAME;
func_name << find_init_fp_assignment_xReiniter.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xReiniter.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_result_zeroblob64@
expression E;
identifier FP_NAME = result_zeroblob64;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_result_zeroblob64@
identifier FP_NAME = result_zeroblob64;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_result_zeroblob64@
fp_name << find_struct_fp_assignment_result_zeroblob64.FP_NAME;
func_name << find_struct_fp_assignment_result_zeroblob64.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_zeroblob64.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_result_zeroblob64@
fp_name << find_init_fp_assignment_result_zeroblob64.FP_NAME;
func_name << find_init_fp_assignment_result_zeroblob64.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_zeroblob64.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_value_blob@
expression E;
identifier FP_NAME = value_blob;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_value_blob@
identifier FP_NAME = value_blob;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_value_blob@
fp_name << find_struct_fp_assignment_value_blob.FP_NAME;
func_name << find_struct_fp_assignment_value_blob.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_blob.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_value_blob@
fp_name << find_init_fp_assignment_value_blob.FP_NAME;
func_name << find_init_fp_assignment_value_blob.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_blob.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_str_vappendf@
expression E;
identifier FP_NAME = str_vappendf;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_str_vappendf@
identifier FP_NAME = str_vappendf;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_str_vappendf@
fp_name << find_struct_fp_assignment_str_vappendf.FP_NAME;
func_name << find_struct_fp_assignment_str_vappendf.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/str_vappendf.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_str_vappendf@
fp_name << find_init_fp_assignment_str_vappendf.FP_NAME;
func_name << find_init_fp_assignment_str_vappendf.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/str_vappendf.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_keyCompare@
expression E;
identifier FP_NAME = keyCompare;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_keyCompare@
identifier FP_NAME = keyCompare;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_keyCompare@
fp_name << find_struct_fp_assignment_keyCompare.FP_NAME;
func_name << find_struct_fp_assignment_keyCompare.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/keyCompare.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_keyCompare@
fp_name << find_init_fp_assignment_keyCompare.FP_NAME;
func_name << find_init_fp_assignment_keyCompare.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/keyCompare.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_bind_zeroblob@
expression E;
identifier FP_NAME = bind_zeroblob;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_bind_zeroblob@
identifier FP_NAME = bind_zeroblob;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_bind_zeroblob@
fp_name << find_struct_fp_assignment_bind_zeroblob.FP_NAME;
func_name << find_struct_fp_assignment_bind_zeroblob.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/bind_zeroblob.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_bind_zeroblob@
fp_name << find_init_fp_assignment_bind_zeroblob.FP_NAME;
func_name << find_init_fp_assignment_bind_zeroblob.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/bind_zeroblob.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_drop_modules@
expression E;
identifier FP_NAME = drop_modules;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_drop_modules@
identifier FP_NAME = drop_modules;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_drop_modules@
fp_name << find_struct_fp_assignment_drop_modules.FP_NAME;
func_name << find_struct_fp_assignment_drop_modules.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/drop_modules.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_drop_modules@
fp_name << find_init_fp_assignment_drop_modules.FP_NAME;
func_name << find_init_fp_assignment_drop_modules.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/drop_modules.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xMutexNotheld@
expression E;
identifier FP_NAME = xMutexNotheld;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xMutexNotheld@
identifier FP_NAME = xMutexNotheld;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xMutexNotheld@
fp_name << find_struct_fp_assignment_xMutexNotheld.FP_NAME;
func_name << find_struct_fp_assignment_xMutexNotheld.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xMutexNotheld.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xMutexNotheld@
fp_name << find_init_fp_assignment_xMutexNotheld.FP_NAME;
func_name << find_init_fp_assignment_xMutexNotheld.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xMutexNotheld.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_value_double@
expression E;
identifier FP_NAME = value_double;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_value_double@
identifier FP_NAME = value_double;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_value_double@
fp_name << find_struct_fp_assignment_value_double.FP_NAME;
func_name << find_struct_fp_assignment_value_double.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_double.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_value_double@
fp_name << find_init_fp_assignment_value_double.FP_NAME;
func_name << find_init_fp_assignment_value_double.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_double.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_bind_parameter_index@
expression E;
identifier FP_NAME = bind_parameter_index;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_bind_parameter_index@
identifier FP_NAME = bind_parameter_index;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_bind_parameter_index@
fp_name << find_struct_fp_assignment_bind_parameter_index.FP_NAME;
func_name << find_struct_fp_assignment_bind_parameter_index.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/bind_parameter_index.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_bind_parameter_index@
fp_name << find_init_fp_assignment_bind_parameter_index.FP_NAME;
func_name << find_init_fp_assignment_bind_parameter_index.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/bind_parameter_index.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xCommit@
expression E;
identifier FP_NAME = xCommit;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xCommit@
identifier FP_NAME = xCommit;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xCommit@
fp_name << find_struct_fp_assignment_xCommit.FP_NAME;
func_name << find_struct_fp_assignment_xCommit.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCommit.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xCommit@
fp_name << find_init_fp_assignment_xCommit.FP_NAME;
func_name << find_init_fp_assignment_xCommit.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCommit.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_result_int64@
expression E;
identifier FP_NAME = result_int64;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_result_int64@
identifier FP_NAME = result_int64;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_result_int64@
fp_name << find_struct_fp_assignment_result_int64.FP_NAME;
func_name << find_struct_fp_assignment_result_int64.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_int64.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_result_int64@
fp_name << find_init_fp_assignment_result_int64.FP_NAME;
func_name << find_init_fp_assignment_result_int64.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_int64.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xvsnprintf@
expression E;
identifier FP_NAME = xvsnprintf;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xvsnprintf@
identifier FP_NAME = xvsnprintf;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xvsnprintf@
fp_name << find_struct_fp_assignment_xvsnprintf.FP_NAME;
func_name << find_struct_fp_assignment_xvsnprintf.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xvsnprintf.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xvsnprintf@
fp_name << find_init_fp_assignment_xvsnprintf.FP_NAME;
func_name << find_init_fp_assignment_xvsnprintf.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xvsnprintf.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_uri_parameter@
expression E;
identifier FP_NAME = uri_parameter;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_uri_parameter@
identifier FP_NAME = uri_parameter;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_uri_parameter@
fp_name << find_struct_fp_assignment_uri_parameter.FP_NAME;
func_name << find_struct_fp_assignment_uri_parameter.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/uri_parameter.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_uri_parameter@
fp_name << find_init_fp_assignment_uri_parameter.FP_NAME;
func_name << find_init_fp_assignment_uri_parameter.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/uri_parameter.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_str_appendchar@
expression E;
identifier FP_NAME = str_appendchar;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_str_appendchar@
identifier FP_NAME = str_appendchar;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_str_appendchar@
fp_name << find_struct_fp_assignment_str_appendchar.FP_NAME;
func_name << find_struct_fp_assignment_str_appendchar.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/str_appendchar.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_str_appendchar@
fp_name << find_init_fp_assignment_str_appendchar.FP_NAME;
func_name << find_init_fp_assignment_str_appendchar.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/str_appendchar.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_valDup@
expression E;
identifier FP_NAME = valDup;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_valDup@
identifier FP_NAME = valDup;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_valDup@
fp_name << find_struct_fp_assignment_valDup.FP_NAME;
func_name << find_struct_fp_assignment_valDup.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/valDup.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_valDup@
fp_name << find_init_fp_assignment_valDup.FP_NAME;
func_name << find_init_fp_assignment_valDup.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/valDup.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_vmprintf@
expression E;
identifier FP_NAME = vmprintf;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_vmprintf@
identifier FP_NAME = vmprintf;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_vmprintf@
fp_name << find_struct_fp_assignment_vmprintf.FP_NAME;
func_name << find_struct_fp_assignment_vmprintf.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vmprintf.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_vmprintf@
fp_name << find_init_fp_assignment_vmprintf.FP_NAME;
func_name << find_init_fp_assignment_vmprintf.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vmprintf.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_blob_bytes@
expression E;
identifier FP_NAME = blob_bytes;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_blob_bytes@
identifier FP_NAME = blob_bytes;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_blob_bytes@
fp_name << find_struct_fp_assignment_blob_bytes.FP_NAME;
func_name << find_struct_fp_assignment_blob_bytes.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/blob_bytes.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_blob_bytes@
fp_name << find_init_fp_assignment_blob_bytes.FP_NAME;
func_name << find_init_fp_assignment_blob_bytes.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/blob_bytes.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_vfs_find@
expression E;
identifier FP_NAME = vfs_find;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_vfs_find@
identifier FP_NAME = vfs_find;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_vfs_find@
fp_name << find_struct_fp_assignment_vfs_find.FP_NAME;
func_name << find_struct_fp_assignment_vfs_find.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vfs_find.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_vfs_find@
fp_name << find_init_fp_assignment_vfs_find.FP_NAME;
func_name << find_init_fp_assignment_vfs_find.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vfs_find.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_uri_boolean@
expression E;
identifier FP_NAME = uri_boolean;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_uri_boolean@
identifier FP_NAME = uri_boolean;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_uri_boolean@
fp_name << find_struct_fp_assignment_uri_boolean.FP_NAME;
func_name << find_struct_fp_assignment_uri_boolean.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/uri_boolean.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_uri_boolean@
fp_name << find_init_fp_assignment_uri_boolean.FP_NAME;
func_name << find_init_fp_assignment_uri_boolean.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/uri_boolean.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_open_v2@
expression E;
identifier FP_NAME = open_v2;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_open_v2@
identifier FP_NAME = open_v2;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_open_v2@
fp_name << find_struct_fp_assignment_open_v2.FP_NAME;
func_name << find_struct_fp_assignment_open_v2.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/open_v2.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_open_v2@
fp_name << find_init_fp_assignment_open_v2.FP_NAME;
func_name << find_init_fp_assignment_open_v2.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/open_v2.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_context_db_handle@
expression E;
identifier FP_NAME = context_db_handle;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_context_db_handle@
identifier FP_NAME = context_db_handle;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_context_db_handle@
fp_name << find_struct_fp_assignment_context_db_handle.FP_NAME;
func_name << find_struct_fp_assignment_context_db_handle.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/context_db_handle.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_context_db_handle@
fp_name << find_init_fp_assignment_context_db_handle.FP_NAME;
func_name << find_init_fp_assignment_context_db_handle.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/context_db_handle.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xRealloc@
expression E;
identifier FP_NAME = xRealloc;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xRealloc@
identifier FP_NAME = xRealloc;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xRealloc@
fp_name << find_struct_fp_assignment_xRealloc.FP_NAME;
func_name << find_struct_fp_assignment_xRealloc.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRealloc.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xRealloc@
fp_name << find_init_fp_assignment_xRealloc.FP_NAME;
func_name << find_init_fp_assignment_xRealloc.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRealloc.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_result_int@
expression E;
identifier FP_NAME = result_int;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_result_int@
identifier FP_NAME = result_int;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_result_int@
fp_name << find_struct_fp_assignment_result_int.FP_NAME;
func_name << find_struct_fp_assignment_result_int.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_int.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_result_int@
fp_name << find_init_fp_assignment_result_int.FP_NAME;
func_name << find_init_fp_assignment_result_int.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_int.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_close_v2@
expression E;
identifier FP_NAME = close_v2;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_close_v2@
identifier FP_NAME = close_v2;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_close_v2@
fp_name << find_struct_fp_assignment_close_v2.FP_NAME;
func_name << find_struct_fp_assignment_close_v2.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/close_v2.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_close_v2@
fp_name << find_init_fp_assignment_close_v2.FP_NAME;
func_name << find_init_fp_assignment_close_v2.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/close_v2.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_signal_set_result@
expression E;
identifier FP_NAME = signal_set_result;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_signal_set_result@
identifier FP_NAME = signal_set_result;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_signal_set_result@
fp_name << find_struct_fp_assignment_signal_set_result.FP_NAME;
func_name << find_struct_fp_assignment_signal_set_result.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/signal_set_result.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_signal_set_result@
fp_name << find_init_fp_assignment_signal_set_result.FP_NAME;
func_name << find_init_fp_assignment_signal_set_result.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/signal_set_result.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xDeleteAux@
expression E;
identifier FP_NAME = xDeleteAux;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xDeleteAux@
identifier FP_NAME = xDeleteAux;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xDeleteAux@
fp_name << find_struct_fp_assignment_xDeleteAux.FP_NAME;
func_name << find_struct_fp_assignment_xDeleteAux.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDeleteAux.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xDeleteAux@
fp_name << find_init_fp_assignment_xDeleteAux.FP_NAME;
func_name << find_init_fp_assignment_xDeleteAux.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDeleteAux.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xDelUser@
expression E;
identifier FP_NAME = xDelUser;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xDelUser@
identifier FP_NAME = xDelUser;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xDelUser@
fp_name << find_struct_fp_assignment_xDelUser.FP_NAME;
func_name << find_struct_fp_assignment_xDelUser.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDelUser.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xDelUser@
fp_name << find_init_fp_assignment_xDelUser.FP_NAME;
func_name << find_init_fp_assignment_xDelUser.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDelUser.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xRelease@
expression E;
identifier FP_NAME = xRelease;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xRelease@
identifier FP_NAME = xRelease;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xRelease@
fp_name << find_struct_fp_assignment_xRelease.FP_NAME;
func_name << find_struct_fp_assignment_xRelease.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRelease.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xRelease@
fp_name << find_init_fp_assignment_xRelease.FP_NAME;
func_name << find_init_fp_assignment_xRelease.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRelease.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xInput@
expression E;
identifier FP_NAME = xInput;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xInput@
identifier FP_NAME = xInput;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xInput@
fp_name << find_struct_fp_assignment_xInput.FP_NAME;
func_name << find_struct_fp_assignment_xInput.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xInput.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xInput@
fp_name << find_init_fp_assignment_xInput.FP_NAME;
func_name << find_init_fp_assignment_xInput.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xInput.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xBestIndex@
expression E;
identifier FP_NAME = xBestIndex;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xBestIndex@
identifier FP_NAME = xBestIndex;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xBestIndex@
fp_name << find_struct_fp_assignment_xBestIndex.FP_NAME;
func_name << find_struct_fp_assignment_xBestIndex.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xBestIndex.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xBestIndex@
fp_name << find_init_fp_assignment_xBestIndex.FP_NAME;
func_name << find_init_fp_assignment_xBestIndex.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xBestIndex.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_column_blob@
expression E;
identifier FP_NAME = column_blob;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_column_blob@
identifier FP_NAME = column_blob;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_column_blob@
fp_name << find_struct_fp_assignment_column_blob.FP_NAME;
func_name << find_struct_fp_assignment_column_blob.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_blob.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_column_blob@
fp_name << find_init_fp_assignment_column_blob.FP_NAME;
func_name << find_init_fp_assignment_column_blob.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_blob.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xPhraseCount@
expression E;
identifier FP_NAME = xPhraseCount;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xPhraseCount@
identifier FP_NAME = xPhraseCount;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xPhraseCount@
fp_name << find_struct_fp_assignment_xPhraseCount.FP_NAME;
func_name << find_struct_fp_assignment_xPhraseCount.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xPhraseCount.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xPhraseCount@
fp_name << find_init_fp_assignment_xPhraseCount.FP_NAME;
func_name << find_init_fp_assignment_xPhraseCount.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xPhraseCount.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_extended_errcode@
expression E;
identifier FP_NAME = extended_errcode;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_extended_errcode@
identifier FP_NAME = extended_errcode;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_extended_errcode@
fp_name << find_struct_fp_assignment_extended_errcode.FP_NAME;
func_name << find_struct_fp_assignment_extended_errcode.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/extended_errcode.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_extended_errcode@
fp_name << find_init_fp_assignment_extended_errcode.FP_NAME;
func_name << find_init_fp_assignment_extended_errcode.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/extended_errcode.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xPhraseNext@
expression E;
identifier FP_NAME = xPhraseNext;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xPhraseNext@
identifier FP_NAME = xPhraseNext;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xPhraseNext@
fp_name << find_struct_fp_assignment_xPhraseNext.FP_NAME;
func_name << find_struct_fp_assignment_xPhraseNext.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xPhraseNext.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xPhraseNext@
fp_name << find_init_fp_assignment_xPhraseNext.FP_NAME;
func_name << find_init_fp_assignment_xPhraseNext.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xPhraseNext.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_backup_init@
expression E;
identifier FP_NAME = backup_init;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_backup_init@
identifier FP_NAME = backup_init;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_backup_init@
fp_name << find_struct_fp_assignment_backup_init.FP_NAME;
func_name << find_struct_fp_assignment_backup_init.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/backup_init.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_backup_init@
fp_name << find_init_fp_assignment_backup_init.FP_NAME;
func_name << find_init_fp_assignment_backup_init.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/backup_init.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xRandomness@
expression E;
identifier FP_NAME = xRandomness;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xRandomness@
identifier FP_NAME = xRandomness;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xRandomness@
fp_name << find_struct_fp_assignment_xRandomness.FP_NAME;
func_name << find_struct_fp_assignment_xRandomness.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRandomness.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xRandomness@
fp_name << find_init_fp_assignment_xRandomness.FP_NAME;
func_name << find_init_fp_assignment_xRandomness.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRandomness.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_str_length@
expression E;
identifier FP_NAME = str_length;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_str_length@
identifier FP_NAME = str_length;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_str_length@
fp_name << find_struct_fp_assignment_str_length.FP_NAME;
func_name << find_struct_fp_assignment_str_length.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/str_length.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_str_length@
fp_name << find_init_fp_assignment_str_length.FP_NAME;
func_name << find_init_fp_assignment_str_length.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/str_length.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_pInit@
expression E;
identifier FP_NAME = pInit;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_pInit@
identifier FP_NAME = pInit;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_pInit@
fp_name << find_struct_fp_assignment_pInit.FP_NAME;
func_name << find_struct_fp_assignment_pInit.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/pInit.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_pInit@
fp_name << find_init_fp_assignment_pInit.FP_NAME;
func_name << find_init_fp_assignment_pInit.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/pInit.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xCallback@
expression E;
identifier FP_NAME = xCallback;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xCallback@
identifier FP_NAME = xCallback;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xCallback@
fp_name << find_struct_fp_assignment_xCallback.FP_NAME;
func_name << find_struct_fp_assignment_xCallback.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCallback.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xCallback@
fp_name << find_init_fp_assignment_xCallback.FP_NAME;
func_name << find_init_fp_assignment_xCallback.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCallback.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xTruncate@
expression E;
identifier FP_NAME = xTruncate;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xTruncate@
identifier FP_NAME = xTruncate;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xTruncate@
fp_name << find_struct_fp_assignment_xTruncate.FP_NAME;
func_name << find_struct_fp_assignment_xTruncate.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xTruncate.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xTruncate@
fp_name << find_init_fp_assignment_xTruncate.FP_NAME;
func_name << find_init_fp_assignment_xTruncate.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xTruncate.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_randomness@
expression E;
identifier FP_NAME = randomness;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_randomness@
identifier FP_NAME = randomness;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_randomness@
fp_name << find_struct_fp_assignment_randomness.FP_NAME;
func_name << find_struct_fp_assignment_randomness.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/randomness.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_randomness@
fp_name << find_init_fp_assignment_randomness.FP_NAME;
func_name << find_init_fp_assignment_randomness.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/randomness.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_str_appendf@
expression E;
identifier FP_NAME = str_appendf;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_str_appendf@
identifier FP_NAME = str_appendf;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_str_appendf@
fp_name << find_struct_fp_assignment_str_appendf.FP_NAME;
func_name << find_struct_fp_assignment_str_appendf.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/str_appendf.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_str_appendf@
fp_name << find_init_fp_assignment_str_appendf.FP_NAME;
func_name << find_init_fp_assignment_str_appendf.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/str_appendf.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_value_text16le@
expression E;
identifier FP_NAME = value_text16le;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_value_text16le@
identifier FP_NAME = value_text16le;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_value_text16le@
fp_name << find_struct_fp_assignment_value_text16le.FP_NAME;
func_name << find_struct_fp_assignment_value_text16le.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_text16le.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_value_text16le@
fp_name << find_init_fp_assignment_value_text16le.FP_NAME;
func_name << find_init_fp_assignment_value_text16le.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_text16le.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xFinalize@
expression E;
identifier FP_NAME = xFinalize;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xFinalize@
identifier FP_NAME = xFinalize;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xFinalize@
fp_name << find_struct_fp_assignment_xFinalize.FP_NAME;
func_name << find_struct_fp_assignment_xFinalize.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFinalize.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xFinalize@
fp_name << find_init_fp_assignment_xFinalize.FP_NAME;
func_name << find_init_fp_assignment_xFinalize.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFinalize.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xDel@
expression E;
identifier FP_NAME = xDel;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xDel@
identifier FP_NAME = xDel;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xDel@
fp_name << find_struct_fp_assignment_xDel.FP_NAME;
func_name << find_struct_fp_assignment_xDel.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDel.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xDel@
fp_name << find_init_fp_assignment_xDel.FP_NAME;
func_name << find_init_fp_assignment_xDel.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDel.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xMutexInit@
expression E;
identifier FP_NAME = xMutexInit;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xMutexInit@
identifier FP_NAME = xMutexInit;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xMutexInit@
fp_name << find_struct_fp_assignment_xMutexInit.FP_NAME;
func_name << find_struct_fp_assignment_xMutexInit.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xMutexInit.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xMutexInit@
fp_name << find_init_fp_assignment_xMutexInit.FP_NAME;
func_name << find_init_fp_assignment_xMutexInit.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xMutexInit.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xSqllog@
expression E;
identifier FP_NAME = xSqllog;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xSqllog@
identifier FP_NAME = xSqllog;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xSqllog@
fp_name << find_struct_fp_assignment_xSqllog.FP_NAME;
func_name << find_struct_fp_assignment_xSqllog.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSqllog.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xSqllog@
fp_name << find_init_fp_assignment_xSqllog.FP_NAME;
func_name << find_init_fp_assignment_xSqllog.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSqllog.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_db_name@
expression E;
identifier FP_NAME = db_name;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_db_name@
identifier FP_NAME = db_name;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_db_name@
fp_name << find_struct_fp_assignment_db_name.FP_NAME;
func_name << find_struct_fp_assignment_db_name.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/db_name.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_db_name@
fp_name << find_init_fp_assignment_db_name.FP_NAME;
func_name << find_init_fp_assignment_db_name.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/db_name.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xCurrentTimeInt64@
expression E;
identifier FP_NAME = xCurrentTimeInt64;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xCurrentTimeInt64@
identifier FP_NAME = xCurrentTimeInt64;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xCurrentTimeInt64@
fp_name << find_struct_fp_assignment_xCurrentTimeInt64.FP_NAME;
func_name << find_struct_fp_assignment_xCurrentTimeInt64.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCurrentTimeInt64.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xCurrentTimeInt64@
fp_name << find_init_fp_assignment_xCurrentTimeInt64.FP_NAME;
func_name << find_init_fp_assignment_xCurrentTimeInt64.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCurrentTimeInt64.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xWalCallback@
expression E;
identifier FP_NAME = xWalCallback;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xWalCallback@
identifier FP_NAME = xWalCallback;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xWalCallback@
fp_name << find_struct_fp_assignment_xWalCallback.FP_NAME;
func_name << find_struct_fp_assignment_xWalCallback.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xWalCallback.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xWalCallback@
fp_name << find_init_fp_assignment_xWalCallback.FP_NAME;
func_name << find_init_fp_assignment_xWalCallback.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xWalCallback.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xCurrentTime@
expression E;
identifier FP_NAME = xCurrentTime;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xCurrentTime@
identifier FP_NAME = xCurrentTime;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xCurrentTime@
fp_name << find_struct_fp_assignment_xCurrentTime.FP_NAME;
func_name << find_struct_fp_assignment_xCurrentTime.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCurrentTime.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xCurrentTime@
fp_name << find_init_fp_assignment_xCurrentTime.FP_NAME;
func_name << find_init_fp_assignment_xCurrentTime.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCurrentTime.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_get_table@
expression E;
identifier FP_NAME = get_table;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_get_table@
identifier FP_NAME = get_table;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_get_table@
fp_name << find_struct_fp_assignment_get_table.FP_NAME;
func_name << find_struct_fp_assignment_get_table.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/get_table.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_get_table@
fp_name << find_init_fp_assignment_get_table.FP_NAME;
func_name << find_init_fp_assignment_get_table.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/get_table.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xValue@
expression E;
identifier FP_NAME = xValue;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xValue@
identifier FP_NAME = xValue;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xValue@
fp_name << find_struct_fp_assignment_xValue.FP_NAME;
func_name << find_struct_fp_assignment_xValue.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xValue.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xValue@
fp_name << find_init_fp_assignment_xValue.FP_NAME;
func_name << find_init_fp_assignment_xValue.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xValue.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_global_recover@
expression E;
identifier FP_NAME = global_recover;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_global_recover@
identifier FP_NAME = global_recover;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_global_recover@
fp_name << find_struct_fp_assignment_global_recover.FP_NAME;
func_name << find_struct_fp_assignment_global_recover.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/global_recover.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_global_recover@
fp_name << find_init_fp_assignment_global_recover.FP_NAME;
func_name << find_init_fp_assignment_global_recover.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/global_recover.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xMerge@
expression E;
identifier FP_NAME = xMerge;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xMerge@
identifier FP_NAME = xMerge;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xMerge@
fp_name << find_struct_fp_assignment_xMerge.FP_NAME;
func_name << find_struct_fp_assignment_xMerge.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xMerge.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xMerge@
fp_name << find_init_fp_assignment_xMerge.FP_NAME;
func_name << find_init_fp_assignment_xMerge.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xMerge.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_create_module@
expression E;
identifier FP_NAME = create_module;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_create_module@
identifier FP_NAME = create_module;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_create_module@
fp_name << find_struct_fp_assignment_create_module.FP_NAME;
func_name << find_struct_fp_assignment_create_module.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/create_module.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_create_module@
fp_name << find_init_fp_assignment_create_module.FP_NAME;
func_name << find_init_fp_assignment_create_module.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/create_module.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xUnlock@
expression E;
identifier FP_NAME = xUnlock;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xUnlock@
identifier FP_NAME = xUnlock;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xUnlock@
fp_name << find_struct_fp_assignment_xUnlock.FP_NAME;
func_name << find_struct_fp_assignment_xUnlock.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xUnlock.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xUnlock@
fp_name << find_init_fp_assignment_xUnlock.FP_NAME;
func_name << find_init_fp_assignment_xUnlock.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xUnlock.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_str_new@
expression E;
identifier FP_NAME = str_new;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_str_new@
identifier FP_NAME = str_new;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_str_new@
fp_name << find_struct_fp_assignment_str_new.FP_NAME;
func_name << find_struct_fp_assignment_str_new.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/str_new.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_str_new@
fp_name << find_init_fp_assignment_str_new.FP_NAME;
func_name << find_init_fp_assignment_str_new.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/str_new.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xSync@
expression E;
identifier FP_NAME = xSync;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xSync@
identifier FP_NAME = xSync;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xSync@
fp_name << find_struct_fp_assignment_xSync.FP_NAME;
func_name << find_struct_fp_assignment_xSync.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSync.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xSync@
fp_name << find_init_fp_assignment_xSync.FP_NAME;
func_name << find_init_fp_assignment_xSync.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSync.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xShmBarrier@
expression E;
identifier FP_NAME = xShmBarrier;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xShmBarrier@
identifier FP_NAME = xShmBarrier;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xShmBarrier@
fp_name << find_struct_fp_assignment_xShmBarrier.FP_NAME;
func_name << find_struct_fp_assignment_xShmBarrier.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xShmBarrier.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xShmBarrier@
fp_name << find_init_fp_assignment_xShmBarrier.FP_NAME;
func_name << find_init_fp_assignment_xShmBarrier.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xShmBarrier.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xUpdate@
expression E;
identifier FP_NAME = xUpdate;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xUpdate@
identifier FP_NAME = xUpdate;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xUpdate@
fp_name << find_struct_fp_assignment_xUpdate.FP_NAME;
func_name << find_struct_fp_assignment_xUpdate.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xUpdate.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xUpdate@
fp_name << find_init_fp_assignment_xUpdate.FP_NAME;
func_name << find_init_fp_assignment_xUpdate.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xUpdate.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_column_decltype16@
expression E;
identifier FP_NAME = column_decltype16;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_column_decltype16@
identifier FP_NAME = column_decltype16;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_column_decltype16@
fp_name << find_struct_fp_assignment_column_decltype16.FP_NAME;
func_name << find_struct_fp_assignment_column_decltype16.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_decltype16.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_column_decltype16@
fp_name << find_init_fp_assignment_column_decltype16.FP_NAME;
func_name << find_init_fp_assignment_column_decltype16.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_decltype16.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_filename_database@
expression E;
identifier FP_NAME = filename_database;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_filename_database@
identifier FP_NAME = filename_database;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_filename_database@
fp_name << find_struct_fp_assignment_filename_database.FP_NAME;
func_name << find_struct_fp_assignment_filename_database.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/filename_database.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_filename_database@
fp_name << find_init_fp_assignment_filename_database.FP_NAME;
func_name << find_init_fp_assignment_filename_database.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/filename_database.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_backup_step@
expression E;
identifier FP_NAME = backup_step;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_backup_step@
identifier FP_NAME = backup_step;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_backup_step@
fp_name << find_struct_fp_assignment_backup_step.FP_NAME;
func_name << find_struct_fp_assignment_backup_step.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/backup_step.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_backup_step@
fp_name << find_init_fp_assignment_backup_step.FP_NAME;
func_name << find_init_fp_assignment_backup_step.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/backup_step.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_transfer_bindings@
expression E;
identifier FP_NAME = transfer_bindings;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_transfer_bindings@
identifier FP_NAME = transfer_bindings;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_transfer_bindings@
fp_name << find_struct_fp_assignment_transfer_bindings.FP_NAME;
func_name << find_struct_fp_assignment_transfer_bindings.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/transfer_bindings.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_transfer_bindings@
fp_name << find_init_fp_assignment_transfer_bindings.FP_NAME;
func_name << find_init_fp_assignment_transfer_bindings.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/transfer_bindings.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_keyDestructor@
expression E;
identifier FP_NAME = keyDestructor;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_keyDestructor@
identifier FP_NAME = keyDestructor;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_keyDestructor@
fp_name << find_struct_fp_assignment_keyDestructor.FP_NAME;
func_name << find_struct_fp_assignment_keyDestructor.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/keyDestructor.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_keyDestructor@
fp_name << find_init_fp_assignment_keyDestructor.FP_NAME;
func_name << find_init_fp_assignment_keyDestructor.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/keyDestructor.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xConnect@
expression E;
identifier FP_NAME = xConnect;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xConnect@
identifier FP_NAME = xConnect;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xConnect@
fp_name << find_struct_fp_assignment_xConnect.FP_NAME;
func_name << find_struct_fp_assignment_xConnect.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xConnect.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xConnect@
fp_name << find_init_fp_assignment_xConnect.FP_NAME;
func_name << find_init_fp_assignment_xConnect.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xConnect.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_result_value@
expression E;
identifier FP_NAME = result_value;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_result_value@
identifier FP_NAME = result_value;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_result_value@
fp_name << find_struct_fp_assignment_result_value.FP_NAME;
func_name << find_struct_fp_assignment_result_value.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_value.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_result_value@
fp_name << find_init_fp_assignment_result_value.FP_NAME;
func_name << find_init_fp_assignment_result_value.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_value.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_blob_open@
expression E;
identifier FP_NAME = blob_open;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_blob_open@
identifier FP_NAME = blob_open;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_blob_open@
fp_name << find_struct_fp_assignment_blob_open.FP_NAME;
func_name << find_struct_fp_assignment_blob_open.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/blob_open.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_blob_open@
fp_name << find_init_fp_assignment_blob_open.FP_NAME;
func_name << find_init_fp_assignment_blob_open.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/blob_open.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xCheckReservedLock@
expression E;
identifier FP_NAME = xCheckReservedLock;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xCheckReservedLock@
identifier FP_NAME = xCheckReservedLock;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xCheckReservedLock@
fp_name << find_struct_fp_assignment_xCheckReservedLock.FP_NAME;
func_name << find_struct_fp_assignment_xCheckReservedLock.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCheckReservedLock.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xCheckReservedLock@
fp_name << find_init_fp_assignment_xCheckReservedLock.FP_NAME;
func_name << find_init_fp_assignment_xCheckReservedLock.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCheckReservedLock.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_result_error_code@
expression E;
identifier FP_NAME = result_error_code;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_result_error_code@
identifier FP_NAME = result_error_code;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_result_error_code@
fp_name << find_struct_fp_assignment_result_error_code.FP_NAME;
func_name << find_struct_fp_assignment_result_error_code.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_error_code.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_result_error_code@
fp_name << find_init_fp_assignment_result_error_code.FP_NAME;
func_name << find_init_fp_assignment_result_error_code.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_error_code.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_value_encoding@
expression E;
identifier FP_NAME = value_encoding;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_value_encoding@
identifier FP_NAME = value_encoding;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_value_encoding@
fp_name << find_struct_fp_assignment_value_encoding.FP_NAME;
func_name << find_struct_fp_assignment_value_encoding.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_encoding.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_value_encoding@
fp_name << find_init_fp_assignment_value_encoding.FP_NAME;
func_name << find_init_fp_assignment_value_encoding.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_encoding.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_value_bytes16@
expression E;
identifier FP_NAME = value_bytes16;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_value_bytes16@
identifier FP_NAME = value_bytes16;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_value_bytes16@
fp_name << find_struct_fp_assignment_value_bytes16.FP_NAME;
func_name << find_struct_fp_assignment_value_bytes16.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_bytes16.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_value_bytes16@
fp_name << find_init_fp_assignment_value_bytes16.FP_NAME;
func_name << find_init_fp_assignment_value_bytes16.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_bytes16.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xShadowName@
expression E;
identifier FP_NAME = xShadowName;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xShadowName@
identifier FP_NAME = xShadowName;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xShadowName@
fp_name << find_struct_fp_assignment_xShadowName.FP_NAME;
func_name << find_struct_fp_assignment_xShadowName.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xShadowName.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xShadowName@
fp_name << find_init_fp_assignment_xShadowName.FP_NAME;
func_name << find_init_fp_assignment_xShadowName.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xShadowName.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xColumnSize@
expression E;
identifier FP_NAME = xColumnSize;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xColumnSize@
identifier FP_NAME = xColumnSize;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xColumnSize@
fp_name << find_struct_fp_assignment_xColumnSize.FP_NAME;
func_name << find_struct_fp_assignment_xColumnSize.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xColumnSize.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xColumnSize@
fp_name << find_init_fp_assignment_xColumnSize.FP_NAME;
func_name << find_init_fp_assignment_xColumnSize.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xColumnSize.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xStress@
expression E;
identifier FP_NAME = xStress;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xStress@
identifier FP_NAME = xStress;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xStress@
fp_name << find_struct_fp_assignment_xStress.FP_NAME;
func_name << find_struct_fp_assignment_xStress.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xStress.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xStress@
fp_name << find_init_fp_assignment_xStress.FP_NAME;
func_name << find_init_fp_assignment_xStress.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xStress.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_stricmp@
expression E;
identifier FP_NAME = stricmp;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_stricmp@
identifier FP_NAME = stricmp;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_stricmp@
fp_name << find_struct_fp_assignment_stricmp.FP_NAME;
func_name << find_struct_fp_assignment_stricmp.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/stricmp.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_stricmp@
fp_name << find_init_fp_assignment_stricmp.FP_NAME;
func_name << find_init_fp_assignment_stricmp.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/stricmp.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_column_table_name16@
expression E;
identifier FP_NAME = column_table_name16;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_column_table_name16@
identifier FP_NAME = column_table_name16;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_column_table_name16@
fp_name << find_struct_fp_assignment_column_table_name16.FP_NAME;
func_name << find_struct_fp_assignment_column_table_name16.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_table_name16.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_column_table_name16@
fp_name << find_init_fp_assignment_column_table_name16.FP_NAME;
func_name << find_init_fp_assignment_column_table_name16.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_table_name16.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xMalloc@
expression E;
identifier FP_NAME = xMalloc;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xMalloc@
identifier FP_NAME = xMalloc;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xMalloc@
fp_name << find_struct_fp_assignment_xMalloc.FP_NAME;
func_name << find_struct_fp_assignment_xMalloc.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xMalloc.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xMalloc@
fp_name << find_init_fp_assignment_xMalloc.FP_NAME;
func_name << find_init_fp_assignment_xMalloc.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xMalloc.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_errstr@
expression E;
identifier FP_NAME = errstr;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_errstr@
identifier FP_NAME = errstr;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_errstr@
fp_name << find_struct_fp_assignment_errstr.FP_NAME;
func_name << find_struct_fp_assignment_errstr.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/errstr.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_errstr@
fp_name << find_init_fp_assignment_errstr.FP_NAME;
func_name << find_init_fp_assignment_errstr.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/errstr.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xV2@
expression E;
identifier FP_NAME = xV2;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xV2@
identifier FP_NAME = xV2;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xV2@
fp_name << find_struct_fp_assignment_xV2.FP_NAME;
func_name << find_struct_fp_assignment_xV2.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xV2.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xV2@
fp_name << find_init_fp_assignment_xV2.FP_NAME;
func_name << find_init_fp_assignment_xV2.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xV2.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_compileoption_used@
expression E;
identifier FP_NAME = compileoption_used;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_compileoption_used@
identifier FP_NAME = compileoption_used;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_compileoption_used@
fp_name << find_struct_fp_assignment_compileoption_used.FP_NAME;
func_name << find_struct_fp_assignment_compileoption_used.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/compileoption_used.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_compileoption_used@
fp_name << find_init_fp_assignment_compileoption_used.FP_NAME;
func_name << find_init_fp_assignment_compileoption_used.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/compileoption_used.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xRead@
expression E;
identifier FP_NAME = xRead;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xRead@
identifier FP_NAME = xRead;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xRead@
fp_name << find_struct_fp_assignment_xRead.FP_NAME;
func_name << find_struct_fp_assignment_xRead.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRead.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xRead@
fp_name << find_init_fp_assignment_xRead.FP_NAME;
func_name << find_init_fp_assignment_xRead.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRead.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_uri_int64@
expression E;
identifier FP_NAME = uri_int64;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_uri_int64@
identifier FP_NAME = uri_int64;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_uri_int64@
fp_name << find_struct_fp_assignment_uri_int64.FP_NAME;
func_name << find_struct_fp_assignment_uri_int64.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/uri_int64.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_uri_int64@
fp_name << find_init_fp_assignment_uri_int64.FP_NAME;
func_name << find_init_fp_assignment_uri_int64.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/uri_int64.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xSize@
expression E;
identifier FP_NAME = xSize;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xSize@
identifier FP_NAME = xSize;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xSize@
fp_name << find_struct_fp_assignment_xSize.FP_NAME;
func_name << find_struct_fp_assignment_xSize.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSize.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xSize@
fp_name << find_init_fp_assignment_xSize.FP_NAME;
func_name << find_init_fp_assignment_xSize.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSize.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xSectorSize@
expression E;
identifier FP_NAME = xSectorSize;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xSectorSize@
identifier FP_NAME = xSectorSize;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xSectorSize@
fp_name << find_struct_fp_assignment_xSectorSize.FP_NAME;
func_name << find_struct_fp_assignment_xSectorSize.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSectorSize.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xSectorSize@
fp_name << find_init_fp_assignment_xSectorSize.FP_NAME;
func_name << find_init_fp_assignment_xSectorSize.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSectorSize.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xTestCallback@
expression E;
identifier FP_NAME = xTestCallback;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xTestCallback@
identifier FP_NAME = xTestCallback;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xTestCallback@
fp_name << find_struct_fp_assignment_xTestCallback.FP_NAME;
func_name << find_struct_fp_assignment_xTestCallback.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xTestCallback.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xTestCallback@
fp_name << find_init_fp_assignment_xTestCallback.FP_NAME;
func_name << find_init_fp_assignment_xTestCallback.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xTestCallback.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_column_bytes16@
expression E;
identifier FP_NAME = column_bytes16;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_column_bytes16@
identifier FP_NAME = column_bytes16;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_column_bytes16@
fp_name << find_struct_fp_assignment_column_bytes16.FP_NAME;
func_name << find_struct_fp_assignment_column_bytes16.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_bytes16.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_column_bytes16@
fp_name << find_init_fp_assignment_column_bytes16.FP_NAME;
func_name << find_init_fp_assignment_column_bytes16.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_bytes16.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_value_subtype@
expression E;
identifier FP_NAME = value_subtype;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_value_subtype@
identifier FP_NAME = value_subtype;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_value_subtype@
fp_name << find_struct_fp_assignment_value_subtype.FP_NAME;
func_name << find_struct_fp_assignment_value_subtype.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_subtype.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_value_subtype@
fp_name << find_init_fp_assignment_value_subtype.FP_NAME;
func_name << find_init_fp_assignment_value_subtype.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_subtype.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_total_changes64@
expression E;
identifier FP_NAME = total_changes64;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_total_changes64@
identifier FP_NAME = total_changes64;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_total_changes64@
fp_name << find_struct_fp_assignment_total_changes64.FP_NAME;
func_name << find_struct_fp_assignment_total_changes64.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/total_changes64.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_total_changes64@
fp_name << find_init_fp_assignment_total_changes64.FP_NAME;
func_name << find_init_fp_assignment_total_changes64.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/total_changes64.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_sleep@
expression E;
identifier FP_NAME = sleep;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_sleep@
identifier FP_NAME = sleep;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_sleep@
fp_name << find_struct_fp_assignment_sleep.FP_NAME;
func_name << find_struct_fp_assignment_sleep.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/sleep.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_sleep@
fp_name << find_init_fp_assignment_sleep.FP_NAME;
func_name << find_init_fp_assignment_sleep.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/sleep.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_bind_parameter_name@
expression E;
identifier FP_NAME = bind_parameter_name;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_bind_parameter_name@
identifier FP_NAME = bind_parameter_name;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_bind_parameter_name@
fp_name << find_struct_fp_assignment_bind_parameter_name.FP_NAME;
func_name << find_struct_fp_assignment_bind_parameter_name.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/bind_parameter_name.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_bind_parameter_name@
fp_name << find_init_fp_assignment_bind_parameter_name.FP_NAME;
func_name << find_init_fp_assignment_bind_parameter_name.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/bind_parameter_name.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_finalize@
expression E;
identifier FP_NAME = finalize;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_finalize@
identifier FP_NAME = finalize;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_finalize@
fp_name << find_struct_fp_assignment_finalize.FP_NAME;
func_name << find_struct_fp_assignment_finalize.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/finalize.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_finalize@
fp_name << find_init_fp_assignment_finalize.FP_NAME;
func_name << find_init_fp_assignment_finalize.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/finalize.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_column_database_name16@
expression E;
identifier FP_NAME = column_database_name16;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_column_database_name16@
identifier FP_NAME = column_database_name16;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_column_database_name16@
fp_name << find_struct_fp_assignment_column_database_name16.FP_NAME;
func_name << find_struct_fp_assignment_column_database_name16.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_database_name16.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_column_database_name16@
fp_name << find_init_fp_assignment_column_database_name16.FP_NAME;
func_name << find_init_fp_assignment_column_database_name16.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_database_name16.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xCond@
expression E;
identifier FP_NAME = xCond;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xCond@
identifier FP_NAME = xCond;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xCond@
fp_name << find_struct_fp_assignment_xCond.FP_NAME;
func_name << find_struct_fp_assignment_xCond.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCond.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xCond@
fp_name << find_init_fp_assignment_xCond.FP_NAME;
func_name << find_init_fp_assignment_xCond.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCond.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_changes@
expression E;
identifier FP_NAME = changes;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_changes@
identifier FP_NAME = changes;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_changes@
fp_name << find_struct_fp_assignment_changes.FP_NAME;
func_name << find_struct_fp_assignment_changes.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/changes.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_changes@
fp_name << find_init_fp_assignment_changes.FP_NAME;
func_name << find_init_fp_assignment_changes.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/changes.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_prepare16_v3@
expression E;
identifier FP_NAME = prepare16_v3;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_prepare16_v3@
identifier FP_NAME = prepare16_v3;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_prepare16_v3@
fp_name << find_struct_fp_assignment_prepare16_v3.FP_NAME;
func_name << find_struct_fp_assignment_prepare16_v3.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/prepare16_v3.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_prepare16_v3@
fp_name << find_init_fp_assignment_prepare16_v3.FP_NAME;
func_name << find_init_fp_assignment_prepare16_v3.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/prepare16_v3.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_data_count@
expression E;
identifier FP_NAME = data_count;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_data_count@
identifier FP_NAME = data_count;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_data_count@
fp_name << find_struct_fp_assignment_data_count.FP_NAME;
func_name << find_struct_fp_assignment_data_count.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/data_count.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_data_count@
fp_name << find_init_fp_assignment_data_count.FP_NAME;
func_name << find_init_fp_assignment_data_count.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/data_count.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_column_name16@
expression E;
identifier FP_NAME = column_name16;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_column_name16@
identifier FP_NAME = column_name16;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_column_name16@
fp_name << find_struct_fp_assignment_column_name16.FP_NAME;
func_name << find_struct_fp_assignment_column_name16.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_name16.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_column_name16@
fp_name << find_init_fp_assignment_column_name16.FP_NAME;
func_name << find_init_fp_assignment_column_name16.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_name16.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_vtab_on_conflict@
expression E;
identifier FP_NAME = vtab_on_conflict;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_vtab_on_conflict@
identifier FP_NAME = vtab_on_conflict;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_vtab_on_conflict@
fp_name << find_struct_fp_assignment_vtab_on_conflict.FP_NAME;
func_name << find_struct_fp_assignment_vtab_on_conflict.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vtab_on_conflict.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_vtab_on_conflict@
fp_name << find_init_fp_assignment_vtab_on_conflict.FP_NAME;
func_name << find_init_fp_assignment_vtab_on_conflict.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vtab_on_conflict.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xDelete@
expression E;
identifier FP_NAME = xDelete;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xDelete@
identifier FP_NAME = xDelete;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xDelete@
fp_name << find_struct_fp_assignment_xDelete.FP_NAME;
func_name << find_struct_fp_assignment_xDelete.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDelete.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xDelete@
fp_name << find_init_fp_assignment_xDelete.FP_NAME;
func_name << find_init_fp_assignment_xDelete.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDelete.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xDepth@
expression E;
identifier FP_NAME = xDepth;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xDepth@
identifier FP_NAME = xDepth;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xDepth@
fp_name << find_struct_fp_assignment_xDepth.FP_NAME;
func_name << find_struct_fp_assignment_xDepth.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDepth.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xDepth@
fp_name << find_init_fp_assignment_xDepth.FP_NAME;
func_name << find_init_fp_assignment_xDepth.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDepth.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xDeviceCharacteristics@
expression E;
identifier FP_NAME = xDeviceCharacteristics;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xDeviceCharacteristics@
identifier FP_NAME = xDeviceCharacteristics;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xDeviceCharacteristics@
fp_name << find_struct_fp_assignment_xDeviceCharacteristics.FP_NAME;
func_name << find_struct_fp_assignment_xDeviceCharacteristics.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDeviceCharacteristics.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xDeviceCharacteristics@
fp_name << find_init_fp_assignment_xDeviceCharacteristics.FP_NAME;
func_name << find_init_fp_assignment_xDeviceCharacteristics.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDeviceCharacteristics.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xFileControl@
expression E;
identifier FP_NAME = xFileControl;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xFileControl@
identifier FP_NAME = xFileControl;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xFileControl@
fp_name << find_struct_fp_assignment_xFileControl.FP_NAME;
func_name << find_struct_fp_assignment_xFileControl.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFileControl.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xFileControl@
fp_name << find_init_fp_assignment_xFileControl.FP_NAME;
func_name << find_init_fp_assignment_xFileControl.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFileControl.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_filename_journal@
expression E;
identifier FP_NAME = filename_journal;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_filename_journal@
identifier FP_NAME = filename_journal;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_filename_journal@
fp_name << find_struct_fp_assignment_filename_journal.FP_NAME;
func_name << find_struct_fp_assignment_filename_journal.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/filename_journal.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_filename_journal@
fp_name << find_init_fp_assignment_filename_journal.FP_NAME;
func_name << find_init_fp_assignment_filename_journal.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/filename_journal.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xQueryToken@
expression E;
identifier FP_NAME = xQueryToken;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xQueryToken@
identifier FP_NAME = xQueryToken;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xQueryToken@
fp_name << find_struct_fp_assignment_xQueryToken.FP_NAME;
func_name << find_struct_fp_assignment_xQueryToken.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xQueryToken.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xQueryToken@
fp_name << find_init_fp_assignment_xQueryToken.FP_NAME;
func_name << find_init_fp_assignment_xQueryToken.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xQueryToken.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_realloc@
expression E;
identifier FP_NAME = realloc;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_realloc@
identifier FP_NAME = realloc;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_realloc@
fp_name << find_struct_fp_assignment_realloc.FP_NAME;
func_name << find_struct_fp_assignment_realloc.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/realloc.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_realloc@
fp_name << find_init_fp_assignment_realloc.FP_NAME;
func_name << find_init_fp_assignment_realloc.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/realloc.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xSelectCallback2@
expression E;
identifier FP_NAME = xSelectCallback2;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xSelectCallback2@
identifier FP_NAME = xSelectCallback2;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xSelectCallback2@
fp_name << find_struct_fp_assignment_xSelectCallback2.FP_NAME;
func_name << find_struct_fp_assignment_xSelectCallback2.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSelectCallback2.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xSelectCallback2@
fp_name << find_init_fp_assignment_xSelectCallback2.FP_NAME;
func_name << find_init_fp_assignment_xSelectCallback2.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSelectCallback2.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xPhraseSize@
expression E;
identifier FP_NAME = xPhraseSize;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xPhraseSize@
identifier FP_NAME = xPhraseSize;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xPhraseSize@
fp_name << find_struct_fp_assignment_xPhraseSize.FP_NAME;
func_name << find_struct_fp_assignment_xPhraseSize.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xPhraseSize.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xPhraseSize@
fp_name << find_init_fp_assignment_xPhraseSize.FP_NAME;
func_name << find_init_fp_assignment_xPhraseSize.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xPhraseSize.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_bind_double@
expression E;
identifier FP_NAME = bind_double;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_bind_double@
identifier FP_NAME = bind_double;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_bind_double@
fp_name << find_struct_fp_assignment_bind_double.FP_NAME;
func_name << find_struct_fp_assignment_bind_double.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/bind_double.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_bind_double@
fp_name << find_init_fp_assignment_bind_double.FP_NAME;
func_name << find_init_fp_assignment_bind_double.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/bind_double.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_error@
expression E;
identifier FP_NAME = error;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_error@
identifier FP_NAME = error;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_error@
fp_name << find_struct_fp_assignment_error.FP_NAME;
func_name << find_struct_fp_assignment_error.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/error.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_error@
fp_name << find_init_fp_assignment_error.FP_NAME;
func_name << find_init_fp_assignment_error.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/error.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xBenignBegin@
expression E;
identifier FP_NAME = xBenignBegin;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xBenignBegin@
identifier FP_NAME = xBenignBegin;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xBenignBegin@
fp_name << find_struct_fp_assignment_xBenignBegin.FP_NAME;
func_name << find_struct_fp_assignment_xBenignBegin.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xBenignBegin.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xBenignBegin@
fp_name << find_init_fp_assignment_xBenignBegin.FP_NAME;
func_name << find_init_fp_assignment_xBenignBegin.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xBenignBegin.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_wal_checkpoint_v2@
expression E;
identifier FP_NAME = wal_checkpoint_v2;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_wal_checkpoint_v2@
identifier FP_NAME = wal_checkpoint_v2;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_wal_checkpoint_v2@
fp_name << find_struct_fp_assignment_wal_checkpoint_v2.FP_NAME;
func_name << find_struct_fp_assignment_wal_checkpoint_v2.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/wal_checkpoint_v2.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_wal_checkpoint_v2@
fp_name << find_init_fp_assignment_wal_checkpoint_v2.FP_NAME;
func_name << find_init_fp_assignment_wal_checkpoint_v2.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/wal_checkpoint_v2.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_strerror@
expression E;
identifier FP_NAME = strerror;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_strerror@
identifier FP_NAME = strerror;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_strerror@
fp_name << find_struct_fp_assignment_strerror.FP_NAME;
func_name << find_struct_fp_assignment_strerror.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/strerror.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_strerror@
fp_name << find_init_fp_assignment_strerror.FP_NAME;
func_name << find_init_fp_assignment_strerror.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/strerror.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_hashFunction@
expression E;
identifier FP_NAME = hashFunction;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_hashFunction@
identifier FP_NAME = hashFunction;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_hashFunction@
fp_name << find_struct_fp_assignment_hashFunction.FP_NAME;
func_name << find_struct_fp_assignment_hashFunction.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/hashFunction.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_hashFunction@
fp_name << find_init_fp_assignment_hashFunction.FP_NAME;
func_name << find_init_fp_assignment_hashFunction.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/hashFunction.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_value_pointer@
expression E;
identifier FP_NAME = value_pointer;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_value_pointer@
identifier FP_NAME = value_pointer;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_value_pointer@
fp_name << find_struct_fp_assignment_value_pointer.FP_NAME;
func_name << find_struct_fp_assignment_value_pointer.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_pointer.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_value_pointer@
fp_name << find_init_fp_assignment_value_pointer.FP_NAME;
func_name << find_init_fp_assignment_value_pointer.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_pointer.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xParseCell@
expression E;
identifier FP_NAME = xParseCell;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xParseCell@
identifier FP_NAME = xParseCell;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xParseCell@
fp_name << find_struct_fp_assignment_xParseCell.FP_NAME;
func_name << find_struct_fp_assignment_xParseCell.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xParseCell.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xParseCell@
fp_name << find_init_fp_assignment_xParseCell.FP_NAME;
func_name << find_init_fp_assignment_xParseCell.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xParseCell.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xFetch@
expression E;
identifier FP_NAME = xFetch;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xFetch@
identifier FP_NAME = xFetch;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xFetch@
fp_name << find_struct_fp_assignment_xFetch.FP_NAME;
func_name << find_struct_fp_assignment_xFetch.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFetch.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xFetch@
fp_name << find_init_fp_assignment_xFetch.FP_NAME;
func_name << find_init_fp_assignment_xFetch.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFetch.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_value_int64@
expression E;
identifier FP_NAME = value_int64;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_value_int64@
identifier FP_NAME = value_int64;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_value_int64@
fp_name << find_struct_fp_assignment_value_int64.FP_NAME;
func_name << find_struct_fp_assignment_value_int64.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_int64.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_value_int64@
fp_name << find_init_fp_assignment_value_int64.FP_NAME;
func_name << find_init_fp_assignment_value_int64.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_int64.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xSavepoint@
expression E;
identifier FP_NAME = xSavepoint;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xSavepoint@
identifier FP_NAME = xSavepoint;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xSavepoint@
fp_name << find_struct_fp_assignment_xSavepoint.FP_NAME;
func_name << find_struct_fp_assignment_xSavepoint.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSavepoint.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xSavepoint@
fp_name << find_init_fp_assignment_xSavepoint.FP_NAME;
func_name << find_init_fp_assignment_xSavepoint.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSavepoint.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_hard_heap_limit64@
expression E;
identifier FP_NAME = hard_heap_limit64;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_hard_heap_limit64@
identifier FP_NAME = hard_heap_limit64;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_hard_heap_limit64@
fp_name << find_struct_fp_assignment_hard_heap_limit64.FP_NAME;
func_name << find_struct_fp_assignment_hard_heap_limit64.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/hard_heap_limit64.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_hard_heap_limit64@
fp_name << find_init_fp_assignment_hard_heap_limit64.FP_NAME;
func_name << find_init_fp_assignment_hard_heap_limit64.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/hard_heap_limit64.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_str_append@
expression E;
identifier FP_NAME = str_append;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_str_append@
identifier FP_NAME = str_append;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_str_append@
fp_name << find_struct_fp_assignment_str_append.FP_NAME;
func_name << find_struct_fp_assignment_str_append.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/str_append.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_str_append@
fp_name << find_init_fp_assignment_str_append.FP_NAME;
func_name << find_init_fp_assignment_str_append.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/str_append.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xFreeSchema@
expression E;
identifier FP_NAME = xFreeSchema;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xFreeSchema@
identifier FP_NAME = xFreeSchema;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xFreeSchema@
fp_name << find_struct_fp_assignment_xFreeSchema.FP_NAME;
func_name << find_struct_fp_assignment_xFreeSchema.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFreeSchema.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xFreeSchema@
fp_name << find_init_fp_assignment_xFreeSchema.FP_NAME;
func_name << find_init_fp_assignment_xFreeSchema.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFreeSchema.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_memory_used@
expression E;
identifier FP_NAME = memory_used;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_memory_used@
identifier FP_NAME = memory_used;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_memory_used@
fp_name << find_struct_fp_assignment_memory_used.FP_NAME;
func_name << find_struct_fp_assignment_memory_used.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/memory_used.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_memory_used@
fp_name << find_init_fp_assignment_memory_used.FP_NAME;
func_name << find_init_fp_assignment_memory_used.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/memory_used.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_column_int64@
expression E;
identifier FP_NAME = column_int64;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_column_int64@
identifier FP_NAME = column_int64;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_column_int64@
fp_name << find_struct_fp_assignment_column_int64.FP_NAME;
func_name << find_struct_fp_assignment_column_int64.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_int64.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_column_int64@
fp_name << find_init_fp_assignment_column_int64.FP_NAME;
func_name << find_init_fp_assignment_column_int64.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_int64.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_value_numeric_type@
expression E;
identifier FP_NAME = value_numeric_type;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_value_numeric_type@
identifier FP_NAME = value_numeric_type;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_value_numeric_type@
fp_name << find_struct_fp_assignment_value_numeric_type.FP_NAME;
func_name << find_struct_fp_assignment_value_numeric_type.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_numeric_type.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_value_numeric_type@
fp_name << find_init_fp_assignment_value_numeric_type.FP_NAME;
func_name << find_init_fp_assignment_value_numeric_type.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_numeric_type.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xRowid@
expression E;
identifier FP_NAME = xRowid;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xRowid@
identifier FP_NAME = xRowid;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xRowid@
fp_name << find_struct_fp_assignment_xRowid.FP_NAME;
func_name << find_struct_fp_assignment_xRowid.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRowid.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xRowid@
fp_name << find_init_fp_assignment_xRowid.FP_NAME;
func_name << find_init_fp_assignment_xRowid.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRowid.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_declare_vtab@
expression E;
identifier FP_NAME = declare_vtab;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_declare_vtab@
identifier FP_NAME = declare_vtab;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_declare_vtab@
fp_name << find_struct_fp_assignment_declare_vtab.FP_NAME;
func_name << find_struct_fp_assignment_declare_vtab.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/declare_vtab.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_declare_vtab@
fp_name << find_init_fp_assignment_declare_vtab.FP_NAME;
func_name << find_init_fp_assignment_declare_vtab.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/declare_vtab.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_column_int@
expression E;
identifier FP_NAME = column_int;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_column_int@
identifier FP_NAME = column_int;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_column_int@
fp_name << find_struct_fp_assignment_column_int.FP_NAME;
func_name << find_struct_fp_assignment_column_int.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_int.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_column_int@
fp_name << find_init_fp_assignment_column_int.FP_NAME;
func_name << find_init_fp_assignment_column_int.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_int.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_errmsg16@
expression E;
identifier FP_NAME = errmsg16;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_errmsg16@
identifier FP_NAME = errmsg16;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_errmsg16@
fp_name << find_struct_fp_assignment_errmsg16.FP_NAME;
func_name << find_struct_fp_assignment_errmsg16.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/errmsg16.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_errmsg16@
fp_name << find_init_fp_assignment_errmsg16.FP_NAME;
func_name << find_init_fp_assignment_errmsg16.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/errmsg16.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_mutex_try@
expression E;
identifier FP_NAME = mutex_try;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_mutex_try@
identifier FP_NAME = mutex_try;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_mutex_try@
fp_name << find_struct_fp_assignment_mutex_try.FP_NAME;
func_name << find_struct_fp_assignment_mutex_try.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/mutex_try.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_mutex_try@
fp_name << find_init_fp_assignment_mutex_try.FP_NAME;
func_name << find_init_fp_assignment_mutex_try.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/mutex_try.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_result_error_toobig@
expression E;
identifier FP_NAME = result_error_toobig;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_result_error_toobig@
identifier FP_NAME = result_error_toobig;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_result_error_toobig@
fp_name << find_struct_fp_assignment_result_error_toobig.FP_NAME;
func_name << find_struct_fp_assignment_result_error_toobig.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_error_toobig.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_result_error_toobig@
fp_name << find_init_fp_assignment_result_error_toobig.FP_NAME;
func_name << find_init_fp_assignment_result_error_toobig.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_error_toobig.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_vfs_unregister@
expression E;
identifier FP_NAME = vfs_unregister;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_vfs_unregister@
identifier FP_NAME = vfs_unregister;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_vfs_unregister@
fp_name << find_struct_fp_assignment_vfs_unregister.FP_NAME;
func_name << find_struct_fp_assignment_vfs_unregister.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vfs_unregister.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_vfs_unregister@
fp_name << find_init_fp_assignment_vfs_unregister.FP_NAME;
func_name << find_init_fp_assignment_vfs_unregister.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vfs_unregister.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xNew@
expression E;
identifier FP_NAME = xNew;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xNew@
identifier FP_NAME = xNew;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xNew@
fp_name << find_struct_fp_assignment_xNew.FP_NAME;
func_name << find_struct_fp_assignment_xNew.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xNew.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xNew@
fp_name << find_init_fp_assignment_xNew.FP_NAME;
func_name << find_init_fp_assignment_xNew.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xNew.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xInstCount@
expression E;
identifier FP_NAME = xInstCount;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xInstCount@
identifier FP_NAME = xInstCount;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xInstCount@
fp_name << find_struct_fp_assignment_xInstCount.FP_NAME;
func_name << find_struct_fp_assignment_xInstCount.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xInstCount.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xInstCount@
fp_name << find_init_fp_assignment_xInstCount.FP_NAME;
func_name << find_init_fp_assignment_xInstCount.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xInstCount.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_bind_value@
expression E;
identifier FP_NAME = bind_value;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_bind_value@
identifier FP_NAME = bind_value;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_bind_value@
fp_name << find_struct_fp_assignment_bind_value.FP_NAME;
func_name << find_struct_fp_assignment_bind_value.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/bind_value.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_bind_value@
fp_name << find_init_fp_assignment_bind_value.FP_NAME;
func_name << find_init_fp_assignment_bind_value.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/bind_value.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xMutexEnter@
expression E;
identifier FP_NAME = xMutexEnter;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xMutexEnter@
identifier FP_NAME = xMutexEnter;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xMutexEnter@
fp_name << find_struct_fp_assignment_xMutexEnter.FP_NAME;
func_name << find_struct_fp_assignment_xMutexEnter.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xMutexEnter.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xMutexEnter@
fp_name << find_init_fp_assignment_xMutexEnter.FP_NAME;
func_name << find_init_fp_assignment_xMutexEnter.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xMutexEnter.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_str_appendall@
expression E;
identifier FP_NAME = str_appendall;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_str_appendall@
identifier FP_NAME = str_appendall;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_str_appendall@
fp_name << find_struct_fp_assignment_str_appendall.FP_NAME;
func_name << find_struct_fp_assignment_str_appendall.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/str_appendall.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_str_appendall@
fp_name << find_init_fp_assignment_str_appendall.FP_NAME;
func_name << find_init_fp_assignment_str_appendall.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/str_appendall.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_value_frombind@
expression E;
identifier FP_NAME = value_frombind;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_value_frombind@
identifier FP_NAME = value_frombind;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_value_frombind@
fp_name << find_struct_fp_assignment_value_frombind.FP_NAME;
func_name << find_struct_fp_assignment_value_frombind.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_frombind.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_value_frombind@
fp_name << find_init_fp_assignment_value_frombind.FP_NAME;
func_name << find_init_fp_assignment_value_frombind.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_frombind.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_db_release_memory@
expression E;
identifier FP_NAME = db_release_memory;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_db_release_memory@
identifier FP_NAME = db_release_memory;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_db_release_memory@
fp_name << find_struct_fp_assignment_db_release_memory.FP_NAME;
func_name << find_struct_fp_assignment_db_release_memory.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/db_release_memory.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_db_release_memory@
fp_name << find_init_fp_assignment_db_release_memory.FP_NAME;
func_name << find_init_fp_assignment_db_release_memory.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/db_release_memory.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_serialize@
expression E;
identifier FP_NAME = serialize;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_serialize@
identifier FP_NAME = serialize;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_serialize@
fp_name << find_struct_fp_assignment_serialize.FP_NAME;
func_name << find_struct_fp_assignment_serialize.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/serialize.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_serialize@
fp_name << find_init_fp_assignment_serialize.FP_NAME;
func_name << find_init_fp_assignment_serialize.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/serialize.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_stmt_status@
expression E;
identifier FP_NAME = stmt_status;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_stmt_status@
identifier FP_NAME = stmt_status;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_stmt_status@
fp_name << find_struct_fp_assignment_stmt_status.FP_NAME;
func_name << find_struct_fp_assignment_stmt_status.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/stmt_status.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_stmt_status@
fp_name << find_init_fp_assignment_stmt_status.FP_NAME;
func_name << find_init_fp_assignment_stmt_status.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/stmt_status.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xCollNeeded16@
expression E;
identifier FP_NAME = xCollNeeded16;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xCollNeeded16@
identifier FP_NAME = xCollNeeded16;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xCollNeeded16@
fp_name << find_struct_fp_assignment_xCollNeeded16.FP_NAME;
func_name << find_struct_fp_assignment_xCollNeeded16.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCollNeeded16.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xCollNeeded16@
fp_name << find_init_fp_assignment_xCollNeeded16.FP_NAME;
func_name << find_init_fp_assignment_xCollNeeded16.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCollNeeded16.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_reset@
expression E;
identifier FP_NAME = reset;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_reset@
identifier FP_NAME = reset;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_reset@
fp_name << find_struct_fp_assignment_reset.FP_NAME;
func_name << find_struct_fp_assignment_reset.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/reset.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_reset@
fp_name << find_init_fp_assignment_reset.FP_NAME;
func_name << find_init_fp_assignment_reset.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/reset.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_reset_auto_extension@
expression E;
identifier FP_NAME = reset_auto_extension;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_reset_auto_extension@
identifier FP_NAME = reset_auto_extension;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_reset_auto_extension@
fp_name << find_struct_fp_assignment_reset_auto_extension.FP_NAME;
func_name << find_struct_fp_assignment_reset_auto_extension.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/reset_auto_extension.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_reset_auto_extension@
fp_name << find_init_fp_assignment_reset_auto_extension.FP_NAME;
func_name << find_init_fp_assignment_reset_auto_extension.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/reset_auto_extension.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xUpdateCallback@
expression E;
identifier FP_NAME = xUpdateCallback;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xUpdateCallback@
identifier FP_NAME = xUpdateCallback;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xUpdateCallback@
fp_name << find_struct_fp_assignment_xUpdateCallback.FP_NAME;
func_name << find_struct_fp_assignment_xUpdateCallback.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xUpdateCallback.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xUpdateCallback@
fp_name << find_init_fp_assignment_xUpdateCallback.FP_NAME;
func_name << find_init_fp_assignment_xUpdateCallback.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xUpdateCallback.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_enable_shared_cache@
expression E;
identifier FP_NAME = enable_shared_cache;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_enable_shared_cache@
identifier FP_NAME = enable_shared_cache;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_enable_shared_cache@
fp_name << find_struct_fp_assignment_enable_shared_cache.FP_NAME;
func_name << find_struct_fp_assignment_enable_shared_cache.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/enable_shared_cache.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_enable_shared_cache@
fp_name << find_init_fp_assignment_enable_shared_cache.FP_NAME;
func_name << find_init_fp_assignment_enable_shared_cache.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/enable_shared_cache.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xGetLastError@
expression E;
identifier FP_NAME = xGetLastError;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xGetLastError@
identifier FP_NAME = xGetLastError;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xGetLastError@
fp_name << find_struct_fp_assignment_xGetLastError.FP_NAME;
func_name << find_struct_fp_assignment_xGetLastError.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xGetLastError.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xGetLastError@
fp_name << find_init_fp_assignment_xGetLastError.FP_NAME;
func_name << find_init_fp_assignment_xGetLastError.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xGetLastError.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xSetOutputs@
expression E;
identifier FP_NAME = xSetOutputs;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xSetOutputs@
identifier FP_NAME = xSetOutputs;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xSetOutputs@
fp_name << find_struct_fp_assignment_xSetOutputs.FP_NAME;
func_name << find_struct_fp_assignment_xSetOutputs.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSetOutputs.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xSetOutputs@
fp_name << find_init_fp_assignment_xSetOutputs.FP_NAME;
func_name << find_init_fp_assignment_xSetOutputs.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSetOutputs.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_value_free@
expression E;
identifier FP_NAME = value_free;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_value_free@
identifier FP_NAME = value_free;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_value_free@
fp_name << find_struct_fp_assignment_value_free.FP_NAME;
func_name << find_struct_fp_assignment_value_free.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_free.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_value_free@
fp_name << find_init_fp_assignment_value_free.FP_NAME;
func_name << find_init_fp_assignment_value_free.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_free.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xUnfetch@
expression E;
identifier FP_NAME = xUnfetch;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xUnfetch@
identifier FP_NAME = xUnfetch;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xUnfetch@
fp_name << find_struct_fp_assignment_xUnfetch.FP_NAME;
func_name << find_struct_fp_assignment_xUnfetch.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xUnfetch.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xUnfetch@
fp_name << find_init_fp_assignment_xUnfetch.FP_NAME;
func_name << find_init_fp_assignment_xUnfetch.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xUnfetch.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_deserialize@
expression E;
identifier FP_NAME = deserialize;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_deserialize@
identifier FP_NAME = deserialize;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_deserialize@
fp_name << find_struct_fp_assignment_deserialize.FP_NAME;
func_name << find_struct_fp_assignment_deserialize.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/deserialize.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_deserialize@
fp_name << find_init_fp_assignment_deserialize.FP_NAME;
func_name << find_init_fp_assignment_deserialize.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/deserialize.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_stmt_readonly@
expression E;
identifier FP_NAME = stmt_readonly;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_stmt_readonly@
identifier FP_NAME = stmt_readonly;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_stmt_readonly@
fp_name << find_struct_fp_assignment_stmt_readonly.FP_NAME;
func_name << find_struct_fp_assignment_stmt_readonly.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/stmt_readonly.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_stmt_readonly@
fp_name << find_init_fp_assignment_stmt_readonly.FP_NAME;
func_name << find_init_fp_assignment_stmt_readonly.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/stmt_readonly.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xNextChar@
expression E;
identifier FP_NAME = xNextChar;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xNextChar@
identifier FP_NAME = xNextChar;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xNextChar@
fp_name << find_struct_fp_assignment_xNextChar.FP_NAME;
func_name << find_struct_fp_assignment_xNextChar.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xNextChar.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xNextChar@
fp_name << find_init_fp_assignment_xNextChar.FP_NAME;
func_name << find_init_fp_assignment_xNextChar.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xNextChar.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_bind_zeroblob64@
expression E;
identifier FP_NAME = bind_zeroblob64;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_bind_zeroblob64@
identifier FP_NAME = bind_zeroblob64;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_bind_zeroblob64@
fp_name << find_struct_fp_assignment_bind_zeroblob64.FP_NAME;
func_name << find_struct_fp_assignment_bind_zeroblob64.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/bind_zeroblob64.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_bind_zeroblob64@
fp_name << find_init_fp_assignment_bind_zeroblob64.FP_NAME;
func_name << find_init_fp_assignment_bind_zeroblob64.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/bind_zeroblob64.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xInstToken@
expression E;
identifier FP_NAME = xInstToken;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xInstToken@
identifier FP_NAME = xInstToken;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xInstToken@
fp_name << find_struct_fp_assignment_xInstToken.FP_NAME;
func_name << find_struct_fp_assignment_xInstToken.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xInstToken.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xInstToken@
fp_name << find_init_fp_assignment_xInstToken.FP_NAME;
func_name << find_init_fp_assignment_xInstToken.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xInstToken.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xTest@
expression E;
identifier FP_NAME = xTest;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xTest@
identifier FP_NAME = xTest;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xTest@
fp_name << find_struct_fp_assignment_xTest.FP_NAME;
func_name << find_struct_fp_assignment_xTest.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xTest.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xTest@
fp_name << find_init_fp_assignment_xTest.FP_NAME;
func_name << find_init_fp_assignment_xTest.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xTest.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xUnpin@
expression E;
identifier FP_NAME = xUnpin;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xUnpin@
identifier FP_NAME = xUnpin;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xUnpin@
fp_name << find_struct_fp_assignment_xUnpin.FP_NAME;
func_name << find_struct_fp_assignment_xUnpin.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xUnpin.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xUnpin@
fp_name << find_init_fp_assignment_xUnpin.FP_NAME;
func_name << find_init_fp_assignment_xUnpin.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xUnpin.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xMutexTry@
expression E;
identifier FP_NAME = xMutexTry;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xMutexTry@
identifier FP_NAME = xMutexTry;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xMutexTry@
fp_name << find_struct_fp_assignment_xMutexTry.FP_NAME;
func_name << find_struct_fp_assignment_xMutexTry.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xMutexTry.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xMutexTry@
fp_name << find_init_fp_assignment_xMutexTry.FP_NAME;
func_name << find_init_fp_assignment_xMutexTry.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xMutexTry.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xPhraseFirstColumn@
expression E;
identifier FP_NAME = xPhraseFirstColumn;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xPhraseFirstColumn@
identifier FP_NAME = xPhraseFirstColumn;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xPhraseFirstColumn@
fp_name << find_struct_fp_assignment_xPhraseFirstColumn.FP_NAME;
func_name << find_struct_fp_assignment_xPhraseFirstColumn.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xPhraseFirstColumn.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xPhraseFirstColumn@
fp_name << find_init_fp_assignment_xPhraseFirstColumn.FP_NAME;
func_name << find_init_fp_assignment_xPhraseFirstColumn.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xPhraseFirstColumn.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_value_type@
expression E;
identifier FP_NAME = value_type;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_value_type@
identifier FP_NAME = value_type;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_value_type@
fp_name << find_struct_fp_assignment_value_type.FP_NAME;
func_name << find_struct_fp_assignment_value_type.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_type.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_value_type@
fp_name << find_init_fp_assignment_value_type.FP_NAME;
func_name << find_init_fp_assignment_value_type.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_type.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_get_autocommit@
expression E;
identifier FP_NAME = get_autocommit;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_get_autocommit@
identifier FP_NAME = get_autocommit;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_get_autocommit@
fp_name << find_struct_fp_assignment_get_autocommit.FP_NAME;
func_name << find_struct_fp_assignment_get_autocommit.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/get_autocommit.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_get_autocommit@
fp_name << find_init_fp_assignment_get_autocommit.FP_NAME;
func_name << find_init_fp_assignment_get_autocommit.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/get_autocommit.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xGetSystemCall@
expression E;
identifier FP_NAME = xGetSystemCall;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xGetSystemCall@
identifier FP_NAME = xGetSystemCall;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xGetSystemCall@
fp_name << find_struct_fp_assignment_xGetSystemCall.FP_NAME;
func_name << find_struct_fp_assignment_xGetSystemCall.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xGetSystemCall.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xGetSystemCall@
fp_name << find_init_fp_assignment_xGetSystemCall.FP_NAME;
func_name << find_init_fp_assignment_xGetSystemCall.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xGetSystemCall.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_test_control@
expression E;
identifier FP_NAME = test_control;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_test_control@
identifier FP_NAME = test_control;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_test_control@
fp_name << find_struct_fp_assignment_test_control.FP_NAME;
func_name << find_struct_fp_assignment_test_control.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/test_control.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_test_control@
fp_name << find_init_fp_assignment_test_control.FP_NAME;
func_name << find_init_fp_assignment_test_control.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/test_control.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_status@
expression E;
identifier FP_NAME = status;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_status@
identifier FP_NAME = status;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_status@
fp_name << find_struct_fp_assignment_status.FP_NAME;
func_name << find_struct_fp_assignment_status.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/status.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_status@
fp_name << find_init_fp_assignment_status.FP_NAME;
func_name << find_init_fp_assignment_status.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/status.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xAutovacDestr@
expression E;
identifier FP_NAME = xAutovacDestr;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xAutovacDestr@
identifier FP_NAME = xAutovacDestr;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xAutovacDestr@
fp_name << find_struct_fp_assignment_xAutovacDestr.FP_NAME;
func_name << find_struct_fp_assignment_xAutovacDestr.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xAutovacDestr.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xAutovacDestr@
fp_name << find_init_fp_assignment_xAutovacDestr.FP_NAME;
func_name << find_init_fp_assignment_xAutovacDestr.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xAutovacDestr.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_setlk_timeout@
expression E;
identifier FP_NAME = setlk_timeout;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_setlk_timeout@
identifier FP_NAME = setlk_timeout;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_setlk_timeout@
fp_name << find_struct_fp_assignment_setlk_timeout.FP_NAME;
func_name << find_struct_fp_assignment_setlk_timeout.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/setlk_timeout.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_setlk_timeout@
fp_name << find_init_fp_assignment_setlk_timeout.FP_NAME;
func_name << find_init_fp_assignment_setlk_timeout.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/setlk_timeout.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_column_origin_name@
expression E;
identifier FP_NAME = column_origin_name;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_column_origin_name@
identifier FP_NAME = column_origin_name;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_column_origin_name@
fp_name << find_struct_fp_assignment_column_origin_name.FP_NAME;
func_name << find_struct_fp_assignment_column_origin_name.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_origin_name.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_column_origin_name@
fp_name << find_init_fp_assignment_column_origin_name.FP_NAME;
func_name << find_init_fp_assignment_column_origin_name.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_origin_name.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_vtab_in_next@
expression E;
identifier FP_NAME = vtab_in_next;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_vtab_in_next@
identifier FP_NAME = vtab_in_next;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_vtab_in_next@
fp_name << find_struct_fp_assignment_vtab_in_next.FP_NAME;
func_name << find_struct_fp_assignment_vtab_in_next.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vtab_in_next.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_vtab_in_next@
fp_name << find_init_fp_assignment_vtab_in_next.FP_NAME;
func_name << find_init_fp_assignment_vtab_in_next.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vtab_in_next.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_wal_checkpoint@
expression E;
identifier FP_NAME = wal_checkpoint;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_wal_checkpoint@
identifier FP_NAME = wal_checkpoint;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_wal_checkpoint@
fp_name << find_struct_fp_assignment_wal_checkpoint.FP_NAME;
func_name << find_struct_fp_assignment_wal_checkpoint.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/wal_checkpoint.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_wal_checkpoint@
fp_name << find_init_fp_assignment_wal_checkpoint.FP_NAME;
func_name << find_init_fp_assignment_wal_checkpoint.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/wal_checkpoint.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_keyword_check@
expression E;
identifier FP_NAME = keyword_check;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_keyword_check@
identifier FP_NAME = keyword_check;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_keyword_check@
fp_name << find_struct_fp_assignment_keyword_check.FP_NAME;
func_name << find_struct_fp_assignment_keyword_check.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/keyword_check.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_keyword_check@
fp_name << find_init_fp_assignment_keyword_check.FP_NAME;
func_name << find_init_fp_assignment_keyword_check.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/keyword_check.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xIntegrity@
expression E;
identifier FP_NAME = xIntegrity;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xIntegrity@
identifier FP_NAME = xIntegrity;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xIntegrity@
fp_name << find_struct_fp_assignment_xIntegrity.FP_NAME;
func_name << find_struct_fp_assignment_xIntegrity.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xIntegrity.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xIntegrity@
fp_name << find_init_fp_assignment_xIntegrity.FP_NAME;
func_name << find_init_fp_assignment_xIntegrity.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xIntegrity.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_blob_close@
expression E;
identifier FP_NAME = blob_close;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_blob_close@
identifier FP_NAME = blob_close;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_blob_close@
fp_name << find_struct_fp_assignment_blob_close.FP_NAME;
func_name << find_struct_fp_assignment_blob_close.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/blob_close.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_blob_close@
fp_name << find_init_fp_assignment_blob_close.FP_NAME;
func_name << find_init_fp_assignment_blob_close.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/blob_close.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xRowCount@
expression E;
identifier FP_NAME = xRowCount;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xRowCount@
identifier FP_NAME = xRowCount;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xRowCount@
fp_name << find_struct_fp_assignment_xRowCount.FP_NAME;
func_name << find_struct_fp_assignment_xRowCount.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRowCount.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xRowCount@
fp_name << find_init_fp_assignment_xRowCount.FP_NAME;
func_name << find_init_fp_assignment_xRowCount.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRowCount.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_column_database_name@
expression E;
identifier FP_NAME = column_database_name;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_column_database_name@
identifier FP_NAME = column_database_name;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_column_database_name@
fp_name << find_struct_fp_assignment_column_database_name.FP_NAME;
func_name << find_struct_fp_assignment_column_database_name.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_database_name.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_column_database_name@
fp_name << find_init_fp_assignment_column_database_name.FP_NAME;
func_name << find_init_fp_assignment_column_database_name.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_database_name.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xDlOpen@
expression E;
identifier FP_NAME = xDlOpen;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xDlOpen@
identifier FP_NAME = xDlOpen;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xDlOpen@
fp_name << find_struct_fp_assignment_xDlOpen.FP_NAME;
func_name << find_struct_fp_assignment_xDlOpen.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDlOpen.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xDlOpen@
fp_name << find_init_fp_assignment_xDlOpen.FP_NAME;
func_name << find_init_fp_assignment_xDlOpen.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDlOpen.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xCleanup@
expression E;
identifier FP_NAME = xCleanup;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xCleanup@
identifier FP_NAME = xCleanup;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xCleanup@
fp_name << find_struct_fp_assignment_xCleanup.FP_NAME;
func_name << find_struct_fp_assignment_xCleanup.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCleanup.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xCleanup@
fp_name << find_init_fp_assignment_xCleanup.FP_NAME;
func_name << find_init_fp_assignment_xCleanup.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCleanup.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xStep@
expression E;
identifier FP_NAME = xStep;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xStep@
identifier FP_NAME = xStep;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xStep@
fp_name << find_struct_fp_assignment_xStep.FP_NAME;
func_name << find_struct_fp_assignment_xStep.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xStep.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xStep@
fp_name << find_init_fp_assignment_xStep.FP_NAME;
func_name << find_init_fp_assignment_xStep.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xStep.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xColumnCount@
expression E;
identifier FP_NAME = xColumnCount;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xColumnCount@
identifier FP_NAME = xColumnCount;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xColumnCount@
fp_name << find_struct_fp_assignment_xColumnCount.FP_NAME;
func_name << find_struct_fp_assignment_xColumnCount.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xColumnCount.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xColumnCount@
fp_name << find_init_fp_assignment_xColumnCount.FP_NAME;
func_name << find_init_fp_assignment_xColumnCount.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xColumnCount.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_uri_key@
expression E;
identifier FP_NAME = uri_key;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_uri_key@
identifier FP_NAME = uri_key;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_uri_key@
fp_name << find_struct_fp_assignment_uri_key.FP_NAME;
func_name << find_struct_fp_assignment_uri_key.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/uri_key.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_uri_key@
fp_name << find_init_fp_assignment_uri_key.FP_NAME;
func_name << find_init_fp_assignment_uri_key.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/uri_key.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_sourceid@
expression E;
identifier FP_NAME = sourceid;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_sourceid@
identifier FP_NAME = sourceid;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_sourceid@
fp_name << find_struct_fp_assignment_sourceid.FP_NAME;
func_name << find_struct_fp_assignment_sourceid.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/sourceid.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_sourceid@
fp_name << find_init_fp_assignment_sourceid.FP_NAME;
func_name << find_init_fp_assignment_sourceid.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/sourceid.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_database_file_object@
expression E;
identifier FP_NAME = database_file_object;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_database_file_object@
identifier FP_NAME = database_file_object;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_database_file_object@
fp_name << find_struct_fp_assignment_database_file_object.FP_NAME;
func_name << find_struct_fp_assignment_database_file_object.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/database_file_object.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_database_file_object@
fp_name << find_init_fp_assignment_database_file_object.FP_NAME;
func_name << find_init_fp_assignment_database_file_object.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/database_file_object.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xVdbeBranch@
expression E;
identifier FP_NAME = xVdbeBranch;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xVdbeBranch@
identifier FP_NAME = xVdbeBranch;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xVdbeBranch@
fp_name << find_struct_fp_assignment_xVdbeBranch.FP_NAME;
func_name << find_struct_fp_assignment_xVdbeBranch.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xVdbeBranch.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xVdbeBranch@
fp_name << find_init_fp_assignment_xVdbeBranch.FP_NAME;
func_name << find_init_fp_assignment_xVdbeBranch.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xVdbeBranch.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_keyDup@
expression E;
identifier FP_NAME = keyDup;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_keyDup@
identifier FP_NAME = keyDup;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_keyDup@
fp_name << find_struct_fp_assignment_keyDup.FP_NAME;
func_name << find_struct_fp_assignment_keyDup.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/keyDup.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_keyDup@
fp_name << find_init_fp_assignment_keyDup.FP_NAME;
func_name << find_init_fp_assignment_keyDup.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/keyDup.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_str_value@
expression E;
identifier FP_NAME = str_value;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_str_value@
identifier FP_NAME = str_value;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_str_value@
fp_name << find_struct_fp_assignment_str_value.FP_NAME;
func_name << find_struct_fp_assignment_str_value.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/str_value.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_str_value@
fp_name << find_init_fp_assignment_str_value.FP_NAME;
func_name << find_init_fp_assignment_str_value.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/str_value.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xColumnText@
expression E;
identifier FP_NAME = xColumnText;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xColumnText@
identifier FP_NAME = xColumnText;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xColumnText@
fp_name << find_struct_fp_assignment_xColumnText.FP_NAME;
func_name << find_struct_fp_assignment_xColumnText.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xColumnText.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xColumnText@
fp_name << find_init_fp_assignment_xColumnText.FP_NAME;
func_name << find_init_fp_assignment_xColumnText.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xColumnText.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_result_null@
expression E;
identifier FP_NAME = result_null;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_result_null@
identifier FP_NAME = result_null;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_result_null@
fp_name << find_struct_fp_assignment_result_null.FP_NAME;
func_name << find_struct_fp_assignment_result_null.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_null.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_result_null@
fp_name << find_init_fp_assignment_result_null.FP_NAME;
func_name << find_init_fp_assignment_result_null.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_null.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_vtab_in@
expression E;
identifier FP_NAME = vtab_in;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_vtab_in@
identifier FP_NAME = vtab_in;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_vtab_in@
fp_name << find_struct_fp_assignment_vtab_in.FP_NAME;
func_name << find_struct_fp_assignment_vtab_in.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vtab_in.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_vtab_in@
fp_name << find_init_fp_assignment_vtab_in.FP_NAME;
func_name << find_init_fp_assignment_vtab_in.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vtab_in.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xShmUnmap@
expression E;
identifier FP_NAME = xShmUnmap;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xShmUnmap@
identifier FP_NAME = xShmUnmap;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xShmUnmap@
fp_name << find_struct_fp_assignment_xShmUnmap.FP_NAME;
func_name << find_struct_fp_assignment_xShmUnmap.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xShmUnmap.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xShmUnmap@
fp_name << find_init_fp_assignment_xShmUnmap.FP_NAME;
func_name << find_init_fp_assignment_xShmUnmap.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xShmUnmap.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_interruptx@
expression E;
identifier FP_NAME = interruptx;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_interruptx@
identifier FP_NAME = interruptx;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_interruptx@
fp_name << find_struct_fp_assignment_interruptx.FP_NAME;
func_name << find_struct_fp_assignment_interruptx.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/interruptx.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_interruptx@
fp_name << find_init_fp_assignment_interruptx.FP_NAME;
func_name << find_init_fp_assignment_interruptx.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/interruptx.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xAppend@
expression E;
identifier FP_NAME = xAppend;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xAppend@
identifier FP_NAME = xAppend;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xAppend@
fp_name << find_struct_fp_assignment_xAppend.FP_NAME;
func_name << find_struct_fp_assignment_xAppend.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xAppend.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xAppend@
fp_name << find_init_fp_assignment_xAppend.FP_NAME;
func_name << find_init_fp_assignment_xAppend.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xAppend.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xCellSize@
expression E;
identifier FP_NAME = xCellSize;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xCellSize@
identifier FP_NAME = xCellSize;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xCellSize@
fp_name << find_struct_fp_assignment_xCellSize.FP_NAME;
func_name << find_struct_fp_assignment_xCellSize.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCellSize.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xCellSize@
fp_name << find_init_fp_assignment_xCellSize.FP_NAME;
func_name << find_init_fp_assignment_xCellSize.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCellSize.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_verify@
expression E;
identifier FP_NAME = verify;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_verify@
identifier FP_NAME = verify;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_verify@
fp_name << find_struct_fp_assignment_verify.FP_NAME;
func_name << find_struct_fp_assignment_verify.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/verify.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_verify@
fp_name << find_init_fp_assignment_verify.FP_NAME;
func_name << find_init_fp_assignment_verify.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/verify.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_expired@
expression E;
identifier FP_NAME = expired;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_expired@
identifier FP_NAME = expired;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_expired@
fp_name << find_struct_fp_assignment_expired.FP_NAME;
func_name << find_struct_fp_assignment_expired.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/expired.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_expired@
fp_name << find_init_fp_assignment_expired.FP_NAME;
func_name << find_init_fp_assignment_expired.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/expired.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xSFunc@
expression E;
identifier FP_NAME = xSFunc;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xSFunc@
identifier FP_NAME = xSFunc;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xSFunc@
fp_name << find_struct_fp_assignment_xSFunc.FP_NAME;
func_name << find_struct_fp_assignment_xSFunc.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSFunc.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xSFunc@
fp_name << find_init_fp_assignment_xSFunc.FP_NAME;
func_name << find_init_fp_assignment_xSFunc.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSFunc.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_next_stmt@
expression E;
identifier FP_NAME = next_stmt;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_next_stmt@
identifier FP_NAME = next_stmt;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_next_stmt@
fp_name << find_struct_fp_assignment_next_stmt.FP_NAME;
func_name << find_struct_fp_assignment_next_stmt.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/next_stmt.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_next_stmt@
fp_name << find_init_fp_assignment_next_stmt.FP_NAME;
func_name << find_init_fp_assignment_next_stmt.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/next_stmt.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xQueryFunc@
expression E;
identifier FP_NAME = xQueryFunc;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xQueryFunc@
identifier FP_NAME = xQueryFunc;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xQueryFunc@
fp_name << find_struct_fp_assignment_xQueryFunc.FP_NAME;
func_name << find_struct_fp_assignment_xQueryFunc.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xQueryFunc.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xQueryFunc@
fp_name << find_init_fp_assignment_xQueryFunc.FP_NAME;
func_name << find_init_fp_assignment_xQueryFunc.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xQueryFunc.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_limit@
expression E;
identifier FP_NAME = limit;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_limit@
identifier FP_NAME = limit;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_limit@
fp_name << find_struct_fp_assignment_limit.FP_NAME;
func_name << find_struct_fp_assignment_limit.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/limit.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_limit@
fp_name << find_init_fp_assignment_limit.FP_NAME;
func_name << find_init_fp_assignment_limit.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/limit.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xProc@
expression E;
identifier FP_NAME = xProc;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xProc@
identifier FP_NAME = xProc;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xProc@
fp_name << find_struct_fp_assignment_xProc.FP_NAME;
func_name << find_struct_fp_assignment_xProc.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xProc.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xProc@
fp_name << find_init_fp_assignment_xProc.FP_NAME;
func_name << find_init_fp_assignment_xProc.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xProc.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xMutexAlloc@
expression E;
identifier FP_NAME = xMutexAlloc;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xMutexAlloc@
identifier FP_NAME = xMutexAlloc;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xMutexAlloc@
fp_name << find_struct_fp_assignment_xMutexAlloc.FP_NAME;
func_name << find_struct_fp_assignment_xMutexAlloc.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xMutexAlloc.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xMutexAlloc@
fp_name << find_init_fp_assignment_xMutexAlloc.FP_NAME;
func_name << find_init_fp_assignment_xMutexAlloc.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xMutexAlloc.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_complete16@
expression E;
identifier FP_NAME = complete16;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_complete16@
identifier FP_NAME = complete16;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_complete16@
fp_name << find_struct_fp_assignment_complete16.FP_NAME;
func_name << find_struct_fp_assignment_complete16.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/complete16.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_complete16@
fp_name << find_init_fp_assignment_complete16.FP_NAME;
func_name << find_init_fp_assignment_complete16.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/complete16.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xColumnLocale@
expression E;
identifier FP_NAME = xColumnLocale;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xColumnLocale@
identifier FP_NAME = xColumnLocale;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xColumnLocale@
fp_name << find_struct_fp_assignment_xColumnLocale.FP_NAME;
func_name << find_struct_fp_assignment_xColumnLocale.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xColumnLocale.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xColumnLocale@
fp_name << find_init_fp_assignment_xColumnLocale.FP_NAME;
func_name << find_init_fp_assignment_xColumnLocale.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xColumnLocale.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_column_count@
expression E;
identifier FP_NAME = column_count;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_column_count@
identifier FP_NAME = column_count;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_column_count@
fp_name << find_struct_fp_assignment_column_count.FP_NAME;
func_name << find_struct_fp_assignment_column_count.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_count.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_column_count@
fp_name << find_init_fp_assignment_column_count.FP_NAME;
func_name << find_init_fp_assignment_column_count.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_count.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_prepare@
expression E;
identifier FP_NAME = prepare;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_prepare@
identifier FP_NAME = prepare;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_prepare@
fp_name << find_struct_fp_assignment_prepare.FP_NAME;
func_name << find_struct_fp_assignment_prepare.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/prepare.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_prepare@
fp_name << find_init_fp_assignment_prepare.FP_NAME;
func_name << find_init_fp_assignment_prepare.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/prepare.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_soft_heap_limit64@
expression E;
identifier FP_NAME = soft_heap_limit64;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_soft_heap_limit64@
identifier FP_NAME = soft_heap_limit64;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_soft_heap_limit64@
fp_name << find_struct_fp_assignment_soft_heap_limit64.FP_NAME;
func_name << find_struct_fp_assignment_soft_heap_limit64.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/soft_heap_limit64.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_soft_heap_limit64@
fp_name << find_init_fp_assignment_soft_heap_limit64.FP_NAME;
func_name << find_init_fp_assignment_soft_heap_limit64.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/soft_heap_limit64.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xExprCallback@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xExprCallback@
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xExprCallback@
fp_name << find_struct_fp_assignment_xExprCallback.FP_NAME;
func_name << find_struct_fp_assignment_xExprCallback.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xExprCallback.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xExprCallback@
fp_name << find_init_fp_assignment_xExprCallback.FP_NAME;
func_name << find_init_fp_assignment_xExprCallback.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xExprCallback.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_keyword_count@
expression E;
identifier FP_NAME = keyword_count;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_keyword_count@
identifier FP_NAME = keyword_count;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_keyword_count@
fp_name << find_struct_fp_assignment_keyword_count.FP_NAME;
func_name << find_struct_fp_assignment_keyword_count.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/keyword_count.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_keyword_count@
fp_name << find_init_fp_assignment_keyword_count.FP_NAME;
func_name << find_init_fp_assignment_keyword_count.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/keyword_count.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_stmt_explain@
expression E;
identifier FP_NAME = stmt_explain;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_stmt_explain@
identifier FP_NAME = stmt_explain;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_stmt_explain@
fp_name << find_struct_fp_assignment_stmt_explain.FP_NAME;
func_name << find_struct_fp_assignment_stmt_explain.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/stmt_explain.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_stmt_explain@
fp_name << find_init_fp_assignment_stmt_explain.FP_NAME;
func_name << find_init_fp_assignment_stmt_explain.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/stmt_explain.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_soft_heap_limit@
expression E;
identifier FP_NAME = soft_heap_limit;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_soft_heap_limit@
identifier FP_NAME = soft_heap_limit;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_soft_heap_limit@
fp_name << find_struct_fp_assignment_soft_heap_limit.FP_NAME;
func_name << find_struct_fp_assignment_soft_heap_limit.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/soft_heap_limit.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_soft_heap_limit@
fp_name << find_init_fp_assignment_soft_heap_limit.FP_NAME;
func_name << find_init_fp_assignment_soft_heap_limit.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/soft_heap_limit.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_vtab_nochange@
expression E;
identifier FP_NAME = vtab_nochange;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_vtab_nochange@
identifier FP_NAME = vtab_nochange;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_vtab_nochange@
fp_name << find_struct_fp_assignment_vtab_nochange.FP_NAME;
func_name << find_struct_fp_assignment_vtab_nochange.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vtab_nochange.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_vtab_nochange@
fp_name << find_init_fp_assignment_vtab_nochange.FP_NAME;
func_name << find_init_fp_assignment_vtab_nochange.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vtab_nochange.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_vtab_in_first@
expression E;
identifier FP_NAME = vtab_in_first;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_vtab_in_first@
identifier FP_NAME = vtab_in_first;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_vtab_in_first@
fp_name << find_struct_fp_assignment_vtab_in_first.FP_NAME;
func_name << find_struct_fp_assignment_vtab_in_first.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vtab_in_first.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_vtab_in_first@
fp_name << find_init_fp_assignment_vtab_in_first.FP_NAME;
func_name << find_init_fp_assignment_vtab_in_first.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vtab_in_first.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xFilter@
expression E;
identifier FP_NAME = xFilter;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xFilter@
identifier FP_NAME = xFilter;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xFilter@
fp_name << find_struct_fp_assignment_xFilter.FP_NAME;
func_name << find_struct_fp_assignment_xFilter.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFilter.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xFilter@
fp_name << find_init_fp_assignment_xFilter.FP_NAME;
func_name << find_init_fp_assignment_xFilter.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFilter.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_is_interrupted@
expression E;
identifier FP_NAME = is_interrupted;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_is_interrupted@
identifier FP_NAME = is_interrupted;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_is_interrupted@
fp_name << find_struct_fp_assignment_is_interrupted.FP_NAME;
func_name << find_struct_fp_assignment_is_interrupted.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/is_interrupted.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_is_interrupted@
fp_name << find_init_fp_assignment_is_interrupted.FP_NAME;
func_name << find_init_fp_assignment_is_interrupted.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/is_interrupted.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xFindTokenizer_v2@
expression E;
identifier FP_NAME = xFindTokenizer_v2;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xFindTokenizer_v2@
identifier FP_NAME = xFindTokenizer_v2;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xFindTokenizer_v2@
fp_name << find_struct_fp_assignment_xFindTokenizer_v2.FP_NAME;
func_name << find_struct_fp_assignment_xFindTokenizer_v2.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFindTokenizer_v2.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xFindTokenizer_v2@
fp_name << find_init_fp_assignment_xFindTokenizer_v2.FP_NAME;
func_name << find_init_fp_assignment_xFindTokenizer_v2.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFindTokenizer_v2.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_thread_cleanup@
expression E;
identifier FP_NAME = thread_cleanup;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_thread_cleanup@
identifier FP_NAME = thread_cleanup;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_thread_cleanup@
fp_name << find_struct_fp_assignment_thread_cleanup.FP_NAME;
func_name << find_struct_fp_assignment_thread_cleanup.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/thread_cleanup.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_thread_cleanup@
fp_name << find_init_fp_assignment_thread_cleanup.FP_NAME;
func_name << find_init_fp_assignment_thread_cleanup.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/thread_cleanup.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_db_handle@
expression E;
identifier FP_NAME = db_handle;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_db_handle@
identifier FP_NAME = db_handle;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_db_handle@
fp_name << find_struct_fp_assignment_db_handle.FP_NAME;
func_name << find_struct_fp_assignment_db_handle.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/db_handle.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_db_handle@
fp_name << find_init_fp_assignment_db_handle.FP_NAME;
func_name << find_init_fp_assignment_db_handle.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/db_handle.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xShutdown@
expression E;
identifier FP_NAME = xShutdown;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xShutdown@
identifier FP_NAME = xShutdown;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xShutdown@
fp_name << find_struct_fp_assignment_xShutdown.FP_NAME;
func_name << find_struct_fp_assignment_xShutdown.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xShutdown.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xShutdown@
fp_name << find_init_fp_assignment_xShutdown.FP_NAME;
func_name << find_init_fp_assignment_xShutdown.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xShutdown.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_error_offset@
expression E;
identifier FP_NAME = error_offset;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_error_offset@
identifier FP_NAME = error_offset;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_error_offset@
fp_name << find_struct_fp_assignment_error_offset.FP_NAME;
func_name << find_struct_fp_assignment_error_offset.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/error_offset.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_error_offset@
fp_name << find_init_fp_assignment_error_offset.FP_NAME;
func_name << find_init_fp_assignment_error_offset.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/error_offset.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xToken@
expression E;
identifier FP_NAME = xToken;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xToken@
identifier FP_NAME = xToken;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xToken@
fp_name << find_struct_fp_assignment_xToken.FP_NAME;
func_name << find_struct_fp_assignment_xToken.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xToken.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xToken@
fp_name << find_init_fp_assignment_xToken.FP_NAME;
func_name << find_init_fp_assignment_xToken.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xToken.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_total_changes@
expression E;
identifier FP_NAME = total_changes;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_total_changes@
identifier FP_NAME = total_changes;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_total_changes@
fp_name << find_struct_fp_assignment_total_changes.FP_NAME;
func_name << find_struct_fp_assignment_total_changes.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/total_changes.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_total_changes@
fp_name << find_init_fp_assignment_total_changes.FP_NAME;
func_name << find_init_fp_assignment_total_changes.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/total_changes.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_filename_wal@
expression E;
identifier FP_NAME = filename_wal;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_filename_wal@
identifier FP_NAME = filename_wal;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_filename_wal@
fp_name << find_struct_fp_assignment_filename_wal.FP_NAME;
func_name << find_struct_fp_assignment_filename_wal.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/filename_wal.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_filename_wal@
fp_name << find_init_fp_assignment_filename_wal.FP_NAME;
func_name << find_init_fp_assignment_filename_wal.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/filename_wal.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xMutexLeave@
expression E;
identifier FP_NAME = xMutexLeave;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xMutexLeave@
identifier FP_NAME = xMutexLeave;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xMutexLeave@
fp_name << find_struct_fp_assignment_xMutexLeave.FP_NAME;
func_name << find_struct_fp_assignment_xMutexLeave.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xMutexLeave.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xMutexLeave@
fp_name << find_init_fp_assignment_xMutexLeave.FP_NAME;
func_name << find_init_fp_assignment_xMutexLeave.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xMutexLeave.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_result_zeroblob@
expression E;
identifier FP_NAME = result_zeroblob;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_result_zeroblob@
identifier FP_NAME = result_zeroblob;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_result_zeroblob@
fp_name << find_struct_fp_assignment_result_zeroblob.FP_NAME;
func_name << find_struct_fp_assignment_result_zeroblob.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_zeroblob.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_result_zeroblob@
fp_name << find_init_fp_assignment_result_zeroblob.FP_NAME;
func_name << find_init_fp_assignment_result_zeroblob.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_zeroblob.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_reader@
expression E;
identifier FP_NAME = reader;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_reader@
identifier FP_NAME = reader;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_reader@
fp_name << find_struct_fp_assignment_reader.FP_NAME;
func_name << find_struct_fp_assignment_reader.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/reader.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_reader@
fp_name << find_init_fp_assignment_reader.FP_NAME;
func_name << find_init_fp_assignment_reader.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/reader.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_subfn@
expression E;
identifier FP_NAME = subfn;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_subfn@
identifier FP_NAME = subfn;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_subfn@
fp_name << find_struct_fp_assignment_subfn.FP_NAME;
func_name << find_struct_fp_assignment_subfn.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/subfn.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_subfn@
fp_name << find_init_fp_assignment_subfn.FP_NAME;
func_name << find_init_fp_assignment_subfn.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/subfn.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_db_cacheflush@
expression E;
identifier FP_NAME = db_cacheflush;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_db_cacheflush@
identifier FP_NAME = db_cacheflush;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_db_cacheflush@
fp_name << find_struct_fp_assignment_db_cacheflush.FP_NAME;
func_name << find_struct_fp_assignment_db_cacheflush.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/db_cacheflush.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_db_cacheflush@
fp_name << find_init_fp_assignment_db_cacheflush.FP_NAME;
func_name << find_init_fp_assignment_db_cacheflush.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/db_cacheflush.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_aggregate_count@
expression E;
identifier FP_NAME = aggregate_count;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_aggregate_count@
identifier FP_NAME = aggregate_count;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_aggregate_count@
fp_name << find_struct_fp_assignment_aggregate_count.FP_NAME;
func_name << find_struct_fp_assignment_aggregate_count.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/aggregate_count.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_aggregate_count@
fp_name << find_init_fp_assignment_aggregate_count.FP_NAME;
func_name << find_init_fp_assignment_aggregate_count.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/aggregate_count.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_errmsg@
expression E;
identifier FP_NAME = errmsg;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_errmsg@
identifier FP_NAME = errmsg;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_errmsg@
fp_name << find_struct_fp_assignment_errmsg.FP_NAME;
func_name << find_struct_fp_assignment_errmsg.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/errmsg.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_errmsg@
fp_name << find_init_fp_assignment_errmsg.FP_NAME;
func_name << find_init_fp_assignment_errmsg.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/errmsg.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xBenignEnd@
expression E;
identifier FP_NAME = xBenignEnd;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xBenignEnd@
identifier FP_NAME = xBenignEnd;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xBenignEnd@
fp_name << find_struct_fp_assignment_xBenignEnd.FP_NAME;
func_name << find_struct_fp_assignment_xBenignEnd.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xBenignEnd.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xBenignEnd@
fp_name << find_init_fp_assignment_xBenignEnd.FP_NAME;
func_name << find_init_fp_assignment_xBenignEnd.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xBenignEnd.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_vtab_config@
expression E;
identifier FP_NAME = vtab_config;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_vtab_config@
identifier FP_NAME = vtab_config;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_vtab_config@
fp_name << find_struct_fp_assignment_vtab_config.FP_NAME;
func_name << find_struct_fp_assignment_vtab_config.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vtab_config.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_vtab_config@
fp_name << find_init_fp_assignment_vtab_config.FP_NAME;
func_name << find_init_fp_assignment_vtab_config.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vtab_config.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_db_mutex@
expression E;
identifier FP_NAME = db_mutex;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_db_mutex@
identifier FP_NAME = db_mutex;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_db_mutex@
fp_name << find_struct_fp_assignment_db_mutex.FP_NAME;
func_name << find_struct_fp_assignment_db_mutex.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/db_mutex.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_db_mutex@
fp_name << find_init_fp_assignment_db_mutex.FP_NAME;
func_name << find_init_fp_assignment_db_mutex.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/db_mutex.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xNextSystemCall@
expression E;
identifier FP_NAME = xNextSystemCall;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xNextSystemCall@
identifier FP_NAME = xNextSystemCall;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xNextSystemCall@
fp_name << find_struct_fp_assignment_xNextSystemCall.FP_NAME;
func_name << find_struct_fp_assignment_xNextSystemCall.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xNextSystemCall.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xNextSystemCall@
fp_name << find_init_fp_assignment_xNextSystemCall.FP_NAME;
func_name << find_init_fp_assignment_xNextSystemCall.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xNextSystemCall.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xNext@
identifier FP_NAME = xNext;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xNext@
fp_name << find_struct_fp_assignment_xNext.FP_NAME;
func_name << find_struct_fp_assignment_xNext.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xNext.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xNext@
fp_name << find_init_fp_assignment_xNext.FP_NAME;
func_name << find_init_fp_assignment_xNext.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xNext.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_backup_pagecount@
expression E;
identifier FP_NAME = backup_pagecount;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_backup_pagecount@
identifier FP_NAME = backup_pagecount;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_backup_pagecount@
fp_name << find_struct_fp_assignment_backup_pagecount.FP_NAME;
func_name << find_struct_fp_assignment_backup_pagecount.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/backup_pagecount.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_backup_pagecount@
fp_name << find_init_fp_assignment_backup_pagecount.FP_NAME;
func_name << find_init_fp_assignment_backup_pagecount.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/backup_pagecount.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_strlike@
expression E;
identifier FP_NAME = strlike;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_strlike@
identifier FP_NAME = strlike;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_strlike@
fp_name << find_struct_fp_assignment_strlike.FP_NAME;
func_name << find_struct_fp_assignment_strlike.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/strlike.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_strlike@
fp_name << find_init_fp_assignment_strlike.FP_NAME;
func_name << find_init_fp_assignment_strlike.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/strlike.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_load_extension@
expression E;
identifier FP_NAME = load_extension;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_load_extension@
identifier FP_NAME = load_extension;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_load_extension@
fp_name << find_struct_fp_assignment_load_extension.FP_NAME;
func_name << find_struct_fp_assignment_load_extension.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/load_extension.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_load_extension@
fp_name << find_init_fp_assignment_load_extension.FP_NAME;
func_name << find_init_fp_assignment_load_extension.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/load_extension.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_stmt_busy@
expression E;
identifier FP_NAME = stmt_busy;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_stmt_busy@
identifier FP_NAME = stmt_busy;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_stmt_busy@
fp_name << find_struct_fp_assignment_stmt_busy.FP_NAME;
func_name << find_struct_fp_assignment_stmt_busy.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/stmt_busy.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_stmt_busy@
fp_name << find_init_fp_assignment_stmt_busy.FP_NAME;
func_name << find_init_fp_assignment_stmt_busy.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/stmt_busy.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_msize@
expression E;
identifier FP_NAME = msize;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_msize@
identifier FP_NAME = msize;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_msize@
fp_name << find_struct_fp_assignment_msize.FP_NAME;
func_name << find_struct_fp_assignment_msize.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/msize.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_msize@
fp_name << find_init_fp_assignment_msize.FP_NAME;
func_name << find_init_fp_assignment_msize.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/msize.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_strglob@
expression E;
identifier FP_NAME = strglob;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_strglob@
identifier FP_NAME = strglob;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_strglob@
fp_name << find_struct_fp_assignment_strglob.FP_NAME;
func_name << find_struct_fp_assignment_strglob.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/strglob.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_strglob@
fp_name << find_init_fp_assignment_strglob.FP_NAME;
func_name << find_init_fp_assignment_strglob.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/strglob.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_funcop@
expression E;
identifier FP_NAME = funcop;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_funcop@
identifier FP_NAME = funcop;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_funcop@
fp_name << find_struct_fp_assignment_funcop.FP_NAME;
func_name << find_struct_fp_assignment_funcop.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/funcop.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_funcop@
fp_name << find_init_fp_assignment_funcop.FP_NAME;
func_name << find_init_fp_assignment_funcop.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/funcop.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xSetSystemCall@
expression E;
identifier FP_NAME = xSetSystemCall;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xSetSystemCall@
identifier FP_NAME = xSetSystemCall;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xSetSystemCall@
fp_name << find_struct_fp_assignment_xSetSystemCall.FP_NAME;
func_name << find_struct_fp_assignment_xSetSystemCall.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSetSystemCall.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xSetSystemCall@
fp_name << find_init_fp_assignment_xSetSystemCall.FP_NAME;
func_name << find_init_fp_assignment_xSetSystemCall.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSetSystemCall.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xProgress@
expression E;
identifier FP_NAME = xProgress;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xProgress@
identifier FP_NAME = xProgress;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xProgress@
fp_name << find_struct_fp_assignment_xProgress.FP_NAME;
func_name << find_struct_fp_assignment_xProgress.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xProgress.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xProgress@
fp_name << find_init_fp_assignment_xProgress.FP_NAME;
func_name << find_init_fp_assignment_xProgress.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xProgress.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xFinal@
expression E;
identifier FP_NAME = xFinal;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xFinal@
identifier FP_NAME = xFinal;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xFinal@
fp_name << find_struct_fp_assignment_xFinal.FP_NAME;
func_name << find_struct_fp_assignment_xFinal.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFinal.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xFinal@
fp_name << find_init_fp_assignment_xFinal.FP_NAME;
func_name << find_init_fp_assignment_xFinal.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFinal.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xRollback@
expression E;
identifier FP_NAME = xRollback;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xRollback@
identifier FP_NAME = xRollback;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xRollback@
fp_name << find_struct_fp_assignment_xRollback.FP_NAME;
func_name << find_struct_fp_assignment_xRollback.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRollback.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xRollback@
fp_name << find_init_fp_assignment_xRollback.FP_NAME;
func_name << find_init_fp_assignment_xRollback.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRollback.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xLanguageid@
expression E;
identifier FP_NAME = xLanguageid;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xLanguageid@
identifier FP_NAME = xLanguageid;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xLanguageid@
fp_name << find_struct_fp_assignment_xLanguageid.FP_NAME;
func_name << find_struct_fp_assignment_xLanguageid.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xLanguageid.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xLanguageid@
fp_name << find_init_fp_assignment_xLanguageid.FP_NAME;
func_name << find_init_fp_assignment_xLanguageid.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xLanguageid.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xPhraseFirst@
expression E;
identifier FP_NAME = xPhraseFirst;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xPhraseFirst@
identifier FP_NAME = xPhraseFirst;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xPhraseFirst@
fp_name << find_struct_fp_assignment_xPhraseFirst.FP_NAME;
func_name << find_struct_fp_assignment_xPhraseFirst.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xPhraseFirst.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xPhraseFirst@
fp_name << find_init_fp_assignment_xPhraseFirst.FP_NAME;
func_name << find_init_fp_assignment_xPhraseFirst.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xPhraseFirst.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_vtab_rhs_value@
expression E;
identifier FP_NAME = vtab_rhs_value;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_vtab_rhs_value@
identifier FP_NAME = vtab_rhs_value;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_vtab_rhs_value@
fp_name << find_struct_fp_assignment_vtab_rhs_value.FP_NAME;
func_name << find_struct_fp_assignment_vtab_rhs_value.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vtab_rhs_value.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_vtab_rhs_value@
fp_name << find_init_fp_assignment_vtab_rhs_value.FP_NAME;
func_name << find_init_fp_assignment_vtab_rhs_value.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vtab_rhs_value.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xShmMap@
expression E;
identifier FP_NAME = xShmMap;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xShmMap@
identifier FP_NAME = xShmMap;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xShmMap@
fp_name << find_struct_fp_assignment_xShmMap.FP_NAME;
func_name << find_struct_fp_assignment_xShmMap.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xShmMap.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xShmMap@
fp_name << find_init_fp_assignment_xShmMap.FP_NAME;
func_name << find_init_fp_assignment_xShmMap.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xShmMap.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_mprintf@
expression E;
identifier FP_NAME = mprintf;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_mprintf@
identifier FP_NAME = mprintf;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_mprintf@
fp_name << find_struct_fp_assignment_mprintf.FP_NAME;
func_name << find_struct_fp_assignment_mprintf.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/mprintf.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_mprintf@
fp_name << find_init_fp_assignment_mprintf.FP_NAME;
func_name << find_init_fp_assignment_mprintf.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/mprintf.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_value_text16be@
expression E;
identifier FP_NAME = value_text16be;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_value_text16be@
identifier FP_NAME = value_text16be;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_value_text16be@
fp_name << find_struct_fp_assignment_value_text16be.FP_NAME;
func_name << find_struct_fp_assignment_value_text16be.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_text16be.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_value_text16be@
fp_name << find_init_fp_assignment_value_text16be.FP_NAME;
func_name << find_init_fp_assignment_value_text16be.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_text16be.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xTableFilter@
expression E;
identifier FP_NAME = xTableFilter;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xTableFilter@
identifier FP_NAME = xTableFilter;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xTableFilter@
fp_name << find_struct_fp_assignment_xTableFilter.FP_NAME;
func_name << find_struct_fp_assignment_xTableFilter.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xTableFilter.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xTableFilter@
fp_name << find_init_fp_assignment_xTableFilter.FP_NAME;
func_name << find_init_fp_assignment_xTableFilter.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xTableFilter.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_str_finish@
expression E;
identifier FP_NAME = str_finish;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_str_finish@
identifier FP_NAME = str_finish;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_str_finish@
fp_name << find_struct_fp_assignment_str_finish.FP_NAME;
func_name << find_struct_fp_assignment_str_finish.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/str_finish.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_str_finish@
fp_name << find_init_fp_assignment_str_finish.FP_NAME;
func_name << find_init_fp_assignment_str_finish.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/str_finish.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xFree@
expression E;
identifier FP_NAME = xFree;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xFree@
identifier FP_NAME = xFree;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xFree@
fp_name << find_struct_fp_assignment_xFree.FP_NAME;
func_name << find_struct_fp_assignment_xFree.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFree.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xFree@
fp_name << find_init_fp_assignment_xFree.FP_NAME;
func_name << find_init_fp_assignment_xFree.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFree.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_prepare_v3@
expression E;
identifier FP_NAME = prepare_v3;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_prepare_v3@
identifier FP_NAME = prepare_v3;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_prepare_v3@
fp_name << find_struct_fp_assignment_prepare_v3.FP_NAME;
func_name << find_struct_fp_assignment_prepare_v3.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/prepare_v3.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_prepare_v3@
fp_name << find_init_fp_assignment_prepare_v3.FP_NAME;
func_name << find_init_fp_assignment_prepare_v3.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/prepare_v3.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xBacktrace@
expression E;
identifier FP_NAME = xBacktrace;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xBacktrace@
identifier FP_NAME = xBacktrace;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xBacktrace@
fp_name << find_struct_fp_assignment_xBacktrace.FP_NAME;
func_name << find_struct_fp_assignment_xBacktrace.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xBacktrace.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xBacktrace@
fp_name << find_init_fp_assignment_xBacktrace.FP_NAME;
func_name << find_init_fp_assignment_xBacktrace.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xBacktrace.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xMutexEnd@
expression E;
identifier FP_NAME = xMutexEnd;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xMutexEnd@
identifier FP_NAME = xMutexEnd;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xMutexEnd@
fp_name << find_struct_fp_assignment_xMutexEnd.FP_NAME;
func_name << find_struct_fp_assignment_xMutexEnd.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xMutexEnd.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xMutexEnd@
fp_name << find_init_fp_assignment_xMutexEnd.FP_NAME;
func_name << find_init_fp_assignment_xMutexEnd.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xMutexEnd.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xGeom@
expression E;
identifier FP_NAME = xGeom;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xGeom@
identifier FP_NAME = xGeom;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xGeom@
fp_name << find_struct_fp_assignment_xGeom.FP_NAME;
func_name << find_struct_fp_assignment_xGeom.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xGeom.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xGeom@
fp_name << find_init_fp_assignment_xGeom.FP_NAME;
func_name << find_init_fp_assignment_xGeom.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xGeom.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_result_error_nomem@
expression E;
identifier FP_NAME = result_error_nomem;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_result_error_nomem@
identifier FP_NAME = result_error_nomem;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_result_error_nomem@
fp_name << find_struct_fp_assignment_result_error_nomem.FP_NAME;
func_name << find_struct_fp_assignment_result_error_nomem.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_error_nomem.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_result_error_nomem@
fp_name << find_init_fp_assignment_result_error_nomem.FP_NAME;
func_name << find_init_fp_assignment_result_error_nomem.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_error_nomem.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xEof@
expression E;
identifier FP_NAME = xEof;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xEof@
identifier FP_NAME = xEof;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xEof@
fp_name << find_struct_fp_assignment_xEof.FP_NAME;
func_name << find_struct_fp_assignment_xEof.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xEof.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xEof@
fp_name << find_init_fp_assignment_xEof.FP_NAME;
func_name << find_init_fp_assignment_xEof.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xEof.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_stmt_isexplain@
expression E;
identifier FP_NAME = stmt_isexplain;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_stmt_isexplain@
identifier FP_NAME = stmt_isexplain;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_stmt_isexplain@
fp_name << find_struct_fp_assignment_stmt_isexplain.FP_NAME;
func_name << find_struct_fp_assignment_stmt_isexplain.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/stmt_isexplain.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_stmt_isexplain@
fp_name << find_init_fp_assignment_stmt_isexplain.FP_NAME;
func_name << find_init_fp_assignment_stmt_isexplain.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/stmt_isexplain.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_blob_read@
expression E;
identifier FP_NAME = blob_read;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_blob_read@
identifier FP_NAME = blob_read;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_blob_read@
fp_name << find_struct_fp_assignment_blob_read.FP_NAME;
func_name << find_struct_fp_assignment_blob_read.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/blob_read.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_blob_read@
fp_name << find_init_fp_assignment_blob_read.FP_NAME;
func_name << find_init_fp_assignment_blob_read.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/blob_read.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_normalized_sql@
expression E;
identifier FP_NAME = normalized_sql;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_normalized_sql@
identifier FP_NAME = normalized_sql;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_normalized_sql@
fp_name << find_struct_fp_assignment_normalized_sql.FP_NAME;
func_name << find_struct_fp_assignment_normalized_sql.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/normalized_sql.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_normalized_sql@
fp_name << find_init_fp_assignment_normalized_sql.FP_NAME;
func_name << find_init_fp_assignment_normalized_sql.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/normalized_sql.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xInit@
expression E;
identifier FP_NAME = xInit;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xInit@
identifier FP_NAME = xInit;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xInit@
fp_name << find_struct_fp_assignment_xInit.FP_NAME;
func_name << find_struct_fp_assignment_xInit.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xInit.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xInit@
fp_name << find_init_fp_assignment_xInit.FP_NAME;
func_name << find_init_fp_assignment_xInit.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xInit.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xRollbackTo@
expression E;
identifier FP_NAME = xRollbackTo;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xRollbackTo@
identifier FP_NAME = xRollbackTo;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xRollbackTo@
fp_name << find_struct_fp_assignment_xRollbackTo.FP_NAME;
func_name << find_struct_fp_assignment_xRollbackTo.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRollbackTo.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xRollbackTo@
fp_name << find_init_fp_assignment_xRollbackTo.FP_NAME;
func_name << find_init_fp_assignment_xRollbackTo.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRollbackTo.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xRekey@
expression E;
identifier FP_NAME = xRekey;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xRekey@
identifier FP_NAME = xRekey;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xRekey@
fp_name << find_struct_fp_assignment_xRekey.FP_NAME;
func_name << find_struct_fp_assignment_xRekey.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRekey.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xRekey@
fp_name << find_init_fp_assignment_xRekey.FP_NAME;
func_name << find_init_fp_assignment_xRekey.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRekey.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_exec@
expression E;
identifier FP_NAME = exec;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_exec@
identifier FP_NAME = exec;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_exec@
fp_name << find_struct_fp_assignment_exec.FP_NAME;
func_name << find_struct_fp_assignment_exec.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/exec.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_exec@
fp_name << find_init_fp_assignment_exec.FP_NAME;
func_name << find_init_fp_assignment_exec.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/exec.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_value_bytes@
expression E;
identifier FP_NAME = value_bytes;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_value_bytes@
identifier FP_NAME = value_bytes;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_value_bytes@
fp_name << find_struct_fp_assignment_value_bytes.FP_NAME;
func_name << find_struct_fp_assignment_value_bytes.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_bytes.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_value_bytes@
fp_name << find_init_fp_assignment_value_bytes.FP_NAME;
func_name << find_init_fp_assignment_value_bytes.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_bytes.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xFileSize@
expression E;
identifier FP_NAME = xFileSize;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xFileSize@
identifier FP_NAME = xFileSize;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xFileSize@
fp_name << find_struct_fp_assignment_xFileSize.FP_NAME;
func_name << find_struct_fp_assignment_xFileSize.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFileSize.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xFileSize@
fp_name << find_init_fp_assignment_xFileSize.FP_NAME;
func_name << find_init_fp_assignment_xFileSize.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFileSize.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_libversion_number@
expression E;
identifier FP_NAME = libversion_number;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_libversion_number@
identifier FP_NAME = libversion_number;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_libversion_number@
fp_name << find_struct_fp_assignment_libversion_number.FP_NAME;
func_name << find_struct_fp_assignment_libversion_number.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/libversion_number.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_libversion_number@
fp_name << find_init_fp_assignment_libversion_number.FP_NAME;
func_name << find_init_fp_assignment_libversion_number.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/libversion_number.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_prepare16@
expression E;
identifier FP_NAME = prepare16;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_prepare16@
identifier FP_NAME = prepare16;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_prepare16@
fp_name << find_struct_fp_assignment_prepare16.FP_NAME;
func_name << find_struct_fp_assignment_prepare16.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/prepare16.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_prepare16@
fp_name << find_init_fp_assignment_prepare16.FP_NAME;
func_name << find_init_fp_assignment_prepare16.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/prepare16.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_bind_null@
expression E;
identifier FP_NAME = bind_null;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_bind_null@
identifier FP_NAME = bind_null;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_bind_null@
fp_name << find_struct_fp_assignment_bind_null.FP_NAME;
func_name << find_struct_fp_assignment_bind_null.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/bind_null.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_bind_null@
fp_name << find_init_fp_assignment_bind_null.FP_NAME;
func_name << find_init_fp_assignment_bind_null.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/bind_null.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_result_double@
expression E;
identifier FP_NAME = result_double;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_result_double@
identifier FP_NAME = result_double;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_result_double@
fp_name << find_struct_fp_assignment_result_double.FP_NAME;
func_name << find_struct_fp_assignment_result_double.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_double.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_result_double@
fp_name << find_init_fp_assignment_result_double.FP_NAME;
func_name << find_init_fp_assignment_result_double.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_double.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_status64@
expression E;
identifier FP_NAME = status64;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_status64@
identifier FP_NAME = status64;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_status64@
fp_name << find_struct_fp_assignment_status64.FP_NAME;
func_name << find_struct_fp_assignment_status64.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/status64.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_status64@
fp_name << find_init_fp_assignment_status64.FP_NAME;
func_name << find_init_fp_assignment_status64.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/status64.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_expanded_sql@
expression E;
identifier FP_NAME = expanded_sql;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_expanded_sql@
identifier FP_NAME = expanded_sql;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_expanded_sql@
fp_name << find_struct_fp_assignment_expanded_sql.FP_NAME;
func_name << find_struct_fp_assignment_expanded_sql.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/expanded_sql.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_expanded_sql@
fp_name << find_init_fp_assignment_expanded_sql.FP_NAME;
func_name << find_init_fp_assignment_expanded_sql.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/expanded_sql.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_extended_result_codes@
expression E;
identifier FP_NAME = extended_result_codes;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_extended_result_codes@
identifier FP_NAME = extended_result_codes;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_extended_result_codes@
fp_name << find_struct_fp_assignment_extended_result_codes.FP_NAME;
func_name << find_struct_fp_assignment_extended_result_codes.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/extended_result_codes.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_extended_result_codes@
fp_name << find_init_fp_assignment_extended_result_codes.FP_NAME;
func_name << find_init_fp_assignment_extended_result_codes.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/extended_result_codes.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_free_filename@
expression E;
identifier FP_NAME = free_filename;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_free_filename@
identifier FP_NAME = free_filename;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_free_filename@
fp_name << find_struct_fp_assignment_free_filename.FP_NAME;
func_name << find_struct_fp_assignment_free_filename.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/free_filename.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_free_filename@
fp_name << find_init_fp_assignment_free_filename.FP_NAME;
func_name << find_init_fp_assignment_free_filename.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/free_filename.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xPhraseNextColumn@
expression E;
identifier FP_NAME = xPhraseNextColumn;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xPhraseNextColumn@
identifier FP_NAME = xPhraseNextColumn;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xPhraseNextColumn@
fp_name << find_struct_fp_assignment_xPhraseNextColumn.FP_NAME;
func_name << find_struct_fp_assignment_xPhraseNextColumn.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xPhraseNextColumn.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xPhraseNextColumn@
fp_name << find_init_fp_assignment_xPhraseNextColumn.FP_NAME;
func_name << find_init_fp_assignment_xPhraseNextColumn.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xPhraseNextColumn.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xUnlockNotify@
expression E;
identifier FP_NAME = xUnlockNotify;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xUnlockNotify@
identifier FP_NAME = xUnlockNotify;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xUnlockNotify@
fp_name << find_struct_fp_assignment_xUnlockNotify.FP_NAME;
func_name << find_struct_fp_assignment_xUnlockNotify.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xUnlockNotify.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xUnlockNotify@
fp_name << find_init_fp_assignment_xUnlockNotify.FP_NAME;
func_name << find_init_fp_assignment_xUnlockNotify.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xUnlockNotify.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_column_text@
expression E;
identifier FP_NAME = column_text;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_column_text@
identifier FP_NAME = column_text;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_column_text@
fp_name << find_struct_fp_assignment_column_text.FP_NAME;
func_name << find_struct_fp_assignment_column_text.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_text.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_column_text@
fp_name << find_init_fp_assignment_column_text.FP_NAME;
func_name << find_init_fp_assignment_column_text.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_text.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xClose@
identifier FP_NAME = xClose;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xClose@
fp_name << find_struct_fp_assignment_xClose.FP_NAME;
func_name << find_struct_fp_assignment_xClose.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xClose.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xClose@
fp_name << find_init_fp_assignment_xClose.FP_NAME;
func_name << find_init_fp_assignment_xClose.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xClose.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xSelectCallback@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xSelectCallback@
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xSelectCallback@
fp_name << find_struct_fp_assignment_xSelectCallback.FP_NAME;
func_name << find_struct_fp_assignment_xSelectCallback.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSelectCallback.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xSelectCallback@
fp_name << find_init_fp_assignment_xSelectCallback.FP_NAME;
func_name << find_init_fp_assignment_xSelectCallback.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSelectCallback.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xDisconnect@
expression E;
identifier FP_NAME = xDisconnect;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xDisconnect@
identifier FP_NAME = xDisconnect;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xDisconnect@
fp_name << find_struct_fp_assignment_xDisconnect.FP_NAME;
func_name << find_struct_fp_assignment_xDisconnect.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDisconnect.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xDisconnect@
fp_name << find_init_fp_assignment_xDisconnect.FP_NAME;
func_name << find_init_fp_assignment_xDisconnect.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDisconnect.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_libversion@
expression E;
identifier FP_NAME = libversion;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_libversion@
identifier FP_NAME = libversion;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_libversion@
fp_name << find_struct_fp_assignment_libversion.FP_NAME;
func_name << find_struct_fp_assignment_libversion.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/libversion.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_libversion@
fp_name << find_init_fp_assignment_libversion.FP_NAME;
func_name << find_init_fp_assignment_libversion.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/libversion.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xWrite@
expression E;
identifier FP_NAME = xWrite;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xWrite@
identifier FP_NAME = xWrite;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xWrite@
fp_name << find_struct_fp_assignment_xWrite.FP_NAME;
func_name << find_struct_fp_assignment_xWrite.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xWrite.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xWrite@
fp_name << find_init_fp_assignment_xWrite.FP_NAME;
func_name << find_init_fp_assignment_xWrite.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xWrite.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_value_nochange@
expression E;
identifier FP_NAME = value_nochange;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_value_nochange@
identifier FP_NAME = value_nochange;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_value_nochange@
fp_name << find_struct_fp_assignment_value_nochange.FP_NAME;
func_name << find_struct_fp_assignment_value_nochange.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_nochange.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_value_nochange@
fp_name << find_init_fp_assignment_value_nochange.FP_NAME;
func_name << find_init_fp_assignment_value_nochange.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_nochange.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xAccess@
expression E;
identifier FP_NAME = xAccess;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xAccess@
identifier FP_NAME = xAccess;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xAccess@
fp_name << find_struct_fp_assignment_xAccess.FP_NAME;
func_name << find_struct_fp_assignment_xAccess.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xAccess.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xAccess@
fp_name << find_init_fp_assignment_xAccess.FP_NAME;
func_name << find_init_fp_assignment_xAccess.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xAccess.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_value_int@
expression E;
identifier FP_NAME = value_int;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_value_int@
identifier FP_NAME = value_int;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_value_int@
fp_name << find_struct_fp_assignment_value_int.FP_NAME;
func_name << find_struct_fp_assignment_value_int.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_int.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_value_int@
fp_name << find_init_fp_assignment_value_int.FP_NAME;
func_name << find_init_fp_assignment_value_int.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_int.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_open16@
expression E;
identifier FP_NAME = open16;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_open16@
identifier FP_NAME = open16;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_open16@
fp_name << find_struct_fp_assignment_open16.FP_NAME;
func_name << find_struct_fp_assignment_open16.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/open16.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_open16@
fp_name << find_init_fp_assignment_open16.FP_NAME;
func_name << find_init_fp_assignment_open16.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/open16.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_column_bytes@
expression E;
identifier FP_NAME = column_bytes;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_column_bytes@
identifier FP_NAME = column_bytes;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_column_bytes@
fp_name << find_struct_fp_assignment_column_bytes.FP_NAME;
func_name << find_struct_fp_assignment_column_bytes.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_bytes.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_column_bytes@
fp_name << find_init_fp_assignment_column_bytes.FP_NAME;
func_name << find_init_fp_assignment_column_bytes.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_bytes.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xInverse@
expression E;
identifier FP_NAME = xInverse;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xInverse@
identifier FP_NAME = xInverse;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xInverse@
fp_name << find_struct_fp_assignment_xInverse.FP_NAME;
func_name << find_struct_fp_assignment_xInverse.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xInverse.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xInverse@
fp_name << find_init_fp_assignment_xInverse.FP_NAME;
func_name << find_init_fp_assignment_xInverse.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xInverse.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_table_column_metadata@
expression E;
identifier FP_NAME = table_column_metadata;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_table_column_metadata@
identifier FP_NAME = table_column_metadata;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_table_column_metadata@
fp_name << find_struct_fp_assignment_table_column_metadata.FP_NAME;
func_name << find_struct_fp_assignment_table_column_metadata.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/table_column_metadata.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_table_column_metadata@
fp_name << find_init_fp_assignment_table_column_metadata.FP_NAME;
func_name << find_init_fp_assignment_table_column_metadata.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/table_column_metadata.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_column_table_name@
expression E;
identifier FP_NAME = column_table_name;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_column_table_name@
identifier FP_NAME = column_table_name;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_column_table_name@
fp_name << find_struct_fp_assignment_column_table_name.FP_NAME;
func_name << find_struct_fp_assignment_column_table_name.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_table_name.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_column_table_name@
fp_name << find_init_fp_assignment_column_table_name.FP_NAME;
func_name << find_init_fp_assignment_column_table_name.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/column_table_name.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_log@
expression E;
identifier FP_NAME = log;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_log@
identifier FP_NAME = log;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_log@
fp_name << find_struct_fp_assignment_log.FP_NAME;
func_name << find_struct_fp_assignment_log.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/log.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_log@
fp_name << find_init_fp_assignment_log.FP_NAME;
func_name << find_init_fp_assignment_log.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/log.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xGet@
expression E;
identifier FP_NAME = xGet;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xGet@
identifier FP_NAME = xGet;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xGet@
fp_name << find_struct_fp_assignment_xGet.FP_NAME;
func_name << find_struct_fp_assignment_xGet.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xGet.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xGet@
fp_name << find_init_fp_assignment_xGet.FP_NAME;
func_name << find_init_fp_assignment_xGet.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xGet.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xLock@
expression E;
identifier FP_NAME = xLock;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xLock@
identifier FP_NAME = xLock;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xLock@
fp_name << find_struct_fp_assignment_xLock.FP_NAME;
func_name << find_struct_fp_assignment_xLock.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xLock.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xLock@
fp_name << find_init_fp_assignment_xLock.FP_NAME;
func_name << find_init_fp_assignment_xLock.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xLock.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_sql@
expression E;
identifier FP_NAME = sql;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_sql@
identifier FP_NAME = sql;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_sql@
fp_name << find_struct_fp_assignment_sql.FP_NAME;
func_name << find_struct_fp_assignment_sql.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/sql.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_sql@
fp_name << find_init_fp_assignment_sql.FP_NAME;
func_name << find_init_fp_assignment_sql.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/sql.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xPagecount@
expression E;
identifier FP_NAME = xPagecount;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xPagecount@
identifier FP_NAME = xPagecount;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xPagecount@
fp_name << find_struct_fp_assignment_xPagecount.FP_NAME;
func_name << find_struct_fp_assignment_xPagecount.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xPagecount.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xPagecount@
fp_name << find_init_fp_assignment_xPagecount.FP_NAME;
func_name << find_init_fp_assignment_xPagecount.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xPagecount.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_file_control@
expression E;
identifier FP_NAME = file_control;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_file_control@
identifier FP_NAME = file_control;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_file_control@
fp_name << find_struct_fp_assignment_file_control.FP_NAME;
func_name << find_struct_fp_assignment_file_control.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/file_control.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_file_control@
fp_name << find_init_fp_assignment_file_control.FP_NAME;
func_name << find_init_fp_assignment_file_control.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/file_control.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xRoundup@
expression E;
identifier FP_NAME = xRoundup;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xRoundup@
identifier FP_NAME = xRoundup;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xRoundup@
fp_name << find_struct_fp_assignment_xRoundup.FP_NAME;
func_name << find_struct_fp_assignment_xRoundup.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRoundup.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xRoundup@
fp_name << find_init_fp_assignment_xRoundup.FP_NAME;
func_name << find_init_fp_assignment_xRoundup.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xRoundup.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_value_text@
expression E;
identifier FP_NAME = value_text;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_value_text@
identifier FP_NAME = value_text;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_value_text@
fp_name << find_struct_fp_assignment_value_text.FP_NAME;
func_name << find_struct_fp_assignment_value_text.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_text.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_value_text@
fp_name << find_init_fp_assignment_value_text.FP_NAME;
func_name << find_init_fp_assignment_value_text.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/value_text.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xDestructor@
expression E;
identifier FP_NAME = xDestructor;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xDestructor@
identifier FP_NAME = xDestructor;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xDestructor@
fp_name << find_struct_fp_assignment_xDestructor.FP_NAME;
func_name << find_struct_fp_assignment_xDestructor.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDestructor.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xDestructor@
fp_name << find_init_fp_assignment_xDestructor.FP_NAME;
func_name << find_init_fp_assignment_xDestructor.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xDestructor.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_create_filename@
expression E;
identifier FP_NAME = create_filename;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_create_filename@
identifier FP_NAME = create_filename;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_create_filename@
fp_name << find_struct_fp_assignment_create_filename.FP_NAME;
func_name << find_struct_fp_assignment_create_filename.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/create_filename.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_create_filename@
fp_name << find_init_fp_assignment_create_filename.FP_NAME;
func_name << find_init_fp_assignment_create_filename.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/create_filename.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_result_error16@
expression E;
identifier FP_NAME = result_error16;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_result_error16@
identifier FP_NAME = result_error16;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_result_error16@
fp_name << find_struct_fp_assignment_result_error16.FP_NAME;
func_name << find_struct_fp_assignment_result_error16.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_error16.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_result_error16@
fp_name << find_init_fp_assignment_result_error16.FP_NAME;
func_name << find_init_fp_assignment_result_error16.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_error16.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_user_data@
expression E;
identifier FP_NAME = user_data;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_user_data@
identifier FP_NAME = user_data;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_user_data@
fp_name << find_struct_fp_assignment_user_data.FP_NAME;
func_name << find_struct_fp_assignment_user_data.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/user_data.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_user_data@
fp_name << find_init_fp_assignment_user_data.FP_NAME;
func_name << find_init_fp_assignment_user_data.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/user_data.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xColumn@
expression E;
identifier FP_NAME = xColumn;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xColumn@
identifier FP_NAME = xColumn;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xColumn@
fp_name << find_struct_fp_assignment_xColumn.FP_NAME;
func_name << find_struct_fp_assignment_xColumn.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xColumn.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xColumn@
fp_name << find_init_fp_assignment_xColumn.FP_NAME;
func_name << find_init_fp_assignment_xColumn.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xColumn.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xAltLocaltime@
expression E;
identifier FP_NAME = xAltLocaltime;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xAltLocaltime@
identifier FP_NAME = xAltLocaltime;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xAltLocaltime@
fp_name << find_struct_fp_assignment_xAltLocaltime.FP_NAME;
func_name << find_struct_fp_assignment_xAltLocaltime.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xAltLocaltime.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xAltLocaltime@
fp_name << find_init_fp_assignment_xAltLocaltime.FP_NAME;
func_name << find_init_fp_assignment_xAltLocaltime.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xAltLocaltime.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xCommitCallback@
expression E;
identifier FP_NAME = xCommitCallback;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xCommitCallback@
identifier FP_NAME = xCommitCallback;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xCommitCallback@
fp_name << find_struct_fp_assignment_xCommitCallback.FP_NAME;
func_name << find_struct_fp_assignment_xCommitCallback.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCommitCallback.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xCommitCallback@
fp_name << find_init_fp_assignment_xCommitCallback.FP_NAME;
func_name << find_init_fp_assignment_xCommitCallback.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCommitCallback.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_result_subtype@
expression E;
identifier FP_NAME = result_subtype;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_result_subtype@
identifier FP_NAME = result_subtype;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_result_subtype@
fp_name << find_struct_fp_assignment_result_subtype.FP_NAME;
func_name << find_struct_fp_assignment_result_subtype.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_subtype.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_result_subtype@
fp_name << find_init_fp_assignment_result_subtype.FP_NAME;
func_name << find_init_fp_assignment_result_subtype.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/result_subtype.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xFindTokenizer@
expression E;
identifier FP_NAME = xFindTokenizer;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xFindTokenizer@
identifier FP_NAME = xFindTokenizer;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xFindTokenizer@
fp_name << find_struct_fp_assignment_xFindTokenizer.FP_NAME;
func_name << find_struct_fp_assignment_xFindTokenizer.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFindTokenizer.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xFindTokenizer@
fp_name << find_init_fp_assignment_xFindTokenizer.FP_NAME;
func_name << find_init_fp_assignment_xFindTokenizer.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xFindTokenizer.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xCmp@
expression E;
identifier FP_NAME = xCmp;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xCmp@
identifier FP_NAME = xCmp;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xCmp@
fp_name << find_struct_fp_assignment_xCmp.FP_NAME;
func_name << find_struct_fp_assignment_xCmp.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCmp.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xCmp@
fp_name << find_init_fp_assignment_xCmp.FP_NAME;
func_name << find_init_fp_assignment_xCmp.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xCmp.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_prepare16_v2@
expression E;
identifier FP_NAME = prepare16_v2;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_prepare16_v2@
identifier FP_NAME = prepare16_v2;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_prepare16_v2@
fp_name << find_struct_fp_assignment_prepare16_v2.FP_NAME;
func_name << find_struct_fp_assignment_prepare16_v2.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/prepare16_v2.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_prepare16_v2@
fp_name << find_init_fp_assignment_prepare16_v2.FP_NAME;
func_name << find_init_fp_assignment_prepare16_v2.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/prepare16_v2.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_keyword_name@
expression E;
identifier FP_NAME = keyword_name;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_keyword_name@
identifier FP_NAME = keyword_name;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_keyword_name@
fp_name << find_struct_fp_assignment_keyword_name.FP_NAME;
func_name << find_struct_fp_assignment_keyword_name.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/keyword_name.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_keyword_name@
fp_name << find_init_fp_assignment_keyword_name.FP_NAME;
func_name << find_init_fp_assignment_keyword_name.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/keyword_name.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_vtab_collation@
expression E;
identifier FP_NAME = vtab_collation;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_vtab_collation@
identifier FP_NAME = vtab_collation;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_vtab_collation@
fp_name << find_struct_fp_assignment_vtab_collation.FP_NAME;
func_name << find_struct_fp_assignment_vtab_collation.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vtab_collation.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_vtab_collation@
fp_name << find_init_fp_assignment_vtab_collation.FP_NAME;
func_name << find_init_fp_assignment_vtab_collation.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/vtab_collation.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_free_table@
expression E;
identifier FP_NAME = free_table;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_free_table@
identifier FP_NAME = free_table;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_free_table@
fp_name << find_struct_fp_assignment_free_table.FP_NAME;
func_name << find_struct_fp_assignment_free_table.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/free_table.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_free_table@
fp_name << find_init_fp_assignment_free_table.FP_NAME;
func_name << find_init_fp_assignment_free_table.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/free_table.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xMutexFree@
expression E;
identifier FP_NAME = xMutexFree;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xMutexFree@
identifier FP_NAME = xMutexFree;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xMutexFree@
fp_name << find_struct_fp_assignment_xMutexFree.FP_NAME;
func_name << find_struct_fp_assignment_xMutexFree.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xMutexFree.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xMutexFree@
fp_name << find_init_fp_assignment_xMutexFree.FP_NAME;
func_name << find_init_fp_assignment_xMutexFree.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xMutexFree.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_valDestructor@
expression E;
identifier FP_NAME = valDestructor;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_valDestructor@
identifier FP_NAME = valDestructor;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_valDestructor@
fp_name << find_struct_fp_assignment_valDestructor.FP_NAME;
func_name << find_struct_fp_assignment_valDestructor.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/valDestructor.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_valDestructor@
fp_name << find_init_fp_assignment_valDestructor.FP_NAME;
func_name << find_init_fp_assignment_valDestructor.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/valDestructor.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_system_errno@
expression E;
identifier FP_NAME = system_errno;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_system_errno@
identifier FP_NAME = system_errno;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_system_errno@
fp_name << find_struct_fp_assignment_system_errno.FP_NAME;
func_name << find_struct_fp_assignment_system_errno.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/system_errno.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_system_errno@
fp_name << find_init_fp_assignment_system_errno.FP_NAME;
func_name << find_init_fp_assignment_system_errno.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/system_errno.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_step@
expression E;
identifier FP_NAME = step;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_step@
identifier FP_NAME = step;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_step@
fp_name << find_struct_fp_assignment_step.FP_NAME;
func_name << find_struct_fp_assignment_step.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/step.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_step@
fp_name << find_init_fp_assignment_step.FP_NAME;
func_name << find_init_fp_assignment_step.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/step.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xUserData@
expression E;
identifier FP_NAME = xUserData;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xUserData@
identifier FP_NAME = xUserData;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xUserData@
fp_name << find_struct_fp_assignment_xUserData.FP_NAME;
func_name << find_struct_fp_assignment_xUserData.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xUserData.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xUserData@
fp_name << find_init_fp_assignment_xUserData.FP_NAME;
func_name << find_init_fp_assignment_xUserData.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xUserData.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_free@
expression E;
identifier FP_NAME = free;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_free@
identifier FP_NAME = free;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_free@
fp_name << find_struct_fp_assignment_free.FP_NAME;
func_name << find_struct_fp_assignment_free.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/free.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_free@
fp_name << find_init_fp_assignment_free.FP_NAME;
func_name << find_init_fp_assignment_free.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/free.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_x@
expression E;
identifier FP_NAME = x;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_x@
identifier FP_NAME = x;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_x@
fp_name << find_struct_fp_assignment_x.FP_NAME;
func_name << find_struct_fp_assignment_x.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/x.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_x@
fp_name << find_init_fp_assignment_x.FP_NAME;
func_name << find_init_fp_assignment_x.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/x.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_bind_int64@
expression E;
identifier FP_NAME = bind_int64;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_bind_int64@
identifier FP_NAME = bind_int64;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_bind_int64@
fp_name << find_struct_fp_assignment_bind_int64.FP_NAME;
func_name << find_struct_fp_assignment_bind_int64.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/bind_int64.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_bind_int64@
fp_name << find_init_fp_assignment_bind_int64.FP_NAME;
func_name << find_init_fp_assignment_bind_int64.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/bind_int64.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xSql@
expression E;
identifier FP_NAME = xSql;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xSql@
identifier FP_NAME = xSql;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xSql@
fp_name << find_struct_fp_assignment_xSql.FP_NAME;
func_name << find_struct_fp_assignment_xSql.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSql.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xSql@
fp_name << find_init_fp_assignment_xSql.FP_NAME;
func_name << find_init_fp_assignment_xSql.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xSql.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_errcode@
expression E;
identifier FP_NAME = errcode;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_errcode@
identifier FP_NAME = errcode;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_errcode@
fp_name << find_struct_fp_assignment_errcode.FP_NAME;
func_name << find_struct_fp_assignment_errcode.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/errcode.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_errcode@
fp_name << find_init_fp_assignment_errcode.FP_NAME;
func_name << find_init_fp_assignment_errcode.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/errcode.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_clear_bindings@
expression E;
identifier FP_NAME = clear_bindings;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_clear_bindings@
identifier FP_NAME = clear_bindings;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_clear_bindings@
fp_name << find_struct_fp_assignment_clear_bindings.FP_NAME;
func_name << find_struct_fp_assignment_clear_bindings.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/clear_bindings.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_clear_bindings@
fp_name << find_init_fp_assignment_clear_bindings.FP_NAME;
func_name << find_init_fp_assignment_clear_bindings.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/clear_bindings.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_xOut@
expression E;
identifier FP_NAME = xOut;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_xOut@
identifier FP_NAME = xOut;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_xOut@
fp_name << find_struct_fp_assignment_xOut.FP_NAME;
func_name << find_struct_fp_assignment_xOut.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xOut.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_xOut@
fp_name << find_init_fp_assignment_xOut.FP_NAME;
func_name << find_init_fp_assignment_xOut.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/xOut.txt", "a") as f:
    f.write(f"{func_name}\n")

// ===== FUNCTION POINTER ASSIGNMENT DETECTION =====

// Rule: Find struct member assignments (.fp = function)
@find_struct_fp_assignment_overload_function@
expression E;
identifier FP_NAME = overload_function;
identifier FUNC_NAME;
@@
(
E.FP_NAME = FUNC_NAME;
|
E.FP_NAME = &FUNC_NAME;
|
E->FP_NAME = FUNC_NAME;
|
E->FP_NAME = &FUNC_NAME;
)

// Rule: Find initialization assignments ({.fp = function})
@find_init_fp_assignment_overload_function@
identifier FP_NAME = overload_function;
identifier FUNC_NAME;
@@
{
.FP_NAME = FUNC_NAME,
}

// Extract assignment information using Python
@script:python depends on find_struct_fp_assignment_overload_function@
fp_name << find_struct_fp_assignment_overload_function.FP_NAME;
func_name << find_struct_fp_assignment_overload_function.FUNC_NAME;
@@
import os

print(f"[STRUCT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/overload_function.txt", "a") as f:
    f.write(f"{func_name}\n")

@script:python depends on find_init_fp_assignment_overload_function@
fp_name << find_init_fp_assignment_overload_function.FP_NAME;
func_name << find_init_fp_assignment_overload_function.FUNC_NAME;
@@
import os

print(f"[INIT_ASSIGNMENT] .{fp_name} = {func_name}")

# Save assignment info
with open("fpName/overload_function.txt", "a") as f:
    f.write(f"{func_name}\n")
