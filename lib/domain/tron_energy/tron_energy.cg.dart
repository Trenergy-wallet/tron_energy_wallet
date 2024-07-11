import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/extended_errors.cg.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';

part 'gen/tron_energy.cg.f.dart';

/// TronEnergy
@freezed
class TronEnergyPipe with _$TronEnergyPipe {
  /// TronEnergy
  const factory TronEnergyPipe({
    required int energyFree,
    required int energyTotal,
  }) = _TronEnergyPipe;

  /// Заглушка
  static const empty = TronEnergyPipe(
    energyFree: 0,
    energyTotal: 0,
  );
}

///
typedef ErrOrTronEnergyPipe = Either<ExtendedErrors, TronEnergyPipe>;
