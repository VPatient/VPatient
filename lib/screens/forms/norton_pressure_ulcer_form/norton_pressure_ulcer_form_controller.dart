import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vpatient/abstractions/base_form.dart';
import 'package:vpatient/main.dart';
import 'package:vpatient/models/norton_pressure_ulcer.dart';
import 'package:vpatient/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:vpatient/widgets/vp_snackbar.dart';

class NortonPressureUlcerFormController extends BaseForm {
  NortonPressureUlcer? _nortonPressureUlcer;
  get nortonPressureUlcer => _nortonPressureUlcer;

  final List<String> _physicalConditions = ['Çok Kötü', 'Kötü', 'Orta', 'İyi'];

  get physicalConditions => _physicalConditions;

  get physicalCondition => _physicalConditions[physicalConditionIndex];

  final _physicalConditionIndex = 0.obs;

  int get physicalConditionIndex => _physicalConditionIndex.value;

  set physicalConditionIndex(int value) =>
      _physicalConditionIndex.value = value;

  final List<String> _mentalConditions = [
    'Stupor',
    'Konfuse',
    'Apatik',
    'Uyanık'
  ];

  final _mentalConditionIndex = 0.obs;

  get mentalConditions => _mentalConditions;

  get mentalCondition => _mentalConditions[mentalConditionIndex];

  int get mentalConditionIndex => _mentalConditionIndex.value;

  set mentalConditionIndex(int value) => _mentalConditionIndex.value = value;

  final List<String> _activityConditions = [
    'Yatağa Bağımlı',
    'Tekerlekli Sandalyede',
    'Yürüme Yard.',
    'Hareketli'
  ];

  final _activityConditionIndex = 0.obs;

  get activityConditions => _activityConditions;

  get activityCondition => _activityConditions[activityConditionIndex];

  int get activityConditionIndex => _activityConditionIndex.value;

  set activityConditionIndex(int value) =>
      _activityConditionIndex.value = value;

  final List<String> _movementConditions = [
    'Hareketsiz',
    'Çok Kısıtlı',
    'Hafifçe Kısıtlı',
    'Tam'
  ];

  final _movementConditionIndex = 0.obs;

  get movementConditions => _movementConditions;

  get movementCondition => _movementConditions[movementConditionIndex];

  int get movementConditionIndex => _movementConditionIndex.value;

  set movementConditionIndex(int value) =>
      _movementConditionIndex.value = value;

  final List<String> _incontinenceConditions = [
    'Her İkisi',
    'Genellikle/İdrar',
    'Nadiren',
    'Yok'
  ];

  final _incontinenceConditionIndex = 0.obs;

  get incontinenceConditions => _incontinenceConditions;

  get incontinenceCondition =>
      _incontinenceConditions[incontinenceConditionIndex];

  int get incontinenceConditionIndex => _incontinenceConditionIndex.value;

  set incontinenceConditionIndex(int value) =>
      _incontinenceConditionIndex.value = value;

  @override
  void onInit() async {
    super.onInit();
    await _getNortonPressureUlcer();
  }

  Future<void> _getNortonPressureUlcer() async {
    final response = await http.get(
      Uri.parse(
          "${APIEndpoints.getNortonPressureUlcerById}?id=${GetStorage().read("selectedPatient")}"),
      headers: {
        "Content-Type": "application/json",
        "auth-token": GetStorage().read("token")
      },
    );

    if (response.statusCode == 200) {
      _nortonPressureUlcer =
          NortonPressureUlcer.fromJson(json.decode(response.body)[0]);
    }
  }

  @override
  void validate() {
    if (!super.isCalled) {
      super.validate();
      return;
    }

    if (physicalConditionIndex != nortonPressureUlcer.physicalCondition - 1) {
      VPSnackbar.error("Fiziksel durumu doğru seçmediniz!");
      setValidated = false;
      return;
    }

    if (mentalConditionIndex != nortonPressureUlcer.mentalCondition - 1) {
      VPSnackbar.error("Mental durumu doğru seçmediniz!");
      setValidated = false;
      return;
    }

    if (activityConditionIndex != nortonPressureUlcer.activityCondition - 1) {
      VPSnackbar.error("Aktivite durumu doğru seçmediniz!");
      setValidated = false;
      return;
    }

    if (movementConditionIndex != nortonPressureUlcer.movementCondition - 1) {
      VPSnackbar.error("Hareket durumu doğru seçmediniz!");
      setValidated = false;
      return;
    }

    if (incontinenceConditionIndex !=
        nortonPressureUlcer.incontinenceCondition - 1) {
      VPSnackbar.error("Intokinans durumu doğru seçmediniz!");
      setValidated = false;
      return;
    }

    VPSnackbar.success("Tebrikler formu doğru bir şekilde doldurdunuz.");
    super.setCalled = false;
    setValidated = true;
    panelController.closePanel();
  }
}
