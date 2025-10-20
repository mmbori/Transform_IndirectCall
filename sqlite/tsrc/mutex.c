/*
** 2007 August 14
**
** The author disclaims copyright to this source code.  In place of
** a legal notice, here is a blessing:
**
**    May you do good and not evil.
**    May you find forgiveness for yourself and forgive others.
**    May you share freely, never taking more than you give.
**
*************************************************************************
** This file contains the C functions that implement mutexes.
**
** This file contains code that is common across all mutex implementations.
*/
#include "sqliteInt.h"

#if defined(SQLITE_DEBUG) && !defined(SQLITE_MUTEX_OMIT)
/*
** For debugging purposes, record when the mutex subsystem is initialized
** and uninitialized so that we can assert() if there is an attempt to
** allocate a mutex while the system is uninitialized.
*/
SQLITE_WSD int mutexIsInit = 0;
#endif /* SQLITE_DEBUG && !defined(SQLITE_MUTEX_OMIT) */


#ifndef SQLITE_MUTEX_OMIT

#ifdef SQLITE_ENABLE_MULTITHREADED_CHECKS
/*
** This block (enclosed by SQLITE_ENABLE_MULTITHREADED_CHECKS) contains
** the implementation of a wrapper around the system default mutex
** implementation (sqlite3DefaultMutex()). 
**
** Most calls are passed directly through to the underlying default
** mutex implementation. Except, if a mutex is configured by calling
** sqlite3MutexWarnOnContention() on it, then if contention is ever
** encountered within xMutexEnter() a warning is emitted via sqlite3_log().
**
** This type of mutex is used as the database handle mutex when testing
** apps that usually use SQLITE_CONFIG_MULTITHREAD mode.
*/

/* 
** Type for all mutexes used when SQLITE_ENABLE_MULTITHREADED_CHECKS
** is defined. Variable CheckMutex.mutex is a pointer to the real mutex
** allocated by the system mutex implementation. Variable iType is usually set
** to the type of mutex requested - SQLITE_MUTEX_RECURSIVE, SQLITE_MUTEX_FAST
** or one of the static mutex identifiers. Or, if this is a recursive mutex
** that has been configured using sqlite3MutexWarnOnContention(), it is
** set to SQLITE_MUTEX_WARNONCONTENTION.
*/
typedef struct CheckMutex CheckMutex;
struct CheckMutex {
  int iType;
  sqlite3_mutex *mutex;
};

#define SQLITE_MUTEX_WARNONCONTENTION  (-1)

/* 
** Pointer to real mutex methods object used by the CheckMutex
** implementation. Set by checkMutexInit(). 
*/
static SQLITE_WSD const sqlite3_mutex_methods *pGlobalMutexMethods;

