#ifndef SQLITE_FP_SIGNATURE_HEADER_H
#define SQLITE_FP_SIGNATURE_HEADER_H

/*
 * SQLite Function Pointer Signatures
 * Auto-generated file - DO NOT EDIT MANUALLY
 * Generated from fpName directory: fpName_tmp
 * Excludes function pointers with missing declarations
 */

#include <stdlib.h>
#include <time.h>
#include <string.h>

// =============== xAccess ===============
// xAccess function pointer signatures
int xAccess_Signatures[2][4];
// xAccess signature initialization function
void init_xAccess_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xAccess_Signatures;
    size_t total_size = sizeof(xAccess_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xAccess_Signatures[0] = multiplexAccess
    // xAccess_Signatures[1] = vfstraceAccess
}
// xAccess function enumeration
typedef enum {
    xAccess_multiplexAccess_enum = 0,
    xAccess_vfstraceAccess_enum = 1
} xAccess_enum;


// xAccess function declarations
int multiplexAccess(sqlite3_vfs *a, const char *b, int c, int *d);
int vfstraceAccess(sqlite3_vfs*, const char *zName, int flags, int *);

// =============== xAppend ===============
// xAppend function pointer signatures
int xAppend_Signatures[2][4];
// xAppend signature initialization function
void init_xAppend_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xAppend_Signatures;
    size_t total_size = sizeof(xAppend_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xAppend_Signatures[0] = fts5AppendPoslist
    // xAppend_Signatures[1] = fts5AppendRowid
}
// xAppend function enumeration
typedef enum {
    xAppend_fts5AppendPoslist_enum = 0,
    xAppend_fts5AppendRowid_enum = 1
} xAppend_enum;


// // xAppend function declarations
// void fts5AppendPoslist(Fts5Index *p,
//   u64 iDelta,
//   Fts5Iter *pMulti,
//   Fts5Buffer *pBuf);
// void fts5AppendRowid(Fts5Index *p,
//   u64 iDelta,
//   Fts5Iter *pUnused,
//   Fts5Buffer *pBuf);

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

// =============== xCheckReservedLock ===============
// xCheckReservedLock function pointer signatures
int xCheckReservedLock_Signatures[3][4];
// xCheckReservedLock signature initialization function
void init_xCheckReservedLock_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xCheckReservedLock_Signatures;
    size_t total_size = sizeof(xCheckReservedLock_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xCheckReservedLock_Signatures[0] = multiplexCheckReservedLock
    // xCheckReservedLock_Signatures[1] = quotaCheckReservedLock
    // xCheckReservedLock_Signatures[2] = vfstraceCheckReservedLock
}
// xCheckReservedLock function enumeration
typedef enum {
    xCheckReservedLock_multiplexCheckReservedLock_enum = 0,
    xCheckReservedLock_quotaCheckReservedLock_enum = 1,
    xCheckReservedLock_vfstraceCheckReservedLock_enum = 2
} xCheckReservedLock_enum;


// xCheckReservedLock function declarations
int multiplexCheckReservedLock(sqlite3_file *pConn, int *pResOut);
int quotaCheckReservedLock(sqlite3_file *pConn, int *pResOut);
int vfstraceCheckReservedLock(sqlite3_file*, int *);

// =============== xClose ===============
// xClose function pointer signatures
int xClose_Signatures[3][4];
// xClose signature initialization function
void init_xClose_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xClose_Signatures;
    size_t total_size = sizeof(xClose_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xClose_Signatures[0] = multiplexClose
    // xClose_Signatures[1] = quotaClose
    // xClose_Signatures[2] = vfstraceClose
}
// xClose function enumeration
typedef enum {
    xClose_multiplexClose_enum = 0,
    xClose_quotaClose_enum = 1,
    xClose_vfstraceClose_enum = 2
} xClose_enum;


// xClose function declarations
int multiplexClose(sqlite3_file *pConn);
int quotaClose(sqlite3_file *pConn);
int vfstraceClose(sqlite3_file*);

// =============== xCount ===============
// xCount function pointer signatures
int xCount_Signatures[3][4];
// xCount signature initialization function
void init_xCount_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xCount_Signatures;
    size_t total_size = sizeof(xCount_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xCount_Signatures[0] = sessionDiffCount
    // xCount_Signatures[1] = sessionPreupdateCount
    // xCount_Signatures[2] = sessionStat1Count
}
// xCount function enumeration
typedef enum {
    xCount_sessionDiffCount_enum = 0,
    xCount_sessionPreupdateCount_enum = 1,
    xCount_sessionStat1Count_enum = 2
} xCount_enum;


// xCount function declarations
int sessionDiffCount(void *pCtx);
int sessionPreupdateCount(void *pCtx);
int sessionStat1Count(void *pCtx);

// =============== xCreate ===============
// xCreate function pointer signatures
int xCreate_Signatures[1][4];
// xCreate signature initialization function
void init_xCreate_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xCreate_Signatures;
    size_t total_size = sizeof(xCreate_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xCreate_Signatures[0] = fts5VtoVCreate
}
// xCreate function enumeration
typedef enum {
    xCreate_fts5VtoVCreate_enum = 0
} xCreate_enum;


