import 'dart:convert';

List<PatientDiagnosis> patientDiagnosisFromJson(String str) =>
    List<PatientDiagnosis>.from(
        json.decode(str).map((x) => PatientDiagnosis.fromJson(x)));

String patientDiagnosisToJson(List<PatientDiagnosis> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PatientDiagnosis {
  PatientDiagnosis({
    required this.id,
    required this.name,
    required this.patientDiagnosisTrue,
    required this.owner,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String name;
  final bool patientDiagnosisTrue;
  final String owner;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  factory PatientDiagnosis.fromJson(Map<String, dynamic> json) =>
      PatientDiagnosis(
        id: json["_id"],
        name: json["name"],
        patientDiagnosisTrue: json["true"],
        owner: json["owner"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "true": patientDiagnosisTrue,
        "owner": owner,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };

  @override
  bool operator ==(other) {
    if (other is PatientDiagnosis) {
      return other.id == id;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => id.hashCode;
}
