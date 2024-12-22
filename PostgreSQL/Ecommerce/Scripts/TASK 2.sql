---------------------TASK 2--------------------------------------------------------------------------

--Adding a new customer to the database 


INSERT INTO altschool.customers(
	name,email,phone_number,address
)

VALUES(
	'praise', 'praiseekpenisi@altschool.com', '123456789', 'Lagos Nigeria'
);


--Updating the stock quantity of a product after a purchase

SELECT * FROM altschool.products 

UPDATE altschool.products
SET stock_quantity = 15
WHERE products_id = 2;



-- Deleting an order from the database

DELETE FROM altschool.orders
WHERE order_id = 10;


-- Retrieve all orders made by a specific customer


SELECT o.order_id,
o.order_date,
o.total_amount
FROM orders o
INNER JOIN customers c 
ON o.customer_id = c.customer_id 
WHERE c.customer_id = 10;
	






