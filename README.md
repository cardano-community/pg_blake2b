# pg_blake2b
PostgreSQL extension for fast secure hashing

## About
The extension provides BLAKE2b cryptographic hash function for [PostgreSQL](https://www.postgresql.org/) using original C implementations of [BLAKE2b](https://github.com/BLAKE2/BLAKE2), optimized for speed on CPUs supporting SSE2, SSSE3, SSE4.1, AVX, or XOP

## Install

Before you begin the install, you may also need to install the '-dev' PostgreSQL packages to build the extension (replace [XX] with your already installed PostgreSQL versionL: 14, 15, 16, etc):

```
sudo apt update
sudo apt install postgresql-server-dev-XX
```

Build and install pg_blake2b:

```
cd /path/to/pg_blake2b
make
sudo make install
```

Run tests:

```
make installcheck
```

Enable extension:

```
CREATE EXTENSION blake2b;
```

## Uninstall

Disable extension:

```
DROP EXTENSION blake2b;
```

Uninstall pg_blake2b:

```
cd /path/to/pg_blake2b
sudo make uninstall
```
## Usage

Extension method is defined as function with 3 parameters. The first parameter specifies the data (string or bytea) for hashing, the second parameter is optional length of the hash in bytes (integer from 1 to 64, 64 by default), and the third parameter specifies the optional key (bytea, max 64 bytes):

```
blake2b(
    data bytea,
    digest_size integer DEFAULT NULL,
    key bytea DEFAULT NULL
)

blake2b(
    data text,
    digest_size integer DEFAULT NULL,
    key bytea DEFAULT NULL
)
```

Example:

```
SELECT encode(blake2b('33', 32), 'hex');
                              encode                              
------------------------------------------------------------------
 ef97c9e36f5e33370c795599501e8f834363461eb001fd227831992c57b5bedf
(1 row)

SELECT encode(blake2b('\x3333'::bytea, 32), 'hex');
                              encode                              
------------------------------------------------------------------
 ef97c9e36f5e33370c795599501e8f834363461eb001fd227831992c57b5bedf
(1 row)

SELECT encode(blake2b('3333', 32), 'hex');
                              encode                              
------------------------------------------------------------------
 f4395a05f95dbb8a628c7be3eb5cbcde9393d90fd44837ab390c027daecc6c33
(1 row)

SELECT encode(blake2b('3333', 32, '\x0123456789'::bytea), 'hex');
                              encode                              
------------------------------------------------------------------
 912bf54103cb9d1093c3e736514040fd6a7ea75d094c8ce843425a4791571b82
(1 row)
```

Hash function speed:

```
EXPLAIN ANALYZE SELECT i, blake2b(i::text) FROM generate_series(1, 1000000) i;
                                                             QUERY PLAN
------------------------------------------------------------------------------------------------------------------------------------
 Function Scan on generate_series i  (cost=0.00..17500.00 rows=1000000 width=36) (actual time=70.494..466.290 rows=1000000 loops=1)
 Planning Time: 0.036 ms
 Execution Time: 494.046 ms
(3 rows)
```
