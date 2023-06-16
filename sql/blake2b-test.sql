--
-- BLAKE2B family
--
CREATE EXTENSION blake2b;

-- BLAKE2B_224
SELECT encode(blake2b('', 28), 'hex');
SELECT encode(blake2b(''::bytea, 28), 'hex');
SELECT encode(blake2b('\x'::bytea, 28), 'hex');
SELECT encode(blake2b('\x', 28), 'hex');
SELECT encode(blake2b('33', 28), 'hex');
SELECT encode(blake2b('\x3333'::bytea, 28), 'hex');
SELECT encode(blake2b('3333', 28), 'hex');
SELECT encode(blake2b('28 bytes digest with key', 28, '\x0123456789'::bytea), 'hex');

-- BLAKE2B_256
SELECT encode(blake2b('', 32), 'hex');
SELECT encode(blake2b(''::bytea, 32), 'hex');
SELECT encode(blake2b('\x'::bytea, 32), 'hex');
SELECT encode(blake2b('\x', 32), 'hex');
SELECT encode(blake2b('33', 32), 'hex');
SELECT encode(blake2b('\x3333'::bytea, 32), 'hex');
SELECT encode(blake2b('3333', 32), 'hex');
SELECT encode(blake2b('32 bytes digest with key', 32, '\x0123456789'::bytea), 'hex');

-- BLAKE2B_384
SELECT encode(blake2b('', 48), 'hex');
SELECT encode(blake2b(''::bytea, 48), 'hex');
SELECT encode(blake2b('\x'::bytea, 48), 'hex');
SELECT encode(blake2b('\x', 48), 'hex');
SELECT encode(blake2b('33', 48), 'hex');
SELECT encode(blake2b('\x3333'::bytea, 48), 'hex');
SELECT encode(blake2b('3333', 48), 'hex');
SELECT encode(blake2b('48 bytes digest with key', 48, '\x0123456789'::bytea), 'hex');

-- BLAKE2B_512
SELECT encode(blake2b(''), 'hex');
SELECT encode(blake2b('', 64), 'hex');
SELECT encode(blake2b(''::bytea, 64), 'hex');
SELECT encode(blake2b('\x'::bytea, 64), 'hex');
SELECT encode(blake2b('\x', 64), 'hex');
SELECT encode(blake2b('33', 64), 'hex');
SELECT encode(blake2b('\x3333'::bytea, 64), 'hex');
SELECT encode(blake2b('3333', 64), 'hex');
SELECT encode(blake2b('64 bytes digest with key', 64, '\x0123456789'::bytea), 'hex');
