SELECT nspname 
FROM pg_catalog.pg_namespace 
WHERE nspname = 'memb_payment';

SELECT * 
FROM information_schema.tables 
WHERE table_schema = 'cd' AND table_name = 'members';

SELECT * 
FROM information_schema.tables 
WHERE table_schema = 'memb_payment' AND table_name = 'billing';