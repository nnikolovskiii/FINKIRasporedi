import 'package:simple_app/domain/models/course.dart';
import 'package:simple_app/domain/models/professor.dart';
import 'package:simple_app/domain/models/room.dart';

import 'enums/day.dart';

class Lecture {
  int id;
  String? name;
  int day;
  double timeFrom;
  double timeTo;
  Professor professor;
  Course course;
  Room room;

  Lecture({
    required this.id,
    required this.name,
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
        name: json['name'],
        day: json['day'],
        timeFrom: double.parse(json['timeFrom'].substring(0, 2)),
        timeTo: double.parse(json['timeTo'].substring(0, 2))+1,
        professor: Professor.fromJson(json['professor']),
        course: Course.fromJson(json['course']),
        room: Room.fromJson(json['room']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'day': day,
      'timeFrom': timeFrom,
      'timeTo': timeTo,
      'professorId': professor.toJson(),
      'courseId': course.toJson(),
      'roomName': room.toJson(),
    };
  }
}
