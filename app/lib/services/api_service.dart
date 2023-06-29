import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://your-backend-api-url.com';

  Future<String> loginUser(String email, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/login'),
        body: {'email': email, 'password': password});

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<String> signUpUser(String firstName, String lastName, String email, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/signup'),
        body: {'firstName': firstName, 'lastName': lastName, 'email': email, 'password': password});

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to sign up');
    }
  }
}
