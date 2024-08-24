-- Set up autovacuum for the database
SHOW autovacuum;

ALTER DATABASE country_club SET autovacuum = 'on';
ALTER TABLE cd.bookings SET (
    autovacuum_vacuum_scale_factor = 0.1,
    autovacuum_analyze_scale_factor = 0.05
);
