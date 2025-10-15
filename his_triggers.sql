USE his_choray;

DELIMITER $$
CREATE TRIGGER trg_invoiceitem_ai
AFTER INSERT ON InvoiceItem
FOR EACH ROW
BEGIN
  UPDATE Invoice i
  SET i.total_amount = (
    SELECT COALESCE(SUM(amount),0) FROM InvoiceItem WHERE invoice_id = NEW.invoice_id
  )
  WHERE i.invoice_id = NEW.invoice_id;
END$$

CREATE TRIGGER trg_invoiceitem_au
AFTER UPDATE ON InvoiceItem
FOR EACH ROW
BEGIN
  UPDATE Invoice i
  SET i.total_amount = (
    SELECT COALESCE(SUM(amount),0) FROM InvoiceItem WHERE invoice_id = NEW.invoice_id
  )
  WHERE i.invoice_id = NEW.invoice_id;
END$$

CREATE TRIGGER trg_invoiceitem_ad
AFTER DELETE ON InvoiceItem
FOR EACH ROW
BEGIN
  UPDATE Invoice i
  SET i.total_amount = (
    SELECT COALESCE(SUM(amount),0) FROM InvoiceItem WHERE invoice_id = OLD.invoice_id
  )
  WHERE i.invoice_id = OLD.invoice_id;
END$$
DELIMITER ;
