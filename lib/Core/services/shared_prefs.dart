import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  final SharedPreferencesAsync _prefs;
  SharedPrefs({required this._prefs});

  static const String _beepKey = 'beep';

  Future<void> setBeep(bool value) async {
    await _prefs.setBool(_beepKey, value);
  }

  Future<bool> getBeep() async {
    return await _prefs.getBool(_beepKey) ?? false;
  }
}
