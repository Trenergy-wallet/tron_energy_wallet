import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/domain/account/account.cg.dart';
import 'package:trenergy_wallet/logic/repo/account/account_provider.cg.dart';
import 'package:trenergy_wallet/ui/screens/wallet/current_asset.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/currency/widgets/row_radio.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/send/send_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/widgets/button.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Choose asset
class ChooseAssetSheet extends HookConsumerWidget {
  /// Choose asset
  const ChooseAssetSheet({
    this.isReceive = false,
    super.key,
  });

  ///
  final bool isReceive;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(sendCtrlProvider);

    /// слушаем  активного токена
    final currentAsset = ref.watch(currentAssetProvider);
    final accountService = ref.watch(accountServiceProvider);
    final account = accountService.valueOrNull ?? Account.empty;
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryMid,
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              border: Border.all(color: AppColors.bwBrightPrimary),
            ),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: account.assets.length,
              separatorBuilder: (_, __) => 8.sbHeight,
              itemBuilder: (_, i) {
                final asset = account.assets[i];
                return RowRadio(
                  name: asset.token.name,
                  code: asset.token.shortName,
                  amount: asset.balance,
                  pathImg: asset.token.icon,
                  onTap: () {
                    ref.read(currentAssetProvider.notifier).updateAsset(asset);
                  },
                  isActive: currentAsset == asset,
                );
              },
            ),
          ),
        ),
        Flexible(
          child: ButtonBottomSheet(
            padHoriz: 12,
            onTapBtn: () {
              if (isReceive) {
                ref.read(appBottomSheetCtrlProvider.notifier).receiveSheet();
              } else {
                ref
                    .read(appBottomSheetCtrlProvider.notifier)
                    .addressRecipient(hasTapBack: true);
              }
            },
            nameBtn: 'mobile.next'.tr(),
          ),
        ),
      ],
    );
  }
}
