// Auto-generated Coccinelle script for function pointer to memcpy conversion
// 
// This script transforms function pointer assignments to memcpy calls:
//   E.FP_NAME = FUNC_NAME; -> memcpy(E.FP_NAME_signature, FP_NAME_signatures[FP_NAME_FUNC_NAME_enum], sizeof(...));
//
// Usage: spatch --sp-file convert_fp_to_memcpy.cocci --dir <source_directory> --in-place

@initialize:python@
@@
print(">>> Starting function pointer to memcpy conversion")
print(">>> Transforming assignments to memcpy calls")

# Clean up any existing output directories
import os
import shutil
if os.path.exists("memcpy_transformations"):
    shutil.rmtree("memcpy_transformations")
os.makedirs("memcpy_transformations", exist_ok=True)

print(">>> Created output directory: memcpy_transformations/")

// ===== FUNCTION POINTER ASSIGNMENT TO MEMCPY (specific functions) =====

// Rules for xAccess (2 functions)
// Rule: .xAccess = multiplexAccess ==> memcpy(...xAccess_signature..., xAccess_signatures[xAccess_multiplexAccess_enum], ...)
@transform_xAccess_multiplexAccess@
expression E;
identifier FP_NAME = xAccess;
identifier FUNC_NAME = multiplexAccess;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xAccess_signature, xAccess_signatures[xAccess_multiplexAccess_enum], sizeof(E.xAccess_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xAccess_signature, xAccess_signatures[xAccess_multiplexAccess_enum], sizeof(E.xAccess_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xAccess_signature, xAccess_signatures[xAccess_multiplexAccess_enum], sizeof(E->xAccess_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xAccess_signature, xAccess_signatures[xAccess_multiplexAccess_enum], sizeof(E->xAccess_signature));
)

// Rule: .xAccess = vfstraceAccess ==> memcpy(...xAccess_signature..., xAccess_signatures[xAccess_vfstraceAccess_enum], ...)
@transform_xAccess_vfstraceAccess@
expression E;
identifier FP_NAME = xAccess;
identifier FUNC_NAME = vfstraceAccess;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xAccess_signature, xAccess_signatures[xAccess_vfstraceAccess_enum], sizeof(E.xAccess_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xAccess_signature, xAccess_signatures[xAccess_vfstraceAccess_enum], sizeof(E.xAccess_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xAccess_signature, xAccess_signatures[xAccess_vfstraceAccess_enum], sizeof(E->xAccess_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xAccess_signature, xAccess_signatures[xAccess_vfstraceAccess_enum], sizeof(E->xAccess_signature));
)

// Rules for xAppend (2 functions)
// Rule: .xAppend = fts5AppendPoslist ==> memcpy(...xAppend_signature..., xAppend_signatures[xAppend_fts5AppendPoslist_enum], ...)
@transform_xAppend_fts5AppendPoslist@
expression E;
identifier FP_NAME = xAppend;
identifier FUNC_NAME = fts5AppendPoslist;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xAppend_signature, xAppend_signatures[xAppend_fts5AppendPoslist_enum], sizeof(E.xAppend_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xAppend_signature, xAppend_signatures[xAppend_fts5AppendPoslist_enum], sizeof(E.xAppend_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xAppend_signature, xAppend_signatures[xAppend_fts5AppendPoslist_enum], sizeof(E->xAppend_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xAppend_signature, xAppend_signatures[xAppend_fts5AppendPoslist_enum], sizeof(E->xAppend_signature));
)

// Rule: .xAppend = fts5AppendRowid ==> memcpy(...xAppend_signature..., xAppend_signatures[xAppend_fts5AppendRowid_enum], ...)
@transform_xAppend_fts5AppendRowid@
expression E;
identifier FP_NAME = xAppend;
identifier FUNC_NAME = fts5AppendRowid;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xAppend_signature, xAppend_signatures[xAppend_fts5AppendRowid_enum], sizeof(E.xAppend_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xAppend_signature, xAppend_signatures[xAppend_fts5AppendRowid_enum], sizeof(E.xAppend_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xAppend_signature, xAppend_signatures[xAppend_fts5AppendRowid_enum], sizeof(E->xAppend_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xAppend_signature, xAppend_signatures[xAppend_fts5AppendRowid_enum], sizeof(E->xAppend_signature));
)

// Rules for xBusy (1 functions)
// Rule: .xBusy = xBusy ==> memcpy(...xBusy_signature..., xBusy_signatures[xBusy_xBusy_enum], ...)
@transform_xBusy_xBusy@
expression E;
identifier FP_NAME = xBusy;
identifier FUNC_NAME = xBusy;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xBusy_signature, xBusy_signatures[xBusy_xBusy_enum], sizeof(E.xBusy_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xBusy_signature, xBusy_signatures[xBusy_xBusy_enum], sizeof(E.xBusy_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xBusy_signature, xBusy_signatures[xBusy_xBusy_enum], sizeof(E->xBusy_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xBusy_signature, xBusy_signatures[xBusy_xBusy_enum], sizeof(E->xBusy_signature));
)

// Rules for xCellSize (4 functions)
// Rule: .xCellSize = cellSizePtr ==> memcpy(...xCellSize_signature..., xCellSize_signatures[xCellSize_cellSizePtr_enum], ...)
@transform_xCellSize_cellSizePtr@
expression E;
identifier FP_NAME = xCellSize;
identifier FUNC_NAME = cellSizePtr;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtr_enum], sizeof(E.xCellSize_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtr_enum], sizeof(E.xCellSize_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtr_enum], sizeof(E->xCellSize_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtr_enum], sizeof(E->xCellSize_signature));
)

// Rule: .xCellSize = cellSizePtrIdxLeaf ==> memcpy(...xCellSize_signature..., xCellSize_signatures[xCellSize_cellSizePtrIdxLeaf_enum], ...)
@transform_xCellSize_cellSizePtrIdxLeaf@
expression E;
identifier FP_NAME = xCellSize;
identifier FUNC_NAME = cellSizePtrIdxLeaf;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrIdxLeaf_enum], sizeof(E.xCellSize_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrIdxLeaf_enum], sizeof(E.xCellSize_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrIdxLeaf_enum], sizeof(E->xCellSize_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrIdxLeaf_enum], sizeof(E->xCellSize_signature));
)

// Rule: .xCellSize = cellSizePtrNoPayload ==> memcpy(...xCellSize_signature..., xCellSize_signatures[xCellSize_cellSizePtrNoPayload_enum], ...)
@transform_xCellSize_cellSizePtrNoPayload@
expression E;
identifier FP_NAME = xCellSize;
identifier FUNC_NAME = cellSizePtrNoPayload;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrNoPayload_enum], sizeof(E.xCellSize_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrNoPayload_enum], sizeof(E.xCellSize_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrNoPayload_enum], sizeof(E->xCellSize_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrNoPayload_enum], sizeof(E->xCellSize_signature));
)

// Rule: .xCellSize = cellSizePtrTableLeaf ==> memcpy(...xCellSize_signature..., xCellSize_signatures[xCellSize_cellSizePtrTableLeaf_enum], ...)
@transform_xCellSize_cellSizePtrTableLeaf@
expression E;
identifier FP_NAME = xCellSize;
identifier FUNC_NAME = cellSizePtrTableLeaf;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrTableLeaf_enum], sizeof(E.xCellSize_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrTableLeaf_enum], sizeof(E.xCellSize_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrTableLeaf_enum], sizeof(E->xCellSize_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrTableLeaf_enum], sizeof(E->xCellSize_signature));
)

// Rules for xCheckReservedLock (3 functions)
// Rule: .xCheckReservedLock = multiplexCheckReservedLock ==> memcpy(...xCheckReservedLock_signature..., xCheckReservedLock_signatures[xCheckReservedLock_multiplexCheckReservedLock_enum], ...)
@transform_xCheckReservedLock_multiplexCheckReservedLock@
expression E;
identifier FP_NAME = xCheckReservedLock;
identifier FUNC_NAME = multiplexCheckReservedLock;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_multiplexCheckReservedLock_enum], sizeof(E.xCheckReservedLock_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_multiplexCheckReservedLock_enum], sizeof(E.xCheckReservedLock_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_multiplexCheckReservedLock_enum], sizeof(E->xCheckReservedLock_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_multiplexCheckReservedLock_enum], sizeof(E->xCheckReservedLock_signature));
)

// Rule: .xCheckReservedLock = quotaCheckReservedLock ==> memcpy(...xCheckReservedLock_signature..., xCheckReservedLock_signatures[xCheckReservedLock_quotaCheckReservedLock_enum], ...)
@transform_xCheckReservedLock_quotaCheckReservedLock@
expression E;
identifier FP_NAME = xCheckReservedLock;
identifier FUNC_NAME = quotaCheckReservedLock;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_quotaCheckReservedLock_enum], sizeof(E.xCheckReservedLock_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_quotaCheckReservedLock_enum], sizeof(E.xCheckReservedLock_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_quotaCheckReservedLock_enum], sizeof(E->xCheckReservedLock_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_quotaCheckReservedLock_enum], sizeof(E->xCheckReservedLock_signature));
)

// Rule: .xCheckReservedLock = vfstraceCheckReservedLock ==> memcpy(...xCheckReservedLock_signature..., xCheckReservedLock_signatures[xCheckReservedLock_vfstraceCheckReservedLock_enum], ...)
@transform_xCheckReservedLock_vfstraceCheckReservedLock@
expression E;
identifier FP_NAME = xCheckReservedLock;
identifier FUNC_NAME = vfstraceCheckReservedLock;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_vfstraceCheckReservedLock_enum], sizeof(E.xCheckReservedLock_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_vfstraceCheckReservedLock_enum], sizeof(E.xCheckReservedLock_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_vfstraceCheckReservedLock_enum], sizeof(E->xCheckReservedLock_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_vfstraceCheckReservedLock_enum], sizeof(E->xCheckReservedLock_signature));
)

