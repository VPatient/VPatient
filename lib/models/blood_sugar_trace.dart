import 'dart:convert';

List<BloodSugarTrace> bloodSugarTraceFromJson(String str) => List<BloodSugarTrace>.from(json.decode(str).map((x) => BloodSugarTrace.fromJson(x)));

String bloodSugarTraceToJson(List<BloodSugarTrace> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BloodSugarTrace {
    BloodSugarTrace({
        required this.id,
        required this.time,
        required this.result,
        required this.note,
        required this.owner,
        required this.v,
        required this.createdAt,
        required this.updatedAt,
    });

    final String id;
    final DateTime time;
    final String result;
    final String note;
    final String owner;
    final int v;
    final DateTime createdAt;
    final DateTime updatedAt;

    factory BloodSugarTrace.fromJson(Map<String, dynamic> json) => BloodSugarTrace(
        id: json["_id"],
        time: DateTime.parse(json["time"]),
        result: json["result"],
        note: json["note"],
        owner: json["owner"],
        v: json["__v"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "time": time.toIso8601String(),
        "result": result,
        "note": note,
        "owner": owner,
        "__v": v,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}