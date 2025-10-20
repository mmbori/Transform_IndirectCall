/*
** 2007 September 14
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
** OVERVIEW:
**
**   This file contains some example code demonstrating how the SQLite 
**   vfs feature can be used to have SQLite operate directly on an 
**   embedded media, without using an intermediate file system.
**
**   Because this is only a demo designed to run on a workstation, the
**   underlying media is simulated using a regular file-system file. The
**   size of the file is fixed when it is first created (default size 10 MB).
**   From SQLite's point of view, this space is used to store a single
**   database file and the journal file. 
**
**   Any statement journal created is stored in volatile memory obtained 
**   from sqlite3_malloc(). Any attempt to create a temporary database file 
**   will fail (SQLITE_IOERR). To prevent SQLite from attempting this,
**   it should be configured to store all temporary database files in 
**   main memory (see pragma "temp_store" or the SQLITE_TEMP_STORE compile 
**   time option).
**
** ASSUMPTIONS:
**
**   After it has been created, the blob file is accessed using the
**   following three functions only:
**
**       mediaRead();            - Read a 512 byte block from the file.
**       mediaWrite();           - Write a 512 byte block to the file.
**       mediaSync();            - Tell the media hardware to sync.
**
**   It is assumed that these can be easily implemented by any "real"
**   media vfs driver adapting this code.
**
** FILE FORMAT:
**
**   The basic principle is that the "database file" is stored at the
**   beginning of the 10 MB blob and grows in a forward direction. The 
**   "journal file" is stored at the end of the 10MB blob and grows
**   in the reverse direction. If, during a transaction, insufficient
**   space is available to expand either the journal or database file,
**   an SQLITE_FULL error is returned. The database file is never allowed
**   to consume more than 90% of the blob space. If SQLite tries to
**   create a file larger than this, SQLITE_FULL is returned.
**
**   No allowance is made for "wear-leveling", as is required by.
**   embedded devices in the absence of equivalent hardware features.
**
**   The first 512 block byte of the file is reserved for storing the
**   size of the "database file". It is updated as part of the sync()
**   operation. On startup, it can only be trusted if no journal file
**   exists. If a journal-file does exist, then it stores the real size
**   of the database region. The second and subsequent blocks store the 
**   actual database content.
**
**   The size of the "journal file" is not stored persistently in the 
**   file. When the system is running, the size of the journal file is
**   stored in volatile memory. When recovering from a crash, this vfs
**   reports a very large size for the journal file. The normal journal
**   header and checksum mechanisms serve to prevent SQLite from 
**   processing any data that lies past the logical end of the journal.
**
**   When SQLite calls OsDelete() to delete the journal file, the final
**   512 bytes of the blob (the area containing the first journal header)
**   are zeroed.
**
** LOCKING:
**
**   File locking is a no-op. Only one connection may be open at any one
**   time using this demo vfs.
*/

#include "sqlite3.h"
#include <assert.h>
#include <string.h>

/*
** Maximum pathname length supported by the fs backend.
*/
#define BLOCKSIZE 512
#define BLOBSIZE 10485760

/*
** Name used to identify this VFS.
*/
#define FS_VFS_NAME "fs"

typedef struct fs_real_file fs_real_file;
struct fs_real_file {
  sqlite3_file *pFile;
  const char *zName;
  int nDatabase;              /* Current size of database region */
  int nJournal;               /* Current size of journal region */
  int nBlob;                  /* Total size of allocated blob */
  int nRef;                   /* Number of pointers to this structure */
  fs_real_file *pNext;
  fs_real_file **ppThis;
};

typedef struct fs_file fs_file;
struct fs_file {
  sqlite3_file base;
  int eType;
  fs_real_file *pReal;
};

typedef struct tmp_file tmp_file;
struct tmp_file {
  sqlite3_file base;
  int nSize;
  int nAlloc;
  char *zAlloc;
};

/* Values for fs_file.eType. */
#define DATABASE_FILE   1
#define JOURNAL_FILE    2

/*
** Method declarations for fs_file.
*/
int fsClose(sqlite3_file*);
int fsRead(sqlite3_file*, void*, int iAmt, sqlite3_int64 iOfst);
int fsWrite(sqlite3_file*, const void*, int iAmt, sqlite3_int64 iOfst);
int fsTruncate(sqlite3_file*, sqlite3_int64 size);
int fsSync(sqlite3_file*, int flags);
int fsFileSize(sqlite3_file*, sqlite3_int64 *pSize);
int fsLock(sqlite3_file*, int);
int fsUnlock(sqlite3_file*, int);
int fsCheckReservedLock(sqlite3_file*, int *pResOut);
int fsFileControl(sqlite3_file*, int op, void *pArg);
int fsSectorSize(sqlite3_file*);
int fsDeviceCharacteristics(sqlite3_file*);

/*
** Method declarations for tmp_file.
*/
int tmpClose(sqlite3_file*);
int tmpRead(sqlite3_file*, void*, int iAmt, sqlite3_int64 iOfst);
int tmpWrite(sqlite3_file*, const void*, int iAmt, sqlite3_int64 iOfst);
int tmpTruncate(sqlite3_file*, sqlite3_int64 size);
int tmpSync(sqlite3_file*, int flags);
int tmpFileSize(sqlite3_file*, sqlite3_int64 *pSize);
int tmpLock(sqlite3_file*, int);
int tmpUnlock(sqlite3_file*, int);
int tmpCheckReservedLock(sqlite3_file*, int *pResOut);
int tmpFileControl(sqlite3_file*, int op, void *pArg);
int tmpSectorSize(sqlite3_file*);
int tmpDeviceCharacteristics(sqlite3_file*);

/*
** Method declarations for fs_vfs.
*/
int fsOpen(sqlite3_vfs*, const char *, sqlite3_file*, int , int *);
static int fsDelete(sqlite3_vfs*, const char *zName, int syncDir);
static int fsAccess(sqlite3_vfs*, const char *zName, int flags, int *);
static int fsFullPathname(sqlite3_vfs*, const char *zName, int nOut,char *zOut);
static void *fsDlOpen(sqlite3_vfs*, const char *zFilename);
static void fsDlError(sqlite3_vfs*, int nByte, char *zErrMsg);
static void (*fsDlSym(sqlite3_vfs*,void*, const char *zSymbol))(void);
static void fsDlClose(sqlite3_vfs*, void*);
static int fsRandomness(sqlite3_vfs*, int nByte, char *zOut);
static int fsSleep(sqlite3_vfs*, int microseconds);
static int fsCurrentTime(sqlite3_vfs*, double*);


typedef struct fs_vfs_t fs_vfs_t;
struct fs_vfs_t {
  sqlite3_vfs base;
  fs_real_file *pFileList;
  sqlite3_vfs *pParent;
};

static fs_vfs_t fs_vfs = {
  {
    1,                                          /* iVersion */
    0,                                          /* szOsFile */
    0,                                          /* mxPathname */
    0,                                          /* pNext */
    FS_VFS_NAME,                                /* zName */
    0,                                          /* pAppData */
    fsOpen,                                     /* xOpen */
    fsDelete,                                   /* xDelete */
    fsAccess,                                   /* xAccess */
    fsFullPathname,                             /* xFullPathname */
    fsDlOpen,                                   /* xDlOpen */
    fsDlError,                                  /* xDlError */
    fsDlSym,                                    /* xDlSym */
    fsDlClose,                                  /* xDlClose */
    fsRandomness,                               /* xRandomness */
    fsSleep,                                    /* xSleep */
    fsCurrentTime,                              /* xCurrentTime */
    0                                           /* xCurrentTimeInt64 */
  }, 
  0,                                            /* pFileList */
  0                                             /* pParent */
};

