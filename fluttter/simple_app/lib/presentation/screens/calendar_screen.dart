import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:simple_app/service/schedule_service.dart';

import '../../domain/models/schedule.dart';
import '../schedule_mapper/schedule_widget.dart';
import 'list/course_list_screen.dart';

void main() {

  runApp(MaterialApp(
    home: CalendarScreen(1),
  ));
}
class CalendarScreen extends StatefulWidget {
  final int scheduleId;

  CalendarScreen(this.scheduleId);

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
    return MaterialApp(
      theme: theme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Your App Title'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flex(
              direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to a different screen when the button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseListScreen(schedule: scheduleFuture!),
                        ),
                      );
                    },
                    child: Text('Add subjects'),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to a different screen when the button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseListScreen(schedule: scheduleFuture!),
                        ),
                      );
                    },
                    child: Text('Create custom lecture'),
                  ),
                ),
              ]),
            Expanded(
              child: scheduleFuture != null
                  ? Center(
                child: ScheduleWidget(schedule: scheduleFuture!, segmented: true,),
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

