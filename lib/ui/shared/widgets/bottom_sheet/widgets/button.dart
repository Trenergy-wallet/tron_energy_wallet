import 'package:flutter/material.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button.dart';

/// Кнопка для bottom sheet
class ButtonBottomSheet extends StatelessWidget {
  /// Кнопка для bottom sheet
  const ButtonBottomSheet({
    required this.onTapBtn,
    required this.nameBtn,
    this.isLimeBtn = true,
    this.isDisabled = false,
    this.padHoriz = 0,
    super.key,
  });

  /// Кнопка
  final void Function() onTapBtn;

  /// Название кнопки
  final String nameBtn;

  /// Цвет кнопки
  final bool isLimeBtn;

  /// Отклонена ли кнопка
  final bool isDisabled;

  /// Отступы слева и справа
  final double padHoriz;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(padHoriz, 12, padHoriz, 0),
      child: isLimeBtn
          ? AppButton.limeL(
              onTap: onTapBtn,
              text: nameBtn,
              isDisabled: isDisabled,
            )
          : AppButton.primaryL(
              onTap: onTapBtn,
              text: nameBtn,
              isDisabled: isDisabled,
            ),
    );
  }
}
