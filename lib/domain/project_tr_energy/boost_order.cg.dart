import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/boost_order.cg.f.dart';

/// Domain для данных, передаваемых в ендпойнте.
@freezed
class BoostOrder with _$BoostOrder {
  /// Domain для данных, передаваемых в ендпойнте.
  const factory BoostOrder({
    required int status,
    required String createdAt,
    required String validUntil,
  }) = _BoostOrder;

  /// Заглушка
  static const empty = BoostOrder(
    status: 0,
    createdAt: '',
    validUntil: '',
  );
}
