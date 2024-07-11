// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/ui/router/router.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button_icon.dart';

/// Простой AppBar содержащий кнопку назад
class SimpleAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// Простой AppBar содержащий кнопку назад и заголовок
  const SimpleAppBar({
    super.key,
    this.onLeadingTap,
    this.title,
    this.titleWidget,
    this.elevation = 0,
    this.hasTransparentBackground = false,
    this.hasLeading = true,
    this.centerTitle = true,
    this.actions,
  });

  /// По умолчанию [tryGoBack]
  final void Function()? onLeadingTap;
  final Widget? titleWidget;
  final String? title;
  final double? elevation;
  final bool hasLeading;
  final bool centerTitle;
  final List<Widget>? actions;

  /// Является ли фон прозрачным. Также влияет на заливку кнопки Назад
  final bool hasTransparentBackground;

  @override
  State<SimpleAppBar> createState() => _SimpleAppBarState();

  @override
  Size get preferredSize => const Size(0, Consts.toolbarHeight);
}

class _SimpleAppBarState extends State<SimpleAppBar> {
  /// Ключ для получения контекста левой кнопки AppBar

  final _leadingKey = GlobalKey();

  double? w;
  @override
  void initState() {
    super.initState();
    addPostFrameCallback(() {
      setState(() {
        w = _leadingKey.currentContext?.size?.width;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      elevation: widget.elevation,
      title: widget.titleWidget ?? AppText.titleH2(widget.title),
      centerTitle: widget.centerTitle,
      leading: widget.hasLeading
          ? Column(
              key: _leadingKey,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButtonIcon.light(
                  iconPath: AppIcons.arrowLeftIcon,
                  onTap: widget.onLeadingTap ?? tryGoBack,
                ),
              ],
            )
          : null,
      actions: [
        if (widget.actions != null) ...widget.actions!,

        /// Сделано для центрирования title если используется Row в title
        if (widget.actions == null && widget.hasLeading)
          SizedBox(
            width: w,
            height: w,
          ),
      ],
    );
  }
}