// // xCreate function declarations
// int fts5VtoVCreate(void *pCtx, 
//   const char **azArg, 
//   int nArg, 
//   Fts5Tokenizer **ppOut);

// =============== xCurrentTime ===============
// xCurrentTime function pointer signatures
int xCurrentTime_Signatures[2][4];
// xCurrentTime signature initialization function
void init_xCurrentTime_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xCurrentTime_Signatures;
    size_t total_size = sizeof(xCurrentTime_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xCurrentTime_Signatures[0] = multiplexCurrentTime
    // xCurrentTime_Signatures[1] = vfstraceCurrentTime
}
// xCurrentTime function enumeration
typedef enum {
    xCurrentTime_multiplexCurrentTime_enum = 0,
    xCurrentTime_vfstraceCurrentTime_enum = 1
} xCurrentTime_enum;


// xCurrentTime function declarations
int multiplexCurrentTime(sqlite3_vfs *a, double *b);
int vfstraceCurrentTime(sqlite3_vfs*, double*);

// =============== xCurrentTimeInt64 ===============
// xCurrentTimeInt64 function pointer signatures
int xCurrentTimeInt64_Signatures[1][4];
// xCurrentTimeInt64 signature initialization function
void init_xCurrentTimeInt64_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xCurrentTimeInt64_Signatures;
    size_t total_size = sizeof(xCurrentTimeInt64_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xCurrentTimeInt64_Signatures[0] = multiplexCurrentTimeInt64
}
// xCurrentTimeInt64 function enumeration
typedef enum {
    xCurrentTimeInt64_multiplexCurrentTimeInt64_enum = 0
} xCurrentTimeInt64_enum;


// xCurrentTimeInt64 function declarations
int multiplexCurrentTimeInt64(sqlite3_vfs *a, sqlite3_int64 *b);

// =============== xDelUser ===============
// xDelUser function pointer signatures
int xDelUser_Signatures[2][4];
// xDelUser signature initialization function
void init_xDelUser_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xDelUser_Signatures;
    size_t total_size = sizeof(xDelUser_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xDelUser_Signatures[0] = circle_del
    // xDelUser_Signatures[1] = cube_context_free
}
// xDelUser function enumeration
typedef enum {
    xDelUser_circle_del_enum = 0,
    xDelUser_cube_context_free_enum = 1
} xDelUser_enum;


// xDelUser function declarations
void circle_del(void *p);
void cube_context_free(void *p);

// =============== xDepth ===============
// xDepth function pointer signatures
int xDepth_Signatures[3][4];
// xDepth signature initialization function
void init_xDepth_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xDepth_Signatures;
    size_t total_size = sizeof(xDepth_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xDepth_Signatures[0] = sessionDiffDepth
    // xDepth_Signatures[1] = sessionPreupdateDepth
    // xDepth_Signatures[2] = sessionStat1Depth
}
// xDepth function enumeration
typedef enum {
    xDepth_sessionDiffDepth_enum = 0,
    xDepth_sessionPreupdateDepth_enum = 1,
    xDepth_sessionStat1Depth_enum = 2
} xDepth_enum;


// xDepth function declarations
int sessionDiffDepth(void *pCtx);
int sessionPreupdateDepth(void *pCtx);
int sessionStat1Depth(void *pCtx);

// =============== xDeviceCharacteristics ===============
// xDeviceCharacteristics function pointer signatures
int xDeviceCharacteristics_Signatures[3][4];
// xDeviceCharacteristics signature initialization function
void init_xDeviceCharacteristics_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xDeviceCharacteristics_Signatures;
    size_t total_size = sizeof(xDeviceCharacteristics_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xDeviceCharacteristics_Signatures[0] = multiplexDeviceCharacteristics
    // xDeviceCharacteristics_Signatures[1] = quotaDeviceCharacteristics
    // xDeviceCharacteristics_Signatures[2] = vfstraceDeviceCharacteristics
}
// xDeviceCharacteristics function enumeration
typedef enum {
    xDeviceCharacteristics_multiplexDeviceCharacteristics_enum = 0,
    xDeviceCharacteristics_quotaDeviceCharacteristics_enum = 1,
    xDeviceCharacteristics_vfstraceDeviceCharacteristics_enum = 2
} xDeviceCharacteristics_enum;


// xDeviceCharacteristics function declarations
int multiplexDeviceCharacteristics(sqlite3_file *pConn);
int quotaDeviceCharacteristics(sqlite3_file *pConn);
int vfstraceDeviceCharacteristics(sqlite3_file*);

// =============== xDlClose ===============
// xDlClose function pointer signatures
int xDlClose_Signatures[1][4];
// xDlClose signature initialization function
void init_xDlClose_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xDlClose_Signatures;
    size_t total_size = sizeof(xDlClose_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xDlClose_Signatures[0] = multiplexDlClose
}
// xDlClose function enumeration
typedef enum {
    xDlClose_multiplexDlClose_enum = 0
} xDlClose_enum;


