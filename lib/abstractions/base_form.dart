import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vpatient/models/patient.dart';
import 'package:http/http.dart' as http;
import 'package:vpatient/utils/api_endpoints.dart';

abstract class BaseForm extends GetxController {
  Patient? _patient;
  get patient => _patient;

  final _isValidated = false.obs;
  get isValidated => _isValidated.value;
  set setValidated(bool value) => _isValidated.value = value;

  final _isCalled = false.obs;
  get isCalled => _isCalled.value;
  set setCalled(bool value) => _isCalled.value = value;

  Future<void> getPatient() async {
    final response = await http.get(
      Uri.parse(
          "${APIEndpoints.getPatientById}?id=${GetStorage().read("selectedPatient")}"),
      headers: {
        "Content-Type": "application/json",
        "auth-token": GetStorage().read("token")
      },
    );

    if (response.statusCode == 200) {
      _patient = Patient.fromJson(json.decode(response.body));
    }
  }

  void validate() {
    setCalled = true;
  }
}
