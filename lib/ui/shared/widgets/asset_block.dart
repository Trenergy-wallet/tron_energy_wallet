import 'package:flutter/material.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/domain/wallet/wallet.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/img_network.dart';
import 'package:trenergy_wallet/ui/shared/widgets/tron_energy_block.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

///  Активный токен
class AssetsBlock extends StatelessWidget {
  /// Активный токен
  const AssetsBlock({
    required this.asset,
    required this.onTap,
    super.key,
  });

  /// Активный токен
  final AppAsset asset;

  /// функция нажатия
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    final token = asset.token;
    final numbUsdPrice = double.tryParse(token.usdPrice) ?? 0;
    final isNegative = token.prevPriceDiffPercent.isNegative;
    final isEnergy = token.id == 1 && token.shortName == 'USDT';
    final shortName =
        token.shortName == Consts.tron ? Consts.trx : token.shortName;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.magnolia,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.bwBrightPrimary),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ImgNetwork(
                      pathImg: token.icon,
                      width: 32,
                      height: 32,
                    ),
                    if (token.icon != asset.iconNetwork)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: ImgNetwork(
                          pathImg: asset.iconNetwork,
                          width: 12,
                          height: 12,
                        ),
                      ),
                  ],
                ),
                8.sbWidth,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppText.bodySubTitle(shortName),
                        4.sbWidth,
                        AppText.bodySmallText(
                          asset.iconNetworkName.toUpperCase(),
                          color: AppColors.bwGrayMid,
                        ),
                      ],
                    ),
                    4.sbHeight,
                    Row(
                      children: [
                        AppText.bodyRegularCond(
                          '\$$numbUsdPrice',
                          color: AppColors.bwGrayMid,
                        ),
                        8.sbWidth,
                        AppText.bodyRegularCond(
                          '${isNegative ? '' : '+'}'
                          '${token.prevPriceDiffPercent}%',
                          color: isNegative
                              ? AppColors.negativeBright
                              : AppColors.positiveBright,
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppText.bodySemiBoldCond(
                      numbWithoutZero(asset.balance),
                    ),
                    4.sbHeight,
                    AppText.bodyRegularCond(
                      '\$${numbWithoutZero(asset.balance * numbUsdPrice)}',
                      color: AppColors.bwGrayMid,
                    ),
                  ],
                ),
              ],
            ),
            if (isEnergy) ...[
              12.sbHeight,
              const TronEnergyBlock(),
            ],
          ],
        ),
      ),
    );
  }
}
