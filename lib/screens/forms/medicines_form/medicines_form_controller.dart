import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vpatient/abstractions/base_form.dart';
import 'package:vpatient/models/medicine.dart';
import 'package:http/http.dart' as http;
import 'package:vpatient/utils/api_endpoints.dart';
import 'package:vpatient/widgets/vp_snackbar.dart';

class MedicinesFormController extends BaseForm {
  final _isChecked = false.obs;
  get isChecked => _isChecked.value;
  set setChecked(bool value) {
    _isChecked.value = value;
    super.setCalled = false;
    setValidated = true;
  }

  Future<List<Medicine>> getResults() async {
    final response = await http.get(
      Uri.parse(
          "${APIEndpoints.getMedicinesById}?id=${GetStorage().read("selectedPatient")}"),
      headers: {
        "Content-Type": "application/json",
        "auth-token": GetStorage().read("token")
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map<Medicine>((json) => Medicine.fromJson(json))
          .toList();
    } else {
      VPSnackbar.error(response.body);
      return List.empty();
    }
  }
}
