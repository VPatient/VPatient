import 'package:flutter/material.dart';
import 'package:vpatient/screens/home_screen.dart';
import 'package:vpatient/utils/local_storage.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/login_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalStorage.init();
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sanal Hastam',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LocalStorage.storage.getString("token") != null
          ? const HomeScreen()
          : LoginScreen(),
    );
  }
}
