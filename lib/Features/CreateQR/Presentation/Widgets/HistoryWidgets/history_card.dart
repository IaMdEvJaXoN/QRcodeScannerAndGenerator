import 'package:flutter/material.dart';
import 'package:proscan/Core/Utils/shared_utils/readable_time_display.dart';
import 'package:proscan/Features/CreateQR/Presentation/Screens/qr_details_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:proscan/Core/Themes/app_themes.dart';

class GeneratedHistoryCard extends StatefulWidget {
  final String qrThumbnail;
  final String title;
  final String contentType;
  final IconData contentTypeIcon;
  final String timestamp;
  final IconData trailingIcon;

  const GeneratedHistoryCard({
    super.key,
    required this.qrThumbnail,
    required this.title,
    required this.contentType,
    required this.contentTypeIcon,
    required this.timestamp,
    this.trailingIcon = Icons.chevron_right_rounded,
  });

  @override
  State<GeneratedHistoryCard> createState() => _GeneratedHistoryCardState();
}

class _GeneratedHistoryCardState extends State<GeneratedHistoryCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GeneratedQrDetailsScreen(
                encodedContent: widget.qrThumbnail,
                contentType: widget.contentType,
                contentTypeIcon: widget.contentTypeIcon,
                generatedDate: widget.timestamp,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 64,
                height: 64,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppThemes.background,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppThemes.outline, width: 1),
                ),
                child: QrImageView(
                  data: widget.qrThumbnail,
                  backgroundColor: AppThemes.background,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(height: 8),
                    Text(
                      widget.title,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppThemes.primaryText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ReadableTimeDisplay.toReadable(widget.timestamp),
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
