import 'package:flutter/material.dart';

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
    List<String> timeSlots = generateTimeSlots();

    return Container(
      width: 100, // Adjust width as needed
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey[200]!, // Border color
            width: 1.0, // Border width
          ),
        ),
      ),
      child: Column(
        children: timeSlots
            .map((time) => Container(
          height: 50,
          width: double.infinity, // Take full width of the container
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[200]!, // Border color
                width: 1.0, // Border width
              ),
            ),
          ),
          child: Text(
            time,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ))
            .toList(),
      ),
    );
  }

  List<String> generateTimeSlots() {
    List<String> timeSlots = [];
    for (int i = startTimeHour; i < endTimeHour; i++) {
      String startHour = i.toString().padLeft(2, '0');
      String startMinute = '00';
      int endHour = i + 1;
      String endMinute = '00';

      String timeSlot =
          '$startHour:$startMinute - ${endHour.toString().padLeft(2, '0')}:$endMinute';
      timeSlots.add(timeSlot);
    }
    return timeSlots;
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimeSlotWidget(startTimeHour: 8, endTimeHour: 19),
            ],
          ),
        ),
      ),
    ),
  );
}
