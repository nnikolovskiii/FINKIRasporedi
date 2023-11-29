class Subject {
  final String id;
  final String name;
  final String abbreviation;
  final int level;

  Subject({
    required this.id,
    required this.name,
    required this.abbreviation,
    required this.level
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['Id'],
      name: json['Name'],
      abbreviation: json['Abbreviation'],
      level: json['Level']
    );
  }
}