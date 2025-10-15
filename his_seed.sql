USE his_choray;

-- Patients & Doctors
INSERT INTO Patient (national_id, full_name, dob, phone, address) VALUES
('0123456789','Nguyễn Văn A','1995-05-10','0901112222','Q.1, HCM'),
('0987654321','Trần Thị B','1990-09-12','0903334444','Q.3, HCM');

INSERT INTO Doctor (full_name, specialty, phone) VALUES
('BS. Lê Minh','Nội tổng quát','0905556666'),
('BS. Phạm Anh','Chẩn đoán hình ảnh','0907778888');

-- Appointment
INSERT INTO Appointment (patient_id, doctor_id, scheduled_at, status, note) VALUES
(1,1,'2025-10-10 09:00:00','completed','Khám lần đầu'),
(2,1,'2025-10-11 10:00:00','scheduled','Khám định kỳ');

-- Medical Record
INSERT INTO MedicalRecord (patient_id, doctor_id, created_at, diagnosis, note) VALUES
(1,1,'2025-10-10 09:30:00','Viêm họng cấp','Nghỉ ngơi, uống nước ấm');

-- Lab test
INSERT INTO LabTest (mr_id, type, result, taken_at) VALUES
(1,'CBC','WBC normal','2025-10-10 10:00:00');

-- Prescription & medicines
INSERT INTO Prescription (mr_id, created_at, advice) VALUES
(1,'2025-10-10 10:15:00','Uống đủ nước, tránh lạnh');

INSERT INTO Medicine (name, unit, price, stock_qty, expire_date) VALUES
('Paracetamol 500mg','viên',1500,1000,'2026-12-31'),
('Amoxicillin 500mg','viên',3000,500,'2026-12-31');

INSERT INTO PrescriptionItem (rx_id, medicine_id, qty, dosage, duration) VALUES
(1,1,10,'1 viên x 3 lần/ngày','3 ngày'),
(1,2,15,'1 viên x 3 lần/ngày','5 ngày');

-- Medical services
INSERT INTO MedicalService (name, price, dept) VALUES
('Khám nội tổng quát',150000,'Khoa Khám bệnh'),
('Siêu âm ổ bụng',250000,'CĐHA');

INSERT INTO MR_Service (mr_id, service_id, qty) VALUES
(1,1,1);

-- Invoice + items
INSERT INTO Invoice (patient_id, issued_at, total_amount, status)
VALUES (1,'2025-10-10 11:00:00',0,'unpaid');

-- Service lines
INSERT INTO InvoiceItem (invoice_id, item_type, ref_id, description, amount)
SELECT 1,'service', mrs.id, CONCAT('Dịch vụ: ', s.name), s.price * mrs.qty
FROM MR_Service mrs JOIN MedicalService s ON mrs.service_id = s.service_id
WHERE mrs.mr_id=1;

-- Medicine lines
INSERT INTO InvoiceItem (invoice_id, item_type, ref_id, description, amount)
SELECT 1,'medicine', rxi.rx_item_id,
       CONCAT('Thuốc: ', m.name, ' x', rxi.qty),
       m.price * rxi.qty
FROM PrescriptionItem rxi JOIN Medicine m ON rxi.medicine_id=m.medicine_id
WHERE rxi.rx_id=1;

-- Lab test line (giá demo)
INSERT INTO InvoiceItem (invoice_id, item_type, ref_id, description, amount)
SELECT 1,'lab', lt.labtest_id, CONCAT('Xét nghiệm: ', lt.type), 120000
FROM LabTest lt WHERE lt.mr_id=1;

-- Cập nhật tổng tiền hoá đơn
UPDATE Invoice i
JOIN (SELECT invoice_id, SUM(amount) AS total FROM InvoiceItem GROUP BY invoice_id) t
  ON i.invoice_id=t.invoice_id
SET i.total_amount=t.total;
-- 1) Tạm tắt safe mode cho session
SET SQL_SAFE_UPDATES = 0;UPDATE Invoice i
JOIN (
  SELECT invoice_id, SUM(amount) AS total
  FROM InvoiceItem
  GROUP BY invoice_id
) t ON i.invoice_id = t.invoice_id
SET i.total_amount = t.total;


-- 2) Cập nhật tổng tiền cho TẤT CẢ hóa đơn từ bảng InvoiceItem
UPDATE Invoice i
JOIN (
  SELECT invoice_id, SUM(amount) AS total
  FROM InvoiceItem
  GROUP BY invoice_id
) t ON i.invoice_id = t.invoice_id
SET i.total_amount = t.total;
SELECT invoice_id, total_amount FROM Invoice;
