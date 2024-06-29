import 'dart:io';

import '../domain/models/lecture_slots.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../domain/configs/app_config.dart';


class LectureSlotService {
  static final String baseUrl = AppConfig.apiUrl;
  Future<LectureSlot> updateLectureSlot(int lectureSlotId, LectureSlot lectureSlot) async {
    final response = await http.put(
      Uri.parse('$baseUrl/LecturesSlots/$lectureSlotId'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(lectureSlot.toJson()),
    );

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      var item = LectureSlot.fromJson(jsonData);
      return item;
    } else {
      throw Exception('Failed to add schedule');
    }
  }

  Future<LectureSlot> resetLectureSlot(int lectureSlotId) async {
    final response = await http.put(
      Uri.parse('$baseUrl/LecturesSlots/reset/$lectureSlotId'),
    );

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);
      var item = LectureSlot.fromJson(jsonData);
      return item;
    } else {
      throw Exception('Failed to add schedule');
    }
  }
}