#ifdef SQLITE_DEBUG
static int checkMutexHeld(sqlite3_mutex *p){
  if (memcmp(pGlobalMutexMethods->xMutexHeld_signature, xMutexHeld_signatures[xMutexHeld_0_enum], sizeof(pGlobalMutexMethods->xMutexHeld_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pGlobalMutexMethods->xMutexHeld_signature, xMutexHeld_signatures[xMutexHeld_counterMutexHeld_enum], sizeof(pGlobalMutexMethods->xMutexHeld_signature)) == 0) {
      return counterMutexHeld(((CheckMutex *)p)->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexHeld_signature, xMutexHeld_signatures[xMutexHeld_debugMutexHeld_enum], sizeof(pGlobalMutexMethods->xMutexHeld_signature)) == 0) {
      return debugMutexHeld(((CheckMutex *)p)->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexHeld_signature, xMutexHeld_signatures[xMutexHeld_wrMutexHeld_enum], sizeof(pGlobalMutexMethods->xMutexHeld_signature)) == 0) {
      return wrMutexHeld(((CheckMutex *)p)->mutex);
    }
}
int checkMutexNotheld(sqlite3_mutex *p){
  if (memcmp(pGlobalMutexMethods->xMutexNotheld_signature, xMutexNotheld_signatures[xMutexNotheld_0_enum], sizeof(pGlobalMutexMethods->xMutexNotheld_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pGlobalMutexMethods->xMutexNotheld_signature, xMutexNotheld_signatures[xMutexNotheld_counterMutexNotheld_enum], sizeof(pGlobalMutexMethods->xMutexNotheld_signature)) == 0) {
      return counterMutexNotheld(((CheckMutex *)p)->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexNotheld_signature, xMutexNotheld_signatures[xMutexNotheld_debugMutexNotheld_enum], sizeof(pGlobalMutexMethods->xMutexNotheld_signature)) == 0) {
      return debugMutexNotheld(((CheckMutex *)p)->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexNotheld_signature, xMutexNotheld_signatures[xMutexNotheld_wrMutexNotheld_enum], sizeof(pGlobalMutexMethods->xMutexNotheld_signature)) == 0) {
      return wrMutexNotheld(((CheckMutex *)p)->mutex);
    }
}
#endif

/*
** Initialize and deinitialize the mutex subsystem.
*/
int checkMutexInit(void){ 
  pGlobalMutexMethods = sqlite3DefaultMutex();
  return SQLITE_OK; 
}
int checkMutexEnd(void){ 
  pGlobalMutexMethods = 0;
  return SQLITE_OK; 
}

/*
** Allocate a mutex.
*/
sqlite3_mutex *checkMutexAlloc(int iType){
  static CheckMutex staticMutexes[] = {
    {2, 0}, {3, 0}, {4, 0}, {5, 0},
    {6, 0}, {7, 0}, {8, 0}, {9, 0},
    {10, 0}, {11, 0}, {12, 0}, {13, 0}
  };
  CheckMutex *p = 0;

  assert( SQLITE_MUTEX_RECURSIVE==1 && SQLITE_MUTEX_FAST==0 );
  if( iType<2 ){
    p = sqlite3MallocZero(sizeof(CheckMutex));
    if( p==0 ) return 0;
    p->iType = iType;
  }else{
#ifdef SQLITE_ENABLE_API_ARMOR
    if( iType-2>=ArraySize(staticMutexes) ){
      (void)SQLITE_MISUSE_BKPT;
      return 0;
    }
#endif
    p = &staticMutexes[iType-2];
  }

  if( p->mutex==0 ){
    if (memcmp(pGlobalMutexMethods->xMutexAlloc_signature, xMutexAlloc_signatures[xMutexAlloc_checkMutexAlloc_enum], sizeof(pGlobalMutexMethods->xMutexAlloc_signature)) == 0) {
      p->mutex = checkMutexAlloc(iType);
    }
    else
      if (memcmp(pGlobalMutexMethods->xMutexAlloc_signature, xMutexAlloc_signatures[xMutexAlloc_counterMutexAlloc_enum], sizeof(pGlobalMutexMethods->xMutexAlloc_signature)) == 0) {
        p->mutex = counterMutexAlloc(iType);
      }
    else
      if (memcmp(pGlobalMutexMethods->xMutexAlloc_signature, xMutexAlloc_signatures[xMutexAlloc_debugMutexAlloc_enum], sizeof(pGlobalMutexMethods->xMutexAlloc_signature)) == 0) {
        p->mutex = debugMutexAlloc(iType);
      }
    else
      if (memcmp(pGlobalMutexMethods->xMutexAlloc_signature, xMutexAlloc_signatures[xMutexAlloc_noopMutexAlloc_enum], sizeof(pGlobalMutexMethods->xMutexAlloc_signature)) == 0) {
        p->mutex = noopMutexAlloc(iType);
      }
    else
      if (memcmp(pGlobalMutexMethods->xMutexAlloc_signature, xMutexAlloc_signatures[xMutexAlloc_pthreadMutexAlloc_enum], sizeof(pGlobalMutexMethods->xMutexAlloc_signature)) == 0) {
        p->mutex = pthreadMutexAlloc(iType);
      }
    else
      if (memcmp(pGlobalMutexMethods->xMutexAlloc_signature, xMutexAlloc_signatures[xMutexAlloc_winMutexAlloc_enum], sizeof(pGlobalMutexMethods->xMutexAlloc_signature)) == 0) {
        p->mutex = winMutexAlloc(iType);
      }
    else
      if (memcmp(pGlobalMutexMethods->xMutexAlloc_signature, xMutexAlloc_signatures[xMutexAlloc_wrMutexAlloc_enum], sizeof(pGlobalMutexMethods->xMutexAlloc_signature)) == 0) {
        p->mutex = wrMutexAlloc(iType);
      }
    if( p->mutex==0 ){
      if( iType<2 ){
        sqlite3_free(p);
      }
      p = 0;
    }
  }

  return (sqlite3_mutex*)p;
}

/*
** Free a mutex.
*/
void checkMutexFree(sqlite3_mutex *p){
  assert( SQLITE_MUTEX_RECURSIVE<2 );
  assert( SQLITE_MUTEX_FAST<2 );
  assert( SQLITE_MUTEX_WARNONCONTENTION<2 );

#ifdef SQLITE_ENABLE_API_ARMOR
  if( ((CheckMutex*)p)->iType<2 )
#endif
  {
    CheckMutex *pCheck = (CheckMutex*)p;
    if (memcmp(pGlobalMutexMethods->xMutexFree_signature, xMutexFree_signatures[xMutexFree_checkMutexFree_enum], sizeof(pGlobalMutexMethods->xMutexFree_signature)) == 0) {
      checkMutexFree(pCheck->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexFree_signature, xMutexFree_signatures[xMutexFree_counterMutexFree_enum], sizeof(pGlobalMutexMethods->xMutexFree_signature)) == 0) {
      counterMutexFree(pCheck->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexFree_signature, xMutexFree_signatures[xMutexFree_debugMutexFree_enum], sizeof(pGlobalMutexMethods->xMutexFree_signature)) == 0) {
      debugMutexFree(pCheck->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexFree_signature, xMutexFree_signatures[xMutexFree_noopMutexFree_enum], sizeof(pGlobalMutexMethods->xMutexFree_signature)) == 0) {
      noopMutexFree(pCheck->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexFree_signature, xMutexFree_signatures[xMutexFree_pthreadMutexFree_enum], sizeof(pGlobalMutexMethods->xMutexFree_signature)) == 0) {
      pthreadMutexFree(pCheck->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexFree_signature, xMutexFree_signatures[xMutexFree_winMutexFree_enum], sizeof(pGlobalMutexMethods->xMutexFree_signature)) == 0) {
      winMutexFree(pCheck->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexFree_signature, xMutexFree_signatures[xMutexFree_wrMutexFree_enum], sizeof(pGlobalMutexMethods->xMutexFree_signature)) == 0) {
      wrMutexFree(pCheck->mutex);
    }
  sqlite3_free(pCheck);
}
#ifdef SQLITE_ENABLE_API_ARMOR
  else{
    (void)SQLITE_MISUSE_BKPT;
  }
#endif
}

/*
** Enter the mutex.
*/
void checkMutexEnter(sqlite3_mutex *p){
  CheckMutex *pCheck = (CheckMutex*)p;
  if( pCheck->iType==SQLITE_MUTEX_WARNONCONTENTION ){
    if( SQLITE_OK==pGlobalMutexMethods->xMutexTry(pCheck->mutex) ){
      return;
    }
    sqlite3_log(SQLITE_MISUSE, 
        "illegal multi-threaded access to database connection"
    );
  }
  if (memcmp(pGlobalMutexMethods->xMutexEnter_signature, xMutexEnter_signatures[xMutexEnter_checkMutexEnter_enum], sizeof(pGlobalMutexMethods->xMutexEnter_signature)) == 0) {
    checkMutexEnter(pCheck->mutex);
  }
  else
    if (memcmp(pGlobalMutexMethods->xMutexEnter_signature, xMutexEnter_signatures[xMutexEnter_counterMutexEnter_enum], sizeof(pGlobalMutexMethods->xMutexEnter_signature)) == 0) {
      counterMutexEnter(pCheck->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexEnter_signature, xMutexEnter_signatures[xMutexEnter_debugMutexEnter_enum], sizeof(pGlobalMutexMethods->xMutexEnter_signature)) == 0) {
      debugMutexEnter(pCheck->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexEnter_signature, xMutexEnter_signatures[xMutexEnter_noopMutexEnter_enum], sizeof(pGlobalMutexMethods->xMutexEnter_signature)) == 0) {
      noopMutexEnter(pCheck->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexEnter_signature, xMutexEnter_signatures[xMutexEnter_pthreadMutexEnter_enum], sizeof(pGlobalMutexMethods->xMutexEnter_signature)) == 0) {
      pthreadMutexEnter(pCheck->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexEnter_signature, xMutexEnter_signatures[xMutexEnter_winMutexEnter_enum], sizeof(pGlobalMutexMethods->xMutexEnter_signature)) == 0) {
      winMutexEnter(pCheck->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexEnter_signature, xMutexEnter_signatures[xMutexEnter_wrMutexEnter_enum], sizeof(pGlobalMutexMethods->xMutexEnter_signature)) == 0) {
      wrMutexEnter(pCheck->mutex);
    }
}

/*
** Enter the mutex (do not block).
*/
int checkMutexTry(sqlite3_mutex *p){
  CheckMutex *pCheck = (CheckMutex*)p;
  if (memcmp(pGlobalMutexMethods->xMutexTry_signature, xMutexTry_signatures[xMutexTry_checkMutexTry_enum], sizeof(pGlobalMutexMethods->xMutexTry_signature)) == 0) {
    return checkMutexTry(pCheck->mutex);
  }
  else
    if (memcmp(pGlobalMutexMethods->xMutexTry_signature, xMutexTry_signatures[xMutexTry_counterMutexTry_enum], sizeof(pGlobalMutexMethods->xMutexTry_signature)) == 0) {
      return counterMutexTry(pCheck->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexTry_signature, xMutexTry_signatures[xMutexTry_debugMutexTry_enum], sizeof(pGlobalMutexMethods->xMutexTry_signature)) == 0) {
      return debugMutexTry(pCheck->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexTry_signature, xMutexTry_signatures[xMutexTry_noopMutexTry_enum], sizeof(pGlobalMutexMethods->xMutexTry_signature)) == 0) {
      return noopMutexTry(pCheck->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexTry_signature, xMutexTry_signatures[xMutexTry_pthreadMutexTry_enum], sizeof(pGlobalMutexMethods->xMutexTry_signature)) == 0) {
      return pthreadMutexTry(pCheck->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexTry_signature, xMutexTry_signatures[xMutexTry_winMutexTry_enum], sizeof(pGlobalMutexMethods->xMutexTry_signature)) == 0) {
      return winMutexTry(pCheck->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexTry_signature, xMutexTry_signatures[xMutexTry_wrMutexTry_enum], sizeof(pGlobalMutexMethods->xMutexTry_signature)) == 0) {
      return wrMutexTry(pCheck->mutex);
    }
}

/*
** Leave the mutex.
*/
void checkMutexLeave(sqlite3_mutex *p){
  CheckMutex *pCheck = (CheckMutex*)p;
  if (memcmp(pGlobalMutexMethods->xMutexLeave_signature, xMutexLeave_signatures[xMutexLeave_checkMutexLeave_enum], sizeof(pGlobalMutexMethods->xMutexLeave_signature)) == 0) {
    checkMutexLeave(pCheck->mutex);
  }
  else
    if (memcmp(pGlobalMutexMethods->xMutexLeave_signature, xMutexLeave_signatures[xMutexLeave_counterMutexLeave_enum], sizeof(pGlobalMutexMethods->xMutexLeave_signature)) == 0) {
      counterMutexLeave(pCheck->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexLeave_signature, xMutexLeave_signatures[xMutexLeave_debugMutexLeave_enum], sizeof(pGlobalMutexMethods->xMutexLeave_signature)) == 0) {
      debugMutexLeave(pCheck->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexLeave_signature, xMutexLeave_signatures[xMutexLeave_noopMutexLeave_enum], sizeof(pGlobalMutexMethods->xMutexLeave_signature)) == 0) {
      noopMutexLeave(pCheck->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexLeave_signature, xMutexLeave_signatures[xMutexLeave_pthreadMutexLeave_enum], sizeof(pGlobalMutexMethods->xMutexLeave_signature)) == 0) {
      pthreadMutexLeave(pCheck->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexLeave_signature, xMutexLeave_signatures[xMutexLeave_winMutexLeave_enum], sizeof(pGlobalMutexMethods->xMutexLeave_signature)) == 0) {
      winMutexLeave(pCheck->mutex);
    }
  else
    if (memcmp(pGlobalMutexMethods->xMutexLeave_signature, xMutexLeave_signatures[xMutexLeave_wrMutexLeave_enum], sizeof(pGlobalMutexMethods->xMutexLeave_signature)) == 0) {
      wrMutexLeave(pCheck->mutex);
    }
}

sqlite3_mutex_methods const *multiThreadedCheckMutex(void){
  static const sqlite3_mutex_methods sMutex = {
    checkMutexInit,
    checkMutexEnd,
    checkMutexAlloc,
    checkMutexFree,
    checkMutexEnter,
    checkMutexTry,
    checkMutexLeave,
#ifdef SQLITE_DEBUG
    checkMutexHeld,
    checkMutexNotheld
#else
    0,
    0
#endif
  ,
  .xMutexInit_signature = xMutexInit_signatures[xMutexInit_checkMutexInit_enum],
  .xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_checkMutexEnd_enum],
  .xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_checkMutexAlloc_enum],
  .xMutexFree_signature = xMutexFree_signatures[xMutexFree_checkMutexFree_enum],
  .xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_checkMutexEnter_enum],
  .xMutexTry_signature = xMutexTry_signatures[xMutexTry_checkMutexTry_enum],
  .xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_checkMutexLeave_enum]
};
  return &sMutex;
}

