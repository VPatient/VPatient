import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vpatient/models/patient.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/utils/api_endpoints.dart';
import 'package:vpatient/utils/vp_snackbar.dart';
import 'package:vpatient/widgets/vp_textfield.dart';
import 'package:http/http.dart' as http;

class PainDescriptionForm extends StatelessWidget {
  const PainDescriptionForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PainDescriptionFormContent();
  }
}

class PainDescriptionFormContent extends StatefulWidget {
  const PainDescriptionFormContent({Key? key}) : super(key: key);

  @override
  State<PainDescriptionFormContent> createState() =>
      _PainDescriptionFormContentState();
}

class _PainDescriptionFormContentState
    extends State<PainDescriptionFormContent> {
  final _painLevel = PainLevel();

  final _natureOfPain = NatureOfPain();

  final _painType = PaintType();

  final _painLocationController = TextEditingController();

  var _isSubmitted = false;

  Patient? _patient;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getPatient(),
        builder: (context, AsyncSnapshot<Patient?> snapshot) {
          if (snapshot.hasData) {
            _patient = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text("Ağrının Şiddeti: ",
                      style: TextStyle(fontSize: 20)),
                  _painLevel,
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Ağrının Niteliği",
                      style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 5,
                  ),
                  _natureOfPain,
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Ağrının Sürekliliği",
                      style: TextStyle(fontSize: 20)),
                  _painType,
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  _painLocation(),
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: _isSubmitted
                            ? MaterialStateProperty.all<Color>(Colors.grey)
                            : MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () {
                        if (_isSubmitted) return;
                        _save();
                      },
                      child: const Text("Kaydet")),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  _painLocation() {
    return VPTextField(
      controller: _painLocationController,
      text: "Ağrının Yeri",
      keyboardType: TextInputType.text,
    );
  }

  Future<Patient?> _getPatient() async {
    final response = await http.get(
      Uri.parse(
          "${APIEndpoints.getPatientById}?id=${GetStorage().read("selectedPatient")}"),
      headers: {
        "Content-Type": "application/json",
        "auth-token": GetStorage().read("token")
      },
    );

    if (response.statusCode == 200) {
      return Patient.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  _save() {
    var painLevel = _painLevel.currentValue;
    var selectedItems = _natureOfPain.selectedItems;
    var painType = _painType.isChecked;
    var painLocation = _painLocationController.text.toLowerCase();

    var realPainLevel = double.parse(_patient!.painIntensity);
    var realPainType = _patient!.painType == "Sürekli";
    var realPainLocation = _patient!.painLocation.toLowerCase();
    var realPainQualifications = _patient!.painQualification.split(", ");

    var painLevelCondition = painLevel == realPainLevel;
    var painTypeCondition = painType == realPainType;
    var painLocationCondition = painLocation == realPainLocation;
    var painQualificationCondition =
        _listEquality(selectedItems, realPainQualifications);

    if (painLevelCondition &&
        painTypeCondition &&
        painLocationCondition &&
        painQualificationCondition) {
      VPSnackbar.success("Tebrikler, formu doğru doldurdunuz");
      _isSubmitted = true;
    } else {
      VPSnackbar.error("Ağrı bilgileriniz yanlış");
      _isSubmitted = false;
    }
  }

  _listEquality(List<String> list1, List<String> list2) {
    var condition1 = list1.toSet().difference(list2.toSet()).isEmpty;
    var condition2 = list1.length == list2.length;
    return condition1 && condition2;
  }
}

class PainLevel extends StatefulWidget {
  PainLevel({Key? key, }) : super(key: key);
  final _painLevelState = _PainLevelState();

  get currentDescription => _painLevelState.currentDescription;
  get currentValue => _painLevelState.currentValue;

  @override
  State<PainLevel> createState() => _painLevelState;
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
  String _currentDescription = "Ağrım Yok";

  get currentDescription => _currentDescription;
  get currentValue => _currentValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text("$_currentDescription (${_currentValue.truncate()})",
              style: Theme.of(context).textTheme.bodyText1),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: VPColors.primaryColor,
              inactiveTrackColor: VPColors.primaryColor.withOpacity(0.2),
              trackShape: const RoundedRectSliderTrackShape(),
              trackHeight: 4.0,
              thumbColor: VPColors.primaryColor,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
              overlayColor: VPColors.primaryColor.withOpacity(0.2),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
            ),
            child: Slider(
              value: _currentValue,
              min: 0,
              max: 10,
              divisions: 5,
              label: _currentDescription,
              onChanged: (value) {
                setState(() {
                  _currentValue = value;
                  _currentDescription =
                      _descriptions[_currentValue.truncate() ~/ 2.toInt()];
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NatureOfPain extends StatelessWidget {
  NatureOfPain({Key? key}) : super(key: key);
  var items = [
    NatureOfPainItem(
      name: "Sızlama",
    ),
    NatureOfPainItem(
      name: "Künt",
    ),
    NatureOfPainItem(
      name: "Yanma",
    ),
    NatureOfPainItem(
      name: "Gerilme",
    ),
    NatureOfPainItem(
      name: "Zonklama",
    ),
    NatureOfPainItem(
      name: "Acıma",
    ),
    NatureOfPainItem(
      name: "Keskin",
    ),
    NatureOfPainItem(
      name: "Sıkıştırma",
    ),
  ];

  get selectedItems => items
      .where((element) => element._natureOfPainItemState.isChecked)
      .map((e) => e.name)
      .toList();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      spacing: 50,
      children: items,
    );
  }
}

class NatureOfPainItem extends StatefulWidget {
  final String name;
  var _natureOfPainItemState;
  NatureOfPainItem({Key? key, this.name = ""}) : super(key: key);

  get isChecked => _natureOfPainItemState.isChecked;

  @override
  State<NatureOfPainItem> createState() {
    _natureOfPainItemState = _NatureOfPainItemState(name);
    return _natureOfPainItemState;
  }
}

class _NatureOfPainItemState extends State<NatureOfPainItem> {
  final String name;
  bool isChecked = false;

  _NatureOfPainItemState(this.name);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(name,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 15,
              )),
      Checkbox(
          checkColor: Colors.white,
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = !isChecked;
            });
          })
    ]);
  }
}

class PaintType extends StatefulWidget {
  PaintType({Key? key}) : super(key: key);
  final _paintTypeState = _PaintTypeState();

  get isChecked => _paintTypeState.isChecked;

  @override
  State<PaintType> createState() => _paintTypeState;
}

class _PaintTypeState extends State<PaintType> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(children: [
          Text("Sürekli", style: Theme.of(context).textTheme.bodyText1),
          Checkbox(
              checkColor: Colors.white,
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value!;
                });
              })
        ]),
        Row(children: [
          Text("Sürekli değil", style: Theme.of(context).textTheme.bodyText1),
          Checkbox(
              checkColor: Colors.white,
              value: !isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = !isChecked;
                });
              })
        ])
      ],
    );
  }
}
