// Auto-generated Coccinelle script to remove `static` keyword
// from functions assigned to function pointers
//
// Generated from:
// - target_fpNames.txt: Target function pointer names
// - fpName/{fp_name}.txt: Actual function names assigned to each function pointer
//
// This script removes static keywords from all functions that are assigned
// to the target function pointers, making them available for cross-compilation
// unit function pointer assignments.
//
// Features:
// - 15+ different static function patterns per function
// - Handles inline, const, volatile, and attribute modifiers
// - Supports complex return types including pointers
// - Covers legacy C styles and modern C standards
// - Extracts function signatures for verification
// - Position tracking for debugging
//
// Usage: spatch --sp-file remove_fp_static.cocci --dir <source_directory> --in-place
// Function pointer to functions mapping:
// xAccess: multiplexAccess, vfstraceAccess
// xAppend: fts5AppendPoslist, fts5AppendRowid
// xBusy: xBusy
// xCellSize: cellSizePtr, cellSizePtrIdxLeaf, cellSizePtrNoPayload, cellSizePtrTableLeaf
// xCheckReservedLock: multiplexCheckReservedLock, quotaCheckReservedLock, vfstraceCheckReservedLock
// xClose: multiplexClose, quotaClose, vfstraceClose
// xCount: sessionDiffCount, sessionPreupdateCount, sessionStat1Count
// xCreate: fts5VtoVCreate
// xCurrentTime: multiplexCurrentTime, vfstraceCurrentTime
// xCurrentTimeInt64: multiplexCurrentTimeInt64
// xDelUser: circle_del, cube_context_free
// xDepth: sessionDiffDepth, sessionPreupdateDepth, sessionStat1Depth
// xDeviceCharacteristics: multiplexDeviceCharacteristics, quotaDeviceCharacteristics, vfstraceDeviceCharacteristics
// xDlClose: multiplexDlClose
// xDlError: multiplexDlError
// xExprCallback: agginfoPersistExprCb, aggregateIdxEprRefToColCallback, analyzeAggregate, checkConstraintExprNode, codeCursorHintCheckExpr, codeCursorHintFixExpr, codeCursorHintIsOrFunction, disallowAggregatesInOrderByCb, exprColumnFlagUnion, exprIdxCover, exprNodeCanReturnSubtype, exprNodeIsConstant, exprNodeIsConstantOrGroupBy, exprNodeIsDeterministic, exprRefToSrcList, fixExprCb, gatherSelectWindowsCallback, havingToWhereExprCb, impliesNotNullRow, incrAggDepth, markImmutableExprStep, propagateConstantExprRewrite, recomputeColumnsUsedExpr, renameColumnExprCb, renameQuotefixExprCb, renameTableExprCb, renameUnmapExprCb, renumberCursorsCb, resolveExprStep, resolveRemoveWindowsCb, selectCheckOnClausesExpr, selectWindowRewriteExprCb, sqlite3CursorRangeHintExprCheck, sqlite3ExprWalkNoop, sqlite3ReturningSubqueryVarSelect, sqlite3WindowExtraAggFuncDepth, whereIsCoveringIndexWalkCallback
// xFileControl: multiplexFileControl, quotaFileControl, vfstraceFileControl
// xFileSize: multiplexFileSize, quotaFileSize, vfstraceFileSize
// xFindTokenizer: fts5FindTokenizer
// xFindTokenizer_v2: fts5FindTokenizer_v2
// xFree: xFree
// xFreeSchema: xFree
// xFullPathname: multiplexFullPathname, vfstraceFullPathname
// xGet: getPageError, getPageMMap, getPageNormal
// xGetLastError: multiplexGetLastError
// xLock: multiplexLock, quotaLock, vfstraceLock
// xMerge: fts5MergePrefixLists, fts5MergeRowidLists
// xNew: sessionDiffNew, sessionPreupdateNew, sessionStat1New
// xNext: fts5ExprNodeNext_AND, fts5ExprNodeNext_NOT, fts5ExprNodeNext_OR, fts5ExprNodeNext_STRING, fts5ExprNodeNext_TERM, fts5SegIterNext, fts5SegIterNext_None, fts5SegIterNext_Reverse
// xOld: sessionDiffOld, sessionPreupdateOld, sessionStat1Old
// xOpen: multiplexOpen, quotaOpen, vfstraceOpen
// xParseCell: btreeParseCellPtr, btreeParseCellPtrIndex, btreeParseCellPtrNoPayload
// xRandomness: multiplexRandomness, vfstraceRandomness
// xRead: multiplexRead, quotaRead, vfstraceRead
// xSectorSize: multiplexSectorSize, quotaSectorSize, vfstraceSectorSize
// xSelectCallback: convertCompoundSelectToSubquery, exprSelectWalkTableConstant, fixSelectCb, gatherSelectWindowsSelectCallback, renameColumnSelectCb, renameTableSelectCb, renameUnmapSelectCb, resolveSelectStep, selectCheckOnClausesSelect, selectExpander, selectRefEnter, selectWindowRewriteSelectCb, sqlite3ReturningSubqueryCorrelated, sqlite3SelectWalkFail, sqlite3SelectWalkNoop, sqlite3WalkerDepthIncrease
// xSelectCallback2: selectAddSubqueryTypeInfo, selectRefLeave, sqlite3SelectPopWith, sqlite3SelectWalkAssert2, sqlite3WalkWinDefnDummyCallback, sqlite3WalkerDepthDecrease
// xSetOutputs: fts5IterSetOutputs_Col, fts5IterSetOutputs_Col100, fts5IterSetOutputs_Full, fts5IterSetOutputs_Nocolset, fts5IterSetOutputs_None, fts5IterSetOutputs_Noop, fts5IterSetOutputs_ZeroColset
// xShmBarrier: multiplexShmBarrier, quotaShmBarrier
// xShmLock: multiplexShmLock, quotaShmLock
// xShmMap: multiplexShmMap, quotaShmMap
// xShmUnmap: multiplexShmUnmap, quotaShmUnmap
// xSleep: multiplexSleep, vfstraceSleep
// xSync: multiplexSync, quotaSync, vfstraceSync
// xTruncate: multiplexTruncate, quotaTruncate, vfstraceTruncate
// xUnlock: multiplexUnlock, quotaUnlock, vfstraceUnlock
// xWrite: multiplexWrite, quotaWrite, vfstraceWrite


