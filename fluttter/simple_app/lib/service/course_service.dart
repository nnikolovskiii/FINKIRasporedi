import 'dart:convert';

import 'package:http/http.dart' as http;

import '../domain/models/course.dart';

class CourseService {
  final String baseUrl = 'https://localhost:7069/api';

  Future<List<Course>> getCoursesWithPagination({int page = 1, int size = 5}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/Courses?page=$page&size=$size'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Course.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<Course>> getCourses() async {
    final response = await http.get(
      Uri.parse('$baseUrl/Courses'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Course.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
