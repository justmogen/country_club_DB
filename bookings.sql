CREATE SCHEMA book;

CREATE TABLE book.bookings
(
    bookid INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    facid INT NOT NULL, 
    memid INT NOT NULL, 
    starttime TIMESTAMP NOT NULL,
    slots INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_bookings_facid FOREIGN KEY (facid) REFERENCES cd.facilities(facid),
    CONSTRAINT fk_bookings_memid FOREIGN KEY (memid) REFERENCES cd.members(memid),
    CONSTRAINT chk_slots CHECK (slots > 0 AND slots <= 48)
);

CREATE TABLE book.coaching_sessions
(
    session_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    member_id INT NOT NULL,
    coach_id INT NOT NULL,
    facility_id INT NOT NULL,
    session_time TIMESTAMP NOT NULL,
    duration INTERVAL NOT NULL,
    fee NUMERIC(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_coaching_sessions_member FOREIGN KEY (member_id) REFERENCES cd.members(memid),
    CONSTRAINT fk_coaching_sessions_coach FOREIGN KEY (coach_id) REFERENCES cd.staff(staff_id),
    CONSTRAINT fk_coaching_sessions_facility FOREIGN KEY (facility_id) REFERENCES cd.facilities(facid)
);

CREATE TABLE book.special_events
(
    event_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    event_name VARCHAR(50) NOT NULL,
    facility_id INT NOT NULL,
    event_date TIMESTAMP NOT NULL,
    organizer_id INT NOT NULL,
    budget NUMERIC(10, 2),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_special_events_facility FOREIGN KEY (facility_id) REFERENCES cd.facilities(facid),
    CONSTRAINT fk_special_events_organizer FOREIGN KEY (organizer_id) REFERENCES cd.staff(staff_id)
);


