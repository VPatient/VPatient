import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vpatient/models/laboratory_result.dart';
import 'package:vpatient/style/colors.dart';
import 'package:vpatient/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:vpatient/widgets/vp_snackbar.dart';
import 'package:vpatient/widgets/vp_circular_progress_indicator.dart';

class LaboratoryResultForm extends StatelessWidget {
  const LaboratoryResultForm({super.key});

  Future<List<LaboratoryResult>> getResults() async {
    final response = await http.get(
      Uri.parse(
          "${APIEndpoints.getLaboratoryResultsById}?id=${GetStorage().read("selectedPatient")}"),
      headers: {
        "Content-Type": "application/json",
        "auth-token": GetStorage().read("token")
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map<LaboratoryResult>((json) => LaboratoryResult.fromJson(json))
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
                    DataCell(Text(snapshot.data![index].referanceInterval)),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
