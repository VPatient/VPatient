import 'package:flutter/material.dart';
import 'package:vpatient/style/colors.dart';

class Themes {
  static final ThemeData baseTheme = ThemeData(
      primaryColor: VPColors.primaryColor,
      textTheme: const TextTheme(
          button: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          bodyText1: TextStyle(
              color: VPColors.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w500),
          caption: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  side: BorderSide(
                      color: VPColors.primaryColor,
                      width: 1,
                      style: BorderStyle.solid))),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(16)))));
}
