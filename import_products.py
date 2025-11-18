import csv
import mysql.connector

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",  # your MySQL password
    database="ecommerce"
)
cursor = conn.cursor()

with open(r"C:\xampp\htdocs\ecommerce\products.csv", "r", encoding="utf-8") as file:
    reader = csv.DictReader(file)
    for row in reader:
        cursor.execute("""
            INSERT INTO products (name, price, description, image, category_id)
            VALUES (%s, %s, %s, %s, %s)
        """, (row["name"], row["price"], row["description"], row["image"], row["category_id"]))

conn.commit()
conn.close()
print("Products imported successfully!")
