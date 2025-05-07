-- Question 1 --
-- Create the database --
CREATE DATABASE clinic_booking;
USE clinic_booking;

-- Create Departments Table --
CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Create Doctors Table -- 
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Create Specializations Table --
CREATE TABLE Specializations (
    specialization_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Create Junction Table for Doctor-Specialization (Many-to-Many) --
CREATE TABLE Doctor_Specializations (
    doctor_id INT NOT NULL,
    specialization_id INT NOT NULL,
    PRIMARY KEY (doctor_id, specialization_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (specialization_id) REFERENCES Specializations(specialization_id)
);

-- Create Patients Table -- 
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    dob DATE NOT NULL
);

-- Create Appointments Table -- 
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Create Prescriptions Table --  
CREATE TABLE Prescriptions (
    prescription_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT NOT NULL,
    notes TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Insert Sample Data --  

-- Insert Departments --
INSERT INTO Departments (name) VALUES
('Cardiology'),
('Ob/Gyn'),
('Neurology'),
('Pediatrics');

-- Insert Specializations --
INSERT INTO Specializations (name) VALUES
('Cardiologist'),
('Gynecologist'),
('Neurologist'),
('Pediatrician'),
('General Practitioner');

-- Insert Doctors --
INSERT INTO Doctors (name, email, department_id) VALUES
('Dr. Mbwavi Joy', 'Joy.Mbwavi@ponaclinic.com', 1),
('Dr. Bob Mududa', 'Bob.Mududa@ponaclinic.com', 2),
('Dr. Clara Patel', 'Clara.Patel@ponaclinic.com', 3),
('Dr. Waceke Susan', 'Susan.Watel@ponaclinic.com', 4)
;

-- Link Doctors to Specializations --
INSERT INTO Doctor_Specializations (doctor_id, specialization_id) VALUES
(1, 1), -- Dr. Joy -> Cardiologist
(2, 2), -- Dr. Bob -> Gynecologist
(3, 3), -- Dr. Clara -> Neurologist
(4, 4), -- Dr. Susan -> Pediatrician
(4, 5); -- Dr. Susan -> Also a General Practitioner

-- Insert Patients --
INSERT INTO Patients (name, email, dob) VALUES
('Mwangi Joan', 'joanmwangi@gmail.com', '1985-05-05'),
('Mwaniki Louis', 'louismwaniki@yahoo.com', '1992-10-12'),
('Michelle Upendo', 'upendom@outlook.com', '2001-11-30'),
('Nathan Taji', 'Natetaji@gmail.com', '2013-09-21')
;

-- Insert Appointments --
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, '2025-05-05 09:00:00', 'Completed'),
(2, 2, '2025-05-06 10:30:00', 'Scheduled'),
(3, 3, '2025-05-07 08:45:00', 'Cancelled'),
(4, 1, '2025-05-08 11:15:00', 'Scheduled'),
(1, 3, '2025-05-09 14:00:00', 'Completed');

-- Insert Prescriptions --
INSERT INTO Prescriptions (appointment_id, notes) VALUES
(1, 'Take 2 tablets of aspirin daily after meals.'),
(2, 'MRI scan recommended before next visit.'),
(3, 'Prescribed rest and hydration. Follow-up in one week.'),
(4, 'Blood pressure medication. Monitor daily.'),
(5, 'Refer to neurologist. EEG test advised.');