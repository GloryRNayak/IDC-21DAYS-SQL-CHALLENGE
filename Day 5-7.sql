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

/* 
==================================================
 DAY 7: HAVING Clause
==================================================
*/

-- Practice Questions:
-- 1. Find services that have admitted more than 500 patients in total.
SELECT 
	SERVICE, SUM(PATIENTS_ADMITTED) AS TOTAL_ADMITTED 
FROM SERVICES_WEEKLY 
GROUP BY SERVICE 
HAVING SUM(PATIENTS_ADMITTED) > 500;
-- 2. Show services where average patient satisfaction is below 75.
SELECT 
	SERVICE, AVG(PATIENT_SATISFACTION) AS AVG_SATISFACTION 
FROM SERVICES_WEEKLY 
GROUP BY SERVICE 
HAVING AVG(PATIENT_SATISFACTION) < 75;
-- 3. List weeks where total staff presence across all services was less than 50.
SELECT 
    week, service, SUM(present) AS total_staff_presence
FROM staff_schedule
GROUP BY week, service
HAVING SUM(present) < 50;


-- Daily Challenge:

-- **Question:** Identify services that refused more than 100 patients in total and had an average patient satisfaction below 80. 
-- Show service name, total refused, and average satisfaction.
SELECT 
	SERVICE, 
    SUM(PATIENTS_REFUSED) AS TOTAL_REFUSED, 
    ROUND(AVG(PATIENT_SATISFACTION),2) AS AVG_SATISFACTION
FROM SERVICES_WEEKLY
GROUP BY SERVICE
HAVING SUM(PATIENTS_REFUSED) > 100 AND AVG(PATIENT_SATISFACTION) < 80;


