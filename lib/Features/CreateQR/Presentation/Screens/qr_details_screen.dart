import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:proscan/Core/Themes/app_themes.dart';
import 'package:proscan/Core/Utils/createQr_utils/save_qr_as_image.dart';
import 'package:proscan/Core/Utils/shared_utils/readable_time_display.dart';
import 'package:proscan/Features/CreateQR/Presentation/Widgets/qr_details_screen/encoded_content_card.dart';
import 'package:proscan/Features/CreateQR/Presentation/Widgets/qr_details_screen/qr_preview_card.dart';
import 'package:share_plus/share_plus.dart';

class GeneratedQrDetailsScreen extends StatefulWidget {
  final String encodedContent;
  final String contentType;
  final IconData contentTypeIcon;
  final String generatedDate;

  const GeneratedQrDetailsScreen({
    super.key,
    required this.encodedContent,
    required this.contentType,
    required this.contentTypeIcon,
    required this.generatedDate,
  });

  @override
  State<GeneratedQrDetailsScreen> createState() =>
      _GeneratedQrDetailsScreenState();
}

class _GeneratedQrDetailsScreenState extends State<GeneratedQrDetailsScreen> {
  final GlobalKey _qrKey = GlobalKey();
  bool isSaving = false;
  Future<void> _saveqQ() async {
    setState(() {
      isSaving = true;
    });
    final success = await QrSaveService.saveCardToGallery(_qrKey);
    setState(() {
      isSaving = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: success
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Lottie.asset(
                      height: 30,
                      width: 30,
                      'assets/success.json',
                      repeat: true,
                    ),
                    SizedBox(width: 12),
                    Text('Image saved to gallery as PNG'),
                  ],
                )
              : Text('Failed to save Qr to gallery'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppThemes.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          'QR Code Details',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppThemes.primaryText,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await SharePlus.instance
                  .share(ShareParams(text: widget.encodedContent))
                  .then((u) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 3),
                        content: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Lottie.asset(
                              'assets/successful.json',
                              repeat: true,
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(width: 12),
                            Text('Shared successfully'),
                          ],
                        ),
                      ),
                    );
                  });
            },
            icon: const Icon(Icons.share_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GeneratedQrPreviewCard(
                data: widget.encodedContent,
                previewKey: _qrKey,
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
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
                        size: 16,
                        color: AppThemes.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        widget.contentType,
                        style: textTheme.labelMedium?.copyWith(
                          color: AppThemes.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              EncodedContentCard(content: widget.encodedContent),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.calendar_today_rounded,
                              color: AppThemes.primary,
                              size: 24,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Generated at',
                              style: textTheme.titleMedium?.copyWith(
                                color: AppThemes.primaryText,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              ReadableTimeDisplay.toReadable(
                                widget.generatedDate,
                              ),
                              style: textTheme.bodyMedium?.copyWith(
                                color: AppThemes.secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.history_rounded,
                              color: AppThemes.primary,
                              size: 24,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Saved in',
                              style: textTheme.titleMedium?.copyWith(
                                color: AppThemes.primaryText,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'History',
                              style: textTheme.bodyMedium?.copyWith(
                                color: AppThemes.secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () async {
                  isSaving ? null : await _saveqQ();
                },
                icon: const Icon(Icons.download_rounded),
                label: const Text('Save Image to Gallery'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await SharePlus.instance.share(
                          ShareParams(text: widget.encodedContent),
                        );
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 3),
                            content: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Lottie.asset(
                                  'assets/successful.json',
                                  repeat: true,
                                  height: 30,
                                  width: 30,
                                ),
                                SizedBox(width: 12),
                                Text('Shared successfully'),
                              ],
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.share_rounded),
                      label: const Text('Share'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await Clipboard.setData(
                          ClipboardData(text: widget.encodedContent),
                        );

                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 3),
                            content: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Lottie.asset(
                                  'assets/successful.json',
                                  repeat: true,
                                  height: 30,
                                  width: 30,
                                ),
                                SizedBox(width: 12),
                                Text('Copied to clipboard'),
                              ],
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy_rounded),
                      label: const Text('Copy Text'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
