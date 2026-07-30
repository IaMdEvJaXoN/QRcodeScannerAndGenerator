import 'package:flutter/material.dart';
import 'package:proscan/Core/Themes/app_themes.dart';

class QrGenerationStepIndicator extends StatelessWidget {
  final int currentStep;

  const QrGenerationStepIndicator({super.key, required this.currentStep});

  static const _labels = [
    'Choose Type',
    'Enter Details',
    'Generate QR',
    'Save / Share',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_labels.length, (index) {
        return Expanded(
          child: _StepItem(
            label: _labels[index],
            active: index == currentStep,
            isFirst: index == 0,
            isLast: index == _labels.length - 1,
          ),
        );
      }),
    );
  }
}

class _StepItem extends StatelessWidget {
  final String label;
  final bool active;
  final bool isFirst;
  final bool isLast;

  const _StepItem({
    required this.label,
    required this.active,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = active ? AppThemes.primary : AppThemes.outline;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: isFirst
                  ? const SizedBox()
                  : Container(height: 2, color: AppThemes.outline),
            ),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            Expanded(
              child: isLast
                  ? const SizedBox()
                  : Container(height: 2, color: AppThemes.outline),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: textTheme.labelMedium?.copyWith(
            color: active ? AppThemes.primary : AppThemes.secondaryText,
            fontWeight: active ? FontWeight.w600 : FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
