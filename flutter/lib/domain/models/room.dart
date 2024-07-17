class Room {
  String name;
  String? abbreviation;

  Room(this.name, this.abbreviation);

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      json['name'],
      json['abbreviation']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'abbreviation': abbreviation
    };
  }

  @override
  String toString() {
    return 'Room{name: $name}';
  }
}
