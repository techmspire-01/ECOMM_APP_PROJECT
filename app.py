from flask import Flask, request, session, jsonify, render_template, redirect
import mysql.connector

app = Flask(__name__, template_folder='api')
app.secret_key = 'super_secret_key'

DB_CONFIG = {
    'host': 'localhost',
    'user': 'techmspire',
    'password': 'securepass',
    'database': 'ecommerce_db'
}

def get_db():
    return mysql.connector.connect(**DB_CONFIG)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/home')
def home():
    if 'username' not in session:
        return redirect('/')
    return render_template('home.html')

@app.route('/products')
def products_page():
    if 'username' not in session:
        return redirect('/')
    return render_template('products.html')

@app.route('/cart')
def cart_page():
    if 'username' not in session:
        return redirect('/')
    return render_template('cart.html')

@app.route('/order')
def order_page():
    if 'username' not in session:
        return redirect('/')
    return render_template('order.html')

@app.route('/order-history')
def order_history_page():
    if 'username' not in session:
        return redirect('/')
    return render_template('order-history.html')

@app.route('/contact')
def contact_page():
    if 'username' not in session:
        return redirect('/')
    return render_template('contact.html')

@app.route('/api/login', methods=['POST'])
def login():
    data = request.form
    username = data.get('username')
    password = data.get('password')

    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT * FROM users WHERE username=%s AND password=%s", (username, password))
    user = cur.fetchone()
    cur.close()
    conn.close()

    if user:
        session['username'] = username
        return jsonify({"message": "Login successful"}), 200
    return jsonify({"message": "Unauthorized"}), 401

@app.route('/api/logout')
def logout():
    session.pop('username', None)
    return jsonify({"message": "Logged out"}), 200

@app.route('/api/products')
def get_products():
    conn = get_db()
    cur = conn.cursor(dictionary=True)
    cur.execute("SELECT id, name, price, category, image_url FROM products")
    products = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify(products)

@app.route('/api/cart', methods=['POST'])
def add_to_cart():
    if 'username' not in session:
        return jsonify({"error": "User not logged in"}), 401

    data = request.json
    product_id = data.get('product_id')
    quantity = int(data.get('quantity', 1))
    username = session['username']

    if not product_id:
        return jsonify({"error": "Missing product ID"}), 400

    conn = get_db()
    cur = conn.cursor()

    cur.execute("SELECT id, quantity FROM cart WHERE username = %s AND product_id = %s", (username, product_id))
    existing = cur.fetchone()

    if existing:
        new_qty = existing[1] + quantity
        cur.execute("UPDATE cart SET quantity = %s WHERE id = %s", (new_qty, existing[0]))
    else:
        cur.execute("INSERT INTO cart (username, product_id, quantity) VALUES (%s, %s, %s)", (username, product_id, quantity))

    conn.commit()
    cur.close()
    conn.close()
    return jsonify({"message": "Added to cart"}), 200

@app.route('/api/cart', methods=['GET'])
def get_cart():
    if 'username' not in session:
        return jsonify({"error": "User not logged in"}), 401

    username = session['username']
    conn = get_db()
    cur = conn.cursor(dictionary=True)
    cur.execute("""
        SELECT c.id, c.product_id, c.quantity, p.name AS product_name, p.price
        FROM cart c
        JOIN products p ON c.product_id = p.id
        WHERE c.username = %s
    """, (username,))
    items = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify(items)

@app.route('/api/cart/update', methods=['POST'])
def update_cart_quantity():
    if 'username' not in session:
        return jsonify({"error": "User not logged in"}), 401

    data = request.json
    cart_id = data.get('cart_id')
    quantity = int(data.get('quantity', 1))

    conn = get_db()
    cur = conn.cursor()
    cur.execute("UPDATE cart SET quantity = %s WHERE id = %s", (quantity, cart_id))
    conn.commit()
    cur.close()
    conn.close()
    return jsonify({"message": "Quantity updated"}), 200

@app.route('/api/cart/remove', methods=['POST'])
def remove_cart_item():
    if 'username' not in session:
        return jsonify({"error": "User not logged in"}), 401

    data = request.json
    cart_id = data.get('cart_id')

    conn = get_db()
    cur = conn.cursor()
    cur.execute("DELETE FROM cart WHERE id = %s", (cart_id,))
    conn.commit()
    cur.close()
    conn.close()
    return jsonify({"message": "Item removed"}), 200

@app.route('/api/order', methods=['POST'])
def place_order():
    if 'username' not in session:
        return jsonify({"error": "User not logged in"}), 401

    data = request.json
    conn = get_db()
    cur = conn.cursor()
    cur.execute("""
        INSERT INTO orders (username, name, address, payment_mode)
        VALUES (%s, %s, %s, %s)
    """, (
        session['username'],
        data.get('name'),
        data.get('address'),
        data.get('payment')
    ))
    conn.commit()
    cur.close()
    conn.close()
    return jsonify({"message": "Order placed"}), 200

@app.route('/api/order-history')
def order_history_api():
    if 'username' not in session:
        return jsonify([])

    username = session['username']
    conn = get_db()
    cur = conn.cursor(dictionary=True)
    cur.execute("""
        SELECT name, address, payment_mode, timestamp
        FROM orders
        WHERE username = %s
        ORDER BY timestamp DESC
    """, (username,))
    orders = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify(orders)

@app.route('/api/contact', methods=['POST'])
def contact():
    data = request.json
    conn = get_db()
    cur = conn.cursor()
    cur.execute("""
        INSERT INTO contacts (name, email, message)
        VALUES (%s, %s, %s)
    """, (
        data.get('name'),
        data.get('email'),
        data.get('message')
    ))
    conn.commit()
    cur.close()
    conn.close()
    return jsonify({"message": "Message received"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
