import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/domain/favorites/favorites.cg.dart';
import 'package:trenergy_wallet/logic/repo/favorites/favorites_provider.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/send/send_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/preloader.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

part 'widgets/_item_favorite.dart';

///
class FavoritesSheet extends ConsumerStatefulWidget {
  ///
  const FavoritesSheet({super.key});

  @override
  ConsumerState<FavoritesSheet> createState() => _FavoritesSheetState();
}

class _FavoritesSheetState extends ConsumerState<FavoritesSheet> {
  double progress = 0;

  AppBottomSheetCtrl get appBottomSctrl =>
      ref.read(appBottomSheetCtrlProvider.notifier);

  void changeProgress(double p) {
    setState(() {
      progress = p;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(sendCtrlProvider);
    final favoritesService = ref.watch(favoritesServiceProvider);
    final favorites = favoritesService.valueOrNull ?? [];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          if (favoritesService.isLoading)
            const Expanded(child: Preloader(isCoins: true))
          else if (favorites.isEmpty) ...[
            16.sbHeight,
            AppText.bodySmallTextCond(
              'mobile.your_saved_addresses_here'.tr(),
              color: AppColors.bwGrayBright,
            ),
            8.sbHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText.bodySmallTextCond(
                  'mobile.click_to_add'.tr(),
                  color: AppColors.bwGrayBright,
                ),
                4.sbWidth,
                AppIcons.addOutline(
                  color: AppColors.bwGrayBright,
                  width: 16,
                  height: 16,
                ),
                AppText.bodySmallTextCond(
                  'mobile.click_to_add_addres'.tr(),
                  color: AppColors.bwGrayBright,
                ),
              ],
            ),
          ] else ...[
            16.sbHeight,
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: screenWidth,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: AppColors.primaryDull,
                    border: Border.all(
                      color: AppColors.bwBrightPrimary,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: favorites.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (c, i) {
                      final favorite = favorites[i];
                      final isFirst = i == 0;
                      final isLast = i == favorites.length - 1;

                      return _ItemFavorite(
                        favorite: favorite,
                        iconPath: AppIcons.trenergyBadgeIcon,
                        rightWidget: AbsorbPointer(
                          child: AppButtonText(
                            text: 'mobile.сhoose'.tr(),
                          ),
                        ),
                        hasDivider: i < favorites.length - 1,
                        isFirst: isFirst,
                        isLast: isLast,
                        onTap: () {
                          ref
                              .read(sendCtrlProvider.notifier)
                              .updateAddressRecipient(favorite.address);
                          delayMs(Consts.humanFriendlyDelay * 3).then(
                            (value) => ref
                                .read(appBottomSheetCtrlProvider.notifier)
                                .addressRecipient(),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            32.sbHeight,
          ],
        ],
      ),
    );
  }
}
