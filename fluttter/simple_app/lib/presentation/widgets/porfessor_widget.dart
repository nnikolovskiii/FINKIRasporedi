// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../domain/models/professor.dart';
//
// class ProfessorWidget extends StatelessWidget {
//   final Professor professor;
//   final VoidCallback onPressed;
//
//   const ProfessorWidget({
//     Key? key,
//     required this.professor,
//     required this.onPressed,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: onPressed,
//       title: Text(
//         'проф. ${professor.name}',
//         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//       subtitle: Text(
//         professor.email,
//         style: TextStyle(fontSize: 16),
//       ),
//       trailing: Icon(Icons.arrow_forward), // Add an arrow icon for selection
//     );
//   }
// }
