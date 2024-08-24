-- query performance on frequently used WHERE & JOIN clauses

-- DROP INDEX cd.idx_members_lastname;
CREATE INDEX idx_members ON cd.members(surname, firstname);

-- Index on membership type for faster grouping or filtering by membership type
CREATE INDEX idx_members_membership_type ON cd.members(membership_type_id);

-- Index on facility usage date for performance optimization in reports
CREATE INDEX idx_facility_usage_date ON cd.facility_usage(usage_date);

-- ...payments by date or member
CREATE INDEX idx_payments_date_member ON memb_payment.payments(payment_date, member_id);

-- Index on billing due dates to quickly find overdue bills
CREATE INDEX idx_billing_due_date ON memb_payment.billing(due_date);

CREATE INDEX idx_facilities_name ON cd.facilities (name);


SELECT 
    tablename,
    indexname,
    indexdef
FROM 
    pg_indexes
WHERE 
    schemaname = 'cd'
ORDER BY 
    tablename, indexname;