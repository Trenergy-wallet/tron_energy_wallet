import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/data/repo/local/local_repo.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/ui/router/router.dart';
import 'package:trenergy_wallet/ui/shared/adaptive_ext.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/rive/splash_screen.dart';
import 'package:trenergy_wallet/ui/theme/theme_provider.dart';

part 'gen/splash_screen.cg.g.dart';
part 'splash_screen.dart';

@riverpod
class _SplashCtrl extends _$SplashCtrl {
  LocalRepo get localRepo => ref.read(repoProvider).local;

  @override
  bool build() {
    final sk = localRepo.getSecretKey();
    final account = localRepo.getAccount(sk: sk);

    addPostFrameCallback(() {
      if (account.token.isEmpty) {
        appRouter.go(ScreenPaths.enterWallet);
      } else {
        localRepo.updateAllService();
        appRouter.go(ScreenPaths.wallet);
      }
      FlutterNativeSplash.remove();
    });

    return false;
  }
}
