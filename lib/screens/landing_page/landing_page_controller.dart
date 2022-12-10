import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPageController extends GetxController {
  final PageController controller = PageController(initialPage: 0);

  final _isNextButtonVisible = true.obs;

  get isNextButtonVisible => _isNextButtonVisible.value;

  void changeNextButtonVisibility() {
    _isNextButtonVisible.value = !_isNextButtonVisible.value;
  }

  void navigateToNextPage() {
    controller.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
    print(controller.toString());
  }

  void navigateToPreviousPage() {
    controller.previousPage(
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
    print(controller.page);
  }
}
