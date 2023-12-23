import 'package:simple_app/domain/models/lecture.dart';

class Schedule {
  int id;
  String name;
  String description;
  List<Lecture> lectures;

  Schedule({
    required this.id,
    required this.name,
    required this.description,
    required this.lectures,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    var lectureList = json['lectures'] as List<dynamic>;
    List<Lecture> lectures = lectureList.map((lectureJson) => Lecture.fromJson(lectureJson)).toList();

    return Schedule(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      lectures: lectures,
    );
  }

  Map<String, dynamic> toJson() {
    // Convert the 'lectures' list to a list of JSON objects using Lecture.toJson
    List<Map<String, dynamic>> lecturesJson = lectures.map((lecture) => lecture.toJson()).toList();

    return {
      'id': id,
      'name': name,
      'description': description,
      'lectures': lecturesJson,
    };
  }
}