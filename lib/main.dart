import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vpatient/screens/home/home_view.dart';
import 'package:vpatient/screens/slide_up_panel/slide_up_panel_controller.dart';
import 'package:vpatient/screens/slide_up_panel/slide_up_panel_view.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/style/themes.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/login/login_view.dart';

final panelController = Get.put(SlideUpPanelController());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  //WidgetsBinding widgetsBinding = Wid
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
      home: const SplashScreen(),
      builder: (context, child) {
        return Navigator(
          onGenerateRoute: (_) => MaterialPageRoute(builder: (context) {
            return Stack(children: [child!, SlideUpPanelView()]);
          }),
        );
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterSplashScreen.fadeIn(
            animationCurve: Curves.easeInOut,
            backgroundColor: VPColors.primaryColor,
            fadeInAnimationDuration: const Duration(milliseconds: 750),
            fadeInChildWidget: Image.asset(
              "assets/images/icons/vpatient-logo.png",
              width: Get.size.width / 3,
            ),
            defaultNextScreen:
                GetStorage().hasData("token") ? HomeScreen() : LoginScreen()));
  }
}
