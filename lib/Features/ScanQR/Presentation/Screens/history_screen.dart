import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:proscan/Core/Themes/app_themes.dart';
import 'package:proscan/Core/Utils/scanQr_utils/scan_ui_mapper.dart';
import 'package:proscan/Features/ScanQR/Presentation/Providers/History_screen_Notifier/history_screen_providers.dart';
import 'package:proscan/Features/ScanQR/Presentation/Widgets/history_widgets/historysearchbar.dart';
import 'package:proscan/Features/ScanQR/Presentation/Widgets/history_widgets/scanhistorycard.dart';

class ScanHistoryScreen extends ConsumerStatefulWidget {
  const ScanHistoryScreen({super.key});

  @override
  ConsumerState<ScanHistoryScreen> createState() => _ScanHistoryScreenState();
}

class _ScanHistoryScreenState extends ConsumerState<ScanHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final scannerHistoryListAsync = ref.watch(scannerHistoryScreenProvider);
    return SliverMainAxisGroup(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _PinnedSearchBarDelegate(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: const HistorySearchBar(),
            ),
          ),
        ),

        scannerHistoryListAsync.when(
          data: (scanHistory) {
            if (scanHistory.isEmpty) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          '''         OOPS !!
NOTHING IN HERE''',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Lottie.asset(
                          'assets/empty.json',
                          animate: true,
                          repeat: true,
                          height: 200,
                          width: 300,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList.separated(
                itemCount: scanHistory.length,
                itemBuilder: (context, index) {
                  final item = scanHistory[index];
                  return ScanHistoryCard(
                    leadingIcon: ScanResultUiMapper.primaryActionIcon(
                      item.contentType,
                    ),
                    title: item.payload.entries
                        .map((e) => "${e.key}:${e.value}")
                        .join(','),
                    contentType: item.contentType,
                    contentTypeIcon: ScanResultUiMapper.primaryActionIcon(
                      item.contentType,
                    ),
                    timestamp: item.timeStamp,
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
              ),
            );
          },
          error: (error, stackTrace) => SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: Text("Error Loading history : \n$error")),
            ),
          ),
          loading: () => SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Lottie.asset(
                'assets/loading.json',
                animate: true,
                repeat: true,
                height: 100,
                width: 50,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PinnedSearchBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _PinnedSearchBarDelegate({required this.child});

  @override
  double get minExtent => 80;

  @override
  double get maxExtent => 80;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(color: AppThemes.background, child: child);
  }

  @override
  bool shouldRebuild(covariant _PinnedSearchBarDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}