static sqlite3_io_methods fs_io_methods = {
  1,                            /* iVersion */
  fsClose,                      /* xClose */
  fsRead,                       /* xRead */
  fsWrite,                      /* xWrite */
  fsTruncate,                   /* xTruncate */
  fsSync,                       /* xSync */
  fsFileSize,                   /* xFileSize */
  fsLock,                       /* xLock */
  fsUnlock,                     /* xUnlock */
  fsCheckReservedLock,          /* xCheckReservedLock */
  fsFileControl,                /* xFileControl */
  fsSectorSize,                 /* xSectorSize */
  fsDeviceCharacteristics,      /* xDeviceCharacteristics */
  0,                            /* xShmMap */
  0,                            /* xShmLock */
  0,                            /* xShmBarrier */
  0                             /* xShmUnmap */
,
  .xClose_signature = xClose_signatures[xClose_fsClose_enum],
  .xRead_signature = xRead_signatures[xRead_fsRead_enum],
  .xWrite_signature = xWrite_signatures[xWrite_fsWrite_enum],
  .xTruncate_signature = xTruncate_signatures[xTruncate_fsTruncate_enum],
  .xSync_signature = xSync_signatures[xSync_fsSync_enum],
  .xFileSize_signature = xFileSize_signatures[xFileSize_fsFileSize_enum],
  .xLock_signature = xLock_signatures[xLock_fsLock_enum],
  .xUnlock_signature = xUnlock_signatures[xUnlock_fsUnlock_enum],
  .xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_fsCheckReservedLock_enum],
  .xFileControl_signature = xFileControl_signatures[xFileControl_fsFileControl_enum],
  .xSectorSize_signature = xSectorSize_signatures[xSectorSize_fsSectorSize_enum],
  .xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_fsDeviceCharacteristics_enum]
};


static sqlite3_io_methods tmp_io_methods = {
  1,                            /* iVersion */
  tmpClose,                     /* xClose */
  tmpRead,                      /* xRead */
  tmpWrite,                     /* xWrite */
  tmpTruncate,                  /* xTruncate */
  tmpSync,                      /* xSync */
  tmpFileSize,                  /* xFileSize */
  tmpLock,                      /* xLock */
  tmpUnlock,                    /* xUnlock */
  tmpCheckReservedLock,         /* xCheckReservedLock */
  tmpFileControl,               /* xFileControl */
  tmpSectorSize,                /* xSectorSize */
  tmpDeviceCharacteristics,     /* xDeviceCharacteristics */
  0,                            /* xShmMap */
  0,                            /* xShmLock */
  0,                            /* xShmBarrier */
  0                             /* xShmUnmap */
,
  .xClose_signature = xClose_signatures[xClose_tmpClose_enum],
  .xRead_signature = xRead_signatures[xRead_tmpRead_enum],
  .xWrite_signature = xWrite_signatures[xWrite_tmpWrite_enum],
  .xTruncate_signature = xTruncate_signatures[xTruncate_tmpTruncate_enum],
  .xSync_signature = xSync_signatures[xSync_tmpSync_enum],
  .xFileSize_signature = xFileSize_signatures[xFileSize_tmpFileSize_enum],
  .xLock_signature = xLock_signatures[xLock_tmpLock_enum],
  .xUnlock_signature = xUnlock_signatures[xUnlock_tmpUnlock_enum],
  .xCheckReservedLock_signature = xCheckReservedLock_signatures[xCheckReservedLock_tmpCheckReservedLock_enum],
  .xFileControl_signature = xFileControl_signatures[xFileControl_tmpFileControl_enum],
  .xSectorSize_signature = xSectorSize_signatures[xSectorSize_tmpSectorSize_enum],
  .xDeviceCharacteristics_signature = xDeviceCharacteristics_signatures[xDeviceCharacteristics_tmpDeviceCharacteristics_enum]
};

/* Useful macros used in several places */
#ifndef MIN
#define MIN(x,y) ((x)<(y)?(x):(y))
#endif
#define MAX(x,y) ((x)>(y)?(x):(y))


/*
** Close a tmp-file.
*/
int tmpClose(sqlite3_file *pFile){
  tmp_file *pTmp = (tmp_file *)pFile;
  sqlite3_free(pTmp->zAlloc);
  return SQLITE_OK;
}

/*
** Read data from a tmp-file.
*/
int tmpRead(
  sqlite3_file *pFile, 
  void *zBuf, 
  int iAmt, 
  sqlite_int64 iOfst
){
  tmp_file *pTmp = (tmp_file *)pFile;
  if( (iAmt+iOfst)>pTmp->nSize ){
    return SQLITE_IOERR_SHORT_READ;
  }
  memcpy(zBuf, &pTmp->zAlloc[iOfst], iAmt);
  return SQLITE_OK;
}

/*
** Write data to a tmp-file.
*/
int tmpWrite(
  sqlite3_file *pFile, 
  const void *zBuf, 
  int iAmt, 
  sqlite_int64 iOfst
){
  tmp_file *pTmp = (tmp_file *)pFile;
  if( (iAmt+iOfst)>pTmp->nAlloc ){
    int nNew = (int)(2*(iAmt+iOfst+pTmp->nAlloc));
    char *zNew = sqlite3_realloc(pTmp->zAlloc, nNew);
    if( !zNew ){
      return SQLITE_NOMEM;
    }
    pTmp->zAlloc = zNew;
    pTmp->nAlloc = nNew;
  }
  memcpy(&pTmp->zAlloc[iOfst], zBuf, iAmt);
  pTmp->nSize = (int)MAX(pTmp->nSize, iOfst+iAmt);
  return SQLITE_OK;
}

/*
** Truncate a tmp-file.
*/
int tmpTruncate(sqlite3_file *pFile, sqlite_int64 size){
  tmp_file *pTmp = (tmp_file *)pFile;
  pTmp->nSize = (int)MIN(pTmp->nSize, size);
  return SQLITE_OK;
}

/*
** Sync a tmp-file.
*/
int tmpSync(sqlite3_file *pFile, int flags){
  return SQLITE_OK;
}

/*
** Return the current file-size of a tmp-file.
*/
int tmpFileSize(sqlite3_file *pFile, sqlite_int64 *pSize){
  tmp_file *pTmp = (tmp_file *)pFile;
  *pSize = pTmp->nSize;
  return SQLITE_OK;
}

/*
** Lock a tmp-file.
*/
int tmpLock(sqlite3_file *pFile, int eLock){
  return SQLITE_OK;
}

/*
** Unlock a tmp-file.
*/
int tmpUnlock(sqlite3_file *pFile, int eLock){
  return SQLITE_OK;
}

/*
** Check if another file-handle holds a RESERVED lock on a tmp-file.
*/
int tmpCheckReservedLock(sqlite3_file *pFile, int *pResOut){
  *pResOut = 0;
  return SQLITE_OK;
}

/*
** File control method. For custom operations on a tmp-file.
*/
int tmpFileControl(sqlite3_file *pFile, int op, void *pArg){
  return SQLITE_OK;
}

/*
** Return the sector-size in bytes for a tmp-file.
*/
int tmpSectorSize(sqlite3_file *pFile){
  return 0;
}

/*
** Return the device characteristic flags supported by a tmp-file.
*/
int tmpDeviceCharacteristics(sqlite3_file *pFile){
  return 0;
}

