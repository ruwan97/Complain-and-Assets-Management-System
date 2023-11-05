SET GLOBAL event_scheduler = ON;

-- reports
DROP EVENT IF EXISTS event_generate_daily_report;
DELIMITER //
CREATE EVENT `event_generate_daily_report`
    ON SCHEDULE EVERY 1 DAY
    STARTS CONCAT(DATE(NOW()), ' 23:55:00')
    ON COMPLETION PRESERVE
    DO
    BEGIN
        CALL sp_generate_daily_reports();
    END;
//
DELIMITER ;

DROP EVENT IF EXISTS event_generate_monthly_report;
DELIMITER //
CREATE EVENT `event_generate_monthly_report`
    ON SCHEDULE EVERY 1 MONTH
    STARTS CONCAT(DATE(NOW()), ' 23:55:00')
    ON COMPLETION PRESERVE
    DO
    BEGIN
        CALL sp_generate_monthly_reports();
    END;
//
DELIMITER ;

-- escalate complaint
DROP EVENT IF EXISTS event_sub_warden_escalation;
DELIMITER //
CREATE EVENT `event_sub_warden_escalation`
    ON SCHEDULE EVERY 1 DAY
    DO
    BEGIN
        CALL sp_sub_warden_escalation();
    END;
//
DELIMITER ;


DROP EVENT IF EXISTS event_academic_warden_escalation;
DELIMITER //
CREATE EVENT `event_academic_warden_escalation`
    ON SCHEDULE EVERY 1 DAY
    DO
    BEGIN
        CALL sp_academic_warden_escalation();
    END;
//
DELIMITER ;
