import 'package:animated_transform/animated_transform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/ui/router/router.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/rive/chat.dart';
import 'package:trenergy_wallet/ui/shared/widgets/rive/settings.dart';
import 'package:trenergy_wallet/ui/shared/widgets/rive/wallet.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Экран навигации
class NavScreen extends ConsumerWidget {
  /// Экран навигации
  const NavScreen({
    super.key,
    required this.navigationShell,
    required this.currentIndex,
    this.hasBottomNav = true,
  });

  ///
  final StatefulNavigationShell navigationShell;

  /// Текущий индекс
  final int currentIndex;

  /// Есть ли нижняя панель
  final bool hasBottomNav;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bs = ref.watch(appBottomSheetCtrlProvider);
    final bsNotif = ref.watch(appBottomSheetCtrlProvider.notifier);

    void handleBackButtonPressed(bool didPop) {
      if (!didPop) {
        // Обработка ситуации, когда поп был заблокирован
        tryGoBack();
      } else {
        // Обработка успешного попа
      }
    }

    return PopScope(
      canPop: false,
      onPopInvoked: handleBackButtonPressed,
      child: Stack(
        children: [
          MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: Scaffold(
              /// AppBar для регулировки темы когда вызывается bottomSheet
              appBar: AppBar(
                toolbarHeight: 0,
                forceMaterialTransparency: true,
                backgroundColor: bs.isActiveSheet
                    ? AppColors.blueVioletBright
                    : AppColors.primaryMid,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness:
                      bs.isActiveSheet ? Brightness.light : Brightness.dark,
                  statusBarBrightness:
                      bs.isActiveSheet ? Brightness.dark : Brightness.light,
                ),
              ),
              backgroundColor: bs.isActiveSheet
                  ? AppColors.blueVioletBright
                  : AppColors.primaryMid,

              /// Rive меню / Панель навигации
              bottomNavigationBar: hasBottomNav
                  ? Padding(
                      padding: const EdgeInsets.only(
                        left: 16.5,
                        right: 16.5,
                        bottom: 2,
                      ),
                      child: Theme(
                        data: ThemeData(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        child: BottomNavigationBar(
                          backgroundColor: AppColors.primaryMid,
                          elevation: 0,
                          type: BottomNavigationBarType.fixed,
                          items: [
                            BottomNavigationBarItem(
                              icon: RiveWallet(isActive: currentIndex == 0),
                              label: '',
                            ),
                            BottomNavigationBarItem(
                              icon: RiveChat(isActive: currentIndex == 1),
                              label: '',
                            ),
                            BottomNavigationBarItem(
                              icon: RiveSettings(isActive: currentIndex == 2),
                              label: '',
                            ),
                          ],
                          currentIndex: currentIndex,
                          onTap: navigationShell.goBranch,
                          iconSize: 30,
                          unselectedFontSize: 30,
                          fixedColor: AppColors.blackBright,
                        ),
                      ),
                    )
                  : null,

              /// Экраны
              body: AnimatedTransform(
                scale: bs.isActiveSheet ? .95 : 1,
                duration: Consts.animateDuration,
                curve: Consts.curveCubic,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(bs.isActiveSheet ? 24 : 0),
                  ),
                  child: navigationShell,
                ),
              ),
            ),
          ),

          /// Полупрозрачный фон
          AnimatedOpacity(
            duration: Consts.animateDuration,
            curve: Consts.curveCubic,
            opacity: bs.isActiveSheet ? 1 : 0,
            child: GestureDetector(
              onTap: bs.onTapBackground ?? bsNotif.closeSheet,
              child: Container(
                width: screenWidth,
                height: bs.isActiveSheet ? screenHeight : 0,
                color: AppColors.dimDark,
              ),
            ),
          ),

          /// Отрисовка UI BottomSheet
          AnimatedPositioned(
            duration: Consts.animateDuration,
            curve: Consts.curveCubic,
            bottom: bs.isActiveSheet ? 0 : -bs.height,
            child: AppBottomSheet(
              title: bs.title,
              onTapBack: bs.onTapBack,
              onTapClose: bs.onTapClose,
              isActiveSheet: bs.isActiveSheet,
              hasInsideScroll: bs.hasInsideScroll,
              height: bs.height,
              colorBg: bs.colorBg,
              child: bs.child,
            ),
          ),
        ],
      ),
    );
  }
}
