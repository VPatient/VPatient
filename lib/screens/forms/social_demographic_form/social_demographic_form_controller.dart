import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialDemographicFormController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    setDegree = "İlkokul terk";
    setCompanion = "Eşi";
    setBloodType = "0 (+)";
    heightController.addListener(_calculateBMI);
    weightController.addListener(_calculateBMI);
  }

  void _calculateBMI() {
    int weight = int.parse(weightController.value.text);
    int height = int.parse(heightController.value.text);

    var bmi = weight / ((height / 100) * (height / 100));

    bmiController.text = bmi.toString();
  }

  // Text field controllers to handle text field's data
  final TextEditingController nameSurnameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController childNumberController = TextEditingController();
  final TextEditingController insuranceController = TextEditingController();
  final TextEditingController primaryDiagnosisController =
      TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController bmiController = TextEditingController();

  // Gender variables
  final _genderValue = "Erkek".obs;
  String get gender => _genderValue.value;
  set setGender(String value) {
    _genderValue.value = value;
  }
  // Gender variables

  // Marrital Status variables
  final _marritalStatus = "Evli".obs;
  String get marritalStatus => _marritalStatus.value;
  set setMarritalStatus(String value) {
    _marritalStatus.value = value;
  }
  // Marrital Status variables

  // Degree variables
  final List<String> _degreeList = [
    'İlkokul terk',
    'İlkokul',
    'Ortaokul',
    'Lise',
    'Üniversite'
  ];
  get degreeList => _degreeList;
  final _degree = "".obs;
  get degree => _degree.value;
  set setDegree(String value) => _degree.value = value;
  // Degree variables

// Companion variables
  final List<String> _companionList = [
    'Eşi',
    'Annesi',
    'Babası',
    'Çocuğu',
    'Kardeşi',
    'Diğer'
  ];
  get companionList => _companionList;
  final _companion = "".obs;
  get companion => _companion.value;
  set setCompanion(String value) => _companion.value = value;
  // Companion variables

  // Companion variables
  final List<String> _bloodTypeList = [
    "0 (+)",
    "0 (-)",
    "A (+)",
    "A (-)",
    "B (+)",
    "B (-)",
    "AB (+)",
    "AB (-)"
  ];
  get bloodTypeList => _bloodTypeList;
  final _bloodType = "".obs;
  get bloodType => _bloodType.value;
  set setBloodType(String value) => _bloodType.value = value;
  // Blood type variables

  // Contagious disease variables
  final _contagiousDiseaseValue = "Yok".obs;
  String get contagiousDisease => _contagiousDiseaseValue.value;
  set setContagiousDisease(String value) {
    _contagiousDiseaseValue.value = value;
  }
  // Contagious disease variables

}
