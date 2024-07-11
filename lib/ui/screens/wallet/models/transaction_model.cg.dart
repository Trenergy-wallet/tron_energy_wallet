import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/domain/transactions/transactions.cg.dart';

part 'gen/transaction_model.cg.f.dart';

///
@freezed
class TransactionModel with _$TransactionModel {
  ///
  const factory TransactionModel({
    required String title,
    required String type,
    required String address,
    required String currency,
    required double amount,
    required DateTime dateTime,
    required bool hasFailed,
  }) = _TransactionModel;
}

///
Map<DateTime, List<TransactionsData>> groupTransactionsByDate(
  List<TransactionsData> transactions,
) {
  final groupedTransactions = <DateTime, List<TransactionsData>>{};

  for (final transaction in transactions) {
    final parseDate = DateFormat('yyyy-MM-dd').parse(transaction.createdAt);
    final date = DateFormat('yyyy-MM-dd')
        .parse(DateFormat('yyyy-MM-dd').format(parseDate));
    if (!groupedTransactions.containsKey(date)) {
      groupedTransactions[date] = [];
    }
    groupedTransactions[date]!.add(transaction);
  }

  return groupedTransactions;
}
