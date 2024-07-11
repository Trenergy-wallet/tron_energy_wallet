part of '../current_asset.cg.dart';

class _Assets extends ConsumerWidget {
  const _Assets();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// слушаем  активного токена
    ref.watch(currentAssetProvider);
    final accountService = ref.watch(accountServiceProvider);
    final account = accountService.valueOrNull ?? Account.empty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.titleH1('mobile.assets'.tr()),
              AppButton.secondaryBlue(
                text: 'mobile.add'.tr(),
                leftPathIcon: AppIcons.coinAddIcon,
                onTap: ref.read(appBottomSheetCtrlProvider.notifier).tokens,
              ),
            ],
          ),
          20.sbHeight,
          if (account.assets.isEmpty && accountService.isLoading)
            Preloader(
              size: 50,
              isCoins: true,
              color: AppColors.positiveBright,
            )
          else if (account.assets.isEmpty)
            AppText.bodyMediumCond(
              'mobile.list_is_empty'.tr(),
            )
          else
            ListView.separated(
              itemCount: account.assets.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => 8.sbHeight,
              itemBuilder: (_, i) {
                final updateAsset = ref.read(currentAssetProvider.notifier);
                final asset = account.assets[i];
                return AssetsBlock(
                  asset: asset,
                  onTap: () => updateAsset.updateAssetAndGo(asset),
                );
              },
            ),
        ],
      ),
    );
  }
}
