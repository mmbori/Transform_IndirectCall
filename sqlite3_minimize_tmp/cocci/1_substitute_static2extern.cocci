// Auto-generated Coccinelle script to replace `static` with `extern`
// for specific functions listed in callsites.json and SQLite structure definitions
//
// This script changes function linkage from static to extern, making them
// globally visible and accessible from other files without includes.
//
// Includes functions from:
// - callsites.json callee lists
// - sqlite3_mutex_methods structure (mutex functions)
// - sqlite3_mem_methods structure (memory functions)  
// - sqlite3_pcache_methods2 structure (page cache functions)
// - UNIXVFS structure (VFS functions)
//
// Usage: spatch --sp-file static_to_extern.cocci --dir <source_directory> --in-place

@initialize:python@
@@
print(">>> Starting static to extern conversion")
print(">>> Making functions globally visible")


// Rules for function: absFunc - change static to extern
@static_to_extern_def_brace_same_line_absFunc@
identifier F = { absFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_absFunc@
identifier F = { absFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_absFunc@
identifier F = { absFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_absFunc@
identifier F = { absFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_absFunc@
identifier F = { absFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: agginfoFree - change static to extern
@static_to_extern_def_brace_same_line_agginfoFree@
identifier F = { agginfoFree };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_agginfoFree@
identifier F = { agginfoFree };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_agginfoFree@
identifier F = { agginfoFree };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_agginfoFree@
identifier F = { agginfoFree };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_agginfoFree@
identifier F = { agginfoFree };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: agginfoPersistExprCb - change static to extern
@static_to_extern_def_brace_same_line_agginfoPersistExprCb@
identifier F = { agginfoPersistExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_agginfoPersistExprCb@
identifier F = { agginfoPersistExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_agginfoPersistExprCb@
identifier F = { agginfoPersistExprCb };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_agginfoPersistExprCb@
identifier F = { agginfoPersistExprCb };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_agginfoPersistExprCb@
identifier F = { agginfoPersistExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: analysisLoader - change static to extern
@static_to_extern_def_brace_same_line_analysisLoader@
identifier F = { analysisLoader };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_analysisLoader@
identifier F = { analysisLoader };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_analysisLoader@
identifier F = { analysisLoader };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_analysisLoader@
identifier F = { analysisLoader };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_analysisLoader@
identifier F = { analysisLoader };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: analyzeAggregate - change static to extern
@static_to_extern_def_brace_same_line_analyzeAggregate@
identifier F = { analyzeAggregate };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_analyzeAggregate@
identifier F = { analyzeAggregate };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_analyzeAggregate@
identifier F = { analyzeAggregate };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_analyzeAggregate@
identifier F = { analyzeAggregate };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_analyzeAggregate@
identifier F = { analyzeAggregate };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: attachFunc - change static to extern
@static_to_extern_def_brace_same_line_attachFunc@
identifier F = { attachFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_attachFunc@
identifier F = { attachFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_attachFunc@
identifier F = { attachFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_attachFunc@
identifier F = { attachFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_attachFunc@
identifier F = { attachFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: avgFinalize - change static to extern
@static_to_extern_def_brace_same_line_avgFinalize@
identifier F = { avgFinalize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_avgFinalize@
identifier F = { avgFinalize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_avgFinalize@
identifier F = { avgFinalize };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_avgFinalize@
identifier F = { avgFinalize };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_avgFinalize@
identifier F = { avgFinalize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: binCollFunc - change static to extern
@static_to_extern_def_brace_same_line_binCollFunc@
identifier F = { binCollFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_binCollFunc@
identifier F = { binCollFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_binCollFunc@
identifier F = { binCollFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_binCollFunc@
identifier F = { binCollFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_binCollFunc@
identifier F = { binCollFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: btreeParseCellPtr - change static to extern
@static_to_extern_def_brace_same_line_btreeParseCellPtr@
identifier F = { btreeParseCellPtr };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_btreeParseCellPtr@
identifier F = { btreeParseCellPtr };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_btreeParseCellPtr@
identifier F = { btreeParseCellPtr };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_btreeParseCellPtr@
identifier F = { btreeParseCellPtr };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_btreeParseCellPtr@
identifier F = { btreeParseCellPtr };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: btreeParseCellPtrIndex - change static to extern
@static_to_extern_def_brace_same_line_btreeParseCellPtrIndex@
identifier F = { btreeParseCellPtrIndex };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_btreeParseCellPtrIndex@
identifier F = { btreeParseCellPtrIndex };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_btreeParseCellPtrIndex@
identifier F = { btreeParseCellPtrIndex };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_btreeParseCellPtrIndex@
identifier F = { btreeParseCellPtrIndex };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_btreeParseCellPtrIndex@
identifier F = { btreeParseCellPtrIndex };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: ceilingFunc - change static to extern
@static_to_extern_def_brace_same_line_ceilingFunc@
identifier F = { ceilingFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_ceilingFunc@
identifier F = { ceilingFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_ceilingFunc@
identifier F = { ceilingFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_ceilingFunc@
identifier F = { ceilingFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_ceilingFunc@
identifier F = { ceilingFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: cellSizePtrTableLeaf - change static to extern
@static_to_extern_def_brace_same_line_cellSizePtrTableLeaf@
identifier F = { cellSizePtrTableLeaf };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_cellSizePtrTableLeaf@
identifier F = { cellSizePtrTableLeaf };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_cellSizePtrTableLeaf@
identifier F = { cellSizePtrTableLeaf };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_cellSizePtrTableLeaf@
identifier F = { cellSizePtrTableLeaf };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_cellSizePtrTableLeaf@
identifier F = { cellSizePtrTableLeaf };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: changes - change static to extern
@static_to_extern_def_brace_same_line_changes@
identifier F = { changes };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_changes@
identifier F = { changes };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_changes@
identifier F = { changes };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_changes@
identifier F = { changes };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_changes@
identifier F = { changes };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: charFunc - change static to extern
@static_to_extern_def_brace_same_line_charFunc@
identifier F = { charFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_charFunc@
identifier F = { charFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_charFunc@
identifier F = { charFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_charFunc@
identifier F = { charFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_charFunc@
identifier F = { charFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: checkConstraintExprNode - change static to extern
@static_to_extern_def_brace_same_line_checkConstraintExprNode@
identifier F = { checkConstraintExprNode };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_checkConstraintExprNode@
identifier F = { checkConstraintExprNode };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_checkConstraintExprNode@
identifier F = { checkConstraintExprNode };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_checkConstraintExprNode@
identifier F = { checkConstraintExprNode };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_checkConstraintExprNode@
identifier F = { checkConstraintExprNode };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: countFinalize - change static to extern
@static_to_extern_def_brace_same_line_countFinalize@
identifier F = { countFinalize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_countFinalize@
identifier F = { countFinalize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_countFinalize@
identifier F = { countFinalize };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_countFinalize@
identifier F = { countFinalize };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_countFinalize@
identifier F = { countFinalize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: countStep - change static to extern
@static_to_extern_def_brace_same_line_countStep@
identifier F = { countStep };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_countStep@
identifier F = { countStep };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_countStep@
identifier F = { countStep };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_countStep@
identifier F = { countStep };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_countStep@
identifier F = { countStep };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: ctimestampFunc - change static to extern
@static_to_extern_def_brace_same_line_ctimestampFunc@
identifier F = { ctimestampFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_ctimestampFunc@
identifier F = { ctimestampFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_ctimestampFunc@
identifier F = { ctimestampFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_ctimestampFunc@
identifier F = { ctimestampFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_ctimestampFunc@
identifier F = { ctimestampFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: dateFunc - change static to extern
@static_to_extern_def_brace_same_line_dateFunc@
identifier F = { dateFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_dateFunc@
identifier F = { dateFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_dateFunc@
identifier F = { dateFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_dateFunc@
identifier F = { dateFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_dateFunc@
identifier F = { dateFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: datetimeFunc - change static to extern
@static_to_extern_def_brace_same_line_datetimeFunc@
identifier F = { datetimeFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_datetimeFunc@
identifier F = { datetimeFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_datetimeFunc@
identifier F = { datetimeFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_datetimeFunc@
identifier F = { datetimeFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_datetimeFunc@
identifier F = { datetimeFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: dense_rankStepFunc - change static to extern
@static_to_extern_def_brace_same_line_dense_rankStepFunc@
identifier F = { dense_rankStepFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_dense_rankStepFunc@
identifier F = { dense_rankStepFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_dense_rankStepFunc@
identifier F = { dense_rankStepFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_dense_rankStepFunc@
identifier F = { dense_rankStepFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_dense_rankStepFunc@
identifier F = { dense_rankStepFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: dense_rankValueFunc - change static to extern
@static_to_extern_def_brace_same_line_dense_rankValueFunc@
identifier F = { dense_rankValueFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_dense_rankValueFunc@
identifier F = { dense_rankValueFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_dense_rankValueFunc@
identifier F = { dense_rankValueFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_dense_rankValueFunc@
identifier F = { dense_rankValueFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_dense_rankValueFunc@
identifier F = { dense_rankValueFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: disallowAggregatesInOrderByCb - change static to extern
@static_to_extern_def_brace_same_line_disallowAggregatesInOrderByCb@
identifier F = { disallowAggregatesInOrderByCb };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_disallowAggregatesInOrderByCb@
identifier F = { disallowAggregatesInOrderByCb };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_disallowAggregatesInOrderByCb@
identifier F = { disallowAggregatesInOrderByCb };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_disallowAggregatesInOrderByCb@
identifier F = { disallowAggregatesInOrderByCb };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_disallowAggregatesInOrderByCb@
identifier F = { disallowAggregatesInOrderByCb };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: exprIdxCover - change static to extern
@static_to_extern_def_brace_same_line_exprIdxCover@
identifier F = { exprIdxCover };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_exprIdxCover@
identifier F = { exprIdxCover };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_exprIdxCover@
identifier F = { exprIdxCover };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_exprIdxCover@
identifier F = { exprIdxCover };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_exprIdxCover@
identifier F = { exprIdxCover };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: exprNodeIsConstant - change static to extern
@static_to_extern_def_brace_same_line_exprNodeIsConstant@
identifier F = { exprNodeIsConstant };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_exprNodeIsConstant@
identifier F = { exprNodeIsConstant };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_exprNodeIsConstant@
identifier F = { exprNodeIsConstant };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_exprNodeIsConstant@
identifier F = { exprNodeIsConstant };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_exprNodeIsConstant@
identifier F = { exprNodeIsConstant };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: exprNodeIsDeterministic - change static to extern
@static_to_extern_def_brace_same_line_exprNodeIsDeterministic@
identifier F = { exprNodeIsDeterministic };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_exprNodeIsDeterministic@
identifier F = { exprNodeIsDeterministic };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_exprNodeIsDeterministic@
identifier F = { exprNodeIsDeterministic };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_exprNodeIsDeterministic@
identifier F = { exprNodeIsDeterministic };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_exprNodeIsDeterministic@
identifier F = { exprNodeIsDeterministic };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: exprRefToSrcList - change static to extern
@static_to_extern_def_brace_same_line_exprRefToSrcList@
identifier F = { exprRefToSrcList };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_exprRefToSrcList@
identifier F = { exprRefToSrcList };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_exprRefToSrcList@
identifier F = { exprRefToSrcList };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_exprRefToSrcList@
identifier F = { exprRefToSrcList };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_exprRefToSrcList@
identifier F = { exprRefToSrcList };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: fixExprCb - change static to extern
@static_to_extern_def_brace_same_line_fixExprCb@
identifier F = { fixExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_fixExprCb@
identifier F = { fixExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_fixExprCb@
identifier F = { fixExprCb };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_fixExprCb@
identifier F = { fixExprCb };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_fixExprCb@
identifier F = { fixExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: fixSelectCb - change static to extern
@static_to_extern_def_brace_same_line_fixSelectCb@
identifier F = { fixSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_fixSelectCb@
identifier F = { fixSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_fixSelectCb@
identifier F = { fixSelectCb };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_fixSelectCb@
identifier F = { fixSelectCb };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_fixSelectCb@
identifier F = { fixSelectCb };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: fts3StrCompare - change static to extern
@static_to_extern_def_brace_same_line_fts3StrCompare@
identifier F = { fts3StrCompare };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_fts3StrCompare@
identifier F = { fts3StrCompare };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_fts3StrCompare@
identifier F = { fts3StrCompare };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_fts3StrCompare@
identifier F = { fts3StrCompare };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_fts3StrCompare@
identifier F = { fts3StrCompare };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: fts3StrHash - change static to extern
@static_to_extern_def_brace_same_line_fts3StrHash@
identifier F = { fts3StrHash };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_fts3StrHash@
identifier F = { fts3StrHash };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_fts3StrHash@
identifier F = { fts3StrHash };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_fts3StrHash@
identifier F = { fts3StrHash };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_fts3StrHash@
identifier F = { fts3StrHash };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: getPageError - change static to extern
@static_to_extern_def_brace_same_line_getPageError@
identifier F = { getPageError };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_getPageError@
identifier F = { getPageError };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_getPageError@
identifier F = { getPageError };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_getPageError@
identifier F = { getPageError };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_getPageError@
identifier F = { getPageError };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: getPageNormal - change static to extern
@static_to_extern_def_brace_same_line_getPageNormal@
identifier F = { getPageNormal };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_getPageNormal@
identifier F = { getPageNormal };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_getPageNormal@
identifier F = { getPageNormal };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_getPageNormal@
identifier F = { getPageNormal };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_getPageNormal@
identifier F = { getPageNormal };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: groupConcatFinalize - change static to extern
@static_to_extern_def_brace_same_line_groupConcatFinalize@
identifier F = { groupConcatFinalize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_groupConcatFinalize@
identifier F = { groupConcatFinalize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_groupConcatFinalize@
identifier F = { groupConcatFinalize };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_groupConcatFinalize@
identifier F = { groupConcatFinalize };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_groupConcatFinalize@
identifier F = { groupConcatFinalize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: groupConcatStep - change static to extern
@static_to_extern_def_brace_same_line_groupConcatStep@
identifier F = { groupConcatStep };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_groupConcatStep@
identifier F = { groupConcatStep };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_groupConcatStep@
identifier F = { groupConcatStep };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_groupConcatStep@
identifier F = { groupConcatStep };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_groupConcatStep@
identifier F = { groupConcatStep };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: hashDestroy - change static to extern
@static_to_extern_def_brace_same_line_hashDestroy@
identifier F = { hashDestroy };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_hashDestroy@
identifier F = { hashDestroy };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_hashDestroy@
identifier F = { hashDestroy };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_hashDestroy@
identifier F = { hashDestroy };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_hashDestroy@
identifier F = { hashDestroy };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: hexFunc - change static to extern
@static_to_extern_def_brace_same_line_hexFunc@
identifier F = { hexFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_hexFunc@
identifier F = { hexFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_hexFunc@
identifier F = { hexFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_hexFunc@
identifier F = { hexFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_hexFunc@
identifier F = { hexFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: impliesNotNullRow - change static to extern
@static_to_extern_def_brace_same_line_impliesNotNullRow@
identifier F = { impliesNotNullRow };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_impliesNotNullRow@
identifier F = { impliesNotNullRow };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_impliesNotNullRow@
identifier F = { impliesNotNullRow };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_impliesNotNullRow@
identifier F = { impliesNotNullRow };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_impliesNotNullRow@
identifier F = { impliesNotNullRow };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: instrFunc - change static to extern
@static_to_extern_def_brace_same_line_instrFunc@
identifier F = { instrFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_instrFunc@
identifier F = { instrFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_instrFunc@
identifier F = { instrFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_instrFunc@
identifier F = { instrFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_instrFunc@
identifier F = { instrFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: jsonArrayFunc - change static to extern
@static_to_extern_def_brace_same_line_jsonArrayFunc@
identifier F = { jsonArrayFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_jsonArrayFunc@
identifier F = { jsonArrayFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_jsonArrayFunc@
identifier F = { jsonArrayFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_jsonArrayFunc@
identifier F = { jsonArrayFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_jsonArrayFunc@
identifier F = { jsonArrayFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: jsonCacheDeleteGeneric - change static to extern
@static_to_extern_def_brace_same_line_jsonCacheDeleteGeneric@
identifier F = { jsonCacheDeleteGeneric };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_jsonCacheDeleteGeneric@
identifier F = { jsonCacheDeleteGeneric };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_jsonCacheDeleteGeneric@
identifier F = { jsonCacheDeleteGeneric };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_jsonCacheDeleteGeneric@
identifier F = { jsonCacheDeleteGeneric };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_jsonCacheDeleteGeneric@
identifier F = { jsonCacheDeleteGeneric };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: jsonObjectFunc - change static to extern
@static_to_extern_def_brace_same_line_jsonObjectFunc@
identifier F = { jsonObjectFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_jsonObjectFunc@
identifier F = { jsonObjectFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_jsonObjectFunc@
identifier F = { jsonObjectFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_jsonObjectFunc@
identifier F = { jsonObjectFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_jsonObjectFunc@
identifier F = { jsonObjectFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: jsonTypeFunc - change static to extern
@static_to_extern_def_brace_same_line_jsonTypeFunc@
identifier F = { jsonTypeFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_jsonTypeFunc@
identifier F = { jsonTypeFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_jsonTypeFunc@
identifier F = { jsonTypeFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_jsonTypeFunc@
identifier F = { jsonTypeFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_jsonTypeFunc@
identifier F = { jsonTypeFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: juliandayFunc - change static to extern
@static_to_extern_def_brace_same_line_juliandayFunc@
identifier F = { juliandayFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_juliandayFunc@
identifier F = { juliandayFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_juliandayFunc@
identifier F = { juliandayFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_juliandayFunc@
identifier F = { juliandayFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_juliandayFunc@
identifier F = { juliandayFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: last_insert_rowid - change static to extern
@static_to_extern_def_brace_same_line_last_insert_rowid@
identifier F = { last_insert_rowid };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_last_insert_rowid@
identifier F = { last_insert_rowid };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_last_insert_rowid@
identifier F = { last_insert_rowid };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_last_insert_rowid@
identifier F = { last_insert_rowid };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_last_insert_rowid@
identifier F = { last_insert_rowid };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: lengthFunc - change static to extern
@static_to_extern_def_brace_same_line_lengthFunc@
identifier F = { lengthFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_lengthFunc@
identifier F = { lengthFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_lengthFunc@
identifier F = { lengthFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_lengthFunc@
identifier F = { lengthFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_lengthFunc@
identifier F = { lengthFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: likeFunc - change static to extern
@static_to_extern_def_brace_same_line_likeFunc@
identifier F = { likeFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_likeFunc@
identifier F = { likeFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_likeFunc@
identifier F = { likeFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_likeFunc@
identifier F = { likeFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_likeFunc@
identifier F = { likeFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: logFunc - change static to extern
@static_to_extern_def_brace_same_line_logFunc@
identifier F = { logFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_logFunc@
identifier F = { logFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_logFunc@
identifier F = { logFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_logFunc@
identifier F = { logFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_logFunc@
identifier F = { logFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: lowerFunc - change static to extern
@static_to_extern_def_brace_same_line_lowerFunc@
identifier F = { lowerFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_lowerFunc@
identifier F = { lowerFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_lowerFunc@
identifier F = { lowerFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_lowerFunc@
identifier F = { lowerFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_lowerFunc@
identifier F = { lowerFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: math1Func - change static to extern
@static_to_extern_def_brace_same_line_math1Func@
identifier F = { math1Func };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_math1Func@
identifier F = { math1Func };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_math1Func@
identifier F = { math1Func };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_math1Func@
identifier F = { math1Func };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_math1Func@
identifier F = { math1Func };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: math2Func - change static to extern
@static_to_extern_def_brace_same_line_math2Func@
identifier F = { math2Func };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_math2Func@
identifier F = { math2Func };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_math2Func@
identifier F = { math2Func };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_math2Func@
identifier F = { math2Func };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_math2Func@
identifier F = { math2Func };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: memjrnlClose - change static to extern
@static_to_extern_def_brace_same_line_memjrnlClose@
identifier F = { memjrnlClose };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_memjrnlClose@
identifier F = { memjrnlClose };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_memjrnlClose@
identifier F = { memjrnlClose };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_memjrnlClose@
identifier F = { memjrnlClose };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_memjrnlClose@
identifier F = { memjrnlClose };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: memjrnlTruncate - change static to extern
@static_to_extern_def_brace_same_line_memjrnlTruncate@
identifier F = { memjrnlTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_memjrnlTruncate@
identifier F = { memjrnlTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_memjrnlTruncate@
identifier F = { memjrnlTruncate };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_memjrnlTruncate@
identifier F = { memjrnlTruncate };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_memjrnlTruncate@
identifier F = { memjrnlTruncate };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: memjrnlWrite - change static to extern
@static_to_extern_def_brace_same_line_memjrnlWrite@
identifier F = { memjrnlWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_memjrnlWrite@
identifier F = { memjrnlWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_memjrnlWrite@
identifier F = { memjrnlWrite };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_memjrnlWrite@
identifier F = { memjrnlWrite };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_memjrnlWrite@
identifier F = { memjrnlWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: minMaxFinalize - change static to extern
@static_to_extern_def_brace_same_line_minMaxFinalize@
identifier F = { minMaxFinalize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_minMaxFinalize@
identifier F = { minMaxFinalize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_minMaxFinalize@
identifier F = { minMaxFinalize };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_minMaxFinalize@
identifier F = { minMaxFinalize };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_minMaxFinalize@
identifier F = { minMaxFinalize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: minmaxStep - change static to extern
@static_to_extern_def_brace_same_line_minmaxStep@
identifier F = { minmaxStep };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_minmaxStep@
identifier F = { minmaxStep };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_minmaxStep@
identifier F = { minmaxStep };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_minmaxStep@
identifier F = { minmaxStep };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_minmaxStep@
identifier F = { minmaxStep };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: nolockClose - change static to extern
@static_to_extern_def_brace_same_line_nolockClose@
identifier F = { nolockClose };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_nolockClose@
identifier F = { nolockClose };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_nolockClose@
identifier F = { nolockClose };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_nolockClose@
identifier F = { nolockClose };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_nolockClose@
identifier F = { nolockClose };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: noopMutexAlloc - change static to extern
@static_to_extern_def_brace_same_line_noopMutexAlloc@
identifier F = { noopMutexAlloc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_noopMutexAlloc@
identifier F = { noopMutexAlloc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_noopMutexAlloc@
identifier F = { noopMutexAlloc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_noopMutexAlloc@
identifier F = { noopMutexAlloc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_noopMutexAlloc@
identifier F = { noopMutexAlloc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: noopMutexEnd - change static to extern
@static_to_extern_def_brace_same_line_noopMutexEnd@
identifier F = { noopMutexEnd };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_noopMutexEnd@
identifier F = { noopMutexEnd };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_noopMutexEnd@
identifier F = { noopMutexEnd };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_noopMutexEnd@
identifier F = { noopMutexEnd };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_noopMutexEnd@
identifier F = { noopMutexEnd };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: noopMutexEnter - change static to extern
@static_to_extern_def_brace_same_line_noopMutexEnter@
identifier F = { noopMutexEnter };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_noopMutexEnter@
identifier F = { noopMutexEnter };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_noopMutexEnter@
identifier F = { noopMutexEnter };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_noopMutexEnter@
identifier F = { noopMutexEnter };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_noopMutexEnter@
identifier F = { noopMutexEnter };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: noopMutexFree - change static to extern
@static_to_extern_def_brace_same_line_noopMutexFree@
identifier F = { noopMutexFree };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_noopMutexFree@
identifier F = { noopMutexFree };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_noopMutexFree@
identifier F = { noopMutexFree };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_noopMutexFree@
identifier F = { noopMutexFree };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_noopMutexFree@
identifier F = { noopMutexFree };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: noopMutexInit - change static to extern
@static_to_extern_def_brace_same_line_noopMutexInit@
identifier F = { noopMutexInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_noopMutexInit@
identifier F = { noopMutexInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_noopMutexInit@
identifier F = { noopMutexInit };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_noopMutexInit@
identifier F = { noopMutexInit };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_noopMutexInit@
identifier F = { noopMutexInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: noopMutexLeave - change static to extern
@static_to_extern_def_brace_same_line_noopMutexLeave@
identifier F = { noopMutexLeave };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_noopMutexLeave@
identifier F = { noopMutexLeave };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_noopMutexLeave@
identifier F = { noopMutexLeave };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_noopMutexLeave@
identifier F = { noopMutexLeave };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_noopMutexLeave@
identifier F = { noopMutexLeave };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: noopMutexTry - change static to extern
@static_to_extern_def_brace_same_line_noopMutexTry@
identifier F = { noopMutexTry };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_noopMutexTry@
identifier F = { noopMutexTry };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_noopMutexTry@
identifier F = { noopMutexTry };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_noopMutexTry@
identifier F = { noopMutexTry };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_noopMutexTry@
identifier F = { noopMutexTry };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: noopValueFunc - change static to extern
@static_to_extern_def_brace_same_line_noopValueFunc@
identifier F = { noopValueFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_noopValueFunc@
identifier F = { noopValueFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_noopValueFunc@
identifier F = { noopValueFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_noopValueFunc@
identifier F = { noopValueFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_noopValueFunc@
identifier F = { noopValueFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: nullifFunc - change static to extern
@static_to_extern_def_brace_same_line_nullifFunc@
identifier F = { nullifFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_nullifFunc@
identifier F = { nullifFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_nullifFunc@
identifier F = { nullifFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_nullifFunc@
identifier F = { nullifFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_nullifFunc@
identifier F = { nullifFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: openDirectory - change static to extern
@static_to_extern_def_brace_same_line_openDirectory@
identifier F = { openDirectory };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_openDirectory@
identifier F = { openDirectory };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_openDirectory@
identifier F = { openDirectory };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_openDirectory@
identifier F = { openDirectory };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_openDirectory@
identifier F = { openDirectory };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: pageReinit - change static to extern
@static_to_extern_def_brace_same_line_pageReinit@
identifier F = { pageReinit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_pageReinit@
identifier F = { pageReinit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_pageReinit@
identifier F = { pageReinit };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_pageReinit@
identifier F = { pageReinit };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_pageReinit@
identifier F = { pageReinit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: pcache1Cachesize - change static to extern
@static_to_extern_def_brace_same_line_pcache1Cachesize@
identifier F = { pcache1Cachesize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_pcache1Cachesize@
identifier F = { pcache1Cachesize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_pcache1Cachesize@
identifier F = { pcache1Cachesize };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_pcache1Cachesize@
identifier F = { pcache1Cachesize };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_pcache1Cachesize@
identifier F = { pcache1Cachesize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: pcache1Create - change static to extern
@static_to_extern_def_brace_same_line_pcache1Create@
identifier F = { pcache1Create };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_pcache1Create@
identifier F = { pcache1Create };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_pcache1Create@
identifier F = { pcache1Create };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_pcache1Create@
identifier F = { pcache1Create };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_pcache1Create@
identifier F = { pcache1Create };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: pcache1Destroy - change static to extern
@static_to_extern_def_brace_same_line_pcache1Destroy@
identifier F = { pcache1Destroy };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_pcache1Destroy@
identifier F = { pcache1Destroy };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_pcache1Destroy@
identifier F = { pcache1Destroy };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_pcache1Destroy@
identifier F = { pcache1Destroy };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_pcache1Destroy@
identifier F = { pcache1Destroy };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: pcache1Fetch - change static to extern
@static_to_extern_def_brace_same_line_pcache1Fetch@
identifier F = { pcache1Fetch };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_pcache1Fetch@
identifier F = { pcache1Fetch };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_pcache1Fetch@
identifier F = { pcache1Fetch };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_pcache1Fetch@
identifier F = { pcache1Fetch };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_pcache1Fetch@
identifier F = { pcache1Fetch };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: pcache1Init - change static to extern
@static_to_extern_def_brace_same_line_pcache1Init@
identifier F = { pcache1Init };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_pcache1Init@
identifier F = { pcache1Init };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_pcache1Init@
identifier F = { pcache1Init };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_pcache1Init@
identifier F = { pcache1Init };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_pcache1Init@
identifier F = { pcache1Init };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: pcache1Pagecount - change static to extern
@static_to_extern_def_brace_same_line_pcache1Pagecount@
identifier F = { pcache1Pagecount };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_pcache1Pagecount@
identifier F = { pcache1Pagecount };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_pcache1Pagecount@
identifier F = { pcache1Pagecount };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_pcache1Pagecount@
identifier F = { pcache1Pagecount };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_pcache1Pagecount@
identifier F = { pcache1Pagecount };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: pcache1Rekey - change static to extern
@static_to_extern_def_brace_same_line_pcache1Rekey@
identifier F = { pcache1Rekey };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_pcache1Rekey@
identifier F = { pcache1Rekey };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_pcache1Rekey@
identifier F = { pcache1Rekey };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_pcache1Rekey@
identifier F = { pcache1Rekey };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_pcache1Rekey@
identifier F = { pcache1Rekey };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: pcache1Shrink - change static to extern
@static_to_extern_def_brace_same_line_pcache1Shrink@
identifier F = { pcache1Shrink };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_pcache1Shrink@
identifier F = { pcache1Shrink };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_pcache1Shrink@
identifier F = { pcache1Shrink };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_pcache1Shrink@
identifier F = { pcache1Shrink };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_pcache1Shrink@
identifier F = { pcache1Shrink };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: pcache1Shutdown - change static to extern
@static_to_extern_def_brace_same_line_pcache1Shutdown@
identifier F = { pcache1Shutdown };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_pcache1Shutdown@
identifier F = { pcache1Shutdown };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_pcache1Shutdown@
identifier F = { pcache1Shutdown };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_pcache1Shutdown@
identifier F = { pcache1Shutdown };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_pcache1Shutdown@
identifier F = { pcache1Shutdown };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: pcache1Truncate - change static to extern
@static_to_extern_def_brace_same_line_pcache1Truncate@
identifier F = { pcache1Truncate };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_pcache1Truncate@
identifier F = { pcache1Truncate };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_pcache1Truncate@
identifier F = { pcache1Truncate };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_pcache1Truncate@
identifier F = { pcache1Truncate };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_pcache1Truncate@
identifier F = { pcache1Truncate };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: pcache1Unpin - change static to extern
@static_to_extern_def_brace_same_line_pcache1Unpin@
identifier F = { pcache1Unpin };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_pcache1Unpin@
identifier F = { pcache1Unpin };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_pcache1Unpin@
identifier F = { pcache1Unpin };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_pcache1Unpin@
identifier F = { pcache1Unpin };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_pcache1Unpin@
identifier F = { pcache1Unpin };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: posixIoFinderImpl - change static to extern
@static_to_extern_def_brace_same_line_posixIoFinderImpl@
identifier F = { posixIoFinderImpl };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_posixIoFinderImpl@
identifier F = { posixIoFinderImpl };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_posixIoFinderImpl@
identifier F = { posixIoFinderImpl };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_posixIoFinderImpl@
identifier F = { posixIoFinderImpl };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_posixIoFinderImpl@
identifier F = { posixIoFinderImpl };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: posixOpen - change static to extern
@static_to_extern_def_brace_same_line_posixOpen@
identifier F = { posixOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_posixOpen@
identifier F = { posixOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_posixOpen@
identifier F = { posixOpen };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_posixOpen@
identifier F = { posixOpen };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_posixOpen@
identifier F = { posixOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: printfFunc - change static to extern
@static_to_extern_def_brace_same_line_printfFunc@
identifier F = { printfFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_printfFunc@
identifier F = { printfFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_printfFunc@
identifier F = { printfFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_printfFunc@
identifier F = { printfFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_printfFunc@
identifier F = { printfFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: propagateConstantExprRewrite - change static to extern
@static_to_extern_def_brace_same_line_propagateConstantExprRewrite@
identifier F = { propagateConstantExprRewrite };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_propagateConstantExprRewrite@
identifier F = { propagateConstantExprRewrite };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_propagateConstantExprRewrite@
identifier F = { propagateConstantExprRewrite };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_propagateConstantExprRewrite@
identifier F = { propagateConstantExprRewrite };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_propagateConstantExprRewrite@
identifier F = { propagateConstantExprRewrite };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: pthreadMutexAlloc - change static to extern
@static_to_extern_def_brace_same_line_pthreadMutexAlloc@
identifier F = { pthreadMutexAlloc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_pthreadMutexAlloc@
identifier F = { pthreadMutexAlloc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_pthreadMutexAlloc@
identifier F = { pthreadMutexAlloc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_pthreadMutexAlloc@
identifier F = { pthreadMutexAlloc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_pthreadMutexAlloc@
identifier F = { pthreadMutexAlloc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: pthreadMutexEnter - change static to extern
@static_to_extern_def_brace_same_line_pthreadMutexEnter@
identifier F = { pthreadMutexEnter };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_pthreadMutexEnter@
identifier F = { pthreadMutexEnter };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_pthreadMutexEnter@
identifier F = { pthreadMutexEnter };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_pthreadMutexEnter@
identifier F = { pthreadMutexEnter };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_pthreadMutexEnter@
identifier F = { pthreadMutexEnter };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: pthreadMutexFree - change static to extern
@static_to_extern_def_brace_same_line_pthreadMutexFree@
identifier F = { pthreadMutexFree };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_pthreadMutexFree@
identifier F = { pthreadMutexFree };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_pthreadMutexFree@
identifier F = { pthreadMutexFree };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_pthreadMutexFree@
identifier F = { pthreadMutexFree };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_pthreadMutexFree@
identifier F = { pthreadMutexFree };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: pthreadMutexInit - change static to extern
@static_to_extern_def_brace_same_line_pthreadMutexInit@
identifier F = { pthreadMutexInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_pthreadMutexInit@
identifier F = { pthreadMutexInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_pthreadMutexInit@
identifier F = { pthreadMutexInit };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_pthreadMutexInit@
identifier F = { pthreadMutexInit };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_pthreadMutexInit@
identifier F = { pthreadMutexInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: pthreadMutexLeave - change static to extern
@static_to_extern_def_brace_same_line_pthreadMutexLeave@
identifier F = { pthreadMutexLeave };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_pthreadMutexLeave@
identifier F = { pthreadMutexLeave };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_pthreadMutexLeave@
identifier F = { pthreadMutexLeave };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_pthreadMutexLeave@
identifier F = { pthreadMutexLeave };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_pthreadMutexLeave@
identifier F = { pthreadMutexLeave };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: quoteFunc - change static to extern
@static_to_extern_def_brace_same_line_quoteFunc@
identifier F = { quoteFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_quoteFunc@
identifier F = { quoteFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_quoteFunc@
identifier F = { quoteFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_quoteFunc@
identifier F = { quoteFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_quoteFunc@
identifier F = { quoteFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: randomBlob - change static to extern
@static_to_extern_def_brace_same_line_randomBlob@
identifier F = { randomBlob };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_randomBlob@
identifier F = { randomBlob };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_randomBlob@
identifier F = { randomBlob };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_randomBlob@
identifier F = { randomBlob };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_randomBlob@
identifier F = { randomBlob };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: rankStepFunc - change static to extern
@static_to_extern_def_brace_same_line_rankStepFunc@
identifier F = { rankStepFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_rankStepFunc@
identifier F = { rankStepFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_rankStepFunc@
identifier F = { rankStepFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_rankStepFunc@
identifier F = { rankStepFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_rankStepFunc@
identifier F = { rankStepFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: rankValueFunc - change static to extern
@static_to_extern_def_brace_same_line_rankValueFunc@
identifier F = { rankValueFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_rankValueFunc@
identifier F = { rankValueFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_rankValueFunc@
identifier F = { rankValueFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_rankValueFunc@
identifier F = { rankValueFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_rankValueFunc@
identifier F = { rankValueFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: replaceFunc - change static to extern
@static_to_extern_def_brace_same_line_replaceFunc@
identifier F = { replaceFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_replaceFunc@
identifier F = { replaceFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_replaceFunc@
identifier F = { replaceFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_replaceFunc@
identifier F = { replaceFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_replaceFunc@
identifier F = { replaceFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: resolveExprStep - change static to extern
@static_to_extern_def_brace_same_line_resolveExprStep@
identifier F = { resolveExprStep };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_resolveExprStep@
identifier F = { resolveExprStep };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_resolveExprStep@
identifier F = { resolveExprStep };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_resolveExprStep@
identifier F = { resolveExprStep };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_resolveExprStep@
identifier F = { resolveExprStep };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: resolveRemoveWindowsCb - change static to extern
@static_to_extern_def_brace_same_line_resolveRemoveWindowsCb@
identifier F = { resolveRemoveWindowsCb };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_resolveRemoveWindowsCb@
identifier F = { resolveRemoveWindowsCb };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_resolveRemoveWindowsCb@
identifier F = { resolveRemoveWindowsCb };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_resolveRemoveWindowsCb@
identifier F = { resolveRemoveWindowsCb };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_resolveRemoveWindowsCb@
identifier F = { resolveRemoveWindowsCb };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: resolveSelectStep - change static to extern
@static_to_extern_def_brace_same_line_resolveSelectStep@
identifier F = { resolveSelectStep };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_resolveSelectStep@
identifier F = { resolveSelectStep };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_resolveSelectStep@
identifier F = { resolveSelectStep };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_resolveSelectStep@
identifier F = { resolveSelectStep };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_resolveSelectStep@
identifier F = { resolveSelectStep };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: roundFunc - change static to extern
@static_to_extern_def_brace_same_line_roundFunc@
identifier F = { roundFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_roundFunc@
identifier F = { roundFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_roundFunc@
identifier F = { roundFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_roundFunc@
identifier F = { roundFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_roundFunc@
identifier F = { roundFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: row_numberStepFunc - change static to extern
@static_to_extern_def_brace_same_line_row_numberStepFunc@
identifier F = { row_numberStepFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_row_numberStepFunc@
identifier F = { row_numberStepFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_row_numberStepFunc@
identifier F = { row_numberStepFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_row_numberStepFunc@
identifier F = { row_numberStepFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_row_numberStepFunc@
identifier F = { row_numberStepFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: row_numberValueFunc - change static to extern
@static_to_extern_def_brace_same_line_row_numberValueFunc@
identifier F = { row_numberValueFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_row_numberValueFunc@
identifier F = { row_numberValueFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_row_numberValueFunc@
identifier F = { row_numberValueFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_row_numberValueFunc@
identifier F = { row_numberValueFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_row_numberValueFunc@
identifier F = { row_numberValueFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: selectAddSubqueryTypeInfo - change static to extern
@static_to_extern_def_brace_same_line_selectAddSubqueryTypeInfo@
identifier F = { selectAddSubqueryTypeInfo };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_selectAddSubqueryTypeInfo@
identifier F = { selectAddSubqueryTypeInfo };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_selectAddSubqueryTypeInfo@
identifier F = { selectAddSubqueryTypeInfo };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_selectAddSubqueryTypeInfo@
identifier F = { selectAddSubqueryTypeInfo };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_selectAddSubqueryTypeInfo@
identifier F = { selectAddSubqueryTypeInfo };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: selectCheckOnClausesExpr - change static to extern
@static_to_extern_def_brace_same_line_selectCheckOnClausesExpr@
identifier F = { selectCheckOnClausesExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_selectCheckOnClausesExpr@
identifier F = { selectCheckOnClausesExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_selectCheckOnClausesExpr@
identifier F = { selectCheckOnClausesExpr };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_selectCheckOnClausesExpr@
identifier F = { selectCheckOnClausesExpr };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_selectCheckOnClausesExpr@
identifier F = { selectCheckOnClausesExpr };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: selectExpander - change static to extern
@static_to_extern_def_brace_same_line_selectExpander@
identifier F = { selectExpander };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_selectExpander@
identifier F = { selectExpander };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_selectExpander@
identifier F = { selectExpander };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_selectExpander@
identifier F = { selectExpander };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_selectExpander@
identifier F = { selectExpander };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: selectWindowRewriteExprCb - change static to extern
@static_to_extern_def_brace_same_line_selectWindowRewriteExprCb@
identifier F = { selectWindowRewriteExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_selectWindowRewriteExprCb@
identifier F = { selectWindowRewriteExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_selectWindowRewriteExprCb@
identifier F = { selectWindowRewriteExprCb };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_selectWindowRewriteExprCb@
identifier F = { selectWindowRewriteExprCb };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_selectWindowRewriteExprCb@
identifier F = { selectWindowRewriteExprCb };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: shellLog - change static to extern
@static_to_extern_def_brace_same_line_shellLog@
identifier F = { shellLog };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_shellLog@
identifier F = { shellLog };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_shellLog@
identifier F = { shellLog };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_shellLog@
identifier F = { shellLog };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_shellLog@
identifier F = { shellLog };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: signFunc - change static to extern
@static_to_extern_def_brace_same_line_signFunc@
identifier F = { signFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_signFunc@
identifier F = { signFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_signFunc@
identifier F = { signFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_signFunc@
identifier F = { signFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_signFunc@
identifier F = { signFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sourceidFunc - change static to extern
@static_to_extern_def_brace_same_line_sourceidFunc@
identifier F = { sourceidFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sourceidFunc@
identifier F = { sourceidFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sourceidFunc@
identifier F = { sourceidFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sourceidFunc@
identifier F = { sourceidFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sourceidFunc@
identifier F = { sourceidFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3DbFree - change static to extern
@static_to_extern_def_brace_same_line_sqlite3DbFree@
identifier F = { sqlite3DbFree };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3DbFree@
identifier F = { sqlite3DbFree };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3DbFree@
identifier F = { sqlite3DbFree };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3DbFree@
identifier F = { sqlite3DbFree };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3DbFree@
identifier F = { sqlite3DbFree };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3DbpageRegister - change static to extern
@static_to_extern_def_brace_same_line_sqlite3DbpageRegister@
identifier F = { sqlite3DbpageRegister };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3DbpageRegister@
identifier F = { sqlite3DbpageRegister };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3DbpageRegister@
identifier F = { sqlite3DbpageRegister };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3DbpageRegister@
identifier F = { sqlite3DbpageRegister };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3DbpageRegister@
identifier F = { sqlite3DbpageRegister };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3DbstatRegister - change static to extern
@static_to_extern_def_brace_same_line_sqlite3DbstatRegister@
identifier F = { sqlite3DbstatRegister };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3DbstatRegister@
identifier F = { sqlite3DbstatRegister };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3DbstatRegister@
identifier F = { sqlite3DbstatRegister };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3DbstatRegister@
identifier F = { sqlite3DbstatRegister };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3DbstatRegister@
identifier F = { sqlite3DbstatRegister };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3ExprDeleteGeneric - change static to extern
@static_to_extern_def_brace_same_line_sqlite3ExprDeleteGeneric@
identifier F = { sqlite3ExprDeleteGeneric };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3ExprDeleteGeneric@
identifier F = { sqlite3ExprDeleteGeneric };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3ExprDeleteGeneric@
identifier F = { sqlite3ExprDeleteGeneric };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3ExprDeleteGeneric@
identifier F = { sqlite3ExprDeleteGeneric };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3ExprDeleteGeneric@
identifier F = { sqlite3ExprDeleteGeneric };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3ExprWalkNoop - change static to extern
@static_to_extern_def_brace_same_line_sqlite3ExprWalkNoop@
identifier F = { sqlite3ExprWalkNoop };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3ExprWalkNoop@
identifier F = { sqlite3ExprWalkNoop };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3ExprWalkNoop@
identifier F = { sqlite3ExprWalkNoop };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3ExprWalkNoop@
identifier F = { sqlite3ExprWalkNoop };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3ExprWalkNoop@
identifier F = { sqlite3ExprWalkNoop };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3Fts3Init - change static to extern
@static_to_extern_def_brace_same_line_sqlite3Fts3Init@
identifier F = { sqlite3Fts3Init };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3Fts3Init@
identifier F = { sqlite3Fts3Init };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3Fts3Init@
identifier F = { sqlite3Fts3Init };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3Fts3Init@
identifier F = { sqlite3Fts3Init };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3Fts3Init@
identifier F = { sqlite3Fts3Init };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3InitCallback - change static to extern
@static_to_extern_def_brace_same_line_sqlite3InitCallback@
identifier F = { sqlite3InitCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3InitCallback@
identifier F = { sqlite3InitCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3InitCallback@
identifier F = { sqlite3InitCallback };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3InitCallback@
identifier F = { sqlite3InitCallback };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3InitCallback@
identifier F = { sqlite3InitCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3JsonTableFunctions - change static to extern
@static_to_extern_def_brace_same_line_sqlite3JsonTableFunctions@
identifier F = { sqlite3JsonTableFunctions };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3JsonTableFunctions@
identifier F = { sqlite3JsonTableFunctions };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3JsonTableFunctions@
identifier F = { sqlite3JsonTableFunctions };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3JsonTableFunctions@
identifier F = { sqlite3JsonTableFunctions };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3JsonTableFunctions@
identifier F = { sqlite3JsonTableFunctions };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3MemFree - change static to extern
@static_to_extern_def_brace_same_line_sqlite3MemFree@
identifier F = { sqlite3MemFree };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3MemFree@
identifier F = { sqlite3MemFree };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3MemFree@
identifier F = { sqlite3MemFree };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3MemFree@
identifier F = { sqlite3MemFree };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3MemFree@
identifier F = { sqlite3MemFree };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3MemInit - change static to extern
@static_to_extern_def_brace_same_line_sqlite3MemInit@
identifier F = { sqlite3MemInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3MemInit@
identifier F = { sqlite3MemInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3MemInit@
identifier F = { sqlite3MemInit };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3MemInit@
identifier F = { sqlite3MemInit };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3MemInit@
identifier F = { sqlite3MemInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3MemMalloc - change static to extern
@static_to_extern_def_brace_same_line_sqlite3MemMalloc@
identifier F = { sqlite3MemMalloc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3MemMalloc@
identifier F = { sqlite3MemMalloc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3MemMalloc@
identifier F = { sqlite3MemMalloc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3MemMalloc@
identifier F = { sqlite3MemMalloc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3MemMalloc@
identifier F = { sqlite3MemMalloc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3MemRealloc - change static to extern
@static_to_extern_def_brace_same_line_sqlite3MemRealloc@
identifier F = { sqlite3MemRealloc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3MemRealloc@
identifier F = { sqlite3MemRealloc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3MemRealloc@
identifier F = { sqlite3MemRealloc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3MemRealloc@
identifier F = { sqlite3MemRealloc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3MemRealloc@
identifier F = { sqlite3MemRealloc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3MemRoundup - change static to extern
@static_to_extern_def_brace_same_line_sqlite3MemRoundup@
identifier F = { sqlite3MemRoundup };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3MemRoundup@
identifier F = { sqlite3MemRoundup };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3MemRoundup@
identifier F = { sqlite3MemRoundup };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3MemRoundup@
identifier F = { sqlite3MemRoundup };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3MemRoundup@
identifier F = { sqlite3MemRoundup };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3MemShutdown - change static to extern
@static_to_extern_def_brace_same_line_sqlite3MemShutdown@
identifier F = { sqlite3MemShutdown };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3MemShutdown@
identifier F = { sqlite3MemShutdown };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3MemShutdown@
identifier F = { sqlite3MemShutdown };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3MemShutdown@
identifier F = { sqlite3MemShutdown };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3MemShutdown@
identifier F = { sqlite3MemShutdown };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3MemSize - change static to extern
@static_to_extern_def_brace_same_line_sqlite3MemSize@
identifier F = { sqlite3MemSize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3MemSize@
identifier F = { sqlite3MemSize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3MemSize@
identifier F = { sqlite3MemSize };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3MemSize@
identifier F = { sqlite3MemSize };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3MemSize@
identifier F = { sqlite3MemSize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3RtreeInit - change static to extern
@static_to_extern_def_brace_same_line_sqlite3RtreeInit@
identifier F = { sqlite3RtreeInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3RtreeInit@
identifier F = { sqlite3RtreeInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3RtreeInit@
identifier F = { sqlite3RtreeInit };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3RtreeInit@
identifier F = { sqlite3RtreeInit };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3RtreeInit@
identifier F = { sqlite3RtreeInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3SchemaClear - change static to extern
@static_to_extern_def_brace_same_line_sqlite3SchemaClear@
identifier F = { sqlite3SchemaClear };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3SchemaClear@
identifier F = { sqlite3SchemaClear };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3SchemaClear@
identifier F = { sqlite3SchemaClear };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3SchemaClear@
identifier F = { sqlite3SchemaClear };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3SchemaClear@
identifier F = { sqlite3SchemaClear };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3SelectPopWith - change static to extern
@static_to_extern_def_brace_same_line_sqlite3SelectPopWith@
identifier F = { sqlite3SelectPopWith };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3SelectPopWith@
identifier F = { sqlite3SelectPopWith };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3SelectPopWith@
identifier F = { sqlite3SelectPopWith };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3SelectPopWith@
identifier F = { sqlite3SelectPopWith };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3SelectPopWith@
identifier F = { sqlite3SelectPopWith };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3SelectWalkNoop - change static to extern
@static_to_extern_def_brace_same_line_sqlite3SelectWalkNoop@
identifier F = { sqlite3SelectWalkNoop };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3SelectWalkNoop@
identifier F = { sqlite3SelectWalkNoop };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3SelectWalkNoop@
identifier F = { sqlite3SelectWalkNoop };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3SelectWalkNoop@
identifier F = { sqlite3SelectWalkNoop };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3SelectWalkNoop@
identifier F = { sqlite3SelectWalkNoop };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3StmtVtabInit - change static to extern
@static_to_extern_def_brace_same_line_sqlite3StmtVtabInit@
identifier F = { sqlite3StmtVtabInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3StmtVtabInit@
identifier F = { sqlite3StmtVtabInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3StmtVtabInit@
identifier F = { sqlite3StmtVtabInit };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3StmtVtabInit@
identifier F = { sqlite3StmtVtabInit };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3StmtVtabInit@
identifier F = { sqlite3StmtVtabInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3TestExtInit - change static to extern
@static_to_extern_def_brace_same_line_sqlite3TestExtInit@
identifier F = { sqlite3TestExtInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3TestExtInit@
identifier F = { sqlite3TestExtInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3TestExtInit@
identifier F = { sqlite3TestExtInit };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3TestExtInit@
identifier F = { sqlite3TestExtInit };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3TestExtInit@
identifier F = { sqlite3TestExtInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3VdbeBytecodeVtabInit - change static to extern
@static_to_extern_def_brace_same_line_sqlite3VdbeBytecodeVtabInit@
identifier F = { sqlite3VdbeBytecodeVtabInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3VdbeBytecodeVtabInit@
identifier F = { sqlite3VdbeBytecodeVtabInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3VdbeBytecodeVtabInit@
identifier F = { sqlite3VdbeBytecodeVtabInit };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3VdbeBytecodeVtabInit@
identifier F = { sqlite3VdbeBytecodeVtabInit };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3VdbeBytecodeVtabInit@
identifier F = { sqlite3VdbeBytecodeVtabInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3WalkWinDefnDummyCallback - change static to extern
@static_to_extern_def_brace_same_line_sqlite3WalkWinDefnDummyCallback@
identifier F = { sqlite3WalkWinDefnDummyCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3WalkWinDefnDummyCallback@
identifier F = { sqlite3WalkWinDefnDummyCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3WalkWinDefnDummyCallback@
identifier F = { sqlite3WalkWinDefnDummyCallback };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3WalkWinDefnDummyCallback@
identifier F = { sqlite3WalkWinDefnDummyCallback };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3WalkWinDefnDummyCallback@
identifier F = { sqlite3WalkWinDefnDummyCallback };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3WalkerDepthDecrease - change static to extern
@static_to_extern_def_brace_same_line_sqlite3WalkerDepthDecrease@
identifier F = { sqlite3WalkerDepthDecrease };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3WalkerDepthDecrease@
identifier F = { sqlite3WalkerDepthDecrease };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3WalkerDepthDecrease@
identifier F = { sqlite3WalkerDepthDecrease };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3WalkerDepthDecrease@
identifier F = { sqlite3WalkerDepthDecrease };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3WalkerDepthDecrease@
identifier F = { sqlite3WalkerDepthDecrease };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3WalkerDepthIncrease - change static to extern
@static_to_extern_def_brace_same_line_sqlite3WalkerDepthIncrease@
identifier F = { sqlite3WalkerDepthIncrease };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3WalkerDepthIncrease@
identifier F = { sqlite3WalkerDepthIncrease };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3WalkerDepthIncrease@
identifier F = { sqlite3WalkerDepthIncrease };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3WalkerDepthIncrease@
identifier F = { sqlite3WalkerDepthIncrease };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3WalkerDepthIncrease@
identifier F = { sqlite3WalkerDepthIncrease };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3WindowExtraAggFuncDepth - change static to extern
@static_to_extern_def_brace_same_line_sqlite3WindowExtraAggFuncDepth@
identifier F = { sqlite3WindowExtraAggFuncDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3WindowExtraAggFuncDepth@
identifier F = { sqlite3WindowExtraAggFuncDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3WindowExtraAggFuncDepth@
identifier F = { sqlite3WindowExtraAggFuncDepth };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3WindowExtraAggFuncDepth@
identifier F = { sqlite3WindowExtraAggFuncDepth };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3WindowExtraAggFuncDepth@
identifier F = { sqlite3WindowExtraAggFuncDepth };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sqlite3_free - change static to extern
@static_to_extern_def_brace_same_line_sqlite3_free@
identifier F = { sqlite3_free };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sqlite3_free@
identifier F = { sqlite3_free };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sqlite3_free@
identifier F = { sqlite3_free };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sqlite3_free@
identifier F = { sqlite3_free };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sqlite3_free@
identifier F = { sqlite3_free };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: statAccumDestructor - change static to extern
@static_to_extern_def_brace_same_line_statAccumDestructor@
identifier F = { statAccumDestructor };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_statAccumDestructor@
identifier F = { statAccumDestructor };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_statAccumDestructor@
identifier F = { statAccumDestructor };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_statAccumDestructor@
identifier F = { statAccumDestructor };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_statAccumDestructor@
identifier F = { statAccumDestructor };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: statGet - change static to extern
@static_to_extern_def_brace_same_line_statGet@
identifier F = { statGet };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_statGet@
identifier F = { statGet };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_statGet@
identifier F = { statGet };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_statGet@
identifier F = { statGet };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_statGet@
identifier F = { statGet };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: statInit - change static to extern
@static_to_extern_def_brace_same_line_statInit@
identifier F = { statInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_statInit@
identifier F = { statInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_statInit@
identifier F = { statInit };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_statInit@
identifier F = { statInit };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_statInit@
identifier F = { statInit };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: statPush - change static to extern
@static_to_extern_def_brace_same_line_statPush@
identifier F = { statPush };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_statPush@
identifier F = { statPush };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_statPush@
identifier F = { statPush };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_statPush@
identifier F = { statPush };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_statPush@
identifier F = { statPush };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: strftimeFunc - change static to extern
@static_to_extern_def_brace_same_line_strftimeFunc@
identifier F = { strftimeFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_strftimeFunc@
identifier F = { strftimeFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_strftimeFunc@
identifier F = { strftimeFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_strftimeFunc@
identifier F = { strftimeFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_strftimeFunc@
identifier F = { strftimeFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: substrFunc - change static to extern
@static_to_extern_def_brace_same_line_substrFunc@
identifier F = { substrFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_substrFunc@
identifier F = { substrFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_substrFunc@
identifier F = { substrFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_substrFunc@
identifier F = { substrFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_substrFunc@
identifier F = { substrFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sumFinalize - change static to extern
@static_to_extern_def_brace_same_line_sumFinalize@
identifier F = { sumFinalize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sumFinalize@
identifier F = { sumFinalize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sumFinalize@
identifier F = { sumFinalize };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sumFinalize@
identifier F = { sumFinalize };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sumFinalize@
identifier F = { sumFinalize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: sumStep - change static to extern
@static_to_extern_def_brace_same_line_sumStep@
identifier F = { sumStep };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_sumStep@
identifier F = { sumStep };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_sumStep@
identifier F = { sumStep };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_sumStep@
identifier F = { sumStep };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_sumStep@
identifier F = { sumStep };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: timeFunc - change static to extern
@static_to_extern_def_brace_same_line_timeFunc@
identifier F = { timeFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_timeFunc@
identifier F = { timeFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_timeFunc@
identifier F = { timeFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_timeFunc@
identifier F = { timeFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_timeFunc@
identifier F = { timeFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: totalFinalize - change static to extern
@static_to_extern_def_brace_same_line_totalFinalize@
identifier F = { totalFinalize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_totalFinalize@
identifier F = { totalFinalize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_totalFinalize@
identifier F = { totalFinalize };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_totalFinalize@
identifier F = { totalFinalize };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_totalFinalize@
identifier F = { totalFinalize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: total_changes - change static to extern
@static_to_extern_def_brace_same_line_total_changes@
identifier F = { total_changes };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_total_changes@
identifier F = { total_changes };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_total_changes@
identifier F = { total_changes };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_total_changes@
identifier F = { total_changes };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_total_changes@
identifier F = { total_changes };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: trimFunc - change static to extern
@static_to_extern_def_brace_same_line_trimFunc@
identifier F = { trimFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_trimFunc@
identifier F = { trimFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_trimFunc@
identifier F = { trimFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_trimFunc@
identifier F = { trimFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_trimFunc@
identifier F = { trimFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: typeofFunc - change static to extern
@static_to_extern_def_brace_same_line_typeofFunc@
identifier F = { typeofFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_typeofFunc@
identifier F = { typeofFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_typeofFunc@
identifier F = { typeofFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_typeofFunc@
identifier F = { typeofFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_typeofFunc@
identifier F = { typeofFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unhexFunc - change static to extern
@static_to_extern_def_brace_same_line_unhexFunc@
identifier F = { unhexFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unhexFunc@
identifier F = { unhexFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unhexFunc@
identifier F = { unhexFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unhexFunc@
identifier F = { unhexFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unhexFunc@
identifier F = { unhexFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unicodeFunc - change static to extern
@static_to_extern_def_brace_same_line_unicodeFunc@
identifier F = { unicodeFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unicodeFunc@
identifier F = { unicodeFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unicodeFunc@
identifier F = { unicodeFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unicodeFunc@
identifier F = { unicodeFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unicodeFunc@
identifier F = { unicodeFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixAccess - change static to extern
@static_to_extern_def_brace_same_line_unixAccess@
identifier F = { unixAccess };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixAccess@
identifier F = { unixAccess };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixAccess@
identifier F = { unixAccess };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixAccess@
identifier F = { unixAccess };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixAccess@
identifier F = { unixAccess };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixClose - change static to extern
@static_to_extern_def_brace_same_line_unixClose@
identifier F = { unixClose };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixClose@
identifier F = { unixClose };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixClose@
identifier F = { unixClose };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixClose@
identifier F = { unixClose };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixClose@
identifier F = { unixClose };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixCurrentTime - change static to extern
@static_to_extern_def_brace_same_line_unixCurrentTime@
identifier F = { unixCurrentTime };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixCurrentTime@
identifier F = { unixCurrentTime };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixCurrentTime@
identifier F = { unixCurrentTime };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixCurrentTime@
identifier F = { unixCurrentTime };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixCurrentTime@
identifier F = { unixCurrentTime };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixCurrentTimeInt64 - change static to extern
@static_to_extern_def_brace_same_line_unixCurrentTimeInt64@
identifier F = { unixCurrentTimeInt64 };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixCurrentTimeInt64@
identifier F = { unixCurrentTimeInt64 };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixCurrentTimeInt64@
identifier F = { unixCurrentTimeInt64 };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixCurrentTimeInt64@
identifier F = { unixCurrentTimeInt64 };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixCurrentTimeInt64@
identifier F = { unixCurrentTimeInt64 };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixDelete - change static to extern
@static_to_extern_def_brace_same_line_unixDelete@
identifier F = { unixDelete };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixDelete@
identifier F = { unixDelete };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixDelete@
identifier F = { unixDelete };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixDelete@
identifier F = { unixDelete };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixDelete@
identifier F = { unixDelete };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixDeviceCharacteristics - change static to extern
@static_to_extern_def_brace_same_line_unixDeviceCharacteristics@
identifier F = { unixDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixDeviceCharacteristics@
identifier F = { unixDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixDeviceCharacteristics@
identifier F = { unixDeviceCharacteristics };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixDeviceCharacteristics@
identifier F = { unixDeviceCharacteristics };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixDeviceCharacteristics@
identifier F = { unixDeviceCharacteristics };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixDlClose - change static to extern
@static_to_extern_def_brace_same_line_unixDlClose@
identifier F = { unixDlClose };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixDlClose@
identifier F = { unixDlClose };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixDlClose@
identifier F = { unixDlClose };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixDlClose@
identifier F = { unixDlClose };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixDlClose@
identifier F = { unixDlClose };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixDlError - change static to extern
@static_to_extern_def_brace_same_line_unixDlError@
identifier F = { unixDlError };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixDlError@
identifier F = { unixDlError };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixDlError@
identifier F = { unixDlError };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixDlError@
identifier F = { unixDlError };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixDlError@
identifier F = { unixDlError };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixDlOpen - change static to extern
@static_to_extern_def_brace_same_line_unixDlOpen@
identifier F = { unixDlOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixDlOpen@
identifier F = { unixDlOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixDlOpen@
identifier F = { unixDlOpen };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixDlOpen@
identifier F = { unixDlOpen };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixDlOpen@
identifier F = { unixDlOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixDlSym - change static to extern
@static_to_extern_def_brace_same_line_unixDlSym@
identifier F = { unixDlSym };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixDlSym@
identifier F = { unixDlSym };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixDlSym@
identifier F = { unixDlSym };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixDlSym@
identifier F = { unixDlSym };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixDlSym@
identifier F = { unixDlSym };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixFileControl - change static to extern
@static_to_extern_def_brace_same_line_unixFileControl@
identifier F = { unixFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixFileControl@
identifier F = { unixFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixFileControl@
identifier F = { unixFileControl };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixFileControl@
identifier F = { unixFileControl };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixFileControl@
identifier F = { unixFileControl };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixFileSize - change static to extern
@static_to_extern_def_brace_same_line_unixFileSize@
identifier F = { unixFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixFileSize@
identifier F = { unixFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixFileSize@
identifier F = { unixFileSize };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixFileSize@
identifier F = { unixFileSize };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixFileSize@
identifier F = { unixFileSize };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixFullPathname - change static to extern
@static_to_extern_def_brace_same_line_unixFullPathname@
identifier F = { unixFullPathname };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixFullPathname@
identifier F = { unixFullPathname };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixFullPathname@
identifier F = { unixFullPathname };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixFullPathname@
identifier F = { unixFullPathname };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixFullPathname@
identifier F = { unixFullPathname };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixGetLastError - change static to extern
@static_to_extern_def_brace_same_line_unixGetLastError@
identifier F = { unixGetLastError };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixGetLastError@
identifier F = { unixGetLastError };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixGetLastError@
identifier F = { unixGetLastError };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixGetLastError@
identifier F = { unixGetLastError };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixGetLastError@
identifier F = { unixGetLastError };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixGetSystemCall - change static to extern
@static_to_extern_def_brace_same_line_unixGetSystemCall@
identifier F = { unixGetSystemCall };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixGetSystemCall@
identifier F = { unixGetSystemCall };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixGetSystemCall@
identifier F = { unixGetSystemCall };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixGetSystemCall@
identifier F = { unixGetSystemCall };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixGetSystemCall@
identifier F = { unixGetSystemCall };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixLock - change static to extern
@static_to_extern_def_brace_same_line_unixLock@
identifier F = { unixLock };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixLock@
identifier F = { unixLock };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixLock@
identifier F = { unixLock };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixLock@
identifier F = { unixLock };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixLock@
identifier F = { unixLock };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixNextSystemCall - change static to extern
@static_to_extern_def_brace_same_line_unixNextSystemCall@
identifier F = { unixNextSystemCall };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixNextSystemCall@
identifier F = { unixNextSystemCall };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixNextSystemCall@
identifier F = { unixNextSystemCall };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixNextSystemCall@
identifier F = { unixNextSystemCall };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixNextSystemCall@
identifier F = { unixNextSystemCall };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixOpen - change static to extern
@static_to_extern_def_brace_same_line_unixOpen@
identifier F = { unixOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixOpen@
identifier F = { unixOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixOpen@
identifier F = { unixOpen };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixOpen@
identifier F = { unixOpen };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixOpen@
identifier F = { unixOpen };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixRandomness - change static to extern
@static_to_extern_def_brace_same_line_unixRandomness@
identifier F = { unixRandomness };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixRandomness@
identifier F = { unixRandomness };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixRandomness@
identifier F = { unixRandomness };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixRandomness@
identifier F = { unixRandomness };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixRandomness@
identifier F = { unixRandomness };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixRead - change static to extern
@static_to_extern_def_brace_same_line_unixRead@
identifier F = { unixRead };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixRead@
identifier F = { unixRead };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixRead@
identifier F = { unixRead };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixRead@
identifier F = { unixRead };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixRead@
identifier F = { unixRead };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixSetSystemCall - change static to extern
@static_to_extern_def_brace_same_line_unixSetSystemCall@
identifier F = { unixSetSystemCall };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixSetSystemCall@
identifier F = { unixSetSystemCall };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixSetSystemCall@
identifier F = { unixSetSystemCall };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixSetSystemCall@
identifier F = { unixSetSystemCall };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixSetSystemCall@
identifier F = { unixSetSystemCall };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixSleep - change static to extern
@static_to_extern_def_brace_same_line_unixSleep@
identifier F = { unixSleep };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixSleep@
identifier F = { unixSleep };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixSleep@
identifier F = { unixSleep };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixSleep@
identifier F = { unixSleep };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixSleep@
identifier F = { unixSleep };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixSync - change static to extern
@static_to_extern_def_brace_same_line_unixSync@
identifier F = { unixSync };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixSync@
identifier F = { unixSync };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixSync@
identifier F = { unixSync };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixSync@
identifier F = { unixSync };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixSync@
identifier F = { unixSync };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixUnlock - change static to extern
@static_to_extern_def_brace_same_line_unixUnlock@
identifier F = { unixUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixUnlock@
identifier F = { unixUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixUnlock@
identifier F = { unixUnlock };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixUnlock@
identifier F = { unixUnlock };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixUnlock@
identifier F = { unixUnlock };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixWrite - change static to extern
@static_to_extern_def_brace_same_line_unixWrite@
identifier F = { unixWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixWrite@
identifier F = { unixWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixWrite@
identifier F = { unixWrite };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixWrite@
identifier F = { unixWrite };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixWrite@
identifier F = { unixWrite };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: unixepochFunc - change static to extern
@static_to_extern_def_brace_same_line_unixepochFunc@
identifier F = { unixepochFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_unixepochFunc@
identifier F = { unixepochFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_unixepochFunc@
identifier F = { unixepochFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_unixepochFunc@
identifier F = { unixepochFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_unixepochFunc@
identifier F = { unixepochFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: upperFunc - change static to extern
@static_to_extern_def_brace_same_line_upperFunc@
identifier F = { upperFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_upperFunc@
identifier F = { upperFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_upperFunc@
identifier F = { upperFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_upperFunc@
identifier F = { upperFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_upperFunc@
identifier F = { upperFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: vdbeRecordCompareInt - change static to extern
@static_to_extern_def_brace_same_line_vdbeRecordCompareInt@
identifier F = { vdbeRecordCompareInt };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_vdbeRecordCompareInt@
identifier F = { vdbeRecordCompareInt };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_vdbeRecordCompareInt@
identifier F = { vdbeRecordCompareInt };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_vdbeRecordCompareInt@
identifier F = { vdbeRecordCompareInt };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_vdbeRecordCompareInt@
identifier F = { vdbeRecordCompareInt };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: vdbeRecordCompareString - change static to extern
@static_to_extern_def_brace_same_line_vdbeRecordCompareString@
identifier F = { vdbeRecordCompareString };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_vdbeRecordCompareString@
identifier F = { vdbeRecordCompareString };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_vdbeRecordCompareString@
identifier F = { vdbeRecordCompareString };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_vdbeRecordCompareString@
identifier F = { vdbeRecordCompareString };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_vdbeRecordCompareString@
identifier F = { vdbeRecordCompareString };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: vdbeSorterCompareInt - change static to extern
@static_to_extern_def_brace_same_line_vdbeSorterCompareInt@
identifier F = { vdbeSorterCompareInt };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_vdbeSorterCompareInt@
identifier F = { vdbeSorterCompareInt };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_vdbeSorterCompareInt@
identifier F = { vdbeSorterCompareInt };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_vdbeSorterCompareInt@
identifier F = { vdbeSorterCompareInt };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_vdbeSorterCompareInt@
identifier F = { vdbeSorterCompareInt };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: vdbeSorterCompareText - change static to extern
@static_to_extern_def_brace_same_line_vdbeSorterCompareText@
identifier F = { vdbeSorterCompareText };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_vdbeSorterCompareText@
identifier F = { vdbeSorterCompareText };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_vdbeSorterCompareText@
identifier F = { vdbeSorterCompareText };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_vdbeSorterCompareText@
identifier F = { vdbeSorterCompareText };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_vdbeSorterCompareText@
identifier F = { vdbeSorterCompareText };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: versionFunc - change static to extern
@static_to_extern_def_brace_same_line_versionFunc@
identifier F = { versionFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_versionFunc@
identifier F = { versionFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_versionFunc@
identifier F = { versionFunc };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_versionFunc@
identifier F = { versionFunc };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_versionFunc@
identifier F = { versionFunc };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: xCeil - change static to extern
@static_to_extern_def_brace_same_line_xCeil@
identifier F = { xCeil };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_xCeil@
identifier F = { xCeil };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_xCeil@
identifier F = { xCeil };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_xCeil@
identifier F = { xCeil };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_xCeil@
identifier F = { xCeil };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

// Rules for function: xFloor - change static to extern
@static_to_extern_def_brace_same_line_xFloor@
identifier F = { xFloor };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_def_brace_next_line_xFloor@
identifier F = { xFloor };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
T F(P)
{ BODY }

@static_to_extern_def_no_type_xFloor@
identifier F = { xFloor };
parameter list P;
type T;
statement list BODY;
@@
- static
+ extern
T F(P) { BODY }

@static_to_extern_decl_with_type_xFloor@
identifier F = { xFloor };
type T;
parameter list P;
@@
- static
+ extern
T F(P);

@static_to_extern_inline_xFloor@
identifier F = { xFloor };
type T;
parameter list P;
statement list BODY;
@@
- static
+ extern
inline T F(P) { BODY }

@finalize:python@
@@
print(">>> Completed processing 182 functions")
print(">>> From JSON: 160, Additional SQLite structures: 22")
print(">>> Functions are now globally visible with extern linkage")
