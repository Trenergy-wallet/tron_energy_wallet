import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/domain/transactions/transactions.cg.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';

part 'gen/token_transactions_provider.cg.g.dart';

/// Контроллер Transactions  для полуучения списка валют
@Riverpod(keepAlive: true)
class TokenTransactionsService extends _$TokenTransactionsService {
  /// страница
  int page = 1;

  @override
  Future<Transactions> build() async {
    return Transactions.empty;
  }

  /// Запрос структуры уровней.
  Future<void> getTokenTransactions({
    required int walletId,
    required int tokenId,
    int? perPage,
  }) async {
    state = const AsyncLoading();
    final res = await ref.read(repoProvider).transactions.getTokenTransactions(
          walletId: walletId,
          tokenId: tokenId,
          perPage: perPage,
        );

    return res.fold(
      (l) {
        showError(l);
        reloadRequest(ref);
        state = const AsyncData(Transactions.empty);
      },
      (r) {
        state = AsyncData(r);
      },
    );
  }
}
