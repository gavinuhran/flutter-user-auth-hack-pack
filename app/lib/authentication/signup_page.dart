import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SignUpPage extends StatelessWidget {
  final AuthService authService = AuthService();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUpPage({super.key});

  Future<void> _signUp(BuildContext context) async {
    try {
      final String token = await authService.signUpUser(
          firstNameController.text, lastNameController.text, emailController.text, passwordController.text);

      // Save the token to shared preferences or secure storage

      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      // Handle sign up error
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Sign Up Failed'),
          content: const Text('Try signing up again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text('Log In'),
                ),
                ElevatedButton(
                  onPressed: () => _signUp(context),
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
