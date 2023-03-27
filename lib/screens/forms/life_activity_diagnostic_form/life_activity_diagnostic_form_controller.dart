import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/abstractions/base_form.dart';

class LifeActivityDiagnosisFormController extends BaseForm with GetSingleTickerProviderStateMixin{
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }
  late final TabController tabController;
}