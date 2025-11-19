/* 
==================================================
 DAY 13:  INNER JOIN
==================================================
*/

-- Practice Questions:

-- 1. Join patients and staff based on their common service field (show patient and staff who work in same service).
SELECT P.NAME AS PATIENTS, S.STAFF_NAME AS STAFFS, S.SERVICE 
FROM PATIENTS P
JOIN STAFF S
ON P.SERVICE = S.SERVICE;
-- 2. Join services_weekly with staff to show weekly service data with staff information.
SELECT SW.WEEK, SW.SERVICE, S.STAFF_ID, S.STAFF_NAME
FROM STAFF S
JOIN SERVICES_WEEKLY SW
ON S.SERVICE = SW.SERVICE;
-- 3. Create a report showing patient information along with staff assigned to their service.
SELECT P.PATIENT_ID, P.NAME AS PATIENTS, S.STAFF_NAME AS STAFF
FROM PATIENTS P
JOIN STAFF S
ON P.SERVICE = S.SERVICE;

-- ### Daily Challenge:

-- **Question:** Create a comprehensive report showing patient_id, patient name, age, service, and the total number of staff members 
-- available in their service. Only include patients from services that have more than 5 staff members. Order by number of 
-- staff descending, then by patient name.
SELECT 
    p.patient_id,
    p.name AS patient_name,
    p.age,
    p.service,
    COUNT(s.staff_id) AS total_staff
FROM patients p
JOIN staff s
ON p.service = s.service
GROUP BY p.patient_id, p.name, p.age, p.service
HAVING COUNT(s.staff_id) > 5
ORDER BY  total_staff DESC, patient_name;


/* 
==================================================
 DAY 14:  LEFT AND RIGHT JOIN
==================================================
*/
--### Practice Questions:

-- 1. Show all staff members and their schedule information (including those with no schedule entries).
SELECT S.STAFF_NAME, SS.ROLE, SS.SERVICE, SS.PRESENT 
FROM STAFF S
LEFT JOIN STAFF_SCHEDULE SS
ON S.STAFF_ID = SS.STAFF_ID;
-- 2. List all services from services_weekly and their corresponding staff (show services even if no staff assigned).
SELECT 
    SW.SERVICE,
    S.STAFF_NAME
FROM SERVICES_WEEKLY SW
LEFT JOIN STAFF_SCHEDULE SS
    ON SW.SERVICE = SS.SERVICE
LEFT JOIN STAFF S
    ON SS.STAFF_ID = S.STAFF_ID;
-- 3. Display all patients and their service's weekly statistics (if available).
SELECT p.name AS patient_name,
    p.service,
    sw.week,
    sw.patients_request,
    sw.patients_admitted,
    sw.patients_refused,
    sw.patient_satisfaction,
    sw.staff_morale,
    sw.event
FROM patients p
LEFT JOIN services_weekly sw
ON p.service = sw.service;

-- ### Daily Challenge:

-- **Question:** Create a staff utilisation report showing all staff members (staff_id, staff_name, role, service) 
-- and the count of weeks they were present (from staff_schedule). Include staff members even if they have no schedule records. 
-- Order by weeks present descending.
SELECT 
    S.STAFF_ID,
    S.STAFF_NAME,
    COALESCE(SS.ROLE, 'N/A') AS ROLE,
    COALESCE(SS.SERVICE, 'N/A') AS SERVICE,
    COUNT(CASE WHEN SS.PRESENT = 'Yes' THEN 1 END) AS WEEKS_PRESENT
FROM STAFF S
LEFT JOIN STAFF_SCHEDULE SS 
    ON S.STAFF_ID = SS.STAFF_ID
GROUP BY 
    S.STAFF_ID,
    S.STAFF_NAME,
    SS.ROLE,
    SS.SERVICE
ORDER BY 
    WEEKS_PRESENT DESC;

/* 
==================================================
 DAY 14:  Multiple Joins
==================================================
*/
-- **Question:** Create a comprehensive service analysis report for week 20 showing: service name, total patients admitted 
-- that week, total patients refused,average patient satisfaction, count of staff assigned to service, and count of staff 
-- present that week. Order by patients admitted descending.
SELECT
	 sw.week ,
    sw.service,
    sw.patients_admitted AS total_admitted,
    sw.patients_refused AS total_refused,
    sw.patient_satisfaction AS avg_satisfaction,
    COUNT(DISTINCT s.staff_id) AS total_staff_assigned,
    COUNT(CASE WHEN ss.present = 1 THEN 1 END) AS staff_present
FROM services_weekly sw
LEFT JOIN staff s 
    ON sw.service = s.service
LEFT JOIN staff_schedule ss
    ON s.staff_id = ss.staff_id
    AND sw.week = ss.week
WHERE sw.week = 20
GROUP BY sw.service, sw.patients_admitted, sw.patients_refused, sw.patient_satisfaction
ORDER BY total_admitted DESC;

