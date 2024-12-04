USE mydb;

SELECT
    *,
    (SELECT customer_id FROM orders WHERE orders.id = order_details.order_id) AS customer_id
FROM order_details;

SELECT *
FROM order_details
WHERE order_id = (
    SELECT id
    FROM orders
    WHERE shipper_id = 3
      AND orders.id = order_id
);

SELECT order_id, AVG(quantity) AS avg_quantity
FROM (
         SELECT *
         FROM order_details
         WHERE quantity > 10
     ) AS temporal_table
GROUP BY order_id;

WITH temporal_table AS (
    SELECT order_id, quantity
    FROM order_details
    WHERE quantity > 10
)
SELECT order_id, AVG(quantity) AS avg_quantity
FROM temporal_table
GROUP BY order_id;

DELIMITER //
DROP FUNCTION IF EXISTS DIVIDER;
CREATE FUNCTION DIVIDER(arg1 FLOAT, arg2 FLOAT)
    RETURNS FLOAT
    NO SQL
BEGIN
    DECLARE result FLOAT;
    SET result = arg1 / arg2;
    RETURN result;
END //
DELIMITER ;

SELECT DIVIDER(quantity, 3.75) as divided_quantity FROM order_details;
