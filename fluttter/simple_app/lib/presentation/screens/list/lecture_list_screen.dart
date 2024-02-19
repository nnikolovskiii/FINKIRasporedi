import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/domain/models/lecture.dart';
import 'package:simple_app/presentation/screens/calendar_screen.dart';
import 'package:simple_app/service/lecture_service.dart';

import '../../../domain/models/lecture_slots.dart';
import '../../../domain/models/schedule.dart';
import '../../../service/schedule_service.dart';
import '../../schedule_mapper/slots/day_slot_widget.dart';
import '../../widgets/SelectedLecturesProvider.dart';

bool isOverlapping(Schedule schedule, Lecture lec) {
  List<LectureSlot> lectures = schedule.lectures ?? [];
  for (LectureSlot lec1 in lectures) {
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
        title: Text('Lecture Slots for ${widget.professorName}'),
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
              separatorBuilder: (BuildContext context, int index) => Divider(),
              // Divider added here
              itemBuilder: (context, index) {
                final lecture = snapshot.data![index];
                return ListTile(
                  title: Text('${DayWidget.daysMap[lecture.day]}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('From: ${lecture.timeFrom}, To: ${lecture.timeTo}'),
                      Text('Room: ${lecture.room.name}'),
                      // Add more details if needed
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
                          .addLecture(widget.schedule.id ?? 0, new LectureSlot(lecture: lecture, day: lecture.day, timeFrom: lecture.timeFrom, timeTo: lecture.timeTo));
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
                );
              },
            );
          }
        },
      ),
    );
  }
}
