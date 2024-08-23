CREATE SCHEMA audit;

CREATE TABLE audit.audit_logs (
    audit_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    table_name VARCHAR(50),
    operation_type VARCHAR(20),
    old_data JSONB,
    new_data JSONB,
    changed_by VARCHAR(50),
    changed_at TIMESTAMP DEFAULT NOW()
);


-- Trigger to log changes to members table
CREATE OR REPLACE FUNCTION audit.audit_member_changes()
RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO audit.audit_logs (table_name, operation_type, old_data, new_data, changed_by)
    VALUES ('members', TG_OP, ROW_TO_JSON(OLD), ROW_TO_JSON(NEW), SESSION_USER);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_audit_member_changes
AFTER INSERT OR UPDATE OR DELETE ON cd.members
FOR EACH ROW
EXECUTE FUNCTION audit.audit_member_changes();