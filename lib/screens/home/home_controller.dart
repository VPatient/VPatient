import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:vpatient/models/user.dart';

class HomeController extends GetxController {
  User getUser() {
    Map<String, dynamic> payload = Jwt.parseJwt(GetStorage().read("token"));

    User user = User.fromJson(payload);

    return user;
  }
}
