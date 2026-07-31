import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proscan/Core/Themes/app_themes.dart';
import 'package:proscan/Features/CreateQR/Presentation/Widgets/Type_Selection_widgets/qr_type_card.dart';
import 'package:proscan/Features/CreateQR/Presentation/Widgets/step_indicator.dart';

class QrTypeSelectionScreen extends StatelessWidget {
  const QrTypeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final qrTypes = <_QrTypeData>[
      _QrTypeData(
        iconWidget: Icon(Icons.language_rounded),
        iconColor: AppThemes.primary,
        iconBackgroundColor: AppThemes.primary.withValues(alpha: 0.1),
        title: 'Website',
      ),
      _QrTypeData(
        iconWidget: Icon(Icons.content_paste_rounded),
        iconColor: AppThemes.primary,
        iconBackgroundColor: AppThemes.primary.withValues(alpha: 0.1),
        title: 'Clipboard',
      ),
      _QrTypeData(
        iconWidget: Icon(Icons.wifi_rounded),
        iconColor: Colors.orange,
        iconBackgroundColor: Colors.orange.withValues(alpha: 0.1),
        title: 'Wi-Fi',
      ),
      _QrTypeData(
        iconWidget: Icon(Icons.notes_rounded),
        iconColor: AppThemes.primary,
        iconBackgroundColor: AppThemes.primary.withValues(alpha: 0.1),
        title: 'Text',
      ),
      _QrTypeData(
        iconWidget: Icon(Icons.email_rounded),
        iconColor: AppThemes.primary,
        iconBackgroundColor: AppThemes.primary.withValues(alpha: 0.1),
        title: 'Email',
      ),
      _QrTypeData(
        iconWidget: Icon(Icons.sms_rounded),
        iconColor: AppThemes.primary,
        iconBackgroundColor: AppThemes.primary.withValues(alpha: 0.1),
        title: 'SMS',
      ),
      _QrTypeData(
        iconWidget: Icon(Icons.call_rounded),
        iconColor: AppThemes.primary,
        iconBackgroundColor: AppThemes.primary.withValues(alpha: 0.1),
        title: 'Phone',
      ),
      _QrTypeData(
        iconWidget: Icon(Icons.contact_page_rounded),
        iconColor: AppThemes.primary,
        iconBackgroundColor: AppThemes.primary.withValues(alpha: 0.1),
        title: 'Contacts',
      ),
      _QrTypeData(
        iconWidget: Icon(Icons.event_rounded),
        iconColor: AppThemes.primary,
        iconBackgroundColor: AppThemes.primary.withValues(alpha: 0.1),
        title: 'Calendar',
      ),
      _QrTypeData(
        iconWidget: Icon(Icons.badge_rounded),
        iconColor: AppThemes.primary,
        iconBackgroundColor: AppThemes.primary.withValues(alpha: 0.1),
        title: 'My Card',
      ),
      _QrTypeData(
        iconWidget: FaIcon(FontAwesomeIcons.paypal),
        iconColor: const Color(0xFF003087),
        iconBackgroundColor: const Color(0xFF003087).withValues(alpha: 0.1),
        title: 'PayPal',
      ),
      _QrTypeData(
        iconWidget: FaIcon(FontAwesomeIcons.facebook),
        iconColor: const Color(0xFF1877F2),
        iconBackgroundColor: const Color(0xFF1877F2).withValues(alpha: 0.1),
        title: 'Facebook',
      ),
      _QrTypeData(
        iconWidget: FaIcon(FontAwesomeIcons.youtube),
        iconColor: const Color(0xFFFF0000),
        iconBackgroundColor: const Color(0xFFFF0000).withValues(alpha: 0.1),
        title: 'YouTube',
      ),
      _QrTypeData(
        iconWidget: FaIcon(FontAwesomeIcons.whatsapp),
        iconColor: const Color(0xFF25D366),
        iconBackgroundColor: const Color(0xFF25D366).withValues(alpha: 0.1),
        title: 'WhatsApp',
      ),
      _QrTypeData(
        iconWidget: FaIcon(FontAwesomeIcons.instagram),
        iconColor: const Color(0xFFE1306C),
        iconBackgroundColor: const Color(0xFFE1306C).withValues(alpha: 0.1),
        title: 'Instagram',
      ),
      _QrTypeData(
        iconWidget: FaIcon(FontAwesomeIcons.xTwitter),
        iconColor: AppThemes.primaryText,
        iconBackgroundColor: AppThemes.primaryText.withValues(alpha: 0.08),
        title: 'X',
      ),
      _QrTypeData(
        iconWidget: FaIcon(FontAwesomeIcons.spotify),
        iconColor: const Color(0xFF1DB954),
        iconBackgroundColor: const Color(0xFF1DB954).withValues(alpha: 0.1),
        title: 'Spotify',
      ),
      _QrTypeData(
        iconWidget: FaIcon(FontAwesomeIcons.viber),
        iconColor: const Color(0xFF7360F2),
        iconBackgroundColor: const Color(0xFF7360F2).withValues(alpha: 0.1),
        title: 'Viber',
      ),
    ];

    return Scaffold(
      //No issue in returning this scaffold because the one in appshell only claims the bottomNavigationBar
      appBar: AppBar(
        title: Text(
          'Create QR Code',
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
              Text(
                "Select what you'd like to generate",
                style: textTheme.headlineMedium?.copyWith(
                  color: AppThemes.primaryText,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Choose the type of QR code you want to create. The selected type will open a dedicated page where you enter the required information before generating the QR code.',
                style: textTheme.bodyMedium?.copyWith(
                  color: AppThemes.secondaryText,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const QrGenerationStepIndicator(currentStep: 0),
              const SizedBox(height: 24),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: qrTypes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  final type = qrTypes[index];
                  return QrTypeCard(
                    iconWidget: type.iconWidget,
                    iconColor: type.iconColor,
                    iconBackgroundColor: type.iconBackgroundColor,
                    title: type.title,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QrTypeData {
  final Widget iconWidget;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String title;

  _QrTypeData({
    required this.iconWidget,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.title,
  });
}
