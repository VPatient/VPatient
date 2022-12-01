import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/screens/login/login_controller.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/widgets/vp_button.dart';
import 'package:vpatient/widgets/vp_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [VPColors.gradientBegin, VPColors.gradientEnd])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FractionallySizedBox(
                widthFactor: 0.4,
                child: Image.asset(
                  "assets/images/icons/vpatient-logo.png",
                ),
              ),
              Column(
                children: [
                  VPTextField(
                      controller: _controller.emailController,
                      icon: Icons.mail,
                      text: "E-mail",
                      keyboardType: TextInputType.emailAddress),
                  VPTextField(
                    controller: _controller.passwordController,
                    icon: Icons.lock,
                    isObscured: true,
                    text: "Şifre",
                    keyboardType: TextInputType.text,
                  ),
                  VPButton(
                      width: 1.0,
                      bgColor: VPColors.primaryColor,
                      textColor: Colors.white,
                      text: "Giriş Yap",
                      function: () => _controller.signIn()),
                  InkWell(
                    onTap: () => _controller.navigateToRegister(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Hesabınız yok mu? Kayıt olmak için tıklayın.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
