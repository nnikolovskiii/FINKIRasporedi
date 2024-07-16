import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/domain/models/professor.dart';
import 'package:flutter_app/domain/models/schedule.dart';
import 'package:flutter_app/service/professor_service.dart';
import 'package:flutter_app/service/course_service.dart';

import '../../widgets/search_bar_widget.dart';
import 'lecture_list_screen.dart';

class ProfessorListScreen extends StatefulWidget {
  final Schedule schedule;
  final String courseId;
  final String courseName;

  const ProfessorListScreen(
      {super.key,
      required this.schedule,
      required this.courseId,
      required this.courseName});

  @override
  State<ProfessorListScreen> createState() =>
      _ProfessorListScreenState(courseId, courseName);
}

class _ProfessorListScreenState extends State<ProfessorListScreen> {
  final String courseId;
  final String courseName;
  List<Professor> professors = [];
  List<Professor> filteredProfessors = [];
  ProfessorService professorService = ProfessorService();
  CourseService courseService = CourseService();
  final TextEditingController _searchController = TextEditingController();

  _ProfessorListScreenState(this.courseId, this.courseName);

  @override
  void initState() {
    super.initState();
    fetchProfessors();
  }

  Future<void> fetchProfessors() async {
    try {
      List<Professor> fetchedProfessors =
          await professorService.getProfessorsByCourseId(courseId: courseId);
      setState(() {
        professors = fetchedProfessors;
        filteredProfessors = fetchedProfessors;
      });
    } catch (e) {
      throw HttpStatus.notFound;
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
        title: Text(
          courseName,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF123499),
          ),
        ),
        elevation: 20,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchBarWidget(
              controller: _searchController,
              onChanged: filterProfessors,
              hintText: "Пребарај професор..",
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: filteredProfessors.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (context, index) {
                  Color backgroundColor = index % 2 == 0
                      ? Colors.transparent
                      : Colors.grey.shade200;
                  return GestureDetector(
                    onTap: () {
                      final selectedProfessor = filteredProfessors[index];
                      String professorId = selectedProfessor.id;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LectureListScreen(
                            schedule: widget.schedule,
                            professorId: professorId,
                            professorName: selectedProfessor.name,
                            courseId: courseId,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      color: backgroundColor,
                      child: ListTile(
                        title: Text(filteredProfessors[index].name),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
