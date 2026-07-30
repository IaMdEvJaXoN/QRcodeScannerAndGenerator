import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:proscan/Core/Themes/app_themes.dart';

class GeneratedQrPreviewCard extends StatelessWidget {
  final String data;
  final GlobalKey previewKey;

  const GeneratedQrPreviewCard({
    super.key,
    required this.data,
    required this.previewKey,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: previewKey,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppThemes.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppThemes.outline, width: 1),
          boxShadow: [
            BoxShadow(
              color: AppThemes.primaryText.withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: QrImageView(
            data: data,
            size: 220,
            backgroundColor: AppThemes.surface,
          ),
        ),
      ),
    );
  }
}