/*
** Mark the SQLITE_MUTEX_RECURSIVE mutex passed as the only argument as
** one on which there should be no contention.
*/
void sqlite3MutexWarnOnContention(sqlite3_mutex *p){
  if( sqlite3GlobalConfig.mutex.xMutexAlloc==checkMutexAlloc ){
    CheckMutex *pCheck = (CheckMutex*)p;
    assert( pCheck->iType==SQLITE_MUTEX_RECURSIVE );
    pCheck->iType = SQLITE_MUTEX_WARNONCONTENTION;
  }
}
#endif   /* ifdef SQLITE_ENABLE_MULTITHREADED_CHECKS */

/*
** Initialize the mutex system.
*/
int sqlite3MutexInit(void){ 
  int rc = SQLITE_OK;
  if( !sqlite3GlobalConfig.mutex.xMutexAlloc ){
    /* If the xMutexAlloc method has not been set, then the user did not
    ** install a mutex implementation via sqlite3_config() prior to 
    ** sqlite3_initialize() being called. This block copies pointers to
    ** the default implementation into the sqlite3GlobalConfig structure.
    */
    sqlite3_mutex_methods const *pFrom;
    sqlite3_mutex_methods *pTo = &sqlite3GlobalConfig.mutex;

    if( sqlite3GlobalConfig.bCoreMutex ){
#ifdef SQLITE_ENABLE_MULTITHREADED_CHECKS
      pFrom = multiThreadedCheckMutex();
#else
      pFrom = sqlite3DefaultMutex();
#endif
    }else{
      pFrom = sqlite3NoopMutex();
    }
    pTo->xMutexInit = pFrom->xMutexInit;
    pTo->xMutexEnd = pFrom->xMutexEnd;
    pTo->xMutexFree = pFrom->xMutexFree;
    pTo->xMutexEnter = pFrom->xMutexEnter;
    pTo->xMutexTry = pFrom->xMutexTry;
    pTo->xMutexLeave = pFrom->xMutexLeave;
    pTo->xMutexHeld = pFrom->xMutexHeld;
    pTo->xMutexNotheld = pFrom->xMutexNotheld;
    sqlite3MemoryBarrier();
    pTo->xMutexAlloc = pFrom->xMutexAlloc;
  }
  assert( sqlite3GlobalConfig.mutex.xMutexInit );
  rc = noopMutexInit();

#ifdef SQLITE_DEBUG
  GLOBAL(int, mutexIsInit) = 1;
#endif

  sqlite3MemoryBarrier();
  return rc;
}

