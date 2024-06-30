import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/schedule_mapper/slots/transparent_time_slot_widget.dart';

import '../../../domain/configs/calendar_config.dart';

class EmptyTimeSlotWidget extends StatelessWidget {
  final bool allDays;

  EmptyTimeSlotWidget({super.key, required this.allDays});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        SizedBox(
          height: 50,
          width: allDays
              ? (width - CalendarConfig.offsetAllDays) * CalendarConfig.calNumAllDays
              : (width - CalendarConfig.offsetOneDay) * CalendarConfig.calNumOneDay,
        ),
      ],
    );
  }
}
