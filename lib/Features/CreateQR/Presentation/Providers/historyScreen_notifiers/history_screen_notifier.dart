import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proscan/Features/CreateQR/Domain/Entity/entity.dart';
import 'package:proscan/Features/CreateQR/Presentation/Providers/createQrsFeature_Providers/providers.dart';
import 'package:proscan/Features/CreateQR/Presentation/Providers/historyScreen_notifiers/history_state.dart';

final createdHistoryScreenProvider =
    AsyncNotifierProvider<HistoryScreenNotifier, List<HistoryScreenState>>(() {
      return HistoryScreenNotifier();
    });

class HistoryScreenNotifier extends AsyncNotifier<List<HistoryScreenState>> {
  @override
  Future<List<HistoryScreenState>> build() async {
    final getGeneratedHistoryUsecase = ref.watch(getGeneratedQrHistoryUseCase);
    final List<GeneratedQrHistoryEntity> historyList =
        await getGeneratedHistoryUsecase();
    final List<HistoryScreenState> history = historyList.map((entity) {
      return HistoryScreenState(
        id: entity.id,
        payload: entity.payLoad,
        contentType: entity.qrType,
        timeStamp: entity.timeStamp,
      );
    }).toList();
    return history;
  }

  Future<void> clearAllCreatedQrsHistory() async {
    final clearHistoryUseCase = ref.read(clearGeneratedQrUseCase);
    state = await AsyncValue.guard(() async {
      await clearHistoryUseCase();
      return List<HistoryScreenState>.empty();
    });
  }
}
