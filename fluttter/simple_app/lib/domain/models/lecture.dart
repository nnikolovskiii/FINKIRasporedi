import 'package:simple_app/domain/models/professor.dart';

class Lecture {
  int id;
  int day;
  String timeFrom;
  String timeTo;
  Professor professorId;
  String courseId;
  String roomName;

  Lecture({
    required this.id,
    required this.day,
    required this.timeFrom,
    required this.timeTo,
    required this.professorId,
    required this.courseId,
    required this.roomName,
  });

  // Factory method to create a Lecture instance from JSON
  factory Lecture.fromJson(Map<String, dynamic> json) {
    return Lecture(
      id: json['id'],
      day: json['day'],
      timeFrom: json['timeFrom'],
      timeTo: json['timeTo'],
      professorId: json['professorId'],
      courseId: json['courseId'],
      roomName: json['roomName'],
    );
  }

  // Method to convert Lecture instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': day,
      'timeFrom': timeFrom,
      'timeTo': timeTo,
      'professorId': professorId,
      'courseId': courseId,
      'roomName': roomName,
    };
  }
}
