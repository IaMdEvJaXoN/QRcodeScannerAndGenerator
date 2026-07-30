import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proscan/Core/Themes/app_themes.dart';
import 'package:proscan/Core/Utils/createQr_utils/qr_encoder.dart';
import 'package:proscan/Features/CreateQR/Presentation/Providers/generateQrsScreen_notifiers/save_qr_notifier.dart';
import 'package:proscan/Features/CreateQR/Presentation/Widgets/QR_generator_widgets/qr_input_form.dart';
import 'package:proscan/Features/CreateQR/Presentation/Widgets/QR_generator_widgets/qr_preview_card.dart';
import 'package:proscan/Features/CreateQR/Presentation/Widgets/step_indicator.dart';
import 'package:share_plus/share_plus.dart';

class GenerateQrScreen extends ConsumerStatefulWidget {
  final String pageTitle;
  final QrFormType formType;

  const GenerateQrScreen({
    super.key,
    required this.pageTitle,
    required this.formType,
  });

  @override
  ConsumerState<GenerateQrScreen> createState() => _GenerateQrScreenState();
}

class _GenerateQrScreenState extends ConsumerState<GenerateQrScreen> {
  Map<String, String> _fieldValues = {};
  String? _generatedContent;

  void _handleGenerate() async {
    final encoded = QrEncoder.encode(widget.formType, _fieldValues);
    if (encoded.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
          content: Text('Please fill in the required fields'),
        ),
      );
      return;
    }
    setState(() => _generatedContent = encoded);
    await _saveCreatedQrCode(encoded);
  }

  Future<void> _saveCreatedQrCode(String encodedData) async {
    final time = DateTime.timestamp().toIso8601String();
    final id = DateTime.now().millisecondsSinceEpoch ~/ 2000;
    final qrinfo = encodedData;
    final typeOfContent = widget.formType.toString();

    await ref
        .read(saveQrProvider.notifier)
        .saveCreatedQr(id, qrinfo, typeOfContent, time);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppThemes.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          widget.pageTitle,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppThemes.primaryText,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info_outline_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const QrGenerationStepIndicator(currentStep: 1),
              const SizedBox(height: 24),
              QrInputForm(
                formType: widget.formType,
                onChanged: (values) => _fieldValues = values,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () {
                  _handleGenerate();
                },
                icon: const Icon(Icons.qr_code_rounded),
                label: const Text('Generate QR'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              if (_generatedContent != null) ...[
                const SizedBox(height: 24),
                QrPreviewCard(data: _generatedContent!),
                const SizedBox(height: 20),
                Text(
                  'Your QR is Ready',
                  style: textTheme.headlineMedium?.copyWith(
                    color: AppThemes.primaryText,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'Generated from\n$_generatedContent',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppThemes.secondaryText,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          await SharePlus.instance.share(
                            ShareParams(text: _generatedContent!),
                          );
                        },
                        icon: const Icon(Icons.share_rounded),
                        label: const Text('Share QR'),
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
                            ClipboardData(text: _generatedContent!),
                          );
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(seconds: 3),
                              content: Text('Copied to clipboard'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.copy_rounded),
                        label: const Text('Copy Original Text'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
