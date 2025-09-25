// ===== RETURN FUNCTION POINTER TRANSFORMATION RULES =====

// Transform return E->xAccess(args) to if-chain with 2 candidates
@transform_return_xAccess_arrow@
expression E;
identifier FP_NAME = xAccess;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xAccess_signature, xAccess_signatures[xAccess_vfstraceAccess_enum], sizeof(E->xAccess_signature)) == 0) {
+ return (1, 'vfstraceAccess')(args);
+ }


// Transform return E->xAppend(args) to if-chain with 2 candidates
@transform_return_xAppend_arrow@
expression E;
identifier FP_NAME = xAppend;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xAppend_signature, xAppend_signatures[xAppend_fts5AppendPoslist_enum], sizeof(E->xAppend_signature)) == 0) {
+ return (0, 'fts5AppendPoslist')(args);
+ }
+ if (memcmp(E->xAppend_signature, xAppend_signatures[xAppend_fts5AppendRowid_enum], sizeof(E->xAppend_signature)) == 0) {
+ return (1, 'fts5AppendRowid')(args);
+ }


// Transform return E->xCellSize(args) to if-chain with 4 candidates
@transform_return_xCellSize_arrow@
expression E;
identifier FP_NAME = xCellSize;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtr_enum], sizeof(E->xCellSize_signature)) == 0) {
+ return (0, 'cellSizePtr')(args);
+ }
+ if (memcmp(E->xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrIdxLeaf_enum], sizeof(E->xCellSize_signature)) == 0) {
+ return (1, 'cellSizePtrIdxLeaf')(args);
+ }
+ if (memcmp(E->xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrNoPayload_enum], sizeof(E->xCellSize_signature)) == 0) {
+ return (2, 'cellSizePtrNoPayload')(args);
+ }
+ if (memcmp(E->xCellSize_signature, xCellSize_signatures[xCellSize_cellSizePtrTableLeaf_enum], sizeof(E->xCellSize_signature)) == 0) {
+ return (3, 'cellSizePtrTableLeaf')(args);
+ }


// Transform return E->xCheckReservedLock(args) to if-chain with 3 candidates
@transform_return_xCheckReservedLock_arrow@
expression E;
identifier FP_NAME = xCheckReservedLock;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_vfstraceCheckReservedLock_enum], sizeof(E->xCheckReservedLock_signature)) == 0) {
+ return (2, 'vfstraceCheckReservedLock')(args);
+ }


// Transform return E->xClose(args) to if-chain with 3 candidates
@transform_return_xClose_arrow@
expression E;
identifier FP_NAME = xClose;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xClose_signature, xClose_signatures[xClose_vfstraceClose_enum], sizeof(E->xClose_signature)) == 0) {
+ return (2, 'vfstraceClose')(args);
+ }


// Transform return E->xCount(args) to if-chain with 3 candidates
@transform_return_xCount_arrow@
expression E;
identifier FP_NAME = xCount;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xCount_signature, xCount_signatures[xCount_sessionDiffCount_enum], sizeof(E->xCount_signature)) == 0) {
+ return (0, 'sessionDiffCount')(args);
+ }
+ if (memcmp(E->xCount_signature, xCount_signatures[xCount_sessionPreupdateCount_enum], sizeof(E->xCount_signature)) == 0) {
+ return (1, 'sessionPreupdateCount')(args);
+ }
+ if (memcmp(E->xCount_signature, xCount_signatures[xCount_sessionStat1Count_enum], sizeof(E->xCount_signature)) == 0) {
+ return (2, 'sessionStat1Count')(args);
+ }


// Transform return E->xCurrentTime(args) to if-chain with 2 candidates
@transform_return_xCurrentTime_arrow@
expression E;
identifier FP_NAME = xCurrentTime;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_vfstraceCurrentTime_enum], sizeof(E->xCurrentTime_signature)) == 0) {
+ return (1, 'vfstraceCurrentTime')(args);
+ }


// Transform return E->xDelUser(args) to if-chain with 2 candidates
@transform_return_xDelUser_arrow@
expression E;
identifier FP_NAME = xDelUser;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xDelUser_signature, xDelUser_signatures[xDelUser_circle_del_enum], sizeof(E->xDelUser_signature)) == 0) {
+ return (0, 'circle_del')(args);
+ }
+ if (memcmp(E->xDelUser_signature, xDelUser_signatures[xDelUser_cube_context_free_enum], sizeof(E->xDelUser_signature)) == 0) {
+ return (1, 'cube_context_free')(args);
+ }


// Transform return E->xDepth(args) to if-chain with 3 candidates
@transform_return_xDepth_arrow@
expression E;
identifier FP_NAME = xDepth;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xDepth_signature, xDepth_signatures[xDepth_sessionDiffDepth_enum], sizeof(E->xDepth_signature)) == 0) {
+ return (0, 'sessionDiffDepth')(args);
+ }
+ if (memcmp(E->xDepth_signature, xDepth_signatures[xDepth_sessionPreupdateDepth_enum], sizeof(E->xDepth_signature)) == 0) {
+ return (1, 'sessionPreupdateDepth')(args);
+ }
+ if (memcmp(E->xDepth_signature, xDepth_signatures[xDepth_sessionStat1Depth_enum], sizeof(E->xDepth_signature)) == 0) {
+ return (2, 'sessionStat1Depth')(args);
+ }


// Transform return E->xDeviceCharacteristics(args) to if-chain with 3 candidates
@transform_return_xDeviceCharacteristics_arrow@
expression E;
identifier FP_NAME = xDeviceCharacteristics;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_vfstraceDeviceCharacteristics_enum], sizeof(E->xDeviceCharacteristics_signature)) == 0) {
+ return (2, 'vfstraceDeviceCharacteristics')(args);
+ }


// Transform return E->xExprCallback(args) to if-chain with 37 candidates
@transform_return_xExprCallback_arrow@
expression E;
identifier FP_NAME = xExprCallback;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_agginfoPersistExprCb_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (0, 'agginfoPersistExprCb')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_aggregateIdxEprRefToColCallback_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (1, 'aggregateIdxEprRefToColCallback')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_analyzeAggregate_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (2, 'analyzeAggregate')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_checkConstraintExprNode_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (3, 'checkConstraintExprNode')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintCheckExpr_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (4, 'codeCursorHintCheckExpr')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintFixExpr_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (5, 'codeCursorHintFixExpr')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintIsOrFunction_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (6, 'codeCursorHintIsOrFunction')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_disallowAggregatesInOrderByCb_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (7, 'disallowAggregatesInOrderByCb')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprColumnFlagUnion_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (8, 'exprColumnFlagUnion')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprIdxCover_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (9, 'exprIdxCover')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeCanReturnSubtype_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (10, 'exprNodeCanReturnSubtype')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsConstant_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (11, 'exprNodeIsConstant')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsConstantOrGroupBy_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (12, 'exprNodeIsConstantOrGroupBy')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsDeterministic_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (13, 'exprNodeIsDeterministic')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprRefToSrcList_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (14, 'exprRefToSrcList')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_fixExprCb_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (15, 'fixExprCb')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_gatherSelectWindowsCallback_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (16, 'gatherSelectWindowsCallback')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_havingToWhereExprCb_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (17, 'havingToWhereExprCb')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_impliesNotNullRow_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (18, 'impliesNotNullRow')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_incrAggDepth_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (19, 'incrAggDepth')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_markImmutableExprStep_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (20, 'markImmutableExprStep')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_propagateConstantExprRewrite_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (21, 'propagateConstantExprRewrite')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_recomputeColumnsUsedExpr_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (22, 'recomputeColumnsUsedExpr')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameColumnExprCb_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (23, 'renameColumnExprCb')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameQuotefixExprCb_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (24, 'renameQuotefixExprCb')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameTableExprCb_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (25, 'renameTableExprCb')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameUnmapExprCb_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (26, 'renameUnmapExprCb')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renumberCursorsCb_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (27, 'renumberCursorsCb')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_resolveExprStep_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (28, 'resolveExprStep')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_resolveRemoveWindowsCb_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (29, 'resolveRemoveWindowsCb')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_selectCheckOnClausesExpr_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (30, 'selectCheckOnClausesExpr')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_selectWindowRewriteExprCb_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (31, 'selectWindowRewriteExprCb')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3CursorRangeHintExprCheck_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (32, 'sqlite3CursorRangeHintExprCheck')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3ExprWalkNoop_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (33, 'sqlite3ExprWalkNoop')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3ReturningSubqueryVarSelect_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (34, 'sqlite3ReturningSubqueryVarSelect')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3WindowExtraAggFuncDepth_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (35, 'sqlite3WindowExtraAggFuncDepth')(args);
+ }
+ if (memcmp(E->xExprCallback_signature, xExprCallback_signatures[xExprCallback_whereIsCoveringIndexWalkCallback_enum], sizeof(E->xExprCallback_signature)) == 0) {
+ return (36, 'whereIsCoveringIndexWalkCallback')(args);
+ }


// Transform return E->xFileControl(args) to if-chain with 3 candidates
@transform_return_xFileControl_arrow@
expression E;
identifier FP_NAME = xFileControl;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xFileControl_signature, xFileControl_signatures[xFileControl_vfstraceFileControl_enum], sizeof(E->xFileControl_signature)) == 0) {
+ return (2, 'vfstraceFileControl')(args);
+ }


// Transform return E->xFileSize(args) to if-chain with 3 candidates
@transform_return_xFileSize_arrow@
expression E;
identifier FP_NAME = xFileSize;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xFileSize_signature, xFileSize_signatures[xFileSize_vfstraceFileSize_enum], sizeof(E->xFileSize_signature)) == 0) {
+ return (2, 'vfstraceFileSize')(args);
+ }


// Transform return E->xFullPathname(args) to if-chain with 2 candidates
@transform_return_xFullPathname_arrow@
expression E;
identifier FP_NAME = xFullPathname;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xFullPathname_signature, xFullPathname_signatures[xFullPathname_vfstraceFullPathname_enum], sizeof(E->xFullPathname_signature)) == 0) {
+ return (1, 'vfstraceFullPathname')(args);
+ }


// Transform return E->xGet(args) to if-chain with 3 candidates
@transform_return_xGet_arrow@
expression E;
identifier FP_NAME = xGet;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xGet_signature, xGet_signatures[xGet_getPageError_enum], sizeof(E->xGet_signature)) == 0) {
+ return (0, 'getPageError')(args);
+ }
+ if (memcmp(E->xGet_signature, xGet_signatures[xGet_getPageMMap_enum], sizeof(E->xGet_signature)) == 0) {
+ return (1, 'getPageMMap')(args);
+ }
+ if (memcmp(E->xGet_signature, xGet_signatures[xGet_getPageNormal_enum], sizeof(E->xGet_signature)) == 0) {
+ return (2, 'getPageNormal')(args);
+ }


// Transform return E->xLock(args) to if-chain with 3 candidates
@transform_return_xLock_arrow@
expression E;
identifier FP_NAME = xLock;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xLock_signature, xLock_signatures[xLock_vfstraceLock_enum], sizeof(E->xLock_signature)) == 0) {
+ return (2, 'vfstraceLock')(args);
+ }


// Transform return E->xMerge(args) to if-chain with 2 candidates
@transform_return_xMerge_arrow@
expression E;
identifier FP_NAME = xMerge;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xMerge_signature, xMerge_signatures[xMerge_fts5MergePrefixLists_enum], sizeof(E->xMerge_signature)) == 0) {
+ return (0, 'fts5MergePrefixLists')(args);
+ }
+ if (memcmp(E->xMerge_signature, xMerge_signatures[xMerge_fts5MergeRowidLists_enum], sizeof(E->xMerge_signature)) == 0) {
+ return (1, 'fts5MergeRowidLists')(args);
+ }


// Transform return E->xNew(args) to if-chain with 3 candidates
@transform_return_xNew_arrow@
expression E;
identifier FP_NAME = xNew;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xNew_signature, xNew_signatures[xNew_sessionDiffNew_enum], sizeof(E->xNew_signature)) == 0) {
+ return (0, 'sessionDiffNew')(args);
+ }
+ if (memcmp(E->xNew_signature, xNew_signatures[xNew_sessionPreupdateNew_enum], sizeof(E->xNew_signature)) == 0) {
+ return (1, 'sessionPreupdateNew')(args);
+ }
+ if (memcmp(E->xNew_signature, xNew_signatures[xNew_sessionStat1New_enum], sizeof(E->xNew_signature)) == 0) {
+ return (2, 'sessionStat1New')(args);
+ }


