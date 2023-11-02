import 'package:flutter/material.dart';
import 'package:simple_app/presentation/screens/ProfessorListScreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:simple_app/presentation/screens/ProfessorListScreen.dart';
import 'package:simple_app/presentation/screens/cardsList.dart';

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
      home: CardList(), // Use a SplashScreen widget
    );
  }
}

