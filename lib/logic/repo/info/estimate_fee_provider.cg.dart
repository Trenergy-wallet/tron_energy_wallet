import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/domain/info/estimate_fee.cg.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';

part 'gen/estimate_fee_provider.cg.g.dart';

/// Контроллер провайдера для проверки estimate fee
@riverpod
class EstimateFeeCtrl extends _$EstimateFeeCtrl {
  @override
  EstimateFee build() {
    return EstimateFee.empty;
  }

  /// Запрос на получение какая комиссия
  Future<void> estimateFee() async {
    final res = await ref.read(repoProvider).info.estimateFee();

    res.fold(
      (l) {
        showError(l, showToast: false);
      },
      (r) {
        state = r;
      },
    );
  }
}
