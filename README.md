# HIS-Lecture5-6-N23DCPT091
HIS – Hospital Information System (Lab)

Sinh viên: Nguyễn Đỗ Tú Mai
MSSV: N23DCPT091

1) Mục tiêu

Thiết kế CSDL cho hệ thống HIS (đăng ký khám, EMR, xét nghiệm, kê đơn, thanh toán).

Cung cấp script tạo bảng, seed dữ liệu, trigger tự tính tổng tiền, view báo cáo.

Đính kèm “dấu vết” MSSV trong DB để xác thực người thực hiện.

2) Yêu cầu môi trường

MySQL Server 8.x, MySQL Workbench 8.x

Collation khuyến nghị: utf8mb4_0900_ai_ci

3) Cấu trúc thư mục
.
├─ his_schema_choray.sql                # Tạo database + bảng
├─ his_seed.sql                         # Seed dữ liệu mẫu + cập nhật tổng tiền
├─ his_triggers.sql                     # Trigger tự động cập nhật total_amount
├─ his_views.sql                        # View báo cáo
├─ his_student_meta_N23DCPT091.sql      # Dấu vết MSSV + Patient “watermark”
├─ his_checks.sql                       # Câu lệnh kiểm tra nhanh
├─ run_all_N23DCPT091.sql               # Chạy tất cả theo thứ tự
└─ (tùy chọn) ERD_HIS_from_SQL.png      # Ảnh ERD xuất từ Workbench

4) Cách chạy (MySQL Workbench)
Cách A – One click

File → Open SQL Script… → mở run_all_N23DCPT091.sql

Bấm Execute (tia sét).

Cách B – Từng bước

Mở & chạy his_schema_choray.sql

Mở & chạy his_seed.sql

(Tuỳ chọn) his_triggers.sql

(Tuỳ chọn) his_views.sql

his_student_meta_N23DCPT091.sql

his_checks.sql

Lưu ý: Script đã dùng câu UPDATE ... WHERE invoice_id IN (...) nên không cần tắt Safe Update Mode.

5) Kiểm tra nhanh (đối chiếu kết quả)

Chạy các câu sau để xác nhận cấu hình đúng:

USE his_choray;

-- Dấu vết MSSV
SELECT * FROM LabSubmission ORDER BY saved_at DESC;

-- Tổng tiền hoá đơn (đã tự cộng)
SELECT invoice_id, total_amount FROM Invoice;

-- “Watermark” Patient chứa MSSV
SELECT patient_id, national_id, full_name
FROM Patient
WHERE national_id = 'N23DCPT091';

6) Các bảng chính

Patient, Doctor, Appointment

MedicalRecord, LabTest, Prescription, PrescriptionItem, Medicine

MedicalService, MR_Service

Invoice, InvoiceItem

Triggers

trg_invoiceitem_ai, trg_invoiceitem_au, trg_invoiceitem_ad
→ Tự động cập nhật Invoice.total_amount khi thêm/sửa/xoá InvoiceItem.

Views

v_invoice_detail: Hoá đơn + dòng chi tiết + tổng tiền.

v_mr_overview: Tổng quan hồ sơ bệnh án (lab + thuốc gộp).

7) ERD / Cách xuất ảnh

MySQL Workbench:
Database → Reverse Engineer… → chọn schema his_choray → Finish → Layout → Auto Layout → File → Export → PNG
→ Lưu thành ERD_HIS_from_SQL.png (đính kèm trong repo nếu cần).

8) Gợi ý câu truy vấn báo cáo
-- Lịch khám theo thời gian
SELECT a.appointment_id, p.full_name AS patient, d.full_name AS doctor,
       a.scheduled_at, a.status
FROM Appointment a
JOIN Patient p ON p.patient_id=a.patient_id
JOIN Doctor  d ON d.doctor_id=a.doctor_id
ORDER BY a.scheduled_at;

-- Doanh thu theo ngày
SELECT DATE(issued_at) AS day, SUM(total_amount) AS revenue
FROM Invoice
GROUP BY DATE(issued_at)
ORDER BY day DESC;

9) Ghi chú kỹ thuật

Tất cả script idempotent: có thể chạy lại nhiều lần; nếu lỗi do tồn tại, hãy Refresh schema và chạy his_schema_choray.sql trước.

Nếu cần tắt/bật Safe Update Mode theo phiên:

SET SQL_SAFE_UPDATES = 0;  -- tắt
-- ... chạy lệnh cập nhật ...
SET SQL_SAFE_UPDATES = 1;  -- bật lại

10) Tác giả

Nguyễn Đỗ Tú Mai – N23DCPT091

Bài thực hành CASE STUDY của lECTURE 5&6 môn Nhập môn Công nghệ Phần mềm – chủ đề Requirements & Analysis → HIS.
