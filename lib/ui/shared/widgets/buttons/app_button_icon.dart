import 'package:flutter/material.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Icon кнопка
class AppButtonIcon extends StatefulWidget {
  /// Icon кнопка
  const AppButtonIcon({
    required this.iconPath,
    this.onTap,
    this.isDisabled = false,
    this.colorBg,
    this.hoverBg,
    this.colorIcon,
    this.customColorIcon,
    this.colorIconPress,
    super.key,
  });

  /// [AppButtonIcon.light]
  AppButtonIcon.light({
    required this.iconPath,
    required this.onTap,
    this.isDisabled = false,
    this.customColorIcon,
    super.key,
  })  : colorBg = AppColors.transparent,
        hoverBg = AppColors.primaryMid,
        colorIcon = isDisabled
            ? AppColors.bwGrayMid
            : customColorIcon ?? AppColors.blackBright,
        colorIconPress =
            isDisabled ? AppColors.bwGrayMid : AppColors.bwGrayBright;

  /// [AppButtonIcon.lime]
  AppButtonIcon.lime({
    required this.iconPath,
    required this.onTap,
    this.isDisabled = false,
    this.customColorIcon,
    super.key,
  })  : colorBg = isDisabled
            ? AppColors.buttonsLimeDull
            : AppColors.buttonsLimeBright,
        hoverBg = AppColors.buttonsLimeMid,
        colorIcon = isDisabled ? AppColors.bwGrayDull : AppColors.blackBright,
        colorIconPress =
            isDisabled ? AppColors.bwGrayDull : AppColors.bwBrightPrimary;

  /// ссылка на иконку
  final String iconPath;

  /// Функция нажатия
  final void Function()? onTap;

  ///
  final bool isDisabled;

  ///
  final Color? colorBg;

  ///
  final Color? hoverBg;

  ///
  final Color? colorIcon;

  ///
  final Color? customColorIcon;

  ///
  final Color? colorIconPress;

  @override
  State<AppButtonIcon> createState() => _AppButtonIconState();
}

class _AppButtonIconState extends State<AppButtonIcon> {
  var _onPress = false;

  void down() {
    setState(() {
      _onPress = true;
    });
  }

  void up() {
    setState(() {
      _onPress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: Consts.borderRadiusAll8,
      color: widget.colorBg,
      child: InkWell(
        borderRadius: Consts.borderRadiusAll8,
        onTapDown: widget.isDisabled ? null : (details) => down(),
        onTapUp: widget.isDisabled ? null : (details) => up(),
        onTap: widget.isDisabled ? null : widget.onTap,
        splashColor: widget.hoverBg,
        highlightColor: widget.hoverBg,
        child: Ink(
          width: 32,
          height: 32,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: Consts.borderRadiusAll8,
            color: widget.colorBg,
          ),
          child: AppIcons.icon(
            widget.iconPath,
            width: 20,
            height: 20,
            color: _onPress ? widget.colorIconPress : widget.colorIcon,
          ),
        ),
      ),
    );
  }
}
