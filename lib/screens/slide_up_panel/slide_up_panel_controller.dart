import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlideUpPanelController extends GetxController
    with GetSingleTickerProviderStateMixin {
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 8, vsync: this);
    panelController = PanelController();
  }

  late final PanelController panelController;
  late final TabController tabController;

  openPanel() {
    panelController.open();
  }
}
