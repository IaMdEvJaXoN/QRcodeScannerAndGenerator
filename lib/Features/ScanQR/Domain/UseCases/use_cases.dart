import 'package:proscan/Features/ScanQR/Domain/Entity/entity.dart';
import 'package:proscan/Features/ScanQR/Domain/RepositoryContract/scanner_contracts.dart';

class GetHistoryUseCase {
  final ScannerContracts repository;
  GetHistoryUseCase({required this.repository});
  Future<List<ScanHistoryEntity>> call() async {
    return await repository.getHistory();
  }
}

class SaveScanUseCase {
  final ScannerContracts repository;
  SaveScanUseCase({required this.repository});
  Future<void> call(ScanHistoryEntity entity) async {
    return await repository.saveScannedItem(entity);
  }
}

class ClearHistoryUseCase {
  final ScannerContracts repository;
  ClearHistoryUseCase({required this.repository});
  Future<void> call() async {
    return await repository.clearHistory();
  }
}