// Transform return E->xNext(args) to if-chain with 8 candidates
@transform_return_xNext_arrow@
expression E;
identifier FP_NAME = xNext;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_AND_enum], sizeof(E->xNext_signature)) == 0) {
+ return (0, 'fts5ExprNodeNext_AND')(args);
+ }
+ if (memcmp(E->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_NOT_enum], sizeof(E->xNext_signature)) == 0) {
+ return (1, 'fts5ExprNodeNext_NOT')(args);
+ }
+ if (memcmp(E->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_OR_enum], sizeof(E->xNext_signature)) == 0) {
+ return (2, 'fts5ExprNodeNext_OR')(args);
+ }
+ if (memcmp(E->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_STRING_enum], sizeof(E->xNext_signature)) == 0) {
+ return (3, 'fts5ExprNodeNext_STRING')(args);
+ }
+ if (memcmp(E->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_TERM_enum], sizeof(E->xNext_signature)) == 0) {
+ return (4, 'fts5ExprNodeNext_TERM')(args);
+ }
+ if (memcmp(E->xNext_signature, xNext_signatures[xNext_fts5SegIterNext_enum], sizeof(E->xNext_signature)) == 0) {
+ return (5, 'fts5SegIterNext')(args);
+ }
+ if (memcmp(E->xNext_signature, xNext_signatures[xNext_fts5SegIterNext_None_enum], sizeof(E->xNext_signature)) == 0) {
+ return (6, 'fts5SegIterNext_None')(args);
+ }
+ if (memcmp(E->xNext_signature, xNext_signatures[xNext_fts5SegIterNext_Reverse_enum], sizeof(E->xNext_signature)) == 0) {
+ return (7, 'fts5SegIterNext_Reverse')(args);
+ }


// Transform return E->xOld(args) to if-chain with 3 candidates
@transform_return_xOld_arrow@
expression E;
identifier FP_NAME = xOld;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xOld_signature, xOld_signatures[xOld_sessionDiffOld_enum], sizeof(E->xOld_signature)) == 0) {
+ return (0, 'sessionDiffOld')(args);
+ }
+ if (memcmp(E->xOld_signature, xOld_signatures[xOld_sessionPreupdateOld_enum], sizeof(E->xOld_signature)) == 0) {
+ return (1, 'sessionPreupdateOld')(args);
+ }
+ if (memcmp(E->xOld_signature, xOld_signatures[xOld_sessionStat1Old_enum], sizeof(E->xOld_signature)) == 0) {
+ return (2, 'sessionStat1Old')(args);
+ }


// Transform return E->xOpen(args) to if-chain with 3 candidates
@transform_return_xOpen_arrow@
expression E;
identifier FP_NAME = xOpen;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xOpen_signature, xOpen_signatures[xOpen_vfstraceOpen_enum], sizeof(E->xOpen_signature)) == 0) {
+ return (2, 'vfstraceOpen')(args);
+ }


// Transform return E->xParseCell(args) to if-chain with 3 candidates
@transform_return_xParseCell_arrow@
expression E;
identifier FP_NAME = xParseCell;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtr_enum], sizeof(E->xParseCell_signature)) == 0) {
+ return (0, 'btreeParseCellPtr')(args);
+ }
+ if (memcmp(E->xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtrIndex_enum], sizeof(E->xParseCell_signature)) == 0) {
+ return (1, 'btreeParseCellPtrIndex')(args);
+ }
+ if (memcmp(E->xParseCell_signature, xParseCell_signatures[xParseCell_btreeParseCellPtrNoPayload_enum], sizeof(E->xParseCell_signature)) == 0) {
+ return (2, 'btreeParseCellPtrNoPayload')(args);
+ }


// Transform return E->xRandomness(args) to if-chain with 2 candidates
@transform_return_xRandomness_arrow@
expression E;
identifier FP_NAME = xRandomness;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xRandomness_signature, xRandomness_signatures[xRandomness_vfstraceRandomness_enum], sizeof(E->xRandomness_signature)) == 0) {
+ return (1, 'vfstraceRandomness')(args);
+ }


// Transform return E->xRead(args) to if-chain with 3 candidates
@transform_return_xRead_arrow@
expression E;
identifier FP_NAME = xRead;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xRead_signature, xRead_signatures[xRead_vfstraceRead_enum], sizeof(E->xRead_signature)) == 0) {
+ return (2, 'vfstraceRead')(args);
+ }


// Transform return E->xSectorSize(args) to if-chain with 3 candidates
@transform_return_xSectorSize_arrow@
expression E;
identifier FP_NAME = xSectorSize;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xSectorSize_signature, xSectorSize_signatures[xSectorSize_vfstraceSectorSize_enum], sizeof(E->xSectorSize_signature)) == 0) {
+ return (2, 'vfstraceSectorSize')(args);
+ }


// Transform return E->xSelectCallback(args) to if-chain with 16 candidates
@transform_return_xSelectCallback_arrow@
expression E;
identifier FP_NAME = xSelectCallback;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_convertCompoundSelectToSubquery_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (0, 'convertCompoundSelectToSubquery')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_exprSelectWalkTableConstant_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (1, 'exprSelectWalkTableConstant')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_fixSelectCb_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (2, 'fixSelectCb')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_gatherSelectWindowsSelectCallback_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (3, 'gatherSelectWindowsSelectCallback')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameColumnSelectCb_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (4, 'renameColumnSelectCb')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameTableSelectCb_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (5, 'renameTableSelectCb')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameUnmapSelectCb_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (6, 'renameUnmapSelectCb')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_resolveSelectStep_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (7, 'resolveSelectStep')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectCheckOnClausesSelect_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (8, 'selectCheckOnClausesSelect')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectExpander_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (9, 'selectExpander')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectRefEnter_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (10, 'selectRefEnter')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectWindowRewriteSelectCb_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (11, 'selectWindowRewriteSelectCb')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3ReturningSubqueryCorrelated_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (12, 'sqlite3ReturningSubqueryCorrelated')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkFail_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (13, 'sqlite3SelectWalkFail')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkNoop_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (14, 'sqlite3SelectWalkNoop')(args);
+ }
+ if (memcmp(E->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3WalkerDepthIncrease_enum], sizeof(E->xSelectCallback_signature)) == 0) {
+ return (15, 'sqlite3WalkerDepthIncrease')(args);
+ }


// Transform return E->xSelectCallback2(args) to if-chain with 6 candidates
@transform_return_xSelectCallback2_arrow@
expression E;
identifier FP_NAME = xSelectCallback2;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_selectAddSubqueryTypeInfo_enum], sizeof(E->xSelectCallback2_signature)) == 0) {
+ return (0, 'selectAddSubqueryTypeInfo')(args);
+ }
+ if (memcmp(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_selectRefLeave_enum], sizeof(E->xSelectCallback2_signature)) == 0) {
+ return (1, 'selectRefLeave')(args);
+ }
+ if (memcmp(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectPopWith_enum], sizeof(E->xSelectCallback2_signature)) == 0) {
+ return (2, 'sqlite3SelectPopWith')(args);
+ }
+ if (memcmp(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectWalkAssert2_enum], sizeof(E->xSelectCallback2_signature)) == 0) {
+ return (3, 'sqlite3SelectWalkAssert2')(args);
+ }
+ if (memcmp(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkWinDefnDummyCallback_enum], sizeof(E->xSelectCallback2_signature)) == 0) {
+ return (4, 'sqlite3WalkWinDefnDummyCallback')(args);
+ }
+ if (memcmp(E->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkerDepthDecrease_enum], sizeof(E->xSelectCallback2_signature)) == 0) {
+ return (5, 'sqlite3WalkerDepthDecrease')(args);
+ }


// Transform return E->xSetOutputs(args) to if-chain with 7 candidates
@transform_return_xSetOutputs_arrow@
expression E;
identifier FP_NAME = xSetOutputs;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Col_enum], sizeof(E->xSetOutputs_signature)) == 0) {
+ return (0, 'fts5IterSetOutputs_Col')(args);
+ }
+ if (memcmp(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Col100_enum], sizeof(E->xSetOutputs_signature)) == 0) {
+ return (1, 'fts5IterSetOutputs_Col100')(args);
+ }
+ if (memcmp(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Full_enum], sizeof(E->xSetOutputs_signature)) == 0) {
+ return (2, 'fts5IterSetOutputs_Full')(args);
+ }
+ if (memcmp(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Nocolset_enum], sizeof(E->xSetOutputs_signature)) == 0) {
+ return (3, 'fts5IterSetOutputs_Nocolset')(args);
+ }
+ if (memcmp(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_None_enum], sizeof(E->xSetOutputs_signature)) == 0) {
+ return (4, 'fts5IterSetOutputs_None')(args);
+ }
+ if (memcmp(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Noop_enum], sizeof(E->xSetOutputs_signature)) == 0) {
+ return (5, 'fts5IterSetOutputs_Noop')(args);
+ }
+ if (memcmp(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_ZeroColset_enum], sizeof(E->xSetOutputs_signature)) == 0) {
+ return (6, 'fts5IterSetOutputs_ZeroColset')(args);
+ }


// Transform return E->xShmBarrier(args) to if-chain with 2 candidates
@transform_return_xShmBarrier_arrow@
expression E;
identifier FP_NAME = xShmBarrier;
expression list args;
@@
- return E->FP_NAME(args);


// Transform return E->xShmLock(args) to if-chain with 2 candidates
@transform_return_xShmLock_arrow@
expression E;
identifier FP_NAME = xShmLock;
expression list args;
@@
- return E->FP_NAME(args);


// Transform return E->xShmMap(args) to if-chain with 2 candidates
@transform_return_xShmMap_arrow@
expression E;
identifier FP_NAME = xShmMap;
expression list args;
@@
- return E->FP_NAME(args);


// Transform return E->xShmUnmap(args) to if-chain with 2 candidates
@transform_return_xShmUnmap_arrow@
expression E;
identifier FP_NAME = xShmUnmap;
expression list args;
@@
- return E->FP_NAME(args);


// Transform return E->xSleep(args) to if-chain with 2 candidates
@transform_return_xSleep_arrow@
expression E;
identifier FP_NAME = xSleep;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xSleep_signature, xSleep_signatures[xSleep_vfstraceSleep_enum], sizeof(E->xSleep_signature)) == 0) {
+ return (1, 'vfstraceSleep')(args);
+ }


// Transform return E->xSync(args) to if-chain with 3 candidates
@transform_return_xSync_arrow@
expression E;
identifier FP_NAME = xSync;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xSync_signature, xSync_signatures[xSync_vfstraceSync_enum], sizeof(E->xSync_signature)) == 0) {
+ return (2, 'vfstraceSync')(args);
+ }


// Transform return E->xTruncate(args) to if-chain with 3 candidates
@transform_return_xTruncate_arrow@
expression E;
identifier FP_NAME = xTruncate;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xTruncate_signature, xTruncate_signatures[xTruncate_vfstraceTruncate_enum], sizeof(E->xTruncate_signature)) == 0) {
+ return (2, 'vfstraceTruncate')(args);
+ }


// Transform return E->xUnlock(args) to if-chain with 3 candidates
@transform_return_xUnlock_arrow@
expression E;
identifier FP_NAME = xUnlock;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xUnlock_signature, xUnlock_signatures[xUnlock_vfstraceUnlock_enum], sizeof(E->xUnlock_signature)) == 0) {
+ return (2, 'vfstraceUnlock')(args);
+ }


// Transform return E->xWrite(args) to if-chain with 3 candidates
@transform_return_xWrite_arrow@
expression E;
identifier FP_NAME = xWrite;
expression list args;
@@
- return E->FP_NAME(args);
+ if (memcmp(E->xWrite_signature, xWrite_signatures[xWrite_vfstraceWrite_enum], sizeof(E->xWrite_signature)) == 0) {
+ return (2, 'vfstraceWrite')(args);
+ }

// Total return transformation rules generated: 37
// ===== RETURN FUNCTION POINTER TRANSFORMATION RULES =====

// Transform return E->xAccess(args) to if-chain with 2 candidates
@transform_return_xAccess@
expression E;
identifier FP_NAME = xAccess;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xAccess_signature, xAccess_signatures[xAccess_vfstraceAccess_enum], sizeof(E.xAccess_signature)) == 0) {
+ return vfstraceAccess(args);
+ }


// Transform return E->xAppend(args) to if-chain with 2 candidates
@transform_return_xAppend@
expression E;
identifier FP_NAME = xAppend;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xAppend_signature, xAppend_signatures[xAppend_fts5AppendPoslist_enum], sizeof(E.xAppend_signature)) == 0) {
+ return fts5AppendPoslist(args);
+ }
+ if (memcmp(E.xAppend_signature, xAppend_signatures[xAppend_fts5AppendRowid_enum], sizeof(E.xAppend_signature)) == 0) {
+ return fts5AppendRowid(args);
+ }


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


