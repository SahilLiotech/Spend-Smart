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
}
