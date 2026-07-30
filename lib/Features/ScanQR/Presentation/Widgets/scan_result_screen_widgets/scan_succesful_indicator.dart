import 'package:flutter/material.dart';
import 'package:proscan/Core/Themes/app_themes.dart';

class ScanSuccessIndicator extends StatelessWidget {
  const ScanSuccessIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Icon(Icons.check_circle_rounded, color: AppThemes.primary, size: 28),
        const SizedBox(height: 8),
        Text(
          'SCANNED SUCCESSFULLY',
          style: textTheme.labelMedium?.copyWith(
            color: AppThemes.secondaryText,
            letterSpacing: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
