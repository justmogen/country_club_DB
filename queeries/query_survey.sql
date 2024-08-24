INSERT INTO feed_survey.surveys (survey_name, description) VALUES
('Facility Satisfaction Survey', 'Survey to gather feedback on facility satisfaction'),
('Member Experience Survey', 'Survey to evaluate overall member experience');

INSERT INTO feed_survey.survey_responses (survey_id, member_id, response_date, rating, comments) VALUES
(1, 9, '2023-08-14', 4, 'The tennis courts are well maintained.'),
(1, 15, '2023-08-14', 5, 'I love the swimming pool!'),
(2, 9, '2023-08-15', 3, 'The gym could use more equipment.'),
(2, 12, '2023-08-15', 4, 'Great experience overall.'),
(2, 16, '2023-08-16', 5, 'I highly recommend the club to others.')
;

SELECT * FROM feed_survey.survey_responses;