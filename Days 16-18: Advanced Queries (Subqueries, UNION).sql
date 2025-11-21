### Practice Questions:

-- 1. Find patients who are in services with above-average staff count.
SELECT PATIENT_ID, NAME, SERVICE FROM PATIENTS WHERE SERVICE IN (
	SELECT SERVICE FROM STAFF GROUP BY SERVICE HAVING COUNT(*) > (
		SELECT AVG(STAFF_COUNT) FROM (
        SELECT SERVICE, COUNT(*) AS STAFF_COUNT FROM STAFF GROUP BY SERVICE) AS STAFF_COUNTS));
-- 2. List staff who work in services that had any week with patient satisfaction below 70.
SELECT STAFF_ID, STAFF_NAME, SERVICE FROM STAFF WHERE SERVICE IN 
	(SELECT SERVICE FROM SERVICES_WEEKLY WHERE PATIENT_SATISFACTION < 70);
-- 3. Show patients from services where total admitted patients exceed 1000.
SELECT * FROM PATIENTS WHERE SERVICE IN (
	SELECT SERVICE FROM SERVICES_WEEKLY GROUP BY SERVICE HAVING SUM(PATIENTS_ADMITTED) > 1000);
    
### Daily Challenge:

-- **Question:** Find all patients who were admitted to services that had at least one week where patients were refused AND 
-- the average patient satisfaction for that service was below the overall hospital average satisfaction.
-- Show patient_id, name, service, and their personal satisfaction score.
SELECT patient_id, name, service, satisfaction AS patient_satisfaction 
FROM patients 
WHERE service IN (
    SELECT service
    FROM services_weekly
    GROUP BY service
    HAVING MAX(patients_refused) > 0 AND AVG(patient_satisfaction) < (
            SELECT AVG(patient_satisfaction) FROM services_weekly
        )
);
