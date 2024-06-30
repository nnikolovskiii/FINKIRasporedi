import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/presentation/screens/schedules_screen.dart';
import 'package:flutter_app/presentation/screens/calendar_content_screen.dart';
import 'package:flutter_app/presentation/theme/app_theme.dart';
import 'package:flutter_app/service/schedule_service.dart';

import '../../domain/models/schedule.dart';
import '../../domain/providers/schedule_provider.dart';
import '../widgets/ActionButton.dart';
import '../widgets/ExpandableFab.dart';
import 'add/add_lecture_slot_screen.dart';
import 'list/course_list_screen.dart';

class CalendarScreen extends StatefulWidget {
  final int scheduleId;

  const CalendarScreen(this.scheduleId, {super.key});

  @override
  _CalendarAppState createState() => _CalendarAppState();
}

class _CalendarAppState extends State<CalendarScreen> {
  final ScheduleService scheduleService = ScheduleService();
  Schedule? scheduleFuture;

  @override
  void initState() {
    super.initState();
    _loadSchedule();
  }

  Future<void> _loadSchedule() async {
    Schedule schedule = await scheduleService.getSchedule(widget.scheduleId);
    setState(() {
      scheduleFuture = schedule;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDefault = Provider.of<ScheduleProvider>(context).isDefault;

    return MaterialApp(
      theme: brightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {
              Provider.of<ScheduleProvider>(context, listen: false).setIsDefault(true);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SchedulesScreen(),
                ),
              );
            },
            child: const Text(
              'Распоред',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF123499),
              ),
            ),
          ),
          elevation: 20,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: scheduleFuture != null
                  ? Center(
                child: CalendarContentScreen(
                  schedule: scheduleFuture!,
                ),
              )
                  : Center(
                child: Padding(
                  padding: const EdgeInsets.all(80.0),
                  child: LoadingAnimationWidget.prograssiveDots(
                    size: 80,
                    color: Colors.blue.shade800,
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: isDefault
            ? null
            : ExpandableFab(
          distance: 112,
          children: [
            ActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SchedulesScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.save),
            ),
            Row(
              children: [
                const Text(
                  "Custom",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0A2472)),
                ),
                const SizedBox(width: 5),
                ActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FieldScreen(schedule: scheduleFuture!),
                      ),
                    );
                  },
                  icon: const Icon(Icons.dashboard_customize),
                ),
              ],
            ),
            ActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseListScreen(schedule: scheduleFuture!),
                  ),
                );
              },
              icon: const Icon(Icons.add_circle_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
