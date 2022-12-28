import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vpatient/models/patient_diagnosis.dart';
import 'package:vpatient/screens/slide_up_panel/slide_up_panel_controller.dart';
import 'package:vpatient/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:vpatient/utils/secrets.dart';
import 'package:vpatient/utils/vp_snackbar.dart';

class PatientDiagnosisController extends GetxController {
  get diagnosis => _getDiagnosis();
  final _selectedDiagnosises = HashSet<PatientDiagnosis>()
      .obs; // HashSet is used to prevent duplicate diagnosis
  final _totalDiagnosis = 0.obs; // total diagnosis count
  final _grade = 0.obs; // grade of the nurse
  final _isSubmitted = false.obs; // is the diagnosis submitted
  final _diagnosisCheck = 0.obs; // diagnosis check
  final SlideUpPanelController _panelController =
      Get.put(SlideUpPanelController());
  final _patientId = GetStorage().read("selectedPatient");

  set setGrade(int value) => _grade.value = value;
  get getGrade => _grade.value;

  set setTotalDiagnosis(int value) => _totalDiagnosis.value = value;
  get getTotalDiagnosis => _totalDiagnosis.value;

  set setIsSubmitted(bool value) => _isSubmitted.value = value;
  get getIsSubmitted => _isSubmitted.value;

  get getSelectedDiagnosises => _selectedDiagnosises.value;

  get getDiagnosisCheck => _diagnosisCheck.value;

  bool isSelected(PatientDiagnosis value) {
    return getSelectedDiagnosises.contains(value);
  }

  void openPanel() {
    _panelController.openPanel();
  }

  // function to provide http request
  Future<List<PatientDiagnosis?>> _getDiagnosis() async {
    final response = await http.get(
      Uri.parse(
          "${APIEndpoints.getPatientDiagnosisById}?id=${GetStorage().read("selectedPatient")}"),
      headers: {
        "Content-Type": "application/json",
        "auth-token": GetStorage().read("token")
      },
    );

    if (response.statusCode == 200) {
      return json
          .decode(response.body)
          .map<PatientDiagnosis?>((json) => PatientDiagnosis.fromJson(json))
          .toList();
    } else {
      VPSnackbar.error(response.body);
      return List.empty();
    }
  }

  controlSubmit() {
    if (getSelectedDiagnosises.isNotEmpty) {
      if (getIsSubmitted) {
        return;
      }
      _calculateGrade();
      submit();
    }
  }

  checkDiagnosis(selectedDiagnosis) {
    // if diagnosis is submitted do not change the diagnosis
    if (getIsSubmitted) {
      return;
    }

    // if diagnosis is selected remove it from selectedDiagnosis
    if (isSelected(selectedDiagnosis)) {
      getSelectedDiagnosises.remove(selectedDiagnosis);
    }

    // if diagnosis is not selected add it to selectedDiagnosis
    else {
      getSelectedDiagnosises.add(selectedDiagnosis);
    }
    
    _diagnosisCheck.value++;
  }

  // calculate grade
  _calculateGrade() {
    // only half of the total diagnosises are true
    double diagnosisPoint = 100 / (_totalDiagnosis / 2);

    // total point
    double totalPoint = 0;

    // if diagnosis is true add diagnosisPoint to totalPoint
    // if diagnosis is false subtract diagnosisPoint from totalPoint
    for (var element in getSelectedDiagnosises) {
      totalPoint = element.patientDiagnosisTrue
          ? totalPoint + diagnosisPoint
          : totalPoint - diagnosisPoint;
    }

    setGrade = totalPoint.toInt();
  }

  submit() async {
    final response = await http.post(Uri.parse(APIEndpoints.createGrade),
        headers: {
          "Content-Type": "application/json",
          "auth-token": GetStorage().read("token")
        },
        body: json.encode({
          "patientId": _patientId,
          "secret": Secrets.gradingSecret,
          "grade": _grade.toInt()
        }));

    if (response.statusCode == 200) {
      VPSnackbar.success('Notunuz başarıyla kaydedildi.');
      setIsSubmitted = true;
      _diagnosisCheck.value++;
    } else {
      VPSnackbar.error(response.body);
    }
  }
}
