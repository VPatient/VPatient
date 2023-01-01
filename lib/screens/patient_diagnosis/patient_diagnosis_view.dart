import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/models/patient_diagnosis.dart';
import 'package:vpatient/screens/home/home_view.dart';
import 'package:vpatient/screens/patient_diagnosis/patient_diagnosis_controller.dart';
import 'package:vpatient/style/colors.dart';

class PatientDiagnosisScreen extends StatelessWidget {
  PatientDiagnosisScreen({Key? key}) : super(key: key);

  final PatientDiagnosisController _controller =
      Get.put(PatientDiagnosisController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _patientDiagnosisScreenAppBar(),
      body: _patientDiagnosisContainerBody(),
    );
  }

  Padding _patientDiagnosisContainerBody() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: 30,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "Hastayla ilgili edindiğiniz bilgiler ışığında hastaya uygun olan tanıyı/tanıları seçiniz: ",
            style: TextStyle(fontSize: 20),
          ),
          Expanded(
            child: _patientDiagnosisScreenBody(),
          ),
          Obx(() => Visibility(
                visible: _controller.getIsSubmitted,
                child: Column(
                  children: [
                    Text(
                      "Aldığınız Puan: ${_controller.getGrade.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                        onPressed: () => Get.off(() => HomeScreen()),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              VPColors.primaryColor),
                        ),
                        child: const Text("Ana Sayfa"))
                  ],
                ),
              )),
          Obx(() => Visibility(
                visible: !_controller.getIsSubmitted,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(VPColors.primaryColor),
                  ),
                  onPressed: () {
                    _controller.controlSubmit();
                  },
                  child: const Text("Gönder"),
                ),
              )),
        ],
      ),
    );
  }

  // create an app bar for diagnosis
  _patientDiagnosisScreenAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: VPColors.primaryColor,
      title: const Text("Hasta Tanı Ekranı"),
      actions: [
        IconButton(
            icon: const Icon(Icons.file_present, size: 30),
            onPressed: () => _controller.openPanel())
      ],
    );
  }

  // create a future builder for diagnosis
  Widget _patientDiagnosisScreenBody() {
    return FutureBuilder(
      future: _controller.diagnosis,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<PatientDiagnosis?> diagnosisList =
              snapshot.data as List<PatientDiagnosis?>;
          _controller.setTotalDiagnosis = diagnosisList.length;
          return (_patientDiagnosisListView(diagnosisList));
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Hata: ${snapshot.error}"),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // create a list view for diagnosis
  ListView _patientDiagnosisListView(List<PatientDiagnosis?> diagnosisList) {
    return ListView.builder(
      itemCount: diagnosisList.length,
      itemBuilder: (context, index) {
        return Card(
          child: _patientDiagnosisListTile(diagnosisList[index]!),
        );
      },
    );
  }

  // create a list tile for diagnosis
  Widget _patientDiagnosisListTile(PatientDiagnosis diagnosis) {
    final isTrue = diagnosis.patientDiagnosisTrue;
    return Obx(() => ListTile(
          enabled: _controller.getDiagnosisCheck >= 0,
          title: Text(diagnosis.name),
          trailing: _controller.getSelectedDiagnosises.contains(diagnosis)
              ? (_controller.getIsSubmitted
                  ? (isTrue
                      ? const Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      : const Icon(
                          Icons.clear,
                          color: Colors.red,
                        ))
                  : const Icon(
                      Icons.check,
                      color: Colors.green,
                    ))
              : const Icon(
                  Icons.check_box_outline_blank,
                  color: Colors.grey,
                ),
          tileColor: _controller.getIsSubmitted
              ? (isTrue ? Colors.green[100] : Colors.red[100])
              : null,
          onTap: () {
            _controller.checkDiagnosis(diagnosis);
          },
        ));
  }
}
