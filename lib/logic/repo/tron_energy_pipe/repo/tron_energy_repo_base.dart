import 'package:trenergy_wallet/domain/tron_energy/tron_energy.cg.dart';

/// Интерфейс tron energy репозитория
abstract interface class TronEnergyPipeRepo {
  /// 7.1. Get Tron Energy Info
  Future<ErrOrTronEnergyPipe> getTronEnergyPipe();
}
