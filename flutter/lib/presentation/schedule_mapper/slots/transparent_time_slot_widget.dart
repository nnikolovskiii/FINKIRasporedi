import 'package:flutter/material.dart';

import '../../../domain/configs/calendar_config.dart';


class TransparentTimeSlotWidget extends StatelessWidget {
  bool allDays;

  TransparentTimeSlotWidget({
    Key? key,
    required this.allDays
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 50,
      width:  allDays
          ? (width - CalendarConfig.offsetAllDays) * CalendarConfig.timeNumAllDays
          : (width - CalendarConfig.offsetOneDay) * CalendarConfig.timeNumOneDay,
      alignment: Alignment.center,
    );
  }
}
