/*
** 2010 September 31
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
** This file contains a VFS "shim" - a layer that sits in between the
** pager and the real VFS.
**
** This particular shim enforces a quota system on files.  One or more
** database files are in a "quota group" that is defined by a GLOB
** pattern.  A quota is set for the combined size of all files in the
** the group.  A quota of zero means "no limit".  If the total size
** of all files in the quota group is greater than the limit, then
** write requests that attempt to enlarge a file fail with SQLITE_FULL.
**
** However, before returning SQLITE_FULL, the write requests invoke
** a callback function that is configurable for each quota group.
** This callback has the opportunity to enlarge the quota.  If the
** callback does enlarge the quota such that the total size of all
** files within the group is less than the new quota, then the write
** continues as if nothing had happened.
*/
#include "test_quota.h"
#include <string.h>
#include <assert.h>

/*
** For an build without mutexes, no-op the mutex calls.
*/
#if defined(SQLITE_THREADSAFE) && SQLITE_THREADSAFE==0
#define sqlite3_mutex_alloc(X)    ((sqlite3_mutex*)8)
#define sqlite3_mutex_free(X)
#define sqlite3_mutex_enter(X)
#define sqlite3_mutex_try(X)      SQLITE_OK
#define sqlite3_mutex_leave(X)
#define sqlite3_mutex_held(X)     ((void)(X),1)
#define sqlite3_mutex_notheld(X)  ((void)(X),1)
#endif /* SQLITE_THREADSAFE==0 */


#ifdef _WIN32
# include <windows.h>
# include <io.h>
#else
# include <unistd.h>
#endif


/************************ Object Definitions ******************************/

/* Forward declaration of all object types */
typedef struct quotaGroup quotaGroup;
typedef struct quotaConn quotaConn;
typedef struct quotaFile quotaFile;

/*
** A "quota group" is a collection of files whose collective size we want
** to limit.  Each quota group is defined by a GLOB pattern.
**
** There is an instance of the following object for each defined quota
** group.  This object records the GLOB pattern that defines which files
** belong to the quota group.  The object also remembers the size limit
** for the group (the quota) and the callback to be invoked when the
** sum of the sizes of the files within the group goes over the limit.
**
** A quota group must be established (using sqlite3_quota_set(...))
** prior to opening any of the database connections that access files
** within the quota group.
*/
struct quotaGroup {
  const char *zPattern;          /* Filename pattern to be quotaed */
  sqlite3_int64 iLimit;          /* Upper bound on total file size */
  sqlite3_int64 iSize;           /* Current size of all files */
  void (*xCallback)(             /* Callback invoked when going over quota */
     const char *zFilename,         /* Name of file whose size increases */
     sqlite3_int64 *piLimit,        /* IN/OUT: The current limit */
     sqlite3_int64 iSize,           /* Total size of all files in the group */
     void *pArg                     /* Client data */
  );
  void *pArg;                    /* Third argument to the xCallback() */
  void (*xDestroy)(void*);       /* Optional destructor for pArg */
  quotaGroup *pNext, **ppPrev;   /* Doubly linked list of all quota objects */
  quotaFile *pFiles;
  int *xCallback_signature;
  int *xDestroy_signature;
             /* Files within this group */
};

/*
** An instance of this structure represents a single file that is part
** of a quota group.  A single file can be opened multiple times.  In
** order keep multiple openings of the same file from causing the size
** of the file to count against the quota multiple times, each file
** has a unique instance of this object and multiple open connections
** to the same file each point to a single instance of this object.
*/
struct quotaFile {
  char *zFilename;                /* Name of this file */
  quotaGroup *pGroup;             /* Quota group to which this file belongs */
  sqlite3_int64 iSize;            /* Current size of this file */
  int nRef;                       /* Number of times this file is open */
  int deleteOnClose;              /* True to delete this file when it closes */
  quotaFile *pNext, **ppPrev;     /* Linked list of files in the same group */
};

/*
** An instance of the following object represents each open connection
** to a file that participates in quota tracking.  This object is a
** subclass of sqlite3_file.  The sqlite3_file object for the underlying
** VFS is appended to this structure.
*/
struct quotaConn {
  sqlite3_file base;              /* Base class - must be first */
  quotaFile *pFile;               /* The underlying file */
  /* The underlying VFS sqlite3_file is appended to this object */
};

/*
** An instance of the following object records the state of an
** open file.  This object is opaque to all users - the internal
** structure is only visible to the functions below.
*/
struct quota_FILE {
  FILE *f;                /* Open stdio file pointer */
  sqlite3_int64 iOfst;    /* Current offset into the file */
  quotaFile *pFile;       /* The file record in the quota system */
#ifdef _WIN32
  char *zMbcsName;        /* Full MBCS pathname of the file */
#endif
};


/************************* Global Variables **********************************/
/*
** All global variables used by this file are containing within the following
** gQuota structure.
*/
static struct {
  /* The pOrigVfs is the real, original underlying VFS implementation.
  ** Most operations pass-through to the real VFS.  This value is read-only
  ** during operation.  It is only modified at start-time and thus does not
  ** require a mutex.
  */
  sqlite3_vfs *pOrigVfs;

  /* The sThisVfs is the VFS structure used by this shim.  It is initialized
  ** at start-time and thus does not require a mutex
  */
  sqlite3_vfs sThisVfs;

  /* The sIoMethods defines the methods used by sqlite3_file objects
  ** associated with this shim.  It is initialized at start-time and does
  ** not require a mutex.
  **
  ** When the underlying VFS is called to open a file, it might return
  ** either a version 1 or a version 2 sqlite3_file object.  This shim
  ** has to create a wrapper sqlite3_file of the same version.  Hence
  ** there are two I/O method structures, one for version 1 and the other
  ** for version 2.
  */
  sqlite3_io_methods sIoMethodsV1;
  sqlite3_io_methods sIoMethodsV2;

  /* True when this shim as been initialized.
  */
  int isInitialized;

  /* For run-time access any of the other global data structures in this
  ** shim, the following mutex must be held.
  */
  sqlite3_mutex *pMutex;

  /* List of quotaGroup objects.
  */
  quotaGroup *pGroup;

} gQuota;

/************************* Utility Routines *********************************/
/*
** Acquire and release the mutex used to serialize access to the
** list of quotaGroups.
*/
static void quotaEnter(void){ sqlite3_mutex_enter(gQuota.pMutex); }
static void quotaLeave(void){ sqlite3_mutex_leave(gQuota.pMutex); }

/* Count the number of open files in a quotaGroup
*/
static int quotaGroupOpenFileCount(quotaGroup *pGroup){
  int N = 0;
  quotaFile *pFile = pGroup->pFiles;
  while( pFile ){
    if( pFile->nRef ) N++;
    pFile = pFile->pNext;
  }
  return N;
}

/* Remove a file from a quota group.
*/
static void quotaRemoveFile(quotaFile *pFile){
  quotaGroup *pGroup = pFile->pGroup;
  pGroup->iSize -= pFile->iSize;
  *pFile->ppPrev = pFile->pNext;
  if( pFile->pNext ) pFile->pNext->ppPrev = pFile->ppPrev;
  sqlite3_free(pFile);
}

/* Remove all files from a quota group.  It is always the case that
** all files will be closed when this routine is called.
*/
static void quotaRemoveAllFiles(quotaGroup *pGroup){
  while( pGroup->pFiles ){
    assert( pGroup->pFiles->nRef==0 );
    quotaRemoveFile(pGroup->pFiles);
  }
}


/* If the reference count and threshold for a quotaGroup are both
** zero, then destroy the quotaGroup.
*/
static void quotaGroupDeref(quotaGroup *pGroup){
  if( pGroup->iLimit==0 && quotaGroupOpenFileCount(pGroup)==0 ){
    quotaRemoveAllFiles(pGroup);
    *pGroup->ppPrev = pGroup->pNext;
    if( pGroup->pNext ) pGroup->pNext->ppPrev = pGroup->ppPrev;
    if( pGroup->xDestroy ) {
      if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_0_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
        0;
      }
      else
        if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_dbpageDisconnect_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
          dbpageDisconnect(pGroup->pArg);
        }
      else
        if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_expertDisconnect_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
          expertDisconnect(pGroup->pArg);
        }
      else
        if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_fsdirDisconnect_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
          fsdirDisconnect(pGroup->pArg);
        }
      else
        if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_fts3DestroyMethod_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
          fts3DestroyMethod(pGroup->pArg);
        }
      else
        if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_fts3auxDisconnectMethod_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
          fts3auxDisconnectMethod(pGroup->pArg);
        }
      else
        if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_fts3tokDisconnectMethod_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
          fts3tokDisconnectMethod(pGroup->pArg);
        }
      else
        if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_pcache1Destroy_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
          pcache1Destroy(pGroup->pArg);
        }
      else
        if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_pcachetraceDestroy_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
          pcachetraceDestroy(pGroup->pArg);
        }
      else
        if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_porterDestroy_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
          porterDestroy(pGroup->pArg);
        }
      else
        if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_rtreeDestroy_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
          rtreeDestroy(pGroup->pArg);
        }
      else
        if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_simpleDestroy_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
          simpleDestroy(pGroup->pArg);
        }
      else
        if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_statDisconnect_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
          statDisconnect(pGroup->pArg);
        }
      else
        if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_unicodeDestroy_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
          unicodeDestroy(pGroup->pArg);
        }
      else
        if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_zipfileDisconnect_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
          zipfileDisconnect(pGroup->pArg);
        }
    }
    sqlite3_free(pGroup);
  }
}

/*
** Return TRUE if string z matches glob pattern zGlob.
**
** Globbing rules:
**
**      '*'       Matches any sequence of zero or more characters.
**
**      '?'       Matches exactly one character.
**
**     [...]      Matches one character from the enclosed list of
**                characters.
**
**     [^...]     Matches one character not in the enclosed list.
**
**     /          Matches "/" or "\\"
**
*/
static int quotaStrglob(const char *zGlob, const char *z){
  int c, c2, cx;
  int invert;
  int seen;

  while( (c = (*(zGlob++)))!=0 ){
    if( c=='*' ){
      while( (c=(*(zGlob++))) == '*' || c=='?' ){
        if( c=='?' && (*(z++))==0 ) return 0;
      }
      if( c==0 ){
        return 1;
      }else if( c=='[' ){
        while( *z && quotaStrglob(zGlob-1,z)==0 ){
          z++;
        }
        return (*z)!=0;
      }
      cx = (c=='/') ? '\\' : c;
      while( (c2 = (*(z++)))!=0 ){
        while( c2!=c && c2!=cx ){
          c2 = *(z++);
          if( c2==0 ) return 0;
        }
        if( quotaStrglob(zGlob,z) ) return 1;
      }
      return 0;
    }else if( c=='?' ){
      if( (*(z++))==0 ) return 0;
    }else if( c=='[' ){
      int prior_c = 0;
      seen = 0;
      invert = 0;
      c = *(z++);
      if( c==0 ) return 0;
      c2 = *(zGlob++);
      if( c2=='^' ){
        invert = 1;
        c2 = *(zGlob++);
      }
      if( c2==']' ){
        if( c==']' ) seen = 1;
        c2 = *(zGlob++);
      }
      while( c2 && c2!=']' ){
        if( c2=='-' && zGlob[0]!=']' && zGlob[0]!=0 && prior_c>0 ){
          c2 = *(zGlob++);
          if( c>=prior_c && c<=c2 ) seen = 1;
          prior_c = 0;
        }else{
          if( c==c2 ){
            seen = 1;
          }
          prior_c = c2;
        }
        c2 = *(zGlob++);
      }
      if( c2==0 || (seen ^ invert)==0 ) return 0;
    }else if( c=='/' ){
      if( z[0]!='/' && z[0]!='\\' ) return 0;
      z++;
    }else{
      if( c!=(*(z++)) ) return 0;
    }
  }
  return *z==0;
}


/* Find a quotaGroup given the filename.
**
** Return a pointer to the quotaGroup object. Return NULL if not found.
*/
static quotaGroup *quotaGroupFind(const char *zFilename){
  quotaGroup *p;
  for(p=gQuota.pGroup; p && quotaStrglob(p->zPattern, zFilename)==0;
      p=p->pNext){}
  return p;
}

/* Translate an sqlite3_file* that is really a quotaConn* into
** the sqlite3_file* for the underlying original VFS.
*/
sqlite3_file *quotaSubOpen(sqlite3_file *pConn){
  quotaConn *p = (quotaConn*)pConn;
  return (sqlite3_file*)&p[1];
}

/* Find a file in a quota group and return a pointer to that file.
** Return NULL if the file is not in the group.
*/
static quotaFile *quotaFindFile(
  quotaGroup *pGroup,     /* Group in which to look for the file */
  const char *zName,      /* Full pathname of the file */
  int createFlag          /* Try to create the file if not found */
){
  quotaFile *pFile = pGroup->pFiles;
  while( pFile && strcmp(pFile->zFilename, zName)!=0 ){
    pFile = pFile->pNext;
  }
  if( pFile==0 && createFlag ){
    int nName = (int)(strlen(zName) & 0x3fffffff);
    pFile = (quotaFile *)sqlite3_malloc( sizeof(*pFile) + nName + 1 );
    if( pFile ){
      memset(pFile, 0, sizeof(*pFile));
      pFile->zFilename = (char*)&pFile[1];
      memcpy(pFile->zFilename, zName, nName+1);
      pFile->pNext = pGroup->pFiles;
      if( pGroup->pFiles ) pGroup->pFiles->ppPrev = &pFile->pNext;
      pFile->ppPrev = &pGroup->pFiles;
      pGroup->pFiles = pFile;
      pFile->pGroup = pGroup;
    }
  }
  return pFile;
}
/*
** Translate UTF8 to MBCS for use in fopen() calls.  Return a pointer to the
** translated text..  Call quota_mbcs_free() to deallocate any memory
** used to store the returned pointer when done.
*/
char *quota_utf8_to_mbcs(const char *zUtf8){
#ifdef _WIN32
  size_t n;          /* Bytes in zUtf8 */
  int nWide;         /* number of UTF-16 characters */
  int nMbcs;         /* Bytes of MBCS */
  LPWSTR zTmpWide;   /* The UTF16 text */
  char *zMbcs;       /* The MBCS text */
  int codepage;      /* Code page used by fopen() */

  n = strlen(zUtf8);
  nWide = MultiByteToWideChar(CP_UTF8, 0, zUtf8, -1, NULL, 0);
  if( nWide==0 ) return 0;
  zTmpWide = (LPWSTR)sqlite3_malloc( (nWide+1)*sizeof(zTmpWide[0]) );
  if( zTmpWide==0 ) return 0;
  MultiByteToWideChar(CP_UTF8, 0, zUtf8, -1, zTmpWide, nWide);
#ifdef SQLITE_OS_WINRT
  codepage = CP_ACP;
#else
  codepage = AreFileApisANSI() ? CP_ACP : CP_OEMCP;
#endif
  nMbcs = WideCharToMultiByte(codepage, 0, zTmpWide, nWide, 0, 0, 0, 0);
  zMbcs = nMbcs ? (char*)sqlite3_malloc( nMbcs+1 ) : 0;
  if( zMbcs ){
    WideCharToMultiByte(codepage, 0, zTmpWide, nWide, zMbcs, nMbcs, 0, 0);
  }
  sqlite3_free(zTmpWide);
  return zMbcs;
#else
  return (char*)zUtf8;  /* No-op on unix */
#endif
}

