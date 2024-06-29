import 'package:flutter/material.dart';
import 'package:simple_app/presentation/screens/list/professor_list_screen.dart';
import 'package:simple_app/service/course_service.dart';
import 'package:simple_app/domain/models/course.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../domain/models/schedule.dart';
import '../../widgets/search_bar_widget.dart';

Color myCustomColor2 = const Color(0xFF42587F);

class CourseListScreen extends StatefulWidget {
  final Schedule schedule;

  const CourseListScreen({Key? key, required this.schedule}) : super(key: key);

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  bool isDark = false;
  List<Course> courses = []; // List to store courses
  List<Course> filteredCourses = []; // List to store filtered courses
  final CourseService _courseService = CourseService(); // Initialize CourseService
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCourses(); // Fetch courses when the app starts
  }

  void fetchCourses() async {
    try {
      List<Course> fetchedCourses = await _courseService.getCourses();
      setState(() {
        courses = fetchedCourses;
        filteredCourses = fetchedCourses;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching courses: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Избери предмети',
          style: TextStyle(
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
            // Search bar and suggestions
            SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                return SearchBarWidget(
                  controller: controller,
                  onChanged: (String value) {
                    setState(() {
                      if (value.isEmpty) {
                        filteredCourses = courses;
                      } else {
                        filteredCourses = courses
                            .where((course) => course.subject.name
                            .toLowerCase()
                            .startsWith(value.toLowerCase()))
                            .toList();
                      }
                    });
                  },
                  hintText: 'Пребарај предмет..',
                );
              },
              suggestionsBuilder: (
                  BuildContext context,
                  SearchController controller,
                  ) {
                return List<Widget>.generate(filteredCourses.length, (int index) {
                  final String itemName = filteredCourses[index].subject.name;
                  return ListTile(
                    title: Text(itemName),
                  );
                });
              },
            ),
            // Filter icon
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                // Implement filter functionality here
              },
            ),
            // Display the filtered list
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
                  itemCount: filteredCourses.length,
                  separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    Color backgroundColor =
                    index % 2 == 0 ? Colors.grey.shade200 : Colors.transparent;
                    final String itemName = filteredCourses[index].subject.name ?? '';
                    return Container(
                      color: backgroundColor,
                      child: ListTile(
                        title: Text(itemName),
                        onTap: () {
                          String courseName = filteredCourses[index].subject.name;
                          String courseId = filteredCourses[index].id;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Притиснавте: $courseName'),
                              duration: const Duration(seconds: 1),
                            ),
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfessorListScreen(
                                schedule: widget.schedule,
                                courseId: courseId,
                                courseName: courseName,
                              ),
                            ),
                          );
                        },
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
