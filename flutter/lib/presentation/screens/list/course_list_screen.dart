import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/screens/list/professor_list_screen.dart';
import 'package:flutter_app/service/course_service.dart';
import 'package:flutter_app/domain/models/course.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../domain/models/schedule.dart';
import '../../widgets/search_bar_widget.dart';

Color myCustomColor2 = const Color(0xFF42587F);

class CourseListScreen extends StatefulWidget {
  final Schedule schedule;

  const CourseListScreen({super.key, required this.schedule});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  bool isDark = false;
  List<Course> courses = [];
  List<Course> filteredCourses = [];
  final CourseService _courseService = CourseService();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCourses();
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
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF375e94),
        title: const Text(
          'Избери предмети',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFFFFFFF),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFFBBBABA),
        ),
        elevation: 20,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
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
                return List<Widget>.generate(filteredCourses.length,
                        (int index) {
                      final String itemName = filteredCourses[index].subject.name;
                      return ListTile(
                        title: Text(itemName),
                      );
                    });
              },
            ),
            // Filter icon
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
                  separatorBuilder: (BuildContext context, int index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.0), // Add space between the items
                    child: Divider(),
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final String itemName = filteredCourses[index].subject.name;
                    return GFListTile(
                        titleText: itemName,

                        onTap: () {
                          String courseName =
                              filteredCourses[index].subject.name;
                          String courseId = filteredCourses[index].id;
                          // ScaffoldMessenger.of(context).showSnackBar(
                          // SnackBar(
                          // content: Text('Притиснавте: $courseName'),
                          // duration: const Duration(seconds: 1),
                          // ),
                          // );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfessorListScreen(
                                schedule: widget.schedule,
                                courseId: courseId,
                                courseName: courseName,
                              ),
                            ),
                          );}
                    );
                  },
                ),
              )
            // Expanded(
            //   child: ListView.separated(
            //     itemCount: filteredCourses.length,
            //     separatorBuilder: (BuildContext context, int index) =>
            //         const Divider(),
            //     itemBuilder: (BuildContext context, int index) {
            //       Color backgroundColor = index % 2 == 0
            //           ? Colors.grey.shade200
            //           : Colors.transparent;
            //       final String itemName = filteredCourses[index].subject.name;
            //       return Container(
            //         color: backgroundColor,
            //         child: ListTile(
            //           title: Text(itemName),
            //           onTap: () {
            //             String courseName =
            //                 filteredCourses[index].subject.name;
            //             String courseId = filteredCourses[index].id;
            //             ScaffoldMessenger.of(context).showSnackBar(
            //               SnackBar(
            //                 content: Text('Притиснавте: $courseName'),
            //                 duration: const Duration(seconds: 1),
            //               ),
            //             );
            //
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                 builder: (context) => ProfessorListScreen(
            //                   schedule: widget.schedule,
            //                   courseId: courseId,
            //                   courseName: courseName,
            //                 ),
            //               ),
            //             );
            //           },
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}