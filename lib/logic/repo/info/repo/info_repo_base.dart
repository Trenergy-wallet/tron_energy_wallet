import 'package:trenergy_wallet/core/extended_errors.cg.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/domain/info/estimate_fee.cg.dart';
import 'package:trenergy_wallet/domain/wallet/wallet.cg.dart';
import 'package:trenergy_wallet/domain/wallet/wallet_type.cg.dart';

/// Интерфейс info репозитория
// ignore: one_member_abstracts
abstract interface class InfoRepo {
  /// 2.3. Currency List
  Future<ErrOrListAppBlockchain> getListBlockchains();

  /// 2.3. Currency List
  Future<ErrOrListAppCurrency> getListCurrency();

  /// 2.3. Validate Tron Address
  Future<ErrOrWalletTypeCheck> walletTypeCheck({required String address});

  /// 2.4. Estimate Tx Energy Fee
  Future<ErrOrEstimateFee> estimateFee();
}

///
typedef ErrOrListAppCurrency = Either<ExtendedErrors, List<AppCurrency>>;

///
typedef ErrOrListAppBlockchain = Either<ExtendedErrors, List<AppBlockchain>>;

/// сокращатель
typedef ErrOrEstimateFee = Either<ExtendedErrors, EstimateFee>;
