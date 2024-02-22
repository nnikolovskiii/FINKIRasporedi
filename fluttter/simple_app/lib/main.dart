import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:simple_app/presentation/screens/auth/sign_in.dart';
import 'package:simple_app/service/lecture_slot_service.dart';
import 'package:simple_app/service/shared_service.dart';
import '../presentation/screens/list/schedule_list_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool result = await SharedService.isLoggedIn();
  Widget defaultHome = result ? ScheduleListScreen() : const SignIn();

  runApp(MyApp(defaultHome: defaultHome));
}

class MyApp extends StatelessWidget {
  final Widget defaultHome;

  const MyApp({Key? key, required this.defaultHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: defaultHome,
      routes: {
        '/home': (context) => ScheduleListScreen(),
        '/login': (context) => const SignIn(),
      },
    );
  }
}
