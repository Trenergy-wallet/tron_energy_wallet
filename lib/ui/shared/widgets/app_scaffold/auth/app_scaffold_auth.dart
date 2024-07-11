import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/ui/shared/widgets/appbar/main_appbar.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Общий скаффолд для auth
class AppScaffoldAuth extends ConsumerWidget {
  /// Общий скаффолд для auth
  const AppScaffoldAuth({
    super.key,
    required this.body,
    this.navBarEnable = true,
    this.appBar,
    this.hasMainAppBar = false,
  });

  ///
  final Widget body;

  /// appBar
  final PreferredSizeWidget? appBar;

  /// Показывать ли главный AppBar
  final bool hasMainAppBar;

  /// Если true отображается нижнее навигационное меню
  final bool navBarEnable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: GestureDetector(
        onTap: FocusManager.instance.primaryFocus?.unfocus,
        child: Scaffold(
          backgroundColor: AppColors.primaryMid,
          appBar: hasMainAppBar
              ? MainAppBar(
                  onTapAccount: () {},
                  onTapBell: () {},
                )
              : appBar,
          resizeToAvoidBottomInset: false,
          body: SafeArea(child: body),
        ),
      ),
    );
  }
}
