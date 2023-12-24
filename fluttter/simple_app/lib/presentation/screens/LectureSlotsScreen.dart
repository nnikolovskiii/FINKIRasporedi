import 'package:flutter/material.dart';
import 'package:simple_app/domain/models/lecture.dart';
import 'package:simple_app/service/lecture_service.dart'; // Import your lecture service


class LectureSlotsScreen extends StatelessWidget {
  final String professorId;
  final String professorName;
  final String courseId;
  final LectureService lectureService = LectureService(); // Initialize LectureService

  LectureSlotsScreen({required this.professorId, required this.professorName, required this.courseId});


  @override
  Widget build(BuildContext context) {
    print(courseId);
    print(professorId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Lecture Slots for $professorName'),
      ),
      body: FutureBuilder<List<Lecture>>(
        future: lectureService.getLecturesByCourseIdAndProfessorId(
          courseId: courseId,
          professorId: professorId,
          page: 1,
          size: 5,
        ),
        builder: (BuildContext context, AsyncSnapshot<List<Lecture>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No lectures available'),
            );
          } else {
            // Display the list of lecture slots
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final lecture = snapshot.data![index];
                return ListTile(
                  title: Text('Lecture ID: ${lecture.id}'),
                  subtitle: Text('Time: ${lecture.day}'),
                  // Add more details if needed
                );
              },
            );
          }
        },
      ),
    );
  }
}
