HIS – Hospital Information System (Lab)

Sinh viên: Nguyễn Đỗ Tú Mai
MSSV: N23DCPT091
Môn: Nhập môn Công nghệ Phần mềm

1) Mục tiêu bài làm

Thiết kế CSDL HIS (đăng ký khám, EMR, xét nghiệm, kê đơn, viện phí).

Cung cấp script tạo bảng, seed dữ liệu, trigger tự tính tổng tiền, view báo cáo.

Kèm use case diagram và đáp án lý thuyết (Lecture 5–6).

Có “dấu vết” MSSV trong DB để xác thực người thực hiện.

2) Cấu trúc repo (tóm tắt các tệp quan trọng)
Database & Script

his_schema_choray.sql – tạo database his_choray và toàn bộ bảng.

his_seed.sql – nạp dữ liệu mẫu (appointment, EMR, lab, thuốc, invoice…) + cập nhật tổng tiền.

his_triggers.sql – 3 trigger tự động cập nhật Invoice.total_amount khi thêm/sửa/xoá InvoiceItem.

his_views.sql – view v_invoice_detail, v_mr_overview.

his_checks.sql – câu lệnh đối chiếu tổng tiền & kiểm tra “dấu vết” MSSV.

run_all_N23DCPT091.sql – chạy một phát tất cả theo đúng thứ tự (khuyên dùng khi chấm).

Tài liệu/ảnh kèm theo

ERD_HIS_from_SQL.png – EER Diagram export từ MySQL Workbench.

ERD_HIS_from_SQL.mwb – file model Workbench (mở sửa/Export lại).

screenshot_invoice_total.png, screenshot_labsubmission.png – bằng chứng chạy thật.

Bài lý thuyết & Use Case (Lecture 5–6)

NGUYỄN ĐỖ TÚ MAI-N23DCPT091-LECTURE5&6-requirements analysis.pdf – bài giải Câu hỏi củng cố lý thuyết (lecture 5–6).

usecasediagramLECTURE5-6-requirements(bài5).png – Use Case Diagram hệ thống đặt phòng khách sạn (bài 5).

Ghi chú: GitHub có thể hiển thị tiếng Việt có dấu trong tên file; nếu gặp lỗi xem trực tiếp, dùng nút Download để tải.

3) Cách chạy (MySQL Workbench)
Cách A – One-click

File → Open SQL Script… → mở run_all_N23DCPT091.sql

Bấm Execute (tia sét).

Cách B – Từng bước

Chạy his_schema_choray.sql

Chạy his_seed.sql

(Khuyến nghị) his_triggers.sql

(Khuyến nghị) his_views.sql

his_checks.sql

Script cập nhật tổng tiền dùng WHERE invoice_id IN (...) nên không cần tắt Safe Update Mode.

4) Kiểm tra nhanh sau khi chạy
USE his_choray;

-- Dấu vết MSSV (bảng nộp bài)
SELECT * FROM LabSubmission ORDER BY saved_at DESC;

-- Tổng tiền hoá đơn (đã cộng từ InvoiceItem)
SELECT invoice_id, total_amount FROM Invoice;

-- “Watermark” bệnh nhân chứa MSSV
SELECT patient_id, national_id, full_name
FROM Patient
WHERE national_id = 'N23DCPT091';

5) ERD & Use Case

ERD: mở ERD_HIS_from_SQL.png (hoặc file .mwb để tùy chỉnh/layout lại rồi Export).

Use Case (Lecture 5–6 – bài 5): xem usecasediagramLECTURE5-6-requirements(bài5).png.

6) Thành phần chính của CSDL

Thực thể: Patient, Doctor, Appointment, MedicalRecord, LabTest,
Prescription, PrescriptionItem, Medicine, MedicalService, MR_Service,
Invoice, InvoiceItem.

Ràng buộc: PK/ FK đầy đủ; chỉ mục tra cứu theo bác sĩ–thời gian; trigger đồng bộ tổng tiền.

7) Thông tin tác giả

Nguyễn Đỗ Tú Mai – N23DCPT091

Bài thực hành môn Nhập môn Công nghệ Phần mềm (Requirements & Analysis → HIS + Lý thuyết Lecture 5–6).

8) Hướng dẫn chấm nhanh (gợi ý)

Chạy run_all_N23DCPT091.sql.

Kiểm tra 3 truy vấn ở mục 4).

Mở ERD_HIS_from_SQL.png đối chiếu mô hình.

Xem NGUYỄN ĐỖ TÚ MAI-N23DCPT091-LECTURE5&6-requirements analysis.pdf để duyệt phần Câu hỏi củng cố lý thuyết; tham chiếu use case ở ảnh PNG.
