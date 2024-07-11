import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/domain/wallet/wallet_type.cg.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';

part 'gen/wallet_check_provider.cg.g.dart';

/// Контроллер провайдера для проверки wallet
@riverpod
class WalletCheckCtrl extends _$WalletCheckCtrl {
  Timer? _debounceTimer;

  @override
  WalletTypeCheck build() {
    return WalletTypeCheck.empty;
  }

  /// Очистка
  void clearCheck() {
    state = WalletTypeCheck.empty;
    _debounceTimer?.cancel();
    _debounceTimer = null;
  }

  ///
  void checkAddress(String value) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (value.isNotEmpty) {
        final res = await ref.read(repoProvider).info.walletTypeCheck(
              address: value,
            );

        res.fold(
          (l) {
            showError(l, showToast: false);
            state = state.copyWith(
              blockchain: state.blockchain.copyWith(
                name: Consts.walletCheckError,
              ),
            );
          },
          (r) {
            state = r;
          },
        );
      }
    });
  }
}
