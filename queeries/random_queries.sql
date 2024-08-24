SELECT *
FROM information_schema.tables
WHERE table_schema = 'cd'
    AND table_name = 'members';


SELECT *
FROM information_schema.tables
WHERE table_schema = 'memb_payment'
    AND table_name = 'billing';


-- TABLE(COLUMNS) METADATA

SELECT column_name,
       data_type,
       is_nullable,
       column_default
FROM information_schema.columns
WHERE table_schema = 'cd'
    AND table_name = 'facilities';


-- TABLE(CONSTRAINTS) METADATA

SELECT constraint_name,
       constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'cd'
    AND table_name = 'facility';


-- TABLE METADATA (FOREIGN KEY CONTARINTS)
SELECT tc.constraint_name,
       kcu.column_name,
       ccu.table_name AS foreign_table_name,
       ccu.column_name AS foreign_column_name
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_name = tc.constraint_name
WHERE constraint_type = 'FOREIGN KEY'
    AND tc.table_name = 'facilities'
    AND tc.table_schema = 'cd';


-- AUDIT
SELECT * FROM audit.audit_logs;






-- ALTER TABLE cd.members
-- ALTER COLUMN phone_id TYPE VARCHAR(15);