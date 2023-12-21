import 'package:flutter/material.dart';
import 'package:simple_app/domain/models/professor.dart';
import 'package:simple_app/service/professor_service.dart';

class ProfessorListScreen extends StatefulWidget {
  final String courseId;

  ProfessorListScreen({required this.courseId});

  @override
  _ProfessorListScreenState createState() =>
      _ProfessorListScreenState(courseId);
}

class _ProfessorListScreenState extends State<ProfessorListScreen> {
  final String courseId;
  List<Professor> professors = [];
  List<Professor> filteredProfessors = [];
  ProfessorService professorService = ProfessorService();

  _ProfessorListScreenState(this.courseId);

  @override
  void initState() {
    super.initState();
    fetchProfessors(); // Fetch professors when the screen initializes
  }

  Future<void> fetchProfessors() async {
    try {
      List<Professor> fetchedProfessors = await professorService
          .getProfessorsByCourseId(courseId: courseId);
      setState(() {
        professors = fetchedProfessors;
        filteredProfessors = fetchedProfessors; // Initialize filtered list
        // Debugging: Print the fetched professors
        print('Fetched Professors: $professors');
      });
    } catch (e) {
      // Print error message
      print('Error fetching professors: $e');
      // Handle error scenarios here
    }
  }

  void filterProfessors(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProfessors = professors;
      } else {
        filteredProfessors = professors
            .where((professor) =>
            professor.name.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Professors for Course: $courseId'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterProfessors(value);
              },
              decoration: InputDecoration(
                labelText: 'Пребарај професор..',
                hintText: 'Search by name...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProfessors.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredProfessors[index].name),
                  // Add other professor details or actions if needed
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
