import 'package:flutter_riverpod/flutter_riverpod.dart';

final zoomControlProvider = NotifierProvider<ZoomControlNotifier, double>(() {
  return ZoomControlNotifier();
});

class ZoomControlNotifier extends Notifier<double> {
  @override
  double build() {
    return 0;
  }

  void updateSliderPosition(double newSliderValue) {
    state = newSliderValue;
  }
}
