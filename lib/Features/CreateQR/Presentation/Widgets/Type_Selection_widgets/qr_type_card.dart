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
  bool _isPressed = false;
  void _navigateToGenerateQrScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            GenerateQrScreen(
              pageTitle: "Generate ${widget.title} QR",
              formType: MapTitleToFormtype.mapTitleToFormType(widget.title),
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn,
          );
          return FadeTransition(
            opacity: curved,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.9, end: 1.0).animate(curved),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 1500),
      ),
      // MaterialPageRoute(
      //   builder: (context) => GenerateQrScreen(
      //     pageTitle: "Generate ${widget.title} QR",
      //     formType: MapTitleToFormtype.mapTitleToFormType(widget.title),
      //   ),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AnimatedScale(
      duration: Duration(milliseconds: 100),
      scale: _isPressed ? 0.8 : 1.0,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapCancel: () => setState(() => _isPressed = false),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTap: () {
            _navigateToGenerateQrScreen(context);
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
      ),
    );
  }
}