// Rules for xClose (3 functions)
// Rule: .xClose = multiplexClose ==> memcpy(...xClose_signature..., xClose_signatures[xClose_multiplexClose_enum], ...)
@transform_xClose_multiplexClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = multiplexClose;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xClose_signature, xClose_signatures[xClose_multiplexClose_enum], sizeof(E.xClose_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xClose_signature, xClose_signatures[xClose_multiplexClose_enum], sizeof(E.xClose_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xClose_signature, xClose_signatures[xClose_multiplexClose_enum], sizeof(E->xClose_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xClose_signature, xClose_signatures[xClose_multiplexClose_enum], sizeof(E->xClose_signature));
)

// Rule: .xClose = quotaClose ==> memcpy(...xClose_signature..., xClose_signatures[xClose_quotaClose_enum], ...)
@transform_xClose_quotaClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = quotaClose;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xClose_signature, xClose_signatures[xClose_quotaClose_enum], sizeof(E.xClose_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xClose_signature, xClose_signatures[xClose_quotaClose_enum], sizeof(E.xClose_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xClose_signature, xClose_signatures[xClose_quotaClose_enum], sizeof(E->xClose_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xClose_signature, xClose_signatures[xClose_quotaClose_enum], sizeof(E->xClose_signature));
)

// Rule: .xClose = vfstraceClose ==> memcpy(...xClose_signature..., xClose_signatures[xClose_vfstraceClose_enum], ...)
@transform_xClose_vfstraceClose@
expression E;
identifier FP_NAME = xClose;
identifier FUNC_NAME = vfstraceClose;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xClose_signature, xClose_signatures[xClose_vfstraceClose_enum], sizeof(E.xClose_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xClose_signature, xClose_signatures[xClose_vfstraceClose_enum], sizeof(E.xClose_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xClose_signature, xClose_signatures[xClose_vfstraceClose_enum], sizeof(E->xClose_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xClose_signature, xClose_signatures[xClose_vfstraceClose_enum], sizeof(E->xClose_signature));
)

// Rules for xCount (3 functions)
// Rule: .xCount = sessionDiffCount ==> memcpy(...xCount_signature..., xCount_signatures[xCount_sessionDiffCount_enum], ...)
@transform_xCount_sessionDiffCount@
expression E;
identifier FP_NAME = xCount;
identifier FUNC_NAME = sessionDiffCount;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xCount_signature, xCount_signatures[xCount_sessionDiffCount_enum], sizeof(E.xCount_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xCount_signature, xCount_signatures[xCount_sessionDiffCount_enum], sizeof(E.xCount_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xCount_signature, xCount_signatures[xCount_sessionDiffCount_enum], sizeof(E->xCount_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xCount_signature, xCount_signatures[xCount_sessionDiffCount_enum], sizeof(E->xCount_signature));
)

// Rule: .xCount = sessionPreupdateCount ==> memcpy(...xCount_signature..., xCount_signatures[xCount_sessionPreupdateCount_enum], ...)
@transform_xCount_sessionPreupdateCount@
expression E;
identifier FP_NAME = xCount;
identifier FUNC_NAME = sessionPreupdateCount;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xCount_signature, xCount_signatures[xCount_sessionPreupdateCount_enum], sizeof(E.xCount_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xCount_signature, xCount_signatures[xCount_sessionPreupdateCount_enum], sizeof(E.xCount_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xCount_signature, xCount_signatures[xCount_sessionPreupdateCount_enum], sizeof(E->xCount_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xCount_signature, xCount_signatures[xCount_sessionPreupdateCount_enum], sizeof(E->xCount_signature));
)

// Rule: .xCount = sessionStat1Count ==> memcpy(...xCount_signature..., xCount_signatures[xCount_sessionStat1Count_enum], ...)
@transform_xCount_sessionStat1Count@
expression E;
identifier FP_NAME = xCount;
identifier FUNC_NAME = sessionStat1Count;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xCount_signature, xCount_signatures[xCount_sessionStat1Count_enum], sizeof(E.xCount_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xCount_signature, xCount_signatures[xCount_sessionStat1Count_enum], sizeof(E.xCount_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xCount_signature, xCount_signatures[xCount_sessionStat1Count_enum], sizeof(E->xCount_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xCount_signature, xCount_signatures[xCount_sessionStat1Count_enum], sizeof(E->xCount_signature));
)

// Rules for xCreate (1 functions)
// Rule: .xCreate = fts5VtoVCreate ==> memcpy(...xCreate_signature..., xCreate_signatures[xCreate_fts5VtoVCreate_enum], ...)
@transform_xCreate_fts5VtoVCreate@
expression E;
identifier FP_NAME = xCreate;
identifier FUNC_NAME = fts5VtoVCreate;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xCreate_signature, xCreate_signatures[xCreate_fts5VtoVCreate_enum], sizeof(E.xCreate_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xCreate_signature, xCreate_signatures[xCreate_fts5VtoVCreate_enum], sizeof(E.xCreate_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xCreate_signature, xCreate_signatures[xCreate_fts5VtoVCreate_enum], sizeof(E->xCreate_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xCreate_signature, xCreate_signatures[xCreate_fts5VtoVCreate_enum], sizeof(E->xCreate_signature));
)

// Rules for xCurrentTime (2 functions)
// Rule: .xCurrentTime = multiplexCurrentTime ==> memcpy(...xCurrentTime_signature..., xCurrentTime_signatures[xCurrentTime_multiplexCurrentTime_enum], ...)
@transform_xCurrentTime_multiplexCurrentTime@
expression E;
identifier FP_NAME = xCurrentTime;
identifier FUNC_NAME = multiplexCurrentTime;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_multiplexCurrentTime_enum], sizeof(E.xCurrentTime_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_multiplexCurrentTime_enum], sizeof(E.xCurrentTime_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_multiplexCurrentTime_enum], sizeof(E->xCurrentTime_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_multiplexCurrentTime_enum], sizeof(E->xCurrentTime_signature));
)

// Rule: .xCurrentTime = vfstraceCurrentTime ==> memcpy(...xCurrentTime_signature..., xCurrentTime_signatures[xCurrentTime_vfstraceCurrentTime_enum], ...)
@transform_xCurrentTime_vfstraceCurrentTime@
expression E;
identifier FP_NAME = xCurrentTime;
identifier FUNC_NAME = vfstraceCurrentTime;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_vfstraceCurrentTime_enum], sizeof(E.xCurrentTime_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_vfstraceCurrentTime_enum], sizeof(E.xCurrentTime_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_vfstraceCurrentTime_enum], sizeof(E->xCurrentTime_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_vfstraceCurrentTime_enum], sizeof(E->xCurrentTime_signature));
)

// Rules for xCurrentTimeInt64 (1 functions)
// Rule: .xCurrentTimeInt64 = multiplexCurrentTimeInt64 ==> memcpy(...xCurrentTimeInt64_signature..., xCurrentTimeInt64_signatures[xCurrentTimeInt64_multiplexCurrentTimeInt64_enum], ...)
@transform_xCurrentTimeInt64_multiplexCurrentTimeInt64@
expression E;
identifier FP_NAME = xCurrentTimeInt64;
identifier FUNC_NAME = multiplexCurrentTimeInt64;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xCurrentTimeInt64_signature, xCurrentTimeInt64_signatures[xCurrentTimeInt64_multiplexCurrentTimeInt64_enum], sizeof(E.xCurrentTimeInt64_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xCurrentTimeInt64_signature, xCurrentTimeInt64_signatures[xCurrentTimeInt64_multiplexCurrentTimeInt64_enum], sizeof(E.xCurrentTimeInt64_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xCurrentTimeInt64_signature, xCurrentTimeInt64_signatures[xCurrentTimeInt64_multiplexCurrentTimeInt64_enum], sizeof(E->xCurrentTimeInt64_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xCurrentTimeInt64_signature, xCurrentTimeInt64_signatures[xCurrentTimeInt64_multiplexCurrentTimeInt64_enum], sizeof(E->xCurrentTimeInt64_signature));
)

// Rules for xDelUser (2 functions)
// Rule: .xDelUser = circle_del ==> memcpy(...xDelUser_signature..., xDelUser_signatures[xDelUser_circle_del_enum], ...)
@transform_xDelUser_circle_del@
expression E;
identifier FP_NAME = xDelUser;
identifier FUNC_NAME = circle_del;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xDelUser_signature, xDelUser_signatures[xDelUser_circle_del_enum], sizeof(E.xDelUser_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xDelUser_signature, xDelUser_signatures[xDelUser_circle_del_enum], sizeof(E.xDelUser_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xDelUser_signature, xDelUser_signatures[xDelUser_circle_del_enum], sizeof(E->xDelUser_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xDelUser_signature, xDelUser_signatures[xDelUser_circle_del_enum], sizeof(E->xDelUser_signature));
)

// Rule: .xDelUser = cube_context_free ==> memcpy(...xDelUser_signature..., xDelUser_signatures[xDelUser_cube_context_free_enum], ...)
@transform_xDelUser_cube_context_free@
expression E;
identifier FP_NAME = xDelUser;
identifier FUNC_NAME = cube_context_free;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xDelUser_signature, xDelUser_signatures[xDelUser_cube_context_free_enum], sizeof(E.xDelUser_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xDelUser_signature, xDelUser_signatures[xDelUser_cube_context_free_enum], sizeof(E.xDelUser_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xDelUser_signature, xDelUser_signatures[xDelUser_cube_context_free_enum], sizeof(E->xDelUser_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xDelUser_signature, xDelUser_signatures[xDelUser_cube_context_free_enum], sizeof(E->xDelUser_signature));
)

// Rules for xDepth (3 functions)
// Rule: .xDepth = sessionDiffDepth ==> memcpy(...xDepth_signature..., xDepth_signatures[xDepth_sessionDiffDepth_enum], ...)
@transform_xDepth_sessionDiffDepth@
expression E;
identifier FP_NAME = xDepth;
identifier FUNC_NAME = sessionDiffDepth;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xDepth_signature, xDepth_signatures[xDepth_sessionDiffDepth_enum], sizeof(E.xDepth_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xDepth_signature, xDepth_signatures[xDepth_sessionDiffDepth_enum], sizeof(E.xDepth_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xDepth_signature, xDepth_signatures[xDepth_sessionDiffDepth_enum], sizeof(E->xDepth_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xDepth_signature, xDepth_signatures[xDepth_sessionDiffDepth_enum], sizeof(E->xDepth_signature));
)

// Rule: .xDepth = sessionPreupdateDepth ==> memcpy(...xDepth_signature..., xDepth_signatures[xDepth_sessionPreupdateDepth_enum], ...)
@transform_xDepth_sessionPreupdateDepth@
expression E;
identifier FP_NAME = xDepth;
identifier FUNC_NAME = sessionPreupdateDepth;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xDepth_signature, xDepth_signatures[xDepth_sessionPreupdateDepth_enum], sizeof(E.xDepth_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xDepth_signature, xDepth_signatures[xDepth_sessionPreupdateDepth_enum], sizeof(E.xDepth_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xDepth_signature, xDepth_signatures[xDepth_sessionPreupdateDepth_enum], sizeof(E->xDepth_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xDepth_signature, xDepth_signatures[xDepth_sessionPreupdateDepth_enum], sizeof(E->xDepth_signature));
)

// Rule: .xDepth = sessionStat1Depth ==> memcpy(...xDepth_signature..., xDepth_signatures[xDepth_sessionStat1Depth_enum], ...)
@transform_xDepth_sessionStat1Depth@
expression E;
identifier FP_NAME = xDepth;
identifier FUNC_NAME = sessionStat1Depth;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xDepth_signature, xDepth_signatures[xDepth_sessionStat1Depth_enum], sizeof(E.xDepth_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xDepth_signature, xDepth_signatures[xDepth_sessionStat1Depth_enum], sizeof(E.xDepth_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xDepth_signature, xDepth_signatures[xDepth_sessionStat1Depth_enum], sizeof(E->xDepth_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xDepth_signature, xDepth_signatures[xDepth_sessionStat1Depth_enum], sizeof(E->xDepth_signature));
)

// Rules for xDeviceCharacteristics (3 functions)
// Rule: .xDeviceCharacteristics = multiplexDeviceCharacteristics ==> memcpy(...xDeviceCharacteristics_signature..., xDeviceCharacteristics_signatures[xDeviceCharacteristics_multiplexDeviceCharacteristics_enum], ...)
@transform_xDeviceCharacteristics_multiplexDeviceCharacteristics@
expression E;
identifier FP_NAME = xDeviceCharacteristics;
identifier FUNC_NAME = multiplexDeviceCharacteristics;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_multiplexDeviceCharacteristics_enum], sizeof(E.xDeviceCharacteristics_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_multiplexDeviceCharacteristics_enum], sizeof(E.xDeviceCharacteristics_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_multiplexDeviceCharacteristics_enum], sizeof(E->xDeviceCharacteristics_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_multiplexDeviceCharacteristics_enum], sizeof(E->xDeviceCharacteristics_signature));
)

// Rule: .xDeviceCharacteristics = quotaDeviceCharacteristics ==> memcpy(...xDeviceCharacteristics_signature..., xDeviceCharacteristics_signatures[xDeviceCharacteristics_quotaDeviceCharacteristics_enum], ...)
@transform_xDeviceCharacteristics_quotaDeviceCharacteristics@
expression E;
identifier FP_NAME = xDeviceCharacteristics;
identifier FUNC_NAME = quotaDeviceCharacteristics;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_quotaDeviceCharacteristics_enum], sizeof(E.xDeviceCharacteristics_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_quotaDeviceCharacteristics_enum], sizeof(E.xDeviceCharacteristics_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_quotaDeviceCharacteristics_enum], sizeof(E->xDeviceCharacteristics_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_quotaDeviceCharacteristics_enum], sizeof(E->xDeviceCharacteristics_signature));
)

// Rule: .xDeviceCharacteristics = vfstraceDeviceCharacteristics ==> memcpy(...xDeviceCharacteristics_signature..., xDeviceCharacteristics_signatures[xDeviceCharacteristics_vfstraceDeviceCharacteristics_enum], ...)
@transform_xDeviceCharacteristics_vfstraceDeviceCharacteristics@
expression E;
identifier FP_NAME = xDeviceCharacteristics;
identifier FUNC_NAME = vfstraceDeviceCharacteristics;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_vfstraceDeviceCharacteristics_enum], sizeof(E.xDeviceCharacteristics_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_vfstraceDeviceCharacteristics_enum], sizeof(E.xDeviceCharacteristics_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_vfstraceDeviceCharacteristics_enum], sizeof(E->xDeviceCharacteristics_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_vfstraceDeviceCharacteristics_enum], sizeof(E->xDeviceCharacteristics_signature));
)

