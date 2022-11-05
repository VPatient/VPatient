import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vpatient/models/user.dart';
import 'package:vpatient/screens/home_screen.dart';
import 'package:vpatient/screens/register_screen.dart';
import 'package:vpatient/style/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vpatient/utils/api_endpoints.dart';
import 'package:vpatient/utils/local_storage.dart';
import 'package:vpatient/widgets/vp_button.dart';
import 'package:vpatient/widgets/vp_textfield.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  signIn(BuildContext context) async {
    final response = await http.post(Uri.parse(APIEndpoints.loginEndpoint),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "email": _emailController.text,
          "password": _passwordController.text
        }));

    if (response.statusCode == 200) {
      await LocalStorage.storage.setString("token", response.body);
      Fluttertoast.showToast(
          msg: "Giriş başarılı",
          backgroundColor: VPColors.vpGreen,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          fontSize: 18);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const HomeScreen()),
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  VPTextField(
                      controller: _emailController,
                      icon: Icons.mail,
                      isObscured: false,
                      text: "E-mail",
                      keyboardType: TextInputType.emailAddress),
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
                      text: "Giriş Yap",
                      function: () => signIn(context)),
                  InkWell(
                    onTap: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                RegisterScreen()),
                        (route) => false),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Hesabınız yok mu? Kayıt olmak için tıklayın.",
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
