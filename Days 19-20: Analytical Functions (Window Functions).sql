/* 
==================================================
 DAY 19:  Window Functions - ROW_NUMBER, RANK, DENSE_RANK
==================================================
*/
### Practice Questions:

-- 1. Rank patients by satisfaction score within each service.
SELECT PATIENT_ID, NAME AS PATIENTS, SATISFACTION, 
DENSE_RANK() OVER (PARTITION BY SERVICE ORDER BY SATISFACTION DESC) AS RANKING
FROM PATIENTS;
-- 2. Assign row numbers to staff ordered by their name.
SELECT STAFF_ID, STAFF_NAME,
row_number() OVER (ORDER BY STAFF_NAME ) AS ROW_NUMBERS
FROM STAFF;
-- 3. Rank services by total patients admitted.
SELECT SERVICE,
SUM(PATIENTS_ADMITTED) AS TOTAL_ADMITTED,
RANK() OVER (ORDER BY SUM(PATIENTS_ADMITTED) DESC) AS SERVICE_RANK
FROM SERVICES_WEEKLY
GROUP BY SERVICE;

### Daily Challenge:

-- **Question:** For each service, rank the weeks by patient satisfaction score (highest first). Show service, week, patient_satisfaction, 
-- patients_admitted, and the rank. Include only the top 3 weeks per service.

SELECT *
FROM (
    SELECT SERVICE, WEEK, PATIENT_SATISFACTION, PATIENTS_ADMITTED,
        ROW_NUMBER() OVER ( PARTITION BY SERVICE ORDER BY PATIENT_SATISFACTION DESC ) AS SAT_RANK
    FROM SERVICES_WEEKLY
) AS X
WHERE SAT_RANK <= 3;

/* 
==================================================
 DAY 20:  Window Functions - Aggregate Window Functions
==================================================
*/

### Practice Questions:

-- 1. Calculate running total of patients admitted by week for each service.
SELECT WEEK, SERVICE,
SUM(PATIENTS_ADMITTED) OVER (partition by SERVICE ORDER BY WEEK) AS RUNNING_TOTAL
FROM SERVICES_WEEKLY;
-- 2. Find the moving average of patient satisfaction over 4-week periods.
SELECT WEEK, SERVICE,
ROUND(AVG(PATIENT_SATISFACTION) OVER (partition by SERVICE ORDER BY WEEK ROWS BETWEEN 3 PRECEDING AND CURRENT ROW ),2) AS RUNNING_AVG
FROM SERVICES_WEEKLY;
-- 3. Show cumulative patient refusals by week across all services.
SELECT WEEK, SERVICE,
SUM(PATIENTS_REFUSED) OVER (ORDER BY WEEK) AS CUM_PATIENT_REFUSAL
FROM SERVICES_WEEKLY;



### Daily Challenge:

-- **Question:** Create a trend analysis showing for each service and week: week number, patients_admitted, running total of patients 
-- admitted (cumulative), 3-week moving average of patient satisfaction (current week and 2 prior weeks), and the difference between 
-- current week admissions and the service average. Filter for weeks 10-20 only.
SELECT WEEK, SERVICE, PATIENTS_ADMITTED,
SUM(PATIENTS_ADMITTED) OVER (PARTITION BY SERVICE ORDER BY WEEK) AS CUM_PATIENT_ADMIT,
ROUND(AVG(PATIENT_SATISFACTION) OVER (PARTITION BY SERVICE ORDER BY WEEK ROWS BETWEEN 2 PRECEDING AND CURRENT ROW ),2) AS RUNNING_AVG,
PATIENTS_ADMITTED - AVG(PATIENTS_ADMITTED) OVER (PARTITION BY SERVICE) AS DIFF_FROM_AVG
FROM SERVICES_WEEKLY
WHERE WEEK between 10 AND 20
ORDER BY SERVICE, WEEK;
