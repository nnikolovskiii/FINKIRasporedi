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

class Subject {
  final String? name;

  Subject({this.name});
}

List<Subject> subjects = [
  Subject(name: "Mobilni informaciski sistemi"),
  Subject(name: "Menadzment informaciski sitemi"),
  Subject(name: "Marketing"),
  Subject(name: "Diskretna 1"),
  Subject(name: "Diskrenta 2"),
];

void main() => runApp(const SearchBarApp());

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({Key? key}) : super(key: key);

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  bool isDark = false;
  List<Subject> filteredSubjects = [];

  @override
  void initState() {
    filteredSubjects = subjects; // Initialize filteredSubjects with the initial list
    super.initState();
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
                          filteredSubjects = subjects;
                        } else {
                          filteredSubjects = subjects
                              .where((subject) =>
                          subject.name?.toLowerCase().startsWith(value.toLowerCase()) ?? false)
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
