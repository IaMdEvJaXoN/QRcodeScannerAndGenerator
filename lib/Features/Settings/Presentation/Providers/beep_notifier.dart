import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proscan/Features/Settings/Presentation/Providers/providers.dart';

final beepProvider = NotifierProvider<BeepNotifier, bool>(() {
  return BeepNotifier();
});

class BeepNotifier extends Notifier<bool> {
  @override
  bool build() {
    bool prefs = false;
    final getBeepPreferenceUseCase = ref.read(getBeepUseCaseProvider);
    getBeepPreferenceUseCase().then((pref) {
      state = pref;
    });
    return prefs;
  }

  Future<void> toggleBeepState() async {
    final setBeepPreferenceUseCase = ref.read(saveBeepUseCaseProvider);
    state = !state;
    await setBeepPreferenceUseCase(state);
  }
}
