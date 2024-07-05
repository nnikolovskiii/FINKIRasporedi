import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/schedule_mapper/slots/empty_time_slot_widget.dart';
import 'package:flutter_app/presentation/schedule_mapper/slots/horizontal_divider_widget.dart';

import '../../domain/models/lecture_slots.dart';
import '../../domain/models/schedule.dart';
import 'slots/day_slot_widget.dart';
import 'slots/lecture_slot_widget.dart';

class ColumnScheduleWidget extends StatelessWidget {
  final int day;
  final List<LectureSlot> lectures;
  final bool allDays;
  final Schedule schedule;
  bool dayBool;

  ColumnScheduleWidget({
    super.key,
    required this.lectures,
    required this.day,
    required this.allDays,
    required this.schedule,
    this.dayBool = true
  });

  defineColumn() {
    List<Widget> lectureWidgets = [];
    lectures.sort((a, b) => a.timeFrom.compareTo(b.timeFrom));
    int j = 0;
    if (dayBool) {
      lectureWidgets.add(DayWidget(
        day: day, allDays: allDays,
      ));
    }
    lectureWidgets.add(HorizontalDividerWidget(hasColor: true, allDays: allDays, time: false,));
    for (int i = 8; i < 20; i++) {
      if (j < lectures.length && i == lectures[j].timeFrom) {
        lectureWidgets.add(LectureWidget(
          lecture: lectures[j],
          allDays: allDays, schedule: schedule,
        ));

        int interval = lectures[j].timeTo - lectures[j].timeFrom;
        i = i + (interval) - 1;
        j++;
      } else {
        lectureWidgets.add(EmptyTimeSlotWidget(allDays: allDays));
      }

      lectureWidgets.add(HorizontalDividerWidget(hasColor: true, allDays: allDays, time: false,));
    }
    return lectureWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...defineColumn(),
            ]),
      ),
    );
  }
}
