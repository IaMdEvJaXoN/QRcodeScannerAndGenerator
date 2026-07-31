import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final randomTextProvider = NotifierProvider<RandomTextTimerNotifier, DateTime>(
  () {
    return RandomTextTimerNotifier();
  },
);

class RandomTextTimerNotifier extends Notifier<DateTime> {
  Timer? _timer;
  @override
  DateTime build() {
    state = DateTime.now();
    _timer = Timer.periodic(const Duration(minutes: 2), (_) {
      state = DateTime.now();
    });

    ref.onDispose(() {
      _timer?.cancel();
    });
    return state;
  }
}
