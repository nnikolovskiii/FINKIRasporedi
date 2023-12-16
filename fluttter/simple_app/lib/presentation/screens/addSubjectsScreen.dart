import 'package:flutter/material.dart';
import 'package:simple_app/service/course_service.dart';
import 'package:simple_app/domain/models/course.dart';

Color myCustomColor2 = Color(0xFF42587F);

ThemeData theme = ThemeData(
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 18, color: Colors.white70),
  ),
  appBarTheme: const AppBarTheme(
    color: Color(0xFFF9DB6D),
    iconTheme: IconThemeData(color: Colors.grey),
    titleTextStyle: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: myCustomColor2,
    brightness: Brightness.light,
  ),
);

class Subject {
  final String? name;

  Subject({this.name});
}

List<Subject> subjects = [];

void main() => runApp(const SearchBarApp());

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({Key? key}) : super(key: key);

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  bool isDark = false;
  List<Subject> filteredSubjects = [];
  List<Course> courses = []; // Add a list to store courses
  CourseService _courseService = CourseService(); // Initialize CourseService

  @override
  void initState() {
    super.initState();
    fetchCourses(); // Fetch courses when the app starts
  }

  void fetchCourses() async {
    try {
      List<Course> fetchedCourses = await _courseService.getCoursesWithPagination();
      setState(() {
        courses = fetchedCourses;
        filteredSubjects = courses.map((course) => Subject(name: course.subject.name)).toList();

        // Debugging: Print the fetched courses and subjects
        print('Fetched Courses: $courses');
        print('Filtered Subjects: $filteredSubjects');
      });
    } catch (e) {
      // Print error message
      print('Error fetching courses: $e');
      // Handle error scenarios here
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    return MaterialApp(
      theme: theme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Избери предмети'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Search bar and suggestions
              SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    onTap: () {},
                    onChanged: (String value) {
                      setState(() {
                        if (value.isEmpty) {
                          filteredSubjects = courses.map((course) => Subject(name: course.subject.name)).toList();
                        } else {
                          filteredSubjects = courses
                              .where((course) => course.subject.name?.toLowerCase().startsWith(value.toLowerCase()) ?? false)
                              .map((course) => Subject(name: course.subject.name))
                              .toList();
                        }
                      });
                    },
                    leading: const Icon(Icons.search),
                  );
                },
                suggestionsBuilder: (
                    BuildContext context,
                    SearchController controller,
                    ) {
                  return List<Widget>.generate(filteredSubjects.length, (int index) {
                    final String item = filteredSubjects.elementAt(index).name as String;
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        // Add functionality on selecting a suggestion if needed
                      },
                    );
                  });
                },
              ),
              // Display the filtered list
              Expanded(
                child: ListView.builder(
                  itemCount: filteredSubjects.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String itemName = filteredSubjects[index].name ?? '';
                    return ListTile(
                      title: Text(itemName),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
