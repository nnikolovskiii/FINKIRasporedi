import 'package:flutter/material.dart';
import 'package:simple_app/presentation/screens/auth/login.dart';
import 'package:simple_app/presentation/screens/schedules_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SchedulesScreen(),
      routes: {
        '/home': (context) => const SchedulesScreen(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
