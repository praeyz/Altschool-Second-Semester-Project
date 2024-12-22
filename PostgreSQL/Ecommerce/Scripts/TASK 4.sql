/*	
	Task 4: Advanced SQL Concepts

	Joins:
	Write queries using INNER JOIN, LEFT JOIN, and FULL JOIN to retrieve data across multiple tables.
	
	Window Functions:
	Use RANK() to rank customers based on their total spending.
	Use ROW_NUMBER() to assign a unique number to each order for a customer.
	
	CTEs and Subqueries:
	Use a Common Table Expression (CTE) to calculate the total revenue per customer, then find the customers with revenue greater than $500.
	Write a subquery to find the product with the highest price.
	
	
	Indexing:
	Create indexes on frequently queried fields (e.g., customer_id, product_id) and demonstrate their impact on query performance.

	
*/






	--Joins:
	  --Write queries using INNER JOIN, LEFT JOIN, and FULL JOIN to retrieve data across multiple tables.

--INNER JOIN--

SELECT p.products_name, oi.quantity 
FROM altschool.products p 
INNER JOIN altschool.order_items oi 
ON p.products_id = oi.products_id 
ORDER BY oi.quantity DESC LIMIT 3;

--LEFT JOIN--

SELECT c.name, c.address, o.total_amount 
FROM altschool.customers c 
LEFT JOIN altschool.orders o 
ON c.customer_id = o.customer_id 
WHERE total_amount IS NULL
ORDER BY o.total_amount;

--FULL JOIN--

SELECT 
    c.customer_id,
    c.name AS customer_name,
    c.email AS customer_email,
    o.order_id,
    o.order_date,
    o.total_amount
FROM 
    altschool.customers c
FULL JOIN 
    altschool.orders o ON c.customer_id = o.customer_id;

   
   
	--------------------Window Functions--------------------------------------------:
   
        --Use RANK() to rank customers based on their total spending
SELECT 
    c.customer_id,
    c.name AS customer_name,
    SUM(oi.quantity * oi.price) AS total_spending,
    RANK() OVER (ORDER BY SUM(oi.quantity * oi.price) DESC) AS rank
FROM 
    altschool.customers c
JOIN 
    altschool.orders o ON c.customer_id = o.customer_id
JOIN 
    altschool.order_items oi ON o.order_id = oi.order_id
GROUP BY 
    c.customer_id, c.name;


	     --Use ROW_NUMBER() to assign a unique number to each order for a customer.   

   SELECT 
    o.customer_id,
    o.order_id,
    o.order_date,
    ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY o.order_date) AS order_number
FROM 
    altschool.orders o;
   
   
   
   
   
 	---------------------------------------------CTEs and Subqueries-----------------------------------
   
	--Use a Common Table Expression (CTE) to calculate the total revenue per customer, then find the customers with revenue greater than $500.
	  
 WITH CustomerRevenue AS (
    SELECT 
        c.customer_id,
        c.name AS customer_name,
        SUM(oi.quantity * oi.price) AS total_revenue
    FROM 
        altschool.customers c
    JOIN 
        altschool.orders o ON c.customer_id = o.customer_id
    JOIN 
        altschool.order_items oi ON o.order_id = oi.order_id
    GROUP BY 
        c.customer_id, c.name
)
SELECT 
    customer_id,
    customer_name,
    total_revenue
FROM 
    CustomerRevenue
WHERE 
    total_revenue > 500;


   	--Write a subquery to find the product with the highest price.
SELECT 
    products_id,
    products_name,
    price
FROM 
    altschool.products
WHERE 
    price = (SELECT MAX(price) FROM altschool.products);

   
	----------------------------------------------------------Indexing--------------------------------------------------------------------:
	--Create indexes on frequently queried fields (e.g., customer_id, product_id) and demonstrate their impact on query performance.
   
CREATE INDEX idx_orders_customer_id ON altschool.orders(customer_id);

CREATE INDEX idx_order_items_products_id ON altschool.order_items(products_id);



---------QUERY WITHOUT INDEX ---------------------------

DROP INDEX IF EXISTS altschool.idx_orders_customer_id;
DROP INDEX IF EXISTS altschool.idx_order_items_products_id;


EXPLAIN ANALYZE
SELECT 
    o.order_id,
    o.order_date,
    c.name AS customer_name,
    c.email AS customer_email
FROM 
    altschool.orders o
JOIN 
    altschool.customers c ON o.customer_id = c.customer_id
WHERE 
    o.customer_id = 1;


 ---------QUERY WITH INDEX ---------------------------
   
CREATE INDEX idx_orders_customer_id ON altschool.orders(customer_id);


EXPLAIN ANALYZE
SELECT 
    o.order_id,
    o.order_date,
    c.name AS customer_name,
    c.email AS customer_email
FROM 
    altschool.orders o
JOIN 
    altschool.customers c ON o.customer_id = c.customer_id
WHERE 
    o.customer_id = 1;


---------------CREATING INDEX ON THE Products_id Field--------------------------------------
   
CREATE INDEX idx_order_items_products_id ON altschool.order_items(products_id);


EXPLAIN ANALYZE
SELECT 
    oi.order_item_id,
    oi.quantity,
    p.products_name,
    p.price
FROM 
    altschool.order_items oi
JOIN 
    altschool.products p ON oi.products_id = p.products_id
WHERE 
    oi.products_id = 101;


