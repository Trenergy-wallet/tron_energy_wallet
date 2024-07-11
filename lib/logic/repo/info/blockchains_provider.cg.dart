import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/domain/wallet/wallet.cg.dart';
import 'package:trenergy_wallet/logic/repo/account/account_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';

part 'gen/blockchains_provider.cg.g.dart';

/// Контроллер Blockchains  для полуучения списка валют
@Riverpod(keepAlive: true)
class BlockchainsService extends _$BlockchainsService {
  @override
  List<AppBlockchain> build() {
    return <AppBlockchain>[];
  }

  /// Добавть id на удаление
  Future<void> deleteToken({
    required int id,
    required int walletId,
  }) async {
    final res = await ref.read(repoProvider).assets.removeAssets(
      walletId: walletId,
      tokensId: [id],
    );

    await res.fold(
      showError,
      (r) {
        updateListBlockchains();
      },
    );
  }

  /// Добавть id на удаление
  Future<void> addToken({
    required int id,
    required int walletId,
  }) async {
    final res = await ref.read(repoProvider).assets.addAssets(
      walletId: walletId,
      tokensId: [id],
    );

    await res.fold(
      showError,
      (r) {
        updateListBlockchains();
      },
    );
  }

  ///
  Future<void> updateListBlockchains() async {
    /// запрос на последние данные об аккаунте
    await ref.read(accountServiceProvider.notifier).getAccount();

    /// получаем аккаунт
    final account = ref.read(accountServiceProvider);

    /// получаем активные токены
    final assets = account.valueOrNull?.assets ?? [];

    state = await _updateIsAddedToAssets(state, assets);
  }

  /// 2.1 Blockchain List
  Future<void> getListBlockchains() async {
    final res = await ref.read(repoProvider).info.getListBlockchains();
    await res.fold(
      showError,
      (r) {
        delayMs(Consts.exitTimeInMillis).then((value) async {
          final account = ref.read(accountServiceProvider);
          final assets = account.valueOrNull?.assets ?? [];

          return state = await _updateIsAddedToAssets(r, assets);
        });
      },
    );
  }

  Future<List<AppBlockchain>> _updateIsAddedToAssets(
    List<AppBlockchain> data,
    List<AppAsset> assets,
  ) async {
// Создаем новый список с изменениями
    final d = data.map((dataItem) {
      final updatedTokens = dataItem.tokens.map((token) {
        final isMatchFound = assets.any(
          (asset) => asset.token.id == token.id,
        );
        if (isMatchFound) {
          return token.copyWith(isAddedToAssets: true);
        } else {
          return token.copyWith(isAddedToAssets: false);
        }
      }).toList();

      return dataItem.copyWith(tokens: updatedTokens);
    }).toList();

    return d;
  }
}
