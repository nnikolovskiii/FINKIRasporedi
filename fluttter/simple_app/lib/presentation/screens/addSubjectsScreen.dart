import 'package:flutter/material.dart';

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

void main() => runApp(const SearchBarApp());

class Subject {
  final String name;
  Subject({required this.name});
}

List<Subject> subjects = [
  Subject(name: "Mobilni informaciski sistemi"),
  Subject(name: "Menadzment informaciski sitemi"),
  Subject(name: "Marketing"),
  Subject(name: "Diskretna 1"),
  Subject(name: "Diskrenta 2"),
];

class SearchBarApp extends StatelessWidget {
  const SearchBarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избери предмети'),
      ),
      body: SubjectSelectionScreen(subjects: subjects),
    );
  }
}

class SubjectSelectionScreen extends StatefulWidget {
  final List<Subject> subjects;

  const SubjectSelectionScreen({Key? key, required this.subjects}) : super(key: key);

  @override
  _SubjectSelectionScreenState createState() => _SubjectSelectionScreenState();
}

class _SubjectSelectionScreenState extends State<SubjectSelectionScreen> {
  int _currentStep = 1;
  late List<Subject> selectedSubjects;
  late List<String> professors;

  @override
  void initState() {
    super.initState();
    selectedSubjects = [];
    professors = [];
  }

  void updateProgress() {
    setState(() {
      _currentStep++;
    });
  }

  void selectSubject(Subject subject) {
    setState(() {
      selectedSubjects.add(subject);
      updateProgress();
      professors = _getProfessorsForSubject(subject);
    });
  }

  List<String> _getProfessorsForSubject(Subject subject) {
    // Replace this with logic to fetch professors based on the selected subject
    return ["Professor 1", "Professor 2", "Professor 3"];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 40, // Adjust the height of the progress indicator as needed
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildProgressStep(1),
              _buildProgressStep(2),
              _buildProgressStep(3),
            ],
          ),
        ),
        Expanded(
          child: _currentStep == 1
              ? SubjectListView(
            subjects: widget.subjects,
            onSubjectSelected: selectSubject,
          )
              : ProfessorListView(professors: professors),
        ),
      ],
    );
  }

  Widget _buildProgressStep(int stepNumber) {
    Color color = stepNumber <= _currentStep ? Colors.green : Colors.grey;
    return Container(
      width: 20, // Adjust the width of each step as needed
      height: 20, // Adjust the height of each step as needed
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

class SubjectListView extends StatelessWidget {
  final List<Subject> subjects;
  final Function(Subject) onSubjectSelected;

  const SubjectListView({Key? key, required this.subjects, required this.onSubjectSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(subjects[index].name),
          onTap: () {
            onSubjectSelected(subjects[index]);
          },
        );
      },
    );
  }
}

class ProfessorListView extends StatelessWidget {
  final List<String> professors;

  const ProfessorListView({Key? key, required this.professors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: professors.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(professors[index]),
          // Add onTap functionality for selecting a professor if needed
        );
      },
    );
  }
}


//
// import 'package:flutter/material.dart';
// import '';
//
// Color myCustomColor2 = Color(0xFF42587F);
//
// ThemeData theme = ThemeData(
//   textTheme: const TextTheme(
//     displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//     bodyLarge: TextStyle(fontSize: 18, color: Colors.white70),
//   ),
//   appBarTheme: const AppBarTheme(
//     color: Color(0xFFF9DB6D),
//     iconTheme: IconThemeData(color: Colors.grey),
//     titleTextStyle: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
//
//   ),
//   colorScheme: ColorScheme.fromSeed(
//     seedColor: myCustomColor2,
//     brightness: Brightness.light,
//   ),
// );
//
// class Subject {
//   final String? name;
//   Subject({this.name});
// }
//
// List<Subject> subjects = [
//   Subject(name: "Mobilni informaciski sistemi"),
//   Subject(name: "Menadzment informaciski sitemi"),
//   Subject(name: "Marketing"),
//   Subject(name: "Diskretna 1"),
//   Subject(name: "Diskrenta 2"),
// ];
//
// void main() => runApp(const SearchBarApp());
//
// class SearchBarApp extends StatefulWidget {
//   const SearchBarApp({Key? key}) : super(key: key);
//
//   @override
//   State<SearchBarApp> createState() => _SearchBarAppState();
// }
//
// class _SearchBarAppState extends State<SearchBarApp> {
//   bool isDark = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final ThemeData themeData = ThemeData(
//       brightness: isDark ? Brightness.dark : Brightness.light,
//     );
//
//     return MaterialApp(
//       theme: theme,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Избери предмети'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             child: Row(
//               children: [
//                 Expanded(
//                   child: SearchAnchor(
//                     builder: (BuildContext context, SearchController controller) {
//                       return SearchBar(
//                         controller: controller,
//                         padding: MaterialStateProperty.all<EdgeInsets>(
//                           const EdgeInsets.symmetric(horizontal: 16.0),
//                         ),
//                         onTap: () {
//                           controller.openView();
//                         },
//                         onChanged: (_) {
//                           controller.openView();
//                         },
//                         leading: const Icon(Icons.search),
//                       );
//                     },
//                     suggestionsBuilder: (
//                         BuildContext context,
//                         SearchController controller,
//                         ) {
//                       return List<Widget>.generate(5, (int index) {
//                         final String item = subjects.elementAt(index).name as String;
//                         return ListTile(
//                           title: Text(item),
//                           onTap: () {
//                             setState(() {
//                               controller.closeView(item);
//                             });
//                           },
//                         );
//                       });
//                     },
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     // Add functionality for the filter icon here
//                     // For example: open a filter dialog or perform a filter action
//                   },
//                   icon: Icon(Icons.filter_list),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );}}