import 'package:simple_app/domain/models/enums/professor_title.dart';

class Professor {
  final String id;
  final String name;
  final String email;
  final ProfessorTitle professorTitle;

  Professor({
    required this.id,
    required this.name,
    required this.email,
    required this.professorTitle
  });
}