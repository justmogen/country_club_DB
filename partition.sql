-- If the dataset grows significantly, consider partitioning large tables, such as facility_usage 
-- or billing, by date to improve performance.

-- Example partitioning facility usage by year


-- CREATE TABLE cd.facility_usage_2024 PARTITION OF cd.facility_usage
-- FOR VALUES FROM ('2024-01-01') TO ('2024-12-31');
-- Create the master table
CREATE TABLE cd.bookings_master (
    bookid GENERATE ALWAYS AS IDENTITY PRIMARY KEY,
    facid integer NOT NULL,
    memid integer NOT NULL,
    starttime timestamp NOT NULL,
    slots integer NOT NULL
) PARTITION BY RANGE (starttime);

-- Create partitions for different years
CREATE TABLE cd.bookings_2023 PARTITION OF cd.bookings_master
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');
    
CREATE TABLE cd.bookings_2024 PARTITION OF cd.bookings_master
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');
