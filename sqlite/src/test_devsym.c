/*
** 2008 Jan 22
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
** This file contains code that modified the OS layer in order to simulate
** different device types (by overriding the return values of the 
** xDeviceCharacteristics() and xSectorSize() methods).
*/
#if SQLITE_TEST          /* This file is used for testing only */

#include "sqlite3.h"
#include "sqliteInt.h"

/*
** Maximum pathname length supported by the devsym backend.
*/
#define DEVSYM_MAX_PATHNAME 512

/*
** Name used to identify this VFS.
*/
#define DEVSYM_VFS_NAME "devsym"
#define WRITECRASH_NAME "writecrash"

typedef struct devsym_file devsym_file;
struct devsym_file {
  sqlite3_file base;
  sqlite3_file *pReal;
};

/*
** Method declarations for devsym_file.
*/
int devsymClose(sqlite3_file*);
int devsymRead(sqlite3_file*, void*, int iAmt, sqlite3_int64 iOfst);
int devsymWrite(sqlite3_file*,const void*,int iAmt, sqlite3_int64 iOfst);
int devsymTruncate(sqlite3_file*, sqlite3_int64 size);
int devsymSync(sqlite3_file*, int flags);
int devsymFileSize(sqlite3_file*, sqlite3_int64 *pSize);
int devsymLock(sqlite3_file*, int);
int devsymUnlock(sqlite3_file*, int);
int devsymCheckReservedLock(sqlite3_file*, int *);
int devsymFileControl(sqlite3_file*, int op, void *pArg);
int devsymSectorSize(sqlite3_file*);
int devsymDeviceCharacteristics(sqlite3_file*);
int devsymShmLock(sqlite3_file*,int,int,int);
int devsymShmMap(sqlite3_file*,int,int,int, void volatile **);
void devsymShmBarrier(sqlite3_file*);
int devsymShmUnmap(sqlite3_file*,int);

/*
** Method declarations for devsym_vfs.
*/
int devsymOpen(sqlite3_vfs*, const char *, sqlite3_file*, int , int *);
int devsymDelete(sqlite3_vfs*, const char *zName, int syncDir);
int devsymAccess(sqlite3_vfs*, const char *zName, int flags, int *);
int devsymFullPathname(sqlite3_vfs*, const char *zName, int, char *zOut);
#ifndef SQLITE_OMIT_LOAD_EXTENSION
static void *devsymDlOpen(sqlite3_vfs*, const char *zFilename);
void devsymDlError(sqlite3_vfs*, int nByte, char *zErrMsg);
void (*devsymDlSym(sqlite3_vfs*,void*, const char *zSymbol))(void);
void devsymDlClose(sqlite3_vfs*, void*);
#endif /* SQLITE_OMIT_LOAD_EXTENSION */
static int devsymRandomness(sqlite3_vfs*, int nByte, char *zOut);
int devsymSleep(sqlite3_vfs*, int microseconds);
int devsymCurrentTime(sqlite3_vfs*, double*);

struct DevsymGlobal {
  sqlite3_vfs *pVfs;
  int iDeviceChar;
  int iSectorSize;
  int nWriteCrash;
};
struct DevsymGlobal g = {0, 0, 512, 0};

/*
** Close an devsym-file.
*/
int devsymClose(sqlite3_file *pFile){
  devsym_file *p = (devsym_file *)pFile;
  sqlite3OsClose(p->pReal);
  return SQLITE_OK;
}

/*
** Read data from an devsym-file.
*/
int devsymRead(
  sqlite3_file *pFile, 
  void *zBuf, 
  int iAmt, 
  sqlite_int64 iOfst
){
  devsym_file *p = (devsym_file *)pFile;
  return sqlite3OsRead(p->pReal, zBuf, iAmt, iOfst);
}

