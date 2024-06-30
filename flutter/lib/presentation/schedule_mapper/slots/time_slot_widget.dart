import 'package:flutter/material.dart';

import '../../../domain/configs/calendar_config.dart';

class TimeSlotWidget extends StatelessWidget {
  final String time;
  final bool allDays;

  TimeSlotWidget({
    Key? key,
    required this.time,
    required this.allDays,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 50,
      width: allDays
          ? (width - CalendarConfig.offsetAllDays) * CalendarConfig.timeNumAllDays
          : (width - CalendarConfig.offsetOneDay) * CalendarConfig.timeNumOneDay,
      alignment: Alignment.center,
      child: Text(
        time,
        style: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}