import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/schedule_mapper/slots/horizontal_divider_widget.dart';
import 'package:flutter_app/presentation/schedule_mapper/slots/time_slot_widget.dart';
import 'package:flutter_app/presentation/schedule_mapper/slots/transparent_time_slot_widget.dart';

class TimeColumnWidget extends StatelessWidget {
  final int startTimeHour;
  final int endTimeHour;
  final int intervalMinutes;
  final bool dayBool;
  final bool allDays;

  const TimeColumnWidget(
      {super.key,
      required this.startTimeHour,
      required this.endTimeHour,
      required this.allDays,
      this.intervalMinutes = 45,
      this.dayBool = true});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    List<Widget> timeSlots = generateTimeSlots(width);

    return Center(
      child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...timeSlots]),
    );
  }

  List<Widget> generateTimeSlots(double width) {
    List<String> timeSlots = [];
    List<Widget> widgets = [];
    if (dayBool) {
      widgets.add(TransparentTimeSlotWidget(
        allDays: allDays,
      ));
    }

    for (int i = startTimeHour; i < endTimeHour; i++) {
      String startHour = i.toString().padLeft(2, '0');
      String startMinute = '00';
      int endHour = i + 1;
      String endMinute = '00';

      String timeSlot =
          '$startHour:$startMinute - ${endHour.toString().padLeft(2, '0')}:$endMinute';
      timeSlots.add(timeSlot);
    }

    widgets.add(HorizontalDividerWidget(
      hasColor: true,
      allDays: allDays,
      time: true,
    ));
    for (int i = 0; i < timeSlots.length; i++) {
      widgets.add(TimeSlotWidget(
        allDays: allDays,
        time: timeSlots[i],
      ));
      widgets.add(HorizontalDividerWidget(
        hasColor: true,
        allDays: allDays,
        time: true,
      ));
    }

    return widgets;
  }
}
