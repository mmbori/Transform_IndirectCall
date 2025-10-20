/*
** 2019-01-21
**
** The author disclaims copyright to this source code.  In place of
** a legal notice, here is a blessing:
**
**    May you do good and not evil.
**    May you find forgiveness for yourself and forgive others.
**    May you share freely, never taking more than you give.
**
*************************************************************************
**
** This file implements an extension that uses the SQLITE_CONFIG_MALLOC
** mechanism to add a tracing layer on top of SQLite.  If this extension
** is registered prior to sqlite3_initialize(), it will cause all memory
** allocation activities to be logged on standard output, or to some other
** FILE specified by the initializer.
**
** This file needs to be compiled into the application that uses it.
**
** This extension is used to implement the --memtrace option of the
** command-line shell.
*/
#include <assert.h>
#include <string.h>
#include <stdio.h>

/* The original memory allocation routines */
static sqlite3_mem_methods memtraceBase;
static FILE *memtraceOut;

/* Methods that trace memory allocations */
void *memtraceMalloc(int n){
  if( memtraceOut ){
    // fprintf(memtraceOut, "MEMTRACE: allocate %d bytes\n", 
    //         memtraceBase.xRoundup(n));
    fprintf(memtraceOut, "MEMTRACE: allocate %d bytes\n", 
            sqlite3MemRoundup(n));
  }
  if (memcmp(memtraceBase.xMalloc_signature, xMalloc_signatures[xMalloc_memtraceMalloc_enum], sizeof(memtraceBase.xMalloc_signature)) == 0) {
    return memtraceMalloc(n);
  }
  else
    if (memcmp(memtraceBase.xMalloc_signature, xMalloc_signatures[xMalloc_sqlite3MemMalloc_enum], sizeof(memtraceBase.xMalloc_signature)) == 0) {
      return sqlite3MemMalloc(n);
    }
}
void memtraceFree(void *p){
  if( p==0 ) return;
  if( memtraceOut ){
    fprintf(memtraceOut, "MEMTRACE: free %d bytes\n", sqlite3MemSize(p));
  }
  if (memcmp(memtraceBase.xFree_signature, xFree_signatures[xFree_memtraceFree_enum], sizeof(memtraceBase.xFree_signature)) == 0) {
    memtraceFree(p);
  }
  else
    if (memcmp(memtraceBase.xFree_signature, xFree_signatures[xFree_sqlite3MemFree_enum], sizeof(memtraceBase.xFree_signature)) == 0) {
      sqlite3MemFree(p);
    }
}
void *memtraceRealloc(void *p, int n){
  if( p==0 ) return memtraceMalloc(n);
  if( n==0 ){
    memtraceFree(p);
    return 0;
  }
  if( memtraceOut ){
    fprintf(memtraceOut, "MEMTRACE: resize %d -> %d bytes\n",
            sqlite3MemSize(p), sqlite3MemRoundup(n));
  }
  if (memcmp(memtraceBase.xRealloc_signature, xRealloc_signatures[xRealloc_memtraceRealloc_enum], sizeof(memtraceBase.xRealloc_signature)) == 0) {
    return memtraceRealloc(p, n);
  }
  else
    if (memcmp(memtraceBase.xRealloc_signature, xRealloc_signatures[xRealloc_sqlite3MemRealloc_enum], sizeof(memtraceBase.xRealloc_signature)) == 0) {
      return sqlite3MemRealloc(p, n);
    }
}
int memtraceSize(void *p){
  if (memcmp(memtraceBase.xSize_signature, xSize_signatures[xSize_memtraceSize_enum], sizeof(memtraceBase.xSize_signature)) == 0) {
    return memtraceSize(p);
  }
  else
    if (memcmp(memtraceBase.xSize_signature, xSize_signatures[xSize_sqlite3MemSize_enum], sizeof(memtraceBase.xSize_signature)) == 0) {
      return sqlite3MemSize(p);
    }
}
int memtraceRoundup(int n){
  if (memcmp(memtraceBase.xRoundup_signature, xRoundup_signatures[xRoundup_memtraceRoundup_enum], sizeof(memtraceBase.xRoundup_signature)) == 0) {
    return memtraceRoundup(n);
  }
  else
    if (memcmp(memtraceBase.xRoundup_signature, xRoundup_signatures[xRoundup_sqlite3MemRoundup_enum], sizeof(memtraceBase.xRoundup_signature)) == 0) {
      return sqlite3MemRoundup(n);
    }
}
int memtraceInit(void *p){
  if (memcmp(memtraceBase.xInit_signature, xInit_signatures[xInit_memtraceInit_enum], sizeof(memtraceBase.xInit_signature)) == 0) {
    return memtraceInit(p);
  }
  else
    if (memcmp(memtraceBase.xInit_signature, xInit_signatures[xInit_pcache1Init_enum], sizeof(memtraceBase.xInit_signature)) == 0) {
      return pcache1Init(p);
    }
  else
    if (memcmp(memtraceBase.xInit_signature, xInit_signatures[xInit_pcachetraceInit_enum], sizeof(memtraceBase.xInit_signature)) == 0) {
      return pcachetraceInit(p);
    }
  else
    if (memcmp(memtraceBase.xInit_signature, xInit_signatures[xInit_sqlite3MemInit_enum], sizeof(memtraceBase.xInit_signature)) == 0) {
      return sqlite3MemInit(p);
    }
}
void memtraceShutdown(void *p){
  if (memcmp(memtraceBase.xShutdown_signature, xShutdown_signatures[xShutdown_memtraceShutdown_enum], sizeof(memtraceBase.xShutdown_signature)) == 0) {
    memtraceShutdown(p);
  }
  else
    if (memcmp(memtraceBase.xShutdown_signature, xShutdown_signatures[xShutdown_pcache1Shutdown_enum], sizeof(memtraceBase.xShutdown_signature)) == 0) {
      pcache1Shutdown(p);
    }
  else
    if (memcmp(memtraceBase.xShutdown_signature, xShutdown_signatures[xShutdown_pcachetraceShutdown_enum], sizeof(memtraceBase.xShutdown_signature)) == 0) {
      pcachetraceShutdown(p);
    }
  else
    if (memcmp(memtraceBase.xShutdown_signature, xShutdown_signatures[xShutdown_sqlite3MemShutdown_enum], sizeof(memtraceBase.xShutdown_signature)) == 0) {
      sqlite3MemShutdown(p);
    }
}

