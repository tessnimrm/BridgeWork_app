
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'http://10.0.2.2:8000';

  // SIGN UP METHOD
  Future<Map<String, dynamic>> signup({
    required String email,
    required String username,
    required String password,
    required String fullname,
  }) async {
    print('========== SIGNUP ATTEMPT ==========');
    final url = Uri.parse('$baseUrl/api/users/register/');
    print('URL: $url');
    print('Email: $email');
    print('Username: $username');
    print('Fullname: $fullname');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'username': username,
          'password': password,
          'fullname': fullname,
        }),
      ).timeout(const Duration(seconds: 10));
      
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');
      
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'message': data['details'],
        };
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? error['email']?[0] ?? 'Signup failed');
      }
    } catch (e) {
      print('Signup error: $e');
      throw Exception('Connection error: $e');
    }
  }

  // LOGIN METHOD
  Future<Map<String, dynamic>> login(String email, String password) async {
    print('========== LOGIN ATTEMPT ==========');
    final url = Uri.parse('$baseUrl/api/users/login/');
    print('URL: $url');
    print('Email: $email');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 10));
      
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', data['token']);
        await prefs.setString('refresh_token', data['refresh']);
        await prefs.setString('user_email', data['user']['email']);
        await prefs.setString('user_name', data['user']['fullname']);
        await prefs.setString('user_username', data['user']['username']);
        await prefs.setString('fullName', data['user']['fullname']);
        await prefs.setString('email', data['user']['email']);
        return data['user'];
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Login failed');
      }
    } catch (e) {
      print('Login error: $e');
      throw Exception('Connection error: $e');
    }
  }

  // LOGOUT METHOD
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refresh_token');
    
    if (refreshToken != null) {
      try {
        final url = Uri.parse('$baseUrl/api/users/logout/');
        await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${await getToken()}',
          },
          body: jsonEncode({'refresh': refreshToken}),
        );
      } catch (e) {
        print('Logout error: $e');
      }
    }
    
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('user_email');
    await prefs.remove('user_name');
    await prefs.remove('user_username');
    await prefs.remove('fullName');
    await prefs.remove('email');
  }

  // GET TOKEN
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }
  
  // CHECK IF LOGGED IN
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
}