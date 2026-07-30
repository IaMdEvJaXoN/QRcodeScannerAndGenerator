import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proscan/Core/Utils/shared_utils/adapter_names.dart';
import 'package:proscan/Features/ScanQR/Data/DataSource/datasource.dart';
import 'package:proscan/Features/ScanQR/Data/Model/model.dart';
import 'package:proscan/Features/ScanQR/Data/RepositoryImplementation/repo_impl.dart';
import 'package:proscan/Features/ScanQR/Domain/RepositoryContract/scanner_contracts.dart';
import 'package:proscan/Features/ScanQR/Domain/UseCases/use_cases.dart';

final openedBoxProvider = Provider<Box<ScanModel>>((_) {
  return Hive.box<ScanModel>(AdapterNames.scanHistoryBoxName);
});

final dataSourceProvider = Provider((ref) {
  final openedBox = ref.watch(openedBoxProvider);
  return ScanLocalDataSourceImplementation(scanBox: openedBox);
});

final repositoryProvider = Provider<ScannerContracts>((ref) {
  final dataSource = ref.watch(dataSourceProvider);
  return RepoImpl(datasource: dataSource);
});

final getHistoryUseCaseProvider = Provider<GetHistoryUseCase>((ref) {
  final repository = ref.watch(repositoryProvider);
  return GetHistoryUseCase(repository: repository);
});

final saveScanUseCasePovider = Provider<SaveScanUseCase>((ref) {
  final repository = ref.watch(repositoryProvider);
  return SaveScanUseCase(repository: repository);
});

final clearHistoryUseCaseProvider = Provider<ClearHistoryUseCase>((ref) {
  final repository = ref.watch(repositoryProvider);
  return ClearHistoryUseCase(repository: repository);
});
