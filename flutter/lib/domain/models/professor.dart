import 'enums/professor_title.dart';

class Professor {
  final String id;
  final String name;
  final String? email;
  final ProfessorTitle? professorTitle;

  Professor({
    required this.id,
    required this.name,
    required this.email,
    required this.professorTitle,
  });

  factory Professor.fromJson(Map<String, dynamic> json) {
    return Professor(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      professorTitle: json['professorTitle'] != null
          ? ProfessorTitle.values[json['professorTitle']]
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'professorTitle': professorTitle != null
          ? ProfessorTitle.values.indexOf(professorTitle!)
          : null,
    };
  }
}
