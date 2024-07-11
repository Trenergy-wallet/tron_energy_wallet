import 'package:flutter/material.dart';
import 'package:trenergy_wallet/domain/favorites/favorites.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// ItemFavorite
class ItemFavorite extends StatelessWidget {
  /// ItemFavorite
  const ItemFavorite({
    required this.favorite,
    required this.iconPath,
    required this.rightWidget,
    required this.onTap,
    this.isFirst = false,
    this.isLast = false,
    super.key,
  });

  /// ItemFavorite
  final Favorites favorite;

  /// Правая часть
  final Widget rightWidget;

  /// Путь к иконке
  final String iconPath;

  /// Обработчик
  final void Function() onTap;

  /// Первый элемент
  final bool isFirst;

  /// Последний элемент
  final bool isLast;

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
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  children: [
                    AppIcons.icon(
                      iconPath,
                      width: 20,
                      height: 20,
                    ),
                    12.sbWidth,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.bodySemiBoldCond(favorite.name),
                          2.sbHeight,
                          AppText.bodyCaption(
                            favorite.address,
                            color: AppColors.bwGrayBright,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    rightWidget,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
