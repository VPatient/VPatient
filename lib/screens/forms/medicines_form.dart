import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vpatient/models/medicine.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:vpatient/widgets/vp_snackbar.dart';
import 'package:vpatient/widgets/vp_circular_progress_indicator.dart';

class MedicinesForm extends StatelessWidget {
  const MedicinesForm({super.key});

  Future<List<Medicine>> getResults() async {
    final response = await http.get(
      Uri.parse(
          "${APIEndpoints.getMedicinesById}?id=${GetStorage().read("selectedPatient")}"),
      headers: {
        "Content-Type": "application/json",
        "auth-token": GetStorage().read("token")
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map<Medicine>((json) => Medicine.fromJson(json))
          .toList();
    } else {
      VPSnackbar.error(response.body);
      return List.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getResults(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child:
                    VPCircularProgressIndicator(color: VPColors.primaryColor));
          }
          return SingleChildScrollView(
            child: DataTable(
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
          );
        });
  }
}
