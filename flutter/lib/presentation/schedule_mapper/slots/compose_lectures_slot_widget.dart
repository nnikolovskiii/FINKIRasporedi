// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_app/presentation/schedule_mapper/slots/transparent_time_slot_widget.dart';
// import 'package:flutter_app/presentation/screens/add/add_lecture_slot_screen.dart';
// import 'package:flutter_app/service/lecture_slot_service.dart';
//
// import '../../../domain/configs/calendar_config.dart';
// import '../../../domain/models/lecture_slots.dart';
// import '../../../domain/models/schedule.dart';
// import '../../../domain/providers/schedule_provider.dart';
// import '../../../service/schedule_service.dart';
// import '../../screens/calendar/calendar_screen.dart';
//
// class ComposeLecturesSlotWidget extends StatelessWidget {
//   final ScheduleService scheduleService = ScheduleService();
//   final LectureSlotService lectureSlotService = LectureSlotService();
//   final Schedule schedule;
//   final bool allDays;
//   final List<LectureSlot> lectureSlots;
//
//   ComposeLecturesSlotWidget({
//     super.key,
//     required this.lectureSlots,
//     required this.allDays,
//     required this.schedule,
//   });
//
//
//   double getHeight(double height, LectureSlot lecture) {
//     int interval = lecture.timeTo - lecture.timeFrom;
//     return ((height * 1 / 13) - CalendarConfig.heightOffset) * interval +
//         8 * (interval - 1);
//   }
//
//   void transformLectureSlots(){
//     lectureSlots
//   }
//
//   Color hexStringToColor(String? hexString) {
//     if (hexString == null) {
//       return Colors.green;
//     }
//     hexString = hexString.replaceAll("#", "");
//     int hexValue = int.parse(hexString, radix: 16);
//     return Color(hexValue | 0xFF000000);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery
//         .of(context)
//         .size
//         .width;
//     double height = MediaQuery
//         .of(context)
//         .size
//         .height - 176.4;
//
//     bool isDefault = Provider
//         .of<ScheduleProvider>(context)
//         .isDefault;
//
//     double itemWidth = allDays
//         ? (width - CalendarConfig.offsetAllDays) * CalendarConfig.calNumAllDays
//         : (width - CalendarConfig.offsetOneDay) * CalendarConfig.calNumOneDay;
//
//     return Container(
//       height: getHeight(height, lecture),
//       width: itemWidth,
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Center(
//         child: Text(
//           lecture.abbreviation ?? "",
//           style: TextStyle(
//             color: darkText ? Colors.white : Colors.black,
//             fontFamily: 'Lato',
//             fontSize: 12,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Color hexToColor(String hexColor) {
//     // Remove the # character if present
//     if (hexColor.startsWith('#')) {
//       hexColor = hexColor.substring(1);
//     }
//     // Parse the hex color string to an integer
//     int hexValue = int.parse(hexColor, radix: 16);
//     // Create a color object from the hex value
//     return Color(hexValue).withOpacity(1.0);
//   }
// }