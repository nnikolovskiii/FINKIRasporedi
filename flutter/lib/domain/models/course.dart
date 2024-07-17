import 'package:flutter_app/domain/models/semester.dart';
import 'package:flutter_app/domain/models/subject.dart';

class Course {
  String id;
  Semester semester;
  Subject subject;

  Course({
    required this.id,
    required this.semester,
    required this.subject,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      semester: Semester.fromJson(json['semester']),
      subject: Subject.fromJson(json['subject']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'semester': semester,
      'subject': subject.toJson(),
    };
  }
}
