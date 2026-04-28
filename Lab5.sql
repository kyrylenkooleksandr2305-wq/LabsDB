DROP TABLE IF EXISTS Hospitalization CASCADE;
DROP TABLE IF EXISTS Treatment CASCADE;
DROP TABLE IF EXISTS Bed CASCADE;
DROP TABLE IF EXISTS Ward CASCADE;
DROP TABLE IF EXISTS Diagnosis CASCADE;
DROP TABLE IF EXISTS Doctor CASCADE;
DROP TABLE IF EXISTS Patient CASCADE;


-- 1. Таблиця Patient
CREATE TABLE Patient (
    PatientID   SERIAL PRIMARY KEY,
    Name        VARCHAR(50) NOT NULL,
    Surname     VARCHAR(50) NOT NULL,
    Gender      VARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
    DateOfBirth DATE NOT NULL
);

-- 2. Таблиця Doctor
CREATE TABLE Doctor (
    DoctorID       SERIAL PRIMARY KEY,
    Name           VARCHAR(50) NOT NULL,
    Surname        VARCHAR(50) NOT NULL,
    Specialization VARCHAR(100) NOT NULL,
    Experience     INTEGER CHECK (Experience >= 0)
);

-- 3. Таблиця Ward
CREATE TABLE Ward (
    WardID     SERIAL PRIMARY KEY,
    WardNumber VARCHAR(10) NOT NULL,
    Capacity   INTEGER NOT NULL CHECK (Capacity > 0)
);

-- 4. Таблиця Diagnosis
CREATE TABLE Diagnosis (
    DiagnosisID      SERIAL PRIMARY KEY,
    NameOfDiagnosis  VARCHAR(100) NOT NULL,
    Stage            VARCHAR(50),
    Description      TEXT
);

-- 5. Таблиця Treatment
CREATE TABLE Treatment (
    TreatmentID SERIAL PRIMARY KEY,
    PatientID   INTEGER NOT NULL,
    DoctorID    INTEGER NOT NULL,
    DiagnosisID INTEGER NOT NULL,
    Medication  VARCHAR(100),
    StartDate   DATE NOT NULL,
    EndDate     DATE,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    FOREIGN KEY (DiagnosisID) REFERENCES Diagnosis(DiagnosisID),
    CHECK (EndDate IS NULL OR EndDate >= StartDate)
);

-- 6. Таблиця Hospitalization
CREATE TABLE Hospitalization (
    HospitalizationID SERIAL PRIMARY KEY,
	BedID             INTEGER NOT NULL,
    PatientID         INTEGER NOT NULL,
    AdmissionDate     DATE NOT NULL,
    DischargeDate     DATE,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    CHECK (DischargeDate IS NULL OR DischargeDate >= AdmissionDate)
);

--7. Таблиця Bed
CREATE TABLE Bed (
	BedID SERIAL PRIMARY KEY,
	WardID INTEGER NOT NULL REFERENCES Ward(WardID),
	BedNumber VARCHAR(100) NOT NULL,
	UNIQUE (WardID, BedNumber)
);

INSERT INTO Patient (Name, Surname, Gender, DateOfBirth) VALUES
    ('Olena', 'Tsindarova', 'Female', '2000-10-20'),
    ('Artem', 'Epsteiko', 'Male', '2005-04-20'),
    ('Oleksandr', 'Bechkal', 'Male', '1998-08-10'),
	('Volodymyr', 'Kuznenko', 'Male', '1965-10-12'),
	('Maria', 'Badrak', 'Female', '1975-10-10');

INSERT INTO Doctor (Name, Surname, Specialization, Experience) VALUES
    ('Anatoliy', 'Bulhakov', 'Cardiology', 22),
    ('Oleksandr', 'Kupchenko', 'Surgery', 10),
    ('Victoria', 'Izotonova', 'Therapy', 5),
	('Vasyl', 'Petrenko', 'Psychotherapist', 17 ),
	('Denis', 'Kozakov', 'Dermatologist', 12);

INSERT INTO Ward (Capacity, WardNumber) VALUES
    (2, 'A1'),
	(4, 'A2');

INSERT INTO Diagnosis (NameOfDiagnosis, Stage, Description) VALUES
    ('Flu', 'Mild', 'Common viral infection'),
    ('Fracture', 'Severe', 'Bone fracture'),
    ('Hypertension', 'Chronic', 'High blood pressure'),
	('Shizophrenia', 'Intial', 'Psychological illness'),
	('Lichen', 'Vezicular', 'Skin illness' );

INSERT INTO Treatment (PatientID, DoctorID, DiagnosisID, Medication, StartDate, EndDate) VALUES
    (1, 1, 1, 'Paracetamol', '2020-12-20', NULL),
    (2, 2, 2, 'Painkillers', '2020-12-21', '2021-01-25'),
    (3, 3, 3, 'Beta blockers', '2021-05-12', '2021-06-12'),
	(4, 4, 4, 'Antipsychotic drug', '2021-06-03', '2021-07-06'),
	(5, 5, 5, 'Clobetasol Propionate', '2021-06-03', NULL);

INSERT INTO Hospitalization (BedID, PatientID, AdmissionDate, DischargeDate) VALUES
    (1, 1, '2020-12-20', NULL),
    (2, 2, '2020-12-21', '2021-01-25'),
    (3, 3, '2021-05-12', '2021-06-12'),
	(4, 4, '2021-06-03', '2021-07-06'),
	(5, 5, '2021-06-03', NULL);

INSERT INTO Bed (WardID,BedNumber) VALUES
	(1, 1), (1, 2),
	(2, 1), (2, 2), (2, 3), (2, 4);

--Перевірка чи все правильно працює:
SELECT 
	p.Name,
	p.Surname,
	w.WardNumber,
	b.BedNumber
FROM Hospitalization h
JOIN Patient p ON h.PatientID = p.PatientID
JOIN Bed b ON h.BedID = b.BedID
JOIN Ward w ON b.WardID = w.WardID;