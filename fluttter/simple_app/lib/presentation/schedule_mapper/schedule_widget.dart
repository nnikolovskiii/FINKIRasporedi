import 'package:flutter/material.dart';

import '../../domain/models/lecture.dart';
import '../../domain/models/lecture_slots.dart';
import '../../domain/models/schedule.dart';

import 'column_schedule_widget.dart';

class ScheduleWidget extends StatelessWidget {
  final Schedule schedule;
  final bool segmented;

  const ScheduleWidget(
      {super.key, required this.schedule, required this.segmented});

  getDayColumns() {
    List<ColumnScheduleWidget> days = [];
    List<List<LectureSlot>> list = [];

    for (int i = 0; i < 5; i++) {
      List<LectureSlot> lecture = [];
      list.add(lecture);
    }

    List<LectureSlot> lectures = schedule.lectures!;

    for (int i = 0; i < lectures.length; i++) {
      int idx = lectures[i].day;
      list[idx].add(lectures[i]);
    }

    for (int i = 0; i < 5; i++) {
      days.add(ColumnScheduleWidget(
        lectures: list[i],
        day: i,
        segmented: segmented,
      ));
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            color: Colors.grey[200],
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: getDayColumns(),
            ),
          ),
          //DraggableContainer()
        ]),
      ),
    ));
  }
}
