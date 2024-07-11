import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/domain/favorites/favorites.cg.dart';
import 'package:trenergy_wallet/logic/repo/favorites/favorites_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/ui/screens/favorites/widgets/item_favorite.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_scaffold/enter/app_scaffold.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/appbar/appbar_simple.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button_icon.dart';
import 'package:trenergy_wallet/ui/shared/widgets/rive/switch.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

part 'widgets/_send_only_favorites.dart';

///
class FavoritesScreen extends ConsumerStatefulWidget {
  ///
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  double progress = 0;

  AppBottomSheetCtrl get appBottomSctrl =>
      ref.read(appBottomSheetCtrlProvider.notifier);

  void changeProgress(double p) {
    setState(() {
      progress = p;
    });
  }

  ///
  Future<bool?> confirmDismiss(
    DismissDirection direction, {
    required Favorites item,
  }) async {
    if (direction == DismissDirection.endToStart) {
      ref.read(favoritesServiceProvider.notifier).chooseFavorites(item);

      return appBottomSctrl.deleteFavorite();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final favoritesService = ref.watch(favoritesServiceProvider);
    final favorites = favoritesService.valueOrNull ?? [];
    return AppScaffold(
      appBar: SimpleAppBar(
        title: 'mobile.favorites_addresses'.tr(),
        actions: [
          AppButtonIcon.lime(
            iconPath: AppIcons.addOutlineIcon,
            onTap: () {
              appBottomSctrl.addFavorite();
            },
          ),
          12.sbWidth,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            16.sbHeight,
            const _SendOnlyFavorites(),
            if (favorites.isEmpty) ...[
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
                  4.sbWidth,
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
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: favorites.length,
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 44),
                          child: Divider(
                            height: 1,
                            color: AppColors.bwBrightPrimary,
                          ),
                        );
                      },
                      itemBuilder: (c, i) {
                        final isFirst = i == 0;
                        final isLast = i == favorites.length - 1;
                        final p = (progress * (screenWidth - 50)) / 2;

                        final radius = isFirst && isLast
                            ? const BorderRadius.all(Radius.circular(16))
                            : isFirst
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  )
                                : isLast
                                    ? const BorderRadius.only(
                                        bottomLeft: Radius.circular(16),
                                        bottomRight: Radius.circular(16),
                                      )
                                    : BorderRadius.zero;
                        return Dismissible(
                          key: Key(favorites[i].id.toString()),
                          background: Container(
                            decoration: BoxDecoration(
                              color: AppColors.negativeLightBright,
                              borderRadius: radius,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AppIcons.trash(
                                  color: AppColors.negativeBright,
                                ),
                                p.sbWidth,
                              ],
                            ),
                          ),
                          confirmDismiss: (v) {
                            return confirmDismiss(v, item: favorites[i]);
                          },
                          onUpdate: (details) {
                            changeProgress(details.progress);
                          },
                          direction: DismissDirection.endToStart,
                          child: ItemFavorite(
                            favorite: favorites[i],
                            iconPath: AppIcons.trenergyBadgeIcon,
                            rightWidget: GestureDetector(
                              onTap: () {
                                clipBoardCopy(
                                  favorites[i].address,
                                  tooltip: 'mobile.address_copied'.tr(
                                    namedArgs: {
                                      'address': favorites[i].address,
                                    },
                                  ),
                                );
                              },
                              child: AppIcons.copy(
                                width: 16,
                                height: 16,
                                color: AppColors.bwBrightPrimary,
                              ),
                            ),
                            onTap: () {
                              appBottomSctrl.patchFavorite(
                                id: favorites[i].id,
                                name: favorites[i].name,
                                address: favorites[i].address,
                              );
                            },
                            isFirst: isFirst,
                            isLast: isLast,
                          ),
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
      ),
    );
  }
}
