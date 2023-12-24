import 'package:simple_app/domain/models/course.dart';
import 'package:simple_app/domain/models/professor.dart';
import 'package:simple_app/domain/models/room.dart';

class Lecture {
  int id;
  String? name;
  Lecture? originalLecture;
  int day;
  String timeFrom;
  String timeTo;
  Professor professor;
  Course course;
  Room room;
  int type;

  Lecture({
    required this.id,
    required this.name,
    required this.originalLecture,
    required this.day,
    required this.timeFrom,
    required this.timeTo,
    required this.professor,
    required this.course,
    required this.room,
    required this.type,
  });

  factory Lecture.fromJson(Map<String, dynamic> json) {
    return Lecture(
        id: json['id'],
        name: json['name'],
        originalLecture: json['originalLecture'] != null
            ? Lecture.fromJson(json['originalLecture'])
            : null,
        day: json['day'],
        timeFrom: json['timeFrom'],
        timeTo: json['timeTo'],
        professor: Professor.fromJson(json['professor']),
        course: Course.fromJson(json['course']),
        room: Room.fromJson(json['room']),
        type: json['type']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'originalLecture': originalLecture?.toJson(),
      'day': day,
      'timeFrom': timeFrom,
      'timeTo': timeTo,
      'professorId': professor.toJson(),
      'courseId': course.toJson(),
      'roomName': room.toJson(),
      'type': type
    };
  }
}
