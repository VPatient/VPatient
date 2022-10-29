import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: const Scaffold(
          body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
            child: Text(
                "Sanal Hastam uygulamasına hoşgeldiniz, yakında yeniliklerle karşınızda olacağız :D",
                style: TextStyle(fontSize: 20))),
      )),
    );
  }
}
