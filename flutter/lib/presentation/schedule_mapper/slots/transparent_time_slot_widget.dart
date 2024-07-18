import 'package:flutter/material.dart';
import '../../../domain/configs/calendar_config.dart';

class TransparentTimeSlotWidget extends StatelessWidget {
  final bool allDays;

  const TransparentTimeSlotWidget({super.key, required this.allDays});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height - 176.4;

    return Container(
      height: (height * 1 / 13) - CalendarConfig.heightOffset,
      width: allDays
          ? (width - CalendarConfig.offsetAllDays) *
              CalendarConfig.timeNumAllDays
          : (width - CalendarConfig.offsetOneDay) *
              CalendarConfig.timeNumOneDay,
      alignment: Alignment.center,
    );
  }
}
