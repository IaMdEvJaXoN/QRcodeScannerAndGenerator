import 'package:flutter/material.dart';
import 'package:proscan/Core/Themes/app_themes.dart';

class ScanInfoCard extends StatelessWidget {
  final String verificationLabel;
  final String decodedContent;
  final String timestamp;

  const ScanInfoCard({
    super.key,
    required this.verificationLabel,
    required this.decodedContent,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Chip(
                label: Text(verificationLabel),
                labelStyle: textTheme.labelMedium?.copyWith(
                  color: AppThemes.primaryText,
                ),
                backgroundColor: AppThemes.primary.withValues(alpha: 0.08),
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppThemes.background,
                borderRadius: BorderRadius.circular(16),
              ),
              child: SelectableText(
                decodedContent,
                style: textTheme.bodyLarge?.copyWith(
                  color: AppThemes.primaryText,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  size: 16,
                  color: AppThemes.secondaryText,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    timestamp,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppThemes.secondaryText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
