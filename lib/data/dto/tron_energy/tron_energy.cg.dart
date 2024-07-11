import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/domain/tron_energy/tron_energy.cg.dart';

part 'gen/tron_energy.cg.f.dart';
part 'gen/tron_energy.cg.g.dart';

/// DTO Get Tron Energy Info
@freezed
class TronEnergyPipeDto with _$TronEnergyPipeDto {
  /// DTO для ендпойнта 9.1
  const factory TronEnergyPipeDto({
    required bool status,
    Map<String, dynamic>? errors,
    TronEnergyPipeDataDto? data,
  }) = _TronEnergyPipeDto;

  const TronEnergyPipeDto._();

  ///
  factory TronEnergyPipeDto.fromJson(Map<String, dynamic> json) =>
      _$TronEnergyPipeDtoFromJson(json);

  /// Защищенное конвертирование в доменный тип.
  ErrOrTronEnergyPipe toDomain() {
    return safeToDomain(
      () => Right(data?.toDomain() ?? TronEnergyPipe.empty),
      status: status,
      errors: errors,
      response: data,
    );
  }
}

/// DTO 7.1. Get Tron Energy Info
@freezed
class TronEnergyPipeDataDto with _$TronEnergyPipeDataDto {
  /// DTO 7.1. Get Tron Energy Pipe Info
  const factory TronEnergyPipeDataDto({
    int? energyFree,
    int? energyTotal,
  }) = _TronEnergyPipeDataDto;

  const TronEnergyPipeDataDto._();

  ///
  factory TronEnergyPipeDataDto.fromJson(Map<String, dynamic> json) =>
      _$TronEnergyPipeDataDtoFromJson(json);

  /// Защищенное конвертирование в доменный тип.
  TronEnergyPipe toDomain() {
    return TronEnergyPipe(
      energyFree: ifNullPrintErrAndSet(
        data: energyFree,
        functionName: 'TronEnergyDataDto.toDomain',
        variableName: 'energyFree',
        ifNullValue: 0,
      ),
      energyTotal: ifNullPrintErrAndSet(
        data: energyTotal,
        functionName: 'TronEnergyDataDto.toDomain',
        variableName: 'energyTotal',
        ifNullValue: 0,
      ),
    );
  }
}
