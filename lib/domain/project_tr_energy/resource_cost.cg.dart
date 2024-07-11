import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/resource_cost.cg.f.dart';

/// Domain для данных, передаваемых в ендпойнте.
@freezed
class ResourceCost with _$ResourceCost {
  /// Domain для данных, передаваемых в ендпойнте.
  const factory ResourceCost({
    required double normalTrx,
    required int trenergyTrx,
  }) = _ResourceCost;

  /// Заглушка
  static const empty = ResourceCost(
    normalTrx: 0,
    trenergyTrx: 0,
  );
}
