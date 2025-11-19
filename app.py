import os
from flask import Flask, render_template, request, redirect, session, flash, jsonify
import mysql.connector
import bcrypt
from werkzeug.utils import secure_filename
import stripe

app = Flask(__name__)
app.secret_key = "mysecretkey"

# Upload folder
app.config["UPLOAD_FOLDER"] = "static/uploads"

# Stripe keys
stripe.api_key = "sk_test_51SVHsEFpFFIttRBhc8PBtemSSWBhd5MU9QvFd4uIGbBfjRAb2Ofd3QCAZYKJehgvm9N6GMGnz5Kl4qIvF4sF4pA800aLpUZawZ"  # Replace with your Stripe secret key

# ---------------------
# DATABASE CONNECTION
# ---------------------
def db_connect():
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="ecommerce"
    )
    return conn

# ---------------------
# HOME ROUTE
# ---------------------
@app.route("/")
def home():
    if "user" in session:
        return render_template("index.html", username=session["user"])
    return render_template("index.html", username=None)

# ---------------------
# REGISTER ROUTE
# ---------------------
@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        username = request.form["username"]
        email = request.form["email"]
        password = request.form["password"].encode("utf-8")

        hashed = bcrypt.hashpw(password, bcrypt.gensalt())

        try:
            conn = db_connect()
            cursor = conn.cursor()
            cursor.execute(
                "INSERT INTO users (username, email, password) VALUES (%s, %s, %s)",
                (username, email, hashed)
            )
            conn.commit()
            conn.close()
            flash("Registration successful! Please login.")
            return redirect("/login")
        except mysql.connector.IntegrityError:
            flash("Username or email already exists!")
            return redirect("/register")
        except Exception as e:
            flash(f"An error occurred: {str(e)}")
            return redirect("/register")

    return render_template("register.html")

# ---------------------
# LOGIN ROUTE
# ---------------------
@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        email = request.form["email"]
        password = request.form["password"].encode("utf-8")

        conn = db_connect()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM users WHERE email=%s", (email,))
        user = cursor.fetchone()
        conn.close()

        if user and bcrypt.checkpw(password, user["password"].encode("utf-8")):
            session["user"] = user["username"]
            flash("Login successful!")
            return redirect("/")
        else:
            flash("Invalid email or password!")
            return redirect("/login")

    return render_template("login.html")

# ---------------------
# LOGOUT ROUTE
# ---------------------
@app.route("/logout")
def logout():
    session.pop("user", None)
    session.pop("admin", None)
    flash("You have been logged out.")
    return redirect("/")

# ---------------------
# ABOUT ROUTE
# ---------------------
@app.route("/about")
def about():
    return render_template("about.html")

# ---------------------
# CATEGORY PAGE
# ---------------------
@app.route("/categories")
def categories_page():
    conn = db_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM categories")
    categories = cursor.fetchall()
    conn.close()
    return render_template("categories.html", categories=categories)

@app.route("/category/<int:cat_id>")
def products_by_category(cat_id):
    conn = db_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT name FROM categories WHERE id=%s", (cat_id,))
    category = cursor.fetchone()
    cursor.execute("SELECT * FROM products WHERE category_id=%s", (cat_id,))
    products = cursor.fetchall()
    conn.close()
    return render_template("category_products.html", category=category, products=products)

# ---------------------
# CONTACT PAGE
# ---------------------
@app.route("/contact", methods=["GET", "POST"])
def contact():
    if request.method == "POST":
        name = request.form["name"]
        email = request.form["email"]
        message = request.form["message"]

        conn = db_connect()
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO contact_messages (name, email, message) VALUES (%s, %s, %s)",
            (name, email, message)
        )
        conn.commit()
        conn.close()

        flash("Your message has been sent!")
        return redirect("/contact")

    return render_template("contact.html")

# ---------------------
# PROFILE PAGE
# ---------------------
@app.route("/profile")
def profile():
    if "user" not in session:
        flash("Please login first!")
        return redirect("/login")

    conn = db_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM users WHERE username=%s", (session["user"],))
    user = cursor.fetchone()
    conn.close()
    return render_template("profile.html", user=user)

