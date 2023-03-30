import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/screens/forms/laboratory_results_form/laboratory_results_form_controller.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/widgets/vp_circular_progress_indicator.dart';

class LaboratoryResultForm extends StatelessWidget {
  LaboratoryResultForm({super.key});

  final _controller = Get.put(LaboratoryResultsFormController());

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
                      DataColumn(label: Text("Parametre Adı")),
                      DataColumn(label: Text("Sonuç")),
                      DataColumn(label: Text("Birim")),
                      DataColumn(label: Text("Referans Aralığı")),
                    ],
                    rows: List<DataRow>.generate(
                      snapshot.data!.length,
                      (index) => DataRow(
                        cells: [
                          DataCell(Text(snapshot.data![index].parameterName)),
                          DataCell(Text(snapshot.data![index].result)),
                          DataCell(Text(snapshot.data![index].unit)),
                          DataCell(
                              Text(snapshot.data![index].referanceInterval)),
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
