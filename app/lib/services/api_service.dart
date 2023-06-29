import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_service.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5000';
  final storage = const FlutterSecureStorage();
  final AuthService authService = AuthService();

  Future<String> getUserFirstName() async {
    try {
      // Retrieve the user's token
      final token = await authService.getUserAuthToken();

      // Make the API call to fetch the user's firstName
      final response = await http.get(
        Uri.parse('$baseUrl/user'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        final firstName = json.decode(response.body)['firstName'];
        return firstName;
      } else {
        throw Exception('Failed to retrieve user firstName');
      }
    } catch (e) {
      throw Exception('Failed to retrieve user firstName: $e');
    }
  }
}
