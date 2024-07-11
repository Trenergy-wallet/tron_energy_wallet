import 'package:flutter/material.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// ItemContainer
class ItemContainer extends StatelessWidget {
  /// ItemContainer
  const ItemContainer({
    required this.title,
    this.iconPath,
    this.onTap,
    this.rightWidget,
    this.color,
    this.hasDivider = true,
    this.isFirst = false,
    this.isLast = false,
    this.paddingDivider = const EdgeInsets.only(left: 44),
    super.key,
  });

  ///
  final String title;

  ///
  final Widget? rightWidget;

  ///
  final String? iconPath;

  ///
  final bool hasDivider;

  ///
  final void Function()? onTap;

  ///
  final bool isFirst;

  ///
  final bool isLast;

  ///
  final Color? color;

  /// отступ для разделителя
  final EdgeInsetsGeometry paddingDivider;

  @override
  Widget build(BuildContext context) {
    final radius = isFirst && isLast
        ? const BorderRadius.all(Radius.circular(16))
        : isFirst
            ? const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              )
            : isLast
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  )
                : BorderRadius.zero;

    return Material(
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Ink(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Row(
                  children: [
                    if (iconPath != null)
                      AppIcons.icon(
                        iconPath!,
                        width: 20,
                        height: 20,
                        color: color,
                      ),
                    12.sbWidth,
                    AppText.bodySubTitle(
                      title,
                      color: color,
                    ),
                    if (rightWidget != null) ...[
                      const Spacer(),
                      rightWidget!,
                    ],
                  ],
                ),
              ),
              if (hasDivider)
                Padding(
                  padding: paddingDivider,
                  child: Divider(height: 1, color: AppColors.bwBrightPrimary),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