// ============================================================================
// Rules for function: agginfoPersistExprCb
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_agginfoPersistExprCb@
identifier F = { agginfoPersistExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_agginfoPersistExprCb@
identifier F = { agginfoPersistExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_agginfoPersistExprCb@
identifier F = { agginfoPersistExprCb };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_agginfoPersistExprCb@
identifier F = { agginfoPersistExprCb };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_agginfoPersistExprCb@
identifier F = { agginfoPersistExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_agginfoPersistExprCb@
identifier F = { agginfoPersistExprCb };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_agginfoPersistExprCb@
identifier F = { agginfoPersistExprCb };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_agginfoPersistExprCb@
identifier F = { agginfoPersistExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_agginfoPersistExprCb@
identifier F = { agginfoPersistExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_agginfoPersistExprCb@
identifier F = { agginfoPersistExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_agginfoPersistExprCb@
identifier F = { agginfoPersistExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: aggregateIdxEprRefToColCallback
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_aggregateIdxEprRefToColCallback@
identifier F = { aggregateIdxEprRefToColCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_aggregateIdxEprRefToColCallback@
identifier F = { aggregateIdxEprRefToColCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_aggregateIdxEprRefToColCallback@
identifier F = { aggregateIdxEprRefToColCallback };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_aggregateIdxEprRefToColCallback@
identifier F = { aggregateIdxEprRefToColCallback };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_aggregateIdxEprRefToColCallback@
identifier F = { aggregateIdxEprRefToColCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_aggregateIdxEprRefToColCallback@
identifier F = { aggregateIdxEprRefToColCallback };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_aggregateIdxEprRefToColCallback@
identifier F = { aggregateIdxEprRefToColCallback };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_aggregateIdxEprRefToColCallback@
identifier F = { aggregateIdxEprRefToColCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_aggregateIdxEprRefToColCallback@
identifier F = { aggregateIdxEprRefToColCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_aggregateIdxEprRefToColCallback@
identifier F = { aggregateIdxEprRefToColCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_aggregateIdxEprRefToColCallback@
identifier F = { aggregateIdxEprRefToColCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: analyzeAggregate
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_analyzeAggregate@
identifier F = { analyzeAggregate };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_analyzeAggregate@
identifier F = { analyzeAggregate };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_analyzeAggregate@
identifier F = { analyzeAggregate };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_analyzeAggregate@
identifier F = { analyzeAggregate };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_analyzeAggregate@
identifier F = { analyzeAggregate };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_analyzeAggregate@
identifier F = { analyzeAggregate };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_analyzeAggregate@
identifier F = { analyzeAggregate };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_analyzeAggregate@
identifier F = { analyzeAggregate };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_analyzeAggregate@
identifier F = { analyzeAggregate };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_analyzeAggregate@
identifier F = { analyzeAggregate };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_analyzeAggregate@
identifier F = { analyzeAggregate };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: btreeParseCellPtr
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_btreeParseCellPtr@
identifier F = { btreeParseCellPtr };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_btreeParseCellPtr@
identifier F = { btreeParseCellPtr };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_btreeParseCellPtr@
identifier F = { btreeParseCellPtr };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_btreeParseCellPtr@
identifier F = { btreeParseCellPtr };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_btreeParseCellPtr@
identifier F = { btreeParseCellPtr };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_btreeParseCellPtr@
identifier F = { btreeParseCellPtr };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_btreeParseCellPtr@
identifier F = { btreeParseCellPtr };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_btreeParseCellPtr@
identifier F = { btreeParseCellPtr };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_btreeParseCellPtr@
identifier F = { btreeParseCellPtr };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_btreeParseCellPtr@
identifier F = { btreeParseCellPtr };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_btreeParseCellPtr@
identifier F = { btreeParseCellPtr };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: btreeParseCellPtrIndex
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_btreeParseCellPtrIndex@
identifier F = { btreeParseCellPtrIndex };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_btreeParseCellPtrIndex@
identifier F = { btreeParseCellPtrIndex };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_btreeParseCellPtrIndex@
identifier F = { btreeParseCellPtrIndex };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_btreeParseCellPtrIndex@
identifier F = { btreeParseCellPtrIndex };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_btreeParseCellPtrIndex@
identifier F = { btreeParseCellPtrIndex };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_btreeParseCellPtrIndex@
identifier F = { btreeParseCellPtrIndex };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_btreeParseCellPtrIndex@
identifier F = { btreeParseCellPtrIndex };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_btreeParseCellPtrIndex@
identifier F = { btreeParseCellPtrIndex };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_btreeParseCellPtrIndex@
identifier F = { btreeParseCellPtrIndex };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_btreeParseCellPtrIndex@
identifier F = { btreeParseCellPtrIndex };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_btreeParseCellPtrIndex@
identifier F = { btreeParseCellPtrIndex };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: btreeParseCellPtrNoPayload
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_btreeParseCellPtrNoPayload@
identifier F = { btreeParseCellPtrNoPayload };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_btreeParseCellPtrNoPayload@
identifier F = { btreeParseCellPtrNoPayload };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_btreeParseCellPtrNoPayload@
identifier F = { btreeParseCellPtrNoPayload };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_btreeParseCellPtrNoPayload@
identifier F = { btreeParseCellPtrNoPayload };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_btreeParseCellPtrNoPayload@
identifier F = { btreeParseCellPtrNoPayload };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_btreeParseCellPtrNoPayload@
identifier F = { btreeParseCellPtrNoPayload };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_btreeParseCellPtrNoPayload@
identifier F = { btreeParseCellPtrNoPayload };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_btreeParseCellPtrNoPayload@
identifier F = { btreeParseCellPtrNoPayload };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_btreeParseCellPtrNoPayload@
identifier F = { btreeParseCellPtrNoPayload };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_btreeParseCellPtrNoPayload@
identifier F = { btreeParseCellPtrNoPayload };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_btreeParseCellPtrNoPayload@
identifier F = { btreeParseCellPtrNoPayload };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: cellSizePtr
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_cellSizePtr@
identifier F = { cellSizePtr };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_cellSizePtr@
identifier F = { cellSizePtr };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_cellSizePtr@
identifier F = { cellSizePtr };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_cellSizePtr@
identifier F = { cellSizePtr };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_cellSizePtr@
identifier F = { cellSizePtr };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_cellSizePtr@
identifier F = { cellSizePtr };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_cellSizePtr@
identifier F = { cellSizePtr };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_cellSizePtr@
identifier F = { cellSizePtr };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_cellSizePtr@
identifier F = { cellSizePtr };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_cellSizePtr@
identifier F = { cellSizePtr };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_cellSizePtr@
identifier F = { cellSizePtr };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: cellSizePtrIdxLeaf
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_cellSizePtrIdxLeaf@
identifier F = { cellSizePtrIdxLeaf };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_cellSizePtrIdxLeaf@
identifier F = { cellSizePtrIdxLeaf };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_cellSizePtrIdxLeaf@
identifier F = { cellSizePtrIdxLeaf };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_cellSizePtrIdxLeaf@
identifier F = { cellSizePtrIdxLeaf };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_cellSizePtrIdxLeaf@
identifier F = { cellSizePtrIdxLeaf };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_cellSizePtrIdxLeaf@
identifier F = { cellSizePtrIdxLeaf };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_cellSizePtrIdxLeaf@
identifier F = { cellSizePtrIdxLeaf };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_cellSizePtrIdxLeaf@
identifier F = { cellSizePtrIdxLeaf };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_cellSizePtrIdxLeaf@
identifier F = { cellSizePtrIdxLeaf };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_cellSizePtrIdxLeaf@
identifier F = { cellSizePtrIdxLeaf };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_cellSizePtrIdxLeaf@
identifier F = { cellSizePtrIdxLeaf };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: cellSizePtrNoPayload
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_cellSizePtrNoPayload@
identifier F = { cellSizePtrNoPayload };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_cellSizePtrNoPayload@
identifier F = { cellSizePtrNoPayload };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_cellSizePtrNoPayload@
identifier F = { cellSizePtrNoPayload };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_cellSizePtrNoPayload@
identifier F = { cellSizePtrNoPayload };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_cellSizePtrNoPayload@
identifier F = { cellSizePtrNoPayload };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_cellSizePtrNoPayload@
identifier F = { cellSizePtrNoPayload };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_cellSizePtrNoPayload@
identifier F = { cellSizePtrNoPayload };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_cellSizePtrNoPayload@
identifier F = { cellSizePtrNoPayload };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_cellSizePtrNoPayload@
identifier F = { cellSizePtrNoPayload };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_cellSizePtrNoPayload@
identifier F = { cellSizePtrNoPayload };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_cellSizePtrNoPayload@
identifier F = { cellSizePtrNoPayload };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: cellSizePtrTableLeaf
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_cellSizePtrTableLeaf@
identifier F = { cellSizePtrTableLeaf };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_cellSizePtrTableLeaf@
identifier F = { cellSizePtrTableLeaf };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_cellSizePtrTableLeaf@
identifier F = { cellSizePtrTableLeaf };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_cellSizePtrTableLeaf@
identifier F = { cellSizePtrTableLeaf };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_cellSizePtrTableLeaf@
identifier F = { cellSizePtrTableLeaf };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_cellSizePtrTableLeaf@
identifier F = { cellSizePtrTableLeaf };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_cellSizePtrTableLeaf@
identifier F = { cellSizePtrTableLeaf };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_cellSizePtrTableLeaf@
identifier F = { cellSizePtrTableLeaf };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_cellSizePtrTableLeaf@
identifier F = { cellSizePtrTableLeaf };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_cellSizePtrTableLeaf@
identifier F = { cellSizePtrTableLeaf };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_cellSizePtrTableLeaf@
identifier F = { cellSizePtrTableLeaf };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: checkConstraintExprNode
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_checkConstraintExprNode@
identifier F = { checkConstraintExprNode };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_checkConstraintExprNode@
identifier F = { checkConstraintExprNode };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_checkConstraintExprNode@
identifier F = { checkConstraintExprNode };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_checkConstraintExprNode@
identifier F = { checkConstraintExprNode };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_checkConstraintExprNode@
identifier F = { checkConstraintExprNode };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_checkConstraintExprNode@
identifier F = { checkConstraintExprNode };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_checkConstraintExprNode@
identifier F = { checkConstraintExprNode };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_checkConstraintExprNode@
identifier F = { checkConstraintExprNode };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_checkConstraintExprNode@
identifier F = { checkConstraintExprNode };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_checkConstraintExprNode@
identifier F = { checkConstraintExprNode };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_checkConstraintExprNode@
identifier F = { checkConstraintExprNode };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: circle_del
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_circle_del@
identifier F = { circle_del };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_circle_del@
identifier F = { circle_del };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_circle_del@
identifier F = { circle_del };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_circle_del@
identifier F = { circle_del };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_circle_del@
identifier F = { circle_del };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_circle_del@
identifier F = { circle_del };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_circle_del@
identifier F = { circle_del };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_circle_del@
identifier F = { circle_del };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_circle_del@
identifier F = { circle_del };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_circle_del@
identifier F = { circle_del };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_circle_del@
identifier F = { circle_del };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: codeCursorHintCheckExpr
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_codeCursorHintCheckExpr@
identifier F = { codeCursorHintCheckExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_codeCursorHintCheckExpr@
identifier F = { codeCursorHintCheckExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_codeCursorHintCheckExpr@
identifier F = { codeCursorHintCheckExpr };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_codeCursorHintCheckExpr@
identifier F = { codeCursorHintCheckExpr };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_codeCursorHintCheckExpr@
identifier F = { codeCursorHintCheckExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_codeCursorHintCheckExpr@
identifier F = { codeCursorHintCheckExpr };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_codeCursorHintCheckExpr@
identifier F = { codeCursorHintCheckExpr };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_codeCursorHintCheckExpr@
identifier F = { codeCursorHintCheckExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_codeCursorHintCheckExpr@
identifier F = { codeCursorHintCheckExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_codeCursorHintCheckExpr@
identifier F = { codeCursorHintCheckExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_codeCursorHintCheckExpr@
identifier F = { codeCursorHintCheckExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: codeCursorHintFixExpr
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_codeCursorHintFixExpr@
identifier F = { codeCursorHintFixExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_codeCursorHintFixExpr@
identifier F = { codeCursorHintFixExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_codeCursorHintFixExpr@
identifier F = { codeCursorHintFixExpr };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_codeCursorHintFixExpr@
identifier F = { codeCursorHintFixExpr };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_codeCursorHintFixExpr@
identifier F = { codeCursorHintFixExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_codeCursorHintFixExpr@
identifier F = { codeCursorHintFixExpr };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_codeCursorHintFixExpr@
identifier F = { codeCursorHintFixExpr };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_codeCursorHintFixExpr@
identifier F = { codeCursorHintFixExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_codeCursorHintFixExpr@
identifier F = { codeCursorHintFixExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_codeCursorHintFixExpr@
identifier F = { codeCursorHintFixExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_codeCursorHintFixExpr@
identifier F = { codeCursorHintFixExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: codeCursorHintIsOrFunction
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_codeCursorHintIsOrFunction@
identifier F = { codeCursorHintIsOrFunction };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_codeCursorHintIsOrFunction@
identifier F = { codeCursorHintIsOrFunction };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_codeCursorHintIsOrFunction@
identifier F = { codeCursorHintIsOrFunction };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_codeCursorHintIsOrFunction@
identifier F = { codeCursorHintIsOrFunction };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_codeCursorHintIsOrFunction@
identifier F = { codeCursorHintIsOrFunction };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_codeCursorHintIsOrFunction@
identifier F = { codeCursorHintIsOrFunction };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_codeCursorHintIsOrFunction@
identifier F = { codeCursorHintIsOrFunction };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_codeCursorHintIsOrFunction@
identifier F = { codeCursorHintIsOrFunction };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_codeCursorHintIsOrFunction@
identifier F = { codeCursorHintIsOrFunction };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_codeCursorHintIsOrFunction@
identifier F = { codeCursorHintIsOrFunction };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_codeCursorHintIsOrFunction@
identifier F = { codeCursorHintIsOrFunction };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: convertCompoundSelectToSubquery
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_convertCompoundSelectToSubquery@
identifier F = { convertCompoundSelectToSubquery };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_convertCompoundSelectToSubquery@
identifier F = { convertCompoundSelectToSubquery };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_convertCompoundSelectToSubquery@
identifier F = { convertCompoundSelectToSubquery };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_convertCompoundSelectToSubquery@
identifier F = { convertCompoundSelectToSubquery };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_convertCompoundSelectToSubquery@
identifier F = { convertCompoundSelectToSubquery };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_convertCompoundSelectToSubquery@
identifier F = { convertCompoundSelectToSubquery };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_convertCompoundSelectToSubquery@
identifier F = { convertCompoundSelectToSubquery };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_convertCompoundSelectToSubquery@
identifier F = { convertCompoundSelectToSubquery };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_convertCompoundSelectToSubquery@
identifier F = { convertCompoundSelectToSubquery };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_convertCompoundSelectToSubquery@
identifier F = { convertCompoundSelectToSubquery };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_convertCompoundSelectToSubquery@
identifier F = { convertCompoundSelectToSubquery };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: cube_context_free
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_cube_context_free@
identifier F = { cube_context_free };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_cube_context_free@
identifier F = { cube_context_free };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_cube_context_free@
identifier F = { cube_context_free };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_cube_context_free@
identifier F = { cube_context_free };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_cube_context_free@
identifier F = { cube_context_free };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_cube_context_free@
identifier F = { cube_context_free };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_cube_context_free@
identifier F = { cube_context_free };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_cube_context_free@
identifier F = { cube_context_free };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_cube_context_free@
identifier F = { cube_context_free };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_cube_context_free@
identifier F = { cube_context_free };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_cube_context_free@
identifier F = { cube_context_free };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: disallowAggregatesInOrderByCb
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_disallowAggregatesInOrderByCb@
identifier F = { disallowAggregatesInOrderByCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_disallowAggregatesInOrderByCb@
identifier F = { disallowAggregatesInOrderByCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_disallowAggregatesInOrderByCb@
identifier F = { disallowAggregatesInOrderByCb };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_disallowAggregatesInOrderByCb@
identifier F = { disallowAggregatesInOrderByCb };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_disallowAggregatesInOrderByCb@
identifier F = { disallowAggregatesInOrderByCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_disallowAggregatesInOrderByCb@
identifier F = { disallowAggregatesInOrderByCb };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_disallowAggregatesInOrderByCb@
identifier F = { disallowAggregatesInOrderByCb };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_disallowAggregatesInOrderByCb@
identifier F = { disallowAggregatesInOrderByCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_disallowAggregatesInOrderByCb@
identifier F = { disallowAggregatesInOrderByCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_disallowAggregatesInOrderByCb@
identifier F = { disallowAggregatesInOrderByCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_disallowAggregatesInOrderByCb@
identifier F = { disallowAggregatesInOrderByCb };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: exprColumnFlagUnion
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_exprColumnFlagUnion@
identifier F = { exprColumnFlagUnion };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_exprColumnFlagUnion@
identifier F = { exprColumnFlagUnion };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_exprColumnFlagUnion@
identifier F = { exprColumnFlagUnion };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_exprColumnFlagUnion@
identifier F = { exprColumnFlagUnion };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_exprColumnFlagUnion@
identifier F = { exprColumnFlagUnion };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_exprColumnFlagUnion@
identifier F = { exprColumnFlagUnion };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_exprColumnFlagUnion@
identifier F = { exprColumnFlagUnion };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_exprColumnFlagUnion@
identifier F = { exprColumnFlagUnion };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_exprColumnFlagUnion@
identifier F = { exprColumnFlagUnion };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_exprColumnFlagUnion@
identifier F = { exprColumnFlagUnion };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_exprColumnFlagUnion@
identifier F = { exprColumnFlagUnion };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: exprIdxCover
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_exprIdxCover@
identifier F = { exprIdxCover };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_exprIdxCover@
identifier F = { exprIdxCover };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_exprIdxCover@
identifier F = { exprIdxCover };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_exprIdxCover@
identifier F = { exprIdxCover };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_exprIdxCover@
identifier F = { exprIdxCover };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_exprIdxCover@
identifier F = { exprIdxCover };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_exprIdxCover@
identifier F = { exprIdxCover };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_exprIdxCover@
identifier F = { exprIdxCover };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_exprIdxCover@
identifier F = { exprIdxCover };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_exprIdxCover@
identifier F = { exprIdxCover };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_exprIdxCover@
identifier F = { exprIdxCover };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: exprNodeCanReturnSubtype
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_exprNodeCanReturnSubtype@
identifier F = { exprNodeCanReturnSubtype };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_exprNodeCanReturnSubtype@
identifier F = { exprNodeCanReturnSubtype };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_exprNodeCanReturnSubtype@
identifier F = { exprNodeCanReturnSubtype };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_exprNodeCanReturnSubtype@
identifier F = { exprNodeCanReturnSubtype };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_exprNodeCanReturnSubtype@
identifier F = { exprNodeCanReturnSubtype };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_exprNodeCanReturnSubtype@
identifier F = { exprNodeCanReturnSubtype };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_exprNodeCanReturnSubtype@
identifier F = { exprNodeCanReturnSubtype };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_exprNodeCanReturnSubtype@
identifier F = { exprNodeCanReturnSubtype };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_exprNodeCanReturnSubtype@
identifier F = { exprNodeCanReturnSubtype };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_exprNodeCanReturnSubtype@
identifier F = { exprNodeCanReturnSubtype };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_exprNodeCanReturnSubtype@
identifier F = { exprNodeCanReturnSubtype };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: exprNodeIsConstant
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_exprNodeIsConstant@
identifier F = { exprNodeIsConstant };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_exprNodeIsConstant@
identifier F = { exprNodeIsConstant };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_exprNodeIsConstant@
identifier F = { exprNodeIsConstant };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_exprNodeIsConstant@
identifier F = { exprNodeIsConstant };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_exprNodeIsConstant@
identifier F = { exprNodeIsConstant };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_exprNodeIsConstant@
identifier F = { exprNodeIsConstant };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_exprNodeIsConstant@
identifier F = { exprNodeIsConstant };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_exprNodeIsConstant@
identifier F = { exprNodeIsConstant };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_exprNodeIsConstant@
identifier F = { exprNodeIsConstant };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_exprNodeIsConstant@
identifier F = { exprNodeIsConstant };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_exprNodeIsConstant@
identifier F = { exprNodeIsConstant };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: exprNodeIsConstantOrGroupBy
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_exprNodeIsConstantOrGroupBy@
identifier F = { exprNodeIsConstantOrGroupBy };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_exprNodeIsConstantOrGroupBy@
identifier F = { exprNodeIsConstantOrGroupBy };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_exprNodeIsConstantOrGroupBy@
identifier F = { exprNodeIsConstantOrGroupBy };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_exprNodeIsConstantOrGroupBy@
identifier F = { exprNodeIsConstantOrGroupBy };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_exprNodeIsConstantOrGroupBy@
identifier F = { exprNodeIsConstantOrGroupBy };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_exprNodeIsConstantOrGroupBy@
identifier F = { exprNodeIsConstantOrGroupBy };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_exprNodeIsConstantOrGroupBy@
identifier F = { exprNodeIsConstantOrGroupBy };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_exprNodeIsConstantOrGroupBy@
identifier F = { exprNodeIsConstantOrGroupBy };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_exprNodeIsConstantOrGroupBy@
identifier F = { exprNodeIsConstantOrGroupBy };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_exprNodeIsConstantOrGroupBy@
identifier F = { exprNodeIsConstantOrGroupBy };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_exprNodeIsConstantOrGroupBy@
identifier F = { exprNodeIsConstantOrGroupBy };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: exprNodeIsDeterministic
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_exprNodeIsDeterministic@
identifier F = { exprNodeIsDeterministic };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_exprNodeIsDeterministic@
identifier F = { exprNodeIsDeterministic };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_exprNodeIsDeterministic@
identifier F = { exprNodeIsDeterministic };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_exprNodeIsDeterministic@
identifier F = { exprNodeIsDeterministic };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_exprNodeIsDeterministic@
identifier F = { exprNodeIsDeterministic };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_exprNodeIsDeterministic@
identifier F = { exprNodeIsDeterministic };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_exprNodeIsDeterministic@
identifier F = { exprNodeIsDeterministic };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_exprNodeIsDeterministic@
identifier F = { exprNodeIsDeterministic };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_exprNodeIsDeterministic@
identifier F = { exprNodeIsDeterministic };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_exprNodeIsDeterministic@
identifier F = { exprNodeIsDeterministic };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_exprNodeIsDeterministic@
identifier F = { exprNodeIsDeterministic };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: exprRefToSrcList
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_exprRefToSrcList@
identifier F = { exprRefToSrcList };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_exprRefToSrcList@
identifier F = { exprRefToSrcList };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_exprRefToSrcList@
identifier F = { exprRefToSrcList };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_exprRefToSrcList@
identifier F = { exprRefToSrcList };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_exprRefToSrcList@
identifier F = { exprRefToSrcList };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_exprRefToSrcList@
identifier F = { exprRefToSrcList };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_exprRefToSrcList@
identifier F = { exprRefToSrcList };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_exprRefToSrcList@
identifier F = { exprRefToSrcList };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_exprRefToSrcList@
identifier F = { exprRefToSrcList };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_exprRefToSrcList@
identifier F = { exprRefToSrcList };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_exprRefToSrcList@
identifier F = { exprRefToSrcList };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: exprSelectWalkTableConstant
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_exprSelectWalkTableConstant@
identifier F = { exprSelectWalkTableConstant };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_exprSelectWalkTableConstant@
identifier F = { exprSelectWalkTableConstant };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_exprSelectWalkTableConstant@
identifier F = { exprSelectWalkTableConstant };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_exprSelectWalkTableConstant@
identifier F = { exprSelectWalkTableConstant };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_exprSelectWalkTableConstant@
identifier F = { exprSelectWalkTableConstant };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_exprSelectWalkTableConstant@
identifier F = { exprSelectWalkTableConstant };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_exprSelectWalkTableConstant@
identifier F = { exprSelectWalkTableConstant };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_exprSelectWalkTableConstant@
identifier F = { exprSelectWalkTableConstant };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_exprSelectWalkTableConstant@
identifier F = { exprSelectWalkTableConstant };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_exprSelectWalkTableConstant@
identifier F = { exprSelectWalkTableConstant };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_exprSelectWalkTableConstant@
identifier F = { exprSelectWalkTableConstant };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fixExprCb
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fixExprCb@
identifier F = { fixExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fixExprCb@
identifier F = { fixExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fixExprCb@
identifier F = { fixExprCb };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fixExprCb@
identifier F = { fixExprCb };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fixExprCb@
identifier F = { fixExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fixExprCb@
identifier F = { fixExprCb };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fixExprCb@
identifier F = { fixExprCb };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fixExprCb@
identifier F = { fixExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fixExprCb@
identifier F = { fixExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fixExprCb@
identifier F = { fixExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fixExprCb@
identifier F = { fixExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fixSelectCb
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fixSelectCb@
identifier F = { fixSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fixSelectCb@
identifier F = { fixSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fixSelectCb@
identifier F = { fixSelectCb };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fixSelectCb@
identifier F = { fixSelectCb };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fixSelectCb@
identifier F = { fixSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fixSelectCb@
identifier F = { fixSelectCb };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fixSelectCb@
identifier F = { fixSelectCb };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fixSelectCb@
identifier F = { fixSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fixSelectCb@
identifier F = { fixSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fixSelectCb@
identifier F = { fixSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fixSelectCb@
identifier F = { fixSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fts5AppendPoslist
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fts5AppendPoslist@
identifier F = { fts5AppendPoslist };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fts5AppendPoslist@
identifier F = { fts5AppendPoslist };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fts5AppendPoslist@
identifier F = { fts5AppendPoslist };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fts5AppendPoslist@
identifier F = { fts5AppendPoslist };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fts5AppendPoslist@
identifier F = { fts5AppendPoslist };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fts5AppendPoslist@
identifier F = { fts5AppendPoslist };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fts5AppendPoslist@
identifier F = { fts5AppendPoslist };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fts5AppendPoslist@
identifier F = { fts5AppendPoslist };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fts5AppendPoslist@
identifier F = { fts5AppendPoslist };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fts5AppendPoslist@
identifier F = { fts5AppendPoslist };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fts5AppendPoslist@
identifier F = { fts5AppendPoslist };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fts5AppendRowid
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fts5AppendRowid@
identifier F = { fts5AppendRowid };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fts5AppendRowid@
identifier F = { fts5AppendRowid };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fts5AppendRowid@
identifier F = { fts5AppendRowid };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fts5AppendRowid@
identifier F = { fts5AppendRowid };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fts5AppendRowid@
identifier F = { fts5AppendRowid };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fts5AppendRowid@
identifier F = { fts5AppendRowid };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fts5AppendRowid@
identifier F = { fts5AppendRowid };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fts5AppendRowid@
identifier F = { fts5AppendRowid };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fts5AppendRowid@
identifier F = { fts5AppendRowid };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fts5AppendRowid@
identifier F = { fts5AppendRowid };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fts5AppendRowid@
identifier F = { fts5AppendRowid };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fts5ExprNodeNext_AND
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fts5ExprNodeNext_AND@
identifier F = { fts5ExprNodeNext_AND };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fts5ExprNodeNext_AND@
identifier F = { fts5ExprNodeNext_AND };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fts5ExprNodeNext_AND@
identifier F = { fts5ExprNodeNext_AND };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fts5ExprNodeNext_AND@
identifier F = { fts5ExprNodeNext_AND };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fts5ExprNodeNext_AND@
identifier F = { fts5ExprNodeNext_AND };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fts5ExprNodeNext_AND@
identifier F = { fts5ExprNodeNext_AND };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fts5ExprNodeNext_AND@
identifier F = { fts5ExprNodeNext_AND };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fts5ExprNodeNext_AND@
identifier F = { fts5ExprNodeNext_AND };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fts5ExprNodeNext_AND@
identifier F = { fts5ExprNodeNext_AND };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fts5ExprNodeNext_AND@
identifier F = { fts5ExprNodeNext_AND };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fts5ExprNodeNext_AND@
identifier F = { fts5ExprNodeNext_AND };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fts5ExprNodeNext_NOT
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fts5ExprNodeNext_NOT@
identifier F = { fts5ExprNodeNext_NOT };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fts5ExprNodeNext_NOT@
identifier F = { fts5ExprNodeNext_NOT };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fts5ExprNodeNext_NOT@
identifier F = { fts5ExprNodeNext_NOT };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fts5ExprNodeNext_NOT@
identifier F = { fts5ExprNodeNext_NOT };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fts5ExprNodeNext_NOT@
identifier F = { fts5ExprNodeNext_NOT };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fts5ExprNodeNext_NOT@
identifier F = { fts5ExprNodeNext_NOT };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fts5ExprNodeNext_NOT@
identifier F = { fts5ExprNodeNext_NOT };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fts5ExprNodeNext_NOT@
identifier F = { fts5ExprNodeNext_NOT };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fts5ExprNodeNext_NOT@
identifier F = { fts5ExprNodeNext_NOT };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fts5ExprNodeNext_NOT@
identifier F = { fts5ExprNodeNext_NOT };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fts5ExprNodeNext_NOT@
identifier F = { fts5ExprNodeNext_NOT };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fts5ExprNodeNext_OR
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fts5ExprNodeNext_OR@
identifier F = { fts5ExprNodeNext_OR };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fts5ExprNodeNext_OR@
identifier F = { fts5ExprNodeNext_OR };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fts5ExprNodeNext_OR@
identifier F = { fts5ExprNodeNext_OR };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fts5ExprNodeNext_OR@
identifier F = { fts5ExprNodeNext_OR };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fts5ExprNodeNext_OR@
identifier F = { fts5ExprNodeNext_OR };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fts5ExprNodeNext_OR@
identifier F = { fts5ExprNodeNext_OR };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fts5ExprNodeNext_OR@
identifier F = { fts5ExprNodeNext_OR };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fts5ExprNodeNext_OR@
identifier F = { fts5ExprNodeNext_OR };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fts5ExprNodeNext_OR@
identifier F = { fts5ExprNodeNext_OR };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fts5ExprNodeNext_OR@
identifier F = { fts5ExprNodeNext_OR };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fts5ExprNodeNext_OR@
identifier F = { fts5ExprNodeNext_OR };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fts5ExprNodeNext_STRING
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fts5ExprNodeNext_STRING@
identifier F = { fts5ExprNodeNext_STRING };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fts5ExprNodeNext_STRING@
identifier F = { fts5ExprNodeNext_STRING };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fts5ExprNodeNext_STRING@
identifier F = { fts5ExprNodeNext_STRING };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fts5ExprNodeNext_STRING@
identifier F = { fts5ExprNodeNext_STRING };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fts5ExprNodeNext_STRING@
identifier F = { fts5ExprNodeNext_STRING };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fts5ExprNodeNext_STRING@
identifier F = { fts5ExprNodeNext_STRING };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fts5ExprNodeNext_STRING@
identifier F = { fts5ExprNodeNext_STRING };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fts5ExprNodeNext_STRING@
identifier F = { fts5ExprNodeNext_STRING };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fts5ExprNodeNext_STRING@
identifier F = { fts5ExprNodeNext_STRING };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fts5ExprNodeNext_STRING@
identifier F = { fts5ExprNodeNext_STRING };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fts5ExprNodeNext_STRING@
identifier F = { fts5ExprNodeNext_STRING };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fts5ExprNodeNext_TERM
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fts5ExprNodeNext_TERM@
identifier F = { fts5ExprNodeNext_TERM };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fts5ExprNodeNext_TERM@
identifier F = { fts5ExprNodeNext_TERM };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fts5ExprNodeNext_TERM@
identifier F = { fts5ExprNodeNext_TERM };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fts5ExprNodeNext_TERM@
identifier F = { fts5ExprNodeNext_TERM };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fts5ExprNodeNext_TERM@
identifier F = { fts5ExprNodeNext_TERM };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fts5ExprNodeNext_TERM@
identifier F = { fts5ExprNodeNext_TERM };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fts5ExprNodeNext_TERM@
identifier F = { fts5ExprNodeNext_TERM };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fts5ExprNodeNext_TERM@
identifier F = { fts5ExprNodeNext_TERM };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fts5ExprNodeNext_TERM@
identifier F = { fts5ExprNodeNext_TERM };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fts5ExprNodeNext_TERM@
identifier F = { fts5ExprNodeNext_TERM };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fts5ExprNodeNext_TERM@
identifier F = { fts5ExprNodeNext_TERM };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fts5FindTokenizer
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fts5FindTokenizer@
identifier F = { fts5FindTokenizer };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fts5FindTokenizer@
identifier F = { fts5FindTokenizer };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fts5FindTokenizer@
identifier F = { fts5FindTokenizer };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fts5FindTokenizer@
identifier F = { fts5FindTokenizer };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fts5FindTokenizer@
identifier F = { fts5FindTokenizer };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fts5FindTokenizer@
identifier F = { fts5FindTokenizer };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fts5FindTokenizer@
identifier F = { fts5FindTokenizer };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fts5FindTokenizer@
identifier F = { fts5FindTokenizer };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fts5FindTokenizer@
identifier F = { fts5FindTokenizer };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fts5FindTokenizer@
identifier F = { fts5FindTokenizer };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fts5FindTokenizer@
identifier F = { fts5FindTokenizer };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fts5FindTokenizer_v2
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fts5FindTokenizer_v2@
identifier F = { fts5FindTokenizer_v2 };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fts5FindTokenizer_v2@
identifier F = { fts5FindTokenizer_v2 };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fts5FindTokenizer_v2@
identifier F = { fts5FindTokenizer_v2 };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fts5FindTokenizer_v2@
identifier F = { fts5FindTokenizer_v2 };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fts5FindTokenizer_v2@
identifier F = { fts5FindTokenizer_v2 };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fts5FindTokenizer_v2@
identifier F = { fts5FindTokenizer_v2 };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fts5FindTokenizer_v2@
identifier F = { fts5FindTokenizer_v2 };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fts5FindTokenizer_v2@
identifier F = { fts5FindTokenizer_v2 };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fts5FindTokenizer_v2@
identifier F = { fts5FindTokenizer_v2 };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fts5FindTokenizer_v2@
identifier F = { fts5FindTokenizer_v2 };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fts5FindTokenizer_v2@
identifier F = { fts5FindTokenizer_v2 };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fts5IterSetOutputs_Col
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fts5IterSetOutputs_Col@
identifier F = { fts5IterSetOutputs_Col };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fts5IterSetOutputs_Col@
identifier F = { fts5IterSetOutputs_Col };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fts5IterSetOutputs_Col@
identifier F = { fts5IterSetOutputs_Col };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fts5IterSetOutputs_Col@
identifier F = { fts5IterSetOutputs_Col };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fts5IterSetOutputs_Col@
identifier F = { fts5IterSetOutputs_Col };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fts5IterSetOutputs_Col@
identifier F = { fts5IterSetOutputs_Col };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fts5IterSetOutputs_Col@
identifier F = { fts5IterSetOutputs_Col };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fts5IterSetOutputs_Col@
identifier F = { fts5IterSetOutputs_Col };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fts5IterSetOutputs_Col@
identifier F = { fts5IterSetOutputs_Col };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fts5IterSetOutputs_Col@
identifier F = { fts5IterSetOutputs_Col };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fts5IterSetOutputs_Col@
identifier F = { fts5IterSetOutputs_Col };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fts5IterSetOutputs_Col100
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fts5IterSetOutputs_Col100@
identifier F = { fts5IterSetOutputs_Col100 };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fts5IterSetOutputs_Col100@
identifier F = { fts5IterSetOutputs_Col100 };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fts5IterSetOutputs_Col100@
identifier F = { fts5IterSetOutputs_Col100 };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fts5IterSetOutputs_Col100@
identifier F = { fts5IterSetOutputs_Col100 };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fts5IterSetOutputs_Col100@
identifier F = { fts5IterSetOutputs_Col100 };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fts5IterSetOutputs_Col100@
identifier F = { fts5IterSetOutputs_Col100 };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fts5IterSetOutputs_Col100@
identifier F = { fts5IterSetOutputs_Col100 };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fts5IterSetOutputs_Col100@
identifier F = { fts5IterSetOutputs_Col100 };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fts5IterSetOutputs_Col100@
identifier F = { fts5IterSetOutputs_Col100 };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fts5IterSetOutputs_Col100@
identifier F = { fts5IterSetOutputs_Col100 };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fts5IterSetOutputs_Col100@
identifier F = { fts5IterSetOutputs_Col100 };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fts5IterSetOutputs_Full
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fts5IterSetOutputs_Full@
identifier F = { fts5IterSetOutputs_Full };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fts5IterSetOutputs_Full@
identifier F = { fts5IterSetOutputs_Full };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fts5IterSetOutputs_Full@
identifier F = { fts5IterSetOutputs_Full };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fts5IterSetOutputs_Full@
identifier F = { fts5IterSetOutputs_Full };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fts5IterSetOutputs_Full@
identifier F = { fts5IterSetOutputs_Full };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fts5IterSetOutputs_Full@
identifier F = { fts5IterSetOutputs_Full };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fts5IterSetOutputs_Full@
identifier F = { fts5IterSetOutputs_Full };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fts5IterSetOutputs_Full@
identifier F = { fts5IterSetOutputs_Full };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fts5IterSetOutputs_Full@
identifier F = { fts5IterSetOutputs_Full };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fts5IterSetOutputs_Full@
identifier F = { fts5IterSetOutputs_Full };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fts5IterSetOutputs_Full@
identifier F = { fts5IterSetOutputs_Full };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fts5IterSetOutputs_Nocolset
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fts5IterSetOutputs_Nocolset@
identifier F = { fts5IterSetOutputs_Nocolset };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fts5IterSetOutputs_Nocolset@
identifier F = { fts5IterSetOutputs_Nocolset };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fts5IterSetOutputs_Nocolset@
identifier F = { fts5IterSetOutputs_Nocolset };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fts5IterSetOutputs_Nocolset@
identifier F = { fts5IterSetOutputs_Nocolset };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fts5IterSetOutputs_Nocolset@
identifier F = { fts5IterSetOutputs_Nocolset };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fts5IterSetOutputs_Nocolset@
identifier F = { fts5IterSetOutputs_Nocolset };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fts5IterSetOutputs_Nocolset@
identifier F = { fts5IterSetOutputs_Nocolset };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fts5IterSetOutputs_Nocolset@
identifier F = { fts5IterSetOutputs_Nocolset };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fts5IterSetOutputs_Nocolset@
identifier F = { fts5IterSetOutputs_Nocolset };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fts5IterSetOutputs_Nocolset@
identifier F = { fts5IterSetOutputs_Nocolset };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fts5IterSetOutputs_Nocolset@
identifier F = { fts5IterSetOutputs_Nocolset };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fts5IterSetOutputs_None
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fts5IterSetOutputs_None@
identifier F = { fts5IterSetOutputs_None };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fts5IterSetOutputs_None@
identifier F = { fts5IterSetOutputs_None };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fts5IterSetOutputs_None@
identifier F = { fts5IterSetOutputs_None };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fts5IterSetOutputs_None@
identifier F = { fts5IterSetOutputs_None };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fts5IterSetOutputs_None@
identifier F = { fts5IterSetOutputs_None };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fts5IterSetOutputs_None@
identifier F = { fts5IterSetOutputs_None };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fts5IterSetOutputs_None@
identifier F = { fts5IterSetOutputs_None };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fts5IterSetOutputs_None@
identifier F = { fts5IterSetOutputs_None };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fts5IterSetOutputs_None@
identifier F = { fts5IterSetOutputs_None };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fts5IterSetOutputs_None@
identifier F = { fts5IterSetOutputs_None };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fts5IterSetOutputs_None@
identifier F = { fts5IterSetOutputs_None };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fts5IterSetOutputs_Noop
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fts5IterSetOutputs_Noop@
identifier F = { fts5IterSetOutputs_Noop };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fts5IterSetOutputs_Noop@
identifier F = { fts5IterSetOutputs_Noop };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fts5IterSetOutputs_Noop@
identifier F = { fts5IterSetOutputs_Noop };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fts5IterSetOutputs_Noop@
identifier F = { fts5IterSetOutputs_Noop };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fts5IterSetOutputs_Noop@
identifier F = { fts5IterSetOutputs_Noop };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fts5IterSetOutputs_Noop@
identifier F = { fts5IterSetOutputs_Noop };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fts5IterSetOutputs_Noop@
identifier F = { fts5IterSetOutputs_Noop };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fts5IterSetOutputs_Noop@
identifier F = { fts5IterSetOutputs_Noop };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fts5IterSetOutputs_Noop@
identifier F = { fts5IterSetOutputs_Noop };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fts5IterSetOutputs_Noop@
identifier F = { fts5IterSetOutputs_Noop };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fts5IterSetOutputs_Noop@
identifier F = { fts5IterSetOutputs_Noop };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fts5IterSetOutputs_ZeroColset
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fts5IterSetOutputs_ZeroColset@
identifier F = { fts5IterSetOutputs_ZeroColset };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fts5IterSetOutputs_ZeroColset@
identifier F = { fts5IterSetOutputs_ZeroColset };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fts5IterSetOutputs_ZeroColset@
identifier F = { fts5IterSetOutputs_ZeroColset };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fts5IterSetOutputs_ZeroColset@
identifier F = { fts5IterSetOutputs_ZeroColset };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fts5IterSetOutputs_ZeroColset@
identifier F = { fts5IterSetOutputs_ZeroColset };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fts5IterSetOutputs_ZeroColset@
identifier F = { fts5IterSetOutputs_ZeroColset };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fts5IterSetOutputs_ZeroColset@
identifier F = { fts5IterSetOutputs_ZeroColset };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fts5IterSetOutputs_ZeroColset@
identifier F = { fts5IterSetOutputs_ZeroColset };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fts5IterSetOutputs_ZeroColset@
identifier F = { fts5IterSetOutputs_ZeroColset };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fts5IterSetOutputs_ZeroColset@
identifier F = { fts5IterSetOutputs_ZeroColset };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fts5IterSetOutputs_ZeroColset@
identifier F = { fts5IterSetOutputs_ZeroColset };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fts5MergePrefixLists
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fts5MergePrefixLists@
identifier F = { fts5MergePrefixLists };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fts5MergePrefixLists@
identifier F = { fts5MergePrefixLists };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fts5MergePrefixLists@
identifier F = { fts5MergePrefixLists };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fts5MergePrefixLists@
identifier F = { fts5MergePrefixLists };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fts5MergePrefixLists@
identifier F = { fts5MergePrefixLists };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fts5MergePrefixLists@
identifier F = { fts5MergePrefixLists };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fts5MergePrefixLists@
identifier F = { fts5MergePrefixLists };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fts5MergePrefixLists@
identifier F = { fts5MergePrefixLists };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fts5MergePrefixLists@
identifier F = { fts5MergePrefixLists };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fts5MergePrefixLists@
identifier F = { fts5MergePrefixLists };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fts5MergePrefixLists@
identifier F = { fts5MergePrefixLists };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fts5MergeRowidLists
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fts5MergeRowidLists@
identifier F = { fts5MergeRowidLists };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fts5MergeRowidLists@
identifier F = { fts5MergeRowidLists };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fts5MergeRowidLists@
identifier F = { fts5MergeRowidLists };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fts5MergeRowidLists@
identifier F = { fts5MergeRowidLists };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fts5MergeRowidLists@
identifier F = { fts5MergeRowidLists };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fts5MergeRowidLists@
identifier F = { fts5MergeRowidLists };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fts5MergeRowidLists@
identifier F = { fts5MergeRowidLists };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fts5MergeRowidLists@
identifier F = { fts5MergeRowidLists };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fts5MergeRowidLists@
identifier F = { fts5MergeRowidLists };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fts5MergeRowidLists@
identifier F = { fts5MergeRowidLists };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fts5MergeRowidLists@
identifier F = { fts5MergeRowidLists };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fts5SegIterNext
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fts5SegIterNext@
identifier F = { fts5SegIterNext };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fts5SegIterNext@
identifier F = { fts5SegIterNext };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fts5SegIterNext@
identifier F = { fts5SegIterNext };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fts5SegIterNext@
identifier F = { fts5SegIterNext };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fts5SegIterNext@
identifier F = { fts5SegIterNext };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fts5SegIterNext@
identifier F = { fts5SegIterNext };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fts5SegIterNext@
identifier F = { fts5SegIterNext };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fts5SegIterNext@
identifier F = { fts5SegIterNext };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fts5SegIterNext@
identifier F = { fts5SegIterNext };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fts5SegIterNext@
identifier F = { fts5SegIterNext };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fts5SegIterNext@
identifier F = { fts5SegIterNext };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fts5SegIterNext_None
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fts5SegIterNext_None@
identifier F = { fts5SegIterNext_None };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fts5SegIterNext_None@
identifier F = { fts5SegIterNext_None };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fts5SegIterNext_None@
identifier F = { fts5SegIterNext_None };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fts5SegIterNext_None@
identifier F = { fts5SegIterNext_None };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fts5SegIterNext_None@
identifier F = { fts5SegIterNext_None };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fts5SegIterNext_None@
identifier F = { fts5SegIterNext_None };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fts5SegIterNext_None@
identifier F = { fts5SegIterNext_None };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fts5SegIterNext_None@
identifier F = { fts5SegIterNext_None };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fts5SegIterNext_None@
identifier F = { fts5SegIterNext_None };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fts5SegIterNext_None@
identifier F = { fts5SegIterNext_None };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fts5SegIterNext_None@
identifier F = { fts5SegIterNext_None };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fts5SegIterNext_Reverse
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fts5SegIterNext_Reverse@
identifier F = { fts5SegIterNext_Reverse };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fts5SegIterNext_Reverse@
identifier F = { fts5SegIterNext_Reverse };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fts5SegIterNext_Reverse@
identifier F = { fts5SegIterNext_Reverse };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fts5SegIterNext_Reverse@
identifier F = { fts5SegIterNext_Reverse };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fts5SegIterNext_Reverse@
identifier F = { fts5SegIterNext_Reverse };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fts5SegIterNext_Reverse@
identifier F = { fts5SegIterNext_Reverse };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fts5SegIterNext_Reverse@
identifier F = { fts5SegIterNext_Reverse };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fts5SegIterNext_Reverse@
identifier F = { fts5SegIterNext_Reverse };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fts5SegIterNext_Reverse@
identifier F = { fts5SegIterNext_Reverse };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fts5SegIterNext_Reverse@
identifier F = { fts5SegIterNext_Reverse };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fts5SegIterNext_Reverse@
identifier F = { fts5SegIterNext_Reverse };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: fts5VtoVCreate
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_fts5VtoVCreate@
identifier F = { fts5VtoVCreate };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_fts5VtoVCreate@
identifier F = { fts5VtoVCreate };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_fts5VtoVCreate@
identifier F = { fts5VtoVCreate };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_fts5VtoVCreate@
identifier F = { fts5VtoVCreate };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_fts5VtoVCreate@
identifier F = { fts5VtoVCreate };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_fts5VtoVCreate@
identifier F = { fts5VtoVCreate };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_fts5VtoVCreate@
identifier F = { fts5VtoVCreate };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_fts5VtoVCreate@
identifier F = { fts5VtoVCreate };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_fts5VtoVCreate@
identifier F = { fts5VtoVCreate };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_fts5VtoVCreate@
identifier F = { fts5VtoVCreate };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_fts5VtoVCreate@
identifier F = { fts5VtoVCreate };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: gatherSelectWindowsCallback
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_gatherSelectWindowsCallback@
identifier F = { gatherSelectWindowsCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_gatherSelectWindowsCallback@
identifier F = { gatherSelectWindowsCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_gatherSelectWindowsCallback@
identifier F = { gatherSelectWindowsCallback };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_gatherSelectWindowsCallback@
identifier F = { gatherSelectWindowsCallback };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_gatherSelectWindowsCallback@
identifier F = { gatherSelectWindowsCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_gatherSelectWindowsCallback@
identifier F = { gatherSelectWindowsCallback };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_gatherSelectWindowsCallback@
identifier F = { gatherSelectWindowsCallback };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_gatherSelectWindowsCallback@
identifier F = { gatherSelectWindowsCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_gatherSelectWindowsCallback@
identifier F = { gatherSelectWindowsCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_gatherSelectWindowsCallback@
identifier F = { gatherSelectWindowsCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_gatherSelectWindowsCallback@
identifier F = { gatherSelectWindowsCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: gatherSelectWindowsSelectCallback
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_gatherSelectWindowsSelectCallback@
identifier F = { gatherSelectWindowsSelectCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_gatherSelectWindowsSelectCallback@
identifier F = { gatherSelectWindowsSelectCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_gatherSelectWindowsSelectCallback@
identifier F = { gatherSelectWindowsSelectCallback };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_gatherSelectWindowsSelectCallback@
identifier F = { gatherSelectWindowsSelectCallback };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_gatherSelectWindowsSelectCallback@
identifier F = { gatherSelectWindowsSelectCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_gatherSelectWindowsSelectCallback@
identifier F = { gatherSelectWindowsSelectCallback };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_gatherSelectWindowsSelectCallback@
identifier F = { gatherSelectWindowsSelectCallback };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_gatherSelectWindowsSelectCallback@
identifier F = { gatherSelectWindowsSelectCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_gatherSelectWindowsSelectCallback@
identifier F = { gatherSelectWindowsSelectCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_gatherSelectWindowsSelectCallback@
identifier F = { gatherSelectWindowsSelectCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_gatherSelectWindowsSelectCallback@
identifier F = { gatherSelectWindowsSelectCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: getPageError
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_getPageError@
identifier F = { getPageError };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_getPageError@
identifier F = { getPageError };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_getPageError@
identifier F = { getPageError };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_getPageError@
identifier F = { getPageError };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_getPageError@
identifier F = { getPageError };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_getPageError@
identifier F = { getPageError };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_getPageError@
identifier F = { getPageError };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_getPageError@
identifier F = { getPageError };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_getPageError@
identifier F = { getPageError };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_getPageError@
identifier F = { getPageError };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_getPageError@
identifier F = { getPageError };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: getPageMMap
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_getPageMMap@
identifier F = { getPageMMap };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_getPageMMap@
identifier F = { getPageMMap };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_getPageMMap@
identifier F = { getPageMMap };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_getPageMMap@
identifier F = { getPageMMap };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_getPageMMap@
identifier F = { getPageMMap };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_getPageMMap@
identifier F = { getPageMMap };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_getPageMMap@
identifier F = { getPageMMap };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_getPageMMap@
identifier F = { getPageMMap };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_getPageMMap@
identifier F = { getPageMMap };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_getPageMMap@
identifier F = { getPageMMap };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_getPageMMap@
identifier F = { getPageMMap };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: getPageNormal
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_getPageNormal@
identifier F = { getPageNormal };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_getPageNormal@
identifier F = { getPageNormal };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_getPageNormal@
identifier F = { getPageNormal };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_getPageNormal@
identifier F = { getPageNormal };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_getPageNormal@
identifier F = { getPageNormal };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_getPageNormal@
identifier F = { getPageNormal };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_getPageNormal@
identifier F = { getPageNormal };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_getPageNormal@
identifier F = { getPageNormal };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_getPageNormal@
identifier F = { getPageNormal };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_getPageNormal@
identifier F = { getPageNormal };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_getPageNormal@
identifier F = { getPageNormal };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: havingToWhereExprCb
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_havingToWhereExprCb@
identifier F = { havingToWhereExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_havingToWhereExprCb@
identifier F = { havingToWhereExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_havingToWhereExprCb@
identifier F = { havingToWhereExprCb };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_havingToWhereExprCb@
identifier F = { havingToWhereExprCb };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_havingToWhereExprCb@
identifier F = { havingToWhereExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_havingToWhereExprCb@
identifier F = { havingToWhereExprCb };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_havingToWhereExprCb@
identifier F = { havingToWhereExprCb };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_havingToWhereExprCb@
identifier F = { havingToWhereExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_havingToWhereExprCb@
identifier F = { havingToWhereExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_havingToWhereExprCb@
identifier F = { havingToWhereExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_havingToWhereExprCb@
identifier F = { havingToWhereExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: impliesNotNullRow
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_impliesNotNullRow@
identifier F = { impliesNotNullRow };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_impliesNotNullRow@
identifier F = { impliesNotNullRow };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_impliesNotNullRow@
identifier F = { impliesNotNullRow };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_impliesNotNullRow@
identifier F = { impliesNotNullRow };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_impliesNotNullRow@
identifier F = { impliesNotNullRow };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_impliesNotNullRow@
identifier F = { impliesNotNullRow };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_impliesNotNullRow@
identifier F = { impliesNotNullRow };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_impliesNotNullRow@
identifier F = { impliesNotNullRow };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_impliesNotNullRow@
identifier F = { impliesNotNullRow };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_impliesNotNullRow@
identifier F = { impliesNotNullRow };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_impliesNotNullRow@
identifier F = { impliesNotNullRow };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: incrAggDepth
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_incrAggDepth@
identifier F = { incrAggDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_incrAggDepth@
identifier F = { incrAggDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_incrAggDepth@
identifier F = { incrAggDepth };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_incrAggDepth@
identifier F = { incrAggDepth };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_incrAggDepth@
identifier F = { incrAggDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_incrAggDepth@
identifier F = { incrAggDepth };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_incrAggDepth@
identifier F = { incrAggDepth };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_incrAggDepth@
identifier F = { incrAggDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_incrAggDepth@
identifier F = { incrAggDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_incrAggDepth@
identifier F = { incrAggDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_incrAggDepth@
identifier F = { incrAggDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: markImmutableExprStep
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_markImmutableExprStep@
identifier F = { markImmutableExprStep };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_markImmutableExprStep@
identifier F = { markImmutableExprStep };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_markImmutableExprStep@
identifier F = { markImmutableExprStep };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_markImmutableExprStep@
identifier F = { markImmutableExprStep };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_markImmutableExprStep@
identifier F = { markImmutableExprStep };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_markImmutableExprStep@
identifier F = { markImmutableExprStep };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_markImmutableExprStep@
identifier F = { markImmutableExprStep };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_markImmutableExprStep@
identifier F = { markImmutableExprStep };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_markImmutableExprStep@
identifier F = { markImmutableExprStep };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_markImmutableExprStep@
identifier F = { markImmutableExprStep };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_markImmutableExprStep@
identifier F = { markImmutableExprStep };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexAccess
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexAccess@
identifier F = { multiplexAccess };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexAccess@
identifier F = { multiplexAccess };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexAccess@
identifier F = { multiplexAccess };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexAccess@
identifier F = { multiplexAccess };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexAccess@
identifier F = { multiplexAccess };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexAccess@
identifier F = { multiplexAccess };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexAccess@
identifier F = { multiplexAccess };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexAccess@
identifier F = { multiplexAccess };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexAccess@
identifier F = { multiplexAccess };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexAccess@
identifier F = { multiplexAccess };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexAccess@
identifier F = { multiplexAccess };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexCheckReservedLock
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexCheckReservedLock@
identifier F = { multiplexCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexCheckReservedLock@
identifier F = { multiplexCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexCheckReservedLock@
identifier F = { multiplexCheckReservedLock };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexCheckReservedLock@
identifier F = { multiplexCheckReservedLock };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexCheckReservedLock@
identifier F = { multiplexCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexCheckReservedLock@
identifier F = { multiplexCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexCheckReservedLock@
identifier F = { multiplexCheckReservedLock };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexCheckReservedLock@
identifier F = { multiplexCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexCheckReservedLock@
identifier F = { multiplexCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexCheckReservedLock@
identifier F = { multiplexCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexCheckReservedLock@
identifier F = { multiplexCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexClose
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexClose@
identifier F = { multiplexClose };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexClose@
identifier F = { multiplexClose };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexClose@
identifier F = { multiplexClose };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexClose@
identifier F = { multiplexClose };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexClose@
identifier F = { multiplexClose };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexClose@
identifier F = { multiplexClose };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexClose@
identifier F = { multiplexClose };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexClose@
identifier F = { multiplexClose };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexClose@
identifier F = { multiplexClose };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexClose@
identifier F = { multiplexClose };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexClose@
identifier F = { multiplexClose };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexCurrentTime
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexCurrentTime@
identifier F = { multiplexCurrentTime };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexCurrentTime@
identifier F = { multiplexCurrentTime };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexCurrentTime@
identifier F = { multiplexCurrentTime };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexCurrentTime@
identifier F = { multiplexCurrentTime };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexCurrentTime@
identifier F = { multiplexCurrentTime };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexCurrentTime@
identifier F = { multiplexCurrentTime };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexCurrentTime@
identifier F = { multiplexCurrentTime };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexCurrentTime@
identifier F = { multiplexCurrentTime };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexCurrentTime@
identifier F = { multiplexCurrentTime };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexCurrentTime@
identifier F = { multiplexCurrentTime };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexCurrentTime@
identifier F = { multiplexCurrentTime };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexCurrentTimeInt64
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexCurrentTimeInt64@
identifier F = { multiplexCurrentTimeInt64 };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexCurrentTimeInt64@
identifier F = { multiplexCurrentTimeInt64 };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexCurrentTimeInt64@
identifier F = { multiplexCurrentTimeInt64 };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexCurrentTimeInt64@
identifier F = { multiplexCurrentTimeInt64 };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexCurrentTimeInt64@
identifier F = { multiplexCurrentTimeInt64 };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexCurrentTimeInt64@
identifier F = { multiplexCurrentTimeInt64 };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexCurrentTimeInt64@
identifier F = { multiplexCurrentTimeInt64 };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexCurrentTimeInt64@
identifier F = { multiplexCurrentTimeInt64 };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexCurrentTimeInt64@
identifier F = { multiplexCurrentTimeInt64 };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexCurrentTimeInt64@
identifier F = { multiplexCurrentTimeInt64 };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexCurrentTimeInt64@
identifier F = { multiplexCurrentTimeInt64 };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexDeviceCharacteristics
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexDeviceCharacteristics@
identifier F = { multiplexDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexDeviceCharacteristics@
identifier F = { multiplexDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexDeviceCharacteristics@
identifier F = { multiplexDeviceCharacteristics };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexDeviceCharacteristics@
identifier F = { multiplexDeviceCharacteristics };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexDeviceCharacteristics@
identifier F = { multiplexDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexDeviceCharacteristics@
identifier F = { multiplexDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexDeviceCharacteristics@
identifier F = { multiplexDeviceCharacteristics };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexDeviceCharacteristics@
identifier F = { multiplexDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexDeviceCharacteristics@
identifier F = { multiplexDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexDeviceCharacteristics@
identifier F = { multiplexDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexDeviceCharacteristics@
identifier F = { multiplexDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexDlClose
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexDlClose@
identifier F = { multiplexDlClose };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexDlClose@
identifier F = { multiplexDlClose };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexDlClose@
identifier F = { multiplexDlClose };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexDlClose@
identifier F = { multiplexDlClose };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexDlClose@
identifier F = { multiplexDlClose };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexDlClose@
identifier F = { multiplexDlClose };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexDlClose@
identifier F = { multiplexDlClose };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexDlClose@
identifier F = { multiplexDlClose };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexDlClose@
identifier F = { multiplexDlClose };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexDlClose@
identifier F = { multiplexDlClose };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexDlClose@
identifier F = { multiplexDlClose };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexDlError
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexDlError@
identifier F = { multiplexDlError };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexDlError@
identifier F = { multiplexDlError };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexDlError@
identifier F = { multiplexDlError };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexDlError@
identifier F = { multiplexDlError };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexDlError@
identifier F = { multiplexDlError };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexDlError@
identifier F = { multiplexDlError };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexDlError@
identifier F = { multiplexDlError };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexDlError@
identifier F = { multiplexDlError };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexDlError@
identifier F = { multiplexDlError };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexDlError@
identifier F = { multiplexDlError };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexDlError@
identifier F = { multiplexDlError };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexFileControl
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexFileControl@
identifier F = { multiplexFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexFileControl@
identifier F = { multiplexFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexFileControl@
identifier F = { multiplexFileControl };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexFileControl@
identifier F = { multiplexFileControl };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexFileControl@
identifier F = { multiplexFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexFileControl@
identifier F = { multiplexFileControl };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexFileControl@
identifier F = { multiplexFileControl };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexFileControl@
identifier F = { multiplexFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexFileControl@
identifier F = { multiplexFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexFileControl@
identifier F = { multiplexFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexFileControl@
identifier F = { multiplexFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexFileSize
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexFileSize@
identifier F = { multiplexFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexFileSize@
identifier F = { multiplexFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexFileSize@
identifier F = { multiplexFileSize };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexFileSize@
identifier F = { multiplexFileSize };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexFileSize@
identifier F = { multiplexFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexFileSize@
identifier F = { multiplexFileSize };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexFileSize@
identifier F = { multiplexFileSize };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexFileSize@
identifier F = { multiplexFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexFileSize@
identifier F = { multiplexFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexFileSize@
identifier F = { multiplexFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexFileSize@
identifier F = { multiplexFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexFullPathname
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexFullPathname@
identifier F = { multiplexFullPathname };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexFullPathname@
identifier F = { multiplexFullPathname };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexFullPathname@
identifier F = { multiplexFullPathname };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexFullPathname@
identifier F = { multiplexFullPathname };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexFullPathname@
identifier F = { multiplexFullPathname };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexFullPathname@
identifier F = { multiplexFullPathname };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexFullPathname@
identifier F = { multiplexFullPathname };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexFullPathname@
identifier F = { multiplexFullPathname };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexFullPathname@
identifier F = { multiplexFullPathname };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexFullPathname@
identifier F = { multiplexFullPathname };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexFullPathname@
identifier F = { multiplexFullPathname };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexGetLastError
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexGetLastError@
identifier F = { multiplexGetLastError };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexGetLastError@
identifier F = { multiplexGetLastError };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexGetLastError@
identifier F = { multiplexGetLastError };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexGetLastError@
identifier F = { multiplexGetLastError };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexGetLastError@
identifier F = { multiplexGetLastError };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexGetLastError@
identifier F = { multiplexGetLastError };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexGetLastError@
identifier F = { multiplexGetLastError };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexGetLastError@
identifier F = { multiplexGetLastError };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexGetLastError@
identifier F = { multiplexGetLastError };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexGetLastError@
identifier F = { multiplexGetLastError };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexGetLastError@
identifier F = { multiplexGetLastError };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexLock
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexLock@
identifier F = { multiplexLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexLock@
identifier F = { multiplexLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexLock@
identifier F = { multiplexLock };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexLock@
identifier F = { multiplexLock };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexLock@
identifier F = { multiplexLock };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexLock@
identifier F = { multiplexLock };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexLock@
identifier F = { multiplexLock };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexLock@
identifier F = { multiplexLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexLock@
identifier F = { multiplexLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexLock@
identifier F = { multiplexLock };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexLock@
identifier F = { multiplexLock };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexOpen
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexOpen@
identifier F = { multiplexOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexOpen@
identifier F = { multiplexOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexOpen@
identifier F = { multiplexOpen };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexOpen@
identifier F = { multiplexOpen };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexOpen@
identifier F = { multiplexOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexOpen@
identifier F = { multiplexOpen };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexOpen@
identifier F = { multiplexOpen };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexOpen@
identifier F = { multiplexOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexOpen@
identifier F = { multiplexOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexOpen@
identifier F = { multiplexOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexOpen@
identifier F = { multiplexOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexRandomness
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexRandomness@
identifier F = { multiplexRandomness };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexRandomness@
identifier F = { multiplexRandomness };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexRandomness@
identifier F = { multiplexRandomness };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexRandomness@
identifier F = { multiplexRandomness };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexRandomness@
identifier F = { multiplexRandomness };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexRandomness@
identifier F = { multiplexRandomness };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexRandomness@
identifier F = { multiplexRandomness };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexRandomness@
identifier F = { multiplexRandomness };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexRandomness@
identifier F = { multiplexRandomness };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexRandomness@
identifier F = { multiplexRandomness };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexRandomness@
identifier F = { multiplexRandomness };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexRead
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexRead@
identifier F = { multiplexRead };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexRead@
identifier F = { multiplexRead };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexRead@
identifier F = { multiplexRead };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexRead@
identifier F = { multiplexRead };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexRead@
identifier F = { multiplexRead };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexRead@
identifier F = { multiplexRead };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexRead@
identifier F = { multiplexRead };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexRead@
identifier F = { multiplexRead };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexRead@
identifier F = { multiplexRead };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexRead@
identifier F = { multiplexRead };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexRead@
identifier F = { multiplexRead };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexSectorSize
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexSectorSize@
identifier F = { multiplexSectorSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexSectorSize@
identifier F = { multiplexSectorSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexSectorSize@
identifier F = { multiplexSectorSize };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexSectorSize@
identifier F = { multiplexSectorSize };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexSectorSize@
identifier F = { multiplexSectorSize };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexSectorSize@
identifier F = { multiplexSectorSize };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexSectorSize@
identifier F = { multiplexSectorSize };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexSectorSize@
identifier F = { multiplexSectorSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexSectorSize@
identifier F = { multiplexSectorSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexSectorSize@
identifier F = { multiplexSectorSize };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexSectorSize@
identifier F = { multiplexSectorSize };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexShmBarrier
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexShmBarrier@
identifier F = { multiplexShmBarrier };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexShmBarrier@
identifier F = { multiplexShmBarrier };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexShmBarrier@
identifier F = { multiplexShmBarrier };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexShmBarrier@
identifier F = { multiplexShmBarrier };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexShmBarrier@
identifier F = { multiplexShmBarrier };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexShmBarrier@
identifier F = { multiplexShmBarrier };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexShmBarrier@
identifier F = { multiplexShmBarrier };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexShmBarrier@
identifier F = { multiplexShmBarrier };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexShmBarrier@
identifier F = { multiplexShmBarrier };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexShmBarrier@
identifier F = { multiplexShmBarrier };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexShmBarrier@
identifier F = { multiplexShmBarrier };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexShmLock
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexShmLock@
identifier F = { multiplexShmLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexShmLock@
identifier F = { multiplexShmLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexShmLock@
identifier F = { multiplexShmLock };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexShmLock@
identifier F = { multiplexShmLock };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexShmLock@
identifier F = { multiplexShmLock };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexShmLock@
identifier F = { multiplexShmLock };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexShmLock@
identifier F = { multiplexShmLock };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexShmLock@
identifier F = { multiplexShmLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexShmLock@
identifier F = { multiplexShmLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexShmLock@
identifier F = { multiplexShmLock };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexShmLock@
identifier F = { multiplexShmLock };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexShmMap
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexShmMap@
identifier F = { multiplexShmMap };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexShmMap@
identifier F = { multiplexShmMap };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexShmMap@
identifier F = { multiplexShmMap };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexShmMap@
identifier F = { multiplexShmMap };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexShmMap@
identifier F = { multiplexShmMap };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexShmMap@
identifier F = { multiplexShmMap };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexShmMap@
identifier F = { multiplexShmMap };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexShmMap@
identifier F = { multiplexShmMap };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexShmMap@
identifier F = { multiplexShmMap };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexShmMap@
identifier F = { multiplexShmMap };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexShmMap@
identifier F = { multiplexShmMap };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexShmUnmap
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexShmUnmap@
identifier F = { multiplexShmUnmap };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexShmUnmap@
identifier F = { multiplexShmUnmap };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexShmUnmap@
identifier F = { multiplexShmUnmap };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexShmUnmap@
identifier F = { multiplexShmUnmap };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexShmUnmap@
identifier F = { multiplexShmUnmap };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexShmUnmap@
identifier F = { multiplexShmUnmap };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexShmUnmap@
identifier F = { multiplexShmUnmap };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexShmUnmap@
identifier F = { multiplexShmUnmap };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexShmUnmap@
identifier F = { multiplexShmUnmap };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexShmUnmap@
identifier F = { multiplexShmUnmap };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexShmUnmap@
identifier F = { multiplexShmUnmap };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexSleep
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexSleep@
identifier F = { multiplexSleep };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexSleep@
identifier F = { multiplexSleep };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexSleep@
identifier F = { multiplexSleep };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexSleep@
identifier F = { multiplexSleep };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexSleep@
identifier F = { multiplexSleep };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexSleep@
identifier F = { multiplexSleep };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexSleep@
identifier F = { multiplexSleep };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexSleep@
identifier F = { multiplexSleep };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexSleep@
identifier F = { multiplexSleep };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexSleep@
identifier F = { multiplexSleep };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexSleep@
identifier F = { multiplexSleep };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexSync
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexSync@
identifier F = { multiplexSync };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexSync@
identifier F = { multiplexSync };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexSync@
identifier F = { multiplexSync };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexSync@
identifier F = { multiplexSync };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexSync@
identifier F = { multiplexSync };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexSync@
identifier F = { multiplexSync };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexSync@
identifier F = { multiplexSync };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexSync@
identifier F = { multiplexSync };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexSync@
identifier F = { multiplexSync };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexSync@
identifier F = { multiplexSync };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexSync@
identifier F = { multiplexSync };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexTruncate
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexTruncate@
identifier F = { multiplexTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexTruncate@
identifier F = { multiplexTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexTruncate@
identifier F = { multiplexTruncate };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexTruncate@
identifier F = { multiplexTruncate };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexTruncate@
identifier F = { multiplexTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexTruncate@
identifier F = { multiplexTruncate };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexTruncate@
identifier F = { multiplexTruncate };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexTruncate@
identifier F = { multiplexTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexTruncate@
identifier F = { multiplexTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexTruncate@
identifier F = { multiplexTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexTruncate@
identifier F = { multiplexTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexUnlock
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexUnlock@
identifier F = { multiplexUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexUnlock@
identifier F = { multiplexUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexUnlock@
identifier F = { multiplexUnlock };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexUnlock@
identifier F = { multiplexUnlock };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexUnlock@
identifier F = { multiplexUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexUnlock@
identifier F = { multiplexUnlock };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexUnlock@
identifier F = { multiplexUnlock };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexUnlock@
identifier F = { multiplexUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexUnlock@
identifier F = { multiplexUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexUnlock@
identifier F = { multiplexUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexUnlock@
identifier F = { multiplexUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: multiplexWrite
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_multiplexWrite@
identifier F = { multiplexWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_multiplexWrite@
identifier F = { multiplexWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_multiplexWrite@
identifier F = { multiplexWrite };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_multiplexWrite@
identifier F = { multiplexWrite };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_multiplexWrite@
identifier F = { multiplexWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_multiplexWrite@
identifier F = { multiplexWrite };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_multiplexWrite@
identifier F = { multiplexWrite };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_multiplexWrite@
identifier F = { multiplexWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_multiplexWrite@
identifier F = { multiplexWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_multiplexWrite@
identifier F = { multiplexWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_multiplexWrite@
identifier F = { multiplexWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: propagateConstantExprRewrite
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_propagateConstantExprRewrite@
identifier F = { propagateConstantExprRewrite };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_propagateConstantExprRewrite@
identifier F = { propagateConstantExprRewrite };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_propagateConstantExprRewrite@
identifier F = { propagateConstantExprRewrite };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_propagateConstantExprRewrite@
identifier F = { propagateConstantExprRewrite };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_propagateConstantExprRewrite@
identifier F = { propagateConstantExprRewrite };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_propagateConstantExprRewrite@
identifier F = { propagateConstantExprRewrite };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_propagateConstantExprRewrite@
identifier F = { propagateConstantExprRewrite };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_propagateConstantExprRewrite@
identifier F = { propagateConstantExprRewrite };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_propagateConstantExprRewrite@
identifier F = { propagateConstantExprRewrite };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_propagateConstantExprRewrite@
identifier F = { propagateConstantExprRewrite };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_propagateConstantExprRewrite@
identifier F = { propagateConstantExprRewrite };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: quotaCheckReservedLock
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_quotaCheckReservedLock@
identifier F = { quotaCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_quotaCheckReservedLock@
identifier F = { quotaCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_quotaCheckReservedLock@
identifier F = { quotaCheckReservedLock };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_quotaCheckReservedLock@
identifier F = { quotaCheckReservedLock };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_quotaCheckReservedLock@
identifier F = { quotaCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_quotaCheckReservedLock@
identifier F = { quotaCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_quotaCheckReservedLock@
identifier F = { quotaCheckReservedLock };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_quotaCheckReservedLock@
identifier F = { quotaCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_quotaCheckReservedLock@
identifier F = { quotaCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_quotaCheckReservedLock@
identifier F = { quotaCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_quotaCheckReservedLock@
identifier F = { quotaCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: quotaClose
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_quotaClose@
identifier F = { quotaClose };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_quotaClose@
identifier F = { quotaClose };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_quotaClose@
identifier F = { quotaClose };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_quotaClose@
identifier F = { quotaClose };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_quotaClose@
identifier F = { quotaClose };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_quotaClose@
identifier F = { quotaClose };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_quotaClose@
identifier F = { quotaClose };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_quotaClose@
identifier F = { quotaClose };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_quotaClose@
identifier F = { quotaClose };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_quotaClose@
identifier F = { quotaClose };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_quotaClose@
identifier F = { quotaClose };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: quotaDeviceCharacteristics
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_quotaDeviceCharacteristics@
identifier F = { quotaDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_quotaDeviceCharacteristics@
identifier F = { quotaDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_quotaDeviceCharacteristics@
identifier F = { quotaDeviceCharacteristics };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_quotaDeviceCharacteristics@
identifier F = { quotaDeviceCharacteristics };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_quotaDeviceCharacteristics@
identifier F = { quotaDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_quotaDeviceCharacteristics@
identifier F = { quotaDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_quotaDeviceCharacteristics@
identifier F = { quotaDeviceCharacteristics };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_quotaDeviceCharacteristics@
identifier F = { quotaDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_quotaDeviceCharacteristics@
identifier F = { quotaDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_quotaDeviceCharacteristics@
identifier F = { quotaDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_quotaDeviceCharacteristics@
identifier F = { quotaDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: quotaFileControl
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_quotaFileControl@
identifier F = { quotaFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_quotaFileControl@
identifier F = { quotaFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_quotaFileControl@
identifier F = { quotaFileControl };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_quotaFileControl@
identifier F = { quotaFileControl };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_quotaFileControl@
identifier F = { quotaFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_quotaFileControl@
identifier F = { quotaFileControl };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_quotaFileControl@
identifier F = { quotaFileControl };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_quotaFileControl@
identifier F = { quotaFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_quotaFileControl@
identifier F = { quotaFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_quotaFileControl@
identifier F = { quotaFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_quotaFileControl@
identifier F = { quotaFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: quotaFileSize
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_quotaFileSize@
identifier F = { quotaFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_quotaFileSize@
identifier F = { quotaFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_quotaFileSize@
identifier F = { quotaFileSize };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_quotaFileSize@
identifier F = { quotaFileSize };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_quotaFileSize@
identifier F = { quotaFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_quotaFileSize@
identifier F = { quotaFileSize };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_quotaFileSize@
identifier F = { quotaFileSize };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_quotaFileSize@
identifier F = { quotaFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_quotaFileSize@
identifier F = { quotaFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_quotaFileSize@
identifier F = { quotaFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_quotaFileSize@
identifier F = { quotaFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: quotaLock
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_quotaLock@
identifier F = { quotaLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_quotaLock@
identifier F = { quotaLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_quotaLock@
identifier F = { quotaLock };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_quotaLock@
identifier F = { quotaLock };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_quotaLock@
identifier F = { quotaLock };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_quotaLock@
identifier F = { quotaLock };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_quotaLock@
identifier F = { quotaLock };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_quotaLock@
identifier F = { quotaLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_quotaLock@
identifier F = { quotaLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_quotaLock@
identifier F = { quotaLock };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_quotaLock@
identifier F = { quotaLock };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: quotaOpen
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_quotaOpen@
identifier F = { quotaOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_quotaOpen@
identifier F = { quotaOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_quotaOpen@
identifier F = { quotaOpen };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_quotaOpen@
identifier F = { quotaOpen };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_quotaOpen@
identifier F = { quotaOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_quotaOpen@
identifier F = { quotaOpen };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_quotaOpen@
identifier F = { quotaOpen };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_quotaOpen@
identifier F = { quotaOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_quotaOpen@
identifier F = { quotaOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_quotaOpen@
identifier F = { quotaOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_quotaOpen@
identifier F = { quotaOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: quotaRead
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_quotaRead@
identifier F = { quotaRead };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_quotaRead@
identifier F = { quotaRead };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_quotaRead@
identifier F = { quotaRead };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_quotaRead@
identifier F = { quotaRead };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_quotaRead@
identifier F = { quotaRead };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_quotaRead@
identifier F = { quotaRead };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_quotaRead@
identifier F = { quotaRead };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_quotaRead@
identifier F = { quotaRead };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_quotaRead@
identifier F = { quotaRead };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_quotaRead@
identifier F = { quotaRead };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_quotaRead@
identifier F = { quotaRead };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: quotaSectorSize
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_quotaSectorSize@
identifier F = { quotaSectorSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_quotaSectorSize@
identifier F = { quotaSectorSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_quotaSectorSize@
identifier F = { quotaSectorSize };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_quotaSectorSize@
identifier F = { quotaSectorSize };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_quotaSectorSize@
identifier F = { quotaSectorSize };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_quotaSectorSize@
identifier F = { quotaSectorSize };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_quotaSectorSize@
identifier F = { quotaSectorSize };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_quotaSectorSize@
identifier F = { quotaSectorSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_quotaSectorSize@
identifier F = { quotaSectorSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_quotaSectorSize@
identifier F = { quotaSectorSize };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_quotaSectorSize@
identifier F = { quotaSectorSize };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: quotaShmBarrier
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_quotaShmBarrier@
identifier F = { quotaShmBarrier };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_quotaShmBarrier@
identifier F = { quotaShmBarrier };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_quotaShmBarrier@
identifier F = { quotaShmBarrier };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_quotaShmBarrier@
identifier F = { quotaShmBarrier };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_quotaShmBarrier@
identifier F = { quotaShmBarrier };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_quotaShmBarrier@
identifier F = { quotaShmBarrier };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_quotaShmBarrier@
identifier F = { quotaShmBarrier };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_quotaShmBarrier@
identifier F = { quotaShmBarrier };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_quotaShmBarrier@
identifier F = { quotaShmBarrier };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_quotaShmBarrier@
identifier F = { quotaShmBarrier };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_quotaShmBarrier@
identifier F = { quotaShmBarrier };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: quotaShmLock
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_quotaShmLock@
identifier F = { quotaShmLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_quotaShmLock@
identifier F = { quotaShmLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_quotaShmLock@
identifier F = { quotaShmLock };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_quotaShmLock@
identifier F = { quotaShmLock };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_quotaShmLock@
identifier F = { quotaShmLock };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_quotaShmLock@
identifier F = { quotaShmLock };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_quotaShmLock@
identifier F = { quotaShmLock };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_quotaShmLock@
identifier F = { quotaShmLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_quotaShmLock@
identifier F = { quotaShmLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_quotaShmLock@
identifier F = { quotaShmLock };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_quotaShmLock@
identifier F = { quotaShmLock };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: quotaShmMap
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_quotaShmMap@
identifier F = { quotaShmMap };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_quotaShmMap@
identifier F = { quotaShmMap };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_quotaShmMap@
identifier F = { quotaShmMap };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_quotaShmMap@
identifier F = { quotaShmMap };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_quotaShmMap@
identifier F = { quotaShmMap };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_quotaShmMap@
identifier F = { quotaShmMap };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_quotaShmMap@
identifier F = { quotaShmMap };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_quotaShmMap@
identifier F = { quotaShmMap };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_quotaShmMap@
identifier F = { quotaShmMap };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_quotaShmMap@
identifier F = { quotaShmMap };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_quotaShmMap@
identifier F = { quotaShmMap };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: quotaShmUnmap
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_quotaShmUnmap@
identifier F = { quotaShmUnmap };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_quotaShmUnmap@
identifier F = { quotaShmUnmap };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_quotaShmUnmap@
identifier F = { quotaShmUnmap };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_quotaShmUnmap@
identifier F = { quotaShmUnmap };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_quotaShmUnmap@
identifier F = { quotaShmUnmap };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_quotaShmUnmap@
identifier F = { quotaShmUnmap };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_quotaShmUnmap@
identifier F = { quotaShmUnmap };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_quotaShmUnmap@
identifier F = { quotaShmUnmap };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_quotaShmUnmap@
identifier F = { quotaShmUnmap };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_quotaShmUnmap@
identifier F = { quotaShmUnmap };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_quotaShmUnmap@
identifier F = { quotaShmUnmap };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: quotaSync
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_quotaSync@
identifier F = { quotaSync };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_quotaSync@
identifier F = { quotaSync };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_quotaSync@
identifier F = { quotaSync };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_quotaSync@
identifier F = { quotaSync };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_quotaSync@
identifier F = { quotaSync };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_quotaSync@
identifier F = { quotaSync };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_quotaSync@
identifier F = { quotaSync };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_quotaSync@
identifier F = { quotaSync };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_quotaSync@
identifier F = { quotaSync };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_quotaSync@
identifier F = { quotaSync };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_quotaSync@
identifier F = { quotaSync };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: quotaTruncate
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_quotaTruncate@
identifier F = { quotaTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_quotaTruncate@
identifier F = { quotaTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_quotaTruncate@
identifier F = { quotaTruncate };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_quotaTruncate@
identifier F = { quotaTruncate };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_quotaTruncate@
identifier F = { quotaTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_quotaTruncate@
identifier F = { quotaTruncate };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_quotaTruncate@
identifier F = { quotaTruncate };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_quotaTruncate@
identifier F = { quotaTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_quotaTruncate@
identifier F = { quotaTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_quotaTruncate@
identifier F = { quotaTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_quotaTruncate@
identifier F = { quotaTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: quotaUnlock
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_quotaUnlock@
identifier F = { quotaUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_quotaUnlock@
identifier F = { quotaUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_quotaUnlock@
identifier F = { quotaUnlock };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_quotaUnlock@
identifier F = { quotaUnlock };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_quotaUnlock@
identifier F = { quotaUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_quotaUnlock@
identifier F = { quotaUnlock };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_quotaUnlock@
identifier F = { quotaUnlock };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_quotaUnlock@
identifier F = { quotaUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_quotaUnlock@
identifier F = { quotaUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_quotaUnlock@
identifier F = { quotaUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_quotaUnlock@
identifier F = { quotaUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: quotaWrite
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_quotaWrite@
identifier F = { quotaWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_quotaWrite@
identifier F = { quotaWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_quotaWrite@
identifier F = { quotaWrite };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_quotaWrite@
identifier F = { quotaWrite };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_quotaWrite@
identifier F = { quotaWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_quotaWrite@
identifier F = { quotaWrite };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_quotaWrite@
identifier F = { quotaWrite };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_quotaWrite@
identifier F = { quotaWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_quotaWrite@
identifier F = { quotaWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_quotaWrite@
identifier F = { quotaWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_quotaWrite@
identifier F = { quotaWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: recomputeColumnsUsedExpr
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_recomputeColumnsUsedExpr@
identifier F = { recomputeColumnsUsedExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_recomputeColumnsUsedExpr@
identifier F = { recomputeColumnsUsedExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_recomputeColumnsUsedExpr@
identifier F = { recomputeColumnsUsedExpr };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_recomputeColumnsUsedExpr@
identifier F = { recomputeColumnsUsedExpr };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_recomputeColumnsUsedExpr@
identifier F = { recomputeColumnsUsedExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_recomputeColumnsUsedExpr@
identifier F = { recomputeColumnsUsedExpr };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_recomputeColumnsUsedExpr@
identifier F = { recomputeColumnsUsedExpr };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_recomputeColumnsUsedExpr@
identifier F = { recomputeColumnsUsedExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_recomputeColumnsUsedExpr@
identifier F = { recomputeColumnsUsedExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_recomputeColumnsUsedExpr@
identifier F = { recomputeColumnsUsedExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_recomputeColumnsUsedExpr@
identifier F = { recomputeColumnsUsedExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: renameColumnExprCb
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_renameColumnExprCb@
identifier F = { renameColumnExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_renameColumnExprCb@
identifier F = { renameColumnExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_renameColumnExprCb@
identifier F = { renameColumnExprCb };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_renameColumnExprCb@
identifier F = { renameColumnExprCb };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_renameColumnExprCb@
identifier F = { renameColumnExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_renameColumnExprCb@
identifier F = { renameColumnExprCb };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_renameColumnExprCb@
identifier F = { renameColumnExprCb };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_renameColumnExprCb@
identifier F = { renameColumnExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_renameColumnExprCb@
identifier F = { renameColumnExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_renameColumnExprCb@
identifier F = { renameColumnExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_renameColumnExprCb@
identifier F = { renameColumnExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: renameColumnSelectCb
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_renameColumnSelectCb@
identifier F = { renameColumnSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_renameColumnSelectCb@
identifier F = { renameColumnSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_renameColumnSelectCb@
identifier F = { renameColumnSelectCb };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_renameColumnSelectCb@
identifier F = { renameColumnSelectCb };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_renameColumnSelectCb@
identifier F = { renameColumnSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_renameColumnSelectCb@
identifier F = { renameColumnSelectCb };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_renameColumnSelectCb@
identifier F = { renameColumnSelectCb };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_renameColumnSelectCb@
identifier F = { renameColumnSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_renameColumnSelectCb@
identifier F = { renameColumnSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_renameColumnSelectCb@
identifier F = { renameColumnSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_renameColumnSelectCb@
identifier F = { renameColumnSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: renameQuotefixExprCb
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_renameQuotefixExprCb@
identifier F = { renameQuotefixExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_renameQuotefixExprCb@
identifier F = { renameQuotefixExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_renameQuotefixExprCb@
identifier F = { renameQuotefixExprCb };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_renameQuotefixExprCb@
identifier F = { renameQuotefixExprCb };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_renameQuotefixExprCb@
identifier F = { renameQuotefixExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_renameQuotefixExprCb@
identifier F = { renameQuotefixExprCb };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_renameQuotefixExprCb@
identifier F = { renameQuotefixExprCb };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_renameQuotefixExprCb@
identifier F = { renameQuotefixExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_renameQuotefixExprCb@
identifier F = { renameQuotefixExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_renameQuotefixExprCb@
identifier F = { renameQuotefixExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_renameQuotefixExprCb@
identifier F = { renameQuotefixExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: renameTableExprCb
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_renameTableExprCb@
identifier F = { renameTableExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_renameTableExprCb@
identifier F = { renameTableExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_renameTableExprCb@
identifier F = { renameTableExprCb };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_renameTableExprCb@
identifier F = { renameTableExprCb };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_renameTableExprCb@
identifier F = { renameTableExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_renameTableExprCb@
identifier F = { renameTableExprCb };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_renameTableExprCb@
identifier F = { renameTableExprCb };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_renameTableExprCb@
identifier F = { renameTableExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_renameTableExprCb@
identifier F = { renameTableExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_renameTableExprCb@
identifier F = { renameTableExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_renameTableExprCb@
identifier F = { renameTableExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: renameTableSelectCb
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_renameTableSelectCb@
identifier F = { renameTableSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_renameTableSelectCb@
identifier F = { renameTableSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_renameTableSelectCb@
identifier F = { renameTableSelectCb };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_renameTableSelectCb@
identifier F = { renameTableSelectCb };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_renameTableSelectCb@
identifier F = { renameTableSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_renameTableSelectCb@
identifier F = { renameTableSelectCb };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_renameTableSelectCb@
identifier F = { renameTableSelectCb };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_renameTableSelectCb@
identifier F = { renameTableSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_renameTableSelectCb@
identifier F = { renameTableSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_renameTableSelectCb@
identifier F = { renameTableSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_renameTableSelectCb@
identifier F = { renameTableSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: renameUnmapExprCb
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_renameUnmapExprCb@
identifier F = { renameUnmapExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_renameUnmapExprCb@
identifier F = { renameUnmapExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_renameUnmapExprCb@
identifier F = { renameUnmapExprCb };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_renameUnmapExprCb@
identifier F = { renameUnmapExprCb };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_renameUnmapExprCb@
identifier F = { renameUnmapExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_renameUnmapExprCb@
identifier F = { renameUnmapExprCb };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_renameUnmapExprCb@
identifier F = { renameUnmapExprCb };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_renameUnmapExprCb@
identifier F = { renameUnmapExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_renameUnmapExprCb@
identifier F = { renameUnmapExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_renameUnmapExprCb@
identifier F = { renameUnmapExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_renameUnmapExprCb@
identifier F = { renameUnmapExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: renameUnmapSelectCb
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_renameUnmapSelectCb@
identifier F = { renameUnmapSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_renameUnmapSelectCb@
identifier F = { renameUnmapSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_renameUnmapSelectCb@
identifier F = { renameUnmapSelectCb };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_renameUnmapSelectCb@
identifier F = { renameUnmapSelectCb };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_renameUnmapSelectCb@
identifier F = { renameUnmapSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_renameUnmapSelectCb@
identifier F = { renameUnmapSelectCb };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_renameUnmapSelectCb@
identifier F = { renameUnmapSelectCb };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_renameUnmapSelectCb@
identifier F = { renameUnmapSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_renameUnmapSelectCb@
identifier F = { renameUnmapSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_renameUnmapSelectCb@
identifier F = { renameUnmapSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_renameUnmapSelectCb@
identifier F = { renameUnmapSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: renumberCursorsCb
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_renumberCursorsCb@
identifier F = { renumberCursorsCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_renumberCursorsCb@
identifier F = { renumberCursorsCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_renumberCursorsCb@
identifier F = { renumberCursorsCb };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_renumberCursorsCb@
identifier F = { renumberCursorsCb };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_renumberCursorsCb@
identifier F = { renumberCursorsCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_renumberCursorsCb@
identifier F = { renumberCursorsCb };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_renumberCursorsCb@
identifier F = { renumberCursorsCb };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_renumberCursorsCb@
identifier F = { renumberCursorsCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_renumberCursorsCb@
identifier F = { renumberCursorsCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_renumberCursorsCb@
identifier F = { renumberCursorsCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_renumberCursorsCb@
identifier F = { renumberCursorsCb };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: resolveExprStep
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_resolveExprStep@
identifier F = { resolveExprStep };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_resolveExprStep@
identifier F = { resolveExprStep };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_resolveExprStep@
identifier F = { resolveExprStep };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_resolveExprStep@
identifier F = { resolveExprStep };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_resolveExprStep@
identifier F = { resolveExprStep };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_resolveExprStep@
identifier F = { resolveExprStep };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_resolveExprStep@
identifier F = { resolveExprStep };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_resolveExprStep@
identifier F = { resolveExprStep };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_resolveExprStep@
identifier F = { resolveExprStep };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_resolveExprStep@
identifier F = { resolveExprStep };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_resolveExprStep@
identifier F = { resolveExprStep };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: resolveRemoveWindowsCb
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_resolveRemoveWindowsCb@
identifier F = { resolveRemoveWindowsCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_resolveRemoveWindowsCb@
identifier F = { resolveRemoveWindowsCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_resolveRemoveWindowsCb@
identifier F = { resolveRemoveWindowsCb };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_resolveRemoveWindowsCb@
identifier F = { resolveRemoveWindowsCb };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_resolveRemoveWindowsCb@
identifier F = { resolveRemoveWindowsCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_resolveRemoveWindowsCb@
identifier F = { resolveRemoveWindowsCb };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_resolveRemoveWindowsCb@
identifier F = { resolveRemoveWindowsCb };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_resolveRemoveWindowsCb@
identifier F = { resolveRemoveWindowsCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_resolveRemoveWindowsCb@
identifier F = { resolveRemoveWindowsCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_resolveRemoveWindowsCb@
identifier F = { resolveRemoveWindowsCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_resolveRemoveWindowsCb@
identifier F = { resolveRemoveWindowsCb };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: resolveSelectStep
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_resolveSelectStep@
identifier F = { resolveSelectStep };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_resolveSelectStep@
identifier F = { resolveSelectStep };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_resolveSelectStep@
identifier F = { resolveSelectStep };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_resolveSelectStep@
identifier F = { resolveSelectStep };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_resolveSelectStep@
identifier F = { resolveSelectStep };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_resolveSelectStep@
identifier F = { resolveSelectStep };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_resolveSelectStep@
identifier F = { resolveSelectStep };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_resolveSelectStep@
identifier F = { resolveSelectStep };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_resolveSelectStep@
identifier F = { resolveSelectStep };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_resolveSelectStep@
identifier F = { resolveSelectStep };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_resolveSelectStep@
identifier F = { resolveSelectStep };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: selectAddSubqueryTypeInfo
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_selectAddSubqueryTypeInfo@
identifier F = { selectAddSubqueryTypeInfo };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_selectAddSubqueryTypeInfo@
identifier F = { selectAddSubqueryTypeInfo };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_selectAddSubqueryTypeInfo@
identifier F = { selectAddSubqueryTypeInfo };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_selectAddSubqueryTypeInfo@
identifier F = { selectAddSubqueryTypeInfo };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_selectAddSubqueryTypeInfo@
identifier F = { selectAddSubqueryTypeInfo };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_selectAddSubqueryTypeInfo@
identifier F = { selectAddSubqueryTypeInfo };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_selectAddSubqueryTypeInfo@
identifier F = { selectAddSubqueryTypeInfo };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_selectAddSubqueryTypeInfo@
identifier F = { selectAddSubqueryTypeInfo };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_selectAddSubqueryTypeInfo@
identifier F = { selectAddSubqueryTypeInfo };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_selectAddSubqueryTypeInfo@
identifier F = { selectAddSubqueryTypeInfo };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_selectAddSubqueryTypeInfo@
identifier F = { selectAddSubqueryTypeInfo };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: selectCheckOnClausesExpr
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_selectCheckOnClausesExpr@
identifier F = { selectCheckOnClausesExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_selectCheckOnClausesExpr@
identifier F = { selectCheckOnClausesExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_selectCheckOnClausesExpr@
identifier F = { selectCheckOnClausesExpr };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_selectCheckOnClausesExpr@
identifier F = { selectCheckOnClausesExpr };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_selectCheckOnClausesExpr@
identifier F = { selectCheckOnClausesExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_selectCheckOnClausesExpr@
identifier F = { selectCheckOnClausesExpr };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_selectCheckOnClausesExpr@
identifier F = { selectCheckOnClausesExpr };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_selectCheckOnClausesExpr@
identifier F = { selectCheckOnClausesExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_selectCheckOnClausesExpr@
identifier F = { selectCheckOnClausesExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_selectCheckOnClausesExpr@
identifier F = { selectCheckOnClausesExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_selectCheckOnClausesExpr@
identifier F = { selectCheckOnClausesExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: selectCheckOnClausesSelect
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_selectCheckOnClausesSelect@
identifier F = { selectCheckOnClausesSelect };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_selectCheckOnClausesSelect@
identifier F = { selectCheckOnClausesSelect };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_selectCheckOnClausesSelect@
identifier F = { selectCheckOnClausesSelect };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_selectCheckOnClausesSelect@
identifier F = { selectCheckOnClausesSelect };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_selectCheckOnClausesSelect@
identifier F = { selectCheckOnClausesSelect };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_selectCheckOnClausesSelect@
identifier F = { selectCheckOnClausesSelect };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_selectCheckOnClausesSelect@
identifier F = { selectCheckOnClausesSelect };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_selectCheckOnClausesSelect@
identifier F = { selectCheckOnClausesSelect };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_selectCheckOnClausesSelect@
identifier F = { selectCheckOnClausesSelect };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_selectCheckOnClausesSelect@
identifier F = { selectCheckOnClausesSelect };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_selectCheckOnClausesSelect@
identifier F = { selectCheckOnClausesSelect };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: selectExpander
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_selectExpander@
identifier F = { selectExpander };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_selectExpander@
identifier F = { selectExpander };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_selectExpander@
identifier F = { selectExpander };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_selectExpander@
identifier F = { selectExpander };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_selectExpander@
identifier F = { selectExpander };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_selectExpander@
identifier F = { selectExpander };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_selectExpander@
identifier F = { selectExpander };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_selectExpander@
identifier F = { selectExpander };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_selectExpander@
identifier F = { selectExpander };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_selectExpander@
identifier F = { selectExpander };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_selectExpander@
identifier F = { selectExpander };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: selectRefEnter
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_selectRefEnter@
identifier F = { selectRefEnter };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_selectRefEnter@
identifier F = { selectRefEnter };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_selectRefEnter@
identifier F = { selectRefEnter };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_selectRefEnter@
identifier F = { selectRefEnter };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_selectRefEnter@
identifier F = { selectRefEnter };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_selectRefEnter@
identifier F = { selectRefEnter };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_selectRefEnter@
identifier F = { selectRefEnter };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_selectRefEnter@
identifier F = { selectRefEnter };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_selectRefEnter@
identifier F = { selectRefEnter };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_selectRefEnter@
identifier F = { selectRefEnter };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_selectRefEnter@
identifier F = { selectRefEnter };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: selectRefLeave
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_selectRefLeave@
identifier F = { selectRefLeave };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_selectRefLeave@
identifier F = { selectRefLeave };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_selectRefLeave@
identifier F = { selectRefLeave };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_selectRefLeave@
identifier F = { selectRefLeave };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_selectRefLeave@
identifier F = { selectRefLeave };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_selectRefLeave@
identifier F = { selectRefLeave };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_selectRefLeave@
identifier F = { selectRefLeave };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_selectRefLeave@
identifier F = { selectRefLeave };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_selectRefLeave@
identifier F = { selectRefLeave };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_selectRefLeave@
identifier F = { selectRefLeave };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_selectRefLeave@
identifier F = { selectRefLeave };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: selectWindowRewriteExprCb
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_selectWindowRewriteExprCb@
identifier F = { selectWindowRewriteExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_selectWindowRewriteExprCb@
identifier F = { selectWindowRewriteExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_selectWindowRewriteExprCb@
identifier F = { selectWindowRewriteExprCb };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_selectWindowRewriteExprCb@
identifier F = { selectWindowRewriteExprCb };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_selectWindowRewriteExprCb@
identifier F = { selectWindowRewriteExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_selectWindowRewriteExprCb@
identifier F = { selectWindowRewriteExprCb };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_selectWindowRewriteExprCb@
identifier F = { selectWindowRewriteExprCb };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_selectWindowRewriteExprCb@
identifier F = { selectWindowRewriteExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_selectWindowRewriteExprCb@
identifier F = { selectWindowRewriteExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_selectWindowRewriteExprCb@
identifier F = { selectWindowRewriteExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_selectWindowRewriteExprCb@
identifier F = { selectWindowRewriteExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: selectWindowRewriteSelectCb
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_selectWindowRewriteSelectCb@
identifier F = { selectWindowRewriteSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_selectWindowRewriteSelectCb@
identifier F = { selectWindowRewriteSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_selectWindowRewriteSelectCb@
identifier F = { selectWindowRewriteSelectCb };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_selectWindowRewriteSelectCb@
identifier F = { selectWindowRewriteSelectCb };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_selectWindowRewriteSelectCb@
identifier F = { selectWindowRewriteSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_selectWindowRewriteSelectCb@
identifier F = { selectWindowRewriteSelectCb };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_selectWindowRewriteSelectCb@
identifier F = { selectWindowRewriteSelectCb };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_selectWindowRewriteSelectCb@
identifier F = { selectWindowRewriteSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_selectWindowRewriteSelectCb@
identifier F = { selectWindowRewriteSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_selectWindowRewriteSelectCb@
identifier F = { selectWindowRewriteSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_selectWindowRewriteSelectCb@
identifier F = { selectWindowRewriteSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sessionDiffCount
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sessionDiffCount@
identifier F = { sessionDiffCount };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sessionDiffCount@
identifier F = { sessionDiffCount };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sessionDiffCount@
identifier F = { sessionDiffCount };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sessionDiffCount@
identifier F = { sessionDiffCount };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sessionDiffCount@
identifier F = { sessionDiffCount };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sessionDiffCount@
identifier F = { sessionDiffCount };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sessionDiffCount@
identifier F = { sessionDiffCount };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sessionDiffCount@
identifier F = { sessionDiffCount };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sessionDiffCount@
identifier F = { sessionDiffCount };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sessionDiffCount@
identifier F = { sessionDiffCount };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sessionDiffCount@
identifier F = { sessionDiffCount };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sessionDiffDepth
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sessionDiffDepth@
identifier F = { sessionDiffDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sessionDiffDepth@
identifier F = { sessionDiffDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sessionDiffDepth@
identifier F = { sessionDiffDepth };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sessionDiffDepth@
identifier F = { sessionDiffDepth };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sessionDiffDepth@
identifier F = { sessionDiffDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sessionDiffDepth@
identifier F = { sessionDiffDepth };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sessionDiffDepth@
identifier F = { sessionDiffDepth };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sessionDiffDepth@
identifier F = { sessionDiffDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sessionDiffDepth@
identifier F = { sessionDiffDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sessionDiffDepth@
identifier F = { sessionDiffDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sessionDiffDepth@
identifier F = { sessionDiffDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sessionDiffNew
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sessionDiffNew@
identifier F = { sessionDiffNew };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sessionDiffNew@
identifier F = { sessionDiffNew };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sessionDiffNew@
identifier F = { sessionDiffNew };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sessionDiffNew@
identifier F = { sessionDiffNew };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sessionDiffNew@
identifier F = { sessionDiffNew };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sessionDiffNew@
identifier F = { sessionDiffNew };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sessionDiffNew@
identifier F = { sessionDiffNew };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sessionDiffNew@
identifier F = { sessionDiffNew };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sessionDiffNew@
identifier F = { sessionDiffNew };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sessionDiffNew@
identifier F = { sessionDiffNew };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sessionDiffNew@
identifier F = { sessionDiffNew };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sessionDiffOld
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sessionDiffOld@
identifier F = { sessionDiffOld };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sessionDiffOld@
identifier F = { sessionDiffOld };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sessionDiffOld@
identifier F = { sessionDiffOld };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sessionDiffOld@
identifier F = { sessionDiffOld };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sessionDiffOld@
identifier F = { sessionDiffOld };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sessionDiffOld@
identifier F = { sessionDiffOld };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sessionDiffOld@
identifier F = { sessionDiffOld };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sessionDiffOld@
identifier F = { sessionDiffOld };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sessionDiffOld@
identifier F = { sessionDiffOld };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sessionDiffOld@
identifier F = { sessionDiffOld };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sessionDiffOld@
identifier F = { sessionDiffOld };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sessionPreupdateCount
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sessionPreupdateCount@
identifier F = { sessionPreupdateCount };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sessionPreupdateCount@
identifier F = { sessionPreupdateCount };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sessionPreupdateCount@
identifier F = { sessionPreupdateCount };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sessionPreupdateCount@
identifier F = { sessionPreupdateCount };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sessionPreupdateCount@
identifier F = { sessionPreupdateCount };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sessionPreupdateCount@
identifier F = { sessionPreupdateCount };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sessionPreupdateCount@
identifier F = { sessionPreupdateCount };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sessionPreupdateCount@
identifier F = { sessionPreupdateCount };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sessionPreupdateCount@
identifier F = { sessionPreupdateCount };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sessionPreupdateCount@
identifier F = { sessionPreupdateCount };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sessionPreupdateCount@
identifier F = { sessionPreupdateCount };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sessionPreupdateDepth
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sessionPreupdateDepth@
identifier F = { sessionPreupdateDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sessionPreupdateDepth@
identifier F = { sessionPreupdateDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sessionPreupdateDepth@
identifier F = { sessionPreupdateDepth };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sessionPreupdateDepth@
identifier F = { sessionPreupdateDepth };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sessionPreupdateDepth@
identifier F = { sessionPreupdateDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sessionPreupdateDepth@
identifier F = { sessionPreupdateDepth };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sessionPreupdateDepth@
identifier F = { sessionPreupdateDepth };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sessionPreupdateDepth@
identifier F = { sessionPreupdateDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sessionPreupdateDepth@
identifier F = { sessionPreupdateDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sessionPreupdateDepth@
identifier F = { sessionPreupdateDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sessionPreupdateDepth@
identifier F = { sessionPreupdateDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sessionPreupdateNew
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sessionPreupdateNew@
identifier F = { sessionPreupdateNew };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sessionPreupdateNew@
identifier F = { sessionPreupdateNew };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sessionPreupdateNew@
identifier F = { sessionPreupdateNew };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sessionPreupdateNew@
identifier F = { sessionPreupdateNew };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sessionPreupdateNew@
identifier F = { sessionPreupdateNew };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sessionPreupdateNew@
identifier F = { sessionPreupdateNew };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sessionPreupdateNew@
identifier F = { sessionPreupdateNew };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sessionPreupdateNew@
identifier F = { sessionPreupdateNew };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sessionPreupdateNew@
identifier F = { sessionPreupdateNew };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sessionPreupdateNew@
identifier F = { sessionPreupdateNew };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sessionPreupdateNew@
identifier F = { sessionPreupdateNew };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sessionPreupdateOld
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sessionPreupdateOld@
identifier F = { sessionPreupdateOld };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sessionPreupdateOld@
identifier F = { sessionPreupdateOld };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sessionPreupdateOld@
identifier F = { sessionPreupdateOld };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sessionPreupdateOld@
identifier F = { sessionPreupdateOld };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sessionPreupdateOld@
identifier F = { sessionPreupdateOld };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sessionPreupdateOld@
identifier F = { sessionPreupdateOld };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sessionPreupdateOld@
identifier F = { sessionPreupdateOld };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sessionPreupdateOld@
identifier F = { sessionPreupdateOld };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sessionPreupdateOld@
identifier F = { sessionPreupdateOld };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sessionPreupdateOld@
identifier F = { sessionPreupdateOld };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sessionPreupdateOld@
identifier F = { sessionPreupdateOld };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sessionStat1Count
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sessionStat1Count@
identifier F = { sessionStat1Count };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sessionStat1Count@
identifier F = { sessionStat1Count };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sessionStat1Count@
identifier F = { sessionStat1Count };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sessionStat1Count@
identifier F = { sessionStat1Count };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sessionStat1Count@
identifier F = { sessionStat1Count };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sessionStat1Count@
identifier F = { sessionStat1Count };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sessionStat1Count@
identifier F = { sessionStat1Count };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sessionStat1Count@
identifier F = { sessionStat1Count };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sessionStat1Count@
identifier F = { sessionStat1Count };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sessionStat1Count@
identifier F = { sessionStat1Count };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sessionStat1Count@
identifier F = { sessionStat1Count };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sessionStat1Depth
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sessionStat1Depth@
identifier F = { sessionStat1Depth };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sessionStat1Depth@
identifier F = { sessionStat1Depth };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sessionStat1Depth@
identifier F = { sessionStat1Depth };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sessionStat1Depth@
identifier F = { sessionStat1Depth };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sessionStat1Depth@
identifier F = { sessionStat1Depth };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sessionStat1Depth@
identifier F = { sessionStat1Depth };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sessionStat1Depth@
identifier F = { sessionStat1Depth };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sessionStat1Depth@
identifier F = { sessionStat1Depth };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sessionStat1Depth@
identifier F = { sessionStat1Depth };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sessionStat1Depth@
identifier F = { sessionStat1Depth };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sessionStat1Depth@
identifier F = { sessionStat1Depth };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sessionStat1New
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sessionStat1New@
identifier F = { sessionStat1New };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sessionStat1New@
identifier F = { sessionStat1New };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sessionStat1New@
identifier F = { sessionStat1New };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sessionStat1New@
identifier F = { sessionStat1New };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sessionStat1New@
identifier F = { sessionStat1New };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sessionStat1New@
identifier F = { sessionStat1New };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sessionStat1New@
identifier F = { sessionStat1New };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sessionStat1New@
identifier F = { sessionStat1New };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sessionStat1New@
identifier F = { sessionStat1New };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sessionStat1New@
identifier F = { sessionStat1New };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sessionStat1New@
identifier F = { sessionStat1New };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sessionStat1Old
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sessionStat1Old@
identifier F = { sessionStat1Old };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sessionStat1Old@
identifier F = { sessionStat1Old };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sessionStat1Old@
identifier F = { sessionStat1Old };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sessionStat1Old@
identifier F = { sessionStat1Old };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sessionStat1Old@
identifier F = { sessionStat1Old };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sessionStat1Old@
identifier F = { sessionStat1Old };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sessionStat1Old@
identifier F = { sessionStat1Old };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sessionStat1Old@
identifier F = { sessionStat1Old };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sessionStat1Old@
identifier F = { sessionStat1Old };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sessionStat1Old@
identifier F = { sessionStat1Old };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sessionStat1Old@
identifier F = { sessionStat1Old };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sqlite3CursorRangeHintExprCheck
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sqlite3CursorRangeHintExprCheck@
identifier F = { sqlite3CursorRangeHintExprCheck };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sqlite3CursorRangeHintExprCheck@
identifier F = { sqlite3CursorRangeHintExprCheck };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sqlite3CursorRangeHintExprCheck@
identifier F = { sqlite3CursorRangeHintExprCheck };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sqlite3CursorRangeHintExprCheck@
identifier F = { sqlite3CursorRangeHintExprCheck };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sqlite3CursorRangeHintExprCheck@
identifier F = { sqlite3CursorRangeHintExprCheck };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sqlite3CursorRangeHintExprCheck@
identifier F = { sqlite3CursorRangeHintExprCheck };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sqlite3CursorRangeHintExprCheck@
identifier F = { sqlite3CursorRangeHintExprCheck };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sqlite3CursorRangeHintExprCheck@
identifier F = { sqlite3CursorRangeHintExprCheck };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sqlite3CursorRangeHintExprCheck@
identifier F = { sqlite3CursorRangeHintExprCheck };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sqlite3CursorRangeHintExprCheck@
identifier F = { sqlite3CursorRangeHintExprCheck };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sqlite3CursorRangeHintExprCheck@
identifier F = { sqlite3CursorRangeHintExprCheck };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sqlite3ExprWalkNoop
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sqlite3ExprWalkNoop@
identifier F = { sqlite3ExprWalkNoop };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sqlite3ExprWalkNoop@
identifier F = { sqlite3ExprWalkNoop };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sqlite3ExprWalkNoop@
identifier F = { sqlite3ExprWalkNoop };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sqlite3ExprWalkNoop@
identifier F = { sqlite3ExprWalkNoop };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sqlite3ExprWalkNoop@
identifier F = { sqlite3ExprWalkNoop };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sqlite3ExprWalkNoop@
identifier F = { sqlite3ExprWalkNoop };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sqlite3ExprWalkNoop@
identifier F = { sqlite3ExprWalkNoop };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sqlite3ExprWalkNoop@
identifier F = { sqlite3ExprWalkNoop };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sqlite3ExprWalkNoop@
identifier F = { sqlite3ExprWalkNoop };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sqlite3ExprWalkNoop@
identifier F = { sqlite3ExprWalkNoop };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sqlite3ExprWalkNoop@
identifier F = { sqlite3ExprWalkNoop };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sqlite3ReturningSubqueryCorrelated
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sqlite3ReturningSubqueryCorrelated@
identifier F = { sqlite3ReturningSubqueryCorrelated };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sqlite3ReturningSubqueryCorrelated@
identifier F = { sqlite3ReturningSubqueryCorrelated };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sqlite3ReturningSubqueryCorrelated@
identifier F = { sqlite3ReturningSubqueryCorrelated };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sqlite3ReturningSubqueryCorrelated@
identifier F = { sqlite3ReturningSubqueryCorrelated };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sqlite3ReturningSubqueryCorrelated@
identifier F = { sqlite3ReturningSubqueryCorrelated };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sqlite3ReturningSubqueryCorrelated@
identifier F = { sqlite3ReturningSubqueryCorrelated };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sqlite3ReturningSubqueryCorrelated@
identifier F = { sqlite3ReturningSubqueryCorrelated };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sqlite3ReturningSubqueryCorrelated@
identifier F = { sqlite3ReturningSubqueryCorrelated };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sqlite3ReturningSubqueryCorrelated@
identifier F = { sqlite3ReturningSubqueryCorrelated };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sqlite3ReturningSubqueryCorrelated@
identifier F = { sqlite3ReturningSubqueryCorrelated };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sqlite3ReturningSubqueryCorrelated@
identifier F = { sqlite3ReturningSubqueryCorrelated };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sqlite3ReturningSubqueryVarSelect
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sqlite3ReturningSubqueryVarSelect@
identifier F = { sqlite3ReturningSubqueryVarSelect };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sqlite3ReturningSubqueryVarSelect@
identifier F = { sqlite3ReturningSubqueryVarSelect };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sqlite3ReturningSubqueryVarSelect@
identifier F = { sqlite3ReturningSubqueryVarSelect };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sqlite3ReturningSubqueryVarSelect@
identifier F = { sqlite3ReturningSubqueryVarSelect };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sqlite3ReturningSubqueryVarSelect@
identifier F = { sqlite3ReturningSubqueryVarSelect };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sqlite3ReturningSubqueryVarSelect@
identifier F = { sqlite3ReturningSubqueryVarSelect };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sqlite3ReturningSubqueryVarSelect@
identifier F = { sqlite3ReturningSubqueryVarSelect };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sqlite3ReturningSubqueryVarSelect@
identifier F = { sqlite3ReturningSubqueryVarSelect };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sqlite3ReturningSubqueryVarSelect@
identifier F = { sqlite3ReturningSubqueryVarSelect };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sqlite3ReturningSubqueryVarSelect@
identifier F = { sqlite3ReturningSubqueryVarSelect };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sqlite3ReturningSubqueryVarSelect@
identifier F = { sqlite3ReturningSubqueryVarSelect };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sqlite3SelectPopWith
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sqlite3SelectPopWith@
identifier F = { sqlite3SelectPopWith };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sqlite3SelectPopWith@
identifier F = { sqlite3SelectPopWith };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sqlite3SelectPopWith@
identifier F = { sqlite3SelectPopWith };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sqlite3SelectPopWith@
identifier F = { sqlite3SelectPopWith };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sqlite3SelectPopWith@
identifier F = { sqlite3SelectPopWith };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sqlite3SelectPopWith@
identifier F = { sqlite3SelectPopWith };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sqlite3SelectPopWith@
identifier F = { sqlite3SelectPopWith };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sqlite3SelectPopWith@
identifier F = { sqlite3SelectPopWith };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sqlite3SelectPopWith@
identifier F = { sqlite3SelectPopWith };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sqlite3SelectPopWith@
identifier F = { sqlite3SelectPopWith };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sqlite3SelectPopWith@
identifier F = { sqlite3SelectPopWith };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sqlite3SelectWalkAssert2
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sqlite3SelectWalkAssert2@
identifier F = { sqlite3SelectWalkAssert2 };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sqlite3SelectWalkAssert2@
identifier F = { sqlite3SelectWalkAssert2 };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sqlite3SelectWalkAssert2@
identifier F = { sqlite3SelectWalkAssert2 };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sqlite3SelectWalkAssert2@
identifier F = { sqlite3SelectWalkAssert2 };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sqlite3SelectWalkAssert2@
identifier F = { sqlite3SelectWalkAssert2 };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sqlite3SelectWalkAssert2@
identifier F = { sqlite3SelectWalkAssert2 };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sqlite3SelectWalkAssert2@
identifier F = { sqlite3SelectWalkAssert2 };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sqlite3SelectWalkAssert2@
identifier F = { sqlite3SelectWalkAssert2 };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sqlite3SelectWalkAssert2@
identifier F = { sqlite3SelectWalkAssert2 };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sqlite3SelectWalkAssert2@
identifier F = { sqlite3SelectWalkAssert2 };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sqlite3SelectWalkAssert2@
identifier F = { sqlite3SelectWalkAssert2 };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sqlite3SelectWalkFail
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sqlite3SelectWalkFail@
identifier F = { sqlite3SelectWalkFail };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sqlite3SelectWalkFail@
identifier F = { sqlite3SelectWalkFail };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sqlite3SelectWalkFail@
identifier F = { sqlite3SelectWalkFail };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sqlite3SelectWalkFail@
identifier F = { sqlite3SelectWalkFail };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sqlite3SelectWalkFail@
identifier F = { sqlite3SelectWalkFail };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sqlite3SelectWalkFail@
identifier F = { sqlite3SelectWalkFail };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sqlite3SelectWalkFail@
identifier F = { sqlite3SelectWalkFail };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sqlite3SelectWalkFail@
identifier F = { sqlite3SelectWalkFail };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sqlite3SelectWalkFail@
identifier F = { sqlite3SelectWalkFail };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sqlite3SelectWalkFail@
identifier F = { sqlite3SelectWalkFail };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sqlite3SelectWalkFail@
identifier F = { sqlite3SelectWalkFail };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sqlite3SelectWalkNoop
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sqlite3SelectWalkNoop@
identifier F = { sqlite3SelectWalkNoop };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sqlite3SelectWalkNoop@
identifier F = { sqlite3SelectWalkNoop };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sqlite3SelectWalkNoop@
identifier F = { sqlite3SelectWalkNoop };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sqlite3SelectWalkNoop@
identifier F = { sqlite3SelectWalkNoop };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sqlite3SelectWalkNoop@
identifier F = { sqlite3SelectWalkNoop };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sqlite3SelectWalkNoop@
identifier F = { sqlite3SelectWalkNoop };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sqlite3SelectWalkNoop@
identifier F = { sqlite3SelectWalkNoop };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sqlite3SelectWalkNoop@
identifier F = { sqlite3SelectWalkNoop };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sqlite3SelectWalkNoop@
identifier F = { sqlite3SelectWalkNoop };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sqlite3SelectWalkNoop@
identifier F = { sqlite3SelectWalkNoop };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sqlite3SelectWalkNoop@
identifier F = { sqlite3SelectWalkNoop };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sqlite3WalkWinDefnDummyCallback
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sqlite3WalkWinDefnDummyCallback@
identifier F = { sqlite3WalkWinDefnDummyCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sqlite3WalkWinDefnDummyCallback@
identifier F = { sqlite3WalkWinDefnDummyCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sqlite3WalkWinDefnDummyCallback@
identifier F = { sqlite3WalkWinDefnDummyCallback };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sqlite3WalkWinDefnDummyCallback@
identifier F = { sqlite3WalkWinDefnDummyCallback };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sqlite3WalkWinDefnDummyCallback@
identifier F = { sqlite3WalkWinDefnDummyCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sqlite3WalkWinDefnDummyCallback@
identifier F = { sqlite3WalkWinDefnDummyCallback };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sqlite3WalkWinDefnDummyCallback@
identifier F = { sqlite3WalkWinDefnDummyCallback };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sqlite3WalkWinDefnDummyCallback@
identifier F = { sqlite3WalkWinDefnDummyCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sqlite3WalkWinDefnDummyCallback@
identifier F = { sqlite3WalkWinDefnDummyCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sqlite3WalkWinDefnDummyCallback@
identifier F = { sqlite3WalkWinDefnDummyCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sqlite3WalkWinDefnDummyCallback@
identifier F = { sqlite3WalkWinDefnDummyCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sqlite3WalkerDepthDecrease
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sqlite3WalkerDepthDecrease@
identifier F = { sqlite3WalkerDepthDecrease };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sqlite3WalkerDepthDecrease@
identifier F = { sqlite3WalkerDepthDecrease };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sqlite3WalkerDepthDecrease@
identifier F = { sqlite3WalkerDepthDecrease };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sqlite3WalkerDepthDecrease@
identifier F = { sqlite3WalkerDepthDecrease };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sqlite3WalkerDepthDecrease@
identifier F = { sqlite3WalkerDepthDecrease };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sqlite3WalkerDepthDecrease@
identifier F = { sqlite3WalkerDepthDecrease };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sqlite3WalkerDepthDecrease@
identifier F = { sqlite3WalkerDepthDecrease };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sqlite3WalkerDepthDecrease@
identifier F = { sqlite3WalkerDepthDecrease };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sqlite3WalkerDepthDecrease@
identifier F = { sqlite3WalkerDepthDecrease };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sqlite3WalkerDepthDecrease@
identifier F = { sqlite3WalkerDepthDecrease };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sqlite3WalkerDepthDecrease@
identifier F = { sqlite3WalkerDepthDecrease };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sqlite3WalkerDepthIncrease
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sqlite3WalkerDepthIncrease@
identifier F = { sqlite3WalkerDepthIncrease };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sqlite3WalkerDepthIncrease@
identifier F = { sqlite3WalkerDepthIncrease };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sqlite3WalkerDepthIncrease@
identifier F = { sqlite3WalkerDepthIncrease };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sqlite3WalkerDepthIncrease@
identifier F = { sqlite3WalkerDepthIncrease };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sqlite3WalkerDepthIncrease@
identifier F = { sqlite3WalkerDepthIncrease };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sqlite3WalkerDepthIncrease@
identifier F = { sqlite3WalkerDepthIncrease };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sqlite3WalkerDepthIncrease@
identifier F = { sqlite3WalkerDepthIncrease };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sqlite3WalkerDepthIncrease@
identifier F = { sqlite3WalkerDepthIncrease };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sqlite3WalkerDepthIncrease@
identifier F = { sqlite3WalkerDepthIncrease };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sqlite3WalkerDepthIncrease@
identifier F = { sqlite3WalkerDepthIncrease };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sqlite3WalkerDepthIncrease@
identifier F = { sqlite3WalkerDepthIncrease };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: sqlite3WindowExtraAggFuncDepth
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_sqlite3WindowExtraAggFuncDepth@
identifier F = { sqlite3WindowExtraAggFuncDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_sqlite3WindowExtraAggFuncDepth@
identifier F = { sqlite3WindowExtraAggFuncDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_sqlite3WindowExtraAggFuncDepth@
identifier F = { sqlite3WindowExtraAggFuncDepth };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_sqlite3WindowExtraAggFuncDepth@
identifier F = { sqlite3WindowExtraAggFuncDepth };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_sqlite3WindowExtraAggFuncDepth@
identifier F = { sqlite3WindowExtraAggFuncDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_sqlite3WindowExtraAggFuncDepth@
identifier F = { sqlite3WindowExtraAggFuncDepth };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_sqlite3WindowExtraAggFuncDepth@
identifier F = { sqlite3WindowExtraAggFuncDepth };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_sqlite3WindowExtraAggFuncDepth@
identifier F = { sqlite3WindowExtraAggFuncDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_sqlite3WindowExtraAggFuncDepth@
identifier F = { sqlite3WindowExtraAggFuncDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_sqlite3WindowExtraAggFuncDepth@
identifier F = { sqlite3WindowExtraAggFuncDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_sqlite3WindowExtraAggFuncDepth@
identifier F = { sqlite3WindowExtraAggFuncDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: vfstraceAccess
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_vfstraceAccess@
identifier F = { vfstraceAccess };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_vfstraceAccess@
identifier F = { vfstraceAccess };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_vfstraceAccess@
identifier F = { vfstraceAccess };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_vfstraceAccess@
identifier F = { vfstraceAccess };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_vfstraceAccess@
identifier F = { vfstraceAccess };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_vfstraceAccess@
identifier F = { vfstraceAccess };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_vfstraceAccess@
identifier F = { vfstraceAccess };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_vfstraceAccess@
identifier F = { vfstraceAccess };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_vfstraceAccess@
identifier F = { vfstraceAccess };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_vfstraceAccess@
identifier F = { vfstraceAccess };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_vfstraceAccess@
identifier F = { vfstraceAccess };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: vfstraceCheckReservedLock
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_vfstraceCheckReservedLock@
identifier F = { vfstraceCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_vfstraceCheckReservedLock@
identifier F = { vfstraceCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_vfstraceCheckReservedLock@
identifier F = { vfstraceCheckReservedLock };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_vfstraceCheckReservedLock@
identifier F = { vfstraceCheckReservedLock };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_vfstraceCheckReservedLock@
identifier F = { vfstraceCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_vfstraceCheckReservedLock@
identifier F = { vfstraceCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_vfstraceCheckReservedLock@
identifier F = { vfstraceCheckReservedLock };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_vfstraceCheckReservedLock@
identifier F = { vfstraceCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_vfstraceCheckReservedLock@
identifier F = { vfstraceCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_vfstraceCheckReservedLock@
identifier F = { vfstraceCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_vfstraceCheckReservedLock@
identifier F = { vfstraceCheckReservedLock };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: vfstraceClose
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_vfstraceClose@
identifier F = { vfstraceClose };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_vfstraceClose@
identifier F = { vfstraceClose };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_vfstraceClose@
identifier F = { vfstraceClose };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_vfstraceClose@
identifier F = { vfstraceClose };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_vfstraceClose@
identifier F = { vfstraceClose };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_vfstraceClose@
identifier F = { vfstraceClose };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_vfstraceClose@
identifier F = { vfstraceClose };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_vfstraceClose@
identifier F = { vfstraceClose };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_vfstraceClose@
identifier F = { vfstraceClose };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_vfstraceClose@
identifier F = { vfstraceClose };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_vfstraceClose@
identifier F = { vfstraceClose };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: vfstraceCurrentTime
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_vfstraceCurrentTime@
identifier F = { vfstraceCurrentTime };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_vfstraceCurrentTime@
identifier F = { vfstraceCurrentTime };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_vfstraceCurrentTime@
identifier F = { vfstraceCurrentTime };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_vfstraceCurrentTime@
identifier F = { vfstraceCurrentTime };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_vfstraceCurrentTime@
identifier F = { vfstraceCurrentTime };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_vfstraceCurrentTime@
identifier F = { vfstraceCurrentTime };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_vfstraceCurrentTime@
identifier F = { vfstraceCurrentTime };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_vfstraceCurrentTime@
identifier F = { vfstraceCurrentTime };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_vfstraceCurrentTime@
identifier F = { vfstraceCurrentTime };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_vfstraceCurrentTime@
identifier F = { vfstraceCurrentTime };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_vfstraceCurrentTime@
identifier F = { vfstraceCurrentTime };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: vfstraceDeviceCharacteristics
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_vfstraceDeviceCharacteristics@
identifier F = { vfstraceDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_vfstraceDeviceCharacteristics@
identifier F = { vfstraceDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_vfstraceDeviceCharacteristics@
identifier F = { vfstraceDeviceCharacteristics };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_vfstraceDeviceCharacteristics@
identifier F = { vfstraceDeviceCharacteristics };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_vfstraceDeviceCharacteristics@
identifier F = { vfstraceDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_vfstraceDeviceCharacteristics@
identifier F = { vfstraceDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_vfstraceDeviceCharacteristics@
identifier F = { vfstraceDeviceCharacteristics };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_vfstraceDeviceCharacteristics@
identifier F = { vfstraceDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_vfstraceDeviceCharacteristics@
identifier F = { vfstraceDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_vfstraceDeviceCharacteristics@
identifier F = { vfstraceDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_vfstraceDeviceCharacteristics@
identifier F = { vfstraceDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: vfstraceFileControl
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_vfstraceFileControl@
identifier F = { vfstraceFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_vfstraceFileControl@
identifier F = { vfstraceFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_vfstraceFileControl@
identifier F = { vfstraceFileControl };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_vfstraceFileControl@
identifier F = { vfstraceFileControl };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_vfstraceFileControl@
identifier F = { vfstraceFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_vfstraceFileControl@
identifier F = { vfstraceFileControl };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_vfstraceFileControl@
identifier F = { vfstraceFileControl };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_vfstraceFileControl@
identifier F = { vfstraceFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_vfstraceFileControl@
identifier F = { vfstraceFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_vfstraceFileControl@
identifier F = { vfstraceFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_vfstraceFileControl@
identifier F = { vfstraceFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: vfstraceFileSize
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_vfstraceFileSize@
identifier F = { vfstraceFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_vfstraceFileSize@
identifier F = { vfstraceFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_vfstraceFileSize@
identifier F = { vfstraceFileSize };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_vfstraceFileSize@
identifier F = { vfstraceFileSize };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_vfstraceFileSize@
identifier F = { vfstraceFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_vfstraceFileSize@
identifier F = { vfstraceFileSize };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_vfstraceFileSize@
identifier F = { vfstraceFileSize };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_vfstraceFileSize@
identifier F = { vfstraceFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_vfstraceFileSize@
identifier F = { vfstraceFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_vfstraceFileSize@
identifier F = { vfstraceFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_vfstraceFileSize@
identifier F = { vfstraceFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: vfstraceFullPathname
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_vfstraceFullPathname@
identifier F = { vfstraceFullPathname };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_vfstraceFullPathname@
identifier F = { vfstraceFullPathname };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_vfstraceFullPathname@
identifier F = { vfstraceFullPathname };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_vfstraceFullPathname@
identifier F = { vfstraceFullPathname };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_vfstraceFullPathname@
identifier F = { vfstraceFullPathname };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_vfstraceFullPathname@
identifier F = { vfstraceFullPathname };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_vfstraceFullPathname@
identifier F = { vfstraceFullPathname };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_vfstraceFullPathname@
identifier F = { vfstraceFullPathname };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_vfstraceFullPathname@
identifier F = { vfstraceFullPathname };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_vfstraceFullPathname@
identifier F = { vfstraceFullPathname };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_vfstraceFullPathname@
identifier F = { vfstraceFullPathname };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: vfstraceLock
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_vfstraceLock@
identifier F = { vfstraceLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_vfstraceLock@
identifier F = { vfstraceLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_vfstraceLock@
identifier F = { vfstraceLock };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_vfstraceLock@
identifier F = { vfstraceLock };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_vfstraceLock@
identifier F = { vfstraceLock };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_vfstraceLock@
identifier F = { vfstraceLock };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_vfstraceLock@
identifier F = { vfstraceLock };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_vfstraceLock@
identifier F = { vfstraceLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_vfstraceLock@
identifier F = { vfstraceLock };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_vfstraceLock@
identifier F = { vfstraceLock };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_vfstraceLock@
identifier F = { vfstraceLock };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: vfstraceOpen
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_vfstraceOpen@
identifier F = { vfstraceOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_vfstraceOpen@
identifier F = { vfstraceOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_vfstraceOpen@
identifier F = { vfstraceOpen };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_vfstraceOpen@
identifier F = { vfstraceOpen };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_vfstraceOpen@
identifier F = { vfstraceOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_vfstraceOpen@
identifier F = { vfstraceOpen };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_vfstraceOpen@
identifier F = { vfstraceOpen };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_vfstraceOpen@
identifier F = { vfstraceOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_vfstraceOpen@
identifier F = { vfstraceOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_vfstraceOpen@
identifier F = { vfstraceOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_vfstraceOpen@
identifier F = { vfstraceOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: vfstraceRandomness
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_vfstraceRandomness@
identifier F = { vfstraceRandomness };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_vfstraceRandomness@
identifier F = { vfstraceRandomness };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_vfstraceRandomness@
identifier F = { vfstraceRandomness };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_vfstraceRandomness@
identifier F = { vfstraceRandomness };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_vfstraceRandomness@
identifier F = { vfstraceRandomness };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_vfstraceRandomness@
identifier F = { vfstraceRandomness };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_vfstraceRandomness@
identifier F = { vfstraceRandomness };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_vfstraceRandomness@
identifier F = { vfstraceRandomness };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_vfstraceRandomness@
identifier F = { vfstraceRandomness };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_vfstraceRandomness@
identifier F = { vfstraceRandomness };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_vfstraceRandomness@
identifier F = { vfstraceRandomness };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: vfstraceRead
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_vfstraceRead@
identifier F = { vfstraceRead };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_vfstraceRead@
identifier F = { vfstraceRead };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_vfstraceRead@
identifier F = { vfstraceRead };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_vfstraceRead@
identifier F = { vfstraceRead };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_vfstraceRead@
identifier F = { vfstraceRead };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_vfstraceRead@
identifier F = { vfstraceRead };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_vfstraceRead@
identifier F = { vfstraceRead };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_vfstraceRead@
identifier F = { vfstraceRead };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_vfstraceRead@
identifier F = { vfstraceRead };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_vfstraceRead@
identifier F = { vfstraceRead };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_vfstraceRead@
identifier F = { vfstraceRead };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: vfstraceSectorSize
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_vfstraceSectorSize@
identifier F = { vfstraceSectorSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_vfstraceSectorSize@
identifier F = { vfstraceSectorSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_vfstraceSectorSize@
identifier F = { vfstraceSectorSize };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_vfstraceSectorSize@
identifier F = { vfstraceSectorSize };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_vfstraceSectorSize@
identifier F = { vfstraceSectorSize };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_vfstraceSectorSize@
identifier F = { vfstraceSectorSize };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_vfstraceSectorSize@
identifier F = { vfstraceSectorSize };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_vfstraceSectorSize@
identifier F = { vfstraceSectorSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_vfstraceSectorSize@
identifier F = { vfstraceSectorSize };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_vfstraceSectorSize@
identifier F = { vfstraceSectorSize };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_vfstraceSectorSize@
identifier F = { vfstraceSectorSize };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: vfstraceSleep
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_vfstraceSleep@
identifier F = { vfstraceSleep };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_vfstraceSleep@
identifier F = { vfstraceSleep };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_vfstraceSleep@
identifier F = { vfstraceSleep };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_vfstraceSleep@
identifier F = { vfstraceSleep };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_vfstraceSleep@
identifier F = { vfstraceSleep };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_vfstraceSleep@
identifier F = { vfstraceSleep };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_vfstraceSleep@
identifier F = { vfstraceSleep };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_vfstraceSleep@
identifier F = { vfstraceSleep };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_vfstraceSleep@
identifier F = { vfstraceSleep };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_vfstraceSleep@
identifier F = { vfstraceSleep };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_vfstraceSleep@
identifier F = { vfstraceSleep };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: vfstraceSync
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_vfstraceSync@
identifier F = { vfstraceSync };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_vfstraceSync@
identifier F = { vfstraceSync };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_vfstraceSync@
identifier F = { vfstraceSync };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_vfstraceSync@
identifier F = { vfstraceSync };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_vfstraceSync@
identifier F = { vfstraceSync };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_vfstraceSync@
identifier F = { vfstraceSync };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_vfstraceSync@
identifier F = { vfstraceSync };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_vfstraceSync@
identifier F = { vfstraceSync };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_vfstraceSync@
identifier F = { vfstraceSync };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_vfstraceSync@
identifier F = { vfstraceSync };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_vfstraceSync@
identifier F = { vfstraceSync };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: vfstraceTruncate
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_vfstraceTruncate@
identifier F = { vfstraceTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_vfstraceTruncate@
identifier F = { vfstraceTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_vfstraceTruncate@
identifier F = { vfstraceTruncate };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_vfstraceTruncate@
identifier F = { vfstraceTruncate };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_vfstraceTruncate@
identifier F = { vfstraceTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_vfstraceTruncate@
identifier F = { vfstraceTruncate };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_vfstraceTruncate@
identifier F = { vfstraceTruncate };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_vfstraceTruncate@
identifier F = { vfstraceTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_vfstraceTruncate@
identifier F = { vfstraceTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_vfstraceTruncate@
identifier F = { vfstraceTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_vfstraceTruncate@
identifier F = { vfstraceTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: vfstraceUnlock
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_vfstraceUnlock@
identifier F = { vfstraceUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_vfstraceUnlock@
identifier F = { vfstraceUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_vfstraceUnlock@
identifier F = { vfstraceUnlock };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_vfstraceUnlock@
identifier F = { vfstraceUnlock };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_vfstraceUnlock@
identifier F = { vfstraceUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_vfstraceUnlock@
identifier F = { vfstraceUnlock };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_vfstraceUnlock@
identifier F = { vfstraceUnlock };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_vfstraceUnlock@
identifier F = { vfstraceUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_vfstraceUnlock@
identifier F = { vfstraceUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_vfstraceUnlock@
identifier F = { vfstraceUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_vfstraceUnlock@
identifier F = { vfstraceUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: vfstraceWrite
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_vfstraceWrite@
identifier F = { vfstraceWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_vfstraceWrite@
identifier F = { vfstraceWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_vfstraceWrite@
identifier F = { vfstraceWrite };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_vfstraceWrite@
identifier F = { vfstraceWrite };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_vfstraceWrite@
identifier F = { vfstraceWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_vfstraceWrite@
identifier F = { vfstraceWrite };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_vfstraceWrite@
identifier F = { vfstraceWrite };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_vfstraceWrite@
identifier F = { vfstraceWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_vfstraceWrite@
identifier F = { vfstraceWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_vfstraceWrite@
identifier F = { vfstraceWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_vfstraceWrite@
identifier F = { vfstraceWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: whereIsCoveringIndexWalkCallback
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_whereIsCoveringIndexWalkCallback@
identifier F = { whereIsCoveringIndexWalkCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_whereIsCoveringIndexWalkCallback@
identifier F = { whereIsCoveringIndexWalkCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_whereIsCoveringIndexWalkCallback@
identifier F = { whereIsCoveringIndexWalkCallback };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_whereIsCoveringIndexWalkCallback@
identifier F = { whereIsCoveringIndexWalkCallback };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_whereIsCoveringIndexWalkCallback@
identifier F = { whereIsCoveringIndexWalkCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_whereIsCoveringIndexWalkCallback@
identifier F = { whereIsCoveringIndexWalkCallback };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_whereIsCoveringIndexWalkCallback@
identifier F = { whereIsCoveringIndexWalkCallback };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_whereIsCoveringIndexWalkCallback@
identifier F = { whereIsCoveringIndexWalkCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_whereIsCoveringIndexWalkCallback@
identifier F = { whereIsCoveringIndexWalkCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_whereIsCoveringIndexWalkCallback@
identifier F = { whereIsCoveringIndexWalkCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_whereIsCoveringIndexWalkCallback@
identifier F = { whereIsCoveringIndexWalkCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: xBusy
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_xBusy@
identifier F = { xBusy };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_xBusy@
identifier F = { xBusy };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_xBusy@
identifier F = { xBusy };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_xBusy@
identifier F = { xBusy };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_xBusy@
identifier F = { xBusy };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_xBusy@
identifier F = { xBusy };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_xBusy@
identifier F = { xBusy };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_xBusy@
identifier F = { xBusy };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_xBusy@
identifier F = { xBusy };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_xBusy@
identifier F = { xBusy };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_xBusy@
identifier F = { xBusy };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }

// ============================================================================
// Rules for function: xFree
// ============================================================================

// Rule 1: Basic static function definition with braces on same line
@remove_static_def_same_line_xFree@
identifier F = { xFree };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P) { BODY }

// Rule 2: Static function definition with braces on next line
@remove_static_def_next_line_xFree@
identifier F = { xFree };
type T;
parameter list P;
statement list BODY;
@@
- static
T F(P)
{ BODY }

// Rule 3: Static function without explicit return type (old C style)
@remove_static_def_no_type_xFree@
identifier F = { xFree };
parameter list P;
statement list BODY;
@@
- static
F(P) { BODY }

// Rule 4: Static function declaration (prototype)
@remove_static_decl_prototype_xFree@
identifier F = { xFree };
type T;
parameter list P;
@@
- static
T F(P);

// Rule 5: Static inline function definition
@remove_static_inline_def_xFree@
identifier F = { xFree };
type T;
parameter list P;
statement list BODY;
@@
- static
inline T F(P) { BODY }

// Rule 6: Inline static function definition (different order)
@remove_inline_static_def_xFree@
identifier F = { xFree };
type T;
parameter list P;
statement list BODY;
@@
inline
- static
T F(P) { BODY }

// Rule 7: Static inline function declaration
@remove_static_inline_decl_xFree@
identifier F = { xFree };
type T;
parameter list P;
@@
- static
inline T F(P);

// Rule 11: Complex return type with pointers
@remove_static_ptr_ret_xFree@
identifier F = { xFree };
type T;
parameter list P;
statement list BODY;
@@
- static
T* F(P) { BODY }

// Rule 12: Complex return type with multiple pointers
@remove_static_multi_ptr_xFree@
identifier F = { xFree };
type T;
parameter list P;
statement list BODY;
@@
- static
T** F(P) { BODY }

// Rule 13: Static function with multiple modifiers
@remove_static_multi_mod_xFree@
identifier F = { xFree };
type T;
parameter list P;
statement list BODY;
@@
- static
inline const T F(P) { BODY }

// Rule 14: Static const function
@remove_static_const_xFree@
identifier F = { xFree };
type T;
parameter list P;
statement list BODY;
@@
- static
const T F(P) { BODY }
