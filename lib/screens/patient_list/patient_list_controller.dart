import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:vpatient/models/patient.dart';
import 'package:vpatient/screens/landing_page/landing_page_view.dart';
import 'package:vpatient/utils/api_endpoints.dart';
import 'package:vpatient/widgets/vp_snackbar.dart';

class PatientListController extends GetxController {
  final _activePage = 0.obs;

  set setActivePage(int page) {
    _activePage.value = page;
  }

  get activePage => _activePage;

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
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();

      _patients =
          parsed.map<Patient>((json) => Patient.fromJson(json)).toList();

      return _patients;
    } else {
      VPSnackbar.error("Hasta bilgileri çekilemedi.");
      return List.empty();
    }
  }

  void selectPatient() async {
    if (GetStorage().hasData("selectedPatient")) {
      GetStorage().remove("selectedPatient");
    }
    await GetStorage()
        .write("selectedPatient", _patients[_activePage.value].id);
    Get.off(() => LandingPage());
  }
}
