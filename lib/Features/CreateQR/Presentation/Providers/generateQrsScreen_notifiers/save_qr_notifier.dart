import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proscan/Features/CreateQR/Domain/Entity/entity.dart';
import 'package:proscan/Features/CreateQR/Presentation/Providers/createQrsFeature_Providers/providers.dart';
import 'package:proscan/Features/CreateQR/Presentation/Providers/generateQrsScreen_notifiers/savecreatedqr_state.dart';
import 'package:proscan/Features/CreateQR/Presentation/Providers/historyScreen_notifiers/history_screen_notifier.dart';

final saveQrProvider = NotifierProvider<SaveQrNotifier, QrState>(() {
  return SaveQrNotifier();
});

class SaveQrNotifier extends Notifier<QrState> {
  @override
  QrState build() {
    return QrState(id: 0, payload: "", contentType: "", timesStamp: "");
  }

  Future<void> saveCreatedQr(
    int id,
    String qrinfo,
    String typeOfContent,
    String time,
  ) async {
    GeneratedQrHistoryEntity entity = GeneratedQrHistoryEntity(
      id: id,
      payLoad: qrinfo,
      qrType: typeOfContent,
      timeStamp: time,
    );
    final saveQrUseCase = ref.read(saveGeneratedQrUseCase);
    await saveQrUseCase(entity);
    ref.invalidate(createdHistoryScreenProvider);
  }
}
