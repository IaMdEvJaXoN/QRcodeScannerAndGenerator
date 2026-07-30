import 'package:flutter/material.dart';
import 'package:proscan/Core/Themes/app_themes.dart';

class SettingsSectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSectionCard({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: textTheme.labelMedium?.copyWith(
            color: AppThemes.primary,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              children: List.generate(children.length * 2 - 1, (index) {
                if (index.isOdd) {
                  return Divider(
                    color: AppThemes.outline.withValues(alpha: 0.5),
                    height: 1,
                  );
                }
                return children[index ~/ 2];
              }),
            ),
          ),
        ),
      ],
    );
  }
}