// Rules for xDlClose (1 functions)
// Rule: .xDlClose = multiplexDlClose ==> memcpy(...xDlClose_signature..., xDlClose_signatures[xDlClose_multiplexDlClose_enum], ...)
@transform_xDlClose_multiplexDlClose@
expression E;
identifier FP_NAME = xDlClose;
identifier FUNC_NAME = multiplexDlClose;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xDlClose_signature, xDlClose_signatures[xDlClose_multiplexDlClose_enum], sizeof(E.xDlClose_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xDlClose_signature, xDlClose_signatures[xDlClose_multiplexDlClose_enum], sizeof(E.xDlClose_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xDlClose_signature, xDlClose_signatures[xDlClose_multiplexDlClose_enum], sizeof(E->xDlClose_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xDlClose_signature, xDlClose_signatures[xDlClose_multiplexDlClose_enum], sizeof(E->xDlClose_signature));
)

// Rules for xDlError (1 functions)
// Rule: .xDlError = multiplexDlError ==> memcpy(...xDlError_signature..., xDlError_signatures[xDlError_multiplexDlError_enum], ...)
@transform_xDlError_multiplexDlError@
expression E;
identifier FP_NAME = xDlError;
identifier FUNC_NAME = multiplexDlError;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xDlError_signature, xDlError_signatures[xDlError_multiplexDlError_enum], sizeof(E.xDlError_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xDlError_signature, xDlError_signatures[xDlError_multiplexDlError_enum], sizeof(E.xDlError_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xDlError_signature, xDlError_signatures[xDlError_multiplexDlError_enum], sizeof(E->xDlError_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xDlError_signature, xDlError_signatures[xDlError_multiplexDlError_enum], sizeof(E->xDlError_signature));
)

// Rules for xExprCallback (37 functions)
// Rule: .xExprCallback = agginfoPersistExprCb ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_agginfoPersistExprCb_enum], ...)
@transform_xExprCallback_agginfoPersistExprCb@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = agginfoPersistExprCb;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_agginfoPersistExprCb_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_agginfoPersistExprCb_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_agginfoPersistExprCb_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_agginfoPersistExprCb_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = aggregateIdxEprRefToColCallback ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_aggregateIdxEprRefToColCallback_enum], ...)
@transform_xExprCallback_aggregateIdxEprRefToColCallback@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = aggregateIdxEprRefToColCallback;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_aggregateIdxEprRefToColCallback_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_aggregateIdxEprRefToColCallback_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_aggregateIdxEprRefToColCallback_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_aggregateIdxEprRefToColCallback_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = analyzeAggregate ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_analyzeAggregate_enum], ...)
@transform_xExprCallback_analyzeAggregate@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = analyzeAggregate;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_analyzeAggregate_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_analyzeAggregate_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_analyzeAggregate_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_analyzeAggregate_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = checkConstraintExprNode ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_checkConstraintExprNode_enum], ...)
@transform_xExprCallback_checkConstraintExprNode@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = checkConstraintExprNode;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_checkConstraintExprNode_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_checkConstraintExprNode_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_checkConstraintExprNode_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_checkConstraintExprNode_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = codeCursorHintCheckExpr ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_codeCursorHintCheckExpr_enum], ...)
@transform_xExprCallback_codeCursorHintCheckExpr@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = codeCursorHintCheckExpr;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintCheckExpr_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintCheckExpr_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintCheckExpr_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintCheckExpr_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = codeCursorHintFixExpr ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_codeCursorHintFixExpr_enum], ...)
@transform_xExprCallback_codeCursorHintFixExpr@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = codeCursorHintFixExpr;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintFixExpr_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintFixExpr_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintFixExpr_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintFixExpr_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = codeCursorHintIsOrFunction ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_codeCursorHintIsOrFunction_enum], ...)
@transform_xExprCallback_codeCursorHintIsOrFunction@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = codeCursorHintIsOrFunction;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintIsOrFunction_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintIsOrFunction_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintIsOrFunction_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintIsOrFunction_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = disallowAggregatesInOrderByCb ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_disallowAggregatesInOrderByCb_enum], ...)
@transform_xExprCallback_disallowAggregatesInOrderByCb@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = disallowAggregatesInOrderByCb;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_disallowAggregatesInOrderByCb_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_disallowAggregatesInOrderByCb_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_disallowAggregatesInOrderByCb_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_disallowAggregatesInOrderByCb_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = exprColumnFlagUnion ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_exprColumnFlagUnion_enum], ...)
@transform_xExprCallback_exprColumnFlagUnion@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = exprColumnFlagUnion;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprColumnFlagUnion_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprColumnFlagUnion_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprColumnFlagUnion_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprColumnFlagUnion_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = exprIdxCover ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_exprIdxCover_enum], ...)
@transform_xExprCallback_exprIdxCover@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = exprIdxCover;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprIdxCover_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprIdxCover_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprIdxCover_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprIdxCover_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = exprNodeCanReturnSubtype ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_exprNodeCanReturnSubtype_enum], ...)
@transform_xExprCallback_exprNodeCanReturnSubtype@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = exprNodeCanReturnSubtype;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeCanReturnSubtype_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeCanReturnSubtype_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeCanReturnSubtype_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeCanReturnSubtype_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = exprNodeIsConstant ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_exprNodeIsConstant_enum], ...)
@transform_xExprCallback_exprNodeIsConstant@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = exprNodeIsConstant;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsConstant_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsConstant_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsConstant_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsConstant_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = exprNodeIsConstantOrGroupBy ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_exprNodeIsConstantOrGroupBy_enum], ...)
@transform_xExprCallback_exprNodeIsConstantOrGroupBy@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = exprNodeIsConstantOrGroupBy;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsConstantOrGroupBy_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsConstantOrGroupBy_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsConstantOrGroupBy_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsConstantOrGroupBy_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = exprNodeIsDeterministic ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_exprNodeIsDeterministic_enum], ...)
@transform_xExprCallback_exprNodeIsDeterministic@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = exprNodeIsDeterministic;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsDeterministic_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsDeterministic_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsDeterministic_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsDeterministic_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = exprRefToSrcList ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_exprRefToSrcList_enum], ...)
@transform_xExprCallback_exprRefToSrcList@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = exprRefToSrcList;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprRefToSrcList_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprRefToSrcList_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprRefToSrcList_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprRefToSrcList_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = fixExprCb ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_fixExprCb_enum], ...)
@transform_xExprCallback_fixExprCb@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = fixExprCb;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_fixExprCb_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_fixExprCb_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_fixExprCb_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_fixExprCb_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = gatherSelectWindowsCallback ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_gatherSelectWindowsCallback_enum], ...)
@transform_xExprCallback_gatherSelectWindowsCallback@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = gatherSelectWindowsCallback;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_gatherSelectWindowsCallback_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_gatherSelectWindowsCallback_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_gatherSelectWindowsCallback_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_gatherSelectWindowsCallback_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = havingToWhereExprCb ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_havingToWhereExprCb_enum], ...)
@transform_xExprCallback_havingToWhereExprCb@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = havingToWhereExprCb;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_havingToWhereExprCb_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_havingToWhereExprCb_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_havingToWhereExprCb_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_havingToWhereExprCb_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = impliesNotNullRow ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_impliesNotNullRow_enum], ...)
@transform_xExprCallback_impliesNotNullRow@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = impliesNotNullRow;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_impliesNotNullRow_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_impliesNotNullRow_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_impliesNotNullRow_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_impliesNotNullRow_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = incrAggDepth ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_incrAggDepth_enum], ...)
@transform_xExprCallback_incrAggDepth@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = incrAggDepth;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_incrAggDepth_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_incrAggDepth_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_incrAggDepth_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_incrAggDepth_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = markImmutableExprStep ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_markImmutableExprStep_enum], ...)
@transform_xExprCallback_markImmutableExprStep@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = markImmutableExprStep;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_markImmutableExprStep_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_markImmutableExprStep_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_markImmutableExprStep_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_markImmutableExprStep_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = propagateConstantExprRewrite ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_propagateConstantExprRewrite_enum], ...)
@transform_xExprCallback_propagateConstantExprRewrite@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = propagateConstantExprRewrite;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_propagateConstantExprRewrite_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_propagateConstantExprRewrite_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_propagateConstantExprRewrite_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_propagateConstantExprRewrite_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = recomputeColumnsUsedExpr ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_recomputeColumnsUsedExpr_enum], ...)
@transform_xExprCallback_recomputeColumnsUsedExpr@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = recomputeColumnsUsedExpr;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_recomputeColumnsUsedExpr_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_recomputeColumnsUsedExpr_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_recomputeColumnsUsedExpr_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_recomputeColumnsUsedExpr_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = renameColumnExprCb ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_renameColumnExprCb_enum], ...)
@transform_xExprCallback_renameColumnExprCb@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = renameColumnExprCb;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameColumnExprCb_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameColumnExprCb_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameColumnExprCb_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameColumnExprCb_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = renameQuotefixExprCb ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_renameQuotefixExprCb_enum], ...)
@transform_xExprCallback_renameQuotefixExprCb@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = renameQuotefixExprCb;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameQuotefixExprCb_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameQuotefixExprCb_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameQuotefixExprCb_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameQuotefixExprCb_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = renameTableExprCb ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_renameTableExprCb_enum], ...)
@transform_xExprCallback_renameTableExprCb@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = renameTableExprCb;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameTableExprCb_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameTableExprCb_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameTableExprCb_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameTableExprCb_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = renameUnmapExprCb ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_renameUnmapExprCb_enum], ...)
@transform_xExprCallback_renameUnmapExprCb@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = renameUnmapExprCb;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameUnmapExprCb_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameUnmapExprCb_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameUnmapExprCb_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameUnmapExprCb_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = renumberCursorsCb ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_renumberCursorsCb_enum], ...)
@transform_xExprCallback_renumberCursorsCb@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = renumberCursorsCb;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renumberCursorsCb_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renumberCursorsCb_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renumberCursorsCb_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renumberCursorsCb_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = resolveExprStep ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_resolveExprStep_enum], ...)
@transform_xExprCallback_resolveExprStep@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = resolveExprStep;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_resolveExprStep_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_resolveExprStep_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_resolveExprStep_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_resolveExprStep_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = resolveRemoveWindowsCb ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_resolveRemoveWindowsCb_enum], ...)
@transform_xExprCallback_resolveRemoveWindowsCb@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = resolveRemoveWindowsCb;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_resolveRemoveWindowsCb_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_resolveRemoveWindowsCb_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_resolveRemoveWindowsCb_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_resolveRemoveWindowsCb_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = selectCheckOnClausesExpr ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_selectCheckOnClausesExpr_enum], ...)
@transform_xExprCallback_selectCheckOnClausesExpr@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = selectCheckOnClausesExpr;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_selectCheckOnClausesExpr_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_selectCheckOnClausesExpr_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_selectCheckOnClausesExpr_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_selectCheckOnClausesExpr_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = selectWindowRewriteExprCb ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_selectWindowRewriteExprCb_enum], ...)
@transform_xExprCallback_selectWindowRewriteExprCb@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = selectWindowRewriteExprCb;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_selectWindowRewriteExprCb_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_selectWindowRewriteExprCb_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_selectWindowRewriteExprCb_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_selectWindowRewriteExprCb_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = sqlite3CursorRangeHintExprCheck ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_sqlite3CursorRangeHintExprCheck_enum], ...)
@transform_xExprCallback_sqlite3CursorRangeHintExprCheck@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = sqlite3CursorRangeHintExprCheck;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3CursorRangeHintExprCheck_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3CursorRangeHintExprCheck_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3CursorRangeHintExprCheck_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3CursorRangeHintExprCheck_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = sqlite3ExprWalkNoop ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_sqlite3ExprWalkNoop_enum], ...)
@transform_xExprCallback_sqlite3ExprWalkNoop@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = sqlite3ExprWalkNoop;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3ExprWalkNoop_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3ExprWalkNoop_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3ExprWalkNoop_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3ExprWalkNoop_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = sqlite3ReturningSubqueryVarSelect ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_sqlite3ReturningSubqueryVarSelect_enum], ...)
@transform_xExprCallback_sqlite3ReturningSubqueryVarSelect@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = sqlite3ReturningSubqueryVarSelect;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3ReturningSubqueryVarSelect_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3ReturningSubqueryVarSelect_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3ReturningSubqueryVarSelect_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3ReturningSubqueryVarSelect_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = sqlite3WindowExtraAggFuncDepth ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_sqlite3WindowExtraAggFuncDepth_enum], ...)
@transform_xExprCallback_sqlite3WindowExtraAggFuncDepth@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = sqlite3WindowExtraAggFuncDepth;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3WindowExtraAggFuncDepth_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3WindowExtraAggFuncDepth_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3WindowExtraAggFuncDepth_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3WindowExtraAggFuncDepth_enum], sizeof(E->xExprCallback_signature));
)

// Rule: .xExprCallback = whereIsCoveringIndexWalkCallback ==> memcpy(...xExprCallback_signature..., xExprCallback_signatures[xExprCallback_whereIsCoveringIndexWalkCallback_enum], ...)
@transform_xExprCallback_whereIsCoveringIndexWalkCallback@
expression E;
identifier FP_NAME = xExprCallback;
identifier FUNC_NAME = whereIsCoveringIndexWalkCallback;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_whereIsCoveringIndexWalkCallback_enum], sizeof(E.xExprCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_whereIsCoveringIndexWalkCallback_enum], sizeof(E.xExprCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_whereIsCoveringIndexWalkCallback_enum], sizeof(E->xExprCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_whereIsCoveringIndexWalkCallback_enum], sizeof(E->xExprCallback_signature));
)

