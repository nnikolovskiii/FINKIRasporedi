import 'package:flutter/material.dart';
import 'package:simple_app/presentation/schedule_mapper/slots/horizontal_divider_widget.dart';
import 'package:simple_app/presentation/schedule_mapper/slots/transparent_time_slot_widget.dart';

class TimeSlotWidget extends StatelessWidget {
  final int startTimeHour;
  final int endTimeHour;
  final int intervalMinutes;

  const TimeSlotWidget({
    Key? key,
    required this.startTimeHour,
    required this.endTimeHour,
    this.intervalMinutes = 45,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> timeSlots = generateTimeSlots();

    return Center(
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TransparentTimeSlotWidget(),
              ...timeSlots
            ]),
      ),
    );
  }

  List<Widget> generateTimeSlots() {
    List<String> timeSlots = [];
    List<Widget> widgets = [];
    for (int i = startTimeHour; i < endTimeHour; i++) {
      String startHour = i.toString().padLeft(2, '0');
      String startMinute = '00';
      int endHour = i + 1;
      String endMinute = '00';

      String timeSlot =
          '$startHour:$startMinute - ${endHour.toString().padLeft(2, '0')}:$endMinute';
      timeSlots.add(timeSlot);
    }

    widgets.add(HorizontalDividerWidget(hasColor: true));
    for (int i = 0; i < timeSlots.length; i++){
      widgets.add(Container(
        height: 50,
        width: 100,
        alignment: Alignment.center,
        child: Text(
          timeSlots[i],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
      if (i != timeSlots.length -1)
        widgets.add(HorizontalDividerWidget(hasColor: true,));
    }

      return widgets;
  }
}
