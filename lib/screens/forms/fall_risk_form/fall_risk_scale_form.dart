import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/models/fall_risk_form_factors.dart';
import 'package:vpatient/screens/forms/fall_risk_form/fall_risk_form_controller.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/widgets/vp_button.dart';

class FallRiskScaleForm extends StatelessWidget {
  FallRiskScaleForm({Key? key}) : super(key: key);

  final _controller = Get.put(FallRiskFormController());

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _renderHeader(),
            Expanded(
                child: ListView.builder(
                    itemCount: _controller.factors.length,
                    itemBuilder: ((context, index) {
                      return _renderListItem(
                          _controller.factors.elementAt(index));
                    }))),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => Text("Toplam puan: ${_controller.totalScore} ")),
              ],
            ),
            const Divider(),
            _renderRiskLevel(),
            _renderSendButton()
          ],
        ));
  }

  Obx _renderSendButton() {
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

  Widget _renderHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            Text("Açıklama", style: TextStyle(color: VPColors.primaryColor))
          ],
        ),
        Row(
          children: const [
            Text("Puan", style: TextStyle(color: VPColors.primaryColor)),
            SizedBox(
              width: 10,
            )
          ],
        )
      ],
    );
  }

  Widget _renderListItem(FallRiskFormFactors factor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [Expanded(child: Text(factor.factor))],
          ),
        ),
        Row(
          children: [
            Text(factor.point.toString()),
            Obx(() => Checkbox(
                activeColor: VPColors.primaryColor,
                checkColor: Colors.white,
                value: factor.isChecked.value,
                onChanged: (bool? value) {
                  int score = value! ? factor.point : -factor.point;
                  _controller.setTotalScore = score;
                  factor.isChecked.value = value;
                }))
          ],
        )
      ],
    );
  }

  Widget _renderRiskLevel() {
    return Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RadioListTile(
              activeColor: VPColors.primaryColor,
              title: const Text("Düşük Risk(Toplam puan 5 in altında)"),
              value: "Düşük Risk(Toplam puan 5 in altında)",
              groupValue: _controller.riskLevel,
              onChanged: (value) => _controller.setRiskLevel = value!,
            ),
            RadioListTile(
              activeColor: VPColors.primaryColor,
              title: const Text("Yüksek Risk(toplam puan 5 ve 5'in üstünde)"),
              value: "Yüksek Risk(toplam puan 5 ve 5'in üstünde)",
              groupValue: _controller.riskLevel,
              onChanged: (value) => _controller.setRiskLevel = value!,
            ),
          ],
        ));
  }
}
