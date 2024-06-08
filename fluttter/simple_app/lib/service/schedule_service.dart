import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/models/lecture_slots.dart';
import '../domain/models/schedule.dart';

class ScheduleService {
    final String baseUrl = 'https://localhost:7069/api';

  Future<List<Schedule>> getDefaultSchedulesWithPagination(
      {int page = 0, int size = 0}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/Students/default'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      var list = jsonData.map((json) => Schedule.fromJson(json)).toList();
      return list;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

    Future<List<Schedule>> getStudentSchedules() async {
      final prefs = await SharedPreferences.getInstance();
      final loginDetails = prefs.getString('login_details');
      String token;
      if (loginDetails!= null) {
        token = jsonDecode(loginDetails)["token"];
      } else {
        throw Exception('Token does not exist. Please log in again.');
      }

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      final response = await http.get(
        Uri.parse('$baseUrl/Students/schedule'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        var list = jsonData.map((json) => Schedule.fromJson(json)).toList();
        return list;
      } else {
        throw Exception('You are not logged in.');
      }
    }


  Future<List<Schedule>> getSchedulesWithPagination(
      {int page = 0, int size = 0}) async {
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

  Future<Schedule> getSchedule(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/Schedules/$id'),
    );

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      var schedule = Schedule.fromJson(jsonData);
      return schedule;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<Schedule> addLecture(int id, LectureSlot lectureSlot) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Schedules/addLecture/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(lectureSlot.toJson()),
    );

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      var item = Schedule.fromJson(jsonData);
      return item;
    } else {
      throw Exception('Failed to add lecture');
    }
  }

  Future<Schedule> removeLecture(int id, int lectureId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/Schedules/removeLecture/$id'),
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

  Future<Schedule> addSchedule(Schedule schedule) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Schedules'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(schedule.toJson()),
    );

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      var item = Schedule.fromJson(jsonData);
      return item;
    } else {
      throw Exception('Failed to add schedule');
    }
  }

  Future<Schedule> deleteSchedule(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/Schedules/$id'),
    );

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      var item = Schedule.fromJson(jsonData);
      return item;
    } else {
      throw Exception('Failed to delete schedule');
    }
  }



}
