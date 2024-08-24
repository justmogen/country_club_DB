-- DROP DATABASE IF EXISTS countryclub WITH (FORCE);

-- REASSIGN OWNED BY target_role TO new_owner;
-- DROP OWNED BY [name]; --drops owned objects

-- Create a role for regular users who only need read access
CREATE ROLE bourne NOINHERIT;
GRANT CONNECT ON DATABASE countryclub TO bourne;
GRANT USAGE ON SCHEMA cd TO bourne;
GRANT SELECT ON ALL TABLES IN SCHEMA cd TO bourne;

-- Create a role for admins with full access
CREATE ROLE club_admin NOINHERIT;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA cd TO club_admin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA cd TO club_admin;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA cd TO club_admin;
