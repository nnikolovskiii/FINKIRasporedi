import 'package:flutter/material.dart';

import '../../../domain/models/schedule.dart';
import '../add/add_lecture_slot_screen.dart';
import 'course_list_screen.dart';

class ChooseLectureScreen extends StatelessWidget {
  final Schedule schedule;

  const ChooseLectureScreen({Key? key, required this.schedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Choose Lecture'),
        ),
        body: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseListScreen(schedule: schedule),
                    ),
                  );
                },
                child: Container(
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Text(
                    'Постоечки предмети',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FieldScreen(schedule: schedule),
                    ),
                  );
                },
                child: Container(
                  color: Colors.green,
                  alignment: Alignment.center,
                  child: Text(
                    'Изборни предмети',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
