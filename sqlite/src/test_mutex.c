/*
** 2008 June 18
**
** The author disclaims copyright to this source code.  In place of
** a legal notice, here is a blessing:
**
**    May you do good and not evil.
**    May you find forgiveness for yourself and forgive others.
**    May you share freely, never taking more than you give.
**
*************************************************************************
** This file contains test logic for the sqlite3_mutex interfaces.
*/
#include "tclsqlite.h"
#include "sqlite3.h"
#include "sqliteInt.h"
#include <stdlib.h>
#include <assert.h>
#include <string.h>

#define MAX_MUTEXES        (SQLITE_MUTEX_STATIC_VFS3+1)
#define STATIC_MUTEXES     (MAX_MUTEXES-(SQLITE_MUTEX_RECURSIVE+1))

/* defined in main.c */
extern const char *sqlite3ErrName(int);

static const char *aName[MAX_MUTEXES+1] = {
  "fast",        "recursive",   "static_main",   "static_mem",
  "static_open", "static_prng", "static_lru",    "static_pmem",
  "static_app1", "static_app2", "static_app3",   "static_vfs1",
  "static_vfs2", "static_vfs3", 0
};

/* A countable mutex */
struct sqlite3_mutex {
  sqlite3_mutex *pReal;
  int eType;
};

/* State variables */
static struct test_mutex_globals {
  int isInstalled;           /* True if installed */
  int disableInit;           /* True to cause sqlite3_initialize() to fail */
  int disableTry;            /* True to force sqlite3_mutex_try() to fail */
  int isInit;                /* True if initialized */
  sqlite3_mutex_methods m;   /* Interface to "real" mutex system */
  int aCounter[MAX_MUTEXES]; /* Number of grabs of each type of mutex */
  sqlite3_mutex aStatic[STATIC_MUTEXES]; /* The static mutexes */
} g = {0};

