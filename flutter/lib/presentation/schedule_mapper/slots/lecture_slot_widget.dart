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

class LectureWidget extends StatelessWidget {
  final ScheduleService scheduleService = ScheduleService();
  final LectureSlotService lectureSlotService = LectureSlotService();
  final Schedule schedule;
  final bool allDays;
  final LectureSlot lecture;

  LectureWidget({
    super.key,
    required this.lecture,
    required this.allDays,
    required this.schedule,
  });

  List<TransparentTimeSlotWidget> getEmptyTimeSlots(LectureSlot lecture) {
    int interval = lecture.timeTo - lecture.timeFrom;
    List<TransparentTimeSlotWidget> emptyWidgets = [];

    for (double i = 0; i < interval; i++) {
      emptyWidgets.add(TransparentTimeSlotWidget(allDays: allDays));
    }

    return emptyWidgets;
  }

  double getHeight(double height, LectureSlot lecture) {
    int interval = lecture.timeTo - lecture.timeFrom;
    return ((height * 1 / 13) - CalendarConfig.heightOffset) * interval + 8 * (interval - 1);
  }

  Color hexStringToColor(String? hexString) {
    if (hexString == null) {
      return Colors.green;
    }
    hexString = hexString.replaceAll("#", "");
    int hexValue = int.parse(hexString, radix: 16);
    return Color(hexValue | 0xFF000000);
  }

  bool isDarkColor(Color color) {
    double brightness = (color.red * 299 + color.green * 587 + color.blue * 114) / 1000;
    return brightness < 128;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height - 176.4;

    bool isDefault = Provider.of<ScheduleProvider>(context).isDefault;

    Color backgroundColor = hexToColor(lecture.hexColor ?? "#619eff");
    bool darkText = isDarkColor(backgroundColor);

    double itemWidth = allDays
        ? (width - CalendarConfig.offsetAllDays) * CalendarConfig.calNumAllDays
        : (width - CalendarConfig.offsetOneDay) * CalendarConfig.calNumOneDay;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (width > 1000 || !allDays) {
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
            child: Stack(
              children: [
                Container(
                  child: Container(
                    height: getHeight(height, lecture),
                    width: itemWidth,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildConditionalWidget(!darkText),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
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
            child: Container(
              height: getHeight(height, lecture),
              width: itemWidth,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  lecture.abbreviation ?? "",
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
      },
    );
  }

  List<Widget> _buildConditionalWidget(bool darkText) {
    List<Widget> widgets = [];

    TextStyle textStyle = TextStyle(
      color: darkText ? Colors.black : Colors.white,
      fontFamily: 'Lato',
      fontSize: 14,
    );

    if (lecture.lecture != null) {
      widgets.add(
        Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                  lecture.lecture!.room.name,
                  style: textStyle,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                child: Text(
                  lecture.lecture!.course.subject.name,
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
                  lecture.lecture!.professor.name,
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
              lecture.name ?? "",
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

  AlertDialog getAlertDialog(BuildContext context){
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              lecture.name ?? lecture.lecture!.course.subject.name,
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
            if (lecture.lecture != null) ...[
              Text(
                'Просторија: ${lecture.lecture!.room.name}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                'Професор: ${lecture.lecture!.professor.name}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ] else
              Text(
                'Лекција: ${lecture.name}',
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
                    await scheduleService.removeLecture(schedule.id ?? 0, lecture.id ?? -1);
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
                        builder: (context) => FieldScreen(schedule: schedule, lectureSlot: lecture),
                      ),
                    ); // Close the dialog
                  },
                  child: const Text(
                    'Ажурирај',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              if (lecture.lecture != null)
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    ),
                    onPressed: () async {
                      await lectureSlotService.resetLectureSlot(lecture.id ?? -1);
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
              lecture.name ?? lecture.lecture!.course.subject.name,
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
            if (lecture.lecture != null) ...[
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyLarge,
                  children: [
                    const TextSpan(
                      text: 'Просторија: ',
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextSpan(
                      text: lecture.lecture!.room.name,
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
                      text: lecture.lecture!.professor.name,
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
                      text: lecture.name,
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
