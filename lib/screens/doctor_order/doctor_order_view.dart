import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/screens/patient_diagnosis/patient_diagnosis_view.dart';
import 'package:vpatient/style/colors.dart';

class DoctorOrderPage extends StatefulWidget {
  @override
  _DoctorOrderState createState() => _DoctorOrderState();
}

class _DoctorOrderState extends State<DoctorOrderPage> {
  List<String> options = [
    "ANTA 4X1",
    "7X1 KAN ŞEKERİ TAKİBİ",
    "AÇT 2X1 (Kemoterapötik ilaçlar böbrekleri bozabilir)",
    "1500 cc TPN OLİCLİNOMEL 12 ssat IV infüzyon",
    "1500 cc %0.9 İzotonik Sodyum Klorür IV infüzyon",
    "Cernevit flk. mayi içine",
    "Durajezik 25 mg 1x1",
    "Contromal 100 mg 2x1 IV infüzyon",
    "Parol flk. 3x1 IV infüzyon",
    "Desefin 1gr 2x1 IV",
    "Flagy 500mg 2x1 IV",
    "Mukostatin gargara 3x1",
    "Klorheks gargara 3x1",
    "Famodin tb. 2x1 PO",
    "Coraspin 100 mg 1x1 PO",
    "Delix 10 mg 1x1 PO",
    "Lantus İnsülin 14 ünite 1x1 SC",
    "Novamix İnsülin 10 Ünite 3x1 SC"
  ];

  List<String> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: VPColors.primaryColor,
        title: const Text("Hekim Orderı"),
        actions: [
          InkWell(
            onTap: () {
              Get.snackbar("Kaydedildi", "Hekim Orderı Kaydedildi");
              Get.off(PatientDiagnosisScreen());
            },
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Seçenekler", style: Get.textTheme.headline6),
          ),
          Expanded(
            child: buildOptions(),
          ),
          const Divider(
            height: 10,
            thickness: 4,
            color: VPColors.secondaryColor,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Hekim Orderı", style: Get.textTheme.headline6),
          ),
          Expanded(
            child: buildSelectedOptions(),
          ),
        ],
      ),
    );
  }

  Widget buildOptions() {
    return DragTarget<String>(
      builder: (context, accepted, rejected) {
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          children: options
              .map((kart) => Draggable(
                    data: kart,
                    feedback: _buildCard(kart),
                    childWhenDragging: Container(),
                    child: _buildCard(kart),
                  ))
              .toList(),
        );
      },
      onWillAccept: (data) =>
          !options.contains(data) && selectedOptions.contains(data),
      onAccept: (data) {
        setState(() {
          selectedOptions.remove(data);
          options.insert(0, data);
        });
      },
    );
  }

  Widget buildSelectedOptions() {
    return DragTarget<String>(
      builder: (context, accepted, rejected) {
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          children: selectedOptions
              .map((kart) => Draggable(
                    data: kart,
                    feedback: _buildCard(kart, true),
                    childWhenDragging: Container(),
                    child: _buildCard(kart, true),
                  ))
              .toList(),
        );
      },
      onWillAccept: (data) =>
          !selectedOptions.contains(data) && options.contains(data),
      onAccept: (data) {
        setState(() {
          options.remove(data);
          selectedOptions.insert(0, data);
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
