import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:proscan/Core/Themes/app_themes.dart';

class QrPreviewCard extends StatelessWidget {
  final String data;

  const QrPreviewCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: QrImageView(
            data: data,
            size: 200,
            backgroundColor: AppThemes.surface,
          ),
        ),
      ),
    );
  }
}
