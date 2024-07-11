import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';

part 'gen/wallet.cg.f.dart';
// part 'gen/wallet.cg.g.dart';

/// AppWallet
@freezed
class AppWallet with _$AppWallet {
  /// AppWallet
  const factory AppWallet({
    required int id,
    required String address,
    required List<AppAsset> assets,
    required AppBlockchain blockchain,
  }) = _AppWallet;

  /// константный синглтон для семантики "Отсутствие данных"
  static const AppWallet empty = AppWallet(
    id: Consts.invalidIntValue,
    address: '',
    blockchain: AppBlockchain.empty,
    assets: [],
  );
}

/// AppBlockchain
@freezed
class AppBlockchain with _$AppBlockchain {
  /// AppBlockchain
  const factory AppBlockchain({
    required int id,
    required String name,
    required String shortName,
    required String icon,
    required List<AppToken> tokens,
  }) = _AppBlockchain;

  /// константный синглтон для семантики "Отсутствие данных"
  static const AppBlockchain empty = AppBlockchain(
    id: 0,
    name: '',
    shortName: '',
    icon: '',
    tokens: [],
  );
}

/// AppCurrency
@freezed
class AppCurrency with _$AppCurrency {
  /// AppCurrency
  const factory AppCurrency({
    required int id,
    required String name,
    required String code,
    required double usdRate,
    int? currentIndex,
  }) = _AppCurrency;

  /// константный синглтон для семантики "Отсутствие данных"
  static const AppCurrency empty = AppCurrency(
    id: 1,
    name: 'United Arab Emirates Dirham',
    code: 'AED',
    usdRate: 0,
  );
}

/// AppAssets
@freezed
class AppAsset with _$AppAsset {
  /// AppAssets
  const factory AppAsset({
    required int id,
    required double balance,
    required AppToken token,
    required String address,
    required String iconNetwork,
    required String iconNetworkName,
    required int walletId,
  }) = _AppAsset;

  /// константный синглтон для семантики "Отсутствие данных"
  static const AppAsset empty = AppAsset(
    id: Consts.invalidIntValue,
    balance: Consts.invalidDoubleValue,
    token: AppToken.empty,
    address: '',
    iconNetwork: '',
    iconNetworkName: '',
    walletId: Consts.invalidIntValue,
  );
}

/// AppTokens
@freezed
class AppToken with _$AppToken {
  /// AppToken
  const factory AppToken({
    required int id,
    required String name,
    required String shortName,
    required String icon,
    required String usdPrice,
    required double prevPriceDiffPercent,
    required String contractAddress,
    required int decimal,
    @Default(false) bool isAddedToAssets,
  }) = _AppToken;

  /// константный синглтон для семантики "Отсутствие данных"
  static const AppToken empty = AppToken(
    id: 0,
    name: '',
    shortName: '',
    icon: '',
    usdPrice: '',
    prevPriceDiffPercent: 0,
    contractAddress: '',
    decimal: Consts.invalidIntValue,
  );
}
