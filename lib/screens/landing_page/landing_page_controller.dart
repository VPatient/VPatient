import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/screens/chat_simulation/chat_simulation_view.dart';

class LandingPageController extends GetxController {
  final PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  final _isNextButtonVisible = false.obs;
  final _isPreviousButtonVisible = true.obs;

  get previousButtonState => _isPreviousButtonVisible.value;
  set setPreviousButtonState(bool value) =>
      _isPreviousButtonVisible.value = value;

  get nextButtonState => _isNextButtonVisible.value;
  set setNextButtonState(bool value) => _isNextButtonVisible.value = value;

  void navigateToNextPage() {
    if (_isNextButtonVisible.value) {
      Get.off(() => ChatSimulationScreen());
    }
    pageController.nextPage(
        duration: const Duration(milliseconds: 750), curve: Curves.linearToEaseOut);
  }

  void navigateToPreviousPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 750), curve: Curves.linearToEaseOut);
  }
}
