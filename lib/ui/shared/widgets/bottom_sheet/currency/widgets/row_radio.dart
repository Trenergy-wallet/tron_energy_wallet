import 'package:flutter/material.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/img_network.dart';
import 'package:trenergy_wallet/ui/shared/widgets/rive/radio_button.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// RowRadio выбор валюты
class RowRadio extends StatelessWidget {
  /// RowRadio выбор валюты
  const RowRadio({
    required this.name,
    required this.code,
    required this.onTap,
    required this.isActive,
    this.amount,
    this.pathImg,
    super.key,
  });

  /// Curreny / Валюта
  final String name;

  /// Code
  final String code;

  /// Amount
  final double? amount;

  /// Нажатие
  final void Function() onTap;

  /// активный
  final bool isActive;

  /// Иконка
  final String? pathImg;

  @override
  Widget build(BuildContext context) {
    final numbAmount = numbWithoutZero(amount ?? 0);
    return Material(
      color: Colors.transparent,
      borderRadius: Consts.borderRadiusAll8,
      child: InkWell(
        borderRadius: Consts.borderRadiusAll8,
        onTap: onTap,
        child: Ink(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: Consts.borderRadiusAll8,
            color: isActive ? AppColors.buttonsLimeDull : AppColors.primaryMid,
            border: Border.all(
              color:
                  isActive ? AppColors.bwBrightPrimary : AppColors.primaryMid,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (pathImg != null) ...[
                ImgNetwork(
                  pathImg: pathImg!,
                  width: 32,
                  height: 32,
                ),
                4.sbWidth,
              ],
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.bodySmallText(
                      name,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (amount != null)
                      AppText.bodyCaption(
                        numbAmount,
                        color: AppColors.bwGrayBright,
                      ),
                  ],
                ),
              ),
              4.sbWidth,
              AppText.bodySmallText(code),
              12.sbWidth,
              AbsorbPointer(
                child: RiveRadioButton(
                  isOn: isActive,
                  onTap: (_) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