/*
** Shutdown the mutex system. This call frees resources allocated by
** sqlite3MutexInit().
*/
int sqlite3MutexEnd(void){
  int rc = SQLITE_OK;
  if( sqlite3GlobalConfig.mutex.xMutexEnd ){
    rc = noopMutexEnd();
  }

#ifdef SQLITE_DEBUG
  GLOBAL(int, mutexIsInit) = 0;
#endif

  return rc;
}

/*
** Retrieve a pointer to a static mutex or allocate a new dynamic one.
*/
sqlite3_mutex *sqlite3_mutex_alloc(int id){
#ifndef SQLITE_OMIT_AUTOINIT
  if( id<=SQLITE_MUTEX_RECURSIVE && sqlite3_initialize() ) return 0;
  if( id>SQLITE_MUTEX_RECURSIVE && sqlite3MutexInit() ) return 0;
#endif
  assert( sqlite3GlobalConfig.mutex.xMutexAlloc );
  return noopMutexAlloc(id);
}

sqlite3_mutex *sqlite3MutexAlloc(int id){
  if( !sqlite3GlobalConfig.bCoreMutex ){
    return 0;
  }
  assert( GLOBAL(int, mutexIsInit) );
  assert( sqlite3GlobalConfig.mutex.xMutexAlloc );
  return noopMutexAlloc(id);
}

