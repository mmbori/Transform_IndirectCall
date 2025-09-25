#ifndef SQLITE_FP_SIGNATURE_HEADER_H
#define SQLITE_FP_SIGNATURE_HEADER_H

/*
 * SQLite Function Pointer Signatures
 * Auto-generated file - DO NOT EDIT MANUALLY
 * Generated from fpName directory: fpName
 * Excludes function pointers with missing declarations
 */

#include <stdlib.h>
#include <time.h>
#include <string.h>

// =============== xBusy ===============
// xBusy function pointer signatures
int xBusy_Signatures[1][4];
// xBusy signature initialization function
void init_xBusy_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xBusy_Signatures;
    size_t total_size = sizeof(xBusy_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xBusy_Signatures[0] = xBusy
}
// xBusy function enumeration
typedef enum {
    xBusy_xBusy_enum = 0
} xBusy_enum;


// xBusy function declarations
int xBusy(void *pArg, int nBusy);

// =============== xCellSize ===============
// xCellSize function pointer signatures
int xCellSize_Signatures[4][4];
// xCellSize signature initialization function
void init_xCellSize_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xCellSize_Signatures;
    size_t total_size = sizeof(xCellSize_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xCellSize_Signatures[0] = cellSizePtr
    // xCellSize_Signatures[1] = cellSizePtrIdxLeaf
    // xCellSize_Signatures[2] = cellSizePtrNoPayload
    // xCellSize_Signatures[3] = cellSizePtrTableLeaf
}
// xCellSize function enumeration
typedef enum {
    xCellSize_cellSizePtr_enum = 0,
    xCellSize_cellSizePtrIdxLeaf_enum = 1,
    xCellSize_cellSizePtrNoPayload_enum = 2,
    xCellSize_cellSizePtrTableLeaf_enum = 3
} xCellSize_enum;


// xCellSize function declarations
u16 cellSizePtr(MemPage *pPage, u8 *pCell);
u16 cellSizePtrIdxLeaf(MemPage *pPage, u8 *pCell);
u16 cellSizePtrNoPayload(MemPage *pPage, u8 *pCell);
u16 cellSizePtrTableLeaf(MemPage *pPage, u8 *pCell);

// =============== xDelete ===============
// xDelete function pointer signatures
int xDelete_Signatures[2][4];
// xDelete signature initialization function
void init_xDelete_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xDelete_Signatures;
    size_t total_size = sizeof(xDelete_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xDelete_Signatures[0] = multiplexDelete
    // xDelete_Signatures[1] = quotaDelete
}
// xDelete function enumeration
typedef enum {
    xDelete_multiplexDelete_enum = 0,
    xDelete_quotaDelete_enum = 1
} xDelete_enum;


// xDelete function declarations
int multiplexDelete(sqlite3_vfs *pVfs,         
  const char *zName,         
  int syncDir);
int quotaDelete(sqlite3_vfs *pVfs,          
  const char *zName,          
  int syncDir);

// =============== xExprCallback ===============
// xExprCallback function pointer signatures
int xExprCallback_Signatures[37][4];
// xExprCallback signature initialization function
void init_xExprCallback_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xExprCallback_Signatures;
    size_t total_size = sizeof(xExprCallback_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xExprCallback_Signatures[0] = agginfoPersistExprCb
    // xExprCallback_Signatures[1] = aggregateIdxEprRefToColCallback
    // xExprCallback_Signatures[2] = analyzeAggregate
    // xExprCallback_Signatures[3] = checkConstraintExprNode
    // xExprCallback_Signatures[4] = codeCursorHintCheckExpr
    // xExprCallback_Signatures[5] = codeCursorHintFixExpr
    // xExprCallback_Signatures[6] = codeCursorHintIsOrFunction
    // xExprCallback_Signatures[7] = disallowAggregatesInOrderByCb
    // xExprCallback_Signatures[8] = exprColumnFlagUnion
    // xExprCallback_Signatures[9] = exprIdxCover
    // xExprCallback_Signatures[10] = exprNodeCanReturnSubtype
    // xExprCallback_Signatures[11] = exprNodeIsConstant
    // xExprCallback_Signatures[12] = exprNodeIsConstantOrGroupBy
    // xExprCallback_Signatures[13] = exprNodeIsDeterministic
    // xExprCallback_Signatures[14] = exprRefToSrcList
    // xExprCallback_Signatures[15] = fixExprCb
    // xExprCallback_Signatures[16] = gatherSelectWindowsCallback
    // xExprCallback_Signatures[17] = havingToWhereExprCb
    // xExprCallback_Signatures[18] = impliesNotNullRow
    // xExprCallback_Signatures[19] = incrAggDepth
    // xExprCallback_Signatures[20] = markImmutableExprStep
    // xExprCallback_Signatures[21] = propagateConstantExprRewrite
    // xExprCallback_Signatures[22] = recomputeColumnsUsedExpr
    // xExprCallback_Signatures[23] = renameColumnExprCb
    // xExprCallback_Signatures[24] = renameQuotefixExprCb
    // xExprCallback_Signatures[25] = renameTableExprCb
    // xExprCallback_Signatures[26] = renameUnmapExprCb
    // xExprCallback_Signatures[27] = renumberCursorsCb
    // xExprCallback_Signatures[28] = resolveExprStep
    // xExprCallback_Signatures[29] = resolveRemoveWindowsCb
    // xExprCallback_Signatures[30] = selectCheckOnClausesExpr
    // xExprCallback_Signatures[31] = selectWindowRewriteExprCb
    // xExprCallback_Signatures[32] = sqlite3CursorRangeHintExprCheck
    // xExprCallback_Signatures[33] = sqlite3ExprWalkNoop
    // xExprCallback_Signatures[34] = sqlite3ReturningSubqueryVarSelect
    // xExprCallback_Signatures[35] = sqlite3WindowExtraAggFuncDepth
    // xExprCallback_Signatures[36] = whereIsCoveringIndexWalkCallback
}
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


