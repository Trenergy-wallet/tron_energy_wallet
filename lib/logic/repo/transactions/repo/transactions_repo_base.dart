import 'package:trenergy_wallet/core/extended_errors.cg.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/domain/empty_data.cg.dart';
import 'package:trenergy_wallet/domain/transactions/transactions.cg.dart';

/// Интерфейс transactions репозитория
abstract interface class TransactionsRepo {
  /// 6.1. All Wallets Transactions
  Future<ErrOrTransactions> getTransactions({
    int? perPage,
    int? page,
  });

  /// 6 Store (Broadcast)
  Future<ErrOrEmptyData> postTransaction({
    required String hex,
  });

  /// Wallet Token Transactions
  Future<ErrOrTransactions> getTokenTransactions({
    required int walletId,
    required int tokenId,
    int? perPage,
  });
}

///
typedef ErrOrTransactions = Either<ExtendedErrors, Transactions>;
