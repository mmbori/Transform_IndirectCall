/*
** 2005 November 29
**
** The author disclaims copyright to this source code.  In place of
** a legal notice, here is a blessing:
**
**    May you do good and not evil.
**    May you find forgiveness for yourself and forgive others.
**    May you share freely, never taking more than you give.
**
******************************************************************************
**
** This file contains OS interface code that is common to all
** architectures.
*/
#include "sqliteInt.h"

/*
** If we compile with the SQLITE_TEST macro set, then the following block
** of code will give us the ability to simulate a disk I/O error.  This
** is used for testing the I/O recovery logic.
*/
#if defined(SQLITE_TEST)
int sqlite3_io_error_hit = 0;            /* Total number of I/O Errors */
int sqlite3_io_error_hardhit = 0;        /* Number of non-benign errors */
int sqlite3_io_error_pending = 0;        /* Count down to first I/O error */
int sqlite3_io_error_persist = 0;        /* True if I/O errors persist */
int sqlite3_io_error_benign = 0;         /* True if errors are benign */
int sqlite3_diskfull_pending = 0;
int sqlite3_diskfull = 0;
#endif /* defined(SQLITE_TEST) */

/*
** When testing, also keep a count of the number of open files.
*/
#if defined(SQLITE_TEST)
int sqlite3_open_file_count = 0;
#endif /* defined(SQLITE_TEST) */

/*
** The default SQLite sqlite3_vfs implementations do not allocate
** memory (actually, os_unix.c allocates a small amount of memory
** from within OsOpen()), but some third-party implementations may.
** So we test the effects of a malloc() failing and the sqlite3OsXXX()
** function returning SQLITE_IOERR_NOMEM using the DO_OS_MALLOC_TEST macro.
**
** The following functions are instrumented for malloc() failure
** testing:
**
**     sqlite3OsRead()
**     sqlite3OsWrite()
**     sqlite3OsSync()
**     sqlite3OsFileSize()
**     sqlite3OsLock()
**     sqlite3OsCheckReservedLock()
**     sqlite3OsFileControl()
**     sqlite3OsShmMap()
**     sqlite3OsOpen()
**     sqlite3OsDelete()
**     sqlite3OsAccess()
**     sqlite3OsFullPathname()
**
*/
#if defined(SQLITE_TEST)
int sqlite3_memdebug_vfs_oom_test = 1;
  #define DO_OS_MALLOC_TEST(x)                                       \
  if (sqlite3_memdebug_vfs_oom_test && (!x || !sqlite3JournalIsInMemory(x))) { \
    void *pTstAlloc = sqlite3Malloc(10);                             \
    if (!pTstAlloc) return SQLITE_IOERR_NOMEM_BKPT;                  \
    sqlite3_free(pTstAlloc);                                         \
  }
#else
  #define DO_OS_MALLOC_TEST(x)
#endif

/*
** The following routines are convenience wrappers around methods
** of the sqlite3_file object.  This is mostly just syntactic sugar. All
** of this would be completely automatic if SQLite were coded using
** C++ instead of plain old C.
*/
void sqlite3OsClose(sqlite3_file *pId){
  if( pId->pMethods ){
    // pId->pMethods->xClose(pId);
    if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_apndClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
      apndClose(pId);
    }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_bytecodevtabClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        bytecodevtabClose(pId);
      }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_completionClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        completionClose(pId);
      }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_dbdataClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        dbdataClose(pId);
      }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_dbpageClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        dbpageClose(pId);
      }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_expertClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        expertClose(pId);
      }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_fsdirClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        fsdirClose(pId);
      }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_fts3CloseMethod_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        fts3CloseMethod(pId);
      }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_fts3auxCloseMethod_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        fts3auxCloseMethod(pId);
      }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_fts3tokCloseMethod_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        fts3tokCloseMethod(pId);
      }
      // else
      // if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_fts5CloseMethod_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
      //   fts5CloseMethod(pId);
      // }
      // else
      // if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_fts5VocabCloseMethod_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
      //   fts5VocabCloseMethod(pId);
      // }
      // else
      // if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_fts5structCloseMethod_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
      //   fts5structCloseMethod(pId);
      // }
      // else
      // if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_fts5tokCloseMethod_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
      //   fts5tokCloseMethod(pId);
      // }
      // else
      // if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_jtClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
      //   jtClose(pId);
      // }
      // else
      // if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_kvvfsClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
      //   kvvfsClose(pId);
      // }
      else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_memjrnlClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        memjrnlClose(pId);
      }
      // else
      // if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_icuClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
      //   icuClose(pId);
      // }
      // else
      // if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_rbuVfsClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
      //   rbuVfsClose(pId);
      // }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_jsonEachClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        jsonEachClose(pId);
      }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_memdbClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        memdbClose(pId);
      }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_memjrnlClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        memjrnlClose(pId);
      }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_porterClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        porterClose(pId);
      }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_pragmaVtabClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        pragmaVtabClose(pId);
      }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_recoverVfsClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        recoverVfsClose(pId);
      }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_rtreeClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        rtreeClose(pId);
      }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_seriesClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        seriesClose(pId);
      }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_simpleClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        simpleClose(pId);
      }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_statClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        statClose(pId);
      }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_stmtClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        stmtClose(pId);
      }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_unicodeClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        unicodeClose(pId);
      }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_vfstraceClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        vfstraceClose(pId);
      }
    else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_zipfileClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        zipfileClose(pId);
      }
      else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_unixClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        unixClose(pId);
      }
      else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_nolockClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        nolockClose(pId);
      }
      else
      if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_dotlockClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
        dotlockClose(pId);
      }
      // else
      // if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_flockClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
      //   flockClose(pId);
      // }
      // else
      // if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_semXClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
      //   semXClose(pId);
      // }
      // else
      // if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_afpClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
      //   afpClose(pId);
      // }
      // else
      // if (memcmp(pId->pMethods->xClose_signature, xClose_signatures[xClose_proxyClose_enum], sizeof(pId->pMethods->xClose_signature)) == 0) {
      //   proxyClose(pId);
      // }
  }
  pId->pMethods = 0;
}


int sqlite3OsRead(sqlite3_file *id, void *pBuf, int amt, i64 offset){
  DO_OS_MALLOC_TEST(id);
  if (memcmp(id->pMethods->xRead_signature, xRead_signatures[xRead_apndRead_enum], sizeof(id->pMethods->xRead_signature)) == 0) {
    return apndRead(id, pBuf, amt, offset);
  }
  else
    if (memcmp(id->pMethods->xRead_signature, xRead_signatures[xRead_memdbRead_enum], sizeof(id->pMethods->xRead_signature)) == 0) {
      return memdbRead(id, pBuf, amt, offset);
    }
  else
    if (memcmp(id->pMethods->xRead_signature, xRead_signatures[xRead_memjrnlRead_enum], sizeof(id->pMethods->xRead_signature)) == 0) {
      return memjrnlRead(id, pBuf, amt, offset);
    }
  else
    if (memcmp(id->pMethods->xRead_signature, xRead_signatures[xRead_recoverVfsRead_enum], sizeof(id->pMethods->xRead_signature)) == 0) {
      return recoverVfsRead(id, pBuf, amt, offset);
    }
  else
    if (memcmp(id->pMethods->xRead_signature, xRead_signatures[xRead_vfstraceRead_enum], sizeof(id->pMethods->xRead_signature)) == 0) {
      return vfstraceRead(id, pBuf, amt, offset);
    }
  else
    if (memcmp(id->pMethods->xRead_signature, xRead_signatures[xRead_unixRead_enum], sizeof(id->pMethods->xRead_signature)) == 0) {
      return unixRead(id, pBuf, amt, offset);
    }
}

