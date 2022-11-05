class User {
  final String id;
  final String name;
  final String email;
  final String studentNumber;
  String? password;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.studentNumber,
      this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'],
        id: json['id'],
        name: json['name'],
        studentNumber: json['studentNumber'],
        password: json['password']);
  }

  @override
  User fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'],
        id: json['id'],
        name: json['name'],
        studentNumber: json['studentNumber'],
        password: json['password']);
  }
}
