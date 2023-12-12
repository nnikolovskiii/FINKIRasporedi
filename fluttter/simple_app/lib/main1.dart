import 'package:flutter/material.dart';
import 'package:simple_app/domain/models/course.dart'; // Import your Course model

import 'api/api_service.dart'; // Import your API service

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService apiService = ApiService(); // Initialize your API service

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Courses and Subjects'),
        ),
        body: FutureBuilder<List<Course>>(
          future: apiService.fetchCourses(page: 1, size: 10),
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
