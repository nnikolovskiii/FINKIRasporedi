import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_app/domain/models/login_request_model.dart';
import 'package:simple_app/domain/models/register_request_model.dart';
import 'package:simple_app/service/shared_service.dart';

import '../domain/models/login_response_model.dart';
import '../domain/models/register_response_model.dart';

class AuthService {
  static const String baseUrl = 'https://localhost:7069/api/auth';

  static Future<bool> login(LoginRequestModel model) async {
    final response = await http.post(Uri.parse('$baseUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      return false;
    }
  }

  static Future<RegisterResponseModel> register(
      RegisterRequestModel model) async {
    final response = await http.post(Uri.parse('$baseUrl/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(model.toJson()));

    return registerResponseJson(response.body);
  }

  Future<void> logout() async {
    final response = await http.post(Uri.parse('$baseUrl/logout'));
    if (response.statusCode != 200) {
      throw Exception('Failed to logout: ${response.body}');
    }
  }
}