// xDlClose function declarations
void multiplexDlClose(sqlite3_vfs *a, void *b);

// =============== xDlError ===============
// xDlError function pointer signatures
int xDlError_Signatures[1][4];
// xDlError signature initialization function
void init_xDlError_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xDlError_Signatures;
    size_t total_size = sizeof(xDlError_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xDlError_Signatures[0] = multiplexDlError
}
// xDlError function enumeration
typedef enum {
    xDlError_multiplexDlError_enum = 0
} xDlError_enum;


// xDlError function declarations
void multiplexDlError(sqlite3_vfs *a, int b, char *c);

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
int sqlite3ExprWalkNoop(Walker *NotUsed, Expr *NotUsed2);
int sqlite3ReturningSubqueryVarSelect(Walker *NotUsed, Expr *pExpr);
int sqlite3WindowExtraAggFuncDepth(Walker *pWalker, Expr *pExpr);
int whereIsCoveringIndexWalkCallback(Walker *pWalk, Expr *pExpr);

// =============== xFileControl ===============
// xFileControl function pointer signatures
int xFileControl_Signatures[3][4];
// xFileControl signature initialization function
void init_xFileControl_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xFileControl_Signatures;
    size_t total_size = sizeof(xFileControl_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xFileControl_Signatures[0] = multiplexFileControl
    // xFileControl_Signatures[1] = quotaFileControl
    // xFileControl_Signatures[2] = vfstraceFileControl
}
// xFileControl function enumeration
typedef enum {
    xFileControl_multiplexFileControl_enum = 0,
    xFileControl_quotaFileControl_enum = 1,
    xFileControl_vfstraceFileControl_enum = 2
} xFileControl_enum;


// xFileControl function declarations
int multiplexFileControl(sqlite3_file *pConn, int op, void *pArg);
int quotaFileControl(sqlite3_file *pConn, int op, void *pArg);
int vfstraceFileControl(sqlite3_file*, int op, void *pArg);

// =============== xFileSize ===============
// xFileSize function pointer signatures
int xFileSize_Signatures[3][4];
// xFileSize signature initialization function
void init_xFileSize_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xFileSize_Signatures;
    size_t total_size = sizeof(xFileSize_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xFileSize_Signatures[0] = multiplexFileSize
    // xFileSize_Signatures[1] = quotaFileSize
    // xFileSize_Signatures[2] = vfstraceFileSize
}
// xFileSize function enumeration
typedef enum {
    xFileSize_multiplexFileSize_enum = 0,
    xFileSize_quotaFileSize_enum = 1,
    xFileSize_vfstraceFileSize_enum = 2
} xFileSize_enum;


// xFileSize function declarations
int multiplexFileSize(sqlite3_file *pConn, sqlite3_int64 *pSize);
int quotaFileSize(sqlite3_file *pConn, sqlite3_int64 *pSize);
int vfstraceFileSize(sqlite3_file*, sqlite3_int64 *pSize);

// =============== xFindTokenizer ===============
// xFindTokenizer function pointer signatures
int xFindTokenizer_Signatures[1][4];
// xFindTokenizer signature initialization function
void init_xFindTokenizer_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xFindTokenizer_Signatures;
    size_t total_size = sizeof(xFindTokenizer_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xFindTokenizer_Signatures[0] = fts5FindTokenizer
}
// xFindTokenizer function enumeration
typedef enum {
    xFindTokenizer_fts5FindTokenizer_enum = 0
} xFindTokenizer_enum;


// // xFindTokenizer function declarations
// int fts5FindTokenizer(fts5_api *pApi,                 
//   const char *zName,              
//   void **ppUserData,
//   fts5_tokenizer *pTokenizer);

// =============== xFindTokenizer_v2 ===============
// xFindTokenizer_v2 function pointer signatures
int xFindTokenizer_v2_Signatures[1][4];
// xFindTokenizer_v2 signature initialization function
void init_xFindTokenizer_v2_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xFindTokenizer_v2_Signatures;
    size_t total_size = sizeof(xFindTokenizer_v2_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xFindTokenizer_v2_Signatures[0] = fts5FindTokenizer_v2
}
// xFindTokenizer_v2 function enumeration
typedef enum {
    xFindTokenizer_v2_fts5FindTokenizer_v2_enum = 0
} xFindTokenizer_v2_enum;


// // xFindTokenizer_v2 function declarations
// int fts5FindTokenizer_v2(fts5_api *pApi,                 
//   const char *zName,              
//   void **ppUserData,
//   fts5_tokenizer_v2 **ppTokenizer);

// =============== xFree ===============
// xFree function pointer signatures
int xFree_Signatures[1][4];
// xFree signature initialization function
void init_xFree_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xFree_Signatures;
    size_t total_size = sizeof(xFree_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xFree_Signatures[0] = xFree
}
// xFree function enumeration
typedef enum {
    xFree_xFree_enum = 0
} xFree_enum;


