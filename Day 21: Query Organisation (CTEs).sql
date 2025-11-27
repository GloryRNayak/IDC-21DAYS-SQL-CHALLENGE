/* 
==================================================
 DAY 21:   Common Table Expressions (CTEs)
==================================================
*/
### Practice Questions:
-- 1. Create a CTE to calculate service statistics, then query from it.
WITH S AS (
	SELECT SERVICE, SUM(PATIENTS_ADMITTED) AS TOTAL_ADMISSIONS,
			SUM(PATIENTS_REFUSED) AS TOTAL_REFUSALS,
            ROUND(AVG(PATIENT_SATISFACTION),2) AS AVG_SATISFACTION
		FROM SERVICES_WEEKLY
        GROUP BY SERVICE)
SELECT * FROM SERVICE_STATS;
-- 2. Use multiple CTEs to break down a complex query into logical steps.
WITH S AS (
	SELECT SERVICE, SUM(PATIENTS_ADMITTED) AS TOTAL_ADMISSIONS
    FROM SERVICES_WEEKLY GROUP BY SERVICE),
A AS(
    SELECT  round(AVG(TOTAL_ADMISSIONS),2) AS AVG_TOTAL
    FROM S )
SELECT S.SERVICE, S.TOTAL_ADMISSIONS,
CASE WHEN A.AVG_TOTAL > S.TOTAL_ADMISSIONS THEN "Above average"
	WHEN A.AVG_TOTAL = S.TOTAL_ADMISSIONS THEN "Average"
    ELSE "Below average"
	END AS PERFORMANCE
FROM A, S
ORDER BY S.TOTAL_ADMISSIONS DESC;
-- 3. Build a CTE for staff utilization and join it with patient data.
WITH util AS (
    SELECT service, SUM(present) / COUNT(*) AS utilization_rate
    FROM staff_schedule
    GROUP BY service),
pat AS (
    SELECT service, COUNT(*) AS total_patients
    FROM patients
    GROUP BY service )
SELECT util.service, utilization_rate, total_patients
FROM util
JOIN pat USING (service)
ORDER BY utilization_rate DESC;



### Daily Challenge:

-- **Question:** Create a comprehensive hospital performance dashboard using CTEs. Calculate: 1) Service-level metrics (total admissions, refusals, 
-- avg satisfaction), 2) Staff metrics per service (total staff, avg weeks present), 3) Patient demographics per service (avg age, count). Then combine 
-- all three CTEs to create a final report showing service name, all calculated metrics, and an overall performance score (weighted average of admission 
-- rate and satisfaction). Order by performance score descending.
WITH service_metrics AS (
    SELECT service, SUM(patients_admitted) AS total_admissions, SUM(patients_refused) AS total_refusals, ROUND(AVG(patient_satisfaction),2) AS avg_satisfaction
    FROM services_weekly GROUP BY service),
staff_metrics AS (
    SELECT s.service, COUNT(DISTINCT s.staff_id) AS total_staff, ROUND((SUM(ss.present) / COUNT(ss.present)) * 100, 2) AS attendance_rate  
    FROM staff s JOIN staff_schedule ss ON s.staff_id = ss.staff_id GROUP BY s.service ),
patient_demo AS (
    SELECT service, ROUND(AVG(age),2) AS avg_age, COUNT(patient_id) AS patient_count
    FROM patients GROUP BY service )
SELECT sm.service, sm.total_admissions, sm.total_refusals, sm.avg_satisfaction, st.total_staff, st.attendance_rate, pd.avg_age, pd.patient_count,
    ROUND((sm.total_admissions * 0.6) + (sm.avg_satisfaction * 0.4),2) AS performance_score
FROM service_metrics sm
JOIN staff_metrics st USING (service)
JOIN patient_demo pd USING (service)
ORDER BY performance_score DESC;
