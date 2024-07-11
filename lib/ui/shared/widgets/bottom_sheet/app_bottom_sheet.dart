import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/logic/repo/info/estimate_fee_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/info/wallet_check_provider.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button_icon.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

part 'widgets/_drag_handle.dart';
part 'widgets/_header.dart';

/// UI BottomSheet
class AppBottomSheet extends ConsumerStatefulWidget {
  /// UI BottomSheet
  const AppBottomSheet({
    required this.child,
    required this.title,
    required this.onTapClose,
    required this.height,
    required this.onTapBack,
    required this.isActiveSheet,
    required this.hasInsideScroll,
    this.colorBg,
    super.key,
  });

  //== Настройки заголовка ==/
  /// Заголовок
  final String title;

  /// Кнопка закрытия
  final void Function() onTapClose;

  /// Кнопка назад
  final void Function()? onTapBack;

  //== Настройки по UI ==/

  /// Активный bottom sheet
  final bool isActiveSheet;

  /// имеет внутреннюю прокрутку
  final bool hasInsideScroll;

  /// высота BottomSheet
  final double? height;

  ///
  final Widget child;

  /// Цвет фона
  final Color? colorBg;

  @override
  ConsumerState<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends ConsumerState<AppBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// слушатели
    ref
      ..watch(estimateFeeCtrlProvider)
      ..watch(walletCheckCtrlProvider);

    final heightStatusBar = MediaQuery.of(context).viewPadding.top;
    const radius = BorderRadius.vertical(top: Radius.circular(24));

    final isDarkColorBg =
        getColorLuminance(widget.colorBg ?? AppColors.primaryDull);

    final smallScreen = screenHeight < Consts.smallScreenHeight;

    final keyboardH = MediaQuery.of(context).viewInsets.bottom;
    return Material(
      color: AppColors.primaryDull,
      shape: const RoundedRectangleBorder(
        borderRadius: radius,
      ),
      child: AnimatedContainer(
        duration: Consts.animateDuration,
        curve: Consts.curveCubic,
        height: (widget.height ?? 0) + keyboardH,
        width: screenWidth,
        constraints: BoxConstraints(
          maxHeight: smallScreen
              ? screenHeight
              : screenHeight - Consts.toolbarHeight - heightStatusBar,
        ),
        decoration: const BoxDecoration(
          borderRadius: radius,
          color: Colors.transparent,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: radius,
              child: ColoredBox(
                color: widget.colorBg ?? Colors.transparent,
                child: Column(
                  children: [
                    const _DragHandle(),
                    _Header(
                      title: widget.title,
                      onTapClose: widget.onTapClose,
                      onTapBack: widget.onTapBack,
                      isDarkColorBg: isDarkColorBg,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}
