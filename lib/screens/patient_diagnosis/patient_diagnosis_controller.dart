import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vpatient/models/patient.dart';
import 'package:vpatient/models/patient_diagnosis.dart';
import 'package:vpatient/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:vpatient/utils/secrets.dart';
import 'package:vpatient/widgets/vp_snackbar.dart';

class PatientDiagnosisController extends GetxController {
  Patient? patient;
  double grade = 0;
  get diagnosis => _getDiagnosis();

  @override
  void onInit() async {
    super.onInit();
    patient = await _getPatient();
    grade = 0;
  }

  // function to provide http request
  Future<Patient?> _getPatient() async {
    final response = await http.get(
      Uri.parse(
          "${APIEndpoints.getPatientById}?id=${GetStorage().read("selectedPatient")}"),
      headers: {
        "Content-Type": "application/json",
        "auth-token": GetStorage().read("token")
      },
    );

    if (response.statusCode == 200) {
      return Patient.fromJson(json.decode(response.body));
    } else {
      return null;
    }
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

  submit() async {
    final response = await http.post(Uri.parse(APIEndpoints.createGrade),
        headers: {
          "Content-Type": "application/json",
          "auth-token": GetStorage().read("token")
        },
        body: json.encode({
          "patientId": patient?.id,
          "secret": Secrets.gradingSecret,
          "grade": grade.toInt()
        }));

    if (response.statusCode == 200) {
      VPSnackbar.success('${patient?.name} için notunuz başarıyla kaydedildi.');
    } else {
      VPSnackbar.error(response.body);
    }
  }
}
