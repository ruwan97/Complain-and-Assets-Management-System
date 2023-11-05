-- Create a view for the daily report
CREATE OR REPLACE VIEW view_daily_report AS
SELECT c.id         AS complaint_id,
       u.id         AS user_id,
       u.first_name AS user_name,
       a.name       AS asset_name,
       c.quantity   AS damage_quantity,
       r.room_no    AS room_no,
       c.description,
       CASE
           WHEN c.status = 1 THEN 'New'
           WHEN c.status = 2 THEN 'Escalated to Sub-Warden'
           WHEN c.status = 3 THEN 'Escalated to Academic Warden'
           WHEN c.status = 4 THEN 'Resolved'
           ELSE 'Unknown'
           END AS complain_status,
       c.is_resolved,
       c.submission_date
FROM complaint c
         JOIN user u ON c.user_id = u.id
         JOIN asset a ON c.asset_id = a.id
         JOIN student s ON u.id = s.user_id
         JOIN room r ON r.id = s.room_id
WHERE c.submission_date = CURDATE()
GROUP BY c.id;

-- Create a view for the monthly report
CREATE OR REPLACE VIEW view_monthly_report AS
SELECT
    c.id AS complaint_id,
    u.id AS user_id,
    u.first_name AS user_name,
    a.name AS asset_name,
    c.quantity AS damage_quantity,
    r.room_no AS room_no,
    c.description,
    CASE
        WHEN c.status = 1 THEN 'New'
        WHEN c.status = 2 THEN 'Escalated to Sub-Warden'
        WHEN c.status = 3 THEN 'Escalated to Academic Warden'
        WHEN c.status = 4 THEN 'Resolved'
        ELSE 'Unknown'
        END AS complain_status,
    c.is_resolved,
    c.submission_date
FROM complaint c
         JOIN user u ON c.user_id = u.id
         JOIN asset a ON c.asset_id = a.id
         JOIN student s ON u.id = s.user_id
         JOIN room r ON r.id = s.room_id
WHERE MONTH(c.submission_date) = MONTH(NOW())
GROUP BY c.id;

-- complain summary
CREATE OR REPLACE VIEW view_daily_complaint_summary AS
SELECT
    r.room_no,
    DATE(c.submission_date) AS complaint_date,
    function_get_daily_complain_count(s.room_id, c.submission_date) AS total_complaints
FROM room r, student s, complaint c
WHERE r.id = s.room_id AND s.user_id = c.user_id
GROUP BY room_no, DATE(c.submission_date), s.room_id, c.submission_date;


CREATE OR REPLACE VIEW view_month_end_complaint_summary AS
SELECT
    t.room_no,
    t.room_id,
    t.complaint_month,
    function_get_monthly_complain_count(t.room_id, t.submission_date) AS total_complaints
FROM (
         SELECT
             r.room_no,
             s.room_id,
             DATE_FORMAT(c.submission_date, '%Y-%m') AS complaint_month,
             MAX(c.submission_date) AS submission_date
         FROM room r, student s, complaint c
         WHERE r.id = s.room_id AND s.user_id = c.user_id
         GROUP BY r.room_no, s.room_id, complaint_month
     ) t;

