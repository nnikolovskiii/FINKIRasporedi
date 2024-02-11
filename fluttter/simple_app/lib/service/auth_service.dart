import 'dart:async';
import 'dart:convert';

import '../domain/models/student.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'http://localhost:5012/api/auth';
  Student? _student;

  get user => _student;

  Future<Student?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'Username': username,
        'Password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String token = responseData['Token'];
      _student = Student(username: username, token: token);
      return _student;
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  Future<String> register(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return 'Registration successful'; // or any success message you prefer
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }

  Future<void> logout() async {
    final response = await http.post(Uri.parse('$baseUrl/logout'));
    if (response.statusCode != 200) {
      throw Exception('Failed to register: ${response.body}');
    }
  }
}