/*
** 2017-10-20
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
** This file implements a VFS shim that allows an SQLite database to be
** appended onto the end of some other file, such as an executable.
**
** A special record must appear at the end of the file that identifies the
** file as an appended database and provides the offset to the first page
** of the exposed content. (Or, it is the length of the content prefix.)
** For best performance page 1 should be located at a disk page boundary,
** though that is not required.
**
** When opening a database using this VFS, the connection might treat
** the file as an ordinary SQLite database, or it might treat it as a
** database appended onto some other file.  The decision is made by
** applying the following rules in order:
**
**  (1)  An empty file is an ordinary database.
**
**  (2)  If the file ends with the appendvfs trailer string
**       "Start-Of-SQLite3-NNNNNNNN" that file is an appended database.
**
**  (3)  If the file begins with the standard SQLite prefix string
**       "SQLite format 3", that file is an ordinary database.
**
**  (4)  If none of the above apply and the SQLITE_OPEN_CREATE flag is
**       set, then a new database is appended to the already existing file.
**
**  (5)  Otherwise, SQLITE_CANTOPEN is returned.
**
** To avoid unnecessary complications with the PENDING_BYTE, the size of
** the file containing the database is limited to 1GiB. (1073741824 bytes)
** This VFS will not read or write past the 1GiB mark.  This restriction
** might be lifted in future versions.  For now, if you need a larger
** database, then keep it in a separate file.
**
** If the file being opened is a plain database (not an appended one), then
** this shim is a pass-through into the default underlying VFS. (rule 3)
**/
#include "sqlite3ext.h"
SQLITE_EXTENSION_INIT1
#include <string.h>
#include <assert.h>

/* The append mark at the end of the database is:
**
**     Start-Of-SQLite3-NNNNNNNN
**     123456789 123456789 12345
**
** The NNNNNNNN represents a 64-bit big-endian unsigned integer which is
** the offset to page 1, and also the length of the prefix content.
*/
#define APND_MARK_PREFIX     "Start-Of-SQLite3-"
#define APND_MARK_PREFIX_SZ  17
#define APND_MARK_FOS_SZ      8
#define APND_MARK_SIZE       (APND_MARK_PREFIX_SZ+APND_MARK_FOS_SZ)

/*
** Maximum size of the combined prefix + database + append-mark.  This
** must be less than 0x40000000 to avoid locking issues on Windows.
*/
#define APND_MAX_SIZE  (0x40000000)

/*
** Try to align the database to an even multiple of APND_ROUNDUP bytes.
*/
#ifndef APND_ROUNDUP
#define APND_ROUNDUP 4096
#endif
#define APND_ALIGN_MASK         ((sqlite3_int64)(APND_ROUNDUP-1))
#define APND_START_ROUNDUP(fsz) (((fsz)+APND_ALIGN_MASK) & ~APND_ALIGN_MASK)

/*
** Forward declaration of objects used by this utility
*/
typedef struct sqlite3_vfs ApndVfs;
typedef struct ApndFile ApndFile;

/* Access to a lower-level VFS that (might) implement dynamic loading,
** access to randomness, etc.
*/
#define ORIGVFS(p)  ((sqlite3_vfs*)((p)->pAppData))
#define ORIGFILE(p) ((sqlite3_file*)(((ApndFile*)(p))+1))

/* An open appendvfs file
**
** An instance of this structure describes the appended database file.
** A separate sqlite3_file object is always appended. The appended
** sqlite3_file object (which can be accessed using ORIGFILE()) describes
** the entire file, including the prefix, the database, and the
** append-mark.
**
** The structure of an AppendVFS database is like this:
**
**   +-------------+---------+----------+-------------+
**   | prefix-file | padding | database | append-mark |
**   +-------------+---------+----------+-------------+
**                           ^          ^
**                           |          |
**                         iPgOne      iMark
**
**
** "prefix file" -  file onto which the database has been appended.
** "padding"     -  zero or more bytes inserted so that "database"
**                  starts on an APND_ROUNDUP boundary
** "database"    -  The SQLite database file
** "append-mark" -  The 25-byte "Start-Of-SQLite3-NNNNNNNN" that indicates
**                  the offset from the start of prefix-file to the start
**                  of "database".
**
** The size of the database is iMark - iPgOne.
**
** The NNNNNNNN in the "Start-Of-SQLite3-NNNNNNNN" suffix is the value
** of iPgOne stored as a big-ending 64-bit integer.
**
** iMark will be the size of the underlying file minus 25 (APND_MARKSIZE).
** Or, iMark is -1 to indicate that it has not yet been written.
*/
struct ApndFile {
  sqlite3_file base;        /* Subclass.  MUST BE FIRST! */
  sqlite3_int64 iPgOne;     /* Offset to the start of the database */
  sqlite3_int64 iMark;      /* Offset of the append mark.  -1 if unwritten */
  /* Always followed by another sqlite3_file that describes the whole file */
};

/*
** Methods for ApndFile
*/
int apndClose(sqlite3_file*);
int apndRead(sqlite3_file*, void*, int iAmt, sqlite3_int64 iOfst);
int apndWrite(sqlite3_file*,const void*,int iAmt, sqlite3_int64 iOfst);
int apndTruncate(sqlite3_file*, sqlite3_int64 size);
int apndSync(sqlite3_file*, int flags);
int apndFileSize(sqlite3_file*, sqlite3_int64 *pSize);
int apndLock(sqlite3_file*, int);
int apndUnlock(sqlite3_file*, int);
int apndCheckReservedLock(sqlite3_file*, int *pResOut);
int apndFileControl(sqlite3_file*, int op, void *pArg);
int apndSectorSize(sqlite3_file*);
int apndDeviceCharacteristics(sqlite3_file*);
int apndShmMap(sqlite3_file*, int iPg, int pgsz, int, void volatile**);
int apndShmLock(sqlite3_file*, int offset, int n, int flags);
void apndShmBarrier(sqlite3_file*);
int apndShmUnmap(sqlite3_file*, int deleteFlag);
int apndFetch(sqlite3_file*, sqlite3_int64 iOfst, int iAmt, void **pp);
int apndUnfetch(sqlite3_file*, sqlite3_int64 iOfst, void *p);

/*
** Methods for ApndVfs
*/
int apndOpen(sqlite3_vfs*, const char *, sqlite3_file*, int , int *);
int apndDelete(sqlite3_vfs*, const char *zName, int syncDir);
int apndAccess(sqlite3_vfs*, const char *zName, int flags, int *);
int apndFullPathname(sqlite3_vfs*, const char *zName, int, char *zOut);
void *apndDlOpen(sqlite3_vfs*, const char *zFilename);
void apndDlError(sqlite3_vfs*, int nByte, char *zErrMsg);
void (*apndDlSym(sqlite3_vfs *pVfs, void *p, const char*zSym))(void);
void apndDlClose(sqlite3_vfs*, void*);
int apndRandomness(sqlite3_vfs*, int nByte, char *zOut);
int apndSleep(sqlite3_vfs*, int microseconds);
int apndCurrentTime(sqlite3_vfs*, double*);
int apndGetLastError(sqlite3_vfs*, int, char *);
int apndCurrentTimeInt64(sqlite3_vfs*, sqlite3_int64*);
int apndSetSystemCall(sqlite3_vfs*, const char*,sqlite3_syscall_ptr);
sqlite3_syscall_ptr apndGetSystemCall(sqlite3_vfs*, const char *z);
const char *apndNextSystemCall(sqlite3_vfs*, const char *zName);

static sqlite3_vfs apnd_vfs = {
  3,                            /* iVersion (set when registered) */
  0,                            /* szOsFile (set when registered) */
  1024,                         /* mxPathname */
  0,                            /* pNext */
  "apndvfs",                    /* zName */
  0,                            /* pAppData (set when registered) */ 
  apndOpen,                     /* xOpen */
  apndDelete,                   /* xDelete */
  apndAccess,                   /* xAccess */
  apndFullPathname,             /* xFullPathname */
  apndDlOpen,                   /* xDlOpen */
  apndDlError,                  /* xDlError */
  apndDlSym,                    /* xDlSym */
  apndDlClose,                  /* xDlClose */
  apndRandomness,               /* xRandomness */
  apndSleep,                    /* xSleep */
  apndCurrentTime,              /* xCurrentTime */
  apndGetLastError,             /* xGetLastError */
  apndCurrentTimeInt64,         /* xCurrentTimeInt64 */
  apndSetSystemCall,            /* xSetSystemCall */
  apndGetSystemCall,            /* xGetSystemCall */
  apndNextSystemCall            /* xNextSystemCall */
,
  .xOpen_signature = xOpen_signatures[xOpen_apndOpen_enum],
  .xDelete_signature = xDelete_signatures[xDelete_apndDelete_enum],
  .xAccess_signature = xAccess_signatures[xAccess_apndAccess_enum],
  .xFullPathname_signature = xFullPathname_signatures[xFullPathname_apndFullPathname_enum],
  .xDlOpen_signature = xDlOpen_signatures[xDlOpen_apndDlOpen_enum],
  .xDlError_signature = xDlError_signatures[xDlError_apndDlError_enum],
  .xDlSym_signature = xDlSym_signatures[xDlSym_apndDlSym_enum],
  .xDlClose_signature = xDlClose_signatures[xDlClose_apndDlClose_enum],
  .xRandomness_signature = xRandomness_signatures[xRandomness_apndRandomness_enum],
  .xSleep_signature = xSleep_signatures[xSleep_apndSleep_enum],
  .xCurrentTime_signature = xCurrentTime_signatures[xCurrentTime_apndCurrentTime_enum],
  .xGetLastError_signature = xGetLastError_signatures[xGetLastError_apndGetLastError_enum],
  .xCurrentTimeInt64_signature = xCurrentTimeInt64_signatures[xCurrentTimeInt64_apndCurrentTimeInt64_enum],
  .xSetSystemCall_signature = xSetSystemCall_signatures[xSetSystemCall_apndSetSystemCall_enum],
  .xGetSystemCall_signature = xGetSystemCall_signatures[xGetSystemCall_apndGetSystemCall_enum],
  .xNextSystemCall_signature = xNextSystemCall_signatures[xNextSystemCall_apndNextSystemCall_enum]
};

