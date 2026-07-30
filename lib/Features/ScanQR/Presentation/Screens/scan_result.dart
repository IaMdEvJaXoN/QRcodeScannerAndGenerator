import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:proscan/Core/Themes/app_themes.dart';
import 'package:proscan/Core/Utils/scanQr_utils/scan_action_launcher.dart';
import 'package:proscan/Features/ScanQR/Presentation/Providers/saveScanNotifier/save_scanned_providers.dart';
import 'package:proscan/Features/ScanQR/Presentation/Widgets/scan_result_screen_widgets/content_type_badge.dart';
import 'package:proscan/Features/ScanQR/Presentation/Widgets/scan_result_screen_widgets/scan_info_card.dart';
import 'package:proscan/Features/ScanQR/Presentation/Widgets/scan_result_screen_widgets/scan_qr_preview.dart';
import 'package:proscan/Features/ScanQR/Presentation/Widgets/scan_result_screen_widgets/scan_status_card.dart';
import 'package:proscan/Features/ScanQR/Presentation/Widgets/scan_result_screen_widgets/scan_succesful_indicator.dart';
import 'package:share_plus/share_plus.dart';

class ScanResultScreen extends ConsumerStatefulWidget {
  final Map<String, String> decodedMap;
  final String decodedContent;
  final String contentType;
  final IconData contentTypeIcon;
  final String verificationLabel;
  final String timestamp;
  final String primaryActionLabel;
  final IconData primaryActionIcon;
  final String statusTitle;
  final String statusDescription;
  final IconData statusIcon;
  final String historyTitle;
  final String historyDescription;
  final IconData historyIcon;

  const ScanResultScreen({
    super.key,
    required this.decodedMap,
    required this.decodedContent,
    required this.contentType,
    required this.contentTypeIcon,
    required this.verificationLabel,
    required this.timestamp,
    required this.primaryActionLabel,
    required this.primaryActionIcon,
    required this.statusTitle,
    required this.statusDescription,
    required this.statusIcon,
    this.historyTitle = 'Saved',
    this.historyDescription = 'Added to History',
    this.historyIcon = Icons.history_rounded,
  });

  @override
  ConsumerState<ScanResultScreen> createState() => _ScanResultScreenState();
}

class _ScanResultScreenState extends ConsumerState<ScanResultScreen> {
  @override
  void initState() {
    super.initState();
    _saveScannedQr();
  }

  Future<void> _saveScannedQr() async {
    final id =
        DateTime.now().millisecondsSinceEpoch ~/
        5000; //consecutive scans within a 5 second window will overwrite each other in memory.
    //A better solution is to use uuid or the millisecondsSinceEpoch without dividing as a string but here i'll leave it as is.
    await ref
        .read(saveScanProvider.notifier)
        .saveScannedQr(
          id,
          widget.decodedMap,
          widget.contentType,
          widget.timestamp,
        );
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
          'Scan Result',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppThemes.primaryText,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final result = await SharePlus.instance.share(
                ShareParams(text: widget.decodedContent),
              );
              if (!context.mounted) {
                return;
              }

              if (result.status == ShareResultStatus.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset(
                          'assets/successful.json',
                          width: 32,
                          height: 32,
                          repeat: true,
                        ),
                        const SizedBox(width: 12),
                        Text('Shared sucessfully'),
                      ],
                    ),
                    duration: const Duration(seconds: 3),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset(
                          'assets/Error animation.json',
                          width: 32,
                          height: 32,
                          repeat: true,
                        ),
                        const SizedBox(width: 12),
                        Text('You did not share anything'),
                      ],
                    ),
                    duration: const Duration(seconds: 3),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                );
              }
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
              ScanQrPreviewCard(data: widget.decodedContent),
              const SizedBox(height: 20),
              const ScanSuccessIndicator(),
              const SizedBox(height: 16),
              ContentTypeBadge(
                contentType: widget.contentType,
                contentTypeIcon: widget.contentTypeIcon,
              ),
              const SizedBox(height: 24),
              ScanInfoCard(
                verificationLabel: widget.verificationLabel,
                decodedContent: widget.decodedContent,
                timestamp: widget.timestamp,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () async {
                  if (widget.statusDescription == 'HTTP') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Lottie.asset(
                              'assets/cant_open_http.json',
                              width: 32,
                              height: 32,
                              repeat: true,
                            ),
                            const SizedBox(width: 12),
                            const Text("Sorry,can't open http links"),
                          ],
                        ),
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    );
                    return;
                  }
                  await ScanActionLauncher.performPrimaryAction(
                    widget.contentType,
                    widget.decodedMap,
                  );
                },
                icon: Icon(widget.primaryActionIcon),
                label: Text(widget.primaryActionLabel),
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
                        await Clipboard.setData(
                          ClipboardData(text: widget.decodedContent),
                        );

                        if (!context.mounted) {
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Lottie.asset(
                                  'assets/success.json',
                                  width: 32,
                                  height: 32,
                                  repeat: true,
                                ),
                                const SizedBox(width: 12),
                                const Text('Copied to clipboard'),
                              ],
                            ),
                            duration: const Duration(seconds: 4),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy_rounded),
                      label: const Text('Copy'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final result = await SharePlus.instance.share(
                          ShareParams(text: widget.decodedContent),
                        );
                        if (!context.mounted) {
                          return;
                        }

                        if (result.status == ShareResultStatus.success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Lottie.asset(
                                    'assets/successful.json',
                                    width: 32,
                                    height: 32,
                                    repeat: true,
                                  ),
                                  const SizedBox(width: 12),
                                  Text('Shared sucessfully'),
                                ],
                              ),
                              duration: const Duration(seconds: 3),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Lottie.asset(
                                    'assets/Error animation.json',
                                    width: 32,
                                    height: 32,
                                    repeat: true,
                                  ),
                                  const SizedBox(width: 12),
                                  Text('You did not share anything'),
                                ],
                              ),
                              duration: const Duration(seconds: 3),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.share_rounded),
                      label: const Text('Share'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ScanStatusCard(
                      icon: widget.statusIcon,
                      title: widget.statusTitle,
                      description: widget.statusDescription,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ScanStatusCard(
                      icon: widget.historyIcon,
                      title: widget.historyTitle,
                      description: widget.historyDescription,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
