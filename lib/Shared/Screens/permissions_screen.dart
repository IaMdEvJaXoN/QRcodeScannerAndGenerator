import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proscan/Core/Themes/app_themes.dart';
import 'package:proscan/Core/Utils/scanQr_utils/camera_permission_check.dart';

class CameraPermissionScreen extends StatefulWidget {
  final VoidCallback onPermissionGranted;

  const CameraPermissionScreen({super.key, required this.onPermissionGranted});

  @override
  State<CameraPermissionScreen> createState() => _CameraPermissionScreenState();
}

class _CameraPermissionScreenState extends State<CameraPermissionScreen> {
  bool _isPermanentlyDenied = false;

  Future<void> _handleAllowPressed() async {
    final status = await CameraPermissionCheck.request();

    if (status.isGranted) {
      widget.onPermissionGranted();
    } else if (status.isPermanentlyDenied) {
      setState(() => _isPermanentlyDenied = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppThemes.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: AppThemes.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt_rounded,
                  color: AppThemes.primary,
                  size: 44,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Camera Access Needed',
                style: textTheme.headlineMedium?.copyWith(
                  color: AppThemes.primaryText,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'ProScan needs access to your camera to scan QR codes. Your camera is only used while scanning.',
                style: textTheme.bodyMedium?.copyWith(
                  color: AppThemes.secondaryText,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              if (_isPermanentlyDenied) ...[
                Text(
                  'Camera permission was denied. Please enable it from your device settings to continue.',
                  style: textTheme.bodyMedium?.copyWith(color: AppThemes.error),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => CameraPermissionCheck.openSettings(),
                  child: const Text('Open Settings'),
                ),
              ] else
                FilledButton(
                  onPressed: _handleAllowPressed,
                  child: const Text('Allow Camera Access'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
