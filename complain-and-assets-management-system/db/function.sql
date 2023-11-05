DROP FUNCTION IF EXISTS function_get_daily_complain_count;
DELIMITER //

CREATE FUNCTION function_get_daily_complain_count(roomId INT, dateVal DATE) RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE countVal INT;
    SELECT COUNT(c.id)
    INTO countVal
    FROM student s, complaint c
    WHERE DATE(c.submission_date) = DATE(dateVal) AND s.room_id = roomId AND  s.user_id = c.user_id;

    RETURN countVal;
END //

DELIMITER ;

SELECT function_get_daily_complain_count(1, '2023-10-26');


DROP FUNCTION IF EXISTS function_get_monthly_complain_count;
DELIMITER //

CREATE FUNCTION function_get_monthly_complain_count(roomId INT, dateVal DATE) RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE countVal INT;
    SELECT COUNT(c.id)
    INTO countVal
    FROM student s, complaint c
    WHERE MONTH(c.submission_date) = MONTH(dateVal) AND s.room_id = roomId AND  s.user_id = c.user_id;

    RETURN countVal;
END //

DELIMITER ;

SELECT function_get_monthly_complain_count(1, '2023-10-26');
