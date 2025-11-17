/* 
==================================================
 DAY 10:  CASE Statements: CASE WHEN, conditional logic, derived columns
==================================================
*/
-- ### Practice Questions:
-- 1. Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores.
SELECT NAME, SATISFACTION,
	CASE WHEN SATISFACTION >=80 THEN "HIGH"
		WHEN SATISFACTION >=40 AND SATISFACTION <=80 THEN "MEDIUM"
        ELSE "LOW"
        END AS SATISFACTION_CATEGORY
FROM PATIENTS;
-- 2. Label staff roles as 'Medical' or 'Support' based on role type.
SELECT STAFF_NAME, ROLE,
	CASE WHEN ROLE = "DOCTOR" OR ROLE="NURSE" THEN "MEDICAL"
		ELSE "SUPPORT"
	END AS ROLE_TYPE
FROM STAFF;
-- 3. Create age groups for patients (0-18, 19-40, 41-65, 65+).
SELECT NAME, AGE,
	CASE WHEN AGE <=18 THEN "TEEN"
		WHEN AGE >=19 AND AGE <=40 THEN "ADULT"
        WHEN AGE >=41 AND AGE <=65 THEN "MIDDLE AGED"
        ELSE "SENIOR"
	END AS AGE_GROUPS
FROM PATIENTS;


-- ### Daily Challenge:
 /*Create a service performance report showing service name, total patients admitted, and a performance category based on the following:  'Excellent' if avg satisfaction >= 85, 'Good' if >= 75, 'Fair' if >= 65, otherwise 'Needs Improvement'. 
Order by average satisfaction descending.?*/

SELECT SERVICE, SUM(PATIENTS_ADMITTED) AS TOTAL_ADMITTED, 
    CASE WHEN AVG(PATIENT_SATISFACTION) >=85 THEN "EXCELLENT"
    WHEN AVG(PATIENT_SATISFACTION) >= 75 THEN "GOOD"
    WHEN AVG(PATIENT_SATISFACTION) >= 65 THEN "FAIR"
    ELSE "NEEDS IMPROVEMENT"
END AS PERFORMANCE_CATEGORY,
	ROUND(AVG(patient_satisfaction), 2) AS avg_satisfaction
FROM SERVICES_WEEKLY
GROUP BY SERVICE
ORDER BY PERFORMANCE_CATEGORY DESC;

/* 
==================================================
 DAY 11: DISTINCT and Handling Duplicates: DISTINCT, removing duplicates, unique values
==================================================
*/
### Practice Questions:

-- 1. List all unique services in the patients table.
SELECT DISTINCT SERVICE FROM PATIENTS;
-- 2. Find all unique staff roles in the hospital.
SELECT DISTINCT ROLE FROM STAFF;
-- 3. Get distinct months from the services_weekly table
SELECT DISTINCT MONTH FROM SERVICES_WEEKLY;

### Daily Challenge:

-- **Question:** Find all unique combinations of service and event type from the services_weekly table 
-- where events are not null or none, along with the count of occurrences for each combination. 
-- Order by count descending.
SELECT 
    DISTINCT service,
    event,
    COUNT(*) AS event_count
FROM services_weekly
WHERE event IS NOT NULL 
  AND event <> 'none'
GROUP BY service, event
ORDER BY event_count DESC;

/* 
==================================================
 DAY 12:  NULL Values and IS NULL/IS NOT NULL
==================================================
*/
## Practice Questions:

-- 1. Find all weeks in services_weekly where no special event occurred.
SELECT WEEK FROM services_weekly WHERE EVENT IS NULL;
-- 2. Count how many records have null or empty event values.
SELECT COUNT(*) FROM SERVICES_WEEKLY WHERE EVENT IS NULL;
-- 3. List all services that had at least one week with a special event.
SELECT SERVICE, EVENT FROM SERVICES_WEEKLY WHERE EVENT IS NOT NULL AND EVENT <> "NONE";

## Daily Challenge:
-- **Question:** Analyze the event impact by comparing weeks with events vs weeks without events. Show: event 
-- status ('With Event' or 'No Event'), count of weeks, average patient satisfaction, and average staff morale. 
-- Order by average patient satisfaction descending.
SELECT 
    CASE 
        WHEN event IS NOT NULL AND LOWER(event) <> 'none' THEN 'With Event'
        ELSE 'No Event'
    END AS event_status,
    COUNT(*) AS total_weeks,
    ROUND(AVG(patient_satisfaction),2) AS avg_satisfaction,
    ROUND(AVG(staff_morale),2) AS avg_morale
FROM services_weekly
GROUP BY event_status
ORDER BY avg_satisfaction DESC;

