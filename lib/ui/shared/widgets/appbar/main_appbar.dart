import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/logic/repo/account/account_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button_icon.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button_text.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Главный AppBar содержащий user acc и уведомления
class MainAppBar extends ConsumerWidget implements PreferredSizeWidget {
  /// Главный AppBar содержащий user acc и уведомления
  const MainAppBar({
    super.key,
    this.onTapAccount,
    this.onTapBell,
  });

  /// Обработчик нажатия на user acc
  final void Function()? onTapAccount;

  /// Обработчик нажатия на уведомления
  final void Function()? onTapBell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(accountServiceProvider);
    final localRepo = ref.watch(repoProvider).local;
    final sk = localRepo.getSecretKey();
    final account = localRepo.getAccount(sk: sk);
    return AppBar(
      forceMaterialTransparency: true,
      backgroundColor: AppColors.primaryMid,
      elevation: 0,
      actions: [
        AppButtonIcon.light(
          iconPath: AppIcons.bellIcon,
          onTap: onTapBell,
        ),
        12.sbWidth,
      ],
      leading: Row(
        children: [
          12.sbWidth,
          Flexible(
            child: AppButtonText(
              text: account.name,
              type: AppTextType.lButtonMedium,
              colorText: AppColors.blackBright,
              hoverColorText: AppColors.primaryMid,
              rightPathIcon: AppIcons.caretDownIcon,
              onTap: onTapAccount,
            ),
          ),
        ],
      ),
      leadingWidth: 130,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size(0, Consts.toolbarHeight);
}
