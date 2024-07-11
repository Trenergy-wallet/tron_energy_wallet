import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/data/dto/wallet/wallet.cg.dart';
import 'package:trenergy_wallet/domain/wallet/wallet.cg.dart';
import 'package:trenergy_wallet/domain/wallet/wallet_type.cg.dart';

part 'gen/wallet_type_check.cg.f.dart';
part 'gen/wallet_type_check.cg.g.dart';

/// WalletTypeCheckDto
@freezed
class WalletTypeCheckDto with _$WalletTypeCheckDto {
  /// WalletTypeCheckDto
  const factory WalletTypeCheckDto({
    bool? status,
    WalletTypeDto? data,
    Map<String, dynamic>? errors,
    String? error,
  }) = _WalletTypeCheckDto;

  /// конструктор
  const WalletTypeCheckDto._();

  /// используем фабричный конструктор
  factory WalletTypeCheckDto.fromJson(Map<String, dynamic> json) =>
      _$WalletTypeCheckDtoFromJson(json);

  /// Перевод в toDomain
  ErrOrWalletTypeCheck toDomain() {
    return safeToDomain(
      () {
        final domain = data?.toDomain() ?? WalletTypeCheck.empty;
        return Right(domain);
      },
      errors: errors,
      response: data,
      status: status ?? false,
    );
  }
}

/// WalletTypeDto
@freezed
class WalletTypeDto with _$WalletTypeDto {
  /// WalletTypeDto
  const factory WalletTypeDto({
    BlockchainDto? blockchain,
  }) = _WalletTypeDto;

  /// конструктор
  const WalletTypeDto._();

  /// используем фабричный конструктор
  factory WalletTypeDto.fromJson(Map<String, dynamic> json) =>
      _$WalletTypeDtoFromJson(json);

  /// toDomain
  WalletTypeCheck toDomain() {
    return WalletTypeCheck(
      blockchain: ifNullPrintErrAndSet(
        data: blockchain?.toDomain(),
        functionName: 'WalletTypeDto.toDomain',
        variableName: 'type',
        ifNullValue: AppBlockchain.empty,
      ),
    );
  }
}