// Transform return E->xCheckReservedLock(args) to if-chain with 3 candidates
@transform_return_xCheckReservedLock@
expression E;
identifier FP_NAME = xCheckReservedLock;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_vfstraceCheckReservedLock_enum], sizeof(E.xCheckReservedLock_signature)) == 0) {
+ return vfstraceCheckReservedLock(args);
+ }


// Transform return E->xClose(args) to if-chain with 3 candidates
@transform_return_xClose@
expression E;
identifier FP_NAME = xClose;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xClose_signature, xClose_signatures[xClose_vfstraceClose_enum], sizeof(E.xClose_signature)) == 0) {
+ return vfstraceClose(args);
+ }


// Transform return E->xCount(args) to if-chain with 3 candidates
@transform_return_xCount@
expression E;
identifier FP_NAME = xCount;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xCount_signature, xCount_signatures[xCount_sessionDiffCount_enum], sizeof(E.xCount_signature)) == 0) {
+ return sessionDiffCount(args);
+ }
+ if (memcmp(E.xCount_signature, xCount_signatures[xCount_sessionPreupdateCount_enum], sizeof(E.xCount_signature)) == 0) {
+ return sessionPreupdateCount(args);
+ }
+ if (memcmp(E.xCount_signature, xCount_signatures[xCount_sessionStat1Count_enum], sizeof(E.xCount_signature)) == 0) {
+ return sessionStat1Count(args);
+ }


// Transform return E->xCurrentTime(args) to if-chain with 2 candidates
@transform_return_xCurrentTime@
expression E;
identifier FP_NAME = xCurrentTime;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_vfstraceCurrentTime_enum], sizeof(E.xCurrentTime_signature)) == 0) {
+ return vfstraceCurrentTime(args);
+ }


// Transform return E->xDelUser(args) to if-chain with 2 candidates
@transform_return_xDelUser@
expression E;
identifier FP_NAME = xDelUser;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xDelUser_signature, xDelUser_signatures[xDelUser_circle_del_enum], sizeof(E.xDelUser_signature)) == 0) {
+ return circle_del(args);
+ }
+ if (memcmp(E.xDelUser_signature, xDelUser_signatures[xDelUser_cube_context_free_enum], sizeof(E.xDelUser_signature)) == 0) {
+ return cube_context_free(args);
+ }


// Transform return E->xDepth(args) to if-chain with 3 candidates
@transform_return_xDepth@
expression E;
identifier FP_NAME = xDepth;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xDepth_signature, xDepth_signatures[xDepth_sessionDiffDepth_enum], sizeof(E.xDepth_signature)) == 0) {
+ return sessionDiffDepth(args);
+ }
+ if (memcmp(E.xDepth_signature, xDepth_signatures[xDepth_sessionPreupdateDepth_enum], sizeof(E.xDepth_signature)) == 0) {
+ return sessionPreupdateDepth(args);
+ }
+ if (memcmp(E.xDepth_signature, xDepth_signatures[xDepth_sessionStat1Depth_enum], sizeof(E.xDepth_signature)) == 0) {
+ return sessionStat1Depth(args);
+ }


// Transform return E->xDeviceCharacteristics(args) to if-chain with 3 candidates
@transform_return_xDeviceCharacteristics@
expression E;
identifier FP_NAME = xDeviceCharacteristics;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_vfstraceDeviceCharacteristics_enum], sizeof(E.xDeviceCharacteristics_signature)) == 0) {
+ return vfstraceDeviceCharacteristics(args);
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


// Transform return E->xFileControl(args) to if-chain with 3 candidates
@transform_return_xFileControl@
expression E;
identifier FP_NAME = xFileControl;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xFileControl_signature, xFileControl_signatures[xFileControl_vfstraceFileControl_enum], sizeof(E.xFileControl_signature)) == 0) {
+ return vfstraceFileControl(args);
+ }


// Transform return E->xFileSize(args) to if-chain with 3 candidates
@transform_return_xFileSize@
expression E;
identifier FP_NAME = xFileSize;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xFileSize_signature, xFileSize_signatures[xFileSize_vfstraceFileSize_enum], sizeof(E.xFileSize_signature)) == 0) {
+ return vfstraceFileSize(args);
+ }


// Transform return E->xFullPathname(args) to if-chain with 2 candidates
@transform_return_xFullPathname@
expression E;
identifier FP_NAME = xFullPathname;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xFullPathname_signature, xFullPathname_signatures[xFullPathname_vfstraceFullPathname_enum], sizeof(E.xFullPathname_signature)) == 0) {
+ return vfstraceFullPathname(args);
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


// Transform return E->xLock(args) to if-chain with 3 candidates
@transform_return_xLock@
expression E;
identifier FP_NAME = xLock;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xLock_signature, xLock_signatures[xLock_vfstraceLock_enum], sizeof(E.xLock_signature)) == 0) {
+ return vfstraceLock(args);
+ }


// Transform return E->xMerge(args) to if-chain with 2 candidates
@transform_return_xMerge@
expression E;
identifier FP_NAME = xMerge;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xMerge_signature, xMerge_signatures[xMerge_fts5MergePrefixLists_enum], sizeof(E.xMerge_signature)) == 0) {
+ return fts5MergePrefixLists(args);
+ }
+ if (memcmp(E.xMerge_signature, xMerge_signatures[xMerge_fts5MergeRowidLists_enum], sizeof(E.xMerge_signature)) == 0) {
+ return fts5MergeRowidLists(args);
+ }


// Transform return E->xNew(args) to if-chain with 3 candidates
@transform_return_xNew@
expression E;
identifier FP_NAME = xNew;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xNew_signature, xNew_signatures[xNew_sessionDiffNew_enum], sizeof(E.xNew_signature)) == 0) {
+ return sessionDiffNew(args);
+ }
+ if (memcmp(E.xNew_signature, xNew_signatures[xNew_sessionPreupdateNew_enum], sizeof(E.xNew_signature)) == 0) {
+ return sessionPreupdateNew(args);
+ }
+ if (memcmp(E.xNew_signature, xNew_signatures[xNew_sessionStat1New_enum], sizeof(E.xNew_signature)) == 0) {
+ return sessionStat1New(args);
+ }


// Transform return E->xNext(args) to if-chain with 8 candidates
@transform_return_xNext@
expression E;
identifier FP_NAME = xNext;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_AND_enum], sizeof(E.xNext_signature)) == 0) {
+ return fts5ExprNodeNext_AND(args);
+ }
+ if (memcmp(E.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_NOT_enum], sizeof(E.xNext_signature)) == 0) {
+ return fts5ExprNodeNext_NOT(args);
+ }
+ if (memcmp(E.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_OR_enum], sizeof(E.xNext_signature)) == 0) {
+ return fts5ExprNodeNext_OR(args);
+ }
+ if (memcmp(E.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_STRING_enum], sizeof(E.xNext_signature)) == 0) {
+ return fts5ExprNodeNext_STRING(args);
+ }
+ if (memcmp(E.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_TERM_enum], sizeof(E.xNext_signature)) == 0) {
+ return fts5ExprNodeNext_TERM(args);
+ }
+ if (memcmp(E.xNext_signature, xNext_signatures[xNext_fts5SegIterNext_enum], sizeof(E.xNext_signature)) == 0) {
+ return fts5SegIterNext(args);
+ }
+ if (memcmp(E.xNext_signature, xNext_signatures[xNext_fts5SegIterNext_None_enum], sizeof(E.xNext_signature)) == 0) {
+ return fts5SegIterNext_None(args);
+ }
+ if (memcmp(E.xNext_signature, xNext_signatures[xNext_fts5SegIterNext_Reverse_enum], sizeof(E.xNext_signature)) == 0) {
+ return fts5SegIterNext_Reverse(args);
+ }


// Transform return E->xOld(args) to if-chain with 3 candidates
@transform_return_xOld@
expression E;
identifier FP_NAME = xOld;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xOld_signature, xOld_signatures[xOld_sessionDiffOld_enum], sizeof(E.xOld_signature)) == 0) {
+ return sessionDiffOld(args);
+ }
+ if (memcmp(E.xOld_signature, xOld_signatures[xOld_sessionPreupdateOld_enum], sizeof(E.xOld_signature)) == 0) {
+ return sessionPreupdateOld(args);
+ }
+ if (memcmp(E.xOld_signature, xOld_signatures[xOld_sessionStat1Old_enum], sizeof(E.xOld_signature)) == 0) {
+ return sessionStat1Old(args);
+ }


// Transform return E->xOpen(args) to if-chain with 3 candidates
@transform_return_xOpen@
expression E;
identifier FP_NAME = xOpen;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xOpen_signature, xOpen_signatures[xOpen_vfstraceOpen_enum], sizeof(E.xOpen_signature)) == 0) {
+ return vfstraceOpen(args);
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


// Transform return E->xRandomness(args) to if-chain with 2 candidates
@transform_return_xRandomness@
expression E;
identifier FP_NAME = xRandomness;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xRandomness_signature, xRandomness_signatures[xRandomness_vfstraceRandomness_enum], sizeof(E.xRandomness_signature)) == 0) {
+ return vfstraceRandomness(args);
+ }


// Transform return E->xRead(args) to if-chain with 3 candidates
@transform_return_xRead@
expression E;
identifier FP_NAME = xRead;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xRead_signature, xRead_signatures[xRead_vfstraceRead_enum], sizeof(E.xRead_signature)) == 0) {
+ return vfstraceRead(args);
+ }


// Transform return E->xSectorSize(args) to if-chain with 3 candidates
@transform_return_xSectorSize@
expression E;
identifier FP_NAME = xSectorSize;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xSectorSize_signature, xSectorSize_signatures[xSectorSize_vfstraceSectorSize_enum], sizeof(E.xSectorSize_signature)) == 0) {
+ return vfstraceSectorSize(args);
+ }


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


// Transform return E->xSetOutputs(args) to if-chain with 7 candidates
@transform_return_xSetOutputs@
expression E;
identifier FP_NAME = xSetOutputs;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Col_enum], sizeof(E.xSetOutputs_signature)) == 0) {
+ return fts5IterSetOutputs_Col(args);
+ }
+ if (memcmp(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Col100_enum], sizeof(E.xSetOutputs_signature)) == 0) {
+ return fts5IterSetOutputs_Col100(args);
+ }
+ if (memcmp(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Full_enum], sizeof(E.xSetOutputs_signature)) == 0) {
+ return fts5IterSetOutputs_Full(args);
+ }
+ if (memcmp(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Nocolset_enum], sizeof(E.xSetOutputs_signature)) == 0) {
+ return fts5IterSetOutputs_Nocolset(args);
+ }
+ if (memcmp(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_None_enum], sizeof(E.xSetOutputs_signature)) == 0) {
+ return fts5IterSetOutputs_None(args);
+ }
+ if (memcmp(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Noop_enum], sizeof(E.xSetOutputs_signature)) == 0) {
+ return fts5IterSetOutputs_Noop(args);
+ }
+ if (memcmp(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_ZeroColset_enum], sizeof(E.xSetOutputs_signature)) == 0) {
+ return fts5IterSetOutputs_ZeroColset(args);
+ }


// Transform return E->xShmBarrier(args) to if-chain with 2 candidates
@transform_return_xShmBarrier@
expression E;
identifier FP_NAME = xShmBarrier;
expression list args;
@@
- return E.FP_NAME(args);


// Transform return E->xShmLock(args) to if-chain with 2 candidates
@transform_return_xShmLock@
expression E;
identifier FP_NAME = xShmLock;
expression list args;
@@
- return E.FP_NAME(args);


// Transform return E->xShmMap(args) to if-chain with 2 candidates
@transform_return_xShmMap@
expression E;
identifier FP_NAME = xShmMap;
expression list args;
@@
- return E.FP_NAME(args);


// Transform return E->xShmUnmap(args) to if-chain with 2 candidates
@transform_return_xShmUnmap@
expression E;
identifier FP_NAME = xShmUnmap;
expression list args;
@@
- return E.FP_NAME(args);


// Transform return E->xSleep(args) to if-chain with 2 candidates
@transform_return_xSleep@
expression E;
identifier FP_NAME = xSleep;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xSleep_signature, xSleep_signatures[xSleep_vfstraceSleep_enum], sizeof(E.xSleep_signature)) == 0) {
+ return vfstraceSleep(args);
+ }


// Transform return E->xSync(args) to if-chain with 3 candidates
@transform_return_xSync@
expression E;
identifier FP_NAME = xSync;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xSync_signature, xSync_signatures[xSync_vfstraceSync_enum], sizeof(E.xSync_signature)) == 0) {
+ return vfstraceSync(args);
+ }


