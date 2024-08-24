INSERT INTO cd.facility_categories (category_name)
VALUES ('Aquatic'),
       ('Sports'),
       ('Fitness'),
       ('Wellness'),
       ('Event'),
       ('Entertainment');


INSERT INTO cd.operational_hours(open_time, close_time, days_open)
VALUES ('05:00+03', '20:00+03', 'Monday-Sunday'),--0800hrs - 2300hrs
('05:00+03', '20:00+03', 'Saturday-Sunday'),--0800hrs - 2300hrs
('05:00+03', '15:00+03', 'Monday-Friday'), -- 0800 am - 1800hrs
('01:00+03', '21:00+03', 'Monday-Sunday'); -- For gym

WITH inserted_phone AS (
    INSERT INTO cd.phones(phone_number, phone_type)
    VALUES 
        ('254-722-029-769', 'Mobile'),
        ('254-722-029-769', 'Work'),
        ('254-722-029-769', 'Home'),
        ('254-722-029-769', 'Mobile')
    RETURNING phone_id
)
INSERT INTO cd.staff(firstname, lastname, role, phone_id, email, hire_date)
    VALUES
        ('Raphael', 'Omondi', 'Facility Manager', (SELECT phone_id FROM inserted_phone LIMIT 1 OFFSET 0), 'raphaomosh@gmail.com', '2024-08-24'),
        ('John', 'Kamau', 'Gym Instructor', (SELECT phone_id FROM inserted_phone LIMIT 1 OFFSET 1), 'kamaujohn@gmail.com', '2024-08-24'),
        ('Lisa', 'Ayako', 'Swimming Coach', (SELECT phone_id FROM inserted_phone LIMIT 1 OFFSET 2), 'ayakolisa@outlook.com', '2024-08-24'),
        ('Tutu', 'Frol', 'Receptionist', (SELECT phone_id FROM inserted_phone LIMIT 1 OFFSET 3), 'tut.frol@gmail.com', '2024-08-24')
;


INSERT INTO cd.facilities (name, category_id, membercost, guestcost, initialoutlay, monthlymaintenance, operational_hours_id, staff_id)
    VALUES 
        ('Tennis Court 1', 2, 500.00, 20.00, 1000.00, 200.00, 2, 1),
        ('Tennis Court 2', 2, 500.00, 20.00, 1000.00, 200.00, 2, 1),
        ('Swimming Pool', 1, 100.00, 25.00, 2000.00, 500.00, 3, 3),
        ('Gym', 3, 150.00, 30.00, 3000.00, 3000.00, 4, 2),
        ('Sauna', 4, 700.00, 15.00, 6500.00, 150.00, 1, 4)
;

CREATE VIEW cd.facility_full_details AS
SELECT
    f.name,
    c.category_name,
    f.membercost,
    f.guestcost,
    f.initialoutlay,
    f.monthlymaintenance AS monthly_fee,
    o.open_time,
    o.close_time,
    o.days_open,
    s.firstname,
    s.role

FROM cd.facilities f
JOIN cd.facility_categories c
    ON f.category_id = c.category_id
JOIN cd.operational_hours o
    ON f.operational_hours_id = o.operational_hours_id
JOIN cd.staff s
    ON f.staff_id = s.staff_id
;

SELECT * FROM cd.facility_full_details;



-- ALTER TABLE cd.operational_hours
--     ALTER COLUMN open_time TYPE time with time zone,
--     ALTER COLUMN close_time TYPE time with time ZONE
-- ;
 -- UPDATE cd.operational_hours
-- SET open_time = open_time AT TIME ZONE 'UTC' AT TIME ZONE 'UTC+3',
--     close_time = close_time AT TIME ZONE 'UTC' AT TIME ZONE 'UTC+3';
