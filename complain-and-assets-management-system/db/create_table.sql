CREATE TABLE action_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    log_description VARCHAR(255),
    log_type VARCHAR(50),
    action VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)
;
