import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vpatient/screens/home/home_view.dart';
import 'package:vpatient/screens/slide_up_panel/slide_up_panel_view.dart';
import 'package:vpatient/style/themes.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/login/login_view.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await sleepApp();
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

Future<void> sleepApp() async {
  await Future.delayed(const Duration(seconds: 2), () {});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sanal Hastam',
      theme: Themes.baseTheme,
      home: GetStorage().hasData("token") ? HomeScreen() : LoginScreen(),
      builder: (context, child) {
        return Stack(
          children: [child!, SlideUpPanelView()],
        );
      },
    );
  }
}
