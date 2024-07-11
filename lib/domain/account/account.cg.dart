import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/domain/wallet/wallet.cg.dart';

part 'gen/account.cg.f.dart';

/// 3.1. Account
@freezed
class Account with _$Account {
  /// 3.1. Account
  const factory Account({
    required String uuid,
    required String name,
    required String photo,
    required String trenergyToken,
    required double totalUsdBalance,
    required AppCurrency currency,
    required List<AppWallet> wallets,
    required List<AppAsset> assets,
  }) = _Account;

  /// константный синглтон для семантики "Отсутствие данных"
  static const Account empty = Account(
    uuid: '',
    name: '',
    photo: '',
    trenergyToken: '',
    totalUsdBalance: 0,
    currency: AppCurrency.empty,
    wallets: [],
    assets: [],
  );
}
