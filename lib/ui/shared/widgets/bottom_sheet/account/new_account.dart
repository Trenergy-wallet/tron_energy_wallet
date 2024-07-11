import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/logic/repo/auth/auth_provider.cg.dart';
import 'package:trenergy_wallet/ui/router/router.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/account/widgets/btn_option.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Sheet новый аккаунт
class NewAccountSheet extends ConsumerWidget {
  /// Sheet новый аккаунт
  const NewAccountSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: Consts.gapHoriz12,
      child: SingleChildScrollView(
        child: Column(
          children: [
            42.sbHeight,
            AppIcons.accountEmoji(),
            42.sbHeight,
            AppText.bodySmallText(
              'mobile.create_import_wallets'.tr(),
              color: AppColors.bwGrayBright,
            ),
            32.sbHeight,
            BtnOption(
              title: 'mobile.new_wallet'.tr(),
              icon: AppIcons.add(),
              iconColorBg: AppColors.reed,
              onTap: () {
                ref.read(authServiceProvider.notifier).fetchAuthMessage();
                ref.read(appBottomSheetCtrlProvider.notifier).closeSheet();
                appRouter.go(ScreenPaths.createWallet, extra: false);
              },
            ),
            20.sbHeight,
            BtnOption(
              title: 'mobile.import'.tr(),
              icon: AppIcons.cloudDownload(),
              iconColorBg: AppColors.peach,
              onTap: () {
                ref.read(authServiceProvider.notifier).fetchAuthMessage();
                ref.read(appBottomSheetCtrlProvider.notifier).closeSheet();
                appRouter.go(ScreenPaths.importWallet);
              },
            ),
          ],
        ),
      ),
    );
  }
}
