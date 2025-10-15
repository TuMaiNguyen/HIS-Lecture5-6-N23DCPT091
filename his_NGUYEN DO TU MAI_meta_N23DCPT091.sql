USE his_choray;

CREATE TABLE IF NOT EXISTS LabSubmission (
  id INT PRIMARY KEY AUTO_INCREMENT,
  student_code VARCHAR(32) NOT NULL,
  full_name    VARCHAR(120) NOT NULL,
  note         VARCHAR(255),
  saved_at     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO LabSubmission (student_code, full_name, note)
VALUES ('N23DCPT091', 'Nguyễn Đỗ Tú Mai', 'Lab HIS – ERD, seed, billing OK');

-- Thêm bạn vào Patient như watermark
INSERT INTO Patient (national_id, full_name, dob, phone, address)
VALUES ('N23DCPT091', 'Nguyễn Đỗ Tú Mai', '2003-01-01', '0900009091',
        'MSSV N23DCPT091 - bài lab của Mai');
