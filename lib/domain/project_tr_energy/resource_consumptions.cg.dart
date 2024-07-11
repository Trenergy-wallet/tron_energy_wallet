import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/resource_consumptions.cg.f.dart';

/// Domain для данных, передаваемых в ендпойнте.
@freezed
class ResourceConsumptions with _$ResourceConsumptions {
  /// Domain для данных, передаваемых в ендпойнте.
  const factory ResourceConsumptions({
    required int txCount,
    required int energyAmount,
    required double normalCostTrx,
    required double trenergyCostTrx,
    DateTime? day,
  }) = _ResourceConsumptions;

  /// Заглушка
  static const empty = ResourceConsumptions(
    txCount: 0,
    energyAmount: 0,
    normalCostTrx: 0,
    trenergyCostTrx: 0,
  );
}
