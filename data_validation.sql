ALTER TABLE cd.phones
ADD CONSTRAINT chk_telephone_format CHECK(phone_number ~ '^\+\d{1,3}-\d{1,14}$');