// Rules for xFileControl (3 functions)
// Rule: .xFileControl = multiplexFileControl ==> memcpy(...xFileControl_signature..., xFileControl_signatures[xFileControl_multiplexFileControl_enum], ...)
@transform_xFileControl_multiplexFileControl@
expression E;
identifier FP_NAME = xFileControl;
identifier FUNC_NAME = multiplexFileControl;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xFileControl_signature, xFileControl_signatures[xFileControl_multiplexFileControl_enum], sizeof(E.xFileControl_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xFileControl_signature, xFileControl_signatures[xFileControl_multiplexFileControl_enum], sizeof(E.xFileControl_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xFileControl_signature, xFileControl_signatures[xFileControl_multiplexFileControl_enum], sizeof(E->xFileControl_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xFileControl_signature, xFileControl_signatures[xFileControl_multiplexFileControl_enum], sizeof(E->xFileControl_signature));
)

// Rule: .xFileControl = quotaFileControl ==> memcpy(...xFileControl_signature..., xFileControl_signatures[xFileControl_quotaFileControl_enum], ...)
@transform_xFileControl_quotaFileControl@
expression E;
identifier FP_NAME = xFileControl;
identifier FUNC_NAME = quotaFileControl;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xFileControl_signature, xFileControl_signatures[xFileControl_quotaFileControl_enum], sizeof(E.xFileControl_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xFileControl_signature, xFileControl_signatures[xFileControl_quotaFileControl_enum], sizeof(E.xFileControl_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xFileControl_signature, xFileControl_signatures[xFileControl_quotaFileControl_enum], sizeof(E->xFileControl_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xFileControl_signature, xFileControl_signatures[xFileControl_quotaFileControl_enum], sizeof(E->xFileControl_signature));
)

// Rule: .xFileControl = vfstraceFileControl ==> memcpy(...xFileControl_signature..., xFileControl_signatures[xFileControl_vfstraceFileControl_enum], ...)
@transform_xFileControl_vfstraceFileControl@
expression E;
identifier FP_NAME = xFileControl;
identifier FUNC_NAME = vfstraceFileControl;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xFileControl_signature, xFileControl_signatures[xFileControl_vfstraceFileControl_enum], sizeof(E.xFileControl_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xFileControl_signature, xFileControl_signatures[xFileControl_vfstraceFileControl_enum], sizeof(E.xFileControl_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xFileControl_signature, xFileControl_signatures[xFileControl_vfstraceFileControl_enum], sizeof(E->xFileControl_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xFileControl_signature, xFileControl_signatures[xFileControl_vfstraceFileControl_enum], sizeof(E->xFileControl_signature));
)

// Rules for xFileSize (3 functions)
// Rule: .xFileSize = multiplexFileSize ==> memcpy(...xFileSize_signature..., xFileSize_signatures[xFileSize_multiplexFileSize_enum], ...)
@transform_xFileSize_multiplexFileSize@
expression E;
identifier FP_NAME = xFileSize;
identifier FUNC_NAME = multiplexFileSize;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xFileSize_signature, xFileSize_signatures[xFileSize_multiplexFileSize_enum], sizeof(E.xFileSize_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xFileSize_signature, xFileSize_signatures[xFileSize_multiplexFileSize_enum], sizeof(E.xFileSize_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xFileSize_signature, xFileSize_signatures[xFileSize_multiplexFileSize_enum], sizeof(E->xFileSize_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xFileSize_signature, xFileSize_signatures[xFileSize_multiplexFileSize_enum], sizeof(E->xFileSize_signature));
)

// Rule: .xFileSize = quotaFileSize ==> memcpy(...xFileSize_signature..., xFileSize_signatures[xFileSize_quotaFileSize_enum], ...)
@transform_xFileSize_quotaFileSize@
expression E;
identifier FP_NAME = xFileSize;
identifier FUNC_NAME = quotaFileSize;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xFileSize_signature, xFileSize_signatures[xFileSize_quotaFileSize_enum], sizeof(E.xFileSize_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xFileSize_signature, xFileSize_signatures[xFileSize_quotaFileSize_enum], sizeof(E.xFileSize_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xFileSize_signature, xFileSize_signatures[xFileSize_quotaFileSize_enum], sizeof(E->xFileSize_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xFileSize_signature, xFileSize_signatures[xFileSize_quotaFileSize_enum], sizeof(E->xFileSize_signature));
)

// Rule: .xFileSize = vfstraceFileSize ==> memcpy(...xFileSize_signature..., xFileSize_signatures[xFileSize_vfstraceFileSize_enum], ...)
@transform_xFileSize_vfstraceFileSize@
expression E;
identifier FP_NAME = xFileSize;
identifier FUNC_NAME = vfstraceFileSize;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xFileSize_signature, xFileSize_signatures[xFileSize_vfstraceFileSize_enum], sizeof(E.xFileSize_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xFileSize_signature, xFileSize_signatures[xFileSize_vfstraceFileSize_enum], sizeof(E.xFileSize_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xFileSize_signature, xFileSize_signatures[xFileSize_vfstraceFileSize_enum], sizeof(E->xFileSize_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xFileSize_signature, xFileSize_signatures[xFileSize_vfstraceFileSize_enum], sizeof(E->xFileSize_signature));
)

// Rules for xFindTokenizer (1 functions)
// Rule: .xFindTokenizer = fts5FindTokenizer ==> memcpy(...xFindTokenizer_signature..., xFindTokenizer_signatures[xFindTokenizer_fts5FindTokenizer_enum], ...)
@transform_xFindTokenizer_fts5FindTokenizer@
expression E;
identifier FP_NAME = xFindTokenizer;
identifier FUNC_NAME = fts5FindTokenizer;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xFindTokenizer_signature, xFindTokenizer_signatures[xFindTokenizer_fts5FindTokenizer_enum], sizeof(E.xFindTokenizer_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xFindTokenizer_signature, xFindTokenizer_signatures[xFindTokenizer_fts5FindTokenizer_enum], sizeof(E.xFindTokenizer_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xFindTokenizer_signature, xFindTokenizer_signatures[xFindTokenizer_fts5FindTokenizer_enum], sizeof(E->xFindTokenizer_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xFindTokenizer_signature, xFindTokenizer_signatures[xFindTokenizer_fts5FindTokenizer_enum], sizeof(E->xFindTokenizer_signature));
)

// Rules for xFindTokenizer_v2 (1 functions)
// Rule: .xFindTokenizer_v2 = fts5FindTokenizer_v2 ==> memcpy(...xFindTokenizer_v2_signature..., xFindTokenizer_v2_signatures[xFindTokenizer_v2_fts5FindTokenizer_v2_enum], ...)
@transform_xFindTokenizer_v2_fts5FindTokenizer_v2@
expression E;
identifier FP_NAME = xFindTokenizer_v2;
identifier FUNC_NAME = fts5FindTokenizer_v2;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xFindTokenizer_v2_signature, xFindTokenizer_v2_signatures[xFindTokenizer_v2_fts5FindTokenizer_v2_enum], sizeof(E.xFindTokenizer_v2_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xFindTokenizer_v2_signature, xFindTokenizer_v2_signatures[xFindTokenizer_v2_fts5FindTokenizer_v2_enum], sizeof(E.xFindTokenizer_v2_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xFindTokenizer_v2_signature, xFindTokenizer_v2_signatures[xFindTokenizer_v2_fts5FindTokenizer_v2_enum], sizeof(E->xFindTokenizer_v2_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xFindTokenizer_v2_signature, xFindTokenizer_v2_signatures[xFindTokenizer_v2_fts5FindTokenizer_v2_enum], sizeof(E->xFindTokenizer_v2_signature));
)

// Rules for xFree (1 functions)
// Rule: .xFree = xFree ==> memcpy(...xFree_signature..., xFree_signatures[xFree_xFree_enum], ...)
@transform_xFree_xFree@
expression E;
identifier FP_NAME = xFree;
identifier FUNC_NAME = xFree;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xFree_signature, xFree_signatures[xFree_xFree_enum], sizeof(E.xFree_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xFree_signature, xFree_signatures[xFree_xFree_enum], sizeof(E.xFree_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xFree_signature, xFree_signatures[xFree_xFree_enum], sizeof(E->xFree_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xFree_signature, xFree_signatures[xFree_xFree_enum], sizeof(E->xFree_signature));
)

// Rules for xFreeSchema (1 functions)
// Rule: .xFreeSchema = xFree ==> memcpy(...xFreeSchema_signature..., xFreeSchema_signatures[xFreeSchema_xFree_enum], ...)
@transform_xFreeSchema_xFree@
expression E;
identifier FP_NAME = xFreeSchema;
identifier FUNC_NAME = xFree;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xFreeSchema_signature, xFreeSchema_signatures[xFreeSchema_xFree_enum], sizeof(E.xFreeSchema_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xFreeSchema_signature, xFreeSchema_signatures[xFreeSchema_xFree_enum], sizeof(E.xFreeSchema_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xFreeSchema_signature, xFreeSchema_signatures[xFreeSchema_xFree_enum], sizeof(E->xFreeSchema_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xFreeSchema_signature, xFreeSchema_signatures[xFreeSchema_xFree_enum], sizeof(E->xFreeSchema_signature));
)

// Rules for xFullPathname (2 functions)
// Rule: .xFullPathname = multiplexFullPathname ==> memcpy(...xFullPathname_signature..., xFullPathname_signatures[xFullPathname_multiplexFullPathname_enum], ...)
@transform_xFullPathname_multiplexFullPathname@
expression E;
identifier FP_NAME = xFullPathname;
identifier FUNC_NAME = multiplexFullPathname;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xFullPathname_signature, xFullPathname_signatures[xFullPathname_multiplexFullPathname_enum], sizeof(E.xFullPathname_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xFullPathname_signature, xFullPathname_signatures[xFullPathname_multiplexFullPathname_enum], sizeof(E.xFullPathname_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xFullPathname_signature, xFullPathname_signatures[xFullPathname_multiplexFullPathname_enum], sizeof(E->xFullPathname_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xFullPathname_signature, xFullPathname_signatures[xFullPathname_multiplexFullPathname_enum], sizeof(E->xFullPathname_signature));
)

// Rule: .xFullPathname = vfstraceFullPathname ==> memcpy(...xFullPathname_signature..., xFullPathname_signatures[xFullPathname_vfstraceFullPathname_enum], ...)
@transform_xFullPathname_vfstraceFullPathname@
expression E;
identifier FP_NAME = xFullPathname;
identifier FUNC_NAME = vfstraceFullPathname;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xFullPathname_signature, xFullPathname_signatures[xFullPathname_vfstraceFullPathname_enum], sizeof(E.xFullPathname_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xFullPathname_signature, xFullPathname_signatures[xFullPathname_vfstraceFullPathname_enum], sizeof(E.xFullPathname_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xFullPathname_signature, xFullPathname_signatures[xFullPathname_vfstraceFullPathname_enum], sizeof(E->xFullPathname_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xFullPathname_signature, xFullPathname_signatures[xFullPathname_vfstraceFullPathname_enum], sizeof(E->xFullPathname_signature));
)

// Rules for xGet (3 functions)
// Rule: .xGet = getPageError ==> memcpy(...xGet_signature..., xGet_signatures[xGet_getPageError_enum], ...)
@transform_xGet_getPageError@
expression E;
identifier FP_NAME = xGet;
identifier FUNC_NAME = getPageError;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xGet_signature, xGet_signatures[xGet_getPageError_enum], sizeof(E.xGet_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xGet_signature, xGet_signatures[xGet_getPageError_enum], sizeof(E.xGet_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xGet_signature, xGet_signatures[xGet_getPageError_enum], sizeof(E->xGet_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xGet_signature, xGet_signatures[xGet_getPageError_enum], sizeof(E->xGet_signature));
)

// Rule: .xGet = getPageMMap ==> memcpy(...xGet_signature..., xGet_signatures[xGet_getPageMMap_enum], ...)
@transform_xGet_getPageMMap@
expression E;
identifier FP_NAME = xGet;
identifier FUNC_NAME = getPageMMap;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xGet_signature, xGet_signatures[xGet_getPageMMap_enum], sizeof(E.xGet_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xGet_signature, xGet_signatures[xGet_getPageMMap_enum], sizeof(E.xGet_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xGet_signature, xGet_signatures[xGet_getPageMMap_enum], sizeof(E->xGet_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xGet_signature, xGet_signatures[xGet_getPageMMap_enum], sizeof(E->xGet_signature));
)

// Rule: .xGet = getPageNormal ==> memcpy(...xGet_signature..., xGet_signatures[xGet_getPageNormal_enum], ...)
@transform_xGet_getPageNormal@
expression E;
identifier FP_NAME = xGet;
identifier FUNC_NAME = getPageNormal;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xGet_signature, xGet_signatures[xGet_getPageNormal_enum], sizeof(E.xGet_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xGet_signature, xGet_signatures[xGet_getPageNormal_enum], sizeof(E.xGet_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xGet_signature, xGet_signatures[xGet_getPageNormal_enum], sizeof(E->xGet_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xGet_signature, xGet_signatures[xGet_getPageNormal_enum], sizeof(E->xGet_signature));
)

// Rules for xGetLastError (1 functions)
// Rule: .xGetLastError = multiplexGetLastError ==> memcpy(...xGetLastError_signature..., xGetLastError_signatures[xGetLastError_multiplexGetLastError_enum], ...)
@transform_xGetLastError_multiplexGetLastError@
expression E;
identifier FP_NAME = xGetLastError;
identifier FUNC_NAME = multiplexGetLastError;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xGetLastError_signature, xGetLastError_signatures[xGetLastError_multiplexGetLastError_enum], sizeof(E.xGetLastError_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xGetLastError_signature, xGetLastError_signatures[xGetLastError_multiplexGetLastError_enum], sizeof(E.xGetLastError_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xGetLastError_signature, xGetLastError_signatures[xGetLastError_multiplexGetLastError_enum], sizeof(E->xGetLastError_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xGetLastError_signature, xGetLastError_signatures[xGetLastError_multiplexGetLastError_enum], sizeof(E->xGetLastError_signature));
)

// Rules for xLock (3 functions)
// Rule: .xLock = multiplexLock ==> memcpy(...xLock_signature..., xLock_signatures[xLock_multiplexLock_enum], ...)
@transform_xLock_multiplexLock@
expression E;
identifier FP_NAME = xLock;
identifier FUNC_NAME = multiplexLock;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xLock_signature, xLock_signatures[xLock_multiplexLock_enum], sizeof(E.xLock_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xLock_signature, xLock_signatures[xLock_multiplexLock_enum], sizeof(E.xLock_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xLock_signature, xLock_signatures[xLock_multiplexLock_enum], sizeof(E->xLock_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xLock_signature, xLock_signatures[xLock_multiplexLock_enum], sizeof(E->xLock_signature));
)

// Rule: .xLock = quotaLock ==> memcpy(...xLock_signature..., xLock_signatures[xLock_quotaLock_enum], ...)
@transform_xLock_quotaLock@
expression E;
identifier FP_NAME = xLock;
identifier FUNC_NAME = quotaLock;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xLock_signature, xLock_signatures[xLock_quotaLock_enum], sizeof(E.xLock_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xLock_signature, xLock_signatures[xLock_quotaLock_enum], sizeof(E.xLock_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xLock_signature, xLock_signatures[xLock_quotaLock_enum], sizeof(E->xLock_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xLock_signature, xLock_signatures[xLock_quotaLock_enum], sizeof(E->xLock_signature));
)

// Rule: .xLock = vfstraceLock ==> memcpy(...xLock_signature..., xLock_signatures[xLock_vfstraceLock_enum], ...)
@transform_xLock_vfstraceLock@
expression E;
identifier FP_NAME = xLock;
identifier FUNC_NAME = vfstraceLock;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xLock_signature, xLock_signatures[xLock_vfstraceLock_enum], sizeof(E.xLock_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xLock_signature, xLock_signatures[xLock_vfstraceLock_enum], sizeof(E.xLock_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xLock_signature, xLock_signatures[xLock_vfstraceLock_enum], sizeof(E->xLock_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xLock_signature, xLock_signatures[xLock_vfstraceLock_enum], sizeof(E->xLock_signature));
)

// Rules for xMerge (2 functions)
// Rule: .xMerge = fts5MergePrefixLists ==> memcpy(...xMerge_signature..., xMerge_signatures[xMerge_fts5MergePrefixLists_enum], ...)
@transform_xMerge_fts5MergePrefixLists@
expression E;
identifier FP_NAME = xMerge;
identifier FUNC_NAME = fts5MergePrefixLists;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xMerge_signature, xMerge_signatures[xMerge_fts5MergePrefixLists_enum], sizeof(E.xMerge_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xMerge_signature, xMerge_signatures[xMerge_fts5MergePrefixLists_enum], sizeof(E.xMerge_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xMerge_signature, xMerge_signatures[xMerge_fts5MergePrefixLists_enum], sizeof(E->xMerge_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xMerge_signature, xMerge_signatures[xMerge_fts5MergePrefixLists_enum], sizeof(E->xMerge_signature));
)

// Rule: .xMerge = fts5MergeRowidLists ==> memcpy(...xMerge_signature..., xMerge_signatures[xMerge_fts5MergeRowidLists_enum], ...)
@transform_xMerge_fts5MergeRowidLists@
expression E;
identifier FP_NAME = xMerge;
identifier FUNC_NAME = fts5MergeRowidLists;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xMerge_signature, xMerge_signatures[xMerge_fts5MergeRowidLists_enum], sizeof(E.xMerge_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xMerge_signature, xMerge_signatures[xMerge_fts5MergeRowidLists_enum], sizeof(E.xMerge_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xMerge_signature, xMerge_signatures[xMerge_fts5MergeRowidLists_enum], sizeof(E->xMerge_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xMerge_signature, xMerge_signatures[xMerge_fts5MergeRowidLists_enum], sizeof(E->xMerge_signature));
)

// Rules for xNew (3 functions)
// Rule: .xNew = sessionDiffNew ==> memcpy(...xNew_signature..., xNew_signatures[xNew_sessionDiffNew_enum], ...)
@transform_xNew_sessionDiffNew@
expression E;
identifier FP_NAME = xNew;
identifier FUNC_NAME = sessionDiffNew;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xNew_signature, xNew_signatures[xNew_sessionDiffNew_enum], sizeof(E.xNew_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xNew_signature, xNew_signatures[xNew_sessionDiffNew_enum], sizeof(E.xNew_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xNew_signature, xNew_signatures[xNew_sessionDiffNew_enum], sizeof(E->xNew_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xNew_signature, xNew_signatures[xNew_sessionDiffNew_enum], sizeof(E->xNew_signature));
)

// Rule: .xNew = sessionPreupdateNew ==> memcpy(...xNew_signature..., xNew_signatures[xNew_sessionPreupdateNew_enum], ...)
@transform_xNew_sessionPreupdateNew@
expression E;
identifier FP_NAME = xNew;
identifier FUNC_NAME = sessionPreupdateNew;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xNew_signature, xNew_signatures[xNew_sessionPreupdateNew_enum], sizeof(E.xNew_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xNew_signature, xNew_signatures[xNew_sessionPreupdateNew_enum], sizeof(E.xNew_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xNew_signature, xNew_signatures[xNew_sessionPreupdateNew_enum], sizeof(E->xNew_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xNew_signature, xNew_signatures[xNew_sessionPreupdateNew_enum], sizeof(E->xNew_signature));
)

// Rule: .xNew = sessionStat1New ==> memcpy(...xNew_signature..., xNew_signatures[xNew_sessionStat1New_enum], ...)
@transform_xNew_sessionStat1New@
expression E;
identifier FP_NAME = xNew;
identifier FUNC_NAME = sessionStat1New;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xNew_signature, xNew_signatures[xNew_sessionStat1New_enum], sizeof(E.xNew_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xNew_signature, xNew_signatures[xNew_sessionStat1New_enum], sizeof(E.xNew_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xNew_signature, xNew_signatures[xNew_sessionStat1New_enum], sizeof(E->xNew_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xNew_signature, xNew_signatures[xNew_sessionStat1New_enum], sizeof(E->xNew_signature));
)

// Rules for xNext (8 functions)
// Rule: .xNext = fts5ExprNodeNext_AND ==> memcpy(...xNext_signature..., xNext_signatures[xNext_fts5ExprNodeNext_AND_enum], ...)
@transform_xNext_fts5ExprNodeNext_AND@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = fts5ExprNodeNext_AND;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_AND_enum], sizeof(E.xNext_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_AND_enum], sizeof(E.xNext_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_AND_enum], sizeof(E->xNext_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_AND_enum], sizeof(E->xNext_signature));
)

// Rule: .xNext = fts5ExprNodeNext_NOT ==> memcpy(...xNext_signature..., xNext_signatures[xNext_fts5ExprNodeNext_NOT_enum], ...)
@transform_xNext_fts5ExprNodeNext_NOT@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = fts5ExprNodeNext_NOT;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_NOT_enum], sizeof(E.xNext_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_NOT_enum], sizeof(E.xNext_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_NOT_enum], sizeof(E->xNext_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_NOT_enum], sizeof(E->xNext_signature));
)

// Rule: .xNext = fts5ExprNodeNext_OR ==> memcpy(...xNext_signature..., xNext_signatures[xNext_fts5ExprNodeNext_OR_enum], ...)
@transform_xNext_fts5ExprNodeNext_OR@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = fts5ExprNodeNext_OR;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_OR_enum], sizeof(E.xNext_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_OR_enum], sizeof(E.xNext_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_OR_enum], sizeof(E->xNext_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_OR_enum], sizeof(E->xNext_signature));
)

// Rule: .xNext = fts5ExprNodeNext_STRING ==> memcpy(...xNext_signature..., xNext_signatures[xNext_fts5ExprNodeNext_STRING_enum], ...)
@transform_xNext_fts5ExprNodeNext_STRING@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = fts5ExprNodeNext_STRING;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_STRING_enum], sizeof(E.xNext_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_STRING_enum], sizeof(E.xNext_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_STRING_enum], sizeof(E->xNext_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_STRING_enum], sizeof(E->xNext_signature));
)

// Rule: .xNext = fts5ExprNodeNext_TERM ==> memcpy(...xNext_signature..., xNext_signatures[xNext_fts5ExprNodeNext_TERM_enum], ...)
@transform_xNext_fts5ExprNodeNext_TERM@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = fts5ExprNodeNext_TERM;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_TERM_enum], sizeof(E.xNext_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_TERM_enum], sizeof(E.xNext_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_TERM_enum], sizeof(E->xNext_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_TERM_enum], sizeof(E->xNext_signature));
)

// Rule: .xNext = fts5SegIterNext ==> memcpy(...xNext_signature..., xNext_signatures[xNext_fts5SegIterNext_enum], ...)
@transform_xNext_fts5SegIterNext@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = fts5SegIterNext;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xNext_signature, xNext_signatures[xNext_fts5SegIterNext_enum], sizeof(E.xNext_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xNext_signature, xNext_signatures[xNext_fts5SegIterNext_enum], sizeof(E.xNext_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xNext_signature, xNext_signatures[xNext_fts5SegIterNext_enum], sizeof(E->xNext_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xNext_signature, xNext_signatures[xNext_fts5SegIterNext_enum], sizeof(E->xNext_signature));
)

// Rule: .xNext = fts5SegIterNext_None ==> memcpy(...xNext_signature..., xNext_signatures[xNext_fts5SegIterNext_None_enum], ...)
@transform_xNext_fts5SegIterNext_None@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = fts5SegIterNext_None;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xNext_signature, xNext_signatures[xNext_fts5SegIterNext_None_enum], sizeof(E.xNext_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xNext_signature, xNext_signatures[xNext_fts5SegIterNext_None_enum], sizeof(E.xNext_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xNext_signature, xNext_signatures[xNext_fts5SegIterNext_None_enum], sizeof(E->xNext_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xNext_signature, xNext_signatures[xNext_fts5SegIterNext_None_enum], sizeof(E->xNext_signature));
)

// Rule: .xNext = fts5SegIterNext_Reverse ==> memcpy(...xNext_signature..., xNext_signatures[xNext_fts5SegIterNext_Reverse_enum], ...)
@transform_xNext_fts5SegIterNext_Reverse@
expression E;
identifier FP_NAME = xNext;
identifier FUNC_NAME = fts5SegIterNext_Reverse;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xNext_signature, xNext_signatures[xNext_fts5SegIterNext_Reverse_enum], sizeof(E.xNext_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xNext_signature, xNext_signatures[xNext_fts5SegIterNext_Reverse_enum], sizeof(E.xNext_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xNext_signature, xNext_signatures[xNext_fts5SegIterNext_Reverse_enum], sizeof(E->xNext_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xNext_signature, xNext_signatures[xNext_fts5SegIterNext_Reverse_enum], sizeof(E->xNext_signature));
)

// Rules for xOld (3 functions)
// Rule: .xOld = sessionDiffOld ==> memcpy(...xOld_signature..., xOld_signatures[xOld_sessionDiffOld_enum], ...)
@transform_xOld_sessionDiffOld@
expression E;
identifier FP_NAME = xOld;
identifier FUNC_NAME = sessionDiffOld;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xOld_signature, xOld_signatures[xOld_sessionDiffOld_enum], sizeof(E.xOld_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xOld_signature, xOld_signatures[xOld_sessionDiffOld_enum], sizeof(E.xOld_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xOld_signature, xOld_signatures[xOld_sessionDiffOld_enum], sizeof(E->xOld_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xOld_signature, xOld_signatures[xOld_sessionDiffOld_enum], sizeof(E->xOld_signature));
)

// Rule: .xOld = sessionPreupdateOld ==> memcpy(...xOld_signature..., xOld_signatures[xOld_sessionPreupdateOld_enum], ...)
@transform_xOld_sessionPreupdateOld@
expression E;
identifier FP_NAME = xOld;
identifier FUNC_NAME = sessionPreupdateOld;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xOld_signature, xOld_signatures[xOld_sessionPreupdateOld_enum], sizeof(E.xOld_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xOld_signature, xOld_signatures[xOld_sessionPreupdateOld_enum], sizeof(E.xOld_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xOld_signature, xOld_signatures[xOld_sessionPreupdateOld_enum], sizeof(E->xOld_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xOld_signature, xOld_signatures[xOld_sessionPreupdateOld_enum], sizeof(E->xOld_signature));
)

// Rule: .xOld = sessionStat1Old ==> memcpy(...xOld_signature..., xOld_signatures[xOld_sessionStat1Old_enum], ...)
@transform_xOld_sessionStat1Old@
expression E;
identifier FP_NAME = xOld;
identifier FUNC_NAME = sessionStat1Old;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xOld_signature, xOld_signatures[xOld_sessionStat1Old_enum], sizeof(E.xOld_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xOld_signature, xOld_signatures[xOld_sessionStat1Old_enum], sizeof(E.xOld_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xOld_signature, xOld_signatures[xOld_sessionStat1Old_enum], sizeof(E->xOld_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xOld_signature, xOld_signatures[xOld_sessionStat1Old_enum], sizeof(E->xOld_signature));
)

// Rules for xOpen (3 functions)
// Rule: .xOpen = multiplexOpen ==> memcpy(...xOpen_signature..., xOpen_signatures[xOpen_multiplexOpen_enum], ...)
@transform_xOpen_multiplexOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = multiplexOpen;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xOpen_signature, xOpen_signatures[xOpen_multiplexOpen_enum], sizeof(E.xOpen_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xOpen_signature, xOpen_signatures[xOpen_multiplexOpen_enum], sizeof(E.xOpen_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xOpen_signature, xOpen_signatures[xOpen_multiplexOpen_enum], sizeof(E->xOpen_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xOpen_signature, xOpen_signatures[xOpen_multiplexOpen_enum], sizeof(E->xOpen_signature));
)

// Rule: .xOpen = quotaOpen ==> memcpy(...xOpen_signature..., xOpen_signatures[xOpen_quotaOpen_enum], ...)
@transform_xOpen_quotaOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = quotaOpen;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xOpen_signature, xOpen_signatures[xOpen_quotaOpen_enum], sizeof(E.xOpen_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xOpen_signature, xOpen_signatures[xOpen_quotaOpen_enum], sizeof(E.xOpen_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xOpen_signature, xOpen_signatures[xOpen_quotaOpen_enum], sizeof(E->xOpen_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xOpen_signature, xOpen_signatures[xOpen_quotaOpen_enum], sizeof(E->xOpen_signature));
)

// Rule: .xOpen = vfstraceOpen ==> memcpy(...xOpen_signature..., xOpen_signatures[xOpen_vfstraceOpen_enum], ...)
@transform_xOpen_vfstraceOpen@
expression E;
identifier FP_NAME = xOpen;
identifier FUNC_NAME = vfstraceOpen;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xOpen_signature, xOpen_signatures[xOpen_vfstraceOpen_enum], sizeof(E.xOpen_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xOpen_signature, xOpen_signatures[xOpen_vfstraceOpen_enum], sizeof(E.xOpen_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xOpen_signature, xOpen_signatures[xOpen_vfstraceOpen_enum], sizeof(E->xOpen_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xOpen_signature, xOpen_signatures[xOpen_vfstraceOpen_enum], sizeof(E->xOpen_signature));
)

// Rules for xParseCell (3 functions)
// Rule: .xParseCell = btreeParseCellPtr ==> memcpy(...xParseCell_signature..., xParseCell_signatures[xParseCell_btreeParseCellPtr_enum], ...)
@transform_xParseCell_btreeParseCellPtr@
expression E;
identifier FP_NAME = xParseCell;
identifier FUNC_NAME = btreeParseCellPtr;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtr_enum], sizeof(E.xParseCell_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtr_enum], sizeof(E.xParseCell_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtr_enum], sizeof(E->xParseCell_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtr_enum], sizeof(E->xParseCell_signature));
)

// Rule: .xParseCell = btreeParseCellPtrIndex ==> memcpy(...xParseCell_signature..., xParseCell_signatures[xParseCell_btreeParseCellPtrIndex_enum], ...)
@transform_xParseCell_btreeParseCellPtrIndex@
expression E;
identifier FP_NAME = xParseCell;
identifier FUNC_NAME = btreeParseCellPtrIndex;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtrIndex_enum], sizeof(E.xParseCell_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtrIndex_enum], sizeof(E.xParseCell_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtrIndex_enum], sizeof(E->xParseCell_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtrIndex_enum], sizeof(E->xParseCell_signature));
)

// Rule: .xParseCell = btreeParseCellPtrNoPayload ==> memcpy(...xParseCell_signature..., xParseCell_signatures[xParseCell_btreeParseCellPtrNoPayload_enum], ...)
@transform_xParseCell_btreeParseCellPtrNoPayload@
expression E;
identifier FP_NAME = xParseCell;
identifier FUNC_NAME = btreeParseCellPtrNoPayload;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtrNoPayload_enum], sizeof(E.xParseCell_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtrNoPayload_enum], sizeof(E.xParseCell_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtrNoPayload_enum], sizeof(E->xParseCell_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtrNoPayload_enum], sizeof(E->xParseCell_signature));
)

// Rules for xRandomness (2 functions)
// Rule: .xRandomness = multiplexRandomness ==> memcpy(...xRandomness_signature..., xRandomness_signatures[xRandomness_multiplexRandomness_enum], ...)
@transform_xRandomness_multiplexRandomness@
expression E;
identifier FP_NAME = xRandomness;
identifier FUNC_NAME = multiplexRandomness;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xRandomness_signature, xRandomness_signatures[xRandomness_multiplexRandomness_enum], sizeof(E.xRandomness_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xRandomness_signature, xRandomness_signatures[xRandomness_multiplexRandomness_enum], sizeof(E.xRandomness_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xRandomness_signature, xRandomness_signatures[xRandomness_multiplexRandomness_enum], sizeof(E->xRandomness_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xRandomness_signature, xRandomness_signatures[xRandomness_multiplexRandomness_enum], sizeof(E->xRandomness_signature));
)

// Rule: .xRandomness = vfstraceRandomness ==> memcpy(...xRandomness_signature..., xRandomness_signatures[xRandomness_vfstraceRandomness_enum], ...)
@transform_xRandomness_vfstraceRandomness@
expression E;
identifier FP_NAME = xRandomness;
identifier FUNC_NAME = vfstraceRandomness;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xRandomness_signature, xRandomness_signatures[xRandomness_vfstraceRandomness_enum], sizeof(E.xRandomness_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xRandomness_signature, xRandomness_signatures[xRandomness_vfstraceRandomness_enum], sizeof(E.xRandomness_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xRandomness_signature, xRandomness_signatures[xRandomness_vfstraceRandomness_enum], sizeof(E->xRandomness_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xRandomness_signature, xRandomness_signatures[xRandomness_vfstraceRandomness_enum], sizeof(E->xRandomness_signature));
)

// Rules for xRead (3 functions)
// Rule: .xRead = multiplexRead ==> memcpy(...xRead_signature..., xRead_signatures[xRead_multiplexRead_enum], ...)
@transform_xRead_multiplexRead@
expression E;
identifier FP_NAME = xRead;
identifier FUNC_NAME = multiplexRead;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xRead_signature, xRead_signatures[xRead_multiplexRead_enum], sizeof(E.xRead_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xRead_signature, xRead_signatures[xRead_multiplexRead_enum], sizeof(E.xRead_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xRead_signature, xRead_signatures[xRead_multiplexRead_enum], sizeof(E->xRead_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xRead_signature, xRead_signatures[xRead_multiplexRead_enum], sizeof(E->xRead_signature));
)

// Rule: .xRead = quotaRead ==> memcpy(...xRead_signature..., xRead_signatures[xRead_quotaRead_enum], ...)
@transform_xRead_quotaRead@
expression E;
identifier FP_NAME = xRead;
identifier FUNC_NAME = quotaRead;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xRead_signature, xRead_signatures[xRead_quotaRead_enum], sizeof(E.xRead_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xRead_signature, xRead_signatures[xRead_quotaRead_enum], sizeof(E.xRead_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xRead_signature, xRead_signatures[xRead_quotaRead_enum], sizeof(E->xRead_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xRead_signature, xRead_signatures[xRead_quotaRead_enum], sizeof(E->xRead_signature));
)

// Rule: .xRead = vfstraceRead ==> memcpy(...xRead_signature..., xRead_signatures[xRead_vfstraceRead_enum], ...)
@transform_xRead_vfstraceRead@
expression E;
identifier FP_NAME = xRead;
identifier FUNC_NAME = vfstraceRead;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xRead_signature, xRead_signatures[xRead_vfstraceRead_enum], sizeof(E.xRead_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xRead_signature, xRead_signatures[xRead_vfstraceRead_enum], sizeof(E.xRead_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xRead_signature, xRead_signatures[xRead_vfstraceRead_enum], sizeof(E->xRead_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xRead_signature, xRead_signatures[xRead_vfstraceRead_enum], sizeof(E->xRead_signature));
)

// Rules for xSectorSize (3 functions)
// Rule: .xSectorSize = multiplexSectorSize ==> memcpy(...xSectorSize_signature..., xSectorSize_signatures[xSectorSize_multiplexSectorSize_enum], ...)
@transform_xSectorSize_multiplexSectorSize@
expression E;
identifier FP_NAME = xSectorSize;
identifier FUNC_NAME = multiplexSectorSize;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSectorSize_signature, xSectorSize_signatures[xSectorSize_multiplexSectorSize_enum], sizeof(E.xSectorSize_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSectorSize_signature, xSectorSize_signatures[xSectorSize_multiplexSectorSize_enum], sizeof(E.xSectorSize_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSectorSize_signature, xSectorSize_signatures[xSectorSize_multiplexSectorSize_enum], sizeof(E->xSectorSize_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSectorSize_signature, xSectorSize_signatures[xSectorSize_multiplexSectorSize_enum], sizeof(E->xSectorSize_signature));
)

// Rule: .xSectorSize = quotaSectorSize ==> memcpy(...xSectorSize_signature..., xSectorSize_signatures[xSectorSize_quotaSectorSize_enum], ...)
@transform_xSectorSize_quotaSectorSize@
expression E;
identifier FP_NAME = xSectorSize;
identifier FUNC_NAME = quotaSectorSize;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSectorSize_signature, xSectorSize_signatures[xSectorSize_quotaSectorSize_enum], sizeof(E.xSectorSize_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSectorSize_signature, xSectorSize_signatures[xSectorSize_quotaSectorSize_enum], sizeof(E.xSectorSize_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSectorSize_signature, xSectorSize_signatures[xSectorSize_quotaSectorSize_enum], sizeof(E->xSectorSize_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSectorSize_signature, xSectorSize_signatures[xSectorSize_quotaSectorSize_enum], sizeof(E->xSectorSize_signature));
)

// Rule: .xSectorSize = vfstraceSectorSize ==> memcpy(...xSectorSize_signature..., xSectorSize_signatures[xSectorSize_vfstraceSectorSize_enum], ...)
@transform_xSectorSize_vfstraceSectorSize@
expression E;
identifier FP_NAME = xSectorSize;
identifier FUNC_NAME = vfstraceSectorSize;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSectorSize_signature, xSectorSize_signatures[xSectorSize_vfstraceSectorSize_enum], sizeof(E.xSectorSize_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSectorSize_signature, xSectorSize_signatures[xSectorSize_vfstraceSectorSize_enum], sizeof(E.xSectorSize_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSectorSize_signature, xSectorSize_signatures[xSectorSize_vfstraceSectorSize_enum], sizeof(E->xSectorSize_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSectorSize_signature, xSectorSize_signatures[xSectorSize_vfstraceSectorSize_enum], sizeof(E->xSectorSize_signature));
)

// Rules for xSelectCallback (16 functions)
// Rule: .xSelectCallback = convertCompoundSelectToSubquery ==> memcpy(...xSelectCallback_signature..., xSelectCallback_signatures[xSelectCallback_convertCompoundSelectToSubquery_enum], ...)
@transform_xSelectCallback_convertCompoundSelectToSubquery@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = convertCompoundSelectToSubquery;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_convertCompoundSelectToSubquery_enum], sizeof(E.xSelectCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_convertCompoundSelectToSubquery_enum], sizeof(E.xSelectCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_convertCompoundSelectToSubquery_enum], sizeof(E->xSelectCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_convertCompoundSelectToSubquery_enum], sizeof(E->xSelectCallback_signature));
)

// Rule: .xSelectCallback = exprSelectWalkTableConstant ==> memcpy(...xSelectCallback_signature..., xSelectCallback_signatures[xSelectCallback_exprSelectWalkTableConstant_enum], ...)
@transform_xSelectCallback_exprSelectWalkTableConstant@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = exprSelectWalkTableConstant;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_exprSelectWalkTableConstant_enum], sizeof(E.xSelectCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_exprSelectWalkTableConstant_enum], sizeof(E.xSelectCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_exprSelectWalkTableConstant_enum], sizeof(E->xSelectCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_exprSelectWalkTableConstant_enum], sizeof(E->xSelectCallback_signature));
)

// Rule: .xSelectCallback = fixSelectCb ==> memcpy(...xSelectCallback_signature..., xSelectCallback_signatures[xSelectCallback_fixSelectCb_enum], ...)
@transform_xSelectCallback_fixSelectCb@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = fixSelectCb;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_fixSelectCb_enum], sizeof(E.xSelectCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_fixSelectCb_enum], sizeof(E.xSelectCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_fixSelectCb_enum], sizeof(E->xSelectCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_fixSelectCb_enum], sizeof(E->xSelectCallback_signature));
)

// Rule: .xSelectCallback = gatherSelectWindowsSelectCallback ==> memcpy(...xSelectCallback_signature..., xSelectCallback_signatures[xSelectCallback_gatherSelectWindowsSelectCallback_enum], ...)
@transform_xSelectCallback_gatherSelectWindowsSelectCallback@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = gatherSelectWindowsSelectCallback;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_gatherSelectWindowsSelectCallback_enum], sizeof(E.xSelectCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_gatherSelectWindowsSelectCallback_enum], sizeof(E.xSelectCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_gatherSelectWindowsSelectCallback_enum], sizeof(E->xSelectCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_gatherSelectWindowsSelectCallback_enum], sizeof(E->xSelectCallback_signature));
)

// Rule: .xSelectCallback = renameColumnSelectCb ==> memcpy(...xSelectCallback_signature..., xSelectCallback_signatures[xSelectCallback_renameColumnSelectCb_enum], ...)
@transform_xSelectCallback_renameColumnSelectCb@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = renameColumnSelectCb;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameColumnSelectCb_enum], sizeof(E.xSelectCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameColumnSelectCb_enum], sizeof(E.xSelectCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameColumnSelectCb_enum], sizeof(E->xSelectCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameColumnSelectCb_enum], sizeof(E->xSelectCallback_signature));
)

// Rule: .xSelectCallback = renameTableSelectCb ==> memcpy(...xSelectCallback_signature..., xSelectCallback_signatures[xSelectCallback_renameTableSelectCb_enum], ...)
@transform_xSelectCallback_renameTableSelectCb@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = renameTableSelectCb;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameTableSelectCb_enum], sizeof(E.xSelectCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameTableSelectCb_enum], sizeof(E.xSelectCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameTableSelectCb_enum], sizeof(E->xSelectCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameTableSelectCb_enum], sizeof(E->xSelectCallback_signature));
)

