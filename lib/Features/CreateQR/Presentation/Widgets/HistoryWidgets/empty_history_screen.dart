import 'package:flutter/material.dart';
import 'package:proscan/Core/Themes/app_themes.dart';

class GeneratedHistoryEmptyState extends StatelessWidget {
  const GeneratedHistoryEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.qr_code_2_rounded, size: 96, color: AppThemes.outline),
          const SizedBox(height: 24),
          Text(
            'No Generated QR Codes Yet',
            style: textTheme.headlineMedium?.copyWith(
              color: AppThemes.primaryText,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first QR code and it will appear here for quick access.',
            style: textTheme.bodyMedium?.copyWith(
              color: AppThemes.secondaryText,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton(onPressed: () {}, child: const Text('Create QR Code')),
        ],
      ),
    );
  }
}
