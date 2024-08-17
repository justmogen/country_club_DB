-- If the dataset grows significantly, consider partitioning large tables, such as facility_usage 
-- or billing, by date to improve performance.

-- Example partitioning facility usage by year


-- CREATE TABLE cd.facility_usage_2024 PARTITION OF cd.facility_usage
-- FOR VALUES FROM ('2024-01-01') TO ('2024-12-31');
