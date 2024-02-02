import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_app/presentation/schedule_mapper/slots/transparent_time_slot_widget.dart';

import '../../../domain/models/lecture.dart';

class LectureWidget extends StatelessWidget {
  final bool segmented;

  List<TransparentTimeSlotWidget> getEmptyTimeSlots(Lecture lecture) {
    double interval = lecture.timeTo - lecture.timeFrom;
    List<TransparentTimeSlotWidget> emptyWidgets = [];

    for (double i = 0; i < interval; i++) {
      emptyWidgets.add(const TransparentTimeSlotWidget());
    }

    return emptyWidgets;
  }

  final Lecture lecture;

  const LectureWidget({
    super.key,
    required this.lecture,
    required this.segmented,
  });

  double getHeight(Lecture lecture) {
    double interval = lecture.timeTo - lecture.timeFrom;
    return 50 * interval;
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
    return Container(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
            ),
            child: Container(
              height: getHeight(lecture),
              width: 100,
              decoration: BoxDecoration(
                color: getRandomColor(),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      lecture.room.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Lato'),
                    ),
                    Text(
                      lecture.course.subject.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato',
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      lecture.professor.name,
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
    );
  }

  Color getRandomColor() {
    // List of predefined colors
    List<Color> colors = [
      Colors.lime.shade300,
      Colors.green.shade200,
      Colors.teal.shade300,
      Colors.cyan.shade200,
      Colors.indigo.shade200,
      Colors.purple.shade200,
      Colors.orange.shade200,
      Colors.deepOrange.shade200,
      Colors.red.shade200,
      Colors.pink.shade200,
      Colors.lightBlue.shade200,
      Colors.blue.shade300,
      Colors.blueGrey.shade200,
    ];

    // Get a random index
    int randomIndex = Random().nextInt(colors.length);

    // Return the random color
    return colors[randomIndex];
  }
}
