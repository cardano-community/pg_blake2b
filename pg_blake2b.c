#include "postgres.h"
#include "fmgr.h"
#include "funcapi.h"
#include "blake2b.c"

PG_MODULE_MAGIC;

PG_FUNCTION_INFO_V1(pg_blake2b);

Datum
pg_blake2b(PG_FUNCTION_ARGS)
{
    uint8_t *hash;

    bytea   *data;
    bytea   *digest;
    bytea   *key = palloc(VARHDRSZ);

    size_t  datalen;
    size_t  keylen = 0;

    int16   digest_size = BLAKE2B_OUTBYTES;

    if (PG_ARGISNULL(0))
    {
        PG_RETURN_NULL();
    }

    data = PG_GETARG_BYTEA_PP(0);
    datalen = VARSIZE_ANY_EXHDR(data);

    if (!PG_ARGISNULL(1))
    {
        digest_size = PG_GETARG_INT16(1);
        if (digest_size < 1 || digest_size > BLAKE2B_OUTBYTES)
        {
            ereport(ERROR,
                (
                 errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                 errmsg("Digest size is out of range"),
                 errdetail("Value %d must be between 1 and %d", digest_size, BLAKE2B_OUTBYTES),
                 errhint("Change the digest size")
                )
            );
        }
    }

    if (!PG_ARGISNULL(2))
    {
        key = PG_GETARG_BYTEA_PP(2);
        keylen = VARSIZE_ANY_EXHDR(key);
        if (keylen > BLAKE2B_KEYBYTES)
        {
            ereport(ERROR,
                (
                 errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                 errmsg("Key is too long"),
                 errdetail("Key length must be less than or equal to %d", BLAKE2B_KEYBYTES),
                 errhint("Change the key")
                )
            );
        }
    }

    hash = palloc(digest_size);
    
    blake2b(hash, digest_size, (uint8_t *) VARDATA_ANY(data), datalen, (uint8_t *) VARDATA_ANY(key), keylen);

    digest = palloc(VARHDRSZ + digest_size);
    SET_VARSIZE(digest, VARHDRSZ + digest_size);
    memcpy(VARDATA(digest), hash, digest_size);

    PG_FREE_IF_COPY(data, 0);
    PG_FREE_IF_COPY(key, 2);
    
    PG_RETURN_BYTEA_P(digest);
}
