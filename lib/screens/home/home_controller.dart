import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:vpatient/models/grade.dart';
import 'package:vpatient/models/user.dart';
import 'package:vpatient/screens/login/login_view.dart';
import 'package:vpatient/screens/slide_up_panel/slide_up_panel_controller.dart';
import 'package:vpatient/utils/api_endpoints.dart';
import 'package:vpatient/widgets/vp_snackbar.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  User getUser() {
    Map<String, dynamic> payload = Jwt.parseJwt(GetStorage().read("token"));

    User user = User.fromJson(payload);

    return user;
  }

  final SlideUpPanelController panelController =
      Get.put(SlideUpPanelController());

  void openPanel() {
    panelController.openPanel();
  }

  void logOut() {
    GetStorage().remove("selectedPatient");
    GetStorage().remove("token");

    Get.off(() => LoginScreen());
  }

  Future<List<Grade>> getPatients() async {
    final response = await http.get(
      Uri.parse(
          "${APIEndpoints.getGrade}?id=${GetStorage().read("selectedPatient")}"),
      headers: {
        "Content-Type": "application/json",
        "auth-token": GetStorage().read("token")
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
          .map<Grade>((json) => Grade.fromJson(json))
          .toList();
    } else {
      VPSnackbar.error(response.body);
      return List.empty();
    }
  }
}
