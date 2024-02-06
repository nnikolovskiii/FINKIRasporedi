import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/domain/models/lecture.dart';
import 'package:simple_app/presentation/screens/calendar_screen.dart';
import 'package:simple_app/service/lecture_service.dart';

import '../../../domain/models/schedule.dart';
import '../../../service/schedule_service.dart';
import '../../schedule_mapper/slots/day_slot_widget.dart';
import '../../widgets/SelectedLecturesProvider.dart';

bool isOverlapping(Schedule schedule, Lecture lec) {
  List<Lecture> lectures = schedule.lectures ?? [];
  for (Lecture lec1 in lectures) {
    if (lec1.day == lec.day) {
      bool overlap =
          ((lec1.timeFrom >= lec.timeFrom && lec1.timeFrom < lec.timeTo) ||
              (lec1.timeTo > lec.timeFrom && lec1.timeTo <= lec.timeTo) ||
              (lec1.timeFrom <= lec.timeFrom && lec1.timeTo >= lec.timeTo));

      if (overlap) {
        return true;
      }
    }
  }
  return false;
}

class LectureListScreen extends StatefulWidget {
  final Schedule schedule;
  final String professorId;
  final String professorName;
  final String courseId;
  final LectureService lectureService = LectureService();
  final ScheduleService scheduleService =
      ScheduleService(); // Initialize LectureService

  LectureListScreen({
    required this.professorId,
    required this.professorName,
    required this.courseId,
    required this.schedule,
  });

  @override
  _LectureListScreenState createState() => _LectureListScreenState();
}

class _LectureListScreenState extends State<LectureListScreen> {
  List<Lecture> selectedLectures = [];

  @override
  Widget build(BuildContext context) {
    print(widget.courseId);
    print(widget.professorId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Термини кај ${widget.professorName}'),
      ),
      body: FutureBuilder<List<Lecture>>(
        future: widget.lectureService.getLecturesByCourseIdAndProfessorId(
          courseId: widget.courseId,
          professorId: widget.professorId,
        ),
        builder: (BuildContext context, AsyncSnapshot<List<Lecture>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No lectures available'),
            );
          } else {
            // Display the list of lecture slots
            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemBuilder: (context, index) {
                final lecture = snapshot.data![index];

                // Determine background color based on index
                Color backgroundColor = index % 2 == 0 ? Colors.white70 : Colors.grey.shade200;

                return Container(
                  color: backgroundColor, // Set background color here
                  child: ListTile(
                    title: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(0,2,0,5),
                      //color: const Color(0xFFc4cfe2), // Set background color for the title text
                      child: Text(
                        '${DayWidget.daysMap[lecture.day]}',
                        style: const TextStyle(
                          color: Color(0xFF19448e),
                          //fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        // Room
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 2), // Adjust the padding as needed
                                child: Text('Просторија:', style: TextStyle(fontWeight: FontWeight.bold)),
                              ),

                              Text('${lecture.room.name}'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        // From
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 2), // Adjust the padding as needed
                                child: Text('Почеток:', style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Text('${lecture.timeFrom}:00 h'),
                            ],
                          ),
                        ),
                        // To
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 2), // Adjust the padding as needed
                                child: Text('Крај:', style: TextStyle(fontWeight: FontWeight.bold)),
                              ),

                              Text('${lecture.timeTo}:00 h'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  onTap: () async {
                    // Access the Provider instance
                    //
                    if (isOverlapping(widget.schedule, lecture)) {
                      // Show pop-up indicating overlap
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Overlap Warning'),
                            content: Text(
                                'The selected lecture overlaps with an existing one.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      await widget.scheduleService
                          .addLecture(widget.schedule.id ?? 0, lecture.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CalendarScreen(widget.schedule.id ?? 0),
                        ),
                      );
                    }
                    // Navigate to AddedLecturesScreen and pass necessary data
                  },
                ),);
              },
            );
          }
        },
      ),
    );
  }
}
