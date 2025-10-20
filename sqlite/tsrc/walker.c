/*
** 2008 August 16
**
** The author disclaims copyright to this source code.  In place of
** a legal notice, here is a blessing:
**
**    May you do good and not evil.
**    May you find forgiveness for yourself and forgive others.
**    May you share freely, never taking more than you give.
**
*************************************************************************
** This file contains routines used for walking the parser tree for
** an SQL statement.
*/
#include "sqliteInt.h"
#include <stdlib.h>
#include <string.h>


#if !defined(SQLITE_OMIT_WINDOWFUNC)
/*
** Walk all expressions linked into the list of Window objects passed
** as the second argument.
*/
static int walkWindowList(Walker *pWalker, Window *pList, int bOneOnly){
  Window *pWin;
  for(pWin=pList; pWin; pWin=pWin->pNextWin){
    int rc;
    rc = sqlite3WalkExprList(pWalker, pWin->pOrderBy);
    if( rc ) return WRC_Abort;
    rc = sqlite3WalkExprList(pWalker, pWin->pPartition);
    if( rc ) return WRC_Abort;
    rc = sqlite3WalkExpr(pWalker, pWin->pFilter);
    if( rc ) return WRC_Abort;
    rc = sqlite3WalkExpr(pWalker, pWin->pStart);
    if( rc ) return WRC_Abort;
    rc = sqlite3WalkExpr(pWalker, pWin->pEnd);
    if( rc ) return WRC_Abort;
    if( bOneOnly ) break;
  }
  return WRC_Continue;
}
#endif

/*
** Walk an expression tree.  Invoke the callback once for each node
** of the expression, while descending.  (In other words, the callback
** is invoked before visiting children.)
**
** The return value from the callback should be one of the WRC_*
** constants to specify how to proceed with the walk.
**
**    WRC_Continue      Continue descending down the tree.
**
**    WRC_Prune         Do not descend into child nodes, but allow
**                      the walk to continue with sibling nodes.
**
**    WRC_Abort         Do no more callbacks.  Unwind the stack and
**                      return from the top-level walk call.
**
** The return value from this routine is WRC_Abort to abandon the tree walk
** and WRC_Continue to continue.
*/
SQLITE_NOINLINE int sqlite3WalkExprNN(Walker *pWalker, Expr *pExpr){
  int rc;
  testcase( ExprHasProperty(pExpr, EP_TokenOnly) );
  testcase( ExprHasProperty(pExpr, EP_Reduced) );
  while(1){
    rc = pWalker->xExprCallback(pWalker, pExpr);
    // if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_agginfoPersistExprCb_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = agginfoPersistExprCb(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_aggregateIdxEprRefToColCallback_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = aggregateIdxEprRefToColCallback(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_analyzeAggregate_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = analyzeAggregate(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_checkConstraintExprNode_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = checkConstraintExprNode(pWalker, pExpr);
    // }
    // // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintCheckExpr_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    // //   rc = codeCursorHintCheckExpr(pWalker, pExpr);
    // // }
    // // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintFixExpr_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    // //   rc = codeCursorHintFixExpr(pWalker, pExpr);
    // // }
    // // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_codeCursorHintIsOrFunction_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    // //   rc = codeCursorHintIsOrFunction(pWalker, pExpr);
    // // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_disallowAggregatesInOrderByCb_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = disallowAggregatesInOrderByCb(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprColumnFlagUnion_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = exprColumnFlagUnion(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprIdxCover_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = exprIdxCover(pWalker, pExpr);
    // }
    // // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeCanrc_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    // //   rc = exprNodeCanrc =Subtype(pWalker, pExpr);
    // // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsConstant_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = exprNodeIsConstant(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsConstantOrGroupBy_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = exprNodeIsConstantOrGroupBy(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprNodeIsDeterministic_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = exprNodeIsDeterministic(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_exprRefToSrcList_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = exprRefToSrcList(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_fixExprCb_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = fixExprCb(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_gatherSelectWindowsCallback_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = gatherSelectWindowsCallback(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_havingToWhereExprCb_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = havingToWhereExprCb(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_impliesNotNullRow_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = impliesNotNullRow(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_incrAggDepth_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = incrAggDepth(pWalker, pExpr);
    // }
    // // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_markImmutableExprStep_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    // //   rc = markImmutableExprStep(pWalker, pExpr);
    // // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_propagateConstantExprRewrite_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = propagateConstantExprRewrite(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_recomputeColumnsUsedExpr_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = recomputeColumnsUsedExpr(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameColumnExprCb_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = renameColumnExprCb(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameQuotefixExprCb_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = renameQuotefixExprCb(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameTableExprCb_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = renameTableExprCb(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renameUnmapExprCb_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = renameUnmapExprCb(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_renumberCursorsCb_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = renumberCursorsCb(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_resolveExprStep_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = resolveExprStep(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_resolveRemoveWindowsCb_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = resolveRemoveWindowsCb(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_selectCheckOnClausesExpr_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = selectCheckOnClausesExpr(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_selectWindowRewriteExprCb_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = selectWindowRewriteExprCb(pWalker, pExpr);
    // }
    // // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3CursorRangeHintExprCheck_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    // //   rc = sqlite3CursorRangeHintExprCheck(pWalker, pExpr);
    // // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3ExprWalkNoop_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = sqlite3ExprWalkNoop(pWalker, pExpr);
    // }
    // // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3ReturningSubqueryVarSelect_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    // //   rc = ingSubqueryVarSelect(pWalker, pExpr);
    // // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_sqlite3WindowExtraAggFuncDepth_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = sqlite3WindowExtraAggFuncDepth(pWalker, pExpr);
    // }
    // else if (memcmp(pWalker->xExprCallback_signature, xExprCallback_signatures[xExprCallback_whereIsCoveringIndexWalkCallback_enum], sizeof(pWalker->xExprCallback_signature)) == 0) {
    //   rc = whereIsCoveringIndexWalkCallback(pWalker, pExpr);
    // }
    if( rc ) return rc & WRC_Abort;
    if( !ExprHasProperty(pExpr,(EP_TokenOnly|EP_Leaf)) ){
      assert( pExpr->x.pList==0 || pExpr->pRight==0 );
      if( pExpr->pLeft && sqlite3WalkExprNN(pWalker, pExpr->pLeft) ){
        return WRC_Abort;
      }
      if( pExpr->pRight ){
        assert( !ExprHasProperty(pExpr, EP_WinFunc) );
        pExpr = pExpr->pRight;
        continue;
      }else if( ExprUseXSelect(pExpr) ){
        assert( !ExprHasProperty(pExpr, EP_WinFunc) );
        if( sqlite3WalkSelect(pWalker, pExpr->x.pSelect) ) return WRC_Abort;
      }else{
        if( pExpr->x.pList ){
          if( sqlite3WalkExprList(pWalker, pExpr->x.pList) ) return WRC_Abort;
        }
#ifndef SQLITE_OMIT_WINDOWFUNC
        if( ExprHasProperty(pExpr, EP_WinFunc) ){
          if( walkWindowList(pWalker, pExpr->y.pWin, 1) ) return WRC_Abort;
        }
#endif
      }
    }
    break;
  }
  return WRC_Continue;
}
int sqlite3WalkExpr(Walker *pWalker, Expr *pExpr){
  return pExpr ? sqlite3WalkExprNN(pWalker,pExpr) : WRC_Continue;
}

