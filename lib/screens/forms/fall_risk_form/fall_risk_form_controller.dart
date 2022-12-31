import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vpatient/abstractions/base_form.dart';
import 'package:vpatient/main.dart';
import 'package:vpatient/models/fall_risk_form_factors.dart';
import 'package:http/http.dart' as http;
import 'package:vpatient/utils/api_endpoints.dart';
import 'package:vpatient/widgets/vp_snackbar.dart';

class FallRiskFormController extends BaseForm {
  @override
  void onInit() async {
    super.onInit();

    _factors = await _getFactors();
  }

  final _totalScore = 0.obs;
  get totalScore => _totalScore.value;
  set setTotalScore(int value) => _totalScore.value += value;

  final _riskLevelValue = "Düşük Risk(Toplam puan 5 in altında)".obs;
  String get riskLevel => _riskLevelValue.value;
  set setRiskLevel(String value) {
    _riskLevelValue.value = value;
  }

  List<FallRiskFormFactors>? _factors;
  get factors => _factors;

  Future<List<FallRiskFormFactors>> _getFactors() async {
    final response = await http.get(
      Uri.parse(APIEndpoints.getFallRiskFormFactors),
      headers: {
        "Content-Type": "application/json",
        "auth-token": GetStorage().read("token")
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map<FallRiskFormFactors>(
              (json) => FallRiskFormFactors.fromJson(json))
          .toList();
    } else {
      VPSnackbar.error(response.body);
      return List.empty();
    }
  }

  Future<List<FallRiskFormFactors>> _getPatientFactors() async {
    final response = await http.get(
      Uri.parse(
          "${APIEndpoints.getPatientFallRiskFactors}?id=${GetStorage().read("selectedPatient")}"),
      headers: {
        "Content-Type": "application/json",
        "auth-token": GetStorage().read("token")
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map<FallRiskFormFactors>(
              (json) => FallRiskFormFactors.fromJson(json))
          .toList();
    } else {
      VPSnackbar.error(response.body);
      return List.empty();
    }
  }

  _listEquality(
      List<FallRiskFormFactors> list1, List<FallRiskFormFactors> list2) {
    var condition1 = list1.toSet().difference(list2.toSet()).isEmpty;
    var condition2 = list1.length == list2.length;
    return condition1 && condition2;
  }

  @override
  void validate() async {
    if (!super.isCalled) {
      super.validate();
      return;
    }

    List<FallRiskFormFactors> patientFactors = await _getPatientFactors();

    List<FallRiskFormFactors> checkedFactors =
        _factors!.where((element) => element.isChecked.value).toList();

    if (!_listEquality(patientFactors, checkedFactors)) {
      setValidated = false;
      VPSnackbar.warning("Lütfen doğru seçenekleri seçiniz");
      return;
    }

    if ((totalScore < 5 &&
            riskLevel != "Düşük Risk(Toplam puan 5 in altında)") ||
        (totalScore >= 5 &&
            riskLevel != "Yüksek Risk(toplam puan 5 ve 5'in üstünde)")) {
      setValidated = false;
      VPSnackbar.warning("Risk seviyesini doğru seçiniz");
      return;
    }

    setValidated = true;
    setCalled = false;
    VPSnackbar.success(
        "Formu başarıyla doldurdunuz, hasta ile konuşmaya devam edebilirsiniz.");
    panelController.closePanel();
  }
}
