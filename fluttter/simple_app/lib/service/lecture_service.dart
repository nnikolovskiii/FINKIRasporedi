import 'dart:convert';

import 'package:http/http.dart' as http;

import '../domain/models/lecture.dart';

class LectureService {
  final String baseUrl = 'http://localhost:5012/api';

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

  Future<List<Lecture>> getLecturesByCourseIdAndProfessorId({int page = 1, int size = 5}) async {
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
}
