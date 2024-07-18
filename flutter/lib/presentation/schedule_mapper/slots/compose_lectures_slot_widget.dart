import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/schedule_mapper/slots/transparent_slot_widget_min.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/service/lecture_slot_service.dart';

import '../../../domain/configs/calendar_config.dart';
import '../../../domain/models/lecture_slots.dart';
import '../../../domain/models/schedule.dart';
import '../../../domain/providers/schedule_provider.dart';
import '../../../service/schedule_service.dart';
import 'horizontal_divider_widget.dart';
import 'lecture_slot_widget_min.dart';

class ComposeLecturesSlotWidget extends StatefulWidget {
  final bool allDays;
  final List<LectureSlot> lectureSlots;
  final Schedule schedule;

  ComposeLecturesSlotWidget({
    Key? key,
    required this.lectureSlots,
    required this.allDays, required this.schedule,
  }) : super(key: key);

  @override
  _ComposeLecturesSlotWidgetState createState() => _ComposeLecturesSlotWidgetState();
}

class _ComposeLecturesSlotWidgetState extends State<ComposeLecturesSlotWidget> {
  final ScheduleService scheduleService = ScheduleService();
  final LectureSlotService lectureSlotService = LectureSlotService();
  late int lastTimeTo;
  late int firstTimeFrom;

  @override
  void initState() {
    super.initState();
    transformLectureSlots();
  }

  void transformLectureSlots() {
    widget.lectureSlots.sort((a, b) => a.timeFrom.compareTo(b.timeFrom));
    firstTimeFrom = widget.lectureSlots[0].timeFrom;
    lastTimeTo = widget.lectureSlots.map((slot) => slot.timeTo).reduce((a, b) => a > b ? a : b);
  }

  double getHeight(double height, int interval) {
    if (interval == 0) {
      return 0;
    } else {
      return ((height * 1 / 13) - CalendarConfig.heightOffset) * interval +
          8 * (interval - 1);
    }
  }

  Color hexStringToColor(String? hexString) {
    if (hexString == null) {
      return Colors.green;
    }
    hexString = hexString.replaceAll("#", "");
    int hexValue = int.parse(hexString, radix: 16);
    return Color(hexValue | 0xFF000000);
  }

  Column getColumn(LectureSlot lectureSlot, double width, double height) {
    List<Widget> widgets = [];
    int intervalFrom = lectureSlot.timeFrom - firstTimeFrom;
    int intervalTo = lastTimeTo - lectureSlot.timeTo;
    for(int i=0; i<intervalFrom; i++){
      widgets.add(TransparentSlotWidgetMin(height: getHeight(height, 1), width: width));
      widgets.add(HorizontalDividerWidget(
        hasColor: true,
        allDays: widget.allDays,
        time: false,
        width: width,
      ));
    }
    // widgets.add(LectureSlotWidgetMin(width: width, height: getHeight(height, intervalFrom), color: Colors.transparent));
    widgets.add(LectureSlotWidgetMin(height: getHeight(height, lectureSlot.timeTo - lectureSlot.timeFrom), width: width, color: hexToColor(lectureSlot.hexColor!), lectureSlot: lectureSlot, allDays: widget.allDays, schedule: widget.schedule,));
    // widgets.add(LectureSlotWidgetMin(width: width, height: getHeight(height, intervalTo), color: Colors.transparent));
    if(intervalTo != 0) {
      widgets.add(HorizontalDividerWidget(
        hasColor: true,
        allDays: widget.allDays,
        time: false,
        width: width,
      ));
    }
    for(int i=0; i<intervalTo-1; i++){
      widgets.add(TransparentSlotWidgetMin(height: getHeight(height, 1), width: width));
      widgets.add(HorizontalDividerWidget(
        hasColor: true,
        allDays: widget.allDays,
        time: false,
        width: width,
      ));
    }
    return Column(children: widgets);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height - 176.4;

    bool isDefault = Provider.of<ScheduleProvider>(context).isDefault;

    double itemWidth = widget.allDays
        ? (width - CalendarConfig.offsetAllDays) * CalendarConfig.calNumAllDays
        : (width - CalendarConfig.offsetOneDay) * CalendarConfig.calNumOneDay;

    double slotWidth = ((itemWidth-8) / widget.lectureSlots.length);

    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Container(
          width: itemWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.red, // Replace with your desired border color
              width: 2.0,        // Replace with your desired border width
            ),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Ensures equal spacing between children
            children: widget.lectureSlots.map((slot) {
              double slotHeight = (slot.timeTo - slot.timeFrom).toDouble();
              return getColumn(slot, slotWidth, height-4);
            }).toList(),
          ),
        ),
      ),
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
