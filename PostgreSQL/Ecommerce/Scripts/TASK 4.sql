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



