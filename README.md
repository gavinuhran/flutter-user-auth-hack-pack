# Flutter/Flask User Authentication Hack Pack
## Description
This repository is a flutter application that is completely bare, other than implementing user authentication to reach a protected dashboard. The tech stack is **Flutter**, **Flask**, and **MongoDB**.
## Prerequisites
1. You have initialized a MongoDB database and have created a username and password that enables you to access said database
2. You have a supported Python version. Users have encountered issues when using Python 11+. I personally use Python 3.9.1
3. You have flutter installed successfully. Check your Flutter status by running `flutter doctor` in terminal
## Instructions
1. In your MongoDB database, initialize a new collection called `users`
2. Clone this repository
```
git clone https://github.com/gavinuhran/flutter-user-auth-hack-pack.git
```
3. Move your working directory into the repository's server folder
```
cd flutter-user-auth-hack-pack/server
```
4. Copy `.env-example` into a new file called `.env`
5. In `.env`, fill the placeholder MongoDB credentials with your own credentials
6. In `.env`, fill the placeholder `SECRET_AUTH_KEY` with your own key. You can generate your own secret auth key by running the following code in a Python file:
```
import secrets

secret_key = secrets.token_hex(32)
print(secret_key)
```
7.  Initialize a virtual environment
```
python -m venv venv
source venv/bin/activate    # if on Windows, use source venv/Scipts/activate
pip install -r requirements.txt
```
8. Run the server
```
python -m flask run
```
9. Run the flutter application
```
cd ../app
flutter pub get
flutter run --debug
``` 