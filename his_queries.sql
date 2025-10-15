-- Lịch khám theo bác sĩ & thời điểm
SELECT a.appointment_id, p.full_name AS patient, d.full_name AS doctor,
       a.scheduled_at, a.status
FROM Appointment a
JOIN Patient p ON p.patient_id=a.patient_id
JOIN Doctor d  ON d.doctor_id=a.doctor_id
ORDER BY a.scheduled_at;

-- Hồ sơ bệnh án + xét nghiệm + đơn thuốc (gộp tên)
SELECT mr.mr_id, p.full_name AS patient, d.full_name AS doctor,
       mr.created_at, mr.diagnosis,
       GROUP_CONCAT(DISTINCT lt.type SEPARATOR ', ') AS lab_tests,
       GROUP_CONCAT(DISTINCT m.name SEPARATOR ', ')  AS medicines
FROM MedicalRecord mr
JOIN Patient p ON p.patient_id=mr.patient_id
JOIN Doctor d  ON d.doctor_id=mr.doctor_id
LEFT JOIN LabTest lt ON lt.mr_id=mr.mr_id
LEFT JOIN Prescription rx ON rx.mr_id=mr.mr_id
LEFT JOIN PrescriptionItem rxi ON rxi.rx_id=rx.rx_id
LEFT JOIN Medicine m ON m.medicine_id=rxi.medicine_id
GROUP BY mr.mr_id;

-- Doanh thu theo ngày (tổng tiền hoá đơn đã xuất)
SELECT DATE(issued_at) AS day, SUM(total_amount) AS revenue
FROM Invoice
GROUP BY DATE(issued_at)
ORDER BY day DESC;
