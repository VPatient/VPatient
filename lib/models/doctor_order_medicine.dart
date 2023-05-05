class DoctorOrderMedicine {
  String? id;
  String? medicineName;
  String? dose;
  String? periods;
  int type;
  DateTime createdAt;
  DateTime updatedAt;

  DoctorOrderMedicine({
    required this.id,
    required this.medicineName,
    required this.dose,
    required this.periods,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DoctorOrderMedicine.fromJson(Map<String, dynamic> json) =>
      DoctorOrderMedicine(
        id: json["_id"],
        medicineName: json["medicineName"],
        dose: json["dose"],
        periods: json["periods"],
        type: json["type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "medicineName": medicineName,
        "dose": dose,
        "periods": periods,
        "type": type,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
