import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:vpatient/abstractions/base_form.dart';
import 'package:vpatient/screens/forms/medicines_form/medicines_form_controller.dart';
import 'package:vpatient/screens/forms/social_demographic_form/social_demographic_form_controller.dart';
import 'package:vpatient/screens/forms/vital_sign_form/vital_sign_form_controller.dart';
import 'package:vpatient/utils/forms.dart';

class SlideUpPanelController extends GetxController
    with GetSingleTickerProviderStateMixin {
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 8, vsync: this);
    panelController = PanelController();
  }

  final _socialDemographicFormController =
      Get.put(SocialDemographicFormController());

  final _medicinesFormController = Get.put(MedicinesFormController());

  final _vitalSignFormController = Get.put(VitalSignFormController());

  BaseForm? form;

  late final PanelController panelController;
  late final TabController tabController;

  openPanel() {
    panelController.open();
  }

  closePanel() {
    panelController.close();
  }

  get isFormValidated => form == null || (form!.isValidated);

  bool validateForm(Forms formType) {
    switch (formType) {
      case Forms.socialDemographicForm:
        form = _socialDemographicFormController;
        break;
      case Forms.medicinesForm:
        form = _medicinesFormController;
        break;
      case Forms.vitalSignForm:
        form = _vitalSignFormController;
        break;
    }

    form!.validate();
    return form!.isValidated;
  }
}
