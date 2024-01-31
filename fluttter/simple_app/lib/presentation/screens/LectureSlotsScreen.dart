import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/domain/models/lecture.dart';
import 'package:simple_app/presentation/screens/calendar.dart';
import 'package:simple_app/service/lecture_service.dart';

import '../../service/schedule_service.dart';
import '../widgets/SelectedLecturesProvider.dart';
import 'AddedLecturesScreen.dart'; // Import your lecture service

class LectureSlotsScreen extends StatefulWidget {
  final int scheduleId;
  final String professorId;
  final String professorName;
  final String courseId;
  final LectureService lectureService = LectureService();
  final ScheduleService scheduleService = ScheduleService(); // Initialize LectureService

  LectureSlotsScreen({
    required this.professorId,
    required this.professorName,
    required this.courseId,
    required this.scheduleId,
  });

  @override
  _LectureSlotsScreenState createState() => _LectureSlotsScreenState();
}

class _LectureSlotsScreenState extends State<LectureSlotsScreen> {
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
          page: 1,
          size: 5,
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
              separatorBuilder: (BuildContext context, int index) => Divider(), // Divider added here
              itemBuilder: (context, index) {
                final lecture = snapshot.data![index];
                return ListTile(
                  title: Text('${lecture.day}'),
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
                    await widget.scheduleService.addLecture(widget.scheduleId, lecture.id);

                    // Navigate to AddedLecturesScreen and pass necessary data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CalendarApp(widget.scheduleId),
                      ),
                    );
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
