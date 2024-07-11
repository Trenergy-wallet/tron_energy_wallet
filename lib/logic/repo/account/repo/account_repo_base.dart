import 'package:trenergy_wallet/core/extended_errors.cg.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/domain/account/account.cg.dart';

/// Интерфейс account репозитория
abstract interface class AccountRepo {
  /// 3.1. Account
  Future<ErrOrAccount> getAccount();

  /// 3.2. Set Currency
  Future<ErrOrAccount> setCurrency({
    required String currencyId,
  });

  /// 3.3. Destroy
  Future<ErrOrAccount> destroyAccount();
}

///
typedef ErrOrAccount = Either<ExtendedErrors, Account>;
