// ===== RETURN FUNCTION POINTER TRANSFORMATION RULES =====

// Transform return E->xCellSize(args) to if-chain with 4 candidates
@transform_return_xCellSize_arrow@
expression E;
identifier FP_NAME = xCellSize;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xCellSize_signature, xCellSize_signatures[xCellSize_(0, 'cellSizePtr')_enum], sizeof(E->xCellSize_signature)) == 0) {
+ return (0, 'cellSizePtr')(args);
+ }
+ if (memcmp(E->xCellSize_signature, xCellSize_signatures[xCellSize_(1, 'cellSizePtrIdxLeaf')_enum], sizeof(E->xCellSize_signature)) == 0) {
+ return (1, 'cellSizePtrIdxLeaf')(args);
+ }
+ if (memcmp(E->xCellSize_signature, xCellSize_signatures[xCellSize_(2, 'cellSizePtrNoPayload')_enum], sizeof(E->xCellSize_signature)) == 0) {
+ return (2, 'cellSizePtrNoPayload')(args);
+ }
+ if (memcmp(E->xCellSize_signature, xCellSize_signatures[xCellSize_(3, 'cellSizePtrTableLeaf')_enum], sizeof(E->xCellSize_signature)) == 0) {
+ return (3, 'cellSizePtrTableLeaf')(args);
+ }


// Transform return E->xExprCallback(args) to if-chain with 37 candidates
@transform_return_xExprCallback_arrow@
expression E;
identifier FP_NAME = xExprCallback;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(0, 'agginfoPersistExprCb')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (0, 'agginfoPersistExprCb')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(1, 'aggregateIdxEprRefToColCallback')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (1, 'aggregateIdxEprRefToColCallback')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(2, 'analyzeAggregate')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (2, 'analyzeAggregate')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(3, 'checkConstraintExprNode')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (3, 'checkConstraintExprNode')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(4, 'codeCursorHintCheckExpr')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (4, 'codeCursorHintCheckExpr')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(5, 'codeCursorHintFixExpr')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (5, 'codeCursorHintFixExpr')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(6, 'codeCursorHintIsOrFunction')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (6, 'codeCursorHintIsOrFunction')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(7, 'disallowAggregatesInOrderByCb')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (7, 'disallowAggregatesInOrderByCb')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(8, 'exprColumnFlagUnion')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (8, 'exprColumnFlagUnion')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(9, 'exprIdxCover')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (9, 'exprIdxCover')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(10, 'exprNodeCanReturnSubtype')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (10, 'exprNodeCanReturnSubtype')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(11, 'exprNodeIsConstant')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (11, 'exprNodeIsConstant')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(12, 'exprNodeIsConstantOrGroupBy')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (12, 'exprNodeIsConstantOrGroupBy')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(13, 'exprNodeIsDeterministic')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (13, 'exprNodeIsDeterministic')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(14, 'exprRefToSrcList')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (14, 'exprRefToSrcList')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(15, 'fixExprCb')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (15, 'fixExprCb')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(16, 'gatherSelectWindowsCallback')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (16, 'gatherSelectWindowsCallback')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(17, 'havingToWhereExprCb')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (17, 'havingToWhereExprCb')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(18, 'impliesNotNullRow')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (18, 'impliesNotNullRow')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(19, 'incrAggDepth')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (19, 'incrAggDepth')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(20, 'markImmutableExprStep')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (20, 'markImmutableExprStep')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(21, 'propagateConstantExprRewrite')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (21, 'propagateConstantExprRewrite')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(22, 'recomputeColumnsUsedExpr')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (22, 'recomputeColumnsUsedExpr')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(23, 'renameColumnExprCb')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (23, 'renameColumnExprCb')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(24, 'renameQuotefixExprCb')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (24, 'renameQuotefixExprCb')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(25, 'renameTableExprCb')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (25, 'renameTableExprCb')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(26, 'renameUnmapExprCb')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (26, 'renameUnmapExprCb')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(27, 'renumberCursorsCb')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (27, 'renumberCursorsCb')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(28, 'resolveExprStep')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (28, 'resolveExprStep')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(29, 'resolveRemoveWindowsCb')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (29, 'resolveRemoveWindowsCb')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(30, 'selectCheckOnClausesExpr')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (30, 'selectCheckOnClausesExpr')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(31, 'selectWindowRewriteExprCb')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (31, 'selectWindowRewriteExprCb')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(32, 'sqlite3CursorRangeHintExprCheck')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (32, 'sqlite3CursorRangeHintExprCheck')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(33, 'sqlite3ExprWalkNoop')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (33, 'sqlite3ExprWalkNoop')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(34, 'sqlite3ReturningSubqueryVarSelect')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (34, 'sqlite3ReturningSubqueryVarSelect')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(35, 'sqlite3WindowExtraAggFuncDepth')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (35, 'sqlite3WindowExtraAggFuncDepth')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_(36, 'whereIsCoveringIndexWalkCallback')_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (36, 'whereIsCoveringIndexWalkCallback')(args);
+ }


// Transform return E->xGet(args) to if-chain with 3 candidates
@transform_return_xGet_arrow@
expression E;
identifier FP_NAME = xGet;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xGet_signature, xGet_signatures[xGet_(0, 'getPageError')_enum], sizeof(E->xGet_signature)) == 0) {
+ return (0, 'getPageError')(args);
+ }
+ if (memcmp(E->xGet_signature, xGet_signatures[xGet_(1, 'getPageMMap')_enum], sizeof(E->xGet_signature)) == 0) {
+ return (1, 'getPageMMap')(args);
+ }
+ if (memcmp(E->xGet_signature, xGet_signatures[xGet_(2, 'getPageNormal')_enum], sizeof(E->xGet_signature)) == 0) {
+ return (2, 'getPageNormal')(args);
+ }


// Transform return E->xParseCell(args) to if-chain with 3 candidates
@transform_return_xParseCell_arrow@
expression E;
identifier FP_NAME = xParseCell;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xParseCell_signature, xParseCell_signatures[xParseCell_(0, 'btreeParseCellPtr')_enum], sizeof(E->xParseCell_signature)) == 0) {
+ return (0, 'btreeParseCellPtr')(args);
+ }
+ if (memcmp(E->xParseCell_signature, xParseCell_signatures[xParseCell_(1, 'btreeParseCellPtrIndex')_enum], sizeof(E->xParseCell_signature)) == 0) {
+ return (1, 'btreeParseCellPtrIndex')(args);
+ }
+ if (memcmp(E->xParseCell_signature, xParseCell_signatures[xParseCell_(2, 'btreeParseCellPtrNoPayload')_enum], sizeof(E->xParseCell_signature)) == 0) {
+ return (2, 'btreeParseCellPtrNoPayload')(args);
+ }


// Transform return E->xRead(args) to if-chain with 2 candidates
@transform_return_xRead_arrow@
expression E;
identifier FP_NAME = xRead;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xRead_signature, xRead_signatures[xRead_(0, 'multiplexRead')_enum], sizeof(E->xRead_signature)) == 0) {
+ return (0, 'multiplexRead')(args);
+ }
+ if (memcmp(E->xRead_signature, xRead_signatures[xRead_(1, 'quotaRead')_enum], sizeof(E->xRead_signature)) == 0) {
+ return (1, 'quotaRead')(args);
+ }


