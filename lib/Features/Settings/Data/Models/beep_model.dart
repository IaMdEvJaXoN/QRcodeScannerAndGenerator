import 'package:proscan/Features/Settings/Domain/Entity/beep_entity.dart';

class BeepModel {
  final bool pref;
  BeepModel({required this.pref});

  factory BeepModel.toModel(bool prefs) {
    return BeepModel(pref: prefs);
  }

  BeepEntity toEntity() {
    return BeepEntity(isBeepAllowed: pref);
  }
}
