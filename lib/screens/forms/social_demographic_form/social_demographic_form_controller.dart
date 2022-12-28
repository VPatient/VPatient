import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/abstractions/base_form.dart';
import 'package:vpatient/widgets/vp_snackbar.dart';

class SocialDemographicFormController extends BaseForm {
  @override
  void onInit() async {
    super.onInit();

    await super.getPatient();

    heightController.addListener(_calculateBMI);
    weightController.addListener(_calculateBMI);

    _fillPatientInfo();
  }

  @override
  void validate() {
    if (!super.isCalled) {
      super.validate();
      return;
    }
    if (nameSurnameController.text != patient?.name) {
      setValidated = false;
      VPSnackbar.error("Ad-soyad bilgisi yanlış girildi.");
      return;
    }

    if (gender != patient?.gender) {
      setValidated = false;

      VPSnackbar.error("Cinsiyet bilgisi yanlış girildi.");
      return;
    }

    if (ageController.text != patient?.age.toString()) {
      setValidated = false;

      VPSnackbar.error("Yaş bilgisi yanlış girildi.");
      return;
    }

    if (marritalStatus != patient!.maritalStatus) {
      setValidated = false;

      VPSnackbar.error("Medeni durum bilgisi yanlış girildi.");
      return;
    }

    if (childNumberController.text != patient?.children.toString()) {
      setValidated = false;
      VPSnackbar.error("Çocuk sayısı bilgisi yanlış girildi.");
      return;
    }

    if (companion != patient?.companion) {
      setValidated = false;
      VPSnackbar.error("Refakatçi bilgisi yanlış girildi.");
      return;
    }

    if (bloodType != patient?.bloodType) {
      setValidated = false;
      VPSnackbar.error("Kan grubu yanlış girildi.");
      return;
    }

    if (insurance != patient?.insurance) {
      setValidated = false;
      VPSnackbar.error("Sosyal güvence bilgisi yanlış girildi.");
      return;
    }

    if (int.parse(heightController.text) != patient?.height) {
      setValidated = false;
      VPSnackbar.error("Boy bilgisi yanlış girildi.");
      return;
    }

    if (int.parse(weightController.text) != patient?.weight) {
      setValidated = false;
      VPSnackbar.error("Kilo bilgisi yanlış girildi.");
      return;
    }

    VPSnackbar.success("Tebrikler formu doğru bir şekilde doldurdunuz.");

    super.setCalled = false;
    setValidated = true;
  }

  _fillPatientInfo() {
    jobController.text = patient?.job;
    insuranceController.text = patient?.insurance;
    primaryDiagnosisController.text = patient?.primaryDiagnosis;
  }

  void _calculateBMI() {
    int weight = int.parse(weightController.value.text);
    int height = int.parse(heightController.value.text);

    var bmi = weight / ((height / 100) * (height / 100));

    bmiController.text = bmi.toString();
  }

  // Text field controllers to handle text field's data
  final TextEditingController nameSurnameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController childNumberController = TextEditingController();
  final TextEditingController insuranceController = TextEditingController();
  final TextEditingController primaryDiagnosisController =
      TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController bmiController = TextEditingController();

  // Gender variables
  final _genderValue = "Erkek".obs;
  String get gender => _genderValue.value;
  set setGender(String value) {
    _genderValue.value = value;
  }
  // Gender variables

  // Marrital Status variables
  final _marritalStatus = "Evli".obs;
  String get marritalStatus => _marritalStatus.value;
  set setMarritalStatus(String value) {
    _marritalStatus.value = value;
  }
  // Marrital Status variables

  // Degree variables
  final List<String> _degreeList = [
    'İlkokul terk',
    'İlkokul',
    'Ortaokul',
    'Lise',
    'Üniversite'
  ];
  get degreeList => _degreeList;
  final _degree = "İlkokul terk".obs;
  get degree => _degree.value;
  set setDegree(String value) => _degree.value = value;
  // Degree variables

// Companion variables
  final List<String> _companionList = [
    'Eşi',
    'Annesi',
    'Babası',
    'Çocuğu',
    'Kardeşi',
    'Diğer'
  ];
  get companionList => _companionList;
  final _companion = "Eşi".obs;
  get companion => _companion.value;
  set setCompanion(String value) => _companion.value = value;
  // Companion variables

  // Companion variables
  final List<String> _bloodTypeList = [
    "0(+)",
    "0(-)",
    "A(+)",
    "A(-)",
    "B(+)",
    "B(-)",
    "AB(+)",
    "AB(-)"
  ];
  get bloodTypeList => _bloodTypeList;
  final _bloodType = "0(+)".obs;
  get bloodType => _bloodType.value;
  set setBloodType(String value) => _bloodType.value = value;
  // Blood type variables

  // Contagious disease variables
  final _contagiousDiseaseValue = "Yok".obs;
  String get contagiousDisease => _contagiousDiseaseValue.value;
  set setContagiousDisease(String value) {
    _contagiousDiseaseValue.value = value;
  }
  // Contagious disease variables

  // Insurance variables
  final List<String> _insuranceList = [
    "SGK",
    "Bağkur",
    "Emekli Sandığı",
    "Özel Sigorta"
  ];
  get insuranceList => _insuranceList;
  final _insurance = "SGK".obs;
  get insurance => _insurance.value;
  set setInsurance(String value) => _insurance.value = value;
  // Insurance variables

}