/* Return true if the countable mutex is currently held */
int counterMutexHeld(sqlite3_mutex *p){
  if (memcmp(g.m.xMutexHeld_signature, xMutexHeld_signatures[xMutexHeld_0_enum], sizeof(g.m.xMutexHeld_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(g.m.xMutexHeld_signature, xMutexHeld_signatures[xMutexHeld_counterMutexHeld_enum], sizeof(g.m.xMutexHeld_signature)) == 0) {
      return counterMutexHeld(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexHeld_signature, xMutexHeld_signatures[xMutexHeld_debugMutexHeld_enum], sizeof(g.m.xMutexHeld_signature)) == 0) {
      return debugMutexHeld(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexHeld_signature, xMutexHeld_signatures[xMutexHeld_wrMutexHeld_enum], sizeof(g.m.xMutexHeld_signature)) == 0) {
      return wrMutexHeld(p->pReal);
    }
}

/* Return true if the countable mutex is not currently held */
int counterMutexNotheld(sqlite3_mutex *p){
  if (memcmp(g.m.xMutexNotheld_signature, xMutexNotheld_signatures[xMutexNotheld_0_enum], sizeof(g.m.xMutexNotheld_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(g.m.xMutexNotheld_signature, xMutexNotheld_signatures[xMutexNotheld_counterMutexNotheld_enum], sizeof(g.m.xMutexNotheld_signature)) == 0) {
      return counterMutexNotheld(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexNotheld_signature, xMutexNotheld_signatures[xMutexNotheld_debugMutexNotheld_enum], sizeof(g.m.xMutexNotheld_signature)) == 0) {
      return debugMutexNotheld(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexNotheld_signature, xMutexNotheld_signatures[xMutexNotheld_wrMutexNotheld_enum], sizeof(g.m.xMutexNotheld_signature)) == 0) {
      return wrMutexNotheld(p->pReal);
    }
}

/* Initialize the countable mutex interface
** Or, if g.disableInit is non-zero, then do not initialize but instead
** return the value of g.disableInit as the result code.  This can be used
** to simulate an initialization failure.
*/
int counterMutexInit(void){ 
  int rc;
  if( g.disableInit ) return g.disableInit;
  if (memcmp(g.m.xMutexInit_signature, xMutexInit_signatures[xMutexInit_checkMutexInit_enum], sizeof(g.m.xMutexInit_signature)) == 0) {
    rc = checkMutexInit();
  }
  else
    if (memcmp(g.m.xMutexInit_signature, xMutexInit_signatures[xMutexInit_counterMutexInit_enum], sizeof(g.m.xMutexInit_signature)) == 0) {
      rc = counterMutexInit();
    }
  else
    if (memcmp(g.m.xMutexInit_signature, xMutexInit_signatures[xMutexInit_debugMutexInit_enum], sizeof(g.m.xMutexInit_signature)) == 0) {
      rc = debugMutexInit();
    }
  else
    if (memcmp(g.m.xMutexInit_signature, xMutexInit_signatures[xMutexInit_noopMutexInit_enum], sizeof(g.m.xMutexInit_signature)) == 0) {
      rc = noopMutexInit();
    }
  else
    if (memcmp(g.m.xMutexInit_signature, xMutexInit_signatures[xMutexInit_pthreadMutexInit_enum], sizeof(g.m.xMutexInit_signature)) == 0) {
      rc = pthreadMutexInit();
    }
  else
    if (memcmp(g.m.xMutexInit_signature, xMutexInit_signatures[xMutexInit_winMutexInit_enum], sizeof(g.m.xMutexInit_signature)) == 0) {
      rc = winMutexInit();
    }
  else
    if (memcmp(g.m.xMutexInit_signature, xMutexInit_signatures[xMutexInit_wrMutexInit_enum], sizeof(g.m.xMutexInit_signature)) == 0) {
      rc = wrMutexInit();
    }
  g.isInit = 1;
  return rc;
}

/*
** Uninitialize the mutex subsystem
*/
int counterMutexEnd(void){ 
  g.isInit = 0;
  if (memcmp(g.m.xMutexEnd_signature, xMutexEnd_signatures[xMutexEnd_checkMutexEnd_enum], sizeof(g.m.xMutexEnd_signature)) == 0) {
    return checkMutexEnd();
  }
  else
    if (memcmp(g.m.xMutexEnd_signature, xMutexEnd_signatures[xMutexEnd_counterMutexEnd_enum], sizeof(g.m.xMutexEnd_signature)) == 0) {
      return counterMutexEnd();
    }
  else
    if (memcmp(g.m.xMutexEnd_signature, xMutexEnd_signatures[xMutexEnd_debugMutexEnd_enum], sizeof(g.m.xMutexEnd_signature)) == 0) {
      return debugMutexEnd();
    }
  else
    if (memcmp(g.m.xMutexEnd_signature, xMutexEnd_signatures[xMutexEnd_noopMutexEnd_enum], sizeof(g.m.xMutexEnd_signature)) == 0) {
      return noopMutexEnd();
    }
  else
    if (memcmp(g.m.xMutexEnd_signature, xMutexEnd_signatures[xMutexEnd_pthreadMutexEnd_enum], sizeof(g.m.xMutexEnd_signature)) == 0) {
      return pthreadMutexEnd();
    }
  else
    if (memcmp(g.m.xMutexEnd_signature, xMutexEnd_signatures[xMutexEnd_winMutexEnd_enum], sizeof(g.m.xMutexEnd_signature)) == 0) {
      return winMutexEnd();
    }
  else
    if (memcmp(g.m.xMutexEnd_signature, xMutexEnd_signatures[xMutexEnd_wrMutexEnd_enum], sizeof(g.m.xMutexEnd_signature)) == 0) {
      return wrMutexEnd();
    }
}

/*
** Allocate a countable mutex
*/
sqlite3_mutex *counterMutexAlloc(int eType){
  sqlite3_mutex *pReal;
  sqlite3_mutex *pRet = 0;

  assert( g.isInit );
  assert( eType>=SQLITE_MUTEX_FAST );
  assert( eType<=SQLITE_MUTEX_STATIC_VFS3 );

  if (memcmp(g.m.xMutexAlloc_signature, xMutexAlloc_signatures[xMutexAlloc_checkMutexAlloc_enum], sizeof(g.m.xMutexAlloc_signature)) == 0) {
    pReal = checkMutexAlloc(eType);
  }
  else
    if (memcmp(g.m.xMutexAlloc_signature, xMutexAlloc_signatures[xMutexAlloc_counterMutexAlloc_enum], sizeof(g.m.xMutexAlloc_signature)) == 0) {
      pReal = counterMutexAlloc(eType);
    }
  else
    if (memcmp(g.m.xMutexAlloc_signature, xMutexAlloc_signatures[xMutexAlloc_debugMutexAlloc_enum], sizeof(g.m.xMutexAlloc_signature)) == 0) {
      pReal = debugMutexAlloc(eType);
    }
  else
    if (memcmp(g.m.xMutexAlloc_signature, xMutexAlloc_signatures[xMutexAlloc_noopMutexAlloc_enum], sizeof(g.m.xMutexAlloc_signature)) == 0) {
      pReal = noopMutexAlloc(eType);
    }
  else
    if (memcmp(g.m.xMutexAlloc_signature, xMutexAlloc_signatures[xMutexAlloc_pthreadMutexAlloc_enum], sizeof(g.m.xMutexAlloc_signature)) == 0) {
      pReal = pthreadMutexAlloc(eType);
    }
  else
    if (memcmp(g.m.xMutexAlloc_signature, xMutexAlloc_signatures[xMutexAlloc_winMutexAlloc_enum], sizeof(g.m.xMutexAlloc_signature)) == 0) {
      pReal = winMutexAlloc(eType);
    }
  else
    if (memcmp(g.m.xMutexAlloc_signature, xMutexAlloc_signatures[xMutexAlloc_wrMutexAlloc_enum], sizeof(g.m.xMutexAlloc_signature)) == 0) {
      pReal = wrMutexAlloc(eType);
    }
  if( !pReal ) return 0;

  if( eType==SQLITE_MUTEX_FAST || eType==SQLITE_MUTEX_RECURSIVE ){
    pRet = (sqlite3_mutex *)malloc(sizeof(sqlite3_mutex));
  }else{
    int eStaticType = eType - (MAX_MUTEXES - STATIC_MUTEXES);
    assert( eStaticType>=0 );
    assert( eStaticType<STATIC_MUTEXES );
    pRet = &g.aStatic[eStaticType];
  }

  pRet->eType = eType;
  pRet->pReal = pReal;
  return pRet;
}

/*
** Free a countable mutex
*/
void counterMutexFree(sqlite3_mutex *p){
  assert( g.isInit );
  if (memcmp(g.m.xMutexFree_signature, xMutexFree_signatures[xMutexFree_checkMutexFree_enum], sizeof(g.m.xMutexFree_signature)) == 0) {
    checkMutexFree(p->pReal);
  }
  else
    if (memcmp(g.m.xMutexFree_signature, xMutexFree_signatures[xMutexFree_counterMutexFree_enum], sizeof(g.m.xMutexFree_signature)) == 0) {
      counterMutexFree(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexFree_signature, xMutexFree_signatures[xMutexFree_debugMutexFree_enum], sizeof(g.m.xMutexFree_signature)) == 0) {
      debugMutexFree(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexFree_signature, xMutexFree_signatures[xMutexFree_noopMutexFree_enum], sizeof(g.m.xMutexFree_signature)) == 0) {
      noopMutexFree(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexFree_signature, xMutexFree_signatures[xMutexFree_pthreadMutexFree_enum], sizeof(g.m.xMutexFree_signature)) == 0) {
      pthreadMutexFree(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexFree_signature, xMutexFree_signatures[xMutexFree_winMutexFree_enum], sizeof(g.m.xMutexFree_signature)) == 0) {
      winMutexFree(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexFree_signature, xMutexFree_signatures[xMutexFree_wrMutexFree_enum], sizeof(g.m.xMutexFree_signature)) == 0) {
      wrMutexFree(p->pReal);
    }
  if( p->eType==SQLITE_MUTEX_FAST || p->eType==SQLITE_MUTEX_RECURSIVE ){
    free(p);
  }
}

/*
** Enter a countable mutex.  Block until entry is safe.
*/
void counterMutexEnter(sqlite3_mutex *p){
  assert( g.isInit );
  assert( p->eType>=0 );
  assert( p->eType<MAX_MUTEXES );
  g.aCounter[p->eType]++;
  if (memcmp(g.m.xMutexEnter_signature, xMutexEnter_signatures[xMutexEnter_checkMutexEnter_enum], sizeof(g.m.xMutexEnter_signature)) == 0) {
    checkMutexEnter(p->pReal);
  }
  else
    if (memcmp(g.m.xMutexEnter_signature, xMutexEnter_signatures[xMutexEnter_counterMutexEnter_enum], sizeof(g.m.xMutexEnter_signature)) == 0) {
      counterMutexEnter(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexEnter_signature, xMutexEnter_signatures[xMutexEnter_debugMutexEnter_enum], sizeof(g.m.xMutexEnter_signature)) == 0) {
      debugMutexEnter(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexEnter_signature, xMutexEnter_signatures[xMutexEnter_noopMutexEnter_enum], sizeof(g.m.xMutexEnter_signature)) == 0) {
      noopMutexEnter(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexEnter_signature, xMutexEnter_signatures[xMutexEnter_pthreadMutexEnter_enum], sizeof(g.m.xMutexEnter_signature)) == 0) {
      pthreadMutexEnter(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexEnter_signature, xMutexEnter_signatures[xMutexEnter_winMutexEnter_enum], sizeof(g.m.xMutexEnter_signature)) == 0) {
      winMutexEnter(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexEnter_signature, xMutexEnter_signatures[xMutexEnter_wrMutexEnter_enum], sizeof(g.m.xMutexEnter_signature)) == 0) {
      wrMutexEnter(p->pReal);
    }
}

/*
** Try to enter a mutex.  Return true on success.
*/
int counterMutexTry(sqlite3_mutex *p){
  assert( g.isInit );
  assert( p->eType>=0 );
  assert( p->eType<MAX_MUTEXES );
  g.aCounter[p->eType]++;
  if( g.disableTry ) return SQLITE_BUSY;
  if (memcmp(g.m.xMutexTry_signature, xMutexTry_signatures[xMutexTry_checkMutexTry_enum], sizeof(g.m.xMutexTry_signature)) == 0) {
    return checkMutexTry(p->pReal);
  }
  else
    if (memcmp(g.m.xMutexTry_signature, xMutexTry_signatures[xMutexTry_counterMutexTry_enum], sizeof(g.m.xMutexTry_signature)) == 0) {
      return counterMutexTry(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexTry_signature, xMutexTry_signatures[xMutexTry_debugMutexTry_enum], sizeof(g.m.xMutexTry_signature)) == 0) {
      return debugMutexTry(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexTry_signature, xMutexTry_signatures[xMutexTry_noopMutexTry_enum], sizeof(g.m.xMutexTry_signature)) == 0) {
      return noopMutexTry(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexTry_signature, xMutexTry_signatures[xMutexTry_pthreadMutexTry_enum], sizeof(g.m.xMutexTry_signature)) == 0) {
      return pthreadMutexTry(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexTry_signature, xMutexTry_signatures[xMutexTry_winMutexTry_enum], sizeof(g.m.xMutexTry_signature)) == 0) {
      return winMutexTry(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexTry_signature, xMutexTry_signatures[xMutexTry_wrMutexTry_enum], sizeof(g.m.xMutexTry_signature)) == 0) {
      return wrMutexTry(p->pReal);
    }
}

/* Leave a mutex
*/
void counterMutexLeave(sqlite3_mutex *p){
  assert( g.isInit );
  if (memcmp(g.m.xMutexLeave_signature, xMutexLeave_signatures[xMutexLeave_checkMutexLeave_enum], sizeof(g.m.xMutexLeave_signature)) == 0) {
    checkMutexLeave(p->pReal);
  }
  else
    if (memcmp(g.m.xMutexLeave_signature, xMutexLeave_signatures[xMutexLeave_counterMutexLeave_enum], sizeof(g.m.xMutexLeave_signature)) == 0) {
      counterMutexLeave(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexLeave_signature, xMutexLeave_signatures[xMutexLeave_debugMutexLeave_enum], sizeof(g.m.xMutexLeave_signature)) == 0) {
      debugMutexLeave(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexLeave_signature, xMutexLeave_signatures[xMutexLeave_noopMutexLeave_enum], sizeof(g.m.xMutexLeave_signature)) == 0) {
      noopMutexLeave(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexLeave_signature, xMutexLeave_signatures[xMutexLeave_pthreadMutexLeave_enum], sizeof(g.m.xMutexLeave_signature)) == 0) {
      pthreadMutexLeave(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexLeave_signature, xMutexLeave_signatures[xMutexLeave_winMutexLeave_enum], sizeof(g.m.xMutexLeave_signature)) == 0) {
      winMutexLeave(p->pReal);
    }
  else
    if (memcmp(g.m.xMutexLeave_signature, xMutexLeave_signatures[xMutexLeave_wrMutexLeave_enum], sizeof(g.m.xMutexLeave_signature)) == 0) {
      wrMutexLeave(p->pReal);
    }
}

/*
** sqlite3_shutdown
*/
static int SQLITE_TCLAPI test_shutdown(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  int rc;

  if( objc!=1 ){
    Tcl_WrongNumArgs(interp, 1, objv, "");
    return TCL_ERROR;
  }

  rc = sqlite3_shutdown();
  Tcl_SetResult(interp, (char *)sqlite3ErrName(rc), TCL_VOLATILE);
  return TCL_OK;
}

/*
** sqlite3_initialize
*/
static int SQLITE_TCLAPI test_initialize(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  int rc;

  if( objc!=1 ){
    Tcl_WrongNumArgs(interp, 1, objv, "");
    return TCL_ERROR;
  }

  rc = sqlite3_initialize();
  Tcl_SetResult(interp, (char *)sqlite3ErrName(rc), TCL_VOLATILE);
  return TCL_OK;
}

/*
** install_mutex_counters BOOLEAN
*/
static int SQLITE_TCLAPI test_install_mutex_counters(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  int rc = SQLITE_OK;
  int isInstall;

  sqlite3_mutex_methods counter_methods = {
    counterMutexInit,
    counterMutexEnd,
    counterMutexAlloc,
    counterMutexFree,
    counterMutexEnter,
    counterMutexTry,
    counterMutexLeave,
    counterMutexHeld,
    counterMutexNotheld
  ,
  .xMutexInit_signature = xMutexInit_signatures[xMutexInit_counterMutexInit_enum],
  .xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_counterMutexEnd_enum],
  .xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_counterMutexAlloc_enum],
  .xMutexFree_signature = xMutexFree_signatures[xMutexFree_counterMutexFree_enum],
  .xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_counterMutexEnter_enum],
  .xMutexTry_signature = xMutexTry_signatures[xMutexTry_counterMutexTry_enum],
  .xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_counterMutexLeave_enum],
  .xMutexHeld_signature = xMutexHeld_signatures[xMutexHeld_counterMutexHeld_enum],
  .xMutexNotheld_signature = xMutexNotheld_signatures[xMutexNotheld_counterMutexNotheld_enum]
};

  if( objc!=2 ){
    Tcl_WrongNumArgs(interp, 1, objv, "BOOLEAN");
    return TCL_ERROR;
  }
  if( TCL_OK!=Tcl_GetBooleanFromObj(interp, objv[1], &isInstall) ){
    return TCL_ERROR;
  }

  assert(isInstall==0 || isInstall==1);
  assert(g.isInstalled==0 || g.isInstalled==1);
  if( isInstall==g.isInstalled ){
    Tcl_AppendResult(interp, "mutex counters are ", NULL);
    Tcl_AppendResult(interp, isInstall?"already installed":"not installed", NULL);
    return TCL_ERROR;
  }

  if( isInstall ){
    assert( g.m.xMutexAlloc==0 );
    rc = sqlite3_config(SQLITE_CONFIG_GETMUTEX, &g.m);
    if( rc==SQLITE_OK ){
      sqlite3_config(SQLITE_CONFIG_MUTEX, &counter_methods);
    }
    g.disableTry = 0;
  }else{
    assert( g.m.xMutexAlloc );
    rc = sqlite3_config(SQLITE_CONFIG_MUTEX, &g.m);
    memset(&g.m, 0, sizeof(sqlite3_mutex_methods));
  }

  if( rc==SQLITE_OK ){
    g.isInstalled = isInstall;
  }

  Tcl_SetResult(interp, (char *)sqlite3ErrName(rc), TCL_VOLATILE);
  return TCL_OK;
}

