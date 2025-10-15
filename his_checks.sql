USE his_choray;

-- Tổng từng hóa đơn tính lại từ InvoiceItem
SELECT ii.invoice_id, SUM(ii.amount) AS calc_total
FROM InvoiceItem ii
GROUP BY ii.invoice_id;

-- So sánh tổng trong Invoice vs tính lại
SELECT i.invoice_id, i.total_amount, t.calc_total,
       (i.total_amount = t.calc_total) AS is_match
FROM Invoice i
JOIN (
  SELECT invoice_id, SUM(amount) AS calc_total
  FROM InvoiceItem GROUP BY invoice_id
) t ON i.invoice_id = t.invoice_id
ORDER BY i.invoice_id;
