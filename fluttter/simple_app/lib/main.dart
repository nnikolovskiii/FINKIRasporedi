import 'package:flutter/material.dart';
import 'package:simple_app/presentation/widgets/porfessor_widget.dart';

import 'api/api_service.dart';
import 'domain/models/professor.dart';

void main() async {
  final apiService = ApiService();
  final List<Professor> professors = await apiService.fetchData();
  runApp(MyApp(professors: professors));
}

class MyApp extends StatelessWidget {
  final List<Professor> professors;

  const MyApp({required this.professors, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Your theme configuration here...
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo Home Page'),
        ),
        body: Center(
          child: ListView(
            children: professors.map((professor) {
              return ProfessorWidget(professor: professor);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
