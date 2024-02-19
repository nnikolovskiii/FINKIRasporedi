import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_app/presentation/schedule_mapper/slots/transparent_time_slot_widget.dart';

import '../../../domain/models/lecture.dart';
import '../../../domain/models/lecture_slots.dart';
import '../../../service/schedule_service.dart';
import '../../screens/calendar_screen.dart';


class LectureWidget extends StatelessWidget {
  final ScheduleService scheduleService = ScheduleService();
  final int scheduleId;
  final bool segmented;

  List<TransparentTimeSlotWidget> getEmptyTimeSlots(LectureSlot lecture) {
    double interval = lecture.timeTo - lecture.timeFrom;
    List<TransparentTimeSlotWidget> emptyWidgets = [];

    for (double i = 0; i < interval; i++) {
      emptyWidgets.add(const TransparentTimeSlotWidget());
    }

    return emptyWidgets;
  }

  final LectureSlot lecture;

  LectureWidget({
    super.key,
    required this.lecture,
    required this.segmented, required this.scheduleId,
  });

  double getHeight(LectureSlot lecture) {
    double interval = lecture.timeTo - lecture.timeFrom;
    return 50 * interval + 8*(interval-1);
  }

  Color hexStringToColor(String? hexString) {
    if (hexString == null) {
      return Colors.green;
    }
    hexString = hexString.replaceAll("#", "");
    int hexValue = int.parse(hexString, radix: 16);
    return Color(hexValue | 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onLongPress: () {
        // Show a dialog or perform any action for deleting the lecture
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Delete Lecture'),
            content: Text('Do you want to delete this lecture?'),
            actions: [
              TextButton(
                onPressed: () async {
                  await scheduleService.removeLecture(scheduleId, lecture.id ?? -1);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CalendarScreen(scheduleId),
                    ),
                  ); // Close the dialog
                },
                child: Text('Delete'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Cancel'),
              ),
            ],
          ),
        );
      },
      child: Container(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              // border: Border(
              //   top: BorderSide(
              //     color: Colors.grey,
              //     width: 2.0,
              //   ),
              //
              // ),
            ),
            child: Container(
              height: getHeight(lecture),
              width: 100,
              decoration: BoxDecoration(
                color: hexToColor(lecture.hexColor ?? "#888888"),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      lecture.lecture!.room.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Lato'),
                    ),
                    Text(
                      lecture.lecture!.course.subject.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato',
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      lecture.lecture!.professor.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (segmented)
            Positioned(
              top: 0,
              left: 0,
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...getEmptyTimeSlots(lecture),
                ],
              ),
            ),
        ],
      ),
    )
    );
  }


  Color hexToColor(String hexColor) {
    // Remove the # character if present
    if (hexColor.startsWith('#')) {
      hexColor = hexColor.substring(1);
    }
    // Parse the hex color string to an integer
    int hexValue = int.parse(hexColor, radix: 16);
    // Create a color object from the hex value
    return Color(hexValue).withOpacity(1.0);
  }

}
