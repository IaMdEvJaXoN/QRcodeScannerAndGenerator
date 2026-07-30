import 'package:proscan/Features/CreateQR/Data/DataSource/data_source.dart';
import 'package:proscan/Features/CreateQR/Data/Models/model.dart';
import 'package:proscan/Features/CreateQR/Domain/Entity/entity.dart';
import 'package:proscan/Features/CreateQR/Domain/RepositoryContracts/repo_contracts.dart';

class RepoImplemenation implements RepoContracts {
  final GeneratedDataSource dataSource;
  RepoImplemenation({required this.dataSource});

  @override
  Future<void> saveGeneratedQr(GeneratedQrHistoryEntity entity) async {
    final model = GeneratedQrModel.fromEntityToModel(entity);
    await dataSource.saveGeneratedQrData(model);
  }

  @override
  Future<List<GeneratedQrHistoryEntity>> getHistory() async {
    final qrData = await dataSource.getGeneratedHistory();
    return qrData.map((model) => model.toEntityFromModel()).toList();
  }

  @override
  Future<void> clearHistory() async {
    await dataSource.clearGeneratedHistory();
  }
}
