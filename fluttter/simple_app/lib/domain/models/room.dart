class Room {
  final String name;

  Room({
    required this.name,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
        name: json['Id']
    );
  }
}