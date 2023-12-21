import 'package:flutter/material.dart';
import 'package:simple_app/domain/models/professor.dart';
import 'package:simple_app/service/professor_service.dart';

class ProfessorListScreen extends StatefulWidget {
  final String courseId;

  ProfessorListScreen({required this.courseId});

  @override
  _ProfessorListScreenState createState() => _ProfessorListScreenState(courseId);
}

class _ProfessorListScreenState extends State<ProfessorListScreen> {
  final String courseId;
  List<Professor> professors = [];
  ProfessorService professorService = ProfessorService();

  _ProfessorListScreenState(this.courseId);

  @override
  void initState() {
    super.initState();
    fetchProfessors(); // Fetch professors when the screen initializes
  }

  Future<void> fetchProfessors() async {
    try {
      List<Professor> fetchedProfessors =
      await professorService.getProfessorsByCourseId(courseId: courseId);
      setState(() {
        professors = fetchedProfessors;
        // Debugging: Print the fetched professors
        print('Fetched Professors: $professors');
      });
    } catch (e) {
      // Print error message
      print('Error fetching professors: $e');
      // Handle error scenarios here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Professors for Course: $courseId'),
      ),
      body: ListView.builder(
        itemCount: professors.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(professors[index].name), // Access professor's name
            // Add other professor details or actions if needed
          );
        },
      ),
    );
  }
}
