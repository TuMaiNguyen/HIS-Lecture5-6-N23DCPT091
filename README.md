HIS – Hospital Information System (Lab)

Sinh viên: Nguyễn Đỗ Tú Mai
MSSV: N23DCPT091
Môn: Nhập môn Công nghệ Phần mềm

1) Mục tiêu bài làm

Thiết kế CSDL HIS (đăng ký khám, EMR, xét nghiệm, kê đơn, viện phí).

Cung cấp script tạo bảng, seed dữ liệu, trigger tự tính tổng tiền, view báo cáo.

Kèm use case diagram và đáp án phần củng cố lý thuyết bài 5 (Lecture 5–6).


2) Cấu trúc repo (tóm tắt các tệp quan trọng cho phần CASE STUDY cuối bài LECTURE 5)
CASE STUDY:  ĐẶC TẢ PHẦN MỀM QUẢN LÝ KHÁM CHỮA BỆNH CHO BỆNH VIỆN CHỢ RẪY
Database & Script

his_schema_choray.sql – tạo database his_choray và toàn bộ bảng.

his_seed.sql – nạp dữ liệu mẫu (appointment, EMR, lab, thuốc, invoice…) + cập nhật tổng tiền.

his_triggers.sql – 3 trigger tự động cập nhật Invoice.total_amount khi thêm/sửa/xoá InvoiceItem.

his_views.sql – view v_invoice_detail, v_mr_overview.

his_checks.sql – câu lệnh đối chiếu tổng tiền & có chèn MSSV.

run_all_N23DCPT091.sql – chạy tất cả theo đúng thứ tự 

Tài liệu/ảnh kèm theo

ERD_HIS_from_SQL.png – EER Diagram export từ MySQL Workbench.

ERD_HIS_from_SQL.mwb – file model Workbench (mở sửa/Export lại).

screenshot_invoice_total.png, screenshot_labsubmission.png – bằng chứng chạy thật.

3) Bài củng cố lý thuyết & Use Case (Lecture 5–6)
## Use Case (Lecture 5–6)

> Sơ đồ use case hệ thống đặt phòng khách sạn.

<a href="<usecasediagramLECTURE5-6-requirements(bài5).png>">
  <img src="<usecasediagramLECTURE5-6-requirements(bài5).png>" alt="Use Case – Hệ thống Đặt Phòng" width="100%">
</a>

- File ảnh gốc: `usecasediagramLECTURE5-6-requirements(bài5).png`
- Bài giải lý thuyết: [`NGUYỄN ĐỖ TÚ MAI-N23DCPT091-LECTURE5&6-requirements analysis.pdf`](NGUYỄN%20ĐỖ%20TÚ%20MAI-N23DCPT091-LECTURE5%266-requirements%20analysis.pdf)

Chạy run_all_N23DCPT091.sql.

Kiểm tra 3 truy vấn ở mục 4).

Mở ERD_HIS_from_SQL.png đối chiếu mô hình.

Xem NGUYỄN ĐỖ TÚ MAI-N23DCPT091-LECTURE5&6-requirements analysis.pdf để duyệt phần Câu hỏi củng cố lý thuyết; tham chiếu use case ở ảnh PNG.
