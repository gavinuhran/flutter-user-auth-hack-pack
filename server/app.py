from flask import Flask, request, jsonify
from mongodb import create_new_user, get_user
import bcrypt
import jwt
import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

app = Flask(__name__)

@app.route('/signup', methods=['POST'])
def signup():
    try:
        data = request.json
        firstName = data.get('firstName')
        lastName = data.get('lastName')
        email = data.get('email')
        password = data.get('password')

        # Perform validation and error handling as needed

        # Hash the password
        hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

        create_new_user(firstName, lastName, email, hashed_password)

        return jsonify({'message': 'User registered successfully'}), 200

    except Exception as e:
        print(f'An error occurred: {e}')
        return jsonify({'message': 'An error occurred', 'error': str(e)}), 500


@app.route('/login', methods=['POST'])
def login():
    data = request.json
    email = data.get('email')
    password = data.get('password')

    # Perform validation and error handling as needed

    # Find the user in the database
    user = get_user(email)

    if user and bcrypt.checkpw(password.encode('utf-8'), user['password']):

        # Generate a JWT token
        token = jwt.encode({'email': email}, str(os.getenv('secret-auth-key')), algorithm='HS256')

        # Return the token to the client
        return jsonify({'token': token}), 200
    else:
        return jsonify({'message': 'Invalid email or password'}), 401
    
@app.route('/user', methods=['GET'])
def getUser():
    token = request.headers.get('Authorization')

    if not token:
        return jsonify({'message': 'Missing token'}), 401

    try:
        decoded_token = jwt.decode(token, os.getenv('secret-auth-key'), algorithms=['HS256'])
        email = decoded_token.get('email')

        # Fetch user data from the database based on the email
        user = get_user(email)

        if user:
            first_name = user.get('firstName')
            return jsonify({'firstName': first_name}), 200
        else:
            return jsonify({'message': 'User not found'}), 404

    except jwt.ExpiredSignatureError:
        return jsonify({'message': 'Expired token'}), 401
    except jwt.InvalidTokenError:
        return jsonify({'message': 'Invalid token'}), 401

if __name__ == '__main__':
    app.run(debug=True)
