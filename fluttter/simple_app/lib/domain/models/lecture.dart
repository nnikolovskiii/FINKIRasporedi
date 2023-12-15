import 'package:simple_app/domain/models/course.dart';
import 'package:simple_app/domain/models/professor.dart';
import 'package:simple_app/domain/models/room.dart';

class Lecture {
  int id;
  int day;
  String timeFrom;
  String timeTo;
  Professor professor;
  Course course;
  Room room;

  Lecture({
    required this.id,
    required this.day,
    required this.timeFrom,
    required this.timeTo,
    required this.professor,
    required this.course,
    required this.room,
  });

  factory Lecture.fromJson(Map<String, dynamic> json) {
    return Lecture(
      id: json['id'],
      day: json['day'],
      timeFrom: json['timeFrom'],
      timeTo: json['timeTo'],
      professor: Professor.fromJson(json['professor']),
      course: Course.fromJson(json['course']),
      room: Room.fromJson(json['room']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': day,
      'timeFrom': timeFrom,
      'timeTo': timeTo,
      'professorId': professor.toJson(),
      'courseId': course.toJson(),
      'roomName': room.toJson(),
    };
  }
}
