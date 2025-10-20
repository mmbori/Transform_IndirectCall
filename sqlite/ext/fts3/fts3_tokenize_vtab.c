/*
** 2013 Apr 22
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
** This file contains code for the "fts3tokenize" virtual table module.
** An fts3tokenize virtual table is created as follows:
**
**   CREATE VIRTUAL TABLE <tbl> USING fts3tokenize(
**       <tokenizer-name>, <arg-1>, ...
**   );
**
** The table created has the following schema:
**
**   CREATE TABLE <tbl>(input, token, start, end, position)
**
** When queried, the query must include a WHERE clause of type:
**
**   input = <string>
**
** The virtual table module tokenizes this <string>, using the FTS3 
** tokenizer specified by the arguments to the CREATE VIRTUAL TABLE 
** statement and returns one row for each token in the result. With
** fields set as follows:
**
**   input:   Always set to a copy of <string>
**   token:   A token from the input.
**   start:   Byte offset of the token within the input <string>.
**   end:     Byte offset of the byte immediately following the end of the
**            token within the input string.
**   pos:     Token offset of token within input.
**
*/
#include "fts3Int.h"
#if !defined(SQLITE_CORE) || defined(SQLITE_ENABLE_FTS3)

#include <string.h>
#include <assert.h>

typedef struct Fts3tokTable Fts3tokTable;
typedef struct Fts3tokCursor Fts3tokCursor;

/*
** Virtual table structure.
*/
struct Fts3tokTable {
  sqlite3_vtab base;              /* Base class used by SQLite core */
  const sqlite3_tokenizer_module *pMod;
  sqlite3_tokenizer *pTok;
};

/*
** Virtual table cursor structure.
*/
struct Fts3tokCursor {
  sqlite3_vtab_cursor base;       /* Base class used by SQLite core */
  char *zInput;                   /* Input string */
  sqlite3_tokenizer_cursor *pCsr; /* Cursor to iterate through zInput */
  int iRowid;                     /* Current 'rowid' value */
  const char *zToken;             /* Current 'token' value */
  int nToken;                     /* Size of zToken in bytes */
  int iStart;                     /* Current 'start' value */
  int iEnd;                       /* Current 'end' value */
  int iPos;                       /* Current 'pos' value */
};

/*
** Query FTS for the tokenizer implementation named zName.
*/
static int fts3tokQueryTokenizer(
  Fts3Hash *pHash,
  const char *zName,
  const sqlite3_tokenizer_module **pp,
  char **pzErr
){
  sqlite3_tokenizer_module *p;
  int nName = (int)strlen(zName);

  p = (sqlite3_tokenizer_module *)sqlite3Fts3HashFind(pHash, zName, nName+1);
  if( !p ){
    sqlite3Fts3ErrMsg(pzErr, "unknown tokenizer: %s", zName);
    return SQLITE_ERROR;
  }

  *pp = p;
  return SQLITE_OK;
}

/*
** The second argument, argv[], is an array of pointers to nul-terminated
** strings. This function makes a copy of the array and strings into a 
** single block of memory. It then dequotes any of the strings that appear
** to be quoted.
**
** If successful, output parameter *pazDequote is set to point at the
** array of dequoted strings and SQLITE_OK is returned. The caller is
** responsible for eventually calling sqlite3_free() to free the array
** in this case. Or, if an error occurs, an SQLite error code is returned.
** The final value of *pazDequote is undefined in this case.
*/
static int fts3tokDequoteArray(
  int argc,                       /* Number of elements in argv[] */
  const char * const *argv,       /* Input array */
  char ***pazDequote              /* Output array */
){
  int rc = SQLITE_OK;             /* Return code */
  if( argc==0 ){
    *pazDequote = 0;
  }else{
    int i;
    int nByte = 0;
    char **azDequote;

    for(i=0; i<argc; i++){
      nByte += (int)(strlen(argv[i]) + 1);
    }

    *pazDequote = azDequote = sqlite3_malloc64(sizeof(char *)*argc + nByte);
    if( azDequote==0 ){
      rc = SQLITE_NOMEM;
    }else{
      char *pSpace = (char *)&azDequote[argc];
      for(i=0; i<argc; i++){
        int n = (int)strlen(argv[i]);
        azDequote[i] = pSpace;
        memcpy(pSpace, argv[i], n+1);
        sqlite3Fts3Dequote(pSpace);
        pSpace += (n+1);
      }
    }
  }

  return rc;
}

