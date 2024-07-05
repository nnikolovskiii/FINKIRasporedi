import 'package:flutter/material.dart';
import 'package:flutter_app/domain/configs/calendar_config.dart';
import 'package:flutter_app/presentation/screens/auth/login.dart';
import 'package:flutter_app/presentation/screens/main_screen.dart';
import 'package:flutter_app/presentation/widgets/video_splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/presentation/screens/login/auth.dart';

import 'domain/configs/app_config.dart';
import 'domain/providers/schedule_provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.forEnvironment();
  await CalendarConfig.forCalendar();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ScheduleProvider(),
      child: MyApp(),
    ),
  );
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
      home: MainScreen(), // Use SplashScreen as the initial screen
      routes: {
        '/home': (context) =>  MainScreen(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
