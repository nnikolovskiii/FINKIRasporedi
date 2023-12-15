class Room {
  String name;

  Room(this.name);

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  @override
  String toString() {
    return 'Room{name: $name}';
  }
}
