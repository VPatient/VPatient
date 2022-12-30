import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/screens/forms/norton_pressure_ulcer_form/norton_pressure_ulcer_form_controller.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/widgets/vp_button.dart';

class NortonPressureUlcerForm extends StatelessWidget {
  final NortonPressureUlcerFormController _controller =
      Get.put(NortonPressureUlcerFormController());

  final TextStyle _labelStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  NortonPressureUlcerForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: _renderConditions(),
    ));
  }

  Column _renderConditions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Obx(
          () => _renderCondition(
              "Fiziksel Durum",
              _controller.physicalCondition,
              _controller.physicalConditions, (value) {
            _controller.physicalConditionIndex =
                _controller.physicalConditions.indexOf(value);
          }),
        ),
        Obx(
          () => _renderCondition("Mental Durum", _controller.mentalCondition,
              _controller.mentalConditions, (value) {
            _controller.mentalConditionIndex =
                _controller.mentalConditions.indexOf(value);
          }),
        ),
        Obx(
          () => _renderCondition("Aktivite", _controller.activityCondition,
              _controller.activityConditions, (value) {
            _controller.activityConditionIndex =
                _controller.activityConditions.indexOf(value);
          }),
        ),
        Obx(
          () => _renderCondition("Hareketlilik", _controller.movementCondition,
              _controller.movementConditions, (value) {
            _controller.movementConditionIndex =
                _controller.movementConditions.indexOf(value);
          }),
        ),
        Obx(
          () => _renderCondition(
              "Intokinans",
              _controller.incontinenceCondition,
              _controller.incontinenceConditions, (value) {
            _controller.incontinenceConditionIndex =
                _controller.incontinenceConditions.indexOf(value);
          }),
        ),
        _sendButton(),
      ],
    );
  }

  Obx _sendButton() {
    return Obx(() => Visibility(
          visible: _controller.isCalled,
          child: Align(
            alignment: Alignment.center,
            child: VPButton(
                bgColor: VPColors.primaryColor,
                text: "Gönder",
                textColor: Colors.white,
                function: () => _controller.validate(),
                width: .5),
          ),
        ));
  }

  Padding _renderCondition(String name, String? value, List<String> items,
      void Function(String?)? onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: _labelStyle,
          ),
          _renderDropdown(value, items, onChanged),
        ],
      ),
    );
  }

  Widget _renderDropdown(
      String? value, List<String> items, void Function(String?)? onChanged) {
    return DropdownButton(
        icon: const Icon(Icons.arrow_drop_down, color: VPColors.primaryColor),
        itemHeight: 50,
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
