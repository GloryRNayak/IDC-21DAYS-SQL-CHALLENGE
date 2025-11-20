-- **Phase 1: Foundation & Inspection**

-- 2. List all unique pizza categories (`DISTINCT`).
SELECT DISTINCT CATEGORY FROM pizza_types;

-- 3. Display `pizza_type_id`, `name`, and ingredients, replacing NULL ingredients with 
-- `"Missing Data"`. Show first 5 rows.
SELECT PIZZA_TYPE_ID, NAME, coalesce(INGREDIENTS,"Missing Data") FROM pizza_types  LIMIT 5;

-- 4. Check for pizzas missing a price (`IS NULL`).
SELECT * FROM PIZZAS WHERE PRICE IS NULL;

-- **Phase 2: Filtering & Exploration**

-- 1. Orders placed on `'2015-01-01'` (`SELECT` + `WHERE`).
SELECT * FROM ORDERS WHERE DATE = '2015-01-01';
-- 2. List pizzas with `price` descending.
SELECT PIZZA_ID, PIZZA_TYPE_ID, PRICE FROM PIZZAS ORDER BY PRICE DESC;
-- 3. Pizzas sold in sizes `'L'` or `'XL'`.
SELECT pizza_id, pizza_type_id, size FROM pizzas WHERE size IN ('L', 'XL');
-- 4. Pizzas priced between $15.00 and $17.00.
SELECT pizza_id, pizza_type_id, size FROM pizzas WHERE size IN ('L', 'XL');
-- 5. Pizzas with `"Chicken"` in the name.
SELECT PIZZA_TYPE_ID, NAME FROM pizza_types WHERE NAME LIKE '%Chicken%';
-- 6. Orders on `'2015-02-15'` or placed after 8 PM.
SELECT * FROM ORDERS WHERE Date = '2015-02-15' OR time >= '20:00:00';

-- **Phase 3: Sales Performance**

-- 1. Total quantity of pizzas sold (`SUM`).
SELECT SUM(QUANTITY) AS TOTAL_QUANTITY FROM ORDER_DETAILS;
-- 2. Average pizza price (`AVG`).
SELECT ROUND(AVG(PRICE),2) AS AVG_PRICE FROM PIZZAS;
-- 3. Total order value per order (`JOIN`, `SUM`, `GROUP BY`).
SELECT 
    O.ORDER_ID, SUM(P.PRICE * O.QUANTITY) AS ORDER_VALUE
FROM
    ORDER_DETAILS O
        JOIN
    PIZZAS P ON O.PIZZA_ID = P.PIZZA_ID
GROUP BY O.ORDER_ID;
-- 4. Total quantity sold per pizza category (`JOIN`, `GROUP BY`).
SELECT 
    PT.CATEGORY, SUM(O.QUANTITY) AS TOTAL_QUANTITY
FROM
    ORDER_DETAILS O
        JOIN
    PIZZAS P ON O.PIZZA_ID = P.PIZZA_ID
        JOIN
    PIZZA_TYPES PT ON P.PIZZA_TYPE_ID = PT.PIZZA_TYPE_ID
GROUP BY PT.CATEGORY;
-- 5. Categories with more than 5,000 pizzas sold (`HAVING`).
SELECT 
    PT.CATEGORY, SUM(O.QUANTITY) AS TOTAL_QUANTITY
FROM
    ORDER_DETAILS O
        JOIN
    PIZZAS P ON O.PIZZA_ID = P.PIZZA_ID
        JOIN
    PIZZA_TYPES PT ON P.PIZZA_TYPE_ID = PT.PIZZA_TYPE_ID
GROUP BY PT.CATEGORY
HAVING SUM(O.QUANTITY) > 5000;
-- 6. Pizzas never ordered (`LEFT/RIGHT JOIN`).
SELECT 
    p.pizza_id, p.pizza_type_id, od.pizza_id
FROM
    order_details od
        RIGHT JOIN
    pizzas p ON p.pizza_id = od.pizza_id
WHERE
    od.pizza_id IS NULL;
-- 7. Price differences between different sizes of the same pizza (`SELF JOIN`).
SELECT 
    p1.size AS small_size,
    p1.price AS small_price,
    p2.size AS medium_size,
    p2.price AS medium_price,
    ROUND((p2.price - p1.price), 0) AS diff
FROM
    pizzas p1
        JOIN
    pizzas p2 ON p1.pizza_type_id = p2.pizza_type_id
        AND p1.size = 'S'
        AND p2.size = 'M';
