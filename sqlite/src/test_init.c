/*
** 2009 August 17
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
** The code in this file is used for testing SQLite. It is not part of
** the source code used in production systems.
**
** Specifically, this file tests the effect of errors while initializing
** the various pluggable sub-systems from within sqlite3_initialize().
** If an error occurs in sqlite3_initialize() the following should be
** true:
**
**   1) An error code is returned to the user, and
**   2) A subsequent call to sqlite3_shutdown() calls the shutdown method
**      of those subsystems that were initialized, and
**   3) A subsequent call to sqlite3_initialize() attempts to initialize
**      the remaining, uninitialized, subsystems.
*/

#include "sqliteInt.h"
#include <string.h>
#include "tclsqlite.h"

struct Wrapped {
  sqlite3_pcache_methods2 pcache;
  sqlite3_mem_methods     mem;
  sqlite3_mutex_methods   mutex;

  int mem_init;              /* True if mem subsystem is initialized */
  int mem_fail;              /* True to fail mem subsystem initialization */
  int mutex_init;            /* True if mutex subsystem is initialized */
  int mutex_fail;            /* True to fail mutex subsystem initialization */
  int pcache_init;           /* True if pcache subsystem is initialized */
  int pcache_fail;           /* True to fail pcache subsystem initialization */
} wrapped;

int wrMemInit(void *pAppData){
  int rc;
  if( wrapped.mem_fail ){
    rc = SQLITE_ERROR;
  }else{
    if (memcmp(wrapped.mem.xInit_signature, xInit_signatures[xInit_memtraceInit_enum], sizeof(wrapped.mem.xInit_signature)) == 0) {
      rc = memtraceInit(wrapped.mem.pAppData);
    }
    else
      if (memcmp(wrapped.mem.xInit_signature, xInit_signatures[xInit_pcache1Init_enum], sizeof(wrapped.mem.xInit_signature)) == 0) {
        rc = pcache1Init(wrapped.mem.pAppData);
      }
    else
      if (memcmp(wrapped.mem.xInit_signature, xInit_signatures[xInit_pcachetraceInit_enum], sizeof(wrapped.mem.xInit_signature)) == 0) {
        rc = pcachetraceInit(wrapped.mem.pAppData);
      }
    else
      if (memcmp(wrapped.mem.xInit_signature, xInit_signatures[xInit_sqlite3MemInit_enum], sizeof(wrapped.mem.xInit_signature)) == 0) {
        rc = sqlite3MemInit(wrapped.mem.pAppData);
      }
  }
  if( rc==SQLITE_OK ){
    wrapped.mem_init = 1;
  }
  return rc;
}
void wrMemShutdown(void *pAppData){
  if (memcmp(wrapped.mem.xShutdown_signature, xShutdown_signatures[xShutdown_memtraceShutdown_enum], sizeof(wrapped.mem.xShutdown_signature)) == 0) {
    memtraceShutdown(wrapped.mem.pAppData);
  }
  else
    if (memcmp(wrapped.mem.xShutdown_signature, xShutdown_signatures[xShutdown_pcache1Shutdown_enum], sizeof(wrapped.mem.xShutdown_signature)) == 0) {
      pcache1Shutdown(wrapped.mem.pAppData);
    }
  else
    if (memcmp(wrapped.mem.xShutdown_signature, xShutdown_signatures[xShutdown_pcachetraceShutdown_enum], sizeof(wrapped.mem.xShutdown_signature)) == 0) {
      pcachetraceShutdown(wrapped.mem.pAppData);
    }
  else
    if (memcmp(wrapped.mem.xShutdown_signature, xShutdown_signatures[xShutdown_sqlite3MemShutdown_enum], sizeof(wrapped.mem.xShutdown_signature)) == 0) {
      sqlite3MemShutdown(wrapped.mem.pAppData);
    }
  wrapped.mem_init = 0;
}
void *wrMemMalloc(int n)           {if (memcmp(wrapped.mem.xMalloc_signature, xMalloc_signatures[xMalloc_memtraceMalloc_enum], sizeof(wrapped.mem.xMalloc_signature)) == 0) {
		return memtraceMalloc(n);
	}
	else
		if (memcmp(wrapped.mem.xMalloc_signature, xMalloc_signatures[xMalloc_sqlite3MemMalloc_enum], sizeof(wrapped.mem.xMalloc_signature)) == 0) {
			return sqlite3MemMalloc(n);
		}}
void wrMemFree(void *p)            {if (memcmp(wrapped.mem.xFree_signature, xFree_signatures[xFree_memtraceFree_enum], sizeof(wrapped.mem.xFree_signature)) == 0) {
		memtraceFree(p);
	}
	else
		if (memcmp(wrapped.mem.xFree_signature, xFree_signatures[xFree_sqlite3MemFree_enum], sizeof(wrapped.mem.xFree_signature)) == 0) {
			sqlite3MemFree(p);
		}}
void *wrMemRealloc(void *p, int n) {if (memcmp(wrapped.mem.xRealloc_signature, xRealloc_signatures[xRealloc_memtraceRealloc_enum], sizeof(wrapped.mem.xRealloc_signature)) == 0) {
		return memtraceRealloc(p, n);
	}
	else
		if (memcmp(wrapped.mem.xRealloc_signature, xRealloc_signatures[xRealloc_sqlite3MemRealloc_enum], sizeof(wrapped.mem.xRealloc_signature)) == 0) {
			return sqlite3MemRealloc(p, n);
		}}
