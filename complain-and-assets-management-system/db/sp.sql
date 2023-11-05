DROP PROCEDURE IF EXISTS sp_register_student;
DELIMITER //
CREATE PROCEDURE sp_register_student(
    IN titleId INT,
    IN firstName VARCHAR(255),
    IN lastName VARCHAR(255),
    IN emailAddress VARCHAR(100),
    IN userPassword VARCHAR(255),
    IN nicNo VARCHAR(12),
    IN contactNo VARCHAR(20),
    IN userAddress VARCHAR(255),
    IN roleId INT,
    IN facultyId INT,
    IN createdAt DATETIME,
    IN userStatus INT,
    IN studentRegNo VARCHAR(20),
    IN roomId INT,
    OUT userId INT -- Define an OUT parameter to return the user ID
)
BEGIN
    -- Insert a new user into the 'user' table
    INSERT INTO `user` (`title_id`, `first_name`, `last_name`, `email`, `password`, `nic`, `contact`, `address`,
                        `role_id`, `faculty_id`, `created_at`, `status`)
    VALUES (titleId, firstName, lastName, emailAddress, userPassword, nicNo, contactNo, userAddress, roleId, facultyId,
            createdAt, userStatus);

    -- Get the last inserted user ID
    SET userId = LAST_INSERT_ID();

    -- Insert a new student into the 'student' table
    INSERT INTO `student` (`user_id`, `registration_no`, `room_id`)
    VALUES (userId, studentRegNo, roomId);
END //
DELIMITER ;

CALL sp_register_student(
        1,
        'John',
        'Doe',
        'johndoe@example2.com',
        'password123',
        '1234567812V',
        '0774567890',
        '123 Main St',
        1,
        1,
        '2023-09-18 00:40:20',
        1,
        'S12346',
        1,
        @userId
     );


-- update student
DROP PROCEDURE IF EXISTS sp_update_student;
DELIMITER //
CREATE PROCEDURE sp_update_student(
    IN studentId INT,
    IN newTitleId INT,
    IN newFirstName VARCHAR(255),
    IN newLastName VARCHAR(255),
    IN newEmailAddress VARCHAR(100),
    IN newUserPassword VARCHAR(255),
    IN newNicNo VARCHAR(12),
    IN newContactNo VARCHAR(20),
    IN newUserAddress VARCHAR(255),
    IN newRoleId INT,
    IN newFacultyId INT,
    IN newStudentRegNo VARCHAR(20),
    IN newRoomId INT
)
BEGIN
    -- Update user information
    UPDATE `user`
    SET `title_id`   = newTitleId,
        `first_name` = newFirstName,
        `last_name`  = newLastName,
        `email`      = newEmailAddress,
        `password`   = newUserPassword,
        `nic`        = newNicNo,
        `contact`    = newContactNo,
        `address`    = newUserAddress,
        `role_id`    = newRoleId,
        `faculty_id` = newFacultyId
    WHERE `id` = studentId;

-- Update student information
    UPDATE `student`
    SET `registration_no` = newStudentRegNo,
        `room_id`         = newRoomId
    WHERE `user_id` = studentId;
END //
DELIMITER ;

CALL sp_update_student(
        2, -- studentId
        2, -- newTitleId
        'John', -- newFirstName
        'Doe', -- newLastName
        'johndoe@example.com', -- newEmailAddress
        'newpassword', -- newUserPassword
        '123456789012', -- newNicNo
        '1234567890', -- newContactNo
        '123 New Street, New City', -- newUserAddress
        1,
        1,
        '20230001', -- newStudentRegNo
        1
     );


-- delete student
DROP PROCEDURE IF EXISTS sp_delete_student;
DELIMITER //
CREATE PROCEDURE sp_delete_student(
    IN studentId INT
)
BEGIN
    -- Delete student information
    DELETE FROM `student` WHERE `user_id` = studentId;

    -- Delete user information
    DELETE FROM `user` WHERE `id` = studentId;
END //
DELIMITER ;

CALL sp_delete_student(2);


-- complain
DROP PROCEDURE IF EXISTS sp_save_complaint;
DELIMITER //

