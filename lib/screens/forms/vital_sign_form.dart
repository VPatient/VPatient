import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vpatient/models/vital_sign.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:vpatient/widgets/vp_snackbar.dart';
import 'package:vpatient/widgets/vp_circular_progress_indicator.dart';

class VitalSignForm extends StatelessWidget {
  const VitalSignForm({super.key});

  Future<List<VitalSign>> getResults() async {
    final response = await http.get(
      Uri.parse(
          "${APIEndpoints.getVitalSignById}?id=${GetStorage().read("selectedPatient")}"),
      headers: {
        "Content-Type": "application/json",
        "auth-token": GetStorage().read("token")
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map<VitalSign>((json) => VitalSign.fromJson(json))
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
                        child: Text("${snapshot.data![index].date.hour}:00"))),
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
          );
        });
  }
}