static const sqlite3_io_methods apnd_io_methods = {
  3,                              /* iVersion */
  apndClose,                      /* xClose */
  apndRead,                       /* xRead */
  apndWrite,                      /* xWrite */
  apndTruncate,                   /* xTruncate */
  apndSync,                       /* xSync */
  apndFileSize,                   /* xFileSize */
  apndLock,                       /* xLock */
  apndUnlock,                     /* xUnlock */
  apndCheckReservedLock,          /* xCheckReservedLock */
  apndFileControl,                /* xFileControl */
  apndSectorSize,                 /* xSectorSize */
  apndDeviceCharacteristics,      /* xDeviceCharacteristics */
  apndShmMap,                     /* xShmMap */
  apndShmLock,                    /* xShmLock */
  apndShmBarrier,                 /* xShmBarrier */
  apndShmUnmap,                   /* xShmUnmap */
  apndFetch,                      /* xFetch */
  apndUnfetch                     /* xUnfetch */
,
  .xClose_signature = xClose_signatures[xClose_apndClose_enum],
  .xRead_signature = xRead_signatures[xRead_apndRead_enum],
  .xWrite_signature = xWrite_signatures[xWrite_apndWrite_enum],
  .xTruncate_signature = xTruncate_signatures[xTruncate_apndTruncate_enum],
  .xSync_signature = xSync_signatures[xSync_apndSync_enum],
  .xFileSize_signature = xFileSize_signatures[xFileSize_apndFileSize_enum],
  .xLock_signature = xLock_signatures[xLock_apndLock_enum],
  .xUnlock_signature = xUnlock_signatures[xUnlock_apndUnlock_enum],
  .xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_apndCheckReservedLock_enum],
  .xFileControl_signature = xFileControl_signatures[xFileControl_apndFileControl_enum],
  .xSectorSize_signature = xSectorSize_signatures[xSectorSize_apndSectorSize_enum],
  .xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_apndDeviceCharacteristics_enum],
  .xShmMap_signature = xShmMap_signatures[xShmMap_apndShmMap_enum],
  .xShmLock_signature = xShmLock_signatures[xShmLock_apndShmLock_enum],
  .xShmBarrier_signature = xShmBarrier_signatures[xShmBarrier_apndShmBarrier_enum],
  .xShmUnmap_signature = xShmUnmap_signatures[xShmUnmap_apndShmUnmap_enum],
  .xFetch_signature = xFetch_signatures[xFetch_apndFetch_enum],
  .xUnfetch_signature = xUnfetch_signatures[xUnfetch_apndUnfetch_enum]
};

