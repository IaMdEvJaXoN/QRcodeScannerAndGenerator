import 'package:proscan/Features/ScanQR/Domain/Entity/entity.dart';

abstract class ScannerContracts {
  Future<void> saveScannedItem(ScanHistoryEntity entity);
  Future<List<ScanHistoryEntity>> getHistory();
  Future<void> clearHistory();
}
