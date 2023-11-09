-- create view for student
CREATE OR REPLACE view view_student_info AS
SELECT u.first_name,
       u.last_name,
       u.email,
       u.nic,
       u.contact,
       u.address,
       ur.name AS role_name,
       f.name AS faculty_name,
       u.created_at,
       u.updated_at,
       u.status,
       s.registration_no,
       r.room_no
FROM `user` u, `student` s, `user_role` ur, `room` r, `faculty` f
WHERE u.id = s.user_id AND u.role_id = 1 AND u.role_id = ur.id AND s.room_id = r.id AND u.faculty_id = f.id;

-- dean information
CREATE OR REPLACE view view_dean_info AS
SELECT u.first_name,
       u.last_name,
       u.email,
       u.nic,
       u.contact,
       u.address,
       ur.name AS role_name,
       f.name AS faculty_name,
       u.created_at,
       u.updated_at,
       u.status,
       d.user_id
FROM `user` u, `dean` d, `user_role` ur, `faculty` f
WHERE u.id = d.user_id AND u.role_id = 2 AND u.role_id = ur.id AND u.faculty_id = f.id;

-- create view for complaint
CREATE OR REPLACE view view_complaint_info AS
SELECT cp.id,
       u.first_name,
       u.last_name,
       ur.name AS role_name,
       f.name  AS faculty_name,
       u.created_at,
       u.updated_at,
       a.name  AS asset_name,
       cp.description,
       cp.submission_date,
       cp.quantity,
       cp.status
FROM `user` u, `complaint` cp, `user_role` ur, `faculty` f, `asset` a
WHERE u.id = cp.student_id AND u.role_id = ur.id AND u.faculty_id = f.id AND cp.asset_id = a.id;


-- senior student counselor information
CREATE OR REPLACE view view_senior_student_counselor_info AS
SELECT u.first_name,
       u.last_name,
       u.email,
       u.nic,
       u.contact,
       u.address,
       ur.name AS role_name,
       f.name AS faculty_name,
       u.created_at,
       u.updated_at,
       u.status,
       ss.user_id
FROM `user` u, `senior_student_counselor` ss, `user_role` ur, `faculty` f
WHERE u.id = ss.user_id AND u.role_id = 5 AND u.role_id = ur.id AND u.faculty_id = f.id;

-- sub warden information
CREATE OR REPLACE view view_sub_warden_info AS
SELECT u.first_name,
       u.last_name,
       u.email,
       u.nic,
       u.contact,
       u.address,
       ur.name AS role_name,
       f.name AS faculty_name,
       u.created_at,
       u.updated_at,
       u.status,
       sw.user_id
FROM `user` u, `sub_warden` sw, `user_role` ur, `faculty` f
WHERE u.id = sw.user_id AND u.role_id = 3 AND u.role_id = ur.id AND u.faculty_id = f.id;


-- academic warden information
CREATE OR REPLACE view view_academic_warden_info AS
SELECT u.first_name,
       u.last_name,
       u.email,
       u.nic,
       u.contact,
       u.address,
       ur.name AS role_name,
       f.name AS faculty_name,
       u.created_at,
       u.updated_at,
       u.status,
       aw.id
FROM `user` u, `academic_warden` aw, `user_role` ur, `faculty` f
WHERE u.id = aw.id AND u.role_id = 4 AND u.role_id = ur.id AND u.faculty_id = f.id;


-- create view for report
CREATE OR REPLACE view view_report_info AS
SELECT u.first_name,
       u.last_name,
       ur.name AS role_name,
       r.report_content,
       r.report_date
FROM `user` u, `report` r, `user_role` ur
WHERE u.id = r.user_id AND u.role_id = ur.id;


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
            JOIN user u ON c.student_id = u.id
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
            JOIN user u ON c.student_id = u.id
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
WHERE r.id = s.room_id AND s.user_id = c.student_id
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
            WHERE r.id = s.room_id AND s.user_id = c.student_id
            GROUP BY r.room_no, s.room_id, complaint_month
     ) t;