-- Membership types

CREATE SCHEMA memb_payment

CREATE TABLE memb_payment.membership_types (
    type_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type_name VARCHAR(30) NOT NULL UNIQUE,
    description TEXT,
    monthly_fee NUMERIC(10, 2) NOT NULL,
    annual_fee NUMERIC(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);


ALTER TABLE cd.members
ADD COLUMN membership_type_id INT NOT NULL,
ADD CONSTRAINT fk_members_membership_type FOREIGN KEY (membership_type_id) REFERENCES
    memb_payment.membership_types(type_id)



-- Billing & Payments

CREATE TABLE memb_payment.payments (
    payment_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    member_id INT NOT NULL,
    amount NUMERIC(10, 2) NOT NULL,
    payment_date TIMESTAMP NOT NULL,  --'YYYY-MM-DD HH:MM:SS'
    payment_method VARCHAR(20) NOT NULL CHECK(payment_method IN('Credit Card', 'Mpesa', 'Cash')),
    reference_no VARCHAR(50),
    CONSTRAINT fk_payments_member FOREIGN KEY (member_id) REFERENCES cd.members(memid)
);


CREATE TABLE memb_payment.billing (
    bill_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    member_id INT NOT NULL,
    billing_period_start DATE NOT NULL,  --YYYY-MM-DD
    billing_period_end DATE NOT NULL,
    amount_due NUMERIC(10, 2) NOT NULL,
    amount_paid NUMERIC(10, 2),
    due_date DATE NOT NULL,
    payment_status VARCHAR(20) NOT NULL CHECK(payment_status IN('Pending', 'Paid', 'Overdue')),
    CONSTRAINT fk_billing_member FOREIGN KEY (member_id) REFERENCES cd.members(memid)
);