// Transform return E->xTruncate(args) to if-chain with 3 candidates
@transform_return_xTruncate@
expression E;
identifier FP_NAME = xTruncate;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xTruncate_signature, xTruncate_signatures[xTruncate_vfstraceTruncate_enum], sizeof(E.xTruncate_signature)) == 0) {
+ return vfstraceTruncate(args);
+ }


// Transform return E->xUnlock(args) to if-chain with 3 candidates
@transform_return_xUnlock@
expression E;
identifier FP_NAME = xUnlock;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xUnlock_signature, xUnlock_signatures[xUnlock_vfstraceUnlock_enum], sizeof(E.xUnlock_signature)) == 0) {
+ return vfstraceUnlock(args);
+ }


// Transform return E->xWrite(args) to if-chain with 3 candidates
@transform_return_xWrite@
expression E;
identifier FP_NAME = xWrite;
expression list args;
@@
- return E.FP_NAME(args);
+ if (memcmp(E.xWrite_signature, xWrite_signatures[xWrite_vfstraceWrite_enum], sizeof(E.xWrite_signature)) == 0) {
+ return vfstraceWrite(args);
+ }

// Total return transformation rules generated: 37
// ===== RETURN FUNCTION POINTER TRANSFORMATION RULES =====

// Transform return E->xAccess(args) to if-chain with 2 candidates
@transform_no_return_xAccess_arrow@
expression E;
identifier FP_NAME = xAccess;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xAccess_signature, xAccess_signatures[xAccess_vfstraceAccess_enum], sizeof(E->xAccess_signature)) == 0) {
+ vfstraceAccess(args);
+ }


// Transform return E->xAppend(args) to if-chain with 2 candidates
@transform_no_return_xAppend_arrow@
expression E;
identifier FP_NAME = xAppend;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xAppend_signature, xAppend_signatures[xAppend_fts5AppendPoslist_enum], sizeof(E->xAppend_signature)) == 0) {
+ fts5AppendPoslist(args);
+ }
+ if (memcmp(E->xAppend_signature, xAppend_signatures[xAppend_fts5AppendRowid_enum], sizeof(E->xAppend_signature)) == 0) {
+ fts5AppendRowid(args);
+ }


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


// Transform return E->xCheckReservedLock(args) to if-chain with 3 candidates
@transform_no_return_xCheckReservedLock_arrow@
expression E;
identifier FP_NAME = xCheckReservedLock;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_vfstraceCheckReservedLock_enum], sizeof(E->xCheckReservedLock_signature)) == 0) {
+ vfstraceCheckReservedLock(args);
+ }


// Transform return E->xClose(args) to if-chain with 3 candidates
@transform_no_return_xClose_arrow@
expression E;
identifier FP_NAME = xClose;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xClose_signature, xClose_signatures[xClose_vfstraceClose_enum], sizeof(E->xClose_signature)) == 0) {
+ vfstraceClose(args);
+ }


// Transform return E->xCount(args) to if-chain with 3 candidates
@transform_no_return_xCount_arrow@
expression E;
identifier FP_NAME = xCount;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xCount_signature, xCount_signatures[xCount_sessionDiffCount_enum], sizeof(E->xCount_signature)) == 0) {
+ sessionDiffCount(args);
+ }
+ if (memcmp(E->xCount_signature, xCount_signatures[xCount_sessionPreupdateCount_enum], sizeof(E->xCount_signature)) == 0) {
+ sessionPreupdateCount(args);
+ }
+ if (memcmp(E->xCount_signature, xCount_signatures[xCount_sessionStat1Count_enum], sizeof(E->xCount_signature)) == 0) {
+ sessionStat1Count(args);
+ }


// Transform return E->xCurrentTime(args) to if-chain with 2 candidates
@transform_no_return_xCurrentTime_arrow@
expression E;
identifier FP_NAME = xCurrentTime;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_vfstraceCurrentTime_enum], sizeof(E->xCurrentTime_signature)) == 0) {
+ vfstraceCurrentTime(args);
+ }


// Transform return E->xDelUser(args) to if-chain with 2 candidates
@transform_no_return_xDelUser_arrow@
expression E;
identifier FP_NAME = xDelUser;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xDelUser_signature, xDelUser_signatures[xDelUser_circle_del_enum], sizeof(E->xDelUser_signature)) == 0) {
+ circle_del(args);
+ }
+ if (memcmp(E->xDelUser_signature, xDelUser_signatures[xDelUser_cube_context_free_enum], sizeof(E->xDelUser_signature)) == 0) {
+ cube_context_free(args);
+ }


// Transform return E->xDepth(args) to if-chain with 3 candidates
@transform_no_return_xDepth_arrow@
expression E;
identifier FP_NAME = xDepth;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xDepth_signature, xDepth_signatures[xDepth_sessionDiffDepth_enum], sizeof(E->xDepth_signature)) == 0) {
+ sessionDiffDepth(args);
+ }
+ if (memcmp(E->xDepth_signature, xDepth_signatures[xDepth_sessionPreupdateDepth_enum], sizeof(E->xDepth_signature)) == 0) {
+ sessionPreupdateDepth(args);
+ }
+ if (memcmp(E->xDepth_signature, xDepth_signatures[xDepth_sessionStat1Depth_enum], sizeof(E->xDepth_signature)) == 0) {
+ sessionStat1Depth(args);
+ }


// Transform return E->xDeviceCharacteristics(args) to if-chain with 3 candidates
@transform_no_return_xDeviceCharacteristics_arrow@
expression E;
identifier FP_NAME = xDeviceCharacteristics;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_vfstraceDeviceCharacteristics_enum], sizeof(E->xDeviceCharacteristics_signature)) == 0) {
+ vfstraceDeviceCharacteristics(args);
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


// Transform return E->xFileControl(args) to if-chain with 3 candidates
@transform_no_return_xFileControl_arrow@
expression E;
identifier FP_NAME = xFileControl;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xFileControl_signature, xFileControl_signatures[xFileControl_vfstraceFileControl_enum], sizeof(E->xFileControl_signature)) == 0) {
+ vfstraceFileControl(args);
+ }


// Transform return E->xFileSize(args) to if-chain with 3 candidates
@transform_no_return_xFileSize_arrow@
expression E;
identifier FP_NAME = xFileSize;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xFileSize_signature, xFileSize_signatures[xFileSize_vfstraceFileSize_enum], sizeof(E->xFileSize_signature)) == 0) {
+ vfstraceFileSize(args);
+ }


// Transform return E->xFullPathname(args) to if-chain with 2 candidates
@transform_no_return_xFullPathname_arrow@
expression E;
identifier FP_NAME = xFullPathname;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xFullPathname_signature, xFullPathname_signatures[xFullPathname_vfstraceFullPathname_enum], sizeof(E->xFullPathname_signature)) == 0) {
+ vfstraceFullPathname(args);
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


// Transform return E->xLock(args) to if-chain with 3 candidates
@transform_no_return_xLock_arrow@
expression E;
identifier FP_NAME = xLock;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xLock_signature, xLock_signatures[xLock_vfstraceLock_enum], sizeof(E->xLock_signature)) == 0) {
+ vfstraceLock(args);
+ }


// Transform return E->xMerge(args) to if-chain with 2 candidates
@transform_no_return_xMerge_arrow@
expression E;
identifier FP_NAME = xMerge;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xMerge_signature, xMerge_signatures[xMerge_fts5MergePrefixLists_enum], sizeof(E->xMerge_signature)) == 0) {
+ fts5MergePrefixLists(args);
+ }
+ if (memcmp(E->xMerge_signature, xMerge_signatures[xMerge_fts5MergeRowidLists_enum], sizeof(E->xMerge_signature)) == 0) {
+ fts5MergeRowidLists(args);
+ }


// Transform return E->xNew(args) to if-chain with 3 candidates
@transform_no_return_xNew_arrow@
expression E;
identifier FP_NAME = xNew;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xNew_signature, xNew_signatures[xNew_sessionDiffNew_enum], sizeof(E->xNew_signature)) == 0) {
+ sessionDiffNew(args);
+ }
+ if (memcmp(E->xNew_signature, xNew_signatures[xNew_sessionPreupdateNew_enum], sizeof(E->xNew_signature)) == 0) {
+ sessionPreupdateNew(args);
+ }
+ if (memcmp(E->xNew_signature, xNew_signatures[xNew_sessionStat1New_enum], sizeof(E->xNew_signature)) == 0) {
+ sessionStat1New(args);
+ }


// Transform return E->xNext(args) to if-chain with 8 candidates
@transform_no_return_xNext_arrow@
expression E;
identifier FP_NAME = xNext;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_AND_enum], sizeof(E->xNext_signature)) == 0) {
+ fts5ExprNodeNext_AND(args);
+ }
+ if (memcmp(E->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_NOT_enum], sizeof(E->xNext_signature)) == 0) {
+ fts5ExprNodeNext_NOT(args);
+ }
+ if (memcmp(E->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_OR_enum], sizeof(E->xNext_signature)) == 0) {
+ fts5ExprNodeNext_OR(args);
+ }
+ if (memcmp(E->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_STRING_enum], sizeof(E->xNext_signature)) == 0) {
+ fts5ExprNodeNext_STRING(args);
+ }
+ if (memcmp(E->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_TERM_enum], sizeof(E->xNext_signature)) == 0) {
+ fts5ExprNodeNext_TERM(args);
+ }
+ if (memcmp(E->xNext_signature, xNext_signatures[xNext_fts5SegIterNext_enum], sizeof(E->xNext_signature)) == 0) {
+ fts5SegIterNext(args);
+ }
+ if (memcmp(E->xNext_signature, xNext_signatures[xNext_fts5SegIterNext_None_enum], sizeof(E->xNext_signature)) == 0) {
+ fts5SegIterNext_None(args);
+ }
+ if (memcmp(E->xNext_signature, xNext_signatures[xNext_fts5SegIterNext_Reverse_enum], sizeof(E->xNext_signature)) == 0) {
+ fts5SegIterNext_Reverse(args);
+ }


// Transform return E->xOld(args) to if-chain with 3 candidates
@transform_no_return_xOld_arrow@
expression E;
identifier FP_NAME = xOld;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xOld_signature, xOld_signatures[xOld_sessionDiffOld_enum], sizeof(E->xOld_signature)) == 0) {
+ sessionDiffOld(args);
+ }
+ if (memcmp(E->xOld_signature, xOld_signatures[xOld_sessionPreupdateOld_enum], sizeof(E->xOld_signature)) == 0) {
+ sessionPreupdateOld(args);
+ }
+ if (memcmp(E->xOld_signature, xOld_signatures[xOld_sessionStat1Old_enum], sizeof(E->xOld_signature)) == 0) {
+ sessionStat1Old(args);
+ }


// Transform return E->xOpen(args) to if-chain with 3 candidates
@transform_no_return_xOpen_arrow@
expression E;
identifier FP_NAME = xOpen;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xOpen_signature, xOpen_signatures[xOpen_vfstraceOpen_enum], sizeof(E->xOpen_signature)) == 0) {
+ vfstraceOpen(args);
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


// Transform return E->xRandomness(args) to if-chain with 2 candidates
@transform_no_return_xRandomness_arrow@
expression E;
identifier FP_NAME = xRandomness;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xRandomness_signature, xRandomness_signatures[xRandomness_vfstraceRandomness_enum], sizeof(E->xRandomness_signature)) == 0) {
+ vfstraceRandomness(args);
+ }


// Transform return E->xRead(args) to if-chain with 3 candidates
@transform_no_return_xRead_arrow@
expression E;
identifier FP_NAME = xRead;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xRead_signature, xRead_signatures[xRead_vfstraceRead_enum], sizeof(E->xRead_signature)) == 0) {
+ vfstraceRead(args);
+ }


// Transform return E->xSectorSize(args) to if-chain with 3 candidates
@transform_no_return_xSectorSize_arrow@
expression E;
identifier FP_NAME = xSectorSize;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xSectorSize_signature, xSectorSize_signatures[xSectorSize_vfstraceSectorSize_enum], sizeof(E->xSectorSize_signature)) == 0) {
+ vfstraceSectorSize(args);
+ }


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


