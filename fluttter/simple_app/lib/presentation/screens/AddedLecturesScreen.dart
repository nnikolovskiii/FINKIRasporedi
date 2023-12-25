import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_app/domain/models/lecture.dart';

import 'package:simple_app/presentation/screens/cardsList.dart';
import 'package:simple_app/presentation/screens/addSubjectsScreen.dart';

import '../../domain/models/course.dart';
import '../widgets/SelectedLecturesProvider.dart';

class AddedLecturesScreen extends StatelessWidget {
  final String courseId;

  AddedLecturesScreen({required this.courseId});

  @override
  Widget build(BuildContext context) {
    // Retrieve the selected lectures using the provider
    List<Lecture> selectedLectures = Provider.of<SelectedLecturesProvider>(context).selectedLectures;

    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Lectures'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchBarApp()),
                );
              },
              child: Text('Add'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedLectures.length,
              itemBuilder: (BuildContext context, int index) {
                Lecture lecture = selectedLectures[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Course ID: $courseId',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Lecture Day: ${lecture.day}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Time From: ${lecture.timeFrom}'),
                        Text('Time To: ${lecture.timeTo}'),
                        Text('Room: ${lecture.room.name}'),
                        // Add more details if needed
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Finish'),
            ),
          ),
        ],
      ),
    );
  }
}
