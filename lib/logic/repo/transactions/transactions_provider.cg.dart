import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/domain/transactions/transactions.cg.dart';
import 'package:trenergy_wallet/logic/repo/account/account_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/logic/repo/tron_energy_pipe/tron_energy_pipe_provider.cg.dart';
import 'package:trenergy_wallet/ui/shared/widgets/bottom_sheet/app_bottom_sheet_ctrl.cg.dart';

part 'gen/transactions_provider.cg.g.dart';

/// Контроллер Transactions  для полуучения списка валют
@Riverpod(keepAlive: true)
class TransactionsService extends _$TransactionsService {
  /// страница
  int page = 1;

  /// Кол-во запросов
  int countRequest = 0;

  @override
  Future<Transactions> build() async {
    final res = await _transactions();
    return res;
  }

  // Запрос структуры уровней.
  Future<Transactions> _transactions() async {
    state = const AsyncLoading();
    final res = await ref.read(repoProvider).transactions.getTransactions(
          page: page,
          perPage: 100,
        );

    return res.fold(
      (l) {
        showError(l);
        reloadRequest(ref);
        throw l;
      },
      (r) {
        return r;
      },
    );
  }

  /// 6 Store (Broadcast)
  Future<void> postTransaction({
    required String hex,
  }) async {
    state = const AsyncLoading();

    final res = await ref.read(repoProvider).transactions.postTransaction(
          hex: hex,
        );

    res.fold(
      (l) {
        showError(l, showToast: false);
      },
      (r) {
        addPostFrameCallback(() {
          ref
            ..read(appBottomSheetCtrlProvider.notifier).sendedCurrency()
            ..read(accountServiceProvider.notifier).getAccount()
            ..invalidate(tronEnergyPipeServiceProvider)
            ..invalidateSelf();
        });
      },
    );
  }
}
