import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:vpatient/models/user.dart';

class UserHelper {
  static User getUser() {
    Map<String, dynamic> payload = Jwt.parseJwt(GetStorage().read("token"));

    User user = User.fromJson(payload);

    return user;
  }

  static String getFirstCharacters() {
    User user = UserHelper.getUser();

    String firstChars = "";

    final chars = user.name.split(" ");

    for (var element in chars) {
      firstChars += element[0];
    }

    return firstChars;
  }
}
