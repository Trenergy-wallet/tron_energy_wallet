import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/ext.dart';
import 'package:trenergy_wallet/data/config/app_config.dart';
import 'package:trenergy_wallet/data/repo/local/local_repo.dart';
import 'package:trenergy_wallet/domain/account/account.cg.dart';
import 'package:trenergy_wallet/logic/providers/locale_provider.cg.dart';
import 'package:trenergy_wallet/logic/providers/push_notifications_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/account/account_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/favorites/favorites_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/ui/router/router.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/icons.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_scaffold/enter/app_scaffold.dart';
import 'package:trenergy_wallet/ui/shared/widgets/app_text.dart';
import 'package:trenergy_wallet/ui/shared/widgets/appbar/appbar_simple.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/buttons/app_button.dart';
import 'package:trenergy_wallet/ui/shared/widgets/item_container.dart';
import 'package:trenergy_wallet/ui/shared/widgets/rive/switch.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

part 'gen/settings_screen.cg.g.dart';
part 'screen_bottom_sheet/delete_account.dart';
part 'settings_screen.dart';

@riverpod
class _SettingsCtrl extends _$SettingsCtrl {
  LocalRepo get localRepo => ref.read(repoProvider).local;

  @override
  bool build() {
    return false;
  }

  void exit() {
    localRepo.saveToken('');
    appRouter.pushReplacement<void>(ScreenPaths.splash);
  }

  void deleteAccount() {
    final sk = localRepo.getSecretKey();
    final account = localRepo.getAccount(sk: sk);
    localRepo.deleteAccountList(account);
  }
}
