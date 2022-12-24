// create a stateless widget named patient_diagnosis_view.dart

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vpatient/models/patient_diagnosis.dart';
import 'package:vpatient/screens/patient_diagnosis/patient_diagnosis_controller.dart';
import 'package:vpatient/style/colors.dart';

class PatientDiagnosisScreen extends StatefulWidget {
  PatientDiagnosisScreen({super.key});

  // implement createState
  @override
  _PatientDiagnosisScreenState createState() => _PatientDiagnosisScreenState();
}

class _PatientDiagnosisScreenState extends State<PatientDiagnosisScreen> {
  final PatientDiagnosisController _controller =
      Get.put(PatientDiagnosisController());
  final patient = GetStorage().read("selectedPatient");
  
  HashSet<PatientDiagnosis> selectedDiagnosis = HashSet<PatientDiagnosis>(); // HashSet is used to prevent duplicate diagnosis
  int totalDiagnosis = 0; // total diagnosis count
  double grade = 0; // grade of the nurse
  bool isSubmitted = false; // is the diagnosis submitted

  @override
  void initState() {
    super.initState();
    isSubmitted = false;
    grade = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _patientDiagnosisScreenAppBar(),
      body: Padding(
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
            Visibility(
              visible: isSubmitted,
              child: Text(
                "Aldığınız Puan: ${grade.toStringAsFixed(2)}", 
                style: const TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: isSubmitted ? MaterialStateProperty.all<Color>(Colors.grey) : MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                if (selectedDiagnosis.isNotEmpty) {
                  setState(() {
                    if (isSubmitted) {
                      return;
                    }
                    grade = _calculateGrade();
                    _controller.grade = grade;
                    _controller.submit();
                    isSubmitted = true;
                  });
                }
              },
              child: const Text("Gönder"),
            ),
          ],
        ),
      ),
    );
  }

  // create an app bar for diagnosis
  _patientDiagnosisScreenAppBar() {
    return AppBar(
      title: const Text("Hasta Tanısı"),
      backgroundColor: VPColors.tertiaryColor,
      centerTitle: true,
    );
  }

  // calculate grade
  _calculateGrade() {
    // only half of the total diagnosises are true
    double diagnosisPoint = 100 / (totalDiagnosis / 2);

    // total point
    double totalPoint = 0;

    // if diagnosis is true add diagnosisPoint to totalPoint
    // if diagnosis is false subtract diagnosisPoint from totalPoint
    for (var element in selectedDiagnosis) {
      totalPoint = element.patientDiagnosisTrue ? totalPoint + diagnosisPoint : totalPoint - diagnosisPoint;
    }

    return totalPoint;
  }

  // create a future builder for diagnosis
  Widget _patientDiagnosisScreenBody() {
    return FutureBuilder(
      future: _controller.diagnosis,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<PatientDiagnosis?> diagnosisList =
              snapshot.data as List<PatientDiagnosis?>;
          totalDiagnosis = diagnosisList.length;
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
    final isSelected = selectedDiagnosis.contains(diagnosis);
    final isTrue = diagnosis.patientDiagnosisTrue;
    return ListTile(
      title: Text(diagnosis.name),
      trailing: isSelected
          ? (isSubmitted
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
      tileColor:
          isSubmitted ? (isTrue ? Colors.green[100] : Colors.red[100]) : null,
      onTap: () {
        setState(() {
          // if diagnosis is submitted do not change the diagnosis
          if (isSubmitted) {
            return;
          }

          // if diagnosis is selected remove it from selectedDiagnosis
          if (isSelected) {
            selectedDiagnosis.remove(diagnosis);
          }

          // if diagnosis is not selected add it to selectedDiagnosis
          else {
            selectedDiagnosis.add(diagnosis);
          }
        });
      },
    );
  }
}
