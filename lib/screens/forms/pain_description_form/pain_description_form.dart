import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/screens/forms/pain_description_form/pain_description_form_controller.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/widgets/vp_button.dart';
import 'package:vpatient/widgets/vp_snackbar.dart';
import 'package:vpatient/widgets/vp_textfield.dart';

class PainDescriptionForm extends StatelessWidget {
  final _controller = Get.put(PainDescriptionFormController());

  final _painLocationController = TextEditingController();

  get _isSubmitted => _controller.isValidated;

  get _patient => _controller.patient;

  PainDescriptionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text("Ağrının Şiddeti: ", style: TextStyle(fontSize: 20)),
          _painLevel(),
          const Divider(),
          const SizedBox(
            height: 15,
          ),
          const Text("Ağrının Niteliği", style: TextStyle(fontSize: 20)),
          const SizedBox(
            height: 5,
          ),
          _painQualifications(),
          const Divider(),
          const SizedBox(
            height: 15,
          ),
          const Text("Ağrının Sürekliliği", style: TextStyle(fontSize: 20)),
          _painType(),
          const Divider(),
          const SizedBox(
            height: 15,
          ),
          const Text("Ağrının Yeri", style: TextStyle(fontSize: 20)),
          _painLocation(),
          const Divider(),
          const SizedBox(
            height: 15,
          ),
          _sendButton(),
        ],
      ),
    );
  }

  _painLocation() {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 8),
        child: Obx(() => DropdownButton<String>(
            isExpanded: true,
            icon:
                const Icon(Icons.arrow_drop_down, color: VPColors.primaryColor),
            itemHeight: 65,
            underline: Container(height: 2, color: VPColors.primaryColor),
            value: _controller.painLocation,
            items: _controller.painLocations
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: SizedBox(width: 150, child: Text(value)),
              );
            }).toList(),
            onChanged: (value) => _controller.setPainLocation = value!)));
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

  _painLevel() {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Column(
        children: [
          Obx(() => Text(
              "${_controller.currentDescription} (${_controller.painIntense})",
              style: Get.textTheme.bodyText1)),
          SliderTheme(
            data: Get.theme.sliderTheme.copyWith(
              activeTrackColor: VPColors.primaryColor,
              inactiveTrackColor: VPColors.primaryColor.withOpacity(0.2),
              trackShape: const RoundedRectSliderTrackShape(),
              trackHeight: 4.0,
              thumbColor: VPColors.primaryColor,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
              overlayColor: VPColors.primaryColor.withOpacity(0.2),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
            ),
            child: Obx(() => Slider(
                  value: _controller.painIntense * 1.0,
                  min: 0,
                  max: 10,
                  divisions: 5,
                  label: _controller.currentDescription,
                  onChanged: (value) {
                    _controller.setPainIntense(value);
                  },
                )),
          ),
        ],
      ),
    );
  }

  _painQualifications() {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      spacing: 50,
      children: _controller.painQualifications.map<Widget>((e) {
        return _painQualificationItem(e);
      }).toList(),
    );
  }

  Widget _painQualificationItem(String name) {
    return Column(children: [
      Text(name,
          style: Get.textTheme.bodyText1!.copyWith(
            fontSize: 15,
          )),
      Obx(() => Checkbox(
          checkColor: Colors.white,
          value: _controller.containsPainQualification(name),
          onChanged: (value) {
            _controller.checkPainQualification(name);
          }))
    ]);
  }

  Obx _painType() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: RadioListTile(
                activeColor: VPColors.primaryColor,
                title: const Text("Sürekli"),
                value: "Sürekli",
                groupValue: _controller.painType,
                onChanged: (value) => _controller.setPainType = value!,
              ),
            ),
            Expanded(
              child: RadioListTile(
                activeColor: VPColors.primaryColor,
                title: const Text("Aralıklı"),
                value: "Aralıklı",
                groupValue: _controller.painType,
                onChanged: (value) => _controller.setPainType = value!,
              ),
            ),
          ],
        ));
  }
}
