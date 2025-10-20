/*
** 2023-06-21
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
** This file implements an extension that uses the SQLITE_CONFIG_PCACHE2
** mechanism to add a tracing layer on top of pluggable page cache of
** SQLite.  If this extension is registered prior to sqlite3_initialize(),
** it will cause all page cache activities to be logged on standard output,
** or to some other FILE specified by the initializer.
**
** This file needs to be compiled into the application that uses it.
**
** This extension is used to implement the --pcachetrace option of the
** command-line shell.
*/
#include <assert.h>
#include <string.h>
#include <stdio.h>

/* The original page cache routines */
static sqlite3_pcache_methods2 pcacheBase;
static FILE *pcachetraceOut;

/* Methods that trace pcache activity */
int pcachetraceInit(void *pArg){
  int nRes;
  if( pcachetraceOut ){
    fprintf(pcachetraceOut, "PCACHETRACE: xInit(%p)\n", pArg);
  }
  if (memcmp(pcacheBase.xInit_signature, xInit_signatures[xInit_memtraceInit_enum], sizeof(pcacheBase.xInit_signature)) == 0) {
    nRes = memtraceInit(pArg);
  }
  else
    if (memcmp(pcacheBase.xInit_signature, xInit_signatures[xInit_pcache1Init_enum], sizeof(pcacheBase.xInit_signature)) == 0) {
      nRes = pcache1Init(pArg);
    }
  else
    if (memcmp(pcacheBase.xInit_signature, xInit_signatures[xInit_pcachetraceInit_enum], sizeof(pcacheBase.xInit_signature)) == 0) {
      nRes = pcachetraceInit(pArg);
    }
  else
    if (memcmp(pcacheBase.xInit_signature, xInit_signatures[xInit_sqlite3MemInit_enum], sizeof(pcacheBase.xInit_signature)) == 0) {
      nRes = sqlite3MemInit(pArg);
    }
  if( pcachetraceOut ){
    fprintf(pcachetraceOut, "PCACHETRACE: xInit(%p) -> %d\n", pArg, nRes);
  }
  return nRes;
}
void pcachetraceShutdown(void *pArg){
  if( pcachetraceOut ){
    fprintf(pcachetraceOut, "PCACHETRACE: xShutdown(%p)\n", pArg);
  }
  if (memcmp(pcacheBase.xShutdown_signature, xShutdown_signatures[xShutdown_memtraceShutdown_enum], sizeof(pcacheBase.xShutdown_signature)) == 0) {
    memtraceShutdown(pArg);
  }
  else
    if (memcmp(pcacheBase.xShutdown_signature, xShutdown_signatures[xShutdown_pcache1Shutdown_enum], sizeof(pcacheBase.xShutdown_signature)) == 0) {
      pcache1Shutdown(pArg);
    }
  else
    if (memcmp(pcacheBase.xShutdown_signature, xShutdown_signatures[xShutdown_pcachetraceShutdown_enum], sizeof(pcacheBase.xShutdown_signature)) == 0) {
      pcachetraceShutdown(pArg);
    }
  else
    if (memcmp(pcacheBase.xShutdown_signature, xShutdown_signatures[xShutdown_sqlite3MemShutdown_enum], sizeof(pcacheBase.xShutdown_signature)) == 0) {
      sqlite3MemShutdown(pArg);
    }
}
sqlite3_pcache *pcachetraceCreate(int szPage, int szExtra, int bPurge){
  sqlite3_pcache *pRes;
  if( pcachetraceOut ){
    fprintf(pcachetraceOut, "PCACHETRACE: xCreate(%d,%d,%d)\n",
            szPage, szExtra, bPurge);
  }
  if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_0_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
    pRes = 0;
  }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_amatchConnect_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = amatchConnect(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_closureConnect_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = closureConnect(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_csvtabCreate_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = csvtabCreate(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_dbpageConnect_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = dbpageConnect(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_echoCreate_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = echoCreate(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_expertConnect_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = expertConnect(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_f5tOrigintextCreate_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = f5tOrigintextCreate(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_f5tTokenizerCreate_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = f5tTokenizerCreate(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_fsConnect_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = fsConnect(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_fsdirConnect_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = fsdirConnect(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_fstreeConnect_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = fstreeConnect(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_fts3CreateMethod_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = fts3CreateMethod(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_fts3auxConnectMethod_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = fts3auxConnectMethod(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_fts3termConnectMethod_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = fts3termConnectMethod(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_fts3tokConnectMethod_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = fts3tokConnectMethod(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_fuzzerConnect_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = fuzzerConnect(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_geopolyCreate_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = geopolyCreate(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_intarrayCreate_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = intarrayCreate(szPage, szExtra, bPurge);
  //   }
  else
    if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_pcache1Create_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
      pRes = pcache1Create(szPage, szExtra, bPurge);
    }
  else
    if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_pcachetraceCreate_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
      pRes = pcachetraceCreate(szPage, szExtra, bPurge);
    }
  else
    if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_porterCreate_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
      pRes = porterCreate(szPage, szExtra, bPurge);
    }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_rtreeCreate_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = rtreeCreate(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_schemaCreate_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = schemaCreate(szPage, szExtra, bPurge);
  //   }
  else
    if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_simpleCreate_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
      pRes = simpleCreate(szPage, szExtra, bPurge);
    }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_spellfix1Create_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = spellfix1Create(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_statConnect_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = statConnect(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_tclConnect_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = tclConnect(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_tclvarConnect_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = tclvarConnect(szPage, szExtra, bPurge);
  //   }
  else
    if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_unicodeCreate_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
      pRes = unicodeCreate(szPage, szExtra, bPurge);
    }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_unionConnect_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = unionConnect(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_vlogConnect_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = vlogConnect(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_vtablogCreate_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = vtablogCreate(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_wholenumberConnect_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = wholenumberConnect(szPage, szExtra, bPurge);
  //   }
  // else
  //   if (memcmp(pcacheBase.xCreate_signature, xCreate_signatures[xCreate_zipfileConnect_enum], sizeof(pcacheBase.xCreate_signature)) == 0) {
  //     pRes = zipfileConnect(szPage, szExtra, bPurge);
  //   }
  if( pcachetraceOut ){
    fprintf(pcachetraceOut, "PCACHETRACE: xCreate(%d,%d,%d) -> %p\n",
            szPage, szExtra, bPurge, pRes);
  }
  return pRes;
}
void pcachetraceCachesize(sqlite3_pcache *p, int nCachesize){
  if( pcachetraceOut ){
    fprintf(pcachetraceOut, "PCACHETRACE: xCachesize(%p, %d)\n", p, nCachesize);
  }
  if (memcmp(pcacheBase.xCachesize_signature, xCachesize_signatures[xCachesize_pcache1Cachesize_enum], sizeof(pcacheBase.xCachesize_signature)) == 0) {
    pcache1Cachesize(p, nCachesize);
  }
  else
    if (memcmp(pcacheBase.xCachesize_signature, xCachesize_signatures[xCachesize_pcachetraceCachesize_enum], sizeof(pcacheBase.xCachesize_signature)) == 0) {
      pcachetraceCachesize(p, nCachesize);
    }
}
int pcachetracePagecount(sqlite3_pcache *p){
  int nRes;
  if( pcachetraceOut ){
    fprintf(pcachetraceOut, "PCACHETRACE: xPagecount(%p)\n", p);
  }
  if (memcmp(pcacheBase.xPagecount_signature, xPagecount_signatures[xPagecount_pcache1Pagecount_enum], sizeof(pcacheBase.xPagecount_signature)) == 0) {
    nRes = pcache1Pagecount(p);
  }
  else
    if (memcmp(pcacheBase.xPagecount_signature, xPagecount_signatures[xPagecount_pcachetracePagecount_enum], sizeof(pcacheBase.xPagecount_signature)) == 0) {
      nRes = pcachetracePagecount(p);
    }
  if( pcachetraceOut ){
    fprintf(pcachetraceOut, "PCACHETRACE: xPagecount(%p) -> %d\n", p, nRes);
  }
  return nRes;
}
sqlite3_pcache_page *pcachetraceFetch(
  sqlite3_pcache *p,
  unsigned key,
  int crFg
){
  sqlite3_pcache_page *pRes;
  if( pcachetraceOut ){
    fprintf(pcachetraceOut, "PCACHETRACE: xFetch(%p,%u,%d)\n", p, key, crFg);
  }
  if (memcmp(pcacheBase.xFetch_signature, xFetch_signatures[xFetch_0_enum], sizeof(pcacheBase.xFetch_signature)) == 0) {
    pRes = 0;
  }
  // else
  //   if (memcmp(pcacheBase.xFetch_signature, xFetch_signatures[xFetch_apndFetch_enum], sizeof(pcacheBase.xFetch_signature)) == 0) {
  //     pRes = apndFetch(p, key, crFg);
  //   }
  // else
  //   if (memcmp(pcacheBase.xFetch_signature, xFetch_signatures[xFetch_memdbFetch_enum], sizeof(pcacheBase.xFetch_signature)) == 0) {
  //     pRes = memdbFetch(p, key, crFg);
  //   }
  else
    if (memcmp(pcacheBase.xFetch_signature, xFetch_signatures[xFetch_pcache1Fetch_enum], sizeof(pcacheBase.xFetch_signature)) == 0) {
      pRes = pcache1Fetch(p, key, crFg);
    }
  else
    if (memcmp(pcacheBase.xFetch_signature, xFetch_signatures[xFetch_pcachetraceFetch_enum], sizeof(pcacheBase.xFetch_signature)) == 0) {
      pRes = pcachetraceFetch(p, key, crFg);
    }
  // else
  //   if (memcmp(pcacheBase.xFetch_signature, xFetch_signatures[xFetch_recoverVfsFetch_enum], sizeof(pcacheBase.xFetch_signature)) == 0) {
  //     pRes = recoverVfsFetch(p, key, crFg);
  //   }
  // else
  //   if (memcmp(pcacheBase.xFetch_signature, xFetch_signatures[xFetch_unixFetch_enum], sizeof(pcacheBase.xFetch_signature)) == 0) {
  //     pRes = unixFetch(p, key, crFg);
  //   }
  if( pcachetraceOut ){
    fprintf(pcachetraceOut, "PCACHETRACE: xFetch(%p,%u,%d) -> %p\n",
            p, key, crFg, pRes);
  }
  return pRes;
}
void pcachetraceUnpin(
  sqlite3_pcache *p,
  sqlite3_pcache_page *pPg,
  int bDiscard
){
  if( pcachetraceOut ){
    fprintf(pcachetraceOut, "PCACHETRACE: xUnpin(%p, %p, %d)\n",
            p, pPg, bDiscard);
  }
  if (memcmp(pcacheBase.xUnpin_signature, xUnpin_signatures[xUnpin_pcache1Unpin_enum], sizeof(pcacheBase.xUnpin_signature)) == 0) {
    pcache1Unpin(p, pPg, bDiscard);
  }
  else
    if (memcmp(pcacheBase.xUnpin_signature, xUnpin_signatures[xUnpin_pcachetraceUnpin_enum], sizeof(pcacheBase.xUnpin_signature)) == 0) {
      pcachetraceUnpin(p, pPg, bDiscard);
    }
}
void pcachetraceRekey(
  sqlite3_pcache *p,
  sqlite3_pcache_page *pPg,
  unsigned oldKey,
  unsigned newKey
){
  if( pcachetraceOut ){
    fprintf(pcachetraceOut, "PCACHETRACE: xRekey(%p, %p, %u, %u)\n",
        p, pPg, oldKey, newKey);
  }
  if (memcmp(pcacheBase.xRekey_signature, xRekey_signatures[xRekey_pcache1Rekey_enum], sizeof(pcacheBase.xRekey_signature)) == 0) {
    pcache1Rekey(p, pPg, oldKey, newKey);
  }
  else
    if (memcmp(pcacheBase.xRekey_signature, xRekey_signatures[xRekey_pcachetraceRekey_enum], sizeof(pcacheBase.xRekey_signature)) == 0) {
      pcachetraceRekey(p, pPg, oldKey, newKey);
    }
  // else
  //   if (memcmp(pcacheBase.xRekey_signature, xRekey_signatures[xRekey_unixRandomness_enum], sizeof(pcacheBase.xRekey_signature)) == 0) {
  //     unixRandomness(p, pPg, oldKey, newKey);
  //   }
}
void pcachetraceTruncate(sqlite3_pcache *p, unsigned n){
  if( pcachetraceOut ){
    fprintf(pcachetraceOut, "PCACHETRACE: xTruncate(%p, %u)\n", p, n);
  }
  if (memcmp(pcacheBase.xTruncate_signature, xTruncate_signatures[xTruncate_apndTruncate_enum], sizeof(pcacheBase.xTruncate_signature)) == 0) {
    apndTruncate(p, n);
  }
  else
    if (memcmp(pcacheBase.xTruncate_signature, xTruncate_signatures[xTruncate_memdbTruncate_enum], sizeof(pcacheBase.xTruncate_signature)) == 0) {
      memdbTruncate(p, n);
    }
  else
    if (memcmp(pcacheBase.xTruncate_signature, xTruncate_signatures[xTruncate_memjrnlTruncate_enum], sizeof(pcacheBase.xTruncate_signature)) == 0) {
      memjrnlTruncate(p, n);
    }
  else
    if (memcmp(pcacheBase.xTruncate_signature, xTruncate_signatures[xTruncate_pcache1Truncate_enum], sizeof(pcacheBase.xTruncate_signature)) == 0) {
      pcache1Truncate(p, n);
    }
  else
    if (memcmp(pcacheBase.xTruncate_signature, xTruncate_signatures[xTruncate_pcachetraceTruncate_enum], sizeof(pcacheBase.xTruncate_signature)) == 0) {
      pcachetraceTruncate(p, n);
    }
  else
    if (memcmp(pcacheBase.xTruncate_signature, xTruncate_signatures[xTruncate_recoverVfsTruncate_enum], sizeof(pcacheBase.xTruncate_signature)) == 0) {
      recoverVfsTruncate(p, n);
    }
  else
    if (memcmp(pcacheBase.xTruncate_signature, xTruncate_signatures[xTruncate_vfstraceTruncate_enum], sizeof(pcacheBase.xTruncate_signature)) == 0) {
      vfstraceTruncate(p, n);
    }
  else
    if (memcmp(pcacheBase.xTruncate_signature, xTruncate_signatures[xTruncate_unixTruncate_enum], sizeof(pcacheBase.xTruncate_signature)) == 0) {
      unixTruncate(p, n);
    }
}
void pcachetraceDestroy(sqlite3_pcache *p){
  if( pcachetraceOut ){
    fprintf(pcachetraceOut, "PCACHETRACE: xDestroy(%p)\n", p);
  }
  if (memcmp(pcacheBase.xDestroy_signature, xDestroy_signatures[xDestroy_0_enum], sizeof(pcacheBase.xDestroy_signature)) == 0) {
    0;
  }
  else
    if (memcmp(pcacheBase.xDestroy_signature, xDestroy_signatures[xDestroy_dbpageDisconnect_enum], sizeof(pcacheBase.xDestroy_signature)) == 0) {
      dbpageDisconnect(p);
    }
  else
    if (memcmp(pcacheBase.xDestroy_signature, xDestroy_signatures[xDestroy_expertDisconnect_enum], sizeof(pcacheBase.xDestroy_signature)) == 0) {
      expertDisconnect(p);
    }
  else
    if (memcmp(pcacheBase.xDestroy_signature, xDestroy_signatures[xDestroy_fsdirDisconnect_enum], sizeof(pcacheBase.xDestroy_signature)) == 0) {
      fsdirDisconnect(p);
    }
  else
    if (memcmp(pcacheBase.xDestroy_signature, xDestroy_signatures[xDestroy_fts3DestroyMethod_enum], sizeof(pcacheBase.xDestroy_signature)) == 0) {
      fts3DestroyMethod(p);
    }
  else
    if (memcmp(pcacheBase.xDestroy_signature, xDestroy_signatures[xDestroy_fts3auxDisconnectMethod_enum], sizeof(pcacheBase.xDestroy_signature)) == 0) {
      fts3auxDisconnectMethod(p);
    }
  else
    if (memcmp(pcacheBase.xDestroy_signature, xDestroy_signatures[xDestroy_fts3tokDisconnectMethod_enum], sizeof(pcacheBase.xDestroy_signature)) == 0) {
      fts3tokDisconnectMethod(p);
    }
  else
    if (memcmp(pcacheBase.xDestroy_signature, xDestroy_signatures[xDestroy_pcache1Destroy_enum], sizeof(pcacheBase.xDestroy_signature)) == 0) {
      pcache1Destroy(p);
    }
  else
    if (memcmp(pcacheBase.xDestroy_signature, xDestroy_signatures[xDestroy_pcachetraceDestroy_enum], sizeof(pcacheBase.xDestroy_signature)) == 0) {
      pcachetraceDestroy(p);
    }
  else
    if (memcmp(pcacheBase.xDestroy_signature, xDestroy_signatures[xDestroy_porterDestroy_enum], sizeof(pcacheBase.xDestroy_signature)) == 0) {
      porterDestroy(p);
    }
  else
    if (memcmp(pcacheBase.xDestroy_signature, xDestroy_signatures[xDestroy_rtreeDestroy_enum], sizeof(pcacheBase.xDestroy_signature)) == 0) {
      rtreeDestroy(p);
    }
  else
    if (memcmp(pcacheBase.xDestroy_signature, xDestroy_signatures[xDestroy_simpleDestroy_enum], sizeof(pcacheBase.xDestroy_signature)) == 0) {
      simpleDestroy(p);
    }
  else
    if (memcmp(pcacheBase.xDestroy_signature, xDestroy_signatures[xDestroy_statDisconnect_enum], sizeof(pcacheBase.xDestroy_signature)) == 0) {
      statDisconnect(p);
    }
  else
    if (memcmp(pcacheBase.xDestroy_signature, xDestroy_signatures[xDestroy_unicodeDestroy_enum], sizeof(pcacheBase.xDestroy_signature)) == 0) {
      unicodeDestroy(p);
    }
  else
    if (memcmp(pcacheBase.xDestroy_signature, xDestroy_signatures[xDestroy_zipfileDisconnect_enum], sizeof(pcacheBase.xDestroy_signature)) == 0) {
      zipfileDisconnect(p);
    }
}
void pcachetraceShrink(sqlite3_pcache *p){
  if( pcachetraceOut ){
    fprintf(pcachetraceOut, "PCACHETRACE: xShrink(%p)\n", p);
  }
  if (memcmp(pcacheBase.xShrink_signature, xShrink_signatures[xShrink_pcache1Shrink_enum], sizeof(pcacheBase.xShrink_signature)) == 0) {
    pcache1Shrink(p);
  }
  else
    if (memcmp(pcacheBase.xShrink_signature, xShrink_signatures[xShrink_pcachetraceShrink_enum], sizeof(pcacheBase.xShrink_signature)) == 0) {
      pcachetraceShrink(p);
    }
}

/* The substitute pcache methods */
static sqlite3_pcache_methods2 ersaztPcacheMethods = {
  0,
  0,
  pcachetraceInit,
  pcachetraceShutdown,
  pcachetraceCreate,
  pcachetraceCachesize,
  pcachetracePagecount,
  pcachetraceFetch,
  pcachetraceUnpin,
  pcachetraceRekey,
  pcachetraceTruncate,
  pcachetraceDestroy,
  pcachetraceShrink
,
  .xInit_signature = xInit_signatures[xInit_pcachetraceInit_enum],
  .xShutdown_signature = xShutdown_signatures[xShutdown_pcachetraceShutdown_enum],
  .xCreate_signature = xCreate_signatures[xCreate_pcachetraceCreate_enum],
  .xCachesize_signature = xCachesize_signatures[xCachesize_pcachetraceCachesize_enum],
  .xPagecount_signature = xPagecount_signatures[xPagecount_pcachetracePagecount_enum],
  .xFetch_signature = xFetch_signatures[xFetch_pcachetraceFetch_enum],
  .xUnpin_signature = xUnpin_signatures[xUnpin_pcachetraceUnpin_enum],
  .xRekey_signature = xRekey_signatures[xRekey_pcachetraceRekey_enum],
  .xTruncate_signature = xTruncate_signatures[xTruncate_pcachetraceTruncate_enum],
  .xDestroy_signature = xDestroy_signatures[xDestroy_pcachetraceDestroy_enum],
  .xShrink_signature = xShrink_signatures[xShrink_pcachetraceShrink_enum]
};

/* Begin tracing memory allocations to out. */
int sqlite3PcacheTraceActivate(FILE *out){
  int rc = SQLITE_OK;
  if( pcacheBase.xFetch==0 ){
    rc = sqlite3_config(SQLITE_CONFIG_GETPCACHE2, &pcacheBase);
    if( rc==SQLITE_OK ){
      rc = sqlite3_config(SQLITE_CONFIG_PCACHE2, &ersaztPcacheMethods);
    }
  }
  pcachetraceOut = out;
  return rc;
}

/* Deactivate memory tracing */
int sqlite3PcacheTraceDeactivate(void){
  int rc = SQLITE_OK;
  if( pcacheBase.xFetch!=0 ){
    rc = sqlite3_config(SQLITE_CONFIG_PCACHE2, &pcacheBase);
    if( rc==SQLITE_OK ){
      memset(&pcacheBase, 0, sizeof(pcacheBase));
    }
  }
  pcachetraceOut = 0;
  return rc;
}