// Transform return E->xSetOutputs(args) to if-chain with 7 candidates
@transform_no_return_xSetOutputs_arrow@
expression E;
identifier FP_NAME = xSetOutputs;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Col_enum], sizeof(E->xSetOutputs_signature)) == 0) {
+ fts5IterSetOutputs_Col(args);
+ }
+ if (memcmp(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Col100_enum], sizeof(E->xSetOutputs_signature)) == 0) {
+ fts5IterSetOutputs_Col100(args);
+ }
+ if (memcmp(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Full_enum], sizeof(E->xSetOutputs_signature)) == 0) {
+ fts5IterSetOutputs_Full(args);
+ }
+ if (memcmp(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Nocolset_enum], sizeof(E->xSetOutputs_signature)) == 0) {
+ fts5IterSetOutputs_Nocolset(args);
+ }
+ if (memcmp(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_None_enum], sizeof(E->xSetOutputs_signature)) == 0) {
+ fts5IterSetOutputs_None(args);
+ }
+ if (memcmp(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Noop_enum], sizeof(E->xSetOutputs_signature)) == 0) {
+ fts5IterSetOutputs_Noop(args);
+ }
+ if (memcmp(E->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_ZeroColset_enum], sizeof(E->xSetOutputs_signature)) == 0) {
+ fts5IterSetOutputs_ZeroColset(args);
+ }


// Transform return E->xShmBarrier(args) to if-chain with 2 candidates
@transform_no_return_xShmBarrier_arrow@
expression E;
identifier FP_NAME = xShmBarrier;
expression list args;
@@
- E->FP_NAME(args);


// Transform return E->xShmLock(args) to if-chain with 2 candidates
@transform_no_return_xShmLock_arrow@
expression E;
identifier FP_NAME = xShmLock;
expression list args;
@@
- E->FP_NAME(args);


// Transform return E->xShmMap(args) to if-chain with 2 candidates
@transform_no_return_xShmMap_arrow@
expression E;
identifier FP_NAME = xShmMap;
expression list args;
@@
- E->FP_NAME(args);


// Transform return E->xShmUnmap(args) to if-chain with 2 candidates
@transform_no_return_xShmUnmap_arrow@
expression E;
identifier FP_NAME = xShmUnmap;
expression list args;
@@
- E->FP_NAME(args);


// Transform return E->xSleep(args) to if-chain with 2 candidates
@transform_no_return_xSleep_arrow@
expression E;
identifier FP_NAME = xSleep;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xSleep_signature, xSleep_signatures[xSleep_vfstraceSleep_enum], sizeof(E->xSleep_signature)) == 0) {
+ vfstraceSleep(args);
+ }


// Transform return E->xSync(args) to if-chain with 3 candidates
@transform_no_return_xSync_arrow@
expression E;
identifier FP_NAME = xSync;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xSync_signature, xSync_signatures[xSync_vfstraceSync_enum], sizeof(E->xSync_signature)) == 0) {
+ vfstraceSync(args);
+ }


// Transform return E->xTruncate(args) to if-chain with 3 candidates
@transform_no_return_xTruncate_arrow@
expression E;
identifier FP_NAME = xTruncate;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xTruncate_signature, xTruncate_signatures[xTruncate_vfstraceTruncate_enum], sizeof(E->xTruncate_signature)) == 0) {
+ vfstraceTruncate(args);
+ }


// Transform return E->xUnlock(args) to if-chain with 3 candidates
@transform_no_return_xUnlock_arrow@
expression E;
identifier FP_NAME = xUnlock;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xUnlock_signature, xUnlock_signatures[xUnlock_vfstraceUnlock_enum], sizeof(E->xUnlock_signature)) == 0) {
+ vfstraceUnlock(args);
+ }


// Transform return E->xWrite(args) to if-chain with 3 candidates
@transform_no_return_xWrite_arrow@
expression E;
identifier FP_NAME = xWrite;
expression list args;
@@
- E->FP_NAME(args);
+ if (memcmp(E->xWrite_signature, xWrite_signatures[xWrite_vfstraceWrite_enum], sizeof(E->xWrite_signature)) == 0) {
+ vfstraceWrite(args);
+ }

// Total no return transformation rules generated: 37
// ===== RETURN FUNCTION POINTER TRANSFORMATION RULES =====

// Transform return E->xAccess(args) to if-chain with 2 candidates
@transform_no_return_xAccess@
expression E;
identifier FP_NAME = xAccess;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xAccess_signature, xAccess_signatures[xAccess_vfstraceAccess_enum], sizeof(E.xAccess_signature)) == 0) {
+ vfstraceAccess(args);
+ }


// Transform return E->xAppend(args) to if-chain with 2 candidates
@transform_no_return_xAppend@
expression E;
identifier FP_NAME = xAppend;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xAppend_signature, xAppend_signatures[xAppend_fts5AppendPoslist_enum], sizeof(E.xAppend_signature)) == 0) {
+ fts5AppendPoslist(args);
+ }
+ if (memcmp(E.xAppend_signature, xAppend_signatures[xAppend_fts5AppendRowid_enum], sizeof(E.xAppend_signature)) == 0) {
+ fts5AppendRowid(args);
+ }


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


// Transform return E->xCheckReservedLock(args) to if-chain with 3 candidates
@transform_no_return_xCheckReservedLock@
expression E;
identifier FP_NAME = xCheckReservedLock;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_vfstraceCheckReservedLock_enum], sizeof(E.xCheckReservedLock_signature)) == 0) {
+ vfstraceCheckReservedLock(args);
+ }


// Transform return E->xClose(args) to if-chain with 3 candidates
@transform_no_return_xClose@
expression E;
identifier FP_NAME = xClose;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xClose_signature, xClose_signatures[xClose_vfstraceClose_enum], sizeof(E.xClose_signature)) == 0) {
+ vfstraceClose(args);
+ }


// Transform return E->xCount(args) to if-chain with 3 candidates
@transform_no_return_xCount@
expression E;
identifier FP_NAME = xCount;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xCount_signature, xCount_signatures[xCount_sessionDiffCount_enum], sizeof(E.xCount_signature)) == 0) {
+ sessionDiffCount(args);
+ }
+ if (memcmp(E.xCount_signature, xCount_signatures[xCount_sessionPreupdateCount_enum], sizeof(E.xCount_signature)) == 0) {
+ sessionPreupdateCount(args);
+ }
+ if (memcmp(E.xCount_signature, xCount_signatures[xCount_sessionStat1Count_enum], sizeof(E.xCount_signature)) == 0) {
+ sessionStat1Count(args);
+ }


// Transform return E->xCurrentTime(args) to if-chain with 2 candidates
@transform_no_return_xCurrentTime@
expression E;
identifier FP_NAME = xCurrentTime;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_vfstraceCurrentTime_enum], sizeof(E.xCurrentTime_signature)) == 0) {
+ vfstraceCurrentTime(args);
+ }


// Transform return E->xDelUser(args) to if-chain with 2 candidates
@transform_no_return_xDelUser@
expression E;
identifier FP_NAME = xDelUser;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xDelUser_signature, xDelUser_signatures[xDelUser_circle_del_enum], sizeof(E.xDelUser_signature)) == 0) {
+ circle_del(args);
+ }
+ if (memcmp(E.xDelUser_signature, xDelUser_signatures[xDelUser_cube_context_free_enum], sizeof(E.xDelUser_signature)) == 0) {
+ cube_context_free(args);
+ }


// Transform return E->xDepth(args) to if-chain with 3 candidates
@transform_no_return_xDepth@
expression E;
identifier FP_NAME = xDepth;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xDepth_signature, xDepth_signatures[xDepth_sessionDiffDepth_enum], sizeof(E.xDepth_signature)) == 0) {
+ sessionDiffDepth(args);
+ }
+ if (memcmp(E.xDepth_signature, xDepth_signatures[xDepth_sessionPreupdateDepth_enum], sizeof(E.xDepth_signature)) == 0) {
+ sessionPreupdateDepth(args);
+ }
+ if (memcmp(E.xDepth_signature, xDepth_signatures[xDepth_sessionStat1Depth_enum], sizeof(E.xDepth_signature)) == 0) {
+ sessionStat1Depth(args);
+ }


// Transform return E->xDeviceCharacteristics(args) to if-chain with 3 candidates
@transform_no_return_xDeviceCharacteristics@
expression E;
identifier FP_NAME = xDeviceCharacteristics;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_vfstraceDeviceCharacteristics_enum], sizeof(E.xDeviceCharacteristics_signature)) == 0) {
+ vfstraceDeviceCharacteristics(args);
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


// Transform return E->xFileControl(args) to if-chain with 3 candidates
@transform_no_return_xFileControl@
expression E;
identifier FP_NAME = xFileControl;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xFileControl_signature, xFileControl_signatures[xFileControl_vfstraceFileControl_enum], sizeof(E.xFileControl_signature)) == 0) {
+ vfstraceFileControl(args);
+ }


// Transform return E->xFileSize(args) to if-chain with 3 candidates
@transform_no_return_xFileSize@
expression E;
identifier FP_NAME = xFileSize;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xFileSize_signature, xFileSize_signatures[xFileSize_vfstraceFileSize_enum], sizeof(E.xFileSize_signature)) == 0) {
+ vfstraceFileSize(args);
+ }


// Transform return E->xFullPathname(args) to if-chain with 2 candidates
@transform_no_return_xFullPathname@
expression E;
identifier FP_NAME = xFullPathname;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xFullPathname_signature, xFullPathname_signatures[xFullPathname_vfstraceFullPathname_enum], sizeof(E.xFullPathname_signature)) == 0) {
+ vfstraceFullPathname(args);
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


// Transform return E->xLock(args) to if-chain with 3 candidates
@transform_no_return_xLock@
expression E;
identifier FP_NAME = xLock;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xLock_signature, xLock_signatures[xLock_vfstraceLock_enum], sizeof(E.xLock_signature)) == 0) {
+ vfstraceLock(args);
+ }


// Transform return E->xMerge(args) to if-chain with 2 candidates
@transform_no_return_xMerge@
expression E;
identifier FP_NAME = xMerge;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xMerge_signature, xMerge_signatures[xMerge_fts5MergePrefixLists_enum], sizeof(E.xMerge_signature)) == 0) {
+ fts5MergePrefixLists(args);
+ }
+ if (memcmp(E.xMerge_signature, xMerge_signatures[xMerge_fts5MergeRowidLists_enum], sizeof(E.xMerge_signature)) == 0) {
+ fts5MergeRowidLists(args);
+ }


// Transform return E->xNew(args) to if-chain with 3 candidates
@transform_no_return_xNew@
expression E;
identifier FP_NAME = xNew;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xNew_signature, xNew_signatures[xNew_sessionDiffNew_enum], sizeof(E.xNew_signature)) == 0) {
+ sessionDiffNew(args);
+ }
+ if (memcmp(E.xNew_signature, xNew_signatures[xNew_sessionPreupdateNew_enum], sizeof(E.xNew_signature)) == 0) {
+ sessionPreupdateNew(args);
+ }
+ if (memcmp(E.xNew_signature, xNew_signatures[xNew_sessionStat1New_enum], sizeof(E.xNew_signature)) == 0) {
+ sessionStat1New(args);
+ }


// Transform return E->xNext(args) to if-chain with 8 candidates
@transform_no_return_xNext@
expression E;
identifier FP_NAME = xNext;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_AND_enum], sizeof(E.xNext_signature)) == 0) {
+ fts5ExprNodeNext_AND(args);
+ }
+ if (memcmp(E.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_NOT_enum], sizeof(E.xNext_signature)) == 0) {
+ fts5ExprNodeNext_NOT(args);
+ }
+ if (memcmp(E.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_OR_enum], sizeof(E.xNext_signature)) == 0) {
+ fts5ExprNodeNext_OR(args);
+ }
+ if (memcmp(E.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_STRING_enum], sizeof(E.xNext_signature)) == 0) {
+ fts5ExprNodeNext_STRING(args);
+ }
+ if (memcmp(E.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_TERM_enum], sizeof(E.xNext_signature)) == 0) {
+ fts5ExprNodeNext_TERM(args);
+ }
+ if (memcmp(E.xNext_signature, xNext_signatures[xNext_fts5SegIterNext_enum], sizeof(E.xNext_signature)) == 0) {
+ fts5SegIterNext(args);
+ }
+ if (memcmp(E.xNext_signature, xNext_signatures[xNext_fts5SegIterNext_None_enum], sizeof(E.xNext_signature)) == 0) {
+ fts5SegIterNext_None(args);
+ }
+ if (memcmp(E.xNext_signature, xNext_signatures[xNext_fts5SegIterNext_Reverse_enum], sizeof(E.xNext_signature)) == 0) {
+ fts5SegIterNext_Reverse(args);
+ }


// Transform return E->xOld(args) to if-chain with 3 candidates
@transform_no_return_xOld@
expression E;
identifier FP_NAME = xOld;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xOld_signature, xOld_signatures[xOld_sessionDiffOld_enum], sizeof(E.xOld_signature)) == 0) {
+ sessionDiffOld(args);
+ }
+ if (memcmp(E.xOld_signature, xOld_signatures[xOld_sessionPreupdateOld_enum], sizeof(E.xOld_signature)) == 0) {
+ sessionPreupdateOld(args);
+ }
+ if (memcmp(E.xOld_signature, xOld_signatures[xOld_sessionStat1Old_enum], sizeof(E.xOld_signature)) == 0) {
+ sessionStat1Old(args);
+ }


