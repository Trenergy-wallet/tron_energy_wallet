import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button.dart';

/// Sheet ожидание покупки энергии
class WaitEnergySheet extends ConsumerWidget {
  /// Sheet ожидание покупки энергии
  const WaitEnergySheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Repo local
    final localRepo = ref.read(repoProvider).local;
    final appBottom = ref.read(appBottomSheetCtrlProvider.notifier);
    final isSmallScreen = screenHeight < Consts.smallScreenHeight;
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: Consts.gapHoriz12,
              child: AppIcons.walletMan(
                width: isSmallScreen ? 200 : 260,
                height: isSmallScreen ? 225 : 285,
              ),
            ),
          ),
        ),
        24.sbHeight,
        Padding(
          padding: Consts.gapHoriz12,
          child: AppButton.limeL(
            onTap: () {
              localRepo.saveBuyEnergyFaq(true);
              appBottom.closeSheet();
            },
            text: 'mobile.done'.tr(),
          ),
        ),
        44.sbHeight,
      ],
    );
  }
}
