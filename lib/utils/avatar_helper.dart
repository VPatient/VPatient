import 'package:flutter/material.dart';
import 'package:vpatient/models/patient.dart';

class AvatarHelper {
  static Image getAvatar(Patient patient) {
    var avatarName = "";
    
    if (patient.gender == "Erkek") {
      if (patient.age >= 50) {
        avatarName = "old-man";
      } else if (patient.age >= 18) {
        avatarName = "man";
      } else {
        avatarName = "boy";
      }
    }

    if (patient.gender == "Kadın") {
      if (patient.age >= 50) {
        avatarName = "old-woman";
      } else if (patient.age >= 18) {
        avatarName = "woman";
      } else {
        avatarName = "girl";
      }
    }

    return Image.asset("assets/images/avatars/$avatarName.png");
  }
}