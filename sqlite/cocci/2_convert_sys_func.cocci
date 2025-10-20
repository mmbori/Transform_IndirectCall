// Auto-generated Coccinelle script for SQLite GlobalConfig transformation
// Replaces function pointer calls with direct function calls

@initialize:python@
@@
print(">>> Starting GlobalConfig transformation")

// ===== FUNCTION CALL REPLACEMENTS =====

@replace_mutex_xmutexinit@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.mutex.xMutexInit(A)
+ noopMutexInit(A)

@replace_mutex_xmutexend@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.mutex.xMutexEnd(A)
+ noopMutexEnd(A)

@replace_mutex_xmutexalloc@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.mutex.xMutexAlloc(A)
+ noopMutexAlloc(A)

@replace_mutex_xmutexfree@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.mutex.xMutexFree(A)
+ noopMutexFree(A)

@replace_mutex_xmutexenter@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.mutex.xMutexEnter(A)
+ noopMutexEnter(A)

@replace_mutex_xmutextry@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.mutex.xMutexTry(A)
+ noopMutexTry(A)

@replace_mutex_xmutexleave@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.mutex.xMutexLeave(A)
+ noopMutexLeave(A)

@replace_mem_xmalloc@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.m.xMalloc(A)
+ sqlite3MemMalloc(A)

@replace_mem_xfree@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.m.xFree(A)
+ sqlite3MemFree(A)

@replace_mem_xrealloc@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.m.xRealloc(A)
+ sqlite3MemRealloc(A)

@replace_mem_xsize@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.m.xSize(A)
+ sqlite3MemSize(A)

@replace_mem_xroundup@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.m.xRoundup(A)
+ sqlite3MemRoundup(A)

@replace_mem_xinit@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.m.xInit(A)
+ sqlite3MemInit(A)

@replace_mem_xshutdown@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.m.xShutdown(A)
+ sqlite3MemShutdown(A)

@replace_pcache_xinit@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.pcache2.xInit(A)
+ pcache1Init(A)

@replace_pcache_xshutdown@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.pcache2.xShutdown(A)
+ pcache1Shutdown(A)

@replace_pcache_xcreate@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.pcache2.xCreate(A)
+ pcache1Create(A)

@replace_pcache_xcachesize@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.pcache2.xCachesize(A)
+ pcache1Cachesize(A)

@replace_pcache_xpagecount@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.pcache2.xPagecount(A)
+ pcache1Pagecount(A)

@replace_pcache_xfetch@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.pcache2.xFetch(A)
+ pcache1Fetch(A)

@replace_pcache_xunpin@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.pcache2.xUnpin(A)
+ pcache1Unpin(A)

@replace_pcache_xrekey@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.pcache2.xRekey(A)
+ pcache1Rekey(A)

@replace_pcache_xtruncate@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.pcache2.xTruncate(A)
+ pcache1Truncate(A)

@replace_pcache_xdestroy@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.pcache2.xDestroy(A)
+ pcache1Destroy(A)

@replace_pcache_xshrink@
identifier CFG = { sqlite3GlobalConfig };
expression list A;
@@
- CFG.pcache2.xShrink(A)
+ pcache1Shrink(A)

@finalize:python@
@@
print(">>> GlobalConfig transformation complete")
