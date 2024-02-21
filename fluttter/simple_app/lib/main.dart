import 'package:flutter/material.dart';
import 'package:simple_app/presentation/screens/auth/login.dart';
import 'package:simple_app/presentation/screens/list/schedule_list_screen.dart';
import 'package:simple_app/service/shared_service.dart';

Widget _defaultHome = const LoginPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get result of the login function.
  bool _result = await SharedService.isLoggedIn();
  if (_result) {
    _defaultHome = ScheduleListScreen();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => _defaultHome,
        '/home': (context) => ScheduleListScreen(),
        '/login': (context) => const LoginPage(),
        //  '/register': (context) => const RegisterPage(),
      },
    );
  }
}
