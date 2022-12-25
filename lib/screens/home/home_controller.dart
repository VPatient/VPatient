import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:vpatient/models/user.dart';
import 'package:vpatient/screens/slide_up_panel/slide_up_panel_controller.dart';

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
}
