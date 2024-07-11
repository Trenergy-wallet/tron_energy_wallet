import 'package:flutter/material.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Кнопка
class AppButton extends StatefulWidget {
  /// Кнопка
  const AppButton({
    this.text,
    required this.onTap,
    this.width,
    this.height,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.type = AppTextType.lButtonSemiB,
    this.leftPathIcon,
    this.rightPathIcon,
    this.background,
    this.disabledBg,
    this.hoverColorBg,
    this.colorText,
    this.disabledColorText,
    this.hoverColorText,
    this.borderColor,
    this.disBorderColor,
    this.hoverBorderColor,
    this.borderRadius = 9,
    this.isDisabled = false,
    this.isNegative = false,
    this.iconPath,
    super.key,
  });

  /// [AppButton.limeL]
  AppButton.limeL({
    this.text,
    required this.onTap,
    this.width,
    this.height,
    this.leftPathIcon,
    this.rightPathIcon,
    this.isDisabled = false,
    this.isNegative = false,
    super.key,
  })  : borderRadius = 12,
        iconPath = null,
        background = isNegative
            ? AppColors.negativeContrastBright
            : AppColors.buttonsLimeBright,
        hoverColorBg = isNegative
            ? AppColors.negativeContrastMid
            : AppColors.buttonsLimeMid,
        disabledBg = isNegative
            ? AppColors.negativeContrastDull
            : AppColors.buttonsLimeDull,
        colorText = AppColors.blackBright,
        hoverColorText = AppColors.blackBright,
        disabledColorText = AppColors.grayMid,
        borderColor = AppColors.blackBright,
        hoverBorderColor = AppColors.blackBright,
        disBorderColor = AppColors.blackBright,
        type = AppTextType.lButtonSemiB,
        padding = EdgeInsets.symmetric(
          horizontal: width == null ? 16 : 0,
          vertical: height == null ? 17 : 0,
        );

  /// [AppButton.limeM]
  AppButton.limeM({
    this.text,
    required this.onTap,
    this.width,
    this.height,
    this.leftPathIcon,
    this.rightPathIcon,
    this.isDisabled = false,
    this.isNegative = false,
    super.key,
  })  : borderRadius = 12,
        iconPath = null,
        background = isNegative
            ? AppColors.negativeContrastBright
            : AppColors.buttonsLimeBright,
        hoverColorBg = isNegative
            ? AppColors.negativeContrastMid
            : AppColors.buttonsLimeMid,
        disabledBg = isNegative
            ? AppColors.negativeContrastDull
            : AppColors.buttonsLimeDull,
        colorText = AppColors.blackBright,
        hoverColorText = AppColors.blackBright,
        disabledColorText = AppColors.grayMid,
        borderColor = AppColors.blackBright,
        hoverBorderColor = AppColors.blackBright,
        disBorderColor = AppColors.blackBright,
        type = AppTextType.lButtonSemiB,
        padding = EdgeInsets.symmetric(
          horizontal: width == null ? 16 : 0,
          vertical: height == null ? 11 : 0,
        );

  /// [AppButton.primaryL]
  AppButton.primaryL({
    this.text,
    required this.onTap,
    this.width,
    this.height,
    this.leftPathIcon,
    this.rightPathIcon,
    this.isDisabled = false,
    this.isNegative = false,
    super.key,
  })  : borderRadius = 12,
        iconPath = null,
        background = isNegative
            ? AppColors.negativeContrastBright
            : AppColors.buttonsBWBright,
        hoverColorBg =
            isNegative ? AppColors.negativeContrastMid : AppColors.buttonsBWMid,
        disabledBg = isNegative
            ? AppColors.negativeContrastDull
            : AppColors.buttonsBWDull,
        colorText =
            isNegative ? AppColors.blackBright : AppColors.buttonsLimeBright,
        hoverColorText =
            isNegative ? AppColors.blackBright : AppColors.buttonsLimeMid,
        disabledColorText =
            isNegative ? AppColors.grayMid : AppColors.buttonsLimeDull,
        borderColor = AppColors.blackBright,
        hoverBorderColor = AppColors.blackBright,
        disBorderColor = AppColors.grayMid,
        type = AppTextType.lButtonSemiB,
        padding = EdgeInsets.symmetric(
          horizontal: width == null ? 16 : 0,
          vertical: height == null ? 17 : 0,
        );

