import 'package:flutter/material.dart';
import 'package:proscan/Core/Themes/app_themes.dart';

class GeneratedHistorySearchBar extends StatelessWidget {
  const GeneratedHistorySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppThemes.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: AppThemes.secondaryText),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search generated codes...',
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppThemes.secondaryText,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
