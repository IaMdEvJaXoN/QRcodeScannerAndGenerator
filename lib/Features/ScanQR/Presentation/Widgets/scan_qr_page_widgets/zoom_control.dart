import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proscan/Features/ScanQR/Presentation/Providers/zoom_control_provider.dart';

class ZoomControl extends ConsumerStatefulWidget {
  const ZoomControl({super.key});

  @override
  ConsumerState<ZoomControl> createState() => _ZoomControlState();
}

class _ZoomControlState extends ConsumerState<ZoomControl> {
  @override
  Widget build(BuildContext context) {
    final currentSliderPosition = ref.watch(zoomControlProvider);
    return ClipRRect(
      //For rounded corners
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        //Applies a filter to a widget on the background.
        filter: ImageFilter.blur(
          sigmaX: 12,
          sigmaY: 12,
        ), //The higher the sigma the blurrier it becomes.
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            children: [
              const Icon(Icons.remove_rounded, color: Colors.white, size: 20),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.white.withValues(alpha: 0.3),
                    thumbColor: Colors.white,
                    overlayColor: Colors.white.withValues(alpha: 0.15),
                    trackHeight: 2,
                  ),
                  child: Slider(
                    value: currentSliderPosition,
                    onChanged: (newSliderPosition) {
                      ref
                          .read(zoomControlProvider.notifier)
                          .updateSliderPosition(newSliderPosition);
                    },
                  ), //Value ranges between 0 and 1.0s
                ),
              ),
              const Icon(Icons.add_rounded, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
