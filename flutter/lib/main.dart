import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/screens/auth/login.dart';
import 'package:flutter_app/presentation/screens/schedules_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'domain/configs/app_config.dart';
import 'domain/providers/schedule_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.forEnvironment();

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
      home: const SchedulesScreen(),
      routes: {
        '/home': (context) => const SchedulesScreen(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
