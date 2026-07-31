import 'package:proscan/Core/services/shared_prefs.dart';

class BeepDatasource {
  final SharedPrefs preferences;
  BeepDatasource({required this.preferences});
  Future<void> setBeepPrefs(bool prefs) async {
    await preferences.setBeep(prefs);
  }

  Future<bool> getSavedBeepPrefs() async {
    return await preferences.getBeep();
  }
}
