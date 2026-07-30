import 'package:proscan/Features/ScanQR/Data/DataSource/datasource.dart';
import 'package:proscan/Features/ScanQR/Data/Model/model.dart';
import 'package:proscan/Features/ScanQR/Domain/Entity/entity.dart';
import 'package:proscan/Features/ScanQR/Domain/RepositoryContract/scanner_contracts.dart';

class RepoImpl implements ScannerContracts {
  final ScanLocalDataSource datasource;
  RepoImpl({required this.datasource});

  @override
  Future<void> saveScannedItem(ScanHistoryEntity entity) async {
    final scanModel = ScanModel.fromEntityToModel(entity);
    await datasource.saveScan(scanModel);
  }

  @override
  Future<List<ScanHistoryEntity>> getHistory() async {
    final scanModels = await datasource.getSavedModels();
    return scanModels.map((model) => model.toEntityFromModel()).toList();
  }

  @override
  Future<void> clearHistory() async {
    await datasource.clearScanHistory();
  }
}
