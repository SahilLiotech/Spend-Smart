import 'package:shared_preferences/shared_preferences.dart';

class Apppref {
  final SharedPreferences _preferences;

  Apppref(this._preferences);

  Future<bool> isOnboardingDone() async {
    return _preferences.getBool('isOnboardingDone') ?? false;
  }

  Future<void> setOnboardingDone(bool value) async {
    await _preferences.setBool('isOnboardingDone', value);
  }
}
