-- 🗓️ Day 1: Basic SELECT Queries

--🧠 PRACTICE QUESTIONS

-- 1️⃣ Retrieve all columns from the `patients` table.
SELECT * FROM patients;
-- 2️⃣ Select only the `patient_id`, `name`, and `age` columns from the `patients` table.
SELECT patient_id, name, age FROM patients;
-- 3️⃣ Display the first 10 records from the `services_weekly` table.
SELECT * FROM services_weekly LIMIT 10;


-- 🏆 DAILY CHALLENGE
-- Question: List all unique hospital services available in the hospital.
SELECT DISTINCT service FROM services_weekly;

/* 
==================================================
🗓️ DAY 2: Filtering and WHERE Conditions
==================================================
*/

-- 🧠 PRACTICE QUESTIONS

-- 1️⃣ Find all patients who are older than 60 years.
SELECT name, age 
FROM patients 
WHERE age > 60;

-- 2️⃣ Retrieve all staff members who work in the 'Emergency' service.
SELECT name, service 
FROM patients 
WHERE service = 'Emergency';

-- 3️⃣ List all weeks where more than 100 patients requested admission in any service.
SELECT week, patients_request 
FROM services_weekly 
WHERE patients_request > 100;


-- 🏆 DAILY CHALLENGE
-- Question: Find all patients admitted to 'Surgery' service with a satisfaction score below 70,
-- showing their patient_id, name, age, and satisfaction score.
SELECT patient_id, name, age, satisfaction 
FROM patients 
WHERE service = 'Surgery' 
AND satisfaction < 70;
