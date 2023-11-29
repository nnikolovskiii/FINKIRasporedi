import 'package:simple_app/domain/models/enums/day.dart';
import 'package:simple_app/domain/models/professor.dart';
import 'package:simple_app/domain/models/room.dart';

import 'course.dart';

class CustomLecture {
  final int id;
  final String name;
  final Day day;
  final DateTime timeFrom;
  final DateTime timeTo;
  final Professor professor;
  final Course course;
  final Room room;

  CustomLecture({
    required this.id,
    required this.name,
    required this.day,
    required this.timeFrom,
    required this.timeTo,
    required this.professor,
    required this.course,
    required this.room
  });
}
