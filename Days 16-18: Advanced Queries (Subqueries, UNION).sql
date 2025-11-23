/* 
==================================================
 DAY 16:  Subqueries (WHERE clause)
==================================================
*/

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


/* 
==================================================
 DAY 17:  Subqueries (SELECT and FROM clause)
==================================================
*/

### Daily Challenge:

-- **Question:** Create a report showing each service with: service name, total patients admitted,
--  the difference between their total admissions and the average admissions across all services, and a rank indicator
--  ('Above Average', 'Average', 'Below Average'). Order by total patients admitted descending.
SELECT 
    s.service,
    s.total_admitted,
    s.total_admitted - (SELECT 
            AVG(x.service_total)
        FROM
            (SELECT 
                SUM(patients_admitted) AS service_total
            FROM
                services_weekly
            GROUP BY service) AS x) AS diff_from_avg,
    CASE
        WHEN
            s.total_admitted > (SELECT 
                    AVG(x.service_total)
                FROM
                    (SELECT 
                        SUM(patients_admitted) AS service_total
                    FROM
                        services_weekly
                    GROUP BY service) AS x)
        THEN
            'Above Average'
        WHEN
            s.total_admitted = (SELECT 
                    AVG(x.service_total)
                FROM
                    (SELECT 
                        SUM(patients_admitted) AS service_total
                    FROM
                        services_weekly
                    GROUP BY service) AS x)
        THEN
            'Average'
        ELSE 'Below Average'
    END AS ranking
FROM
    (SELECT 
        service, SUM(patients_admitted) AS total_admitted
    FROM
        services_weekly
    GROUP BY service) AS s
ORDER BY total_admitted DESC;

/* 
==================================================
 DAY 18: UNION and UNION ALL
==================================================
*/
### Practice Questions:
-- 1. Combine patient names and staff names into a single list.
SELECT NAME AS PATIENT_NAMES 
FROM PATIENTS
UNION 
SELECT STAFF_NAME
FROM STAFF;

-- 2. Create a union of high satisfaction patients (>90) and low satisfaction patients (<50).
SELECT NAME AS PATIENTS, SATISFACTION, 'HIGH SATISFACTION' AS CATEGORY
FROM PATIENTS
WHERE SATISFACTION > 90
UNION 
SELECT NAME AS PATIENTS, SATISFACTION, 'LOW SATISFACTION' AS CATEGORY
FROM PATIENTS
WHERE SATISFACTION < 50
ORDER BY SATISFACTION;

-- 3. List all unique names from both patients and staff tables.
SELECT DISTINCT NAME AS PATIENTS, 'PATIENTS' AS IDENTITY
FROM PATIENTS
UNION ALL
SELECT DISTINCT STAFF_NAME, 'STAFF' AS IDENTITY
FROM STAFF;

-- DAILY CHALLENGE
 -- Question: Create a comprehensive personnel and patient list showing: identifier (patient_id or staff_id), full name,
--  type ('Patient' or 'Staff'), and associated service. Include only those in 'surgery' or 'emergency' services. Order by type, 
--  then service, then name.
SELECT PATIENT_ID AS IDENTIFIER, NAME AS FULL_NAME, 'PATIENT' AS TYPE, SERVICE
FROM PATIENTS
WHERE SERVICE IN ('SURGERY', 'EMERGENCY')
UNION ALL
SELECT STAFF_ID AS IDENTIFIER, STAFF_NAME AS FULL_NAME, 'STAFF' AS TYPE, SERVICE
FROM STAFF
WHERE SERVICE IN ('SURGERY', 'EMERGENCY')
ORDER BY TYPE, SERVICE, FULL_NAME; 



