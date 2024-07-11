import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/data/repo/local/local_repo.dart';
import 'package:trenergy_wallet/logic/providers/fcm_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/ui/router/router.dart';
import 'package:trenergy_wallet/ui/screens/create_import_wallet/enter_ctrl.cg.dart';
import 'package:trenergy_wallet/ui/screens/create_import_wallet/wallet/wallet_ctrl.cg.dart';

part 'gen/auth_provider.cg.g.dart';

/// Контроллер auth для полуучения и отправки контрольной подписи.
@Riverpod(keepAlive: true)
class AuthService extends _$AuthService {
  /// Repo local
  LocalRepo get localRepo => ref.read(repoProvider).local;

  @override
  void build() {}

  /// 1.1 Get Auth Message
  Future<void> fetchAuthMessage() async {
    final res = await ref.read(repoProvider).auth.fetchAuthMessage();
    res.fold(
      (l) {
        showError(l, showToast: false);
      },
      (r) => localRepo.saveAuthMessage(r.message),
    );
  }

  /// 1.2 Post Auth Message
  Future<void> authMessage({
    required String address,
    required String signature,
    required String message,
  }) async {
    final res = await ref.read(repoProvider).auth.authMessage(
          address: address,
          signature: signature,
          message: message,
        );

    res.fold(
      (l) {
        showError(l, showToast: false);
      },
      (r) {
        final createAccount = ref.read(createAccountCtrlProvider.notifier)
          ..updateAccount(token: r.token);
        final account = ref.read(createAccountCtrlProvider);
        ref.read(fcmProvider);
        localRepo.saveAccount(account);
        createAccount.clearAccount();
        ref.read(walletCtrlProvider.notifier).updateIsLoading(false);
        appRouter.go(ScreenPaths.wallet);
      },
    );
  }
}
