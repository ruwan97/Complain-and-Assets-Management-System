SET GLOBAL event_scheduler = ON;

DELIMITER //
CREATE EVENT EscalateComplaintsToSubWarden
    ON SCHEDULE EVERY 1 DAY STARTS CURRENT_TIMESTAMP
    DO
    BEGIN
        -- Update complaints that are waiting for sub-warden action for 3 days
        UPDATE complaint
        SET status = 'ESCALATED_TO_SUB_WARDEN'
        WHERE status = 'NEW' AND DATEDIFF(NOW(), submission_date) >= 3;
    END;
//
DELIMITER ;

DELIMITER //
CREATE EVENT EscalateComplaintsToAcademicWarden
    ON SCHEDULE EVERY 1 DAY STARTS CURRENT_TIMESTAMP
    DO
    BEGIN
        -- Update complaints that are waiting for academic warden action for 7 days
        UPDATE complaint
        SET status = 'ESCALATED_TO_ACADEMIC_WARDEN'
        WHERE status = 'ESCALATED_TO_SUB_WARDEN' AND DATEDIFF(NOW(), submission_date) >= 7;
    END;
//
DELIMITER ;

DELIMITER //
CREATE EVENT EscalateComplaints
    ON SCHEDULE EVERY 1 DAY STARTS CURRENT_TIMESTAMP
    DO
    BEGIN
        -- Update complaints based on escalation rules
        UPDATE complaint
        SET status = CASE
                         WHEN status = 'NEW' AND DATEDIFF(NOW(), submission_date) >= 3 THEN 'ESCALATED_TO_SUB_WARDEN'
                         WHEN status = 'ESCALATED_TO_SUB_WARDEN' AND DATEDIFF(NOW(), submission_date) >= 7 THEN 'ESCALATED_TO_ACADEMIC_WARDEN'
                         ELSE status
            END
        WHERE status IN ('NEW', 'ESCALATED_TO_SUB_WARDEN');
    END;
//
DELIMITER ;

