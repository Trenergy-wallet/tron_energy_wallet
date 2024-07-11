import 'package:flutter/material.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Текст кнопка - ссылка
class AppButtonText extends StatefulWidget {
  /// Текст кнопка - ссылка
  const AppButtonText({
    required this.text,
    this.onTap,
    this.type,
    this.colorText,
    this.disabledColorText,
    this.hoverColorText,
    this.leftPathIcon,
    this.rightPathIcon,
    this.isDisabled = false,
    super.key,
  });

  /// Текст
  final String text;

  /// Цвет текста
  final Color? colorText;

  /// Цвет текста неактивного состояния
  final Color? disabledColorText;

  /// Цвет фона при наведении
  final Color? hoverColorText;

  ///
  final void Function()? onTap;

  /// Тип
  final AppTextType? type;

  /// Иконка слева
  final String? leftPathIcon;

  /// Иконка справа
  final String? rightPathIcon;

  /// Заблокирована
  final bool isDisabled;

  @override
  State<AppButtonText> createState() => _AppButtonTextState();
}

class _AppButtonTextState extends State<AppButtonText> {
  bool isPressed = false;

  //== text ==//
  Color get clrText => widget.colorText ?? AppColors.blueVioletBright;
  Color get hoverClrText => widget.hoverColorText ?? AppColors.blueVioletMid;
  Color get disClrText => widget.disabledColorText ?? AppColors.blueVioletDull;

  @override
  Widget build(BuildContext context) {
    final dynamicClrText = widget.isDisabled
        ? disClrText
        : isPressed
            ? hoverClrText
            : clrText;
    return Material(
      color: Colors.transparent,
      child: Ink(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          overlayColor: WidgetStateColor.resolveWith(
            (states) {
              addPostFrameCallback(() {
                final p = states.contains(WidgetState.pressed);
                setState(() {
                  isPressed = p;
                });
              });
              return AppColors.transparent;
            },
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.leftPathIcon != null) ...[
                AppIcons.icon(
                  widget.leftPathIcon!,
                  color: dynamicClrText,
                  width: 16,
                  height: 16,
                ),
                4.sbWidth,
              ],
              Flexible(
                child: AppText(
                  widget.text,
                  style: widget.type?.withColor(
                        color: dynamicClrText,
                      ) ??
                      AppTextType.buttonsLink.withColor(
                        color: dynamicClrText,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.rightPathIcon != null) ...[
                4.sbWidth,
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
    );
  }
}
