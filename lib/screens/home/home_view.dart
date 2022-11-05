import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vpatient/screens/home/home_controller.dart';
import 'package:vpatient/screens/login/login_view.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text("Hoşgeldin ${_controller.getUser().name}"),
              const Text("Kullanıcı Bilgileri: "),
              Text("Id: ${_controller.getUser().id}"),
              Text("Adı Soyadı: ${_controller.getUser().name}"),
              Text("Email: ${_controller.getUser().email}"),
              Text("Öğrenci No: ${_controller.getUser().studentNumber}"),
            ],
          ),
          ElevatedButton(
            child: const Text("Çıkış Yap"),
            onPressed: () {
              GetStorage().remove("token");
              Get.to(LoginScreen());
            },
          )
        ],
      )),
    );
  }
}
