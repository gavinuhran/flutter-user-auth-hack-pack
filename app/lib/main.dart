import 'package:flutter/material.dart';
import 'authentication/login_page.dart';
import 'authentication/signup_page.dart';
import 'protected_pages/dashboard_page.dart';
import 'services/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/dashboard') {
          // Check if the user is authenticated before accessing the dashboard
          return MaterialPageRoute(
            builder: (_) {
              return FutureBuilder<bool>(
                future: AuthService().isAuthenticated(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading indicator or splash screen
                    return const CircularProgressIndicator();
                  } else if (snapshot.data == true) {
                    // User is authenticated, allow access to the dashboard
                    return const DashboardPage();
                  } else {
                    // User is not authenticated, redirect to the login page
                    return LoginPage();
                  }
                },
              );
            },
          );
        } else if (settings.name == '/login') {
          // Handle the '/login' route
          return MaterialPageRoute(
            builder: (_) => LoginPage(),
          );
        } else {
          // Handle unknown routes or fallback to a default page
          return MaterialPageRoute(
            builder: (_) => LoginPage(),
          );
        }
      },
    );
  }
}