// xExprCallback function declarations
int agginfoPersistExprCb(Walker *pWalker, Expr *pExpr);
int aggregateIdxEprRefToColCallback(Walker *pWalker, Expr *pExpr);
int analyzeAggregate(Walker *pWalker, Expr *pExpr);
define CKCNSTRNT_ROWID    0x02    
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
ifndef SQLITE_OMIT_WINDOWFUNC
int gatherSelectWindowsCallback(Walker *pWalker, Expr *pExpr);
int havingToWhereExprCb(Walker *pWalker, Expr *pExpr);
int impliesNotNullRow(Walker *pWalker, Expr *pExpr);
define EXCLUDED_TABLE_NUMBER  2
int incrAggDepth(Walker *pWalker, Expr *pExpr);
ifdef SQLITE_DEBUG
int markImmutableExprStep(Walker *pWalker, Expr *pExpr);
int propagateConstantExprRewrite(Walker *pWalker, Expr *pExpr);
int recomputeColumnsUsedExpr(Walker *pWalker, Expr *pExpr);
int renameColumnExprCb(Walker *pWalker, Expr *pExpr);
int renameQuotefixExprCb(Walker *pWalker, Expr *pExpr);
int renameTableExprCb(Walker *pWalker, Expr *pExpr);
int renameUnmapExprCb(Walker *pWalker, Expr *pExpr);
int renumberCursorsCb(Walker *pWalker, Expr *pExpr);
int resolveExprStep(Walker *pWalker, Expr *pExpr);
ifndef SQLITE_OMIT_WINDOWFUNC
int resolveRemoveWindowsCb(Walker *pWalker, Expr *pExpr);
int selectCheckOnClausesExpr(Walker *pWalker, Expr *pExpr);
int selectWindowRewriteExprCb(Walker *pWalker, Expr *pExpr);
int sqlite3CursorRangeHintExprCheck(Walker *pWalker, Expr *pExpr);
int sqlite3ExprWalkNoop(Walker*, Expr*);
int sqlite3ReturningSubqueryVarSelect(Walker *NotUsed, Expr *pExpr);
int sqlite3WindowExtraAggFuncDepth(Walker *pWalker, Expr *pExpr);
int whereIsCoveringIndexWalkCallback(Walker *pWalk, Expr *pExpr);

// =============== xGet ===============
// xGet function pointer signatures
int xGet_Signatures[3][4];
// xGet signature initialization function
void init_xGet_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xGet_Signatures;
    size_t total_size = sizeof(xGet_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xGet_Signatures[0] = getPageError
    // xGet_Signatures[1] = getPageMMap
    // xGet_Signatures[2] = getPageNormal
}
// xGet function enumeration
typedef enum {
    xGet_getPageError_enum = 0,
    xGet_getPageMMap_enum = 1,
    xGet_getPageNormal_enum = 2
} xGet_enum;


// xGet function declarations
int getPageError(Pager*,Pgno,DbPage**,int);
0
int getPageMMap(Pager*,Pgno,DbPage**,int);
int getPageNormal(Pager*,Pgno,DbPage**,int);