// Rule: .xSelectCallback = renameUnmapSelectCb ==> memcpy(...xSelectCallback_signature..., xSelectCallback_signatures[xSelectCallback_renameUnmapSelectCb_enum], ...)
@transform_xSelectCallback_renameUnmapSelectCb@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = renameUnmapSelectCb;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameUnmapSelectCb_enum], sizeof(E.xSelectCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameUnmapSelectCb_enum], sizeof(E.xSelectCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameUnmapSelectCb_enum], sizeof(E->xSelectCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameUnmapSelectCb_enum], sizeof(E->xSelectCallback_signature));
)

// Rule: .xSelectCallback = resolveSelectStep ==> memcpy(...xSelectCallback_signature..., xSelectCallback_signatures[xSelectCallback_resolveSelectStep_enum], ...)
@transform_xSelectCallback_resolveSelectStep@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = resolveSelectStep;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_resolveSelectStep_enum], sizeof(E.xSelectCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_resolveSelectStep_enum], sizeof(E.xSelectCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_resolveSelectStep_enum], sizeof(E->xSelectCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_resolveSelectStep_enum], sizeof(E->xSelectCallback_signature));
)

// Rule: .xSelectCallback = selectCheckOnClausesSelect ==> memcpy(...xSelectCallback_signature..., xSelectCallback_signatures[xSelectCallback_selectCheckOnClausesSelect_enum], ...)
@transform_xSelectCallback_selectCheckOnClausesSelect@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = selectCheckOnClausesSelect;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectCheckOnClausesSelect_enum], sizeof(E.xSelectCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectCheckOnClausesSelect_enum], sizeof(E.xSelectCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectCheckOnClausesSelect_enum], sizeof(E->xSelectCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectCheckOnClausesSelect_enum], sizeof(E->xSelectCallback_signature));
)

