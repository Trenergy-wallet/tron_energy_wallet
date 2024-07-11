import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/ext.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/data/config/app_config.dart';
import 'package:trenergy_wallet/domain/account/account.cg.dart';
import 'package:trenergy_wallet/domain/transactions/transactions.cg.dart';
import 'package:trenergy_wallet/logic/repo/account/account_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/favorites/favorites_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/tron_scan/tron_scan_provider.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/send/widgets/transfer_row_block.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

/// Sheet по транзакции
class TransactionSheet extends ConsumerWidget {
  /// Sheet по транзакции
  const TransactionSheet({required this.trans, super.key});

  /// Транзакция
  final TransactionsData trans;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBottom = ref.read(appBottomSheetCtrlProvider.notifier);
    final isTransfer = trans.type == Consts.typeTransfer;
    final tronScan = ref.watch(tronScanServiceProvider);
    final accountService = ref.watch(accountServiceProvider);
    final account = accountService.valueOrNull ?? Account.empty;
    final usdRate = double.tryParse(trans.token.usdPrice) ?? 0;

    final addresses = <String>[];

    final favorites = ref.watch(favoritesServiceProvider).valueOrNull ?? [];
    final fav = favorites
        .where(
          (e) => e.address == trans.fromAddress || e.address == trans.toAddress,
        )
        .firstOrNull;

    for (final w in account.wallets) {
      addresses.add(w.address);
    }

    final isNegative = addresses.contains(trans.fromAddress);

    final netUsage = tronScan.cost.netUsage;
    final netFee = tronScan.cost.netFee / Consts.trxMillion;

    final energyUsage = tronScan.cost.energyUsage;
    final energyUsageTotal = tronScan.cost.energyUsageTotal;
    final energyFee = tronScan.cost.energyFee / Consts.trxMillion;

    final energyEqual = energyUsage == energyUsageTotal;

    final comsa = energyFee == 0 && energyUsage == 0
        ? ''
        : energyUsage == 0
            ? '$energyFee TRX'
            : energyEqual
                ? '$energyUsage Energy\n\n'
                : '$energyUsage Energy\n\n${energyFee.toStringAsFixed(2)} '
                    'TRX (Energy)';

    final bandwidth = netUsage != 0
        ? '$netUsage Bandwidth'
        : '${energyEqual ? '' : '\n'}$netFee TRX (Band.)';

    final commission = '$comsa $bandwidth';
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: Consts.gapHoriz12,
              child: Column(
                children: [
                  12.sbHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText.balanceL(
                        (isNegative ? '-' : '+') +
                            numbWithoutZero(
                              trans.amount,
                              precision: isTransfer ? 6 : 0,
                            ),
                      ),
                      8.sbWidth,
                      AppText.balanceL(trans.token.shortName),
                    ],
                  ),
                  12.sbHeight,
                  AppText.bodySubTitle(
                    '~\$${numbWithoutZero(
                      trans.amount * usdRate,
                      precision: isTransfer ? 6 : 0,
                    )}',
                    color: AppColors.bwGrayMid,
                  ),
                  44.sbHeight,
                  TransferRowBlock(
                    leftText: 'mobile.date'.tr(),
                    rightText: trans.createdAt,
                  ),
                  16.sbHeight,
                  TransferRowBlock(
                    leftText: 'mobile.status'.tr(),
                    rightWidget: Row(
                      children: [
                        AppIcons.icon(AppIcons.badgeStatus),
                        8.sbWidth,
                        AppText.bodySemiBoldCond(tronScan.contractRet),
                      ],
                    ),
                  ),
                  if (isTransfer) ...[
                    16.sbHeight,
                    TransferRowBlock(
                      leftText: isNegative
                          ? 'mobile.recipient'.tr()
                          : 'mobile.sender'.tr(),
                      rightText: isNegative
                          ? trans.toAddress.shortAddressWallet
                          : trans.fromAddress.shortAddressWallet,
                    ),
                  ],
                  if (fav != null) ...[
                    16.sbHeight,
                    TransferRowBlock(
                      leftText: '',
                      rightText: fav.name,
                    ),
                  ],
                  if (isTransfer)
                    if (isNegative) ...[
                      16.sbHeight,
                      TransferRowBlock(
                        leftText: 'mobile.network_commission'.tr(),
                        rightText: commission,
                      ),
                    ],
                  if (isTransfer) ...[
                    24.sbHeight,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: AppButton.strokeM(
                        text: 'mobile.watch_block_explorer'.tr(),
                        leftPathIcon: AppIcons.connectedIcon,
                        onTap: () async {
                          final urlTrxTronscan = AppConfig.apiTrxTxid;

                          final url = Uri.parse(
                            '$urlTrxTronscan${trans.txId}',
                          );

                          if (!await launchUrl(url)) {
                            throw Exception('Could not launch $url');
                          }
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        if (isTransfer) ...[
          24.sbHeight,
          Padding(
            padding: Consts.gapHoriz12,
            child: AppButton.strokeL(
              onTap: () async {
                fav != null
                    ? appBottom.deleteFavorite(
                        address:
                            isNegative ? trans.toAddress : trans.fromAddress,
                      )
                    : appBottom.addFavorite(
                        address:
                            isNegative ? trans.toAddress : trans.fromAddress,
                      );
              },
              text: fav != null
                  ? 'mobile.remove_favorites'.tr()
                  : 'mobile.add_favorites'.tr(),
              isNegative: fav != null,
              leftPathIcon:
                  fav != null ? AppIcons.userDeleteIcon : AppIcons.userAddIcon,
            ),
          ),
          44.sbHeight,
        ],
      ],
    );
  }
}
