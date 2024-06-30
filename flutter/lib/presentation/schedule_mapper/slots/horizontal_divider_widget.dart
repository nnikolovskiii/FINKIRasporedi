import 'package:flutter/material.dart';

import '../../../domain/configs/calendar_config.dart';

class HorizontalDividerWidget extends StatelessWidget {
  final bool hasColor;
  final bool allDays;
  final bool time;

  HorizontalDividerWidget({super.key, required this.hasColor, required this.allDays, required this.time});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double itemWidth;
    if (time){
      itemWidth = allDays
          ? (width - CalendarConfig.offsetAllDays) * CalendarConfig.timeNumAllDays
          : (width - CalendarConfig.offsetOneDay) * CalendarConfig.timeNumOneDay;
    }else{
      itemWidth = allDays
          ? (width - CalendarConfig.offsetAllDays) * CalendarConfig.calNumAllDays
          : (width - CalendarConfig.offsetOneDay) * CalendarConfig.calNumOneDay;
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(0,3.0, 0, 3.0),
        width:  itemWidth,
        height: 2.0,
        color: hasColor ? Colors.grey.shade300 : null);
  }
}
