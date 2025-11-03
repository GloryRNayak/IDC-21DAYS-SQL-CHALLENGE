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

