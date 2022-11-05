import 'package:flutter/material.dart';
import 'package:vpatient/screens/home_screen.dart';
import 'package:vpatient/utils/local_storage.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalStorage.init();
  runApp(const MyApp());
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
