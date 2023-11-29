import 'package:simple_app/domain/models/enums/day.dart';
import 'package:simple_app/domain/models/professor.dart';
import 'package:simple_app/domain/models/room.dart';

import 'course.dart';

class Lecture {
  final int id;
  final Day day;
  final DateTime timeFrom;
  final DateTime timeTo;
  final Professor professor;
  final Course course;
  final Room room;

  Lecture({
    required this.id,
    required this.day,
    required this.timeFrom,
    required this.timeTo,
    required this.professor,
    required this.course,
    required this.room
  });
}