/*
** read_mutex_counters
*/
static int SQLITE_TCLAPI test_read_mutex_counters(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  Tcl_Obj *pRet;
  int ii;

  if( objc!=1 ){
    Tcl_WrongNumArgs(interp, 1, objv, "");
    return TCL_ERROR;
  }

  pRet = Tcl_NewObj();
  Tcl_IncrRefCount(pRet);
  for(ii=0; ii<MAX_MUTEXES; ii++){
    Tcl_ListObjAppendElement(interp, pRet, Tcl_NewStringObj(aName[ii], -1));
    Tcl_ListObjAppendElement(interp, pRet, Tcl_NewIntObj(g.aCounter[ii]));
  }
  Tcl_SetObjResult(interp, pRet);
  Tcl_DecrRefCount(pRet);

  return TCL_OK;
}

/*
** clear_mutex_counters
*/
static int SQLITE_TCLAPI test_clear_mutex_counters(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  int ii;

  if( objc!=1 ){
    Tcl_WrongNumArgs(interp, 1, objv, "");
    return TCL_ERROR;
  }

  for(ii=0; ii<MAX_MUTEXES; ii++){
    g.aCounter[ii] = 0;
  }
  return TCL_OK;
}

/*
** Create and free a mutex.  Return the mutex pointer.  The pointer
** will be invalid since the mutex has already been freed.  The
** return pointer just checks to see if the mutex really was allocated.
*/
static int SQLITE_TCLAPI test_alloc_mutex(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
#if SQLITE_THREADSAFE
  sqlite3_mutex *p = sqlite3_mutex_alloc(SQLITE_MUTEX_FAST);
  char zBuf[100];
  sqlite3_mutex_free(p);
  sqlite3_snprintf(sizeof(zBuf), zBuf, "%p", p);
  Tcl_AppendResult(interp, zBuf, (char*)0);
#endif
  return TCL_OK;
}