/*
** Close an apnd-file.
*/
int apndClose(sqlite3_file *pFile){
  pFile = ORIGFILE(pFile);
  if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_apndClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
    return apndClose(pFile);
  }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_bytecodevtabClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return bytecodevtabClose(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_completionClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return completionClose(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_dbdataClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return dbdataClose(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_dbpageClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return dbpageClose(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_expertClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return expertClose(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_fsdirClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return fsdirClose(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_fts3CloseMethod_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return fts3CloseMethod(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_fts3auxCloseMethod_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return fts3auxCloseMethod(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_fts3tokCloseMethod_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return fts3tokCloseMethod(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_jsonEachClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return jsonEachClose(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_memdbClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return memdbClose(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_memjrnlClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return memjrnlClose(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_porterClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return porterClose(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_pragmaVtabClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return pragmaVtabClose(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_recoverVfsClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return recoverVfsClose(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_rtreeClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return rtreeClose(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_seriesClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return seriesClose(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_simpleClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return simpleClose(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_statClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return statClose(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_stmtClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return stmtClose(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_unicodeClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return unicodeClose(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_vfstraceClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return vfstraceClose(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_zipfileClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return zipfileClose(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_unixClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return unixClose(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_nolockClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return nolockClose(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xClose_signature, xClose_signatures[xClose_dotlockClose_enum], sizeof(pFile->pMethods->xClose_signature)) == 0) {
      return dotlockClose(pFile);
    }
}

/*
** Read data from an apnd-file.
*/
int apndRead(
  sqlite3_file *pFile, 
  void *zBuf, 
  int iAmt, 
  sqlite_int64 iOfst
){
  ApndFile *paf = (ApndFile *)pFile;
  pFile = ORIGFILE(pFile);
  if (memcmp(pFile->pMethods->xRead_signature, xRead_signatures[xRead_apndRead_enum], sizeof(pFile->pMethods->xRead_signature)) == 0) {
    return apndRead(pFile, zBuf, iAmt, paf->iPgOne + iOfst);
  }
  else
    if (memcmp(pFile->pMethods->xRead_signature, xRead_signatures[xRead_memdbRead_enum], sizeof(pFile->pMethods->xRead_signature)) == 0) {
      return memdbRead(pFile, zBuf, iAmt, paf->iPgOne + iOfst);
    }
  else
    if (memcmp(pFile->pMethods->xRead_signature, xRead_signatures[xRead_memjrnlRead_enum], sizeof(pFile->pMethods->xRead_signature)) == 0) {
      return memjrnlRead(pFile, zBuf, iAmt, paf->iPgOne + iOfst);
    }
  else
    if (memcmp(pFile->pMethods->xRead_signature, xRead_signatures[xRead_recoverVfsRead_enum], sizeof(pFile->pMethods->xRead_signature)) == 0) {
      return recoverVfsRead(pFile, zBuf, iAmt, paf->iPgOne + iOfst);
    }
  else
    if (memcmp(pFile->pMethods->xRead_signature, xRead_signatures[xRead_vfstraceRead_enum], sizeof(pFile->pMethods->xRead_signature)) == 0) {
      return vfstraceRead(pFile, zBuf, iAmt, paf->iPgOne + iOfst);
    }
  else
    if (memcmp(pFile->pMethods->xRead_signature, xRead_signatures[xRead_unixRead_enum], sizeof(pFile->pMethods->xRead_signature)) == 0) {
      return unixRead(pFile, zBuf, iAmt, paf->iPgOne + iOfst);
    }
}

/*
** Add the append-mark onto what should become the end of the file.
*  If and only if this succeeds, internal ApndFile.iMark is updated.
*  Parameter iWriteEnd is the appendvfs-relative offset of the new mark.
*/
static int apndWriteMark(
  ApndFile *paf,
  sqlite3_file *pFile,
  sqlite_int64 iWriteEnd
){
  sqlite_int64 iPgOne = paf->iPgOne;
  unsigned char a[APND_MARK_SIZE];
  int i = APND_MARK_FOS_SZ;
  int rc;
  assert(pFile == ORIGFILE(paf));
  memcpy(a, APND_MARK_PREFIX, APND_MARK_PREFIX_SZ);
  while( --i >= 0 ){
    a[APND_MARK_PREFIX_SZ+i] = (unsigned char)(iPgOne & 0xff);
    iPgOne >>= 8;
  }
  iWriteEnd += paf->iPgOne;
  if( SQLITE_OK==(rc = pFile->pMethods->xWrite
                  (pFile, a, APND_MARK_SIZE, iWriteEnd)) ){
    paf->iMark = iWriteEnd;
  }
  // rc = pFile->pMethods->xWrite(pFile, a, APND_MARK_SIZE, iWriteEnd);
  // if( SQLITE_OK == rc) {
  //   paf->iMark = iWriteEnd;
  // }

  return rc;
}

/*
** Write data to an apnd-file.
*/
int apndWrite(
  sqlite3_file *pFile,
  const void *zBuf,
  int iAmt,
  sqlite_int64 iOfst
){
  ApndFile *paf = (ApndFile *)pFile;
  sqlite_int64 iWriteEnd = iOfst + iAmt;
  if( iWriteEnd>=APND_MAX_SIZE ) return SQLITE_FULL;
  pFile = ORIGFILE(pFile);
  /* If append-mark is absent or will be overwritten, write it. */
  if( paf->iMark < 0 || paf->iPgOne + iWriteEnd > paf->iMark ){
    int rc = apndWriteMark(paf, pFile, iWriteEnd);
    if( SQLITE_OK!=rc ) return rc;
  }
  if (memcmp(pFile->pMethods->xWrite_signature, xWrite_signatures[xWrite_apndWrite_enum], sizeof(pFile->pMethods->xWrite_signature)) == 0) {
    return apndWrite(pFile, zBuf, iAmt, paf->iPgOne + iOfst);
  }
  // else
  //   if (memcmp(pFile->pMethods->xWrite_signature, xWrite_signatures[xWrite_kvstorageWrite_enum], sizeof(pFile->pMethods->xWrite_signature)) == 0) {
  //     return kvstorageWrite(pFile, zBuf, iAmt, paf->iPgOne + iOfst);
  //   }
  else
    if (memcmp(pFile->pMethods->xWrite_signature, xWrite_signatures[xWrite_memdbWrite_enum], sizeof(pFile->pMethods->xWrite_signature)) == 0) {
      return memdbWrite(pFile, zBuf, iAmt, paf->iPgOne + iOfst);
    }
  else
    if (memcmp(pFile->pMethods->xWrite_signature, xWrite_signatures[xWrite_memjrnlWrite_enum], sizeof(pFile->pMethods->xWrite_signature)) == 0) {
      return memjrnlWrite(pFile, zBuf, iAmt, paf->iPgOne + iOfst);
    }
  else
    if (memcmp(pFile->pMethods->xWrite_signature, xWrite_signatures[xWrite_recoverVfsWrite_enum], sizeof(pFile->pMethods->xWrite_signature)) == 0) {
      return recoverVfsWrite(pFile, zBuf, iAmt, paf->iPgOne + iOfst);
    }
  else
    if (memcmp(pFile->pMethods->xWrite_signature, xWrite_signatures[xWrite_vfstraceWrite_enum], sizeof(pFile->pMethods->xWrite_signature)) == 0) {
      return vfstraceWrite(pFile, zBuf, iAmt, paf->iPgOne + iOfst);
    }
  else
    if (memcmp(pFile->pMethods->xWrite_signature, xWrite_signatures[xWrite_unixWrite_enum], sizeof(pFile->pMethods->xWrite_signature)) == 0) {
      return unixWrite(pFile, zBuf, iAmt, paf->iPgOne + iOfst);
    }
}

/*
** Truncate an apnd-file.
*/
int apndTruncate(sqlite3_file *pFile, sqlite_int64 size){
  ApndFile *paf = (ApndFile *)pFile;
  pFile = ORIGFILE(pFile);
  /* The append mark goes out first so truncate failure does not lose it. */
  if( SQLITE_OK!=apndWriteMark(paf, pFile, size) ) return SQLITE_IOERR;
  /* Truncate underlying file just past append mark */
  if (memcmp(pFile->pMethods->xTruncate_signature, xTruncate_signatures[xTruncate_apndTruncate_enum], sizeof(pFile->pMethods->xTruncate_signature)) == 0) {
    return apndTruncate(pFile, paf->iMark + APND_MARK_SIZE);
  }
  else
    if (memcmp(pFile->pMethods->xTruncate_signature, xTruncate_signatures[xTruncate_memdbTruncate_enum], sizeof(pFile->pMethods->xTruncate_signature)) == 0) {
      return memdbTruncate(pFile, paf->iMark + APND_MARK_SIZE);
    }
  else
    if (memcmp(pFile->pMethods->xTruncate_signature, xTruncate_signatures[xTruncate_memjrnlTruncate_enum], sizeof(pFile->pMethods->xTruncate_signature)) == 0) {
      return memjrnlTruncate(pFile, paf->iMark + APND_MARK_SIZE);
    }
  // else
  //   if (memcmp(pFile->pMethods->xTruncate_signature, xTruncate_signatures[xTruncate_pcache1Truncate_enum], sizeof(pFile->pMethods->xTruncate_signature)) == 0) {
  //     return pcache1Truncate(pFile, paf->iMark + APND_MARK_SIZE);
  //   }
  // else
  //   if (memcmp(pFile->pMethods->xTruncate_signature, xTruncate_signatures[xTruncate_pcachetraceTruncate_enum], sizeof(pFile->pMethods->xTruncate_signature)) == 0) {
  //     return pcachetraceTruncate(pFile, paf->iMark + APND_MARK_SIZE);
  //   }
  else
    if (memcmp(pFile->pMethods->xTruncate_signature, xTruncate_signatures[xTruncate_recoverVfsTruncate_enum], sizeof(pFile->pMethods->xTruncate_signature)) == 0) {
      return recoverVfsTruncate(pFile, paf->iMark + APND_MARK_SIZE);
    }
  else
    if (memcmp(pFile->pMethods->xTruncate_signature, xTruncate_signatures[xTruncate_vfstraceTruncate_enum], sizeof(pFile->pMethods->xTruncate_signature)) == 0) {
      return vfstraceTruncate(pFile, paf->iMark + APND_MARK_SIZE);
    }
  else
    if (memcmp(pFile->pMethods->xTruncate_signature, xTruncate_signatures[xTruncate_unixTruncate_enum], sizeof(pFile->pMethods->xTruncate_signature)) == 0) {
      return unixTruncate(pFile, paf->iMark + APND_MARK_SIZE);
    }
}

/*
** Sync an apnd-file.
*/
int apndSync(sqlite3_file *pFile, int flags){
  pFile = ORIGFILE(pFile);
  // return pFile->pMethods->xSync(pFile, flags);
  if (memcmp(pFile->pMethods->xSync_signature, xSync_signatures[xSync_0_enum], sizeof(pFile->pMethods->xSync_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pFile->pMethods->xSync_signature, xSync_signatures[xSync_apndSync_enum], sizeof(pFile->pMethods->xSync_signature)) == 0) {
    	return apndSync(pFile, flags);
    }
  // else
  //   if (memcmp(pFile->pMethods->xSync_signature, xSync_signatures[xSync_dbpageSync_enum], sizeof(pFile->pMethods->xSync_signature)) == 0) {
  //   	return dbpageSync(pFile, flags);
  //   }
  // else
  //   if (memcmp(pFile->pMethods->xSync_signature, xSync_signatures[xSync_echoSync_enum], sizeof(pFile->pMethods->xSync_signature)) == 0) {
  //   	return echoSync(pFile, flags);
  //   }
  // else
  //   if (memcmp(pFile->pMethods->xSync_signature, xSync_signatures[xSync_fts3SyncMethod_enum], sizeof(pFile->pMethods->xSync_signature)) == 0) {
  //   	return fts3SyncMethod(pFile, flags);
  //   }
  else
    if (memcmp(pFile->pMethods->xSync_signature, xSync_signatures[xSync_memdbSync_enum], sizeof(pFile->pMethods->xSync_signature)) == 0) {
    	return memdbSync(pFile, flags);
    }
  else
    if (memcmp(pFile->pMethods->xSync_signature, xSync_signatures[xSync_memjrnlSync_enum], sizeof(pFile->pMethods->xSync_signature)) == 0) {
    	return memjrnlSync(pFile, flags);
    }
  else
    if (memcmp(pFile->pMethods->xSync_signature, xSync_signatures[xSync_recoverVfsSync_enum], sizeof(pFile->pMethods->xSync_signature)) == 0) {
    	return recoverVfsSync(pFile, flags);
    }
  // else
  //   if (memcmp(pFile->pMethods->xSync_signature, xSync_signatures[xSync_rtreeEndTransaction_enum], sizeof(pFile->pMethods->xSync_signature)) == 0) {
  //   	return rtreeEndTransaction(pFile, flags);
  //   }
  else
    if (memcmp(pFile->pMethods->xSync_signature, xSync_signatures[xSync_vfstraceSync_enum], sizeof(pFile->pMethods->xSync_signature)) == 0) {
    	return vfstraceSync(pFile, flags);
    }
  // else
  //   if (memcmp(pFile->pMethods->xSync_signature, xSync_signatures[xSync_vtablogSync_enum], sizeof(pFile->pMethods->xSync_signature)) == 0) {
  //   	return vtablogSync(pFile, flags);
  //   }
  else
    if (memcmp(pFile->pMethods->xSync_signature, xSync_signatures[xSync_unixSync_enum], sizeof(pFile->pMethods->xSync_signature)) == 0) {
    	return unixSync(pFile, flags);
    }
}

/*
** Return the current file-size of an apnd-file.
** If the append mark is not yet there, the file-size is 0.
*/
int apndFileSize(sqlite3_file *pFile, sqlite_int64 *pSize){
  ApndFile *paf = (ApndFile *)pFile;
  *pSize = ( paf->iMark >= 0 )? (paf->iMark - paf->iPgOne) : 0;
  return SQLITE_OK;
}

/*
** Lock an apnd-file.
*/
int apndLock(sqlite3_file *pFile, int eLock){
  pFile = ORIGFILE(pFile);
  // return pFile->pMethods->xLock(pFile, eLock);
  if (memcmp(pFile->pMethods->xLock_signature, xLock_signatures[xLock_0_enum], sizeof(pFile->pMethods->xLock_signature)) == 0) {
      return 0;
  }
  else
    if (memcmp(pFile->pMethods->xLock_signature, xLock_signatures[xLock_apndLock_enum], sizeof(pFile->pMethods->xLock_signature)) == 0) {
      return apndLock(pFile, eLock);
    }
  else
    if (memcmp(pFile->pMethods->xLock_signature, xLock_signatures[xLock_memdbLock_enum], sizeof(pFile->pMethods->xLock_signature)) == 0) {
      return memdbLock(pFile, eLock);
    }
  else
    if (memcmp(pFile->pMethods->xLock_signature, xLock_signatures[xLock_recoverVfsLock_enum], sizeof(pFile->pMethods->xLock_signature)) == 0) {
      return recoverVfsLock(pFile, eLock);
    }
  else
    if (memcmp(pFile->pMethods->xLock_signature, xLock_signatures[xLock_vfstraceLock_enum], sizeof(pFile->pMethods->xLock_signature)) == 0) {
      return vfstraceLock(pFile, eLock);
    }
  else
    if (memcmp(pFile->pMethods->xLock_signature, xLock_signatures[xLock_unixLock_enum], sizeof(pFile->pMethods->xLock_signature)) == 0) {
      return unixLock(pFile, eLock);
    }
  else
    if (memcmp(pFile->pMethods->xLock_signature, xLock_signatures[xLock_nolockLock_enum], sizeof(pFile->pMethods->xLock_signature)) == 0) {
      return nolockLock(pFile, eLock);
    }
  else
    if (memcmp(pFile->pMethods->xLock_signature, xLock_signatures[xLock_dotlockLock_enum], sizeof(pFile->pMethods->xLock_signature)) == 0) {
      return dotlockLock(pFile, eLock);
    }
}

/*
** Unlock an apnd-file.
*/
int apndUnlock(sqlite3_file *pFile, int eLock){
  pFile = ORIGFILE(pFile);
  // return pFile->pMethods->xUnlock(pFile, eLock);
  if (memcmp(pFile->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_0_enum], sizeof(pFile->pMethods->xUnlock_signature)) == 0) {
        0;
  }
  else
    if (memcmp(pFile->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_apndUnlock_enum], sizeof(pFile->pMethods->xUnlock_signature)) == 0) {
      return apndUnlock(pFile, eLock);
    }
  else
    if (memcmp(pFile->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_memdbUnlock_enum], sizeof(pFile->pMethods->xUnlock_signature)) == 0) {
      return memdbUnlock(pFile, eLock);
    }
  else
    if (memcmp(pFile->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_recoverVfsUnlock_enum], sizeof(pFile->pMethods->xUnlock_signature)) == 0) {
      return recoverVfsUnlock(pFile, eLock);
    }
  else
    if (memcmp(pFile->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_vfstraceUnlock_enum], sizeof(pFile->pMethods->xUnlock_signature)) == 0) {
      return vfstraceUnlock(pFile, eLock);
    }
  else
    if (memcmp(pFile->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_unixUnlock_enum], sizeof(pFile->pMethods->xUnlock_signature)) == 0) {
      return unixUnlock(pFile, eLock);
    }
  else
    if (memcmp(pFile->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_nolockUnlock_enum], sizeof(pFile->pMethods->xUnlock_signature)) == 0) {
      return nolockUnlock(pFile, eLock);
    }
  else
    if (memcmp(pFile->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_dotlockUnlock_enum], sizeof(pFile->pMethods->xUnlock_signature)) == 0) {
      return dotlockUnlock(pFile, eLock);
    }
}

/*
** Check if another file-handle holds a RESERVED lock on an apnd-file.
*/
int apndCheckReservedLock(sqlite3_file *pFile, int *pResOut){
  pFile = ORIGFILE(pFile);
  // return pFile->pMethods->xCheckReservedLock(pFile, pResOut);
  if (memcmp(pFile->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_0_enum], sizeof(pFile->pMethods->xCheckReservedLock_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pFile->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_apndCheckReservedLock_enum], sizeof(pFile->pMethods->xCheckReservedLock_signature)) == 0) {
      return apndCheckReservedLock(pFile, pResOut);
    }
  else
    if (memcmp(pFile->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_recoverVfsCheckReservedLock_enum], sizeof(pFile->pMethods->xCheckReservedLock_signature)) == 0) {
      return recoverVfsCheckReservedLock(pFile, pResOut);
    }
  else
    if (memcmp(pFile->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_vfstraceCheckReservedLock_enum], sizeof(pFile->pMethods->xCheckReservedLock_signature)) == 0) {
      return vfstraceCheckReservedLock(pFile, pResOut);
    }
  else
    if (memcmp(pFile->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_unixCheckReservedLock_enum], sizeof(pFile->pMethods->xCheckReservedLock_signature)) == 0) {
      return unixCheckReservedLock(pFile, pResOut);
    }
  else
    if (memcmp(pFile->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_nolockCheckReservedLock_enum], sizeof(pFile->pMethods->xCheckReservedLock_signature)) == 0) {
      return nolockCheckReservedLock(pFile, pResOut);
    }
  else
    if (memcmp(pFile->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_dotlockCheckReservedLock_enum], sizeof(pFile->pMethods->xCheckReservedLock_signature)) == 0) {
      return dotlockCheckReservedLock(pFile, pResOut);
    }
}

/*
** File control method. For custom operations on an apnd-file.
*/
int apndFileControl(sqlite3_file *pFile, int op, void *pArg){
  ApndFile *paf = (ApndFile *)pFile;
  int rc;
  pFile = ORIGFILE(pFile);
  if( op==SQLITE_FCNTL_SIZE_HINT ) *(sqlite3_int64*)pArg += paf->iPgOne;
  if (memcmp(pFile->pMethods->xFileControl_signature, xFileControl_signatures[xFileControl_0_enum], sizeof(pFile->pMethods->xFileControl_signature)) == 0) {
    rc = 0;
  }
  else
    if (memcmp(pFile->pMethods->xFileControl_signature, xFileControl_signatures[xFileControl_apndFileControl_enum], sizeof(pFile->pMethods->xFileControl_signature)) == 0) {
      rc = apndFileControl(pFile, op, pArg);
    }
  else
    if (memcmp(pFile->pMethods->xFileControl_signature, xFileControl_signatures[xFileControl_memdbFileControl_enum], sizeof(pFile->pMethods->xFileControl_signature)) == 0) {
      rc = memdbFileControl(pFile, op, pArg);
    }
  else
    if (memcmp(pFile->pMethods->xFileControl_signature, xFileControl_signatures[xFileControl_recoverVfsFileControl_enum], sizeof(pFile->pMethods->xFileControl_signature)) == 0) {
      rc = recoverVfsFileControl(pFile, op, pArg);
    }
  else
    if (memcmp(pFile->pMethods->xFileControl_signature, xFileControl_signatures[xFileControl_vfstraceFileControl_enum], sizeof(pFile->pMethods->xFileControl_signature)) == 0) {
      rc = vfstraceFileControl(pFile, op, pArg);
    }
  else
    if (memcmp(pFile->pMethods->xFileControl_signature, xFileControl_signatures[xFileControl_unixFileControl_enum], sizeof(pFile->pMethods->xFileControl_signature)) == 0) {
      rc = unixFileControl(pFile, op, pArg);
    }
  if( rc==SQLITE_OK && op==SQLITE_FCNTL_VFSNAME ){
    *(char**)pArg = sqlite3_mprintf("apnd(%lld)/%z", paf->iPgOne,*(char**)pArg);
  }
  return rc;
}

/*
** Return the sector-size in bytes for an apnd-file.
*/
int apndSectorSize(sqlite3_file *pFile){
  pFile = ORIGFILE(pFile);
  if (memcmp(pFile->pMethods->xSectorSize_signature, xSectorSize_signatures[xSectorSize_0_enum], sizeof(pFile->pMethods->xSectorSize_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pFile->pMethods->xSectorSize_signature, xSectorSize_signatures[xSectorSize_apndSectorSize_enum], sizeof(pFile->pMethods->xSectorSize_signature)) == 0) {
      return apndSectorSize(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xSectorSize_signature, xSectorSize_signatures[xSectorSize_recoverVfsSectorSize_enum], sizeof(pFile->pMethods->xSectorSize_signature)) == 0) {
      return recoverVfsSectorSize(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xSectorSize_signature, xSectorSize_signatures[xSectorSize_vfstraceSectorSize_enum], sizeof(pFile->pMethods->xSectorSize_signature)) == 0) {
      return vfstraceSectorSize(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xSectorSize_signature, xSectorSize_signatures[xSectorSize_unixSectorSize_enum], sizeof(pFile->pMethods->xSectorSize_signature)) == 0) {
      return unixSectorSize(pFile);
    }
}

/*
** Return the device characteristic flags supported by an apnd-file.
*/
int apndDeviceCharacteristics(sqlite3_file *pFile){
  pFile = ORIGFILE(pFile);
  if (memcmp(pFile->pMethods->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_0_enum], sizeof(pFile->pMethods->xDeviceCharacteristics_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pFile->pMethods->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_apndDeviceCharacteristics_enum], sizeof(pFile->pMethods->xDeviceCharacteristics_signature)) == 0) {
      return apndDeviceCharacteristics(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_memdbDeviceCharacteristics_enum], sizeof(pFile->pMethods->xDeviceCharacteristics_signature)) == 0) {
      return memdbDeviceCharacteristics(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_recoverVfsDeviceCharacteristics_enum], sizeof(pFile->pMethods->xDeviceCharacteristics_signature)) == 0) {
      return recoverVfsDeviceCharacteristics(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_vfstraceDeviceCharacteristics_enum], sizeof(pFile->pMethods->xDeviceCharacteristics_signature)) == 0) {
      return vfstraceDeviceCharacteristics(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_unixDeviceCharacteristics_enum], sizeof(pFile->pMethods->xDeviceCharacteristics_signature)) == 0) {
      return unixDeviceCharacteristics(pFile);
    }
}

/* Create a shared memory file mapping */
int apndShmMap(
  sqlite3_file *pFile,
  int iPg,
  int pgsz,
  int bExtend,
  void volatile **pp
){
  pFile = ORIGFILE(pFile);
  if (memcmp(pFile->pMethods->xShmMap_signature, xShmMap_signatures[xShmMap_0_enum], sizeof(pFile->pMethods->xShmMap_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pFile->pMethods->xShmMap_signature, xShmMap_signatures[xShmMap_apndShmMap_enum], sizeof(pFile->pMethods->xShmMap_signature)) == 0) {
      return apndShmMap(pFile, iPg, pgsz, bExtend, pp);
    }
  else
    if (memcmp(pFile->pMethods->xShmMap_signature, xShmMap_signatures[xShmMap_recoverVfsShmMap_enum], sizeof(pFile->pMethods->xShmMap_signature)) == 0) {
      return recoverVfsShmMap(pFile, iPg, pgsz, bExtend, pp);
    }
  else
    if (memcmp(pFile->pMethods->xShmMap_signature, xShmMap_signatures[xShmMap_unixShmMap_enum], sizeof(pFile->pMethods->xShmMap_signature)) == 0) {
      return unixShmMap(pFile, iPg, pgsz, bExtend, pp);
    }
}

/* Perform locking on a shared-memory segment */
int apndShmLock(sqlite3_file *pFile, int offset, int n, int flags){
  pFile = ORIGFILE(pFile);
  if (memcmp(pFile->pMethods->xShmLock_signature, xShmLock_signatures[xShmLock_0_enum], sizeof(pFile->pMethods->xShmLock_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pFile->pMethods->xShmLock_signature, xShmLock_signatures[xShmLock_apndShmLock_enum], sizeof(pFile->pMethods->xShmLock_signature)) == 0) {
      return apndShmLock(pFile, offset, n, flags);
    }
  else
    if (memcmp(pFile->pMethods->xShmLock_signature, xShmLock_signatures[xShmLock_recoverVfsShmLock_enum], sizeof(pFile->pMethods->xShmLock_signature)) == 0) {
      return recoverVfsShmLock(pFile, offset, n, flags);
    }
  else
    if (memcmp(pFile->pMethods->xShmLock_signature, xShmLock_signatures[xShmLock_unixShmLock_enum], sizeof(pFile->pMethods->xShmLock_signature)) == 0) {
      return unixShmLock(pFile, offset, n, flags);
    }
}

/* Memory barrier operation on shared memory */
void apndShmBarrier(sqlite3_file *pFile){
  pFile = ORIGFILE(pFile);
  if (memcmp(pFile->pMethods->xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_0_enum], sizeof(pFile->pMethods->xShmBarrier_signature)) == 0) {
    0;
  }
  else
    if (memcmp(pFile->pMethods->xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_apndShmBarrier_enum], sizeof(pFile->pMethods->xShmBarrier_signature)) == 0) {
      apndShmBarrier(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_recoverVfsShmBarrier_enum], sizeof(pFile->pMethods->xShmBarrier_signature)) == 0) {
      recoverVfsShmBarrier(pFile);
    }
  else
    if (memcmp(pFile->pMethods->xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_unixShmBarrier_enum], sizeof(pFile->pMethods->xShmBarrier_signature)) == 0) {
      unixShmBarrier(pFile);
    }
}

/* Unmap a shared memory segment */
int apndShmUnmap(sqlite3_file *pFile, int deleteFlag){
  pFile = ORIGFILE(pFile);
  if (memcmp(pFile->pMethods->xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_0_enum], sizeof(pFile->pMethods->xShmUnmap_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pFile->pMethods->xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_apndShmUnmap_enum], sizeof(pFile->pMethods->xShmUnmap_signature)) == 0) {
      return apndShmUnmap(pFile, deleteFlag);
    }
  else
    if (memcmp(pFile->pMethods->xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_recoverVfsShmUnmap_enum], sizeof(pFile->pMethods->xShmUnmap_signature)) == 0) {
      return recoverVfsShmUnmap(pFile, deleteFlag);
    }
  else
    if (memcmp(pFile->pMethods->xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_unixShmUnmap_enum], sizeof(pFile->pMethods->xShmUnmap_signature)) == 0) {
      return unixShmUnmap(pFile, deleteFlag);
    }
}

