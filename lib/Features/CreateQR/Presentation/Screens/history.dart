import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:proscan/Core/Themes/app_themes.dart';
import 'package:proscan/Core/Utils/createQr_utils/content_typetoicon_mapper.dart';
import 'package:proscan/Core/Utils/createQr_utils/split_typeofcontent_in_generate_screen.dart';
import 'package:proscan/Features/CreateQR/Presentation/Providers/historyScreen_notifiers/history_screen_notifier.dart';
import 'package:proscan/Features/CreateQR/Presentation/Widgets/HistoryWidgets/history_card.dart';
import 'package:proscan/Features/CreateQR/Presentation/Widgets/HistoryWidgets/history_search_bar.dart';

class GeneratedHistoryScreen extends ConsumerStatefulWidget {
  const GeneratedHistoryScreen({super.key});

  @override
  ConsumerState<GeneratedHistoryScreen> createState() =>
      _GeneratedHistoryScreenState();
}

class _GeneratedHistoryScreenState
    extends ConsumerState<GeneratedHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final generatedQrsHistoryList = ref.watch(createdHistoryScreenProvider);
    return SliverMainAxisGroup(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _PinnedSearchBarDelegate(
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: GeneratedHistorySearchBar(),
            ),
          ),
        ),

        generatedQrsHistoryList.when(
          data: (qrsHistory) {
            if (qrsHistory.isEmpty) {
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
                itemCount: qrsHistory.length,
                itemBuilder: (context, index) {
                  final item = qrsHistory[index];
                  return GeneratedHistoryCard(
                    qrThumbnail: item.payload,
                    title: item.payload,
                    contentType: GetContentTypeFromQrFormType.getContentType(
                      item.contentType,
                    ),
                    contentTypeIcon: QrFormTypeIconMapper.getIcon(
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
          error: (error, stackTrace) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Center(child: Text("Error Loading history : \n$error")),
              ),
            );
          },
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
