import 'package:hive_flutter/adapters.dart';
import 'package:proscan/Features/CreateQR/Data/Models/model.dart';

abstract class GeneratedDataSource {
  Future<void> saveGeneratedQrData(GeneratedQrModel model);
  Future<List<GeneratedQrModel>> getGeneratedHistory();
  Future<void> clearGeneratedHistory();
}

class GeneratedDataSourceImplementation implements GeneratedDataSource {
  final Box<GeneratedQrModel> generatedQrBox;
  GeneratedDataSourceImplementation({required this.generatedQrBox});
  @override
  Future<void> saveGeneratedQrData(GeneratedQrModel model) async {
    await generatedQrBox.put(model.id, model);
  }

  @override
  Future<List<GeneratedQrModel>> getGeneratedHistory() async {
    final generatedQrs = generatedQrBox.values.toList();
    generatedQrs.sort((a, b) => b.id.compareTo(a.id));
    return generatedQrs;
  }

  @override
  Future<void> clearGeneratedHistory() async {
    await generatedQrBox.clear();
  }
}