/*
** Write data to an devsym-file.
*/
int devsymWrite(
  sqlite3_file *pFile, 
  const void *zBuf, 
  int iAmt, 
  sqlite_int64 iOfst
){
  devsym_file *p = (devsym_file *)pFile;
  return sqlite3OsWrite(p->pReal, zBuf, iAmt, iOfst);
}

/*
** Truncate an devsym-file.
*/
int devsymTruncate(sqlite3_file *pFile, sqlite_int64 size){
  devsym_file *p = (devsym_file *)pFile;
  return sqlite3OsTruncate(p->pReal, size);
}

/*
** Sync an devsym-file.
*/
int devsymSync(sqlite3_file *pFile, int flags){
  devsym_file *p = (devsym_file *)pFile;
  return sqlite3OsSync(p->pReal, flags);
}

/*
** Return the current file-size of an devsym-file.
*/
int devsymFileSize(sqlite3_file *pFile, sqlite_int64 *pSize){
  devsym_file *p = (devsym_file *)pFile;
  return sqlite3OsFileSize(p->pReal, pSize);
}

/*
** Lock an devsym-file.
*/
int devsymLock(sqlite3_file *pFile, int eLock){
  devsym_file *p = (devsym_file *)pFile;
  return sqlite3OsLock(p->pReal, eLock);
}

/*
** Unlock an devsym-file.
*/
int devsymUnlock(sqlite3_file *pFile, int eLock){
  devsym_file *p = (devsym_file *)pFile;
  return sqlite3OsUnlock(p->pReal, eLock);
}

/*
** Check if another file-handle holds a RESERVED lock on an devsym-file.
*/
int devsymCheckReservedLock(sqlite3_file *pFile, int *pResOut){
  devsym_file *p = (devsym_file *)pFile;
  return sqlite3OsCheckReservedLock(p->pReal, pResOut);
}

/*
** File control method. For custom operations on an devsym-file.
*/
int devsymFileControl(sqlite3_file *pFile, int op, void *pArg){
  devsym_file *p = (devsym_file *)pFile;
  return sqlite3OsFileControl(p->pReal, op, pArg);
}

/*
** Return the sector-size in bytes for an devsym-file.
*/
int devsymSectorSize(sqlite3_file *pFile){
  return g.iSectorSize;
}

/*
** Return the device characteristic flags supported by an devsym-file.
*/
int devsymDeviceCharacteristics(sqlite3_file *pFile){
  return g.iDeviceChar;
}