// Transform return E->xSelectCallback(args) to if-chain with 16 candidates
@transform_return_xSelectCallback_arrow@
expression E;
identifier FP_NAME = xSelectCallback;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_(0, 'convertCompoundSelectToSubquery')_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (0, 'convertCompoundSelectToSubquery')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_(1, 'exprSelectWalkTableConstant')_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (1, 'exprSelectWalkTableConstant')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_(2, 'fixSelectCb')_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (2, 'fixSelectCb')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_(3, 'gatherSelectWindowsSelectCallback')_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (3, 'gatherSelectWindowsSelectCallback')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_(4, 'renameColumnSelectCb')_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (4, 'renameColumnSelectCb')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_(5, 'renameTableSelectCb')_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (5, 'renameTableSelectCb')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_(6, 'renameUnmapSelectCb')_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (6, 'renameUnmapSelectCb')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_(7, 'resolveSelectStep')_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (7, 'resolveSelectStep')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_(8, 'selectCheckOnClausesSelect')_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (8, 'selectCheckOnClausesSelect')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_(9, 'selectExpander')_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (9, 'selectExpander')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_(10, 'selectRefEnter')_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (10, 'selectRefEnter')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_(11, 'selectWindowRewriteSelectCb')_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (11, 'selectWindowRewriteSelectCb')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_(12, 'sqlite3ReturningSubqueryCorrelated')_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (12, 'sqlite3ReturningSubqueryCorrelated')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_(13, 'sqlite3SelectWalkFail')_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (13, 'sqlite3SelectWalkFail')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_(14, 'sqlite3SelectWalkNoop')_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (14, 'sqlite3SelectWalkNoop')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_(15, 'sqlite3WalkerDepthIncrease')_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (15, 'sqlite3WalkerDepthIncrease')(args);
+ }


// Transform return E->xSelectCallback2(args) to if-chain with 6 candidates
@transform_return_xSelectCallback2_arrow@
expression E;
identifier FP_NAME = xSelectCallback2;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_(0, 'selectAddSubqueryTypeInfo')_enum], sizeof(E->xSelectCallback2_signature)) == 0) {
+ return (0, 'selectAddSubqueryTypeInfo')(args);
+ }
+ if (memcmp(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_(1, 'selectRefLeave')_enum], sizeof(E->xSelectCallback2_signature)) == 0) {
+ return (1, 'selectRefLeave')(args);
+ }
+ if (memcmp(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_(2, 'sqlite3SelectPopWith')_enum], sizeof(E->xSelectCallback2_signature)) == 0) {
+ return (2, 'sqlite3SelectPopWith')(args);
+ }
+ if (memcmp(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_(3, 'sqlite3SelectWalkAssert2')_enum], sizeof(E->xSelectCallback2_signature)) == 0) {
+ return (3, 'sqlite3SelectWalkAssert2')(args);
+ }
+ if (memcmp(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_(4, 'sqlite3WalkWinDefnDummyCallback')_enum], sizeof(E->xSelectCallback2_signature)) == 0) {
+ return (4, 'sqlite3WalkWinDefnDummyCallback')(args);
+ }
+ if (memcmp(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_(5, 'sqlite3WalkerDepthDecrease')_enum], sizeof(E->xSelectCallback2_signature)) == 0) {
+ return (5, 'sqlite3WalkerDepthDecrease')(args);
+ }


// Transform return E->xWrite(args) to if-chain with 2 candidates
@transform_return_xWrite_arrow@
expression E;
identifier FP_NAME = xWrite;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xWrite_signature, xWrite_signatures[xWrite_(0, 'multiplexWrite')_enum], sizeof(E->xWrite_signature)) == 0) {
+ return (0, 'multiplexWrite')(args);
+ }
+ if (memcmp(E->xWrite_signature, xWrite_signatures[xWrite_(1, 'quotaWrite')_enum], sizeof(E->xWrite_signature)) == 0) {
+ return (1, 'quotaWrite')(args);
+ }

// Total return transformation rules generated: 8
// ===== RETURN FUNCTION POINTER TRANSFORMATION RULES =====

// Transform return E->xCellSize(args) to if-chain with 4 candidates
@transform_return_xCellSize@
expression E;
identifier FP_NAME = xCellSize;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtr_enum], sizeof(E.xCellSize_signature)) == 0) {
+ return cellSizePtr(args);
+ }
+ if (memcmp(E.xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrIdxLeaf_enum], sizeof(E.xCellSize_signature)) == 0) {
+ return cellSizePtrIdxLeaf(args);
+ }
+ if (memcmp(E.xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrNoPayload_enum], sizeof(E.xCellSize_signature)) == 0) {
+ return cellSizePtrNoPayload(args);
+ }
+ if (memcmp(E.xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrTableLeaf_enum], sizeof(E.xCellSize_signature)) == 0) {
+ return cellSizePtrTableLeaf(args);
+ }


