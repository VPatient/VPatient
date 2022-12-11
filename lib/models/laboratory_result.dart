import 'dart:convert';

List<LaboratoryResult> laboratoryResultFromJson(String str) => List<LaboratoryResult>.from(json.decode(str).map((x) => LaboratoryResult.fromJson(x)));

String laboratoryResultToJson(List<LaboratoryResult> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LaboratoryResult {
    LaboratoryResult({
        required this.id,
        required this.parameterName,
        required this.result,
        required this.unit,
        required this.referanceInterval,
        required this.owner,
        required this.v,
        required this.createdAt,
        required this.updatedAt,
    });

    final String id;
    final String parameterName;
    final String result;
    final String unit;
    final String referanceInterval;
    final String owner;
    final int v;
    final DateTime createdAt;
    final DateTime updatedAt;

    factory LaboratoryResult.fromJson(Map<String, dynamic> json) => LaboratoryResult(
        id: json["_id"],
        parameterName: json["parameterName"],
        result: json["result"],
        unit: json["unit"],
        referanceInterval: json["referanceInterval"],
        owner: json["owner"],
        v: json["__v"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "parameterName": parameterName,
        "result": result,
        "unit": unit,
        "referanceInterval": referanceInterval,
        "owner": owner,
        "__v": v,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
