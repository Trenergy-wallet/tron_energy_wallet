import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Sheet покупка энергии FAQ
class BuyEnergyFaqSheet extends ConsumerWidget {
  /// Sheet покупка энергии FAQ
  const BuyEnergyFaqSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Repo local
    final localRepo = ref.read(repoProvider).local;
    final appBottom = ref.read(appBottomSheetCtrlProvider.notifier);
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: SingleChildScrollView(
            child: Padding(
              padding: Consts.gapHoriz12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppIcons.buyEnergyImg(),
                  44.sbHeightSmall,
                  AppText.titleH1(
                    'mobile.explanation_energy_1'.tr(),
                    color: AppColors.pattensBlue,
                  ),
                  12.sbHeight,
                  AppText.bodyRegularCond(
                    'mobile.explanation_energy_2'.tr(),
                    color: AppColors.pattensBlue,
                  ),
                  12.sbHeight,
                  AppText.bodyRegularCond(
                    'mobile.explanation_energy_3'.tr(),
                    color: AppColors.pattensBlue,
                  ),
                  12.sbHeight,
                  AppText.bodyRegularCond(
                    'mobile.explanation_energy_4'.tr(),
                    color: AppColors.pattensBlue,
                  ),
                ],
              ),
            ),
          ),
        ),
        24.sbHeight,
        Padding(
          padding: Consts.gapHoriz12,
          child: AppButton.primaryL(
            onTap: () {
              localRepo.saveBuyEnergyFaq(true);
              appBottom.buyEnergy();
            },
            text: 'mobile.its_clear'.tr(),
          ),
        ),
        44.sbHeight,
      ],
    );
  }
}
