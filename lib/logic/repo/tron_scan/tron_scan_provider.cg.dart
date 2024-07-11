import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/domain/tron_scan/tron_scan.cg.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';

part 'gen/tron_scan_provider.cg.g.dart';

/// Контроллер Tron Scan  для полуучения списка валют
@Riverpod(keepAlive: true)
class TronScanService extends _$TronScanService {
  @override
  TronScan build() {
    return TronScan.empty;
  }

  /// Запрос tron scan
  Future<void> getTronScan({required String hash}) async {
    final res = await ref.read(repoProvider).tronScan.getTronScan(hash: hash);

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
