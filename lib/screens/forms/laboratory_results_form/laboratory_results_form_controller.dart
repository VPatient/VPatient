import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vpatient/abstractions/base_form.dart';
import 'package:vpatient/models/laboratory_result.dart';
import 'package:vpatient/utils/api_endpoints.dart';
import 'package:vpatient/widgets/vp_snackbar.dart';
import 'package:http/http.dart' as http;

class LaboratoryResultsFormController extends BaseForm {
  final _isChecked = false.obs;
  get isChecked => _isChecked.value;
  set setChecked(bool value) {
    _isChecked.value = value;

    if (isChecked) {
      VPSnackbar.success(
          "Formu onayladınız, hasta ile konuşmaya devam edebilirsiniz.");
      super.setCalled = false;
      setValidated = true;
    }
  }

  Future<List<LaboratoryResult>> getResults() async {
    final response = await http.get(
      Uri.parse(
          "${APIEndpoints.getLaboratoryResultsById}?id=${GetStorage().read("selectedPatient")}"),
      headers: {
        "Content-Type": "application/json",
        "auth-token": GetStorage().read("token")
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map<LaboratoryResult>((json) => LaboratoryResult.fromJson(json))
          .toList();
    } else {
      VPSnackbar.error(response.body);
      return List.empty();
    }
  }
}
