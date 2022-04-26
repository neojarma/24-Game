import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences {
  static late SharedPreferences _preferences;

  static const _username = 'username';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setUsername(String username) async {
    await _preferences.setString(_username, username);
  }

  static String getUsername() => _preferences.getString(_username) ?? '';
}
