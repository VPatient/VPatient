import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/screens/forms/social_demographic_form/social_demographic_form_controller.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/widgets/vp_button.dart';

import 'package:vpatient/widgets/vp_textfield.dart';

class SocialDemographicForm extends StatelessWidget {
  SocialDemographicForm({Key? key}) : super(key: key);

  final _controller = Get.put(SocialDemographicFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _renderLabel("Adı Soyadı"),
              _renderNameSurname(),
              _renderLabel("Cinsiyet"),
              _renderGender(),
              _renderLabel("Yaş"),
              _renderAge(),
              _renderLabel("Medeni Durum"),
              _renderMarritalStatus(),
              _renderLabel("Eğitim Derecesi"),
              _renderDegree(),
              _renderLabel("Meslek"),
              _renderJob(),
              _renderLabel("Çocuk Sayısı"),
              _renderChildNumber(),
              _renderLabel("Sosyal Güvence"),
              _renderInsurance(),
              _renderLabel("Refakatçisi"),
              _renderCompanion(),
              _renderLabel("Kan Grubu"),
              _renderBloodType(),
              _renderLabel("Bulaşıcı Hastalık"),
              _renderContagiousDisease(),
              _renderLabel("Primer Tıbbi Tanı"),
              _primaryDiagnosis(),
              _renderLabel("Boy (cm)"),
              _renderHeight(),
              _renderLabel("Kilo (kg)"),
              _renderWeight(),
              _renderLabel("Vücut Kitle İndeksi"),
              _renderBMI(),
              _renderSendButton()
            ],
          ),
        ),
      ),
    );
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

  VPTextFieldOutline _renderBMI() {
    return VPTextFieldOutline(
      enabled: false,
      text: "",
      keyboardType: TextInputType.number,
      controller: _controller.bmiController,
    );
  }

  VPTextFieldOutline _renderWeight() {
    return VPTextFieldOutline(
      text: "",
      keyboardType: TextInputType.number,
      controller: _controller.weightController,
    );
  }

  VPTextFieldOutline _renderHeight() {
    return VPTextFieldOutline(
      text: "",
      keyboardType: TextInputType.number,
      controller: _controller.heightController,
    );
  }

  VPTextFieldOutline _primaryDiagnosis() {
    return VPTextFieldOutline(
      text: "",
      keyboardType: TextInputType.text,
      controller: _controller.primaryDiagnosisController,
    );
  }

  Obx _renderContagiousDisease() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: RadioListTile(
                activeColor: VPColors.primaryColor,
                title: const Text("Yok"),
                value: "Yok",
                groupValue: _controller.contagiousDisease,
                onChanged: (value) => _controller.setContagiousDisease = value!,
              ),
            ),
            Expanded(
              child: RadioListTile(
                activeColor: VPColors.primaryColor,
                title: const Text("Var"),
                value: "Var",
                groupValue: _controller.contagiousDisease,
                onChanged: (value) => _controller.setContagiousDisease = value!,
              ),
            ),
          ],
        ));
  }

  Padding _renderBloodType() {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 8),
        child: Obx(() => DropdownButton<String>(
            isExpanded: true,
            icon:
                const Icon(Icons.arrow_drop_down, color: VPColors.primaryColor),
            itemHeight: 65,
            underline: Container(height: 2, color: VPColors.primaryColor),
            value: _controller.bloodType,
            items: _controller.bloodTypeList
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: SizedBox(width: 150, child: Text(value)),
              );
            }).toList(),
            onChanged: (value) => _controller.setBloodType = value!)));
  }

  Padding _renderCompanion() {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 8),
        child: Obx(() => DropdownButton<String>(
            isExpanded: true,
            icon:
                const Icon(Icons.arrow_drop_down, color: VPColors.primaryColor),
            itemHeight: 65,
            underline: Container(height: 2, color: VPColors.primaryColor),
            value: _controller.companion,
            items: _controller.companionList
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: SizedBox(width: 150, child: Text(value)),
              );
            }).toList(),
            onChanged: (value) => _controller.setCompanion = value!)));
  }

  Padding _renderInsurance() {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 8),
        child: Obx(() => DropdownButton<String>(
            isExpanded: true,
            icon:
                const Icon(Icons.arrow_drop_down, color: VPColors.primaryColor),
            itemHeight: 65,
            underline: Container(height: 2, color: VPColors.primaryColor),
            value: _controller.insurance,
            items: _controller.insuranceList
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: SizedBox(width: 150, child: Text(value)),
              );
            }).toList(),
            onChanged: (value) => _controller.setInsurance = value!)));
  }

  VPTextFieldOutline _renderChildNumber() {
    return VPTextFieldOutline(
      text: "",
      keyboardType: TextInputType.number,
      controller: _controller.childNumberController,
    );
  }

  VPTextFieldOutline _renderJob() {
    return VPTextFieldOutline(
      text: "",
      keyboardType: TextInputType.text,
      controller: _controller.jobController,
    );
  }

  Padding _renderDegree() {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 8),
        child: Obx(() => DropdownButton<String>(
            isExpanded: true,
            icon:
                const Icon(Icons.arrow_drop_down, color: VPColors.primaryColor),
            itemHeight: 65,
            underline: Container(height: 2, color: VPColors.primaryColor),
            value: _controller.degree,
            items: _controller.degreeList
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: SizedBox(width: 150, child: Text(value)),
              );
            }).toList(),
            onChanged: (value) => _controller.setDegree = value!)));
  }

  VPTextFieldOutline _renderNameSurname() {
    return VPTextFieldOutline(
      text: "",
      keyboardType: TextInputType.text,
      controller: _controller.nameSurnameController,
    );
  }

  Padding _renderLabel(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Text("$label: ", style: Get.textTheme.labelLarge),
    );
  }

  Obx _renderGender() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: RadioListTile(
                activeColor: VPColors.primaryColor,
                title: const Text("Erkek"),
                value: "Erkek",
                groupValue: _controller.gender,
                onChanged: (value) => _controller.setGender = value!,
              ),
            ),
            Expanded(
              child: RadioListTile(
                activeColor: VPColors.primaryColor,
                title: const Text("Kadın"),
                value: "Kadın",
                groupValue: _controller.gender,
                onChanged: (value) => _controller.setGender = value!,
              ),
            ),
          ],
        ));
  }

  VPTextFieldOutline _renderAge() {
    return VPTextFieldOutline(
      text: "",
      keyboardType: TextInputType.number,
      controller: _controller.ageController,
    );
  }

  Obx _renderMarritalStatus() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: RadioListTile(
                activeColor: VPColors.primaryColor,
                title: const Text("Evli"),
                value: "Evli",
                groupValue: _controller.marritalStatus,
                onChanged: (value) => _controller.setMarritalStatus = value!,
              ),
            ),
            Expanded(
              child: RadioListTile(
                activeColor: VPColors.primaryColor,
                title: const Text("Bekar"),
                value: "Bekar",
                groupValue: _controller.marritalStatus,
                onChanged: (value) => _controller.setMarritalStatus = value!,
              ),
            ),
          ],
        ));
  }
}