/*
** Shared-memory methods are all pass-throughs.
*/
int devsymShmLock(sqlite3_file *pFile, int ofst, int n, int flags){
  devsym_file *p = (devsym_file *)pFile;
  if (memcmp(p->pReal->pMethods->xShmLock_signature, xShmLock_signatures[xShmLock_0_enum], sizeof(p->pReal->pMethods->xShmLock_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(p->pReal->pMethods->xShmLock_signature, xShmLock_signatures[xShmLock_apndShmLock_enum], sizeof(p->pReal->pMethods->xShmLock_signature)) == 0) {
      return apndShmLock(p->pReal, ofst, n, flags);
    }
  else
    if (memcmp(p->pReal->pMethods->xShmLock_signature, xShmLock_signatures[xShmLock_recoverVfsShmLock_enum], sizeof(p->pReal->pMethods->xShmLock_signature)) == 0) {
      return recoverVfsShmLock(p->pReal, ofst, n, flags);
    }
  else
    if (memcmp(p->pReal->pMethods->xShmLock_signature, xShmLock_signatures[xShmLock_unixShmLock_enum], sizeof(p->pReal->pMethods->xShmLock_signature)) == 0) {
      return unixShmLock(p->pReal, ofst, n, flags);
    }
}
int devsymShmMap(
  sqlite3_file *pFile, 
  int iRegion, 
  int szRegion, 
  int isWrite, 
  void volatile **pp
){
  devsym_file *p = (devsym_file *)pFile;
  if (memcmp(p->pReal->pMethods->xShmMap_signature, xShmMap_signatures[xShmMap_0_enum], sizeof(p->pReal->pMethods->xShmMap_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(p->pReal->pMethods->xShmMap_signature, xShmMap_signatures[xShmMap_apndShmMap_enum], sizeof(p->pReal->pMethods->xShmMap_signature)) == 0) {
      return apndShmMap(p->pReal, iRegion, szRegion, isWrite, pp);
    }
  else
    if (memcmp(p->pReal->pMethods->xShmMap_signature, xShmMap_signatures[xShmMap_recoverVfsShmMap_enum], sizeof(p->pReal->pMethods->xShmMap_signature)) == 0) {
      return recoverVfsShmMap(p->pReal, iRegion, szRegion, isWrite, pp);
    }
  else
    if (memcmp(p->pReal->pMethods->xShmMap_signature, xShmMap_signatures[xShmMap_unixShmMap_enum], sizeof(p->pReal->pMethods->xShmMap_signature)) == 0) {
      return unixShmMap(p->pReal, iRegion, szRegion, isWrite, pp);
    }
}
void devsymShmBarrier(sqlite3_file *pFile){
  devsym_file *p = (devsym_file *)pFile;
  if (memcmp(p->pReal->pMethods->xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_0_enum], sizeof(p->pReal->pMethods->xShmBarrier_signature)) == 0) {
    0;
  }
  else
    if (memcmp(p->pReal->pMethods->xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_apndShmBarrier_enum], sizeof(p->pReal->pMethods->xShmBarrier_signature)) == 0) {
      apndShmBarrier(p->pReal);
    }
  else
    if (memcmp(p->pReal->pMethods->xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_recoverVfsShmBarrier_enum], sizeof(p->pReal->pMethods->xShmBarrier_signature)) == 0) {
      recoverVfsShmBarrier(p->pReal);
    }
  else
    if (memcmp(p->pReal->pMethods->xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_unixShmBarrier_enum], sizeof(p->pReal->pMethods->xShmBarrier_signature)) == 0) {
      unixShmBarrier(p->pReal);
    }
}
int devsymShmUnmap(sqlite3_file *pFile, int delFlag){
  devsym_file *p = (devsym_file *)pFile;
  if (memcmp(p->pReal->pMethods->xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_0_enum], sizeof(p->pReal->pMethods->xShmUnmap_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(p->pReal->pMethods->xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_apndShmUnmap_enum], sizeof(p->pReal->pMethods->xShmUnmap_signature)) == 0) {
      return apndShmUnmap(p->pReal, delFlag);
    }
  else
    if (memcmp(p->pReal->pMethods->xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_recoverVfsShmUnmap_enum], sizeof(p->pReal->pMethods->xShmUnmap_signature)) == 0) {
      return recoverVfsShmUnmap(p->pReal, delFlag);
    }
  else
    if (memcmp(p->pReal->pMethods->xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_unixShmUnmap_enum], sizeof(p->pReal->pMethods->xShmUnmap_signature)) == 0) {
      return unixShmUnmap(p->pReal, delFlag);
    }
}