/*
** Call sqlite3WalkExpr() for every expression in list p or until
** an abort request is seen.
*/
int sqlite3WalkExprList(Walker *pWalker, ExprList *p){
  int i;
  struct ExprList_item *pItem;
  if( p ){
    for(i=p->nExpr, pItem=p->a; i>0; i--, pItem++){
      if( sqlite3WalkExpr(pWalker, pItem->pExpr) ) return WRC_Abort;
    }
  }
  return WRC_Continue;
}

/*
** This is a no-op callback for Walker->xSelectCallback2.  If this
** callback is set, then the Select->pWinDefn list is traversed.
*/
void sqlite3WalkWinDefnDummyCallback(Walker *pWalker, Select *p){
  UNUSED_PARAMETER(pWalker);
  UNUSED_PARAMETER(p);
  /* No-op */
}

/*
** Walk all expressions associated with SELECT statement p.  Do
** not invoke the SELECT callback on p, but do (of course) invoke
** any expr callbacks and SELECT callbacks that come from subqueries.
** Return WRC_Abort or WRC_Continue.
*/
int sqlite3WalkSelectExpr(Walker *pWalker, Select *p){
  if( sqlite3WalkExprList(pWalker, p->pEList) ) return WRC_Abort;
  if( sqlite3WalkExpr(pWalker, p->pWhere) ) return WRC_Abort;
  if( sqlite3WalkExprList(pWalker, p->pGroupBy) ) return WRC_Abort;
  if( sqlite3WalkExpr(pWalker, p->pHaving) ) return WRC_Abort;
  if( sqlite3WalkExprList(pWalker, p->pOrderBy) ) return WRC_Abort;
  if( sqlite3WalkExpr(pWalker, p->pLimit) ) return WRC_Abort;
#if !defined(SQLITE_OMIT_WINDOWFUNC)
  if( p->pWinDefn ){
    Parse *pParse;
    if( pWalker->xSelectCallback2==sqlite3WalkWinDefnDummyCallback
     || ((pParse = pWalker->pParse)!=0 && IN_RENAME_OBJECT)
#ifndef SQLITE_OMIT_CTE
     || pWalker->xSelectCallback2==sqlite3SelectPopWith
#endif
    ){
      /* The following may return WRC_Abort if there are unresolvable
      ** symbols (e.g. a table that does not exist) in a window definition. */
      int rc = walkWindowList(pWalker, p->pWinDefn, 0);
      return rc;
    }
  }
#endif
  return WRC_Continue;
}

