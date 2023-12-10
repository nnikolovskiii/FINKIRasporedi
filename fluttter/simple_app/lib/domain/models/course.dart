import 'package:simple_app/domain/models/subject.dart';

class Course {
  String id;
  String semesterCode;
  Subject subject;

  Course({
    required this.id,
    required this.semesterCode,
    required this.subject,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      semesterCode: json['semesterCode'],
      subject: Subject.fromJson(json['semesterCode']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'semesterCode': semesterCode,
      'subjectId': subjectId,
    };
  }
}
