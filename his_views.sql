USE his_choray;

CREATE OR REPLACE VIEW v_invoice_detail AS
SELECT i.invoice_id, p.full_name AS patient, i.issued_at, i.status,
       ii.item_type, ii.description, ii.amount, i.total_amount
FROM Invoice i
JOIN Patient p   ON p.patient_id = i.patient_id
LEFT JOIN InvoiceItem ii ON ii.invoice_id = i.invoice_id;

CREATE OR REPLACE VIEW v_mr_overview AS
SELECT mr.mr_id, p.full_name AS patient, d.full_name AS doctor,
       mr.created_at, mr.diagnosis,
       GROUP_CONCAT(DISTINCT lt.type ORDER BY lt.type SEPARATOR ', ') AS lab_tests,
       GROUP_CONCAT(DISTINCT m.name ORDER BY m.name SEPARATOR ', ')  AS medicines
FROM MedicalRecord mr
JOIN Patient p ON p.patient_id = mr.patient_id
JOIN Doctor  d ON d.doctor_id  = mr.doctor_id
LEFT JOIN LabTest lt         ON lt.mr_id = mr.mr_id
LEFT JOIN Prescription rx    ON rx.mr_id = mr.mr_id
LEFT JOIN PrescriptionItem rxi ON rxi.rx_id = rx.rx_id
LEFT JOIN Medicine m         ON m.medicine_id = rxi.medicine_id
GROUP BY mr.mr_id;