/*
** Walk the parse trees associated with all subqueries in the
** FROM clause of SELECT statement p.  Do not invoke the select
** callback on p, but do invoke it on each FROM clause subquery
** and on any subqueries further down in the tree.  Return 
** WRC_Abort or WRC_Continue;
*/
int sqlite3WalkSelectFrom(Walker *pWalker, Select *p){
  SrcList *pSrc;
  int i;
  SrcItem *pItem;

  pSrc = p->pSrc;
  if( ALWAYS(pSrc) ){
    for(i=pSrc->nSrc, pItem=pSrc->a; i>0; i--, pItem++){
      if( pItem->fg.isSubquery
       && sqlite3WalkSelect(pWalker, pItem->u4.pSubq->pSelect)
      ){
        return WRC_Abort;
      }
      if( pItem->fg.isTabFunc
       && sqlite3WalkExprList(pWalker, pItem->u1.pFuncArg)
      ){
        return WRC_Abort;
      }
    }
  }
  return WRC_Continue;
}

/*
** Call sqlite3WalkExpr() for every expression in Select statement p.
** Invoke sqlite3WalkSelect() for subqueries in the FROM clause and
** on the compound select chain, p->pPrior. 
**
** If it is not NULL, the xSelectCallback() callback is invoked before
** the walk of the expressions and FROM clause. The xSelectCallback2()
** method is invoked following the walk of the expressions and FROM clause,
** but only if both xSelectCallback and xSelectCallback2 are both non-NULL
** and if the expressions and FROM clause both return WRC_Continue;
**
** Return WRC_Continue under normal conditions.  Return WRC_Abort if
** there is an abort request.
**
** If the Walker does not have an xSelectCallback() then this routine
** is a no-op returning WRC_Continue.
*/
int sqlite3WalkSelect(Walker *pWalker, Select *p){
  int rc;
  if( p==0 ) return WRC_Continue;
  if( pWalker->xSelectCallback==0 ) return WRC_Continue;
  do{
    if (memcmp(pWalker->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_0_enum], sizeof(pWalker->xSelectCallback_signature)) == 0) {
      rc = 0;
    }
    else
      if (memcmp(pWalker->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_convertCompoundSelectToSubquery_enum], sizeof(pWalker->xSelectCallback_signature)) == 0) {
        rc = convertCompoundSelectToSubquery(pWalker, p);
      }
    else
      if (memcmp(pWalker->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_exprSelectWalkTableConstant_enum], sizeof(pWalker->xSelectCallback_signature)) == 0) {
        rc = exprSelectWalkTableConstant(pWalker, p);
      }
    else
      if (memcmp(pWalker->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_fixSelectCb_enum], sizeof(pWalker->xSelectCallback_signature)) == 0) {
        rc = fixSelectCb(pWalker, p);
      }
    else
      if (memcmp(pWalker->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_gatherSelectWindowsSelectCallback_enum], sizeof(pWalker->xSelectCallback_signature)) == 0) {
        rc = gatherSelectWindowsSelectCallback(pWalker, p);
      }
    else
      if (memcmp(pWalker->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameColumnSelectCb_enum], sizeof(pWalker->xSelectCallback_signature)) == 0) {
        rc = renameColumnSelectCb(pWalker, p);
      }
    else
      if (memcmp(pWalker->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameTableSelectCb_enum], sizeof(pWalker->xSelectCallback_signature)) == 0) {
        rc = renameTableSelectCb(pWalker, p);
      }
    else
      if (memcmp(pWalker->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_renameUnmapSelectCb_enum], sizeof(pWalker->xSelectCallback_signature)) == 0) {
        rc = renameUnmapSelectCb(pWalker, p);
      }
    else
      if (memcmp(pWalker->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_resolveSelectStep_enum], sizeof(pWalker->xSelectCallback_signature)) == 0) {
        rc = resolveSelectStep(pWalker, p);
      }
    else
      if (memcmp(pWalker->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectCheckOnClausesSelect_enum], sizeof(pWalker->xSelectCallback_signature)) == 0) {
        rc = selectCheckOnClausesSelect(pWalker, p);
      }
    else
      if (memcmp(pWalker->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectExpander_enum], sizeof(pWalker->xSelectCallback_signature)) == 0) {
        rc = selectExpander(pWalker, p);
      }
    else
      if (memcmp(pWalker->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectRefEnter_enum], sizeof(pWalker->xSelectCallback_signature)) == 0) {
        rc = selectRefEnter(pWalker, p);
      }
    else
      if (memcmp(pWalker->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_selectWindowRewriteSelectCb_enum], sizeof(pWalker->xSelectCallback_signature)) == 0) {
        rc = selectWindowRewriteSelectCb(pWalker, p);
      }
    else
      if (memcmp(pWalker->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3ReturningSubqueryCorrelated_enum], sizeof(pWalker->xSelectCallback_signature)) == 0) {
        rc = sqlite3ReturningSubqueryCorrelated(pWalker, p);
      }
    else
      if (memcmp(pWalker->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkFail_enum], sizeof(pWalker->xSelectCallback_signature)) == 0) {
        rc = sqlite3SelectWalkFail(pWalker, p);
      }
    else
      if (memcmp(pWalker->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3SelectWalkNoop_enum], sizeof(pWalker->xSelectCallback_signature)) == 0) {
        rc = sqlite3SelectWalkNoop(pWalker, p);
      }
    else
      if (memcmp(pWalker->xSelectCallback_signature, xSelectCallback_signatures[xSelectCallback_sqlite3WalkerDepthIncrease_enum], sizeof(pWalker->xSelectCallback_signature)) == 0) {
        rc = sqlite3WalkerDepthIncrease(pWalker, p);
      }
    if( rc ) return rc & WRC_Abort;
    if( sqlite3WalkSelectExpr(pWalker, p)
     || sqlite3WalkSelectFrom(pWalker, p)
    ){
      return WRC_Abort;
    }
    if( pWalker->xSelectCallback2 ){
      if (memcmp(pWalker->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_0_enum], sizeof(pWalker->xSelectCallback2_signature)) == 0) {
        0;
      }
      else
        if (memcmp(pWalker->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_selectAddSubqueryTypeInfo_enum], sizeof(pWalker->xSelectCallback2_signature)) == 0) {
          selectAddSubqueryTypeInfo(pWalker, p);
        }
      else
        if (memcmp(pWalker->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_selectRefLeave_enum], sizeof(pWalker->xSelectCallback2_signature)) == 0) {
          selectRefLeave(pWalker, p);
        }
      else
        if (memcmp(pWalker->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3SelectPopWith_enum], sizeof(pWalker->xSelectCallback2_signature)) == 0) {
          sqlite3SelectPopWith(pWalker, p);
        }
      else
        if (memcmp(pWalker->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkWinDefnDummyCallback_enum], sizeof(pWalker->xSelectCallback2_signature)) == 0) {
          sqlite3WalkWinDefnDummyCallback(pWalker, p);
        }
      else
        if (memcmp(pWalker->xSelectCallback2_signature, xSelectCallback2_signatures[xSelectCallback2_sqlite3WalkerDepthDecrease_enum], sizeof(pWalker->xSelectCallback2_signature)) == 0) {
          sqlite3WalkerDepthDecrease(pWalker, p);
        }
    }
    p = p->pPrior;
  }while( p!=0 );
  return WRC_Continue;
}