int wrMemSize(void *p)             {if (memcmp(wrapped.mem.xSize_signature, xSize_signatures[xSize_memtraceSize_enum], sizeof(wrapped.mem.xSize_signature)) == 0) {
		return memtraceSize(p);
	}
	else
		if (memcmp(wrapped.mem.xSize_signature, xSize_signatures[xSize_sqlite3MemSize_enum], sizeof(wrapped.mem.xSize_signature)) == 0) {
			return sqlite3MemSize(p);
		}}
int wrMemRoundup(int n)            {if (memcmp(wrapped.mem.xRoundup_signature, xRoundup_signatures[xRoundup_memtraceRoundup_enum], sizeof(wrapped.mem.xRoundup_signature)) == 0) {
		return memtraceRoundup(n);
	}
	else
		if (memcmp(wrapped.mem.xRoundup_signature, xRoundup_signatures[xRoundup_sqlite3MemRoundup_enum], sizeof(wrapped.mem.xRoundup_signature)) == 0) {
			return sqlite3MemRoundup(n);
		}}


int wrMutexInit(void){
  int rc;
  if( wrapped.mutex_fail ){
    rc = SQLITE_ERROR;
  }else{
    if (memcmp(wrapped.mutex.xMutexInit_signature, xMutexInit_signatures[xMutexInit_checkMutexInit_enum], sizeof(wrapped.mutex.xMutexInit_signature)) == 0) {
      rc = checkMutexInit();
    }
    else
      if (memcmp(wrapped.mutex.xMutexInit_signature, xMutexInit_signatures[xMutexInit_counterMutexInit_enum], sizeof(wrapped.mutex.xMutexInit_signature)) == 0) {
        rc = counterMutexInit();
      }
    else
      if (memcmp(wrapped.mutex.xMutexInit_signature, xMutexInit_signatures[xMutexInit_debugMutexInit_enum], sizeof(wrapped.mutex.xMutexInit_signature)) == 0) {
        rc = debugMutexInit();
      }
    else
      if (memcmp(wrapped.mutex.xMutexInit_signature, xMutexInit_signatures[xMutexInit_noopMutexInit_enum], sizeof(wrapped.mutex.xMutexInit_signature)) == 0) {
        rc = noopMutexInit();
      }
    else
      if (memcmp(wrapped.mutex.xMutexInit_signature, xMutexInit_signatures[xMutexInit_pthreadMutexInit_enum], sizeof(wrapped.mutex.xMutexInit_signature)) == 0) {
        rc = pthreadMutexInit();
      }
    else
      if (memcmp(wrapped.mutex.xMutexInit_signature, xMutexInit_signatures[xMutexInit_winMutexInit_enum], sizeof(wrapped.mutex.xMutexInit_signature)) == 0) {
        rc = winMutexInit();
      }
    else
      if (memcmp(wrapped.mutex.xMutexInit_signature, xMutexInit_signatures[xMutexInit_wrMutexInit_enum], sizeof(wrapped.mutex.xMutexInit_signature)) == 0) {
        rc = wrMutexInit();
      }
  }
  if( rc==SQLITE_OK ){
    wrapped.mutex_init = 1;
  }
  return rc;
}
int wrMutexEnd(void){
  if (memcmp(wrapped.mutex.xMutexEnd_signature, xMutexEnd_signatures[xMutexEnd_checkMutexEnd_enum], sizeof(wrapped.mutex.xMutexEnd_signature)) == 0) {
    checkMutexEnd();
  }
  else
    if (memcmp(wrapped.mutex.xMutexEnd_signature, xMutexEnd_signatures[xMutexEnd_counterMutexEnd_enum], sizeof(wrapped.mutex.xMutexEnd_signature)) == 0) {
      counterMutexEnd();
    }
  else
    if (memcmp(wrapped.mutex.xMutexEnd_signature, xMutexEnd_signatures[xMutexEnd_debugMutexEnd_enum], sizeof(wrapped.mutex.xMutexEnd_signature)) == 0) {
      debugMutexEnd();
    }
  else
    if (memcmp(wrapped.mutex.xMutexEnd_signature, xMutexEnd_signatures[xMutexEnd_noopMutexEnd_enum], sizeof(wrapped.mutex.xMutexEnd_signature)) == 0) {
      noopMutexEnd();
    }
  else
    if (memcmp(wrapped.mutex.xMutexEnd_signature, xMutexEnd_signatures[xMutexEnd_pthreadMutexEnd_enum], sizeof(wrapped.mutex.xMutexEnd_signature)) == 0) {
      pthreadMutexEnd();
    }
  else
    if (memcmp(wrapped.mutex.xMutexEnd_signature, xMutexEnd_signatures[xMutexEnd_winMutexEnd_enum], sizeof(wrapped.mutex.xMutexEnd_signature)) == 0) {
      winMutexEnd();
    }
  else
    if (memcmp(wrapped.mutex.xMutexEnd_signature, xMutexEnd_signatures[xMutexEnd_wrMutexEnd_enum], sizeof(wrapped.mutex.xMutexEnd_signature)) == 0) {
      wrMutexEnd();
    }
  wrapped.mutex_init = 0;
  return SQLITE_OK;
}
sqlite3_mutex *wrMutexAlloc(int e){
  if (memcmp(wrapped.mutex.xMutexAlloc_signature, xMutexAlloc_signatures[xMutexAlloc_checkMutexAlloc_enum], sizeof(wrapped.mutex.xMutexAlloc_signature)) == 0) {
    return checkMutexAlloc(e);
  }
  else
    if (memcmp(wrapped.mutex.xMutexAlloc_signature, xMutexAlloc_signatures[xMutexAlloc_counterMutexAlloc_enum], sizeof(wrapped.mutex.xMutexAlloc_signature)) == 0) {
      return counterMutexAlloc(e);
    }
  else
    if (memcmp(wrapped.mutex.xMutexAlloc_signature, xMutexAlloc_signatures[xMutexAlloc_debugMutexAlloc_enum], sizeof(wrapped.mutex.xMutexAlloc_signature)) == 0) {
      return debugMutexAlloc(e);
    }
  else
    if (memcmp(wrapped.mutex.xMutexAlloc_signature, xMutexAlloc_signatures[xMutexAlloc_noopMutexAlloc_enum], sizeof(wrapped.mutex.xMutexAlloc_signature)) == 0) {
      return noopMutexAlloc(e);
    }
  else
    if (memcmp(wrapped.mutex.xMutexAlloc_signature, xMutexAlloc_signatures[xMutexAlloc_pthreadMutexAlloc_enum], sizeof(wrapped.mutex.xMutexAlloc_signature)) == 0) {
      return pthreadMutexAlloc(e);
    }
  else
    if (memcmp(wrapped.mutex.xMutexAlloc_signature, xMutexAlloc_signatures[xMutexAlloc_winMutexAlloc_enum], sizeof(wrapped.mutex.xMutexAlloc_signature)) == 0) {
      return winMutexAlloc(e);
    }
  else
    if (memcmp(wrapped.mutex.xMutexAlloc_signature, xMutexAlloc_signatures[xMutexAlloc_wrMutexAlloc_enum], sizeof(wrapped.mutex.xMutexAlloc_signature)) == 0) {
      return wrMutexAlloc(e);
    }
}
void wrMutexFree(sqlite3_mutex *p){
  if (memcmp(wrapped.mutex.xMutexFree_signature, xMutexFree_signatures[xMutexFree_checkMutexFree_enum], sizeof(wrapped.mutex.xMutexFree_signature)) == 0) {
    checkMutexFree(p);
  }
  else
    if (memcmp(wrapped.mutex.xMutexFree_signature, xMutexFree_signatures[xMutexFree_counterMutexFree_enum], sizeof(wrapped.mutex.xMutexFree_signature)) == 0) {
      counterMutexFree(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexFree_signature, xMutexFree_signatures[xMutexFree_debugMutexFree_enum], sizeof(wrapped.mutex.xMutexFree_signature)) == 0) {
      debugMutexFree(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexFree_signature, xMutexFree_signatures[xMutexFree_noopMutexFree_enum], sizeof(wrapped.mutex.xMutexFree_signature)) == 0) {
      noopMutexFree(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexFree_signature, xMutexFree_signatures[xMutexFree_pthreadMutexFree_enum], sizeof(wrapped.mutex.xMutexFree_signature)) == 0) {
      pthreadMutexFree(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexFree_signature, xMutexFree_signatures[xMutexFree_winMutexFree_enum], sizeof(wrapped.mutex.xMutexFree_signature)) == 0) {
      winMutexFree(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexFree_signature, xMutexFree_signatures[xMutexFree_wrMutexFree_enum], sizeof(wrapped.mutex.xMutexFree_signature)) == 0) {
      wrMutexFree(p);
    }
}
void wrMutexEnter(sqlite3_mutex *p){
  if (memcmp(wrapped.mutex.xMutexEnter_signature, xMutexEnter_signatures[xMutexEnter_checkMutexEnter_enum], sizeof(wrapped.mutex.xMutexEnter_signature)) == 0) {
    checkMutexEnter(p);
  }
  else
    if (memcmp(wrapped.mutex.xMutexEnter_signature, xMutexEnter_signatures[xMutexEnter_counterMutexEnter_enum], sizeof(wrapped.mutex.xMutexEnter_signature)) == 0) {
      counterMutexEnter(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexEnter_signature, xMutexEnter_signatures[xMutexEnter_debugMutexEnter_enum], sizeof(wrapped.mutex.xMutexEnter_signature)) == 0) {
      debugMutexEnter(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexEnter_signature, xMutexEnter_signatures[xMutexEnter_noopMutexEnter_enum], sizeof(wrapped.mutex.xMutexEnter_signature)) == 0) {
      noopMutexEnter(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexEnter_signature, xMutexEnter_signatures[xMutexEnter_pthreadMutexEnter_enum], sizeof(wrapped.mutex.xMutexEnter_signature)) == 0) {
      pthreadMutexEnter(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexEnter_signature, xMutexEnter_signatures[xMutexEnter_winMutexEnter_enum], sizeof(wrapped.mutex.xMutexEnter_signature)) == 0) {
      winMutexEnter(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexEnter_signature, xMutexEnter_signatures[xMutexEnter_wrMutexEnter_enum], sizeof(wrapped.mutex.xMutexEnter_signature)) == 0) {
      wrMutexEnter(p);
    }
}
int wrMutexTry(sqlite3_mutex *p){
  if (memcmp(wrapped.mutex.xMutexTry_signature, xMutexTry_signatures[xMutexTry_checkMutexTry_enum], sizeof(wrapped.mutex.xMutexTry_signature)) == 0) {
    return checkMutexTry(p);
  }
  else
    if (memcmp(wrapped.mutex.xMutexTry_signature, xMutexTry_signatures[xMutexTry_counterMutexTry_enum], sizeof(wrapped.mutex.xMutexTry_signature)) == 0) {
      return counterMutexTry(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexTry_signature, xMutexTry_signatures[xMutexTry_debugMutexTry_enum], sizeof(wrapped.mutex.xMutexTry_signature)) == 0) {
      return debugMutexTry(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexTry_signature, xMutexTry_signatures[xMutexTry_noopMutexTry_enum], sizeof(wrapped.mutex.xMutexTry_signature)) == 0) {
      return noopMutexTry(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexTry_signature, xMutexTry_signatures[xMutexTry_pthreadMutexTry_enum], sizeof(wrapped.mutex.xMutexTry_signature)) == 0) {
      return pthreadMutexTry(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexTry_signature, xMutexTry_signatures[xMutexTry_winMutexTry_enum], sizeof(wrapped.mutex.xMutexTry_signature)) == 0) {
      return winMutexTry(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexTry_signature, xMutexTry_signatures[xMutexTry_wrMutexTry_enum], sizeof(wrapped.mutex.xMutexTry_signature)) == 0) {
      return wrMutexTry(p);
    }
}
void wrMutexLeave(sqlite3_mutex *p){
  if (memcmp(wrapped.mutex.xMutexLeave_signature, xMutexLeave_signatures[xMutexLeave_checkMutexLeave_enum], sizeof(wrapped.mutex.xMutexLeave_signature)) == 0) {
    checkMutexLeave(p);
  }
  else
    if (memcmp(wrapped.mutex.xMutexLeave_signature, xMutexLeave_signatures[xMutexLeave_counterMutexLeave_enum], sizeof(wrapped.mutex.xMutexLeave_signature)) == 0) {
      counterMutexLeave(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexLeave_signature, xMutexLeave_signatures[xMutexLeave_debugMutexLeave_enum], sizeof(wrapped.mutex.xMutexLeave_signature)) == 0) {
      debugMutexLeave(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexLeave_signature, xMutexLeave_signatures[xMutexLeave_noopMutexLeave_enum], sizeof(wrapped.mutex.xMutexLeave_signature)) == 0) {
      noopMutexLeave(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexLeave_signature, xMutexLeave_signatures[xMutexLeave_pthreadMutexLeave_enum], sizeof(wrapped.mutex.xMutexLeave_signature)) == 0) {
      pthreadMutexLeave(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexLeave_signature, xMutexLeave_signatures[xMutexLeave_winMutexLeave_enum], sizeof(wrapped.mutex.xMutexLeave_signature)) == 0) {
      winMutexLeave(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexLeave_signature, xMutexLeave_signatures[xMutexLeave_wrMutexLeave_enum], sizeof(wrapped.mutex.xMutexLeave_signature)) == 0) {
      wrMutexLeave(p);
    }
}
int wrMutexHeld(sqlite3_mutex *p){
  if (memcmp(wrapped.mutex.xMutexHeld_signature, xMutexHeld_signatures[xMutexHeld_0_enum], sizeof(wrapped.mutex.xMutexHeld_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(wrapped.mutex.xMutexHeld_signature, xMutexHeld_signatures[xMutexHeld_counterMutexHeld_enum], sizeof(wrapped.mutex.xMutexHeld_signature)) == 0) {
      return counterMutexHeld(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexHeld_signature, xMutexHeld_signatures[xMutexHeld_debugMutexHeld_enum], sizeof(wrapped.mutex.xMutexHeld_signature)) == 0) {
      return debugMutexHeld(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexHeld_signature, xMutexHeld_signatures[xMutexHeld_wrMutexHeld_enum], sizeof(wrapped.mutex.xMutexHeld_signature)) == 0) {
      return wrMutexHeld(p);
    }
}
int wrMutexNotheld(sqlite3_mutex *p){
  if (memcmp(wrapped.mutex.xMutexNotheld_signature, xMutexNotheld_signatures[xMutexNotheld_0_enum], sizeof(wrapped.mutex.xMutexNotheld_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(wrapped.mutex.xMutexNotheld_signature, xMutexNotheld_signatures[xMutexNotheld_counterMutexNotheld_enum], sizeof(wrapped.mutex.xMutexNotheld_signature)) == 0) {
      return counterMutexNotheld(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexNotheld_signature, xMutexNotheld_signatures[xMutexNotheld_debugMutexNotheld_enum], sizeof(wrapped.mutex.xMutexNotheld_signature)) == 0) {
      return debugMutexNotheld(p);
    }
  else
    if (memcmp(wrapped.mutex.xMutexNotheld_signature, xMutexNotheld_signatures[xMutexNotheld_wrMutexNotheld_enum], sizeof(wrapped.mutex.xMutexNotheld_signature)) == 0) {
      return wrMutexNotheld(p);
    }
}



int wrPCacheInit(void *pArg){
  int rc;
  if( wrapped.pcache_fail ){
    rc = SQLITE_ERROR;
  }else{
    if (memcmp(wrapped.pcache.xInit_signature, xInit_signatures[xInit_memtraceInit_enum], sizeof(wrapped.pcache.xInit_signature)) == 0) {
      rc = memtraceInit(wrapped.pcache.pArg);
    }
    else
      if (memcmp(wrapped.pcache.xInit_signature, xInit_signatures[xInit_pcache1Init_enum], sizeof(wrapped.pcache.xInit_signature)) == 0) {
        rc = pcache1Init(wrapped.pcache.pArg);
      }
    else
      if (memcmp(wrapped.pcache.xInit_signature, xInit_signatures[xInit_pcachetraceInit_enum], sizeof(wrapped.pcache.xInit_signature)) == 0) {
        rc = pcachetraceInit(wrapped.pcache.pArg);
      }
    else
      if (memcmp(wrapped.pcache.xInit_signature, xInit_signatures[xInit_sqlite3MemInit_enum], sizeof(wrapped.pcache.xInit_signature)) == 0) {
        rc = sqlite3MemInit(wrapped.pcache.pArg);
      }
  }
  if( rc==SQLITE_OK ){
    wrapped.pcache_init = 1;
  }
  return rc;
}
void wrPCacheShutdown(void *pArg){
  if (memcmp(wrapped.pcache.xShutdown_signature, xShutdown_signatures[xShutdown_memtraceShutdown_enum], sizeof(wrapped.pcache.xShutdown_signature)) == 0) {
    memtraceShutdown(wrapped.pcache.pArg);
  }
  else
    if (memcmp(wrapped.pcache.xShutdown_signature, xShutdown_signatures[xShutdown_pcache1Shutdown_enum], sizeof(wrapped.pcache.xShutdown_signature)) == 0) {
      pcache1Shutdown(wrapped.pcache.pArg);
    }
  else
    if (memcmp(wrapped.pcache.xShutdown_signature, xShutdown_signatures[xShutdown_pcachetraceShutdown_enum], sizeof(wrapped.pcache.xShutdown_signature)) == 0) {
      pcachetraceShutdown(wrapped.pcache.pArg);
    }
  else
    if (memcmp(wrapped.pcache.xShutdown_signature, xShutdown_signatures[xShutdown_sqlite3MemShutdown_enum], sizeof(wrapped.pcache.xShutdown_signature)) == 0) {
      sqlite3MemShutdown(wrapped.pcache.pArg);
    }
  wrapped.pcache_init = 0;
}

sqlite3_pcache *wrPCacheCreate(int a, int b, int c){
  if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_0_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_amatchConnect_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return amatchConnect(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_closureConnect_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return closureConnect(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_csvtabCreate_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return csvtabCreate(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_dbpageConnect_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return dbpageConnect(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_echoCreate_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return echoCreate(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_expertConnect_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return expertConnect(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_f5tOrigintextCreate_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return f5tOrigintextCreate(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_f5tTokenizerCreate_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return f5tTokenizerCreate(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_fsConnect_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return fsConnect(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_fsdirConnect_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return fsdirConnect(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_fstreeConnect_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return fstreeConnect(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_fts3CreateMethod_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return fts3CreateMethod(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_fts3auxConnectMethod_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return fts3auxConnectMethod(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_fts3termConnectMethod_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return fts3termConnectMethod(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_fts3tokConnectMethod_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return fts3tokConnectMethod(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_fuzzerConnect_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return fuzzerConnect(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_geopolyCreate_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return geopolyCreate(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_intarrayCreate_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return intarrayCreate(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_pcache1Create_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return pcache1Create(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_pcachetraceCreate_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return pcachetraceCreate(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_porterCreate_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return porterCreate(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_rtreeCreate_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return rtreeCreate(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_schemaCreate_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return schemaCreate(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_simpleCreate_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return simpleCreate(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_spellfix1Create_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return spellfix1Create(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_statConnect_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return statConnect(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_tclConnect_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return tclConnect(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_tclvarConnect_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return tclvarConnect(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_unicodeCreate_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return unicodeCreate(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_unionConnect_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return unionConnect(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_vlogConnect_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return vlogConnect(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_vtablogCreate_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return vtablogCreate(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_wholenumberConnect_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return wholenumberConnect(a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xCreate_signature, xCreate_signatures[xCreate_zipfileConnect_enum], sizeof(wrapped.pcache.xCreate_signature)) == 0) {
      return zipfileConnect(a, b, c);
    }
}  
void wrPCacheCachesize(sqlite3_pcache *p, int n){
  if (memcmp(wrapped.pcache.xCachesize_signature, xCachesize_signatures[xCachesize_pcache1Cachesize_enum], sizeof(wrapped.pcache.xCachesize_signature)) == 0) {
    pcache1Cachesize(p, n);
  }
  else
    if (memcmp(wrapped.pcache.xCachesize_signature, xCachesize_signatures[xCachesize_pcachetraceCachesize_enum], sizeof(wrapped.pcache.xCachesize_signature)) == 0) {
      pcachetraceCachesize(p, n);
    }
}  
int wrPCachePagecount(sqlite3_pcache *p){
  if (memcmp(wrapped.pcache.xPagecount_signature, xPagecount_signatures[xPagecount_pcache1Pagecount_enum], sizeof(wrapped.pcache.xPagecount_signature)) == 0) {
    return pcache1Pagecount(p);
  }
  else
    if (memcmp(wrapped.pcache.xPagecount_signature, xPagecount_signatures[xPagecount_pcachetracePagecount_enum], sizeof(wrapped.pcache.xPagecount_signature)) == 0) {
      return pcachetracePagecount(p);
    }
}  
sqlite3_pcache_page *wrPCacheFetch(sqlite3_pcache *p, unsigned a, int b){
  if (memcmp(wrapped.pcache.xFetch_signature, xFetch_signatures[xFetch_0_enum], sizeof(wrapped.pcache.xFetch_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(wrapped.pcache.xFetch_signature, xFetch_signatures[xFetch_apndFetch_enum], sizeof(wrapped.pcache.xFetch_signature)) == 0) {
      return apndFetch(p, a, b);
    }
  else
    if (memcmp(wrapped.pcache.xFetch_signature, xFetch_signatures[xFetch_memdbFetch_enum], sizeof(wrapped.pcache.xFetch_signature)) == 0) {
      return memdbFetch(p, a, b);
    }
  else
    if (memcmp(wrapped.pcache.xFetch_signature, xFetch_signatures[xFetch_pcache1Fetch_enum], sizeof(wrapped.pcache.xFetch_signature)) == 0) {
      return pcache1Fetch(p, a, b);
    }
  else
    if (memcmp(wrapped.pcache.xFetch_signature, xFetch_signatures[xFetch_pcachetraceFetch_enum], sizeof(wrapped.pcache.xFetch_signature)) == 0) {
      return pcachetraceFetch(p, a, b);
    }
  else
    if (memcmp(wrapped.pcache.xFetch_signature, xFetch_signatures[xFetch_recoverVfsFetch_enum], sizeof(wrapped.pcache.xFetch_signature)) == 0) {
      return recoverVfsFetch(p, a, b);
    }
  else
    if (memcmp(wrapped.pcache.xFetch_signature, xFetch_signatures[xFetch_unixFetch_enum], sizeof(wrapped.pcache.xFetch_signature)) == 0) {
      return unixFetch(p, a, b);
    }
}  
void wrPCacheUnpin(sqlite3_pcache *p, sqlite3_pcache_page *a, int b){
  if (memcmp(wrapped.pcache.xUnpin_signature, xUnpin_signatures[xUnpin_pcache1Unpin_enum], sizeof(wrapped.pcache.xUnpin_signature)) == 0) {
    pcache1Unpin(p, a, b);
  }
  else
    if (memcmp(wrapped.pcache.xUnpin_signature, xUnpin_signatures[xUnpin_pcachetraceUnpin_enum], sizeof(wrapped.pcache.xUnpin_signature)) == 0) {
      pcachetraceUnpin(p, a, b);
    }
}  
void wrPCacheRekey(
  sqlite3_pcache *p, 
  sqlite3_pcache_page *a, 
  unsigned b, 
  unsigned c
){
  if (memcmp(wrapped.pcache.xRekey_signature, xRekey_signatures[xRekey_pcache1Rekey_enum], sizeof(wrapped.pcache.xRekey_signature)) == 0) {
    pcache1Rekey(p, a, b, c);
  }
  else
    if (memcmp(wrapped.pcache.xRekey_signature, xRekey_signatures[xRekey_pcachetraceRekey_enum], sizeof(wrapped.pcache.xRekey_signature)) == 0) {
      pcachetraceRekey(p, a, b, c);
    }
  else
    if (memcmp(wrapped.pcache.xRekey_signature, xRekey_signatures[xRekey_unixRandomness_enum], sizeof(wrapped.pcache.xRekey_signature)) == 0) {
      unixRandomness(p, a, b, c);
    }
}  
void wrPCacheTruncate(sqlite3_pcache *p, unsigned a){
  if (memcmp(wrapped.pcache.xTruncate_signature, xTruncate_signatures[xTruncate_apndTruncate_enum], sizeof(wrapped.pcache.xTruncate_signature)) == 0) {
    apndTruncate(p, a);
  }
  else
    if (memcmp(wrapped.pcache.xTruncate_signature, xTruncate_signatures[xTruncate_memdbTruncate_enum], sizeof(wrapped.pcache.xTruncate_signature)) == 0) {
      memdbTruncate(p, a);
    }
  else
    if (memcmp(wrapped.pcache.xTruncate_signature, xTruncate_signatures[xTruncate_memjrnlTruncate_enum], sizeof(wrapped.pcache.xTruncate_signature)) == 0) {
      memjrnlTruncate(p, a);
    }
  else
    if (memcmp(wrapped.pcache.xTruncate_signature, xTruncate_signatures[xTruncate_pcache1Truncate_enum], sizeof(wrapped.pcache.xTruncate_signature)) == 0) {
      pcache1Truncate(p, a);
    }
  else
    if (memcmp(wrapped.pcache.xTruncate_signature, xTruncate_signatures[xTruncate_pcachetraceTruncate_enum], sizeof(wrapped.pcache.xTruncate_signature)) == 0) {
      pcachetraceTruncate(p, a);
    }
  else
    if (memcmp(wrapped.pcache.xTruncate_signature, xTruncate_signatures[xTruncate_recoverVfsTruncate_enum], sizeof(wrapped.pcache.xTruncate_signature)) == 0) {
      recoverVfsTruncate(p, a);
    }
  else
    if (memcmp(wrapped.pcache.xTruncate_signature, xTruncate_signatures[xTruncate_vfstraceTruncate_enum], sizeof(wrapped.pcache.xTruncate_signature)) == 0) {
      vfstraceTruncate(p, a);
    }
  else
    if (memcmp(wrapped.pcache.xTruncate_signature, xTruncate_signatures[xTruncate_unixTruncate_enum], sizeof(wrapped.pcache.xTruncate_signature)) == 0) {
      unixTruncate(p, a);
    }
}  
void wrPCacheDestroy(sqlite3_pcache *p){
  if (memcmp(wrapped.pcache.xDestroy_signature, xDestroy_signatures[xDestroy_0_enum], sizeof(wrapped.pcache.xDestroy_signature)) == 0) {
    0;
  }
  else
    if (memcmp(wrapped.pcache.xDestroy_signature, xDestroy_signatures[xDestroy_dbpageDisconnect_enum], sizeof(wrapped.pcache.xDestroy_signature)) == 0) {
      dbpageDisconnect(p);
    }
  else
    if (memcmp(wrapped.pcache.xDestroy_signature, xDestroy_signatures[xDestroy_expertDisconnect_enum], sizeof(wrapped.pcache.xDestroy_signature)) == 0) {
      expertDisconnect(p);
    }
  else
    if (memcmp(wrapped.pcache.xDestroy_signature, xDestroy_signatures[xDestroy_fsdirDisconnect_enum], sizeof(wrapped.pcache.xDestroy_signature)) == 0) {
      fsdirDisconnect(p);
    }
  else
    if (memcmp(wrapped.pcache.xDestroy_signature, xDestroy_signatures[xDestroy_fts3DestroyMethod_enum], sizeof(wrapped.pcache.xDestroy_signature)) == 0) {
      fts3DestroyMethod(p);
    }
  else
    if (memcmp(wrapped.pcache.xDestroy_signature, xDestroy_signatures[xDestroy_fts3auxDisconnectMethod_enum], sizeof(wrapped.pcache.xDestroy_signature)) == 0) {
      fts3auxDisconnectMethod(p);
    }
  else
    if (memcmp(wrapped.pcache.xDestroy_signature, xDestroy_signatures[xDestroy_fts3tokDisconnectMethod_enum], sizeof(wrapped.pcache.xDestroy_signature)) == 0) {
      fts3tokDisconnectMethod(p);
    }
  else
    if (memcmp(wrapped.pcache.xDestroy_signature, xDestroy_signatures[xDestroy_pcache1Destroy_enum], sizeof(wrapped.pcache.xDestroy_signature)) == 0) {
      pcache1Destroy(p);
    }
  else
    if (memcmp(wrapped.pcache.xDestroy_signature, xDestroy_signatures[xDestroy_pcachetraceDestroy_enum], sizeof(wrapped.pcache.xDestroy_signature)) == 0) {
      pcachetraceDestroy(p);
    }
  else
    if (memcmp(wrapped.pcache.xDestroy_signature, xDestroy_signatures[xDestroy_porterDestroy_enum], sizeof(wrapped.pcache.xDestroy_signature)) == 0) {
      porterDestroy(p);
    }
  else
    if (memcmp(wrapped.pcache.xDestroy_signature, xDestroy_signatures[xDestroy_rtreeDestroy_enum], sizeof(wrapped.pcache.xDestroy_signature)) == 0) {
      rtreeDestroy(p);
    }
  else
    if (memcmp(wrapped.pcache.xDestroy_signature, xDestroy_signatures[xDestroy_simpleDestroy_enum], sizeof(wrapped.pcache.xDestroy_signature)) == 0) {
      simpleDestroy(p);
    }
  else
    if (memcmp(wrapped.pcache.xDestroy_signature, xDestroy_signatures[xDestroy_statDisconnect_enum], sizeof(wrapped.pcache.xDestroy_signature)) == 0) {
      statDisconnect(p);
    }
  else
    if (memcmp(wrapped.pcache.xDestroy_signature, xDestroy_signatures[xDestroy_unicodeDestroy_enum], sizeof(wrapped.pcache.xDestroy_signature)) == 0) {
      unicodeDestroy(p);
    }
  else
    if (memcmp(wrapped.pcache.xDestroy_signature, xDestroy_signatures[xDestroy_zipfileDisconnect_enum], sizeof(wrapped.pcache.xDestroy_signature)) == 0) {
      zipfileDisconnect(p);
    }
}  

static void installInitWrappers(void){
  sqlite3_mutex_methods mutexmethods = {
    wrMutexInit,  wrMutexEnd,   wrMutexAlloc,
    wrMutexFree,  wrMutexEnter, wrMutexTry,
    wrMutexLeave, wrMutexHeld,  wrMutexNotheld
  ,
  .xMutexInit_signature = xMutexInit_signatures[xMutexInit_wrMutexInit_enum],
  .xMutexEnd_signature = xMutexEnd_signatures[xMutexEnd_wrMutexEnd_enum],
  .xMutexAlloc_signature = xMutexAlloc_signatures[xMutexAlloc_wrMutexAlloc_enum],
  .xMutexFree_signature = xMutexFree_signatures[xMutexFree_wrMutexFree_enum],
  .xMutexEnter_signature = xMutexEnter_signatures[xMutexEnter_wrMutexEnter_enum],
  .xMutexTry_signature = xMutexTry_signatures[xMutexTry_wrMutexTry_enum],
  .xMutexLeave_signature = xMutexLeave_signatures[xMutexLeave_wrMutexLeave_enum],
  .xMutexHeld_signature = xMutexHeld_signatures[xMutexHeld_wrMutexHeld_enum],
  .xMutexNotheld_signature = xMutexNotheld_signatures[xMutexNotheld_wrMutexNotheld_enum]
};
  sqlite3_pcache_methods2 pcachemethods = {
    1, 0,
    wrPCacheInit,      wrPCacheShutdown,  wrPCacheCreate, 
    wrPCacheCachesize, wrPCachePagecount, wrPCacheFetch,
    wrPCacheUnpin,     wrPCacheRekey,     wrPCacheTruncate,  
    wrPCacheDestroy
  ,
  .xInit_signature = xInit_signatures[xInit_wrPCacheInit_enum],
  .xShutdown_signature = xShutdown_signatures[xShutdown_wrPCacheShutdown_enum],
  .xCreate_signature = xCreate_signatures[xCreate_wrPCacheCreate_enum],
  .xCachesize_signature = xCachesize_signatures[xCachesize_wrPCacheCachesize_enum],
  .xPagecount_signature = xPagecount_signatures[xPagecount_wrPCachePagecount_enum],
  .xFetch_signature = xFetch_signatures[xFetch_wrPCacheFetch_enum],
  .xUnpin_signature = xUnpin_signatures[xUnpin_wrPCacheUnpin_enum],
  .xRekey_signature = xRekey_signatures[xRekey_wrPCacheRekey_enum],
  .xTruncate_signature = xTruncate_signatures[xTruncate_wrPCacheTruncate_enum],
  .xDestroy_signature = xDestroy_signatures[xDestroy_wrPCacheDestroy_enum]
};
  sqlite3_mem_methods memmethods = {
    wrMemMalloc,   wrMemFree,    wrMemRealloc,
    wrMemSize,     wrMemRoundup, wrMemInit,
    wrMemShutdown,
    0
  ,
  .xMalloc_signature = xMalloc_signatures[xMalloc_wrMemMalloc_enum],
  .xFree_signature = xFree_signatures[xFree_wrMemFree_enum],
  .xRealloc_signature = xRealloc_signatures[xRealloc_wrMemRealloc_enum],
  .xSize_signature = xSize_signatures[xSize_wrMemSize_enum],
  .xRoundup_signature = xRoundup_signatures[xRoundup_wrMemRoundup_enum],
  .xInit_signature = xInit_signatures[xInit_wrMemInit_enum],
  .xShutdown_signature = xShutdown_signatures[xShutdown_wrMemShutdown_enum]
};

  memset(&wrapped, 0, sizeof(wrapped));

  sqlite3_shutdown();
  sqlite3_config(SQLITE_CONFIG_GETMUTEX, &wrapped.mutex);
  sqlite3_config(SQLITE_CONFIG_GETMALLOC, &wrapped.mem);
  sqlite3_config(SQLITE_CONFIG_GETPCACHE2, &wrapped.pcache);
  sqlite3_config(SQLITE_CONFIG_MUTEX, &mutexmethods);
  sqlite3_config(SQLITE_CONFIG_MALLOC, &memmethods);
  sqlite3_config(SQLITE_CONFIG_PCACHE2, &pcachemethods);
}

static int SQLITE_TCLAPI init_wrapper_install(
  ClientData clientData, /* Unused */
  Tcl_Interp *interp,    /* The TCL interpreter that invoked this command */
  int objc,              /* Number of arguments */
  Tcl_Obj *CONST objv[]  /* Command arguments */
){
  int i;
  installInitWrappers();
  for(i=1; i<objc; i++){
    char *z = Tcl_GetString(objv[i]);
    if( strcmp(z, "mem")==0 ){
      wrapped.mem_fail = 1;
    }else if( strcmp(z, "mutex")==0 ){
      wrapped.mutex_fail = 1;
    }else if( strcmp(z, "pcache")==0 ){
      wrapped.pcache_fail = 1;
    }else{
      Tcl_AppendResult(interp, "Unknown argument: \"", z, "\"", NULL);
      return TCL_ERROR;
    }
  }
  return TCL_OK;
}

static int SQLITE_TCLAPI init_wrapper_uninstall(
  ClientData clientData, /* Unused */
  Tcl_Interp *interp,    /* The TCL interpreter that invoked this command */
  int objc,              /* Number of arguments */
  Tcl_Obj *CONST objv[]  /* Command arguments */
){
  if( objc!=1 ){
    Tcl_WrongNumArgs(interp, 1, objv, "");
    return TCL_ERROR;
  }

  sqlite3_shutdown();
  sqlite3_config(SQLITE_CONFIG_MUTEX, &wrapped.mutex);
  sqlite3_config(SQLITE_CONFIG_MALLOC, &wrapped.mem);
  sqlite3_config(SQLITE_CONFIG_PCACHE2, &wrapped.pcache);
  return TCL_OK;
}

static int SQLITE_TCLAPI init_wrapper_clear(
  ClientData clientData, /* Unused */
  Tcl_Interp *interp,    /* The TCL interpreter that invoked this command */
  int objc,              /* Number of arguments */
  Tcl_Obj *CONST objv[]  /* Command arguments */
){
  if( objc!=1 ){
    Tcl_WrongNumArgs(interp, 1, objv, "");
    return TCL_ERROR;
  }

  wrapped.mem_fail = 0;
  wrapped.mutex_fail = 0;
  wrapped.pcache_fail = 0;
  return TCL_OK;
}

static int SQLITE_TCLAPI init_wrapper_query(
  ClientData clientData, /* Unused */
  Tcl_Interp *interp,    /* The TCL interpreter that invoked this command */
  int objc,              /* Number of arguments */
  Tcl_Obj *CONST objv[]  /* Command arguments */
){
  Tcl_Obj *pRet;

  if( objc!=1 ){
    Tcl_WrongNumArgs(interp, 1, objv, "");
    return TCL_ERROR;
  }

  pRet = Tcl_NewObj();
  if( wrapped.mutex_init ){
    Tcl_ListObjAppendElement(interp, pRet, Tcl_NewStringObj("mutex", -1));
  }
  if( wrapped.mem_init ){
    Tcl_ListObjAppendElement(interp, pRet, Tcl_NewStringObj("mem", -1));
  }
  if( wrapped.pcache_init ){
    Tcl_ListObjAppendElement(interp, pRet, Tcl_NewStringObj("pcache", -1));
  }

  Tcl_SetObjResult(interp, pRet);
  return TCL_OK;
}

int Sqlitetest_init_Init(Tcl_Interp *interp){
  static struct {
     char *zName;
     Tcl_ObjCmdProc *xProc;
  } aObjCmd[] = {
    {"init_wrapper_install",   init_wrapper_install},
    {"init_wrapper_query",     init_wrapper_query  },
    {"init_wrapper_uninstall", init_wrapper_uninstall},
    {"init_wrapper_clear",     init_wrapper_clear}
  };
  int i;

  for(i=0; i<sizeof(aObjCmd)/sizeof(aObjCmd[0]); i++){
    Tcl_CreateObjCommand(interp, aObjCmd[i].zName, aObjCmd[i].xProc, 0, 0);
  }

  return TCL_OK;
}
