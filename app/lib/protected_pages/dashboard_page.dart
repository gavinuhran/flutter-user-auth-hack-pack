import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String firstName = '';

  @override
  void initState() {
    super.initState();
    getUserFirstName();
  }

  Future<void> getUserFirstName() async {
    try {
      final apiService = ApiService();
      final userFirstName = await apiService.getUserFirstName();
      setState(() {
        firstName = userFirstName;
      });
    } catch (e) {
      // Handle error
      print('Failed to get user firstName: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: Text('Welcome to the Dashboard, $firstName'),
      ),
    );
  }
}
