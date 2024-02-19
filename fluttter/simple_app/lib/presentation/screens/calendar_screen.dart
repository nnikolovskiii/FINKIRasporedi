import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:simple_app/presentation/screens/list/schedule_list_screen.dart';
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
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => ScheduleListScreen(),
          //
          //       ),
          //     );
          //   },
          // ),
          title: const Text('Распоред',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF123499),
          ),),
          elevation: 20,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flex(
              direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: OutlinedButton(
                    onPressed: () {
                      // Navigate to a different screen when the button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseListScreen(schedule: scheduleFuture!),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(8.0), // Set padding for the button
                    minimumSize: const Size(100, 40),),
                    child: const Row(
                      children: [
                        Icon(Icons.add, color: Colors.blueGrey), // Replace with your desired icon
                        SizedBox(width: 8), // Adjust the spacing between icon and text
                        Text('Додади предмет', style: TextStyle(color: Colors.blueGrey)),
                      ],
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: OutlinedButton(

                    onPressed: () {
                      // Navigate to a different screen when the button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScheduleListScreen(),

                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Распоредот е зачуван'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(8.0), // Set padding for the button
                      minimumSize: Size(100, 40),),
                    child: const Row(
                      children: [
                        Icon(Icons.save_alt_outlined, color: Colors.blueGrey), // Replace with your desired icon
                        SizedBox(width: 8), // Adjust the spacing between icon and text
                        Text('Зачувај распоред', style: TextStyle(color: Colors.blueGrey)),
                      ],
                    ),
                  ),
                ),

//i try
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: ElevatedButton(
                //     onPressed: () {
                //       // Navigate to a different screen when the button is pressed
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => CourseListScreen(schedule: scheduleFuture!),
                //         ),
                //       );
                //     },
                //     child: Text('Create custom lecture'),
                //   ),
                // ),
              ]),
            Expanded(
              child: scheduleFuture != null
                  ? Center(
                child: ScheduleWidget(schedule: scheduleFuture!, segmented:false,),
              )
                  : Center(
                child: Padding(
                  padding: const EdgeInsets.all(80.0),
                  child: LoadingAnimationWidget.prograssiveDots(
                    // leftDotColor: Color(0xFF01579B),
                    // rightDotColor: Colors.orange,
                    size: 80,
                    color: Colors.blue.shade800,
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

