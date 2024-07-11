import 'package:flutter/material.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/img_network.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Transfer row
class TransferRowBlock extends StatelessWidget {
  /// Transfer row
  const TransferRowBlock({
    required this.leftText,
    this.rightText,
    this.pathImg,
    this.rightWidget,
    super.key,
  });

  /// Left text
  final String leftText;

  /// Right text
  final String? rightText;

  /// Right widget
  final Widget? rightWidget;

  /// Path img
  final String? pathImg;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: AppText.bodyMedium(
            leftText,
            color: AppColors.bwGrayBright,
          ),
        ),
        8.sbWidth,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (pathImg != null) ...[
              ImgNetwork(
                pathImg: pathImg!,
                width: 16,
                height: 16,
              ),
              8.sbWidth,
            ],
            if (rightWidget != null)
              rightWidget ?? const SizedBox.shrink()
            else
              AppText.bodySemiBoldCond(
                rightText ?? '',
                textAlign: TextAlign.end,
              ),
          ],
        ),
      ],
    );
  }
}
