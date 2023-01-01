// To parse this JSON data, do
//
//     final grade = gradeFromJson(jsonString);

import 'dart:convert';

import 'package:vpatient/models/patient.dart';

Grade gradeFromJson(String str) => Grade.fromJson(json.decode(str));

String gradeToJson(Grade data) => json.encode(data.toJson());

class Grade {
  Grade({
    required this.id,
    required this.user,
    required this.patient,
    required this.grade,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String user;
  Patient patient;
  int grade;
  DateTime createdAt;
  DateTime updatedAt;

  factory Grade.fromJson(Map<String, dynamic> json) => Grade(
        id: json["_id"],
        user: json["user"],
        patient: Patient.fromJson(json["patient"]),
        grade: json["grade"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "patient": patient.toJson(),
        "grade": grade,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
