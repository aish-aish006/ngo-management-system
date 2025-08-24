from flask import Flask, request, jsonify
import mysql.connector
from flask_cors import CORS  # Allow frontend to make requests

app = Flask(__name__)
CORS(app)

def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="Cmrit@123",
        database="ngo_management"
    )

@app.route('/donors', methods=['GET'])
def get_donors():
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT name, donation_amount FROM donors")
    donors = cursor.fetchall()
    cursor.close()
    db.close()
    return jsonify(donors)

@app.route('/add_donor', methods=['POST'])
def add_donor():
    data = request.get_json()
    name = data.get('name')
    amount = data.get('donation_amount')

    if not name or amount is None:
        return jsonify({"error": "Name and donation amount required!"}), 400

    db = get_db_connection()
    cursor = db.cursor()
    cursor.execute("INSERT INTO donors (name, donation_amount) VALUES (%s, %s)", (name, amount))
    db.commit()
    cursor.close()
    db.close()
    return jsonify({"message": "Donor added successfully!"}), 201

if __name__ == '__main__':
    app.run(debug=True)

