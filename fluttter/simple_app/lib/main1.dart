// import 'package:flutter/material.dart';
// import 'package:simple_app/service/lecture_service.dart';
// import 'package:simple_app/service/schedule_service.dart';
//
// import 'domain/models/schedule.dart';
//
// Future<void> main() async {
//   ScheduleService scheduleService = ScheduleService();
//   // Schedule schedule = Schedule(name: "lol", description: "lol1");
//   // await scheduleService.addSchedule(schedule);
//   Schedule schedule = await scheduleService.getSchedule(3);
//   await scheduleService.addLecture(3, 5);
//   scheduleService.getSchedulesWithPagination();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Vertical Containers'),
//         ),
//         body: Center(
//           child: Container(
//
//             padding: EdgeInsets.all(5.0),
//             color: Colors.grey[200],
//             child: Flex(
//               direction: Axis.vertical,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   decoration: const BoxDecoration(
//                     border: Border(
//                       top: BorderSide(
//                         color: Colors.grey,
//                         width: 2.0,
//                       ),
//                     ),
//                   ),
//                   child: Container(
//                     height: 100,
//                     width: 100,
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
//                     ),
//                   ),
//                 )
//                 ,
//                 Container(
//                   height: 50,
//                   width: 100,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     border: const Border(
//                       top: BorderSide(
//                         color: Colors.grey,
//                         width: 2.0,
//                       ),
//
//                     ),// Adjust the radius as needed
//                   ),
//                 ),
//                 Container(
//                   height: 50,
//                   width: 100,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     border: const Border(
//                       top: BorderSide(
//                         color: Colors.grey,
//                         width: 2.0,
//                       ),
//                     ),// Adjust the radius as needed
//                   ),
//                 ),
//                 Container(
//                   decoration: const BoxDecoration(
//                     border: Border(
//                       top: BorderSide(
//                         color: Colors.grey,
//                         width: 2.0,
//                       ),
//                     ),
//                   ),
//                   child: Container(
//                     height: 50,
//                     width: 100,
//                     decoration: BoxDecoration(
//                       color: Colors.purple,
//                       borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
//                     ),
//                   ),
//                 ),
//                 Container(
//                   decoration: const BoxDecoration(
//                     border: Border(
//                       top: BorderSide(
//                         color: Colors.grey,
//                         width: 2.0,
//                       ),
//                     ),
//                   ),
//                   child: Container(
//                     height: 150,
//                     width: 100,
//                     decoration: BoxDecoration(
//                       color: Colors.orange,
//                       borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
