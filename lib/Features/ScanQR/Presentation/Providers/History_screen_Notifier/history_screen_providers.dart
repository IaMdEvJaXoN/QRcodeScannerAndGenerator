import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proscan/Features/ScanQR/Domain/Entity/entity.dart';
import 'package:proscan/Features/ScanQR/Presentation/Providers/History_screen_Notifier/scan_history_state.dart';
import 'package:proscan/Features/ScanQR/Presentation/Providers/ScanQRFeature_Providers/providers.dart';

//Async notifier doesn't need passing ref,it has builtin access to ref.
final scannerHistoryScreenProvider =
    AsyncNotifierProvider<HistoryScreenNotifier, List<ScanHistoryState>>(() {
      return HistoryScreenNotifier();
    });

class HistoryScreenNotifier extends AsyncNotifier<List<ScanHistoryState>> {
  @override
  Future<List<ScanHistoryState>> build() async {
   
    final getHistoryUsecase = ref.watch(getHistoryUseCaseProvider);
    final List<ScanHistoryEntity> historyList = await getHistoryUsecase();
    final List<ScanHistoryState> history = historyList.map((entity) {
      return ScanHistoryState(
        id: entity.id,
        payload: entity.payLoad,
        contentType: entity.contentType,
        timeStamp: entity.timeStamp,
      );
    }).toList();
    return history;
  }

  //State is wrapped in AsyncValue which manages data,loading and errors
  Future<void> clearHistory() async {
    final clearHistoryUsecase = ref.read(clearHistoryUseCaseProvider);
    state = await AsyncValue.guard(() async {
      await clearHistoryUsecase();
      return List<
        ScanHistoryState
      >.empty(); //Manually without asyncValue.Guard ------ state=const AsyncData([])
    });
  }
}
