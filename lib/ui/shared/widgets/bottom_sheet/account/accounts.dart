import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/account/widgets/btn_option.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/widgets/button.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Аккаунты
class AccountsSheet extends ConsumerWidget {
  /// Аккаунты
  const AccountsSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localRepo = ref.read(repoProvider).local;
    final sk = localRepo.getSecretKey();
    final account = localRepo.getAccount(sk: sk);
    final accounts = localRepo.getAccountList(sk: sk);
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            child: Padding(
              padding: Consts.gapHoriz12,
              child: Column(
                children: [
                  12.sbHeight,
                  for (final a in accounts) ...[
                    BtnOption(
                      title: a.name,
                      isActive: a == account,
                      icon: AppIcons.logoIcon(),
                      iconColorBg: AppColors.buttonsBlueDull,
                      onTap: () {
                        localRepo.chooseAccount(a);
                      },
                    ),
                    20.sbHeight,
                  ],
                ],
              ),
            ),
          ),
        ),
        Flexible(
          child: ButtonBottomSheet(
            padHoriz: 12,
            onTapBtn:
                ref.read(appBottomSheetCtrlProvider.notifier).addNewAccount,
            nameBtn: 'mobile.add_account'.tr(),
            isLimeBtn: false,
          ),
        ),
      ],
    );
  }
}
