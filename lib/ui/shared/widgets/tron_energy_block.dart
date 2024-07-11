import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/data/repo/local/local_repo.dart';
import 'package:trenergy_wallet/domain/account/account.cg.dart';
import 'package:trenergy_wallet/domain/tron_energy/tron_energy.cg.dart';
import 'package:trenergy_wallet/logic/providers/inapp_logger.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/logic/repo/tron_energy_pipe/tron_energy_pipe_provider.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Блок энергии
class TronEnergyBlock extends ConsumerStatefulWidget {
  /// Блок энергии
  const TronEnergyBlock({super.key});

  @override
  ConsumerState<TronEnergyBlock> createState() => _TronEnergyBlockState();
}

class _TronEnergyBlockState extends ConsumerState<TronEnergyBlock> {
  Account? account;

  static const int stepSec = 5;
  double energyFree = 0;
  int energyTotal = 0;
  double count = 0;

  Timer? timer;

  int get totalSeconds => 24 * 60 * 60;
  double get countInterval => totalSeconds / stepSec;

  /// Repo local
  LocalRepo get localRepo => ref.read(repoProvider).local;

  @override
  void initState() {
    super.initState();
    addPostFrameCallback(() {
      ref.invalidate(tronEnergyPipeServiceProvider);
    });
  }

  void setEnergy(TronEnergyPipe energy) {
    setState(() {
      energyFree = energy.energyFree.toDouble();
      energyTotal = energy.energyTotal;
      count = energy.energyTotal / countInterval;
    });
  }

  void startTimer() {
    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: stepSec), (timer) {
      if (energyFree > energyTotal) {
        timer.cancel();
        setState(() {
          energyFree = energyTotal.toDouble();
        });
      } else {
        setState(() {
          energyFree += count;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      ref.listen(tronEnergyPipeServiceProvider, (_, next) {
        final energy = next.valueOrNull ?? TronEnergyPipe.empty;
        setEnergy(energy);

        if (energyFree < energyTotal) {
          startTimer();
        }
      });
    } catch (_, s) {
      InAppLogger.instance.logError('TronEnergyBlockState', '$s');
    }

    /// для отображения на экране короткие суммы
    final eFree = compactCurrency(energyFree);
    final eTotal = compactCurrency(energyTotal);

    /// для рассчетов
    final commonCalc = energyFree / energyTotal;
    final condCommonCalc = commonCalc > 1.0 ? 1.0 : commonCalc;
    final calcEnergy = condCommonCalc * 100;

    /// для отображение на экране процент
    final percentUI =
        '${calcEnergy.isNaN ? 0 : calcEnergy.toStringAsFixed(0)}%';

    /// для рассчетов
    final percent = (energyFree / energyTotal).isNaN ? 0.0 : condCommonCalc;

    return Container(
      padding: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.bwBrightPrimary),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  AppIcons.atomBolder(width: 16, height: 16),
                  2.sbWidth,
                  AppText.bodyRegularCond('$eFree / $eTotal'),
                ],
              ),
              AppButton.secondaryViolet(
                leftPathIcon: AppIcons.atomBolderIcon,
                text: 'mobile.buy'.tr(),
                onTap: () {
                  localRepo.getBuyEnergyFaq()
                      ? ref
                          .read(appBottomSheetCtrlProvider.notifier)
                          .buyEnergy()
                      : ref
                          .read(appBottomSheetCtrlProvider.notifier)
                          .buyEnergyFaq();
                },
              ),
            ],
          ),
          8.sbHeight,
          Row(
            children: [
              SizedBox(
                width: 40,
                child: Center(child: AppText.bodyRegularCond(percentUI)),
              ),
              8.sbWidth,
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final maxWidth = constraints.maxWidth;
                    return Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: const Color(0xffD8F1FA),
                        borderRadius: Consts.borderRadiusAll12,
                        border: Border.all(
                          color: AppColors.bwBrightPrimary,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            clipBehavior: Clip.none,
                            borderRadius: Consts.borderRadiusAll12,
                            child: AnimatedContainer(
                              constraints:
                                  BoxConstraints(maxWidth: screenWidth),
                              duration: const Duration(
                                milliseconds: Consts.humanFriendlyDelay,
                              ),
                              decoration: BoxDecoration(
                                color: getColorForEnergy(percent),
                              ),
                              width: maxWidth * percent,
                              height: 24,
                              alignment: Alignment.centerRight,
                              child: Transform.translate(
                                offset: Offset(percent >= .99 ? 12 : 6, 0),
                                child: getProgressIconRound(percent),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
