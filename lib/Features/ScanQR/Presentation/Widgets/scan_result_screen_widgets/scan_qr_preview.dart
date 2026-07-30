import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:proscan/Core/Themes/app_themes.dart';

class ScanQrPreviewCard extends StatelessWidget {
  final String data;

  const ScanQrPreviewCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppThemes.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppThemes.primary, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: AppThemes.primaryText.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: QrImageView(
          data: data,
          size: 180,
          backgroundColor: AppThemes.surface,
        ),
      ),
    );
  }
}
