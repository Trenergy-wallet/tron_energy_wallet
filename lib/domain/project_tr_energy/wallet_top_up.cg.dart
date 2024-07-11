import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/extended_errors.cg.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';

part 'gen/wallet_top_up.cg.f.dart';

/// Адрес кошелька из ендпойнта 9.3
@freezed
class WalletTopUp with _$WalletTopUp {
  /// Операции
  const factory WalletTopUp({
    required String address,
    required String qrCodePath,
  }) = _WalletTopUp;

  /// Заглушка
  static const empty = WalletTopUp(
    address: '',
    qrCodePath: '',
  );
}

/// сокращатель
typedef ErrOrWalletTopUp = Either<ExtendedErrors, WalletTopUp>;
