import 'dart:ui';
import 'package:flutter/material.dart';

class ScannerTopBar extends StatelessWidget {
  final bool isTorchOn;
  final VoidCallback onGalleryPressed;
  final VoidCallback onTorchPressed;
  final VoidCallback onManualEntryPressed;
  const ScannerTopBar({
    super.key,
    required this.isTorchOn,
    required this.onGalleryPressed,
    required this.onTorchPressed,
    required this.onManualEntryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _GlassIconButton(
            icon: Icons.photo_library_rounded,
            onPressed: () {
              onGalleryPressed();
            },
          ),
          Text(
            'ProScan',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              _GlassIconButton(
                icon: isTorchOn
                    ? Icons.flash_on_rounded
                    : Icons.flash_off_rounded,
                onPressed: () {
                  onTorchPressed();
                },
              ),
              // const SizedBox(width: 12),
              // _GlassIconButton(
              //   icon: Icons.keyboard_alt_outlined,
              //   onPressed: () {
              //     onManualEntryPressed();
              //   },
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _GlassIconButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(icon, color: Colors.white, size: 22),
          ),
        ),
      ),
    );
  }
}
