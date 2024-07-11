import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/domain/meta.cg.dart';
import 'package:trenergy_wallet/domain/wallet/wallet.cg.dart';

part 'gen/transactions.cg.f.dart';

/// Операции
@freezed
class Transactions with _$Transactions {
  /// Операции
  const factory Transactions({
    required List<TransactionsData> data,
    required Meta meta,
  }) = _Transactions;

  /// Заглушка
  static const empty = Transactions(
    data: [],
    meta: Meta.empty,
  );
}

/// Операции данные
@freezed
class TransactionsData with _$TransactionsData {
  /// Операции данные
  const factory TransactionsData({
    required String fromAddress,
    required String toAddress,
    required String txId,
    required double amount,
    required String createdAt,
    required AppToken token,
    required int type,
    required bool isRisky,
  }) = _TransactionsData;
}
