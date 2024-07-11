import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/domain/favorites/favorites.cg.dart';
import 'package:trenergy_wallet/logic/repo/favorites/favorites_provider.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button.dart';

/// Удаление из избранных
class DeleteFavoriteSheet extends HookConsumerWidget {
  /// Удаление из избранных
  const DeleteFavoriteSheet({this.address, super.key});

  /// Адрес
  final String? address;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBottomSheetC = ref.read(appBottomSheetCtrlProvider.notifier);
    final favorites = ref.watch(favoritesServiceProvider).valueOrNull ?? [];
    final c = ref.read(favoritesServiceProvider.notifier);
    var item = c.currentFavorites;

    if (address != null) {
      item = favorites.where((e) => e.address == address).firstOrNull ??
          Favorites.empty;
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
                  12.sbHeight,
                  AppText.bodyRegularCond(
                    'mobile.really_want_delete_address'.tr(),
                  ),
                  44.sbHeight,
                  Row(
                    children: [
                      Expanded(
                        child: AppButton.strokeL(
                          text: 'mobile.delete'.tr(),
                          isNegative: true,
                          onTap: () {
                            appBottomSheetC
                              ..pinConfirm(
                                ifEqualsStartFunc: () {
                                  c.destroyFavorites(favoriteId: item.id);
                                  appBottomSheetC.closeSheet();
                                },
                              )
                              ..updateOnTapClose(() {
                                c.timerCompleter.complete(false);
                                appBottomSheetC.closeSheet();
                              });
                          },
                        ),
                      ),
                      12.sbWidth,
                      Expanded(
                        child: AppButton.primaryL(
                          text: 'mobile.cancellation'.tr(),
                          onTap: () {
                            c.timerCompleter.complete(false);
                            appBottomSheetC.closeSheet();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
