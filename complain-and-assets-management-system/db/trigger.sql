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
    DECLARE logDescription VARCHAR(100);

    SELECT u.first_name INTO userName FROM user u WHERE u.id = NEW.user_id;
    SELECT a.name INTO assetName FROM asset a WHERE a.id = NEW.asset_id;

    SET logType = 'Complaint';
    SET operation = 'Insert';
    SET logDescription = CONCAT('Complaint save for user ', userName, ' regarding asset ', assetName);

    CALL sp_insert_action_log(operation, logType, CURRENT_TIMESTAMP,  logDescription);
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

    CALL sp_insert_action_log(logDescription, logType, CURRENT_TIMESTAMP, operation);
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
    SET logDescription = CONCAT('Complaint delete for user ', userName, ' regarding asset ', assetName);

    CALL sp_insert_action_log(logDescription, logType, CURRENT_TIMESTAMP, operation);
END//
DELIMITER ;



DROP TRIGGER IF EXISTS trigger_after_report_insert;

DELIMITER //

CREATE TRIGGER trigger_after_report_insert
    AFTER INSERT ON report
    FOR EACH ROW
BEGIN
    DECLARE userName VARCHAR(255);
    DECLARE logType VARCHAR(50);
    DECLARE operation VARCHAR(50);
    DECLARE logDescription VARCHAR(100);

    SELECT u.first_name INTO userName FROM user u WHERE u.id = NEW.user_id;


    SET logType = 'Report';
    SET operation = 'Insert';
    SET logDescription = CONCAT('New report added by user ', userName );

    CALL sp_insert_action_log(operation, logType, CURRENT_TIMESTAMP,  logDescription);
END//

DELIMITER ;




-- User log triggers
-- insert

DROP TRIGGER IF EXISTS trigger_after_user_insert;

DELIMITER //

CREATE TRIGGER trigger_after_user_insert
    AFTER INSERT ON user
    FOR EACH ROW
BEGIN
    DECLARE userName VARCHAR(50);
    DECLARE logType VARCHAR(50);
    DECLARE roleName VARCHAR(50);
    DECLARE operation VARCHAR(50);
    DECLARE logDescription VARCHAR(100);

    SELECT ur.name INTO roleName FROM user_role ur WHERE ur.id = NEW.role_id;
    
    SET userName = NEW.first_name;
    SET logType = 'User';
    SET operation = 'Insert';
    SET logDescription = CONCAT('Registered a new ', roleName, ' named ', userName);

    CALL sp_insert_action_log(operation,logType, CURRENT_TIMESTAMP,  logDescription);
END//
DELIMITER ;


-- update

DROP TRIGGER IF EXISTS trigger_after_user_update;

DELIMITER //

CREATE TRIGGER trigger_after_user_update
    AFTER UPDATE ON user
    FOR EACH ROW
BEGIN
    DECLARE userName VARCHAR(50);
    DECLARE logType VARCHAR(50);
    DECLARE roleName VARCHAR(50);
    DECLARE operation VARCHAR(50);
    DECLARE logDescription VARCHAR(100);

    SELECT ur.name INTO roleName FROM user_role ur WHERE ur.id = NEW.role_id;

    SET userName = NEW.first_name;
    SET logType = 'User';
    SET operation = 'Update';
    SET logDescription = CONCAT('Updated details of  ', roleName, ' named ', userName);

    CALL sp_insert_action_log(operation,logType, CURRENT_TIMESTAMP,  logDescription);
END//
DELIMITER ;

-- user deleted
DROP TRIGGER IF EXISTS trigger_after_user_delete;

DELIMITER //

CREATE TRIGGER trigger_after_user_delete
    AFTER DELETE ON user
    FOR EACH ROW
BEGIN
    DECLARE userName VARCHAR(50);
    DECLARE roleName VARCHAR(50);
    DECLARE logType VARCHAR(50);
    DECLARE operation VARCHAR(50);
    DECLARE logDescription VARCHAR(100);

    SELECT ur.name INTO roleName FROM user_role ur WHERE ur.id = OLD.role_id;

    SET userName = OLD.first_name;
    SET logType = 'User';
    SET operation = 'Delete';
    SET logDescription = CONCAT('Delete details of  ', roleName, ' named ', userName);

    CALL sp_insert_action_log(operation,logType, CURRENT_TIMESTAMP,  logDescription);
END//
DELIMITER ;
