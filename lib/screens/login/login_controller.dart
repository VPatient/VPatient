import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:vpatient/screens/home/home_view.dart';
import 'package:vpatient/screens/register/register_view.dart';
import 'package:vpatient/utils/api_endpoints.dart';

class LoginController extends GetxController {
  navigateToRegister() {
    Get.to(() => RegisterScreen());
  }

  signIn(String email, String password) async {
    if (!_validate(email, password)) return;

    final response = await http.post(Uri.parse(APIEndpoints.loginEndpoint),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "email": email,
          "password": password,
        }));

    if (response.statusCode == 200) {
      await GetStorage().write("token", response.body);
      Get.snackbar("Başarılı", "Giriş Başarılı.",
          backgroundColor: Get.theme.primaryColor,
          colorText: Colors.white,
          icon: const Icon(Icons.done, color: Colors.white));
      Get.to(() => HomeScreen());
    } else {
      Get.snackbar("Hata", response.reasonPhrase!,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: const Icon(
            Icons.error,
            color: Colors.white,
          ));
    }
  }

  bool _validate(email, password) {
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

    return true;
  }
}
