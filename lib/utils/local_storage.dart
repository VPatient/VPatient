import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static late final SharedPreferences _prefs;
  static SharedPreferences get storage => _prefs;
}
