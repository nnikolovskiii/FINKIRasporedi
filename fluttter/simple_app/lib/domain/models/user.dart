class User {
  final String id;
  final String userName;
  final String email;

  User({
    required this.id,
    required this.userName,
    required this.email
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['Id'],
      userName: json['Name'],
      email: json['Email']
    );
  }
}