// Rule: .xSelectCallback = selectExpander ==> memcpy(...xSelectCallback_signature..., xSelectCallback_signatures[xSelectCallback_selectExpander_enum], ...)
@transform_xSelectCallback_selectExpander@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = selectExpander;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectExpander_enum], sizeof(E.xSelectCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectExpander_enum], sizeof(E.xSelectCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectExpander_enum], sizeof(E->xSelectCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectExpander_enum], sizeof(E->xSelectCallback_signature));
)

// Rule: .xSelectCallback = selectRefEnter ==> memcpy(...xSelectCallback_signature..., xSelectCallback_signatures[xSelectCallback_selectRefEnter_enum], ...)
@transform_xSelectCallback_selectRefEnter@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = selectRefEnter;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectRefEnter_enum], sizeof(E.xSelectCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectRefEnter_enum], sizeof(E.xSelectCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectRefEnter_enum], sizeof(E->xSelectCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectRefEnter_enum], sizeof(E->xSelectCallback_signature));
)

// Rule: .xSelectCallback = selectWindowRewriteSelectCb ==> memcpy(...xSelectCallback_signature..., xSelectCallback_signatures[xSelectCallback_selectWindowRewriteSelectCb_enum], ...)
@transform_xSelectCallback_selectWindowRewriteSelectCb@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = selectWindowRewriteSelectCb;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectWindowRewriteSelectCb_enum], sizeof(E.xSelectCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectWindowRewriteSelectCb_enum], sizeof(E.xSelectCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectWindowRewriteSelectCb_enum], sizeof(E->xSelectCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectWindowRewriteSelectCb_enum], sizeof(E->xSelectCallback_signature));
)

// Rule: .xSelectCallback = sqlite3ReturningSubqueryCorrelated ==> memcpy(...xSelectCallback_signature..., xSelectCallback_signatures[xSelectCallback_sqlite3ReturningSubqueryCorrelated_enum], ...)
@transform_xSelectCallback_sqlite3ReturningSubqueryCorrelated@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = sqlite3ReturningSubqueryCorrelated;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3ReturningSubqueryCorrelated_enum], sizeof(E.xSelectCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3ReturningSubqueryCorrelated_enum], sizeof(E.xSelectCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3ReturningSubqueryCorrelated_enum], sizeof(E->xSelectCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3ReturningSubqueryCorrelated_enum], sizeof(E->xSelectCallback_signature));
)

// Rule: .xSelectCallback = sqlite3SelectWalkFail ==> memcpy(...xSelectCallback_signature..., xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkFail_enum], ...)
@transform_xSelectCallback_sqlite3SelectWalkFail@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = sqlite3SelectWalkFail;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkFail_enum], sizeof(E.xSelectCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkFail_enum], sizeof(E.xSelectCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkFail_enum], sizeof(E->xSelectCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkFail_enum], sizeof(E->xSelectCallback_signature));
)

