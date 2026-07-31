import 'package:proscan/Features/Settings/Domain/RepositoryImplementation/beep_contracts.dart';

class SetBeepPreferenceUseCase {
  final BeepContracts repository;
  SetBeepPreferenceUseCase({required this.repository});

  Future<void> call(bool pref) async {
    await repository.setBeepPreference(pref);
  }
}

class GetBeepPreferenceUseCase {
  final BeepContracts repository;
  GetBeepPreferenceUseCase({required this.repository});

  Future<bool> call() async {
    return await repository.getSavedBeepPreference();
  }
}
