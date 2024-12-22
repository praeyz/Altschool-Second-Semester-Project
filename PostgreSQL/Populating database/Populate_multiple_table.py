import psycopg2
from psycopg2 import OperationalError
import faker
from faker import Faker
import random


# Establish connection
try:
    conn = psycopg2.connect(
        host = 'localhost',
        database = 'postgres',
        user = 'postgres',

    )
    print(f"connected!")

except OperationalError as e:
    print(f"couldnt connect to database, {e}")

fake = Faker()

def generate_order_items_data(rows):
    order_data = []
    for i in range(rows):
        quantity = random.randint(0, 100)
        price = random.randint(5, 100000)
        order_data.append((quantity, price))
    return order_data


def generate_products_data(rows):
    products_data =[]
    for i in range(rows):
        product_name = fake.company()
        category = fake.catch_phrase()
        price = random.randint(5, 10000)
        stock_quantity = random.randint(0, 100)
        products_data.append((product_name, category, price, stock_quantity))
    return products_data


def generate_orders_data(rows):
    order_items_data = []
    for i in range(rows):
        order_date = fake.date()
        order_items = generate_order_items_data(random.randint(1, 5))
        total_amount = sum(quantity * price for quantity, price in order_items )
        order_items_data.append((order_date, total_amount))
    return order_items_data


    

# Function to insert data into a table

def insert_products_data(conn, products_data):
    with conn.cursor() as cursor:
        cursor.execute("SET search_path TO altschool;")
        insert_query = """
            INSERT INTO products (products_name, category, price, stock_quantity)
            VALUES (%s, %s, %s, %s)
        """
        try:
            cursor.executemany(insert_query, products_data)
            conn.commit()
            print(f"Inserted {len(products_data)} products data into the database!")

        except OperationalError as e:
            conn.rollback()
            print(f" error inserting for the products_data: {e}")



def insert_orders_data(conn, order_data):
    with conn.cursor() as cursor:
        cursor.execute("SET search_path TO altschool;")
        insert_query = """
            INSERT INTO orders (order_date, total_amount)
            VALUES (%s, %s)
        """
        try:
            cursor.executemany(insert_query, order_data)
            conn.commit()
            print(f"Inserted {len(order_data)} order datas into the Ecommerce database")

        except OperationalError as e:
            conn.rollback()
            print(f" error inserting for the products_data: {e}")

def insert_order_items_data(conn, order_items_data):
    with conn.cursor() as cursor:
        cursor.execute("SET search_path TO altschool;")
        insert_query =""" 
            INSERT INTO order_items (quantity, price)
            VALUES (%s, %s)
        """
        try:
            cursor.executemany(insert_query, order_items_data)
            conn.commit()
            print(f"Inserted {len(order_items_data)} items into the Ecommerce database")

        except OperationalError as e:
            conn.rollback()
            print(f" error inserting for the products_data: {e}")


if __name__ == "__main__":
    if conn:
        products_data = generate_products_data(100)  # lets Generate 100 product records
        insert_products_data(conn, products_data)

        order_items_data = generate_order_items_data(100)
        insert_order_items_data(conn, order_items_data)

        #order_data = generate_orders_data(100)
        #insert_orders_data(conn, order_data)