/*
** sqlite3_config OPTION
**
** OPTION can be either one of the keywords:
**
**            SQLITE_CONFIG_SINGLETHREAD
**            SQLITE_CONFIG_MULTITHREAD
**            SQLITE_CONFIG_SERIALIZED
**
** Or OPTION can be an raw integer.
*/
static int SQLITE_TCLAPI test_config(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  struct ConfigOption {
    const char *zName;
    int iValue;
  } aOpt[] = {
    {"singlethread", SQLITE_CONFIG_SINGLETHREAD},
    {"multithread",  SQLITE_CONFIG_MULTITHREAD},
    {"serialized",   SQLITE_CONFIG_SERIALIZED},
    {0, 0}
  };
  int s = sizeof(struct ConfigOption);
  int i;
  int rc;

  if( objc!=2 ){
    Tcl_WrongNumArgs(interp, 1, objv, "");
    return TCL_ERROR;
  }

  if( Tcl_GetIndexFromObjStruct(interp, objv[1], aOpt, s, "flag", 0, &i) ){
    if( Tcl_GetIntFromObj(interp, objv[1], &i) ){
      return TCL_ERROR;
    }
  }else{
    i = aOpt[i].iValue;
  }

  rc = sqlite3_config(i);
  Tcl_SetResult(interp, (char *)sqlite3ErrName(rc), TCL_VOLATILE);
  return TCL_OK;
}

