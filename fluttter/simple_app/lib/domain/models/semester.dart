import 'package:simple_app/domain/models/enums/semester_type.dart';

class Semester{
  final String code;
  final String year;
  final SemesterType semesterType;

  Semester({
    required this.code,
    required this.year,
    required this.semesterType,
  });

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
        code: json['Code'],
        year: json['Year'],
        semesterType: SemesterType.values[json['SemesterType']],
    );
  }
}