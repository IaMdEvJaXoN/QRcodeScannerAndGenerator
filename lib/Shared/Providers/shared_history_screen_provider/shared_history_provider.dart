import 'package:flutter_riverpod/flutter_riverpod.dart';

final sharedHistoryScreenProvider =
    NotifierProvider<SharedHistoryNotifier, bool>(() {
      return SharedHistoryNotifier();
    });

class SharedHistoryNotifier extends Notifier<bool> {
  @override
  bool build() {
    return true;
  }

  void toggleHistoryScreenIndex(int screenId) {
    if (screenId == 0) {
      state = true;
    } else {
      state = !state;
    }
  }
}
