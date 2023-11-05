-- complaint
DROP TRIGGER IF EXISTS trigger_after_complaint_insert;
DELIMITER //
CREATE TRIGGER trigger_after_complaint_insert
    AFTER INSERT ON complaint
    FOR EACH ROW
BEGIN
    DECLARE userName VARCHAR(255);
    DECLARE assetName VARCHAR(255);
    DECLARE logType VARCHAR(50);
    DECLARE operation VARCHAR(50);
    DECLARE logDescription VARCHAR(255);

    SELECT u.first_name INTO userName FROM user u WHERE u.id = NEW.user_id;
    SELECT a.name INTO assetName FROM asset a WHERE a.id = NEW.asset_id;

    SET logType = 'Complaint';
    SET operation = 'Insert';
    SET logDescription = CONCAT('Complaint updated for user ', userName, ' regarding asset ', assetName);

    CALL sp_insert_action_log(logDescription, logType, operation);
END//
DELIMITER ;

DROP TRIGGER IF EXISTS trigger_after_complaint_update;
DELIMITER //
CREATE TRIGGER trigger_after_complaint_update
    AFTER UPDATE ON complaint
    FOR EACH ROW
BEGIN
    DECLARE userName VARCHAR(255);
    DECLARE assetName VARCHAR(255);
    DECLARE logType VARCHAR(50);
    DECLARE operation VARCHAR(50);
    DECLARE logDescription VARCHAR(255);

    SELECT u.first_name INTO userName FROM user u WHERE u.id = NEW.user_id;
    SELECT a.name INTO assetName FROM asset a WHERE a.id = NEW.asset_id;

    SET logType = 'Complaint';
    SET operation = 'Update';
    SET logDescription = CONCAT('Complaint updated for user ', userName, ' regarding asset ', assetName);

    CALL sp_insert_action_log(logDescription, logType, operation);
END//
DELIMITER ;


DROP TRIGGER IF EXISTS trigger_after_complaint_delete;
DELIMITER //
CREATE TRIGGER trigger_after_complaint_delete
    AFTER DELETE ON complaint
    FOR EACH ROW
BEGIN
    DECLARE userName VARCHAR(255);
    DECLARE assetName VARCHAR(255);
    DECLARE logType VARCHAR(50);
    DECLARE operation VARCHAR(50);
    DECLARE logDescription VARCHAR(255);

    SELECT u.first_name INTO userName FROM user u WHERE u.id = OLD.user_id;
    SELECT a.name INTO assetName FROM asset a WHERE a.id = OLD.asset_id;

    SET logType = 'Complaint';
    SET operation = 'Delete';
    SET logDescription = CONCAT('Complaint updated for user ', userName, ' regarding asset ', assetName);

    CALL sp_insert_action_log(logDescription, logType, operation);
END//
DELIMITER ;

-- user registration
DROP TRIGGER IF EXISTS trigger_after_user_insert;
DELIMITER //
CREATE TRIGGER trigger_after_user_insert
    AFTER INSERT ON user
    FOR EACH ROW
BEGIN
    DECLARE userFullName VARCHAR(255);
    DECLARE logType VARCHAR(50);
    DECLARE operation VARCHAR(50);
    DECLARE logDescription VARCHAR(255);

    SET userFullName = CONCAT(NEW.first_name, ' ', NEW.last_name);

    SET logType = 'User';
    SET operation = 'Insert';
    SET logDescription = CONCAT('New user created: ', userFullName);

    CALL sp_insert_action_log(logDescription, logType, operation);
END//
DELIMITER ;


DROP TRIGGER IF EXISTS trigger_after_user_update;
DELIMITER //
CREATE TRIGGER trigger_after_user_update
    AFTER UPDATE ON user
    FOR EACH ROW
BEGIN
    DECLARE userFullName VARCHAR(255);
    DECLARE logType VARCHAR(50);
    DECLARE operation VARCHAR(50);
    DECLARE logDescription VARCHAR(255);

    SET userFullName = CONCAT(NEW.first_name, ' ', NEW.last_name);

    SET logType = 'User';
    SET operation = 'Update';
    SET logDescription = CONCAT('User information updated: ', userFullName);

    CALL sp_insert_action_log(logDescription, logType, operation);
END//
DELIMITER ;


DROP TRIGGER IF EXISTS trigger_after_user_delete;
DELIMITER //
CREATE TRIGGER trigger_after_user_delete
    AFTER DELETE ON user
    FOR EACH ROW
BEGIN
    DECLARE userFullName VARCHAR(255);
    DECLARE logType VARCHAR(50);
    DECLARE operation VARCHAR(50);
    DECLARE logDescription VARCHAR(255);

    SET userFullName = CONCAT(OLD.first_name, ' ', OLD.last_name);

    SET logType = 'User';
    SET operation = 'Delete';
    SET logDescription = CONCAT('User deleted: ', userFullName);

    CALL sp_insert_action_log(logDescription, logType, operation);
END//
DELIMITER ;


-- report
DROP TRIGGER IF EXISTS trigger_after_report_insert;
DELIMITER //
CREATE TRIGGER trigger_after_report_insert
    AFTER INSERT ON report
    FOR EACH ROW
BEGIN
    DECLARE userFullName VARCHAR(255);
    DECLARE logType VARCHAR(50);
    DECLARE operation VARCHAR(50);
    DECLARE logDescription VARCHAR(255);

    SELECT CONCAT(u.first_name, ' ', u.last_name) INTO userFullName FROM user u WHERE u.id = NEW.user_id;

    SET logType = 'Report';
    SET operation = 'Insert';
    SET logDescription = CONCAT('New report added by user: ', userFullName);

    CALL sp_insert_action_log(logDescription, logType, operation);
END//
DELIMITER ;

