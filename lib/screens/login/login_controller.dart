import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:vpatient/screens/home/home_view.dart';
import 'package:vpatient/screens/register/register_view.dart';
import 'package:vpatient/utils/api_endpoints.dart';
import 'package:vpatient/utils/vp_snackbar.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  navigateToRegister() {
    Get.to(() => RegisterScreen());
  }

  signIn() async {
    var email = emailController.text.trim();
    var password = passwordController.text.trim();

    if (!_validate(email, password)) return;

    final response = await http.post(Uri.parse(APIEndpoints.loginEndpoint),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "email": email,
          "password": password,
        }));

    if (response.statusCode == 200) {
      await GetStorage().write("token", response.body);

      VPSnackbar.success("Giriş başarılı.");

      Get.to(() => HomeScreen());
    } else {
      VPSnackbar.error(response.body);
    }
  }

  bool _validate(email, password) {
    if (!GetUtils.isEmail(email)) {
      VPSnackbar.warning("Lütfen Geçerli bir email adresi giriniz.");
      return false;
    }

    if (GetUtils.isNull(password)) {
      VPSnackbar.warning("Şifre boş bırakılamaz.");
      return false;
    }

    return true;
  }
}
