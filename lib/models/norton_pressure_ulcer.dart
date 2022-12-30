import 'dart:convert';

List<NortonPressureUlcer> nortonPressureUlcerFromJson(String str) => List<NortonPressureUlcer>.from(json.decode(str).map((x) => NortonPressureUlcer.fromJson(x)));

String nortonPressureUlcerToJson(List<NortonPressureUlcer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NortonPressureUlcer {
    NortonPressureUlcer({
        required this.id,
        required this.physicalCondition,
        required this.mentalCondition,
        required this.activityCondition,
        required this.movementCondition,
        required this.incontinenceCondition,
        required this.owner,
        required this.date,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String id;
    final int physicalCondition;
    final int mentalCondition;
    final int activityCondition;
    final int movementCondition;
    final int incontinenceCondition;
    final String owner;
    final DateTime date;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    factory NortonPressureUlcer.fromJson(Map<String, dynamic> json) => NortonPressureUlcer(
        id: json["_id"],
        physicalCondition: json["physicalCondition"],
        mentalCondition: json["mentalCondition"],
        activityCondition: json["activityCondition"],
        movementCondition: json["movementCondition"],
        incontinenceCondition: json["incontinenceCondition"],
        owner: json["owner"],
        date: DateTime.parse(json["date"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "physicalCondition": physicalCondition,
        "mentalCondition": mentalCondition,
        "activityCondition": activityCondition,
        "movementCondition": movementCondition,
        "incontinenceCondition": incontinenceCondition,
        "owner": owner,
        "date": date.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
