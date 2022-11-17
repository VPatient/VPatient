// To parse this JSON data, do
//
//     final patient = patientFromJson(jsonString);

import 'dart:convert';

Patient patientFromJson(String str) => Patient.fromJson(json.decode(str));

String patientToJson(Patient data) => json.encode(data.toJson());

class Patient {
  Patient({
    required this.id,
    required this.name,
    required this.gender,
    required this.age,
    required this.maritalStatus,
    required this.degree,
    required this.job,
    required this.children,
    required this.insurance,
    required this.racialAndReligion,
    required this.companion,
    required this.bloodType,
    required this.contagiousDisease,
    required this.primaryDiagnosis,
    required this.height,
    required this.weight,
    required this.hospitalizationReason,
    required this.previouslyHospitalized,
    required this.allergies,
    required this.cigaretteHabit,
    required this.alcoholHabit,
    required this.substanceAbuse,
    required this.motherCauseofDeath,
    required this.dadCauseofDeath,
    required this.siblingCauseofDeath,
    required this.closeRelativeCauseofDeath,
    required this.painLocation,
    required this.painIntensity,
    required this.painType,
    required this.painQualification,
  });

  String id;
  String name;
  String gender;
  int age;
  String maritalStatus;
  String degree;
  String job;
  int children;
  String insurance;
  String racialAndReligion;
  String companion;
  String bloodType;
  bool contagiousDisease;
  String primaryDiagnosis;
  int height;
  int weight;
  String hospitalizationReason;
  String previouslyHospitalized;
  String allergies;
  String cigaretteHabit;
  String alcoholHabit;
  String substanceAbuse;
  String motherCauseofDeath;
  String dadCauseofDeath;
  String siblingCauseofDeath;
  String closeRelativeCauseofDeath;
  String painLocation;
  String painIntensity;
  String painType;
  String painQualification;

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json["_id"],
        name: json["name"],
        gender: json["gender"],
        age: json["age"],
        maritalStatus: json["maritalStatus"],
        degree: json["degree"],
        job: json["job"],
        children: json["children"],
        insurance: json["insurance"],
        racialAndReligion: json["racialAndReligion"],
        companion: json["companion"],
        bloodType: json["bloodType"],
        contagiousDisease: json["contagiousDisease"],
        primaryDiagnosis: json["primaryDiagnosis"],
        height: json["height"],
        weight: json["weight"],
        hospitalizationReason: json["hospitalizationReason"],
        previouslyHospitalized: json["previouslyHospitalized"],
        allergies: json["allergies"],
        cigaretteHabit: json["cigaretteHabit"],
        alcoholHabit: json["alcoholHabit"],
        substanceAbuse: json["substanceAbuse"],
        motherCauseofDeath: json["motherCauseofDeath"],
        dadCauseofDeath: json["dadCauseofDeath"],
        siblingCauseofDeath: json["siblingCauseofDeath"],
        closeRelativeCauseofDeath: json["closeRelativeCauseofDeath"],
        painLocation: json["painLocation"],
        painIntensity: json["painIntensity"],
        painType: json["painType"],
        painQualification: json["painQualification"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "gender": gender,
        "age": age,
        "maritalStatus": maritalStatus,
        "degree": degree,
        "job": job,
        "children": children,
        "insurance": insurance,
        "racialAndReligion": racialAndReligion,
        "companion": companion,
        "bloodType": bloodType,
        "contagiousDisease": contagiousDisease,
        "primaryDiagnosis": primaryDiagnosis,
        "height": height,
        "weight": weight,
        "hospitalizationReason": hospitalizationReason,
        "previouslyHospitalized": previouslyHospitalized,
        "allergies": allergies,
        "cigaretteHabit": cigaretteHabit,
        "alcoholHabit": alcoholHabit,
        "substanceAbuse": substanceAbuse,
        "motherCauseofDeath": motherCauseofDeath,
        "dadCauseofDeath": dadCauseofDeath,
        "siblingCauseofDeath": siblingCauseofDeath,
        "closeRelativeCauseofDeath": closeRelativeCauseofDeath,
        "painLocation": painLocation,
        "painIntensity": painIntensity,
        "painType": painType,
        "painQualification": painQualification,
      };
}
