class Subject {
  String id;
  String name;
  String abbreviation;
  int level;

  Subject({
    required this.id,
    required this.name,
    required this.abbreviation,
    required this.level,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      abbreviation: json['abbreviation'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'abbreviation': abbreviation,
      'level': level,
    };
  }
}
