import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/ext.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/domain/account/account.cg.dart';
import 'package:trenergy_wallet/domain/chart/chart_historical.cg.dart';
import 'package:trenergy_wallet/domain/transactions/transactions.cg.dart';
import 'package:trenergy_wallet/domain/wallet/wallet.cg.dart';
import 'package:trenergy_wallet/logic/repo/account/account_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/chart/chart_historical_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/chart/enum/chart_enum.dart';
import 'package:trenergy_wallet/logic/repo/transactions/token_transactions_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/transactions/transactions_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/tron_energy_pipe/tron_energy_pipe_provider.cg.dart';
import 'package:trenergy_wallet/ui/router/router.dart';
import 'package:trenergy_wallet/ui/screens/wallet/models/transaction_model.cg.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/app_alert.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_scaffold/enter/app_scaffold.dart';

import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/appbar/appbar_simple.dart';
import 'package:trenergy_wallet/ui/shared/widgets/asset_block.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button.dart';
import 'package:trenergy_wallet/ui/shared/widgets/img_network.dart';
import 'package:trenergy_wallet/ui/shared/widgets/preloader.dart';
import 'package:trenergy_wallet/ui/shared/widgets/rive/refresh.dart';
import 'package:trenergy_wallet/ui/shared/widgets/tron_energy_block.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

part 'gen/current_asset.cg.g.dart';

part 'wallet_screen.dart';
part 'screens/_asset_screen.dart';
part 'widgets/_all_transactions.dart';
part 'widgets/_assets.dart';
part 'widgets/_balance.dart';
part 'widgets/_send_receive_btn.dart';
part 'widgets/_chart.dart';
part 'widgets/_refresh.dart';

/// Активный токен
@riverpod
class CurrentAsset extends _$CurrentAsset {
  @override
  AppAsset build() {
    // final accountService = ref.watch(accountServiceProvider);
    // final account = accountService.valueOrNull ?? Account.empty;
    // final assets = account.assets;

    // AppAsset? asset;

    // /// Устанавливаем первый активный токен по умолчанию
    // if (assets.isNotEmpty) {
    //   asset = assets.first;
    // }
    return AppAsset.empty;
  }

  /// Обновляет активный токен и перенаправляет на экран с активным токеном
  void updateAssetAndGo(AppAsset asset) {
    state = asset;
    appRouter.go(ScreenPaths.asset);
  }

  /// Обновляет активный токен
  void updateAsset(AppAsset? asset) {
    if (asset == null) return;
    state = asset;
  }
}
