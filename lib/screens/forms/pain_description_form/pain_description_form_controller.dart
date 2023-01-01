import 'package:get/get.dart';
import 'package:vpatient/abstractions/base_form.dart';
import 'package:vpatient/main.dart';
import 'package:vpatient/widgets/vp_snackbar.dart';

class PainDescriptionFormController extends BaseForm {
  // pain level
  final _painIntense = 0.obs;

  // get pain level
  get painIntense => _painIntense.value.truncate();

  // pain level descriptions
  final List<String> _descriptions = [
    "Ağrım Yok",
    "Çok az var",
    "Biraz var",
    "Oldukça fazla",
    "Çok fazla",
    "Dayanılacak gibi değil"
  ];

  // pain current description
  String _currentDescription = "Ağrım Yok";

  // get current description
  get currentDescription => _currentDescription;

  // create list obs
  final _painQualifications = [].obs;

  // add or remove item from pain qualifications
  void checkPainQualification(String item) => _painQualifications.contains(item)
      ? _painQualifications.remove(item)
      : _painQualifications.add(item);

  // check if pain qualifications contains item
  bool containsPainQualification(String item) =>
      _painQualifications.contains(item);

  // all possible pain qualifications
  final _painQualificationTypes = [
    "Sızlama",
    "Künt",
    "Yanma",
    "Gerilme",
    "Zonklama",
    "Acıma",
    "Batma",
    "Sıkıştırma",
  ];

  // get pain qualifications
  get painQualifications => _painQualificationTypes;

  // pain type
  final _painType = "Sürekli".obs;
  String get painType => _painType.value;

  set setPainType(String value) {
    _painType.value = value;
  }

  // pain location
  final _painLocation = "Sağ Göğüs".obs;

  // get pain location
  get painLocation => _painLocation.value;

  // set pain location
  set setPainLocation(String value) => _painLocation.value = value;

  // all possible pain locations
  final _painLocations = [
    "Sağ Göğüs",
    "Sol Göğüs",
    "Karın",
    "Sağ Bacak",
    "Sol Bacak",
    "Sağ Kol",
    "Sol Kol",
    "Sırt",
    "Baş",
    "Diğer"
  ];

  // get pain locations
  get painLocations => _painLocations;

  @override
  void onInit() async {
    super.onInit();
    await super.getPatient();
  }

  @override
  void validate() {
    if (!super.isCalled) {
      super.validate();
      return;
    }

    if (painIntense == patient.painIntensity) {
      VPSnackbar.error("Ağrı şiddetini doğru seçmediniz");
      setValidated = false;
      return;
    }

    if (painLocation != patient.painLocation) {
      VPSnackbar.error("Ağrı yerini doğru seçmediniz");
      setValidated = false;
      return;
    }

    if ((patient.painType != painType)) {
      VPSnackbar.error("Ağrı sürekliliğini doğru seçmediniz");
      setValidated = false;
      return;
    }

    if (!controlRealPainQualifications()) {
      VPSnackbar.error("Ağrı niteliklerini doğru seçmediniz");
      setValidated = false;
      return;
    }

    VPSnackbar.success("Tebrikler formu doğru bir şekilde doldurdunuz.");
    super.setCalled = false;
    setValidated = true;
    panelController.closePanel();
  }

  bool controlRealPainQualifications() {
    var list1 = patient.painQualification.split(", ");
    var list2 = _painQualifications;

    var condition1 = list1.toSet().difference(list2.toSet()).isEmpty;
    var condition2 = list1.length == list2.length;
    return condition1 && condition2;
  }

  void setPainIntense(double value) {
    _painIntense.value = value.truncate();
    _currentDescription = _descriptions[value.truncate() ~/ 2];
  }
}