// Transform return E->xOpen(args) to if-chain with 3 candidates
@transform_no_return_xOpen@
expression E;
identifier FP_NAME = xOpen;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xOpen_signature, xOpen_signatures[xOpen_vfstraceOpen_enum], sizeof(E.xOpen_signature)) == 0) {
+ vfstraceOpen(args);
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


// Transform return E->xRandomness(args) to if-chain with 2 candidates
@transform_no_return_xRandomness@
expression E;
identifier FP_NAME = xRandomness;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xRandomness_signature, xRandomness_signatures[xRandomness_vfstraceRandomness_enum], sizeof(E.xRandomness_signature)) == 0) {
+ vfstraceRandomness(args);
+ }


// Transform return E->xRead(args) to if-chain with 3 candidates
@transform_no_return_xRead@
expression E;
identifier FP_NAME = xRead;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xRead_signature, xRead_signatures[xRead_vfstraceRead_enum], sizeof(E.xRead_signature)) == 0) {
+ vfstraceRead(args);
+ }


// Transform return E->xSectorSize(args) to if-chain with 3 candidates
@transform_no_return_xSectorSize@
expression E;
identifier FP_NAME = xSectorSize;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xSectorSize_signature, xSectorSize_signatures[xSectorSize_vfstraceSectorSize_enum], sizeof(E.xSectorSize_signature)) == 0) {
+ vfstraceSectorSize(args);
+ }


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


// Transform return E->xSetOutputs(args) to if-chain with 7 candidates
@transform_no_return_xSetOutputs@
expression E;
identifier FP_NAME = xSetOutputs;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Col_enum], sizeof(E.xSetOutputs_signature)) == 0) {
+ fts5IterSetOutputs_Col(args);
+ }
+ if (memcmp(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Col100_enum], sizeof(E.xSetOutputs_signature)) == 0) {
+ fts5IterSetOutputs_Col100(args);
+ }
+ if (memcmp(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Full_enum], sizeof(E.xSetOutputs_signature)) == 0) {
+ fts5IterSetOutputs_Full(args);
+ }
+ if (memcmp(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Nocolset_enum], sizeof(E.xSetOutputs_signature)) == 0) {
+ fts5IterSetOutputs_Nocolset(args);
+ }
+ if (memcmp(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_None_enum], sizeof(E.xSetOutputs_signature)) == 0) {
+ fts5IterSetOutputs_None(args);
+ }
+ if (memcmp(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Noop_enum], sizeof(E.xSetOutputs_signature)) == 0) {
+ fts5IterSetOutputs_Noop(args);
+ }
+ if (memcmp(E.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_ZeroColset_enum], sizeof(E.xSetOutputs_signature)) == 0) {
+ fts5IterSetOutputs_ZeroColset(args);
+ }


// Transform return E->xShmBarrier(args) to if-chain with 2 candidates
@transform_no_return_xShmBarrier@
expression E;
identifier FP_NAME = xShmBarrier;
expression list args;
@@
- E.FP_NAME(args);


// Transform return E->xShmLock(args) to if-chain with 2 candidates
@transform_no_return_xShmLock@
expression E;
identifier FP_NAME = xShmLock;
expression list args;
@@
- E.FP_NAME(args);


// Transform return E->xShmMap(args) to if-chain with 2 candidates
@transform_no_return_xShmMap@
expression E;
identifier FP_NAME = xShmMap;
expression list args;
@@
- E.FP_NAME(args);


// Transform return E->xShmUnmap(args) to if-chain with 2 candidates
@transform_no_return_xShmUnmap@
expression E;
identifier FP_NAME = xShmUnmap;
expression list args;
@@
- E.FP_NAME(args);


// Transform return E->xSleep(args) to if-chain with 2 candidates
@transform_no_return_xSleep@
expression E;
identifier FP_NAME = xSleep;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xSleep_signature, xSleep_signatures[xSleep_vfstraceSleep_enum], sizeof(E.xSleep_signature)) == 0) {
+ vfstraceSleep(args);
+ }


// Transform return E->xSync(args) to if-chain with 3 candidates
@transform_no_return_xSync@
expression E;
identifier FP_NAME = xSync;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xSync_signature, xSync_signatures[xSync_vfstraceSync_enum], sizeof(E.xSync_signature)) == 0) {
+ vfstraceSync(args);
+ }


// Transform return E->xTruncate(args) to if-chain with 3 candidates
@transform_no_return_xTruncate@
expression E;
identifier FP_NAME = xTruncate;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xTruncate_signature, xTruncate_signatures[xTruncate_vfstraceTruncate_enum], sizeof(E.xTruncate_signature)) == 0) {
+ vfstraceTruncate(args);
+ }


// Transform return E->xUnlock(args) to if-chain with 3 candidates
@transform_no_return_xUnlock@
expression E;
identifier FP_NAME = xUnlock;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xUnlock_signature, xUnlock_signatures[xUnlock_vfstraceUnlock_enum], sizeof(E.xUnlock_signature)) == 0) {
+ vfstraceUnlock(args);
+ }


// Transform return E->xWrite(args) to if-chain with 3 candidates
@transform_no_return_xWrite@
expression E;
identifier FP_NAME = xWrite;
expression list args;
@@
- E.FP_NAME(args);
+ if (memcmp(E.xWrite_signature, xWrite_signatures[xWrite_vfstraceWrite_enum], sizeof(E.xWrite_signature)) == 0) {
+ vfstraceWrite(args);
+ }

// Total no return transformation rules generated: 37
// ===== RETURN FUNCTION POINTER TRANSFORMATION RULES =====

// Transform return E->xAccess(args) to if-chain with 2 candidates
@transform_assignment_xAccess_arrow@
expression E1, E2;
identifier FP_NAME = xAccess;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xAccess_signature, xAccess_signatures[xAccess_vfstraceAccess_enum], sizeof(E2->xAccess_signature)) == 0) {
+ E1 = vfstraceAccess(args);
+ }


// Transform return E->xAppend(args) to if-chain with 2 candidates
@transform_assignment_xAppend_arrow@
expression E1, E2;
identifier FP_NAME = xAppend;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xAppend_signature, xAppend_signatures[xAppend_fts5AppendPoslist_enum], sizeof(E2->xAppend_signature)) == 0) {
+ E1 = fts5AppendPoslist(args);
+ }
+ if (memcmp(E2->xAppend_signature, xAppend_signatures[xAppend_fts5AppendRowid_enum], sizeof(E2->xAppend_signature)) == 0) {
+ E1 = fts5AppendRowid(args);
+ }


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


// Transform return E->xCheckReservedLock(args) to if-chain with 3 candidates
@transform_assignment_xCheckReservedLock_arrow@
expression E1, E2;
identifier FP_NAME = xCheckReservedLock;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_vfstraceCheckReservedLock_enum], sizeof(E2->xCheckReservedLock_signature)) == 0) {
+ E1 = vfstraceCheckReservedLock(args);
+ }


// Transform return E->xClose(args) to if-chain with 3 candidates
@transform_assignment_xClose_arrow@
expression E1, E2;
identifier FP_NAME = xClose;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xClose_signature, xClose_signatures[xClose_vfstraceClose_enum], sizeof(E2->xClose_signature)) == 0) {
+ E1 = vfstraceClose(args);
+ }


// Transform return E->xCount(args) to if-chain with 3 candidates
@transform_assignment_xCount_arrow@
expression E1, E2;
identifier FP_NAME = xCount;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xCount_signature, xCount_signatures[xCount_sessionDiffCount_enum], sizeof(E2->xCount_signature)) == 0) {
+ E1 = sessionDiffCount(args);
+ }
+ if (memcmp(E2->xCount_signature, xCount_signatures[xCount_sessionPreupdateCount_enum], sizeof(E2->xCount_signature)) == 0) {
+ E1 = sessionPreupdateCount(args);
+ }
+ if (memcmp(E2->xCount_signature, xCount_signatures[xCount_sessionStat1Count_enum], sizeof(E2->xCount_signature)) == 0) {
+ E1 = sessionStat1Count(args);
+ }


// Transform return E->xCurrentTime(args) to if-chain with 2 candidates
@transform_assignment_xCurrentTime_arrow@
expression E1, E2;
identifier FP_NAME = xCurrentTime;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_vfstraceCurrentTime_enum], sizeof(E2->xCurrentTime_signature)) == 0) {
+ E1 = vfstraceCurrentTime(args);
+ }


// Transform return E->xDelUser(args) to if-chain with 2 candidates
@transform_assignment_xDelUser_arrow@
expression E1, E2;
identifier FP_NAME = xDelUser;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xDelUser_signature, xDelUser_signatures[xDelUser_circle_del_enum], sizeof(E2->xDelUser_signature)) == 0) {
+ E1 = circle_del(args);
+ }
+ if (memcmp(E2->xDelUser_signature, xDelUser_signatures[xDelUser_cube_context_free_enum], sizeof(E2->xDelUser_signature)) == 0) {
+ E1 = cube_context_free(args);
+ }


// Transform return E->xDepth(args) to if-chain with 3 candidates
@transform_assignment_xDepth_arrow@
expression E1, E2;
identifier FP_NAME = xDepth;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xDepth_signature, xDepth_signatures[xDepth_sessionDiffDepth_enum], sizeof(E2->xDepth_signature)) == 0) {
+ E1 = sessionDiffDepth(args);
+ }
+ if (memcmp(E2->xDepth_signature, xDepth_signatures[xDepth_sessionPreupdateDepth_enum], sizeof(E2->xDepth_signature)) == 0) {
+ E1 = sessionPreupdateDepth(args);
+ }
+ if (memcmp(E2->xDepth_signature, xDepth_signatures[xDepth_sessionStat1Depth_enum], sizeof(E2->xDepth_signature)) == 0) {
+ E1 = sessionStat1Depth(args);
+ }


// Transform return E->xDeviceCharacteristics(args) to if-chain with 3 candidates
@transform_assignment_xDeviceCharacteristics_arrow@
expression E1, E2;
identifier FP_NAME = xDeviceCharacteristics;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_vfstraceDeviceCharacteristics_enum], sizeof(E2->xDeviceCharacteristics_signature)) == 0) {
+ E1 = vfstraceDeviceCharacteristics(args);
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


// Transform return E->xFileControl(args) to if-chain with 3 candidates
@transform_assignment_xFileControl_arrow@
expression E1, E2;
identifier FP_NAME = xFileControl;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xFileControl_signature, xFileControl_signatures[xFileControl_vfstraceFileControl_enum], sizeof(E2->xFileControl_signature)) == 0) {
+ E1 = vfstraceFileControl(args);
+ }


// Transform return E->xFileSize(args) to if-chain with 3 candidates
@transform_assignment_xFileSize_arrow@
expression E1, E2;
identifier FP_NAME = xFileSize;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xFileSize_signature, xFileSize_signatures[xFileSize_vfstraceFileSize_enum], sizeof(E2->xFileSize_signature)) == 0) {
+ E1 = vfstraceFileSize(args);
+ }


// Transform return E->xFullPathname(args) to if-chain with 2 candidates
@transform_assignment_xFullPathname_arrow@
expression E1, E2;
identifier FP_NAME = xFullPathname;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xFullPathname_signature, xFullPathname_signatures[xFullPathname_vfstraceFullPathname_enum], sizeof(E2->xFullPathname_signature)) == 0) {
+ E1 = vfstraceFullPathname(args);
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


// Transform return E->xLock(args) to if-chain with 3 candidates
@transform_assignment_xLock_arrow@
expression E1, E2;
identifier FP_NAME = xLock;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xLock_signature, xLock_signatures[xLock_vfstraceLock_enum], sizeof(E2->xLock_signature)) == 0) {
+ E1 = vfstraceLock(args);
+ }


// Transform return E->xMerge(args) to if-chain with 2 candidates
@transform_assignment_xMerge_arrow@
expression E1, E2;
identifier FP_NAME = xMerge;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xMerge_signature, xMerge_signatures[xMerge_fts5MergePrefixLists_enum], sizeof(E2->xMerge_signature)) == 0) {
+ E1 = fts5MergePrefixLists(args);
+ }
+ if (memcmp(E2->xMerge_signature, xMerge_signatures[xMerge_fts5MergeRowidLists_enum], sizeof(E2->xMerge_signature)) == 0) {
+ E1 = fts5MergeRowidLists(args);
+ }


