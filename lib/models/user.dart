class User {
  final String id;
  final String name;
  final String email;
  final String studentNumber;
  final bool isAdmin;
  String? password;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.studentNumber,
      required this.isAdmin,
      this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'],
        id: json['_id'],
        name: json['name'],
        studentNumber: json['studentNumber'],
        isAdmin: json['isAdmin']);
  }
}
