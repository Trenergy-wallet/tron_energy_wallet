import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/logic/providers/internet_provider.dart';

part 'gen/app_scaffold_auth_c.cg.g.dart';

/// Контроллер AppScaffold
@riverpod
class AppScaffoldAuthCtrl extends _$AppScaffoldAuthCtrl {
  /// Если true значит нет соединения с интернетом
  late final bool noConnection;

  @override
  int build() {
    _init();
    return 0;
  }

  void _init() {
    noConnection = ref.watch(InternetController.provider);
    // Запускаем контроллер CloudMessaging
    // ref.read(fcmProvider);
  }

  ///
  void goToPage(BuildContext context, double index) {
    addPostFrameCallback(() {
      StatefulNavigationShell.of(context).goBranch(index.toInt());
    });
  }
}
