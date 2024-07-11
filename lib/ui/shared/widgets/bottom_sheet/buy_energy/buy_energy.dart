import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide TextDirection;
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/domain/account/account.cg.dart';
import 'package:trenergy_wallet/domain/tron_energy/tron_energy.cg.dart';
import 'package:trenergy_wallet/domain/wallet/wallet.cg.dart';
import 'package:trenergy_wallet/logic/repo/account/account_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/project_tr_energy/buy_energy_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/tron_energy_pipe/tron_energy_pipe_provider.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_input.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

part 'widgets/_slider.dart';
part 'widgets/_row_info.dart';

/// Sheet покупка энергии
class BuyEnergySheet extends ConsumerStatefulWidget {
  /// Sheet покупка энергии
  const BuyEnergySheet({super.key});

  @override
  ConsumerState<BuyEnergySheet> createState() => _BuyEnergySheetState();
}

class _BuyEnergySheetState extends ConsumerState<BuyEnergySheet> {
  double value = Consts.transactionAverageCost.toDouble();
  final _debouncer = Debouncer(
    delay: const Duration(milliseconds: Consts.humanFriendlyDelay * 3),
  );
  final ctrl = TextEditingController(text: '${Consts.transactionAverageCost}');

  TronEnergyPipe? tronEnergy;
  Account? account;
  AppAsset? appAsset;
  double maxEnergy = 0;
  String trxSun = '';
  int countTrans = 0;
  double balance = 0;
  bool isDisabled = false;

  @override
  void initState() {
    super.initState();
    tronEnergy = ref.read(tronEnergyPipeServiceProvider).valueOrNull ??
        TronEnergyPipe.empty;

    appAsset = geAppAsset(ref.read(accountServiceProvider));
    balance = (appAsset?.balance ?? 0) - 0.5;
    final b = balance <= 0 ? 0 : balance;
    maxEnergy = b * Consts.trxMillion / Consts.trxSun;
    isDisabled = balance <= 7;

    sumSun();
  }

  void sumSun() {
    setState(() {
      trxSun = numbWithoutZero(value * Consts.trxSun / Consts.trxMillion);
      countTrans = value ~/ Consts.transactionAverageCost;
    });
  }

  void onChangeSlider(double v) {
    ctrl.text = v.toStringAsFixed(0);
    checkAvaible();
    sumSun();
  }

  void onchageText(String v) {
    final parsV = double.tryParse(v) ?? 0;

    _debouncer.call(() {
      setState(() {
        if (parsV < Consts.transactionAverageCost) {
          isDisabled = false;
          value = Consts.transactionAverageCost.toDouble();
          ctrl.text = Consts.transactionAverageCost.toString();
          checkAvaible();
          return;
        }
        if (parsV >= maxEnergy) {
          final s =
              parsV >= Consts.maxEnergySlider ? Consts.maxEnergySlider : parsV;
          value = s;
          ctrl.text = s.toStringAsFixed(0);
          checkAvaible();
          return;
        }
        isDisabled = false;
        value = double.tryParse(v) ?? 0;
      });
      sumSun();
    });
  }

  void checkAvaible() {
    final parsV = double.tryParse(ctrl.text) ?? 0;
    setState(() {
      if (parsV > maxEnergy) {
        isDisabled = true;
      } else {
        isDisabled = false;
      }
      value = parsV;
    });
  }

  @override
  void dispose() {
    ctrl.dispose();
    _debouncer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trans = countTrans == 1
        ? '~$countTrans⚡️'
        : '~$countTrans (${countTrans ~/ 2}⚡️)';

    final keyboardH = MediaQuery.of(context).viewInsets.bottom;
    final isShowKeyboard = keyboardH > 100;

    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: FocusManager.instance.primaryFocus?.unfocus,
            child: ColoredBox(
              color: AppColors.transparent,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: Consts.gapHoriz12,
                  child: Column(
                    children: [
                      _RowInfo(
                        leftText: 'mobile.my_energy'.tr(),
                        rightText:
                            '${tronEnergy?.energyFree} / ${tronEnergy?.energyTotal}',
                      ),
                      16.sbHeight,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AppText.bodyMedium(
                              'mobile.buy_energy'.tr(),
                              color: AppColors.bwGrayBright,
                            ),
                          ),
                          Flexible(
                            child: AppInput(
                              hintText: '0',
                              controller: ctrl,
                              textAlign: TextAlign.center,
                              onChanged: onchageText,
                              hasError: isDisabled,
                              showErrorText: false,
                              contextMenuBuilder: (c, editableTextState) {
                                return AdaptiveTextSelectionToolbar
                                    .editableText(
                                  editableTextState: editableTextState,
                                );
                              },
                              // keyboardType: TextInputType.number,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                // signed: true,
                                decimal: true,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                //   FilteringTextInputFormatter.deny(
                                //     RegExp(r'[.,\n ]'),
                                //   ),
                              ],
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                        ],
                      ),
                      24.sbHeight,
                      _Slider(
                        value: value,
                        onChange: onChangeSlider,
                        maxEnergy: maxEnergy,
                      ),
                      24.sbHeight,
                      _RowInfo(
                        leftText: 'mobile.transactions'.tr(),
                        rightText: trans,
                      ),
                      16.sbHeight,
                      _RowInfo(
                        leftText: 'mobile.price'.tr(),
                        rightText: '$trxSun ${Consts.trx}',
                      ),
                      16.sbHeight,
                      _RowInfo(
                        leftText: 'mobile.available'.tr(),
                        rightText:
                            '${numbWithoutZero(balance <= 0 ? 0 : balance)} '
                            '${Consts.trx}',
                        rightErrorText: 'mobile.not_enough_trx'.tr(),
                        isDisabled: isDisabled,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        24.sbHeight,
        Padding(
          padding: Consts.gapHoriz12,
          child: Column(
            children: [
              if (appAsset?.balance == null) ...[
                AppText.bodySmallText(
                  'mobile.token_is_not_assets'.tr(),
                  color: AppColors.negativeBright,
                ),
                4.sbHeight,
              ],
              AppButton.limeL(
                onTap: () {
                  ref.read(buyEnergyServiceProvider.notifier).fetchWalletTopUp(
                        resourceAmount: int.tryParse(ctrl.text) ?? 0,
                        costTrx: int.tryParse(trxSun) ?? 0,
                      );
                },
                text: 'mobile.buy_energy'.tr(),
                isDisabled: isDisabled,
              ),
            ],
          ),
        ),
        if (isShowKeyboard) (keyboardH + 8).sbHeight else 44.sbHeight,
      ],
    );
  }
}
