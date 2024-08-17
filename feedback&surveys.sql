-- Feedback and Surveys from members

CREATE SCHEMA feed_survey;

CREATE TABLE feed_survey.surveys (
    survey_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    survey_name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);


CREATE TABLE feed_survey.survey_responses (
    response_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    survey_id INT NOT NULL,
    member_id INT NOT NULL,
    response_date TIMESTAMP NOT NULL,
    rating INT NOT NULL CHECK(rating >= 1 AND rating <= 5),
    comments TEXT,
    CONSTRAINT fk_survey_responses_survey FOREIGN KEY (survey_id) REFERENCES
        feed_survey.surveys(survey_id),
    CONSTRAINT fk_survey_responses_member FOREIGN KEY (member_id) REFERENCES
        cd.members(memid)
);

