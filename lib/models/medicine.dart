import 'dart:convert';

List<Medicine> medicineFromJson(String str) => List<Medicine>.from(json.decode(str).map((x) => Medicine.fromJson(x)));

String medicineToJson(List<Medicine> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Medicine {
    Medicine({
        required this.id,
        required this.name,
        required this.dose,
        required this.time,
        required this.reason,
        required this.duration,
        required this.owner,
        required this.v,
        required this.createdAt,
        required this.updatedAt,
    });

    final String id;
    final String name;
    final String dose;
    final String time;
    final String reason;
    final String duration;
    final String owner;
    final int v;
    final DateTime createdAt;
    final DateTime updatedAt;

    factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
        id: json["_id"],
        name: json["name"],
        dose: json["dose"],
        time: json["time"],
        reason: json["reason"],
        duration: json["duration"],
        owner: json["owner"],
        v: json["__v"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "dose": dose,
        "time": time,
        "reason": reason,
        "duration": duration,
        "owner": owner,
        "__v": v,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}