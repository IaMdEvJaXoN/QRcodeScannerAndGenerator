import 'package:flutter/material.dart';
import 'package:proscan/Core/Themes/app_themes.dart';

class ScannerOverlay extends StatefulWidget {
  const ScannerOverlay({super.key});

  @override
  State<ScannerOverlay> createState() => _ScannerOverlayState();
}

class _ScannerOverlayState extends State<ScannerOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Alignment> _scanLineAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync:
          this, //Prevents wastage of resources especially when the widget is not visible.
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scanLineAnimation = Tween<Alignment>(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final frameSize = size.width * 0.7;

    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(size.width, size.height),
          painter: _ScannerCutoutPainter(frameSize: frameSize),
        ),
        SizedBox(
          width: frameSize,
          height: frameSize,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: _CornerBracket(alignment: Alignment.topLeft),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: _CornerBracket(alignment: Alignment.topRight),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: _CornerBracket(alignment: Alignment.bottomLeft),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: _CornerBracket(alignment: Alignment.bottomRight),
              ),
              AnimatedBuilder(
                animation: _scanLineAnimation,
                builder: (context, child) {
                  return Align(
                    alignment: _scanLineAnimation.value,
                    child: child,
                  );
                },
                child: Container(
                  height: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppThemes.primary,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: AppThemes.primary.withValues(alpha: 0.6),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CornerBracket extends StatelessWidget {
  final Alignment alignment;

  const _CornerBracket({required this.alignment});

  @override
  Widget build(BuildContext context) {
    final isTop =
        alignment == Alignment.topLeft || alignment == Alignment.topRight;
    final isLeft =
        alignment == Alignment.topLeft || alignment == Alignment.bottomLeft;

    return SizedBox(
      width: 32,
      height: 32,
      child: Stack(
        children: [
          Positioned(
            top: isTop ? 0 : null,
            bottom: isTop ? null : 0,
            left: isLeft ? 0 : null,
            right: isLeft ? null : 0,
            child: Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: AppThemes.primary,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: AppThemes.primary.withValues(alpha: 0.6),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: isTop ? 0 : null,
            bottom: isTop ? null : 0,
            left: isLeft ? 0 : null,
            right: isLeft ? null : 0,
            child: Container(
              width: 4,
              height: 32,
              decoration: BoxDecoration(
                color: AppThemes.primary,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: AppThemes.primary.withValues(alpha: 0.6),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScannerCutoutPainter extends CustomPainter {
  final double frameSize;

  _ScannerCutoutPainter({required this.frameSize});

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.6);

    final cutoutRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: frameSize,
      height: frameSize,
    );

    final cutoutRRect = RRect.fromRectAndRadius(
      cutoutRect,
      const Radius.circular(24),
    );

    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(cutoutRRect)
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant _ScannerCutoutPainter oldDelegate) {
    return oldDelegate.frameSize != frameSize;
  }
}
