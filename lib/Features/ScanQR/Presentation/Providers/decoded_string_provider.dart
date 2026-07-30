import 'package:flutter_riverpod/flutter_riverpod.dart';

final decodedStringProvider = NotifierProvider<DecodedStringNotifier, String>(
  () {
    return DecodedStringNotifier();
  },
);

class DecodedStringNotifier extends Notifier<String> {
  @override
  String build() {
    return "";
  }

  void updateDecodedString(String decodedString) {
    state = decodedString;
  }
}