/*
** Open an devsym file handle.
*/
int devsymOpen(
  sqlite3_vfs *pVfs,
  const char *zName,
  sqlite3_file *pFile,
  int flags,
  int *pOutFlags
){
static sqlite3_io_methods devsym_io_methods = {
  2,                                /* iVersion */
  devsymClose,                      /* xClose */
  devsymRead,                       /* xRead */
  devsymWrite,                      /* xWrite */
  devsymTruncate,                   /* xTruncate */
  devsymSync,                       /* xSync */
  devsymFileSize,                   /* xFileSize */
  devsymLock,                       /* xLock */
  devsymUnlock,                     /* xUnlock */
  devsymCheckReservedLock,          /* xCheckReservedLock */
  devsymFileControl,                /* xFileControl */
  devsymSectorSize,                 /* xSectorSize */
  devsymDeviceCharacteristics,      /* xDeviceCharacteristics */
  devsymShmMap,                     /* xShmMap */
  devsymShmLock,                    /* xShmLock */
  devsymShmBarrier,                 /* xShmBarrier */
  devsymShmUnmap                    /* xShmUnmap */
,
  .xClose_signature = xClose_signatures[xClose_devsymClose_enum],
  .xRead_signature = xRead_signatures[xRead_devsymRead_enum],
  .xWrite_signature = xWrite_signatures[xWrite_devsymWrite_enum],
  .xTruncate_signature = xTruncate_signatures[xTruncate_devsymTruncate_enum],
  .xSync_signature = xSync_signatures[xSync_devsymSync_enum],
  .xFileSize_signature = xFileSize_signatures[xFileSize_devsymFileSize_enum],
  .xLock_signature = xLock_signatures[xLock_devsymLock_enum],
  .xUnlock_signature = xUnlock_signatures[xUnlock_devsymUnlock_enum],
  .xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_devsymCheckReservedLock_enum],
  .xFileControl_signature = xFileControl_signatures[xFileControl_devsymFileControl_enum],
  .xSectorSize_signature = xSectorSize_signatures[xSectorSize_devsymSectorSize_enum],
  .xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_devsymDeviceCharacteristics_enum],
  .xShmMap_signature = xShmMap_signatures[xShmMap_devsymShmMap_enum],
  .xShmLock_signature = xShmLock_signatures[xShmLock_devsymShmLock_enum],
  .xShmBarrier_signature = xShmBarrier_signatures[xShmBarrier_devsymShmBarrier_enum],
  .xShmUnmap_signature = xShmUnmap_signatures[xShmUnmap_devsymShmUnmap_enum]
};

  int rc;
  devsym_file *p = (devsym_file *)pFile;
  p->pReal = (sqlite3_file *)&p[1];
  rc = sqlite3OsOpen(g.pVfs, zName, p->pReal, flags, pOutFlags);
  if( p->pReal->pMethods ){
    pFile->pMethods = &devsym_io_methods;
  }
  return rc;
}

/*
** Delete the file located at zPath. If the dirSync argument is true,
** ensure the file-system modifications are synced to disk before
** returning.
*/
int devsymDelete(sqlite3_vfs *pVfs, const char *zPath, int dirSync){
  return sqlite3OsDelete(g.pVfs, zPath, dirSync);
}

/*
** Test for access permissions. Return true if the requested permission
** is available, or false otherwise.
*/
int devsymAccess(
  sqlite3_vfs *pVfs, 
  const char *zPath, 
  int flags, 
  int *pResOut
){
  return sqlite3OsAccess(g.pVfs, zPath, flags, pResOut);
}

/*
** Populate buffer zOut with the full canonical pathname corresponding
** to the pathname in zPath. zOut is guaranteed to point to a buffer
** of at least (DEVSYM_MAX_PATHNAME+1) bytes.
*/
int devsymFullPathname(
  sqlite3_vfs *pVfs, 
  const char *zPath, 
  int nOut, 
  char *zOut
){
  return sqlite3OsFullPathname(g.pVfs, zPath, nOut, zOut);
}

#ifndef SQLITE_OMIT_LOAD_EXTENSION
/*
** Open the dynamic library located at zPath and return a handle.
*/
static void *devsymDlOpen(sqlite3_vfs *pVfs, const char *zPath){
  return sqlite3OsDlOpen(g.pVfs, zPath);
}

/*
** Populate the buffer zErrMsg (size nByte bytes) with a human readable
** utf-8 string describing the most recent error encountered associated 
** with dynamic libraries.
*/
void devsymDlError(sqlite3_vfs *pVfs, int nByte, char *zErrMsg){
  sqlite3OsDlError(g.pVfs, nByte, zErrMsg);
}