// Transform return E->xNew(args) to if-chain with 3 candidates
@transform_assignment_xNew_arrow@
expression E1, E2;
identifier FP_NAME = xNew;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xNew_signature, xNew_signatures[xNew_sessionDiffNew_enum], sizeof(E2->xNew_signature)) == 0) {
+ E1 = sessionDiffNew(args);
+ }
+ if (memcmp(E2->xNew_signature, xNew_signatures[xNew_sessionPreupdateNew_enum], sizeof(E2->xNew_signature)) == 0) {
+ E1 = sessionPreupdateNew(args);
+ }
+ if (memcmp(E2->xNew_signature, xNew_signatures[xNew_sessionStat1New_enum], sizeof(E2->xNew_signature)) == 0) {
+ E1 = sessionStat1New(args);
+ }


// Transform return E->xNext(args) to if-chain with 8 candidates
@transform_assignment_xNext_arrow@
expression E1, E2;
identifier FP_NAME = xNext;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_AND_enum], sizeof(E2->xNext_signature)) == 0) {
+ E1 = fts5ExprNodeNext_AND(args);
+ }
+ if (memcmp(E2->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_NOT_enum], sizeof(E2->xNext_signature)) == 0) {
+ E1 = fts5ExprNodeNext_NOT(args);
+ }
+ if (memcmp(E2->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_OR_enum], sizeof(E2->xNext_signature)) == 0) {
+ E1 = fts5ExprNodeNext_OR(args);
+ }
+ if (memcmp(E2->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_STRING_enum], sizeof(E2->xNext_signature)) == 0) {
+ E1 = fts5ExprNodeNext_STRING(args);
+ }
+ if (memcmp(E2->xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_TERM_enum], sizeof(E2->xNext_signature)) == 0) {
+ E1 = fts5ExprNodeNext_TERM(args);
+ }
+ if (memcmp(E2->xNext_signature, xNext_signatures[xNext_fts5SegIterNext_enum], sizeof(E2->xNext_signature)) == 0) {
+ E1 = fts5SegIterNext(args);
+ }
+ if (memcmp(E2->xNext_signature, xNext_signatures[xNext_fts5SegIterNext_None_enum], sizeof(E2->xNext_signature)) == 0) {
+ E1 = fts5SegIterNext_None(args);
+ }
+ if (memcmp(E2->xNext_signature, xNext_signatures[xNext_fts5SegIterNext_Reverse_enum], sizeof(E2->xNext_signature)) == 0) {
+ E1 = fts5SegIterNext_Reverse(args);
+ }


// Transform return E->xOld(args) to if-chain with 3 candidates
@transform_assignment_xOld_arrow@
expression E1, E2;
identifier FP_NAME = xOld;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xOld_signature, xOld_signatures[xOld_sessionDiffOld_enum], sizeof(E2->xOld_signature)) == 0) {
+ E1 = sessionDiffOld(args);
+ }
+ if (memcmp(E2->xOld_signature, xOld_signatures[xOld_sessionPreupdateOld_enum], sizeof(E2->xOld_signature)) == 0) {
+ E1 = sessionPreupdateOld(args);
+ }
+ if (memcmp(E2->xOld_signature, xOld_signatures[xOld_sessionStat1Old_enum], sizeof(E2->xOld_signature)) == 0) {
+ E1 = sessionStat1Old(args);
+ }


// Transform return E->xOpen(args) to if-chain with 3 candidates
@transform_assignment_xOpen_arrow@
expression E1, E2;
identifier FP_NAME = xOpen;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xOpen_signature, xOpen_signatures[xOpen_vfstraceOpen_enum], sizeof(E2->xOpen_signature)) == 0) {
+ E1 = vfstraceOpen(args);
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


// Transform return E->xRandomness(args) to if-chain with 2 candidates
@transform_assignment_xRandomness_arrow@
expression E1, E2;
identifier FP_NAME = xRandomness;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xRandomness_signature, xRandomness_signatures[xRandomness_vfstraceRandomness_enum], sizeof(E2->xRandomness_signature)) == 0) {
+ E1 = vfstraceRandomness(args);
+ }


// Transform return E->xRead(args) to if-chain with 3 candidates
@transform_assignment_xRead_arrow@
expression E1, E2;
identifier FP_NAME = xRead;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xRead_signature, xRead_signatures[xRead_vfstraceRead_enum], sizeof(E2->xRead_signature)) == 0) {
+ E1 = vfstraceRead(args);
+ }


// Transform return E->xSectorSize(args) to if-chain with 3 candidates
@transform_assignment_xSectorSize_arrow@
expression E1, E2;
identifier FP_NAME = xSectorSize;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xSectorSize_signature, xSectorSize_signatures[xSectorSize_vfstraceSectorSize_enum], sizeof(E2->xSectorSize_signature)) == 0) {
+ E1 = vfstraceSectorSize(args);
+ }


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


// Transform return E->xSetOutputs(args) to if-chain with 7 candidates
@transform_assignment_xSetOutputs_arrow@
expression E1, E2;
identifier FP_NAME = xSetOutputs;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Col_enum], sizeof(E2->xSetOutputs_signature)) == 0) {
+ E1 = fts5IterSetOutputs_Col(args);
+ }
+ if (memcmp(E2->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Col100_enum], sizeof(E2->xSetOutputs_signature)) == 0) {
+ E1 = fts5IterSetOutputs_Col100(args);
+ }
+ if (memcmp(E2->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Full_enum], sizeof(E2->xSetOutputs_signature)) == 0) {
+ E1 = fts5IterSetOutputs_Full(args);
+ }
+ if (memcmp(E2->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Nocolset_enum], sizeof(E2->xSetOutputs_signature)) == 0) {
+ E1 = fts5IterSetOutputs_Nocolset(args);
+ }
+ if (memcmp(E2->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_None_enum], sizeof(E2->xSetOutputs_signature)) == 0) {
+ E1 = fts5IterSetOutputs_None(args);
+ }
+ if (memcmp(E2->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Noop_enum], sizeof(E2->xSetOutputs_signature)) == 0) {
+ E1 = fts5IterSetOutputs_Noop(args);
+ }
+ if (memcmp(E2->xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_ZeroColset_enum], sizeof(E2->xSetOutputs_signature)) == 0) {
+ E1 = fts5IterSetOutputs_ZeroColset(args);
+ }


// Transform return E->xShmBarrier(args) to if-chain with 2 candidates
@transform_assignment_xShmBarrier_arrow@
expression E1, E2;
identifier FP_NAME = xShmBarrier;
expression list args;
@@
- E1 = E2->FP_NAME(args);


// Transform return E->xShmLock(args) to if-chain with 2 candidates
@transform_assignment_xShmLock_arrow@
expression E1, E2;
identifier FP_NAME = xShmLock;
expression list args;
@@
- E1 = E2->FP_NAME(args);


// Transform return E->xShmMap(args) to if-chain with 2 candidates
@transform_assignment_xShmMap_arrow@
expression E1, E2;
identifier FP_NAME = xShmMap;
expression list args;
@@
- E1 = E2->FP_NAME(args);


// Transform return E->xShmUnmap(args) to if-chain with 2 candidates
@transform_assignment_xShmUnmap_arrow@
expression E1, E2;
identifier FP_NAME = xShmUnmap;
expression list args;
@@
- E1 = E2->FP_NAME(args);


// Transform return E->xSleep(args) to if-chain with 2 candidates
@transform_assignment_xSleep_arrow@
expression E1, E2;
identifier FP_NAME = xSleep;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xSleep_signature, xSleep_signatures[xSleep_vfstraceSleep_enum], sizeof(E2->xSleep_signature)) == 0) {
+ E1 = vfstraceSleep(args);
+ }


// Transform return E->xSync(args) to if-chain with 3 candidates
@transform_assignment_xSync_arrow@
expression E1, E2;
identifier FP_NAME = xSync;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xSync_signature, xSync_signatures[xSync_vfstraceSync_enum], sizeof(E2->xSync_signature)) == 0) {
+ E1 = vfstraceSync(args);
+ }


// Transform return E->xTruncate(args) to if-chain with 3 candidates
@transform_assignment_xTruncate_arrow@
expression E1, E2;
identifier FP_NAME = xTruncate;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xTruncate_signature, xTruncate_signatures[xTruncate_vfstraceTruncate_enum], sizeof(E2->xTruncate_signature)) == 0) {
+ E1 = vfstraceTruncate(args);
+ }


// Transform return E->xUnlock(args) to if-chain with 3 candidates
@transform_assignment_xUnlock_arrow@
expression E1, E2;
identifier FP_NAME = xUnlock;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xUnlock_signature, xUnlock_signatures[xUnlock_vfstraceUnlock_enum], sizeof(E2->xUnlock_signature)) == 0) {
+ E1 = vfstraceUnlock(args);
+ }


// Transform return E->xWrite(args) to if-chain with 3 candidates
@transform_assignment_xWrite_arrow@
expression E1, E2;
identifier FP_NAME = xWrite;
expression list args;
@@
- E1 = E2->FP_NAME(args);
+ if (memcmp(E2->xWrite_signature, xWrite_signatures[xWrite_vfstraceWrite_enum], sizeof(E2->xWrite_signature)) == 0) {
+ E1 = vfstraceWrite(args);
+ }

// Total assignment transformation rules generated: 37
// ===== RETURN FUNCTION POINTER TRANSFORMATION RULES =====

// Transform return E->xAccess(args) to if-chain with 2 candidates
@transform_assignment_xAccess@
expression E1, E2;
identifier FP_NAME = xAccess;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xAccess_signature, xAccess_signatures[xAccess_vfstraceAccess_enum], sizeof(E2.xAccess_signature)) == 0) {
+ E1 = vfstraceAccess(args);
+ }


// Transform return E->xAppend(args) to if-chain with 2 candidates
@transform_assignment_xAppend@
expression E1, E2;
identifier FP_NAME = xAppend;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xAppend_signature, xAppend_signatures[xAppend_fts5AppendPoslist_enum], sizeof(E2.xAppend_signature)) == 0) {
+ E1 = fts5AppendPoslist(args);
+ }
+ if (memcmp(E2.xAppend_signature, xAppend_signatures[xAppend_fts5AppendRowid_enum], sizeof(E2.xAppend_signature)) == 0) {
+ E1 = fts5AppendRowid(args);
+ }


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


// Transform return E->xCheckReservedLock(args) to if-chain with 3 candidates
@transform_assignment_xCheckReservedLock@
expression E1, E2;
identifier FP_NAME = xCheckReservedLock;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_vfstraceCheckReservedLock_enum], sizeof(E2.xCheckReservedLock_signature)) == 0) {
+ E1 = vfstraceCheckReservedLock(args);
+ }


// Transform return E->xClose(args) to if-chain with 3 candidates
@transform_assignment_xClose@
expression E1, E2;
identifier FP_NAME = xClose;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xClose_signature, xClose_signatures[xClose_vfstraceClose_enum], sizeof(E2.xClose_signature)) == 0) {
+ E1 = vfstraceClose(args);
+ }


// Transform return E->xCount(args) to if-chain with 3 candidates
@transform_assignment_xCount@
expression E1, E2;
identifier FP_NAME = xCount;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xCount_signature, xCount_signatures[xCount_sessionDiffCount_enum], sizeof(E2.xCount_signature)) == 0) {
+ E1 = sessionDiffCount(args);
+ }
+ if (memcmp(E2.xCount_signature, xCount_signatures[xCount_sessionPreupdateCount_enum], sizeof(E2.xCount_signature)) == 0) {
+ E1 = sessionPreupdateCount(args);
+ }
+ if (memcmp(E2.xCount_signature, xCount_signatures[xCount_sessionStat1Count_enum], sizeof(E2.xCount_signature)) == 0) {
+ E1 = sessionStat1Count(args);
+ }


// Transform return E->xCurrentTime(args) to if-chain with 2 candidates
@transform_assignment_xCurrentTime@
expression E1, E2;
identifier FP_NAME = xCurrentTime;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_vfstraceCurrentTime_enum], sizeof(E2.xCurrentTime_signature)) == 0) {
+ E1 = vfstraceCurrentTime(args);
+ }


// Transform return E->xDelUser(args) to if-chain with 2 candidates
@transform_assignment_xDelUser@
expression E1, E2;
identifier FP_NAME = xDelUser;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xDelUser_signature, xDelUser_signatures[xDelUser_circle_del_enum], sizeof(E2.xDelUser_signature)) == 0) {
+ E1 = circle_del(args);
+ }
+ if (memcmp(E2.xDelUser_signature, xDelUser_signatures[xDelUser_cube_context_free_enum], sizeof(E2.xDelUser_signature)) == 0) {
+ E1 = cube_context_free(args);
+ }