/*
** Schema of the tokenizer table.
*/
#define FTS3_TOK_SCHEMA "CREATE TABLE x(input, token, start, end, position)"

/*
** This function does all the work for both the xConnect and xCreate methods.
** These tables have no persistent representation of their own, so xConnect
** and xCreate are identical operations.
**
**   argv[0]: module name
**   argv[1]: database name 
**   argv[2]: table name
**   argv[3]: first argument (tokenizer name)
*/
int fts3tokConnectMethod(
  sqlite3 *db,                    /* Database connection */
  void *pHash,                    /* Hash table of tokenizers */
  int argc,                       /* Number of elements in argv array */
  const char * const *argv,       /* xCreate/xConnect argument array */
  sqlite3_vtab **ppVtab,          /* OUT: New sqlite3_vtab object */
  char **pzErr                    /* OUT: sqlite3_malloc'd error message */
){
  Fts3tokTable *pTab = 0;
  const sqlite3_tokenizer_module *pMod = 0;
  sqlite3_tokenizer *pTok = 0;
  int rc;
  char **azDequote = 0;
  int nDequote;

  rc = sqlite3_declare_vtab(db, FTS3_TOK_SCHEMA);
  if( rc!=SQLITE_OK ) return rc;

  nDequote = argc-3;
  rc = fts3tokDequoteArray(nDequote, &argv[3], &azDequote);

  if( rc==SQLITE_OK ){
    const char *zModule;
    if( nDequote<1 ){
      zModule = "simple";
    }else{
      zModule = azDequote[0];
    }
    rc = fts3tokQueryTokenizer((Fts3Hash*)pHash, zModule, &pMod, pzErr);
  }

  assert( (rc==SQLITE_OK)==(pMod!=0) );
  if( rc==SQLITE_OK ){
    const char * const *azArg = 0;
    if( nDequote>1 ) azArg = (const char * const *)&azDequote[1];
    if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_0_enum], sizeof(pMod->xCreate_signature)) == 0) {
      rc = 0;
    }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_amatchConnect_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = amatchConnect((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_closureConnect_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = closureConnect((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_csvtabCreate_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = csvtabCreate((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_dbpageConnect_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = dbpageConnect((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_echoCreate_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = echoCreate((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_expertConnect_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = expertConnect((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_f5tOrigintextCreate_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = f5tOrigintextCreate((nDequote > 1 ? nDequote - 1 : 0), azArg,
    //                              &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_f5tTokenizerCreate_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = f5tTokenizerCreate((nDequote > 1 ? nDequote - 1 : 0), azArg,
    //                             &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_fsConnect_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = fsConnect((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_fsdirConnect_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = fsdirConnect((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_fstreeConnect_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = fstreeConnect((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_fts3CreateMethod_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = fts3CreateMethod((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_fts3auxConnectMethod_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = fts3auxConnectMethod((nDequote > 1 ? nDequote - 1 : 0), azArg,
    //                               &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_fts3termConnectMethod_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = fts3termConnectMethod((nDequote > 1 ? nDequote - 1 : 0), azArg,
    //                                &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_fts3tokConnectMethod_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = fts3tokConnectMethod((nDequote > 1 ? nDequote - 1 : 0), azArg,
    //                               &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_fuzzerConnect_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = fuzzerConnect((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_geopolyCreate_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = geopolyCreate((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_intarrayCreate_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = intarrayCreate((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
    else
      if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_pcache1Create_enum], sizeof(pMod->xCreate_signature)) == 0) {
        rc = pcache1Create((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
      }
    else
      if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_pcachetraceCreate_enum], sizeof(pMod->xCreate_signature)) == 0) {
        rc = pcachetraceCreate((nDequote > 1 ? nDequote - 1 : 0), azArg,
                               &pTok);
      }
    else
      if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_porterCreate_enum], sizeof(pMod->xCreate_signature)) == 0) {
        rc = porterCreate((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
      }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_rtreeCreate_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = rtreeCreate((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_schemaCreate_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = schemaCreate((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
    else
      if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_simpleCreate_enum], sizeof(pMod->xCreate_signature)) == 0) {
        rc = simpleCreate((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
      }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_spellfix1Create_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = spellfix1Create((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_statConnect_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = statConnect((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_tclConnect_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = tclConnect((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_tclvarConnect_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = tclvarConnect((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
    else
      if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_unicodeCreate_enum], sizeof(pMod->xCreate_signature)) == 0) {
        rc = unicodeCreate((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
      }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_unionConnect_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = unionConnect((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_vlogConnect_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = vlogConnect((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_vtablogCreate_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = vtablogCreate((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_wholenumberConnect_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = wholenumberConnect((nDequote > 1 ? nDequote - 1 : 0), azArg,
    //                             &pTok);
    //   }
    // else
    //   if (memcmp(pMod->xCreate_signature, xCreate_signatures[xCreate_zipfileConnect_enum], sizeof(pMod->xCreate_signature)) == 0) {
    //     rc = zipfileConnect((nDequote > 1 ? nDequote - 1 : 0), azArg, &pTok);
    //   }
  }

  if( rc==SQLITE_OK ){
    pTab = (Fts3tokTable *)sqlite3_malloc(sizeof(Fts3tokTable));
    if( pTab==0 ){
      rc = SQLITE_NOMEM;
    }
  }

  if( rc==SQLITE_OK ){
    memset(pTab, 0, sizeof(Fts3tokTable));
    pTab->pMod = pMod;
    pTab->pTok = pTok;
    *ppVtab = &pTab->base;
  }else{
    if( pTok ){
      if (memcmp(pMod->xDestroy_signature, xDestroy_signatures[xDestroy_0_enum], sizeof(pMod->xDestroy_signature)) == 0) {
        0;
      }
      else
        if (memcmp(pMod->xDestroy_signature, xDestroy_signatures[xDestroy_dbpageDisconnect_enum], sizeof(pMod->xDestroy_signature)) == 0) {
          dbpageDisconnect(pTok);
        }
      else
        if (memcmp(pMod->xDestroy_signature, xDestroy_signatures[xDestroy_expertDisconnect_enum], sizeof(pMod->xDestroy_signature)) == 0) {
          expertDisconnect(pTok);
        }
      else
        if (memcmp(pMod->xDestroy_signature, xDestroy_signatures[xDestroy_fsdirDisconnect_enum], sizeof(pMod->xDestroy_signature)) == 0) {
          fsdirDisconnect(pTok);
        }
      else
        if (memcmp(pMod->xDestroy_signature, xDestroy_signatures[xDestroy_fts3DestroyMethod_enum], sizeof(pMod->xDestroy_signature)) == 0) {
          fts3DestroyMethod(pTok);
        }
      else
        if (memcmp(pMod->xDestroy_signature, xDestroy_signatures[xDestroy_fts3auxDisconnectMethod_enum], sizeof(pMod->xDestroy_signature)) == 0) {
          fts3auxDisconnectMethod(pTok);
        }
      else
        if (memcmp(pMod->xDestroy_signature, xDestroy_signatures[xDestroy_fts3tokDisconnectMethod_enum], sizeof(pMod->xDestroy_signature)) == 0) {
          fts3tokDisconnectMethod(pTok);
        }
      else
        if (memcmp(pMod->xDestroy_signature, xDestroy_signatures[xDestroy_pcache1Destroy_enum], sizeof(pMod->xDestroy_signature)) == 0) {
          pcache1Destroy(pTok);
        }
      else
        if (memcmp(pMod->xDestroy_signature, xDestroy_signatures[xDestroy_pcachetraceDestroy_enum], sizeof(pMod->xDestroy_signature)) == 0) {
          pcachetraceDestroy(pTok);
        }
      else
        if (memcmp(pMod->xDestroy_signature, xDestroy_signatures[xDestroy_porterDestroy_enum], sizeof(pMod->xDestroy_signature)) == 0) {
          porterDestroy(pTok);
        }
      else
        if (memcmp(pMod->xDestroy_signature, xDestroy_signatures[xDestroy_rtreeDestroy_enum], sizeof(pMod->xDestroy_signature)) == 0) {
          rtreeDestroy(pTok);
        }
      else
        if (memcmp(pMod->xDestroy_signature, xDestroy_signatures[xDestroy_simpleDestroy_enum], sizeof(pMod->xDestroy_signature)) == 0) {
          simpleDestroy(pTok);
        }
      else
        if (memcmp(pMod->xDestroy_signature, xDestroy_signatures[xDestroy_statDisconnect_enum], sizeof(pMod->xDestroy_signature)) == 0) {
          statDisconnect(pTok);
        }
      else
        if (memcmp(pMod->xDestroy_signature, xDestroy_signatures[xDestroy_unicodeDestroy_enum], sizeof(pMod->xDestroy_signature)) == 0) {
          unicodeDestroy(pTok);
        }
      else
        if (memcmp(pMod->xDestroy_signature, xDestroy_signatures[xDestroy_zipfileDisconnect_enum], sizeof(pMod->xDestroy_signature)) == 0) {
          zipfileDisconnect(pTok);
        }
    }
  }

  sqlite3_free(azDequote);
  return rc;
}

/*
** This function does the work for both the xDisconnect and xDestroy methods.
** These tables have no persistent representation of their own, so xDisconnect
** and xDestroy are identical operations.
*/
int fts3tokDisconnectMethod(sqlite3_vtab *pVtab){
  Fts3tokTable *pTab = (Fts3tokTable *)pVtab;

  if (memcmp(pTab->pMod->xDestroy_signature, xDestroy_signatures[xDestroy_0_enum], sizeof(pTab->pMod->xDestroy_signature)) == 0) {
    0;
  }
  else
    if (memcmp(pTab->pMod->xDestroy_signature, xDestroy_signatures[xDestroy_dbpageDisconnect_enum], sizeof(pTab->pMod->xDestroy_signature)) == 0) {
      dbpageDisconnect(pTab->pTok);
    }
  else
    if (memcmp(pTab->pMod->xDestroy_signature, xDestroy_signatures[xDestroy_expertDisconnect_enum], sizeof(pTab->pMod->xDestroy_signature)) == 0) {
      expertDisconnect(pTab->pTok);
    }
  else
    if (memcmp(pTab->pMod->xDestroy_signature, xDestroy_signatures[xDestroy_fsdirDisconnect_enum], sizeof(pTab->pMod->xDestroy_signature)) == 0) {
      fsdirDisconnect(pTab->pTok);
    }
  else
    if (memcmp(pTab->pMod->xDestroy_signature, xDestroy_signatures[xDestroy_fts3DestroyMethod_enum], sizeof(pTab->pMod->xDestroy_signature)) == 0) {
      fts3DestroyMethod(pTab->pTok);
    }
  else
    if (memcmp(pTab->pMod->xDestroy_signature, xDestroy_signatures[xDestroy_fts3auxDisconnectMethod_enum], sizeof(pTab->pMod->xDestroy_signature)) == 0) {
      fts3auxDisconnectMethod(pTab->pTok);
    }
  else
    if (memcmp(pTab->pMod->xDestroy_signature, xDestroy_signatures[xDestroy_fts3tokDisconnectMethod_enum], sizeof(pTab->pMod->xDestroy_signature)) == 0) {
      fts3tokDisconnectMethod(pTab->pTok);
    }
  else
    if (memcmp(pTab->pMod->xDestroy_signature, xDestroy_signatures[xDestroy_pcache1Destroy_enum], sizeof(pTab->pMod->xDestroy_signature)) == 0) {
      pcache1Destroy(pTab->pTok);
    }
  else
    if (memcmp(pTab->pMod->xDestroy_signature, xDestroy_signatures[xDestroy_pcachetraceDestroy_enum], sizeof(pTab->pMod->xDestroy_signature)) == 0) {
      pcachetraceDestroy(pTab->pTok);
    }
  else
    if (memcmp(pTab->pMod->xDestroy_signature, xDestroy_signatures[xDestroy_porterDestroy_enum], sizeof(pTab->pMod->xDestroy_signature)) == 0) {
      porterDestroy(pTab->pTok);
    }
  else
    if (memcmp(pTab->pMod->xDestroy_signature, xDestroy_signatures[xDestroy_rtreeDestroy_enum], sizeof(pTab->pMod->xDestroy_signature)) == 0) {
      rtreeDestroy(pTab->pTok);
    }
  else
    if (memcmp(pTab->pMod->xDestroy_signature, xDestroy_signatures[xDestroy_simpleDestroy_enum], sizeof(pTab->pMod->xDestroy_signature)) == 0) {
      simpleDestroy(pTab->pTok);
    }
  else
    if (memcmp(pTab->pMod->xDestroy_signature, xDestroy_signatures[xDestroy_statDisconnect_enum], sizeof(pTab->pMod->xDestroy_signature)) == 0) {
      statDisconnect(pTab->pTok);
    }
  else
    if (memcmp(pTab->pMod->xDestroy_signature, xDestroy_signatures[xDestroy_unicodeDestroy_enum], sizeof(pTab->pMod->xDestroy_signature)) == 0) {
      unicodeDestroy(pTab->pTok);
    }
  else
    if (memcmp(pTab->pMod->xDestroy_signature, xDestroy_signatures[xDestroy_zipfileDisconnect_enum], sizeof(pTab->pMod->xDestroy_signature)) == 0) {
      zipfileDisconnect(pTab->pTok);
    }
  sqlite3_free(pTab);
  return SQLITE_OK;
}

/*
** xBestIndex - Analyze a WHERE and ORDER BY clause.
*/
int fts3tokBestIndexMethod(
  sqlite3_vtab *pVTab, 
  sqlite3_index_info *pInfo
){
  int i;
  UNUSED_PARAMETER(pVTab);

  for(i=0; i<pInfo->nConstraint; i++){
    if( pInfo->aConstraint[i].usable 
     && pInfo->aConstraint[i].iColumn==0 
     && pInfo->aConstraint[i].op==SQLITE_INDEX_CONSTRAINT_EQ 
    ){
      pInfo->idxNum = 1;
      pInfo->aConstraintUsage[i].argvIndex = 1;
      pInfo->aConstraintUsage[i].omit = 1;
      pInfo->estimatedCost = 1;
      return SQLITE_OK;
    }
  }

  pInfo->idxNum = 0;
  assert( pInfo->estimatedCost>1000000.0 );

  return SQLITE_OK;
}

/*
** xOpen - Open a cursor.
*/
int fts3tokOpenMethod(sqlite3_vtab *pVTab, sqlite3_vtab_cursor **ppCsr){
  Fts3tokCursor *pCsr;
  UNUSED_PARAMETER(pVTab);

  pCsr = (Fts3tokCursor *)sqlite3_malloc(sizeof(Fts3tokCursor));
  if( pCsr==0 ){
    return SQLITE_NOMEM;
  }
  memset(pCsr, 0, sizeof(Fts3tokCursor));

  *ppCsr = (sqlite3_vtab_cursor *)pCsr;
  return SQLITE_OK;
}

/*
** Reset the tokenizer cursor passed as the only argument. As if it had
** just been returned by fts3tokOpenMethod().
*/
static void fts3tokResetCursor(Fts3tokCursor *pCsr){
  if( pCsr->pCsr ){
    Fts3tokTable *pTab = (Fts3tokTable *)(pCsr->base.pVtab);
    if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_apndClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
      apndClose(pCsr->pCsr);
    }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_bytecodevtabClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        bytecodevtabClose(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_completionClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        completionClose(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_dbdataClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        dbdataClose(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_dbpageClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        dbpageClose(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_expertClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        expertClose(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_fsdirClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        fsdirClose(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_fts3CloseMethod_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        fts3CloseMethod(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_fts3auxCloseMethod_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        fts3auxCloseMethod(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_fts3tokCloseMethod_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        fts3tokCloseMethod(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_jsonEachClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        jsonEachClose(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_memdbClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        memdbClose(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_memjrnlClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        memjrnlClose(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_porterClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        porterClose(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_pragmaVtabClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        pragmaVtabClose(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_recoverVfsClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        recoverVfsClose(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_rtreeClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        rtreeClose(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_seriesClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        seriesClose(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_simpleClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        simpleClose(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_statClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        statClose(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_stmtClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        stmtClose(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_unicodeClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        unicodeClose(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_vfstraceClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        vfstraceClose(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_zipfileClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        zipfileClose(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_unixClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        unixClose(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_nolockClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        nolockClose(pCsr->pCsr);
      }
    else
      if (memcmp(pTab->pMod->xClose_signature, xClose_signatures[xClose_dotlockClose_enum], sizeof(pTab->pMod->xClose_signature)) == 0) {
        dotlockClose(pCsr->pCsr);
      }
    pCsr->pCsr = 0;
  }
  sqlite3_free(pCsr->zInput);
  pCsr->zInput = 0;
  pCsr->zToken = 0;
  pCsr->nToken = 0;
  pCsr->iStart = 0;
  pCsr->iEnd = 0;
  pCsr->iPos = 0;
  pCsr->iRowid = 0;
}

/*
** xClose - Close a cursor.
*/
int fts3tokCloseMethod(sqlite3_vtab_cursor *pCursor){
  Fts3tokCursor *pCsr = (Fts3tokCursor *)pCursor;

  fts3tokResetCursor(pCsr);
  sqlite3_free(pCsr);
  return SQLITE_OK;
}

/*
** xNext - Advance the cursor to the next row, if any.
*/
int fts3tokNextMethod(sqlite3_vtab_cursor *pCursor){
  Fts3tokCursor *pCsr = (Fts3tokCursor *)pCursor;
  Fts3tokTable *pTab = (Fts3tokTable *)(pCursor->pVtab);
  int rc;                         /* Return code */

  pCsr->iRowid++;
  if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_0_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
    rc = 0;
  }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_amatchNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = amatchNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                     &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_binfoNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = binfoNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                    &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_bytecodevtabNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = bytecodevtabNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken,
  //                           &pCsr->iStart, &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_carrayNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = carrayNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                     &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_cidxNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = cidxNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                   &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_closureNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = closureNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken,
  //                      &pCsr->iStart, &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_completionNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = completionNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken,
  //                         &pCsr->iStart, &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_csvtabNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = csvtabNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                     &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_dbdataNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = dbdataNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                     &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_dbpageNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = dbpageNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                     &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_deltaparsevtabNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = deltaparsevtabNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken,
  //                             &pCsr->iStart, &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_echoNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = echoNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                   &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_expertNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = expertNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                     &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_explainNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = explainNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken,
  //                      &pCsr->iStart, &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_fsNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = fsNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                 &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_fsdirNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = fsdirNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                    &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_fstreeNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = fstreeNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                     &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_fts3NextMethod_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = fts3NextMethod(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken,
  //                         &pCsr->iStart, &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_fts3auxNextMethod_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = fts3auxNextMethod(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken,
  //                            &pCsr->iStart, &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_fts3termNextMethod_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = fts3termNextMethod(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken,
  //                             &pCsr->iStart, &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_fts3tokNextMethod_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = fts3tokNextMethod(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken,
  //                            &pCsr->iStart, &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_fuzzerNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = fuzzerNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                     &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_intarrayNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = intarrayNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken,
  //                       &pCsr->iStart, &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_jsonEachNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = jsonEachNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken,
  //                       &pCsr->iStart, &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_memstatNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = memstatNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken,
  //                      &pCsr->iStart, &pCsr->iEnd, &pCsr->iPos);
  //   }
  else
    if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_porterNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
      rc = porterNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
                      &pCsr->iEnd, &pCsr->iPos);
    }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_pragmaVtabNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = pragmaVtabNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken,
  //                         &pCsr->iStart, &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_prefixesNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = prefixesNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken,
  //                       &pCsr->iStart, &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_qpvtabNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = qpvtabNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                     &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_rtreeNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = rtreeNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                    &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_schemaNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = schemaNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                     &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_seriesNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = seriesNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                     &pCsr->iEnd, &pCsr->iPos);
  //   }
  else
    if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_simpleNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
      rc = simpleNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
                      &pCsr->iEnd, &pCsr->iPos);
    }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_spellfix1Next_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = spellfix1Next(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken,
  //                        &pCsr->iStart, &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_statNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = statNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                   &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_stmtNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = stmtNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                   &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_tclNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = tclNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                  &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_tclvarNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = tclvarNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                     &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_templatevtabNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = templatevtabNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken,
  //                           &pCsr->iStart, &pCsr->iEnd, &pCsr->iPos);
  //   }
  else
    if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_unicodeNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
      rc = unicodeNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken,
                       &pCsr->iStart, &pCsr->iEnd, &pCsr->iPos);
    }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_unionNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = unionNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                    &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_vlogNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = vlogNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken, &pCsr->iStart,
  //                   &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_vstattabNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = vstattabNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken,
  //                       &pCsr->iStart, &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_vtablogNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = vtablogNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken,
  //                      &pCsr->iStart, &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_wholenumberNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = wholenumberNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken,
  //                          &pCsr->iStart, &pCsr->iEnd, &pCsr->iPos);
  //   }
  // else
  //   if (memcmp(pTab->pMod->xNext_signature, xNext_signatures[xNext_zipfileNext_enum], sizeof(pTab->pMod->xNext_signature)) == 0) {
  //     rc = zipfileNext(pCsr->pCsr, &pCsr->zToken, &pCsr->nToken,
  //                      &pCsr->iStart, &pCsr->iEnd, &pCsr->iPos);
  //   }

  if( rc!=SQLITE_OK ){
    fts3tokResetCursor(pCsr);
    if( rc==SQLITE_DONE ) rc = SQLITE_OK;
  }

  return rc;
}

/*
** xFilter - Initialize a cursor to point at the start of its data.
*/
int fts3tokFilterMethod(
  sqlite3_vtab_cursor *pCursor,   /* The cursor used for this query */
  int idxNum,                     /* Strategy index */
  const char *idxStr,             /* Unused */
  int nVal,                       /* Number of elements in apVal */
  sqlite3_value **apVal           /* Arguments for the indexing scheme */
){
  int rc = SQLITE_ERROR;
  Fts3tokCursor *pCsr = (Fts3tokCursor *)pCursor;
  Fts3tokTable *pTab = (Fts3tokTable *)(pCursor->pVtab);
  UNUSED_PARAMETER(idxStr);
  UNUSED_PARAMETER(nVal);

  fts3tokResetCursor(pCsr);
  if( idxNum==1 ){
    const char *zByte = (const char *)sqlite3_value_text(apVal[0]);
    sqlite3_int64 nByte = sqlite3_value_bytes(apVal[0]);
    pCsr->zInput = sqlite3_malloc64(nByte+1);
    if( pCsr->zInput==0 ){
      rc = SQLITE_NOMEM;
    }else{
      if( nByte>0 ) memcpy(pCsr->zInput, zByte, nByte);
      pCsr->zInput[nByte] = 0;
      // if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_amatchOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //   rc = amatchOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      // }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_apndOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = apndOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_binfoOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = binfoOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_bytecodevtabOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = bytecodevtabOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_carrayOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = carrayOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_cidxOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = cidxOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_closureOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = closureOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_completionOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = completionOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_csvtabOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = csvtabOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_dbdataOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = dbdataOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_dbpageOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = dbpageOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_deltaparsevtabOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = deltaparsevtabOpen(pTab->pTok, pCsr->zInput, nByte,
      //                             &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_echoOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = echoOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_expertOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = expertOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_explainOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = explainOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_fsOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = fsOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_fsdirOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = fsdirOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_fstreeOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = fstreeOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_fts3OpenMethod_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = fts3OpenMethod(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_fts3auxOpenMethod_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = fts3auxOpenMethod(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_fts3termOpenMethod_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = fts3termOpenMethod(pTab->pTok, pCsr->zInput, nByte,
      //                             &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_fts3tokOpenMethod_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = fts3tokOpenMethod(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_fuzzerOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = fuzzerOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_intarrayOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = intarrayOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = jsonEachOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpenEach_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = jsonEachOpenEach(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_jsonEachOpenTree_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = jsonEachOpenTree(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_memdbOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = memdbOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_memstatOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = memstatOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
        if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_porterOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
          rc = porterOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
        }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_pragmaVtabOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = pragmaVtabOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_prefixesOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = prefixesOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_qpvtabOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = qpvtabOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_rtreeOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = rtreeOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_schemaOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = schemaOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_seriesOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = seriesOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      else
        if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_simpleOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
          rc = simpleOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
        }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_spellfix1Open_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = spellfix1Open(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_statOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = statOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_stmtOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = stmtOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_tclOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = tclOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_tclvarOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = tclvarOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_templatevtabOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = templatevtabOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      else
        if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_unicodeOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
          rc = unicodeOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
        }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_unionOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = unionOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_vfstraceOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = vfstraceOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_vstattabOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = vstattabOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_vtablogOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = vtablogOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_wholenumberOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = wholenumberOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_zipfileOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = zipfileOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      // else
      //   if (memcmp(pTab->pMod->xOpen_signature, xOpen_signatures[xOpen_unixOpen_enum], sizeof(pTab->pMod->xOpen_signature)) == 0) {
      //     rc = unixOpen(pTab->pTok, pCsr->zInput, nByte, &pCsr->pCsr);
      //   }
      if( rc==SQLITE_OK ){
        pCsr->pCsr->pTokenizer = pTab->pTok;
      }
    }
  }

  if( rc!=SQLITE_OK ) return rc;
  return fts3tokNextMethod(pCursor);
}

/*
** xEof - Return true if the cursor is at EOF, or false otherwise.
*/
int fts3tokEofMethod(sqlite3_vtab_cursor *pCursor){
  Fts3tokCursor *pCsr = (Fts3tokCursor *)pCursor;
  return (pCsr->zToken==0);
}

/*
** xColumn - Return a column value.
*/
int fts3tokColumnMethod(
  sqlite3_vtab_cursor *pCursor,   /* Cursor to retrieve value from */
  sqlite3_context *pCtx,          /* Context for sqlite3_result_xxx() calls */
  int iCol                        /* Index of column to read value from */
){
  Fts3tokCursor *pCsr = (Fts3tokCursor *)pCursor;

  /* CREATE TABLE x(input, token, start, end, position) */
  switch( iCol ){
    case 0:
      sqlite3_result_text(pCtx, pCsr->zInput, -1, SQLITE_TRANSIENT);
      break;
    case 1:
      sqlite3_result_text(pCtx, pCsr->zToken, pCsr->nToken, SQLITE_TRANSIENT);
      break;
    case 2:
      sqlite3_result_int(pCtx, pCsr->iStart);
      break;
    case 3:
      sqlite3_result_int(pCtx, pCsr->iEnd);
      break;
    default:
      assert( iCol==4 );
      sqlite3_result_int(pCtx, pCsr->iPos);
      break;
  }
  return SQLITE_OK;
}

/*
** xRowid - Return the current rowid for the cursor.
*/
int fts3tokRowidMethod(
  sqlite3_vtab_cursor *pCursor,   /* Cursor to retrieve value from */
  sqlite_int64 *pRowid            /* OUT: Rowid value */
){
  Fts3tokCursor *pCsr = (Fts3tokCursor *)pCursor;
  *pRowid = (sqlite3_int64)pCsr->iRowid;
  return SQLITE_OK;
}

/*
** Register the fts3tok module with database connection db. Return SQLITE_OK
** if successful or an error code if sqlite3_create_module() fails.
*/
int sqlite3Fts3InitTok(sqlite3 *db, Fts3Hash *pHash, void(*xDestroy)(void*)){
  static const sqlite3_module fts3tok_module = {
     0,                           /* iVersion      */
     fts3tokConnectMethod,        /* xCreate       */
     fts3tokConnectMethod,        /* xConnect      */
     fts3tokBestIndexMethod,      /* xBestIndex    */
     fts3tokDisconnectMethod,     /* xDisconnect   */
     fts3tokDisconnectMethod,     /* xDestroy      */
     fts3tokOpenMethod,           /* xOpen         */
     fts3tokCloseMethod,          /* xClose        */
     fts3tokFilterMethod,         /* xFilter       */
     fts3tokNextMethod,           /* xNext         */
     fts3tokEofMethod,            /* xEof          */
     fts3tokColumnMethod,         /* xColumn       */
     fts3tokRowidMethod,          /* xRowid        */
     0,                           /* xUpdate       */
     0,                           /* xBegin        */
     0,                           /* xSync         */
     0,                           /* xCommit       */
     0,                           /* xRollback     */
     0,                           /* xFindFunction */
     0,                           /* xRename       */
     0,                           /* xSavepoint    */
     0,                           /* xRelease      */
     0,                           /* xRollbackTo   */
     0,                           /* xShadowName   */
     0                            /* xIntegrity    */
  ,
  .xCreate_signature = xCreate_signatures[xCreate_fts3tokConnectMethod_enum],
  .xConnect_signature = xConnect_signatures[xConnect_fts3tokConnectMethod_enum],
  .xBestIndex_signature = xBestIndex_signatures[xBestIndex_fts3tokBestIndexMethod_enum],
  .xDisconnect_signature = xDisconnect_signatures[xDisconnect_fts3tokDisconnectMethod_enum],
  .xDestroy_signature = xDestroy_signatures[xDestroy_fts3tokDisconnectMethod_enum],
  .xOpen_signature = xOpen_signatures[xOpen_fts3tokOpenMethod_enum],
  .xClose_signature = xClose_signatures[xClose_fts3tokCloseMethod_enum],
  .xFilter_signature = xFilter_signatures[xFilter_fts3tokFilterMethod_enum],
  .xNext_signature = xNext_signatures[xNext_fts3tokNextMethod_enum],
  .xEof_signature = xEof_signatures[xEof_fts3tokEofMethod_enum],
  .xColumn_signature = xColumn_signatures[xColumn_fts3tokColumnMethod_enum],
  .xRowid_signature = xRowid_signatures[xRowid_fts3tokRowidMethod_enum]
};
  int rc;                         /* Return code */

  rc = sqlite3_create_module_v2(
      db, "fts3tokenize", &fts3tok_module, (void*)pHash, xDestroy
  );
  return rc;
}

#endif /* !defined(SQLITE_CORE) || defined(SQLITE_ENABLE_FTS3) */
