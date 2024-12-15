set search_path to altschool;

CREATE TABLE customers(
	customer_id SERIAL PRIMARY KEY,
	name CHAR(50) NOT NULL,
	email VARCHAR(250) UNIQUE,
	phone_number BIGINT UNIQUE,
	address VARCHAR(250)
);

CREATE TABLE orders(
	order_id SERIAL PRIMARY KEY,
	customer_id INT,
	order_date DATE NOT NULL,
	total_amount DECIMAL(15,2) NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE products(
	products_id SERIAL PRIMARY KEY,
	products_name VARCHAR(100) NOT NULL,
	category VARCHAR(100) NOT NULL,
	price DECIMAL(10,2) NOT NULL,
	stock_quantity INT NOT NULL
);

CREATE TABLE order_items(
	order_item_id SERIAL PRIMARY KEY,
	order_id INT,
	products_id INT,
	quantity INT NOT NULL,
	price DECIMAL(10,2) NOT NULL,
	FOREIGN KEY(order_id) REFERENCES orders(order_id),
	FOREIGN KEY(products_id) REFERENCES products(products_id)
);