/* The substitute memory allocator */
static sqlite3_mem_methods ersaztMethods = {
  memtraceMalloc,
  memtraceFree,
  memtraceRealloc,
  memtraceSize,
  memtraceRoundup,
  memtraceInit,
  memtraceShutdown,
  0
,
  .xMalloc_signature = xMalloc_signatures[xMalloc_memtraceMalloc_enum],
  .xFree_signature = xFree_signatures[xFree_memtraceFree_enum],
  .xRealloc_signature = xRealloc_signatures[xRealloc_memtraceRealloc_enum],
  .xSize_signature = xSize_signatures[xSize_memtraceSize_enum],
  .xRoundup_signature = xRoundup_signatures[xRoundup_memtraceRoundup_enum],
  .xInit_signature = xInit_signatures[xInit_memtraceInit_enum],
  .xShutdown_signature = xShutdown_signatures[xShutdown_memtraceShutdown_enum]
};

/* Begin tracing memory allocations to out. */
int sqlite3MemTraceActivate(FILE *out){
  int rc = SQLITE_OK;
  if( memtraceBase.xMalloc==0 ){
    rc = sqlite3_config(SQLITE_CONFIG_GETMALLOC, &memtraceBase);
    if( rc==SQLITE_OK ){
      rc = sqlite3_config(SQLITE_CONFIG_MALLOC, &ersaztMethods);
    }
  }
  memtraceOut = out;
  return rc;
}

/* Deactivate memory tracing */
int sqlite3MemTraceDeactivate(void){
  int rc = SQLITE_OK;
  if( memtraceBase.xMalloc!=0 ){
    rc = sqlite3_config(SQLITE_CONFIG_MALLOC, &memtraceBase);
    if( rc==SQLITE_OK ){
      memset(&memtraceBase, 0, sizeof(memtraceBase));
    }
  }
  memtraceOut = 0;
  return rc;
}
