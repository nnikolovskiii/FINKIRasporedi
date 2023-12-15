import 'package:flutter/material.dart';
import 'package:simple_app/service/course_service.dart';
import 'package:simple_app/domain/models/course.dart'; // Import your Course model

import 'service/professor_service.dart'; // Import your API service

void main() {
  runApp(MyApp());
  ProfessorService professor_service = ProfessorService();
  professor_service.getProfessorsByCourseId(courseId: "W23veb.programiranje");
}

class MyApp extends StatelessWidget {
  final CourseService apiService = CourseService(); // Initialize your API service

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Courses and Subjects'),
        ),
        body: FutureBuilder<List<Course>>(
          future: apiService.getCoursesWithPagination(page: 1, size: 10),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No data available');
            } else {
              // Data has been successfully fetched
              List<Course> courses = snapshot.data!;
              return ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  Course course = courses[index];
                  return ListTile(
                    title: Text('Course ID: ${course.id}'),
                    subtitle: Text('Semester Code: ${course.semester.code}\nSubject: ${course.subject.name}'),
                    // Assuming 'name' is a property of the Subject class
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
