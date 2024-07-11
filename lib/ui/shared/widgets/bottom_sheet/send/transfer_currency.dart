import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/ext.dart';
import 'package:trenergy_wallet/logic/repo/info/estimate_fee_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/transactions/transactions_provider.cg.dart';
import 'package:trenergy_wallet/ui/screens/wallet/current_asset.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/send/send_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/send/widgets/transfer_row_block.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/widgets/button.dart';
import 'package:trenergy_wallet/ui/shared/widgets/preloader.dart';

/// Transfer currency
class TransferCurrencySheet extends ConsumerWidget {
  /// Transfer currency
  const TransferCurrencySheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(transactionsServiceProvider).isLoading;
    final estimateFee = ref.watch(estimateFeeCtrlProvider);

    final asset = ref.watch(currentAssetProvider);
    final sendCtrlM = ref.watch(sendCtrlProvider);
    final sendCtrl = ref.watch(sendCtrlProvider.notifier);

    final addressRecipient = sendCtrlM.addressRecipient.shortAddressWallet;
    return Padding(
      padding: Consts.gapHoriz12,
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Padding(
                padding: Consts.gapHoriz12,
                child: Column(
                  children: [
                    AppText.titleH1(
                      '${sendCtrlM.amount} ${asset.token.shortName}',
                    ),
                    68.sbHeightSmall,
                    TransferRowBlock(
                      leftText: 'mobile.asset'.tr(),
                      rightText: '${asset.token.name} ${asset.token.shortName}',
                      pathImg: asset.token.icon,
                    ),
                    16.sbHeight,
                    TransferRowBlock(
                      leftText: 'mobile.from_where'.tr(),
                      rightText: asset.address.shortAddressWallet,
                    ),
                    16.sbHeight,
                    TransferRowBlock(
                      leftText: 'mobile.to_where'.tr(),
                      rightText: addressRecipient,
                    ),
                    if (!Consts.trxWords.contains(asset.token.name)) ...[
                      16.sbHeight,
                      TransferRowBlock(
                        leftText: 'mobile.network_commission'.tr(),
                        rightText: '${estimateFee.trx} ${Consts.trx}',
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          if (isLoading) const Preloader(),
          Flexible(
            child: ButtonBottomSheet(
              onTapBtn: sendCtrl.sendAmount,
              nameBtn: 'mobile.send'.tr(),
              isDisabled: isLoading,
            ),
          ),
        ],
      ),
    );
  }
}
