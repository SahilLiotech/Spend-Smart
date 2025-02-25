import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static bool isOnboardingDone() {
    return _preferences.getBool('isOnboardingDone') ?? false;
  }

  static Future<void> setOnboardingDone(bool value) async {
    await _preferences.setBool('isOnboardingDone', value);
  }

  static String getUserName() {
    return _preferences.getString('userName') ?? '';
  }

  static Future<void> setUserName(String value) async {
    await _preferences.setString('userName', value);
  }

  static String getUserEmail() {
    return _preferences.getString('userEmail') ?? '';
  }

  static Future<void> setUserEmail(String value) async {
    await _preferences.setString('userEmail', value);
  }

  static Future<void> clearUserData() async {
    await _preferences.remove('userName');
    await _preferences.remove('userEmail');
  }
}
