import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:simple_app/service/schedule_service.dart';

import '../../domain/models/schedule.dart';
import '../mapper/schedule_widget.dart'; // Replace with the actual file name
import 'addSubjectsScreen.dart'; // Updated import statement

void main() {

  runApp(MaterialApp(
    home: CalendarApp(1),
  ));
}
class CalendarApp extends StatefulWidget {
  final int scheduleId;

  CalendarApp(this.scheduleId);

  @override
  _CalendarAppState createState() => _CalendarAppState();
}

class _CalendarAppState extends State<CalendarApp> {
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Your App Title'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to a different screen when the button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchBarApp(scheduleId: widget.scheduleId),
                    ),
                  );
                },
                child: Text('Add subjects'),
              ),
            ),
            Expanded(
              child: scheduleFuture != null
                  ? Center(
                child: ScheduleWidget(schedule: scheduleFuture!),
              )
                  : Center(
                child: Padding(
                  padding: const EdgeInsets.all(80.0),
                  child: LoadingAnimationWidget.flickr(
                    leftDotColor: Color(0xFF01579B) ,
                    rightDotColor: Colors.orange,
                    size: 80,
                  ),
                ),
              ), // Loading indicator
            ),
          ],
        ),
      ),
    );
  }
}

