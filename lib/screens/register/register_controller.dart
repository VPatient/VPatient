import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vpatient/screens/login/login_view.dart';
import 'package:vpatient/utils/api_endpoints.dart';
import 'package:vpatient/utils/vp_snackbar.dart';

class RegisterController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController studentNumberController = TextEditingController();
  final TextEditingController nameSurnameController = TextEditingController();

  navigateToLogin() {
    Get.to(() => LoginScreen());
  }

  register() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String name = nameSurnameController.text.trim();
    String studentNo = studentNumberController.text.trim();

    if (!_validate(email, password, name, studentNo)) return;

    final response = await http.post(Uri.parse(APIEndpoints.registerEndpoint),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "name": name,
          "studentNumber": studentNo,
          "email": email,
          "password": password
        }));

    if (response.statusCode == 200) {
      VPSnackbar.success("Kayıt işlemi başarılı");
      Get.to(() => LoginScreen());
    } else {
      VPSnackbar.error(response.body);
    }
  }

  bool _validate(email, password, name, studentNo) {
    if (!GetUtils.isEmail(email)) {
      VPSnackbar.warning("Lütfen Geçerli bir email adresi giriniz.");
      return false;
    }

    if (GetUtils.isNull(password)) {
      VPSnackbar.warning("Şifre boş bırakılamaz.");
      return false;
    }

    if (!GetUtils.isNumericOnly(studentNo)) {
      VPSnackbar.warning("Öğrenci numarası sadece rakamlardan oluşmalıdır.");
      return false;
    }

    return true;
  }
}