int sqlite3OsWrite(sqlite3_file *id, const void *pBuf, int amt, i64 offset){
  DO_OS_MALLOC_TEST(id);
  if (memcmp(id->pMethods->xWrite_signature, xWrite_signatures[xWrite_apndWrite_enum], sizeof(id->pMethods->xWrite_signature)) == 0) {
    return apndWrite(id, pBuf, amt, offset);
  }
  // else
  //   if (memcmp(id->pMethods->xWrite_signature, xWrite_signatures[xWrite_kvstorageWrite_enum], sizeof(id->pMethods->xWrite_signature)) == 0) {
  //     return kvstorageWrite(id, pBuf, amt, offset);
  //   }
  else
    if (memcmp(id->pMethods->xWrite_signature, xWrite_signatures[xWrite_memdbWrite_enum], sizeof(id->pMethods->xWrite_signature)) == 0) {
      return memdbWrite(id, pBuf, amt, offset);
    }
  else
    if (memcmp(id->pMethods->xWrite_signature, xWrite_signatures[xWrite_memjrnlWrite_enum], sizeof(id->pMethods->xWrite_signature)) == 0) {
      return memjrnlWrite(id, pBuf, amt, offset);
    }
  else
    if (memcmp(id->pMethods->xWrite_signature, xWrite_signatures[xWrite_recoverVfsWrite_enum], sizeof(id->pMethods->xWrite_signature)) == 0) {
      return recoverVfsWrite(id, pBuf, amt, offset);
    }
  else
    if (memcmp(id->pMethods->xWrite_signature, xWrite_signatures[xWrite_vfstraceWrite_enum], sizeof(id->pMethods->xWrite_signature)) == 0) {
      return vfstraceWrite(id, pBuf, amt, offset);
    }
  else
    if (memcmp(id->pMethods->xWrite_signature, xWrite_signatures[xWrite_unixWrite_enum], sizeof(id->pMethods->xWrite_signature)) == 0) {
      return unixWrite(id, pBuf, amt, offset);
    }
}
int sqlite3OsTruncate(sqlite3_file *id, i64 size){
  if (memcmp(id->pMethods->xTruncate_signature, xTruncate_signatures[xTruncate_apndTruncate_enum], sizeof(id->pMethods->xTruncate_signature)) == 0) {
    return apndTruncate(id, size);
  }
  else
    if (memcmp(id->pMethods->xTruncate_signature, xTruncate_signatures[xTruncate_memdbTruncate_enum], sizeof(id->pMethods->xTruncate_signature)) == 0) {
      return memdbTruncate(id, size);
    }
  else
    if (memcmp(id->pMethods->xTruncate_signature, xTruncate_signatures[xTruncate_memjrnlTruncate_enum], sizeof(id->pMethods->xTruncate_signature)) == 0) {
      return memjrnlTruncate(id, size);
    }
  // else
  //   if (memcmp(id->pMethods->xTruncate_signature, xTruncate_signatures[xTruncate_pcache1Truncate_enum], sizeof(id->pMethods->xTruncate_signature)) == 0) {
  //     return pcache1Truncate(id, size);
  //   }
  // else
  //   if (memcmp(id->pMethods->xTruncate_signature, xTruncate_signatures[xTruncate_pcachetraceTruncate_enum], sizeof(id->pMethods->xTruncate_signature)) == 0) {
  //     return pcachetraceTruncate(id, size);
  //   }
  else
    if (memcmp(id->pMethods->xTruncate_signature, xTruncate_signatures[xTruncate_recoverVfsTruncate_enum], sizeof(id->pMethods->xTruncate_signature)) == 0) {
      return recoverVfsTruncate(id, size);
    }
  else
    if (memcmp(id->pMethods->xTruncate_signature, xTruncate_signatures[xTruncate_vfstraceTruncate_enum], sizeof(id->pMethods->xTruncate_signature)) == 0) {
      return vfstraceTruncate(id, size);
    }
  else
    if (memcmp(id->pMethods->xTruncate_signature, xTruncate_signatures[xTruncate_unixTruncate_enum], sizeof(id->pMethods->xTruncate_signature)) == 0) {
      return unixTruncate(id, size);
    }
}

// ========================= cocci 수정 쉽도록 코드 변경하기 ==============================
// ====================================================================================
int sqlite3OsSync(sqlite3_file *id, int flags){
  DO_OS_MALLOC_TEST(id);
  return flags ? id->pMethods->xSync(id, flags) : SQLITE_OK;
}

int sqlite3OsFileSize(sqlite3_file *id, i64 *pSize){
  DO_OS_MALLOC_TEST(id);
  if (memcmp(id->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_apndFileSize_enum], sizeof(id->pMethods->xFileSize_signature)) == 0) {
    return apndFileSize(id, pSize);
  }
  else
    if (memcmp(id->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_memdbFileSize_enum], sizeof(id->pMethods->xFileSize_signature)) == 0) {
      return memdbFileSize(id, pSize);
    }
  else
    if (memcmp(id->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_memjrnlFileSize_enum], sizeof(id->pMethods->xFileSize_signature)) == 0) {
      return memjrnlFileSize(id, pSize);
    }
  else
    if (memcmp(id->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_recoverVfsFileSize_enum], sizeof(id->pMethods->xFileSize_signature)) == 0) {
      return recoverVfsFileSize(id, pSize);
    }
  else
    if (memcmp(id->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_vfstraceFileSize_enum], sizeof(id->pMethods->xFileSize_signature)) == 0) {
      return vfstraceFileSize(id, pSize);
    }
  else
    if (memcmp(id->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_unixFileSize_enum], sizeof(id->pMethods->xFileSize_signature)) == 0) {
      return unixFileSize(id, pSize);
    }
}

