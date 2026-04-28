--Кількість пацієнтів
SELECT COUNT(*) AS total_patient FROM Patient;

--Середній досвід
SELECT AVG(Experience) AS avg_experience FROM Doctor;

--Показує максимальний досвід
SELECT MAX(Experience) AS max_experience FROM Doctor;

--Підраховує загальну кількість лікувань
SELECT COUNT(*) AS total_treatment FROM Treatment;

--Групує по гендеру
SELECT Gender, COUNT(*) AS count FROM Patient 
GROUP BY Gender;

--Рахує кількість записів в палаті
SELECT WardNumber, COUNT(*) AS count FROM Ward
GROUP BY WardNumber;

--Кількість лікувань у лікарів
SELECT DoctorID, COUNT(*) AS treatment_count 
FROM Treatment
GROUP BY DoctorID;

--Групувати скільки груп лікарів з однаковим досвідом
SELECT Experience, COUNT(*) AS exp_count FROM Doctor
GROUP BY Experience
HAVING COUNT(*) > 1;

--Пацієнт та лікування
SELECT p.Name, p.Surname, t.Medication FROM Patient p
INNER JOIN Treatment t ON p.PatientID = t.PatientID;

--Показати пацієнта, його лікаря та діагноз користуючись джоїн
SELECT p.Name, d.Name AS doctor_name, diag.NameOfDiagnosis FROM Treatment t 
JOIN Patient p ON t.PatientID = p.PatientID
JOIN Doctor d ON t.DoctorID = d.DoctorID
JOIN Diagnosis diag ON t.DiagnosisID = diag.DiagnosisID;

--Об'єднати та показати таблицю пацієнта та його лікування
SELECT p.Name, t.Medication FROM Patient p 
LEFT JOIN Treatment t ON p.PatientID = t.PatientID;

--Показати пацієнтів, у яких є лікування
SELECT * 
FROM Patient
WHERE PatientID IN(
	SELECT PatientID FROM Treatment
);

--Показати лікарів, у яких досвід більший за середній
SELECT * FROM Doctor
WHERE Experience > (
	SELECT AVG(Experience) FROM Doctor
);

--Окремо для кожного пацієнта кількість лікувань
SELECT Name,
	(SELECT COUNT(*) FROM Treatment t
	WHERE t.PatientID = p.PatientID) AS treatments_count
FROM Patient p;

--Кількість лікування для кожного пацієнта
SELECT p.Name, COUNT(t.TreatmentID) AS treatments_count FROM Patient p
LEFT JOIN Treatment t ON p.PatientID = t.PatientID 
GROUP BY p.Name; 

