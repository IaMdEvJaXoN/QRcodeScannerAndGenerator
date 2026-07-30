import 'package:flutter/material.dart';
import 'package:proscan/Core/Themes/app_themes.dart';

class ContentTypeBadge extends StatelessWidget {
  final String contentType;
  final IconData contentTypeIcon;

  const ContentTypeBadge({
    super.key,
    required this.contentType,
    required this.contentTypeIcon,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: AppThemes.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(contentTypeIcon, color: AppThemes.primary, size: 20),
            const SizedBox(width: 8),
            Text(
              contentType,
              style: textTheme.titleMedium?.copyWith(
                color: AppThemes.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
