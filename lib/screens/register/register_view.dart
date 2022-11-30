import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/screens/register/register_controller.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/widgets/vp_button.dart';
import 'package:vpatient/widgets/vp_textfield.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _studentNumberController =
      TextEditingController();
  final TextEditingController _nameSurnameController = TextEditingController();

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
                    bgColor: Get.theme.primaryColor,
                    textColor: Colors.white,
                    text: "Kayıt Ol",
                    function: () => _controller.register(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                        _nameSurnameController.text.trim(),
                        _studentNumberController.text.trim())),
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
