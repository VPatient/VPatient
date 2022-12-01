import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VPSnackbar {
  static SnackbarController success(String text, [String title = "Başarılı"]) {
    return Get.snackbar(title, text,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        backgroundColor: Get.theme.primaryColor,
        colorText: Colors.white,
        icon: const Icon(Icons.done, color: Colors.white));
  }

  static SnackbarController warning(String text, [String title = "Uyarı"]) {
    return Get.snackbar(title, text,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        backgroundColor: Colors.amber,
        colorText: Colors.white,
        icon: const Icon(Icons.warning, color: Colors.white));
  }

  static SnackbarController error(String text, [String title = "Hata"]) {
    return Get.snackbar(title, text,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error, color: Colors.white));
  }
}
