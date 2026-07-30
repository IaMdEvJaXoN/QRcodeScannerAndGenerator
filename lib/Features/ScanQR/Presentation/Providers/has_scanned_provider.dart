import 'package:flutter_riverpod/flutter_riverpod.dart';

final hasScannedProvider = NotifierProvider<HasscannedNotifier, bool>(() {
  return HasscannedNotifier();
});

class HasscannedNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void updateScanState(bool newState) {
    state = newState;
  }
}
