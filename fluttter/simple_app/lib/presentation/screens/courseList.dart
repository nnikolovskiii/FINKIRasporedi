import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/models/course.dart';
import '../../service/course_service.dart';

class CourseListScreen extends StatefulWidget {
  CourseListScreen();

  @override
  _CourseListScreenState createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  List<Course> courses = [];
  CourseService _courseService = CourseService();
  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  void fetchCourses() async {
    try {
      courses = await _courseService.getCourses();

    } catch (e) {
      // Print error message
      print('Error fetching courses: $e');
      // Handle error scenarios here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course List'),
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(courses[index].subject.name),
          );
        },
      ),
    );
  }
}