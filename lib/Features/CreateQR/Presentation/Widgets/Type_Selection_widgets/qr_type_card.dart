import 'package:flutter/material.dart';
import 'package:proscan/Core/Themes/app_themes.dart';
import 'package:proscan/Core/Utils/createQr_utils/map_title_to_formtype.dart';
import 'package:proscan/Features/CreateQR/Presentation/Screens/generate_qr_screen.dart';

class QrTypeCard extends StatefulWidget {
  final Widget iconWidget;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String title;

  const QrTypeCard({
    super.key,
    required this.iconWidget,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.title,
  });

  @override
  State<QrTypeCard> createState() => _QrTypeCardState();
}

class _QrTypeCardState extends State<QrTypeCard> {
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
              builder: (context) => GenerateQrScreen(
                pageTitle: "Generate ${widget.title} QR",
                formType: MapTitleToFormtype.mapTitleToFormType(widget.title),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: widget.iconBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: IconTheme(
                    data: IconThemeData(color: widget.iconColor, size: 22),
                    child: widget.iconWidget,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.title,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppThemes.primaryText,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
