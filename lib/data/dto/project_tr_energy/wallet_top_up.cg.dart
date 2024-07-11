import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/domain/project_tr_energy/wallet_top_up.cg.dart';

part 'gen/wallet_top_up.cg.f.dart';

part 'gen/wallet_top_up.cg.g.dart';

/// WalletTopUpDto
///
/// DTO для обменного кошелька.
@freezed
class WalletTopUpDto with _$WalletTopUpDto {
  /// WalletAddressDto
  const factory WalletTopUpDto({
    required bool status,
    WalletTopUpDataDto? data,
    Map<String, dynamic>? errors,
    String? error,
  }) = _WalletTopUpDto;

  /// конструктор
  const WalletTopUpDto._();

  /// используем фабричный конструктор
  factory WalletTopUpDto.fromJson(Map<String, dynamic> json) =>
      _$WalletTopUpDtoFromJson(json);

  /// Перевод в toDomain
  ErrOrWalletTopUp toDomain() {
    return safeToDomain(
      () => Right(data?.toDomain() ?? WalletTopUp.empty),
      status: status,
      errors: errors,
      response: data,
    );
  }
}

/// Operations данные
@freezed
class WalletTopUpDataDto with _$WalletTopUpDataDto {
  /// Operations данные
  const factory WalletTopUpDataDto({
    int? id,
    String? address,
    String? qrCode,
  }) = _WalletTopUpDataDto;

  /// конструктор
  const WalletTopUpDataDto._();

  /// используем фабричный конструктор
  factory WalletTopUpDataDto.fromJson(Map<String, dynamic> json) =>
      _$WalletTopUpDataDtoFromJson(json);

  /// toDomain
  WalletTopUp toDomain() {
    return WalletTopUp(
      address: ifNullPrintErrAndSet(
        data: address,
        functionName: 'WalletTopUpDataDto.toDomain',
        variableName: 'address',
        ifNullValue: '',
      ),
      qrCodePath: ifNullPrintErrAndSet(
        data: qrCode,
        functionName: 'WalletTopUpDataDto.toDomain',
        variableName: 'qrCode',
        ifNullValue: '',
      ),
    );
  }
}
