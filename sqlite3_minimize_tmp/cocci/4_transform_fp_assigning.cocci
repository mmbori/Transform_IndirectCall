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

// Rules for xRead (2 functions)
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

// Rules for xWrite (2 functions)
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

// Total transformation rules generated: 76

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

