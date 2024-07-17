import 'package:flutter/material.dart';

import '../../../domain/configs/calendar_config.dart';

class TimeSlotWidget extends StatelessWidget {
  final String time;
  final bool allDays;

  const TimeSlotWidget({
    super.key,
    required this.time,
    required this.allDays,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height - 176.4;
    double itemWidth = allDays
        ? (width - CalendarConfig.offsetAllDays) * CalendarConfig.timeNumAllDays
        : (width - CalendarConfig.offsetOneDay) * CalendarConfig.timeNumOneDay;

    return Container(
      height: (height * 1 / 13) - CalendarConfig.heightOffset,
      width: itemWidth,
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          time,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