  /// [AppButton.primaryM]
  AppButton.primaryM({
    this.text,
    required this.onTap,
    this.width,
    this.height,
    this.leftPathIcon,
    this.rightPathIcon,
    this.isDisabled = false,
    this.isNegative = false,
    super.key,
  })  : borderRadius = 12,
        iconPath = null,
        background = isNegative
            ? AppColors.negativeContrastBright
            : AppColors.buttonsBWBright,
        hoverColorBg =
            isNegative ? AppColors.negativeContrastMid : AppColors.buttonsBWMid,
        disabledBg = isNegative
            ? AppColors.negativeContrastDull
            : AppColors.buttonsBWDull,
        colorText =
            isNegative ? AppColors.blackBright : AppColors.buttonsLimeBright,
        hoverColorText =
            isNegative ? AppColors.blackBright : AppColors.buttonsLimeMid,
        disabledColorText =
            isNegative ? AppColors.grayMid : AppColors.buttonsLimeDull,
        borderColor = AppColors.blackBright,
        hoverBorderColor = AppColors.blackBright,
        disBorderColor = AppColors.grayMid,
        type = AppTextType.lButtonSemiB,
        padding = EdgeInsets.symmetric(
          horizontal: width == null ? 16 : 0,
          vertical: height == null ? 11 : 0,
        );

  /// [AppButton.strokeL]
  AppButton.strokeL({
    this.text,
    required this.onTap,
    this.width,
    this.height,
    this.leftPathIcon,
    this.rightPathIcon,
    this.isDisabled = false,
    this.isNegative = false,
    super.key,
  })  : borderRadius = 12,
        iconPath = null,
        background = AppColors.transparent,
        hoverColorBg = AppColors.transparent,
        disabledBg = AppColors.transparent,
        colorText =
            isNegative ? AppColors.negativeBright : AppColors.bwBrightPrimary,
        hoverColorText =
            isNegative ? AppColors.negativeMid : AppColors.bwGrayBright,
        disabledColorText =
            isNegative ? AppColors.negativeDull : AppColors.bwGrayMid,
        borderColor =
            isNegative ? AppColors.negativeBright : AppColors.blackBright,
        hoverBorderColor =
            isNegative ? AppColors.negativeMid : AppColors.bwGrayBright,
        disBorderColor =
            isNegative ? AppColors.negativeDull : AppColors.grayMid,
        type = AppTextType.lButtonSemiB,
        padding = EdgeInsets.symmetric(
          horizontal: width == null ? 16 : 0,
          vertical: height == null ? 17 : 0,
        );

  /// [AppButton.strokeM]
  AppButton.strokeM({
    this.text,
    required this.onTap,
    this.width,
    this.height,
    this.leftPathIcon,
    this.rightPathIcon,
    this.isDisabled = false,
    this.isNegative = false,
    super.key,
  })  : borderRadius = 12,
        iconPath = null,
        background = AppColors.transparent,
        hoverColorBg = AppColors.transparent,
        disabledBg = AppColors.transparent,
        colorText =
            isNegative ? AppColors.negativeBright : AppColors.bwBrightPrimary,
        hoverColorText =
            isNegative ? AppColors.negativeMid : AppColors.bwGrayBright,
        disabledColorText =
            isNegative ? AppColors.negativeDull : AppColors.bwGrayMid,
        borderColor =
            isNegative ? AppColors.negativeBright : AppColors.blackBright,
        hoverBorderColor =
            isNegative ? AppColors.negativeMid : AppColors.bwGrayBright,
        disBorderColor =
            isNegative ? AppColors.negativeDull : AppColors.grayMid,
        type = AppTextType.lButtonSemiB,
        padding = EdgeInsets.symmetric(
          horizontal: width == null ? 16 : 0,
          vertical: height == null ? 11 : 0,
        );