/*
** Free a dynamic mutex.
*/
void sqlite3_mutex_free(sqlite3_mutex *p){
  if( p ){
    assert( sqlite3GlobalConfig.mutex.xMutexFree );
    noopMutexFree(p);
  }
}

/*
** Obtain the mutex p. If some other thread already has the mutex, block
** until it can be obtained.
*/
void sqlite3_mutex_enter(sqlite3_mutex *p){
  if( p ){
    assert( sqlite3GlobalConfig.mutex.xMutexEnter );
    noopMutexEnter(p);
  }
}

/*
** Obtain the mutex p. If successful, return SQLITE_OK. Otherwise, if another
** thread holds the mutex and it cannot be obtained, return SQLITE_BUSY.
*/
int sqlite3_mutex_try(sqlite3_mutex *p){
  int rc = SQLITE_OK;
  if( p ){
    assert( sqlite3GlobalConfig.mutex.xMutexTry );
    return noopMutexTry(p);
  }
  return rc;
}

/*
** The sqlite3_mutex_leave() routine exits a mutex that was previously
** entered by the same thread.  The behavior is undefined if the mutex 
** is not currently entered. If a NULL pointer is passed as an argument
** this function is a no-op.
*/
void sqlite3_mutex_leave(sqlite3_mutex *p){
  if( p ){
    assert( sqlite3GlobalConfig.mutex.xMutexLeave );
    noopMutexLeave(p);
  }
}

#ifndef NDEBUG
/*
** The sqlite3_mutex_held() and sqlite3_mutex_notheld() routine are
** intended for use inside assert() statements.
**
** Because these routines raise false-positive alerts in TSAN, disable
** them (make them always return 1) when compiling with TSAN.
*/
int sqlite3_mutex_held(sqlite3_mutex *p){
# if defined(__has_feature)
#   if __has_feature(thread_sanitizer)
      p = 0;
#   endif
# endif
  assert( p==0 || sqlite3GlobalConfig.mutex.xMutexHeld );
  return p==0 || sqlite3GlobalConfig.mutex.xMutexHeld(p);
}
int sqlite3_mutex_notheld(sqlite3_mutex *p){
# if defined(__has_feature)
#   if __has_feature(thread_sanitizer)
      p = 0;
#   endif
# endif
  assert( p==0 || sqlite3GlobalConfig.mutex.xMutexNotheld );
  return p==0 || sqlite3GlobalConfig.mutex.xMutexNotheld(p);
}
#endif /* NDEBUG */

#endif /* !defined(SQLITE_MUTEX_OMIT) */
