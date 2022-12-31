import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/screens/forms/blood_sugar_trace_form/blood_sugar_trace_form_controller.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/widgets/vp_circular_progress_indicator.dart';

class BloodSugarTraceForm extends StatelessWidget {
  BloodSugarTraceForm({super.key});

  final _controller = Get.put(BloodSugarTraceFormController());

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
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    columnSpacing: 20,
                    columns: const [
                      DataColumn(label: Text("Tarih")),
                      DataColumn(label: Text("Sonuç")),
                      DataColumn(label: Text("Not")),
                    ],
                    rows: List<DataRow>.generate(
                      snapshot.data!.length,
                      (index) => DataRow(
                        cells: [
                          DataCell(
                              Text("${snapshot.data![index].time.hour}:00")),
                          DataCell(Text(snapshot.data![index].result)),
                          DataCell(Text(snapshot.data![index].note)),
                        ],
                      ),
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
            ),
          );
        });
  }
}

/* DataTable(
              columnSpacing: 20,
              columns: const [
                DataColumn(label: Text("Tarih")),
                DataColumn(label: Text("Sonuç")),
                DataColumn(label: Text("Not")),
              ],
              rows: List<DataRow>.generate(
                snapshot.data!.length,
                (index) => DataRow(
                  cells: [
                    DataCell(Text("${snapshot.data![index].time.hour}:00")),
                    DataCell(Text(snapshot.data![index].result)),
                    DataCell(Text(snapshot.data![index].note)),
                  ],
                ),
              ),
            ),*/