/*
** Return a pointer to the symbol zSymbol in the dynamic library pHandle.
*/
void (*devsymDlSym(sqlite3_vfs *pVfs, void *p, const char *zSym))(void){
  return sqlite3OsDlSym(g.pVfs, p, zSym);
}

/*
** Close the dynamic library handle pHandle.
*/
void devsymDlClose(sqlite3_vfs *pVfs, void *pHandle){
  sqlite3OsDlClose(g.pVfs, pHandle);
}
#endif /* SQLITE_OMIT_LOAD_EXTENSION */

/*
** Populate the buffer pointed to by zBufOut with nByte bytes of 
** random data.
*/
static int devsymRandomness(sqlite3_vfs *pVfs, int nByte, char *zBufOut){
  return sqlite3OsRandomness(g.pVfs, nByte, zBufOut);
}

/*
** Sleep for nMicro microseconds. Return the number of microseconds 
** actually slept.
*/
int devsymSleep(sqlite3_vfs *pVfs, int nMicro){
  return sqlite3OsSleep(g.pVfs, nMicro);
}

/*
** Return the current time as a Julian Day number in *pTimeOut.
*/
int devsymCurrentTime(sqlite3_vfs *pVfs, double *pTimeOut){
  if (memcmp(g.pVfs->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_0_enum], sizeof(g.pVfs->xCurrentTime_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(g.pVfs->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_apndCurrentTime_enum], sizeof(g.pVfs->xCurrentTime_signature)) == 0) {
      return apndCurrentTime(g.pVfs, pTimeOut);
    }
  else
    if (memcmp(g.pVfs->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_vfstraceCurrentTime_enum], sizeof(g.pVfs->xCurrentTime_signature)) == 0) {
      return vfstraceCurrentTime(g.pVfs, pTimeOut);
    }
  else
    if (memcmp(g.pVfs->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_unixCurrentTime_enum], sizeof(g.pVfs->xCurrentTime_signature)) == 0) {
      return unixCurrentTime(g.pVfs, pTimeOut);
    }
}

/*
** Return the sector-size in bytes for an writecrash-file.
*/
int writecrashSectorSize(sqlite3_file *pFile){
  devsym_file *p = (devsym_file *)pFile;
  return sqlite3OsSectorSize(p->pReal);
}

/*
** Return the device characteristic flags supported by an writecrash-file.
*/
int writecrashDeviceCharacteristics(sqlite3_file *pFile){
  devsym_file *p = (devsym_file *)pFile;
  return sqlite3OsDeviceCharacteristics(p->pReal);
}

/*
** Write data to an writecrash-file.
*/
int writecrashWrite(
  sqlite3_file *pFile, 
  const void *zBuf, 
  int iAmt, 
  sqlite_int64 iOfst
){
  devsym_file *p = (devsym_file *)pFile;
  if( g.nWriteCrash>0 ){
    g.nWriteCrash--;
    if( g.nWriteCrash==0 ) abort();
  }
  return sqlite3OsWrite(p->pReal, zBuf, iAmt, iOfst);
}

