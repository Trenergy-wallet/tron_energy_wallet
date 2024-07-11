import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/domain/wallet/wallet.cg.dart';

part 'gen/wallet.cg.f.dart';
part 'gen/wallet.cg.g.dart';

/// DTO Wallet
@freezed
class WalletDto with _$WalletDto {
  /// DTO Wallet
  const factory WalletDto({
    int? id,
    String? address,
    BlockchainDto? blockchain,
    List<AssetDto>? assets,
  }) = _WalletDto;

  const WalletDto._();

  ///
  factory WalletDto.fromJson(Map<String, dynamic> json) =>
      _$WalletDtoFromJson(json);

  /// Конвертим в домен.
  AppWallet toDomain() {
    return AppWallet(
      id: ifNullPrintErrAndSet(
        data: id,
        functionName: 'WalletDto.toDomain',
        variableName: 'id',
        ifNullValue: Consts.invalidIntValue,
      ),
      address: ifNullPrintErrAndSet(
        data: address,
        functionName: 'WalletDto.toDomain',
        variableName: 'address',
        ifNullValue: '',
      ),
      blockchain: ifNullPrintErrAndSet(
        data: blockchain?.toDomain() ?? AppBlockchain.empty,
        functionName: 'WalletDto.toDomain',
        variableName: 'blockchain',
        ifNullValue: AppBlockchain.empty,
      ),
      assets: ifNullPrintErrAndSet(
        data: assets?.map((e) => e.toDomain()).toList() ?? [],
        functionName: 'WalletDto.toDomain',
        variableName: 'assets',
        ifNullValue: [],
      ),
    );
  }
}

/// DTO BlockchainDto
@freezed
class BlockchainDto with _$BlockchainDto {
  /// DTO BlockchainDto
  const factory BlockchainDto({
    int? id,
    String? name,
    String? shortName,
    String? icon,
    List<TokenDto>? tokens,
  }) = _BlockchainDto;

  const BlockchainDto._();

  ///
  factory BlockchainDto.fromJson(Map<String, dynamic> json) =>
      _$BlockchainDtoFromJson(json);

  /// Конвертим в домен.
  AppBlockchain toDomain() {
    return AppBlockchain(
      id: ifNullPrintErrAndSet(
        data: id,
        functionName: 'BlockchainDto.toDomain',
        variableName: 'id',
        ifNullValue: Consts.invalidIntValue,
      ),
      name: ifNullPrintErrAndSet(
        data: name,
        functionName: 'BlockchainDto.toDomain',
        variableName: 'name',
        ifNullValue: '',
      ),
      shortName: ifNullPrintErrAndSet(
        data: shortName,
        functionName: 'BlockchainDto.toDomain',
        variableName: 'shortName',
        ifNullValue: '',
      ),
      icon: ifNullPrintErrAndSet(
        data: icon,
        functionName: 'BlockchainDto.toDomain',
        variableName: 'icon',
        ifNullValue: '',
      ),
      tokens: ifNullPrintErrAndSet(
        data: tokens?.map((e) => e.toDomain()).toList(),
        functionName: 'BlockchainDto.toDomain',
        variableName: 'tokens',
        ifNullValue: [],
      ),
    );
  }
}

/// DTO CurrencyDto
@freezed
class CurrencyDto with _$CurrencyDto {
  /// DTO CurrencyDto
  const factory CurrencyDto({
    int? id,
    String? name,
    String? code,
    double? usdRate,
  }) = _CurrencyDto;

  const CurrencyDto._();

  ///
  factory CurrencyDto.fromJson(Map<String, dynamic> json) =>
      _$CurrencyDtoFromJson(json);