static sqlite3 *getDbPointer(Tcl_Interp *pInterp, Tcl_Obj *pObj){
  sqlite3 *db;
  Tcl_CmdInfo info;
  char *zCmd = Tcl_GetString(pObj);
  if( Tcl_GetCommandInfo(pInterp, zCmd, &info) ){
    db = *((sqlite3 **)info.objClientData);
  }else{
    db = (sqlite3*)sqlite3TestTextToPtr(zCmd);
  }
  assert( db );
  return db;
}

static sqlite3_mutex *getStaticMutexPointer(
  Tcl_Interp *pInterp,
  Tcl_Obj *pObj
){
  int iMutex;
  if( Tcl_GetIndexFromObj(pInterp, pObj, aName, "mutex name", 0, &iMutex) ){
    return 0;
  }
  assert( iMutex!=SQLITE_MUTEX_FAST && iMutex!=SQLITE_MUTEX_RECURSIVE );
  return counterMutexAlloc(iMutex);
}

static int SQLITE_TCLAPI test_enter_static_mutex(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  sqlite3_mutex *pMutex;
  if( objc!=2 ){
    Tcl_WrongNumArgs(interp, 1, objv, "NAME");
    return TCL_ERROR;
  }
  pMutex = getStaticMutexPointer(interp, objv[1]);
  if( !pMutex ){
    return TCL_ERROR;
  }
  sqlite3_mutex_enter(pMutex);
  return TCL_OK;
}