CREATE PROCEDURE sp_save_complaint(
    IN p_user_id INT,
    IN p_asset_id INT,
    IN p_description VARCHAR(255),
    IN p_is_resolved BOOLEAN,
    IN p_status INT,
    IN p_urgency INT,
    IN p_quantity INT,
    IN p_image_url VARCHAR(255),
    IN p_qr_code_url VARCHAR(255),
    IN p_escalation_count INT,
    IN p_submission_date DATE,
    IN p_escalation_date DATE,
    IN p_sub_warden_action_date DATE,
    IN p_academic_warden_action_date DATE
)
BEGIN
    INSERT INTO complaint
    (user_id, asset_id, description, is_resolved, status, urgency, quantity, image_url, qr_code_url, escalation_count,
     submission_date, escalation_date, sub_warden_action_date, academic_warden_action_date)
    VALUES (p_user_id, p_asset_id, p_description, p_is_resolved, p_status, p_urgency, p_quantity, p_image_url,
            p_qr_code_url, p_escalation_count, p_submission_date, p_escalation_date, p_sub_warden_action_date,
            p_academic_warden_action_date);
END//

DELIMITER ;

CALL sp_save_complaint(
        1, -- p_user_id
        1, -- p_asset_id
        'Description 1', -- p_description
        0, -- p_is_resolved (assuming false)
        1, -- p_status
        1, -- p_urgency
        5, -- p_quantity
        'image_url_1', -- p_image_url
        'qr_code_url_1', -- p_qr_code_url
        0, -- p_escalation_count
        CURDATE(), -- p_submission_date (format: 'YYYY-MM-DD')
        null, -- p_escalation_date (format: 'YYYY-MM-DD')
        null, -- p_sub_warden_action_date (format: 'YYYY-MM-DD')
        null -- p_academic_warden_action_date (format: 'YYYY-MM-DD')
     );

CALL sp_save_complaint(
        1, -- p_user_id
        2, -- p_asset_id
        'Description 2', -- p_description
        1, -- p_is_resolved (assuming true)
        2, -- p_status
        2, -- p_urgency
        3, -- p_quantity
        'image_url_2', -- p_image_url
        'qr_code_url_2', -- p_qr_code_url
        1, -- p_escalation_count
        CURDATE(), -- p_submission_date (format: 'YYYY-MM-DD')
        null, -- p_escalation_date (format: 'YYYY-MM-DD')
        null, -- p_sub_warden_action_date (format: 'YYYY-MM-DD')
        null -- p_academic_warden_action_date (format: 'YYYY-MM-DD')
     );


-- asset
DROP PROCEDURE IF EXISTS sp_insert_asset;
DELIMITER //

CREATE PROCEDURE sp_insert_asset(
    IN p_name VARCHAR(255),
    IN p_description VARCHAR(255),
    IN p_asset_condition VARCHAR(255),
    IN p_quantity INT
)
BEGIN
    INSERT INTO asset
        (name, description, asset_condition, quantity)
    VALUES (p_name, p_description, p_asset_condition, p_quantity);
END//

DELIMITER ;

CALL sp_insert_asset(
        'Laptop', -- p_name
        'Dell Latitude', -- p_description
        'Good', -- p_asset_condition
        10 -- p_quantity
     );

CALL sp_insert_asset(
        'Monitor', -- p_name
        'Dell Monitor', -- p_description
        'Excellent', -- p_asset_condition
        15 -- p_quantity
     );


-- reports
DROP PROCEDURE IF EXISTS sp_insert_report;
DELIMITER //
CREATE PROCEDURE sp_insert_report(
    IN p_user_id INT,
    IN p_report_type VARCHAR(255),
    IN p_report_content VARCHAR(255)
)
BEGIN
    INSERT INTO report (user_id, report_type, report_date, report_content)
    VALUES (p_user_id, p_report_type, CURDATE(), p_report_content);
END //
DELIMITER ;


