import 'dart:convert';

import 'package:flutter/material.dart';

import '../../domain/models/lecture.dart';

class LectureWidget extends StatelessWidget {
  final Lecture lecture;

  const LectureWidget({super.key,
    required this.lecture,
  });

  double getHeight(Lecture lecture) {
    double from = double.parse(lecture.timeFrom.substring(0, 2));
    double to = double.parse(lecture.timeTo.substring(0, 2)) + 1;
    double interval = to - from;
    return 50 * interval;
  }


  Color hexStringToColor(String? hexString) {
    if(hexString == null){
      return Colors.green;
    }
    hexString = hexString.replaceAll("#", "");
    int hexValue = int.parse(hexString, radix: 16);
    return Color(hexValue | 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
      ),
      child: Container(
        height: getHeight(lecture),
        width: 100,
        decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(lecture.room.name),
              Text(lecture.course.subject.name),
              Text(lecture.professor.name),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  String jsonString = '{"id":1,"name":null,"originalLecture":null,"day":0,"timeFrom":"08:00:00","timeTo":"09:45:00","professor":{"id":"aleksandar.stojmenski","name":"Александар Стојменски","email":null,"professorTitle":null},"course":{"id":"W23strukturno.programiranje","semester":{"code":"W23","year":"2023","semesterType":1},"subject":{"id":"strukturno.programiranje","name":"Структурно програмирање","level":1,"abbreviation":null}},"room":{"name":"315 ТМФ"},"type":0}';

  Map<String, dynamic> jsonMap = json.decode(jsonString);
  Lecture lecture = Lecture.fromJson(jsonMap);
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: LectureWidget(
           lecture: lecture,
          ),
        ),
      ),
    ),
  );
}
