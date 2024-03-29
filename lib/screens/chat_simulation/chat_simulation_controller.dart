import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vpatient/models/chat_message.dart';
import 'package:vpatient/models/patient.dart';
import 'package:vpatient/screens/patient_diagnosis/patient_diagnosis_view.dart';
import 'package:vpatient/screens/slide_up_panel/slide_up_panel_controller.dart';
import 'package:vpatient/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:vpatient/utils/avatar_helper.dart';
import 'package:vpatient/utils/forms.dart';
import 'package:vpatient/utils/message_sender.dart';
import 'package:vpatient/utils/user_helper.dart';
import 'package:vpatient/widgets/vp_snackbar.dart';

import '../forms/life_activity_diagnostic_form/life_activity_diagnostic_form_controller.dart';

class ChatSimulationController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    patient = await _getPatient();
    messages = await _getScenario();
    fillCombobox();
    setAppBarText = patient?.name;
  }

  final _lifeActivityDiagnosisFormController =
      Get.put(LifeActivityDiagnosisFormController());

  final _appBarText = "".obs; // app bar text
  final _message = "Hasta ile iletişime geçin.".obs;

  get message => _message.value;

  set setMessage(String value) => _message.value = value;
  final TextEditingController chatController =
      TextEditingController(); // chat controller
  final ScrollController listController =
      ScrollController(); //  list controller
  final _sendMessageDisabled = true.obs; // send message button state
  final SlideUpPanelController _panelController =
      Get.put(SlideUpPanelController()); // slide up panel controller

  var sentMessages = [].obs; // sent messages
  var comboBoxMessages = [].obs; // nurse's messages

  Patient? patient; // patient
  Forms? lastForm; // last form
  List<ChatMessage> messages = List.empty(); // all messages
  int messageSequence = 1; // message sequence

  get sendMessageStatus =>
      _sendMessageDisabled.value; // send message button state

  get patientImage async => patient == null
      ? await _getPatient().then((value) => AvatarHelper.getAvatar(value!))
      : AvatarHelper.getAvatar(patient!); // get patient image

  get appBarText => _appBarText; // get app bar text

  set setAppBarText(text) => _appBarText.value = text; // set app bar text

  void changeSendMessageState() {
    // change send message button state
    _sendMessageDisabled.value = !_sendMessageDisabled.value;
  }

  // function to fill nurse answer combo box every time
  void fillCombobox() {
    // check if last form is not null and form is not validated
    if (lastForm != null && !_panelController.validateForm(lastForm!)) {
      comboBoxMessages.clear();
    }

    // check if messages are not empty
    if (comboBoxMessages.isNotEmpty) comboBoxMessages.clear();

    // add right message to combo box
    comboBoxMessages.addAll(
        messages.where((element) => element.sequence == messageSequence));

    // add random messages to combo box
    comboBoxMessages.addAll((messages.toList()..shuffle())
        .where((element) =>
            element.sequence != messageSequence &&
            !element.action &&
            element.sender == MessageSender.nurse)
        .take(3));

    // shuffle combo box messages
    comboBoxMessages.shuffle();
  }

  // function to send nurse's messages
  void sendMessage() {
    // check if form is validated
    if (!_panelController.isFormValidated) {
      VPSnackbar.warning("Lütfen ilgili formu doldurunuz.");
      return;
    }

    // check if message is empty
    if (_message.value == "Hasta ile iletişime geçin.") {
      VPSnackbar.warning("Lütfen bir mesaj seçiniz.");
      return;
    }

    // get message
    var message =
        messages.where((element) => element.text == _message.value).first;

    // check if message sequence is correct
    if (message.sequence != messageSequence) {
      VPSnackbar.warning("Lütfen hastayla doğru şekilde iletişime geçin.");
      return;
    }

    // if last form is not null, set it to null
    if (lastForm != null) {
      lastForm = null;
      _panelController.form = null;
    }

    // call function to get nurse message
    _getNurseMessage(message: message);
  }

  // function to get nurse messages
  void _getNurseMessage({ChatMessage? message}) {
    // get nurse message
    message ??=
        messages.where((element) => element.sequence == messageSequence).first;

    // increse message sequence
    messageSequence++;

    // add message to sent messages
    sentMessages.add(message);

    _changeUI();
    fillCombobox();
    checkNextMessage();
  }

  void openPanel() {
    _panelController.openPanel();
  }

  // function to get next message
  void checkNextMessage() {
    // get next message
    var message =
        messages.where((element) => element.sequence == messageSequence).first;

    // check if message is action
    if (message.action) {
      // get tab index
      int tab = _findTabWithAction(message.text);
      int childTabIndex = 0;

      //8 den sonrası için alt tabın indisleri olduğu için 8 e eşitlendi
      if (tab > 8) {
        childTabIndex = tab%8;
        tab = 8;

      }

      // check if tab is -1
      if (tab == -1) {
        Get.offAll(() => PatientDiagnosisScreen());
        return;
      }
      // open panel
      openPanel();


      // animate to tab
      _panelController.tabController.animateTo(tab,
          curve: Curves.decelerate,
          duration: const Duration(milliseconds: 500));

      // animate to child tab
      _lifeActivityDiagnosisFormController.tabController.animateTo(childTabIndex,
          curve: Curves.decelerate,
          duration: const Duration(milliseconds: 500));

      // increse message sequence
      messageSequence++;

      // fill combo box
      fillCombobox();

      // return
      return;
    }

    // check if message is patient
    if (message.sender == MessageSender.patient) {
      // get patient message
      changeSendMessageState();
      // animate to bottom
      _getPatientsMessage();
    }
  }

  int _findTabWithAction(String actionName) {
    switch (actionName) {
      case "{DiagnosisScreen}":
        return -1;
      case "{DemographicForm}":
        lastForm = Forms.socialDemographicForm;
        return 0;
      case "{NortonPressureUlcerForm}":
        lastForm = Forms.nortonPressureUlcerForm;
        return 1;
      case "{PainDescriptionForm}":
        lastForm = Forms.painDescriptionForm;
        return 2;
      case "{FallRiskForm}":
        lastForm = Forms.fallRiskForm;
        return 3;
      case "{LaboratoryResultsForm}":
        lastForm = Forms.laboratoryResultsForm;
        return 4;
      case "{BloodSugarTraceForm}":
        lastForm = Forms.bloodSugarTraceForm;
        return 5;
      case "{MedicinesForm}":
        lastForm = Forms.medicinesForm;
        return 6;
      case "{VitalSignForm}":
        lastForm = Forms.vitalSignForm;
        return 7;
      case "{LifeActivityForm0}":
        lastForm = Forms.vitalSignForm;
        return 8;
      case "{LifeActivityForm1}":
        lastForm = Forms.vitalSignForm;
        return 9;
      case "{LifeActivityForm2}":
        lastForm = Forms.vitalSignForm;
        return 10;
      case "{LifeActivityForm3}":
        lastForm = Forms.vitalSignForm;
        return 11;
      case "{LifeActivityForm4}":
        lastForm = Forms.vitalSignForm;
        return 12;
      case "{LifeActivityForm5}":
        lastForm = Forms.vitalSignForm;
        return 13;
      default:
        return -1;
    }
  }

  // function to get patient's messages
  void _getPatientsMessage() async {
    // get patient message
    var message =
        messages.where((element) => element.sequence == messageSequence).first;

    setAppBarText = "Yazıyor...";

    // wait for calculated time
    await Future.delayed(
      Duration(milliseconds: message.text.length * 10),
      () {
        sentMessages.add(message);
      },
    );

    messageSequence++; // increase message sequence

    _changeUI();

    setAppBarText = patient?.name;

    checkNextMessage();
    fillCombobox();
    changeSendMessageState();
  }

  // function to provide http request
  Future<Patient?> _getPatient() async {
    // get patient by id
    final response = await http.get(
      Uri.parse(
          "${APIEndpoints.getPatientById}?id=${GetStorage().read("selectedPatient")}"),
      headers: {
        "Content-Type": "application/json",
        "auth-token": GetStorage().read("token")
      },
    );

    // if response is success return patient
    if (response.statusCode == 200) {
      return Patient.fromJson(json.decode(response.body));
    }

    // if response is not success return null
    else {
      return null;
    }
  }

  // function close keyboard after nurse sends message
  void _unfocusKeyboard() {
    setMessage = "Hasta ile iletişime geçin."; // clear text field
    FocusManager.instance.primaryFocus?.unfocus(); // close keyboard
  }

  // function focus on last message on view
  void _jumpToLastMessage() {
    double offset = sentMessages.last.text.length * 3.0;
    listController.animateTo(listController.position.maxScrollExtent + offset,
        curve: Curves.linear,
        duration: const Duration(milliseconds: 300)); // jump to last message
  }

  // function to change ui after nurse sends message
  void _changeUI() {
    _unfocusKeyboard(); // close keyboard
    _jumpToLastMessage(); // jump to last message
  }

  // function that provide http request
  Future<List<ChatMessage>> _getScenario() async {
    // post request to get scenario
    final response = await http.get(
      Uri.parse(
          "${APIEndpoints.getScenario}?id=${GetStorage().read("selectedPatient")}"),
      headers: {
        "Content-Type": "application/json",
        "auth-token": GetStorage().read("token")
      },
    );

    // if request is successful
    if (response.statusCode == 200) {
      // decode json and return list of messages
      messages = jsonDecode(response.body)
          .map<ChatMessage>((json) => ChatMessage.fromJson(json))
          .toList();

      messages.first.text = messages.first.text
          .replaceAll("[user.name]", UserHelper.getUser().name);

      return messages;
    }

    // if request is not successful
    else {
      // show error message
      VPSnackbar.error(response.body);
      return List.empty();
    }
  }
}
