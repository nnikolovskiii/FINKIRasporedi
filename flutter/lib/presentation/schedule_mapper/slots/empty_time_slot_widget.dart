import 'package:flutter/material.dart';

import '../../../domain/configs/calendar_config.dart';

class EmptyTimeSlotWidget extends StatelessWidget {
  final bool allDays;

  const EmptyTimeSlotWidget({super.key, required this.allDays});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height - 176.4;

    return Stack(
      children: [
        SizedBox(
          height: (height * 1 / 13) - CalendarConfig.heightOffset,
          width: allDays
              ? (width - CalendarConfig.offsetAllDays) *
                  CalendarConfig.calNumAllDays
              : (width - CalendarConfig.offsetOneDay) *
                  CalendarConfig.calNumOneDay,
        ),
      ],
    );
  }
}
