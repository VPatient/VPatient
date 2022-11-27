
import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final String text;
  const FormHeader({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize:25));
  }
}

