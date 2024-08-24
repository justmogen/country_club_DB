INSERT INTO book.bookings (facid, memid, starttime, slots) VALUES
(17, 12, '2023-08-10 09:00:00', 2), -- booked Tennis Court 1 for 1 hour
(16, 15, '2023-08-10 10:00:00', 4), -- booked Tennis Court 2 for 2 hours
(18, 16, '2023-08-11 15:00:00', 6), -- booked Swimming Pool for 3 hours
(14, 9, '2023-08-12 12:00:00', 2), -- booked Gym for 1 hour
(15, 12, '2023-08-13 14:00:00', 3) -- booked Sauna for 1.5 hours
;

CREATE VIEW book.v_booked_members_details AS
SELECT
    f.name,
    m.surname,
    m.firstname,
    m.email,
    b.starttime,
    b.slots

FROM book.bookings b
JOIN cd.facilities f
    ON b.facid = f.facid
JOIN cd.members m
    ON b.memid = m.memid
;

SELECT * FROM book.v_booked_members_details;