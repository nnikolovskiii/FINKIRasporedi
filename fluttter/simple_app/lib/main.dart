import 'package:flutter/material.dart';
import 'package:simple_app/presentation/screens/ProfessorListScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Your theme configuration here...
      ),
      home: ProfessorListScreen(),
    );
  }
}


