import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpatient/screens/forms/medicines_form/medicines_form_controller.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/widgets/vp_circular_progress_indicator.dart';

class MedicinesForm extends StatelessWidget {
  MedicinesForm({super.key});

  final _controller = Get.put(MedicinesFormController());

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
                DataTable(
                  columnSpacing: 20,
                  columns: const [
                    DataColumn(label: Text("Adı")),
                    DataColumn(label: Text("Dozu")),
                    DataColumn(label: Text("Saati")),
                    DataColumn(label: Text("Nedeni")),
                    DataColumn(label: Text("Süresi"))
                  ],
                  rows: List<DataRow>.generate(
                    snapshot.data!.length,
                    (index) => DataRow(
                      cells: [
                        DataCell(Text(snapshot.data![index].name)),
                        DataCell(Text(snapshot.data![index].dose)),
                        DataCell(
                          Text(snapshot.data![index].time),
                        ),
                        DataCell(Text(snapshot.data![index].reason)),
                        DataCell(Text(snapshot.data![index].duration)),
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
            ),
          );
        });
  }
}