// Transform return E->xExprCallback(args) to if-chain with 37 candidates
@transform_return_xExprCallback@
expression E;
identifier FP_NAME = xExprCallback;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_agginfoPersistExprCb_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return agginfoPersistExprCb(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_aggregateIdxEprRefToColCallback_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return aggregateIdxEprRefToColCallback(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_analyzeAggregate_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return analyzeAggregate(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_checkConstraintExprNode_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return checkConstraintExprNode(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintCheckExpr_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return codeCursorHintCheckExpr(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintFixExpr_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return codeCursorHintFixExpr(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintIsOrFunction_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return codeCursorHintIsOrFunction(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_disallowAggregatesInOrderByCb_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return disallowAggregatesInOrderByCb(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprColumnFlagUnion_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return exprColumnFlagUnion(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprIdxCover_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return exprIdxCover(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeCanReturnSubtype_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return exprNodeCanReturnSubtype(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsConstant_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return exprNodeIsConstant(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsConstantOrGroupBy_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return exprNodeIsConstantOrGroupBy(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsDeterministic_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return exprNodeIsDeterministic(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprRefToSrcList_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return exprRefToSrcList(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_fixExprCb_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return fixExprCb(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_gatherSelectWindowsCallback_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return gatherSelectWindowsCallback(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_havingToWhereExprCb_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return havingToWhereExprCb(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_impliesNotNullRow_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return impliesNotNullRow(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_incrAggDepth_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return incrAggDepth(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_markImmutableExprStep_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return markImmutableExprStep(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_propagateConstantExprRewrite_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return propagateConstantExprRewrite(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_recomputeColumnsUsedExpr_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return recomputeColumnsUsedExpr(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameColumnExprCb_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return renameColumnExprCb(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameQuotefixExprCb_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return renameQuotefixExprCb(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameTableExprCb_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return renameTableExprCb(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameUnmapExprCb_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return renameUnmapExprCb(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renumberCursorsCb_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return renumberCursorsCb(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_resolveExprStep_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return resolveExprStep(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_resolveRemoveWindowsCb_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return resolveRemoveWindowsCb(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_selectCheckOnClausesExpr_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return selectCheckOnClausesExpr(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_selectWindowRewriteExprCb_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return selectWindowRewriteExprCb(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3CursorRangeHintExprCheck_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return sqlite3CursorRangeHintExprCheck(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3ExprWalkNoop_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return sqlite3ExprWalkNoop(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3ReturningSubqueryVarSelect_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return sqlite3ReturningSubqueryVarSelect(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3WindowExtraAggFuncDepth_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return sqlite3WindowExtraAggFuncDepth(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_whereIsCoveringIndexWalkCallback_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ return whereIsCoveringIndexWalkCallback(args);
+ }


// Transform return E->xGet(args) to if-chain with 3 candidates
@transform_return_xGet@
expression E;
identifier FP_NAME = xGet;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xGet_signature, xGet_signatures[xGet_getPageError_enum], sizeof(E.xGet_signature)) == 0) {
+ return getPageError(args);
+ }
+ if (memcmp(E.xGet_signature, xGet_signatures[xGet_getPageMMap_enum], sizeof(E.xGet_signature)) == 0) {
+ return getPageMMap(args);
+ }
+ if (memcmp(E.xGet_signature, xGet_signatures[xGet_getPageNormal_enum], sizeof(E.xGet_signature)) == 0) {
+ return getPageNormal(args);
+ }


// Transform return E->xParseCell(args) to if-chain with 3 candidates
@transform_return_xParseCell@
expression E;
identifier FP_NAME = xParseCell;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtr_enum], sizeof(E.xParseCell_signature)) == 0) {
+ return btreeParseCellPtr(args);
+ }
+ if (memcmp(E.xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtrIndex_enum], sizeof(E.xParseCell_signature)) == 0) {
+ return btreeParseCellPtrIndex(args);
+ }
+ if (memcmp(E.xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtrNoPayload_enum], sizeof(E.xParseCell_signature)) == 0) {
+ return btreeParseCellPtrNoPayload(args);
+ }


// Transform return E->xRead(args) to if-chain with 2 candidates
@transform_return_xRead@
expression E;
identifier FP_NAME = xRead;
expression list args;
@@
- return E.FP_NAME(args);


// Transform return E->xSelectCallback(args) to if-chain with 16 candidates
@transform_return_xSelectCallback@
expression E;
identifier FP_NAME = xSelectCallback;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_convertCompoundSelectToSubquery_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ return convertCompoundSelectToSubquery(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_exprSelectWalkTableConstant_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ return exprSelectWalkTableConstant(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_fixSelectCb_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ return fixSelectCb(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_gatherSelectWindowsSelectCallback_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ return gatherSelectWindowsSelectCallback(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameColumnSelectCb_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ return renameColumnSelectCb(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameTableSelectCb_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ return renameTableSelectCb(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameUnmapSelectCb_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ return renameUnmapSelectCb(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_resolveSelectStep_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ return resolveSelectStep(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectCheckOnClausesSelect_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ return selectCheckOnClausesSelect(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectExpander_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ return selectExpander(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectRefEnter_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ return selectRefEnter(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectWindowRewriteSelectCb_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ return selectWindowRewriteSelectCb(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3ReturningSubqueryCorrelated_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ return sqlite3ReturningSubqueryCorrelated(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkFail_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ return sqlite3SelectWalkFail(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkNoop_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ return sqlite3SelectWalkNoop(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3WalkerDepthIncrease_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ return sqlite3WalkerDepthIncrease(args);
+ }


// Transform return E->xSelectCallback2(args) to if-chain with 6 candidates
@transform_return_xSelectCallback2@
expression E;
identifier FP_NAME = xSelectCallback2;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_selectAddSubqueryTypeInfo_enum], sizeof(E.xSelectCallback2_signature)) == 0) {
+ return selectAddSubqueryTypeInfo(args);
+ }
+ if (memcmp(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_selectRefLeave_enum], sizeof(E.xSelectCallback2_signature)) == 0) {
+ return selectRefLeave(args);
+ }
+ if (memcmp(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectPopWith_enum], sizeof(E.xSelectCallback2_signature)) == 0) {
+ return sqlite3SelectPopWith(args);
+ }
+ if (memcmp(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectWalkAssert2_enum], sizeof(E.xSelectCallback2_signature)) == 0) {
+ return sqlite3SelectWalkAssert2(args);
+ }
+ if (memcmp(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkWinDefnDummyCallback_enum], sizeof(E.xSelectCallback2_signature)) == 0) {
+ return sqlite3WalkWinDefnDummyCallback(args);
+ }
+ if (memcmp(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkerDepthDecrease_enum], sizeof(E.xSelectCallback2_signature)) == 0) {
+ return sqlite3WalkerDepthDecrease(args);
+ }


// Transform return E->xWrite(args) to if-chain with 2 candidates
@transform_return_xWrite@
expression E;
identifier FP_NAME = xWrite;
expression list args;
@@
- return E.FP_NAME(args);

// Total return transformation rules generated: 8
// ===== RETURN FUNCTION POINTER TRANSFORMATION RULES =====

// Transform return E->xCellSize(args) to if-chain with 4 candidates
@transform_no_return_xCellSize_arrow@
expression E;
identifier FP_NAME = xCellSize;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtr_enum], sizeof(E->xCellSize_signature)) == 0) {
+ cellSizePtr(args);
+ }
+ if (memcmp(E->xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrIdxLeaf_enum], sizeof(E->xCellSize_signature)) == 0) {
+ cellSizePtrIdxLeaf(args);
+ }
+ if (memcmp(E->xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrNoPayload_enum], sizeof(E->xCellSize_signature)) == 0) {
+ cellSizePtrNoPayload(args);
+ }
+ if (memcmp(E->xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrTableLeaf_enum], sizeof(E->xCellSize_signature)) == 0) {
+ cellSizePtrTableLeaf(args);
+ }


// Transform return E->xExprCallback(args) to if-chain with 37 candidates
@transform_no_return_xExprCallback_arrow@
expression E;
identifier FP_NAME = xExprCallback;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_agginfoPersistExprCb_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ agginfoPersistExprCb(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_aggregateIdxEprRefToColCallback_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ aggregateIdxEprRefToColCallback(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_analyzeAggregate_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ analyzeAggregate(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_checkConstraintExprNode_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ checkConstraintExprNode(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintCheckExpr_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ codeCursorHintCheckExpr(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintFixExpr_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ codeCursorHintFixExpr(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintIsOrFunction_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ codeCursorHintIsOrFunction(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_disallowAggregatesInOrderByCb_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ disallowAggregatesInOrderByCb(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprColumnFlagUnion_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ exprColumnFlagUnion(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprIdxCover_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ exprIdxCover(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeCanReturnSubtype_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ exprNodeCanReturnSubtype(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsConstant_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ exprNodeIsConstant(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsConstantOrGroupBy_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ exprNodeIsConstantOrGroupBy(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsDeterministic_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ exprNodeIsDeterministic(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprRefToSrcList_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ exprRefToSrcList(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_fixExprCb_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ fixExprCb(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_gatherSelectWindowsCallback_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ gatherSelectWindowsCallback(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_havingToWhereExprCb_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ havingToWhereExprCb(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_impliesNotNullRow_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ impliesNotNullRow(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_incrAggDepth_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ incrAggDepth(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_markImmutableExprStep_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ markImmutableExprStep(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_propagateConstantExprRewrite_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ propagateConstantExprRewrite(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_recomputeColumnsUsedExpr_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ recomputeColumnsUsedExpr(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameColumnExprCb_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ renameColumnExprCb(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameQuotefixExprCb_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ renameQuotefixExprCb(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameTableExprCb_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ renameTableExprCb(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameUnmapExprCb_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ renameUnmapExprCb(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renumberCursorsCb_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ renumberCursorsCb(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_resolveExprStep_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ resolveExprStep(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_resolveRemoveWindowsCb_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ resolveRemoveWindowsCb(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_selectCheckOnClausesExpr_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ selectCheckOnClausesExpr(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_selectWindowRewriteExprCb_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ selectWindowRewriteExprCb(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3CursorRangeHintExprCheck_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ sqlite3CursorRangeHintExprCheck(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3ExprWalkNoop_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ sqlite3ExprWalkNoop(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3ReturningSubqueryVarSelect_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ sqlite3ReturningSubqueryVarSelect(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3WindowExtraAggFuncDepth_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ sqlite3WindowExtraAggFuncDepth(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_whereIsCoveringIndexWalkCallback_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ whereIsCoveringIndexWalkCallback(args);
+ }


// Transform return E->xGet(args) to if-chain with 3 candidates
@transform_no_return_xGet_arrow@
expression E;
identifier FP_NAME = xGet;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xGet_signature, xGet_signatures[xGet_getPageError_enum], sizeof(E->xGet_signature)) == 0) {
+ getPageError(args);
+ }
+ if (memcmp(E->xGet_signature, xGet_signatures[xGet_getPageMMap_enum], sizeof(E->xGet_signature)) == 0) {
+ getPageMMap(args);
+ }
+ if (memcmp(E->xGet_signature, xGet_signatures[xGet_getPageNormal_enum], sizeof(E->xGet_signature)) == 0) {
+ getPageNormal(args);
+ }


// Transform return E->xParseCell(args) to if-chain with 3 candidates
@transform_no_return_xParseCell_arrow@
expression E;
identifier FP_NAME = xParseCell;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtr_enum], sizeof(E->xParseCell_signature)) == 0) {
+ btreeParseCellPtr(args);
+ }
+ if (memcmp(E->xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtrIndex_enum], sizeof(E->xParseCell_signature)) == 0) {
+ btreeParseCellPtrIndex(args);
+ }
+ if (memcmp(E->xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtrNoPayload_enum], sizeof(E->xParseCell_signature)) == 0) {
+ btreeParseCellPtrNoPayload(args);
+ }


// Transform return E->xRead(args) to if-chain with 2 candidates
@transform_no_return_xRead_arrow@
expression E;
identifier FP_NAME = xRead;
expression list args;
@@
- E->FP_NAME(args);


// Transform return E->xSelectCallback(args) to if-chain with 16 candidates
@transform_no_return_xSelectCallback_arrow@
expression E;
identifier FP_NAME = xSelectCallback;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_convertCompoundSelectToSubquery_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ convertCompoundSelectToSubquery(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_exprSelectWalkTableConstant_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ exprSelectWalkTableConstant(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_fixSelectCb_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ fixSelectCb(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_gatherSelectWindowsSelectCallback_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ gatherSelectWindowsSelectCallback(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameColumnSelectCb_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ renameColumnSelectCb(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameTableSelectCb_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ renameTableSelectCb(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameUnmapSelectCb_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ renameUnmapSelectCb(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_resolveSelectStep_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ resolveSelectStep(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectCheckOnClausesSelect_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ selectCheckOnClausesSelect(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectExpander_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ selectExpander(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectRefEnter_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ selectRefEnter(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectWindowRewriteSelectCb_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ selectWindowRewriteSelectCb(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3ReturningSubqueryCorrelated_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ sqlite3ReturningSubqueryCorrelated(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkFail_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ sqlite3SelectWalkFail(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkNoop_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ sqlite3SelectWalkNoop(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3WalkerDepthIncrease_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ sqlite3WalkerDepthIncrease(args);
+ }


// Transform return E->xSelectCallback2(args) to if-chain with 6 candidates
@transform_no_return_xSelectCallback2_arrow@
expression E;
identifier FP_NAME = xSelectCallback2;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_selectAddSubqueryTypeInfo_enum], sizeof(E->xSelectCallback2_signature)) == 0) {
+ selectAddSubqueryTypeInfo(args);
+ }
+ if (memcmp(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_selectRefLeave_enum], sizeof(E->xSelectCallback2_signature)) == 0) {
+ selectRefLeave(args);
+ }
+ if (memcmp(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectPopWith_enum], sizeof(E->xSelectCallback2_signature)) == 0) {
+ sqlite3SelectPopWith(args);
+ }
+ if (memcmp(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectWalkAssert2_enum], sizeof(E->xSelectCallback2_signature)) == 0) {
+ sqlite3SelectWalkAssert2(args);
+ }
+ if (memcmp(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkWinDefnDummyCallback_enum], sizeof(E->xSelectCallback2_signature)) == 0) {
+ sqlite3WalkWinDefnDummyCallback(args);
+ }
+ if (memcmp(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkerDepthDecrease_enum], sizeof(E->xSelectCallback2_signature)) == 0) {
+ sqlite3WalkerDepthDecrease(args);
+ }


// Transform return E->xWrite(args) to if-chain with 2 candidates
@transform_no_return_xWrite_arrow@
expression E;
identifier FP_NAME = xWrite;
expression list args;
@@
- E->FP_NAME(args);

// Total no return transformation rules generated: 8
// ===== RETURN FUNCTION POINTER TRANSFORMATION RULES =====

// Transform return E->xCellSize(args) to if-chain with 4 candidates
@transform_no_return_xCellSize@
expression E;
identifier FP_NAME = xCellSize;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtr_enum], sizeof(E.xCellSize_signature)) == 0) {
+ cellSizePtr(args);
+ }
+ if (memcmp(E.xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrIdxLeaf_enum], sizeof(E.xCellSize_signature)) == 0) {
+ cellSizePtrIdxLeaf(args);
+ }
+ if (memcmp(E.xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrNoPayload_enum], sizeof(E.xCellSize_signature)) == 0) {
+ cellSizePtrNoPayload(args);
+ }
+ if (memcmp(E.xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrTableLeaf_enum], sizeof(E.xCellSize_signature)) == 0) {
+ cellSizePtrTableLeaf(args);
+ }


// Transform return E->xExprCallback(args) to if-chain with 37 candidates
@transform_no_return_xExprCallback@
expression E;
identifier FP_NAME = xExprCallback;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_agginfoPersistExprCb_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ agginfoPersistExprCb(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_aggregateIdxEprRefToColCallback_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ aggregateIdxEprRefToColCallback(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_analyzeAggregate_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ analyzeAggregate(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_checkConstraintExprNode_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ checkConstraintExprNode(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintCheckExpr_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ codeCursorHintCheckExpr(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintFixExpr_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ codeCursorHintFixExpr(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintIsOrFunction_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ codeCursorHintIsOrFunction(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_disallowAggregatesInOrderByCb_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ disallowAggregatesInOrderByCb(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprColumnFlagUnion_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ exprColumnFlagUnion(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprIdxCover_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ exprIdxCover(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeCanReturnSubtype_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ exprNodeCanReturnSubtype(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsConstant_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ exprNodeIsConstant(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsConstantOrGroupBy_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ exprNodeIsConstantOrGroupBy(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsDeterministic_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ exprNodeIsDeterministic(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprRefToSrcList_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ exprRefToSrcList(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_fixExprCb_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ fixExprCb(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_gatherSelectWindowsCallback_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ gatherSelectWindowsCallback(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_havingToWhereExprCb_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ havingToWhereExprCb(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_impliesNotNullRow_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ impliesNotNullRow(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_incrAggDepth_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ incrAggDepth(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_markImmutableExprStep_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ markImmutableExprStep(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_propagateConstantExprRewrite_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ propagateConstantExprRewrite(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_recomputeColumnsUsedExpr_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ recomputeColumnsUsedExpr(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameColumnExprCb_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ renameColumnExprCb(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameQuotefixExprCb_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ renameQuotefixExprCb(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameTableExprCb_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ renameTableExprCb(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameUnmapExprCb_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ renameUnmapExprCb(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renumberCursorsCb_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ renumberCursorsCb(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_resolveExprStep_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ resolveExprStep(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_resolveRemoveWindowsCb_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ resolveRemoveWindowsCb(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_selectCheckOnClausesExpr_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ selectCheckOnClausesExpr(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_selectWindowRewriteExprCb_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ selectWindowRewriteExprCb(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3CursorRangeHintExprCheck_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ sqlite3CursorRangeHintExprCheck(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3ExprWalkNoop_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ sqlite3ExprWalkNoop(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3ReturningSubqueryVarSelect_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ sqlite3ReturningSubqueryVarSelect(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3WindowExtraAggFuncDepth_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ sqlite3WindowExtraAggFuncDepth(args);
+ }
+ if (memcmp(E.xExprCallback_signature, xExprCallback_signatures[xExprCallback_whereIsCoveringIndexWalkCallback_enum], sizeof(E.xExprCallback_signature)) == 0) {
+ whereIsCoveringIndexWalkCallback(args);
+ }


// Transform return E->xGet(args) to if-chain with 3 candidates
@transform_no_return_xGet@
expression E;
identifier FP_NAME = xGet;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xGet_signature, xGet_signatures[xGet_getPageError_enum], sizeof(E.xGet_signature)) == 0) {
+ getPageError(args);
+ }
+ if (memcmp(E.xGet_signature, xGet_signatures[xGet_getPageMMap_enum], sizeof(E.xGet_signature)) == 0) {
+ getPageMMap(args);
+ }
+ if (memcmp(E.xGet_signature, xGet_signatures[xGet_getPageNormal_enum], sizeof(E.xGet_signature)) == 0) {
+ getPageNormal(args);
+ }


// Transform return E->xParseCell(args) to if-chain with 3 candidates
@transform_no_return_xParseCell@
expression E;
identifier FP_NAME = xParseCell;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtr_enum], sizeof(E.xParseCell_signature)) == 0) {
+ btreeParseCellPtr(args);
+ }
+ if (memcmp(E.xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtrIndex_enum], sizeof(E.xParseCell_signature)) == 0) {
+ btreeParseCellPtrIndex(args);
+ }
+ if (memcmp(E.xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtrNoPayload_enum], sizeof(E.xParseCell_signature)) == 0) {
+ btreeParseCellPtrNoPayload(args);
+ }


// Transform return E->xRead(args) to if-chain with 2 candidates
@transform_no_return_xRead@
expression E;
identifier FP_NAME = xRead;
expression list args;
@@
- E.FP_NAME(args);


// Transform return E->xSelectCallback(args) to if-chain with 16 candidates
@transform_no_return_xSelectCallback@
expression E;
identifier FP_NAME = xSelectCallback;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_convertCompoundSelectToSubquery_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ convertCompoundSelectToSubquery(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_exprSelectWalkTableConstant_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ exprSelectWalkTableConstant(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_fixSelectCb_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ fixSelectCb(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_gatherSelectWindowsSelectCallback_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ gatherSelectWindowsSelectCallback(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameColumnSelectCb_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ renameColumnSelectCb(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameTableSelectCb_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ renameTableSelectCb(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameUnmapSelectCb_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ renameUnmapSelectCb(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_resolveSelectStep_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ resolveSelectStep(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectCheckOnClausesSelect_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ selectCheckOnClausesSelect(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectExpander_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ selectExpander(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectRefEnter_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ selectRefEnter(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectWindowRewriteSelectCb_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ selectWindowRewriteSelectCb(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3ReturningSubqueryCorrelated_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ sqlite3ReturningSubqueryCorrelated(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkFail_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ sqlite3SelectWalkFail(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkNoop_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ sqlite3SelectWalkNoop(args);
+ }
+ if (memcmp(E.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3WalkerDepthIncrease_enum], sizeof(E.xSelectCallback_signature)) == 0) {
+ sqlite3WalkerDepthIncrease(args);
+ }


// Transform return E->xSelectCallback2(args) to if-chain with 6 candidates
@transform_no_return_xSelectCallback2@
expression E;
identifier FP_NAME = xSelectCallback2;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_selectAddSubqueryTypeInfo_enum], sizeof(E.xSelectCallback2_signature)) == 0) {
+ selectAddSubqueryTypeInfo(args);
+ }
+ if (memcmp(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_selectRefLeave_enum], sizeof(E.xSelectCallback2_signature)) == 0) {
+ selectRefLeave(args);
+ }
+ if (memcmp(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectPopWith_enum], sizeof(E.xSelectCallback2_signature)) == 0) {
+ sqlite3SelectPopWith(args);
+ }
+ if (memcmp(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectWalkAssert2_enum], sizeof(E.xSelectCallback2_signature)) == 0) {
+ sqlite3SelectWalkAssert2(args);
+ }
+ if (memcmp(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkWinDefnDummyCallback_enum], sizeof(E.xSelectCallback2_signature)) == 0) {
+ sqlite3WalkWinDefnDummyCallback(args);
+ }
+ if (memcmp(E.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkerDepthDecrease_enum], sizeof(E.xSelectCallback2_signature)) == 0) {
+ sqlite3WalkerDepthDecrease(args);
+ }


// Transform return E->xWrite(args) to if-chain with 2 candidates
@transform_no_return_xWrite@
expression E;
identifier FP_NAME = xWrite;
expression list args;
@@
- E.FP_NAME(args);

// Total no return transformation rules generated: 8
// ===== RETURN FUNCTION POINTER TRANSFORMATION RULES =====

// Transform return E->xCellSize(args) to if-chain with 4 candidates
@transform_assignment_xCellSize_arrow@
expression E1, E2;
identifier FP_NAME = xCellSize;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtr_enum], sizeof(E2->xCellSize_signature)) == 0) {
+ E1 = cellSizePtr(args);
+ }
+ if (memcmp(E2->xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrIdxLeaf_enum], sizeof(E2->xCellSize_signature)) == 0) {
+ E1 = cellSizePtrIdxLeaf(args);
+ }
+ if (memcmp(E2->xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrNoPayload_enum], sizeof(E2->xCellSize_signature)) == 0) {
+ E1 = cellSizePtrNoPayload(args);
+ }
+ if (memcmp(E2->xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrTableLeaf_enum], sizeof(E2->xCellSize_signature)) == 0) {
+ E1 = cellSizePtrTableLeaf(args);
+ }


// Transform return E->xExprCallback(args) to if-chain with 37 candidates
@transform_assignment_xExprCallback_arrow@
expression E1, E2;
identifier FP_NAME = xExprCallback;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_agginfoPersistExprCb_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = agginfoPersistExprCb(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_aggregateIdxEprRefToColCallback_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = aggregateIdxEprRefToColCallback(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_analyzeAggregate_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = analyzeAggregate(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_checkConstraintExprNode_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = checkConstraintExprNode(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintCheckExpr_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = codeCursorHintCheckExpr(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintFixExpr_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = codeCursorHintFixExpr(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintIsOrFunction_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = codeCursorHintIsOrFunction(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_disallowAggregatesInOrderByCb_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = disallowAggregatesInOrderByCb(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprColumnFlagUnion_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = exprColumnFlagUnion(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprIdxCover_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = exprIdxCover(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeCanReturnSubtype_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = exprNodeCanReturnSubtype(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsConstant_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = exprNodeIsConstant(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsConstantOrGroupBy_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = exprNodeIsConstantOrGroupBy(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsDeterministic_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = exprNodeIsDeterministic(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprRefToSrcList_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = exprRefToSrcList(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_fixExprCb_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = fixExprCb(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_gatherSelectWindowsCallback_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = gatherSelectWindowsCallback(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_havingToWhereExprCb_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = havingToWhereExprCb(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_impliesNotNullRow_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = impliesNotNullRow(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_incrAggDepth_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = incrAggDepth(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_markImmutableExprStep_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = markImmutableExprStep(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_propagateConstantExprRewrite_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = propagateConstantExprRewrite(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_recomputeColumnsUsedExpr_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = recomputeColumnsUsedExpr(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameColumnExprCb_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = renameColumnExprCb(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameQuotefixExprCb_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = renameQuotefixExprCb(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameTableExprCb_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = renameTableExprCb(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameUnmapExprCb_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = renameUnmapExprCb(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renumberCursorsCb_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = renumberCursorsCb(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_resolveExprStep_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = resolveExprStep(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_resolveRemoveWindowsCb_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = resolveRemoveWindowsCb(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_selectCheckOnClausesExpr_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = selectCheckOnClausesExpr(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_selectWindowRewriteExprCb_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = selectWindowRewriteExprCb(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3CursorRangeHintExprCheck_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = sqlite3CursorRangeHintExprCheck(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3ExprWalkNoop_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = sqlite3ExprWalkNoop(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3ReturningSubqueryVarSelect_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = sqlite3ReturningSubqueryVarSelect(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3WindowExtraAggFuncDepth_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = sqlite3WindowExtraAggFuncDepth(args);
+ }
+ if (memcmp(E2->xExprCallback_signature, xExprCallback_signatures[xExprCallback_whereIsCoveringIndexWalkCallback_enum], sizeof(E2->xExprCallback_signature)) == 0) {
+ E1 = whereIsCoveringIndexWalkCallback(args);
+ }


// Transform return E->xGet(args) to if-chain with 3 candidates
@transform_assignment_xGet_arrow@
expression E1, E2;
identifier FP_NAME = xGet;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xGet_signature, xGet_signatures[xGet_getPageError_enum], sizeof(E2->xGet_signature)) == 0) {
+ E1 = getPageError(args);
+ }
+ if (memcmp(E2->xGet_signature, xGet_signatures[xGet_getPageMMap_enum], sizeof(E2->xGet_signature)) == 0) {
+ E1 = getPageMMap(args);
+ }
+ if (memcmp(E2->xGet_signature, xGet_signatures[xGet_getPageNormal_enum], sizeof(E2->xGet_signature)) == 0) {
+ E1 = getPageNormal(args);
+ }


// Transform return E->xParseCell(args) to if-chain with 3 candidates
@transform_assignment_xParseCell_arrow@
expression E1, E2;
identifier FP_NAME = xParseCell;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtr_enum], sizeof(E2->xParseCell_signature)) == 0) {
+ E1 = btreeParseCellPtr(args);
+ }
+ if (memcmp(E2->xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtrIndex_enum], sizeof(E2->xParseCell_signature)) == 0) {
+ E1 = btreeParseCellPtrIndex(args);
+ }
+ if (memcmp(E2->xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtrNoPayload_enum], sizeof(E2->xParseCell_signature)) == 0) {
+ E1 = btreeParseCellPtrNoPayload(args);
+ }


// Transform return E->xRead(args) to if-chain with 2 candidates
@transform_assignment_xRead_arrow@
expression E1, E2;
identifier FP_NAME = xRead;
expression list args;
@@
- E1 = E2->FP_NAME(args);


// Transform return E->xSelectCallback(args) to if-chain with 16 candidates
@transform_assignment_xSelectCallback_arrow@
expression E1, E2;
identifier FP_NAME = xSelectCallback;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_convertCompoundSelectToSubquery_enum], sizeof(E2->xSelectCallback_signature)) == 0) {
+ E1 = convertCompoundSelectToSubquery(args);
+ }
+ if (memcmp(E2->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_exprSelectWalkTableConstant_enum], sizeof(E2->xSelectCallback_signature)) == 0) {
+ E1 = exprSelectWalkTableConstant(args);
+ }
+ if (memcmp(E2->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_fixSelectCb_enum], sizeof(E2->xSelectCallback_signature)) == 0) {
+ E1 = fixSelectCb(args);
+ }
+ if (memcmp(E2->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_gatherSelectWindowsSelectCallback_enum], sizeof(E2->xSelectCallback_signature)) == 0) {
+ E1 = gatherSelectWindowsSelectCallback(args);
+ }
+ if (memcmp(E2->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameColumnSelectCb_enum], sizeof(E2->xSelectCallback_signature)) == 0) {
+ E1 = renameColumnSelectCb(args);
+ }
+ if (memcmp(E2->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameTableSelectCb_enum], sizeof(E2->xSelectCallback_signature)) == 0) {
+ E1 = renameTableSelectCb(args);
+ }
+ if (memcmp(E2->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameUnmapSelectCb_enum], sizeof(E2->xSelectCallback_signature)) == 0) {
+ E1 = renameUnmapSelectCb(args);
+ }
+ if (memcmp(E2->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_resolveSelectStep_enum], sizeof(E2->xSelectCallback_signature)) == 0) {
+ E1 = resolveSelectStep(args);
+ }
+ if (memcmp(E2->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectCheckOnClausesSelect_enum], sizeof(E2->xSelectCallback_signature)) == 0) {
+ E1 = selectCheckOnClausesSelect(args);
+ }
+ if (memcmp(E2->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectExpander_enum], sizeof(E2->xSelectCallback_signature)) == 0) {
+ E1 = selectExpander(args);
+ }
+ if (memcmp(E2->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectRefEnter_enum], sizeof(E2->xSelectCallback_signature)) == 0) {
+ E1 = selectRefEnter(args);
+ }
+ if (memcmp(E2->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectWindowRewriteSelectCb_enum], sizeof(E2->xSelectCallback_signature)) == 0) {
+ E1 = selectWindowRewriteSelectCb(args);
+ }
+ if (memcmp(E2->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3ReturningSubqueryCorrelated_enum], sizeof(E2->xSelectCallback_signature)) == 0) {
+ E1 = sqlite3ReturningSubqueryCorrelated(args);
+ }
+ if (memcmp(E2->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkFail_enum], sizeof(E2->xSelectCallback_signature)) == 0) {
+ E1 = sqlite3SelectWalkFail(args);
+ }
+ if (memcmp(E2->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkNoop_enum], sizeof(E2->xSelectCallback_signature)) == 0) {
+ E1 = sqlite3SelectWalkNoop(args);
+ }
+ if (memcmp(E2->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3WalkerDepthIncrease_enum], sizeof(E2->xSelectCallback_signature)) == 0) {
+ E1 = sqlite3WalkerDepthIncrease(args);
+ }


// Transform return E->xSelectCallback2(args) to if-chain with 6 candidates
@transform_assignment_xSelectCallback2_arrow@
expression E1, E2;
identifier FP_NAME = xSelectCallback2;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_selectAddSubqueryTypeInfo_enum], sizeof(E2->xSelectCallback2_signature)) == 0) {
+ E1 = selectAddSubqueryTypeInfo(args);
+ }
+ if (memcmp(E2->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_selectRefLeave_enum], sizeof(E2->xSelectCallback2_signature)) == 0) {
+ E1 = selectRefLeave(args);
+ }
+ if (memcmp(E2->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectPopWith_enum], sizeof(E2->xSelectCallback2_signature)) == 0) {
+ E1 = sqlite3SelectPopWith(args);
+ }
+ if (memcmp(E2->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectWalkAssert2_enum], sizeof(E2->xSelectCallback2_signature)) == 0) {
+ E1 = sqlite3SelectWalkAssert2(args);
+ }
+ if (memcmp(E2->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkWinDefnDummyCallback_enum], sizeof(E2->xSelectCallback2_signature)) == 0) {
+ E1 = sqlite3WalkWinDefnDummyCallback(args);
+ }
+ if (memcmp(E2->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkerDepthDecrease_enum], sizeof(E2->xSelectCallback2_signature)) == 0) {
+ E1 = sqlite3WalkerDepthDecrease(args);
+ }


// Transform return E->xWrite(args) to if-chain with 2 candidates
@transform_assignment_xWrite_arrow@
expression E1, E2;
identifier FP_NAME = xWrite;
expression list args;
@@
- E1 = E2->FP_NAME(args);

// Total assignment transformation rules generated: 8
// ===== RETURN FUNCTION POINTER TRANSFORMATION RULES =====

// Transform return E->xCellSize(args) to if-chain with 4 candidates
@transform_assignment_xCellSize@
expression E1, E2;
identifier FP_NAME = xCellSize;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtr_enum], sizeof(E2.xCellSize_signature)) == 0) {
+ E1 = cellSizePtr(args);
+ }
+ if (memcmp(E2.xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrIdxLeaf_enum], sizeof(E2.xCellSize_signature)) == 0) {
+ E1 = cellSizePtrIdxLeaf(args);
+ }
+ if (memcmp(E2.xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrNoPayload_enum], sizeof(E2.xCellSize_signature)) == 0) {
+ E1 = cellSizePtrNoPayload(args);
+ }
+ if (memcmp(E2.xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrTableLeaf_enum], sizeof(E2.xCellSize_signature)) == 0) {
+ E1 = cellSizePtrTableLeaf(args);
+ }


// Transform return E->xExprCallback(args) to if-chain with 37 candidates
@transform_assignment_xExprCallback@
expression E1, E2;
identifier FP_NAME = xExprCallback;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_agginfoPersistExprCb_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = agginfoPersistExprCb(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_aggregateIdxEprRefToColCallback_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = aggregateIdxEprRefToColCallback(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_analyzeAggregate_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = analyzeAggregate(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_checkConstraintExprNode_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = checkConstraintExprNode(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintCheckExpr_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = codeCursorHintCheckExpr(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintFixExpr_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = codeCursorHintFixExpr(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintIsOrFunction_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = codeCursorHintIsOrFunction(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_disallowAggregatesInOrderByCb_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = disallowAggregatesInOrderByCb(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprColumnFlagUnion_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = exprColumnFlagUnion(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprIdxCover_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = exprIdxCover(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeCanReturnSubtype_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = exprNodeCanReturnSubtype(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsConstant_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = exprNodeIsConstant(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsConstantOrGroupBy_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = exprNodeIsConstantOrGroupBy(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsDeterministic_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = exprNodeIsDeterministic(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprRefToSrcList_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = exprRefToSrcList(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_fixExprCb_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = fixExprCb(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_gatherSelectWindowsCallback_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = gatherSelectWindowsCallback(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_havingToWhereExprCb_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = havingToWhereExprCb(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_impliesNotNullRow_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = impliesNotNullRow(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_incrAggDepth_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = incrAggDepth(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_markImmutableExprStep_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = markImmutableExprStep(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_propagateConstantExprRewrite_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = propagateConstantExprRewrite(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_recomputeColumnsUsedExpr_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = recomputeColumnsUsedExpr(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameColumnExprCb_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = renameColumnExprCb(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameQuotefixExprCb_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = renameQuotefixExprCb(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameTableExprCb_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = renameTableExprCb(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameUnmapExprCb_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = renameUnmapExprCb(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_renumberCursorsCb_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = renumberCursorsCb(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_resolveExprStep_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = resolveExprStep(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_resolveRemoveWindowsCb_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = resolveRemoveWindowsCb(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_selectCheckOnClausesExpr_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = selectCheckOnClausesExpr(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_selectWindowRewriteExprCb_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = selectWindowRewriteExprCb(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3CursorRangeHintExprCheck_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = sqlite3CursorRangeHintExprCheck(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3ExprWalkNoop_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = sqlite3ExprWalkNoop(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3ReturningSubqueryVarSelect_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = sqlite3ReturningSubqueryVarSelect(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3WindowExtraAggFuncDepth_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = sqlite3WindowExtraAggFuncDepth(args);
+ }
+ if (memcmp(E2.xExprCallback_signature, xExprCallback_signatures[xExprCallback_whereIsCoveringIndexWalkCallback_enum], sizeof(E2.xExprCallback_signature)) == 0) {
+ E1 = whereIsCoveringIndexWalkCallback(args);
+ }


// Transform return E->xGet(args) to if-chain with 3 candidates
@transform_assignment_xGet@
expression E1, E2;
identifier FP_NAME = xGet;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xGet_signature, xGet_signatures[xGet_getPageError_enum], sizeof(E2.xGet_signature)) == 0) {
+ E1 = getPageError(args);
+ }
+ if (memcmp(E2.xGet_signature, xGet_signatures[xGet_getPageMMap_enum], sizeof(E2.xGet_signature)) == 0) {
+ E1 = getPageMMap(args);
+ }
+ if (memcmp(E2.xGet_signature, xGet_signatures[xGet_getPageNormal_enum], sizeof(E2.xGet_signature)) == 0) {
+ E1 = getPageNormal(args);
+ }


// Transform return E->xParseCell(args) to if-chain with 3 candidates
@transform_assignment_xParseCell@
expression E1, E2;
identifier FP_NAME = xParseCell;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtr_enum], sizeof(E2.xParseCell_signature)) == 0) {
+ E1 = btreeParseCellPtr(args);
+ }
+ if (memcmp(E2.xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtrIndex_enum], sizeof(E2.xParseCell_signature)) == 0) {
+ E1 = btreeParseCellPtrIndex(args);
+ }
+ if (memcmp(E2.xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtrNoPayload_enum], sizeof(E2.xParseCell_signature)) == 0) {
+ E1 = btreeParseCellPtrNoPayload(args);
+ }


// Transform return E->xRead(args) to if-chain with 2 candidates
@transform_assignment_xRead@
expression E1, E2;
identifier FP_NAME = xRead;
expression list args;
@@
- E1 = E2.FP_NAME(args);


// Transform return E->xSelectCallback(args) to if-chain with 16 candidates
@transform_assignment_xSelectCallback@
expression E1, E2;
identifier FP_NAME = xSelectCallback;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_convertCompoundSelectToSubquery_enum], sizeof(E2.xSelectCallback_signature)) == 0) {
+ E1 = convertCompoundSelectToSubquery(args);
+ }
+ if (memcmp(E2.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_exprSelectWalkTableConstant_enum], sizeof(E2.xSelectCallback_signature)) == 0) {
+ E1 = exprSelectWalkTableConstant(args);
+ }
+ if (memcmp(E2.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_fixSelectCb_enum], sizeof(E2.xSelectCallback_signature)) == 0) {
+ E1 = fixSelectCb(args);
+ }
+ if (memcmp(E2.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_gatherSelectWindowsSelectCallback_enum], sizeof(E2.xSelectCallback_signature)) == 0) {
+ E1 = gatherSelectWindowsSelectCallback(args);
+ }
+ if (memcmp(E2.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameColumnSelectCb_enum], sizeof(E2.xSelectCallback_signature)) == 0) {
+ E1 = renameColumnSelectCb(args);
+ }
+ if (memcmp(E2.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameTableSelectCb_enum], sizeof(E2.xSelectCallback_signature)) == 0) {
+ E1 = renameTableSelectCb(args);
+ }
+ if (memcmp(E2.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameUnmapSelectCb_enum], sizeof(E2.xSelectCallback_signature)) == 0) {
+ E1 = renameUnmapSelectCb(args);
+ }
+ if (memcmp(E2.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_resolveSelectStep_enum], sizeof(E2.xSelectCallback_signature)) == 0) {
+ E1 = resolveSelectStep(args);
+ }
+ if (memcmp(E2.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectCheckOnClausesSelect_enum], sizeof(E2.xSelectCallback_signature)) == 0) {
+ E1 = selectCheckOnClausesSelect(args);
+ }
+ if (memcmp(E2.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectExpander_enum], sizeof(E2.xSelectCallback_signature)) == 0) {
+ E1 = selectExpander(args);
+ }
+ if (memcmp(E2.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectRefEnter_enum], sizeof(E2.xSelectCallback_signature)) == 0) {
+ E1 = selectRefEnter(args);
+ }
+ if (memcmp(E2.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectWindowRewriteSelectCb_enum], sizeof(E2.xSelectCallback_signature)) == 0) {
+ E1 = selectWindowRewriteSelectCb(args);
+ }
+ if (memcmp(E2.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3ReturningSubqueryCorrelated_enum], sizeof(E2.xSelectCallback_signature)) == 0) {
+ E1 = sqlite3ReturningSubqueryCorrelated(args);
+ }
+ if (memcmp(E2.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkFail_enum], sizeof(E2.xSelectCallback_signature)) == 0) {
+ E1 = sqlite3SelectWalkFail(args);
+ }
+ if (memcmp(E2.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkNoop_enum], sizeof(E2.xSelectCallback_signature)) == 0) {
+ E1 = sqlite3SelectWalkNoop(args);
+ }
+ if (memcmp(E2.xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3WalkerDepthIncrease_enum], sizeof(E2.xSelectCallback_signature)) == 0) {
+ E1 = sqlite3WalkerDepthIncrease(args);
+ }


// Transform return E->xSelectCallback2(args) to if-chain with 6 candidates
@transform_assignment_xSelectCallback2@
expression E1, E2;
identifier FP_NAME = xSelectCallback2;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_selectAddSubqueryTypeInfo_enum], sizeof(E2.xSelectCallback2_signature)) == 0) {
+ E1 = selectAddSubqueryTypeInfo(args);
+ }
+ if (memcmp(E2.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_selectRefLeave_enum], sizeof(E2.xSelectCallback2_signature)) == 0) {
+ E1 = selectRefLeave(args);
+ }
+ if (memcmp(E2.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectPopWith_enum], sizeof(E2.xSelectCallback2_signature)) == 0) {
+ E1 = sqlite3SelectPopWith(args);
+ }
+ if (memcmp(E2.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectWalkAssert2_enum], sizeof(E2.xSelectCallback2_signature)) == 0) {
+ E1 = sqlite3SelectWalkAssert2(args);
+ }
+ if (memcmp(E2.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkWinDefnDummyCallback_enum], sizeof(E2.xSelectCallback2_signature)) == 0) {
+ E1 = sqlite3WalkWinDefnDummyCallback(args);
+ }
+ if (memcmp(E2.xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkerDepthDecrease_enum], sizeof(E2.xSelectCallback2_signature)) == 0) {
+ E1 = sqlite3WalkerDepthDecrease(args);
+ }


// Transform return E->xWrite(args) to if-chain with 2 candidates
@transform_assignment_xWrite@
expression E1, E2;
identifier FP_NAME = xWrite;
expression list args;
@@
- E1 = E2.FP_NAME(args);

// Total assignment transformation rules generated: 8
