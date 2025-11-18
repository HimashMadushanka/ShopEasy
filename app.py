import mysql.connector
from flask import Flask, render_template, request, redirect, session, flash
import bcrypt

app = Flask(__name__)
app.secret_key = "mysecretkey"  # required for sessions

# ---------------------
# DATABASE CONNECTION
# ---------------------
def db_connect():
    conn = mysql.connector.connect(
        host="localhost",
        user="root",             # your MySQL username
        password="", # your MySQL password
        database="ecommerce"     # your database name
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

        # Hash the password
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
    flash("You have been logged out.")
    return redirect("/")

# ---------------------
# RUN APP
# ---------------------
if __name__ == "__main__":
    app.run(debug=True)