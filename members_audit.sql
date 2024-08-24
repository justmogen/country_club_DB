CREATE TABLE cd.members_audit (
    audit_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    memid integer NOT NULL,
    action character varying(10) NOT NULL,
    action_time timestamp NOT NULL DEFAULT now(),
    old_surname character varying(50),
    new_surname character varying(50),
    old_firstname character varying(50),
    new_firstname character varying(50),
    old_address character varying(50),
    new_address character varying(100),
    old_zipcode integer,
    new_zipcode integer,
    old_telephone character varying(20),
    new_telephone character varying(20),
    old_recommendedby integer,
    new_recommendedby integer,
    old_joindate timestamp,
    new_joindate timestamp
);

CREATE OR REPLACE FUNCTION audit_members()
RETURNS TRIGGER AS
$$
BEGIN
    IF (TG_OP = 'UPDATE') THEN
        INSERT INTO cd.members_audit(memid, action, old_surname, new_surname, old_firstname, new_firstname, 
                                        old_address, new_address, old_zipcode, new_zipcode, old_telephone, new_telephone, 
                                        old_recommendedby, new_recommendedby, old_joindate, new_joindate)
        VALUES (OLD.memid, 'UPDATE', OLD.surname, NEW.surname, OLD.firstname, NEW.firstname, 
                    OLD.address, NEW.address, OLD.zipcode, NEW.zipcode, OLD.telephone, NEW.telephone, 
                    OLD.recommendedby, NEW.recommendedby, OLD.joindate, NEW.joindate);
    ELSEIF (TG_OP = 'DELETE') THEN
        INSERT INTO cd.members_audit (memid, action, old_surname, old_firstname, old_address, old_zipcode, 
                                        old_telephone, old_recommendedby, old_joindate)
        VALUES (OLD.memid, 'DELETE', OLD.surname, OLD.firstname, OLD.address, OLD.zipcode, 
                OLD.telephone, OLD.recommendedby, OLD.joindate);
    END IF;
    RETURN NEW;

END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_audit_members
AFTER UPDATE OR DELETE ON cd.members
FOR EACH ROW EXECUTE FUNCTION audit_members();