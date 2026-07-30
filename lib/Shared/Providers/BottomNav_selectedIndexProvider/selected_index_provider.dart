import 'package:flutter_riverpod/legacy.dart';

final selectedIndexProvider = StateNotifierProvider<SelectedIndexNotifier, int>(
  (_) {
    return SelectedIndexNotifier();
  },
);

class SelectedIndexNotifier extends StateNotifier<int> {
  SelectedIndexNotifier() : super(0);
  void updateIndex(int index) {
    state = index;
  }
}