/*
** Close an fs-file.
*/
int fsClose(sqlite3_file *pFile){
  int rc = SQLITE_OK;
  fs_file *p = (fs_file *)pFile;
  fs_real_file *pReal = p->pReal;

  /* Decrement the real_file ref-count. */
  pReal->nRef--;
  assert(pReal->nRef>=0);

  /* When the ref-count reaches 0, destroy the structure */
  if( pReal->nRef==0 ){
    *pReal->ppThis = pReal->pNext;
    if( pReal->pNext ){
      pReal->pNext->ppThis = pReal->ppThis;
    }
    if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_apndClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
      rc = apndClose(pReal->pFile);
    }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_bytecodevtabClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = bytecodevtabClose(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_completionClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = completionClose(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_dbdataClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = dbdataClose(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_dbpageClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = dbpageClose(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_expertClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = expertClose(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_fsdirClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = fsdirClose(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_fts3CloseMethod_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = fts3CloseMethod(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_fts3auxCloseMethod_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = fts3auxCloseMethod(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_fts3tokCloseMethod_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = fts3tokCloseMethod(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_jsonEachClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = jsonEachClose(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_memdbClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = memdbClose(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_memjrnlClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = memjrnlClose(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_porterClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = porterClose(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_pragmaVtabClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = pragmaVtabClose(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_recoverVfsClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = recoverVfsClose(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_rtreeClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = rtreeClose(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_seriesClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = seriesClose(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_simpleClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = simpleClose(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_statClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = statClose(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_stmtClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = stmtClose(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_unicodeClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = unicodeClose(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_vfstraceClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = vfstraceClose(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_zipfileClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = zipfileClose(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_unixClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = unixClose(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_nolockClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = nolockClose(pReal->pFile);
      }
    else
      if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_dotlockClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
        rc = dotlockClose(pReal->pFile);
      }
    sqlite3_free(pReal);
  }

  return rc;
}

/*
** Read data from an fs-file.
*/
int fsRead(
  sqlite3_file *pFile, 
  void *zBuf, 
  int iAmt, 
  sqlite_int64 iOfst
){
  int rc = SQLITE_OK;
  fs_file *p = (fs_file *)pFile;
  fs_real_file *pReal = p->pReal;
  sqlite3_file *pF = pReal->pFile;

  if( (p->eType==DATABASE_FILE && (iAmt+iOfst)>pReal->nDatabase)
   || (p->eType==JOURNAL_FILE && (iAmt+iOfst)>pReal->nJournal)
  ){
    rc = SQLITE_IOERR_SHORT_READ;
  }else if( p->eType==DATABASE_FILE ){
    if (memcmp(pF->pMethods->xRead_signature, xRead_signatures[xRead_apndRead_enum], sizeof(pF->pMethods->xRead_signature)) == 0) {
      rc = apndRead(pF, zBuf, iAmt, iOfst + BLOCKSIZE);
    }
    else
      if (memcmp(pF->pMethods->xRead_signature, xRead_signatures[xRead_memdbRead_enum], sizeof(pF->pMethods->xRead_signature)) == 0) {
        rc = memdbRead(pF, zBuf, iAmt, iOfst + BLOCKSIZE);
      }
    else
      if (memcmp(pF->pMethods->xRead_signature, xRead_signatures[xRead_memjrnlRead_enum], sizeof(pF->pMethods->xRead_signature)) == 0) {
        rc = memjrnlRead(pF, zBuf, iAmt, iOfst + BLOCKSIZE);
      }
    else
      if (memcmp(pF->pMethods->xRead_signature, xRead_signatures[xRead_recoverVfsRead_enum], sizeof(pF->pMethods->xRead_signature)) == 0) {
        rc = recoverVfsRead(pF, zBuf, iAmt, iOfst + BLOCKSIZE);
      }
    else
      if (memcmp(pF->pMethods->xRead_signature, xRead_signatures[xRead_vfstraceRead_enum], sizeof(pF->pMethods->xRead_signature)) == 0) {
        rc = vfstraceRead(pF, zBuf, iAmt, iOfst + BLOCKSIZE);
      }
    else
      if (memcmp(pF->pMethods->xRead_signature, xRead_signatures[xRead_unixRead_enum], sizeof(pF->pMethods->xRead_signature)) == 0) {
        rc = unixRead(pF, zBuf, iAmt, iOfst + BLOCKSIZE);
      }
  }else{
    /* Journal file. */
    int iRem = iAmt;
    int iBuf = 0;
    int ii = (int)iOfst;
    while( iRem>0 && rc==SQLITE_OK ){
      int iRealOff = pReal->nBlob - BLOCKSIZE*((ii/BLOCKSIZE)+1) + ii%BLOCKSIZE;
      int iRealAmt = MIN(iRem, BLOCKSIZE - (iRealOff%BLOCKSIZE));

      if (memcmp(pF->pMethods->xRead_signature, xRead_signatures[xRead_apndRead_enum], sizeof(pF->pMethods->xRead_signature)) == 0) {
        rc = apndRead(pF, &((char *)zBuf)[iBuf], iRealAmt, iRealOff);
      }
      else
        if (memcmp(pF->pMethods->xRead_signature, xRead_signatures[xRead_memdbRead_enum], sizeof(pF->pMethods->xRead_signature)) == 0) {
          rc = memdbRead(pF, &((char *)zBuf)[iBuf], iRealAmt, iRealOff);
        }
      else
        if (memcmp(pF->pMethods->xRead_signature, xRead_signatures[xRead_memjrnlRead_enum], sizeof(pF->pMethods->xRead_signature)) == 0) {
          rc = memjrnlRead(pF, &((char *)zBuf)[iBuf], iRealAmt, iRealOff);
        }
      else
        if (memcmp(pF->pMethods->xRead_signature, xRead_signatures[xRead_recoverVfsRead_enum], sizeof(pF->pMethods->xRead_signature)) == 0) {
          rc = recoverVfsRead(pF, &((char *)zBuf)[iBuf], iRealAmt, iRealOff);
        }
      else
        if (memcmp(pF->pMethods->xRead_signature, xRead_signatures[xRead_vfstraceRead_enum], sizeof(pF->pMethods->xRead_signature)) == 0) {
          rc = vfstraceRead(pF, &((char *)zBuf)[iBuf], iRealAmt, iRealOff);
        }
      else
        if (memcmp(pF->pMethods->xRead_signature, xRead_signatures[xRead_unixRead_enum], sizeof(pF->pMethods->xRead_signature)) == 0) {
          rc = unixRead(pF, &((char *)zBuf)[iBuf], iRealAmt, iRealOff);
        }
      ii += iRealAmt;
      iBuf += iRealAmt;
      iRem -= iRealAmt;
    }
  }

  return rc;
}

/*
** Write data to an fs-file.
*/
int fsWrite(
  sqlite3_file *pFile, 
  const void *zBuf, 
  int iAmt, 
  sqlite_int64 iOfst
){
  int rc = SQLITE_OK;
  fs_file *p = (fs_file *)pFile;
  fs_real_file *pReal = p->pReal;
  sqlite3_file *pF = pReal->pFile;

  if( p->eType==DATABASE_FILE ){
    if( (iAmt+iOfst+BLOCKSIZE)>(pReal->nBlob-pReal->nJournal) ){
      rc = SQLITE_FULL;
    }else{
      if (memcmp(pF->pMethods->xWrite_signature, xWrite_signatures[xWrite_apndWrite_enum], sizeof(pF->pMethods->xWrite_signature)) == 0) {
        rc = apndWrite(pF, zBuf, iAmt, iOfst + BLOCKSIZE);
      }
      else
        if (memcmp(pF->pMethods->xWrite_signature, xWrite_signatures[xWrite_kvstorageWrite_enum], sizeof(pF->pMethods->xWrite_signature)) == 0) {
          rc = kvstorageWrite(pF, zBuf, iAmt, iOfst + BLOCKSIZE);
        }
      else
        if (memcmp(pF->pMethods->xWrite_signature, xWrite_signatures[xWrite_memdbWrite_enum], sizeof(pF->pMethods->xWrite_signature)) == 0) {
          rc = memdbWrite(pF, zBuf, iAmt, iOfst + BLOCKSIZE);
        }
      else
        if (memcmp(pF->pMethods->xWrite_signature, xWrite_signatures[xWrite_memjrnlWrite_enum], sizeof(pF->pMethods->xWrite_signature)) == 0) {
          rc = memjrnlWrite(pF, zBuf, iAmt, iOfst + BLOCKSIZE);
        }
      else
        if (memcmp(pF->pMethods->xWrite_signature, xWrite_signatures[xWrite_recoverVfsWrite_enum], sizeof(pF->pMethods->xWrite_signature)) == 0) {
          rc = recoverVfsWrite(pF, zBuf, iAmt, iOfst + BLOCKSIZE);
        }
      else
        if (memcmp(pF->pMethods->xWrite_signature, xWrite_signatures[xWrite_vfstraceWrite_enum], sizeof(pF->pMethods->xWrite_signature)) == 0) {
          rc = vfstraceWrite(pF, zBuf, iAmt, iOfst + BLOCKSIZE);
        }
      else
        if (memcmp(pF->pMethods->xWrite_signature, xWrite_signatures[xWrite_unixWrite_enum], sizeof(pF->pMethods->xWrite_signature)) == 0) {
          rc = unixWrite(pF, zBuf, iAmt, iOfst + BLOCKSIZE);
        }
      if( rc==SQLITE_OK ){
        pReal->nDatabase = (int)MAX(pReal->nDatabase, iAmt+iOfst);
      }
    }
  }else{
    /* Journal file. */
    int iRem = iAmt;
    int iBuf = 0;
    int ii = (int)iOfst;
    while( iRem>0 && rc==SQLITE_OK ){
      int iRealOff = pReal->nBlob - BLOCKSIZE*((ii/BLOCKSIZE)+1) + ii%BLOCKSIZE;
      int iRealAmt = MIN(iRem, BLOCKSIZE - (iRealOff%BLOCKSIZE));

      if( iRealOff<(pReal->nDatabase+BLOCKSIZE) ){
        rc = SQLITE_FULL;
      }else{
        if (memcmp(pF->pMethods->xWrite_signature, xWrite_signatures[xWrite_apndWrite_enum], sizeof(pF->pMethods->xWrite_signature)) == 0) {
          rc = apndWrite(pF, &((char *)zBuf)[iBuf], iRealAmt, iRealOff);
        }
        else
          if (memcmp(pF->pMethods->xWrite_signature, xWrite_signatures[xWrite_kvstorageWrite_enum], sizeof(pF->pMethods->xWrite_signature)) == 0) {
            rc = kvstorageWrite(pF, &((char *)zBuf)[iBuf], iRealAmt, iRealOff);
          }
        else
          if (memcmp(pF->pMethods->xWrite_signature, xWrite_signatures[xWrite_memdbWrite_enum], sizeof(pF->pMethods->xWrite_signature)) == 0) {
            rc = memdbWrite(pF, &((char *)zBuf)[iBuf], iRealAmt, iRealOff);
          }
        else
          if (memcmp(pF->pMethods->xWrite_signature, xWrite_signatures[xWrite_memjrnlWrite_enum], sizeof(pF->pMethods->xWrite_signature)) == 0) {
            rc = memjrnlWrite(pF, &((char *)zBuf)[iBuf], iRealAmt, iRealOff);
          }
        else
          if (memcmp(pF->pMethods->xWrite_signature, xWrite_signatures[xWrite_recoverVfsWrite_enum], sizeof(pF->pMethods->xWrite_signature)) == 0) {
            rc = recoverVfsWrite(pF, &((char *)zBuf)[iBuf], iRealAmt,
                                 iRealOff);
          }
        else
          if (memcmp(pF->pMethods->xWrite_signature, xWrite_signatures[xWrite_vfstraceWrite_enum], sizeof(pF->pMethods->xWrite_signature)) == 0) {
            rc = vfstraceWrite(pF, &((char *)zBuf)[iBuf], iRealAmt, iRealOff);
          }
        else
          if (memcmp(pF->pMethods->xWrite_signature, xWrite_signatures[xWrite_unixWrite_enum], sizeof(pF->pMethods->xWrite_signature)) == 0) {
            rc = unixWrite(pF, &((char *)zBuf)[iBuf], iRealAmt, iRealOff);
          }
        ii += iRealAmt;
        iBuf += iRealAmt;
        iRem -= iRealAmt;
      }
    }
    if( rc==SQLITE_OK ){
      pReal->nJournal = (int)MAX(pReal->nJournal, iAmt+iOfst);
    }
  }

  return rc;
}

/*
** Truncate an fs-file.
*/
int fsTruncate(sqlite3_file *pFile, sqlite_int64 size){
  fs_file *p = (fs_file *)pFile;
  fs_real_file *pReal = p->pReal;
  if( p->eType==DATABASE_FILE ){
    pReal->nDatabase = (int)MIN(pReal->nDatabase, size);
  }else{
    pReal->nJournal = (int)MIN(pReal->nJournal, size);
  }
  return SQLITE_OK;
}

/*
** Sync an fs-file.
*/
int fsSync(sqlite3_file *pFile, int flags){
  fs_file *p = (fs_file *)pFile;
  fs_real_file *pReal = p->pReal;
  sqlite3_file *pRealFile = pReal->pFile;
  int rc = SQLITE_OK;

  if( p->eType==DATABASE_FILE ){
    unsigned char zSize[4];
    zSize[0] = (pReal->nDatabase&0xFF000000)>>24;
    zSize[1] = (unsigned char)((pReal->nDatabase&0x00FF0000)>>16);
    zSize[2] = (pReal->nDatabase&0x0000FF00)>>8;
    zSize[3] = (pReal->nDatabase&0x000000FF);
    if (memcmp(pRealFile->pMethods->xWrite_signature, xWrite_signatures[xWrite_apndWrite_enum], sizeof(pRealFile->pMethods->xWrite_signature)) == 0) {
      rc = apndWrite(pRealFile, zSize, 4, 0);
    }
    else
      if (memcmp(pRealFile->pMethods->xWrite_signature, xWrite_signatures[xWrite_kvstorageWrite_enum], sizeof(pRealFile->pMethods->xWrite_signature)) == 0) {
        rc = kvstorageWrite(pRealFile, zSize, 4, 0);
      }
    else
      if (memcmp(pRealFile->pMethods->xWrite_signature, xWrite_signatures[xWrite_memdbWrite_enum], sizeof(pRealFile->pMethods->xWrite_signature)) == 0) {
        rc = memdbWrite(pRealFile, zSize, 4, 0);
      }
    else
      if (memcmp(pRealFile->pMethods->xWrite_signature, xWrite_signatures[xWrite_memjrnlWrite_enum], sizeof(pRealFile->pMethods->xWrite_signature)) == 0) {
        rc = memjrnlWrite(pRealFile, zSize, 4, 0);
      }
    else
      if (memcmp(pRealFile->pMethods->xWrite_signature, xWrite_signatures[xWrite_recoverVfsWrite_enum], sizeof(pRealFile->pMethods->xWrite_signature)) == 0) {
        rc = recoverVfsWrite(pRealFile, zSize, 4, 0);
      }
    else
      if (memcmp(pRealFile->pMethods->xWrite_signature, xWrite_signatures[xWrite_vfstraceWrite_enum], sizeof(pRealFile->pMethods->xWrite_signature)) == 0) {
        rc = vfstraceWrite(pRealFile, zSize, 4, 0);
      }
    else
      if (memcmp(pRealFile->pMethods->xWrite_signature, xWrite_signatures[xWrite_unixWrite_enum], sizeof(pRealFile->pMethods->xWrite_signature)) == 0) {
        rc = unixWrite(pRealFile, zSize, 4, 0);
      }
  }
  if( rc==SQLITE_OK ){
    if (memcmp(pRealFile->pMethods->xSync_signature, xSync_signatures[xSync_0_enum], sizeof(pRealFile->pMethods->xSync_signature)) == 0) {
      rc = 0;
    }
    else
      if (memcmp(pRealFile->pMethods->xSync_signature, xSync_signatures[xSync_apndSync_enum], sizeof(pRealFile->pMethods->xSync_signature)) == 0) {
        rc = apndSync(pRealFile, flags & (~SQLITE_SYNC_DATAONLY));
      }
    else
      if (memcmp(pRealFile->pMethods->xSync_signature, xSync_signatures[xSync_dbpageSync_enum], sizeof(pRealFile->pMethods->xSync_signature)) == 0) {
        rc = dbpageSync(pRealFile, flags & (~SQLITE_SYNC_DATAONLY));
      }
    else
      if (memcmp(pRealFile->pMethods->xSync_signature, xSync_signatures[xSync_echoSync_enum], sizeof(pRealFile->pMethods->xSync_signature)) == 0) {
        rc = echoSync(pRealFile, flags & (~SQLITE_SYNC_DATAONLY));
      }
    else
      if (memcmp(pRealFile->pMethods->xSync_signature, xSync_signatures[xSync_fts3SyncMethod_enum], sizeof(pRealFile->pMethods->xSync_signature)) == 0) {
        rc = fts3SyncMethod(pRealFile, flags & (~SQLITE_SYNC_DATAONLY));
      }
    else
      if (memcmp(pRealFile->pMethods->xSync_signature, xSync_signatures[xSync_memdbSync_enum], sizeof(pRealFile->pMethods->xSync_signature)) == 0) {
        rc = memdbSync(pRealFile, flags & (~SQLITE_SYNC_DATAONLY));
      }
    else
      if (memcmp(pRealFile->pMethods->xSync_signature, xSync_signatures[xSync_memjrnlSync_enum], sizeof(pRealFile->pMethods->xSync_signature)) == 0) {
        rc = memjrnlSync(pRealFile, flags & (~SQLITE_SYNC_DATAONLY));
      }
    else
      if (memcmp(pRealFile->pMethods->xSync_signature, xSync_signatures[xSync_recoverVfsSync_enum], sizeof(pRealFile->pMethods->xSync_signature)) == 0) {
        rc = recoverVfsSync(pRealFile, flags & (~SQLITE_SYNC_DATAONLY));
      }
    else
      if (memcmp(pRealFile->pMethods->xSync_signature, xSync_signatures[xSync_rtreeEndTransaction_enum], sizeof(pRealFile->pMethods->xSync_signature)) == 0) {
        rc = rtreeEndTransaction(pRealFile, flags & (~SQLITE_SYNC_DATAONLY));
      }
    else
      if (memcmp(pRealFile->pMethods->xSync_signature, xSync_signatures[xSync_vfstraceSync_enum], sizeof(pRealFile->pMethods->xSync_signature)) == 0) {
        rc = vfstraceSync(pRealFile, flags & (~SQLITE_SYNC_DATAONLY));
      }
    else
      if (memcmp(pRealFile->pMethods->xSync_signature, xSync_signatures[xSync_vtablogSync_enum], sizeof(pRealFile->pMethods->xSync_signature)) == 0) {
        rc = vtablogSync(pRealFile, flags & (~SQLITE_SYNC_DATAONLY));
      }
    else
      if (memcmp(pRealFile->pMethods->xSync_signature, xSync_signatures[xSync_unixSync_enum], sizeof(pRealFile->pMethods->xSync_signature)) == 0) {
        rc = unixSync(pRealFile, flags & (~SQLITE_SYNC_DATAONLY));
      }
  }

  return rc;
}

/*
** Return the current file-size of an fs-file.
*/
int fsFileSize(sqlite3_file *pFile, sqlite_int64 *pSize){
  fs_file *p = (fs_file *)pFile;
  fs_real_file *pReal = p->pReal;
  if( p->eType==DATABASE_FILE ){
    *pSize = pReal->nDatabase;
  }else{
    *pSize = pReal->nJournal;
  }
  return SQLITE_OK;
}

/*
** Lock an fs-file.
*/
int fsLock(sqlite3_file *pFile, int eLock){
  return SQLITE_OK;
}

/*
** Unlock an fs-file.
*/
int fsUnlock(sqlite3_file *pFile, int eLock){
  return SQLITE_OK;
}

/*
** Check if another file-handle holds a RESERVED lock on an fs-file.
*/
int fsCheckReservedLock(sqlite3_file *pFile, int *pResOut){
  *pResOut = 0;
  return SQLITE_OK;
}

/*
** File control method. For custom operations on an fs-file.
*/
int fsFileControl(sqlite3_file *pFile, int op, void *pArg){
  if( op==SQLITE_FCNTL_PRAGMA ) return SQLITE_NOTFOUND;
  return SQLITE_OK;
}

/*
** Return the sector-size in bytes for an fs-file.
*/
int fsSectorSize(sqlite3_file *pFile){
  return BLOCKSIZE;
}

/*
** Return the device characteristic flags supported by an fs-file.
*/
int fsDeviceCharacteristics(sqlite3_file *pFile){
  return 0;
}

/*
** Open an fs file handle.
*/
int fsOpen(
  sqlite3_vfs *pVfs,
  const char *zName,
  sqlite3_file *pFile,
  int flags,
  int *pOutFlags
){
  fs_vfs_t *pFsVfs = (fs_vfs_t *)pVfs;
  fs_file *p = (fs_file *)pFile;
  fs_real_file *pReal = 0;
  int eType;
  int nName;
  int rc = SQLITE_OK;

  if( 0==(flags&(SQLITE_OPEN_MAIN_DB|SQLITE_OPEN_MAIN_JOURNAL)) ){
    tmp_file *p2 = (tmp_file *)pFile;
    memset(p2, 0, sizeof(*p2));
    p2->base.pMethods = &tmp_io_methods;
    return SQLITE_OK;
  }

  eType = ((flags&(SQLITE_OPEN_MAIN_DB))?DATABASE_FILE:JOURNAL_FILE);
  p->base.pMethods = &fs_io_methods;
  p->eType = eType;

  assert(strlen("-journal")==8);
  nName = (int)strlen(zName)-((eType==JOURNAL_FILE)?8:0);
  pReal=pFsVfs->pFileList; 
  for(; pReal && strncmp(pReal->zName, zName, nName); pReal=pReal->pNext);

  if( !pReal ){
    int real_flags = (flags&~(SQLITE_OPEN_MAIN_DB))|SQLITE_OPEN_TEMP_DB;
    sqlite3_int64 size;
    sqlite3_file *pRealFile;
    sqlite3_vfs *pParent = pFsVfs->pParent;
    assert(eType==DATABASE_FILE);

    pReal = (fs_real_file *)sqlite3_malloc(sizeof(*pReal)+pParent->szOsFile);
    if( !pReal ){
      rc = SQLITE_NOMEM;
      goto open_out;
    }
    memset(pReal, 0, sizeof(*pReal)+pParent->szOsFile);
    pReal->zName = zName;
    pReal->pFile = (sqlite3_file *)(&pReal[1]);

    if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_amatchOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
      rc = amatchOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
    }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_apndOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = apndOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_binfoOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = binfoOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_bytecodevtabOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = bytecodevtabOpen(pParent, zName, pReal->pFile, real_flags,
                              pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_carrayOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = carrayOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_cidxOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = cidxOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_closureOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = closureOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_completionOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = completionOpen(pParent, zName, pReal->pFile, real_flags,
                            pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_csvtabOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = csvtabOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_dbdataOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = dbdataOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_dbpageOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = dbpageOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_deltaparsevtabOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = deltaparsevtabOpen(pParent, zName, pReal->pFile, real_flags,
                                pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_echoOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = echoOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_expertOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = expertOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_explainOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = explainOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_fsOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = fsOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_fsdirOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = fsdirOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_fstreeOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = fstreeOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_fts3OpenMethod_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = fts3OpenMethod(pParent, zName, pReal->pFile, real_flags,
                            pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_fts3auxOpenMethod_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = fts3auxOpenMethod(pParent, zName, pReal->pFile, real_flags,
                               pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_fts3termOpenMethod_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = fts3termOpenMethod(pParent, zName, pReal->pFile, real_flags,
                                pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_fts3tokOpenMethod_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = fts3tokOpenMethod(pParent, zName, pReal->pFile, real_flags,
                               pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_fuzzerOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = fuzzerOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_intarrayOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = intarrayOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = jsonEachOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpenEach_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = jsonEachOpenEach(pParent, zName, pReal->pFile, real_flags,
                              pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpenTree_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = jsonEachOpenTree(pParent, zName, pReal->pFile, real_flags,
                              pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_memdbOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = memdbOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_memstatOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = memstatOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_porterOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = porterOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_pragmaVtabOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = pragmaVtabOpen(pParent, zName, pReal->pFile, real_flags,
                            pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_prefixesOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = prefixesOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_qpvtabOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = qpvtabOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_rtreeOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = rtreeOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_schemaOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = schemaOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_seriesOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = seriesOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_simpleOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = simpleOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_spellfix1Open_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = spellfix1Open(pParent, zName, pReal->pFile, real_flags,
                           pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_statOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = statOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_stmtOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = stmtOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_tclOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = tclOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_tclvarOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = tclvarOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_templatevtabOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = templatevtabOpen(pParent, zName, pReal->pFile, real_flags,
                              pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_unicodeOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = unicodeOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_unionOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = unionOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_vfstraceOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = vfstraceOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_vstattabOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = vstattabOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_vtablogOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = vtablogOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_wholenumberOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = wholenumberOpen(pParent, zName, pReal->pFile, real_flags,
                             pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_zipfileOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = zipfileOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    else
      if (memcmp(pParent->xOpen_signature, xOpen_signatures[xOpen_unixOpen_enum], sizeof(pParent->xOpen_signature)) == 0) {
        rc = unixOpen(pParent, zName, pReal->pFile, real_flags, pOutFlags);
      }
    if( rc!=SQLITE_OK ){
      goto open_out;
    }
    pRealFile = pReal->pFile;

    if (memcmp(pRealFile->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_apndFileSize_enum], sizeof(pRealFile->pMethods->xFileSize_signature)) == 0) {
      rc = apndFileSize(pRealFile, &size);
    }
    else
      if (memcmp(pRealFile->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_memdbFileSize_enum], sizeof(pRealFile->pMethods->xFileSize_signature)) == 0) {
        rc = memdbFileSize(pRealFile, &size);
      }
    else
      if (memcmp(pRealFile->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_memjrnlFileSize_enum], sizeof(pRealFile->pMethods->xFileSize_signature)) == 0) {
        rc = memjrnlFileSize(pRealFile, &size);
      }
    else
      if (memcmp(pRealFile->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_recoverVfsFileSize_enum], sizeof(pRealFile->pMethods->xFileSize_signature)) == 0) {
        rc = recoverVfsFileSize(pRealFile, &size);
      }
    else
      if (memcmp(pRealFile->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_vfstraceFileSize_enum], sizeof(pRealFile->pMethods->xFileSize_signature)) == 0) {
        rc = vfstraceFileSize(pRealFile, &size);
      }
    else
      if (memcmp(pRealFile->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_unixFileSize_enum], sizeof(pRealFile->pMethods->xFileSize_signature)) == 0) {
        rc = unixFileSize(pRealFile, &size);
      }
    if( rc!=SQLITE_OK ){
      goto open_out;
    }
    if( size==0 ){
      if (memcmp(pRealFile->pMethods->xWrite_signature, xWrite_signatures[xWrite_apndWrite_enum], sizeof(pRealFile->pMethods->xWrite_signature)) == 0) {
        rc = apndWrite(pRealFile, "\0", 1, BLOBSIZE - 1);
      }
      else
        if (memcmp(pRealFile->pMethods->xWrite_signature, xWrite_signatures[xWrite_kvstorageWrite_enum], sizeof(pRealFile->pMethods->xWrite_signature)) == 0) {
          rc = kvstorageWrite(pRealFile, "\0", 1, BLOBSIZE - 1);
        }
      else
        if (memcmp(pRealFile->pMethods->xWrite_signature, xWrite_signatures[xWrite_memdbWrite_enum], sizeof(pRealFile->pMethods->xWrite_signature)) == 0) {
          rc = memdbWrite(pRealFile, "\0", 1, BLOBSIZE - 1);
        }
      else
        if (memcmp(pRealFile->pMethods->xWrite_signature, xWrite_signatures[xWrite_memjrnlWrite_enum], sizeof(pRealFile->pMethods->xWrite_signature)) == 0) {
          rc = memjrnlWrite(pRealFile, "\0", 1, BLOBSIZE - 1);
        }
      else
        if (memcmp(pRealFile->pMethods->xWrite_signature, xWrite_signatures[xWrite_recoverVfsWrite_enum], sizeof(pRealFile->pMethods->xWrite_signature)) == 0) {
          rc = recoverVfsWrite(pRealFile, "\0", 1, BLOBSIZE - 1);
        }
      else
        if (memcmp(pRealFile->pMethods->xWrite_signature, xWrite_signatures[xWrite_vfstraceWrite_enum], sizeof(pRealFile->pMethods->xWrite_signature)) == 0) {
          rc = vfstraceWrite(pRealFile, "\0", 1, BLOBSIZE - 1);
        }
      else
        if (memcmp(pRealFile->pMethods->xWrite_signature, xWrite_signatures[xWrite_unixWrite_enum], sizeof(pRealFile->pMethods->xWrite_signature)) == 0) {
          rc = unixWrite(pRealFile, "\0", 1, BLOBSIZE - 1);
        }
      pReal->nBlob = BLOBSIZE;
    }else{
      unsigned char zS[4];
      pReal->nBlob = (int)size;
      if (memcmp(pRealFile->pMethods->xRead_signature, xRead_signatures[xRead_apndRead_enum], sizeof(pRealFile->pMethods->xRead_signature)) == 0) {
        rc = apndRead(pRealFile, zS, 4, 0);
      }
      else
        if (memcmp(pRealFile->pMethods->xRead_signature, xRead_signatures[xRead_memdbRead_enum], sizeof(pRealFile->pMethods->xRead_signature)) == 0) {
          rc = memdbRead(pRealFile, zS, 4, 0);
        }
      else
        if (memcmp(pRealFile->pMethods->xRead_signature, xRead_signatures[xRead_memjrnlRead_enum], sizeof(pRealFile->pMethods->xRead_signature)) == 0) {
          rc = memjrnlRead(pRealFile, zS, 4, 0);
        }
      else
        if (memcmp(pRealFile->pMethods->xRead_signature, xRead_signatures[xRead_recoverVfsRead_enum], sizeof(pRealFile->pMethods->xRead_signature)) == 0) {
          rc = recoverVfsRead(pRealFile, zS, 4, 0);
        }
      else
        if (memcmp(pRealFile->pMethods->xRead_signature, xRead_signatures[xRead_vfstraceRead_enum], sizeof(pRealFile->pMethods->xRead_signature)) == 0) {
          rc = vfstraceRead(pRealFile, zS, 4, 0);
        }
      else
        if (memcmp(pRealFile->pMethods->xRead_signature, xRead_signatures[xRead_unixRead_enum], sizeof(pRealFile->pMethods->xRead_signature)) == 0) {
          rc = unixRead(pRealFile, zS, 4, 0);
        }
      pReal->nDatabase = (zS[0]<<24)+(zS[1]<<16)+(zS[2]<<8)+zS[3];
      if( rc==SQLITE_OK ){
        if (memcmp(pRealFile->pMethods->xRead_signature, xRead_signatures[xRead_apndRead_enum], sizeof(pRealFile->pMethods->xRead_signature)) == 0) {
          rc = apndRead(pRealFile, zS, 4, pReal->nBlob - 4);
        }
        else
          if (memcmp(pRealFile->pMethods->xRead_signature, xRead_signatures[xRead_memdbRead_enum], sizeof(pRealFile->pMethods->xRead_signature)) == 0) {
            rc = memdbRead(pRealFile, zS, 4, pReal->nBlob - 4);
          }
        else
          if (memcmp(pRealFile->pMethods->xRead_signature, xRead_signatures[xRead_memjrnlRead_enum], sizeof(pRealFile->pMethods->xRead_signature)) == 0) {
            rc = memjrnlRead(pRealFile, zS, 4, pReal->nBlob - 4);
          }
        else
          if (memcmp(pRealFile->pMethods->xRead_signature, xRead_signatures[xRead_recoverVfsRead_enum], sizeof(pRealFile->pMethods->xRead_signature)) == 0) {
            rc = recoverVfsRead(pRealFile, zS, 4, pReal->nBlob - 4);
          }
        else
          if (memcmp(pRealFile->pMethods->xRead_signature, xRead_signatures[xRead_vfstraceRead_enum], sizeof(pRealFile->pMethods->xRead_signature)) == 0) {
            rc = vfstraceRead(pRealFile, zS, 4, pReal->nBlob - 4);
          }
        else
          if (memcmp(pRealFile->pMethods->xRead_signature, xRead_signatures[xRead_unixRead_enum], sizeof(pRealFile->pMethods->xRead_signature)) == 0) {
            rc = unixRead(pRealFile, zS, 4, pReal->nBlob - 4);
          }
        if( zS[0] || zS[1] || zS[2] || zS[3] ){
          pReal->nJournal = pReal->nBlob;
        }
      }
    }

    if( rc==SQLITE_OK ){
      pReal->pNext = pFsVfs->pFileList;
      if( pReal->pNext ){
        pReal->pNext->ppThis = &pReal->pNext;
      }
      pReal->ppThis = &pFsVfs->pFileList;
      pFsVfs->pFileList = pReal;
    }
  }

open_out:
  if( pReal ){
    if( rc==SQLITE_OK ){
      p->pReal = pReal;
      pReal->nRef++;
    }else{
      if( pReal->pFile->pMethods ){
        if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_apndClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
          apndClose(pReal->pFile);
        }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_bytecodevtabClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            bytecodevtabClose(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_completionClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            completionClose(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_dbdataClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            dbdataClose(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_dbpageClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            dbpageClose(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_expertClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            expertClose(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_fsdirClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            fsdirClose(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_fts3CloseMethod_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            fts3CloseMethod(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_fts3auxCloseMethod_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            fts3auxCloseMethod(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_fts3tokCloseMethod_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            fts3tokCloseMethod(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_jsonEachClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            jsonEachClose(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_memdbClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            memdbClose(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_memjrnlClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            memjrnlClose(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_porterClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            porterClose(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_pragmaVtabClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            pragmaVtabClose(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_recoverVfsClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            recoverVfsClose(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_rtreeClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            rtreeClose(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_seriesClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            seriesClose(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_simpleClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            simpleClose(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_statClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            statClose(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_stmtClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            stmtClose(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_unicodeClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            unicodeClose(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_vfstraceClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            vfstraceClose(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_zipfileClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            zipfileClose(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_unixClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            unixClose(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_nolockClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            nolockClose(pReal->pFile);
          }
        else
          if (memcmp(pReal->pFile->pMethods->xClose_signature, xClose_signatures[xClose_dotlockClose_enum], sizeof(pReal->pFile->pMethods->xClose_signature)) == 0) {
            dotlockClose(pReal->pFile);
          }
      }
      sqlite3_free(pReal);
    }
  }
  return rc;
}

/*
** Delete the file located at zPath. If the dirSync argument is true,
** ensure the file-system modifications are synced to disk before
** returning.
*/
static int fsDelete(sqlite3_vfs *pVfs, const char *zPath, int dirSync){
  int rc = SQLITE_OK;
  fs_vfs_t *pFsVfs = (fs_vfs_t *)pVfs;
  fs_real_file *pReal;
  sqlite3_file *pF;
  int nName = (int)strlen(zPath) - 8;

  assert(strlen("-journal")==8);
  assert(strcmp("-journal", &zPath[nName])==0);

  pReal = pFsVfs->pFileList; 
  for(; pReal && strncmp(pReal->zName, zPath, nName); pReal=pReal->pNext);
  if( pReal ){
    pF = pReal->pFile;
    if (memcmp(pF->pMethods->xWrite_signature, xWrite_signatures[xWrite_apndWrite_enum], sizeof(pF->pMethods->xWrite_signature)) == 0) {
      rc = apndWrite(pF, "\0\0\0\0", 4, pReal->nBlob - BLOCKSIZE);
    }
    else
      if (memcmp(pF->pMethods->xWrite_signature, xWrite_signatures[xWrite_kvstorageWrite_enum], sizeof(pF->pMethods->xWrite_signature)) == 0) {
        rc = kvstorageWrite(pF, "\0\0\0\0", 4, pReal->nBlob - BLOCKSIZE);
      }
    else
      if (memcmp(pF->pMethods->xWrite_signature, xWrite_signatures[xWrite_memdbWrite_enum], sizeof(pF->pMethods->xWrite_signature)) == 0) {
        rc = memdbWrite(pF, "\0\0\0\0", 4, pReal->nBlob - BLOCKSIZE);
      }
    else
      if (memcmp(pF->pMethods->xWrite_signature, xWrite_signatures[xWrite_memjrnlWrite_enum], sizeof(pF->pMethods->xWrite_signature)) == 0) {
        rc = memjrnlWrite(pF, "\0\0\0\0", 4, pReal->nBlob - BLOCKSIZE);
      }
    else
      if (memcmp(pF->pMethods->xWrite_signature, xWrite_signatures[xWrite_recoverVfsWrite_enum], sizeof(pF->pMethods->xWrite_signature)) == 0) {
        rc = recoverVfsWrite(pF, "\0\0\0\0", 4, pReal->nBlob - BLOCKSIZE);
      }
    else
      if (memcmp(pF->pMethods->xWrite_signature, xWrite_signatures[xWrite_vfstraceWrite_enum], sizeof(pF->pMethods->xWrite_signature)) == 0) {
        rc = vfstraceWrite(pF, "\0\0\0\0", 4, pReal->nBlob - BLOCKSIZE);
      }
    else
      if (memcmp(pF->pMethods->xWrite_signature, xWrite_signatures[xWrite_unixWrite_enum], sizeof(pF->pMethods->xWrite_signature)) == 0) {
        rc = unixWrite(pF, "\0\0\0\0", 4, pReal->nBlob - BLOCKSIZE);
      }
    if( rc==SQLITE_OK ){
      pReal->nJournal = 0;
    }
  }
  return rc;
}

/*
** Test for access permissions. Return true if the requested permission
** is available, or false otherwise.
*/
static int fsAccess(
  sqlite3_vfs *pVfs, 
  const char *zPath, 
  int flags, 
  int *pResOut
){
  fs_vfs_t *pFsVfs = (fs_vfs_t *)pVfs;
  fs_real_file *pReal;
  int isJournal = 0;
  int nName = (int)strlen(zPath);

  if( flags!=SQLITE_ACCESS_EXISTS ){
    sqlite3_vfs *pParent = ((fs_vfs_t *)pVfs)->pParent;
    if (memcmp(pParent->xAccess_signature, xAccess_signatures[xAccess_apndAccess_enum], sizeof(pParent->xAccess_signature)) == 0) {
      return apndAccess(pParent, zPath, flags, pResOut);
    }
    else
      if (memcmp(pParent->xAccess_signature, xAccess_signatures[xAccess_memdbAccess_enum], sizeof(pParent->xAccess_signature)) == 0) {
        return memdbAccess(pParent, zPath, flags, pResOut);
      }
    else
      if (memcmp(pParent->xAccess_signature, xAccess_signatures[xAccess_vfstraceAccess_enum], sizeof(pParent->xAccess_signature)) == 0) {
        return vfstraceAccess(pParent, zPath, flags, pResOut);
      }
    else
      if (memcmp(pParent->xAccess_signature, xAccess_signatures[xAccess_unixAccess_enum], sizeof(pParent->xAccess_signature)) == 0) {
        return unixAccess(pParent, zPath, flags, pResOut);
      }
  }

  assert(strlen("-journal")==8);
  if( nName>8 && strcmp("-journal", &zPath[nName-8])==0 ){
    nName -= 8;
    isJournal = 1;
  }

  pReal = pFsVfs->pFileList; 
  for(; pReal && strncmp(pReal->zName, zPath, nName); pReal=pReal->pNext);

  *pResOut = (pReal && (!isJournal || pReal->nJournal>0));
  return SQLITE_OK;
}

/*
** Populate buffer zOut with the full canonical pathname corresponding
** to the pathname in zPath. zOut is guaranteed to point to a buffer
** of at least (FS_MAX_PATHNAME+1) bytes.
*/
static int fsFullPathname(
  sqlite3_vfs *pVfs,            /* Pointer to vfs object */
  const char *zPath,            /* Possibly relative input path */
  int nOut,                     /* Size of output buffer in bytes */
  char *zOut                    /* Output buffer */
){
  sqlite3_vfs *pParent = ((fs_vfs_t *)pVfs)->pParent;
  if (memcmp(pParent->xFullPathname_signature, xFullPathname_signatures[xFullPathname_apndFullPathname_enum], sizeof(pParent->xFullPathname_signature)) == 0) {
    return apndFullPathname(pParent, zPath, nOut, zOut);
  }
  else
    if (memcmp(pParent->xFullPathname_signature, xFullPathname_signatures[xFullPathname_memdbFullPathname_enum], sizeof(pParent->xFullPathname_signature)) == 0) {
      return memdbFullPathname(pParent, zPath, nOut, zOut);
    }
  else
    if (memcmp(pParent->xFullPathname_signature, xFullPathname_signatures[xFullPathname_vfstraceFullPathname_enum], sizeof(pParent->xFullPathname_signature)) == 0) {
      return vfstraceFullPathname(pParent, zPath, nOut, zOut);
    }
  else
    if (memcmp(pParent->xFullPathname_signature, xFullPathname_signatures[xFullPathname_unixFullPathname_enum], sizeof(pParent->xFullPathname_signature)) == 0) {
      return unixFullPathname(pParent, zPath, nOut, zOut);
    }
}

/*
** Open the dynamic library located at zPath and return a handle.
*/
static void *fsDlOpen(sqlite3_vfs *pVfs, const char *zPath){
  sqlite3_vfs *pParent = ((fs_vfs_t *)pVfs)->pParent;
  if (memcmp(pParent->xDlOpen_signature, xDlOpen_signatures[xDlOpen_apndDlOpen_enum], sizeof(pParent->xDlOpen_signature)) == 0) {
    return apndDlOpen(pParent, zPath);
  }
  else
    if (memcmp(pParent->xDlOpen_signature, xDlOpen_signatures[xDlOpen_memdbDlOpen_enum], sizeof(pParent->xDlOpen_signature)) == 0) {
      return memdbDlOpen(pParent, zPath);
    }
  else
    if (memcmp(pParent->xDlOpen_signature, xDlOpen_signatures[xDlOpen_unixDlOpen_enum], sizeof(pParent->xDlOpen_signature)) == 0) {
      return unixDlOpen(pParent, zPath);
    }
}

/*
** Populate the buffer zErrMsg (size nByte bytes) with a human readable
** utf-8 string describing the most recent error encountered associated 
** with dynamic libraries.
*/
static void fsDlError(sqlite3_vfs *pVfs, int nByte, char *zErrMsg){
  sqlite3_vfs *pParent = ((fs_vfs_t *)pVfs)->pParent;
  if (memcmp(pParent->xDlError_signature, xDlError_signatures[xDlError_0_enum], sizeof(pParent->xDlError_signature)) == 0) {
    0;
  }
  else
    if (memcmp(pParent->xDlError_signature, xDlError_signatures[xDlError_apndDlError_enum], sizeof(pParent->xDlError_signature)) == 0) {
      apndDlError(pParent, nByte, zErrMsg);
    }
  else
    if (memcmp(pParent->xDlError_signature, xDlError_signatures[xDlError_memdbDlError_enum], sizeof(pParent->xDlError_signature)) == 0) {
      memdbDlError(pParent, nByte, zErrMsg);
    }
  else
    if (memcmp(pParent->xDlError_signature, xDlError_signatures[xDlError_unixDlError_enum], sizeof(pParent->xDlError_signature)) == 0) {
      unixDlError(pParent, nByte, zErrMsg);
    }
}

/*
** Return a pointer to the symbol zSymbol in the dynamic library pHandle.
*/
static void (*fsDlSym(sqlite3_vfs *pVfs, void *pH, const char *zSym))(void){
  sqlite3_vfs *pParent = ((fs_vfs_t *)pVfs)->pParent;
  return pParent->xDlSym(pParent, pH, zSym);
}

/*
** Close the dynamic library handle pHandle.
*/
static void fsDlClose(sqlite3_vfs *pVfs, void *pHandle){
  sqlite3_vfs *pParent = ((fs_vfs_t *)pVfs)->pParent;
  if (memcmp(pParent->xDlClose_signature, xDlClose_signatures[xDlClose_0_enum], sizeof(pParent->xDlClose_signature)) == 0) {
    0;
  }
  else
    if (memcmp(pParent->xDlClose_signature, xDlClose_signatures[xDlClose_apndDlClose_enum], sizeof(pParent->xDlClose_signature)) == 0) {
      apndDlClose(pParent, pHandle);
    }
  else
    if (memcmp(pParent->xDlClose_signature, xDlClose_signatures[xDlClose_memdbDlClose_enum], sizeof(pParent->xDlClose_signature)) == 0) {
      memdbDlClose(pParent, pHandle);
    }
  else
    if (memcmp(pParent->xDlClose_signature, xDlClose_signatures[xDlClose_unixDlClose_enum], sizeof(pParent->xDlClose_signature)) == 0) {
      unixDlClose(pParent, pHandle);
    }
}

/*
** Populate the buffer pointed to by zBufOut with nByte bytes of 
** random data.
*/
static int fsRandomness(sqlite3_vfs *pVfs, int nByte, char *zBufOut){
  sqlite3_vfs *pParent = ((fs_vfs_t *)pVfs)->pParent;
  if (memcmp(pParent->xRandomness_signature, xRandomness_signatures[xRandomness_apndRandomness_enum], sizeof(pParent->xRandomness_signature)) == 0) {
    return apndRandomness(pParent, nByte, zBufOut);
  }
  else
    if (memcmp(pParent->xRandomness_signature, xRandomness_signatures[xRandomness_memdbRandomness_enum], sizeof(pParent->xRandomness_signature)) == 0) {
      return memdbRandomness(pParent, nByte, zBufOut);
    }
  else
    if (memcmp(pParent->xRandomness_signature, xRandomness_signatures[xRandomness_vfstraceRandomness_enum], sizeof(pParent->xRandomness_signature)) == 0) {
      return vfstraceRandomness(pParent, nByte, zBufOut);
    }
  else
    if (memcmp(pParent->xRandomness_signature, xRandomness_signatures[xRandomness_unixRandomness_enum], sizeof(pParent->xRandomness_signature)) == 0) {
      return unixRandomness(pParent, nByte, zBufOut);
    }
}

/*
** Sleep for nMicro microseconds. Return the number of microseconds 
** actually slept.
*/
static int fsSleep(sqlite3_vfs *pVfs, int nMicro){
  sqlite3_vfs *pParent = ((fs_vfs_t *)pVfs)->pParent;
  if (memcmp(pParent->xSleep_signature, xSleep_signatures[xSleep_0_enum], sizeof(pParent->xSleep_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pParent->xSleep_signature, xSleep_signatures[xSleep_apndSleep_enum], sizeof(pParent->xSleep_signature)) == 0) {
      return apndSleep(pParent, nMicro);
    }
  else
    if (memcmp(pParent->xSleep_signature, xSleep_signatures[xSleep_memdbSleep_enum], sizeof(pParent->xSleep_signature)) == 0) {
      return memdbSleep(pParent, nMicro);
    }
  else
    if (memcmp(pParent->xSleep_signature, xSleep_signatures[xSleep_vfstraceSleep_enum], sizeof(pParent->xSleep_signature)) == 0) {
      return vfstraceSleep(pParent, nMicro);
    }
  else
    if (memcmp(pParent->xSleep_signature, xSleep_signatures[xSleep_unixSleep_enum], sizeof(pParent->xSleep_signature)) == 0) {
      return unixSleep(pParent, nMicro);
    }
}

/*
** Return the current time as a Julian Day number in *pTimeOut.
*/
static int fsCurrentTime(sqlite3_vfs *pVfs, double *pTimeOut){
  sqlite3_vfs *pParent = ((fs_vfs_t *)pVfs)->pParent;
  if (memcmp(pParent->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_0_enum], sizeof(pParent->xCurrentTime_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pParent->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_apndCurrentTime_enum], sizeof(pParent->xCurrentTime_signature)) == 0) {
      return apndCurrentTime(pParent, pTimeOut);
    }
  else
    if (memcmp(pParent->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_vfstraceCurrentTime_enum], sizeof(pParent->xCurrentTime_signature)) == 0) {
      return vfstraceCurrentTime(pParent, pTimeOut);
    }
  else
    if (memcmp(pParent->xCurrentTime_signature, xCurrentTime_signatures[xCurrentTime_unixCurrentTime_enum], sizeof(pParent->xCurrentTime_signature)) == 0) {
      return unixCurrentTime(pParent, pTimeOut);
    }
}

/*
** This procedure registers the fs vfs with SQLite. If the argument is
** true, the fs vfs becomes the new default vfs. It is the only publicly
** available function in this file.
*/
int fs_register(void){
  if( fs_vfs.pParent ) return SQLITE_OK;
  fs_vfs.pParent = sqlite3_vfs_find(0);
  fs_vfs.base.mxPathname = fs_vfs.pParent->mxPathname;
  fs_vfs.base.szOsFile = MAX(sizeof(tmp_file), sizeof(fs_file));
  return sqlite3_vfs_register(&fs_vfs.base, 0);
}

#ifdef SQLITE_TEST
  int SqlitetestOnefile_Init() {return fs_register();}
#endif
