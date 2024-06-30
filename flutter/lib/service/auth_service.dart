import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/domain/models/login_request_model.dart';
import 'package:flutter_app/domain/models/register_request_model.dart';

import '../domain/configs/app_config.dart';
import '../domain/models/login_response_model.dart';

class AuthService {
  static final String baseUrl = AppConfig.apiUrl;

  static Future<bool> login(LoginRequestModel model) async {
    final response = await http.post(Uri.parse('$baseUrl/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      final loginResponse = loginResponseJson(response.body);
      await _saveLoginDetails(loginResponse);
      return true;
    } else {
      return false;
    }
  }

  static Future<String> register(
      RegisterRequestModel model) async {
    final response = await http.post(Uri.parse('$baseUrl/auth/register'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(model.toJson()));

    return response.body;
  }

  static Future<void> logout() async {
    await _clearLoginDetails();
  }

  static Future<void> _saveLoginDetails(
      LoginResponseModel loginResponse) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('login_details', jsonEncode(loginResponse.toJson()));
  }

  static Future<void> _clearLoginDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('login_details');
  }

  static Future<Map<String, dynamic>?> getLoggedInUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? loginDetailsString = prefs.getString('login_details');
    if (loginDetailsString != null) {
      final Map<String, dynamic> loginDetails =
      jsonDecode(loginDetailsString);
      return loginDetails;
    }
    return null;
  }

  static Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('login_details');
  }

  static Future<bool> isUsernameAvailable(String username) async {
    final response = await http.post(Uri.parse('$baseUrl/CheckUsernameAvailability?username=$username'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['isAvailable'];
    } else {
      throw Exception('Failed to check username availability');
    }
  }
}