static int SQLITE_TCLAPI test_leave_static_mutex(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  sqlite3_mutex *pMutex;
  if( objc!=2 ){
    Tcl_WrongNumArgs(interp, 1, objv, "NAME");
    return TCL_ERROR;
  }
  pMutex = getStaticMutexPointer(interp, objv[1]);
  if( !pMutex ){
    return TCL_ERROR;
  }
  sqlite3_mutex_leave(pMutex);
  return TCL_OK;
}

static int SQLITE_TCLAPI test_enter_db_mutex(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  sqlite3 *db;
  if( objc!=2 ){
    Tcl_WrongNumArgs(interp, 1, objv, "DB");
    return TCL_ERROR;
  }
  db = getDbPointer(interp, objv[1]);
  if( !db ){
    return TCL_ERROR;
  }
  sqlite3_mutex_enter(sqlite3_db_mutex(db));
  return TCL_OK;
}

static int SQLITE_TCLAPI test_leave_db_mutex(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  sqlite3 *db;
  if( objc!=2 ){
    Tcl_WrongNumArgs(interp, 1, objv, "DB");
    return TCL_ERROR;
  }
  db = getDbPointer(interp, objv[1]);
  if( !db ){
    return TCL_ERROR;
  }
  sqlite3_mutex_leave(sqlite3_db_mutex(db));
  return TCL_OK;
}

