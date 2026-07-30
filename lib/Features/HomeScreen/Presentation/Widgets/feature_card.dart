import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proscan/Core/Routing/routes.dart';
import 'package:proscan/Core/Themes/app_themes.dart';
import 'package:proscan/Core/Utils/shared_utils/navigation_bar_index.dart';
import 'package:proscan/Shared/Providers/BottomNav_selectedIndexProvider/selected_index_provider.dart';

class FeatureCard extends ConsumerStatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String screenName;
  final IconData trailingIcon;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.screenName,
    this.trailingIcon = Icons.chevron_right_rounded,
  });

  @override
  ConsumerState<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends ConsumerState<FeatureCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final navigationIndexReader = ref.read(selectedIndexProvider.notifier);
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          final destination = widget.screenName;
          if (destination == AppRoutes.scanQr) {
            navigationIndexReader.updateIndex(NavigationBarIndex.scanner);
          } else if (destination == AppRoutes.qrTypeSelect) {
            navigationIndexReader.updateIndex(NavigationBarIndex.qrTypeGenerator);
          } else if (destination == AppRoutes.settings) {
            navigationIndexReader.updateIndex(NavigationBarIndex.settings);
          } else {
            return;
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppThemes.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(widget.icon, color: AppThemes.primary, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: textTheme.titleMedium?.copyWith(
                        color: AppThemes.primaryText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.subtitle,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppThemes.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                widget.trailingIcon,
                color: AppThemes.secondaryText,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
