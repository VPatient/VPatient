import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/screens/forms/vital_sign_form/vital_sign_form_controller.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/widgets/vp_circular_progress_indicator.dart';

class VitalSignForm extends StatelessWidget {
  VitalSignForm({super.key});

  final _controller = Get.put(VitalSignFormController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _controller.getResults(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child:
                    VPCircularProgressIndicator(color: VPColors.primaryColor));
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DataTable(
                columnSpacing: 20,
                columns: const [
                  DataColumn(label: Text("Tarih")),
                  DataColumn(label: Text("Kan\nBasıncı")),
                  DataColumn(label: Text("Nabız/dk")),
                  DataColumn(label: Text("Solunum/dk")),
                  DataColumn(label: Text("Vücut\nSıcaklığı")),
                ],
                rows: List<DataRow>.generate(
                  snapshot.data!.length,
                  (index) => DataRow(
                    cells: [
                      DataCell(Center(
                          child:
                              Text("${snapshot.data![index].date.hour}:00"))),
                      DataCell(Center(
                          child: Text(snapshot.data![index].bloodPressure))),
                      DataCell(Center(
                          child: Text(snapshot.data![index].pulseOverMinute))),
                      DataCell(Center(
                          child: Text(snapshot.data![index].breathOverMinute))),
                      DataCell(Center(
                          child: Text(snapshot.data![index].bodyTemperature))),
                    ],
                  ),
                ),
              ),
              Obx(() => Visibility(
                    visible: _controller.isCalled,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                            value: _controller.isChecked,
                            onChanged: ((value) {
                              _controller.setChecked = value!;
                            })),
                        InkWell(
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              _controller.setChecked = !_controller.isChecked;
                            },
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                child: const Text("Formu inceledim")))
                      ],
                    ),
                  ))
            ],
          );
        });
  }
}
