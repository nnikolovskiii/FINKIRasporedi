import 'dart:convert';

import 'package:http/http.dart' as http;

import '../domain/models/course.dart';
import '../domain/models/schedule.dart';

class ScheduleService {
  final String baseUrl = 'http://localhost:5012/api';

  Future<List<Schedule>> getSchedulesWithPagination(
      {int page = 1, int size = 5}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/Schedules?page=$page&size=$size'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      var list = jsonData.map((json) => Schedule.fromJson(json)).toList();
      return list;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<Schedule> addLecture(int id, int lectureId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Schedules/addLecture/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(lectureId),
    );

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      var item = Schedule.fromJson(jsonData);
      return item;
    } else {
      throw Exception('Failed to add lecture');
    }
  }
}
