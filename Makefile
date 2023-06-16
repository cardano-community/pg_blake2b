EXTENSION = blake2b
MODULE_big = blake2b
DATA = blake2b--1.0.sql
OBJS = pg_blake2b.o
REGRESS = blake2b-test
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
