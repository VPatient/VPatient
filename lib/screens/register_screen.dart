import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/utils/api_endpoints.dart';
import 'package:vpatient/widgets/vp_button.dart';
import 'package:vpatient/widgets/vp_textfield.dart';
import 'package:vpatient/screens/login_screen.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _studentNumberController =
      TextEditingController();
  final TextEditingController _nameSurnameController = TextEditingController();

  // waiting for API endpoint.
  register(BuildContext context) async {
    print("çalıştı");
    final response = await http.post(Uri.parse(APIEndpoints.registerEndpoint),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "email": _emailController.text,
          "password": _passwordController.text,
          "name": _nameSurnameController.text,
          "studentNumber": _studentNumberController.text
        }));

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Kayıt işlemi başarılı",
          backgroundColor: VPColors.vpGreen,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          fontSize: 18);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
          (route) => false);
    } else {
      Fluttertoast.showToast(
          msg: response.reasonPhrase!,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          fontSize: 18);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [VPColors.gradientBegin, VPColors.gradientEnd])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
              flex: 1,
              child: Image.asset("assets/images/icons/vpatient-logo.png")),
          Flexible(
            flex: 5,
            child: SingleChildScrollView(
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  VPTextField(
                    controller: _emailController,
                    icon: Icons.mail,
                    isObscured: false,
                    text: "E-mail",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  VPTextField(
                    controller: _nameSurnameController,
                    icon: Icons.person,
                    isObscured: false,
                    text: "Ad Soyad",
                    keyboardType: TextInputType.text,
                  ),
                  VPTextField(
                      controller: _studentNumberController,
                      icon: Icons.school,
                      isObscured: false,
                      text: "Öğrenci Numarası",
                      keyboardType: TextInputType.number),
                  VPTextField(
                    controller: _passwordController,
                    icon: Icons.lock,
                    isObscured: true,
                    text: "Şifre",
                    keyboardType: TextInputType.text,
                  ),
                  VPButton(
                      width: 1.0,
                      bgColor: VPColors.vpGreen,
                      textColor: Colors.white,
                      text: "Kayıt Ol",
                      function: () => register(context)),
                  InkWell(
                    onTap: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen()),
                        (route) => false),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Zaten bir hesabınız var mı? Giriş yapın.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
