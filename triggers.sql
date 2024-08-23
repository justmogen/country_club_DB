-- Triggers are automatic actions executed when certain events occur in the database 

-- Trigger to update the updated_at timestamp on members table
CREATE OR REPLACE FUNCTION cd.update_member_timestamp()
RETURNS TRIGGER AS
$$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_update_member_timestamp
BEFORE UPDATE ON cd.members
FOR EACH ROW
EXECUTE FUNCTION cd.update_member_timestamp();



-- Trigger to automatically move overdue bills to a different table for archival
CREATE OR REPLACE FUNCTION memb_payment.archive_overdue_bills()
RETURNS TRIGGER AS
$$
BEGIN
    IF (NEW.payment_status = 'Overdue') THEN
        INSERT INTO memb_payment.archived_bills (member_id, bill_id, amount_due, due_date, archived_at)
        VALUES (NEW.member_id, NEW.bill_id, NEW.amount_due, NEW.due_date, NOW());
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_archive_overdue_bills
AFTER UPDATE ON memb_payment.billing
FOR EACH ROW
WHEN (NEW.payment_status = 'Overdue')
EXECUTE FUNCTION memb_payment.archive_overdue_bills();




-- DROP TRIGGER IF EXISTS trg_update_member_timestamp ON cd.members;
-- DROP TRIGGER IF EXISTS trg_archive_overdue_bills ON memb_payment.billing;

-- DROP FUNCTION IF EXISTS public.update_member_timestamp();
-- DROP FUNCTION IF EXISTS public.archive_overdue_bills();