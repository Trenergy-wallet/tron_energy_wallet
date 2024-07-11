import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/logic/repo/info/wallet_check_provider.cg.dart';
import 'package:trenergy_wallet/ui/screens/wallet/current_asset.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_input.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/send/send_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/widgets/button.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button_text.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Address Recipient
class AddressRecipientSheet extends HookConsumerWidget {
  /// Address Recipient
  const AddressRecipientSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(currentAssetProvider);
    final sendCtrlM = ref.watch(sendCtrlProvider);
    final sendCtrl = ref.watch(sendCtrlProvider.notifier);

    final ctrl = useTextEditingController(text: sendCtrlM.addressRecipient);
    useListenable(ctrl);

    final walletCheckM = ref.watch(walletCheckCtrlProvider);

    final hasError = ctrl.text.isNotEmpty &&
        walletCheckM.blockchain.name == Consts.walletCheckError;

    final focusNode = FocusNode();

    final keyboardH = MediaQuery.of(context).viewInsets.bottom;
    final isShowKeyboard = keyboardH > 100;

    if (!hasError) {
      FocusScope.of(context).requestFocus(focusNode);
    }
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: Consts.gapHoriz12,
              child: Column(
                children: [
                  24.sbHeight,
                  AppInput(
                    controller: ctrl,
                    hintText: 'mobile.address'.tr(),
                    maxLines: 1,
                    focusNode: focusNode,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    suffixIcon: AppButtonText(
                      text: 'mobile.insert'.tr(),
                      onTap: () async {
                        final v = await clipBoardPast();
                        sendCtrl.updateAddressRecipient(v);
                        ctrl.text = await clipBoardPast();
                      },
                      colorText: hasError ? AppColors.negativeBright : null,
                    ),
                    onChanged: (v) {
                      if (v.isEmpty) {
                        ctrl.clear();
                      }
                      sendCtrl.updateAddressRecipient(v);
                    },
                    hasError: hasError,
                    errorText:
                        'mobile.address_does_not_match_TRC-20_network'.tr(),
                  ),
                  24.sbHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // AppButtonText(
                      //   text: 'mobile.scan_qr'.tr(),
                      //   leftPathIcon: AppIcons.qrScanIcon,
                      //   onTap: () {
                      //   },
                      // ),
                      AppButtonText(
                        text: 'mobile.favorites'.tr(),
                        leftPathIcon: AppIcons.addressBook,
                        onTap: ref
                            .read(appBottomSheetCtrlProvider.notifier)
                            .showListFavorite,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isShowKeyboard)
          ButtonBottomSheet(
            padHoriz: 12,
            onTapBtn: () {
              sendCtrl.goToAmountCurrency(ctrl.text);
            },
            nameBtn: 'mobile.next'.tr(),
            isDisabled: ctrl.text.isEmpty || hasError,
          ),
        if (isShowKeyboard) (keyboardH + 8).sbHeight,
      ],
    );
  }
}
