import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../domain/models/lecture.dart';

class LectureService {
  static final String baseUrl = dotenv.env['API_URL'] ?? (throw Exception('API_URL environment variable not found'));

  Future<List<Lecture>> getLecturesWithPagination({int page = 1, int size = 5}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/Lectures?page=$page&size=$size'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
       var list = jsonData.map((json) => Lecture.fromJson(json)).toList();
       return list;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<Lecture>> getLecturesByCourseIdAndProfessorId({
    required String courseId,
    required String professorId,
    int page = 1,
    int size = 5
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl/Lectures?courseId=$courseId&professorId=$professorId&page=$page&size=$size'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      var list = jsonData.map((json) => Lecture.fromJson(json)).toList();
      return list;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