  /// [AppButton.secondaryBlue]
  AppButton.secondaryBlue({
    this.text,
    required this.onTap,
    this.height,
    this.width,
    this.leftPathIcon,
    this.rightPathIcon,
    this.isDisabled = false,
    this.isNegative = false,
    super.key,
  })  : borderRadius = 40,
        iconPath = null,
        background = AppColors.buttonsBlueBright,
        colorText = AppColors.blackBright,
        disabledBg = AppColors.buttonsBlueDull,
        hoverColorBg = AppColors.buttonsBlueMid,
        disabledColorText = AppColors.grayDull,
        hoverColorText = AppColors.blackBright,
        disBorderColor = AppColors.transparent,
        borderColor = AppColors.transparent,
        hoverBorderColor = AppColors.grayMid,
        type = AppTextType.mButtonMedium,
        padding = const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        );

  /// [AppButton.secondaryViolet]
  AppButton.secondaryViolet({
    this.text,
    required this.onTap,
    this.height,
    this.width,
    this.leftPathIcon,
    this.rightPathIcon,
    this.isDisabled = false,
    this.isNegative = false,
    super.key,
  })  : borderRadius = 40,
        iconPath = null,
        background = AppColors.buttonsVioletBright,
        colorText = AppColors.blackBright,
        disabledBg = AppColors.buttonsVioletDull,
        hoverColorBg = AppColors.buttonsVioletMid,
        disabledColorText = AppColors.grayDull,
        hoverColorText = AppColors.blackBright,
        disBorderColor = AppColors.transparent,
        borderColor = AppColors.transparent,
        hoverBorderColor = AppColors.grayMid,
        type = AppTextType.mButtonMedium,
        padding = const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        );

  /// [AppButton.numpad]
  AppButton.numpad({
    this.text,
    required this.onTap,
    this.iconPath,
    this.width,
    this.height,
    super.key,
  })  : borderRadius = 60,
        isDisabled = false,
        leftPathIcon = null,
        rightPathIcon = null,
        isNegative = false,
        // width = 100,
        // height = 72,
        background = AppColors.transparent,
        colorText = AppColors.bwBrightPrimary,
        borderColor = AppColors.blackBright,
        hoverColorBg = AppColors.buttonsLimeMid,
        hoverColorText = AppColors.blackBright,
        disabledBg = AppColors.buttonsLimeDull,
        disabledColorText = AppColors.grayMid,
        disBorderColor = AppColors.grayMid,
        hoverBorderColor = AppColors.grayMid,
        type = AppTextType.buttonsNumpad,
        padding = EdgeInsets.symmetric(vertical: height == null ? 20 : 0);

  /// [AppButton.tertiary]
  AppButton.tertiary({
    this.text,
    required this.onTap,
    this.width,
    this.height,
    this.leftPathIcon,
    this.rightPathIcon,
    this.isDisabled = false,
    this.isNegative = false,
    this.background,
    super.key,
  })  : borderRadius = 12,
        iconPath = null,
        hoverColorBg = isNegative
            ? AppColors.negativeContrastMid
            : AppColors.buttonsLavenderBright,
        disabledBg = isNegative
            ? AppColors.negativeContrastDull
            : AppColors.negativeContrastDull,
        colorText = AppColors.bwBrightPrimary,
        hoverColorText = AppColors.bwBrightPrimary,
        disabledColorText = AppColors.bwGrayMid,
        borderColor = AppColors.transparent,
        hoverBorderColor = AppColors.transparent,
        disBorderColor = AppColors.transparent,
        type = AppTextType.mButtonMedium,
        padding = EdgeInsets.symmetric(
          horizontal: width == null ? 8 : 0,
          vertical: height == null ? 4 : 0,
        );

  /// Ширина
  final double? width;

  /// Высота
  final double? height;

  /// Текст кнопки
  final String? text;

  /// Цвет текста
  final Color? colorText;

  /// Цвет текста неактивного состояния
  final Color? disabledColorText;

  /// Цвет фона при наведении
  final Color? hoverColorText;

  /// Цвет фона
  final Color? background;

  /// Цвет фона неактивного состояния
  final Color? disabledBg;

  /// Цвет фона при наведении
  final Color? hoverColorBg;

  /// Цвет границы неактивного состояния
  final Color? disBorderColor;

  /// Цвет границы
  final Color? borderColor;

  /// Цвет границы при наведении
  final Color? hoverBorderColor;

  /// Тип текста
  final AppTextType type;

  /// Внутренние отступы
  final EdgeInsetsGeometry? padding;

  /// иконка слева
  final String? leftPathIcon;

  /// иконка справа
  final String? rightPathIcon;

  /// Нажатие
  final void Function() onTap;

  /// Заблокирована
  final bool isDisabled;

  /// Красная кнопка
  final bool isNegative;

  /// Радиус
  final double borderRadius;

  /// Иконка вместо текста
  final String? iconPath;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool isPressed = false;

  //== background ==//
  Color get disClrBg => widget.disabledBg ?? AppColors.grayMid;
  Color get clrBg => widget.background ?? AppColors.blackBright;
  Color get hoverClrBg => widget.hoverColorBg ?? AppColors.blackBright;

  //== text ==//
  Color get disClrText => widget.disabledColorText ?? AppColors.grayMid;
  Color get clrText => widget.colorText ?? AppColors.blackBright;
  Color get hoverClrText => widget.hoverColorText ?? AppColors.blackBright;

  //== border ==//
  Color get disClrBorder => widget.disBorderColor ?? AppColors.grayMid;
  Color get clrBorder => widget.borderColor ?? AppColors.blackBright;
  Color get hoverClrBorder => widget.hoverBorderColor ?? AppColors.blackBright;

  @override
  Widget build(BuildContext context) {
    final dynamicClrBg = widget.isDisabled
        ? disClrBg
        : isPressed
            ? hoverClrBg
            : clrBg;

    final dynamicClrText = widget.isDisabled
        ? disClrText
        : isPressed
            ? hoverClrText
            : clrText;

    final dynamicClrBorder = widget.isDisabled
        ? disClrBorder
        : isPressed
            ? hoverClrBorder
            : clrBorder;

    /// отступы
    const gap = 8;

    //== Расчет ширины ==//

    /// ширина
    double? w;

    /// ширина текста
    final textPainter = TextPainter(
      text: TextSpan(
        text: widget.text,
        style: widget.type.withColor(color: AppColors.blackBright),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    /// ширина левой и правой иконок
    final leftIconW = widget.leftPathIcon != null ? Consts.iconSize + gap : 0;
    final rightIconW = widget.rightPathIcon != null ? Consts.iconSize + gap : 0;

    /// общая ширина
    final textW = textPainter.width +
        (widget.padding?.horizontal ?? 0) +
        leftIconW +
        rightIconW;

    /// если указана ширина и если она меньше ширины текста и иконок
    /// что бы не выходила ошибка
    if (widget.width != null) {
      if (textW > (widget.width ?? 0) && (widget.iconPath == null)) {
        w = textW.ceil().toDouble();
      } else {
        w = widget.width ?? 0;
      }
    }
    //== Расчет ширины ==//

    return Material(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      color: dynamicClrBg,
      child: InkWell(
        onTap: widget.isDisabled ? null : widget.onTap,
        overlayColor: WidgetStateColor.resolveWith(
          (states) {
            addPostFrameCallback(() {
              final p = states.contains(WidgetState.pressed);
              setState(() {
                isPressed = p;
              });
            });

            return hoverClrBg;
          },
        ),
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Container(
          width: w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(color: dynamicClrBorder),
          ),
          child: Ink(
            width: w,
            height: widget.height,
            padding: widget.padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius - 1),
              color: dynamicClrBg,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.leftPathIcon != null) ...[
                  AppIcons.icon(
                    widget.leftPathIcon!,
                    color: dynamicClrText,
                    width: 16,
                    height: 16,
                  ),
                  gap.sbWidth,
                ],
                if (widget.iconPath != null)
                  AppIcons.icon(widget.iconPath!)
                else
                  AppText(
                    widget.text ?? '',
                    style: widget.type.withColor(color: dynamicClrText),
                  ),
                if (widget.rightPathIcon != null) ...[
                  gap.sbWidth,
                  AppIcons.icon(
                    widget.rightPathIcon!,
                    color: dynamicClrText,
                    width: 16,
                    height: 16,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
