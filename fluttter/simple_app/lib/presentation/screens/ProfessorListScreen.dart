// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../../service/professor_service.dart';
// import '../../domain/models/professor.dart';
// import '../widgets/porfessor_widget.dart';
// import 'ProfessorDetailsScreen.dart';
//
// class ProfessorListScreen extends StatefulWidget {
//   @override
//   _ProfessorListScreenState createState() => _ProfessorListScreenState();
// }
//
// class _ProfessorListScreenState extends State<ProfessorListScreen> {
//   late List<Professor> professors;
//   List<Professor> filteredProfessors = []; // List to store filtered professors
//   TextEditingController searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   Future<void> fetchData() async {
//     final apiService = ProfessorService(); // Assuming you have created the ApiService class
//     try {
//       final data = await apiService.fetchData();
//       setState(() {
//         professors = data;
//         filteredProfessors = data; // Initialize filtered list with all professors
//       });
//     } catch (e) {
//       // Handle the error
//     }
//   }
//
//   void showProfessorDetails(Professor professor) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => ProfessorDetailsScreen(professor: professor),
//       ),
//     );
//   }
//
//   void filterProfessors(String query) {
//     setState(() {
//       filteredProfessors = professors
//           .where((professor) => professor.name.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Professor List')),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: searchController,
//               onChanged: (query) {
//                 filterProfessors(query);
//               },
//               decoration: InputDecoration(
//                 labelText: 'Search Professors',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: filteredProfessors.length,
//               itemBuilder: (context, index) {
//                 final professor = filteredProfessors[index];
//                 return GestureDetector(
//                   onTap: () {
//                     showProfessorDetails(professor);
//                   },
//                   child: ProfessorWidget(
//                     professor: professor, onPressed: () {  showProfessorDetails(professor); },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Add any other actions you want to perform
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
