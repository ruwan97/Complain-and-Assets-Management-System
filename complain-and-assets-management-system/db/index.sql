-- single column index
CREATE INDEX index_email_address  ON user (email);
CREATE INDEX index_nic  ON user (nic);
CREATE INDEX index_name  ON asset (name);
CREATE INDEX index_complaint_status  ON complaint (status);
CREATE INDEX index_report_date  ON report (report_date);
CREATE INDEX index_report_type  ON report (report_type);
CREATE INDEX index_students_count  ON room (no_of_students);
CREATE INDEX index_stu_registration_no  ON student (registration_no);


-- composite
CREATE INDEX index_email_mobile ON user (email, contact);
CREATE INDEX index_firstname_lastname ON user (first_name, last_name);
CREATE INDEX index_address_mobile ON user (address, contact);
CREATE INDEX index_registrationNo_roomId ON student (registration_no, room_id);
CREATE INDEX index_studentCount_roomNo ON room (no_of_students, room_no);
CREATE INDEX index_condition_name ON asset (asset_condition, name);
CREATE INDEX index_content_date ON report (content, date_time);
CREATE INDEX index_description_isResolved ON complaint (description, is_resolved);

