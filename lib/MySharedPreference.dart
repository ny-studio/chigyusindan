import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference {

  static Future<int> getPrefsLimit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("limit") ?? 10;
  }

  static void setPrefsLimit(int limit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("limit", limit);
  }

  static Future<bool> getPrefsSound() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("sound") ?? true;
  }

  static void setPrefsSound(bool sound) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("sound", sound);
  }

  static Future<int> getPrefsTestLimit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("test_limit") ?? 100;
  }

  static void setPrefsTestLimit(int limit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("test_limit", limit);
  }
}