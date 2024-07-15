import 'dart:convert';

import 'package:flutter_app/domain/models/room.dart';
import 'package:http/http.dart' as http;
import '../domain/configs/app_config.dart';

class RoomService {
  static final String baseUrl = AppConfig.apiUrl;

  Future<List<Room>> getAllRooms() async {
    final response = await http.get(
      Uri.parse('$baseUrl/Rooms'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Room.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