int sqlite3OsLock(sqlite3_file *id, int lockType){
  DO_OS_MALLOC_TEST(id);
  assert( lockType>=SQLITE_LOCK_SHARED && lockType<=SQLITE_LOCK_EXCLUSIVE );
  if (memcmp(id->pMethods->xLock_signature, xLock_signatures[xLock_0_enum], sizeof(id->pMethods->xLock_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(id->pMethods->xLock_signature, xLock_signatures[xLock_apndLock_enum], sizeof(id->pMethods->xLock_signature)) == 0) {
      return apndLock(id, lockType);
    }
  else
    if (memcmp(id->pMethods->xLock_signature, xLock_signatures[xLock_memdbLock_enum], sizeof(id->pMethods->xLock_signature)) == 0) {
      return memdbLock(id, lockType);
    }
  else
    if (memcmp(id->pMethods->xLock_signature, xLock_signatures[xLock_recoverVfsLock_enum], sizeof(id->pMethods->xLock_signature)) == 0) {
      return recoverVfsLock(id, lockType);
    }
  else
    if (memcmp(id->pMethods->xLock_signature, xLock_signatures[xLock_vfstraceLock_enum], sizeof(id->pMethods->xLock_signature)) == 0) {
      return vfstraceLock(id, lockType);
    }
  else
    if (memcmp(id->pMethods->xLock_signature, xLock_signatures[xLock_unixLock_enum], sizeof(id->pMethods->xLock_signature)) == 0) {
      return unixLock(id, lockType);
    }
  else
    if (memcmp(id->pMethods->xLock_signature, xLock_signatures[xLock_nolockLock_enum], sizeof(id->pMethods->xLock_signature)) == 0) {
      return nolockLock(id, lockType);
    }
  else
    if (memcmp(id->pMethods->xLock_signature, xLock_signatures[xLock_dotlockLock_enum], sizeof(id->pMethods->xLock_signature)) == 0) {
      return dotlockLock(id, lockType);
    }
  // else
  //   if (memcmp(id->pMethods->xLock_signature, xLock_signatures[xLock_flockLock_enum], sizeof(id->pMethods->xLock_signature)) == 0) {
  //     return flockLock(id, lockType);
  //   }
  // else
  //   if (memcmp(id->pMethods->xLock_signature, xLock_signatures[xLock_semXLock_enum], sizeof(id->pMethods->xLock_signature)) == 0) {
  //     return semXLock(id, lockType);
  //   }
  // else
  //   if (memcmp(id->pMethods->xLock_signature, xLock_signatures[xLock_afpLock_enum], sizeof(id->pMethods->xLock_signature)) == 0) {
  //     return afpLock(id, lockType);
  //   }
  // else
  //   if (memcmp(id->pMethods->xLock_signature, xLock_signatures[xLock_proxyLock_enum], sizeof(id->pMethods->xLock_signature)) == 0) {
  //     return proxyLock(id, lockType);
  //   }
}

int sqlite3OsUnlock(sqlite3_file *id, int lockType){
  assert( lockType==SQLITE_LOCK_NONE || lockType==SQLITE_LOCK_SHARED );
  if (memcmp(id->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_0_enum], sizeof(id->pMethods->xUnlock_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(id->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_apndUnlock_enum], sizeof(id->pMethods->xUnlock_signature)) == 0) {
      return apndUnlock(id, lockType);
    }
  else
    if (memcmp(id->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_memdbUnlock_enum], sizeof(id->pMethods->xUnlock_signature)) == 0) {
      return memdbUnlock(id, lockType);
    }
  else
    if (memcmp(id->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_recoverVfsUnlock_enum], sizeof(id->pMethods->xUnlock_signature)) == 0) {
      return recoverVfsUnlock(id, lockType);
    }
  else
    if (memcmp(id->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_vfstraceUnlock_enum], sizeof(id->pMethods->xUnlock_signature)) == 0) {
      return vfstraceUnlock(id, lockType);
    }
  else
    if (memcmp(id->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_unixUnlock_enum], sizeof(id->pMethods->xUnlock_signature)) == 0) {
      return unixUnlock(id, lockType);
    }
  else
    if (memcmp(id->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_nolockUnlock_enum], sizeof(id->pMethods->xUnlock_signature)) == 0) {
      return nolockUnlock(id, lockType);
    }
  else
    if (memcmp(id->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_dotlockUnlock_enum], sizeof(id->pMethods->xUnlock_signature)) == 0) {
      return dotlockUnlock(id, lockType);
    }
  // else
  //   if (memcmp(id->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_flockUnlock_enum], sizeof(id->pMethods->xUnlock_signature)) == 0) {
  //     return flockUnlock(id, lockType);
  //   }
  // else
  //   if (memcmp(id->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_semXUnlock_enum], sizeof(id->pMethods->xUnlock_signature)) == 0) {
  //     return semXUnlock(id, lockType);
  //   }
  // else
  //   if (memcmp(id->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_afpUnlock_enum], sizeof(id->pMethods->xUnlock_signature)) == 0) {
  //     return afpUnlock(id, lockType);
  //   }
  // else
  //   if (memcmp(id->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_proxyUnlock_enum], sizeof(id->pMethods->xUnlock_signature)) == 0) {
  //     return proxyUnlock(id, lockType);
  //   }
  // else
  //   if (memcmp(id->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_nfsUnlock_enum], sizeof(id->pMethods->xUnlock_signature)) == 0) {
  //     return nfsUnlock(id, lockType);
  //   }
}

int sqlite3OsCheckReservedLock(sqlite3_file *id, int *pResOut){
  DO_OS_MALLOC_TEST(id);
  if (memcmp(id->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_0_enum], sizeof(id->pMethods->xCheckReservedLock_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(id->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_apndCheckReservedLock_enum], sizeof(id->pMethods->xCheckReservedLock_signature)) == 0) {
      return apndCheckReservedLock(id, pResOut);
    }
  else
    if (memcmp(id->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_recoverVfsCheckReservedLock_enum], sizeof(id->pMethods->xCheckReservedLock_signature)) == 0) {
      return recoverVfsCheckReservedLock(id, pResOut);
    }
  else
    if (memcmp(id->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_vfstraceCheckReservedLock_enum], sizeof(id->pMethods->xCheckReservedLock_signature)) == 0) {
      return vfstraceCheckReservedLock(id, pResOut);
    }
  else
    if (memcmp(id->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_unixCheckReservedLock_enum], sizeof(id->pMethods->xCheckReservedLock_signature)) == 0) {
      return unixCheckReservedLock(id, pResOut);
    }
  else
    if (memcmp(id->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_nolockCheckReservedLock_enum], sizeof(id->pMethods->xCheckReservedLock_signature)) == 0) {
      return nolockCheckReservedLock(id, pResOut);
    }
  else
    if (memcmp(id->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_dotlockCheckReservedLock_enum], sizeof(id->pMethods->xCheckReservedLock_signature)) == 0) {
      return dotlockCheckReservedLock(id, pResOut);
    }
  // else
  //   if (memcmp(id->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_flockCheckReservedLock_enum], sizeof(id->pMethods->xCheckReservedLock_signature)) == 0) {
  //     return flockCheckReservedLock(id, pResOut);
  //   }
  // else
  //   if (memcmp(id->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_semXCheckReservedLock_enum], sizeof(id->pMethods->xCheckReservedLock_signature)) == 0) {
  //     return semXCheckReservedLock(id, pResOut);
  //   }
  // else
  //   if (memcmp(id->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_afpCheckReservedLock_enum], sizeof(id->pMethods->xCheckReservedLock_signature)) == 0) {
  //     return afpCheckReservedLock(id, pResOut);
  //   }
  // else
  //   if (memcmp(id->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_proxyCheckReservedLock_enum], sizeof(id->pMethods->xCheckReservedLock_signature)) == 0) {
  //     return proxyCheckReservedLock(id, pResOut);
  //   }
}

