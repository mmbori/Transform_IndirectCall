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

#include "btreeInt.h"
#include "sqliteInt.h"

// =============== xAccess ===============
// xAccess function pointer signatures
static int xAccess_signatures[2][4];
// xAccess signature initialization function
static void init_xAccess_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xAccess_signatures;
    size_t total_size = sizeof(xAccess_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xAccess_signatures[0] = multiplexAccess
    // xAccess_signatures[1] = vfstraceAccess
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
static int xAppend_signatures[2][4];
// xAppend signature initialization function
static void init_xAppend_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xAppend_signatures;
    size_t total_size = sizeof(xAppend_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xAppend_signatures[0] = fts5AppendPoslist
    // xAppend_signatures[1] = fts5AppendRowid
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
static int xBusy_signatures[1][4];
// xBusy signature initialization function
static void init_xBusy_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xBusy_signatures;
    size_t total_size = sizeof(xBusy_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xBusy_signatures[0] = xBusy
}
// xBusy function enumeration
typedef enum {
    xBusy_xBusy_enum = 0
} xBusy_enum;


// xBusy function declarations
int xBusy(void *pArg, int nBusy);

// =============== xCellSize ===============
// xCellSize function pointer signatures
static int xCellSize_signatures[4][4];
// xCellSize signature initialization function
static void init_xCellSize_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xCellSize_signatures;
    size_t total_size = sizeof(xCellSize_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xCellSize_signatures[0] = cellSizePtr
    // xCellSize_signatures[1] = cellSizePtrIdxLeaf
    // xCellSize_signatures[2] = cellSizePtrNoPayload
    // xCellSize_signatures[3] = cellSizePtrTableLeaf
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
static int xCheckReservedLock_signatures[3][4];
// xCheckReservedLock signature initialization function
static void init_xCheckReservedLock_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xCheckReservedLock_signatures;
    size_t total_size = sizeof(xCheckReservedLock_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xCheckReservedLock_signatures[0] = multiplexCheckReservedLock
    // xCheckReservedLock_signatures[1] = quotaCheckReservedLock
    // xCheckReservedLock_signatures[2] = vfstraceCheckReservedLock
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
static int xClose_signatures[3][4];
// xClose signature initialization function
static void init_xClose_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xClose_signatures;
    size_t total_size = sizeof(xClose_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xClose_signatures[0] = multiplexClose
    // xClose_signatures[1] = quotaClose
    // xClose_signatures[2] = vfstraceClose
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
static int xCount_signatures[3][4];
// xCount signature initialization function
static void init_xCount_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xCount_signatures;
    size_t total_size = sizeof(xCount_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xCount_signatures[0] = sessionDiffCount
    // xCount_signatures[1] = sessionPreupdateCount
    // xCount_signatures[2] = sessionStat1Count
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
static int xCreate_signatures[2][4];
// xCreate signature initialization function
static void init_xCreate_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xCreate_signatures;
    size_t total_size = sizeof(xCreate_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xCreate_signatures[0] = fts5VtoVCreate
    // xCreate_signatures[1] = vtshimCreate
}
// xCreate function enumeration
typedef enum {
    xCreate_fts5VtoVCreate_enum = 0,
    xCreate_vtshimCreate_enum = 1
} xCreate_enum;


// // xCreate function declarations
// int fts5VtoVCreate(void *pCtx, 
//   const char **azArg, 
//   int nArg, 
//   Fts5Tokenizer **ppOut);

// =============== xCurrentTime ===============
// xCurrentTime function pointer signatures
static int xCurrentTime_signatures[2][4];
// xCurrentTime signature initialization function
static void init_xCurrentTime_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xCurrentTime_signatures;
    size_t total_size = sizeof(xCurrentTime_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xCurrentTime_signatures[0] = multiplexCurrentTime
    // xCurrentTime_signatures[1] = vfstraceCurrentTime
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
static int xCurrentTimeInt64_signatures[1][4];
// xCurrentTimeInt64 signature initialization function
static void init_xCurrentTimeInt64_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xCurrentTimeInt64_signatures;
    size_t total_size = sizeof(xCurrentTimeInt64_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xCurrentTimeInt64_signatures[0] = multiplexCurrentTimeInt64
}
// xCurrentTimeInt64 function enumeration
typedef enum {
    xCurrentTimeInt64_multiplexCurrentTimeInt64_enum = 0
} xCurrentTimeInt64_enum;


// xCurrentTimeInt64 function declarations
int multiplexCurrentTimeInt64(sqlite3_vfs *a, sqlite3_int64 *b);

// =============== xDelUser ===============
// xDelUser function pointer signatures
static int xDelUser_signatures[2][4];
// xDelUser signature initialization function
static void init_xDelUser_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xDelUser_signatures;
    size_t total_size = sizeof(xDelUser_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xDelUser_signatures[0] = circle_del
    // xDelUser_signatures[1] = cube_context_free
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
static int xDepth_signatures[3][4];
// xDepth signature initialization function
static void init_xDepth_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xDepth_signatures;
    size_t total_size = sizeof(xDepth_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xDepth_signatures[0] = sessionDiffDepth
    // xDepth_signatures[1] = sessionPreupdateDepth
    // xDepth_signatures[2] = sessionStat1Depth
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
static int xDeviceCharacteristics_signatures[3][4];
// xDeviceCharacteristics signature initialization function
static void init_xDeviceCharacteristics_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xDeviceCharacteristics_signatures;
    size_t total_size = sizeof(xDeviceCharacteristics_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xDeviceCharacteristics_signatures[0] = multiplexDeviceCharacteristics
    // xDeviceCharacteristics_signatures[1] = quotaDeviceCharacteristics
    // xDeviceCharacteristics_signatures[2] = vfstraceDeviceCharacteristics
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
static int xDlClose_signatures[1][4];
// xDlClose signature initialization function
static void init_xDlClose_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xDlClose_signatures;
    size_t total_size = sizeof(xDlClose_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xDlClose_signatures[0] = multiplexDlClose
}
// xDlClose function enumeration
typedef enum {
    xDlClose_multiplexDlClose_enum = 0
} xDlClose_enum;


// xDlClose function declarations
void multiplexDlClose(sqlite3_vfs *a, void *b);

// =============== xDlError ===============
// xDlError function pointer signatures
static int xDlError_signatures[1][4];
// xDlError signature initialization function
static void init_xDlError_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xDlError_signatures;
    size_t total_size = sizeof(xDlError_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xDlError_signatures[0] = multiplexDlError
}
// xDlError function enumeration
typedef enum {
    xDlError_multiplexDlError_enum = 0
} xDlError_enum;


// xDlError function declarations
void multiplexDlError(sqlite3_vfs *a, int b, char *c);

// =============== xExprCallback ===============
// xExprCallback function pointer signatures
static int xExprCallback_signatures[37][4];
// xExprCallback signature initialization function
static void init_xExprCallback_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xExprCallback_signatures;
    size_t total_size = sizeof(xExprCallback_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xExprCallback_signatures[0] = agginfoPersistExprCb
    // xExprCallback_signatures[1] = aggregateIdxEprRefToColCallback
    // xExprCallback_signatures[2] = analyzeAggregate
    // xExprCallback_signatures[3] = checkConstraintExprNode
    // xExprCallback_signatures[4] = codeCursorHintCheckExpr
    // xExprCallback_signatures[5] = codeCursorHintFixExpr
    // xExprCallback_signatures[6] = codeCursorHintIsOrFunction
    // xExprCallback_signatures[7] = disallowAggregatesInOrderByCb
    // xExprCallback_signatures[8] = exprColumnFlagUnion
    // xExprCallback_signatures[9] = exprIdxCover
    // xExprCallback_signatures[10] = exprNodeCanReturnSubtype
    // xExprCallback_signatures[11] = exprNodeIsConstant
    // xExprCallback_signatures[12] = exprNodeIsConstantOrGroupBy
    // xExprCallback_signatures[13] = exprNodeIsDeterministic
    // xExprCallback_signatures[14] = exprRefToSrcList
    // xExprCallback_signatures[15] = fixExprCb
    // xExprCallback_signatures[16] = gatherSelectWindowsCallback
    // xExprCallback_signatures[17] = havingToWhereExprCb
    // xExprCallback_signatures[18] = impliesNotNullRow
    // xExprCallback_signatures[19] = incrAggDepth
    // xExprCallback_signatures[20] = markImmutableExprStep
    // xExprCallback_signatures[21] = propagateConstantExprRewrite
    // xExprCallback_signatures[22] = recomputeColumnsUsedExpr
    // xExprCallback_signatures[23] = renameColumnExprCb
    // xExprCallback_signatures[24] = renameQuotefixExprCb
    // xExprCallback_signatures[25] = renameTableExprCb
    // xExprCallback_signatures[26] = renameUnmapExprCb
    // xExprCallback_signatures[27] = renumberCursorsCb
    // xExprCallback_signatures[28] = resolveExprStep
    // xExprCallback_signatures[29] = resolveRemoveWindowsCb
    // xExprCallback_signatures[30] = selectCheckOnClausesExpr
    // xExprCallback_signatures[31] = selectWindowRewriteExprCb
    // xExprCallback_signatures[32] = sqlite3CursorRangeHintExprCheck
    // xExprCallback_signatures[33] = sqlite3ExprWalkNoop
    // xExprCallback_signatures[34] = sqlite3ReturningSubqueryVarSelect
    // xExprCallback_signatures[35] = sqlite3WindowExtraAggFuncDepth
    // xExprCallback_signatures[36] = whereIsCoveringIndexWalkCallback
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
static int xFileControl_signatures[3][4];
// xFileControl signature initialization function
static void init_xFileControl_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xFileControl_signatures;
    size_t total_size = sizeof(xFileControl_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xFileControl_signatures[0] = multiplexFileControl
    // xFileControl_signatures[1] = quotaFileControl
    // xFileControl_signatures[2] = vfstraceFileControl
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
static int xFileSize_signatures[3][4];
// xFileSize signature initialization function
static void init_xFileSize_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xFileSize_signatures;
    size_t total_size = sizeof(xFileSize_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xFileSize_signatures[0] = multiplexFileSize
    // xFileSize_signatures[1] = quotaFileSize
    // xFileSize_signatures[2] = vfstraceFileSize
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
static int xFindTokenizer_signatures[1][4];
// xFindTokenizer signature initialization function
static void init_xFindTokenizer_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xFindTokenizer_signatures;
    size_t total_size = sizeof(xFindTokenizer_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xFindTokenizer_signatures[0] = fts5FindTokenizer
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
static int xFindTokenizer_v2_signatures[1][4];
// xFindTokenizer_v2 signature initialization function
static void init_xFindTokenizer_v2_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xFindTokenizer_v2_signatures;
    size_t total_size = sizeof(xFindTokenizer_v2_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xFindTokenizer_v2_signatures[0] = fts5FindTokenizer_v2
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
static int xFree_signatures[1][4];
// xFree signature initialization function
static void init_xFree_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xFree_signatures;
    size_t total_size = sizeof(xFree_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xFree_signatures[0] = xFree
}
// xFree function enumeration
typedef enum {
    xFree_xFree_enum = 0
} xFree_enum;


// xFree function declarations
void xFree(void *p);

// =============== xFreeSchema ===============
// xFreeSchema function pointer signatures
static int xFreeSchema_signatures[1][4];
// xFreeSchema signature initialization function
static void init_xFreeSchema_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xFreeSchema_signatures;
    size_t total_size = sizeof(xFreeSchema_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xFreeSchema_signatures[0] = xFree
}
// xFreeSchema function enumeration
typedef enum {
    xFreeSchema_xFree_enum = 0
} xFreeSchema_enum;


// xFreeSchema function declarations
void xFree(void *p);

// =============== xFullPathname ===============
// xFullPathname function pointer signatures
static int xFullPathname_signatures[2][4];
// xFullPathname signature initialization function
static void init_xFullPathname_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xFullPathname_signatures;
    size_t total_size = sizeof(xFullPathname_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xFullPathname_signatures[0] = multiplexFullPathname
    // xFullPathname_signatures[1] = vfstraceFullPathname
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
static int xGet_signatures[3][4];
// xGet signature initialization function
static void init_xGet_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xGet_signatures;
    size_t total_size = sizeof(xGet_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xGet_signatures[0] = getPageError
    // xGet_signatures[1] = getPageMMap
    // xGet_signatures[2] = getPageNormal
}
// xGet function enumeration
typedef enum {
    xGet_getPageError_enum = 0,
    xGet_getPageMMap_enum = 1,
    xGet_getPageNormal_enum = 2
} xGet_enum;


// xGet function declarations
int getPageError(Pager*,Pgno,DbPage**,int);
int getPageMMap(Pager*,Pgno,DbPage**,int);
int getPageNormal(Pager*,Pgno,DbPage**,int);

// =============== xGetLastError ===============
// xGetLastError function pointer signatures
static int xGetLastError_signatures[1][4];
// xGetLastError signature initialization function
static void init_xGetLastError_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xGetLastError_signatures;
    size_t total_size = sizeof(xGetLastError_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xGetLastError_signatures[0] = multiplexGetLastError
}
// xGetLastError function enumeration
typedef enum {
    xGetLastError_multiplexGetLastError_enum = 0
} xGetLastError_enum;


// xGetLastError function declarations
int multiplexGetLastError(sqlite3_vfs *a, int b, char *c);

// =============== xLock ===============
// xLock function pointer signatures
static int xLock_signatures[3][4];
// xLock signature initialization function
static void init_xLock_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xLock_signatures;
    size_t total_size = sizeof(xLock_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xLock_signatures[0] = multiplexLock
    // xLock_signatures[1] = quotaLock
    // xLock_signatures[2] = vfstraceLock
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
static int xMerge_signatures[2][4];
// xMerge signature initialization function
static void init_xMerge_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xMerge_signatures;
    size_t total_size = sizeof(xMerge_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xMerge_signatures[0] = fts5MergePrefixLists
    // xMerge_signatures[1] = fts5MergeRowidLists
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
static int xNew_signatures[3][4];
// xNew signature initialization function
static void init_xNew_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xNew_signatures;
    size_t total_size = sizeof(xNew_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xNew_signatures[0] = sessionDiffNew
    // xNew_signatures[1] = sessionPreupdateNew
    // xNew_signatures[2] = sessionStat1New
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
static int xNext_signatures[8][4];
// xNext signature initialization function
static void init_xNext_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xNext_signatures;
    size_t total_size = sizeof(xNext_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xNext_signatures[0] = fts5ExprNodeNext_AND
    // xNext_signatures[1] = fts5ExprNodeNext_NOT
    // xNext_signatures[2] = fts5ExprNodeNext_OR
    // xNext_signatures[3] = fts5ExprNodeNext_STRING
    // xNext_signatures[4] = fts5ExprNodeNext_TERM
    // xNext_signatures[5] = fts5SegIterNext
    // xNext_signatures[6] = fts5SegIterNext_None
    // xNext_signatures[7] = fts5SegIterNext_Reverse
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
static int xOld_signatures[3][4];
// xOld signature initialization function
static void init_xOld_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xOld_signatures;
    size_t total_size = sizeof(xOld_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xOld_signatures[0] = sessionDiffOld
    // xOld_signatures[1] = sessionPreupdateOld
    // xOld_signatures[2] = sessionStat1Old
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
static int xOpen_signatures[4][4];
// xOpen signature initialization function
static void init_xOpen_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xOpen_signatures;
    size_t total_size = sizeof(xOpen_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xOpen_signatures[0] = multiplexOpen
    // xOpen_signatures[1] = quotaOpen
    // xOpen_signatures[2] = vfstraceOpen
    // xOpen_signatures[3] = vtshimOpen
}
// xOpen function enumeration
typedef enum {
    xOpen_multiplexOpen_enum = 0,
    xOpen_quotaOpen_enum = 1,
    xOpen_vfstraceOpen_enum = 2,
    xOpen_vtshimOpen_enum = 3
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
int vtshimOpen(sqlite3_vtab *pBase, sqlite3_vtab_cursor **ppCursor);

// =============== xParseCell ===============
// xParseCell function pointer signatures
static int xParseCell_signatures[3][4];
// xParseCell signature initialization function
static void init_xParseCell_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xParseCell_signatures;
    size_t total_size = sizeof(xParseCell_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xParseCell_signatures[0] = btreeParseCellPtr
    // xParseCell_signatures[1] = btreeParseCellPtrIndex
    // xParseCell_signatures[2] = btreeParseCellPtrNoPayload
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
static int xRandomness_signatures[2][4];
// xRandomness signature initialization function
static void init_xRandomness_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xRandomness_signatures;
    size_t total_size = sizeof(xRandomness_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xRandomness_signatures[0] = multiplexRandomness
    // xRandomness_signatures[1] = vfstraceRandomness
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
static int xRead_signatures[3][4];
// xRead signature initialization function
static void init_xRead_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xRead_signatures;
    size_t total_size = sizeof(xRead_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xRead_signatures[0] = multiplexRead
    // xRead_signatures[1] = quotaRead
    // xRead_signatures[2] = vfstraceRead
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
static int xSectorSize_signatures[3][4];
// xSectorSize signature initialization function
static void init_xSectorSize_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xSectorSize_signatures;
    size_t total_size = sizeof(xSectorSize_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xSectorSize_signatures[0] = multiplexSectorSize
    // xSectorSize_signatures[1] = quotaSectorSize
    // xSectorSize_signatures[2] = vfstraceSectorSize
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
static int xSelectCallback_signatures[16][4];
// xSelectCallback signature initialization function
static void init_xSelectCallback_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xSelectCallback_signatures;
    size_t total_size = sizeof(xSelectCallback_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xSelectCallback_signatures[0] = convertCompoundSelectToSubquery
    // xSelectCallback_signatures[1] = exprSelectWalkTableConstant
    // xSelectCallback_signatures[2] = fixSelectCb
    // xSelectCallback_signatures[3] = gatherSelectWindowsSelectCallback
    // xSelectCallback_signatures[4] = renameColumnSelectCb
    // xSelectCallback_signatures[5] = renameTableSelectCb
    // xSelectCallback_signatures[6] = renameUnmapSelectCb
    // xSelectCallback_signatures[7] = resolveSelectStep
    // xSelectCallback_signatures[8] = selectCheckOnClausesSelect
    // xSelectCallback_signatures[9] = selectExpander
    // xSelectCallback_signatures[10] = selectRefEnter
    // xSelectCallback_signatures[11] = selectWindowRewriteSelectCb
    // xSelectCallback_signatures[12] = sqlite3ReturningSubqueryCorrelated
    // xSelectCallback_signatures[13] = sqlite3SelectWalkFail
    // xSelectCallback_signatures[14] = sqlite3SelectWalkNoop
    // xSelectCallback_signatures[15] = sqlite3WalkerDepthIncrease
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
static int xSelectCallback2_signatures[6][4];
// xSelectCallback2 signature initialization function
static void init_xSelectCallback2_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xSelectCallback2_signatures;
    size_t total_size = sizeof(xSelectCallback2_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xSelectCallback2_signatures[0] = selectAddSubqueryTypeInfo
    // xSelectCallback2_signatures[1] = selectRefLeave
    // xSelectCallback2_signatures[2] = sqlite3SelectPopWith
    // xSelectCallback2_signatures[3] = sqlite3SelectWalkAssert2
    // xSelectCallback2_signatures[4] = sqlite3WalkWinDefnDummyCallback
    // xSelectCallback2_signatures[5] = sqlite3WalkerDepthDecrease
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
void selectAddSubqueryTypeInfo(Walker *pWalker, Select *p);
void selectRefLeave(Walker *pWalker, Select *pSelect);
void sqlite3SelectPopWith(Walker *pWalker, Select *p);
void sqlite3SelectWalkAssert2(Walker *NotUsed, Select *NotUsed2);
void sqlite3WalkWinDefnDummyCallback(Walker *pWalker, Select *p);
void sqlite3WalkerDepthDecrease(Walker *pWalker, Select *pSelect);

// =============== xSetOutputs ===============
// xSetOutputs function pointer signatures
static int xSetOutputs_signatures[7][4];
// xSetOutputs signature initialization function
static void init_xSetOutputs_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xSetOutputs_signatures;
    size_t total_size = sizeof(xSetOutputs_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xSetOutputs_signatures[0] = fts5IterSetOutputs_Col
    // xSetOutputs_signatures[1] = fts5IterSetOutputs_Col100
    // xSetOutputs_signatures[2] = fts5IterSetOutputs_Full
    // xSetOutputs_signatures[3] = fts5IterSetOutputs_Nocolset
    // xSetOutputs_signatures[4] = fts5IterSetOutputs_None
    // xSetOutputs_signatures[5] = fts5IterSetOutputs_Noop
    // xSetOutputs_signatures[6] = fts5IterSetOutputs_ZeroColset
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
static int xShmBarrier_signatures[2][4];
// xShmBarrier signature initialization function
static void init_xShmBarrier_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xShmBarrier_signatures;
    size_t total_size = sizeof(xShmBarrier_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xShmBarrier_signatures[0] = multiplexShmBarrier
    // xShmBarrier_signatures[1] = quotaShmBarrier
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
static int xShmLock_signatures[2][4];
// xShmLock signature initialization function
static void init_xShmLock_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xShmLock_signatures;
    size_t total_size = sizeof(xShmLock_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xShmLock_signatures[0] = multiplexShmLock
    // xShmLock_signatures[1] = quotaShmLock
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
static int xShmMap_signatures[2][4];
// xShmMap signature initialization function
static void init_xShmMap_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xShmMap_signatures;
    size_t total_size = sizeof(xShmMap_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xShmMap_signatures[0] = multiplexShmMap
    // xShmMap_signatures[1] = quotaShmMap
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
static int xShmUnmap_signatures[2][4];
// xShmUnmap signature initialization function
static void init_xShmUnmap_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xShmUnmap_signatures;
    size_t total_size = sizeof(xShmUnmap_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xShmUnmap_signatures[0] = multiplexShmUnmap
    // xShmUnmap_signatures[1] = quotaShmUnmap
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
static int xSleep_signatures[2][4];
// xSleep signature initialization function
static void init_xSleep_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xSleep_signatures;
    size_t total_size = sizeof(xSleep_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xSleep_signatures[0] = multiplexSleep
    // xSleep_signatures[1] = vfstraceSleep
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
static int xSync_signatures[3][4];
// xSync signature initialization function
static void init_xSync_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xSync_signatures;
    size_t total_size = sizeof(xSync_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xSync_signatures[0] = multiplexSync
    // xSync_signatures[1] = quotaSync
    // xSync_signatures[2] = vfstraceSync
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
static int xTruncate_signatures[3][4];
// xTruncate signature initialization function
static void init_xTruncate_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xTruncate_signatures;
    size_t total_size = sizeof(xTruncate_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xTruncate_signatures[0] = multiplexTruncate
    // xTruncate_signatures[1] = quotaTruncate
    // xTruncate_signatures[2] = vfstraceTruncate
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
static int xUnlock_signatures[3][4];
// xUnlock signature initialization function
static void init_xUnlock_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xUnlock_signatures;
    size_t total_size = sizeof(xUnlock_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xUnlock_signatures[0] = multiplexUnlock
    // xUnlock_signatures[1] = quotaUnlock
    // xUnlock_signatures[2] = vfstraceUnlock
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
static int xWrite_signatures[3][4];
// xWrite signature initialization function
static void init_xWrite_signatures(void) {
    static int initialized = 0;
    if (initialized) return;
    initialized = 1;

    // Fill all signatures with random data
    unsigned char* ptr = (unsigned char*)xWrite_signatures;
    size_t total_size = sizeof(xWrite_signatures);
    for (size_t i = 0; i < total_size; i++) {
        ptr[i] = (unsigned char)(rand() & 0xFF);
    }

    // xWrite_signatures[0] = multiplexWrite
    // xWrite_signatures[1] = quotaWrite
    // xWrite_signatures[2] = vfstraceWrite
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
static void init_all_fp_signatures(void) {
    static int global_initialized = 0;
    if (global_initialized) return;
    global_initialized = 1;

    // Seed the random number generator
    srand((unsigned int)time(NULL));

    init_xAccess_signatures();
    init_xAppend_signatures();
    init_xBusy_signatures();
    init_xCellSize_signatures();
    init_xCheckReservedLock_signatures();
    init_xClose_signatures();
    init_xCount_signatures();
    init_xCreate_signatures();
    init_xCurrentTime_signatures();
    init_xCurrentTimeInt64_signatures();
    init_xDelUser_signatures();
    init_xDepth_signatures();
    init_xDeviceCharacteristics_signatures();
    init_xDlClose_signatures();
    init_xDlError_signatures();
    init_xExprCallback_signatures();
    init_xFileControl_signatures();
    init_xFileSize_signatures();
    init_xFindTokenizer_signatures();
    init_xFindTokenizer_v2_signatures();
    init_xFree_signatures();
    init_xFreeSchema_signatures();
    init_xFullPathname_signatures();
    init_xGet_signatures();
    init_xGetLastError_signatures();
    init_xLock_signatures();
    init_xMerge_signatures();
    init_xNew_signatures();
    init_xNext_signatures();
    init_xOld_signatures();
    init_xOpen_signatures();
    init_xParseCell_signatures();
    init_xRandomness_signatures();
    init_xRead_signatures();
    init_xSectorSize_signatures();
    init_xSelectCallback_signatures();
    init_xSelectCallback2_signatures();
    init_xSetOutputs_signatures();
    init_xShmBarrier_signatures();
    init_xShmLock_signatures();
    init_xShmMap_signatures();
    init_xShmUnmap_signatures();
    init_xSleep_signatures();
    init_xSync_signatures();
    init_xTruncate_signatures();
    init_xUnlock_signatures();
    init_xWrite_signatures();
}

// Individual initialization function declarations
static void init_xAccess_signatures(void);
static void init_xAppend_signatures(void);
static void init_xBusy_signatures(void);
static void init_xCellSize_signatures(void);
static void init_xCheckReservedLock_signatures(void);
static void init_xClose_signatures(void);
static void init_xCount_signatures(void);
static void init_xCreate_signatures(void);
static void init_xCurrentTime_signatures(void);
static void init_xCurrentTimeInt64_signatures(void);
static void init_xDelUser_signatures(void);
static void init_xDepth_signatures(void);
static void init_xDeviceCharacteristics_signatures(void);
static void init_xDlClose_signatures(void);
static void init_xDlError_signatures(void);
static void init_xExprCallback_signatures(void);
static void init_xFileControl_signatures(void);
static void init_xFileSize_signatures(void);
static void init_xFindTokenizer_signatures(void);
static void init_xFindTokenizer_v2_signatures(void);
static void init_xFree_signatures(void);
static void init_xFreeSchema_signatures(void);
static void init_xFullPathname_signatures(void);
static void init_xGet_signatures(void);
static void init_xGetLastError_signatures(void);
static void init_xLock_signatures(void);
static void init_xMerge_signatures(void);
static void init_xNew_signatures(void);
static void init_xNext_signatures(void);
static void init_xOld_signatures(void);
static void init_xOpen_signatures(void);
static void init_xParseCell_signatures(void);
static void init_xRandomness_signatures(void);
static void init_xRead_signatures(void);
static void init_xSectorSize_signatures(void);
static void init_xSelectCallback_signatures(void);
static void init_xSelectCallback2_signatures(void);
static void init_xSetOutputs_signatures(void);
static void init_xShmBarrier_signatures(void);
static void init_xShmLock_signatures(void);
static void init_xShmMap_signatures(void);
static void init_xShmUnmap_signatures(void);
static void init_xSleep_signatures(void);
static void init_xSync_signatures(void);
static void init_xTruncate_signatures(void);
static void init_xUnlock_signatures(void);
static void init_xWrite_signatures(void);

#endif /* SQLITE_FP_SIGNATURE_HEADER_H */
