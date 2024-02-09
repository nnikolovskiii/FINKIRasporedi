import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/presentation/schedule_mapper/slots/empty_time_slot_widget.dart';
import 'package:simple_app/presentation/schedule_mapper/slots/horizontal_divider_widget.dart';

import '../../domain/models/lecture.dart';
import 'slots/day_slot_widget.dart';
import 'slots/lecture_widget.dart';

class ColumnScheduleWidget extends StatelessWidget {
  final int day;
  final List<Lecture> lectures;
  final bool segmented;
  final int scheduleId;

  const ColumnScheduleWidget({
    super.key,
    required this.lectures,
    required this.day,
    required this.segmented,
    required this.scheduleId,
  });

  defineColumn() {
    List<Widget> lectureWidgets = [];
    lectures.sort((a, b) => a.timeFrom.compareTo(b.timeFrom));
    int j = 0;
    lectureWidgets.add(HorizontalDividerWidget(hasColor: true,));
    for (int i = 8; i < 20; i++) {
      if (j < lectures.length && i == lectures[j].timeFrom as int) {
        lectureWidgets.add(LectureWidget(
          lecture: lectures[j],
          segmented: segmented, scheduleId: scheduleId,
        ));

        double interval = lectures[j].timeTo - lectures[j].timeFrom;
        i = i + (interval as int) - 1;
        j++;
      } else {
        lectureWidgets.add(EmptyTimeSlotWidget(segmented: segmented));
      }
      if (i != 19)
        lectureWidgets.add(HorizontalDividerWidget(hasColor: true,));
    }
    return lectureWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(5.0),
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DayWidget(
                day: day,
              ),
              ...defineColumn(),
            ]),
      ),
    );
  }
}
