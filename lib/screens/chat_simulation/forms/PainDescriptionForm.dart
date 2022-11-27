import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/screens/chat_simulation/forms/util/FormConstants.dart';
import 'package:vpatient/screens/chat_simulation/forms/util/FormWidgets.dart';
import 'package:vpatient/widgets/vp_textfield.dart';

class PainDescriptionForm extends StatelessWidget {
  const PainDescriptionForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FormContent();
  }
}

class FormContent extends StatelessWidget {
  const FormContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(left: 2.0, top: 50.0, right: 2.0, bottom: 2.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            const FormHeader(text: painDescriptionFormHeader),
            PainDescriptor()
          ],
        ),
      ),
    );
  }
}

class PainDescriptor extends StatelessWidget {
  final Map<int, String> painLevelText = {};

  PainDescriptor({Key? key}) : super(key: key) {
    final painLevelTextEntries = {
      0: 'Ağrım yok',
      2: 'Çok az var',
      4: 'Biraz var',
      6: 'Oldukça fazla',
      8: 'Çok Fazla',
      10: 'Dayanılacak gibi değil',
    };
    painLevelText.addAll(painLevelTextEntries);

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        padding: const EdgeInsets.all(10),
        height: 200.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(color: Colors.grey, spreadRadius: 1),
          ],
        ),
        child: Column(
          children: [
            Text("Ağrının Şiddeti"),
            SizedBox(height: 5),
            Divider(),
            SingleChildScrollView(
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: List.generate(
                      6,
                      (index) => PainDescriptorItem(
                          painLevel: painLevelText.keys.elementAt(index),
                          painText: painLevelText.values.elementAt(index)),
                  growable: false)
              ),
            ),
          ],
        ));
  }
}


class PainDescriptorItem extends StatelessWidget {
  final int painLevel;
  final String painText;

  const PainDescriptorItem(
      {Key? key, required this.painLevel, required this.painText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      child: Container(
        height: 130,
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(painLevel.toString()),
            const SizedBox(height: 5),
            Text(painText)
          ],
        ),
      )
    );
  }
}
