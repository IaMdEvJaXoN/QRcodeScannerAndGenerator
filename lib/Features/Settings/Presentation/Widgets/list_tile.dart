import 'package:flutter/material.dart';
import 'package:proscan/Core/Themes/app_themes.dart';

class SettingsListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingsListTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      leading: Icon(leadingIcon, color: AppThemes.primary, size: 24),
      title: Text(
        title,
        style: textTheme.bodyLarge?.copyWith(
          color: AppThemes.primaryText,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: textTheme.bodyMedium?.copyWith(
                color: AppThemes.secondaryText,
              ),
            )
          : null,
      trailing: trailing,
    );
  }
}
