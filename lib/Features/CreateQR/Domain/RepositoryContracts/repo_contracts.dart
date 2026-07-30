import 'package:proscan/Features/CreateQR/Domain/Entity/entity.dart';

abstract class RepoContracts {
  Future<void> saveGeneratedQr(GeneratedQrHistoryEntity entity);
  Future<List<GeneratedQrHistoryEntity>> getHistory();
  Future<void> clearHistory();
}