// xFree function declarations
void xFree(void *p);

// =============== xFreeSchema ===============
// xFreeSchema function pointer signatures
int xFreeSchema_Signatures[1][4];
// xFreeSchema signature initialization function
void init_xFreeSchema_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xFreeSchema_Signatures;
    size_t total_size = sizeof(xFreeSchema_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xFreeSchema_Signatures[0] = xFree
}
// xFreeSchema function enumeration
typedef enum {
    xFreeSchema_xFree_enum = 0
} xFreeSchema_enum;


// xFreeSchema function declarations
void xFree(void *p);

// =============== xFullPathname ===============
// xFullPathname function pointer signatures
int xFullPathname_Signatures[2][4];
// xFullPathname signature initialization function
void init_xFullPathname_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xFullPathname_Signatures;
    size_t total_size = sizeof(xFullPathname_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xFullPathname_Signatures[0] = multiplexFullPathname
    // xFullPathname_Signatures[1] = vfstraceFullPathname
}
// xFullPathname function enumeration
typedef enum {
    xFullPathname_multiplexFullPathname_enum = 0,
    xFullPathname_vfstraceFullPathname_enum = 1
} xFullPathname_enum;


// xFullPathname function declarations
int multiplexFullPathname(sqlite3_vfs *a, const char *b, int c, char *d);
int vfstraceFullPathname(sqlite3_vfs*, const char *zName, int, char *);

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

// =============== xGetLastError ===============
// xGetLastError function pointer signatures
int xGetLastError_Signatures[1][4];
// xGetLastError signature initialization function
void init_xGetLastError_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xGetLastError_Signatures;
    size_t total_size = sizeof(xGetLastError_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xGetLastError_Signatures[0] = multiplexGetLastError
}
// xGetLastError function enumeration
typedef enum {
    xGetLastError_multiplexGetLastError_enum = 0
} xGetLastError_enum;


// xGetLastError function declarations
int multiplexGetLastError(sqlite3_vfs *a, int b, char *c);

// =============== xLock ===============
// xLock function pointer signatures
int xLock_Signatures[3][4];
// xLock signature initialization function
void init_xLock_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xLock_Signatures;
    size_t total_size = sizeof(xLock_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xLock_Signatures[0] = multiplexLock
    // xLock_Signatures[1] = quotaLock
    // xLock_Signatures[2] = vfstraceLock
}
// xLock function enumeration
typedef enum {
    xLock_multiplexLock_enum = 0,
    xLock_quotaLock_enum = 1,
    xLock_vfstraceLock_enum = 2
} xLock_enum;


// xLock function declarations
int multiplexLock(sqlite3_file *pConn, int lock);
int quotaLock(sqlite3_file *pConn, int lock);
int vfstraceLock(sqlite3_file*, int);

// =============== xMerge ===============
// xMerge function pointer signatures
int xMerge_Signatures[2][4];
// xMerge signature initialization function
void init_xMerge_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xMerge_Signatures;
    size_t total_size = sizeof(xMerge_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xMerge_Signatures[0] = fts5MergePrefixLists
    // xMerge_Signatures[1] = fts5MergeRowidLists
}
// xMerge function enumeration
typedef enum {
    xMerge_fts5MergePrefixLists_enum = 0,
    xMerge_fts5MergeRowidLists_enum = 1
} xMerge_enum;


// // xMerge function declarations
// void fts5MergePrefixLists(Fts5Index *p,                   
//   Fts5Buffer *p1,                 
//   int nBuf,                       
//   Fts5Buffer *aBuf);
// void fts5MergeRowidLists(Fts5Index *p,                   
//   Fts5Buffer *p1,                 
//   int nBuf,                       
//   Fts5Buffer *aBuf);

// =============== xNew ===============
// xNew function pointer signatures
int xNew_Signatures[3][4];
// xNew signature initialization function
void init_xNew_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xNew_Signatures;
    size_t total_size = sizeof(xNew_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xNew_Signatures[0] = sessionDiffNew
    // xNew_Signatures[1] = sessionPreupdateNew
    // xNew_Signatures[2] = sessionStat1New
}
// xNew function enumeration
typedef enum {
    xNew_sessionDiffNew_enum = 0,
    xNew_sessionPreupdateNew_enum = 1,
    xNew_sessionStat1New_enum = 2
} xNew_enum;


// xNew function declarations
int sessionDiffNew(void *pCtx, int iVal, sqlite3_value **ppVal);
int sessionPreupdateNew(void *pCtx, int iVal, sqlite3_value **ppVal);
int sessionStat1New(void *pCtx, int iCol, sqlite3_value **ppVal);

