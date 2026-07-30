import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proscan/Core/Themes/app_themes.dart';
import 'package:share_plus/share_plus.dart';

class ScanHistoryCard extends ConsumerStatefulWidget {
  final IconData leadingIcon;
  final String title;
  final String contentType;
  final IconData contentTypeIcon;
  final String timestamp;
  final IconData trailingIcon;

  const ScanHistoryCard({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.contentType,
    required this.contentTypeIcon,
    required this.timestamp,
    this.trailingIcon = Icons.chevron_right_rounded,
  });

  @override
  ConsumerState<ScanHistoryCard> createState() => _ScanHistoryCardState();
}

class _ScanHistoryCardState extends ConsumerState<ScanHistoryCard> {
  void _showScanHistDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        final dialogTextTheme = Theme.of(dialogContext).textTheme;

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(widget.contentTypeIcon, color: AppThemes.primary, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.contentType,
                  style: dialogTextTheme.titleMedium?.copyWith(
                    color: AppThemes.primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CONTENT',
                style: dialogTextTheme.labelMedium?.copyWith(
                  color: AppThemes.secondaryText,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppThemes.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SelectableText(
                  widget.title,
                  style: dialogTextTheme.bodyMedium?.copyWith(
                    color: AppThemes.primaryText,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 14,
                    color: AppThemes.secondaryText,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Scanned on ${widget.timestamp}',
                      style: dialogTextTheme.bodySmall?.copyWith(
                        color: AppThemes.secondaryText,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            Center(
              child: TextButton.icon(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: widget.title));
                  if (!dialogContext.mounted) {
                    return;
                  }
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    const SnackBar(
                      content: Text('Copied to clipboard'),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 3),
                    ),
                  );
                },
                icon: const Icon(Icons.copy_rounded, size: 18),
                label: const Text('Copy'),
              ),
            ),
            Center(
              child: TextButton.icon(
                onPressed: () async {
                  await SharePlus.instance.share(ShareParams(text: widget.title));
                },
                icon: const Icon(Icons.share_rounded, size: 18),
                label: const Text('Share'),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Close'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          _showScanHistDetailsDialog(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppThemes.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.leadingIcon,
                  color: AppThemes.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppThemes.primaryText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppThemes.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                widget.contentTypeIcon,
                                size: 14,
                                color: AppThemes.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.contentType,
                                style: textTheme.labelMedium?.copyWith(
                                  color: AppThemes.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          widget.timestamp,
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppThemes.secondaryText,
                          ),
                        ),
                      ],
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
