import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/logic/repo/favorites/favorites_provider.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/send/send_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/widgets/button.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button.dart';

/// Sended currency / Отправленные валюты / Экран завершения перевода
class SendedCurrencySheet extends ConsumerWidget {
  /// Sended currency / Отправленные валюты / Экран завершения перевода
  const SendedCurrencySheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSmallScreen = screenHeight < Consts.smallScreenHeight;
    final send = ref.watch(sendCtrlProvider);
    final favorites = ref.watch(favoritesServiceProvider).valueOrNull ?? [];
    final fav =
        favorites.where((e) => e.address == send.addressRecipient).firstOrNull;
    final appBottom = ref.read(appBottomSheetCtrlProvider.notifier);

    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              AppIcons.walletMan(
                width: isSmallScreen ? 200 : 260,
                height: isSmallScreen ? 225 : 285,
              ),
            ],
          ),
        ),
        Flexible(
          child: Column(
            children: [
              Padding(
                padding: Consts.gapHoriz12,
                child: AppButton.strokeL(
                  onTap: () async {
                    fav != null
                        ? appBottom.deleteFavorite(
                            address: send.addressRecipient,
                          )
                        : appBottom.addFavorite(
                            address: send.addressRecipient,
                          );
                  },
                  text: fav != null
                      ? 'mobile.remove_favorites'.tr()
                      : 'mobile.add_favorites'.tr(),
                  isNegative: fav != null,
                  leftPathIcon: fav != null
                      ? AppIcons.userDeleteIcon
                      : AppIcons.userAddIcon,
                ),
              ),
              ButtonBottomSheet(
                padHoriz: 12,
                onTapBtn: () {
                  ref.read(appBottomSheetCtrlProvider.notifier).closeSheet();
                },
                nameBtn: 'mobile.done'.tr(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