  /// Конвертим в домен.
  AppCurrency toDomain() {
    return AppCurrency(
      id: ifNullPrintErrAndSet(
        data: id,
        functionName: 'CurrencyDto.toDomain',
        variableName: 'id',
        ifNullValue: Consts.invalidIntValue,
      ),
      name: ifNullPrintErrAndSet(
        data: name,
        functionName: 'CurrencyDto.toDomain',
        variableName: 'name',
        ifNullValue: '',
      ),
      code: ifNullPrintErrAndSet(
        data: code,
        functionName: 'CurrencyDto.toDomain',
        variableName: 'code',
        ifNullValue: '',
      ),
      usdRate: ifNullPrintErrAndSet(
        data: usdRate,
        functionName: 'CurrencyDto.toDomain',
        variableName: 'usdRate',
        ifNullValue: 0,
      ),
    );
  }
}

/// DTO AssetDto
@freezed
class AssetDto with _$AssetDto {
  /// DTO AssetDto
  const factory AssetDto({
    int? id,
    double? balance,
    TokenDto? token,
  }) = _AssetDto;

  const AssetDto._();

  ///
  factory AssetDto.fromJson(Map<String, dynamic> json) =>
      _$AssetDtoFromJson(json);

  /// Конвертим в домен.
  AppAsset toDomain({
    int? walletId,
    String? address,
    String? iconNetwork,
    String? iconNetworkName,
  }) {
    return AppAsset(
      iconNetwork: iconNetwork ?? '',
      iconNetworkName: iconNetworkName ?? '',
      walletId: walletId ?? Consts.invalidIntValue,
      address: address ?? '',
      id: ifNullPrintErrAndSet(
        data: id,
        functionName: 'AssetDto.toDomain',
        variableName: 'id',
        ifNullValue: Consts.invalidIntValue,
      ),
      balance: ifNullPrintErrAndSet(
        data: balance,
        functionName: 'AssetDto.toDomain',
        variableName: 'balance',
        ifNullValue: 0,
      ),
      token: ifNullPrintErrAndSet(
        data: token?.toDomain(),
        functionName: 'AssetDto.toDomain',
        variableName: 'token',
        ifNullValue: AppToken.empty,
      ),
    );
  }
}

/// DTO TokenDto
@freezed
class TokenDto with _$TokenDto {
  /// DTO TokenDto
  const factory TokenDto({
    int? id,
    String? name,
    String? shortName,
    String? icon,
    String? usdPrice,
    double? prevPriceDiffPercent,
    String? contractAddress,
    int? decimal,
  }) = _TokenDto;

  const TokenDto._();

  ///
  factory TokenDto.fromJson(Map<String, dynamic> json) =>
      _$TokenDtoFromJson(json);

  /// Конвертим в домен.
  AppToken toDomain() {
    return AppToken(
      id: ifNullPrintErrAndSet(
        data: id,
        functionName: 'TokenDto.toDomain',
        variableName: 'id',
        ifNullValue: Consts.invalidIntValue,
      ),
      name: ifNullPrintErrAndSet(
        data: name,
        functionName: 'TokenDto.toDomain',
        variableName: 'name',
        ifNullValue: '',
      ),
      shortName: ifNullPrintErrAndSet(
        data: shortName,
        functionName: 'TokenDto.toDomain',
        variableName: 'shortName',
        ifNullValue: '',
      ),
      icon: ifNullPrintErrAndSet(
        data: icon,
        functionName: 'TokenDto.toDomain',
        variableName: 'icon',
        ifNullValue: '',
      ),
      usdPrice: ifNullPrintErrAndSet(
        data: usdPrice,
        functionName: 'TokenDto.toDomain',
        variableName: 'usdPrice',
        ifNullValue: '',
      ),
      prevPriceDiffPercent: ifNullPrintErrAndSet(
        data: prevPriceDiffPercent,
        functionName: 'TokenDto.toDomain',
        variableName: 'prevPriceDiffPercent',
        ifNullValue: 0,
      ),
      contractAddress: contractAddress ?? '',
      // ifNullPrintErrAndSet(
      //   data: contractAddress,
      //   functionName: 'TokenDto.toDomain',
      //   variableName: 'contractAddress',
      //   ifNullValue: '',
      // ),
      decimal: ifNullPrintErrAndSet(
        data: decimal,
        functionName: 'TokenDto.toDomain',
        variableName: 'decimal',
        ifNullValue: Consts.invalidIntValue,
      ),
    );
  }
}
