import 'package:permission_handler/permission_handler.dart';

class CameraPermissionCheck {
  CameraPermissionCheck._();
  static Future<PermissionStatus> checkStatus() async {
    return await Permission.camera.status;
  }

  static Future<PermissionStatus> request() async {
    return await Permission.camera.request();
  }

  static Future<bool> openSettings() async {
    return await openAppSettings();
  }
}