// Rule: .xSelectCallback = sqlite3SelectWalkNoop ==> memcpy(...xSelectCallback_signature..., xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkNoop_enum], ...)
@transform_xSelectCallback_sqlite3SelectWalkNoop@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = sqlite3SelectWalkNoop;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkNoop_enum], sizeof(E.xSelectCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkNoop_enum], sizeof(E.xSelectCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkNoop_enum], sizeof(E->xSelectCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkNoop_enum], sizeof(E->xSelectCallback_signature));
)

// Rule: .xSelectCallback = sqlite3WalkerDepthIncrease ==> memcpy(...xSelectCallback_signature..., xSelectCallback_signatures[xSelectCallback_sqlite3WalkerDepthIncrease_enum], ...)
@transform_xSelectCallback_sqlite3WalkerDepthIncrease@
expression E;
identifier FP_NAME = xSelectCallback;
identifier FUNC_NAME = sqlite3WalkerDepthIncrease;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3WalkerDepthIncrease_enum], sizeof(E.xSelectCallback_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3WalkerDepthIncrease_enum], sizeof(E.xSelectCallback_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3WalkerDepthIncrease_enum], sizeof(E->xSelectCallback_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3WalkerDepthIncrease_enum], sizeof(E->xSelectCallback_signature));
)

// Rules for xSelectCallback2 (6 functions)
// Rule: .xSelectCallback2 = selectAddSubqueryTypeInfo ==> memcpy(...xSelectCallback2_signature..., xSelectCallback2_signatures[xSelectCallback2_selectAddSubqueryTypeInfo_enum], ...)
@transform_xSelectCallback2_selectAddSubqueryTypeInfo@
expression E;
identifier FP_NAME = xSelectCallback2;
identifier FUNC_NAME = selectAddSubqueryTypeInfo;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_selectAddSubqueryTypeInfo_enum], sizeof(E.xSelectCallback2_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_selectAddSubqueryTypeInfo_enum], sizeof(E.xSelectCallback2_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_selectAddSubqueryTypeInfo_enum], sizeof(E->xSelectCallback2_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_selectAddSubqueryTypeInfo_enum], sizeof(E->xSelectCallback2_signature));
)

// Rule: .xSelectCallback2 = selectRefLeave ==> memcpy(...xSelectCallback2_signature..., xSelectCallback2_signatures[xSelectCallback2_selectRefLeave_enum], ...)
@transform_xSelectCallback2_selectRefLeave@
expression E;
identifier FP_NAME = xSelectCallback2;
identifier FUNC_NAME = selectRefLeave;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_selectRefLeave_enum], sizeof(E.xSelectCallback2_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_selectRefLeave_enum], sizeof(E.xSelectCallback2_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_selectRefLeave_enum], sizeof(E->xSelectCallback2_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_selectRefLeave_enum], sizeof(E->xSelectCallback2_signature));
)

// Rule: .xSelectCallback2 = sqlite3SelectPopWith ==> memcpy(...xSelectCallback2_signature..., xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectPopWith_enum], ...)
@transform_xSelectCallback2_sqlite3SelectPopWith@
expression E;
identifier FP_NAME = xSelectCallback2;
identifier FUNC_NAME = sqlite3SelectPopWith;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectPopWith_enum], sizeof(E.xSelectCallback2_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectPopWith_enum], sizeof(E.xSelectCallback2_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectPopWith_enum], sizeof(E->xSelectCallback2_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectPopWith_enum], sizeof(E->xSelectCallback2_signature));
)

// Rule: .xSelectCallback2 = sqlite3SelectWalkAssert2 ==> memcpy(...xSelectCallback2_signature..., xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectWalkAssert2_enum], ...)
@transform_xSelectCallback2_sqlite3SelectWalkAssert2@
expression E;
identifier FP_NAME = xSelectCallback2;
identifier FUNC_NAME = sqlite3SelectWalkAssert2;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectWalkAssert2_enum], sizeof(E.xSelectCallback2_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectWalkAssert2_enum], sizeof(E.xSelectCallback2_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectWalkAssert2_enum], sizeof(E->xSelectCallback2_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectWalkAssert2_enum], sizeof(E->xSelectCallback2_signature));
)

// Rule: .xSelectCallback2 = sqlite3WalkWinDefnDummyCallback ==> memcpy(...xSelectCallback2_signature..., xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkWinDefnDummyCallback_enum], ...)
@transform_xSelectCallback2_sqlite3WalkWinDefnDummyCallback@
expression E;
identifier FP_NAME = xSelectCallback2;
identifier FUNC_NAME = sqlite3WalkWinDefnDummyCallback;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkWinDefnDummyCallback_enum], sizeof(E.xSelectCallback2_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkWinDefnDummyCallback_enum], sizeof(E.xSelectCallback2_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkWinDefnDummyCallback_enum], sizeof(E->xSelectCallback2_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkWinDefnDummyCallback_enum], sizeof(E->xSelectCallback2_signature));
)

// Rule: .xSelectCallback2 = sqlite3WalkerDepthDecrease ==> memcpy(...xSelectCallback2_signature..., xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkerDepthDecrease_enum], ...)
@transform_xSelectCallback2_sqlite3WalkerDepthDecrease@
expression E;
identifier FP_NAME = xSelectCallback2;
identifier FUNC_NAME = sqlite3WalkerDepthDecrease;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkerDepthDecrease_enum], sizeof(E.xSelectCallback2_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkerDepthDecrease_enum], sizeof(E.xSelectCallback2_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkerDepthDecrease_enum], sizeof(E->xSelectCallback2_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkerDepthDecrease_enum], sizeof(E->xSelectCallback2_signature));
)

// Rules for xSetOutputs (7 functions)
// Rule: .xSetOutputs = fts5IterSetOutputs_Col ==> memcpy(...xSetOutputs_signature..., xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Col_enum], ...)
@transform_xSetOutputs_fts5IterSetOutputs_Col@
expression E;
identifier FP_NAME = xSetOutputs;
identifier FUNC_NAME = fts5IterSetOutputs_Col;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Col_enum], sizeof(E.xSetOutputs_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Col_enum], sizeof(E.xSetOutputs_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Col_enum], sizeof(E->xSetOutputs_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Col_enum], sizeof(E->xSetOutputs_signature));
)

// Rule: .xSetOutputs = fts5IterSetOutputs_Col100 ==> memcpy(...xSetOutputs_signature..., xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Col100_enum], ...)
@transform_xSetOutputs_fts5IterSetOutputs_Col100@
expression E;
identifier FP_NAME = xSetOutputs;
identifier FUNC_NAME = fts5IterSetOutputs_Col100;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Col100_enum], sizeof(E.xSetOutputs_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Col100_enum], sizeof(E.xSetOutputs_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Col100_enum], sizeof(E->xSetOutputs_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Col100_enum], sizeof(E->xSetOutputs_signature));
)

// Rule: .xSetOutputs = fts5IterSetOutputs_Full ==> memcpy(...xSetOutputs_signature..., xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Full_enum], ...)
@transform_xSetOutputs_fts5IterSetOutputs_Full@
expression E;
identifier FP_NAME = xSetOutputs;
identifier FUNC_NAME = fts5IterSetOutputs_Full;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Full_enum], sizeof(E.xSetOutputs_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Full_enum], sizeof(E.xSetOutputs_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Full_enum], sizeof(E->xSetOutputs_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Full_enum], sizeof(E->xSetOutputs_signature));
)

// Rule: .xSetOutputs = fts5IterSetOutputs_Nocolset ==> memcpy(...xSetOutputs_signature..., xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Nocolset_enum], ...)
@transform_xSetOutputs_fts5IterSetOutputs_Nocolset@
expression E;
identifier FP_NAME = xSetOutputs;
identifier FUNC_NAME = fts5IterSetOutputs_Nocolset;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Nocolset_enum], sizeof(E.xSetOutputs_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Nocolset_enum], sizeof(E.xSetOutputs_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Nocolset_enum], sizeof(E->xSetOutputs_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Nocolset_enum], sizeof(E->xSetOutputs_signature));
)

// Rule: .xSetOutputs = fts5IterSetOutputs_None ==> memcpy(...xSetOutputs_signature..., xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_None_enum], ...)
@transform_xSetOutputs_fts5IterSetOutputs_None@
expression E;
identifier FP_NAME = xSetOutputs;
identifier FUNC_NAME = fts5IterSetOutputs_None;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_None_enum], sizeof(E.xSetOutputs_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_None_enum], sizeof(E.xSetOutputs_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_None_enum], sizeof(E->xSetOutputs_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_None_enum], sizeof(E->xSetOutputs_signature));
)

// Rule: .xSetOutputs = fts5IterSetOutputs_Noop ==> memcpy(...xSetOutputs_signature..., xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Noop_enum], ...)
@transform_xSetOutputs_fts5IterSetOutputs_Noop@
expression E;
identifier FP_NAME = xSetOutputs;
identifier FUNC_NAME = fts5IterSetOutputs_Noop;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Noop_enum], sizeof(E.xSetOutputs_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Noop_enum], sizeof(E.xSetOutputs_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Noop_enum], sizeof(E->xSetOutputs_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Noop_enum], sizeof(E->xSetOutputs_signature));
)

// Rule: .xSetOutputs = fts5IterSetOutputs_ZeroColset ==> memcpy(...xSetOutputs_signature..., xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_ZeroColset_enum], ...)
@transform_xSetOutputs_fts5IterSetOutputs_ZeroColset@
expression E;
identifier FP_NAME = xSetOutputs;
identifier FUNC_NAME = fts5IterSetOutputs_ZeroColset;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_ZeroColset_enum], sizeof(E.xSetOutputs_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_ZeroColset_enum], sizeof(E.xSetOutputs_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_ZeroColset_enum], sizeof(E->xSetOutputs_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_ZeroColset_enum], sizeof(E->xSetOutputs_signature));
)

// Rules for xShmBarrier (2 functions)
// Rule: .xShmBarrier = multiplexShmBarrier ==> memcpy(...xShmBarrier_signature..., xShmBarrier_signatures[xShmBarrier_multiplexShmBarrier_enum], ...)
@transform_xShmBarrier_multiplexShmBarrier@
expression E;
identifier FP_NAME = xShmBarrier;
identifier FUNC_NAME = multiplexShmBarrier;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_multiplexShmBarrier_enum], sizeof(E.xShmBarrier_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_multiplexShmBarrier_enum], sizeof(E.xShmBarrier_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_multiplexShmBarrier_enum], sizeof(E->xShmBarrier_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_multiplexShmBarrier_enum], sizeof(E->xShmBarrier_signature));
)

// Rule: .xShmBarrier = quotaShmBarrier ==> memcpy(...xShmBarrier_signature..., xShmBarrier_signatures[xShmBarrier_quotaShmBarrier_enum], ...)
@transform_xShmBarrier_quotaShmBarrier@
expression E;
identifier FP_NAME = xShmBarrier;
identifier FUNC_NAME = quotaShmBarrier;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_quotaShmBarrier_enum], sizeof(E.xShmBarrier_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_quotaShmBarrier_enum], sizeof(E.xShmBarrier_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_quotaShmBarrier_enum], sizeof(E->xShmBarrier_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_quotaShmBarrier_enum], sizeof(E->xShmBarrier_signature));
)

// Rules for xShmLock (2 functions)
// Rule: .xShmLock = multiplexShmLock ==> memcpy(...xShmLock_signature..., xShmLock_signatures[xShmLock_multiplexShmLock_enum], ...)
@transform_xShmLock_multiplexShmLock@
expression E;
identifier FP_NAME = xShmLock;
identifier FUNC_NAME = multiplexShmLock;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xShmLock_signature, xShmLock_signatures[xShmLock_multiplexShmLock_enum], sizeof(E.xShmLock_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xShmLock_signature, xShmLock_signatures[xShmLock_multiplexShmLock_enum], sizeof(E.xShmLock_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xShmLock_signature, xShmLock_signatures[xShmLock_multiplexShmLock_enum], sizeof(E->xShmLock_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xShmLock_signature, xShmLock_signatures[xShmLock_multiplexShmLock_enum], sizeof(E->xShmLock_signature));
)

// Rule: .xShmLock = quotaShmLock ==> memcpy(...xShmLock_signature..., xShmLock_signatures[xShmLock_quotaShmLock_enum], ...)
@transform_xShmLock_quotaShmLock@
expression E;
identifier FP_NAME = xShmLock;
identifier FUNC_NAME = quotaShmLock;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xShmLock_signature, xShmLock_signatures[xShmLock_quotaShmLock_enum], sizeof(E.xShmLock_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xShmLock_signature, xShmLock_signatures[xShmLock_quotaShmLock_enum], sizeof(E.xShmLock_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xShmLock_signature, xShmLock_signatures[xShmLock_quotaShmLock_enum], sizeof(E->xShmLock_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xShmLock_signature, xShmLock_signatures[xShmLock_quotaShmLock_enum], sizeof(E->xShmLock_signature));
)

// Rules for xShmMap (2 functions)
// Rule: .xShmMap = multiplexShmMap ==> memcpy(...xShmMap_signature..., xShmMap_signatures[xShmMap_multiplexShmMap_enum], ...)
@transform_xShmMap_multiplexShmMap@
expression E;
identifier FP_NAME = xShmMap;
identifier FUNC_NAME = multiplexShmMap;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xShmMap_signature, xShmMap_signatures[xShmMap_multiplexShmMap_enum], sizeof(E.xShmMap_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xShmMap_signature, xShmMap_signatures[xShmMap_multiplexShmMap_enum], sizeof(E.xShmMap_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xShmMap_signature, xShmMap_signatures[xShmMap_multiplexShmMap_enum], sizeof(E->xShmMap_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xShmMap_signature, xShmMap_signatures[xShmMap_multiplexShmMap_enum], sizeof(E->xShmMap_signature));
)

// Rule: .xShmMap = quotaShmMap ==> memcpy(...xShmMap_signature..., xShmMap_signatures[xShmMap_quotaShmMap_enum], ...)
@transform_xShmMap_quotaShmMap@
expression E;
identifier FP_NAME = xShmMap;
identifier FUNC_NAME = quotaShmMap;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xShmMap_signature, xShmMap_signatures[xShmMap_quotaShmMap_enum], sizeof(E.xShmMap_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xShmMap_signature, xShmMap_signatures[xShmMap_quotaShmMap_enum], sizeof(E.xShmMap_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xShmMap_signature, xShmMap_signatures[xShmMap_quotaShmMap_enum], sizeof(E->xShmMap_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xShmMap_signature, xShmMap_signatures[xShmMap_quotaShmMap_enum], sizeof(E->xShmMap_signature));
)

// Rules for xShmUnmap (2 functions)
// Rule: .xShmUnmap = multiplexShmUnmap ==> memcpy(...xShmUnmap_signature..., xShmUnmap_signatures[xShmUnmap_multiplexShmUnmap_enum], ...)
@transform_xShmUnmap_multiplexShmUnmap@
expression E;
identifier FP_NAME = xShmUnmap;
identifier FUNC_NAME = multiplexShmUnmap;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_multiplexShmUnmap_enum], sizeof(E.xShmUnmap_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_multiplexShmUnmap_enum], sizeof(E.xShmUnmap_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_multiplexShmUnmap_enum], sizeof(E->xShmUnmap_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_multiplexShmUnmap_enum], sizeof(E->xShmUnmap_signature));
)

// Rule: .xShmUnmap = quotaShmUnmap ==> memcpy(...xShmUnmap_signature..., xShmUnmap_signatures[xShmUnmap_quotaShmUnmap_enum], ...)
@transform_xShmUnmap_quotaShmUnmap@
expression E;
identifier FP_NAME = xShmUnmap;
identifier FUNC_NAME = quotaShmUnmap;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_quotaShmUnmap_enum], sizeof(E.xShmUnmap_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_quotaShmUnmap_enum], sizeof(E.xShmUnmap_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_quotaShmUnmap_enum], sizeof(E->xShmUnmap_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_quotaShmUnmap_enum], sizeof(E->xShmUnmap_signature));
)

