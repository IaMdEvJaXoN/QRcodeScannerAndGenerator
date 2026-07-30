import 'package:flutter/material.dart';
import 'package:proscan/Core/Themes/app_themes.dart';

class ScanStatusCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const ScanStatusCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppThemes.primary, size: 24),
            const SizedBox(height: 8),
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                color: AppThemes.primaryText,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              description,
              style: textTheme.bodyMedium?.copyWith(
                color: AppThemes.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
