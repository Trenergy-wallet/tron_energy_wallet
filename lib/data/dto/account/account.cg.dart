import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/data/dto/wallet/wallet.cg.dart';
import 'package:trenergy_wallet/domain/account/account.cg.dart';
import 'package:trenergy_wallet/domain/wallet/wallet.cg.dart';
import 'package:trenergy_wallet/logic/repo/account/repo/account_repo_base.dart';

part 'gen/account.cg.f.dart';
part 'gen/account.cg.g.dart';

/// DTO для 3.1. Account
@freezed
class AccountDto with _$AccountDto {
  /// DTO для 3.1. Account
  const factory AccountDto({
    required bool status,
    Map<String, dynamic>? errors,
    AccountDataDto? data,
  }) = _AccountDto;

  const AccountDto._();

  ///
  factory AccountDto.fromJson(Map<String, dynamic> json) =>
      _$AccountDtoFromJson(json);

  /// Защищенное конвертирование в доменный тип.
  ErrOrAccount toDomain() {
    return safeToDomain(
      () => Right(data?.toDomain() ?? Account.empty),
      status: status,
      errors: errors,
      response: data,
    );
  }
}

/// DTO для ендпойнта 9.1
@freezed
class AccountDataDto with _$AccountDataDto {
  /// DTO для ендпойнта 9.1
  const factory AccountDataDto({
    String? uuid,
    String? name,
    String? photo,
    String? trenergyToken,
    double? totalUsdBalance,
    CurrencyDto? currency,
    List<WalletDto>? wallets,
  }) = _AccountDataDto;

  const AccountDataDto._();

  ///
  factory AccountDataDto.fromJson(Map<String, dynamic> json) =>
      _$AccountDataDtoFromJson(json);

  /// Конвертим в домен.
  Account toDomain() {
    final assetList = <AppAsset>[];
    final w = wallets ?? [];
    for (final a in w) {
      final assets = a.assets
              ?.map(
                (e) => e.toDomain(
                  walletId: a.id,
                  address: a.address,
                  iconNetwork: a.blockchain?.icon,
                  iconNetworkName: a.blockchain?.name,
                ),
              )
              .toList() ??
          [];
      assetList.addAll(assets);
    }

    return Account(
      uuid: ifNullPrintErrAndSet(
        data: uuid,
        functionName: 'AccountDataDto.toDomain',
        variableName: 'uuid',
        ifNullValue: '',
      ),
      name: ifNullPrintErrAndSet(
        data: name,
        functionName: 'AccountDataDto.toDomain',
        variableName: 'name',
        ifNullValue: '',
      ),
      photo: ifNullPrintErrAndSet(
        data: photo,
        functionName: 'AccountDataDto.toDomain',
        variableName: 'photo',
        ifNullValue: '',
      ),
      trenergyToken: ifNullPrintErrAndSet(
        data: trenergyToken,
        functionName: 'AccountDataDto.toDomain',
        variableName: 'trenergyToken',
        ifNullValue: '',
      ),
      totalUsdBalance: ifNullPrintErrAndSet(
        data: totalUsdBalance,
        functionName: 'AccountDataDto.toDomain',
        variableName: 'totalUsdBalance',
        ifNullValue: 0,
      ),
      currency: ifNullPrintErrAndSet(
        data: currency?.toDomain(),
        functionName: 'AccountDataDto.toDomain',
        variableName: 'currency',
        ifNullValue: AppCurrency.empty,
      ),
      wallets: ifNullPrintErrAndSet(
        data: wallets?.map((e) => e.toDomain()).toList(),
        functionName: 'AccountDataDto.toDomain',
        variableName: 'wallets',
        ifNullValue: [],
      ),
      assets: ifNullPrintErrAndSet(
        data: assetList.map((e) => e).toList(),
        functionName: 'AccountDataDto.toDomain',
        variableName: 'assets',
        ifNullValue: [],
      ),
    );
  }
}