// =============== xParseCell ===============
// xParseCell function pointer signatures
int xParseCell_Signatures[3][4];
// xParseCell signature initialization function
void init_xParseCell_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xParseCell_Signatures;
    size_t total_size = sizeof(xParseCell_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xParseCell_Signatures[0] = btreeParseCellPtr
    // xParseCell_Signatures[1] = btreeParseCellPtrIndex
    // xParseCell_Signatures[2] = btreeParseCellPtrNoPayload
}
// xParseCell function enumeration
typedef enum {
    xParseCell_btreeParseCellPtr_enum = 0,
    xParseCell_btreeParseCellPtrIndex_enum = 1,
    xParseCell_btreeParseCellPtrNoPayload_enum = 2
} xParseCell_enum;


// xParseCell function declarations
void btreeParseCellPtr(MemPage *pPage,         
  u8 *pCell,              
  CellInfo *pInfo);
void btreeParseCellPtrIndex(MemPage *pPage,         
  u8 *pCell,              
  CellInfo *pInfo);
void btreeParseCellPtrNoPayload(MemPage *pPage,         
  u8 *pCell,              
  CellInfo *pInfo);

// =============== xRead ===============
// xRead function pointer signatures
int xRead_Signatures[2][4];
// xRead signature initialization function
void init_xRead_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xRead_Signatures;
    size_t total_size = sizeof(xRead_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xRead_Signatures[0] = multiplexRead
    // xRead_Signatures[1] = quotaRead
}
// xRead function enumeration
typedef enum {
    xRead_multiplexRead_enum = 0,
    xRead_quotaRead_enum = 1
} xRead_enum;


// xRead function declarations
int multiplexRead(sqlite3_file *pConn,
  void *pBuf,
  int iAmt,
  sqlite3_int64 iOfst);
int quotaRead(sqlite3_file *pConn,
  void *pBuf,
  int iAmt,
  sqlite3_int64 iOfst);

// =============== xSelectCallback ===============
// xSelectCallback function pointer signatures
int xSelectCallback_Signatures[16][4];
// xSelectCallback signature initialization function
void init_xSelectCallback_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xSelectCallback_Signatures;
    size_t total_size = sizeof(xSelectCallback_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xSelectCallback_Signatures[0] = convertCompoundSelectToSubquery
    // xSelectCallback_Signatures[1] = exprSelectWalkTableConstant
    // xSelectCallback_Signatures[2] = fixSelectCb
    // xSelectCallback_Signatures[3] = gatherSelectWindowsSelectCallback
    // xSelectCallback_Signatures[4] = renameColumnSelectCb
    // xSelectCallback_Signatures[5] = renameTableSelectCb
    // xSelectCallback_Signatures[6] = renameUnmapSelectCb
    // xSelectCallback_Signatures[7] = resolveSelectStep
    // xSelectCallback_Signatures[8] = selectCheckOnClausesSelect
    // xSelectCallback_Signatures[9] = selectExpander
    // xSelectCallback_Signatures[10] = selectRefEnter
    // xSelectCallback_Signatures[11] = selectWindowRewriteSelectCb
    // xSelectCallback_Signatures[12] = sqlite3ReturningSubqueryCorrelated
    // xSelectCallback_Signatures[13] = sqlite3SelectWalkFail
    // xSelectCallback_Signatures[14] = sqlite3SelectWalkNoop
    // xSelectCallback_Signatures[15] = sqlite3WalkerDepthIncrease
}
// xSelectCallback function enumeration
typedef enum {
    xSelectCallback_convertCompoundSelectToSubquery_enum = 0,
    xSelectCallback_exprSelectWalkTableConstant_enum = 1,
    xSelectCallback_fixSelectCb_enum = 2,
    xSelectCallback_gatherSelectWindowsSelectCallback_enum = 3,
    xSelectCallback_renameColumnSelectCb_enum = 4,
    xSelectCallback_renameTableSelectCb_enum = 5,
    xSelectCallback_renameUnmapSelectCb_enum = 6,
    xSelectCallback_resolveSelectStep_enum = 7,
    xSelectCallback_selectCheckOnClausesSelect_enum = 8,
    xSelectCallback_selectExpander_enum = 9,
    xSelectCallback_selectRefEnter_enum = 10,
    xSelectCallback_selectWindowRewriteSelectCb_enum = 11,
    xSelectCallback_sqlite3ReturningSubqueryCorrelated_enum = 12,
    xSelectCallback_sqlite3SelectWalkFail_enum = 13,
    xSelectCallback_sqlite3SelectWalkNoop_enum = 14,
    xSelectCallback_sqlite3WalkerDepthIncrease_enum = 15
} xSelectCallback_enum;


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
int sqlite3SelectWalkFail(Walker*, Select*);
int sqlite3SelectWalkNoop(Walker*, Select*);
int sqlite3WalkerDepthIncrease(Walker*,Select*);

