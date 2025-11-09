/* 
==================================================
 DAY 5: Aggregate Functions (COUNT, SUM, AVG, MIN, MAX)
==================================================
*/

--  PRACTICE QUESTIONS

-- 1.  Count the total number of patients in the hospital.
SELECT COUNT(DISTINCT patient_id) AS total_patients 
FROM patients;

-- 2.  Calculate the average satisfaction score of all patients.
SELECT ROUND(AVG(satisfaction), 2) AS avg_satisfaction 
FROM patients;

-- 3. Find the minimum and maximum age of patients.
SELECT MIN(age) AS minimum_age, MAX(age) AS maximum_age 
FROM patients;


--  DAILY CHALLENGE
-- Question: Calculate the total number of patients admitted, total patients refused,
-- and the average patient satisfaction across all services and weeks.
-- Round the average satisfaction to 2 decimal places.
SELECT 
    SUM(patients_admitted) AS total_patients,
    SUM(patients_refused) AS patients_refused,
    ROUND(AVG(patient_satisfaction), 2) AS avg_patient_satisfaction
FROM services_weekly;

/* 
==================================================
 DAY 6: GROUP BY Clause
==================================================
*/

-- Practice Questions:

-- 1. Count the number of patients by each service.
SELECT SERVICE, COUNT(*) AS TOTAL_PATIENTS FROM PATIENTS GROUP BY SERVICE;
-- 2. Calculate the average age of patients grouped by service.
SELECT SERVICE, ROUND(AVG(AGE), 2) AS AVG_AGE FROM PATIENTS GROUP BY SERVICE;
-- 3. Find the total number of staff members per role.
SELECT ROLE, COUNT(*) TOTAL_STAFF FROM STAFF GROUP BY ROLE;

-- ### Daily Challenge:
-- **Question:** For each hospital service, calculate the total number of patients admitted, total patients refused, 
-- and the admission rate (percentage of requests that were admitted). Order by admission rate descending.
SELECT SERVICE, 
	SUM(PATIENTS_ADMITTED) AS TOTAL_PATIENTS_ADM, 
	SUM(PATIENTS_REFUSED) AS TOTAL_REFUSED,
    ROUND((SUM(PATIENTS_ADMITTED)/SUM(PATIENTS_REQUEST) * 100),2) AS ADMISSION_RATE
    FROM SERVICES_WEEKLY GROUP BY SERVICE ORDER BY ADMISSION_RATE DESC;
