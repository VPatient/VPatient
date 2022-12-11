import 'dart:convert';

List<VitalSign> vitalSignFromJson(String str) => List<VitalSign>.from(json.decode(str).map((x) => VitalSign.fromJson(x)));

String vitalSignToJson(List<VitalSign> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VitalSign {
    VitalSign({
        required this.id,
        required this.date,
        required this.bloodPressure,
        required this.pulseOverMinute,
        required this.breathOverMinute,
        required this.bodyTemperature,
        required this.owner,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String id;
    final DateTime date;
    final String bloodPressure;
    final String pulseOverMinute;
    final String breathOverMinute;
    final String bodyTemperature;
    final String owner;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    factory VitalSign.fromJson(Map<String, dynamic> json) => VitalSign(
        id: json["_id"],
        date: DateTime.parse(json["date"]),
        bloodPressure: json["bloodPressure"],
        pulseOverMinute: json["pulseOverMinute"],
        breathOverMinute: json["breathOverMinute"],
        bodyTemperature: json["bodyTemperature"],
        owner: json["owner"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "date": date.toIso8601String(),
        "bloodPressure": bloodPressure,
        "pulseOverMinute": pulseOverMinute,
        "breathOverMinute": breathOverMinute,
        "bodyTemperature": bodyTemperature,
        "owner": owner,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
