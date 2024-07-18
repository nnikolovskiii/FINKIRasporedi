import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain/configs/app_config.dart';
import 'domain/configs/calendar_config.dart';
import 'domain/models/lecture_slots.dart';
import 'domain/providers/schedule_provider.dart';
import 'presentation/schedule_mapper/slots/compose_lectures_slot_widget.dart';

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
    // Create overlapping LectureSlots
    List<LectureSlot> lectureSlots = [
      LectureSlot(
        id: 1,
        name: "Math",
        day: 1,
        timeFrom: 8,
        timeTo: 10,
        hexColor: "#FF0000",
        abbreviation: "MTH",
      ),
      LectureSlot(
        id: 2,
        name: "Science",
        day: 1,
        timeFrom: 9,
        timeTo: 11,
        hexColor: "#00FF00",
        abbreviation: "SCI",
      ),
      LectureSlot(
        id: 3,
        name: "History",
        day: 1,
        timeFrom: 9,
        timeTo: 12,
        hexColor: "#0000FF",
        abbreviation: "HIS",
      ),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Adjust padding as needed
            child: ComposeLecturesSlotWidget(
              lectureSlots: lectureSlots,
              allDays: true,
            ),
          ),
        ),
      ),
    );
  }
}
