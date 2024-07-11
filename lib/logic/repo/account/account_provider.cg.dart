import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/data/repo/local/local_repo.dart';
import 'package:trenergy_wallet/domain/account/account.cg.dart';
import 'package:trenergy_wallet/domain/wallet/wallet.cg.dart';
import 'package:trenergy_wallet/logic/providers/push_notifications_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/ui/screens/wallet/current_asset.cg.dart';

part 'gen/account_provider.cg.g.dart';

/// Контроллер account для получения данных о пользователей
@Riverpod(keepAlive: true)
class AccountService extends _$AccountService {
  /// Repo local
  LocalRepo get localRepo => ref.read(repoProvider).local;

  @override
  Future<Account> build() async {
    return Future.value(Account.empty);
  }

  /// 3.1. Account
  Future<void> getAccount() async {
    state = const AsyncLoading();
    final res = await ref.read(repoProvider).account.getAccount();
    res.fold(
      (l) {
        throw l;
      },
      (r) {
        AppAsset? newAsset;
        final asset = ref.read(currentAssetProvider);
        final assetNotif = ref.read(currentAssetProvider.notifier);
        for (final a in r.assets) {
          if (a.token.id == asset.token.id) {
            newAsset = a;
          }
        }
        assetNotif.updateAsset(newAsset);

        return state = AsyncData(r);
      },
    );
  }

  /// 3.2. Set Currency
  Future<void> setCurrency({required String currencyId}) async {
    final res = await ref
        .read(repoProvider)
        .account
        .setCurrency(currencyId: currencyId);

    await res.fold(
      (l) {
        throw l;
      },
      (r) => getAccount(),
    );
  }

  /// Переключение вкл/выкл push-уведомлений.
  void switchPushNotifications(bool value) {
    ref.read(pushNotificationsProvider.notifier).savePushFlag(value);
  }
}
