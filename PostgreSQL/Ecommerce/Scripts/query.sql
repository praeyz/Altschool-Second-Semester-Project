

-- trying to fix the foreign key showing NULL problem
UPDATE altschool.order_items 
SET order_id = ( 
	SELECT order_id
	FROM orders
	WHERE orders.order_id = order_items.order_item_id 
	);
	
UPDATE altschool.order_items 
SET products_id = ( 
	SELECT products_id 
	FROM products
	WHERE products.products_id = order_items.order_item_id 
	);