# ---------------------
# Add to Cart Route
# ---------------------
@app.route("/add_to_cart", methods=["POST"])
def add_to_cart():
    if "user" not in session:
        flash("Please login first!")
        return redirect("/login")

    username = session["user"]
    product_id = request.form["product_id"]
    product_name = request.form["product_name"]
    price = request.form["price"]

    conn = db_connect()
    cursor = conn.cursor(dictionary=True)

    cursor.execute(
        "SELECT * FROM cart WHERE username=%s AND product_id=%s",
        (username, product_id)
    )
    item = cursor.fetchone()

    if item:
        cursor.execute(
            "UPDATE cart SET quantity = quantity + 1 WHERE username=%s AND product_id=%s",
            (username, product_id)
        )
    else:
        cursor.execute(
            "INSERT INTO cart (username, product_id, product_name, price, quantity) VALUES (%s, %s, %s, %s, %s)",
            (username, product_id, product_name, price, 1)
        )

    conn.commit()
    conn.close()
    flash("Item added to cart!")
    return redirect("/cart")

# ---------------------
# View Cart Route
# ---------------------
@app.route("/cart")
def cart():
    if "user" not in session:
        flash("Please login first!")
        return redirect("/login")

    username = session["user"]
    conn = db_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM cart WHERE username=%s", (username,))
    items = cursor.fetchall()
    conn.close()

    total = sum(item["price"] * item["quantity"] for item in items)
    return render_template("cart.html", items=items, total=total)

# ---------------------
# Remove Item From Cart
# ---------------------
@app.route("/remove/<int:id>")
def remove_item(id):
    conn = db_connect()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM cart WHERE id=%s", (id,))
    conn.commit()
    conn.close()
    flash("Item removed!")
    return redirect("/cart")

# ---------------------
# PRODUCTS PAGE
# ---------------------
@app.route("/products")
def products_page():
    return render_template("products.html")

# ---------------------
# API PRODUCTS
# ---------------------
@app.route("/api/products")
def api_products():
    conn = db_connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM products")
    products = cursor.fetchall()
    conn.close()
    return jsonify(products)

# ---------------------
# CHECKOUT ROUTE (WITH STRIPE & CASH)
# ---------------------
@app.route("/checkout", methods=["GET", "POST"])
def checkout():
    if "user" not in session:
        flash("Please login first!")
        return redirect("/login")
    
    username = session["user"]
    conn = db_connect()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM cart WHERE username=%s", (username,))
    items = cursor.fetchall()
    total = sum(item["price"] * item["quantity"] for item in items) * 100  # Stripe uses cents

    if request.method == "POST":
        shipping_address = request.form["shipping_address"]
        payment_method = request.form["payment_method"]

        if payment_method == "Card Payment":
            intent = stripe.PaymentIntent.create(
                amount=int(total),
                currency="usd",
                payment_method_types=["card"],
                metadata={"username": username}
            )
            conn.close()
            return render_template("card_payment.html", client_secret=intent.client_secret, total=total/100)
        else:
            cursor.execute(
                "INSERT INTO orders (username, total_amount, payment_method, shipping_address) VALUES (%s,%s,%s,%s)",
                (username, total/100, payment_method, shipping_address)
            )
            order_id = cursor.lastrowid

            for item in items:
                cursor.execute(
                    "INSERT INTO order_items (order_id, product_id, product_name, price, quantity) VALUES (%s,%s,%s,%s,%s)",
                    (order_id, item['product_id'], item['product_name'], item['price'], item['quantity'])
                )

            cursor.execute("DELETE FROM cart WHERE username=%s", (username,))
            conn.commit()
            conn.close()
            flash("Order placed successfully! Pay on delivery.")
            return redirect("/")

    conn.close()
    return render_template("checkout.html", items=items, total=total/100)

# ---------------------
# Payment Success Route
# ---------------------
@app.route("/payment-success")
def payment_success():
    flash("Payment successful! Your order is confirmed.")
    return redirect("/")

# ---------------------
# RUN APP
# ---------------------
if __name__ == "__main__":
    os.makedirs(app.config["UPLOAD_FOLDER"], exist_ok=True)
    app.run(debug=True)
