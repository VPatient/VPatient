import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vpatient/style/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> signIn() async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      if (userCredential.user != null) {
        Fluttertoast.showToast(
            msg: "Giriş İşlemi Başarılı",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: VPColors.vpGreen,
            textColor: Colors.white);

        /*if (userCredential.user!.emailVerified) {
          ...
        } else {
          Fluttertoast.showToast(
              msg:
                  "Lütfen önce emailinize gelen linke tıklayarak hesabınızı onaylayın.");
        }*/
      }
      return false;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }

    return false;
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
                      text: "E-mail"),
                  VPTextField(
                      controller: _passwordController,
                      icon: Icons.lock,
                      isObscured: true,
                      text: "Şifre"),
                  VPButton(
                      bgColor: VPColors.vpGreen,
                      textColor: Colors.white,
                      text: "Giriş Yap",
                      function: () => signIn()),
                  VPButton(
                      bgColor: Colors.white,
                      textColor: VPColors.vpGreen,
                      text: "Kayıt Ol",
                      function: () => print("Kayıt Ol")),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class VPButton extends StatelessWidget {
  const VPButton({
    Key? key,
    required bgColor,
    required text,
    required textColor,
    required function,
  })  : _bgColor = bgColor,
        _text = text,
        _textColor = textColor,
        _function = function,
        super(key: key);

  final Color _bgColor;
  final String _text;
  final Color _textColor;
  final VoidCallback _function;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20, left: 25, right: 25),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      //color: Colors.white,
      child: ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(16)),
              backgroundColor: MaterialStateProperty.all<Color>(_bgColor)),
          onPressed: _function,
          child:
              Text(_text, style: TextStyle(color: _textColor, fontSize: 20))),
    );
  }
}

class VPTextField extends StatelessWidget {
  const VPTextField(
      {Key? key,
      required TextEditingController controller,
      required isObscured,
      required icon,
      required text})
      : _controller = controller,
        _isObscured = isObscured,
        _icon = icon,
        _text = text,
        super(key: key);

  final TextEditingController _controller;
  final bool _isObscured;
  final IconData? _icon;
  final String _text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25))),
      margin: const EdgeInsets.only(top: 10, bottom: 20, left: 16, right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: TextField(
        style: const TextStyle(color: VPColors.vpGreen, fontSize: 18),
        obscureText: _isObscured,
        controller: _controller,
        cursorColor: VPColors.vpGreen,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            icon: Icon(
              _icon,
              color: VPColors.vpGreen,
            ),
            hintText: _text,
            hintStyle: const TextStyle(color: VPColors.vpGreen, fontSize: 18)),
      ),
    );
  }
}
