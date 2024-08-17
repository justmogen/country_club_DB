-- facility usage tracking

CREATE TABLE cd.facility_usage (
    usage_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    facility_id INT NOT NULL,
    member_id INT NOT NULL,
    usage_date TIMESTAMP NOT NULL,
    duration INTERVAL NOT NULL,
    usage_type VARCHAR(20) NOT NULL CHECK(usage_type IN('Booking', 'Walk-in', 'Event')),
    CONSTRAINT fk_facility_usage_facility FOREIGN KEY (facility_id) REFERENCES
        cd.facilities(facid),
    CONSTRAINT fk_facility_usage_member FOREIGN KEY (member_id) REFERENCES
        cd.members(memid)
);