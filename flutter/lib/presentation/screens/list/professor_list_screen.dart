import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/domain/models/professor.dart';
import 'package:flutter_app/domain/models/schedule.dart';
import 'package:flutter_app/service/professor_service.dart';
import 'package:flutter_app/service/course_service.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../widgets/search_bar_widget.dart';
import 'lecture_list_screen.dart';

class ProfessorListScreen extends StatefulWidget {
  final Schedule schedule;
  final String courseId;
  final String courseName;

  const ProfessorListScreen({
    super.key,
    required this.schedule,
    required this.courseId,
    required this.courseName,
  });

  @override
  State<ProfessorListScreen> createState() => _ProfessorListScreenState();
}

class _ProfessorListScreenState extends State<ProfessorListScreen> {
  List<Professor> professors = [];
  List<Professor> filteredProfessors = [];
  ProfessorService professorService = ProfessorService();
  CourseService courseService = CourseService();
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfessors();
  }

  Future<void> fetchProfessors() async {
    try {
      List<Professor> fetchedProfessors = await professorService
          .getProfessorsByCourseId(courseId: widget.courseId);
      setState(() {
        professors = fetchedProfessors;
        filteredProfessors = fetchedProfessors;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
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
        backgroundColor: const Color(0xFF375e94),
        title: Text(
          widget.courseName,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFFFFFFFF),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF8F8F8F),
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
            if (isLoading)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(80.0),
                  child: LoadingAnimationWidget.prograssiveDots(
                    size: 80,
                    color: Colors.blue.shade800,
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.separated(
                  itemCount: filteredProfessors.length,
                  separatorBuilder: (BuildContext context, int index) =>
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.0),
                    child: Divider(),
                  ),
                  itemBuilder: (context, index) {
                    final String professorName = filteredProfessors[index].name;
                    return GFListTile(
                      titleText: professorName,
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
                              courseId: widget.courseId,
                            ),
                          ),
                        );
                      },
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
