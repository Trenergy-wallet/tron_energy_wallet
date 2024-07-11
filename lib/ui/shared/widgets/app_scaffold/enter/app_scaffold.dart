import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trenergy_wallet/ui/shared/widgets/appbar/main_appbar.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

/// Общий скаффолд с градиентом (первая версия).
class AppScaffold extends ConsumerWidget {
  /// Общий скаффолд с градиентом (первая версия).
  const AppScaffold({
    super.key,
    required this.body,
    this.navBarEnable = true,
    this.appBar,
    this.hasMainAppBar = false,
    this.onTapAccount,
    this.onTapBell,
    this.bottomNavigationBar,
  });

  ///
  final Widget body;

  /// appBar
  final PreferredSizeWidget? appBar;

  /// Показывать ли главный AppBar
  final bool hasMainAppBar;

  /// Если true отображается нижнее навигационное меню
  final bool navBarEnable;

  ///
  final Widget? bottomNavigationBar;

  /// тап на аккаунт
  final void Function()? onTapAccount;

  /// тап на колольчик
  final void Function()? onTapBell;

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
                  onTapAccount: onTapAccount,
                  onTapBell: onTapBell,
                )
              : appBar,
          body: SafeArea(
            child: body,
          ),
        ),
      ),
    );
  }
}