/*
** Use sqlite3OsFileControl() when we are doing something that might fail
** and we need to know about the failures.  Use sqlite3OsFileControlHint()
** when simply tossing information over the wall to the VFS and we do not
** really care if the VFS receives and understands the information since it
** is only a hint and can be safely ignored.  The sqlite3OsFileControlHint()
** routine has no return value since the return value would be meaningless.
*/
int sqlite3OsFileControl(sqlite3_file *id, int op, void *pArg){
  if( id->pMethods==0 ) return SQLITE_NOTFOUND;
#ifdef SQLITE_TEST
  if( op!=SQLITE_FCNTL_COMMIT_PHASETWO
   && op!=SQLITE_FCNTL_LOCK_TIMEOUT
   && op!=SQLITE_FCNTL_CKPT_DONE
   && op!=SQLITE_FCNTL_CKPT_START
  ){
    /* Faults are not injected into COMMIT_PHASETWO because, assuming SQLite
    ** is using a regular VFS, it is called after the corresponding
    ** transaction has been committed. Injecting a fault at this point
    ** confuses the test scripts - the COMMIT command returns SQLITE_NOMEM
    ** but the transaction is committed anyway.
    **
    ** The core must call OsFileControl() though, not OsFileControlHint(),
    ** as if a custom VFS (e.g. zipvfs) returns an error here, it probably
    ** means the commit really has failed and an error should be returned
    ** to the user.
    **
    ** The CKPT_DONE and CKPT_START file-controls are write-only signals
    ** to the cksumvfs.  Their return code is meaningless and is ignored
    ** by the SQLite core, so there is no point in simulating OOMs for them.
    */
    DO_OS_MALLOC_TEST(id);
  }
#endif
  if (memcmp(id->pMethods->xFileControl_signature, xFileControl_signatures[xFileControl_0_enum], sizeof(id->pMethods->xFileControl_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(id->pMethods->xFileControl_signature, xFileControl_signatures[xFileControl_apndFileControl_enum], sizeof(id->pMethods->xFileControl_signature)) == 0) {
      return apndFileControl(id, op, pArg);
    }
  else
    if (memcmp(id->pMethods->xFileControl_signature, xFileControl_signatures[xFileControl_memdbFileControl_enum], sizeof(id->pMethods->xFileControl_signature)) == 0) {
      return memdbFileControl(id, op, pArg);
    }
  else
    if (memcmp(id->pMethods->xFileControl_signature, xFileControl_signatures[xFileControl_recoverVfsFileControl_enum], sizeof(id->pMethods->xFileControl_signature)) == 0) {
      return recoverVfsFileControl(id, op, pArg);
    }
  else
    if (memcmp(id->pMethods->xFileControl_signature, xFileControl_signatures[xFileControl_vfstraceFileControl_enum], sizeof(id->pMethods->xFileControl_signature)) == 0) {
      return vfstraceFileControl(id, op, pArg);
    }
  else
    if (memcmp(id->pMethods->xFileControl_signature, xFileControl_signatures[xFileControl_unixFileControl_enum], sizeof(id->pMethods->xFileControl_signature)) == 0) {
      return unixFileControl(id, op, pArg);
    }
}

// ========================== 내가수정 ============================
// ===============================================================
void sqlite3OsFileControlHint(sqlite3_file *id, int op, void *pArg){
  // if( id->pMethods ) (void)id->pMethods->xFileControl(id, op, pArg);
  if (id->pMethods) {
    if (memcmp(id->pMethods->xFileControl_signature, xFileControl_signatures[xFileControl_0_enum], sizeof(id->pMethods->xFileControl_signature)) == 0) {
      0;
    }
    else
      if (memcmp(id->pMethods->xFileControl_signature, xFileControl_signatures[xFileControl_apndFileControl_enum], sizeof(id->pMethods->xFileControl_signature)) == 0) {
        (void)apndFileControl(id, op, pArg);
      }
    else
      if (memcmp(id->pMethods->xFileControl_signature, xFileControl_signatures[xFileControl_memdbFileControl_enum], sizeof(id->pMethods->xFileControl_signature)) == 0) {
        (void)memdbFileControl(id, op, pArg);
      }
    else
      if (memcmp(id->pMethods->xFileControl_signature, xFileControl_signatures[xFileControl_recoverVfsFileControl_enum], sizeof(id->pMethods->xFileControl_signature)) == 0) {
        (void)recoverVfsFileControl(id, op, pArg);
      }
    else
      if (memcmp(id->pMethods->xFileControl_signature, xFileControl_signatures[xFileControl_vfstraceFileControl_enum], sizeof(id->pMethods->xFileControl_signature)) == 0) {
        (void)vfstraceFileControl(id, op, pArg);
      }
    else
      if (memcmp(id->pMethods->xFileControl_signature, xFileControl_signatures[xFileControl_unixFileControl_enum], sizeof(id->pMethods->xFileControl_signature)) == 0) {
        (void)unixFileControl(id, op, pArg);
      }
  }
}

// ========================= cocci 수정 쉽도록 코드 변경하기 ==============================
// ====================================================================================
int sqlite3OsSectorSize(sqlite3_file *id){
  int (*xSectorSize)(sqlite3_file*) = id->pMethods->xSectorSize;
  return (xSectorSize ? xSectorSize(id) : SQLITE_DEFAULT_SECTOR_SIZE);
}

int sqlite3OsDeviceCharacteristics(sqlite3_file *id){
  if( NEVER(id->pMethods==0) ) return 0;
  if (memcmp(id->pMethods->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_0_enum], sizeof(id->pMethods->xDeviceCharacteristics_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(id->pMethods->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_apndDeviceCharacteristics_enum], sizeof(id->pMethods->xDeviceCharacteristics_signature)) == 0) {
      return apndDeviceCharacteristics(id);
    }
  else
    if (memcmp(id->pMethods->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_memdbDeviceCharacteristics_enum], sizeof(id->pMethods->xDeviceCharacteristics_signature)) == 0) {
      return memdbDeviceCharacteristics(id);
    }
  else
    if (memcmp(id->pMethods->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_recoverVfsDeviceCharacteristics_enum], sizeof(id->pMethods->xDeviceCharacteristics_signature)) == 0) {
      return recoverVfsDeviceCharacteristics(id);
    }
  else
    if (memcmp(id->pMethods->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_vfstraceDeviceCharacteristics_enum], sizeof(id->pMethods->xDeviceCharacteristics_signature)) == 0) {
      return vfstraceDeviceCharacteristics(id);
    }
  else
    if (memcmp(id->pMethods->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_unixDeviceCharacteristics_enum], sizeof(id->pMethods->xDeviceCharacteristics_signature)) == 0) {
      return unixDeviceCharacteristics(id);
    }
}

