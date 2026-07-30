import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanFromGallery {
  static Future<String?> scanImageFromGallery(
    MobileScannerController mobilescannerController,
  ) async {
    String? decoded;
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        return null;
      }
      final BarcodeCapture? capture = await mobilescannerController
          .analyzeImage(image.path);
      if (capture != null && capture.barcodes.isNotEmpty) {
        decoded = capture.barcodes.first.rawValue;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Gallery scan Failed: $e');
    }
    return decoded;
  }
}
