DROP PROCEDURE IF EXISTS sp_register_student;

DELIMITER //
CREATE PROCEDURE sp_register_student(
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
    INSERT INTO `user` (`first_name`, `last_name`, `email`, `password`, `nic`, `login_attempts`,`contact`, `address`, `role_id`,
                        `faculty_id`, `created_at`, `status`)
    VALUES (firstName, lastName, emailAddress, userPassword, nicNo, 0, contactNo, userAddress, roleId, facultyId,
            createdAt, userStatus);

    -- Get the last inserted user ID
    SET userId = LAST_INSERT_ID();

    -- Insert a new student into the 'student' table
    INSERT INTO `student` (`user_id`, `registration_no`, `room_id`)
    VALUES (userId, studentRegNo, roomId);
END //
DELIMITER ;

CALL sp_register_student(
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
DELIMITER //
CREATE PROCEDURE sp_update_student(
    IN studentId INT,
    IN firstName VARCHAR(255),
    IN lastName VARCHAR(255),
    IN emailAddress VARCHAR(100),
    IN userPassword VARCHAR(255),
    IN nicNo VARCHAR(12),
    IN contactNo VARCHAR(20),
    IN userAddress VARCHAR(255),
    IN roleId INT,
    IN facultyId INT,
    IN updatedAt DATETIME,
    IN userStatus INT,
    IN studentRegNo VARCHAR(20),
    IN roomId INT
)
BEGIN
    -- Update user information
    UPDATE `user`
    SET `first_name`= firstName,
        `last_name`= lastName,
        `email`= emailAddress,
        `password`= userPassword,
        `nic`= nicNo,
        `contact`= contactNo,
        `address`= userAddress,
        `role_id`= roleId,
        `faculty_id`= facultyId,
        `updated_at`= updatedAt,
        `status`= userStatus
    WHERE `id` = studentId;

    -- Update user information
    UPDATE `student`
    SET `registration_no` = studentRegNo,
        `room_id`         = roomId
    WHERE `user_id` = studentId;

END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE sp_remove_student(
    IN studentId INT
)
BEGIN
    -- delete student informations
    DELETE FROM `student` WHERE `user_id` = studentId;

    -- delete user informations
    DELETE FROM `user` WHERE `id` = studentId;
END //
DELIMITER ;


-- AssetInsert

DELIMITER //
CREATE PROCEDURE sp_add_asset(
    IN assetCondition VARCHAR(255),
    IN assetDescription VARCHAR(255),
    IN assetName VARCHAR(100),
    IN assetQuantity INT
)
BEGIN
    -- Insert a new asset into the 'asset' table
    INSERT INTO `asset` (`asset_condition`, `description`, `name`, `quantity`)
    VALUES (assetCondition, assetDescription, assetName, assetQuantity);

END //
DELIMITER ;

-- Call the stored procedure with Sample Data 1
CALL sp_add_asset('Good', 'Chair', 'Chair', 5);

-- Call the stored procedure with Sample Data 2
CALL sp_add_asset('Used', 'table', 'table', 10);


CALL sp_add_asset(
        'Broken',
        'Two Tables are broken',
        'Table',
        '2'
    );


DELIMITER //
CREATE PROCEDURE sp_update_asset(
    IN assetId INT,
    IN assetCondition VARCHAR(255),
    IN assetDescription VARCHAR(255),
    IN AssetName VARCHAR(100),
    IN assetQuantity INT
)
BEGIN
    -- Update asset information
    UPDATE `asset`
    SET `asset_condition`= assetCondition,
        `description`= assetDescription,
        `name`= AssetName,
        `quantity`= assetQuantity
    WHERE `id` = assetId;

END //
DELIMITER ;


-- AssetDelete

DELIMITER //
CREATE PROCEDURE sp_remove_asset(
    IN assetId INT
)
BEGIN
    -- delete student informations
    DELETE FROM `asset` WHERE `id` = assetId;

END //
DELIMITER ;


-- subWarden

DELIMITER //
CREATE PROCEDURE sp_register_subWarden(
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
    OUT userId INT -- Define an OUT parameter to return the user ID
)
BEGIN
    -- Insert a new user into the 'user' table
    INSERT INTO `user` (`first_name`, `last_name`, `email`, `password`, `nic`, `contact`, `address`, `role_id`,
                        `faculty_id`, `created_at`, `status`)
    VALUES (firstName, lastName, emailAddress, userPassword, nicNo, contactNo, userAddress, roleId, facultyId,
            createdAt, userStatus);

    -- Get the last inserted user ID
    SET userId = LAST_INSERT_ID();

    -- Insert a new subWarden into the 'subWarden' table
    INSERT INTO `student` (`user_id`)
    VALUES (userId);
END //
DELIMITER ;

CALL sp_register_subWarden(
        'Jamila',
        'Hasangi',
        'jamilahasangi@example1.com',
        'password123',
        '995733110V',
        '0761864773',
        '123 Matara walgama',
        3,
        1,
        '2023-09-18 00:40:20',
        1,
        @userId
    );

-- update subWarden
DELIMITER //
CREATE PROCEDURE sp_update_subWarden(
    IN subWardenId INT,
    IN firstName VARCHAR(255),
    IN lastName VARCHAR(255),
    IN emailAddress VARCHAR(100),
    IN userPassword VARCHAR(255),
    IN nicNo VARCHAR(12),
    IN contactNo VARCHAR(20),
    IN userAddress VARCHAR(255),
    IN roleId INT,
    IN facultyId INT,
    IN updatedAt DATETIME,
    IN userStatus INT
)
BEGIN
    -- Update user information
    UPDATE `user`
    SET `first_name`= firstName,
        `last_name`= lastName,
        `email`= emailAddress,
        `password`= userPassword,
        `nic`= nicNo,
        `contact`= contactNo,
        `address`= userAddress,
        `role_id`= roleId,
        `faculty_id`= facultyId,
        `updated_at`= updatedAt,
        `status`= userStatus
    WHERE `id` = subWardenId;

END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE sp_remove_subWarden(
    IN subWardenId INT
)
BEGIN
    -- delete subWarden information
    DELETE FROM `sub_warden` WHERE `user_id` = subWardenId;

    -- delete user information
    DELETE FROM `user` WHERE `id` = subWardenId;
END //
DELIMITER ;


-- senior student counselor register

DELIMITER //
CREATE PROCEDURE sp_register_senior_student_counselor(
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
    OUT userId INT -- Define an OUT parameter to return the user ID
)
BEGIN
    -- Insert a new user into the 'user' table
    INSERT INTO `user` (`first_name`, `last_name`, `email`, `password`, `nic`, `contact`, `address`, `role_id`,
                        `faculty_id`, `created_at`, `status`)
    VALUES (firstName, lastName, emailAddress, userPassword, nicNo, contactNo, userAddress, roleId, facultyId,
            createdAt, userStatus);

    -- Get the last inserted user ID
    SET userId = LAST_INSERT_ID();

    -- Insert a new student into the 'senior_student_counselor' table
    INSERT INTO `senior_student_counselor` (`user_id`)
    VALUES (userId);
END //
DELIMITER ;

CALL sp_register_senior_student_counselor(
        'Malsha',
        'Prabuddhi',
        'malsha@gmail.com',
        'password123',
        '1978567812V',
        '0744567899',
        '145 Main St',
        5,
        1,
        '2023-09-18 00:40:20',
        1,
        @userId
    );


-- senior student counselor updated

DELIMITER //
CREATE PROCEDURE sp_update_senior_student_counselor(
    IN sscId INT,
    IN firstName VARCHAR(255),
    IN lastName VARCHAR(255),
    IN emailAddress VARCHAR(100),
    IN userPassword VARCHAR(255),
    IN nicNo VARCHAR(12),
    IN contactNo VARCHAR(20),
    IN userAddress VARCHAR(255),
    IN roleId INT,
    IN facultyId INT,
    IN updatedAt DATETIME,
    IN userStatus INT
)
BEGIN

    -- Update user information
    UPDATE `user`
    SET `first_name`= firstName,
        `last_name`= lastName,
        `email`= emailAddress,
        `password`= userPassword,
        `nic`= nicNo,
        `contact`= contactNo,
        `address`= userAddress,
        `role_id`= roleId,
        `faculty_id`= facultyId,
        `updated_at`= updatedAt,
        `status`= userStatus
    WHERE `id` = sscId;


END //
DELIMITER ;


-- senior student counselor deleted

DELIMITER //
CREATE PROCEDURE sp_remove_senior_student_counselor(
    IN sscId INT
)
BEGIN
    -- delete senior student counselor informations
    DELETE FROM `senior_student_counselor` WHERE `user_id` = sscId;

    -- delete user informations
    DELETE FROM `user` WHERE `id` = sscId;
END //
DELIMITER ;


-- InsertAcademicWarden

DELIMITER //
CREATE PROCEDURE sp_register_academicWarden(
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
    OUT userId INT -- Define an OUT parameter to return the user ID
)
BEGIN
    -- Insert a new user into the 'user' table
    INSERT INTO `user` (`first_name`, `last_name`, `email`, `password`, `nic`, `contact`, `address`, `role_id`,
                        `faculty_id`, `created_at`, `status`)
    VALUES (firstName, lastName, emailAddress, userPassword, nicNo, contactNo, userAddress, roleId, facultyId,
            createdAt, userStatus);

    -- Get the last inserted user ID
    SET userId = LAST_INSERT_ID();

    -- Insert a new student into the 'student' table
    INSERT INTO `academic_warden` (`id`)
    VALUES (userId);
END //
DELIMITER ;

CALL sp_register_academicWarden(
        'Nimal',
        'Jayalath',
        'Nimal@example2.com',
        'password666',
        '6666567812V',
        '0774567890',
        '76/4 Main St',
        4,
        1,
        '2023-09-18 00:40:20',
        1,
        @userId
    );


-- update academicWarden
DELIMITER //
CREATE PROCEDURE sp_update_academicWarden(
    IN AwID INT,
    IN firstName VARCHAR(255),
    IN lastName VARCHAR(255),
    IN emailAddress VARCHAR(100),
    IN userPassword VARCHAR(255),
    IN nicNo VARCHAR(12),
    IN contactNo VARCHAR(20),
    IN userAddress VARCHAR(255),
    IN roleId INT,
    IN facultyId INT,
    IN updatedAt DATETIME,
    IN userStatus INT
)
BEGIN
    -- Update AcademicWarden information
    UPDATE `user`
    SET `first_name`= firstName,
        `last_name`= lastName,
        `email`= emailAddress,
        `password`= userPassword,
        `nic`= nicNo,
        `contact`= contactNo,
        `address`= userAddress,
        `role_id`= roleId,
        `faculty_id`= facultyId,
        `updated_at`= updatedAt,
        `status`= userStatus
    WHERE `id` = AwID;

END //
DELIMITER ;


-- Remove Academic Warden
DELIMITER //
CREATE PROCEDURE sp_remove_academicWarden(
    IN AwID INT
)
BEGIN
    -- delete AcademicWarden informations
    DELETE FROM `academic_warden` WHERE `id` = id;

    -- delete user informations
    DELETE FROM `user` WHERE `id` = id;
END //
DELIMITER ;


-- dean

DELIMITER //
CREATE PROCEDURE sp_register_dean(
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
    OUT userId INT -- Define an OUT parameter to return the user ID
)
BEGIN
    -- Insert a new user into the 'user' table
    INSERT INTO `user` (`first_name`, `last_name`, `email`, `password`, `nic`, `contact`, `address`, `role_id`,
                        `faculty_id`, `created_at`, `status`)
    VALUES (firstName, lastName, emailAddress, userPassword, nicNo, contactNo, userAddress, roleId, facultyId,
            createdAt, userStatus);

    -- Get the last inserted user ID
    SET userId = LAST_INSERT_ID();

    -- Insert a new dean into the 'dean' table
    INSERT INTO `dean` (`user_id`)
    VALUES (userId);
END //
DELIMITER ;

CALL sp_register_dean(
        'Subash',
        'Jayasingha',
        'subashjayasingha@example2.com',
        'password123',
        '665739810V',
        '0714564773',
        '103 Galle Karapitiya',
        2,
        1,
        '2023-09-18 00:40:20',
        1,
        @userId
    );

-- update dean
DELIMITER //
CREATE PROCEDURE sp_update_dean(
    IN deanId INT,
    IN firstName VARCHAR(255),
    IN lastName VARCHAR(255),
    IN emailAddress VARCHAR(100),
    IN userPassword VARCHAR(255),
    IN nicNo VARCHAR(12),
    IN contactNo VARCHAR(20),
    IN userAddress VARCHAR(255),
    IN roleId INT,
    IN facultyId INT,
    IN updatedAt DATETIME,
    IN userStatus INT
)
BEGIN
    -- Update user information
    UPDATE `user`
    SET `first_name`= firstName,
        `last_name`= lastName,
        `email`= emailAddress,
        `password`= userPassword,
        `nic`= nicNo,
        `contact`= contactNo,
        `address`= userAddress,
        `role_id`= roleId,
        `faculty_id`= facultyId,
        `updated_at`= updatedAt,
        `status`= userStatus
    WHERE `id` = deanId;

END //
DELIMITER ;

-- RemoveDean

DELIMITER //
CREATE PROCEDURE sp_remove_dean(
    IN deanId INT
)
BEGIN
    -- delete subWarden information
    DELETE FROM `dean` WHERE `user_id` = deanId;

    -- delete user information
    DELETE FROM `user` WHERE `id` = deanId;
END //
DELIMITER ;


-- room

DELIMITER //
CREATE PROCEDURE sp_add_room(
    IN roomFloorId INT,
    IN roomStudentCount INT,
    IN roomNo INT
)
BEGIN
    -- Insert a new details into the 'room' table
    INSERT INTO `room` (`floor_id`, `no_of_students`, `room_no`)
    VALUES (roomFloorId, roomStudentCount, roomNo);

END //
DELIMITER ;

CALL sp_add_room(
        '1',
        '04',
        '203'
    );

-- report
DROP PROCEDURE IF EXISTS sp_add_report;
DELIMITER //
CREATE PROCEDURE sp_add_report(
    IN p_user_id INT,
    IN p_report_type VARCHAR(255),
    IN p_report_content VARCHAR(255)
)
BEGIN
    INSERT INTO report (user_id, report_type, report_date, report_content)
    VALUES (p_user_id, p_report_type, CURDATE(), p_report_content);
END //
DELIMITER ;



CALL sp_add_report(
        'complain Number 01',
        '2023-10-26 14:30:00.000000',
        1
    );


-- remove report info
DELIMITER //
CREATE PROCEDURE sp_remove_report(
    IN reportId INT
)
BEGIN
    -- delete report info
    DELETE FROM `report` WHERE `user_id` = reportId;

    -- delete user info
    DELETE FROM `user` WHERE `id` = reportId;
END //
DELIMITER ;

-- complaint procedure register
DROP PROCEDURE IF EXISTS sp_register_complaint;
DELIMITER //
CREATE PROCEDURE sp_register_complaint(
    IN userId INT,
    IN assetId INT,
    IN descriptions VARCHAR(255),
    IN complaintStatus INT,
    IN complaintUrgency INT,
    IN complaintQuantity INT,
    IN imageURL VARCHAR(255),
    IN qrCodeUrl VARCHAR(255),
    IN submissionDate DATETIME
)
BEGIN
    -- Insert a new complaint
    INSERT INTO `complaint` (`student_id`, `asset_id`, `description`, `is_resolved`, `status`, `urgency`, `quantity`,
                             `image_url`, `qr_code_url`, `escalation_count`, `submission_date`, `escalation_date`,
                             `sub_warden_action_date`, `academic_warden_action_date`)
    VALUES (userId, assetId, descriptions, false, complaintStatus, complaintUrgency, complaintQuantity, imageURL,
            qrCodeUrl, null, submissionDate, NULL, NULL, NULL);
END //
DELIMITER ;

-- Call the stored procedure with Sample Data 1
CALL sp_register_complaint(11, 1, 'Broken equipment', 1, 1, 2, 'sample_image1.jpg', 'sample_qrcode1.jpg', 0, NOW());

-- Call the stored procedure with Sample Data 2
CALL sp_register_complaint(10, 2, 'Network issues', 1, 2, 1, 'sample_image2.jpg', 'sample_qrcode2.jpg', 0, NOW());


-- complaint procedure updated
DELIMITER //
CREATE PROCEDURE sp_update_complaint(
    IN complaintId INT,
    IN userId INT,
    IN assetId INT,
    IN descriptions TEXT,
    IN isResolved BOOLEAN,
    IN complaintStatus INT,
    IN complaintUrgency INT,
    IN complaintQuantity INT,
    IN imageURL VARCHAR(255),
    IN qrCodeUrl VARCHAR(255),
    IN escalationCount INT
)
BEGIN
    -- Update complaint information
    UPDATE `complaint`
    SET `student_id`          = userId,
        `asset_id`         = assetId,
        `description`      = descriptions,
        `is_resolved`      = isResolved,
        `status`           = complaintStatus,
        `urgency`          = complaintUrgency,
        `quantity`         = complaintQuantity,
        `image_url`        = imageURL,
        `qr_code_url`      = qrCodeUrl,
        `escalation_count` = escalationCount
    WHERE `id` = complaintId;
END //
DELIMITER ;

-- complaint procedure remove
DELIMITER //
CREATE PROCEDURE sp_remove_complaint(
    IN complaintId INT
)
BEGIN
    -- Delete complaint by ID
    DELETE FROM `complaint` WHERE `id` = complaintId;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_insert_action_log;
DELIMITER //
CREATE PROCEDURE sp_insert_action_log(
    IN logAction VARCHAR(50),
    IN logType VARCHAR(50),
    IN createdAt DATETIME,
    IN logDescription VARCHAR(100)
)
BEGIN
    -- Insert a new details into the 'action_log' table
    INSERT INTO `action_log` (`action`, `log_type`, `created_at`, `log_description`)
    VALUES (logAction, logType, createdAt, logDescription);

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
    SET @file_name = CONCAT('C:/wamp64/tmp/daily_report_', DATE_FORMAT(NOW(), '%Y-%m-%d'), '.csv');
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
    CALL sp_add_report(userId, type, content);
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_send_report_to_academic_warden;
DELIMITER //
CREATE PROCEDURE sp_send_report_to_academic_warden(IN userId INT, IN type VARCHAR(10), IN content VARCHAR(1000))
BEGIN
    -- Insert data to the report for the sub warden
    CALL sp_add_report(userId, type, content);
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_send_report_to_senior_student_counselor;
DELIMITER //
CREATE PROCEDURE sp_send_report_to_senior_student_counselor(IN userId INT, IN type VARCHAR(10), IN content VARCHAR(1000))
BEGIN
    -- Insert data to the report for the sub warden
    CALL sp_add_report(userId, type, content);
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
    SET @file_name = CONCAT('C:/wamp64/tmp/monthly_report_', DATE_FORMAT(NOW(), '%Y-%m'), '.csv');
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
    CALL sp_add_report(userId, type, content);
    END //
    DELIMITER ;


DROP PROCEDURE IF EXISTS sp_academic_warden_escalation;
DELIMITER //
CREATE PROCEDURE sp_academic_warden_escalation()
BEGIN
    -- Update complaints that are waiting for sub-warden action for 3 days
    UPDATE complaint
    SET status                 = 2,
        escalation_date        = CURRENT_DATE
    WHERE DATEDIFF(CURRENT_DATE, submission_date) > 3
      AND status = 1;
END//
DELIMITER ;