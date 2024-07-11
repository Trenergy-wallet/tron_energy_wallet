import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/extended_errors.cg.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/domain/wallet/wallet.cg.dart';

part 'gen/wallet_type.cg.f.dart';

/// Тип кошелька
enum WalletType {
  ///
  tron(
    currency: 'TRX',
    blockchain: 'Tron',
  ),

  ///
  btc(
    currency: 'BTC',
    blockchain: 'Bitcoin',
  );

  const WalletType({
    required this.currency,
    required this.blockchain,
  });

  /// валюта
  final String currency;

  /// blockchain
  final String blockchain;
}

///
@freezed
class WalletTypeCheck with _$WalletTypeCheck {
  ///
  const factory WalletTypeCheck({
    required AppBlockchain blockchain,
  }) = _WalletTypeCheck;

  const WalletTypeCheck._();

  /// константный синглтон для семантики "Отсутствие данных"
  static const empty = WalletTypeCheck(
    blockchain: AppBlockchain.empty,
  );
}

/// сокращатель
typedef ErrOrWalletTypeCheck = Either<ExtendedErrors, WalletTypeCheck>;
