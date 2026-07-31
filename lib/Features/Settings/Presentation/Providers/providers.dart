import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proscan/Core/services/shared_prefs.dart';
import 'package:proscan/Features/Settings/Data/DataSource/beep_datasource.dart';
import 'package:proscan/Features/Settings/Data/RepositoryImplementation/beep_repo_impl.dart';
import 'package:proscan/Features/Settings/Domain/RepositoryImplementation/beep_contracts.dart';
import 'package:proscan/Features/Settings/Domain/UseCases/beep_usecases/beep.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefsClassProvider = Provider((_) {
  final prefs = SharedPreferencesAsync();
  return SharedPrefs(prefs: prefs);
});

final dataSourceProvider = Provider<BeepDatasource>((ref) {
  final sharedPrefs = ref.watch(sharedPrefsClassProvider);
  return BeepDatasource(preferences: sharedPrefs);
});

final repoImpProvider = Provider<BeepContracts>((ref) {
  final dataSource = ref.watch(dataSourceProvider);
  return BeepRepoImpl(datasource: dataSource);
});

final saveBeepUseCaseProvider = Provider((ref) {
  final repository = ref.watch(repoImpProvider);
  return SetBeepPreferenceUseCase(repository: repository);
});

final getBeepUseCaseProvider = Provider((ref) {
  final repository = ref.watch(repoImpProvider);
  return GetBeepPreferenceUseCase(repository: repository);
});
