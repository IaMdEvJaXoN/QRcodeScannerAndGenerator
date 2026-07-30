import 'package:proscan/Features/CreateQR/Domain/Entity/entity.dart';
import 'package:proscan/Features/CreateQR/Domain/RepositoryContracts/repo_contracts.dart';

class SaveGeneratedQrUseCase {
  final RepoContracts repository;
  SaveGeneratedQrUseCase({required this.repository});
  Future<void> call(GeneratedQrHistoryEntity entity) async {
    await repository.saveGeneratedQr(entity);
  }
}

class GetGeneratedQrHistoryUseCase {
  final RepoContracts repository;
  GetGeneratedQrHistoryUseCase({required this.repository});
  Future<List<GeneratedQrHistoryEntity>> call() async {
    return await repository.getHistory();
  }
}

class ClearGenerateQrHistoryUseCase {
  final RepoContracts repository;
  ClearGenerateQrHistoryUseCase({required this.repository});
  Future<void> call() async {
    await repository.clearHistory();
  }
}
