import 'package:flutter/material.dart';
import 'package:vpatient/screens/login_screen.dart';
import 'package:vpatient/utils/local_storage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Home Screen ${LocalStorage.storage.getString("token")}"),
          ElevatedButton(
            child: Text("Çıkış Yap"),
            onPressed: () {
              LocalStorage.storage.remove("token");
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen()),
                  (route) => false);
            },
          )
        ],
      )),
    );
  }
}