// Rules for xSleep (2 functions)
// Rule: .xSleep = multiplexSleep ==> memcpy(...xSleep_signature..., xSleep_signatures[xSleep_multiplexSleep_enum], ...)
@transform_xSleep_multiplexSleep@
expression E;
identifier FP_NAME = xSleep;
identifier FUNC_NAME = multiplexSleep;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSleep_signature, xSleep_signatures[xSleep_multiplexSleep_enum], sizeof(E.xSleep_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSleep_signature, xSleep_signatures[xSleep_multiplexSleep_enum], sizeof(E.xSleep_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSleep_signature, xSleep_signatures[xSleep_multiplexSleep_enum], sizeof(E->xSleep_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSleep_signature, xSleep_signatures[xSleep_multiplexSleep_enum], sizeof(E->xSleep_signature));
)

// Rule: .xSleep = vfstraceSleep ==> memcpy(...xSleep_signature..., xSleep_signatures[xSleep_vfstraceSleep_enum], ...)
@transform_xSleep_vfstraceSleep@
expression E;
identifier FP_NAME = xSleep;
identifier FUNC_NAME = vfstraceSleep;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSleep_signature, xSleep_signatures[xSleep_vfstraceSleep_enum], sizeof(E.xSleep_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSleep_signature, xSleep_signatures[xSleep_vfstraceSleep_enum], sizeof(E.xSleep_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSleep_signature, xSleep_signatures[xSleep_vfstraceSleep_enum], sizeof(E->xSleep_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSleep_signature, xSleep_signatures[xSleep_vfstraceSleep_enum], sizeof(E->xSleep_signature));
)

// Rules for xSync (3 functions)
// Rule: .xSync = multiplexSync ==> memcpy(...xSync_signature..., xSync_signatures[xSync_multiplexSync_enum], ...)
@transform_xSync_multiplexSync@
expression E;
identifier FP_NAME = xSync;
identifier FUNC_NAME = multiplexSync;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSync_signature, xSync_signatures[xSync_multiplexSync_enum], sizeof(E.xSync_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSync_signature, xSync_signatures[xSync_multiplexSync_enum], sizeof(E.xSync_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSync_signature, xSync_signatures[xSync_multiplexSync_enum], sizeof(E->xSync_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSync_signature, xSync_signatures[xSync_multiplexSync_enum], sizeof(E->xSync_signature));
)

// Rule: .xSync = quotaSync ==> memcpy(...xSync_signature..., xSync_signatures[xSync_quotaSync_enum], ...)
@transform_xSync_quotaSync@
expression E;
identifier FP_NAME = xSync;
identifier FUNC_NAME = quotaSync;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSync_signature, xSync_signatures[xSync_quotaSync_enum], sizeof(E.xSync_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSync_signature, xSync_signatures[xSync_quotaSync_enum], sizeof(E.xSync_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSync_signature, xSync_signatures[xSync_quotaSync_enum], sizeof(E->xSync_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSync_signature, xSync_signatures[xSync_quotaSync_enum], sizeof(E->xSync_signature));
)

// Rule: .xSync = vfstraceSync ==> memcpy(...xSync_signature..., xSync_signatures[xSync_vfstraceSync_enum], ...)
@transform_xSync_vfstraceSync@
expression E;
identifier FP_NAME = xSync;
identifier FUNC_NAME = vfstraceSync;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xSync_signature, xSync_signatures[xSync_vfstraceSync_enum], sizeof(E.xSync_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xSync_signature, xSync_signatures[xSync_vfstraceSync_enum], sizeof(E.xSync_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xSync_signature, xSync_signatures[xSync_vfstraceSync_enum], sizeof(E->xSync_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xSync_signature, xSync_signatures[xSync_vfstraceSync_enum], sizeof(E->xSync_signature));
)

// Rules for xTruncate (3 functions)
// Rule: .xTruncate = multiplexTruncate ==> memcpy(...xTruncate_signature..., xTruncate_signatures[xTruncate_multiplexTruncate_enum], ...)
@transform_xTruncate_multiplexTruncate@
expression E;
identifier FP_NAME = xTruncate;
identifier FUNC_NAME = multiplexTruncate;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xTruncate_signature, xTruncate_signatures[xTruncate_multiplexTruncate_enum], sizeof(E.xTruncate_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xTruncate_signature, xTruncate_signatures[xTruncate_multiplexTruncate_enum], sizeof(E.xTruncate_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xTruncate_signature, xTruncate_signatures[xTruncate_multiplexTruncate_enum], sizeof(E->xTruncate_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xTruncate_signature, xTruncate_signatures[xTruncate_multiplexTruncate_enum], sizeof(E->xTruncate_signature));
)

// Rule: .xTruncate = quotaTruncate ==> memcpy(...xTruncate_signature..., xTruncate_signatures[xTruncate_quotaTruncate_enum], ...)
@transform_xTruncate_quotaTruncate@
expression E;
identifier FP_NAME = xTruncate;
identifier FUNC_NAME = quotaTruncate;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xTruncate_signature, xTruncate_signatures[xTruncate_quotaTruncate_enum], sizeof(E.xTruncate_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xTruncate_signature, xTruncate_signatures[xTruncate_quotaTruncate_enum], sizeof(E.xTruncate_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xTruncate_signature, xTruncate_signatures[xTruncate_quotaTruncate_enum], sizeof(E->xTruncate_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xTruncate_signature, xTruncate_signatures[xTruncate_quotaTruncate_enum], sizeof(E->xTruncate_signature));
)

// Rule: .xTruncate = vfstraceTruncate ==> memcpy(...xTruncate_signature..., xTruncate_signatures[xTruncate_vfstraceTruncate_enum], ...)
@transform_xTruncate_vfstraceTruncate@
expression E;
identifier FP_NAME = xTruncate;
identifier FUNC_NAME = vfstraceTruncate;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xTruncate_signature, xTruncate_signatures[xTruncate_vfstraceTruncate_enum], sizeof(E.xTruncate_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xTruncate_signature, xTruncate_signatures[xTruncate_vfstraceTruncate_enum], sizeof(E.xTruncate_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xTruncate_signature, xTruncate_signatures[xTruncate_vfstraceTruncate_enum], sizeof(E->xTruncate_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xTruncate_signature, xTruncate_signatures[xTruncate_vfstraceTruncate_enum], sizeof(E->xTruncate_signature));
)

// Rules for xUnlock (3 functions)
// Rule: .xUnlock = multiplexUnlock ==> memcpy(...xUnlock_signature..., xUnlock_signatures[xUnlock_multiplexUnlock_enum], ...)
@transform_xUnlock_multiplexUnlock@
expression E;
identifier FP_NAME = xUnlock;
identifier FUNC_NAME = multiplexUnlock;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xUnlock_signature, xUnlock_signatures[xUnlock_multiplexUnlock_enum], sizeof(E.xUnlock_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xUnlock_signature, xUnlock_signatures[xUnlock_multiplexUnlock_enum], sizeof(E.xUnlock_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xUnlock_signature, xUnlock_signatures[xUnlock_multiplexUnlock_enum], sizeof(E->xUnlock_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xUnlock_signature, xUnlock_signatures[xUnlock_multiplexUnlock_enum], sizeof(E->xUnlock_signature));
)

// Rule: .xUnlock = quotaUnlock ==> memcpy(...xUnlock_signature..., xUnlock_signatures[xUnlock_quotaUnlock_enum], ...)
@transform_xUnlock_quotaUnlock@
expression E;
identifier FP_NAME = xUnlock;
identifier FUNC_NAME = quotaUnlock;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xUnlock_signature, xUnlock_signatures[xUnlock_quotaUnlock_enum], sizeof(E.xUnlock_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xUnlock_signature, xUnlock_signatures[xUnlock_quotaUnlock_enum], sizeof(E.xUnlock_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xUnlock_signature, xUnlock_signatures[xUnlock_quotaUnlock_enum], sizeof(E->xUnlock_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xUnlock_signature, xUnlock_signatures[xUnlock_quotaUnlock_enum], sizeof(E->xUnlock_signature));
)

// Rule: .xUnlock = vfstraceUnlock ==> memcpy(...xUnlock_signature..., xUnlock_signatures[xUnlock_vfstraceUnlock_enum], ...)
@transform_xUnlock_vfstraceUnlock@
expression E;
identifier FP_NAME = xUnlock;
identifier FUNC_NAME = vfstraceUnlock;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xUnlock_signature, xUnlock_signatures[xUnlock_vfstraceUnlock_enum], sizeof(E.xUnlock_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xUnlock_signature, xUnlock_signatures[xUnlock_vfstraceUnlock_enum], sizeof(E.xUnlock_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xUnlock_signature, xUnlock_signatures[xUnlock_vfstraceUnlock_enum], sizeof(E->xUnlock_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xUnlock_signature, xUnlock_signatures[xUnlock_vfstraceUnlock_enum], sizeof(E->xUnlock_signature));
)

// Rules for xWrite (3 functions)
// Rule: .xWrite = multiplexWrite ==> memcpy(...xWrite_signature..., xWrite_signatures[xWrite_multiplexWrite_enum], ...)
@transform_xWrite_multiplexWrite@
expression E;
identifier FP_NAME = xWrite;
identifier FUNC_NAME = multiplexWrite;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xWrite_signature, xWrite_signatures[xWrite_multiplexWrite_enum], sizeof(E.xWrite_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xWrite_signature, xWrite_signatures[xWrite_multiplexWrite_enum], sizeof(E.xWrite_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xWrite_signature, xWrite_signatures[xWrite_multiplexWrite_enum], sizeof(E->xWrite_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xWrite_signature, xWrite_signatures[xWrite_multiplexWrite_enum], sizeof(E->xWrite_signature));
)

// Rule: .xWrite = quotaWrite ==> memcpy(...xWrite_signature..., xWrite_signatures[xWrite_quotaWrite_enum], ...)
@transform_xWrite_quotaWrite@
expression E;
identifier FP_NAME = xWrite;
identifier FUNC_NAME = quotaWrite;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xWrite_signature, xWrite_signatures[xWrite_quotaWrite_enum], sizeof(E.xWrite_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xWrite_signature, xWrite_signatures[xWrite_quotaWrite_enum], sizeof(E.xWrite_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xWrite_signature, xWrite_signatures[xWrite_quotaWrite_enum], sizeof(E->xWrite_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xWrite_signature, xWrite_signatures[xWrite_quotaWrite_enum], sizeof(E->xWrite_signature));
)

// Rule: .xWrite = vfstraceWrite ==> memcpy(...xWrite_signature..., xWrite_signatures[xWrite_vfstraceWrite_enum], ...)
@transform_xWrite_vfstraceWrite@
expression E;
identifier FP_NAME = xWrite;
identifier FUNC_NAME = vfstraceWrite;
@@
(
- E.FP_NAME = FUNC_NAME;
+ memcpy(E.xWrite_signature, xWrite_signatures[xWrite_vfstraceWrite_enum], sizeof(E.xWrite_signature));
|
- E.FP_NAME = &FUNC_NAME;
+ memcpy(E.xWrite_signature, xWrite_signatures[xWrite_vfstraceWrite_enum], sizeof(E.xWrite_signature));
|
- E->FP_NAME = FUNC_NAME;
+ memcpy(E->xWrite_signature, xWrite_signatures[xWrite_vfstraceWrite_enum], sizeof(E->xWrite_signature));
|
- E->FP_NAME = &FUNC_NAME;
+ memcpy(E->xWrite_signature, xWrite_signatures[xWrite_vfstraceWrite_enum], sizeof(E->xWrite_signature));
)

// Total transformation rules generated: 169

// ===== USAGE INSTRUCTIONS =====
/*
After running this script:

1. Check memcpy_transformations/ directory for transformation logs

Example transformation:
   Before: obj.callback = my_function;
   After:  memcpy(obj.callback_signature, callback_signatures[callback_my_function_enum], sizeof(obj.callback_signature));

Note: This assumes that:
- FP_NAME_signatures arrays are already defined
- FP_NAME_FUNC_NAME_enum values are already defined
- Structs have FP_NAME_signature fields
- <string.h> is included where needed
*/