/*
** Open an writecrash file handle.
*/
int writecrashOpen(
  sqlite3_vfs *pVfs,
  const char *zName,
  sqlite3_file *pFile,
  int flags,
  int *pOutFlags
){
static sqlite3_io_methods writecrash_io_methods = {
  2,                                /* iVersion */
  devsymClose,                      /* xClose */
  devsymRead,                       /* xRead */
  writecrashWrite,                  /* xWrite */
  devsymTruncate,                   /* xTruncate */
  devsymSync,                       /* xSync */
  devsymFileSize,                   /* xFileSize */
  devsymLock,                       /* xLock */
  devsymUnlock,                     /* xUnlock */
  devsymCheckReservedLock,          /* xCheckReservedLock */
  devsymFileControl,                /* xFileControl */
  writecrashSectorSize,             /* xSectorSize */
  writecrashDeviceCharacteristics,  /* xDeviceCharacteristics */
  devsymShmMap,                     /* xShmMap */
  devsymShmLock,                    /* xShmLock */
  devsymShmBarrier,                 /* xShmBarrier */
  devsymShmUnmap                    /* xShmUnmap */
,
  .xClose_signature = xClose_signatures[xClose_devsymClose_enum],
  .xRead_signature = xRead_signatures[xRead_devsymRead_enum],
  .xWrite_signature = xWrite_signatures[xWrite_writecrashWrite_enum],
  .xTruncate_signature = xTruncate_signatures[xTruncate_devsymTruncate_enum],
  .xSync_signature = xSync_signatures[xSync_devsymSync_enum],
  .xFileSize_signature = xFileSize_signatures[xFileSize_devsymFileSize_enum],
  .xLock_signature = xLock_signatures[xLock_devsymLock_enum],
  .xUnlock_signature = xUnlock_signatures[xUnlock_devsymUnlock_enum],
  .xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_devsymCheckReservedLock_enum],
  .xFileControl_signature = xFileControl_signatures[xFileControl_devsymFileControl_enum],
  .xSectorSize_signature = xSectorSize_signatures[xSectorSize_writecrashSectorSize_enum],
  .xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_writecrashDeviceCharacteristics_enum],
  .xShmMap_signature = xShmMap_signatures[xShmMap_devsymShmMap_enum],
  .xShmLock_signature = xShmLock_signatures[xShmLock_devsymShmLock_enum],
  .xShmBarrier_signature = xShmBarrier_signatures[xShmBarrier_devsymShmBarrier_enum],
  .xShmUnmap_signature = xShmUnmap_signatures[xShmUnmap_devsymShmUnmap_enum]
};

  int rc;
  devsym_file *p = (devsym_file *)pFile;
  p->pReal = (sqlite3_file *)&p[1];
  rc = sqlite3OsOpen(g.pVfs, zName, p->pReal, flags, pOutFlags);
  if( p->pReal->pMethods ){
    pFile->pMethods = &writecrash_io_methods;
  }
  return rc;
}

static sqlite3_vfs devsym_vfs = {
  2,                     /* iVersion */
  sizeof(devsym_file),      /* szOsFile */
  DEVSYM_MAX_PATHNAME,      /* mxPathname */
  0,                     /* pNext */
  DEVSYM_VFS_NAME,          /* zName */
  0,                     /* pAppData */
  devsymOpen,               /* xOpen */
  devsymDelete,             /* xDelete */
  devsymAccess,             /* xAccess */
  devsymFullPathname,       /* xFullPathname */
#ifndef SQLITE_OMIT_LOAD_EXTENSION
  devsymDlOpen,             /* xDlOpen */
  devsymDlError,            /* xDlError */
  devsymDlSym,              /* xDlSym */
  devsymDlClose,            /* xDlClose */
#else
  0,                        /* xDlOpen */
  0,                        /* xDlError */
  0,                        /* xDlSym */
  0,                        /* xDlClose */
#endif /* SQLITE_OMIT_LOAD_EXTENSION */
  devsymRandomness,         /* xRandomness */
  devsymSleep,              /* xSleep */
  devsymCurrentTime,        /* xCurrentTime */
  0,                        /* xGetLastError */
  0                         /* xCurrentTimeInt64 */
,
  .xOpen_signature = xOpen_signatures[xOpen_devsymOpen_enum],
  .xDelete_signature = xDelete_signatures[xDelete_devsymDelete_enum],
  .xAccess_signature = xAccess_signatures[xAccess_devsymAccess_enum],
  .xFullPathname_signature = xFullPathname_signatures[xFullPathname_devsymFullPathname_enum],
  .xDlError_signature = xDlError_signatures[xDlError_devsymDlError_enum],
  .xDlSym_signature = xDlSym_signatures[xDlSym_devsymDlSym_enum],
  .xDlClose_signature = xDlClose_signatures[xDlClose_devsymDlClose_enum],
  .xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_devsymSleep_enum],
  .xGetSystemCall_signature = xGetSystemCall_signatures[xGetSystemCall_devsymCurrentTime_enum]
};

