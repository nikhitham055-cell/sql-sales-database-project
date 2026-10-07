CREATE DATABASE sales;

USE sales;

-- Part A – Basic Queries
-- 1. Display all customers.

SELECT * FROM customers;

-- 2. Display customers from Kerala.

SELECT * FROM customers
WHERE state = 'Kerala';

-- 3. Display all products from the Electronics category.

SELECT * FROM products
WHERE category = 'Electronics';

-- 4. Display products with price greater than 1000.

SELECT * FROM products
WHERE price > 1000;

-- 5. Display all completed orders.

SELECT * FROM orders
WHERE order_status = 'Completed'; 

-- 6. Sort products by price in ascending order.

SELECT * FROM products
ORDER BY price;

-- 7. Display the 5 most expensive products.

SELECT * FROM products
ORDER BY price DESC
LIMIT 5;

-- Part B – Aggregate Functions
-- 8. Find the total number of customers.

SELECT COUNT(*) AS total_customers
FROM customers;

-- 9. Find the total number of orders.

SELECT COUNT(*) AS total_orders
FROM orders;

-- 10. Find the average product price.

SELECT AVG(price) AS avg_price
FROM products;

-- 11. Find the highest product price.

SELECT MAX(price) AS highest_price
FROM products;

-- 12. Find the lowest product price.

SELECT MIN(price) AS lowest_price
FROM products;

-- 13. Find the total quantity sold for each product.

SELECT product_id, SUM(quantity) AS total_quantity
FROM order_details
GROUP BY product_id;

-- Part C – GROUP BY
-- 14. Find the number of customers in each state.

SELECT State, COUNT(*) AS total_customers
FROM customers
GROUP BY State;

-- 15. Find the number of products in each category.

SELECT category, COUNT(*) AS total_products
FROM products
GROUP BY category;

-- 16. Find the number of orders for each payment mode.

SELECT payment_mode, COUNT(*) AS total_orders
FROM orders
GROUP BY payment_mode;

-- 17. Display categories having more than 3 products.

SELECT category, COUNT(*) AS tot
FROM products
GROUP BY category
HAVING tot > 3;

-- Part D – JOIN
-- 18. Display customer name and order date.

SELECT c.customer_name, o.order_date
FROM customers AS c
JOIN orders AS o
ON c.customer_id = o.customer_id;

-- 19. Display product name and quantity.

SELECT p.product_name, od.quantity
FROM products AS p
JOIN order_details AS od
ON p.product_id = od.product_id;

-- 20. Display customer name, product name and quantity.

SELECT c.customer_name, p.product_name, od.quantity
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_details AS od
    ON o.order_id = od.order_id 
JOIN products AS p
    ON od.product_id = p.product_id;

-- 21. Display Order ID, Customer Name and Order Status.

SELECT o.order_id, c.customer_name, o.order_status
FROM customers AS c
JOIN orders AS o
ON c.customer_id = o.customer_id;
    
-- Part E – CASE
-- 22. Display product name, price and price category: High, Medium or Low.
	
SELECT product_name, price,
CASE
    WHEN price >= 2000 THEN 'High'
    WHEN price >= 1000 THEN 'Medium'
    ELSE 'Low'
END AS price_category
FROM products;

-- 23. Display customer name, age and age category: Young, Adult or Senior.

SELECT customer_name, age,
CASE 
    WHEN age >= 50 THEN 'Senior'
    WHEN age >= 18 THEN 'adult'
    ELSE 'young'
END AS age_category
FROM customers;

-- Part F – Simple Subqueries
-- 24. Display products whose price is greater than the average product price.

SELECT product_name
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);

-- 25. Display the product with the highest price.

SELECT product_name
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products
);

-- Part G – UPDATE / ALTER / DELETE
-- 26. Increase the price of Electronics products by 10%.

UPDATE products
SET price = price * 1.10
WHERE category = 'Electronics';

-- 27. Change the status of Order ID 5 to Completed.

UPDATE orders
SET order_status = 'Completed'
WHERE order_id = 5;

-- 28. Add an Email column to the Customers table.

ALTER TABLE customers
ADD email VARCHAR(100);

-- 29. Modify the Customer_Name column.

ALTER TABLE customers
MODIFY customer_name VARCHAR(100);

-- 30. Delete cancelled orders.

DELETE FROM orders
WHERE order_status = 'Cancelled';

-- Part H – Simple Data Analyst Questions
-- 31. Which product has the highest quantity sold?

SELECT p.product_id, p.product_name, SUM(od.quantity) AS quantity
FROM products AS p
JOIN order_details AS od
ON p.product_id = od.product_id
GROUP BY product_id, product_name
ORDER BY quantity DESC
LIMIT 1;

-- 32. Which category has the most products?

SELECT category, COUNT(*) AS total
FROM products
GROUP BY category
ORDER BY total DESC
LIMIT 1;

-- 33. Which payment mode is used most frequently?

SELECT payment_mode, COUNT(*) AS total_payment_mode
FROM orders
GROUP BY payment_mode
ORDER BY total_payment_mode DESC
LIMIT 1;

-- 34. Which state has the highest number of customers?

SELECT state, COUNT(*) AS total_customers
FROM customers
GROUP BY state
ORDER BY total_customers DESC
LIMIT 1;

-- 35. Display products whose total quantity sold is less than 10.

SELECT p.product_name, SUM(od.quantity) AS total_quantity
FROM products AS p
JOIN order_details AS od
ON p.product_id = od.product_id
GROUP BY p.product_id, product_name
HAVING total_quantity < 10;