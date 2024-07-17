import 'package:flutter/material.dart';
import 'package:flutter_app/domain/configs/calendar_config.dart';
import 'package:flutter_app/presentation/screens/login/auth.dart';
import 'package:flutter_app/presentation/screens/main_screen.dart';
import 'package:provider/provider.dart';

import 'domain/configs/app_config.dart';
import 'domain/providers/schedule_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.forEnvironment();
  await CalendarConfig.forCalendar();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ScheduleProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
      routes: {
        '/home': (context) => const MainScreen(),
        '/login': (context) => AuthScreen(),
      },
    );
  }
}
