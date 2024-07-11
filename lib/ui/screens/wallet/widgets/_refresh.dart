part of '../current_asset.cg.dart';

class _Refresh extends StatelessWidget {
  const _Refresh({this.info, super.key});

  final PullToRefreshScrollNotificationInfo? info;

  @override
  Widget build(BuildContext context) {
    final offset = info?.dragOffset ?? 0.0;
    return SliverToBoxAdapter(
      child: Container(
        height: offset,
        width: screenWidth,
        alignment: Alignment.center,
        child: const RiveRefresh(),
      ),
    );
  }
}
