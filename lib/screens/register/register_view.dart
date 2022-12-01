import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/screens/register/register_controller.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/widgets/vp_button.dart';
import 'package:vpatient/widgets/vp_textfield.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final _controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [VPColors.gradientBegin, VPColors.gradientEnd])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                VPTextField(
                  controller: _controller.emailController,
                  icon: Icons.mail,
                  text: "E-mail",
                  keyboardType: TextInputType.emailAddress,
                ),
                VPTextField(
                  controller: _controller.nameSurnameController,
                  icon: Icons.person,
                  text: "Ad Soyad",
                  keyboardType: TextInputType.text,
                ),
                VPTextField(
                    controller: _controller.studentNumberController,
                    icon: Icons.school,
                    text: "Öğrenci Numarası",
                    keyboardType: TextInputType.number),
                VPTextField(
                  controller: _controller.passwordController,
                  icon: Icons.lock,
                  isObscured: true,
                  text: "Şifre",
                  keyboardType: TextInputType.text,
                ),
                VPButton(
                    width: 1.0,
                    bgColor: Get.theme.primaryColor,
                    textColor: Colors.white,
                    text: "Kayıt Ol",
                    function: () => _controller.register()),
                InkWell(
                  onTap: () => _controller.navigateToLogin(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Zaten bir hesabınız var mı? Giriş yapın.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
