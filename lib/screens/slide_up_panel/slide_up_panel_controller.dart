import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:vpatient/abstractions/base_form.dart';
import 'package:vpatient/models/patient.dart';
import 'package:vpatient/screens/forms/norton_pressure_ulcer_form/norton_pressure_ulcer_form_controller.dart';
import 'package:vpatient/screens/forms/pain_description_form/pain_description_form_controller.dart';
import 'package:vpatient/screens/forms/blood_sugar_trace_form/blood_sugar_trace_form_controller.dart';
import 'package:vpatient/screens/forms/fall_risk_form/fall_risk_form_controller.dart';
import 'package:vpatient/screens/forms/laboratory_results_form/laboratory_results_form_controller.dart';
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

  final _painDescriptionFormController =
      Get.put(PainDescriptionFormController());

  final _medicinesFormController = Get.put(MedicinesFormController());

  final _vitalSignFormController = Get.put(VitalSignFormController());

  final _bloodSugarTraceFormController =
      Get.put(BloodSugarTraceFormController());

  final _laboratoryResultsFormController =
      Get.put(LaboratoryResultsFormController());

  final _nortonPressureUlcerFormController =
      Get.put(NortonPressureUlcerFormController());

  final _fallRiskFormController = Get.put(FallRiskFormController());

  BaseForm? form;

  late final PanelController panelController;
  late final TabController tabController;

  openPanel() {
    panelController.open();
  }

  closePanel() {
    panelController.close();
  }

  fillSocialDemographicForm(Patient patient) {
    _socialDemographicFormController.fillPatientInfo(patient);
  }

  get isFormValidated => form == null || (form!.isValidated);

  bool validateForm(Forms formType) {
    switch (formType) {
      case Forms.socialDemographicForm:
        form = _socialDemographicFormController;
        break;
      case Forms.painDescriptionForm:
        form = _painDescriptionFormController;
        break;
      case Forms.medicinesForm:
        form = _medicinesFormController;
        break;
      case Forms.vitalSignForm:
        form = _vitalSignFormController;
        break;
      case Forms.bloodSugarTraceForm:
        form = _bloodSugarTraceFormController;
        break;
      case Forms.laboratoryResultsForm:
        form = _laboratoryResultsFormController;
        break;
      case Forms.fallRiskForm:
        form = _fallRiskFormController;
        break;
      case Forms.nortonPressureUlcerForm:
        form = _nortonPressureUlcerFormController;
        break;
      default:
        form = _socialDemographicFormController;
    }

    form!.validate();
    return form!.isValidated;
  }
}
