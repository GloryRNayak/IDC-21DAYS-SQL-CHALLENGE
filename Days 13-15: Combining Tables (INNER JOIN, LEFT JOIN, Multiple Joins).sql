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