// Transform return E->xDepth(args) to if-chain with 3 candidates
@transform_assignment_xDepth@
expression E1, E2;
identifier FP_NAME = xDepth;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xDepth_signature, xDepth_signatures[xDepth_sessionDiffDepth_enum], sizeof(E2.xDepth_signature)) == 0) {
+ E1 = sessionDiffDepth(args);
+ }
+ if (memcmp(E2.xDepth_signature, xDepth_signatures[xDepth_sessionPreupdateDepth_enum], sizeof(E2.xDepth_signature)) == 0) {
+ E1 = sessionPreupdateDepth(args);
+ }
+ if (memcmp(E2.xDepth_signature, xDepth_signatures[xDepth_sessionStat1Depth_enum], sizeof(E2.xDepth_signature)) == 0) {
+ E1 = sessionStat1Depth(args);
+ }


// Transform return E->xDeviceCharacteristics(args) to if-chain with 3 candidates
@transform_assignment_xDeviceCharacteristics@
expression E1, E2;
identifier FP_NAME = xDeviceCharacteristics;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_vfstraceDeviceCharacteristics_enum], sizeof(E2.xDeviceCharacteristics_signature)) == 0) {
+ E1 = vfstraceDeviceCharacteristics(args);
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


// Transform return E->xFileControl(args) to if-chain with 3 candidates
@transform_assignment_xFileControl@
expression E1, E2;
identifier FP_NAME = xFileControl;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xFileControl_signature, xFileControl_signatures[xFileControl_vfstraceFileControl_enum], sizeof(E2.xFileControl_signature)) == 0) {
+ E1 = vfstraceFileControl(args);
+ }


// Transform return E->xFileSize(args) to if-chain with 3 candidates
@transform_assignment_xFileSize@
expression E1, E2;
identifier FP_NAME = xFileSize;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xFileSize_signature, xFileSize_signatures[xFileSize_vfstraceFileSize_enum], sizeof(E2.xFileSize_signature)) == 0) {
+ E1 = vfstraceFileSize(args);
+ }


// Transform return E->xFullPathname(args) to if-chain with 2 candidates
@transform_assignment_xFullPathname@
expression E1, E2;
identifier FP_NAME = xFullPathname;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xFullPathname_signature, xFullPathname_signatures[xFullPathname_vfstraceFullPathname_enum], sizeof(E2.xFullPathname_signature)) == 0) {
+ E1 = vfstraceFullPathname(args);
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


// Transform return E->xLock(args) to if-chain with 3 candidates
@transform_assignment_xLock@
expression E1, E2;
identifier FP_NAME = xLock;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xLock_signature, xLock_signatures[xLock_vfstraceLock_enum], sizeof(E2.xLock_signature)) == 0) {
+ E1 = vfstraceLock(args);
+ }


// Transform return E->xMerge(args) to if-chain with 2 candidates
@transform_assignment_xMerge@
expression E1, E2;
identifier FP_NAME = xMerge;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xMerge_signature, xMerge_signatures[xMerge_fts5MergePrefixLists_enum], sizeof(E2.xMerge_signature)) == 0) {
+ E1 = fts5MergePrefixLists(args);
+ }
+ if (memcmp(E2.xMerge_signature, xMerge_signatures[xMerge_fts5MergeRowidLists_enum], sizeof(E2.xMerge_signature)) == 0) {
+ E1 = fts5MergeRowidLists(args);
+ }


// Transform return E->xNew(args) to if-chain with 3 candidates
@transform_assignment_xNew@
expression E1, E2;
identifier FP_NAME = xNew;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xNew_signature, xNew_signatures[xNew_sessionDiffNew_enum], sizeof(E2.xNew_signature)) == 0) {
+ E1 = sessionDiffNew(args);
+ }
+ if (memcmp(E2.xNew_signature, xNew_signatures[xNew_sessionPreupdateNew_enum], sizeof(E2.xNew_signature)) == 0) {
+ E1 = sessionPreupdateNew(args);
+ }
+ if (memcmp(E2.xNew_signature, xNew_signatures[xNew_sessionStat1New_enum], sizeof(E2.xNew_signature)) == 0) {
+ E1 = sessionStat1New(args);
+ }


// Transform return E->xNext(args) to if-chain with 8 candidates
@transform_assignment_xNext@
expression E1, E2;
identifier FP_NAME = xNext;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_AND_enum], sizeof(E2.xNext_signature)) == 0) {
+ E1 = fts5ExprNodeNext_AND(args);
+ }
+ if (memcmp(E2.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_NOT_enum], sizeof(E2.xNext_signature)) == 0) {
+ E1 = fts5ExprNodeNext_NOT(args);
+ }
+ if (memcmp(E2.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_OR_enum], sizeof(E2.xNext_signature)) == 0) {
+ E1 = fts5ExprNodeNext_OR(args);
+ }
+ if (memcmp(E2.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_STRING_enum], sizeof(E2.xNext_signature)) == 0) {
+ E1 = fts5ExprNodeNext_STRING(args);
+ }
+ if (memcmp(E2.xNext_signature, xNext_signatures[xNext_fts5ExprNodeNext_TERM_enum], sizeof(E2.xNext_signature)) == 0) {
+ E1 = fts5ExprNodeNext_TERM(args);
+ }
+ if (memcmp(E2.xNext_signature, xNext_signatures[xNext_fts5SegIterNext_enum], sizeof(E2.xNext_signature)) == 0) {
+ E1 = fts5SegIterNext(args);
+ }
+ if (memcmp(E2.xNext_signature, xNext_signatures[xNext_fts5SegIterNext_None_enum], sizeof(E2.xNext_signature)) == 0) {
+ E1 = fts5SegIterNext_None(args);
+ }
+ if (memcmp(E2.xNext_signature, xNext_signatures[xNext_fts5SegIterNext_Reverse_enum], sizeof(E2.xNext_signature)) == 0) {
+ E1 = fts5SegIterNext_Reverse(args);
+ }


// Transform return E->xOld(args) to if-chain with 3 candidates
@transform_assignment_xOld@
expression E1, E2;
identifier FP_NAME = xOld;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xOld_signature, xOld_signatures[xOld_sessionDiffOld_enum], sizeof(E2.xOld_signature)) == 0) {
+ E1 = sessionDiffOld(args);
+ }
+ if (memcmp(E2.xOld_signature, xOld_signatures[xOld_sessionPreupdateOld_enum], sizeof(E2.xOld_signature)) == 0) {
+ E1 = sessionPreupdateOld(args);
+ }
+ if (memcmp(E2.xOld_signature, xOld_signatures[xOld_sessionStat1Old_enum], sizeof(E2.xOld_signature)) == 0) {
+ E1 = sessionStat1Old(args);
+ }


// Transform return E->xOpen(args) to if-chain with 3 candidates
@transform_assignment_xOpen@
expression E1, E2;
identifier FP_NAME = xOpen;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xOpen_signature, xOpen_signatures[xOpen_vfstraceOpen_enum], sizeof(E2.xOpen_signature)) == 0) {
+ E1 = vfstraceOpen(args);
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


// Transform return E->xRandomness(args) to if-chain with 2 candidates
@transform_assignment_xRandomness@
expression E1, E2;
identifier FP_NAME = xRandomness;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xRandomness_signature, xRandomness_signatures[xRandomness_vfstraceRandomness_enum], sizeof(E2.xRandomness_signature)) == 0) {
+ E1 = vfstraceRandomness(args);
+ }


// Transform return E->xRead(args) to if-chain with 3 candidates
@transform_assignment_xRead@
expression E1, E2;
identifier FP_NAME = xRead;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xRead_signature, xRead_signatures[xRead_vfstraceRead_enum], sizeof(E2.xRead_signature)) == 0) {
+ E1 = vfstraceRead(args);
+ }


// Transform return E->xSectorSize(args) to if-chain with 3 candidates
@transform_assignment_xSectorSize@
expression E1, E2;
identifier FP_NAME = xSectorSize;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xSectorSize_signature, xSectorSize_signatures[xSectorSize_vfstraceSectorSize_enum], sizeof(E2.xSectorSize_signature)) == 0) {
+ E1 = vfstraceSectorSize(args);
+ }


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


// Transform return E->xSetOutputs(args) to if-chain with 7 candidates
@transform_assignment_xSetOutputs@
expression E1, E2;
identifier FP_NAME = xSetOutputs;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Col_enum], sizeof(E2.xSetOutputs_signature)) == 0) {
+ E1 = fts5IterSetOutputs_Col(args);
+ }
+ if (memcmp(E2.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Col100_enum], sizeof(E2.xSetOutputs_signature)) == 0) {
+ E1 = fts5IterSetOutputs_Col100(args);
+ }
+ if (memcmp(E2.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Full_enum], sizeof(E2.xSetOutputs_signature)) == 0) {
+ E1 = fts5IterSetOutputs_Full(args);
+ }
+ if (memcmp(E2.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Nocolset_enum], sizeof(E2.xSetOutputs_signature)) == 0) {
+ E1 = fts5IterSetOutputs_Nocolset(args);
+ }
+ if (memcmp(E2.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_None_enum], sizeof(E2.xSetOutputs_signature)) == 0) {
+ E1 = fts5IterSetOutputs_None(args);
+ }
+ if (memcmp(E2.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_Noop_enum], sizeof(E2.xSetOutputs_signature)) == 0) {
+ E1 = fts5IterSetOutputs_Noop(args);
+ }
+ if (memcmp(E2.xSetOutputs_signature, xSetOutputs_signatures[xSetOutputs_fts5IterSetOutputs_ZeroColset_enum], sizeof(E2.xSetOutputs_signature)) == 0) {
+ E1 = fts5IterSetOutputs_ZeroColset(args);
+ }


// Transform return E->xShmBarrier(args) to if-chain with 2 candidates
@transform_assignment_xShmBarrier@
expression E1, E2;
identifier FP_NAME = xShmBarrier;
expression list args;
@@
- E1 = E2.FP_NAME(args);


// Transform return E->xShmLock(args) to if-chain with 2 candidates
@transform_assignment_xShmLock@
expression E1, E2;
identifier FP_NAME = xShmLock;
expression list args;
@@
- E1 = E2.FP_NAME(args);


// Transform return E->xShmMap(args) to if-chain with 2 candidates
@transform_assignment_xShmMap@
expression E1, E2;
identifier FP_NAME = xShmMap;
expression list args;
@@
- E1 = E2.FP_NAME(args);


// Transform return E->xShmUnmap(args) to if-chain with 2 candidates
@transform_assignment_xShmUnmap@
expression E1, E2;
identifier FP_NAME = xShmUnmap;
expression list args;
@@
- E1 = E2.FP_NAME(args);


// Transform return E->xSleep(args) to if-chain with 2 candidates
@transform_assignment_xSleep@
expression E1, E2;
identifier FP_NAME = xSleep;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xSleep_signature, xSleep_signatures[xSleep_vfstraceSleep_enum], sizeof(E2.xSleep_signature)) == 0) {
+ E1 = vfstraceSleep(args);
+ }


// Transform return E->xSync(args) to if-chain with 3 candidates
@transform_assignment_xSync@
expression E1, E2;
identifier FP_NAME = xSync;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xSync_signature, xSync_signatures[xSync_vfstraceSync_enum], sizeof(E2.xSync_signature)) == 0) {
+ E1 = vfstraceSync(args);
+ }


// Transform return E->xTruncate(args) to if-chain with 3 candidates
@transform_assignment_xTruncate@
expression E1, E2;
identifier FP_NAME = xTruncate;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xTruncate_signature, xTruncate_signatures[xTruncate_vfstraceTruncate_enum], sizeof(E2.xTruncate_signature)) == 0) {
+ E1 = vfstraceTruncate(args);
+ }


// Transform return E->xUnlock(args) to if-chain with 3 candidates
@transform_assignment_xUnlock@
expression E1, E2;
identifier FP_NAME = xUnlock;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xUnlock_signature, xUnlock_signatures[xUnlock_vfstraceUnlock_enum], sizeof(E2.xUnlock_signature)) == 0) {
+ E1 = vfstraceUnlock(args);
+ }


// Transform return E->xWrite(args) to if-chain with 3 candidates
@transform_assignment_xWrite@
expression E1, E2;
identifier FP_NAME = xWrite;
expression list args;
@@
- E1 = E2.FP_NAME(args);
+ if (memcmp(E2.xWrite_signature, xWrite_signatures[xWrite_vfstraceWrite_enum], sizeof(E2.xWrite_signature)) == 0) {
+ E1 = vfstraceWrite(args);
+ }

// Total assignment transformation rules generated: 37
