import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vpatient/models/chat_message.dart';
import 'package:vpatient/models/patient.dart';
import 'package:vpatient/models/user.dart';
import 'package:vpatient/screens/patient_diagnosis/patient_diagnosis_view.dart';
import 'package:vpatient/screens/slide_up_panel/slide_up_panel_controller.dart';
import 'package:vpatient/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:vpatient/utils/forms.dart';
import 'package:vpatient/utils/message_sender.dart';
import 'package:vpatient/utils/user_helper.dart';
import 'package:vpatient/widgets/vp_snackbar.dart';

class ChatSimulationController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    patient = await _getPatient();
    messages = await _getScenario();
    fillCombobox();
    setAppBarText = patient?.name;
    user = UserHelper.getUser();
  }

  //message variables
  List<ChatMessage> messages = List.empty();
  var comboBoxMessages = [].obs;
  int messageSequence = 1;
  var sentMessages = [].obs;

  // other necessary variables
  final _appBarText = "".obs;
  Patient? patient;
  final TextEditingController chatController = TextEditingController();
  final ScrollController listController = ScrollController();
  final _sendMessageDisabled = true.obs;
  final SlideUpPanelController _panelController =
      Get.put(SlideUpPanelController());
  User? user;
  bool isSocialDemographicFormFilled = false;
  Forms? lastForm;

  get sendMessageStatus => _sendMessageDisabled.value;

  get patientImage async => patient == null
      ? await _getPatient().then((value) => value?.gender)
      : patient?.gender;

  get appBarText => _appBarText;
  set setAppBarText(text) => _appBarText.value = text;

  void changeSendMessageState() {
    _sendMessageDisabled.value = !_sendMessageDisabled.value;
  }

  // function to fill nurse answer combo box every time
  void fillCombobox() {
    if (lastForm != null && !_panelController.validateForm(lastForm!)) {
      comboBoxMessages.clear();
    }

    if (comboBoxMessages.isNotEmpty) comboBoxMessages.clear();

    comboBoxMessages.addAll(
        messages.where((element) => element.sequence == messageSequence));

    comboBoxMessages.addAll((messages.toList()..shuffle())
        .where((element) =>
            element.sequence != messageSequence &&
            !element.action &&
            element.sender == MessageSender.nurse)
        .take(3));

    comboBoxMessages.shuffle();
  }

  // function to send nurse's messages
  void sendMessage() {
    if (!_panelController.isFormValidated) {
      VPSnackbar.warning("Lütfen ilgili formu doldurunuz.");
      return;
    }

    if (chatController.text.isEmpty) {
      VPSnackbar.warning("Lütfen bir mesaj seçiniz.");
      return;
    }

    var message =
        messages.where((element) => element.text == chatController.text).first;

    if (message.sequence != messageSequence) {
      VPSnackbar.warning("Lütfen hastayla doğru şekilde iletişime geçin.");
      return;
    }

    if (lastForm != null) {
      lastForm = null;
      _panelController.form = null;
    }

    _getNurseMessage(message: message);
  }

  void _getNurseMessage({ChatMessage? message}) {
    message ??=
        messages.where((element) => element.sequence == messageSequence).first;

    messageSequence++;

    sentMessages.add(message);
    _changeUI();
    fillCombobox();
    checkNextMessage();
  }

  void openPanel() {
    _panelController.openPanel();
  }

  void checkNextMessage() {
    var message =
        messages.where((element) => element.sequence == messageSequence).first;

    if (message.action) {
      openPanel();
      _panelController.tabController.animateTo(_findTabWithAction(message.text),
          curve: Curves.decelerate,
          duration: const Duration(milliseconds: 500));

      messageSequence++;
      fillCombobox();
      return;
      //checkNextMessage();
    }

    if (message.sender == MessageSender.patient) {
      changeSendMessageState();
      _getPatientsMessage();
    }
  }

  int _findTabWithAction(String actionName) {
    switch (actionName) {
      case "{Medicines}":
        lastForm = Forms.medicinesForm;
        return 6;
      case "{Demografic}":
        lastForm = Forms.socialDemographicForm;
        return 0;
      case "{VitalSign}":
        lastForm = Forms.vitalSignForm;
        return 7;
      case "{Laboratory}":
        lastForm = Forms.laboratoryResultsForm;
        return 3;
      case "{FallRiskForm}":
        lastForm = Forms.fallRiskForm;
        return 4;
      case "{NortonPressureUlcerForm}":
        lastForm = Forms.nortonPressureUlcerForm;
        return 1;
      case "{DiagnosisScreen}":
        Get.off(() => PatientDiagnosisScreen());
        return 0;
      default:
        return -1;
    }
  }

  void showDialog(ChatMessage message) {
    Get.defaultDialog(
      title: "Bilgilendirme",
      middleText: message.text,
      backgroundColor: Colors.white,
      titleStyle: const TextStyle(color: Colors.black54),
      middleTextStyle: const TextStyle(color: Colors.black87),
      textCancel: "Kapat",
      cancelTextColor: Colors.black87,
      buttonColor: Colors.transparent,
      barrierDismissible: true,
      radius: 20,
    );
  }

  void _getPatientsMessage() async {
    var message =
        messages.where((element) => element.sequence == messageSequence).first;
    messageSequence++;
    setAppBarText = "Yazıyor...";
    await Future.delayed(
      Duration(milliseconds: message.text.length * 10),
      () {
        sentMessages.add(message);
      },
    );
    _changeUI();
    setAppBarText = patient?.name;
    checkNextMessage();
    fillCombobox();
    changeSendMessageState();
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

  // function close keyboard after nurse sends message
  void _unfocusKeyboard() {
    chatController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  // function focus on last message on view
  void _jumpToLastMessage() {
    listController.animateTo(listController.position.maxScrollExtent + 15000,
        curve: Curves.linear, duration: const Duration(milliseconds: 300));
  }

  void _changeUI() {
    _unfocusKeyboard();
    _jumpToLastMessage();
  }

  // function that provide http request
  Future<List<ChatMessage>> _getScenario() async {
    final response = await http.get(
      Uri.parse(
          "${APIEndpoints.getScenario}?id=${GetStorage().read("selectedPatient")}"),
      headers: {
        "Content-Type": "application/json",
        "auth-token": GetStorage().read("token")
      },
    );
    if (response.statusCode == 200) {
      messages = jsonDecode(response.body)
          .map<ChatMessage>((json) => ChatMessage.fromJson(json))
          .toList();
      return messages;
    } else {
      VPSnackbar.error(response.body);
      return List.empty();
    }
  }
}
