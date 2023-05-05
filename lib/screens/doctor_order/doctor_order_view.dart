import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vpatient/models/doctor_order_medicine.dart';
import 'package:vpatient/screens/patient_diagnosis/patient_diagnosis_view.dart';
import 'package:vpatient/style/colors.dart';
import 'package:http/http.dart' as http;
import 'package:vpatient/utils/api_endpoints.dart';
import 'package:vpatient/widgets/vp_snackbar.dart';

class DoctorOrderPage extends StatefulWidget {
  @override
  _DoctorOrderState createState() => _DoctorOrderState();
}

class _DoctorOrderState extends State<DoctorOrderPage> {
  List<DoctorOrderMedicine> options = [];
  List<DoctorOrderMedicine> oral = [];
  List<DoctorOrderMedicine> parenteral = [];

  //create a http request to ApiEndpoints.getDoctorOrderMedicine and equalize options with response
  Future<List<DoctorOrderMedicine>> getDoctorOrderMedicine() async {
    final response = await http.get(
      Uri.parse(APIEndpoints.getDoctorOrderMedicines),
      headers: {
        "Content-Type": "application/json",
        "auth-token": GetStorage().read("token")
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        options.addAll(jsonDecode(response.body)
            .map<DoctorOrderMedicine>(
                (json) => DoctorOrderMedicine.fromJson(json))
            .toList());
      });
    } else {
      Get.snackbar("Hata", "Hekim Orderı Getirilemedi");
    }

    return options;
  }

  void checkAndNavigate() {
    if (checkLists()) {
      VPSnackbar.success("Başarılı", "Hekim Orderı Kaydedildi");
      Get.off(PatientDiagnosisScreen());
    }
  }

  bool checkLists() {
    if (oral.isEmpty || parenteral.isEmpty || options.isNotEmpty) {
      VPSnackbar.warning("HATA",
          "Bütün seçeneklerin Oral veye Parenteral Tedavi olarak seçilmesi gerekiyor");
      return false;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    getDoctorOrderMedicine();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: VPColors.primaryColor,
          title: const Text("Hekim Orderı"),
          actions: [
            InkWell(
              onTap: () => checkAndNavigate(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text("Tanı Ekranı"),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLayoutCard(title: "Seçenekler", child: buildOptions()),
            Row(
              children: [
                _buildLayoutCard(
                  title: "Oral Tedavi",
                  child: buildOralSelections(),
                  width: 0.5,
                ),
                _buildLayoutCard(
                  title: "Parenteral Tedavi",
                  child: buildParenteralSelections(),
                  width: 0.5,
                ),
              ],
            )
          ],
        ));
  }

  Widget _buildLayoutCard({String? title, Widget? child, double width = 1}) {
    return SizedBox(
      height: Get.height * 0.45,
      width: Get.width * width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: VPColors.secondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  title!,
                  style: Get.textTheme.headline6!.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
              child: Container(
                decoration: const BoxDecoration(
                  color: VPColors.secondaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: child,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildOptions() {
    return DragTarget<DoctorOrderMedicine>(
      builder: (context, accepted, rejected) {
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          children: options
              .map((kart) => Draggable(
                    data: kart,
                    feedback: _buildCard(kart.medicineName!),
                    childWhenDragging: Container(),
                    child: _buildCard(kart.medicineName!),
                  ))
              .toList(),
        );
      },
      onWillAccept: (data) =>
          !options.contains(data) &&
          (oral.contains(data) || parenteral.contains(data)),
      onAccept: (data) {
        setState(() {
          if (oral.contains(data)) {
            oral.remove(data);
          } else if (parenteral.contains(data)) {
            parenteral.remove(data);
          }

          options.insert(0, data);
        });
      },
    );
  }

  Widget buildOralSelections() {
    return DragTarget<DoctorOrderMedicine>(
      builder: (context, accepted, rejected) {
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          children: oral
              .map((kart) => Draggable(
                    data: kart,
                    feedback: _buildCard(kart.medicineName!, true),
                    childWhenDragging: Container(),
                    child: _buildCard(kart.medicineName!, true),
                  ))
              .toList(),
        );
      },
      onWillAccept: (data) =>
          data?.type == 0 &&
          !oral.contains(data) &&
          (options.contains(data) || parenteral.contains(data)),
      onAccept: (data) {
        setState(() {
          if (options.contains(data)) {
            options.remove(data);
          } else if (parenteral.contains(data)) {
            parenteral.remove(data);
          }
          oral.insert(0, data);
        });
      },
    );
  }

  Widget buildParenteralSelections() {
    return DragTarget<DoctorOrderMedicine>(
      builder: (context, accepted, rejected) {
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          children: parenteral
              .map((kart) => Draggable(
                    data: kart,
                    feedback: _buildCard(kart.medicineName!, true),
                    childWhenDragging: Container(),
                    child: _buildCard(kart.medicineName!, true),
                  ))
              .toList(),
        );
      },
      onWillAccept: (data) =>
          data?.type == 1 &&
          !parenteral.contains(data) &&
          (options.contains(data) || oral.contains(data)),
      onAccept: (data) {
        setState(() {
          if (options.contains(data)) {
            options.remove(data);
          } else if (oral.contains(data)) {
            oral.remove(data);
          }
          parenteral.insert(0, data);
        });
      },
    );
  }

  Widget _buildCard(String text, [bool isTrue = false]) {
    return Container(
      height: 100,
      width: 200,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isTrue ? VPColors.primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20,
              color: isTrue ? Colors.white : VPColors.primaryColor),
        ),
      ),
    );
  }
}
