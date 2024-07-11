import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/domain/info/estimate_fee.cg.dart';
import 'package:trenergy_wallet/logic/repo/info/repo/info_repo_base.dart';

part 'gen/estimate_fee.cg.f.dart';
part 'gen/estimate_fee.cg.g.dart';

/// EstimateFeeDto
@freezed
class EstimateFeeDto with _$EstimateFeeDto {
  /// EstimateFeeDto
  const factory EstimateFeeDto({
    bool? status,
    EstimateFeeDataDto? data,
    Map<String, dynamic>? errors,
    String? error,
  }) = _EstimateFeeDto;

  /// конструктор
  const EstimateFeeDto._();

  /// используем фабричный конструктор
  factory EstimateFeeDto.fromJson(Map<String, dynamic> json) =>
      _$EstimateFeeDtoFromJson(json);

  /// Перевод в toDomain
  ErrOrEstimateFee toDomain() {
    return safeToDomain(
      () {
        final domain = data?.toDomain() ?? EstimateFee.empty;
        return Right(domain);
      },
      errors: errors,
      response: data,
      status: status ?? false,
    );
  }
}

/// EstimateFeeDataDto
@freezed
class EstimateFeeDataDto with _$EstimateFeeDataDto {
  /// EstimateFeeDataDto
  const factory EstimateFeeDataDto({
    double? trx,
    double? energy,
  }) = _EstimateFeeDataDto;

  /// конструктор
  const EstimateFeeDataDto._();

  /// используем фабричный конструктор
  factory EstimateFeeDataDto.fromJson(Map<String, dynamic> json) =>
      _$EstimateFeeDataDtoFromJson(json);

  /// toDomain
  EstimateFee toDomain() {
    return EstimateFee(
      trx: ifNullPrintErrAndSet(
        data: trx,
        functionName: 'EstimateFeeDataDto.toDomain',
        variableName: 'trx',
        ifNullValue: Consts.invalidDoubleValue,
      ),
      energy: ifNullPrintErrAndSet(
        data: energy,
        functionName: 'EstimateFeeDataDto.toDomain',
        variableName: 'energy',
        ifNullValue: Consts.invalidDoubleValue,
      ),
    );
  }
}
