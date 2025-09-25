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

// Total transformation rules generated: 102

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

