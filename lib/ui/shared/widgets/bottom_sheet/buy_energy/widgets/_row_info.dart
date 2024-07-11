part of '../buy_energy.dart';

class _RowInfo extends StatelessWidget {
  const _RowInfo({
    required this.leftText,
    this.rightText,
    this.rightWidget,
    this.rightErrorText,
    this.isDisabled = false,
    super.key,
  });

  final String leftText;
  final String? rightText;
  final String? rightErrorText;
  final bool isDisabled;

  final Widget? rightWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText.bodyMedium(
          leftText,
          color: AppColors.bwGrayBright,
        ),
        if (rightWidget != null)
          rightWidget!
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText.bodySemiBoldCond(
                rightText,
                color: isDisabled ? AppColors.negativeBright : null,
              ),
              if (isDisabled) ...[
                16.sbHeight,
                AppText.bodySemiBoldCond(
                  rightErrorText,
                  color: AppColors.negativeBright,
                ),
              ],
            ],
          ),
      ],
    );
  }
}
