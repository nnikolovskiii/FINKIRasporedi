// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
//
// import '../mapper/schedule_widget.dart'; // Replace with the actual file name
// import '../screens/addSubjectsScreen.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Your App Title'),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.add),
//               onPressed: () {
//                 // Navigate to a different screen when the button is pressed
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => SearchBarApp(), // Replace with your new screen widget
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//         body: Center(
//           child: ScheduleWidget(schedule: null,), // You can pass your schedule data if needed
//         ),
//       ),
//     );
//   }
// }
