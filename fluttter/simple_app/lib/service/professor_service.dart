import 'dart:convert';

import 'package:http/http.dart' as http;

import '../domain/models/professor.dart';

class ProfessorService {
  final String baseUrl = 'http://localhost:5012/api';

  Future<List<Professor>> getProfessorsWithPagination({int page = 1, int size = 5}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/Professors?page=$page&size=$size'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      final List<Professor> professors = jsonData.map((json) {
        return Professor(
            id: json['id'],
            name: json['name'],
            email: json['email'],
            professorTitle: json['proffesorTitle']);
      }).toList();

      return professors;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<Professor>> getProfessorsByCourseId({required String courseId, int page = 1, int size = 10}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/Courses/AllProfessors/$courseId?page=$page&size=$size'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      final List<Professor> professors = jsonData.map((json) {
        return Professor(
            id: json['id'],
            name: json['name'],
            email: json['email'],
            professorTitle: json['proffesorTitle']);
      }).toList();

      return professors;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