int Sqlitetest_mutex_Init(Tcl_Interp *interp){
  static struct {
    char *zName;
    Tcl_ObjCmdProc *xProc;
  } aCmd[] = {
    { "sqlite3_shutdown",        (Tcl_ObjCmdProc*)test_shutdown },
    { "sqlite3_initialize",      (Tcl_ObjCmdProc*)test_initialize },
    { "sqlite3_config",          (Tcl_ObjCmdProc*)test_config },

    { "enter_static_mutex",      (Tcl_ObjCmdProc*)test_enter_static_mutex },
    { "leave_static_mutex",      (Tcl_ObjCmdProc*)test_leave_static_mutex },

    { "enter_db_mutex",          (Tcl_ObjCmdProc*)test_enter_db_mutex },
    { "leave_db_mutex",          (Tcl_ObjCmdProc*)test_leave_db_mutex },

    { "alloc_dealloc_mutex",     (Tcl_ObjCmdProc*)test_alloc_mutex },
    { "install_mutex_counters",  (Tcl_ObjCmdProc*)test_install_mutex_counters },
    { "read_mutex_counters",     (Tcl_ObjCmdProc*)test_read_mutex_counters },
    { "clear_mutex_counters",    (Tcl_ObjCmdProc*)test_clear_mutex_counters },
  };
  int i;
  for(i=0; i<sizeof(aCmd)/sizeof(aCmd[0]); i++){
    Tcl_CreateObjCommand(interp, aCmd[i].zName, aCmd[i].xProc, 0, 0);
  }

  Tcl_LinkVar(interp, "disable_mutex_init", 
              (char*)&g.disableInit, TCL_LINK_INT);
  Tcl_LinkVar(interp, "disable_mutex_try", 
              (char*)&g.disableTry, TCL_LINK_INT);
  return SQLITE_OK;
}