// =============== xSelectCallback2 ===============
// xSelectCallback2 function pointer signatures
int xSelectCallback2_Signatures[6][4];
// xSelectCallback2 signature initialization function
void init_xSelectCallback2_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xSelectCallback2_Signatures;
    size_t total_size = sizeof(xSelectCallback2_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xSelectCallback2_Signatures[0] = selectAddSubqueryTypeInfo
    // xSelectCallback2_Signatures[1] = selectRefLeave
    // xSelectCallback2_Signatures[2] = sqlite3SelectPopWith
    // xSelectCallback2_Signatures[3] = sqlite3SelectWalkAssert2
    // xSelectCallback2_Signatures[4] = sqlite3WalkWinDefnDummyCallback
    // xSelectCallback2_Signatures[5] = sqlite3WalkerDepthDecrease
}
// xSelectCallback2 function enumeration
typedef enum {
    xSelectCallback2_selectAddSubqueryTypeInfo_enum = 0,
    xSelectCallback2_selectRefLeave_enum = 1,
    xSelectCallback2_sqlite3SelectPopWith_enum = 2,
    xSelectCallback2_sqlite3SelectWalkAssert2_enum = 3,
    xSelectCallback2_sqlite3WalkWinDefnDummyCallback_enum = 4,
    xSelectCallback2_sqlite3WalkerDepthDecrease_enum = 5
} xSelectCallback2_enum;


// xSelectCallback2 function declarations
ifndef SQLITE_OMIT_SUBQUERY
void selectAddSubqueryTypeInfo(Walker *pWalker, Select *p);
void selectRefLeave(Walker *pWalker, Select *pSelect);
ifndef SQLITE_OMIT_CTE
void sqlite3SelectPopWith(Walker*, Select*);
ifdef SQLITE_DEBUG
void sqlite3SelectWalkAssert2(Walker*, Select*);
void sqlite3WalkWinDefnDummyCallback(Walker*,Select*);
void sqlite3WalkerDepthDecrease(Walker*,Select*);

// =============== xWrite ===============
// xWrite function pointer signatures
int xWrite_Signatures[2][4];
// xWrite signature initialization function
void init_xWrite_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xWrite_Signatures;
    size_t total_size = sizeof(xWrite_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xWrite_Signatures[0] = multiplexWrite
    // xWrite_Signatures[1] = quotaWrite
}
// xWrite function enumeration
typedef enum {
    xWrite_multiplexWrite_enum = 0,
    xWrite_quotaWrite_enum = 1
} xWrite_enum;


// xWrite function declarations
int multiplexWrite(sqlite3_file *pConn,
  const void *pBuf,
  int iAmt,
  sqlite3_int64 iOfst);
int quotaWrite(sqlite3_file *pConn,
  const void *pBuf,
  int iAmt,
  sqlite3_int64 iOfst);

// Global initialization function for all signatures
void init_all_fp_Signatures(void) {
    static int global_initialized = 0;
    if (global_initialized) return;
    global_initialized = 1;

    // Seed the random number generator
    srand((unsigned int)time(NULL));

    init_xBusy_Signatures();
    init_xCellSize_Signatures();
    init_xDelete_Signatures();
    init_xExprCallback_Signatures();
    init_xGet_Signatures();
    init_xParseCell_Signatures();
    init_xRead_Signatures();
    init_xSelectCallback_Signatures();
    init_xSelectCallback2_Signatures();
    init_xWrite_Signatures();
}

// Individual initialization function declarations
void init_xBusy_Signatures(void);
void init_xCellSize_Signatures(void);
void init_xDelete_Signatures(void);
void init_xExprCallback_Signatures(void);
void init_xGet_Signatures(void);
void init_xParseCell_Signatures(void);
void init_xRead_Signatures(void);
void init_xSelectCallback_Signatures(void);
void init_xSelectCallback2_Signatures(void);
void init_xWrite_Signatures(void);

#endif /* SQLITE_FP_SIGNATURE_HEADER_H */
