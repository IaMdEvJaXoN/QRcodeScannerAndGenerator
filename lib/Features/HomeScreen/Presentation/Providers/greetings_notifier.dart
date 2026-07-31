import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final greetingsProvider = NotifierProvider<GreetingsNotifier, DateTime>(() {
  return GreetingsNotifier();
});

class GreetingsNotifier extends Notifier<DateTime> {
  Timer? _timer;

  @override
  DateTime build() {
    state =
        DateTime.now(); //This is run the first time the provider is called

    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      final now = DateTime.now();
      if ((now.hour == 5 ||
              now.hour == 12 ||
              now.hour == 17 ||
              now.hour == 21) &&
          (now.minute == 0)) {
        state = now;
      }
    });

    ref.onDispose(() {
      _timer?.cancel();
    });

    return state;
  }
}
