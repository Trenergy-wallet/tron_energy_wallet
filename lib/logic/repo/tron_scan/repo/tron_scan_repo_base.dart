import 'package:trenergy_wallet/domain/tron_scan/tron_scan.cg.dart';

/// Интерфейс tron scan репозитория
abstract interface class TronScanRepo {
  /// Get Tron Scan Info
  Future<ErrOrTronScan> getTronScan({required String hash});
}
