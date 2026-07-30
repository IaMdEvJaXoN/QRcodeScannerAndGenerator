import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proscan/Features/ScanQR/Domain/Entity/entity.dart';
import 'package:proscan/Features/ScanQR/Presentation/Providers/History_screen_Notifier/history_screen_providers.dart';
import 'package:proscan/Features/ScanQR/Presentation/Providers/ScanQRFeature_Providers/providers.dart';
import 'package:proscan/Features/ScanQR/Presentation/Providers/saveScanNotifier/save_scan_state.dart';

final saveScanProvider = NotifierProvider<SaveScanNotifier, SaveScanState>(() {
  return SaveScanNotifier();
});

class SaveScanNotifier extends Notifier<SaveScanState> {
  @override
  SaveScanState build() {
    return SaveScanState(id: 0, payload: {}, contentType: "", timeStamp: "");
  }

  Future<void> saveScannedQr(
    int idNumber,
    Map<String, String> qrInfo,
    String typeOfContent,
    String time,
  ) async {
    ScanHistoryEntity entity = ScanHistoryEntity(
      id: idNumber,
      payLoad: qrInfo,
      contentType: typeOfContent,
      timeStamp: time,
    );
    final saveScanusecase = ref.read(saveScanUseCasePovider);
    await saveScanusecase(entity);
    ref.invalidate(scannerHistoryScreenProvider);
  }
}
