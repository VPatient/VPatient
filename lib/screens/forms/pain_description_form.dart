import 'package:flutter/material.dart';
import 'package:vpatient/style/colors.dart';

class PainDescriptionForm extends StatelessWidget {
  const PainDescriptionForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PainDescriptionFormContent();
  }
}

class PainDescriptionFormContent extends StatelessWidget {
  const PainDescriptionFormContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          SizedBox(height: 50),
          Text("Ağrının Şiddeti"),
          SizedBox(height: 5),
          PainLevel(),
          Divider(),
          SizedBox(height: 15),
          Text("Ağrının Niteliği"),
          NatureOfPain(),
          Divider(),
          SizedBox(height: 15),
          Text("Ağrının Sürekliliği"),
          PaintType()
        ],
      ),
    );
  }
}

class PainLevel extends StatefulWidget {
  const PainLevel({Key? key}) : super(key: key);

  @override
  State<PainLevel> createState() => _PainLevelState();
}

class _PainLevelState extends State<PainLevel> {
  double _currentValue = 0;
  final List<String> _descriptions = [
    "Ağrım Yok",
    "Çok az var",
    "Biraz var",
    "Oldukça fazla",
    "Çok fazla",
    "Dayanılacak gibi değil"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Slider(
        activeColor: VPColors.primaryColor,
        label: _descriptions[(_currentValue.round() ~/ 2)],
        value: _currentValue,
        onChanged: (value) {
          setState(() {
            _currentValue = value;
          });
        },
        divisions: 5,
        min: 0,
        max: 10,
      ),
    );
  }
}

class NatureOfPain extends StatelessWidget {
  const NatureOfPain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                NatureOfPainItem(),
                NatureOfPainItem(),
                NatureOfPainItem()
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                NatureOfPainItem(),
                NatureOfPainItem(),
                NatureOfPainItem()
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                NatureOfPainItem(),
                NatureOfPainItem(),
                NatureOfPainItem()
              ],
            )
          ],
        )
      ],
    );
  }
}

class NatureOfPainItem extends StatefulWidget {
  const NatureOfPainItem({Key? key}) : super(key: key);

  @override
  State<NatureOfPainItem> createState() => _NatureOfPainItemState();
}

class _NatureOfPainItemState extends State<NatureOfPainItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Text("Sızlama"),
      Checkbox(
          checkColor: Colors.white,
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          })
    ]);
  }
}

class PaintType extends StatefulWidget {
  const PaintType({Key? key}) : super(key: key);

  @override
  State<PaintType> createState() => _PaintTypeState();
}

class _PaintTypeState extends State<PaintType> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(children: [
          const Text("Sürekli"),
          Checkbox(
              checkColor: Colors.white,
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              })
        ]),
        Row(children: [
          const Text("Sürekli değil"),
          Checkbox(
              checkColor: Colors.white,
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              })
        ])
      ],
    );
  }
}
