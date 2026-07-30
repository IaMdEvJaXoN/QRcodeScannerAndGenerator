import 'package:flutter/material.dart';
import 'package:proscan/Core/Themes/app_themes.dart';

class ApplicationLogoCard extends StatelessWidget {
  const ApplicationLogoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppThemes.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(
            Icons.qr_code_2_rounded,
            color: AppThemes.primary,
            size: 32,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'ProScan',
          style: textTheme.titleMedium?.copyWith(
            color: AppThemes.primaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Built with Flutter',
          style: textTheme.bodyMedium?.copyWith(color: AppThemes.secondaryText),
        ),
        const SizedBox(height: 2),
        Text(
          'Version 1.0.0',
          style: textTheme.bodySmall?.copyWith(color: AppThemes.secondaryText),
        ),
      ],
    );
  }
}
