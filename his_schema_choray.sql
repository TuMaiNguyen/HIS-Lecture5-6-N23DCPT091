-- CREATE & USE SCHEMA
CREATE DATABASE IF NOT EXISTS his_choray
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;
USE his_choray;

-- DROP in dependency order (child first)
DROP TABLE IF EXISTS InvoiceItem, Invoice, MR_Service, MedicalService,
  PrescriptionItem, Medicine, Prescription, LabTest, MedicalRecord,
  Appointment, Doctor, Patient;

-- Patients & Doctors
CREATE TABLE Patient (
  patient_id   INT PRIMARY KEY AUTO_INCREMENT,
  national_id  VARCHAR(32),
  full_name    VARCHAR(120) NOT NULL,
  dob          DATE,
  phone        VARCHAR(20),
  address      VARCHAR(255)
);

CREATE TABLE Doctor (
  doctor_id  INT PRIMARY KEY AUTO_INCREMENT,
  full_name  VARCHAR(120) NOT NULL,
  specialty  VARCHAR(80),
  phone      VARCHAR(20)
);

-- Appointments
CREATE TABLE Appointment (
  appointment_id INT PRIMARY KEY AUTO_INCREMENT,
  patient_id     INT NOT NULL,
  doctor_id      INT NOT NULL,
  scheduled_at   DATETIME NOT NULL,
  status         VARCHAR(20) DEFAULT 'scheduled',
  note           VARCHAR(255),
  CONSTRAINT fk_ap_pt FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
  CONSTRAINT fk_ap_dr FOREIGN KEY (doctor_id)  REFERENCES Doctor(doctor_id),
  INDEX idx_ap_doc_time (doctor_id, scheduled_at)
);

-- Medical Record & Lab Test
CREATE TABLE MedicalRecord (
  mr_id       INT PRIMARY KEY AUTO_INCREMENT,
  patient_id  INT NOT NULL,
  doctor_id   INT NOT NULL,
  created_at  DATETIME NOT NULL,
  diagnosis   TEXT,
  note        TEXT,
  CONSTRAINT fk_mr_pt FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
  CONSTRAINT fk_mr_dr FOREIGN KEY (doctor_id)  REFERENCES Doctor(doctor_id)
);

CREATE TABLE LabTest (
  labtest_id INT PRIMARY KEY AUTO_INCREMENT,
  mr_id      INT NOT NULL,
  type       VARCHAR(80) NOT NULL,
  result     TEXT,
  taken_at   DATETIME,
  CONSTRAINT fk_lab_mr FOREIGN KEY (mr_id) REFERENCES MedicalRecord(mr_id)
);

-- Prescription
CREATE TABLE Prescription (
  rx_id      INT PRIMARY KEY AUTO_INCREMENT,
  mr_id      INT NOT NULL,
  created_at DATETIME NOT NULL,
  advice     TEXT,
  CONSTRAINT fk_rx_mr FOREIGN KEY (mr_id) REFERENCES MedicalRecord(mr_id)
);

CREATE TABLE Medicine (
  medicine_id INT PRIMARY KEY AUTO_INCREMENT,
  name        VARCHAR(120) NOT NULL,
  unit        VARCHAR(20),
  price       DECIMAL(12,2) DEFAULT 0,
  stock_qty   INT DEFAULT 0,
  expire_date DATE
);

CREATE TABLE PrescriptionItem (
  rx_item_id  INT PRIMARY KEY AUTO_INCREMENT,
  rx_id       INT NOT NULL,
  medicine_id INT NOT NULL,
  qty         INT NOT NULL,
  dosage      VARCHAR(80),
  duration    VARCHAR(80),
  CONSTRAINT fk_rxi_rx  FOREIGN KEY (rx_id)       REFERENCES Prescription(rx_id),
  CONSTRAINT fk_rxi_med FOREIGN KEY (medicine_id)  REFERENCES Medicine(medicine_id),
  INDEX idx_rxi_rx (rx_id)
);

-- Medical Services used in MR
CREATE TABLE MedicalService (
  service_id INT PRIMARY KEY AUTO_INCREMENT,
  name       VARCHAR(120) NOT NULL,
  price      DECIMAL(12,2) NOT NULL,
  dept       VARCHAR(80)
);

CREATE TABLE MR_Service (
  id         INT PRIMARY KEY AUTO_INCREMENT,
  mr_id      INT NOT NULL,
  service_id INT NOT NULL,
  qty        INT NOT NULL DEFAULT 1,
  CONSTRAINT fk_mrs_mr  FOREIGN KEY (mr_id)      REFERENCES MedicalRecord(mr_id),
  CONSTRAINT fk_mrs_srv FOREIGN KEY (service_id) REFERENCES MedicalService(service_id)
);

-- Billing
CREATE TABLE Invoice (
  invoice_id    INT PRIMARY KEY AUTO_INCREMENT,
  patient_id    INT NOT NULL,
  issued_at     DATETIME NOT NULL,
  total_amount  DECIMAL(12,2) DEFAULT 0,
  status        VARCHAR(20) DEFAULT 'unpaid',
  CONSTRAINT fk_inv_pt FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
  INDEX idx_inv_pt (patient_id)
);

CREATE TABLE InvoiceItem (
  inv_item_id INT PRIMARY KEY AUTO_INCREMENT,
  invoice_id  INT NOT NULL,
  item_type   VARCHAR(20) NOT NULL, -- service|lab|medicine|other
  ref_id      INT,                  -- MR_Service.id / LabTest.labtest_id / PrescriptionItem.rx_item_id
  description VARCHAR(255),
  amount      DECIMAL(12,2) NOT NULL,
  CONSTRAINT fk_invi_inv FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id),
  INDEX idx_invi_inv (invoice_id)
);
