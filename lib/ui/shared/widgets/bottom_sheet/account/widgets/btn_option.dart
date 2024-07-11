import 'package:flutter/material.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Кнопка выбор аккаунта кошелька
class BtnOption extends StatelessWidget {
  /// Кнопка выбор аккаунта кошелька
  const BtnOption({
    required this.title,
    required this.icon,
    required this.iconColorBg,
    required this.onTap,
    this.isActive = false,
    super.key,
  });

  /// Заголовок
  final String title;

  /// Функция нажатия
  final void Function() onTap;

  /// Иконка
  final Widget icon;

  /// Цвет фона иконки
  final Color iconColorBg;

  /// Активен ли аккаунт
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Ink(
          padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border: Border.all(
              color: AppColors.bwBrightPrimary,
              width: isActive ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: iconColorBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: icon,
              ),
              8.sbWidth,
              AppText.bodySubTitle(title),
              const Spacer(),
              AppIcons.arrowRight(),
            ],
          ),
        ),
      ),
    );
  }
}
