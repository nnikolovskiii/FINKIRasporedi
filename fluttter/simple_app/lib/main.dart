import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../presentation/screens/list/schedule_list_screen.dart';

void main() {
  runApp(MyApp());
}

Color myCustomColor2 = Color(0xFF42587F);

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
    seedColor: Color(0xFF0A2472),
  ),
);
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      darkTheme: theme,
      themeMode: ThemeMode.system,
      home:  ScheduleListScreen(), // Use a SplashScreen widget
    );
  }
}