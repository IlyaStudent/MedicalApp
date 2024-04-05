import 'package:shared_preferences/shared_preferences.dart';

class PreferncesServices {
  //HospitalBranch
  static Future<SharedPreferences> get _instance async =>
      await SharedPreferences.getInstance();

  Future<String> getPreference(String key) async {
    final SharedPreferences prefs = await _instance;
    return prefs.getString(key) ?? "Филиал на Московское шоссе";
  }

  Future<void> setPreference(String key, String value) async {
    final SharedPreferences prefs = await _instance;
    await prefs.setString(key, value);
  }

  Future<void> clearPreferences() async {
    final SharedPreferences prefs = await _instance;
    await prefs.clear();
  }
}
