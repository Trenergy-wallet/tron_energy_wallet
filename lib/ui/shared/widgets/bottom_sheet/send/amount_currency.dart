import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/ext.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/ui/screens/wallet/current_asset.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/send/send_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/widgets/button.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button.dart';
import 'package:trenergy_wallet/ui/shared/widgets/img_network.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Amount currency
class AmountCurrencySheet extends HookConsumerWidget {
  /// Amount currency
  const AmountCurrencySheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asset = ref.watch(currentAssetProvider);
    final sendM = ref.watch(sendCtrlProvider);
    final sendCtrl = ref.watch(sendCtrlProvider.notifier);

    final ctrl = useTextEditingController();
    final hasError = useState(false);
    useListenable(ctrl);

    final intText = double.tryParse(ctrl.text.replaceAll(' ', '')) ?? 0;
    final isDisabled = ctrl.text.isEmpty || intText == 0 || hasError.value;

    final focusNode = FocusNode();

    final keyboardH = MediaQuery.of(context).viewInsets.bottom;
    final isShowKeyboard = keyboardH > 100;

    if (!hasError.value) {
      FocusScope.of(context).requestFocus(focusNode);
    }

    return Padding(
      padding: Consts.gapHoriz12,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Padding(
                padding: Consts.gapHoriz12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.bodyRegularCond(
                          asset.token.name,
                          color: AppColors.bwGrayMid,
                        ),
                        AppText.bodyRegularCond(
                          '${'mobile.send_to'.tr()}: '
                          '${sendM.addressRecipient.shortAddressWallet}',
                          color: AppColors.bwGrayMid,
                        ),
                      ],
                    ),
                    8.sbHeight,
                    AutoSizeTextField(
                      controller: ctrl,
                      autofocus: true,
                      focusNode: focusNode,
                      cursorHeight: 44,
                      style: AppStyles.bigInput.copyWith(
                        color: hasError.value
                            ? AppColors.negativeBright
                            : AppColors.blackBright,
                      ),
                      presetFontSizes: const [44, 24],
                      keyboardType: const TextInputType.numberWithOptions(
                        signed: true,
                      ),
                      inputFormatters: [CustomNumberFormatter()],
                      onChanged: (value) {
                        final amount =
                            double.tryParse(value.replaceAll(' ', '')) ?? 0;
                        if (amount > asset.balance) {
                          hasError.value = true;
                        } else {
                          hasError.value = false;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: '.00',
                        hintStyle: AppStyles.bigInput.copyWith(
                          color: AppColors.bwGrayMid,
                        ),
                        contentPadding: EdgeInsets.zero,
                        constraints: const BoxConstraints(maxHeight: 44),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    if (hasError.value) ...[
                      8.sbHeight,
                      AppText.bodySmallTextCond(
                        'mobile.insufficient_funds'.tr(),
                        color: AppColors.negativeBright,
                      ),
                    ],
                    8.sbHeight,
                    Row(
                      children: [
                        ImgNetwork(
                          pathImg: asset.token.icon,
                          width: 16,
                          height: 16,
                        ),
                        4.sbWidth,
                        AppText.bodySmallTextCond(
                          'mobile.available_balance'.tr(
                            namedArgs: {'balance': asset.balance.toString()},
                          ),
                          color: hasError.value
                              ? AppColors.negativeBright
                              : AppColors.blackBright,
                        ),
                        const Spacer(),
                        AppButton.secondaryBlue(
                          onTap: () {
                            ctrl.text = formatAmount(asset.balance.toString());
                          },
                          text: 'mobile.max'.tr(),
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
              onTapBtn: () {
                ref
                    .read(appBottomSheetCtrlProvider.notifier)
                    .transferCurrency();

                sendCtrl.updateAmount(ctrl.text);
              },
              nameBtn: 'mobile.next'.tr(),
              isDisabled: isDisabled,
            ),
          if (isShowKeyboard) (keyboardH + 8).sbHeight,
        ],
      ),
    );
  }
}
