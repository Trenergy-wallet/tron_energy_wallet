import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/domain/project_tr_energy/boost_order.cg.dart';

part 'gen/boost_order.cg.f.dart';
part 'gen/boost_order.cg.g.dart';

/// ДТО для данных, передаваемых в ендпойнте.
@freezed
class BoostOrderDto with _$BoostOrderDto {
  /// ДТО для данных, передаваемых в ендпойнте.
  const factory BoostOrderDto({
    int? status,
    String? createdAt,
    String? validUntil,
  }) = _BoostOrderDto;

  const BoostOrderDto._();

  ///
  factory BoostOrderDto.fromJson(Map<String, dynamic> json) =>
      _$BoostOrderDtoFromJson(json);

  /// toDomain
  BoostOrder toDomain() {
    return BoostOrder(
      status: ifNullPrintErrAndSet(
        data: status,
        functionName: 'BoostOrderDto.toDomain',
        variableName: 'status',
        ifNullValue: 0,
      ),
      createdAt: ifNullPrintErrAndSet(
        data: createdAt,
        functionName: 'BoostOrderDto.toDomain',
        variableName: 'createdAt',
        ifNullValue: '',
      ),
      validUntil: ifNullPrintErrAndSet(
        data: validUntil,
        functionName: 'BoostOrderDto.toDomain',
        variableName: 'validUntil',
        ifNullValue: '',
      ),
    );
  }
}
