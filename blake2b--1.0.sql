-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION blake2b" to load this file. \quit

CREATE FUNCTION blake2b(data bytea, digest_size integer DEFAULT NULL, key bytea DEFAULT NULL)
RETURNS bytea
AS 'MODULE_PATHNAME', 'pg_blake2b'
LANGUAGE C IMMUTABLE PARALLEL SAFE;

CREATE FUNCTION blake2b(data text, digest_size integer DEFAULT NULL, key bytea DEFAULT NULL)
RETURNS bytea
AS 'MODULE_PATHNAME', 'pg_blake2b'
LANGUAGE C IMMUTABLE PARALLEL SAFE;
