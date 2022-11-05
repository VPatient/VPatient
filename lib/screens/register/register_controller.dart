import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vpatient/screens/login/login_view.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/utils/api_endpoints.dart';

class RegisterController extends GetxController {
  navigateToLogin() {
    Get.to(LoginScreen());
  }

  register(String email, String password, String name, String studentNo) async {
    if (!_validate(email, password, name, studentNo)) return;

    final response = await http.post(Uri.parse(APIEndpoints.registerEndpoint),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "email": email,
          "password": password,
          "name": name,
          "studentNumber": studentNo
        }));

    if (response.statusCode == 200) {
      Get.snackbar("Başarılı", "Kayıt işlemi başarılı.",
          backgroundColor: VPColors.primaryColor,
          colorText: Colors.white,
          icon: const Icon(Icons.done, color: Colors.white));
      Get.to(LoginScreen());
    } else {
      Get.snackbar("Hata", response.reasonPhrase!,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: const Icon(Icons.error, color: Colors.white));
    }
  }

  bool _validate(email, password, name, studentNo) {
    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Uyarı!", "Lütfen Geçerli bir email adresi giriniz.",
          backgroundColor: Colors.amber,
          colorText: Colors.white,
          icon: const Icon(Icons.warning, color: Colors.white));
      return false;
    }

    if (GetUtils.isNull(password)) {
      Get.snackbar("Uyarı!", "Şifre boş bırakılamaz.",
          backgroundColor: Colors.amber,
          colorText: Colors.white,
          icon: const Icon(Icons.warning, color: Colors.white));
      return false;
    }

    if (!GetUtils.isAlphabetOnly(name)) {
      Get.snackbar("Uyarı!", "Ad-soyad sadece harflerden oluşmalıdır.",
          backgroundColor: Colors.amber,
          colorText: Colors.white,
          icon: const Icon(Icons.warning, color: Colors.white));
      return false;
    }

    if (!GetUtils.isNumericOnly(studentNo)) {
      Get.snackbar("Uyarı!", "Öğrenci numarası sadece rakamlardan oluşmalıdır.",
          backgroundColor: Colors.amber,
          colorText: Colors.white,
          icon: const Icon(Icons.warning, color: Colors.white));
      return false;
    }

    return true;
  }
}