-- for sub warden, academic warden, senior student counselor
DROP PROCEDURE IF EXISTS sp_generate_daily_reports;
DELIMITER //
CREATE PROCEDURE sp_generate_daily_reports()
BEGIN
    DECLARE sub_warden_id INT;
    DECLARE academic_warden_id INT;
    DECLARE senior_counselor_id INT;
    DECLARE type VARCHAR(10);
    DECLARE content VARCHAR(1000);

    -- Get the IDs of the sub warden, academic warden, and senior student counselor
    SELECT id INTO sub_warden_id FROM user WHERE role_id = 3 AND status = 1 ORDER BY id LIMIT 1;
    SELECT id INTO academic_warden_id FROM user WHERE role_id = 4 AND status = 1 ORDER BY id LIMIT 1;
    SELECT id INTO senior_counselor_id FROM user WHERE role_id = 5 AND status = 1 ORDER BY id LIMIT 1;

    -- Fetch data from the view and write to file
    SET @file_name = CONCAT('/var/lib/mysql-files/daily_report_', DATE_FORMAT(NOW(), '%Y-%m-%d'), '.csv');
    SET @sql_query = CONCAT('SELECT * FROM view_daily_report INTO OUTFILE ''', @file_name, '''');
    PREPARE stmt FROM @sql_query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    SET type = 'daily';
    SET content = 'Daily report - please check the attached file';

    -- Send the daily report to the sub warden, academic warden, and senior student counselor
    CALL sp_send_report_to_sub_warden(sub_warden_id, type, content);
    CALL sp_send_report_to_academic_warden(academic_warden_id, type, content);
    CALL sp_send_report_to_senior_student_counselor(senior_counselor_id, type, content);
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS sp_send_report_to_sub_warden;
DELIMITER //
CREATE PROCEDURE sp_send_report_to_sub_warden(IN userId INT, IN type VARCHAR(10), IN content VARCHAR(1000))
BEGIN
    -- Insert data to the report for the sub warden
    CALL sp_insert_report(userId, type, content);
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_send_report_to_academic_warden;
DELIMITER //
CREATE PROCEDURE sp_send_report_to_academic_warden(IN userId INT, IN type VARCHAR(10), IN content VARCHAR(1000))
BEGIN
    -- Insert data to the report for the sub warden
    CALL sp_insert_report(userId, type, content);
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_send_report_to_senior_student_counselor;
DELIMITER //
CREATE PROCEDURE sp_send_report_to_senior_student_counselor(IN userId INT, IN type VARCHAR(10), IN content VARCHAR(1000))
BEGIN
    -- Insert data to the report for the sub warden
    CALL sp_insert_report(userId, type, content);
END //
DELIMITER ;

-- for dean
DROP PROCEDURE IF EXISTS sp_generate_monthly_reports;
DELIMITER //
CREATE PROCEDURE sp_generate_monthly_reports()
BEGIN
    DECLARE dean_id INT;
    DECLARE type VARCHAR(10);
    DECLARE content VARCHAR(1000);
    DECLARE file_path VARCHAR(200);

    -- Get the ID of the dean
    SELECT id INTO dean_id FROM user WHERE role_id = 2 AND status = 1;

    -- Query for all complaints in the month
    SET @file_name = CONCAT('/var/lib/mysql-files/monthly_report_', DATE_FORMAT(NOW(), '%Y-%m'), '.csv');
    SET @sql_query = CONCAT('SELECT * FROM view_monthly_report INTO OUTFILE ''', @file_name, '''');
    PREPARE stmt FROM @sql_query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    SET type = 'monthly';
    SET content = 'Monthly report - please check the attached file';

    -- Sending the monthly report to the dean
    CALL sp_send_report_to_dean(dean_id, type, content);
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_send_report_to_dean;
DELIMITER //
CREATE PROCEDURE sp_send_report_to_dean(IN userId INT, IN type VARCHAR(10), IN content VARCHAR(1000))
BEGIN
    -- Insert data to the report for the sub warden
    CALL sp_insert_report(userId, type, content);
END //
DELIMITER ;


-- escalate complain
DROP PROCEDURE IF EXISTS sp_sub_warden_escalation;
DELIMITER //
CREATE PROCEDURE sp_sub_warden_escalation()
BEGIN
    -- Update complaints that are waiting for sub-warden action for 3 days
    UPDATE complaint
    SET status                 = 2,
        escalation_count       = escalation_count + 1,
        escalation_date        = CURRENT_DATE,
        sub_warden_action_date = CURRENT_DATE
    WHERE DATEDIFF(CURRENT_DATE, submission_date) > 3
      AND status = 1;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_academic_warden_escalation;
DELIMITER //
CREATE PROCEDURE sp_academic_warden_escalation()
BEGIN
    -- Update complaints that are waiting for academic warden action for 7 days
    UPDATE complaint
    SET status                      = 3,
        escalation_count            = escalation_count + 1,
        escalation_date             = CURRENT_DATE,
        academic_warden_action_date = CURRENT_DATE
    WHERE DATEDIFF(CURRENT_DATE, submission_date) > 7
      AND status = 2;
END//
DELIMITER ;


-- action log
DROP PROCEDURE IF EXISTS sp_insert_action_log;
DELIMITER //
CREATE PROCEDURE sp_insert_action_log(IN description VARCHAR(255), IN type VARCHAR(50), IN act VARCHAR(50))
BEGIN
    INSERT INTO action_log (log_description, log_type, action)
    VALUES (description, type, act);
END//
DELIMITER ;














