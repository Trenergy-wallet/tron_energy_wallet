part of '../current_asset.cg.dart';

///
class AssetScreen extends ConsumerStatefulWidget {
  ///
  const AssetScreen({
    super.key,
  });

  @override
  ConsumerState<AssetScreen> createState() => _AssetScreenState();
}

class _AssetScreenState extends ConsumerState<AssetScreen> {
  @override
  void initState() {
    super.initState();
    addPostFrameCallback(() {
      final asset = ref.read(currentAssetProvider);
      ref.watch(tokenTransactionsServiceProvider.notifier).getTokenTransactions(
            walletId: asset.walletId,
            tokenId: asset.token.id,
          );
      ref
          .watch(chartHistoricalServiceProvider.notifier)
          .fetchChart(currency: asset.token.shortName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tokenTransService = ref.watch(tokenTransactionsServiceProvider);
    final m = tokenTransService.valueOrNull ?? Transactions.empty;
    final asset = ref.watch(currentAssetProvider);
    final numUsdPrice = double.tryParse(asset.token.usdPrice) ?? 0;

    final isEnergy = asset.token.id == 1 && asset.token.shortName == 'USDT';

    return AppScaffold(
      navBarEnable: false,
      appBar: SimpleAppBar(
        titleWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImgNetwork(
              width: 32,
              height: 32,
              pathImg: asset.token.icon,
            ),
            6.sbWidth,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.bodySmallText(asset.token.name),
                AppText.bodySmallText(
                  asset.token.shortName,
                  color: AppColors.bwGrayMid,
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
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
            children: [
              AppText.balanceL(numbWithoutZero(asset.balance)),
              12.sbHeight,
              AppText.bodySubTitle(
                '~\$${numbWithoutZero(asset.balance * numUsdPrice)}',
                color: AppColors.bwGrayMid,
              ),
              32.sbHeightSmall,
              _SendReceiveBtn(
                onTapSend: ref
                    .read(appBottomSheetCtrlProvider.notifier)
                    .addressRecipient,
                onTapReceive:
                    ref.read(appBottomSheetCtrlProvider.notifier).receiveSheet,
              ),
              40.sbHeightSmall,
              if (isEnergy) ...[
                Container(
                  width: screenWidth,
                  margin: Consts.gapHoriz12,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: Consts.borderRadiusAll16,
                    border: Border.all(
                      color: AppColors.bwBrightPrimary,
                    ),
                    color: AppColors.magnolia,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.titleH1('mobile.your_energy'.tr()),
                      12.sbHeight,
                      const TronEnergyBlock(),
                    ],
                  ),
                ),
                40.sbHeightSmall,
              ],
              _ChartCurrency(asset: asset),
              40.sbHeight,
              _AllTransactions(
                title: 'mobile.transactions',
                textEmptyList: 'mobile.displayed_asset_transactions_here',
                transactions: m.data,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
