import 'package:flutter/material.dart';
import 'package:proscan/Core/Themes/app_themes.dart';

class EncodedContentCard extends StatelessWidget {
  final String content;

  const EncodedContentCard({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ENCODED CONTENT',
          style: textTheme.labelMedium?.copyWith(
            color: AppThemes.secondaryText,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          color: AppThemes.background,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SelectableText(
              content,
              style: textTheme.bodyLarge?.copyWith(
                color: AppThemes.primaryText,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
