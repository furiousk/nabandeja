import 'package:shared_preferences/shared_preferences.dart';

class PreferencesProvider {
  static Future<String> getCompanyId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("company") ?? "";
  }
}
