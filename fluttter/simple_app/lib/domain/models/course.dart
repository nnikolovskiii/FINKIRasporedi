import 'package:simple_app/domain/models/semester.dart';
import 'package:simple_app/domain/models/subject.dart';

class Course {
  final String id;
  final Semester semester;
  final Subject subject;

  Course({
    required this.id,
    required this.semester,
    required this.subject
  });
}

