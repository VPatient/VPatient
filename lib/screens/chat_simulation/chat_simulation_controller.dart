import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vpatient/models/chat_message.dart';
import 'package:vpatient/models/patient.dart';
import 'package:vpatient/utils/api_endpoints.dart';
import 'package:vpatient/utils/message_sender.dart';
import 'package:http/http.dart' as http;

class ChatSimulationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  @override
  void onInit() async {
    patient = await _getPatient();
    setAppBarText = patient?.name;

    super.onInit();
  }

  final List<ChatMessage> _messages = [
    ChatMessage("Seni seviyorum.", MessageSender.patient),
  ];

  Patient? patient;

  final _appBarText = "".obs;
  var sentMessages = [].obs;

  get patientImage async => patient == null
      ? await _getPatient().then((value) => value?.gender)
      : patient?.gender;

  get appBarText => _appBarText;
  set setAppBarText(text) => _appBarText.value = text;

  final TextEditingController chatController = TextEditingController();
  final ScrollController listController = ScrollController();

  void sendMessage() {
    sentMessages.add(ChatMessage(chatController.text, MessageSender.nurse));
    _unfocusKeyboard();
    _jumpToLastMessage();
    _getPatientsMessage();
  }

  void _unfocusKeyboard() {
    chatController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _jumpToLastMessage() {
    listController.animateTo(listController.position.maxScrollExtent + 10000,
        curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
  }

  void _getPatientsMessage() async {
    setAppBarText = "Yazıyor...";
    await Future.delayed(
      const Duration(seconds: 6),
      () {
        sentMessages.add(_messages[Random().nextInt(_messages.length)]);

        _jumpToLastMessage();
      },
    );
    setAppBarText = patient?.name;
  }

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
}
