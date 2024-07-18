import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/presentation/schedule_mapper/slots/transparent_time_slot_widget.dart';
import 'package:flutter_app/presentation/screens/add/add_lecture_slot_screen.dart';
import 'package:flutter_app/service/lecture_slot_service.dart';

import '../../../domain/configs/calendar_config.dart';
import '../../../domain/models/lecture_slots.dart';
import '../../../domain/models/schedule.dart';
import '../../../domain/providers/schedule_provider.dart';
import '../../../service/schedule_service.dart';
import '../../screens/calendar/calendar_screen.dart';

class LectureSlotWidgetMin extends StatelessWidget {
  final ScheduleService scheduleService = ScheduleService();
  final LectureSlotService lectureSlotService = LectureSlotService();
  final LectureSlot lectureSlot;
  final double height;
  final double width;
  final Color color;
  final bool allDays;
  final Schedule schedule;

  LectureSlotWidgetMin({
    super.key,
    required this.lectureSlot, required this.height, required this.width, required this.color, required this.allDays, required this.schedule,
  });


  bool isDarkColor(Color color) {
    double brightness = (color.red * 299 + color.green * 587 + color.blue * 114) / 1000;
    return brightness < 128;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDefault = Provider.of<ScheduleProvider>(context).isDefault;

    bool darkText = isDarkColor(color);


          if (screenWidth > 1000 || !allDays) {
            return GestureDetector(
              onLongPress: isDefault
                  ? null
                  : () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return getAlertDialog(context);
                  },
                );
              },
              child:
                  Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        lectureSlot.abbreviation ?? "",
                        style: TextStyle(
                          color: darkText ? Colors.white : Colors.black,
                          fontFamily: 'Lato',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
            );
          }
          // } else {
          //   return GestureDetector(
          //     onTap: isDefault ?
          //         () {
          //       showDialog(
          //         context: context,
          //         builder: (context) {
          //           return getAlertDialogDetails(context);
          //         },
          //       );
          //     }
          //         : null,
          //     onLongPress: isDefault
          //         ? null
          //         : () {
          //       showDialog(
          //         context: context,
          //         builder: (context) {
          //           return getAlertDialog(context);
          //         },
          //       );
          //     },
          //     child: Container(
          //       height: getHeight(height, lectureSlot),
          //       width: itemWidth,
          //       decoration: BoxDecoration(
          //         color: backgroundColor,
          //         borderRadius: BorderRadius.circular(10.0),
          //       ),
          //       child: Center(
          //         child: Text(
          //           lectureSlot.abbreviation ?? "",
          //           style: TextStyle(
          //             color: darkText ? Colors.white : Colors.black,
          //             fontFamily: 'Lato',
          //             fontSize: 12,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ),
          //     ),
          //   );
          // }
          else{
            return Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10.0),
              ),
            );
          }

  }

  List<Widget> _buildConditionalWidget(bool darkText) {
    List<Widget> widgets = [];

    TextStyle textStyle = TextStyle(
      color: darkText ? Colors.black : Colors.white,
      fontFamily: 'Lato',
      fontSize: 14,
    );

    if (lectureSlot.lecture != null) {
      widgets.add(
        Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                  lectureSlot.lecture!.room.name,
                  style: textStyle,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                child: Text(
                  lectureSlot.lecture!.course.subject.name,
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                  lectureSlot.lecture!.professor.name,
                  style: textStyle,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      widgets.add(
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
            child: Text(
              lectureSlot.name ?? "",
              style: textStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
    }

    return widgets;
  }


  AlertDialog getAlertDialog(BuildContext context){
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              lectureSlot.name ?? lectureSlot.lecture!.course.subject.name,
              style: Theme.of(context).textTheme.headlineMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            if (lectureSlot.lecture != null) ...[
              Text(
                'Просторија: ${lectureSlot.lecture!.room.name}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Професор: ${lectureSlot.lecture!.professor.name}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ] else
              Text(
                'Лекција: ${lectureSlot.name}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            const SizedBox(height: 20),
            Text(
              'Изберете акција:',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                  onPressed: () async {
                    await scheduleService.removeLecture(schedule.id ?? 0, lectureSlot.id ?? -1);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CalendarScreen(schedule.id ?? 0),
                      ),
                    ); // Close the dialog
                  },
                  child: const Text(
                    'Избриши',
                    style: TextStyle(color: Colors.white),
                  ),

                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FieldScreen(schedule: schedule, lectureSlot: lectureSlot),
                      ),
                    ); // Close the dialog
                  },
                  child: const Text(
                    'Ажурирај',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              if (lectureSlot.lecture != null)
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    ),
                    onPressed: () async {
                      await lectureSlotService.resetLectureSlot(lectureSlot.id ?? -1);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CalendarScreen(schedule.id ?? 0),
                        ),
                      ); // Close the dialog
                    },
                    child: const Text(
                      'Ресетирај',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  AlertDialog getAlertDialogDetails(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              lectureSlot.name ?? lectureSlot.lecture!.course.subject.name,
              style: Theme.of(context).textTheme.headlineMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            if (lectureSlot.lecture != null) ...[
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyLarge,
                  children: [
                    const TextSpan(
                      text: 'Просторија: ',
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextSpan(
                      text: lectureSlot.lecture!.room.name,
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyLarge,
                  children: [
                    const TextSpan(
                      text: 'Професор: ',
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextSpan(
                      text: lectureSlot.lecture!.professor.name,
                    ),
                  ],
                ),
              ),
            ] else
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyLarge,
                  children: [
                    const TextSpan(
                      text: 'Лекција: ',
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextSpan(
                      text: lectureSlot.name,
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

}