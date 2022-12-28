import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vpatient/models/blood_sugar_trace.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:vpatient/widgets/vp_snackbar.dart';
import 'package:vpatient/widgets/vp_circular_progress_indicator.dart';

class BloodSugarTraceForm extends StatelessWidget {
  const BloodSugarTraceForm({super.key});

  Future<List<BloodSugarTrace>> getResults() async {
    final response = await http.get(
      Uri.parse(
          "${APIEndpoints.getBloodSugarTraceById}?id=${GetStorage().read("selectedPatient")}"),
      headers: {
        "Content-Type": "application/json",
        "auth-token": GetStorage().read("token")
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map<BloodSugarTrace>((json) => BloodSugarTrace.fromJson(json))
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
            ),
          );
        });
  }
}