/* Increase the walkerDepth when entering a subquery, and
** decrease when leaving the subquery.
*/
int sqlite3WalkerDepthIncrease(Walker *pWalker, Select *pSelect){
  UNUSED_PARAMETER(pSelect);
  pWalker->walkerDepth++;
  return WRC_Continue;
}
void sqlite3WalkerDepthDecrease(Walker *pWalker, Select *pSelect){
  UNUSED_PARAMETER(pSelect);
  pWalker->walkerDepth--;
}


/*
** No-op routine for the parse-tree walker.
**
** When this routine is the Walker.xExprCallback then expression trees
** are walked without any actions being taken at each node.  Presumably,
** when this routine is used for Walker.xExprCallback then 
** Walker.xSelectCallback is set to do something useful for every 
** subquery in the parser tree.
*/
int sqlite3ExprWalkNoop(Walker *NotUsed, Expr *NotUsed2){
  UNUSED_PARAMETER2(NotUsed, NotUsed2);
  return WRC_Continue;
}

/*
** No-op routine for the parse-tree walker for SELECT statements.
** subquery in the parser tree.
*/
int sqlite3SelectWalkNoop(Walker *NotUsed, Select *NotUsed2){
  UNUSED_PARAMETER2(NotUsed, NotUsed2);
  return WRC_Continue;
}
