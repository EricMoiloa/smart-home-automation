import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:smartlife/Api%20services/token_storage.dart';

class LoginApiServices {
  final String _baseUrl = 'http://127.0.0.1:8000';
  final SecureStorage _secureStorage = SecureStorage();

  Future<http.Response> createUser(
      String username, String email, String password) async {
    final body = {
      'username': username,
      'email': email,
      'password': password,
    };
    final response = await http.post(Uri.parse('$_baseUrl/users'),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));

    // Check for 307 status code
    if (response.statusCode == 307) {
      // Extract redirect location from headers
      final location = response.headers['location'];
      if (location != null) {
        // Follow the redirect (consider max redirects to avoid loops)
        final followUpResponse = await http.post(Uri.parse(location),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(body));
        return followUpResponse;
      } else {
        // Handle error: missing location header in redirect
        throw Exception(
            'Temporary redirect (307) received but location header missing');
      }
    } else {
      return response; // Return original response if not a 307
    }
  }

  Future<http.Response> login(String email, String password) async {
   

    final response = await http.post(
      Uri.parse('$_baseUrl/login'), // login endpoint is login
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
     body: {
        'username': email, 
        'password': password,
      },
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      // Login successful, handle response (e.g., extract token)
      print('Login successful');
      return response;
    } else if (response.statusCode == 307) {
      // Handle 307 redirect if necessary
      final location = response.headers['location'];
      if (location != null) {
        final followUpResponse = await http.post(
          Uri.parse(location),
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {
        'username': email, // The key should be 'username' as FastAPI expects it
        'password': password,
      },
        );
        return followUpResponse;
      } else {
        throw Exception(
            'Temporary redirect (307) received but location header missing');
      }
    } else {
      // Handle other errors
      final message = response.reasonPhrase ?? 'Login failed';
      throw Exception('Login failed: $message');
    }
  }

  Future<http.Response> getProtectedData() async {
    final token = await _secureStorage.readToken();
    final response = await http.get(
      Uri.parse('$_baseUrl/protected-endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  }

  Future<http.Response> getUser(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));
    return response;
  }
}