// =============== xNext ===============
// xNext function pointer signatures
int xNext_Signatures[8][4];
// xNext signature initialization function
void init_xNext_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xNext_Signatures;
    size_t total_size = sizeof(xNext_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xNext_Signatures[0] = fts5ExprNodeNext_AND
    // xNext_Signatures[1] = fts5ExprNodeNext_NOT
    // xNext_Signatures[2] = fts5ExprNodeNext_OR
    // xNext_Signatures[3] = fts5ExprNodeNext_STRING
    // xNext_Signatures[4] = fts5ExprNodeNext_TERM
    // xNext_Signatures[5] = fts5SegIterNext
    // xNext_Signatures[6] = fts5SegIterNext_None
    // xNext_Signatures[7] = fts5SegIterNext_Reverse
}
// xNext function enumeration
typedef enum {
    xNext_fts5ExprNodeNext_AND_enum = 0,
    xNext_fts5ExprNodeNext_NOT_enum = 1,
    xNext_fts5ExprNodeNext_OR_enum = 2,
    xNext_fts5ExprNodeNext_STRING_enum = 3,
    xNext_fts5ExprNodeNext_TERM_enum = 4,
    xNext_fts5SegIterNext_enum = 5,
    xNext_fts5SegIterNext_None_enum = 6,
    xNext_fts5SegIterNext_Reverse_enum = 7
} xNext_enum;


// // xNext function declarations
// int fts5ExprNodeNext_AND(Fts5Expr *pExpr, 
//   Fts5ExprNode *pNode,
//   int bFromValid,
//   i64 iFrom);
// int fts5ExprNodeNext_NOT(Fts5Expr *pExpr, 
//   Fts5ExprNode *pNode,
//   int bFromValid,
//   i64 iFrom);
// int fts5ExprNodeNext_OR(Fts5Expr *pExpr, 
//   Fts5ExprNode *pNode,
//   int bFromValid,
//   i64 iFrom);
// int fts5ExprNodeNext_STRING(Fts5Expr *pExpr,                
//   Fts5ExprNode *pNode,            
//   int bFromValid,
//   i64 iFrom);
// int fts5ExprNodeNext_TERM(Fts5Expr *pExpr, 
//   Fts5ExprNode *pNode,
//   int bFromValid,
//   i64 iFrom);
// void fts5SegIterNext(Fts5Index*, Fts5SegIter*, int*);
// void fts5SegIterNext_None(Fts5Index*, Fts5SegIter*, int*);
// void fts5SegIterNext_Reverse(Fts5Index*, Fts5SegIter*, int*);

// =============== xOld ===============
// xOld function pointer signatures
int xOld_Signatures[3][4];
// xOld signature initialization function
void init_xOld_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xOld_Signatures;
    size_t total_size = sizeof(xOld_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xOld_Signatures[0] = sessionDiffOld
    // xOld_Signatures[1] = sessionPreupdateOld
    // xOld_Signatures[2] = sessionStat1Old
}
// xOld function enumeration
typedef enum {
    xOld_sessionDiffOld_enum = 0,
    xOld_sessionPreupdateOld_enum = 1,
    xOld_sessionStat1Old_enum = 2
} xOld_enum;


// xOld function declarations
int sessionDiffOld(void *pCtx, int iVal, sqlite3_value **ppVal);
int sessionPreupdateOld(void *pCtx, int iVal, sqlite3_value **ppVal);
int sessionStat1Old(void *pCtx, int iCol, sqlite3_value **ppVal);

// =============== xOpen ===============
// xOpen function pointer signatures
int xOpen_Signatures[3][4];
// xOpen signature initialization function
void init_xOpen_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xOpen_Signatures;
    size_t total_size = sizeof(xOpen_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xOpen_Signatures[0] = multiplexOpen
    // xOpen_Signatures[1] = quotaOpen
    // xOpen_Signatures[2] = vfstraceOpen
}
// xOpen function enumeration
typedef enum {
    xOpen_multiplexOpen_enum = 0,
    xOpen_quotaOpen_enum = 1,
    xOpen_vfstraceOpen_enum = 2
} xOpen_enum;


// xOpen function declarations
int multiplexOpen(sqlite3_vfs *pVfs,         
  const char *zName,         
  sqlite3_file *pConn,       
  int flags,                 
  int *pOutFlags);
int quotaOpen(sqlite3_vfs *pVfs,          
  const char *zName,          
  sqlite3_file *pConn,        
  int flags,                  
  int *pOutFlags);
int vfstraceOpen(sqlite3_vfs*, const char *, sqlite3_file*, int , int *);

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

// =============== xRandomness ===============
// xRandomness function pointer signatures
int xRandomness_Signatures[2][4];
// xRandomness signature initialization function
void init_xRandomness_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xRandomness_Signatures;
    size_t total_size = sizeof(xRandomness_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xRandomness_Signatures[0] = multiplexRandomness
    // xRandomness_Signatures[1] = vfstraceRandomness
}
// xRandomness function enumeration
typedef enum {
    xRandomness_multiplexRandomness_enum = 0,
    xRandomness_vfstraceRandomness_enum = 1
} xRandomness_enum;


// xRandomness function declarations
int multiplexRandomness(sqlite3_vfs *a, int b, char *c);
int vfstraceRandomness(sqlite3_vfs*, int nByte, char *zOut);

