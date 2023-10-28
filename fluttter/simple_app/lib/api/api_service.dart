import 'dart:convert';

import 'package:http/http.dart' as http;

import '../domain/models/professor.dart';

class ApiService {
  final String baseUrl = 'http://localhost:5012/api';

  Future<List<Professor>> fetchData() async {
    final response = await http.get(Uri.parse('$baseUrl/Proffesors'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      final List<Professor> professors = jsonData.map((json) {
        return Professor(
          id: json['id'],
          name: json['name'],
          email: json['email'],
          professorTitle: json['proffesorTitle']
        );
      }).toList();

      return professors;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