static sqlite3_vfs writecrash_vfs = {
  2,                     /* iVersion */
  sizeof(devsym_file),      /* szOsFile */
  DEVSYM_MAX_PATHNAME,      /* mxPathname */
  0,                     /* pNext */
  WRITECRASH_NAME,          /* zName */
  0,                     /* pAppData */
  writecrashOpen,           /* xOpen */
  devsymDelete,             /* xDelete */
  devsymAccess,             /* xAccess */
  devsymFullPathname,       /* xFullPathname */
#ifndef SQLITE_OMIT_LOAD_EXTENSION
  devsymDlOpen,             /* xDlOpen */
  devsymDlError,            /* xDlError */
  devsymDlSym,              /* xDlSym */
  devsymDlClose,            /* xDlClose */
#else
  0,                        /* xDlOpen */
  0,                        /* xDlError */
  0,                        /* xDlSym */
  0,                        /* xDlClose */
#endif /* SQLITE_OMIT_LOAD_EXTENSION */
  devsymRandomness,         /* xRandomness */
  devsymSleep,              /* xSleep */
  devsymCurrentTime,        /* xCurrentTime */
  0,                        /* xGetLastError */
  0                         /* xCurrentTimeInt64 */
,
  .xOpen_signature = xOpen_signatures[xOpen_writecrashOpen_enum],
  .xDelete_signature = xDelete_signatures[xDelete_devsymDelete_enum],
  .xAccess_signature = xAccess_signatures[xAccess_devsymAccess_enum],
  .xFullPathname_signature = xFullPathname_signatures[xFullPathname_devsymFullPathname_enum],
  .xDlError_signature = xDlError_signatures[xDlError_devsymDlError_enum],
  .xDlSym_signature = xDlSym_signatures[xDlSym_devsymDlSym_enum],
  .xDlClose_signature = xDlClose_signatures[xDlClose_devsymDlClose_enum],
  .xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_devsymSleep_enum],
  .xGetSystemCall_signature = xGetSystemCall_signatures[xGetSystemCall_devsymCurrentTime_enum]
};


/*
** This procedure registers the devsym vfs with SQLite. If the argument is
** true, the devsym vfs becomes the new default vfs. It is the only publicly
** available function in this file.
*/
void devsym_register(int iDeviceChar, int iSectorSize){

  if( g.pVfs==0 ){
    g.pVfs = sqlite3_vfs_find(0);
    devsym_vfs.szOsFile += g.pVfs->szOsFile;
    writecrash_vfs.szOsFile += g.pVfs->szOsFile;
    sqlite3_vfs_register(&devsym_vfs, 0);
    sqlite3_vfs_register(&writecrash_vfs, 0);
  }
  if( iDeviceChar>=0 ){
    g.iDeviceChar = iDeviceChar;
  }else{
    g.iDeviceChar = 0;
  }
  if( iSectorSize>=0 ){
    g.iSectorSize = iSectorSize;
  }else{
    g.iSectorSize = 512;
  }
}

void devsym_unregister(){
  sqlite3_vfs_unregister(&devsym_vfs);
  sqlite3_vfs_unregister(&writecrash_vfs);
  g.pVfs = 0;
  g.iDeviceChar = 0;
  g.iSectorSize = 0;
}

void devsym_crash_on_write(int nWrite){
  if( g.pVfs==0 ){
    g.pVfs = sqlite3_vfs_find(0);
    devsym_vfs.szOsFile += g.pVfs->szOsFile;
    writecrash_vfs.szOsFile += g.pVfs->szOsFile;
    sqlite3_vfs_register(&devsym_vfs, 0);
    sqlite3_vfs_register(&writecrash_vfs, 0);
  }
  g.nWriteCrash = nWrite;
}

#endif
