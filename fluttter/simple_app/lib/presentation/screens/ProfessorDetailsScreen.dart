import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../domain/models/professor.dart';

class ProfessorDetailsScreen extends StatelessWidget {
  final Professor professor;

  const ProfessorDetailsScreen({required this.professor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Professor Details')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: ${professor.name}'),
          Text('Email: ${professor.email}'),
          Text('Professor Title: ${professor.professorTitle}'),
        ],
      ),
    );
  }
}
