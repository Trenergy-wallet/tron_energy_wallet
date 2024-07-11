part of '../app_bottom_sheet.dart';

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    this.onTapBack,
    this.onTapClose,
    this.isDarkColorBg = false,
  });

  final String title;
  final void Function()? onTapBack;
  final void Function()? onTapClose;
  final bool isDarkColorBg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 21),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (onTapBack != null)
            GestureDetector(
              onTap: onTapBack,
              child: AppIcons.arrowLeft(height: 16, width: 16),
            )
          else
            const SizedBox(width: 16),
          Flexible(
            child: AppText.titleH2(
              title,
              textAlign: TextAlign.center,
              color: isDarkColorBg ? AppColors.primaryDull : null,
            ),
          ),
          AppButtonIcon.light(
            iconPath: AppIcons.crossSmallIcon,
            onTap: onTapClose,
            customColorIcon: isDarkColorBg ? AppColors.primaryDull : null,
          ),
        ],
      ),
    );
  }
}
