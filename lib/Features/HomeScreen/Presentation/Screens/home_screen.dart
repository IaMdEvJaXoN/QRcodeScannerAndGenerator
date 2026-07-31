import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:proscan/Core/Routing/routes.dart';
import 'package:proscan/Core/Themes/app_themes.dart';
import 'package:proscan/Core/Utils/homescreen_utils/greetings_determiner.dart';
import 'package:proscan/Core/Utils/homescreen_utils/homescreen_animation.dart';
import 'package:proscan/Core/Utils/homescreen_utils/homescreen_text.dart';
import 'package:proscan/Core/Utils/scanQr_utils/scan_ui_mapper.dart';
import 'package:proscan/Core/Utils/shared_utils/navigation_bar_index.dart';
import 'package:proscan/Features/HomeScreen/Presentation/Providers/greetings_notifier.dart';
import 'package:proscan/Features/HomeScreen/Presentation/Providers/random_text_timer_provider.dart';
import 'package:proscan/Features/HomeScreen/Presentation/Widgets/feature_card.dart';
import 'package:proscan/Features/HomeScreen/Presentation/Widgets/recent_scan_card.dart';
import 'package:proscan/Features/ScanQR/Presentation/Providers/History_screen_Notifier/history_screen_providers.dart';
import 'package:proscan/Shared/Providers/BottomNav_selectedIndexProvider/selected_index_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String greeting = "";
  String getGreetingToDisplay(DateTime currentTime) {
    return GreetingsDeterminer.determineGreeting(currentTime);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    ref.watch(selectedIndexProvider);
    final scanHistory = ref.watch(scannerHistoryScreenProvider);
    final navigationIndexReader = ref.read(selectedIndexProvider.notifier);
    final currentDateTime = ref.watch(greetingsProvider);
    final currentDateAndTime = ref.watch(randomTextProvider);
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.qr_code_2_rounded,
                  color: AppThemes.primary,
                  size: 28,
                ),
                const SizedBox(width: 8),
                Text(
                  'ProScan',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppThemes.primary,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    navigationIndexReader.updateIndex(
                      NavigationBarIndex.settings,
                    );
                  },
                  icon: const Icon(Icons.settings_outlined),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        getGreetingToDisplay(currentDateTime),
                        style: textTheme.headlineMedium?.copyWith(
                          color: AppThemes.primaryText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        HomescreenText.getText(currentDateAndTime),
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppThemes.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                //const SizedBox(width: 3),
                Expanded(child: HomescreenAnimation.getAnimation(currentDateAndTime)),
              ],
            ),

            const SizedBox(height: 24),
            const FeatureCard(
              icon: Icons.qr_code_scanner_rounded,
              title: 'Scan QR Code',
              subtitle: 'Scan QR codes instantly using your camera.',
              screenName: AppRoutes.scanQr,
            ),
            const SizedBox(height: 16),
            const FeatureCard(
              icon: Icons.qr_code_2_rounded,
              title: 'Create QR Code',
              subtitle:
                  'Generate QR codes for websites, contacts, Wi-Fi, social media and more.',
              screenName: AppRoutes.qrTypeSelect,
            ),
            const SizedBox(height: 16),
            const FeatureCard(
              icon: Icons.settings_rounded,
              title: 'Settings',
              subtitle: 'Customize scanning behaviour and preferences.',
              screenName: AppRoutes.settings,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'RECENT SCANS',
                  style: textTheme.labelMedium?.copyWith(
                    color: AppThemes.secondaryText,
                    letterSpacing: 1,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    navigationIndexReader.updateIndex(
                      NavigationBarIndex.sharedHistoryScreen,
                    );
                  },
                  child: Text(
                    'View All',
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppThemes.primary,
                    ),
                  ),
                ),
              ],
            ),

            scanHistory.when(
              data: (history) {
                if (history.isEmpty) {
                  return Center(
                    child: Lottie.asset(
                      height: 200,
                      width: 200,
                      repeat: true,
                      'assets/empty.json',
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap:
                      true, //The widget to sixe itself to fit its content rather than trying to fit in the space provided by the parent widget.
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: history.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final data = history[index];
                    //Displaying 4 recent scans
                    if (index < history.length && index <= 3) {
                      return RecentScanCard(
                        icon: ScanResultUiMapper.primaryActionIcon(
                          data.contentType,
                        ),
                        title: data.contentType,
                        subtitle: data.payload.values.join(','),
                      );
                    } else {
                      return null;
                    }
                  },
                );
              },
              error: (error, stackTrace) {
                return Center(child: Text('Error : $error'));
              },
              loading: () {
                return Center(
                  child: Lottie.asset(
                    height: 200,
                    width: 200,
                    'assets/loading.json',
                    repeat: true,
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
