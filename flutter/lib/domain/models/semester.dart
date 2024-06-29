import 'enums/semester_type.dart';

class Semester {
  String code;
  String year;
  SemesterType semesterType;

  Semester({
    required this.code,
    required this.year,
    required this.semesterType,
  });

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
      code: json['code'],
      year: json['year'],
      semesterType: SemesterType.values[json['semesterType']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'year': year,
      'semesterType': SemesterType.values.indexOf(semesterType),
    };
  }
}
