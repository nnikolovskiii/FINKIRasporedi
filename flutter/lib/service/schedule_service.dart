import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../domain/configs/app_config.dart';

import '../domain/models/lecture_slots.dart';
import '../domain/models/schedule.dart';

class ScheduleService {
  static final String baseUrl = AppConfig.apiUrl;
  Future<List<Schedule>> getDefaultSchedulesWithPagination(
      {int page = 0, int size = 0}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/Schedules/default'),
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
      final response = await http.get(
        Uri.parse('$baseUrl/Schedules/student'),
        headers: await _getAuthorizationHeaders(),
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
      headers: await _getAuthorizationHeaders(),
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
      final headers = await _getAuthorizationHeaders();
      final http.Response response;
      if (headers.isEmpty) {
        response = await http.get(
          Uri.parse('$baseUrl/Schedules/$id'),
        );
      }else{
        response = await http.get(
          Uri.parse('$baseUrl/Schedules/$id'),
          headers: headers,
        );
      }

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
      headers: await _getAuthorizationHeaders(),
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
      headers: await _getAuthorizationHeaders(),
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
      headers: await _getAuthorizationHeaders(),
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
      headers: await _getAuthorizationHeaders(),
    );

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      var item = Schedule.fromJson(jsonData);
      return item;
    } else {
      throw Exception('Failed to delete schedule');
    }
  }


    Future<Map<String, String>> _getAuthorizationHeaders() async {
      final prefs = await SharedPreferences.getInstance();
      final loginDetails = prefs.getString('login_details');
      if (loginDetails == null) {
        // Return an empty map if login details do not exist
        return {};
      }

      final token = jsonDecode(loginDetails)["token"];
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      return headers;
    }


}
