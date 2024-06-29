import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../domain/configs/app_config.dart';

import '../domain/models/professor.dart';

class ProfessorService {
  static final String baseUrl = AppConfig.apiUrl;
  Future<List<Professor>> getProfessorsWithPagination(
      {int page = 1, int size = 5}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/Professors?page=$page&size=$size'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Professor.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<Professor>> getProfessorsByCourseId(
      {required String courseId, int page = 1, int size = 10}) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/Courses/AllProfessors/$courseId?page=$page&size=$size'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      var list = jsonData.map((json) => Professor.fromJson(json)).toList();
      return list;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
