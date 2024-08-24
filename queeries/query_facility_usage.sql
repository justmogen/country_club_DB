INSERT INTO cd.facility_usage (facility_id, member_id, usage_date, duration, usage_type) VALUES
(14, 9, '2023-08-10 09:00:00', '1 hour', 'Booking'),
(18, 16, '2023-08-10 10:00:00', '2 hours', 'Booking'),
(15, 12, '2023-08-11 15:00:00', '3 hours', 'Booking'),
(16, 15, '2023-08-12 12:00:00', '1 hour', 'Booking'),
(17, 9, '2023-08-13 14:00:00', '1.5 hours', 'Booking');

SELECT
    f.name,
    m.surname,
    m.firstname,
    fu.usage_date,
    fu.usage_type

FROM cd.facility_usage fu
JOIN cd.facilities f
ON
    fu.facility_id = f.facid
JOIN cd.members m
ON
    m.memid = fu.member_id
;

