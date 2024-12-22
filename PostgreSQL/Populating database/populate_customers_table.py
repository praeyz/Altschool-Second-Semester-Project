import psycopg2
from psycopg2 import OperationalError
from faker import Faker
import random


try:
    conn = psycopg2.connect(
        host='localhost',
        database='postgres',
        user='postgres',

    )
    print("Connected!")
except OperationalError as e:
    print(f"Couldn't connect to the database: {e}")
 

AltschoolFake = Faker()

# Generate random data
def generate_customers_data(rows):
    random_data = []
    email_set = set()
    for i in range(rows):
        name = AltschoolFake.name()

        # trying to make the emails unique when we generate large data
        while True:
            email = AltschoolFake.email()
            if email not in email_set:
                email_set.add(email)
                break
 
        address = AltschoolFake.address()
        phone_number = AltschoolFake.numerify('##########')
        random_data.append((name, email, phone_number, address))
    return random_data

# Now lets Insert the generated fakedata into the Ecommerce database
def insert_customers_data(conn, customers_data):
    with conn.cursor() as cursor:
        cursor.execute("SET search_path TO altschool;")  #making sure we are working in Altschols schema i created
        insert_query = """
            INSERT INTO customers (name, email, phone_number, address)
            VALUES (%s, %s, %s, %s)
        """
        try:
            cursor.executemany(insert_query, customers_data)
            conn.commit()
            print(f"succesfully Inserted {len(customers_data)} rows into the Ecommerce database!")
        except Exception as e:
            conn.rollback()  # Undo partial inserts if there's an error, dont insert half values
            print(f"Error inserting data: {e}")

# Main script
if __name__ == "__main__":
    if conn:
        customers_data = generate_customers_data(100)  # Generate 100 unique customer records
        insert_customers_data(conn, customers_data)