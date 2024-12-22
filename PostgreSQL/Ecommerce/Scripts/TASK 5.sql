
/*
 Task 5: Optimization
Analyze query performance using EXPLAIN or EXPLAIN ANALYZE.
Optimize slow queries by adjusting indexes, reordering joins, or rewriting the query.

*/

--The EXPLAIN shows how the database would run the query and which indexes it would use

EXPLAIN
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

   
   
 --The EXPLAIN ANALYZE command provides a query execution plan and also runs the query, showing the actual execution time and other statistics.

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
   
   
 --Adjusting Slow Queries
 
DROP INDEX IF EXISTS altschool.idx_orders_customer_id;

 -- Original Query
 
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

   
   
   --Optimized Query
   
CREATE INDEX IF NOT EXISTS idx_orders_customer_id ON altschool.orders(customer_id);

EXPLAIN ANALYZE
SELECT 
    o.order_id,
    o.order_date,
    c.name AS customer_name,
    c.email AS customer_email
FROM 
    altschool.customers c
JOIN 
    altschool.orders o ON c.customer_id = o.customer_id
WHERE 
    o.customer_id = 1;

