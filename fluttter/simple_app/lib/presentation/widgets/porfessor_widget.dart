import 'package:flutter/material.dart';

import '../../domain/models/professor.dart';

class ProfessorWidget extends StatelessWidget {
  final Professor professor;

  const ProfessorWidget({super.key, required this.professor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name: ${professor.name}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('Email: ${professor.email}'),
        // You can add more professor information here if needed
      ],
    );
  }
}
