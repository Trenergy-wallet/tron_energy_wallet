part of 'current_asset.cg.dart';

///
class WalletScreen extends ConsumerWidget {
  ///
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      navBarEnable: false,
      hasMainAppBar: true,
      onTapAccount: ref.read(appBottomSheetCtrlProvider.notifier).accounts,
      onTapBell: () => appRouter.push(ScreenPaths.notifications),
      body: PullToRefreshNotification(
        color: AppColors.bwGrayBright,
        onRefresh: () async {
          await ref.read(accountServiceProvider.notifier).getAccount();
          ref
            ..invalidate(tronEnergyPipeServiceProvider)
            ..invalidate(transactionsServiceProvider);
          return true;
        },
        child: CustomScrollView(
          slivers: [
            PullToRefreshContainer((v) {
              return _Refresh(info: v);
            }),
            SliverToBoxAdapter(
              child: Container(
                width: screenWidth,
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.only(top: 24),
                decoration: BoxDecoration(
                  color: AppColors.primaryDull,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(44),
                    topRight: Radius.circular(44),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _Balance(),
                    32.sbHeight,
                    _SendReceiveBtn(
                      onTapSend: ref
                          .read(appBottomSheetCtrlProvider.notifier)
                          .chooseAsset,
                      onTapReceive: () => ref
                          .read(appBottomSheetCtrlProvider.notifier)
                          .chooseAsset(isReceive: true),
                    ),
                    64.sbHeightSmall,
                    const _Assets(),
                    40.sbHeightSmall,
                    const _AllTransactions(),
                    // 50.sbHeight,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