// =============== xRead ===============
// xRead function pointer signatures
int xRead_Signatures[3][4];
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
    // xRead_Signatures[2] = vfstraceRead
}
// xRead function enumeration
typedef enum {
    xRead_multiplexRead_enum = 0,
    xRead_quotaRead_enum = 1,
    xRead_vfstraceRead_enum = 2
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
int vfstraceRead(sqlite3_file*, void*, int iAmt, sqlite3_int64 iOfst);

// =============== xSectorSize ===============
// xSectorSize function pointer signatures
int xSectorSize_Signatures[3][4];
// xSectorSize signature initialization function
void init_xSectorSize_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xSectorSize_Signatures;
    size_t total_size = sizeof(xSectorSize_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xSectorSize_Signatures[0] = multiplexSectorSize
    // xSectorSize_Signatures[1] = quotaSectorSize
    // xSectorSize_Signatures[2] = vfstraceSectorSize
}
// xSectorSize function enumeration
typedef enum {
    xSectorSize_multiplexSectorSize_enum = 0,
    xSectorSize_quotaSectorSize_enum = 1,
    xSectorSize_vfstraceSectorSize_enum = 2
} xSectorSize_enum;


// xSectorSize function declarations
int multiplexSectorSize(sqlite3_file *pConn);
int quotaSectorSize(sqlite3_file *pConn);
int vfstraceSectorSize(sqlite3_file*);

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
int sqlite3SelectWalkFail(Walker *pWalker, Select *NotUsed);
int sqlite3SelectWalkNoop(Walker *NotUsed, Select *NotUsed2);
int sqlite3WalkerDepthIncrease(Walker *pWalker, Select *pSelect);

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
void sqlite3SelectPopWith(Walker *pWalker, Select *p);
if SQLITE_DEBUG
void sqlite3SelectWalkAssert2(Walker *NotUsed, Select *NotUsed2);
void sqlite3WalkWinDefnDummyCallback(Walker *pWalker, Select *p);
void sqlite3WalkerDepthDecrease(Walker *pWalker, Select *pSelect);

// =============== xSetOutputs ===============
// xSetOutputs function pointer signatures
int xSetOutputs_Signatures[7][4];
// xSetOutputs signature initialization function
void init_xSetOutputs_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xSetOutputs_Signatures;
    size_t total_size = sizeof(xSetOutputs_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xSetOutputs_Signatures[0] = fts5IterSetOutputs_Col
    // xSetOutputs_Signatures[1] = fts5IterSetOutputs_Col100
    // xSetOutputs_Signatures[2] = fts5IterSetOutputs_Full
    // xSetOutputs_Signatures[3] = fts5IterSetOutputs_Nocolset
    // xSetOutputs_Signatures[4] = fts5IterSetOutputs_None
    // xSetOutputs_Signatures[5] = fts5IterSetOutputs_Noop
    // xSetOutputs_Signatures[6] = fts5IterSetOutputs_ZeroColset
}
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


// // xSetOutputs function declarations
// void fts5IterSetOutputs_Col(Fts5Iter *pIter, Fts5SegIter *pSeg);
// void fts5IterSetOutputs_Col100(Fts5Iter *pIter, Fts5SegIter *pSeg);
// void fts5IterSetOutputs_Full(Fts5Iter *pIter, Fts5SegIter *pSeg);
// void fts5IterSetOutputs_Nocolset(Fts5Iter *pIter, Fts5SegIter *pSeg);
// void fts5IterSetOutputs_None(Fts5Iter *pIter, Fts5SegIter *pSeg);
// void fts5IterSetOutputs_Noop(Fts5Iter *pUnused1, Fts5SegIter *pUnused2);
// void fts5IterSetOutputs_ZeroColset(Fts5Iter *pIter, Fts5SegIter *pSeg);

// =============== xShmBarrier ===============
// xShmBarrier function pointer signatures
int xShmBarrier_Signatures[2][4];
// xShmBarrier signature initialization function
void init_xShmBarrier_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xShmBarrier_Signatures;
    size_t total_size = sizeof(xShmBarrier_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xShmBarrier_Signatures[0] = multiplexShmBarrier
    // xShmBarrier_Signatures[1] = quotaShmBarrier
}
// xShmBarrier function enumeration
typedef enum {
    xShmBarrier_multiplexShmBarrier_enum = 0,
    xShmBarrier_quotaShmBarrier_enum = 1
} xShmBarrier_enum;


// xShmBarrier function declarations
void multiplexShmBarrier(sqlite3_file *pConn);
void quotaShmBarrier(sqlite3_file *pConn);

// =============== xShmLock ===============
// xShmLock function pointer signatures
int xShmLock_Signatures[2][4];
// xShmLock signature initialization function
void init_xShmLock_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xShmLock_Signatures;
    size_t total_size = sizeof(xShmLock_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xShmLock_Signatures[0] = multiplexShmLock
    // xShmLock_Signatures[1] = quotaShmLock
}
// xShmLock function enumeration
typedef enum {
    xShmLock_multiplexShmLock_enum = 0,
    xShmLock_quotaShmLock_enum = 1
} xShmLock_enum;


// xShmLock function declarations
int multiplexShmLock(sqlite3_file *pConn,       
  int ofst,                  
  int n,                     
  int flags);
int quotaShmLock(sqlite3_file *pConn,       
  int ofst,                  
  int n,                     
  int flags);

// =============== xShmMap ===============
// xShmMap function pointer signatures
int xShmMap_Signatures[2][4];
// xShmMap signature initialization function
void init_xShmMap_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xShmMap_Signatures;
    size_t total_size = sizeof(xShmMap_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xShmMap_Signatures[0] = multiplexShmMap
    // xShmMap_Signatures[1] = quotaShmMap
}
// xShmMap function enumeration
typedef enum {
    xShmMap_multiplexShmMap_enum = 0,
    xShmMap_quotaShmMap_enum = 1
} xShmMap_enum;


// xShmMap function declarations
int multiplexShmMap(sqlite3_file *pConn,            
  int iRegion,                    
  int szRegion,                   
  int bExtend,                    
  void volatile **pp);
int quotaShmMap(sqlite3_file *pConn,            
  int iRegion,                    
  int szRegion,                   
  int bExtend,                    
  void volatile **pp);

// =============== xShmUnmap ===============
// xShmUnmap function pointer signatures
int xShmUnmap_Signatures[2][4];
// xShmUnmap signature initialization function
void init_xShmUnmap_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xShmUnmap_Signatures;
    size_t total_size = sizeof(xShmUnmap_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xShmUnmap_Signatures[0] = multiplexShmUnmap
    // xShmUnmap_Signatures[1] = quotaShmUnmap
}
// xShmUnmap function enumeration
typedef enum {
    xShmUnmap_multiplexShmUnmap_enum = 0,
    xShmUnmap_quotaShmUnmap_enum = 1
} xShmUnmap_enum;


// xShmUnmap function declarations
int multiplexShmUnmap(sqlite3_file *pConn, int deleteFlag);
int quotaShmUnmap(sqlite3_file *pConn, int deleteFlag);

// =============== xSleep ===============
// xSleep function pointer signatures
int xSleep_Signatures[2][4];
// xSleep signature initialization function
void init_xSleep_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xSleep_Signatures;
    size_t total_size = sizeof(xSleep_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xSleep_Signatures[0] = multiplexSleep
    // xSleep_Signatures[1] = vfstraceSleep
}
// xSleep function enumeration
typedef enum {
    xSleep_multiplexSleep_enum = 0,
    xSleep_vfstraceSleep_enum = 1
} xSleep_enum;


// xSleep function declarations
int multiplexSleep(sqlite3_vfs *a, int b);
int vfstraceSleep(sqlite3_vfs*, int microseconds);

// =============== xSync ===============
// xSync function pointer signatures
int xSync_Signatures[3][4];
// xSync signature initialization function
void init_xSync_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xSync_Signatures;
    size_t total_size = sizeof(xSync_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xSync_Signatures[0] = multiplexSync
    // xSync_Signatures[1] = quotaSync
    // xSync_Signatures[2] = vfstraceSync
}
// xSync function enumeration
typedef enum {
    xSync_multiplexSync_enum = 0,
    xSync_quotaSync_enum = 1,
    xSync_vfstraceSync_enum = 2
} xSync_enum;


// xSync function declarations
int multiplexSync(sqlite3_file *pConn, int flags);
int quotaSync(sqlite3_file *pConn, int flags);
int vfstraceSync(sqlite3_file*, int flags);

// =============== xTruncate ===============
// xTruncate function pointer signatures
int xTruncate_Signatures[3][4];
// xTruncate signature initialization function
void init_xTruncate_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xTruncate_Signatures;
    size_t total_size = sizeof(xTruncate_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xTruncate_Signatures[0] = multiplexTruncate
    // xTruncate_Signatures[1] = quotaTruncate
    // xTruncate_Signatures[2] = vfstraceTruncate
}
// xTruncate function enumeration
typedef enum {
    xTruncate_multiplexTruncate_enum = 0,
    xTruncate_quotaTruncate_enum = 1,
    xTruncate_vfstraceTruncate_enum = 2
} xTruncate_enum;


// xTruncate function declarations
int multiplexTruncate(sqlite3_file *pConn, sqlite3_int64 size);
int quotaTruncate(sqlite3_file *pConn, sqlite3_int64 size);
int vfstraceTruncate(sqlite3_file*, sqlite3_int64 size);

// =============== xUnlock ===============
// xUnlock function pointer signatures
int xUnlock_Signatures[3][4];
// xUnlock signature initialization function
void init_xUnlock_Signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xUnlock_Signatures;
    size_t total_size = sizeof(xUnlock_Signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xUnlock_Signatures[0] = multiplexUnlock
    // xUnlock_Signatures[1] = quotaUnlock
    // xUnlock_Signatures[2] = vfstraceUnlock
}
// xUnlock function enumeration
typedef enum {
    xUnlock_multiplexUnlock_enum = 0,
    xUnlock_quotaUnlock_enum = 1,
    xUnlock_vfstraceUnlock_enum = 2
} xUnlock_enum;


// xUnlock function declarations
int multiplexUnlock(sqlite3_file *pConn, int lock);
int quotaUnlock(sqlite3_file *pConn, int lock);
int vfstraceUnlock(sqlite3_file*, int);

// =============== xWrite ===============
// xWrite function pointer signatures
int xWrite_Signatures[3][4];
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
    // xWrite_Signatures[2] = vfstraceWrite
}
// xWrite function enumeration
typedef enum {
    xWrite_multiplexWrite_enum = 0,
    xWrite_quotaWrite_enum = 1,
    xWrite_vfstraceWrite_enum = 2
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
int vfstraceWrite(sqlite3_file*,const void*,int iAmt, sqlite3_int64);

// Global initialization function for all signatures
void init_all_fp_Signatures(void) {
    static int global_initialized = 0;
    if (global_initialized) return;
    global_initialized = 1;

    // Seed the random number generator
    srand((unsigned int)time(NULL));

    init_xAccess_Signatures();
    init_xAppend_Signatures();
    init_xBusy_Signatures();
    init_xCellSize_Signatures();
    init_xCheckReservedLock_Signatures();
    init_xClose_Signatures();
    init_xCount_Signatures();
    init_xCreate_Signatures();
    init_xCurrentTime_Signatures();
    init_xCurrentTimeInt64_Signatures();
    init_xDelUser_Signatures();
    init_xDepth_Signatures();
    init_xDeviceCharacteristics_Signatures();
    init_xDlClose_Signatures();
    init_xDlError_Signatures();
    init_xExprCallback_Signatures();
    init_xFileControl_Signatures();
    init_xFileSize_Signatures();
    init_xFindTokenizer_Signatures();
    init_xFindTokenizer_v2_Signatures();
    init_xFree_Signatures();
    init_xFreeSchema_Signatures();
    init_xFullPathname_Signatures();
    init_xGet_Signatures();
    init_xGetLastError_Signatures();
    init_xLock_Signatures();
    init_xMerge_Signatures();
    init_xNew_Signatures();
    init_xNext_Signatures();
    init_xOld_Signatures();
    init_xOpen_Signatures();
    init_xParseCell_Signatures();
    init_xRandomness_Signatures();
    init_xRead_Signatures();
    init_xSectorSize_Signatures();
    init_xSelectCallback_Signatures();
    init_xSelectCallback2_Signatures();
    init_xSetOutputs_Signatures();
    init_xShmBarrier_Signatures();
    init_xShmLock_Signatures();
    init_xShmMap_Signatures();
    init_xShmUnmap_Signatures();
    init_xSleep_Signatures();
    init_xSync_Signatures();
    init_xTruncate_Signatures();
    init_xUnlock_Signatures();
    init_xWrite_Signatures();
}

// Individual initialization function declarations
void init_xAccess_Signatures(void);
void init_xAppend_Signatures(void);
void init_xBusy_Signatures(void);
void init_xCellSize_Signatures(void);
void init_xCheckReservedLock_Signatures(void);
void init_xClose_Signatures(void);
void init_xCount_Signatures(void);
void init_xCreate_Signatures(void);
void init_xCurrentTime_Signatures(void);
void init_xCurrentTimeInt64_Signatures(void);
void init_xDelUser_Signatures(void);
void init_xDepth_Signatures(void);
void init_xDeviceCharacteristics_Signatures(void);
void init_xDlClose_Signatures(void);
void init_xDlError_Signatures(void);
void init_xExprCallback_Signatures(void);
void init_xFileControl_Signatures(void);
void init_xFileSize_Signatures(void);
void init_xFindTokenizer_Signatures(void);
void init_xFindTokenizer_v2_Signatures(void);
void init_xFree_Signatures(void);
void init_xFreeSchema_Signatures(void);
void init_xFullPathname_Signatures(void);
void init_xGet_Signatures(void);
void init_xGetLastError_Signatures(void);
void init_xLock_Signatures(void);
void init_xMerge_Signatures(void);
void init_xNew_Signatures(void);
void init_xNext_Signatures(void);
void init_xOld_Signatures(void);
void init_xOpen_Signatures(void);
void init_xParseCell_Signatures(void);
void init_xRandomness_Signatures(void);
void init_xRead_Signatures(void);
void init_xSectorSize_Signatures(void);
void init_xSelectCallback_Signatures(void);
void init_xSelectCallback2_Signatures(void);
void init_xSetOutputs_Signatures(void);
void init_xShmBarrier_Signatures(void);
void init_xShmLock_Signatures(void);
void init_xShmMap_Signatures(void);
void init_xShmUnmap_Signatures(void);
void init_xSleep_Signatures(void);
void init_xSync_Signatures(void);
void init_xTruncate_Signatures(void);
void init_xUnlock_Signatures(void);
void init_xWrite_Signatures(void);

#endif /* SQLITE_FP_SIGNATURE_HEADER_H */