#ifndef SQLITE_OMIT_WAL
int sqlite3OsShmLock(sqlite3_file *id, int offset, int n, int flags){
  if (memcmp(id->pMethods->xShmLock_signature, xShmLock_signatures[xShmLock_0_enum], sizeof(id->pMethods->xShmLock_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(id->pMethods->xShmLock_signature, xShmLock_signatures[xShmLock_apndShmLock_enum], sizeof(id->pMethods->xShmLock_signature)) == 0) {
      return apndShmLock(id, offset, n, flags);
    }
  else
    if (memcmp(id->pMethods->xShmLock_signature, xShmLock_signatures[xShmLock_recoverVfsShmLock_enum], sizeof(id->pMethods->xShmLock_signature)) == 0) {
      return recoverVfsShmLock(id, offset, n, flags);
    }
  else
    if (memcmp(id->pMethods->xShmLock_signature, xShmLock_signatures[xShmLock_unixShmLock_enum], sizeof(id->pMethods->xShmLock_signature)) == 0) {
      return unixShmLock(id, offset, n, flags);
    }
}
void sqlite3OsShmBarrier(sqlite3_file *id){
  if (memcmp(id->pMethods->xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_0_enum], sizeof(id->pMethods->xShmBarrier_signature)) == 0) {
    0;
  }
  else
    if (memcmp(id->pMethods->xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_apndShmBarrier_enum], sizeof(id->pMethods->xShmBarrier_signature)) == 0) {
      apndShmBarrier(id);
    }
  else
    if (memcmp(id->pMethods->xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_recoverVfsShmBarrier_enum], sizeof(id->pMethods->xShmBarrier_signature)) == 0) {
      recoverVfsShmBarrier(id);
    }
  else
    if (memcmp(id->pMethods->xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_unixShmBarrier_enum], sizeof(id->pMethods->xShmBarrier_signature)) == 0) {
      unixShmBarrier(id);
    }
}
int sqlite3OsShmUnmap(sqlite3_file *id, int deleteFlag){
  if (memcmp(id->pMethods->xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_0_enum], sizeof(id->pMethods->xShmUnmap_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(id->pMethods->xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_apndShmUnmap_enum], sizeof(id->pMethods->xShmUnmap_signature)) == 0) {
      return apndShmUnmap(id, deleteFlag);
    }
  else
    if (memcmp(id->pMethods->xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_recoverVfsShmUnmap_enum], sizeof(id->pMethods->xShmUnmap_signature)) == 0) {
      return recoverVfsShmUnmap(id, deleteFlag);
    }
  else
    if (memcmp(id->pMethods->xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_unixShmUnmap_enum], sizeof(id->pMethods->xShmUnmap_signature)) == 0) {
      return unixShmUnmap(id, deleteFlag);
    }
}
int sqlite3OsShmMap(
  sqlite3_file *id,               /* Database file handle */
  int iPage,
  int pgsz,
  int bExtend,                    /* True to extend file if necessary */
  void volatile **pp              /* OUT: Pointer to mapping */
){
  DO_OS_MALLOC_TEST(id);
  if (memcmp(id->pMethods->xShmMap_signature, xShmMap_signatures[xShmMap_0_enum], sizeof(id->pMethods->xShmMap_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(id->pMethods->xShmMap_signature, xShmMap_signatures[xShmMap_apndShmMap_enum], sizeof(id->pMethods->xShmMap_signature)) == 0) {
      return apndShmMap(id, iPage, pgsz, bExtend, pp);
    }
  else
    if (memcmp(id->pMethods->xShmMap_signature, xShmMap_signatures[xShmMap_recoverVfsShmMap_enum], sizeof(id->pMethods->xShmMap_signature)) == 0) {
      return recoverVfsShmMap(id, iPage, pgsz, bExtend, pp);
    }
  else
    if (memcmp(id->pMethods->xShmMap_signature, xShmMap_signatures[xShmMap_unixShmMap_enum], sizeof(id->pMethods->xShmMap_signature)) == 0) {
      return unixShmMap(id, iPage, pgsz, bExtend, pp);
    }
}
#endif /* SQLITE_OMIT_WAL */

#if SQLITE_MAX_MMAP_SIZE>0
/* The real implementation of xFetch and xUnfetch */
int sqlite3OsFetch(sqlite3_file *id, i64 iOff, int iAmt, void **pp){
  DO_OS_MALLOC_TEST(id);
  if (memcmp(id->pMethods->xFetch_signature, xFetch_signatures[xFetch_0_enum], sizeof(id->pMethods->xFetch_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(id->pMethods->xFetch_signature, xFetch_signatures[xFetch_apndFetch_enum], sizeof(id->pMethods->xFetch_signature)) == 0) {
      return apndFetch(id, iOff, iAmt, pp);
    }
  else
    if (memcmp(id->pMethods->xFetch_signature, xFetch_signatures[xFetch_memdbFetch_enum], sizeof(id->pMethods->xFetch_signature)) == 0) {
      return memdbFetch(id, iOff, iAmt, pp);
    }
  // else
  //   if (memcmp(id->pMethods->xFetch_signature, xFetch_signatures[xFetch_pcache1Fetch_enum], sizeof(id->pMethods->xFetch_signature)) == 0) {
  //     return pcache1Fetch(id, iOff, iAmt, pp);
  //   }
  // else
  //   if (memcmp(id->pMethods->xFetch_signature, xFetch_signatures[xFetch_pcachetraceFetch_enum], sizeof(id->pMethods->xFetch_signature)) == 0) {
  //     return pcachetraceFetch(id, iOff, iAmt, pp);
  //   }
  else
    if (memcmp(id->pMethods->xFetch_signature, xFetch_signatures[xFetch_recoverVfsFetch_enum], sizeof(id->pMethods->xFetch_signature)) == 0) {
      return recoverVfsFetch(id, iOff, iAmt, pp);
    }
  else
    if (memcmp(id->pMethods->xFetch_signature, xFetch_signatures[xFetch_unixFetch_enum], sizeof(id->pMethods->xFetch_signature)) == 0) {
      return unixFetch(id, iOff, iAmt, pp);
    }
}
int sqlite3OsUnfetch(sqlite3_file *id, i64 iOff, void *p){
  if (memcmp(id->pMethods->xUnfetch_signature, xUnfetch_signatures[xUnfetch_0_enum], sizeof(id->pMethods->xUnfetch_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(id->pMethods->xUnfetch_signature, xUnfetch_signatures[xUnfetch_apndUnfetch_enum], sizeof(id->pMethods->xUnfetch_signature)) == 0) {
      return apndUnfetch(id, iOff, p);
    }
  else
    if (memcmp(id->pMethods->xUnfetch_signature, xUnfetch_signatures[xUnfetch_memdbUnfetch_enum], sizeof(id->pMethods->xUnfetch_signature)) == 0) {
      return memdbUnfetch(id, iOff, p);
    }
  else
    if (memcmp(id->pMethods->xUnfetch_signature, xUnfetch_signatures[xUnfetch_recoverVfsUnfetch_enum], sizeof(id->pMethods->xUnfetch_signature)) == 0) {
      return recoverVfsUnfetch(id, iOff, p);
    }
  else
    if (memcmp(id->pMethods->xUnfetch_signature, xUnfetch_signatures[xUnfetch_unixUnfetch_enum], sizeof(id->pMethods->xUnfetch_signature)) == 0) {
      return unixUnfetch(id, iOff, p);
    }
}
#else
/* No-op stubs to use when memory-mapped I/O is disabled */
int sqlite3OsFetch(sqlite3_file *id, i64 iOff, int iAmt, void **pp){
  *pp = 0;
  return SQLITE_OK;
}
int sqlite3OsUnfetch(sqlite3_file *id, i64 iOff, void *p){
  return SQLITE_OK;
}
#endif

/*
** The next group of routines are convenience wrappers around the
** VFS methods.
*/
int sqlite3OsOpen(
  sqlite3_vfs *pVfs,
  const char *zPath,
  sqlite3_file *pFile,
  int flags,
  int *pFlagsOut
){
  int rc;
  DO_OS_MALLOC_TEST(0);
  /* 0x87f7f is a mask of SQLITE_OPEN_ flags that are valid to be passed
  ** down into the VFS layer.  Some SQLITE_OPEN_ flags (for example,
  ** SQLITE_OPEN_FULLMUTEX or SQLITE_OPEN_SHAREDCACHE) are blocked before
  ** reaching the VFS. */
  assert( zPath || (flags & SQLITE_OPEN_EXCLUSIVE) );
  // rc = pVfs->xOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);

  // printf("\nxOpen signature : %d %d %d %d\n", pVfs->xOpen_signature[0], pVfs->xOpen_signature[1], pVfs->xOpen_signature[2], pVfs->xOpen_signature[3]);

  // if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_amatchOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //   rc = amatchOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_apndOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
      rc = apndOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
      printf("\n apndOpen\n");
  }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_binfoOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = binfoOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_bytecodevtabOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = bytecodevtabOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_carrayOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = carrayOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_cfOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = cfOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_cidxOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  // //     rc = cidxOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_cksmOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = cksmOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_closureOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = closureOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_completionOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = completionOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_csvtabOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = csvtabOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_dbdataOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = dbdataOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_dbpageOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = dbpageOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_deltaparsevtabOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = deltaparsevtabOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_demoOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = demoOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_devsymOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = devsymOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_echoOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = echoOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_expertOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = expertOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_explainOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = explainOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_fsOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = fsOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_fsdirOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = fsdirOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_fstreeOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = fstreeOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_fts3OpenMethod_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = fts3OpenMethod(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_fts3auxOpenMethod_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = fts3auxOpenMethod(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_fts3termOpenMethod_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = fts3termOpenMethod(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_fts3tokOpenMethod_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = fts3tokOpenMethod(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_fts5OpenMethod_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = fts5OpenMethod(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_fts5VocabOpenMethod_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = fts5VocabOpenMethod(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_fts5structOpenMethod_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = fts5structOpenMethod(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_fts5tokOpenMethod_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = fts5tokOpenMethod(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_fuzzerOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = fuzzerOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_icuOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = icuOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_intarrayOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = intarrayOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = jsonEachOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpenEach_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = jsonEachOpenEach(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpenTree_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = jsonEachOpenTree(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_jtOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = jtOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_kvvfsOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = kvvfsOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_memOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = memOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_memdbOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
      rc = memdbOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
      printf("\n memdbOpen\n");
  }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_memstatOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = memstatOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_multiplexOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = multiplexOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_porterOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = porterOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_pragmaVtabOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = pragmaVtabOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_prefixesOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = prefixesOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_qpvtabOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = qpvtabOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_quotaOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = quotaOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_rbuVfsOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = rbuVfsOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_rtreeOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = rtreeOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_schemaOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = schemaOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_seriesOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = seriesOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_simpleOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = simpleOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_spellfix1Open_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = spellfix1Open(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_statOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = statOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_stmtOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = stmtOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_tclOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = tclOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_tclvarOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = tclvarOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_templatevtabOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = templatevtabOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_testTokenizerOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = testTokenizerOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_tvfsOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = tvfsOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_unicodeOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = unicodeOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_unionOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = unionOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_vfslogOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = vfslogOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_vfstraceOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = vfstraceOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  //     printf("\n vfstraceOpen\n");
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_vlogOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = vlogOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_vstattabOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = vstattabOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_vtablogOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = vtablogOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_wholenumberOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = wholenumberOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_winOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = winOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_writecrashOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = writecrashOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  // else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_zipfileOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
  //     rc = zipfileOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  // }
  else if (memcmp(pVfs->xOpen_signature, xOpen_signatures[xOpen_unixOpen_enum], sizeof(pVfs->xOpen_signature)) == 0) {
      rc = unixOpen(pVfs, zPath, pFile, flags & 0x1087f7f, pFlagsOut);
  }
  else {
      // Default case: signature not matched
      rc = SQLITE_ERROR;
      printf("\n SQLITE_ERROR\n");
  }


  assert( rc==SQLITE_OK || pFile->pMethods==0 );
  return rc;
}

// ========================= cocci 수정 쉽도록 코드 변경하기 ==============================
// ====================================================================================
int sqlite3OsDelete(sqlite3_vfs *pVfs, const char *zPath, int dirSync){
  DO_OS_MALLOC_TEST(0);
  assert( dirSync==0 || dirSync==1 );
  return pVfs->xDelete!=0 ? pVfs->xDelete(pVfs, zPath, dirSync) : SQLITE_OK;
}

// =========================== 얘가 문제였음 !!!! ======================================
// ===================================================================================
int sqlite3OsAccess(
  sqlite3_vfs *pVfs,
  const char *zPath,
  int flags,
  int *pResOut
){
  DO_OS_MALLOC_TEST(0);
  if (memcmp(pVfs->xAccess_signature, xAccess_signatures[xAccess_apndAccess_enum], sizeof(pVfs->xAccess_signature)) == 0) {
    return apndAccess(pVfs, zPath, flags, pResOut);
  }
  else
    if (memcmp(pVfs->xAccess_signature, xAccess_signatures[xAccess_memdbAccess_enum], sizeof(pVfs->xAccess_signature)) == 0) {
      return memdbAccess(pVfs, zPath, flags, pResOut);
    }
  else
    if (memcmp(pVfs->xAccess_signature, xAccess_signatures[xAccess_vfstraceAccess_enum], sizeof(pVfs->xAccess_signature)) == 0) {
      return vfstraceAccess(pVfs, zPath, flags, pResOut);
    }
  // else
  //   if (memcmp(pVfs->xAccess_signature, xAccess_signatures[xAccess_unixDelete_enum], sizeof(pVfs->xAccess_signature)) == 0) {
  //     return unixDelete(pVfs, zPath, flags, pResOut);
  //   }
}

// =========================== 얘가 문제였음 !!!! ======================================
// ===================================================================================
int sqlite3OsFullPathname(
  sqlite3_vfs *pVfs,
  const char *zPath,
  int nPathOut,
  char *zPathOut
){
  DO_OS_MALLOC_TEST(0);
  zPathOut[0] = 0;
  if (memcmp(pVfs->xFullPathname_signature, xFullPathname_signatures[xFullPathname_apndFullPathname_enum], sizeof(pVfs->xFullPathname_signature)) == 0) {
    return apndFullPathname(pVfs, zPath, nPathOut, zPathOut);
  }
  else
    if (memcmp(pVfs->xFullPathname_signature, xFullPathname_signatures[xFullPathname_memdbFullPathname_enum], sizeof(pVfs->xFullPathname_signature)) == 0) {
      return memdbFullPathname(pVfs, zPath, nPathOut, zPathOut);
    }
  else
    if (memcmp(pVfs->xFullPathname_signature, xFullPathname_signatures[xFullPathname_vfstraceFullPathname_enum], sizeof(pVfs->xFullPathname_signature)) == 0) {
      return vfstraceFullPathname(pVfs, zPath, nPathOut, zPathOut);
    }
  else
    if (memcmp(pVfs->xFullPathname_signature, xFullPathname_signatures[xFullPathname_unixFullPathname_enum], sizeof(pVfs->xFullPathname_signature)) == 0) {
      return unixFullPathname(pVfs, zPath, nPathOut, zPathOut);
    }
}

#ifndef SQLITE_OMIT_LOAD_EXTENSION
void *sqlite3OsDlOpen(sqlite3_vfs *pVfs, const char *zPath){
  assert( zPath!=0 );
  assert( strlen(zPath)<=SQLITE_MAX_PATHLEN );  /* tag-20210611-1 */
  if (memcmp(pVfs->xDlOpen_signature, xDlOpen_signatures[xDlOpen_apndDlOpen_enum], sizeof(pVfs->xDlOpen_signature)) == 0) {
    return apndDlOpen(pVfs, zPath);
  }
  else
    if (memcmp(pVfs->xDlOpen_signature, xDlOpen_signatures[xDlOpen_memdbDlOpen_enum], sizeof(pVfs->xDlOpen_signature)) == 0) {
      return memdbDlOpen(pVfs, zPath);
    }
  else
    if (memcmp(pVfs->xDlOpen_signature, xDlOpen_signatures[xDlOpen_unixDlOpen_enum], sizeof(pVfs->xDlOpen_signature)) == 0) {
      return unixDlOpen(pVfs, zPath);
    }
}
void sqlite3OsDlError(sqlite3_vfs *pVfs, int nByte, char *zBufOut){
  if (memcmp(pVfs->xDlError_signature, xDlError_signatures[xDlError_0_enum], sizeof(pVfs->xDlError_signature)) == 0) {
    0;
  }
  else
    if (memcmp(pVfs->xDlError_signature, xDlError_signatures[xDlError_apndDlError_enum], sizeof(pVfs->xDlError_signature)) == 0) {
      apndDlError(pVfs, nByte, zBufOut);
    }
  else
    if (memcmp(pVfs->xDlError_signature, xDlError_signatures[xDlError_memdbDlError_enum], sizeof(pVfs->xDlError_signature)) == 0) {
      memdbDlError(pVfs, nByte, zBufOut);
    }
  else
    if (memcmp(pVfs->xDlError_signature, xDlError_signatures[xDlError_unixDlError_enum], sizeof(pVfs->xDlError_signature)) == 0) {
      unixDlError(pVfs, nByte, zBufOut);
    }
}
void (*sqlite3OsDlSym(sqlite3_vfs *pVfs, void *pHdle, const char *zSym))(void){
  return pVfs->xDlSym(pVfs, pHdle, zSym);
}
void sqlite3OsDlClose(sqlite3_vfs *pVfs, void *pHandle){
  if (memcmp(pVfs->xDlClose_signature, xDlClose_signatures[xDlClose_0_enum], sizeof(pVfs->xDlClose_signature)) == 0) {
    0;
  }
  else
    if (memcmp(pVfs->xDlClose_signature, xDlClose_signatures[xDlClose_apndDlClose_enum], sizeof(pVfs->xDlClose_signature)) == 0) {
      apndDlClose(pVfs, pHandle);
    }
  else
    if (memcmp(pVfs->xDlClose_signature, xDlClose_signatures[xDlClose_memdbDlClose_enum], sizeof(pVfs->xDlClose_signature)) == 0) {
      memdbDlClose(pVfs, pHandle);
    }
  else
    if (memcmp(pVfs->xDlClose_signature, xDlClose_signatures[xDlClose_unixDlClose_enum], sizeof(pVfs->xDlClose_signature)) == 0) {
      unixDlClose(pVfs, pHandle);
    }
}
#endif /* SQLITE_OMIT_LOAD_EXTENSION */

// =========================== 얘가 문제였음 !!!! ======================================
// ===================================================================================
int sqlite3OsRandomness(sqlite3_vfs *pVfs, int nByte, char *zBufOut){
  if( sqlite3Config.iPrngSeed ){
    memset(zBufOut, 0, nByte);
    if( ALWAYS(nByte>(signed)sizeof(unsigned)) ) nByte = sizeof(unsigned int);
    memcpy(zBufOut, &sqlite3Config.iPrngSeed, nByte);
    return SQLITE_OK;
  }else{
    if (memcmp(pVfs->xRandomness_signature, xRandomness_signatures[xRandomness_apndRandomness_enum], sizeof(pVfs->xRandomness_signature)) == 0) {
      return apndRandomness(pVfs, nByte, zBufOut);
    }
    else
      if (memcmp(pVfs->xRandomness_signature, xRandomness_signatures[xRandomness_memdbRandomness_enum], sizeof(pVfs->xRandomness_signature)) == 0) {
        return memdbRandomness(pVfs, nByte, zBufOut);
      }
    else
      if (memcmp(pVfs->xRandomness_signature, xRandomness_signatures[xRandomness_vfstraceRandomness_enum], sizeof(pVfs->xRandomness_signature)) == 0) {
        return vfstraceRandomness(pVfs, nByte, zBufOut);
      }
    else
      if (memcmp(pVfs->xRandomness_signature, xRandomness_signatures[xRandomness_unixRandomness_enum], sizeof(pVfs->xRandomness_signature)) == 0) {
        return unixRandomness(pVfs, nByte, zBufOut);
      }
  }
}

int sqlite3OsSleep(sqlite3_vfs *pVfs, int nMicro){
  if (memcmp(pVfs->xSleep_signature, xSleep_signatures[xSleep_0_enum], sizeof(pVfs->xSleep_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pVfs->xSleep_signature, xSleep_signatures[xSleep_apndSleep_enum], sizeof(pVfs->xSleep_signature)) == 0) {
      return apndSleep(pVfs, nMicro);
    }
  else
    if (memcmp(pVfs->xSleep_signature, xSleep_signatures[xSleep_memdbSleep_enum], sizeof(pVfs->xSleep_signature)) == 0) {
      return memdbSleep(pVfs, nMicro);
    }
  else
    if (memcmp(pVfs->xSleep_signature, xSleep_signatures[xSleep_vfstraceSleep_enum], sizeof(pVfs->xSleep_signature)) == 0) {
      return vfstraceSleep(pVfs, nMicro);
    }
  else
    if (memcmp(pVfs->xSleep_signature, xSleep_signatures[xSleep_unixSleep_enum], sizeof(pVfs->xSleep_signature)) == 0) {
      return unixSleep(pVfs, nMicro);
    }
}

// ========================= cocci 수정 쉽도록 코드 변경하기 ==============================
// ====================================================================================
int sqlite3OsGetLastError(sqlite3_vfs *pVfs){
  return pVfs->xGetLastError ? pVfs->xGetLastError(pVfs, 0, 0) : 0;
}

// =========================== 얘가 문제였음 !!!! ======================================
// ===================================================================================
int sqlite3OsCurrentTimeInt64(sqlite3_vfs *pVfs, sqlite3_int64 *pTimeOut){
  int rc;
  /* IMPLEMENTATION-OF: R-49045-42493 SQLite will use the xCurrentTimeInt64()
  ** method to get the current date and time if that method is available
  ** (if iVersion is 2 or greater and the function pointer is not NULL) and
  ** will fall back to xCurrentTime() if xCurrentTimeInt64() is
  ** unavailable.
  */
  if( pVfs->iVersion>=2 && pVfs->xCurrentTimeInt64 ){
    if (memcmp(pVfs->xCurrentTimeInt64_signature, xCurrentTimeInt64_signatures[xCurrentTimeInt64_0_enum], sizeof(pVfs->xCurrentTimeInt64_signature)) == 0) {
      rc = 0;
    }
    else
      if (memcmp(pVfs->xCurrentTimeInt64_signature, xCurrentTimeInt64_signatures[xCurrentTimeInt64_apndCurrentTimeInt64_enum], sizeof(pVfs->xCurrentTimeInt64_signature)) == 0) {
        rc = apndCurrentTimeInt64(pVfs, pTimeOut);
      }
    else
      if (memcmp(pVfs->xCurrentTimeInt64_signature, xCurrentTimeInt64_signatures[xCurrentTimeInt64_memdbCurrentTimeInt64_enum], sizeof(pVfs->xCurrentTimeInt64_signature)) == 0) {
        rc = memdbCurrentTimeInt64(pVfs, pTimeOut);
      }
    else
      if (memcmp(pVfs->xCurrentTimeInt64_signature, xCurrentTimeInt64_signatures[xCurrentTimeInt64_unixCurrentTimeInt64_enum], sizeof(pVfs->xCurrentTimeInt64_signature)) == 0) {
        rc = unixCurrentTimeInt64(pVfs, pTimeOut);
      }
  }else{
    double r;
    if (memcmp(pVfs->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_0_enum], sizeof(pVfs->xCurrentTime_signature)) == 0) {
      rc = 0;
    }
    else
      if (memcmp(pVfs->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_apndCurrentTime_enum], sizeof(pVfs->xCurrentTime_signature)) == 0) {
        rc = apndCurrentTime(pVfs, &r);
      }
    else
      if (memcmp(pVfs->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_vfstraceCurrentTime_enum], sizeof(pVfs->xCurrentTime_signature)) == 0) {
        rc = vfstraceCurrentTime(pVfs, &r);
      }
    else
      if (memcmp(pVfs->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_unixCurrentTime_enum], sizeof(pVfs->xCurrentTime_signature)) == 0) {
        rc = unixCurrentTime(pVfs, &r);
      }
    *pTimeOut = (sqlite3_int64)(r*86400000.0);
  }
  return rc;
}

int sqlite3OsOpenMalloc(
  sqlite3_vfs *pVfs,
  const char *zFile,
  sqlite3_file **ppFile,
  int flags,
  int *pOutFlags
){
  int rc;
  sqlite3_file *pFile;
  pFile = (sqlite3_file *)sqlite3MallocZero(pVfs->szOsFile);
  if( pFile ){
    rc = sqlite3OsOpen(pVfs, zFile, pFile, flags, pOutFlags);
    if( rc!=SQLITE_OK ){
      sqlite3_free(pFile);
      *ppFile = 0;
    }else{
      *ppFile = pFile;
    }
  }else{
    *ppFile = 0;
    rc = SQLITE_NOMEM_BKPT;
  }
  assert( *ppFile!=0 || rc!=SQLITE_OK );
  return rc;
}
void sqlite3OsCloseFree(sqlite3_file *pFile){
  assert( pFile );
  sqlite3OsClose(pFile);
  sqlite3_free(pFile);
}

/*
** This function is a wrapper around the OS specific implementation of
** sqlite3_os_init(). The purpose of the wrapper is to provide the
** ability to simulate a malloc failure, so that the handling of an
** error in sqlite3_os_init() by the upper layers can be tested.
*/
int sqlite3OsInit(void){
  void *p = sqlite3_malloc(10);
  if( p==0 ) return SQLITE_NOMEM_BKPT;
  sqlite3_free(p);
  return sqlite3_os_init();
}

/*
** The list of all registered VFS implementations.
*/
static sqlite3_vfs * SQLITE_WSD vfsList = 0;
#define vfsList GLOBAL(sqlite3_vfs *, vfsList)

/*
** Locate a VFS by name.  If no name is given, simply return the
** first VFS on the list.
*/
sqlite3_vfs *sqlite3_vfs_find(const char *zVfs){
  sqlite3_vfs *pVfs = 0;
#if SQLITE_THREADSAFE
  sqlite3_mutex *mutex;
#endif
#ifndef SQLITE_OMIT_AUTOINIT
  int rc = sqlite3_initialize();
  if( rc ) return 0;
#endif
#if SQLITE_THREADSAFE
  mutex = sqlite3MutexAlloc(SQLITE_MUTEX_STATIC_MAIN);
#endif
  sqlite3_mutex_enter(mutex);
  for(pVfs = vfsList; pVfs; pVfs=pVfs->pNext){
    if( zVfs==0 ) break;
    if( strcmp(zVfs, pVfs->zName)==0 ) break;
  }
  sqlite3_mutex_leave(mutex);
  return pVfs;
}

/*
** Unlink a VFS from the linked list
*/
static void vfsUnlink(sqlite3_vfs *pVfs){
  assert( sqlite3_mutex_held(sqlite3MutexAlloc(SQLITE_MUTEX_STATIC_MAIN)) );
  if( pVfs==0 ){
    /* No-op */
  }else if( vfsList==pVfs ){
    vfsList = pVfs->pNext;
  }else if( vfsList ){
    sqlite3_vfs *p = vfsList;
    while( p->pNext && p->pNext!=pVfs ){
      p = p->pNext;
    }
    if( p->pNext==pVfs ){
      p->pNext = pVfs->pNext;
    }
  }
}

/*
** Register a VFS with the system.  It is harmless to register the same
** VFS multiple times.  The new VFS becomes the default if makeDflt is
** true.
*/
int sqlite3_vfs_register(sqlite3_vfs *pVfs, int makeDflt){
  MUTEX_LOGIC(sqlite3_mutex *mutex;)
#ifndef SQLITE_OMIT_AUTOINIT
  int rc = sqlite3_initialize();
  if( rc ) return rc;
#endif
#ifdef SQLITE_ENABLE_API_ARMOR
  if( pVfs==0 ) return SQLITE_MISUSE_BKPT;
#endif

  MUTEX_LOGIC( mutex = sqlite3MutexAlloc(SQLITE_MUTEX_STATIC_MAIN); )
  sqlite3_mutex_enter(mutex);
  vfsUnlink(pVfs);
  if( makeDflt || vfsList==0 ){
    pVfs->pNext = vfsList;
    vfsList = pVfs;
  }else{
    pVfs->pNext = vfsList->pNext;
    vfsList->pNext = pVfs;
  }
  assert(vfsList);
  sqlite3_mutex_leave(mutex);
  return SQLITE_OK;
}

/*
** Unregister a VFS so that it is no longer accessible.
*/
int sqlite3_vfs_unregister(sqlite3_vfs *pVfs){
  MUTEX_LOGIC(sqlite3_mutex *mutex;)
#ifndef SQLITE_OMIT_AUTOINIT
  int rc = sqlite3_initialize();
  if( rc ) return rc;
#endif
  MUTEX_LOGIC( mutex = sqlite3MutexAlloc(SQLITE_MUTEX_STATIC_MAIN); )
  sqlite3_mutex_enter(mutex);
  vfsUnlink(pVfs);
  sqlite3_mutex_leave(mutex);
  return SQLITE_OK;
}
