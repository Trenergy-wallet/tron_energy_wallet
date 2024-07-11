import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/order.cg.f.dart';

/// Domain для данных, передаваемых в ендпойнте.
@freezed
class Order with _$Order {
  /// Domain для данных, передаваемых в ендпойнте.
  const factory Order({
    required int status,
    required String createdAt,
    required String validUntil,
  }) = _Order;

  /// Заглушка
  static const empty = Order(
    status: 0,
    createdAt: '',
    validUntil: '',
  );
}
