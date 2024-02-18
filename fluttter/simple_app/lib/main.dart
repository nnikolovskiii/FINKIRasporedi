import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/presentation/screens/wrapper.dart';
import 'package:simple_app/service/auth_service.dart';

import 'domain/models/student.dart';

void main() {
  runApp(const MyApp());
}

Color myCustomColor2 = const Color(0xFF42587F);

ThemeData theme = ThemeData(
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 14, color: Color(0xFF0A2472)),
  ),
  appBarTheme: const AppBarTheme(
    color: Color(0xFFDDDDDD),
    iconTheme: IconThemeData(color: Color(0xFF0A2472)),
    titleTextStyle: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),

  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF0A2472),
  ),
);
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Student?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme,
        darkTheme: theme,
        themeMode: ThemeMode.system,
        home:  const Wrapper(), // Use a SplashScreen widget
      ),
    );
  }
}