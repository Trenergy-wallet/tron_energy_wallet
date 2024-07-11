import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/domain/project_tr_energy/order.cg.dart';

part 'gen/order.cg.f.dart';
part 'gen/order.cg.g.dart';

/// ДТО для данных, передаваемых в ендпойнте.
@freezed
class OrderDto with _$OrderDto {
  /// ДТО для данных, передаваемых в ендпойнте.
  const factory OrderDto({
    int? status,
    String? createdAt,
    String? validUntil,
  }) = _OrderDto;

  const OrderDto._();

  ///
  factory OrderDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDtoFromJson(json);

  /// toDomain
  Order toDomain() {
    return Order(
      status: ifNullPrintErrAndSet(
        data: status,
        functionName: 'OrderDto.toDomain',
        variableName: 'status',
        ifNullValue: 0,
      ),
      createdAt: ifNullPrintErrAndSet(
        data: createdAt,
        functionName: 'OrderDto.toDomain',
        variableName: 'createdAt',
        ifNullValue: '',
      ),
      validUntil: ifNullPrintErrAndSet(
        data: validUntil,
        functionName: 'OrderDto.toDomain',
        variableName: 'validUntil',
        ifNullValue: '',
      ),
    );
  }
}
