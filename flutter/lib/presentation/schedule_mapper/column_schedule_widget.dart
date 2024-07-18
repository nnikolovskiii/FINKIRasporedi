import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/schedule_mapper/slots/compose_lectures_slot_widget.dart';
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
  final bool dayBool;

  const ColumnScheduleWidget(
      {super.key,
        required this.lectures,
        required this.day,
        required this.allDays,
        required this.schedule,
        this.dayBool = true});

  defineColumn() {
    List<Widget> lectureWidgets = [];
    lectures.sort((a, b) => a.timeFrom.compareTo(b.timeFrom));
    if (dayBool) {
      lectureWidgets.add(DayWidget(
        day: day,
        allDays: allDays,
      ));
    }
    lectureWidgets.add(HorizontalDividerWidget(
      hasColor: true,
      allDays: allDays,
      time: false,
    ));

    List<LectureSlot> overlappingLectureSlots = [];
    int to = 8;
    int currentFrom;
    int currentTo;

    for (int i = 0; i < lectures.length; i++) {
      currentFrom = lectures[i].timeFrom;
      currentTo = lectures[i].timeTo;

      if (currentFrom >= to){
        if (overlappingLectureSlots.length > 1){
          lectureWidgets.add(ComposeLecturesSlotWidget(lectureSlots: overlappingLectureSlots, allDays: allDays));
          lectureWidgets.add(HorizontalDividerWidget(
            hasColor: true,
            allDays: allDays,
            time: false,
          ));
        }else if (overlappingLectureSlots.length != 0){
          lectureWidgets.add(LectureWidget(
            lecture: overlappingLectureSlots[0],
            allDays: allDays,
            schedule: schedule,
          ));
          lectureWidgets.add(HorizontalDividerWidget(
            hasColor: true,
            allDays: allDays,
            time: false,
          ));
        }

        for (int j = 0; j < currentFrom-to; j++){
          lectureWidgets.add(EmptyTimeSlotWidget(allDays: allDays));
          lectureWidgets.add(HorizontalDividerWidget(
            hasColor: true,
            allDays: allDays,
            time: false,
          ));
        }

        if(currentTo > to){
          to = currentTo;
        }

        overlappingLectureSlots = [lectures[i]];
      }else{
        if(currentTo > to){
          to = currentTo;
        }

        overlappingLectureSlots.add(lectures[i]);
      }


    }
    if (overlappingLectureSlots.length > 1){
      lectureWidgets.add(ComposeLecturesSlotWidget(lectureSlots: overlappingLectureSlots, allDays: allDays));
      lectureWidgets.add(HorizontalDividerWidget(
        hasColor: true,
        allDays: allDays,
        time: false,
      ));
    }else if (overlappingLectureSlots.length != 0){
      lectureWidgets.add(LectureWidget(
        lecture: overlappingLectureSlots[0],
        allDays: allDays,
        schedule: schedule,
      ));
      lectureWidgets.add(HorizontalDividerWidget(
        hasColor: true,
        allDays: allDays,
        time: false,
      ));
    }

    for (int j = 0; j < 20-to; j++){
      lectureWidgets.add(EmptyTimeSlotWidget(allDays: allDays));
      lectureWidgets.add(HorizontalDividerWidget(
        hasColor: true,
        allDays: allDays,
        time: false,
      ));
    }



    return lectureWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...defineColumn(),
          ]),
    );
  }
}