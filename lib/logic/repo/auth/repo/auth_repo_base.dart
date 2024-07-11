import 'package:trenergy_wallet/core/extended_errors.cg.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/domain/auth/auth.cg.dart';
import 'package:trenergy_wallet/domain/auth/token.cg.dart';

/// Интерфейс auth репозитория
abstract interface class AuthRepo {
  /// 1.1 Get Auth Message
  Future<ErrOrAuth> fetchAuthMessage();

  /// 1.1 Post Auth Message
  Future<ErrOrToken> authMessage({
    required String address,
    required String signature,
    required String message,
  });
}

///
typedef ErrOrAuth = Either<ExtendedErrors, Auth>;

///
typedef ErrOrToken = Either<ExtendedErrors, Token>;