/*
** Deallocate any memory allocated by quota_utf8_to_mbcs().
*/
void quota_mbcs_free(char *zOld){
#ifdef _WIN32
  sqlite3_free(zOld);
#else
  /* No-op on unix */
#endif
}

/************************* VFS Method Wrappers *****************************/
/*
** This is the xOpen method used for the "quota" VFS.
**
** Most of the work is done by the underlying original VFS.  This method
** simply links the new file into the appropriate quota group if it is a
** file that needs to be tracked.
*/
int quotaOpen(
  sqlite3_vfs *pVfs,          /* The quota VFS */
  const char *zName,          /* Name of file to be opened */
  sqlite3_file *pConn,        /* Fill in this file descriptor */
  int flags,                  /* Flags to control the opening */
  int *pOutFlags              /* Flags showing results of opening */
){
  int rc;                                    /* Result code */
  quotaConn *pQuotaOpen;                     /* The new quota file descriptor */
  quotaFile *pFile;                          /* Corresponding quotaFile obj */
  quotaGroup *pGroup;                        /* The group file belongs to */
  sqlite3_file *pSubOpen;                    /* Real file descriptor */
  sqlite3_vfs *pOrigVfs = gQuota.pOrigVfs;   /* Real VFS */

  /* If the file is not a main database file or a WAL, then use the
  ** normal xOpen method.
  */
  if( (flags & (SQLITE_OPEN_MAIN_DB|SQLITE_OPEN_WAL))==0 ){
    if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_amatchOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
      return amatchOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
    }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_apndOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return apndOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_binfoOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return binfoOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_bytecodevtabOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return bytecodevtabOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_carrayOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return carrayOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_cidxOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return cidxOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_closureOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return closureOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_completionOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return completionOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_csvtabOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return csvtabOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_dbdataOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return dbdataOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_dbpageOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return dbpageOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_deltaparsevtabOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return deltaparsevtabOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_echoOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return echoOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_expertOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return expertOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_explainOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return explainOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fsOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return fsOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fsdirOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return fsdirOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fstreeOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return fstreeOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fts3OpenMethod_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return fts3OpenMethod(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fts3auxOpenMethod_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return fts3auxOpenMethod(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fts3termOpenMethod_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return fts3termOpenMethod(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fts3tokOpenMethod_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return fts3tokOpenMethod(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fuzzerOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return fuzzerOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_intarrayOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return intarrayOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return jsonEachOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpenEach_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return jsonEachOpenEach(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpenTree_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return jsonEachOpenTree(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_memdbOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return memdbOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_memstatOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return memstatOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_porterOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return porterOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_pragmaVtabOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return pragmaVtabOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_prefixesOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return prefixesOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_qpvtabOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return qpvtabOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_rtreeOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return rtreeOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_schemaOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return schemaOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_seriesOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return seriesOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_simpleOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return simpleOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_spellfix1Open_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return spellfix1Open(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_statOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return statOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_stmtOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return stmtOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_tclOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return tclOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_tclvarOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return tclvarOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_templatevtabOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return templatevtabOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_unicodeOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return unicodeOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_unionOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return unionOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_vfstraceOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return vfstraceOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_vstattabOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return vstattabOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_vtablogOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return vtablogOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_wholenumberOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return wholenumberOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_zipfileOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return zipfileOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_unixOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        return unixOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
  }

  /* If the name of the file does not match any quota group, then
  ** use the normal xOpen method.
  */
  quotaEnter();
  pGroup = quotaGroupFind(zName);
  if( pGroup==0 ){
    if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_amatchOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
      rc = amatchOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
    }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_apndOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = apndOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_binfoOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = binfoOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_bytecodevtabOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = bytecodevtabOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_carrayOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = carrayOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_cidxOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = cidxOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_closureOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = closureOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_completionOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = completionOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_csvtabOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = csvtabOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_dbdataOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = dbdataOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_dbpageOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = dbpageOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_deltaparsevtabOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = deltaparsevtabOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_echoOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = echoOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_expertOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = expertOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_explainOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = explainOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fsOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = fsOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fsdirOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = fsdirOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fstreeOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = fstreeOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fts3OpenMethod_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = fts3OpenMethod(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fts3auxOpenMethod_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = fts3auxOpenMethod(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fts3termOpenMethod_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = fts3termOpenMethod(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fts3tokOpenMethod_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = fts3tokOpenMethod(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fuzzerOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = fuzzerOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_intarrayOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = intarrayOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = jsonEachOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpenEach_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = jsonEachOpenEach(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpenTree_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = jsonEachOpenTree(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_memdbOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = memdbOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_memstatOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = memstatOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_porterOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = porterOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_pragmaVtabOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = pragmaVtabOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_prefixesOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = prefixesOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_qpvtabOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = qpvtabOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_rtreeOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = rtreeOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_schemaOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = schemaOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_seriesOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = seriesOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_simpleOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = simpleOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_spellfix1Open_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = spellfix1Open(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_statOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = statOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_stmtOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = stmtOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_tclOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = tclOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_tclvarOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = tclvarOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_templatevtabOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = templatevtabOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_unicodeOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = unicodeOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_unionOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = unionOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_vfstraceOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = vfstraceOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_vstattabOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = vstattabOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_vtablogOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = vtablogOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_wholenumberOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = wholenumberOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_zipfileOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = zipfileOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_unixOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = unixOpen(pOrigVfs, zName, pConn, flags, pOutFlags);
      }
  }else{
    /* If we get to this point, it means the file needs to be quota tracked.
    */
    pQuotaOpen = (quotaConn*)pConn;
    pSubOpen = quotaSubOpen(pConn);
    if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_amatchOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
      rc = amatchOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
    }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_apndOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = apndOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_binfoOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = binfoOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_bytecodevtabOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = bytecodevtabOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_carrayOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = carrayOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_cidxOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = cidxOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_closureOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = closureOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_completionOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = completionOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_csvtabOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = csvtabOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_dbdataOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = dbdataOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_dbpageOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = dbpageOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_deltaparsevtabOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = deltaparsevtabOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_echoOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = echoOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_expertOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = expertOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_explainOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = explainOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fsOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = fsOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fsdirOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = fsdirOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fstreeOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = fstreeOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fts3OpenMethod_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = fts3OpenMethod(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fts3auxOpenMethod_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = fts3auxOpenMethod(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fts3termOpenMethod_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = fts3termOpenMethod(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fts3tokOpenMethod_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = fts3tokOpenMethod(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_fuzzerOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = fuzzerOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_intarrayOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = intarrayOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = jsonEachOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpenEach_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = jsonEachOpenEach(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpenTree_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = jsonEachOpenTree(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_memdbOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = memdbOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_memstatOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = memstatOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_porterOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = porterOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_pragmaVtabOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = pragmaVtabOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_prefixesOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = prefixesOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_qpvtabOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = qpvtabOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_rtreeOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = rtreeOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_schemaOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = schemaOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_seriesOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = seriesOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_simpleOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = simpleOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_spellfix1Open_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = spellfix1Open(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_statOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = statOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_stmtOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = stmtOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_tclOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = tclOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_tclvarOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = tclvarOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_templatevtabOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = templatevtabOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_unicodeOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = unicodeOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_unionOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = unionOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_vfstraceOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = vfstraceOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_vstattabOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = vstattabOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_vtablogOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = vtablogOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_wholenumberOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = wholenumberOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_zipfileOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = zipfileOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    else
      if (memcmp(pOrigVfs->xOpen_signature, xOpen_signatures[xOpen_unixOpen_enum], sizeof(pOrigVfs->xOpen_signature)) == 0) {
        rc = unixOpen(pOrigVfs, zName, pSubOpen, flags, pOutFlags);
      }
    if( rc==SQLITE_OK ){
      pFile = quotaFindFile(pGroup, zName, 1);
      if( pFile==0 ){
        quotaLeave();
        if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_apndClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
          apndClose(pSubOpen);
        }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_bytecodevtabClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            bytecodevtabClose(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_completionClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            completionClose(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_dbdataClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            dbdataClose(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_dbpageClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            dbpageClose(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_expertClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            expertClose(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_fsdirClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            fsdirClose(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_fts3CloseMethod_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            fts3CloseMethod(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_fts3auxCloseMethod_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            fts3auxCloseMethod(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_fts3tokCloseMethod_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            fts3tokCloseMethod(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_jsonEachClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            jsonEachClose(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_memdbClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            memdbClose(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_memjrnlClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            memjrnlClose(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_porterClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            porterClose(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_pragmaVtabClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            pragmaVtabClose(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_recoverVfsClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            recoverVfsClose(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_rtreeClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            rtreeClose(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_seriesClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            seriesClose(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_simpleClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            simpleClose(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_statClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            statClose(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_stmtClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            stmtClose(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_unicodeClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            unicodeClose(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_vfstraceClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            vfstraceClose(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_zipfileClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            zipfileClose(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_unixClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            unixClose(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_nolockClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            nolockClose(pSubOpen);
          }
        else
          if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_dotlockClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
            dotlockClose(pSubOpen);
          }
        return SQLITE_NOMEM;
      }
      pFile->deleteOnClose = (flags & SQLITE_OPEN_DELETEONCLOSE)!=0;
      pFile->nRef++;
      pQuotaOpen->pFile = pFile;
      if( pSubOpen->pMethods->iVersion==1 ){
        pQuotaOpen->base.pMethods = &gQuota.sIoMethodsV1;
      }else{
        pQuotaOpen->base.pMethods = &gQuota.sIoMethodsV2;
      }
    }
  }
  quotaLeave();
  return rc;
}

/*
** This is the xDelete method used for the "quota" VFS.
**
** If the file being deleted is part of the quota group, then reduce
** the size of the quota group accordingly.  And remove the file from
** the set of files in the quota group.
*/
int quotaDelete(
  sqlite3_vfs *pVfs,          /* The quota VFS */
  const char *zName,          /* Name of file to be deleted */
  int syncDir                 /* Do a directory sync after deleting */
){
  int rc;                                    /* Result code */
  quotaFile *pFile;                          /* Files in the quota */
  quotaGroup *pGroup;                        /* The group file belongs to */
  sqlite3_vfs *pOrigVfs = gQuota.pOrigVfs;   /* Real VFS */

  /* Do the actual file delete */
  if (memcmp(pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_0_enum], sizeof(pOrigVfs->xDelete_signature)) == 0) {
    rc = 0;
  }
  else
    if (memcmp(pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_apndDelete_enum], sizeof(pOrigVfs->xDelete_signature)) == 0) {
      rc = apndDelete(pOrigVfs, zName, syncDir);
    }
  else
    if (memcmp(pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_f5tOrigintextDelete_enum], sizeof(pOrigVfs->xDelete_signature)) == 0) {
      rc = f5tOrigintextDelete(pOrigVfs, zName, syncDir);
    }
  else
    if (memcmp(pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_f5tTokenizerDelete_enum], sizeof(pOrigVfs->xDelete_signature)) == 0) {
      rc = f5tTokenizerDelete(pOrigVfs, zName, syncDir);
    }
  else
    if (memcmp(pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_kvstorageDelete_enum], sizeof(pOrigVfs->xDelete_signature)) == 0) {
      rc = kvstorageDelete(pOrigVfs, zName, syncDir);
    }
  else
    if (memcmp(pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_vfstraceDelete_enum], sizeof(pOrigVfs->xDelete_signature)) == 0) {
      rc = vfstraceDelete(pOrigVfs, zName, syncDir);
    }
  else
    if (memcmp(pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_unixDelete_enum], sizeof(pOrigVfs->xDelete_signature)) == 0) {
      rc = unixDelete(pOrigVfs, zName, syncDir);
    }

  /* If the file just deleted is a member of a quota group, then remove
  ** it from that quota group.
  */
  if( rc==SQLITE_OK ){
    quotaEnter();
    pGroup = quotaGroupFind(zName);
    if( pGroup ){
      pFile = quotaFindFile(pGroup, zName, 0);
      if( pFile ){
        if( pFile->nRef ){
          pFile->deleteOnClose = 1;
        }else{
          quotaRemoveFile(pFile);
          quotaGroupDeref(pGroup);
        }
      }
    }
    quotaLeave();
  }
  return rc;
}


/************************ I/O Method Wrappers *******************************/

/* xClose requests get passed through to the original VFS.  But we
** also have to unlink the quotaConn from the quotaFile and quotaGroup.
** The quotaFile and/or quotaGroup are freed if they are no longer in use.
*/
int quotaClose(sqlite3_file *pConn){
  quotaConn *p = (quotaConn*)pConn;
  quotaFile *pFile = p->pFile;
  sqlite3_file *pSubOpen = quotaSubOpen(pConn);
  int rc;
  if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_apndClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
    rc = apndClose(pSubOpen);
  }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_bytecodevtabClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = bytecodevtabClose(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_completionClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = completionClose(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_dbdataClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = dbdataClose(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_dbpageClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = dbpageClose(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_expertClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = expertClose(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_fsdirClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = fsdirClose(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_fts3CloseMethod_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = fts3CloseMethod(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_fts3auxCloseMethod_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = fts3auxCloseMethod(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_fts3tokCloseMethod_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = fts3tokCloseMethod(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_jsonEachClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = jsonEachClose(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_memdbClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = memdbClose(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_memjrnlClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = memjrnlClose(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_porterClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = porterClose(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_pragmaVtabClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = pragmaVtabClose(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_recoverVfsClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = recoverVfsClose(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_rtreeClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = rtreeClose(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_seriesClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = seriesClose(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_simpleClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = simpleClose(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_statClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = statClose(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_stmtClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = stmtClose(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_unicodeClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = unicodeClose(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_vfstraceClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = vfstraceClose(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_zipfileClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = zipfileClose(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_unixClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = unixClose(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_nolockClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = nolockClose(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xClose_signature, xClose_signatures[xClose_dotlockClose_enum], sizeof(pSubOpen->pMethods->xClose_signature)) == 0) {
      rc = dotlockClose(pSubOpen);
    }
  quotaEnter();
  pFile->nRef--;
  if( pFile->nRef==0 ){
    quotaGroup *pGroup = pFile->pGroup;
    if( pFile->deleteOnClose ){
      if (memcmp(gQuota.pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_0_enum], sizeof(gQuota.pOrigVfs->xDelete_signature)) == 0) {
        0;
      }
      else
        if (memcmp(gQuota.pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_apndDelete_enum], sizeof(gQuota.pOrigVfs->xDelete_signature)) == 0) {
          apndDelete(gQuota.pOrigVfs, pFile->zFilename, 0);
        }
      else
        if (memcmp(gQuota.pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_f5tOrigintextDelete_enum], sizeof(gQuota.pOrigVfs->xDelete_signature)) == 0) {
          f5tOrigintextDelete(gQuota.pOrigVfs, pFile->zFilename, 0);
        }
      else
        if (memcmp(gQuota.pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_f5tTokenizerDelete_enum], sizeof(gQuota.pOrigVfs->xDelete_signature)) == 0) {
          f5tTokenizerDelete(gQuota.pOrigVfs, pFile->zFilename, 0);
        }
      else
        if (memcmp(gQuota.pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_kvstorageDelete_enum], sizeof(gQuota.pOrigVfs->xDelete_signature)) == 0) {
          kvstorageDelete(gQuota.pOrigVfs, pFile->zFilename, 0);
        }
      else
        if (memcmp(gQuota.pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_vfstraceDelete_enum], sizeof(gQuota.pOrigVfs->xDelete_signature)) == 0) {
          vfstraceDelete(gQuota.pOrigVfs, pFile->zFilename, 0);
        }
      else
        if (memcmp(gQuota.pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_unixDelete_enum], sizeof(gQuota.pOrigVfs->xDelete_signature)) == 0) {
          unixDelete(gQuota.pOrigVfs, pFile->zFilename, 0);
        }
      quotaRemoveFile(pFile);
    }
    quotaGroupDeref(pGroup);
  }
  quotaLeave();
  return rc;
}

/* Pass xRead requests directory thru to the original VFS without
** further processing.
*/
int quotaRead(
  sqlite3_file *pConn,
  void *pBuf,
  int iAmt,
  sqlite3_int64 iOfst
){
  sqlite3_file *pSubOpen = quotaSubOpen(pConn);
  if (memcmp(pSubOpen->pMethods->xRead_signature, xRead_signatures[xRead_apndRead_enum], sizeof(pSubOpen->pMethods->xRead_signature)) == 0) {
    return apndRead(pSubOpen, pBuf, iAmt, iOfst);
  }
  else
    if (memcmp(pSubOpen->pMethods->xRead_signature, xRead_signatures[xRead_memdbRead_enum], sizeof(pSubOpen->pMethods->xRead_signature)) == 0) {
      return memdbRead(pSubOpen, pBuf, iAmt, iOfst);
    }
  else
    if (memcmp(pSubOpen->pMethods->xRead_signature, xRead_signatures[xRead_memjrnlRead_enum], sizeof(pSubOpen->pMethods->xRead_signature)) == 0) {
      return memjrnlRead(pSubOpen, pBuf, iAmt, iOfst);
    }
  else
    if (memcmp(pSubOpen->pMethods->xRead_signature, xRead_signatures[xRead_recoverVfsRead_enum], sizeof(pSubOpen->pMethods->xRead_signature)) == 0) {
      return recoverVfsRead(pSubOpen, pBuf, iAmt, iOfst);
    }
  else
    if (memcmp(pSubOpen->pMethods->xRead_signature, xRead_signatures[xRead_vfstraceRead_enum], sizeof(pSubOpen->pMethods->xRead_signature)) == 0) {
      return vfstraceRead(pSubOpen, pBuf, iAmt, iOfst);
    }
  else
    if (memcmp(pSubOpen->pMethods->xRead_signature, xRead_signatures[xRead_unixRead_enum], sizeof(pSubOpen->pMethods->xRead_signature)) == 0) {
      return unixRead(pSubOpen, pBuf, iAmt, iOfst);
    }
}

/* Check xWrite requests to see if they expand the file.  If they do,
** the perform a quota check before passing them through to the
** original VFS.
*/
int quotaWrite(
  sqlite3_file *pConn,
  const void *pBuf,
  int iAmt,
  sqlite3_int64 iOfst
){
  quotaConn *p = (quotaConn*)pConn;
  sqlite3_file *pSubOpen = quotaSubOpen(pConn);
  sqlite3_int64 iEnd = iOfst+iAmt;
  quotaGroup *pGroup;
  quotaFile *pFile = p->pFile;
  sqlite3_int64 szNew;

  if( pFile->iSize<iEnd ){
    pGroup = pFile->pGroup;
    quotaEnter();
    szNew = pGroup->iSize - pFile->iSize + iEnd;
    if( szNew>pGroup->iLimit && pGroup->iLimit>0 ){
      if( pGroup->xCallback ){
        pGroup->xCallback(pFile->zFilename, &pGroup->iLimit, szNew,
                          pGroup->pArg);
      }
      if( szNew>pGroup->iLimit && pGroup->iLimit>0 ){
        quotaLeave();
        return SQLITE_FULL;
      }
    }
    pGroup->iSize = szNew;
    pFile->iSize = iEnd;
    quotaLeave();
  }
  if (memcmp(pSubOpen->pMethods->xWrite_signature, xWrite_signatures[xWrite_apndWrite_enum], sizeof(pSubOpen->pMethods->xWrite_signature)) == 0) {
    return apndWrite(pSubOpen, pBuf, iAmt, iOfst);
  }
  else
    if (memcmp(pSubOpen->pMethods->xWrite_signature, xWrite_signatures[xWrite_kvstorageWrite_enum], sizeof(pSubOpen->pMethods->xWrite_signature)) == 0) {
      return kvstorageWrite(pSubOpen, pBuf, iAmt, iOfst);
    }
  else
    if (memcmp(pSubOpen->pMethods->xWrite_signature, xWrite_signatures[xWrite_memdbWrite_enum], sizeof(pSubOpen->pMethods->xWrite_signature)) == 0) {
      return memdbWrite(pSubOpen, pBuf, iAmt, iOfst);
    }
  else
    if (memcmp(pSubOpen->pMethods->xWrite_signature, xWrite_signatures[xWrite_memjrnlWrite_enum], sizeof(pSubOpen->pMethods->xWrite_signature)) == 0) {
      return memjrnlWrite(pSubOpen, pBuf, iAmt, iOfst);
    }
  else
    if (memcmp(pSubOpen->pMethods->xWrite_signature, xWrite_signatures[xWrite_recoverVfsWrite_enum], sizeof(pSubOpen->pMethods->xWrite_signature)) == 0) {
      return recoverVfsWrite(pSubOpen, pBuf, iAmt, iOfst);
    }
  else
    if (memcmp(pSubOpen->pMethods->xWrite_signature, xWrite_signatures[xWrite_vfstraceWrite_enum], sizeof(pSubOpen->pMethods->xWrite_signature)) == 0) {
      return vfstraceWrite(pSubOpen, pBuf, iAmt, iOfst);
    }
  else
    if (memcmp(pSubOpen->pMethods->xWrite_signature, xWrite_signatures[xWrite_unixWrite_enum], sizeof(pSubOpen->pMethods->xWrite_signature)) == 0) {
      return unixWrite(pSubOpen, pBuf, iAmt, iOfst);
    }
}

/* Pass xTruncate requests thru to the original VFS.  If the
** success, update the file size.
*/
int quotaTruncate(sqlite3_file *pConn, sqlite3_int64 size){
  quotaConn *p = (quotaConn*)pConn;
  sqlite3_file *pSubOpen = quotaSubOpen(pConn);
  int rc = pSubOpen->pMethods->xTruncate(pSubOpen, size);
  quotaFile *pFile = p->pFile;
  quotaGroup *pGroup;
  if( rc==SQLITE_OK ){
    quotaEnter();
    pGroup = pFile->pGroup;
    pGroup->iSize -= pFile->iSize;
    pFile->iSize = size;
    pGroup->iSize += size;
    quotaLeave();
  }
  return rc;
}

/* Pass xSync requests through to the original VFS without change
*/
int quotaSync(sqlite3_file *pConn, int flags){
  sqlite3_file *pSubOpen = quotaSubOpen(pConn);
  if (memcmp(pSubOpen->pMethods->xSync_signature, xSync_signatures[xSync_0_enum], sizeof(pSubOpen->pMethods->xSync_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pSubOpen->pMethods->xSync_signature, xSync_signatures[xSync_apndSync_enum], sizeof(pSubOpen->pMethods->xSync_signature)) == 0) {
      return apndSync(pSubOpen, flags);
    }
  else
    if (memcmp(pSubOpen->pMethods->xSync_signature, xSync_signatures[xSync_dbpageSync_enum], sizeof(pSubOpen->pMethods->xSync_signature)) == 0) {
      return dbpageSync(pSubOpen, flags);
    }
  else
    if (memcmp(pSubOpen->pMethods->xSync_signature, xSync_signatures[xSync_echoSync_enum], sizeof(pSubOpen->pMethods->xSync_signature)) == 0) {
      return echoSync(pSubOpen, flags);
    }
  else
    if (memcmp(pSubOpen->pMethods->xSync_signature, xSync_signatures[xSync_fts3SyncMethod_enum], sizeof(pSubOpen->pMethods->xSync_signature)) == 0) {
      return fts3SyncMethod(pSubOpen, flags);
    }
  else
    if (memcmp(pSubOpen->pMethods->xSync_signature, xSync_signatures[xSync_memdbSync_enum], sizeof(pSubOpen->pMethods->xSync_signature)) == 0) {
      return memdbSync(pSubOpen, flags);
    }
  else
    if (memcmp(pSubOpen->pMethods->xSync_signature, xSync_signatures[xSync_memjrnlSync_enum], sizeof(pSubOpen->pMethods->xSync_signature)) == 0) {
      return memjrnlSync(pSubOpen, flags);
    }
  else
    if (memcmp(pSubOpen->pMethods->xSync_signature, xSync_signatures[xSync_recoverVfsSync_enum], sizeof(pSubOpen->pMethods->xSync_signature)) == 0) {
      return recoverVfsSync(pSubOpen, flags);
    }
  else
    if (memcmp(pSubOpen->pMethods->xSync_signature, xSync_signatures[xSync_rtreeEndTransaction_enum], sizeof(pSubOpen->pMethods->xSync_signature)) == 0) {
      return rtreeEndTransaction(pSubOpen, flags);
    }
  else
    if (memcmp(pSubOpen->pMethods->xSync_signature, xSync_signatures[xSync_vfstraceSync_enum], sizeof(pSubOpen->pMethods->xSync_signature)) == 0) {
      return vfstraceSync(pSubOpen, flags);
    }
  else
    if (memcmp(pSubOpen->pMethods->xSync_signature, xSync_signatures[xSync_vtablogSync_enum], sizeof(pSubOpen->pMethods->xSync_signature)) == 0) {
      return vtablogSync(pSubOpen, flags);
    }
  else
    if (memcmp(pSubOpen->pMethods->xSync_signature, xSync_signatures[xSync_unixSync_enum], sizeof(pSubOpen->pMethods->xSync_signature)) == 0) {
      return unixSync(pSubOpen, flags);
    }
}

/* Pass xFileSize requests through to the original VFS but then
** update the quotaGroup with the new size before returning.
*/
int quotaFileSize(sqlite3_file *pConn, sqlite3_int64 *pSize){
  quotaConn *p = (quotaConn*)pConn;
  sqlite3_file *pSubOpen = quotaSubOpen(pConn);
  quotaFile *pFile = p->pFile;
  quotaGroup *pGroup;
  sqlite3_int64 sz;
  int rc;

  if (memcmp(pSubOpen->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_apndFileSize_enum], sizeof(pSubOpen->pMethods->xFileSize_signature)) == 0) {
    rc = apndFileSize(pSubOpen, &sz);
  }
  else
    if (memcmp(pSubOpen->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_memdbFileSize_enum], sizeof(pSubOpen->pMethods->xFileSize_signature)) == 0) {
      rc = memdbFileSize(pSubOpen, &sz);
    }
  else
    if (memcmp(pSubOpen->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_memjrnlFileSize_enum], sizeof(pSubOpen->pMethods->xFileSize_signature)) == 0) {
      rc = memjrnlFileSize(pSubOpen, &sz);
    }
  else
    if (memcmp(pSubOpen->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_recoverVfsFileSize_enum], sizeof(pSubOpen->pMethods->xFileSize_signature)) == 0) {
      rc = recoverVfsFileSize(pSubOpen, &sz);
    }
  else
    if (memcmp(pSubOpen->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_vfstraceFileSize_enum], sizeof(pSubOpen->pMethods->xFileSize_signature)) == 0) {
      rc = vfstraceFileSize(pSubOpen, &sz);
    }
  else
    if (memcmp(pSubOpen->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_unixFileSize_enum], sizeof(pSubOpen->pMethods->xFileSize_signature)) == 0) {
      rc = unixFileSize(pSubOpen, &sz);
    }
  if( rc==SQLITE_OK ){
    quotaEnter();
    pGroup = pFile->pGroup;
    pGroup->iSize -= pFile->iSize;
    pFile->iSize = sz;
    pGroup->iSize += sz;
    quotaLeave();
    *pSize = sz;
  }
  return rc;
}

/* Pass xLock requests through to the original VFS unchanged.
*/
int quotaLock(sqlite3_file *pConn, int lock){
  sqlite3_file *pSubOpen = quotaSubOpen(pConn);
  if (memcmp(pSubOpen->pMethods->xLock_signature, xLock_signatures[xLock_0_enum], sizeof(pSubOpen->pMethods->xLock_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pSubOpen->pMethods->xLock_signature, xLock_signatures[xLock_apndLock_enum], sizeof(pSubOpen->pMethods->xLock_signature)) == 0) {
      return apndLock(pSubOpen, lock);
    }
  else
    if (memcmp(pSubOpen->pMethods->xLock_signature, xLock_signatures[xLock_memdbLock_enum], sizeof(pSubOpen->pMethods->xLock_signature)) == 0) {
      return memdbLock(pSubOpen, lock);
    }
  else
    if (memcmp(pSubOpen->pMethods->xLock_signature, xLock_signatures[xLock_recoverVfsLock_enum], sizeof(pSubOpen->pMethods->xLock_signature)) == 0) {
      return recoverVfsLock(pSubOpen, lock);
    }
  else
    if (memcmp(pSubOpen->pMethods->xLock_signature, xLock_signatures[xLock_vfstraceLock_enum], sizeof(pSubOpen->pMethods->xLock_signature)) == 0) {
      return vfstraceLock(pSubOpen, lock);
    }
  else
    if (memcmp(pSubOpen->pMethods->xLock_signature, xLock_signatures[xLock_unixLock_enum], sizeof(pSubOpen->pMethods->xLock_signature)) == 0) {
      return unixLock(pSubOpen, lock);
    }
  else
    if (memcmp(pSubOpen->pMethods->xLock_signature, xLock_signatures[xLock_nolockLock_enum], sizeof(pSubOpen->pMethods->xLock_signature)) == 0) {
      return nolockLock(pSubOpen, lock);
    }
  else
    if (memcmp(pSubOpen->pMethods->xLock_signature, xLock_signatures[xLock_dotlockLock_enum], sizeof(pSubOpen->pMethods->xLock_signature)) == 0) {
      return dotlockLock(pSubOpen, lock);
    }
}

/* Pass xUnlock requests through to the original VFS unchanged.
*/
int quotaUnlock(sqlite3_file *pConn, int lock){
  sqlite3_file *pSubOpen = quotaSubOpen(pConn);
  if (memcmp(pSubOpen->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_0_enum], sizeof(pSubOpen->pMethods->xUnlock_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pSubOpen->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_apndUnlock_enum], sizeof(pSubOpen->pMethods->xUnlock_signature)) == 0) {
      return apndUnlock(pSubOpen, lock);
    }
  else
    if (memcmp(pSubOpen->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_memdbUnlock_enum], sizeof(pSubOpen->pMethods->xUnlock_signature)) == 0) {
      return memdbUnlock(pSubOpen, lock);
    }
  else
    if (memcmp(pSubOpen->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_recoverVfsUnlock_enum], sizeof(pSubOpen->pMethods->xUnlock_signature)) == 0) {
      return recoverVfsUnlock(pSubOpen, lock);
    }
  else
    if (memcmp(pSubOpen->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_vfstraceUnlock_enum], sizeof(pSubOpen->pMethods->xUnlock_signature)) == 0) {
      return vfstraceUnlock(pSubOpen, lock);
    }
  else
    if (memcmp(pSubOpen->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_unixUnlock_enum], sizeof(pSubOpen->pMethods->xUnlock_signature)) == 0) {
      return unixUnlock(pSubOpen, lock);
    }
  else
    if (memcmp(pSubOpen->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_nolockUnlock_enum], sizeof(pSubOpen->pMethods->xUnlock_signature)) == 0) {
      return nolockUnlock(pSubOpen, lock);
    }
  else
    if (memcmp(pSubOpen->pMethods->xUnlock_signature, xUnlock_signatures[xUnlock_dotlockUnlock_enum], sizeof(pSubOpen->pMethods->xUnlock_signature)) == 0) {
      return dotlockUnlock(pSubOpen, lock);
    }
}

/* Pass xCheckReservedLock requests through to the original VFS unchanged.
*/
int quotaCheckReservedLock(sqlite3_file *pConn, int *pResOut){
  sqlite3_file *pSubOpen = quotaSubOpen(pConn);
  if (memcmp(pSubOpen->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_0_enum], sizeof(pSubOpen->pMethods->xCheckReservedLock_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pSubOpen->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_apndCheckReservedLock_enum], sizeof(pSubOpen->pMethods->xCheckReservedLock_signature)) == 0) {
      return apndCheckReservedLock(pSubOpen, pResOut);
    }
  else
    if (memcmp(pSubOpen->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_recoverVfsCheckReservedLock_enum], sizeof(pSubOpen->pMethods->xCheckReservedLock_signature)) == 0) {
      return recoverVfsCheckReservedLock(pSubOpen, pResOut);
    }
  else
    if (memcmp(pSubOpen->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_vfstraceCheckReservedLock_enum], sizeof(pSubOpen->pMethods->xCheckReservedLock_signature)) == 0) {
      return vfstraceCheckReservedLock(pSubOpen, pResOut);
    }
  else
    if (memcmp(pSubOpen->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_unixCheckReservedLock_enum], sizeof(pSubOpen->pMethods->xCheckReservedLock_signature)) == 0) {
      return unixCheckReservedLock(pSubOpen, pResOut);
    }
  else
    if (memcmp(pSubOpen->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_nolockCheckReservedLock_enum], sizeof(pSubOpen->pMethods->xCheckReservedLock_signature)) == 0) {
      return nolockCheckReservedLock(pSubOpen, pResOut);
    }
  else
    if (memcmp(pSubOpen->pMethods->xCheckReservedLock_signature, xCheckReservedLock_signatures[xCheckReservedLock_dotlockCheckReservedLock_enum], sizeof(pSubOpen->pMethods->xCheckReservedLock_signature)) == 0) {
      return dotlockCheckReservedLock(pSubOpen, pResOut);
    }
}

/* Pass xFileControl requests through to the original VFS unchanged.
*/
int quotaFileControl(sqlite3_file *pConn, int op, void *pArg){
  sqlite3_file *pSubOpen = quotaSubOpen(pConn);
  int rc = pSubOpen->pMethods->xFileControl(pSubOpen, op, pArg);
#if defined(SQLITE_FCNTL_VFSNAME)
  if( op==SQLITE_FCNTL_VFSNAME && rc==SQLITE_OK ){
    *(char**)pArg = sqlite3_mprintf("quota/%z", *(char**)pArg);
  }
#endif
  return rc;
}

/* Pass xSectorSize requests through to the original VFS unchanged.
*/
int quotaSectorSize(sqlite3_file *pConn){
  sqlite3_file *pSubOpen = quotaSubOpen(pConn);
  if (memcmp(pSubOpen->pMethods->xSectorSize_signature, xSectorSize_signatures[xSectorSize_0_enum], sizeof(pSubOpen->pMethods->xSectorSize_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pSubOpen->pMethods->xSectorSize_signature, xSectorSize_signatures[xSectorSize_apndSectorSize_enum], sizeof(pSubOpen->pMethods->xSectorSize_signature)) == 0) {
      return apndSectorSize(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xSectorSize_signature, xSectorSize_signatures[xSectorSize_recoverVfsSectorSize_enum], sizeof(pSubOpen->pMethods->xSectorSize_signature)) == 0) {
      return recoverVfsSectorSize(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xSectorSize_signature, xSectorSize_signatures[xSectorSize_vfstraceSectorSize_enum], sizeof(pSubOpen->pMethods->xSectorSize_signature)) == 0) {
      return vfstraceSectorSize(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xSectorSize_signature, xSectorSize_signatures[xSectorSize_unixSectorSize_enum], sizeof(pSubOpen->pMethods->xSectorSize_signature)) == 0) {
      return unixSectorSize(pSubOpen);
    }
}

/* Pass xDeviceCharacteristics requests through to the original VFS unchanged.
*/
int quotaDeviceCharacteristics(sqlite3_file *pConn){
  sqlite3_file *pSubOpen = quotaSubOpen(pConn);
  if (memcmp(pSubOpen->pMethods->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_0_enum], sizeof(pSubOpen->pMethods->xDeviceCharacteristics_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pSubOpen->pMethods->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_apndDeviceCharacteristics_enum], sizeof(pSubOpen->pMethods->xDeviceCharacteristics_signature)) == 0) {
      return apndDeviceCharacteristics(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_memdbDeviceCharacteristics_enum], sizeof(pSubOpen->pMethods->xDeviceCharacteristics_signature)) == 0) {
      return memdbDeviceCharacteristics(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_recoverVfsDeviceCharacteristics_enum], sizeof(pSubOpen->pMethods->xDeviceCharacteristics_signature)) == 0) {
      return recoverVfsDeviceCharacteristics(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_vfstraceDeviceCharacteristics_enum], sizeof(pSubOpen->pMethods->xDeviceCharacteristics_signature)) == 0) {
      return vfstraceDeviceCharacteristics(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xDeviceCharacteristics_signature, xDeviceCharacteristics_signatures[xDeviceCharacteristics_unixDeviceCharacteristics_enum], sizeof(pSubOpen->pMethods->xDeviceCharacteristics_signature)) == 0) {
      return unixDeviceCharacteristics(pSubOpen);
    }
}

/* Pass xShmMap requests through to the original VFS unchanged.
*/
int quotaShmMap(
  sqlite3_file *pConn,            /* Handle open on database file */
  int iRegion,                    /* Region to retrieve */
  int szRegion,                   /* Size of regions */
  int bExtend,                    /* True to extend file if necessary */
  void volatile **pp              /* OUT: Mapped memory */
){
  sqlite3_file *pSubOpen = quotaSubOpen(pConn);
  if (memcmp(pSubOpen->pMethods->xShmMap_signature, xShmMap_signatures[xShmMap_0_enum], sizeof(pSubOpen->pMethods->xShmMap_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pSubOpen->pMethods->xShmMap_signature, xShmMap_signatures[xShmMap_apndShmMap_enum], sizeof(pSubOpen->pMethods->xShmMap_signature)) == 0) {
      return apndShmMap(pSubOpen, iRegion, szRegion, bExtend, pp);
    }
  else
    if (memcmp(pSubOpen->pMethods->xShmMap_signature, xShmMap_signatures[xShmMap_recoverVfsShmMap_enum], sizeof(pSubOpen->pMethods->xShmMap_signature)) == 0) {
      return recoverVfsShmMap(pSubOpen, iRegion, szRegion, bExtend, pp);
    }
  else
    if (memcmp(pSubOpen->pMethods->xShmMap_signature, xShmMap_signatures[xShmMap_unixShmMap_enum], sizeof(pSubOpen->pMethods->xShmMap_signature)) == 0) {
      return unixShmMap(pSubOpen, iRegion, szRegion, bExtend, pp);
    }
}

/* Pass xShmLock requests through to the original VFS unchanged.
*/
int quotaShmLock(
  sqlite3_file *pConn,       /* Database file holding the shared memory */
  int ofst,                  /* First lock to acquire or release */
  int n,                     /* Number of locks to acquire or release */
  int flags                  /* What to do with the lock */
){
  sqlite3_file *pSubOpen = quotaSubOpen(pConn);
  if (memcmp(pSubOpen->pMethods->xShmLock_signature, xShmLock_signatures[xShmLock_0_enum], sizeof(pSubOpen->pMethods->xShmLock_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pSubOpen->pMethods->xShmLock_signature, xShmLock_signatures[xShmLock_apndShmLock_enum], sizeof(pSubOpen->pMethods->xShmLock_signature)) == 0) {
      return apndShmLock(pSubOpen, ofst, n, flags);
    }
  else
    if (memcmp(pSubOpen->pMethods->xShmLock_signature, xShmLock_signatures[xShmLock_recoverVfsShmLock_enum], sizeof(pSubOpen->pMethods->xShmLock_signature)) == 0) {
      return recoverVfsShmLock(pSubOpen, ofst, n, flags);
    }
  else
    if (memcmp(pSubOpen->pMethods->xShmLock_signature, xShmLock_signatures[xShmLock_unixShmLock_enum], sizeof(pSubOpen->pMethods->xShmLock_signature)) == 0) {
      return unixShmLock(pSubOpen, ofst, n, flags);
    }
}

/* Pass xShmBarrier requests through to the original VFS unchanged.
*/
void quotaShmBarrier(sqlite3_file *pConn){
  sqlite3_file *pSubOpen = quotaSubOpen(pConn);
  if (memcmp(pSubOpen->pMethods->xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_0_enum], sizeof(pSubOpen->pMethods->xShmBarrier_signature)) == 0) {
    0;
  }
  else
    if (memcmp(pSubOpen->pMethods->xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_apndShmBarrier_enum], sizeof(pSubOpen->pMethods->xShmBarrier_signature)) == 0) {
      apndShmBarrier(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_recoverVfsShmBarrier_enum], sizeof(pSubOpen->pMethods->xShmBarrier_signature)) == 0) {
      recoverVfsShmBarrier(pSubOpen);
    }
  else
    if (memcmp(pSubOpen->pMethods->xShmBarrier_signature, xShmBarrier_signatures[xShmBarrier_unixShmBarrier_enum], sizeof(pSubOpen->pMethods->xShmBarrier_signature)) == 0) {
      unixShmBarrier(pSubOpen);
    }
}

/* Pass xShmUnmap requests through to the original VFS unchanged.
*/
int quotaShmUnmap(sqlite3_file *pConn, int deleteFlag){
  sqlite3_file *pSubOpen = quotaSubOpen(pConn);
  if (memcmp(pSubOpen->pMethods->xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_0_enum], sizeof(pSubOpen->pMethods->xShmUnmap_signature)) == 0) {
    return 0;
  }
  else
    if (memcmp(pSubOpen->pMethods->xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_apndShmUnmap_enum], sizeof(pSubOpen->pMethods->xShmUnmap_signature)) == 0) {
      return apndShmUnmap(pSubOpen, deleteFlag);
    }
  else
    if (memcmp(pSubOpen->pMethods->xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_recoverVfsShmUnmap_enum], sizeof(pSubOpen->pMethods->xShmUnmap_signature)) == 0) {
      return recoverVfsShmUnmap(pSubOpen, deleteFlag);
    }
  else
    if (memcmp(pSubOpen->pMethods->xShmUnmap_signature, xShmUnmap_signatures[xShmUnmap_unixShmUnmap_enum], sizeof(pSubOpen->pMethods->xShmUnmap_signature)) == 0) {
      return unixShmUnmap(pSubOpen, deleteFlag);
    }
}

/************************** Public Interfaces *****************************/
/*
** Initialize the quota VFS shim.  Use the VFS named zOrigVfsName
** as the VFS that does the actual work.  Use the default if
** zOrigVfsName==NULL.
**
** The quota VFS shim is named "quota".  It will become the default
** VFS if makeDefault is non-zero.
**
** THIS ROUTINE IS NOT THREADSAFE.  Call this routine exactly once
** during start-up.
*/
int sqlite3_quota_initialize(const char *zOrigVfsName, int makeDefault){
  sqlite3_vfs *pOrigVfs;
  if( gQuota.isInitialized ) return SQLITE_MISUSE;
  pOrigVfs = sqlite3_vfs_find(zOrigVfsName);
  if( pOrigVfs==0 ) return SQLITE_ERROR;
  assert( pOrigVfs!=&gQuota.sThisVfs );
  gQuota.pMutex = sqlite3_mutex_alloc(SQLITE_MUTEX_FAST);
  if( !gQuota.pMutex ){
    return SQLITE_NOMEM;
  }
  gQuota.isInitialized = 1;
  gQuota.pOrigVfs = pOrigVfs;
  gQuota.sThisVfs = *pOrigVfs;
  gQuota.sThisVfs.xOpen = quotaOpen;
  gQuota.sThisVfs.xDelete = quotaDelete;
  gQuota.sThisVfs.szOsFile += sizeof(quotaConn);
  gQuota.sThisVfs.zName = "quota";
  gQuota.sIoMethodsV1.iVersion = 1;
  gQuota.sIoMethodsV1.xClose = quotaClose;
  gQuota.sIoMethodsV1.xRead = quotaRead;
  gQuota.sIoMethodsV1.xWrite = quotaWrite;
  gQuota.sIoMethodsV1.xTruncate = quotaTruncate;
  gQuota.sIoMethodsV1.xSync = quotaSync;
  gQuota.sIoMethodsV1.xFileSize = quotaFileSize;
  gQuota.sIoMethodsV1.xLock = quotaLock;
  gQuota.sIoMethodsV1.xUnlock = quotaUnlock;
  gQuota.sIoMethodsV1.xCheckReservedLock = quotaCheckReservedLock;
  gQuota.sIoMethodsV1.xFileControl = quotaFileControl;
  gQuota.sIoMethodsV1.xSectorSize = quotaSectorSize;
  gQuota.sIoMethodsV1.xDeviceCharacteristics = quotaDeviceCharacteristics;
  gQuota.sIoMethodsV2 = gQuota.sIoMethodsV1;
  gQuota.sIoMethodsV2.iVersion = 2;
  gQuota.sIoMethodsV2.xShmMap = quotaShmMap;
  gQuota.sIoMethodsV2.xShmLock = quotaShmLock;
  gQuota.sIoMethodsV2.xShmBarrier = quotaShmBarrier;
  gQuota.sIoMethodsV2.xShmUnmap = quotaShmUnmap;
  sqlite3_vfs_register(&gQuota.sThisVfs, makeDefault);
  return SQLITE_OK;
}

/*
** Shutdown the quota system.
**
** All SQLite database connections must be closed before calling this
** routine.
**
** THIS ROUTINE IS NOT THREADSAFE.  Call this routine exactly once while
** shutting down in order to free all remaining quota groups.
*/
int sqlite3_quota_shutdown(void){
  quotaGroup *pGroup;
  if( gQuota.isInitialized==0 ) return SQLITE_MISUSE;
  for(pGroup=gQuota.pGroup; pGroup; pGroup=pGroup->pNext){
    if( quotaGroupOpenFileCount(pGroup)>0 ) return SQLITE_MISUSE;
  }
  while( gQuota.pGroup ){
    pGroup = gQuota.pGroup;
    gQuota.pGroup = pGroup->pNext;
    pGroup->iLimit = 0;
    assert( quotaGroupOpenFileCount(pGroup)==0 );
    quotaGroupDeref(pGroup);
  }
  gQuota.isInitialized = 0;
  sqlite3_mutex_free(gQuota.pMutex);
  sqlite3_vfs_unregister(&gQuota.sThisVfs);
  memset(&gQuota, 0, sizeof(gQuota));
  return SQLITE_OK;
}

/*
** Create or destroy a quota group.
**
** The quota group is defined by the zPattern.  When calling this routine
** with a zPattern for a quota group that already exists, this routine
** merely updates the iLimit, xCallback, and pArg values for that quota
** group.  If zPattern is new, then a new quota group is created.
**
** If the iLimit for a quota group is set to zero, then the quota group
** is disabled and will be deleted when the last database connection using
** the quota group is closed.
**
** Calling this routine on a zPattern that does not exist and with a
** zero iLimit is a no-op.
**
** A quota group must exist with a non-zero iLimit prior to opening
** database connections if those connections are to participate in the
** quota group.  Creating a quota group does not affect database connections
** that are already open.
*/
int sqlite3_quota_set(
  const char *zPattern,           /* The filename pattern */
  sqlite3_int64 iLimit,           /* New quota to set for this quota group */
  void (*xCallback)(              /* Callback invoked when going over quota */
     const char *zFilename,         /* Name of file whose size increases */
     sqlite3_int64 *piLimit,        /* IN/OUT: The current limit */
     sqlite3_int64 iSize,           /* Total size of all files in the group */
     void *pArg                     /* Client data */
  ),
  void *pArg,                     /* client data passed thru to callback */
  void (*xDestroy)(void*)         /* Optional destructor for pArg */
){
  quotaGroup *pGroup;
  quotaEnter();
  pGroup = gQuota.pGroup;
  while( pGroup && strcmp(pGroup->zPattern, zPattern)!=0 ){
    pGroup = pGroup->pNext;
  }
  if( pGroup==0 ){
    int nPattern = (int)(strlen(zPattern) & 0x3fffffff);
    if( iLimit<=0 ){
      quotaLeave();
      return SQLITE_OK;
    }
    pGroup = (quotaGroup *)sqlite3_malloc( sizeof(*pGroup) + nPattern + 1 );
    if( pGroup==0 ){
      quotaLeave();
      return SQLITE_NOMEM;
    }
    memset(pGroup, 0, sizeof(*pGroup));
    pGroup->zPattern = (char*)&pGroup[1];
    memcpy((char *)pGroup->zPattern, zPattern, nPattern+1);
    if( gQuota.pGroup ) gQuota.pGroup->ppPrev = &pGroup->pNext;
    pGroup->pNext = gQuota.pGroup;
    pGroup->ppPrev = &gQuota.pGroup;
    gQuota.pGroup = pGroup;
  }
  pGroup->iLimit = iLimit;
  pGroup->xCallback = xCallback;
  if( pGroup->xDestroy && pGroup->pArg!=pArg ){
    if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_0_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
      0;
    }
    else
      if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_dbpageDisconnect_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
        dbpageDisconnect(pGroup->pArg);
      }
    else
      if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_expertDisconnect_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
        expertDisconnect(pGroup->pArg);
      }
    else
      if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_fsdirDisconnect_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
        fsdirDisconnect(pGroup->pArg);
      }
    else
      if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_fts3DestroyMethod_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
        fts3DestroyMethod(pGroup->pArg);
      }
    else
      if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_fts3auxDisconnectMethod_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
        fts3auxDisconnectMethod(pGroup->pArg);
      }
    else
      if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_fts3tokDisconnectMethod_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
        fts3tokDisconnectMethod(pGroup->pArg);
      }
    else
      if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_pcache1Destroy_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
        pcache1Destroy(pGroup->pArg);
      }
    else
      if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_pcachetraceDestroy_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
        pcachetraceDestroy(pGroup->pArg);
      }
    else
      if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_porterDestroy_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
        porterDestroy(pGroup->pArg);
      }
    else
      if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_rtreeDestroy_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
        rtreeDestroy(pGroup->pArg);
      }
    else
      if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_simpleDestroy_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
        simpleDestroy(pGroup->pArg);
      }
    else
      if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_statDisconnect_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
        statDisconnect(pGroup->pArg);
      }
    else
      if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_unicodeDestroy_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
        unicodeDestroy(pGroup->pArg);
      }
    else
      if (memcmp(pGroup->xDestroy_signature, xDestroy_signatures[xDestroy_zipfileDisconnect_enum], sizeof(pGroup->xDestroy_signature)) == 0) {
        zipfileDisconnect(pGroup->pArg);
      }
  }
  pGroup->pArg = pArg;
  pGroup->xDestroy = xDestroy;
  quotaGroupDeref(pGroup);
  quotaLeave();
  return SQLITE_OK;
}

/*
** Bring the named file under quota management.  Or if it is already under
** management, update its size.
*/
int sqlite3_quota_file(const char *zFilename){
  char *zFull = 0;
  sqlite3_file *fd;
  int rc;
  int outFlags = 0;
  sqlite3_int64 iSize;
  int nAlloc = gQuota.sThisVfs.szOsFile + gQuota.sThisVfs.mxPathname+2;

  /* Allocate space for a file-handle and the full path for file zFilename */
  fd = (sqlite3_file *)sqlite3_malloc(nAlloc);
  if( fd==0 ){
    rc = SQLITE_NOMEM;
  }else{
    zFull = &((char *)fd)[gQuota.sThisVfs.szOsFile];
    if (memcmp(gQuota.pOrigVfs->xFullPathname_signature, xFullPathname_signatures[xFullPathname_apndFullPathname_enum], sizeof(gQuota.pOrigVfs->xFullPathname_signature)) == 0) {
      rc = apndFullPathname(gQuota.pOrigVfs, zFilename,
                            gQuota.sThisVfs.mxPathname + 1, zFull);
    }
    else
      if (memcmp(gQuota.pOrigVfs->xFullPathname_signature, xFullPathname_signatures[xFullPathname_memdbFullPathname_enum], sizeof(gQuota.pOrigVfs->xFullPathname_signature)) == 0) {
        rc = memdbFullPathname(gQuota.pOrigVfs, zFilename,
                               gQuota.sThisVfs.mxPathname + 1, zFull);
      }
    else
      if (memcmp(gQuota.pOrigVfs->xFullPathname_signature, xFullPathname_signatures[xFullPathname_vfstraceFullPathname_enum], sizeof(gQuota.pOrigVfs->xFullPathname_signature)) == 0) {
        rc = vfstraceFullPathname(gQuota.pOrigVfs, zFilename,
                                  gQuota.sThisVfs.mxPathname + 1, zFull);
      }
    else
      if (memcmp(gQuota.pOrigVfs->xFullPathname_signature, xFullPathname_signatures[xFullPathname_unixFullPathname_enum], sizeof(gQuota.pOrigVfs->xFullPathname_signature)) == 0) {
        rc = unixFullPathname(gQuota.pOrigVfs, zFilename,
                              gQuota.sThisVfs.mxPathname + 1, zFull);
      }
  }

  if( rc==SQLITE_OK ){
    zFull[strlen(zFull)+1] = '\0';
    rc = quotaOpen(&gQuota.sThisVfs, zFull, fd,
                   SQLITE_OPEN_READONLY | SQLITE_OPEN_MAIN_DB, &outFlags);
    if( rc==SQLITE_OK ){
      if (memcmp(fd->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_apndFileSize_enum], sizeof(fd->pMethods->xFileSize_signature)) == 0) {
        apndFileSize(fd, &iSize);
      }
      else
        if (memcmp(fd->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_memdbFileSize_enum], sizeof(fd->pMethods->xFileSize_signature)) == 0) {
          memdbFileSize(fd, &iSize);
        }
      else
        if (memcmp(fd->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_memjrnlFileSize_enum], sizeof(fd->pMethods->xFileSize_signature)) == 0) {
          memjrnlFileSize(fd, &iSize);
        }
      else
        if (memcmp(fd->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_recoverVfsFileSize_enum], sizeof(fd->pMethods->xFileSize_signature)) == 0) {
          recoverVfsFileSize(fd, &iSize);
        }
      else
        if (memcmp(fd->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_vfstraceFileSize_enum], sizeof(fd->pMethods->xFileSize_signature)) == 0) {
          vfstraceFileSize(fd, &iSize);
        }
      else
        if (memcmp(fd->pMethods->xFileSize_signature, xFileSize_signatures[xFileSize_unixFileSize_enum], sizeof(fd->pMethods->xFileSize_signature)) == 0) {
          unixFileSize(fd, &iSize);
        }
      if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_apndClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
        apndClose(fd);
      }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_bytecodevtabClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          bytecodevtabClose(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_completionClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          completionClose(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_dbdataClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          dbdataClose(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_dbpageClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          dbpageClose(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_expertClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          expertClose(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_fsdirClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          fsdirClose(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_fts3CloseMethod_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          fts3CloseMethod(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_fts3auxCloseMethod_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          fts3auxCloseMethod(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_fts3tokCloseMethod_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          fts3tokCloseMethod(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_jsonEachClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          jsonEachClose(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_memdbClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          memdbClose(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_memjrnlClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          memjrnlClose(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_porterClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          porterClose(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_pragmaVtabClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          pragmaVtabClose(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_recoverVfsClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          recoverVfsClose(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_rtreeClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          rtreeClose(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_seriesClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          seriesClose(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_simpleClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          simpleClose(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_statClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          statClose(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_stmtClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          stmtClose(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_unicodeClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          unicodeClose(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_vfstraceClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          vfstraceClose(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_zipfileClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          zipfileClose(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_unixClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          unixClose(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_nolockClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          nolockClose(fd);
        }
      else
        if (memcmp(fd->pMethods->xClose_signature, xClose_signatures[xClose_dotlockClose_enum], sizeof(fd->pMethods->xClose_signature)) == 0) {
          dotlockClose(fd);
        }
    }else if( rc==SQLITE_CANTOPEN ){
      quotaGroup *pGroup;
      quotaFile *pFile;
      quotaEnter();
      pGroup = quotaGroupFind(zFull);
      if( pGroup ){
        pFile = quotaFindFile(pGroup, zFull, 0);
        if( pFile ) quotaRemoveFile(pFile);
      }
      quotaLeave();
    }
  }

  sqlite3_free(fd);
  return rc;
}

/*
** Open a potentially quotaed file for I/O.
*/
quota_FILE *sqlite3_quota_fopen(const char *zFilename, const char *zMode){
  quota_FILE *p = 0;
  char *zFull = 0;
  char *zFullTranslated = 0;
  int rc;
  quotaGroup *pGroup;
  quotaFile *pFile;

  zFull = (char*)sqlite3_malloc(gQuota.sThisVfs.mxPathname + 1);
  if( zFull==0 ) return 0;
  if (memcmp(gQuota.pOrigVfs->xFullPathname_signature, xFullPathname_signatures[xFullPathname_apndFullPathname_enum], sizeof(gQuota.pOrigVfs->xFullPathname_signature)) == 0) {
    rc = apndFullPathname(gQuota.pOrigVfs, zFilename,
                          gQuota.sThisVfs.mxPathname + 1, zFull);
  }
  else
    if (memcmp(gQuota.pOrigVfs->xFullPathname_signature, xFullPathname_signatures[xFullPathname_memdbFullPathname_enum], sizeof(gQuota.pOrigVfs->xFullPathname_signature)) == 0) {
      rc = memdbFullPathname(gQuota.pOrigVfs, zFilename,
                             gQuota.sThisVfs.mxPathname + 1, zFull);
    }
  else
    if (memcmp(gQuota.pOrigVfs->xFullPathname_signature, xFullPathname_signatures[xFullPathname_vfstraceFullPathname_enum], sizeof(gQuota.pOrigVfs->xFullPathname_signature)) == 0) {
      rc = vfstraceFullPathname(gQuota.pOrigVfs, zFilename,
                                gQuota.sThisVfs.mxPathname + 1, zFull);
    }
  else
    if (memcmp(gQuota.pOrigVfs->xFullPathname_signature, xFullPathname_signatures[xFullPathname_unixFullPathname_enum], sizeof(gQuota.pOrigVfs->xFullPathname_signature)) == 0) {
      rc = unixFullPathname(gQuota.pOrigVfs, zFilename,
                            gQuota.sThisVfs.mxPathname + 1, zFull);
    }
  if( rc ) goto quota_fopen_error;
  p = (quota_FILE*)sqlite3_malloc(sizeof(*p));
  if( p==0 ) goto quota_fopen_error;
  memset(p, 0, sizeof(*p));
  zFullTranslated = quota_utf8_to_mbcs(zFull);
  if( zFullTranslated==0 ) goto quota_fopen_error;
  p->f = fopen(zFullTranslated, zMode);
  if( p->f==0 ) goto quota_fopen_error;
  quotaEnter();
  pGroup = quotaGroupFind(zFull);
  if( pGroup ){
    pFile = quotaFindFile(pGroup, zFull, 1);
    if( pFile==0 ){
      quotaLeave();
      goto quota_fopen_error;
    }
    pFile->nRef++;
    p->pFile = pFile;
  }
  quotaLeave();
  sqlite3_free(zFull);
#ifdef _WIN32
  p->zMbcsName = zFullTranslated;
#endif
  return p;

quota_fopen_error:
  quota_mbcs_free(zFullTranslated);
  sqlite3_free(zFull);
  if( p && p->f ) fclose(p->f);
  sqlite3_free(p);
  return 0;
}

/*
** Read content from a quota_FILE
*/
size_t sqlite3_quota_fread(
  void *pBuf,            /* Store the content here */
  size_t size,           /* Size of each element */
  size_t nmemb,          /* Number of elements to read */
  quota_FILE *p          /* Read from this quota_FILE object */
){
  return fread(pBuf, size, nmemb, p->f);
}

/*
** Write content into a quota_FILE.  Invoke the quota callback and block
** the write if we exceed quota.
*/
size_t sqlite3_quota_fwrite(
  const void *pBuf,      /* Take content to write from here */
  size_t size,           /* Size of each element */
  size_t nmemb,          /* Number of elements */
  quota_FILE *p          /* Write to this quota_FILE object */
){
  sqlite3_int64 iOfst;
  sqlite3_int64 iEnd;
  sqlite3_int64 szNew;
  quotaFile *pFile;
  size_t rc;

  iOfst = ftell(p->f);
  iEnd = iOfst + size*nmemb;
  pFile = p->pFile;
  if( pFile && pFile->iSize<iEnd ){
    quotaGroup *pGroup = pFile->pGroup;
    quotaEnter();
    szNew = pGroup->iSize - pFile->iSize + iEnd;
    if( szNew>pGroup->iLimit && pGroup->iLimit>0 ){
      if( pGroup->xCallback ){
        pGroup->xCallback(pFile->zFilename, &pGroup->iLimit, szNew,
                          pGroup->pArg);
      }
      if( szNew>pGroup->iLimit && pGroup->iLimit>0 ){
        iEnd = pGroup->iLimit - pGroup->iSize + pFile->iSize;
        nmemb = (size_t)((iEnd - iOfst)/size);
        iEnd = iOfst + size*nmemb;
        szNew = pGroup->iSize - pFile->iSize + iEnd;
      }
    }
    pGroup->iSize = szNew;
    pFile->iSize = iEnd;
    quotaLeave();
  }else{
    pFile = 0;
  }
  rc = fwrite(pBuf, size, nmemb, p->f);

  /* If the write was incomplete, adjust the file size and group size
  ** downward */
  if( rc<nmemb && pFile ){
    size_t nWritten = rc;
    sqlite3_int64 iNewEnd = iOfst + size*nWritten;
    if( iNewEnd<iEnd ) iNewEnd = iEnd;
    quotaEnter();
    pFile->pGroup->iSize += iNewEnd - pFile->iSize;
    pFile->iSize = iNewEnd;
    quotaLeave();
  }
  return rc;
}

/*
** Close an open quota_FILE stream.
*/
int sqlite3_quota_fclose(quota_FILE *p){
  int rc;
  quotaFile *pFile;
  rc = fclose(p->f);
  pFile = p->pFile;
  if( pFile ){
    quotaEnter();
    pFile->nRef--;
    if( pFile->nRef==0 ){
      quotaGroup *pGroup = pFile->pGroup;
      if( pFile->deleteOnClose ){
        if (memcmp(gQuota.pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_0_enum], sizeof(gQuota.pOrigVfs->xDelete_signature)) == 0) {
          0;
        }
        else
          if (memcmp(gQuota.pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_apndDelete_enum], sizeof(gQuota.pOrigVfs->xDelete_signature)) == 0) {
            apndDelete(gQuota.pOrigVfs, pFile->zFilename, 0);
          }
        else
          if (memcmp(gQuota.pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_f5tOrigintextDelete_enum], sizeof(gQuota.pOrigVfs->xDelete_signature)) == 0) {
            f5tOrigintextDelete(gQuota.pOrigVfs, pFile->zFilename, 0);
          }
        else
          if (memcmp(gQuota.pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_f5tTokenizerDelete_enum], sizeof(gQuota.pOrigVfs->xDelete_signature)) == 0) {
            f5tTokenizerDelete(gQuota.pOrigVfs, pFile->zFilename, 0);
          }
        else
          if (memcmp(gQuota.pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_kvstorageDelete_enum], sizeof(gQuota.pOrigVfs->xDelete_signature)) == 0) {
            kvstorageDelete(gQuota.pOrigVfs, pFile->zFilename, 0);
          }
        else
          if (memcmp(gQuota.pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_vfstraceDelete_enum], sizeof(gQuota.pOrigVfs->xDelete_signature)) == 0) {
            vfstraceDelete(gQuota.pOrigVfs, pFile->zFilename, 0);
          }
        else
          if (memcmp(gQuota.pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_unixDelete_enum], sizeof(gQuota.pOrigVfs->xDelete_signature)) == 0) {
            unixDelete(gQuota.pOrigVfs, pFile->zFilename, 0);
          }
        quotaRemoveFile(pFile);
      }
      quotaGroupDeref(pGroup);
    }
    quotaLeave();
  }
#ifdef _WIN32
  quota_mbcs_free(p->zMbcsName);
#endif
  sqlite3_free(p);
  return rc;
}

/*
** Flush memory buffers for a quota_FILE to disk.
*/
int sqlite3_quota_fflush(quota_FILE *p, int doFsync){
  int rc;
  rc = fflush(p->f);
  if( rc==0 && doFsync ){
#ifdef _WIN32
    rc = _commit(_fileno(p->f));
#else
    rc = fsync(fileno(p->f));
#endif
  }
  return rc!=0;
}

/*
** Seek on a quota_FILE stream.
*/
int sqlite3_quota_fseek(quota_FILE *p, long offset, int whence){
  return fseek(p->f, offset, whence);
}

/*
** rewind a quota_FILE stream.
*/
void sqlite3_quota_rewind(quota_FILE *p){
  rewind(p->f);
}

/*
** Tell the current location of a quota_FILE stream.
*/
long sqlite3_quota_ftell(quota_FILE *p){
  return ftell(p->f);
}

/*
** Test the error indicator for the given file.
*/
int sqlite3_quota_ferror(quota_FILE *p){
  return ferror(p->f);
}

/*
** Truncate a file to szNew bytes.
*/
int sqlite3_quota_ftruncate(quota_FILE *p, sqlite3_int64 szNew){
  quotaFile *pFile = p->pFile;
  int rc;
  if( (pFile = p->pFile)!=0 && pFile->iSize<szNew ){
    quotaGroup *pGroup;
    if( pFile->iSize<szNew ){
      /* This routine cannot be used to extend a file that is under
      ** quota management.  Only true truncation is allowed. */
      return -1;
    }
    pGroup = pFile->pGroup;
    quotaEnter();
    pGroup->iSize += szNew - pFile->iSize;
    quotaLeave();
  }
#ifdef _WIN32
#  if defined(__MSVCRT__) && defined(SQLITE_TEST)
     /* _chsize_s() is missing from MingW (as of 2012-11-06).  Use
     ** _chsize() as a work-around for testing purposes. */
     rc = _chsize(_fileno(p->f), (long)szNew);
#  else
     rc = _chsize_s(_fileno(p->f), szNew);
#  endif
#else
  rc = ftruncate(fileno(p->f), szNew);
#endif
  if( pFile && rc==0 ){
    quotaGroup *pGroup = pFile->pGroup;
    quotaEnter();
    pGroup->iSize += szNew - pFile->iSize;
    pFile->iSize = szNew;
    quotaLeave();
  }
  return rc;
}

/*
** Determine the time that the given file was last modified, in
** seconds size 1970.  Write the result into *pTime.  Return 0 on
** success and non-zero on any kind of error.
*/
int sqlite3_quota_file_mtime(quota_FILE *p, time_t *pTime){
  int rc;
#ifdef _WIN32
  struct _stati64 buf;
  rc = _stati64(p->zMbcsName, &buf);
#else
  struct stat buf;
  rc = fstat(fileno(p->f), &buf);
#endif
  if( rc==0 ) *pTime = buf.st_mtime;
  return rc;
}

/*
** Return the true size of the file, as reported by the operating
** system.
*/
sqlite3_int64 sqlite3_quota_file_truesize(quota_FILE *p){
  int rc;
#ifdef _WIN32
  struct _stati64 buf;
  rc = _stati64(p->zMbcsName, &buf);
#else
  struct stat buf;
  rc = fstat(fileno(p->f), &buf);
#endif
  return rc==0 ? buf.st_size : -1;
}

/*
** Return the size of the file, as it is known to the quota subsystem.
*/
sqlite3_int64 sqlite3_quota_file_size(quota_FILE *p){
  return p->pFile ? p->pFile->iSize : -1;
}

/*
** Determine the amount of data in bytes available for reading
** in the given file.
*/
long sqlite3_quota_file_available(quota_FILE *p){
  FILE* f = p->f;
  long pos1, pos2;
  int rc;
  pos1 = ftell(f);
  if ( pos1 < 0 ) return -1;
  rc = fseek(f, 0, SEEK_END);
  if ( rc != 0 ) return -1;
  pos2 = ftell(f);
  if ( pos2 < 0 ) return -1;
  rc = fseek(f, pos1, SEEK_SET);
  if ( rc != 0 ) return -1;
  return pos2 - pos1;
}

/*
** Remove a managed file.  Update quotas accordingly.
*/
int sqlite3_quota_remove(const char *zFilename){
  char *zFull;            /* Full pathname for zFilename */
  size_t nFull;           /* Number of bytes in zFilename */
  int rc;                 /* Result code */
  quotaGroup *pGroup;     /* Group containing zFilename */
  quotaFile *pFile;       /* A file in the group */
  quotaFile *pNextFile;   /* next file in the group */
  int diff;               /* Difference between filenames */
  char c;                 /* First character past end of pattern */

  zFull = (char*)sqlite3_malloc(gQuota.sThisVfs.mxPathname + 1);
  if( zFull==0 ) return SQLITE_NOMEM;
  if (memcmp(gQuota.pOrigVfs->xFullPathname_signature, xFullPathname_signatures[xFullPathname_apndFullPathname_enum], sizeof(gQuota.pOrigVfs->xFullPathname_signature)) == 0) {
    rc = apndFullPathname(gQuota.pOrigVfs, zFilename,
                          gQuota.sThisVfs.mxPathname + 1, zFull);
  }
  else
    if (memcmp(gQuota.pOrigVfs->xFullPathname_signature, xFullPathname_signatures[xFullPathname_memdbFullPathname_enum], sizeof(gQuota.pOrigVfs->xFullPathname_signature)) == 0) {
      rc = memdbFullPathname(gQuota.pOrigVfs, zFilename,
                             gQuota.sThisVfs.mxPathname + 1, zFull);
    }
  else
    if (memcmp(gQuota.pOrigVfs->xFullPathname_signature, xFullPathname_signatures[xFullPathname_vfstraceFullPathname_enum], sizeof(gQuota.pOrigVfs->xFullPathname_signature)) == 0) {
      rc = vfstraceFullPathname(gQuota.pOrigVfs, zFilename,
                                gQuota.sThisVfs.mxPathname + 1, zFull);
    }
  else
    if (memcmp(gQuota.pOrigVfs->xFullPathname_signature, xFullPathname_signatures[xFullPathname_unixFullPathname_enum], sizeof(gQuota.pOrigVfs->xFullPathname_signature)) == 0) {
      rc = unixFullPathname(gQuota.pOrigVfs, zFilename,
                            gQuota.sThisVfs.mxPathname + 1, zFull);
    }
  if( rc ){
    sqlite3_free(zFull);
    return rc;
  }

  /* Figure out the length of the full pathname.  If the name ends with
  ** / (or \ on windows) then remove the trailing /.
  */
  nFull = strlen(zFull);
  if( nFull>0 && (zFull[nFull-1]=='/' || zFull[nFull-1]=='\\') ){
    nFull--;
    zFull[nFull] = 0;
  }

  quotaEnter();
  pGroup = quotaGroupFind(zFull);
  if( pGroup ){
    for(pFile=pGroup->pFiles; pFile && rc==SQLITE_OK; pFile=pNextFile){
      pNextFile = pFile->pNext;
      diff = strncmp(zFull, pFile->zFilename, nFull);
      if( diff==0 && ((c = pFile->zFilename[nFull])==0 || c=='/' || c=='\\') ){
        if( pFile->nRef ){
          pFile->deleteOnClose = 1;
        }else{
          if (memcmp(gQuota.pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_0_enum], sizeof(gQuota.pOrigVfs->xDelete_signature)) == 0) {
            rc = 0;
          }
          else
            if (memcmp(gQuota.pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_apndDelete_enum], sizeof(gQuota.pOrigVfs->xDelete_signature)) == 0) {
              rc = apndDelete(gQuota.pOrigVfs, pFile->zFilename, 0);
            }
          else
            if (memcmp(gQuota.pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_f5tOrigintextDelete_enum], sizeof(gQuota.pOrigVfs->xDelete_signature)) == 0) {
              rc = f5tOrigintextDelete(gQuota.pOrigVfs, pFile->zFilename, 0);
            }
          else
            if (memcmp(gQuota.pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_f5tTokenizerDelete_enum], sizeof(gQuota.pOrigVfs->xDelete_signature)) == 0) {
              rc = f5tTokenizerDelete(gQuota.pOrigVfs, pFile->zFilename, 0);
            }
          else
            if (memcmp(gQuota.pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_kvstorageDelete_enum], sizeof(gQuota.pOrigVfs->xDelete_signature)) == 0) {
              rc = kvstorageDelete(gQuota.pOrigVfs, pFile->zFilename, 0);
            }
          else
            if (memcmp(gQuota.pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_vfstraceDelete_enum], sizeof(gQuota.pOrigVfs->xDelete_signature)) == 0) {
              rc = vfstraceDelete(gQuota.pOrigVfs, pFile->zFilename, 0);
            }
          else
            if (memcmp(gQuota.pOrigVfs->xDelete_signature, xDelete_signatures[xDelete_unixDelete_enum], sizeof(gQuota.pOrigVfs->xDelete_signature)) == 0) {
              rc = unixDelete(gQuota.pOrigVfs, pFile->zFilename, 0);
            }
          quotaRemoveFile(pFile);
          quotaGroupDeref(pGroup);
        }
      }
    }
  }
  quotaLeave();
  sqlite3_free(zFull);
  return rc;
}

/***************************** Test Code ***********************************/
#ifdef SQLITE_TEST
#include "tclsqlite.h"

/*
** Argument passed to a TCL quota-over-limit callback.
*/
typedef struct TclQuotaCallback TclQuotaCallback;
struct TclQuotaCallback {
  Tcl_Interp *interp;    /* Interpreter in which to run the script */
  Tcl_Obj *pScript;      /* Script to be run */
};

extern const char *sqlite3ErrName(int);


/*
** This is the callback from a quota-over-limit.
*/
static void tclQuotaCallback(
  const char *zFilename,          /* Name of file whose size increases */
  sqlite3_int64 *piLimit,         /* IN/OUT: The current limit */
  sqlite3_int64 iSize,            /* Total size of all files in the group */
  void *pArg                      /* Client data */
){
  TclQuotaCallback *p;            /* Callback script object */
  Tcl_Obj *pEval;                 /* Script to evaluate */
  Tcl_Obj *pVarname;              /* Name of variable to pass as 2nd arg */
  unsigned int rnd;               /* Random part of pVarname */
  int rc;                         /* Tcl error code */

  p = (TclQuotaCallback *)pArg;
  if( p==0 ) return;

  pVarname = Tcl_NewStringObj("::piLimit_", -1);
  Tcl_IncrRefCount(pVarname);
  sqlite3_randomness(sizeof(rnd), (void *)&rnd);
  Tcl_AppendObjToObj(pVarname, Tcl_NewIntObj((int)(rnd&0x7FFFFFFF)));
  Tcl_ObjSetVar2(p->interp, pVarname, 0, Tcl_NewWideIntObj(*piLimit), 0);

  pEval = Tcl_DuplicateObj(p->pScript);
  Tcl_IncrRefCount(pEval);
  Tcl_ListObjAppendElement(0, pEval, Tcl_NewStringObj(zFilename, -1));
  Tcl_ListObjAppendElement(0, pEval, pVarname);
  Tcl_ListObjAppendElement(0, pEval, Tcl_NewWideIntObj(iSize));
  rc = Tcl_EvalObjEx(p->interp, pEval, TCL_EVAL_GLOBAL);

  if( rc==TCL_OK ){
    Tcl_WideInt x;
    Tcl_Obj *pLimit = Tcl_ObjGetVar2(p->interp, pVarname, 0, 0);
    rc = Tcl_GetWideIntFromObj(p->interp, pLimit, &x);
    *piLimit = x;
    Tcl_UnsetVar(p->interp, Tcl_GetString(pVarname), 0);
  }

  Tcl_DecrRefCount(pEval);
  Tcl_DecrRefCount(pVarname);
  if( rc!=TCL_OK ) Tcl_BackgroundError(p->interp);
}

/*
** Destructor for a TCL quota-over-limit callback.
*/
static void tclCallbackDestructor(void *pObj){
  TclQuotaCallback *p = (TclQuotaCallback*)pObj;
  if( p ){
    Tcl_DecrRefCount(p->pScript);
    sqlite3_free((char *)p);
  }
}

/*
** tclcmd: sqlite3_quota_initialize NAME MAKEDEFAULT
*/
static int SQLITE_TCLAPI test_quota_initialize(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  const char *zName;              /* Name of new quota VFS */
  int makeDefault;                /* True to make the new VFS the default */
  int rc;                         /* Value returned by quota_initialize() */

  /* Process arguments */
  if( objc!=3 ){
    Tcl_WrongNumArgs(interp, 1, objv, "NAME MAKEDEFAULT");
    return TCL_ERROR;
  }
  zName = Tcl_GetString(objv[1]);
  if( Tcl_GetBooleanFromObj(interp, objv[2], &makeDefault) ) return TCL_ERROR;
  if( zName[0]=='\0' ) zName = 0;

  /* Call sqlite3_quota_initialize() */
  rc = sqlite3_quota_initialize(zName, makeDefault);
  Tcl_SetResult(interp, (char *)sqlite3ErrName(rc), TCL_STATIC);

  return TCL_OK;
}

/*
** tclcmd: sqlite3_quota_shutdown
*/
static int SQLITE_TCLAPI test_quota_shutdown(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  int rc;                         /* Value returned by quota_shutdown() */

  if( objc!=1 ){
    Tcl_WrongNumArgs(interp, 1, objv, "");
    return TCL_ERROR;
  }

  /* Call sqlite3_quota_shutdown() */
  rc = sqlite3_quota_shutdown();
  Tcl_SetResult(interp, (char *)sqlite3ErrName(rc), TCL_STATIC);

  return TCL_OK;
}

/*
** tclcmd: sqlite3_quota_set PATTERN LIMIT SCRIPT
*/
static int SQLITE_TCLAPI test_quota_set(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  const char *zPattern;           /* File pattern to configure */
  Tcl_WideInt iLimit;             /* Initial quota in bytes */
  Tcl_Obj *pScript;               /* Tcl script to invoke to increase quota */
  int rc;                         /* Value returned by quota_set() */
  TclQuotaCallback *p;            /* Callback object */
  Tcl_Size nScript;               /* Length of callback script */
  void (*xDestroy)(void*);        /* Optional destructor for pArg */
  void (*xCallback)(const char *, sqlite3_int64 *, sqlite3_int64, void *);

  /* Process arguments */
  if( objc!=4 ){
    Tcl_WrongNumArgs(interp, 1, objv, "PATTERN LIMIT SCRIPT");
    return TCL_ERROR;
  }
  zPattern = Tcl_GetString(objv[1]);
  if( Tcl_GetWideIntFromObj(interp, objv[2], &iLimit) ) return TCL_ERROR;
  pScript = objv[3];
  Tcl_GetStringFromObj(pScript, &nScript);

  if( nScript>0 ){
    /* Allocate a TclQuotaCallback object */
    p = (TclQuotaCallback *)sqlite3_malloc(sizeof(TclQuotaCallback));
    if( !p ){
      Tcl_SetResult(interp, (char *)"SQLITE_NOMEM", TCL_STATIC);
      return TCL_OK;
    }
    memset(p, 0, sizeof(TclQuotaCallback));
    p->interp = interp;
    Tcl_IncrRefCount(pScript);
    p->pScript = pScript;
    xDestroy = tclCallbackDestructor;
    xCallback = tclQuotaCallback;
  }else{
    p = 0;
    xDestroy = 0;
    xCallback = 0;
  }

  /* Invoke sqlite3_quota_set() */
  rc = sqlite3_quota_set(zPattern, iLimit, xCallback, (void*)p, xDestroy);

  Tcl_SetResult(interp, (char *)sqlite3ErrName(rc), TCL_STATIC);
  return TCL_OK;
}

/*
** tclcmd: sqlite3_quota_file FILENAME
*/
static int SQLITE_TCLAPI test_quota_file(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  const char *zFilename;          /* File pattern to configure */
  int rc;                         /* Value returned by quota_file() */

  /* Process arguments */
  if( objc!=2 ){
    Tcl_WrongNumArgs(interp, 1, objv, "FILENAME");
    return TCL_ERROR;
  }
  zFilename = Tcl_GetString(objv[1]);

  /* Invoke sqlite3_quota_file() */
  rc = sqlite3_quota_file(zFilename);

  Tcl_SetResult(interp, (char *)sqlite3ErrName(rc), TCL_STATIC);
  return TCL_OK;
}

/*
** tclcmd:  sqlite3_quota_dump
*/
static int SQLITE_TCLAPI test_quota_dump(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  Tcl_Obj *pResult;
  Tcl_Obj *pGroupTerm;
  Tcl_Obj *pFileTerm;
  quotaGroup *pGroup;
  quotaFile *pFile;

  pResult = Tcl_NewObj();
  quotaEnter();
  for(pGroup=gQuota.pGroup; pGroup; pGroup=pGroup->pNext){
    pGroupTerm = Tcl_NewObj();
    Tcl_ListObjAppendElement(interp, pGroupTerm,
          Tcl_NewStringObj(pGroup->zPattern, -1));
    Tcl_ListObjAppendElement(interp, pGroupTerm,
          Tcl_NewWideIntObj(pGroup->iLimit));
    Tcl_ListObjAppendElement(interp, pGroupTerm,
          Tcl_NewWideIntObj(pGroup->iSize));
    for(pFile=pGroup->pFiles; pFile; pFile=pFile->pNext){
      int i;
      char zTemp[1000];
      pFileTerm = Tcl_NewObj();
      sqlite3_snprintf(sizeof(zTemp), zTemp, "%s", pFile->zFilename);
      for(i=0; zTemp[i]; i++){ if( zTemp[i]=='\\' ) zTemp[i] = '/'; }
      Tcl_ListObjAppendElement(interp, pFileTerm,
            Tcl_NewStringObj(zTemp, -1));
      Tcl_ListObjAppendElement(interp, pFileTerm,
            Tcl_NewWideIntObj(pFile->iSize));
      Tcl_ListObjAppendElement(interp, pFileTerm,
            Tcl_NewWideIntObj(pFile->nRef));
      Tcl_ListObjAppendElement(interp, pFileTerm,
            Tcl_NewWideIntObj(pFile->deleteOnClose));
      Tcl_ListObjAppendElement(interp, pGroupTerm, pFileTerm);
    }
    Tcl_ListObjAppendElement(interp, pResult, pGroupTerm);
  }
  quotaLeave();
  Tcl_SetObjResult(interp, pResult);
  return TCL_OK;
}

/*
** tclcmd: sqlite3_quota_fopen FILENAME MODE
*/
static int SQLITE_TCLAPI test_quota_fopen(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  const char *zFilename;          /* File pattern to configure */
  const char *zMode;              /* Mode string */
  quota_FILE *p;                  /* Open string object */
  char zReturn[50];               /* Name of pointer to return */

  /* Process arguments */
  if( objc!=3 ){
    Tcl_WrongNumArgs(interp, 1, objv, "FILENAME MODE");
    return TCL_ERROR;
  }
  zFilename = Tcl_GetString(objv[1]);
  zMode = Tcl_GetString(objv[2]);
  p = sqlite3_quota_fopen(zFilename, zMode);
  sqlite3_snprintf(sizeof(zReturn), zReturn, "%p", p);
  Tcl_SetResult(interp, zReturn, TCL_VOLATILE);
  return TCL_OK;
}

/* Defined in test1.c */
extern void *sqlite3TestTextToPtr(const char*);

/*
** tclcmd: sqlite3_quota_fread HANDLE SIZE NELEM
*/
static int SQLITE_TCLAPI test_quota_fread(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  quota_FILE *p;
  char *zBuf;
  int sz;
  int nElem;
  size_t got;

  if( objc!=4 ){
    Tcl_WrongNumArgs(interp, 1, objv, "HANDLE SIZE NELEM");
    return TCL_ERROR;
  }
  p = sqlite3TestTextToPtr(Tcl_GetString(objv[1]));
  if( Tcl_GetIntFromObj(interp, objv[2], &sz) ) return TCL_ERROR;
  if( Tcl_GetIntFromObj(interp, objv[3], &nElem) ) return TCL_ERROR;
  zBuf = (char*)sqlite3_malloc( sz*nElem + 1 );
  if( zBuf==0 ){
    Tcl_SetResult(interp, "out of memory", TCL_STATIC);
    return TCL_ERROR;
  }
  got = sqlite3_quota_fread(zBuf, sz, nElem, p);
  zBuf[got*sz] = 0;
  Tcl_SetResult(interp, zBuf, TCL_VOLATILE);
  sqlite3_free(zBuf);
  return TCL_OK;
}

/*
** tclcmd: sqlite3_quota_fwrite HANDLE SIZE NELEM CONTENT
*/
static int SQLITE_TCLAPI test_quota_fwrite(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  quota_FILE *p;
  char *zBuf;
  int sz;
  int nElem;
  size_t got;

  if( objc!=5 ){
    Tcl_WrongNumArgs(interp, 1, objv, "HANDLE SIZE NELEM CONTENT");
    return TCL_ERROR;
  }
  p = sqlite3TestTextToPtr(Tcl_GetString(objv[1]));
  if( Tcl_GetIntFromObj(interp, objv[2], &sz) ) return TCL_ERROR;
  if( Tcl_GetIntFromObj(interp, objv[3], &nElem) ) return TCL_ERROR;
  zBuf = Tcl_GetString(objv[4]);
  got = sqlite3_quota_fwrite(zBuf, sz, nElem, p);
  Tcl_SetObjResult(interp, Tcl_NewWideIntObj(got));
  return TCL_OK;
}

/*
** tclcmd: sqlite3_quota_fclose HANDLE
*/
static int SQLITE_TCLAPI test_quota_fclose(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  quota_FILE *p;
  int rc;

  if( objc!=2 ){
    Tcl_WrongNumArgs(interp, 1, objv, "HANDLE");
    return TCL_ERROR;
  }
  p = sqlite3TestTextToPtr(Tcl_GetString(objv[1]));
  rc = sqlite3_quota_fclose(p);
  Tcl_SetObjResult(interp, Tcl_NewIntObj(rc));
  return TCL_OK;
}

/*
** tclcmd: sqlite3_quota_fflush HANDLE ?HARDSYNC?
*/
static int SQLITE_TCLAPI test_quota_fflush(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  quota_FILE *p;
  int rc;
  int doSync = 0;

  if( objc!=2 && objc!=3 ){
    Tcl_WrongNumArgs(interp, 1, objv, "HANDLE ?HARDSYNC?");
    return TCL_ERROR;
  }
  p = sqlite3TestTextToPtr(Tcl_GetString(objv[1]));
  if( objc==3 ){
    if( Tcl_GetBooleanFromObj(interp, objv[2], &doSync) ) return TCL_ERROR;
  }
  rc = sqlite3_quota_fflush(p, doSync);
  Tcl_SetObjResult(interp, Tcl_NewIntObj(rc));
  return TCL_OK;
}

/*
** tclcmd: sqlite3_quota_fseek HANDLE OFFSET WHENCE
*/
static int SQLITE_TCLAPI test_quota_fseek(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  quota_FILE *p;
  int ofst;
  const char *zWhence;
  int whence;
  int rc;

  if( objc!=4 ){
    Tcl_WrongNumArgs(interp, 1, objv, "HANDLE OFFSET WHENCE");
    return TCL_ERROR;
  }
  p = sqlite3TestTextToPtr(Tcl_GetString(objv[1]));
  if( Tcl_GetIntFromObj(interp, objv[2], &ofst) ) return TCL_ERROR;
  zWhence = Tcl_GetString(objv[3]);
  if( strcmp(zWhence, "SEEK_SET")==0 ){
    whence = SEEK_SET;
  }else if( strcmp(zWhence, "SEEK_CUR")==0 ){
    whence = SEEK_CUR;
  }else if( strcmp(zWhence, "SEEK_END")==0 ){
    whence = SEEK_END;
  }else{
    Tcl_AppendResult(interp,
           "WHENCE should be SEEK_SET, SEEK_CUR, or SEEK_END", (char*)0);
    return TCL_ERROR;
  }
  rc = sqlite3_quota_fseek(p, ofst, whence);
  Tcl_SetObjResult(interp, Tcl_NewIntObj(rc));
  return TCL_OK;
}

/*
** tclcmd: sqlite3_quota_rewind HANDLE
*/
static int SQLITE_TCLAPI test_quota_rewind(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  quota_FILE *p;
  if( objc!=2 ){
    Tcl_WrongNumArgs(interp, 1, objv, "HANDLE");
    return TCL_ERROR;
  }
  p = sqlite3TestTextToPtr(Tcl_GetString(objv[1]));
  sqlite3_quota_rewind(p);
  return TCL_OK;
}

/*
** tclcmd: sqlite3_quota_ftell HANDLE
*/
static int SQLITE_TCLAPI test_quota_ftell(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  quota_FILE *p;
  sqlite3_int64 x;
  if( objc!=2 ){
    Tcl_WrongNumArgs(interp, 1, objv, "HANDLE");
    return TCL_ERROR;
  }
  p = sqlite3TestTextToPtr(Tcl_GetString(objv[1]));
  x = sqlite3_quota_ftell(p);
  Tcl_SetObjResult(interp, Tcl_NewWideIntObj(x));
  return TCL_OK;
}

/*
** tclcmd: sqlite3_quota_ftruncate HANDLE SIZE
*/
static int SQLITE_TCLAPI test_quota_ftruncate(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  quota_FILE *p;
  sqlite3_int64 x;
  Tcl_WideInt w;
  int rc;
  if( objc!=3 ){
    Tcl_WrongNumArgs(interp, 1, objv, "HANDLE SIZE");
    return TCL_ERROR;
  }
  p = sqlite3TestTextToPtr(Tcl_GetString(objv[1]));
  if( Tcl_GetWideIntFromObj(interp, objv[2], &w) ) return TCL_ERROR;
  x = (sqlite3_int64)w;
  rc = sqlite3_quota_ftruncate(p, x);
  Tcl_SetObjResult(interp, Tcl_NewIntObj(rc));
  return TCL_OK;
}

/*
** tclcmd: sqlite3_quota_file_size HANDLE
*/
static int SQLITE_TCLAPI test_quota_file_size(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  quota_FILE *p;
  sqlite3_int64 x;
  if( objc!=2 ){
    Tcl_WrongNumArgs(interp, 1, objv, "HANDLE");
    return TCL_ERROR;
  }
  p = sqlite3TestTextToPtr(Tcl_GetString(objv[1]));
  x = sqlite3_quota_file_size(p);
  Tcl_SetObjResult(interp, Tcl_NewWideIntObj(x));
  return TCL_OK;
}

/*
** tclcmd: sqlite3_quota_file_truesize HANDLE
*/
static int SQLITE_TCLAPI test_quota_file_truesize(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  quota_FILE *p;
  sqlite3_int64 x;
  if( objc!=2 ){
    Tcl_WrongNumArgs(interp, 1, objv, "HANDLE");
    return TCL_ERROR;
  }
  p = sqlite3TestTextToPtr(Tcl_GetString(objv[1]));
  x = sqlite3_quota_file_truesize(p);
  Tcl_SetObjResult(interp, Tcl_NewWideIntObj(x));
  return TCL_OK;
}

/*
** tclcmd: sqlite3_quota_file_mtime HANDLE
*/
static int SQLITE_TCLAPI test_quota_file_mtime(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  quota_FILE *p;
  time_t t;
  if( objc!=2 ){
    Tcl_WrongNumArgs(interp, 1, objv, "HANDLE");
    return TCL_ERROR;
  }
  p = sqlite3TestTextToPtr(Tcl_GetString(objv[1]));
  t = 0;
  sqlite3_quota_file_mtime(p, &t);
  Tcl_SetObjResult(interp, Tcl_NewWideIntObj(t));
  return TCL_OK;
}


/*
** tclcmd: sqlite3_quota_remove FILENAME
*/
static int SQLITE_TCLAPI test_quota_remove(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  const char *zFilename;          /* File pattern to configure */
  int rc;
  if( objc!=2 ){
    Tcl_WrongNumArgs(interp, 1, objv, "FILENAME");
    return TCL_ERROR;
  }
  zFilename = Tcl_GetString(objv[1]);
  rc = sqlite3_quota_remove(zFilename);
  Tcl_SetObjResult(interp, Tcl_NewIntObj(rc));
  return TCL_OK;
}

/*
** tclcmd: sqlite3_quota_glob PATTERN TEXT
**
** Test the glob pattern matching.  Return 1 if TEXT matches PATTERN
** and return 0 if it does not.
*/
static int SQLITE_TCLAPI test_quota_glob(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  const char *zPattern;          /* The glob pattern */
  const char *zText;             /* Text to compare against the pattern */
  int rc;
  if( objc!=3 ){
    Tcl_WrongNumArgs(interp, 1, objv, "PATTERN TEXT");
    return TCL_ERROR;
  }
  zPattern = Tcl_GetString(objv[1]);
  zText = Tcl_GetString(objv[2]);
  rc = quotaStrglob(zPattern, zText);
  Tcl_SetObjResult(interp, Tcl_NewIntObj(rc));
  return TCL_OK;
}

/*
** tclcmd: sqlite3_quota_file_available HANDLE
**
** Return the number of bytes from the current file point to the end of
** the file.
*/
static int SQLITE_TCLAPI test_quota_file_available(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  quota_FILE *p;
  sqlite3_int64 x;
  if( objc!=2 ){
    Tcl_WrongNumArgs(interp, 1, objv, "HANDLE");
    return TCL_ERROR;
  }
  p = sqlite3TestTextToPtr(Tcl_GetString(objv[1]));
  x = sqlite3_quota_file_available(p);
  Tcl_SetObjResult(interp, Tcl_NewWideIntObj(x));
  return TCL_OK;
}

/*
** tclcmd: sqlite3_quota_ferror HANDLE
**
** Return true if the file handle is in the error state.
*/
static int SQLITE_TCLAPI test_quota_ferror(
  void * clientData,
  Tcl_Interp *interp,
  int objc,
  Tcl_Obj *CONST objv[]
){
  quota_FILE *p;
  int x;
  if( objc!=2 ){
    Tcl_WrongNumArgs(interp, 1, objv, "HANDLE");
    return TCL_ERROR;
  }
  p = sqlite3TestTextToPtr(Tcl_GetString(objv[1]));
  x = sqlite3_quota_ferror(p);
  Tcl_SetObjResult(interp, Tcl_NewIntObj(x));
  return TCL_OK;
}

/*
** This routine registers the custom TCL commands defined in this
** module.  This should be the only procedure visible from outside
** of this module.
*/
int Sqlitequota_Init(Tcl_Interp *interp){
  static struct {
     char *zName;
     Tcl_ObjCmdProc *xProc;
  } aCmd[] = {
    { "sqlite3_quota_initialize",    test_quota_initialize },
    { "sqlite3_quota_shutdown",      test_quota_shutdown },
    { "sqlite3_quota_set",           test_quota_set },
    { "sqlite3_quota_file",          test_quota_file },
    { "sqlite3_quota_dump",          test_quota_dump },
    { "sqlite3_quota_fopen",         test_quota_fopen },
    { "sqlite3_quota_fread",         test_quota_fread },
    { "sqlite3_quota_fwrite",        test_quota_fwrite },
    { "sqlite3_quota_fclose",        test_quota_fclose },
    { "sqlite3_quota_fflush",        test_quota_fflush },
    { "sqlite3_quota_fseek",         test_quota_fseek },
    { "sqlite3_quota_rewind",        test_quota_rewind },
    { "sqlite3_quota_ftell",         test_quota_ftell },
    { "sqlite3_quota_ftruncate",     test_quota_ftruncate },
    { "sqlite3_quota_file_size",     test_quota_file_size },
    { "sqlite3_quota_file_truesize", test_quota_file_truesize },
    { "sqlite3_quota_file_mtime",    test_quota_file_mtime },
    { "sqlite3_quota_remove",        test_quota_remove },
    { "sqlite3_quota_glob",          test_quota_glob },
    { "sqlite3_quota_file_available",test_quota_file_available },
    { "sqlite3_quota_ferror",        test_quota_ferror },
  };
  int i;

  for(i=0; i<sizeof(aCmd)/sizeof(aCmd[0]); i++){
    Tcl_CreateObjCommand(interp, aCmd[i].zName, aCmd[i].xProc, 0, 0);
  }

  return TCL_OK;
}
#endif
