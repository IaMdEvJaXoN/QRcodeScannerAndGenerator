import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proscan/Core/Themes/app_themes.dart';
import 'package:proscan/Features/CreateQR/Presentation/Providers/historyScreen_notifiers/history_screen_notifier.dart';
import 'package:proscan/Features/CreateQR/Presentation/Screens/history.dart';
import 'package:proscan/Features/ScanQR/Presentation/Providers/History_screen_Notifier/history_screen_providers.dart';
import 'package:proscan/Features/ScanQR/Presentation/Screens/history_screen.dart';
import 'package:proscan/Shared/Providers/shared_history_screen_provider/shared_history_provider.dart';

class SharedHistoryScreen extends ConsumerStatefulWidget {
  const SharedHistoryScreen({super.key});

  @override
  ConsumerState<SharedHistoryScreen> createState() =>
      _SharedHistoryScreenState();
}

class _SharedHistoryScreenState extends ConsumerState<SharedHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final isScanSelected = ref.watch(sharedHistoryScreenProvider);

    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppThemes.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppThemes.background,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              floating: true,
              pinned: true,
              title: Center(
                child: Text(
                  'History',
                  style: textTheme.headlineMedium?.copyWith(
                    color: AppThemes.primaryText,
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (isScanSelected) {
                      await ref
                          .read(scannerHistoryScreenProvider.notifier)
                          .clearHistory();
                    } else {
                      await ref
                          .read(createdHistoryScreenProvider.notifier)
                          .clearAllCreatedQrsHistory();
                    }
                  },
                  child: const Text('Clear All'),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: FilledButton.icon(
                        onPressed: () {
                          ref
                              .read(sharedHistoryScreenProvider.notifier)
                              .toggleHistoryScreenIndex(0);
                        },
                        label: const Text('Scan'),
                        icon: const Icon(Icons.qr_code_scanner_outlined),
                      ),
                    ),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          ref
                              .read(sharedHistoryScreenProvider.notifier)
                              .toggleHistoryScreenIndex(1);
                        },
                        label: const Text('Create'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Scan and history screens.
            isScanSelected
                ? const ScanHistoryScreen()
                : const GeneratedHistoryScreen(),
          ],
        ),
      ),
    );
  }
}