/* Fetch a page of a memory-mapped file */
int apndFetch(
  sqlite3_file *pFile,
  sqlite3_int64 iOfst,
  int iAmt,
  void **pp
){
  ApndFile *p = (ApndFile *)pFile;
  if( p->iMark < 0 || iOfst+iAmt > p->iMark ){
    return SQLITE_IOERR; /* Cannot read what is not yet there. */
  }
  pFile = ORIGFILE(pFile);
  if (memcmp(pFile->pMethods->xFetch_signature, xFetch_signatures[xFetch_0_enum], sizeof(pFile->pMethods->xFetch_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pFile->pMethods->xFetch_signature, xFetch_signatures[xFetch_apndFetch_enum], sizeof(pFile->pMethods->xFetch_signature)) == 0) {
      return apndFetch(pFile, iOfst + p->iPgOne, iAmt, pp);
    }
  else
    if (memcmp(pFile->pMethods->xFetch_signature, xFetch_signatures[xFetch_memdbFetch_enum], sizeof(pFile->pMethods->xFetch_signature)) == 0) {
      return memdbFetch(pFile, iOfst + p->iPgOne, iAmt, pp);
    }
  // else
  //   if (memcmp(pFile->pMethods->xFetch_signature, xFetch_signatures[xFetch_pcache1Fetch_enum], sizeof(pFile->pMethods->xFetch_signature)) == 0) {
  //     return pcache1Fetch(pFile, iOfst + p->iPgOne, iAmt, pp);
  //   }
  // else
  //   if (memcmp(pFile->pMethods->xFetch_signature, xFetch_signatures[xFetch_pcachetraceFetch_enum], sizeof(pFile->pMethods->xFetch_signature)) == 0) {
  //     return pcachetraceFetch(pFile, iOfst + p->iPgOne, iAmt, pp);
  //   }
  else
    if (memcmp(pFile->pMethods->xFetch_signature, xFetch_signatures[xFetch_recoverVfsFetch_enum], sizeof(pFile->pMethods->xFetch_signature)) == 0) {
      return recoverVfsFetch(pFile, iOfst + p->iPgOne, iAmt, pp);
    }
  else
    if (memcmp(pFile->pMethods->xFetch_signature, xFetch_signatures[xFetch_unixFetch_enum], sizeof(pFile->pMethods->xFetch_signature)) == 0) {
      return unixFetch(pFile, iOfst + p->iPgOne, iAmt, pp);
    }
}

/* Release a memory-mapped page */
int apndUnfetch(sqlite3_file *pFile, sqlite3_int64 iOfst, void *pPage){
  ApndFile *p = (ApndFile *)pFile;
  pFile = ORIGFILE(pFile);
  if (memcmp(pFile->pMethods->xUnfetch_signature, xUnfetch_signatures[xUnfetch_0_enum], sizeof(pFile->pMethods->xUnfetch_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pFile->pMethods->xUnfetch_signature, xUnfetch_signatures[xUnfetch_apndUnfetch_enum], sizeof(pFile->pMethods->xUnfetch_signature)) == 0) {
      return apndUnfetch(pFile, iOfst + p->iPgOne, pPage);
    }
  else
    if (memcmp(pFile->pMethods->xUnfetch_signature, xUnfetch_signatures[xUnfetch_memdbUnfetch_enum], sizeof(pFile->pMethods->xUnfetch_signature)) == 0) {
      return memdbUnfetch(pFile, iOfst + p->iPgOne, pPage);
    }
  else
    if (memcmp(pFile->pMethods->xUnfetch_signature, xUnfetch_signatures[xUnfetch_recoverVfsUnfetch_enum], sizeof(pFile->pMethods->xUnfetch_signature)) == 0) {
      return recoverVfsUnfetch(pFile, iOfst + p->iPgOne, pPage);
    }
  else
    if (memcmp(pFile->pMethods->xUnfetch_signature, xUnfetch_signatures[xUnfetch_unixUnfetch_enum], sizeof(pFile->pMethods->xUnfetch_signature)) == 0) {
      return unixUnfetch(pFile, iOfst + p->iPgOne, pPage);
    }
}

/*
** Try to read the append-mark off the end of a file.  Return the
** start of the appended database if the append-mark is present.
** If there is no valid append-mark, return -1;
**
** An append-mark is only valid if the NNNNNNNN start-of-database offset
** indicates that the appended database contains at least one page.  The
** start-of-database value must be a multiple of 512.
*/
static sqlite3_int64 apndReadMark(sqlite3_int64 sz, sqlite3_file *pFile){
  int rc, i;
  sqlite3_int64 iMark;
  int msbs = 8 * (APND_MARK_FOS_SZ-1);
  unsigned char a[APND_MARK_SIZE];

  if( APND_MARK_SIZE!=(sz & 0x1ff) ) return -1;
  if (memcmp(pFile->pMethods->xRead_signature, xRead_signatures[xRead_apndRead_enum], sizeof(pFile->pMethods->xRead_signature)) == 0) {
    rc = apndRead(pFile, a, APND_MARK_SIZE, sz - APND_MARK_SIZE);
  }
  else
    if (memcmp(pFile->pMethods->xRead_signature, xRead_signatures[xRead_memdbRead_enum], sizeof(pFile->pMethods->xRead_signature)) == 0) {
      rc = memdbRead(pFile, a, APND_MARK_SIZE, sz - APND_MARK_SIZE);
    }
  else
    if (memcmp(pFile->pMethods->xRead_signature, xRead_signatures[xRead_memjrnlRead_enum], sizeof(pFile->pMethods->xRead_signature)) == 0) {
      rc = memjrnlRead(pFile, a, APND_MARK_SIZE, sz - APND_MARK_SIZE);
    }
  else
    if (memcmp(pFile->pMethods->xRead_signature, xRead_signatures[xRead_recoverVfsRead_enum], sizeof(pFile->pMethods->xRead_signature)) == 0) {
      rc = recoverVfsRead(pFile, a, APND_MARK_SIZE, sz - APND_MARK_SIZE);
    }
  else
    if (memcmp(pFile->pMethods->xRead_signature, xRead_signatures[xRead_vfstraceRead_enum], sizeof(pFile->pMethods->xRead_signature)) == 0) {
      rc = vfstraceRead(pFile, a, APND_MARK_SIZE, sz - APND_MARK_SIZE);
    }
  else
    if (memcmp(pFile->pMethods->xRead_signature, xRead_signatures[xRead_unixRead_enum], sizeof(pFile->pMethods->xRead_signature)) == 0) {
      rc = unixRead(pFile, a, APND_MARK_SIZE, sz - APND_MARK_SIZE);
    }
  if( rc ) return -1;
  if( memcmp(a, APND_MARK_PREFIX, APND_MARK_PREFIX_SZ)!=0 ) return -1;
  iMark = ((sqlite3_int64)(a[APND_MARK_PREFIX_SZ] & 0x7f)) << msbs;
  for(i=1; i<8; i++){
    msbs -= 8;
    iMark |= (sqlite3_int64)a[APND_MARK_PREFIX_SZ+i]<<msbs;
  }
  if( iMark > (sz - APND_MARK_SIZE - 512) ) return -1;
  if( iMark & 0x1ff ) return -1;
  return iMark;
}

static const char apvfsSqliteHdr[] = "SQLite format 3";
/*
** Check to see if the file is an appendvfs SQLite database file.
** Return true iff it is such. Parameter sz is the file's size.
*/
static int apndIsAppendvfsDatabase(sqlite3_int64 sz, sqlite3_file *pFile){
  int rc;
  char zHdr[16];
  sqlite3_int64 iMark = apndReadMark(sz, pFile);
  if( iMark>=0 ){
    /* If file has the correct end-marker, the expected odd size, and the
    ** SQLite DB type marker where the end-marker puts it, then it
    ** is an appendvfs database.
    */
    if (memcmp(pFile->pMethods->xRead_signature, xRead_signatures[xRead_apndRead_enum], sizeof(pFile->pMethods->xRead_signature)) == 0) {
      rc = apndRead(pFile, zHdr, sizeof(zHdr), iMark);
    }
    else
      if (memcmp(pFile->pMethods->xRead_signature, xRead_signatures[xRead_memdbRead_enum], sizeof(pFile->pMethods->xRead_signature)) == 0) {
        rc = memdbRead(pFile, zHdr, sizeof(zHdr), iMark);
      }
    else
      if (memcmp(pFile->pMethods->xRead_signature, xRead_signatures[xRead_memjrnlRead_enum], sizeof(pFile->pMethods->xRead_signature)) == 0) {
        rc = memjrnlRead(pFile, zHdr, sizeof(zHdr), iMark);
      }
    else
      if (memcmp(pFile->pMethods->xRead_signature, xRead_signatures[xRead_recoverVfsRead_enum], sizeof(pFile->pMethods->xRead_signature)) == 0) {
        rc = recoverVfsRead(pFile, zHdr, sizeof(zHdr), iMark);
      }
    else
      if (memcmp(pFile->pMethods->xRead_signature, xRead_signatures[xRead_vfstraceRead_enum], sizeof(pFile->pMethods->xRead_signature)) == 0) {
        rc = vfstraceRead(pFile, zHdr, sizeof(zHdr), iMark);
      }
    else
      if (memcmp(pFile->pMethods->xRead_signature, xRead_signatures[xRead_unixRead_enum], sizeof(pFile->pMethods->xRead_signature)) == 0) {
        rc = unixRead(pFile, zHdr, sizeof(zHdr), iMark);
      }
    if( SQLITE_OK==rc
     && memcmp(zHdr, apvfsSqliteHdr, sizeof(zHdr))==0
     && (sz & 0x1ff) == APND_MARK_SIZE
     && sz>=512+APND_MARK_SIZE
    ){
      return 1; /* It's an appendvfs database */
    }
  }
  return 0;
}

/*
** Check to see if the file is an ordinary SQLite database file.
** Return true iff so. Parameter sz is the file's size.
*/
static int apndIsOrdinaryDatabaseFile(sqlite3_int64 sz, sqlite3_file *pFile){
  char zHdr[16];
  // if( apndIsAppendvfsDatabase(sz, pFile) /* rule 2 */
  //  || (sz & 0x1ff) != 0
  //  || SQLITE_OK!=pFile->pMethods->xRead(pFile, zHdr, sizeof(zHdr), 0)
  //  || memcmp(zHdr, apvfsSqliteHdr, sizeof(zHdr))!=0
  // ){
  //   return 0;
  // }else{
  //   return 1;
  // }
  int rc = pFile->pMethods->xRead(pFile, zHdr, sizeof(zHdr), 0);
  if( apndIsAppendvfsDatabase(sz, pFile) /* rule 2 */
   || (sz & 0x1ff) != 0
   || SQLITE_OK!=rc
   || memcmp(zHdr, apvfsSqliteHdr, sizeof(zHdr))!=0
  ){
    return 0;
  }else{
    return 1;
  }
}

/*
** Open an apnd file handle.
*/
int apndOpen(
  sqlite3_vfs *pApndVfs,
  const char *zName,
  sqlite3_file *pFile,
  int flags,
  int *pOutFlags
){
  ApndFile *pApndFile = (ApndFile*)pFile;
  sqlite3_file *pBaseFile = ORIGFILE(pFile);
  sqlite3_vfs *pBaseVfs = ORIGVFS(pApndVfs);
  int rc;
  sqlite3_int64 sz = 0;
  if( (flags & SQLITE_OPEN_MAIN_DB)==0 ){
    /* The appendvfs is not to be used for transient or temporary databases.
    ** Just use the base VFS open to initialize the given file object and
    ** open the underlying file. (Appendvfs is then unused for this file.)
    */
    // if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_amatchOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //   return amatchOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    // }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_apndOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return apndOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_binfoOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return binfoOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_bytecodevtabOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return bytecodevtabOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_carrayOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return carrayOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_cidxOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return cidxOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_closureOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return closureOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_completionOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return completionOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_csvtabOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return csvtabOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_dbdataOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return dbdataOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_dbpageOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return dbpageOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_deltaparsevtabOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return deltaparsevtabOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_echoOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return echoOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_expertOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return expertOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_explainOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return explainOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_fsOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return fsOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_fsdirOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return fsdirOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_fstreeOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return fstreeOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_fts3OpenMethod_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return fts3OpenMethod(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_fts3auxOpenMethod_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return fts3auxOpenMethod(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_fts3termOpenMethod_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return fts3termOpenMethod(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_fts3tokOpenMethod_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return fts3tokOpenMethod(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_fuzzerOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return fuzzerOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_intarrayOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return intarrayOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return jsonEachOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpenEach_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return jsonEachOpenEach(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpenTree_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return jsonEachOpenTree(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
      if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_memdbOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
        return memdbOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
      }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_memstatOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return memstatOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_porterOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return porterOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_pragmaVtabOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return pragmaVtabOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_prefixesOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return prefixesOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_qpvtabOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return qpvtabOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_rtreeOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return rtreeOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_schemaOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return schemaOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_seriesOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return seriesOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_simpleOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return simpleOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_spellfix1Open_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return spellfix1Open(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_statOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return statOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_stmtOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return stmtOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_tclOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return tclOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_tclvarOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return tclvarOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_templatevtabOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return templatevtabOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_unicodeOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return unicodeOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_unionOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return unionOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    else
      if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_vfstraceOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
        return vfstraceOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
      }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_vstattabOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return vstattabOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_vtablogOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return vtablogOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_wholenumberOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return wholenumberOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    // else
    //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_zipfileOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
    //     return zipfileOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
    //   }
    else
      if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_unixOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
        return unixOpen(pBaseVfs, zName, pFile, flags, pOutFlags);
      }
  }
  memset(pApndFile, 0, sizeof(ApndFile));
  pFile->pMethods = &apnd_io_methods;
  pApndFile->iMark = -1;    /* Append mark not yet written */

  // if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_amatchOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //   rc = amatchOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  // }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_apndOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = apndOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_binfoOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = binfoOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_bytecodevtabOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = bytecodevtabOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_carrayOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = carrayOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_cidxOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = cidxOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_closureOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = closureOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_completionOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = completionOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_csvtabOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = csvtabOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_dbdataOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = dbdataOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_dbpageOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = dbpageOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_deltaparsevtabOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = deltaparsevtabOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_echoOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = echoOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_expertOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = expertOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_explainOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = explainOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_fsOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = fsOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_fsdirOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = fsdirOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_fstreeOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = fstreeOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_fts3OpenMethod_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = fts3OpenMethod(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_fts3auxOpenMethod_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = fts3auxOpenMethod(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_fts3termOpenMethod_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = fts3termOpenMethod(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_fts3tokOpenMethod_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = fts3tokOpenMethod(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_fuzzerOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = fuzzerOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_intarrayOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = intarrayOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = jsonEachOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpenEach_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = jsonEachOpenEach(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpenTree_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = jsonEachOpenTree(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
    if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_memdbOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
      rc = memdbOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
    }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_memstatOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = memstatOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_porterOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = porterOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_pragmaVtabOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = pragmaVtabOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_prefixesOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = prefixesOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_qpvtabOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = qpvtabOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_rtreeOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = rtreeOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_schemaOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = schemaOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_seriesOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = seriesOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_simpleOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = simpleOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_spellfix1Open_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = spellfix1Open(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_statOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = statOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_stmtOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = stmtOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_tclOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = tclOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_tclvarOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = tclvarOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_templatevtabOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = templatevtabOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_unicodeOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = unicodeOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_unionOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = unionOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  else
    if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_vfstraceOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
      rc = vfstraceOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
    }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_vstattabOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = vstattabOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_vtablogOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = vtablogOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_wholenumberOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = wholenumberOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  // else
  //   if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_zipfileOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
  //     rc = zipfileOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
  //   }
  else
    if (memcmp(pBaseVfs->xOpen_signature, xOpen_signatures[xOpen_unixOpen_enum], sizeof(pBaseVfs->xOpen_signature)) == 0) {
      rc = unixOpen(pBaseVfs, zName, pBaseFile, flags, pOutFlags);
    }
  if( rc==SQLITE_OK ){
    if (memcmp(pBaseFile->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_apndFileSize_enum], sizeof(pBaseFile->pMethods->xFileSize_signature)) == 0) {
      rc = apndFileSize(pBaseFile, &sz);
    }
    else
      if (memcmp(pBaseFile->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_memdbFileSize_enum], sizeof(pBaseFile->pMethods->xFileSize_signature)) == 0) {
        rc = memdbFileSize(pBaseFile, &sz);
      }
    else
      if (memcmp(pBaseFile->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_memjrnlFileSize_enum], sizeof(pBaseFile->pMethods->xFileSize_signature)) == 0) {
        rc = memjrnlFileSize(pBaseFile, &sz);
      }
    else
      if (memcmp(pBaseFile->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_recoverVfsFileSize_enum], sizeof(pBaseFile->pMethods->xFileSize_signature)) == 0) {
        rc = recoverVfsFileSize(pBaseFile, &sz);
      }
    else
      if (memcmp(pBaseFile->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_vfstraceFileSize_enum], sizeof(pBaseFile->pMethods->xFileSize_signature)) == 0) {
        rc = vfstraceFileSize(pBaseFile, &sz);
      }
    else
      if (memcmp(pBaseFile->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_unixFileSize_enum], sizeof(pBaseFile->pMethods->xFileSize_signature)) == 0) {
        rc = unixFileSize(pBaseFile, &sz);
      }
    if( rc ){
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_apndClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        apndClose(pBaseFile);
      }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_bytecodevtabClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          bytecodevtabClose(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_completionClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          completionClose(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_dbdataClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          dbdataClose(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_dbpageClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          dbpageClose(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_expertClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          expertClose(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_fsdirClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          fsdirClose(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_fts3CloseMethod_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          fts3CloseMethod(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_fts3auxCloseMethod_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          fts3auxCloseMethod(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_fts3tokCloseMethod_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          fts3tokCloseMethod(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_jsonEachClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          jsonEachClose(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_memdbClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          memdbClose(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_memjrnlClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          memjrnlClose(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_porterClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          porterClose(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_pragmaVtabClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          pragmaVtabClose(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_recoverVfsClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          recoverVfsClose(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_rtreeClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          rtreeClose(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_seriesClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          seriesClose(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_simpleClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          simpleClose(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_statClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          statClose(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_stmtClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          stmtClose(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_unicodeClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          unicodeClose(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_vfstraceClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          vfstraceClose(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_zipfileClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          zipfileClose(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_unixClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          unixClose(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_nolockClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          nolockClose(pBaseFile);
        }
      else
        if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_dotlockClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
          dotlockClose(pBaseFile);
        }
    }
  }
  if( rc ){
    pFile->pMethods = 0;
    return rc;
  }
  if( apndIsOrdinaryDatabaseFile(sz, pBaseFile) ){
    /* The file being opened appears to be just an ordinary DB. Copy
    ** the base dispatch-table so this instance mimics the base VFS. 
    */
    memmove(pApndFile, pBaseFile, pBaseVfs->szOsFile);
    return SQLITE_OK;
  }
  pApndFile->iPgOne = apndReadMark(sz, pFile);
  if( pApndFile->iPgOne>=0 ){
    pApndFile->iMark = sz - APND_MARK_SIZE; /* Append mark found */
    return SQLITE_OK;
  }
  if( (flags & SQLITE_OPEN_CREATE)==0 ){
    if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_apndClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
      apndClose(pBaseFile);
    }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_bytecodevtabClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        bytecodevtabClose(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_completionClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        completionClose(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_dbdataClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        dbdataClose(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_dbpageClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        dbpageClose(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_expertClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        expertClose(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_fsdirClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        fsdirClose(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_fts3CloseMethod_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        fts3CloseMethod(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_fts3auxCloseMethod_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        fts3auxCloseMethod(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_fts3tokCloseMethod_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        fts3tokCloseMethod(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_jsonEachClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        jsonEachClose(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_memdbClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        memdbClose(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_memjrnlClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        memjrnlClose(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_porterClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        porterClose(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_pragmaVtabClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        pragmaVtabClose(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_recoverVfsClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        recoverVfsClose(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_rtreeClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        rtreeClose(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_seriesClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        seriesClose(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_simpleClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        simpleClose(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_statClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        statClose(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_stmtClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        stmtClose(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_unicodeClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        unicodeClose(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_vfstraceClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        vfstraceClose(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_zipfileClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        zipfileClose(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_unixClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        unixClose(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_nolockClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        nolockClose(pBaseFile);
      }
    else
      if (memcmp(pBaseFile->pMethods->xClose_signature, xClose_signatures[xClose_dotlockClose_enum], sizeof(pBaseFile->pMethods->xClose_signature)) == 0) {
        dotlockClose(pBaseFile);
      }
    rc = SQLITE_CANTOPEN;
    pFile->pMethods = 0;
  }else{
    /* Round newly added appendvfs location to #define'd page boundary. 
    ** Note that nothing has yet been written to the underlying file.
    ** The append mark will be written along with first content write.
    ** Until then, paf->iMark value indicates it is not yet written.
    */
    pApndFile->iPgOne = APND_START_ROUNDUP(sz);
  }
  return rc;
}

/*
** Delete an apnd file.
** For an appendvfs, this could mean delete the appendvfs portion,
** leaving the appendee as it was before it gained an appendvfs.
** For now, this code deletes the underlying file too.
*/
int apndDelete(sqlite3_vfs *pVfs, const char *zPath, int dirSync){
  if (memcmp(ORIGVFS(pVfs)->xDelete_signature, xDelete_signatures[xDelete_0_enum], sizeof(ORIGVFS(pVfs)->xDelete_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(ORIGVFS(pVfs)->xDelete_signature, xDelete_signatures[xDelete_apndDelete_enum], sizeof(ORIGVFS(pVfs)->xDelete_signature)) == 0) {
      return apndDelete(ORIGVFS(pVfs), zPath, dirSync);
    }
  // else
  //   if (memcmp(ORIGVFS(pVfs)->xDelete_signature, xDelete_signatures[xDelete_f5tOrigintextDelete_enum], sizeof(ORIGVFS(pVfs)->xDelete_signature)) == 0) {
  //     return f5tOrigintextDelete(ORIGVFS(pVfs), zPath, dirSync);
  //   }
  // else
  //   if (memcmp(ORIGVFS(pVfs)->xDelete_signature, xDelete_signatures[xDelete_f5tTokenizerDelete_enum], sizeof(ORIGVFS(pVfs)->xDelete_signature)) == 0) {
  //     return f5tTokenizerDelete(ORIGVFS(pVfs), zPath, dirSync);
  //   }
  // else
  //   if (memcmp(ORIGVFS(pVfs)->xDelete_signature, xDelete_signatures[xDelete_kvstorageDelete_enum], sizeof(ORIGVFS(pVfs)->xDelete_signature)) == 0) {
  //     return kvstorageDelete(ORIGVFS(pVfs), zPath, dirSync);
  //   }
  else
    if (memcmp(ORIGVFS(pVfs)->xDelete_signature, xDelete_signatures[xDelete_vfstraceDelete_enum], sizeof(ORIGVFS(pVfs)->xDelete_signature)) == 0) {
      return vfstraceDelete(ORIGVFS(pVfs), zPath, dirSync);
    }
  else
    if (memcmp(ORIGVFS(pVfs)->xDelete_signature, xDelete_signatures[xDelete_unixDelete_enum], sizeof(ORIGVFS(pVfs)->xDelete_signature)) == 0) {
      return unixDelete(ORIGVFS(pVfs), zPath, dirSync);
    }
}

/*
** All other VFS methods are pass-thrus.
*/
int apndAccess(
  sqlite3_vfs *pVfs, 
  const char *zPath, 
  int flags, 
  int *pResOut
){
  printf("apndAccess\n");
  if (memcmp(ORIGVFS(pVfs)->xAccess_signature, xAccess_signatures[xAccess_apndAccess_enum], sizeof(ORIGVFS(pVfs)->xAccess_signature)) == 0) {
    return apndAccess(ORIGVFS(pVfs), zPath, flags, pResOut);
  }
  else
    if (memcmp(ORIGVFS(pVfs)->xAccess_signature, xAccess_signatures[xAccess_memdbAccess_enum], sizeof(ORIGVFS(pVfs)->xAccess_signature)) == 0) {
      return memdbAccess(ORIGVFS(pVfs), zPath, flags, pResOut);
    }
  else
    if (memcmp(ORIGVFS(pVfs)->xAccess_signature, xAccess_signatures[xAccess_vfstraceAccess_enum], sizeof(ORIGVFS(pVfs)->xAccess_signature)) == 0) {
      return vfstraceAccess(ORIGVFS(pVfs), zPath, flags, pResOut);
    }
  else
    if (memcmp(ORIGVFS(pVfs)->xAccess_signature, xAccess_signatures[xAccess_unixAccess_enum], sizeof(ORIGVFS(pVfs)->xAccess_signature)) == 0) {
      return unixAccess(ORIGVFS(pVfs), zPath, flags, pResOut);
    }
}
int apndFullPathname(
  sqlite3_vfs *pVfs, 
  const char *zPath, 
  int nOut, 
  char *zOut
){
  if (memcmp(ORIGVFS(pVfs)->xFullPathname_signature, xFullPathname_signatures[xFullPathname_apndFullPathname_enum], sizeof(ORIGVFS(pVfs)->xFullPathname_signature)) == 0) {
    return apndFullPathname(ORIGVFS(pVfs), zPath, nOut, zOut);
  }
  else
    if (memcmp(ORIGVFS(pVfs)->xFullPathname_signature, xFullPathname_signatures[xFullPathname_memdbFullPathname_enum], sizeof(ORIGVFS(pVfs)->xFullPathname_signature)) == 0) {
      return memdbFullPathname(ORIGVFS(pVfs), zPath, nOut, zOut);
    }
  else
    if (memcmp(ORIGVFS(pVfs)->xFullPathname_signature, xFullPathname_signatures[xFullPathname_vfstraceFullPathname_enum], sizeof(ORIGVFS(pVfs)->xFullPathname_signature)) == 0) {
      return vfstraceFullPathname(ORIGVFS(pVfs), zPath, nOut, zOut);
    }
  else
    if (memcmp(ORIGVFS(pVfs)->xFullPathname_signature, xFullPathname_signatures[xFullPathname_unixFullPathname_enum], sizeof(ORIGVFS(pVfs)->xFullPathname_signature)) == 0) {
      return unixFullPathname(ORIGVFS(pVfs), zPath, nOut, zOut);
    }
}
void *apndDlOpen(sqlite3_vfs *pVfs, const char *zPath){
  if (memcmp(ORIGVFS(pVfs)->xDlOpen_signature, xDlOpen_signatures[xDlOpen_apndDlOpen_enum], sizeof(ORIGVFS(pVfs)->xDlOpen_signature)) == 0) {
    return apndDlOpen(ORIGVFS(pVfs), zPath);
  }
  else
    if (memcmp(ORIGVFS(pVfs)->xDlOpen_signature, xDlOpen_signatures[xDlOpen_memdbDlOpen_enum], sizeof(ORIGVFS(pVfs)->xDlOpen_signature)) == 0) {
      return memdbDlOpen(ORIGVFS(pVfs), zPath);
    }
  else
    if (memcmp(ORIGVFS(pVfs)->xDlOpen_signature, xDlOpen_signatures[xDlOpen_unixDlOpen_enum], sizeof(ORIGVFS(pVfs)->xDlOpen_signature)) == 0) {
      return unixDlOpen(ORIGVFS(pVfs), zPath);
    }
}
void apndDlError(sqlite3_vfs *pVfs, int nByte, char *zErrMsg){
  if (memcmp(ORIGVFS(pVfs)->xDlError_signature, xDlError_signatures[xDlError_0_enum], sizeof(ORIGVFS(pVfs)->xDlError_signature)) == 0) {
    0;
  }
  else
    if (memcmp(ORIGVFS(pVfs)->xDlError_signature, xDlError_signatures[xDlError_apndDlError_enum], sizeof(ORIGVFS(pVfs)->xDlError_signature)) == 0) {
      apndDlError(ORIGVFS(pVfs), nByte, zErrMsg);
    }
  else
    if (memcmp(ORIGVFS(pVfs)->xDlError_signature, xDlError_signatures[xDlError_memdbDlError_enum], sizeof(ORIGVFS(pVfs)->xDlError_signature)) == 0) {
      memdbDlError(ORIGVFS(pVfs), nByte, zErrMsg);
    }
  else
    if (memcmp(ORIGVFS(pVfs)->xDlError_signature, xDlError_signatures[xDlError_unixDlError_enum], sizeof(ORIGVFS(pVfs)->xDlError_signature)) == 0) {
      unixDlError(ORIGVFS(pVfs), nByte, zErrMsg);
    }
}

void (*apndDlSym(sqlite3_vfs *pVfs, void *p, const char *zSym))(void){
  // return ORIGVFS(pVfs)->xDlSym(ORIGVFS(pVfs), p, zSym);
  if (memcmp(ORIGVFS(pVfs)->xDlSym_signature, xDlSym_signatures[xDlSym_0_enum], sizeof(ORIGVFS(pVfs)->xDlSym_signature)) == 0) {
  return 0;
  }
else
  if (memcmp(ORIGVFS(pVfs)->xDlSym_signature, xDlSym_signatures[xDlSym_apndDlSym_enum], sizeof(ORIGVFS(pVfs)->xDlSym_signature)) == 0) {
    return apndDlSym(ORIGVFS(pVfs), p, zSym);
  }
// else
//   if (memcmp(ORIGVFS(pVfs)->xDlSym_signature, xDlSym_signatures[xDlSym_cfDlSym_enum], sizeof(ORIGVFS(pVfs)->xDlSym_signature)) == 0) {
//     return cfDlSym(ORIGVFS(pVfs), p, zSym);
//   }
// else
//   if (memcmp(ORIGVFS(pVfs)->xDlSym_signature, xDlSym_signatures[xDlSym_cksmDlSym_enum], sizeof(ORIGVFS(pVfs)->xDlSym_signature)) == 0) {
//     return cksmDlSym(ORIGVFS(pVfs), p, zSym);
//   }
//   else
//   if (memcmp(ORIGVFS(pVfs)->xDlSym_signature, xDlSym_signatures[xDlSym_demoDlSym_enum], sizeof(ORIGVFS(pVfs)->xDlSym_signature)) == 0) {
//     return demoDlSym(ORIGVFS(pVfs), p, zSym);
//   }
// else
//   if (memcmp(ORIGVFS(pVfs)->xDlSym_signature, xDlSym_signatures[xDlSym_devsymDlSym_enum], sizeof(ORIGVFS(pVfs)->xDlSym_signature)) == 0) {
//     return devsymDlSym(ORIGVFS(pVfs), p, zSym);
//   }
//   else
//   if (memcmp(ORIGVFS(pVfs)->xDlSym_signature, xDlSym_signatures[xDlSym_jtDlSym_enum], sizeof(ORIGVFS(pVfs)->xDlSym_signature)) == 0) {
//     return jtDlSym(ORIGVFS(pVfs), p, zSym);
//   }
// else
//   if (memcmp(ORIGVFS(pVfs)->xDlSym_signature, xDlSym_signatures[xDlSym_memDlSym_enum], sizeof(ORIGVFS(pVfs)->xDlSym_signature)) == 0) {
//     return memDlSym(ORIGVFS(pVfs), p, zSym);
//   }
  else
  if (memcmp(ORIGVFS(pVfs)->xDlSym_signature, xDlSym_signatures[xDlSym_memdbDlSym_enum], sizeof(ORIGVFS(pVfs)->xDlSym_signature)) == 0) {
    return memdbDlSym(ORIGVFS(pVfs), p, zSym);
  }
  // else
  // if (memcmp(ORIGVFS(pVfs)->xDlSym_signature, xDlSym_signatures[xDlSym_multiplexDlSym_enum], sizeof(ORIGVFS(pVfs)->xDlSym_signature)) == 0) {
  //   return multiplexDlSym(ORIGVFS(pVfs), p, zSym);
  // }
  // else
  // if (memcmp(ORIGVFS(pVfs)->xDlSym_signature, xDlSym_signatures[xDlSym_rbuVfsDlSym_enum], sizeof(ORIGVFS(pVfs)->xDlSym_signature)) == 0) {
  //   return rbuVfsDlSym(ORIGVFS(pVfs), p, zSym);
  // }
  // else
  // if (memcmp(ORIGVFS(pVfs)->xDlSym_signature, xDlSym_signatures[xDlSym_tvfsDlSym_enum], sizeof(ORIGVFS(pVfs)->xDlSym_signature)) == 0) {
  //   return tvfsDlSym(ORIGVFS(pVfs), p, zSym);
  // }
  // else
  // if (memcmp(ORIGVFS(pVfs)->xDlSym_signature, xDlSym_signatures[xDlSym_vfslogDlSym_enum], sizeof(ORIGVFS(pVfs)->xDlSym_signature)) == 0) {
  //   return vfslogDlSym(ORIGVFS(pVfs), p, zSym);
  // }
  // else
  // if (memcmp(ORIGVFS(pVfs)->xDlSym_signature, xDlSym_signatures[xDlSym_winDlSym_enum], sizeof(ORIGVFS(pVfs)->xDlSym_signature)) == 0) {
  //   return winDlSym(ORIGVFS(pVfs), p, zSym);
  // }
  else
  if (memcmp(ORIGVFS(pVfs)->xDlSym_signature, xDlSym_signatures[xDlSym_unixDlSym_enum], sizeof(ORIGVFS(pVfs)->xDlSym_signature)) == 0) {
    return unixDlSym(ORIGVFS(pVfs), p, zSym);
  }
}

void apndDlClose(sqlite3_vfs *pVfs, void *pHandle){
  if (memcmp(ORIGVFS(pVfs)->xDlClose_signature, xDlClose_signatures[xDlClose_0_enum], sizeof(ORIGVFS(pVfs)->xDlClose_signature)) == 0) {
    0;
  }
  else
    if (memcmp(ORIGVFS(pVfs)->xDlClose_signature, xDlClose_signatures[xDlClose_apndDlClose_enum], sizeof(ORIGVFS(pVfs)->xDlClose_signature)) == 0) {
      apndDlClose(ORIGVFS(pVfs), pHandle);
    }
  else
    if (memcmp(ORIGVFS(pVfs)->xDlClose_signature, xDlClose_signatures[xDlClose_memdbDlClose_enum], sizeof(ORIGVFS(pVfs)->xDlClose_signature)) == 0) {
      memdbDlClose(ORIGVFS(pVfs), pHandle);
    }
  else
    if (memcmp(ORIGVFS(pVfs)->xDlClose_signature, xDlClose_signatures[xDlClose_unixDlClose_enum], sizeof(ORIGVFS(pVfs)->xDlClose_signature)) == 0) {
      unixDlClose(ORIGVFS(pVfs), pHandle);
    }
}
int apndRandomness(sqlite3_vfs *pVfs, int nByte, char *zBufOut){
  if (memcmp(ORIGVFS(pVfs)->xRandomness_signature, xRandomness_signatures[xRandomness_apndRandomness_enum], sizeof(ORIGVFS(pVfs)->xRandomness_signature)) == 0) {
    return apndRandomness(ORIGVFS(pVfs), nByte, zBufOut);
  }
  else
    if (memcmp(ORIGVFS(pVfs)->xRandomness_signature, xRandomness_signatures[xRandomness_memdbRandomness_enum], sizeof(ORIGVFS(pVfs)->xRandomness_signature)) == 0) {
      return memdbRandomness(ORIGVFS(pVfs), nByte, zBufOut);
    }
  else
    if (memcmp(ORIGVFS(pVfs)->xRandomness_signature, xRandomness_signatures[xRandomness_vfstraceRandomness_enum], sizeof(ORIGVFS(pVfs)->xRandomness_signature)) == 0) {
      return vfstraceRandomness(ORIGVFS(pVfs), nByte, zBufOut);
    }
  else
    if (memcmp(ORIGVFS(pVfs)->xRandomness_signature, xRandomness_signatures[xRandomness_unixRandomness_enum], sizeof(ORIGVFS(pVfs)->xRandomness_signature)) == 0) {
      return unixRandomness(ORIGVFS(pVfs), nByte, zBufOut);
    }
}
int apndSleep(sqlite3_vfs *pVfs, int nMicro){
  if (memcmp(ORIGVFS(pVfs)->xSleep_signature, xSleep_signatures[xSleep_0_enum], sizeof(ORIGVFS(pVfs)->xSleep_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(ORIGVFS(pVfs)->xSleep_signature, xSleep_signatures[xSleep_apndSleep_enum], sizeof(ORIGVFS(pVfs)->xSleep_signature)) == 0) {
      return apndSleep(ORIGVFS(pVfs), nMicro);
    }
  else
    if (memcmp(ORIGVFS(pVfs)->xSleep_signature, xSleep_signatures[xSleep_memdbSleep_enum], sizeof(ORIGVFS(pVfs)->xSleep_signature)) == 0) {
      return memdbSleep(ORIGVFS(pVfs), nMicro);
    }
  else
    if (memcmp(ORIGVFS(pVfs)->xSleep_signature, xSleep_signatures[xSleep_vfstraceSleep_enum], sizeof(ORIGVFS(pVfs)->xSleep_signature)) == 0) {
      return vfstraceSleep(ORIGVFS(pVfs), nMicro);
    }
  else
    if (memcmp(ORIGVFS(pVfs)->xSleep_signature, xSleep_signatures[xSleep_unixSleep_enum], sizeof(ORIGVFS(pVfs)->xSleep_signature)) == 0) {
      return unixSleep(ORIGVFS(pVfs), nMicro);
    }
}
int apndCurrentTime(sqlite3_vfs *pVfs, double *pTimeOut){
  if (memcmp(ORIGVFS(pVfs)->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_0_enum], sizeof(ORIGVFS(pVfs)->xCurrentTime_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(ORIGVFS(pVfs)->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_apndCurrentTime_enum], sizeof(ORIGVFS(pVfs)->xCurrentTime_signature)) == 0) {
      return apndCurrentTime(ORIGVFS(pVfs), pTimeOut);
    }
  else
    if (memcmp(ORIGVFS(pVfs)->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_vfstraceCurrentTime_enum], sizeof(ORIGVFS(pVfs)->xCurrentTime_signature)) == 0) {
      return vfstraceCurrentTime(ORIGVFS(pVfs), pTimeOut);
    }
  else
    if (memcmp(ORIGVFS(pVfs)->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_unixCurrentTime_enum], sizeof(ORIGVFS(pVfs)->xCurrentTime_signature)) == 0) {
      return unixCurrentTime(ORIGVFS(pVfs), pTimeOut);
    }
}
int apndGetLastError(sqlite3_vfs *pVfs, int a, char *b){
  if (memcmp(ORIGVFS(pVfs)->xGetLastError_signature, xGetLastError_signatures[xGetLastError_0_enum], sizeof(ORIGVFS(pVfs)->xGetLastError_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(ORIGVFS(pVfs)->xGetLastError_signature, xGetLastError_signatures[xGetLastError_apndGetLastError_enum], sizeof(ORIGVFS(pVfs)->xGetLastError_signature)) == 0) {
      return apndGetLastError(ORIGVFS(pVfs), a, b);
    }
  else
    if (memcmp(ORIGVFS(pVfs)->xGetLastError_signature, xGetLastError_signatures[xGetLastError_memdbGetLastError_enum], sizeof(ORIGVFS(pVfs)->xGetLastError_signature)) == 0) {
      return memdbGetLastError(ORIGVFS(pVfs), a, b);
    }
  else
    if (memcmp(ORIGVFS(pVfs)->xGetLastError_signature, xGetLastError_signatures[xGetLastError_unixGetLastError_enum], sizeof(ORIGVFS(pVfs)->xGetLastError_signature)) == 0) {
      return unixGetLastError(ORIGVFS(pVfs), a, b);
    }
}
int apndCurrentTimeInt64(sqlite3_vfs *pVfs, sqlite3_int64 *p){
  if (memcmp(ORIGVFS(pVfs)->xCurrentTimeInt64_signature, xCurrentTimeInt64_signatures[xCurrentTimeInt64_0_enum], sizeof(ORIGVFS(pVfs)->xCurrentTimeInt64_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(ORIGVFS(pVfs)->xCurrentTimeInt64_signature, xCurrentTimeInt64_signatures[xCurrentTimeInt64_apndCurrentTimeInt64_enum], sizeof(ORIGVFS(pVfs)->xCurrentTimeInt64_signature)) == 0) {
      return apndCurrentTimeInt64(ORIGVFS(pVfs), p);
    }
  else
    if (memcmp(ORIGVFS(pVfs)->xCurrentTimeInt64_signature, xCurrentTimeInt64_signatures[xCurrentTimeInt64_memdbCurrentTimeInt64_enum], sizeof(ORIGVFS(pVfs)->xCurrentTimeInt64_signature)) == 0) {
      return memdbCurrentTimeInt64(ORIGVFS(pVfs), p);
    }
  else
    if (memcmp(ORIGVFS(pVfs)->xCurrentTimeInt64_signature, xCurrentTimeInt64_signatures[xCurrentTimeInt64_unixCurrentTimeInt64_enum], sizeof(ORIGVFS(pVfs)->xCurrentTimeInt64_signature)) == 0) {
      return unixCurrentTimeInt64(ORIGVFS(pVfs), p);
    }
}
int apndSetSystemCall(
  sqlite3_vfs *pVfs,
  const char *zName,
  sqlite3_syscall_ptr pCall
){
  if (memcmp(ORIGVFS(pVfs)->xSetSystemCall_signature, xSetSystemCall_signatures[xSetSystemCall_0_enum], sizeof(ORIGVFS(pVfs)->xSetSystemCall_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(ORIGVFS(pVfs)->xSetSystemCall_signature, xSetSystemCall_signatures[xSetSystemCall_apndSetSystemCall_enum], sizeof(ORIGVFS(pVfs)->xSetSystemCall_signature)) == 0) {
      return apndSetSystemCall(ORIGVFS(pVfs), zName, pCall);
    }
  // else
  //   if (memcmp(ORIGVFS(pVfs)->xSetSystemCall_signature, xSetSystemCall_signatures[xSetSystemCall_devsymSleep_enum], sizeof(ORIGVFS(pVfs)->xSetSystemCall_signature)) == 0) {
  //     return devsymSleep(ORIGVFS(pVfs), zName, pCall);
  //   }
  // else
  //   if (memcmp(ORIGVFS(pVfs)->xSetSystemCall_signature, xSetSystemCall_signatures[xSetSystemCall_rbuVfsSleep_enum], sizeof(ORIGVFS(pVfs)->xSetSystemCall_signature)) == 0) {
  //     return rbuVfsSleep(ORIGVFS(pVfs), zName, pCall);
  //   }
  // else
  //   if (memcmp(ORIGVFS(pVfs)->xSetSystemCall_signature, xSetSystemCall_signatures[xSetSystemCall_tvfsSleep_enum], sizeof(ORIGVFS(pVfs)->xSetSystemCall_signature)) == 0) {
  //     return tvfsSleep(ORIGVFS(pVfs), zName, pCall);
  //   }
  else
    if (memcmp(ORIGVFS(pVfs)->xSetSystemCall_signature, xSetSystemCall_signatures[xSetSystemCall_unixSetSystemCall_enum], sizeof(ORIGVFS(pVfs)->xSetSystemCall_signature)) == 0) {
      return unixSetSystemCall(ORIGVFS(pVfs), zName, pCall);
    }
}
sqlite3_syscall_ptr apndGetSystemCall(
  sqlite3_vfs *pVfs,
  const char *zName
){
  if (memcmp(ORIGVFS(pVfs)->xGetSystemCall_signature, xGetSystemCall_signatures[xGetSystemCall_0_enum], sizeof(ORIGVFS(pVfs)->xGetSystemCall_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(ORIGVFS(pVfs)->xGetSystemCall_signature, xGetSystemCall_signatures[xGetSystemCall_apndGetSystemCall_enum], sizeof(ORIGVFS(pVfs)->xGetSystemCall_signature)) == 0) {
      return apndGetSystemCall(ORIGVFS(pVfs), zName);
    }
  else
    if (memcmp(ORIGVFS(pVfs)->xGetSystemCall_signature, xGetSystemCall_signatures[xGetSystemCall_unixGetSystemCall_enum], sizeof(ORIGVFS(pVfs)->xGetSystemCall_signature)) == 0) {
      return unixGetSystemCall(ORIGVFS(pVfs), zName);
    }
}
const char *apndNextSystemCall(sqlite3_vfs *pVfs, const char *zName){
  if (memcmp(ORIGVFS(pVfs)->xNextSystemCall_signature, xNextSystemCall_signatures[xNextSystemCall_0_enum], sizeof(ORIGVFS(pVfs)->xNextSystemCall_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(ORIGVFS(pVfs)->xNextSystemCall_signature, xNextSystemCall_signatures[xNextSystemCall_apndNextSystemCall_enum], sizeof(ORIGVFS(pVfs)->xNextSystemCall_signature)) == 0) {
      return apndNextSystemCall(ORIGVFS(pVfs), zName);
    }
  // else
  //   if (memcmp(ORIGVFS(pVfs)->xNextSystemCall_signature, xNextSystemCall_signatures[xNextSystemCall_rbuVfsGetLastError_enum], sizeof(ORIGVFS(pVfs)->xNextSystemCall_signature)) == 0) {
  //     return rbuVfsGetLastError(ORIGVFS(pVfs), zName);
  //   }
  else
    if (memcmp(ORIGVFS(pVfs)->xNextSystemCall_signature, xNextSystemCall_signatures[xNextSystemCall_unixNextSystemCall_enum], sizeof(ORIGVFS(pVfs)->xNextSystemCall_signature)) == 0) {
      return unixNextSystemCall(ORIGVFS(pVfs), zName);
    }
}

  
#ifdef _WIN32
__declspec(dllexport)
#endif
/* 
** This routine is called when the extension is loaded.
** Register the new VFS.
*/
int sqlite3_appendvfs_init(
  sqlite3 *db, 
  char **pzErrMsg, 
  const sqlite3_api_routines *pApi
){
  int rc = SQLITE_OK;
  sqlite3_vfs *pOrig;
  SQLITE_EXTENSION_INIT2(pApi);
  (void)pzErrMsg;
  (void)db;
  pOrig = sqlite3_vfs_find(0);
  if( pOrig==0 ) return SQLITE_ERROR;
  apnd_vfs.iVersion = pOrig->iVersion;
  apnd_vfs.pAppData = pOrig;
  apnd_vfs.szOsFile = pOrig->szOsFile + sizeof(ApndFile);
  rc = sqlite3_vfs_register(&apnd_vfs, 0);
#ifdef APPENDVFS_TEST
  if( rc==SQLITE_OK ){
    rc = sqlite3_auto_extension((void(*)(void))apndvfsRegister);
  }
#endif
  if( rc==SQLITE_OK ) rc = SQLITE_OK_LOAD_PERMANENTLY;
  return rc;
}
