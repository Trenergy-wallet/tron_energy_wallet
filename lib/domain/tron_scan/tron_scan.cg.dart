import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/extended_errors.cg.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';

part 'gen/tron_scan.cg.f.dart';

/// TronScan
@freezed
class TronScan with _$TronScan {
  /// TronScan
  const factory TronScan({
    required String contractRet,
    required String toAddress,
    required TronScanCost cost,
    required TokenTransferInfoScan tokenTransferInfo,
    required String ownerAddress,
    required String hash,
  }) = _TronScan;

  /// Заглушка
  static const empty = TronScan(
    contractRet: '',
    toAddress: '',
    cost: TronScanCost.empty,
    tokenTransferInfo: TokenTransferInfoScan.empty,
    ownerAddress: '',
    hash: '',
  );
}

/// Cost
@freezed
class TronScanCost with _$TronScanCost {
  /// Cost
  const factory TronScanCost({
    required int multiSignFee,
    required int netFee,
    required int energyPenaltyTotal,
    required int netFeeCost,
    required int energyUsage,
    required int fee,
    required int energyFeeCost,
    required int energyFee,
    required int energyUsageTotal,
    required int memoFee,
    required int originEnergyUsage,
    required int netUsage,
  }) = _TronScanCost;

  /// Заглушка
  static const empty = TronScanCost(
    energyUsage: 0,
    energyFee: 0,
    energyUsageTotal: 0,
    energyFeeCost: 0,
    energyPenaltyTotal: 0,
    netFee: 0,
    netFeeCost: 0,
    multiSignFee: 0,
    originEnergyUsage: 0,
    memoFee: 0,
    netUsage: 0,
    fee: 0,
  );
}

/// TokenTransferInfo
@freezed
class TokenTransferInfoScan with _$TokenTransferInfoScan {
  /// TokenTransferInfo
  const factory TokenTransferInfoScan({
    required String iconUrl,
    required String symbol,
    required String level,
    required String toAddress,
    required String contractAddress,
    required String type,
    required int decimals,
    required String name,
    required bool vip,
    required String tokenType,
    required String fromAddress,
    required String amountStr,
    required int status,
  }) = _TokenTransferInfoScan;

  /// Заглушка
  static const empty = TokenTransferInfoScan(
    status: 0,
    amountStr: '',
    name: '',
    iconUrl: '',
    symbol: '',
    level: '',
    toAddress: '',
    contractAddress: '',
    type: '',
    decimals: 0,
    tokenType: '',
    fromAddress: '',
    vip: false,
  );
}

///
typedef ErrOrTronScan = Either<ExtendedErrors, TronScan>;
