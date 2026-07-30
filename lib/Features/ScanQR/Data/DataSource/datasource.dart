import 'package:hive_flutter/hive_flutter.dart';
import 'package:proscan/Features/ScanQR/Data/Model/model.dart';

abstract class ScanLocalDataSource {
  Future<void> saveScan(ScanModel model);
  Future<List<ScanModel>> getSavedModels();
  Future<void> clearScanHistory();
}

class ScanLocalDataSourceImplementation implements ScanLocalDataSource {
  final Box<ScanModel> scanBox;
  ScanLocalDataSourceImplementation({required this.scanBox});

  @override
  Future<void> saveScan(ScanModel model) async {
    await scanBox.put(model.id, model);
  }

  @override
  Future<List<ScanModel>> getSavedModels() async {
    final scans =scanBox.values.toList();
    scans.sort((a, b) => b.id.compareTo(a.id)); //Newest first
    return scans;
  }

  @override
  Future<void> clearScanHistory() async {
    await scanBox.clear();
  }
}
