import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:proscan/Core/Utils/shared_utils/adapter_names.dart';
import 'package:proscan/Features/CreateQR/Data/DataSource/data_source.dart';
import 'package:proscan/Features/CreateQR/Data/Models/model.dart';
import 'package:proscan/Features/CreateQR/Data/RepositoryImplementation/repo_implemenation.dart';
import 'package:proscan/Features/CreateQR/Domain/RepositoryContracts/repo_contracts.dart';
import 'package:proscan/Features/CreateQR/Domain/Usecases/use_cases.dart';

final createdQrsBoxProvider = Provider<Box<GeneratedQrModel>>((_) {
  return Hive.box<GeneratedQrModel>(AdapterNames.generatedQrsHistoryBoxName);
});

final createdQrsDataSourceProvider =
    Provider<GeneratedDataSourceImplementation>((ref) {
      final openedBox = ref.watch(createdQrsBoxProvider);
      return GeneratedDataSourceImplementation(generatedQrBox: openedBox);
    });

final createdQrsRepositoryProvider = Provider<RepoContracts>((ref) {
  final dataSource = ref.watch(createdQrsDataSourceProvider);
  return RepoImplemenation(dataSource: dataSource);
});

final getGeneratedQrHistoryUseCase = Provider<GetGeneratedQrHistoryUseCase>((
  ref,
) {
  final repository = ref.watch(createdQrsRepositoryProvider);
  return GetGeneratedQrHistoryUseCase(repository: repository);
});

final saveGeneratedQrUseCase = Provider<SaveGeneratedQrUseCase>((ref) {
  final repository = ref.watch(createdQrsRepositoryProvider);
  return SaveGeneratedQrUseCase(repository: repository);
});

final clearGeneratedQrUseCase = Provider<ClearGenerateQrHistoryUseCase>((ref) {
  final repository = ref.watch(createdQrsRepositoryProvider);
  return ClearGenerateQrHistoryUseCase(repository: repository);
});
