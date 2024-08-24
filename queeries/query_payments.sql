INSERT INTO memb_payment.payments (member_id, payment_date, amount, payment_method, reference_no) VALUES
(9, '2024-08-24', 5000.00, 'Credit Card', 'REF123456'),
(16, '2024-08-24', 1000.00, 'Mpesa', 'REF234567'),
(12, '2024-08-22', 2000.00, 'Credit Card', 'REF345678'),
(15, '2024-08-23', 5000.00, 'Cash', 'REF456789'),
(9, '2024-08-24', 1000.00, 'Mpesa', 'REF567890')
;

SELECT
    m.surname,
    m.firstname,
    mp.amount,
    mp.payment_date,
    mp.payment_method,
    mp.reference_no
    
FROM memb_payment.payments mp
JOIN cd.members m
ON
    m.memid = mp.member_id
;