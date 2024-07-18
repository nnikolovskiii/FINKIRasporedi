import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/presentation/screens/add/add_lecture_slot_screen.dart';
import 'package:flutter_app/service/lecture_slot_service.dart';

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
              onTap: isDefault ?
                  () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return getAlertDialogDetails(context);
                  },
                );
              }
                  : null,
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
              icon: const Icon(Icons.close),
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
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                  onPressed: () async {
                    await scheduleService.removeLecture(schedule.id ?? 0, lectureSlot.id ?? -1);
                    if(context.mounted){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CalendarScreen(schedule.id ?? 0),
                      ),
                    ); // Close the dialog
                  }},
                  child: const Text(
                    'Избриши',
                    style: TextStyle(color: Colors.white),
                  ),

                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    ),
                    onPressed: () async {
                      await lectureSlotService.resetLectureSlot(lectureSlot.id ?? -1);
                      if(context.mounted){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CalendarScreen(schedule.id ?? 0),
                          ),
                        ); // Close the dialog
                      }
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
              icon: const Icon(Icons.close),
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