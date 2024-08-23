INSERT INTO memb_payment.membership_types (type_name, description, monthly_fee, annual_fee)
VALUES ('Regular', 'Standard membership with access to basic facilities', 50.00, 500.00),
       ('Premium', 'Premium membership with access to all facilities', 100.00, 1000.00),
       ('VIP', 'VIP membership with exclusive benefits and priority booking', 200.00, 2000.00);


-- ADDRESSES OF MEMBERS


-- NEW MEMBERS
WITH inserted_address AS (
        INSERT INTO cd.addresses(street, city, state, zipcode, country)
        VALUES ('Utange', 'Mombasa', 'Shanzu', '90200', 'Kenya')
        RETURNING address_id
),
inserted_phone AS (
        INSERT INTO cd.phones(phone_number, phone_type)
        VALUES ('254-708-483-440', 'Home')
        RETURNING phone_id
)
INSERT INTO cd.members (surname, firstname, address_id, phone_id, email, recommendedby, joindate, membership_status, membership_type_id)
VALUES ('Kim', 
        'Bruno', 
        (SELECT address_id FROM inserted_address),
        (SELECT phone_id FROM inserted_phone),
        'Kim2@gmail.com',
        9,
        '2024-08-23',
        'Active',
        3
);


UPDATE cd.members
SET membership_status = 'Suspended'
WHERE memid = 9;

-- CREATE VIEW cd.member_full_details AS
SELECT
    m.surname,
    m.firstname,
    a.street,
    a.state,
    p.phone_number AS phone,
    m.email,
    m.joindate,
    m.membership_status,
    t.type_name,
    m.recommendedby
FROM cd.members m
JOIN cd.phones p
ON m.phone_id = p.phone_id
JOIN cd.addresses a
ON m.address_id = a.address_id
JOIN memb_payment.membership_types t
ON m.membership_type_id = t.type_id;
-- WHERE m.email = 'justm@gmail.com';

-- SELECT * FROM cd.member_full_details WHERE email = 'justmogen@gmail.com';



-- SELECT address_id
 -- FROM cd.addresses
-- WHERE street IN ('St Mary');
-- DELETE FROM cd.members WHERE memid=1;

-- SELECT *
-- FROM cd.members ;


-- ALTER TABLE cd.members DROP CONSTRAINT fk_members_membership_type;  -- Drop existing FK

-- ALTER TABLE cd.members
-- ADD COLUMN membership_type_name VARCHAR(50);  -- Add the new column

-- ALTER TABLE cd.members
-- ADD CONSTRAINT fk_members_membership_type_name FOREIGN KEY (membership_type_name)
-- REFERENCES memb_payment.membership_types (type_name)
-- ON UPDATE NO ACTION
-- ON DELETE NO ACTION;  -- Set up the new FK
