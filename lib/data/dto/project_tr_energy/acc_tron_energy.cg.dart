import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/domain/project_tr_energy/acc_tr_energy.cg.dart';
import 'package:trenergy_wallet/logic/repo/project_tr_energy/repo/project_tr_energy_repo_base.dart';

part 'gen/acc_tron_energy.cg.f.dart';
part 'gen/acc_tron_energy.cg.g.dart';

/// Дто для ендпойнта 9.1
@freezed
class AccountTrEnergyDto with _$AccountTrEnergyDto {
  /// Дто для ендпойнта 9.1
  const factory AccountTrEnergyDto({
    required bool status,
    Map<String, dynamic>? errors,
    AccountTrEnergyDataDto? data,
  }) = _AccountTrEnergyDto;

  const AccountTrEnergyDto._();

  ///
  factory AccountTrEnergyDto.fromJson(Map<String, dynamic> json) =>
      _$AccountTrEnergyDtoFromJson(json);

  /// Защищенное конвертирование в доменный тип.
  ErrOrAccountTrEnergy toDomain() {
    return safeToDomain(
      () => Right(data?.toDomain() ?? AccountTrEnergy.empty),
      status: status,
      errors: errors,
      response: data,
    );
  }
}

// FIXME(vvk): дату пока тупо не конвертирую, а подставляю текущую.
//   Пока просто ее некуда выводить, и я хочу получить ответ, почему
//    опять даты у нас строками, а не int.
/// Дто для ендпойнта 9.1
@freezed
class AccountTrEnergyDataDto with _$AccountTrEnergyDataDto {
  /// Дто для ендпойнта 9.1
  const factory AccountTrEnergyDataDto({
    double? balance,
  }) = _AccountTrEnergyDataDto;

  const AccountTrEnergyDataDto._();

  ///
  factory AccountTrEnergyDataDto.fromJson(Map<String, dynamic> json) =>
      _$AccountTrEnergyDataDtoFromJson(json);

  /// Конвертим в домен.
  AccountTrEnergy toDomain() {
    return AccountTrEnergy(
      balance: ifNullPrintErrAndSet(
        data: balance,
        functionName: 'AccountDataDto.toDomain',
        variableName: 'balance',
        ifNullValue: -1,
      ),
    );
  }
}
