import 'domain/models/semester.dart';

void main() {
  // Sample data
  List<Map<String, dynamic>> semesterData = [
    {'code': 'S24', 'year': '2024', 'semesterType': 0},
    {'code': 'W23', 'year': '2023', 'semesterType': 1},
  ];

  // Convert the data to a list of Semester objects
  List<Semester> semesters = semesterData.map((json) => Semester.fromJson(json)).toList();

  // Print the list of Semester objects
  semesters.forEach((semester) {
    print('Code: ${semester.code}, Year: ${semester.year}, SemesterType: ${semester.semesterType}');
  });

}