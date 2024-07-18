import 'package:flutter/material.dart';
import '../../../domain/configs/calendar_config.dart';

class HorizontalDividerWidget extends StatelessWidget {
  final bool hasColor;
  final bool allDays;
  final bool time;
  final double? width;

  const HorizontalDividerWidget({
    super.key,
    required this.hasColor,
    required this.allDays,
    required this.time,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth;

    if (width != null) {
      itemWidth = width!;
    } else {
      if (time) {
        itemWidth = allDays
            ? (screenWidth - CalendarConfig.offsetAllDays) * CalendarConfig.timeNumAllDays
            : (screenWidth - CalendarConfig.offsetOneDay) * CalendarConfig.timeNumOneDay;
      } else {
        itemWidth = allDays
            ? (screenWidth - CalendarConfig.offsetAllDays) * CalendarConfig.calNumAllDays
            : (screenWidth - CalendarConfig.offsetOneDay) * CalendarConfig.calNumOneDay;
      }
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 3.0, 0, 3.0),
      width: itemWidth,
      height: 2.0,
      color: hasColor ? Colors.grey.shade300 : null,
    );
  }
}
