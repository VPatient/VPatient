import 'package:flutter/material.dart';
import 'package:vpatient/style/colors.dart';

class NortonPressureUlcerForm extends StatefulWidget {
  const NortonPressureUlcerForm({super.key});

  @override
  State<NortonPressureUlcerForm> createState() =>
      _NortonPressureUlcerFormState();
}

class _NortonPressureUlcerFormState extends State<NortonPressureUlcerForm> {
  final TextStyle _labelStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  final List<String> _physicalConditions = ['İyi', 'Orta', 'Kötü', 'Çok Kötü'];
  String? physicalConditionValue;

  final List<String> _mentalConditions = [
    'Uyanık',
    'Apatik',
    'Konfuse',
    'Stupor'
  ];
  String? mentalConditionValue;

  final List<String> _activityConditions = [
    'Hareketli',
    'Yürüme Yard.',
    'Tekerlekli Sandalyede',
    'Yatağa Bağımlı'
  ];
  String? activityConditionValue;

  final List<String> _movementConditions = [
    'Tam',
    'Hafifçe Kısıtlı',
    'Çok Kısıtlı',
    'Hareketsiz'
  ];
  String? movementConditionValue;

  final List<String> _incontinenceConditions = [
    'Yok',
    'Nadiren',
    'Genellikle/İdrar',
    'Her İkisi'
  ];
  String? incontinenceConditionValue;

  @override
  void initState() {
    super.initState();
    physicalConditionValue = _physicalConditions.first;
    mentalConditionValue = _mentalConditions.first;
    activityConditionValue = _activityConditions.first;
    movementConditionValue = _movementConditions.first;
    incontinenceConditionValue = _incontinenceConditions.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Fiziksel Durum',
                style: _labelStyle,
              ),
              _renderDropdown(physicalConditionValue, _physicalConditions,
                  (value) {
                setState(() {
                  physicalConditionValue = value;
                });
              }),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mental Durum',
                style: _labelStyle,
              ),
              _renderDropdown(mentalConditionValue, _mentalConditions, (value) {
                setState(() {
                  mentalConditionValue = value;
                });
              }),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Aktivite',
                style: _labelStyle,
              ),
              _renderDropdown(activityConditionValue, _activityConditions,
                  (value) {
                setState(() {
                  activityConditionValue = value;
                });
              }),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hareketlilik',
                style: _labelStyle,
              ),
              _renderDropdown(movementConditionValue, _movementConditions,
                  (value) {
                setState(() {
                  movementConditionValue = value;
                });
              }),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'İnkontinans',
                style: _labelStyle,
              ),
              _renderDropdown(
                  incontinenceConditionValue, _incontinenceConditions, (value) {
                setState(() {
                  incontinenceConditionValue = value;
                });
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _renderDropdown(
      String? value, List<String> items, void Function(String?)? onChanged) {
    return DropdownButton(
        icon: const Icon(Icons.arrow_drop_down, color: VPColors.primaryColor),
        itemHeight: 65,
        underline: Container(height: 2, color: VPColors.primaryColor),
        value: value,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: SizedBox(width: 150, child: Text(value)),
          );
        }).toList(),
        onChanged: onChanged);
  }
}
