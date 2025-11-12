--  Day 1: Basic SELECT Queries

-- PRACTICE QUESTIONS

-- 1️.  Retrieve all columns from the `patients` table.
SELECT * FROM patients;
-- 2️. Select only the `patient_id`, `name`, and `age` columns from the `patients` table.
SELECT patient_id, name, age FROM patients;
-- 3️. Display the first 10 records from the `services_weekly` table.
SELECT * FROM services_weekly LIMIT 10;


--  DAILY CHALLENGE
-- Question: List all unique hospital services available in the hospital.
SELECT DISTINCT service FROM services_weekly;

/* 
==================================================
 DAY 2: Filtering and WHERE Conditions
==================================================
*/

-- PRACTICE QUESTIONS

-- 1️. Find all patients who are older than 60 years.
SELECT name, age 
FROM patients 
WHERE age > 60;

-- 2️. Retrieve all staff members who work in the 'Emergency' service.
SELECT name, service 
FROM patients 
WHERE service = 'Emergency';

-- 3️. List all weeks where more than 100 patients requested admission in any service.
SELECT week, patients_request 
FROM services_weekly 
WHERE patients_request > 100;


-- DAILY CHALLENGE
-- Question: Find all patients admitted to 'Surgery' service with a satisfaction score below 70,
-- showing their patient_id, name, age, and satisfaction score.
SELECT patient_id, name, age, satisfaction 
FROM patients 
WHERE service = 'Surgery' 
AND satisfaction < 70;

/* 
==================================================
DAY 3: Sorting Data with ORDER BY
==================================================
*/
--  PRACTICE QUESTIONS
-- 1. List all patients sorted by age in descending order.
SELECT NAME AS PATIENTS, AGE FROM PATIENTS ORDER BY AGE DESC;
-- 2. Show all services_weekly data sorted by week number ascending and patients_request descending.
SELECT * FROM SERVICES_WEEKLY ORDER BY WEEK ASC, PATIENTS_REQUEST DESC;
-- 3. Display staff members sorted alphabetically by their names.
SELECT STAFF_NAME FROM STAFF ORDER BY STAFF_NAME;

--  Daily Challenge:
/* **Question:** Retrieve the top 5 weeks with the highest patient refusals across all services, showing week, service,
 patients_refused, and patients_request. Sort by patients_refused in descending order.*/
 SELECT WEEK, SERVICE, PATIENTS_REFUSED, PATIENTS_REQUEST
 FROM SERVICES_WEEKLY
 ORDER BY PATIENTS_REFUSED DESC
 LIMIT 5;

/* 
==================================================
DAY 4: LIMIT and OFFSET
==================================================
*/
--   Practice Questions:

-- 1. Display the first 5 patients from the patients table.
SELECT NAME FROM PATIENTS LIMIT 5;
-- 2. Show patients 11-20 using OFFSET.
SELECT NAME FROM PATIENTS LIMIT 10 OFFSET 10;
-- 3. Get the 10 most recent patient admissions based on arrival_date.
SELECT NAME, ARRIVAL_DATE FROM PATIENTS ORDER BY ARRIVAL_DATE DESC LIMIT 10;

-- Daily Challenge:

-- **Question:** Find the 3rd to 7th highest patient satisfaction scores from the patients table, 
-- showing patient_id, name, service, and satisfaction. Display only these 5 records.
SELECT PATIENT_ID, NAME, SERVICE, SATISFACTION 
FROM PATIENTS
ORDER BY SATISFACTION DESC
LIMIT 5
OFFSET 2;
