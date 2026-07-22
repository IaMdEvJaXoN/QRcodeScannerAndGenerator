import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:proscan/Core/Themes/app_themes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  Future<void> _navigateToNextPage() async {
    Future.delayed(const Duration(seconds: 4), () {
      /////////////////////////////////
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppThemes.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'PROSCAN',
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 4,
                  color: AppThemes.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Icon(
                Icons.qr_code_2_rounded,
                size: 140,
                color: AppThemes.primaryText,
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'QR Scanner & Creator',
                  style: textTheme.headlineLarge?.copyWith(
                    color: AppThemes.primaryText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'SCAN • GENERATE • SHARE',
                style: textTheme.labelMedium?.copyWith(
                  letterSpacing: 2,
                  color: AppThemes.secondaryText,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 64),
              Align(
                alignment: Alignment.bottomCenter,
                child: SpinKitDancingSquare(
                  duration: const Duration(milliseconds: 2000),
                  color: AppThemes.primaryText,
                  size: 100.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
