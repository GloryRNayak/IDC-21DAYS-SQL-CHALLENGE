 ### Practice Questions:

-- 1. Convert all patient names to uppercase.
SELECT 
    UPPER(NAME) AS UPPER_NAMES
FROM PATIENTS;
-- 2. Find the length of each staff member's name.
SELECT 
	STAFF_NAME, length(STAFF_NAME) AS NAME_LEN 
FROM STAFF;
-- 3. Concatenate staff_id and staff_name with a hyphen separator.
SELECT 
	concat(STAFF_ID, '-', STAFF_NAME) 
FROM STAFF;


/*### Daily Challenge:

**Question:** Create a patient summary that shows patient_id, full name in uppercase, service in lowercase,
 age category (if age >= 65 then 'Senior', if age >= 18 then 'Adult', else 'Minor'), and name length. 
 Only show patients whose name length is greater than 10 characters.*/
 SELECT PATIENT_ID, UPPER(NAME) AS FULL_NAME, LOWER(SERVICE) AS SERVICE, 
	CASE WHEN AGE>=65 THEN 'SENIOR'
		WHEN AGE>=18 THEN 'ADULT'
        ELSE 'MINOR'
        END AS AGE_GROUP,
        LENGTH(name) AS name_length
FROM PATIENTS
WHERE length(NAME) > 10;


### Practice Questions:

-- 1. Extract the year from all patient arrival dates.
SELECT YEAR(ARRIVAL_DATE) AS YEAR FROM PATIENTS;
-- 2. Calculate the length of stay for each patient (departure_date - arrival_date).
SELECT DATEDIFF(DEPARTURE_DATE, ARRIVAL_DATE) AS NO_OF_DAYS FROM PATIENTS;
-- 3. Find all patients who arrived in a specific month.
SELECT NAME, ARRIVAL_DATE FROM PATIENTS WHERE MONTH(ARRIVAL_DATE) ='6';

### Daily Challenge:

-- **Question:** Calculate the average length of stay (in days) for each service, 
-- showing only services where the average stay is more than 7 days. Also show the count of patients and order by average stay descending.
SELECT 
    SERVICE, 
    ROUND(AVG(DATEDIFF(departure_date, arrival_date)), 2) AS AVG_STAYDAYS, 
    COUNT(*) AS TOTAL_PATIENTS
FROM PATIENTS
GROUP BY SERVICE
HAVING AVG(DATEDIFF(departure_date, arrival_date)) > 7
ORDER BY AVG_STAYDAYS DESC;
