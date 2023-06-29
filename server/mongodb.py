import os
from dotenv import load_dotenv
from pymongo import MongoClient
from flask import jsonify

# Load environment variables from .env file
load_dotenv()

CLIENT = MongoClient(f'mongodb+srv://{os.getenv("MONGODB_USERNAME")}:{os.getenv("MONGODB_PASSWORD")}@{os.getenv("MONGODB_URI")}')

def create_new_user(firstName, lastName, email, hashed_password):

    # Database and collection information
    db = CLIENT['FitGenius']
    users_collection = db['users']  # Collection for storing user information

    # Check if the user already exists
    if users_collection.find_one({'email': email}):
        return jsonify({'message': 'User already exists'}), 409

    # Insert the new user into the database
    user = {'firstName': firstName, 'lastName': lastName, 'email': email, 'password': hashed_password}
    users_collection.insert_one(user)
    
def get_user(email):
    # Database and collection information
    db = CLIENT['FitGenius']
    users_collection = db['users']  # Collection for storing user information

    # Find the user in the database
    return users_collection.find_one({'email': email})