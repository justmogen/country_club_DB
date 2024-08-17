-- Views allow you to create virtual tables that represent the result of a query

-- View to summarize facility usage by member
CREATE VIEW cd.v_member_facility_usage AS
SELECT
    m.memid,
    m.firstname || ' ' || m.surname AS member_name,
    f.name AS facility_name,
    COUNT(u.usage_id) AS total_usage,
    SUM(u.duration) AS total_duration
FROM
    cd.members m
    JOIN cd.facility_usage u ON m.memid = u.member_id
    JOIN cd.facilities f ON u.facility_id = f.facid
GROUP BY
    m.memid, m.firstname, m.surname, f.name;


-- View to calculate the total revenue generated from bookings
CREATE VIEW cd.v_member_facility_revenue AS
SELECT
    f.facid,
    f.name AS facility_name,
    SUM(b.slots * membercost) AS total_revenue
FROM
    cd.facilities f
    JOIN book.bookings b ON f.facid = b.facid
GROUP BY
    f.facid, f.name;


-- View to list members with overdue bills
CREATE VIEW memb_payment.v_overdue_bills AS
SELECT
    m.memid,
    m.firstname || ' ' || m.surname AS member_name,
    b.amount_due,
    b.due_date,
    (b.amount_due - COALESCE(b.amount_paid, 0)) AS amount_outstanding
FROM
    cd.members m
    JOIN memb_payment.billing b ON m.memid = b.member_id
WHERE
    b.payment_status = 'Overdue';
