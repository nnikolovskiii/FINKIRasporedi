import '../domain/models/lecture_slots.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LectureSlotService {
  final String baseUrl = 'http://localhost:5012/api';

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
