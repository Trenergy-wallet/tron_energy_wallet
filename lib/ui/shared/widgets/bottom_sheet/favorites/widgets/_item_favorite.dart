part of '../favorites.dart';

/// ItemFavorite
class _ItemFavorite extends StatelessWidget {
  /// ItemFavorite
  const _ItemFavorite({
    required this.favorite,
    this.hasDivider = true,
    required this.iconPath,
    required this.rightWidget,
    this.isFirst = false,
    this.isLast = false,
    this.onTap,
  });

  final Favorites favorite;
  final Widget rightWidget;
  final String iconPath;
  final bool hasDivider;
  final bool isFirst;
  final bool isLast;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ColoredBox(
        color: AppColors.transparent,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Row(
                children: [
                  AppIcons.icon(iconPath, width: 20, height: 20),
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
                  12.sbWidth,
                  rightWidget,
                ],
              ),
            ),
            if (hasDivider)
              Padding(
                padding: const EdgeInsets.only(left: 44),
                child: Divider(height: 1, color: AppColors.bwBrightPrimary),
              ),
          ],
        ),
      ),
    );
  }
}
