import 'package:shared_preferences/shared_preferences.dart';

class SessionStorage {
  static const _loggedInKey = 'logged_in';

  static Future<bool> isLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_loggedInKey) ?? false;
  }

  static Future<void> saveLogin() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_loggedInKey, true);
  }

  static Future<void> logout() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_loggedInKey);
  }
}
