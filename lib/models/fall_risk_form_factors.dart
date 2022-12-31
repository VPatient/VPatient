import 'dart:convert';

import 'package:get/get.dart';

FallRiskFormFactors fallRiskFormFactorsFromJson(String str) =>
    FallRiskFormFactors.fromJson(json.decode(str));

String fallRiskFormFactorsToJson(FallRiskFormFactors data) =>
    json.encode(data.toJson());

class FallRiskFormFactors {
  FallRiskFormFactors({
    required this.id,
    required this.factor,
    required this.major,
    required this.point,
    required this.order,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String factor;
  bool major;
  int point;
  int order;
  int v;
  DateTime createdAt;
  DateTime updatedAt;
  final isChecked = false.obs;

  factory FallRiskFormFactors.fromJson(Map<String, dynamic> json) =>
      FallRiskFormFactors(
        id: json["_id"],
        factor: json["factor"],
        major: json["major"],
        point: json["point"],
        order: json["order"],
        v: json["__v"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "factor": factor,
        "major": major,
        "point": point,
        "order": order,
        "__v": v,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };

  @override
  bool operator ==(other) {
    if (other is FallRiskFormFactors) {
      return other.id == id;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => id.hashCode;
}
