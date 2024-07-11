import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/domain/wallet/wallet.cg.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';

part 'gen/currencies_provider.cg.g.dart';

/// Контроллер Currencies  для полуучения списка валют
@Riverpod(keepAlive: true)
class CurrenciesService extends _$CurrenciesService {
  @override
  List<AppCurrency> build() {
    return [];
  }

  /// 2.3. Currency List
  Future<void> getListCurrency() async {
    final res = await ref.read(repoProvider).info.getListCurrency();
    res.fold(
      showError,
      (r) => state = r,
    );
  }
}
