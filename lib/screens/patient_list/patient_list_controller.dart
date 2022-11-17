import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:vpatient/models/patient.dart';
import 'package:vpatient/screens/home/home_view.dart';
import 'package:vpatient/utils/api_endpoints.dart';

class PatientListController extends GetxController {
  final _activePage = 0.obs;

  set setActivePage(int page) {
    _activePage.value = page;
  }

  get activePage => _activePage;

  final PageController pageController =
      PageController(viewportFraction: 0.8, initialPage: 0);

  List<Patient> _patients = List.empty();

  Future<List<Patient>> get patients async =>
      _patients.isEmpty ? await _getPatients() : _patients;

  Future<List<Patient>> _getPatients() async {
    final response = await http.get(Uri.parse(APIEndpoints.getPatientsEndpoint),
        headers: {
          "content-type": "application/json",
          "auth-token": GetStorage().read("token")
        });

    if (response.statusCode == 200) {
      debugPrint(response.body);
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();

      _patients =
          parsed.map<Patient>((json) => Patient.fromJson(json)).toList();
      return _patients;
    } else {
      Get.snackbar("Hata!", "Hasta bilgileri çekilemedi.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: const Icon(Icons.error, color: Colors.white));
      return List.empty();
    }
  }

  void selectPatient() {
    GetStorage().write("selectedPatient", _patients[_activePage.value].id);
    Get.off(HomeScreen());
  }
}
