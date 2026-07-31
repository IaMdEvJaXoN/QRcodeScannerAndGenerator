import 'package:proscan/Features/Settings/Data/DataSource/beep_datasource.dart';
import 'package:proscan/Features/Settings/Domain/RepositoryImplementation/beep_contracts.dart';

class BeepRepoImpl implements BeepContracts {
  final BeepDatasource datasource;
  BeepRepoImpl({required this.datasource});

  @override
  Future<void> setBeepPreference(bool pref) async {
    await datasource.setBeepPrefs(pref);
  }

  @override
  Future<bool> getSavedBeepPreference() async{
    return await datasource.getSavedBeepPrefs();
  }
}
