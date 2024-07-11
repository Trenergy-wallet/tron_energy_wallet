import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/domain/tron_scan/tron_scan.cg.dart';

part 'gen/tron_scan.cg.f.dart';
part 'gen/tron_scan.cg.g.dart';

/// DTO Get Tron Scan Info
@freezed
class TronScanDto with _$TronScanDto {
  /// DTO
  const factory TronScanDto({
    @JsonKey(name: 'contractRet') String? contractRet,
    @JsonKey(name: 'toAddress') String? toAddress,
    TronScanCostDto? cost,
    TokenTransferInfoSacnDto? tokenTransferInfo,
    @JsonKey(name: 'ownerAddress') String? ownerAddress,
    String? hash,
  }) = _TronScanDto;

  const TronScanDto._();

  ///
  factory TronScanDto.fromJson(Map<String, dynamic> json) =>
      _$TronScanDtoFromJson(json);

  /// Защищенное конвертирование в доменный тип.
  ErrOrTronScan toDomain() {
    final data = TronScan(
      contractRet: contractRet ?? '',
      toAddress: toAddress ?? '',
      cost: cost?.toDomain() ?? TronScanCost.empty,
      tokenTransferInfo:
          tokenTransferInfo?.toDomain() ?? TokenTransferInfoScan.empty,
      ownerAddress: ownerAddress ?? '',
      hash: hash ?? '',
    );
    return safeToDomain(
      () => Right(data),
      status: true,
      errors: {},
      response: data,
    );
  }
}

/// DTO
@freezed
class TronScanCostDto with _$TronScanCostDto {
  /// DTO
  const factory TronScanCostDto({
    int? multiSignFee,
    int? netFee,
    int? energyPenaltyTotal,
    int? netFeeCost,
    int? energyUsage,
    int? fee,
    int? energyFeeCost,
    int? energyFee,
    int? energyUsageTotal,
    @JsonKey(name: 'memoFee') int? memoFee,
    int? originEnergyUsage,
    int? netUsage,
  }) = _TronScanCostDto;

  const TronScanCostDto._();

  ///
  factory TronScanCostDto.fromJson(Map<String, dynamic> json) =>
      _$TronScanCostDtoFromJson(json);

  /// toDomain
  TronScanCost toDomain() {
    return TronScanCost(
      multiSignFee: multiSignFee ?? 0,
      netFee: netFee ?? 0,
      energyPenaltyTotal: energyPenaltyTotal ?? 0,
      netFeeCost: netFeeCost ?? 0,
      energyUsage: energyUsage ?? 0,
      fee: fee ?? 0,
      energyFeeCost: energyFeeCost ?? 0,
      energyFee: energyFee ?? 0,
      energyUsageTotal: energyUsageTotal ?? 0,
      memoFee: memoFee ?? 0,
      originEnergyUsage: originEnergyUsage ?? 0,
      netUsage: netUsage ?? 0,
    );
  }
}

/// DTO
@freezed
class TokenTransferInfoSacnDto with _$TokenTransferInfoSacnDto {
  /// DTO
  const factory TokenTransferInfoSacnDto({
    String? iconUrl,
    String? symbol,
    String? level,
    String? toAddress,
    String? contractAddress,
    String? type,
    int? decimals,
    String? name,
    bool? vip,
    @JsonKey(name: 'tokenType') String? tokenType,
    String? fromAddress,
    String? amountStr,
    int? status,
  }) = _TokenTransferInfoSacnDto;

  const TokenTransferInfoSacnDto._();

  ///
  factory TokenTransferInfoSacnDto.fromJson(Map<String, dynamic> json) =>
      _$TokenTransferInfoSacnDtoFromJson(json);

  /// toDomain
  TokenTransferInfoScan toDomain() {
    return TokenTransferInfoScan(
      iconUrl: iconUrl ?? '',
      symbol: symbol ?? '',
      level: level ?? '',
      toAddress: toAddress ?? '',
      contractAddress: contractAddress ?? '',
      type: type ?? '',
      decimals: decimals ?? 0,
      name: name ?? '',
      vip: vip ?? false,
      status: status ?? 0,
      tokenType: tokenType ?? '',
      fromAddress: fromAddress ?? '',
      amountStr: amountStr ?? '',
    );
  }
}
