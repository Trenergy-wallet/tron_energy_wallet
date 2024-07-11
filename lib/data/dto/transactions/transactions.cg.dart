import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/data/dto/meta.cg.dart';
import 'package:trenergy_wallet/data/dto/wallet/wallet.cg.dart';
import 'package:trenergy_wallet/domain/meta.cg.dart';
import 'package:trenergy_wallet/domain/transactions/transactions.cg.dart';
import 'package:trenergy_wallet/domain/wallet/wallet.cg.dart';
import 'package:trenergy_wallet/logic/repo/transactions/repo/transactions_repo_base.dart';

part 'gen/transactions.cg.f.dart';
part 'gen/transactions.cg.g.dart';

/// TransactionsDto
@freezed
class TransactionsDto with _$TransactionsDto {
  /// TransactionsDto
  const factory TransactionsDto({
    bool? status,
    List<TransactionsDataDto>? data,
    MetaDto? meta,
  }) = _TransactionsDto;

  /// конструктор
  const TransactionsDto._();

  /// используем фабричный конструктор
  factory TransactionsDto.fromJson(Map<String, dynamic> json) =>
      _$TransactionsDtoFromJson(json);

  /// Перевод в toDomain
  Future<ErrOrTransactions> toDomain() {
    return safeFunc(() async {
      final domain = Transactions(
        data: data?.map((e) => e.toDomain()).toList() ?? [],
        meta: meta?.toDomain() ?? Meta.empty,
      );
      return Right(domain);
    });
  }
}

/// Transactions данные
@freezed
class TransactionsDataDto with _$TransactionsDataDto {
  /// Transactions данные
  const factory TransactionsDataDto({
    String? fromAddress,
    String? toAddress,
    String? txId,
    double? amount,
    String? createdAt,
    int? type,
    TokenDto? token,
    bool? isRisky,
  }) = _TransactionsDataDto;

  /// конструктор
  const TransactionsDataDto._();

  /// используем фабричный конструктор
  factory TransactionsDataDto.fromJson(Map<String, dynamic> json) =>
      _$TransactionsDataDtoFromJson(json);

  /// toDomain
  TransactionsData toDomain() {
    return TransactionsData(
      fromAddress: ifNullPrintErrAndSet(
        data: fromAddress,
        functionName: 'TransactionsDataDto.toDomain',
        variableName: 'fromAddress',
        ifNullValue: '',
      ),
      toAddress: ifNullPrintErrAndSet(
        data: toAddress,
        functionName: 'TransactionsDataDto.toDomain',
        variableName: 'toAddress',
        ifNullValue: '',
      ),
      txId: ifNullPrintErrAndSet(
        data: txId,
        functionName: 'TransactionsDataDto.toDomain',
        variableName: 'txId',
        ifNullValue: '',
      ),
      amount: ifNullPrintErrAndSet(
        data: amount,
        functionName: 'TransactionsDataDto.toDomain',
        variableName: 'amount',
        ifNullValue: 0,
      ),
      createdAt: ifNullPrintErrAndSet(
        data: createdAt,
        functionName: 'TransactionsDataDto.toDomain',
        variableName: 'createdAt',
        ifNullValue: '',
      ),
      token: ifNullPrintErrAndSet(
        data: token?.toDomain(),
        functionName: 'TransactionsDataDto.toDomain',
        variableName: 'createdAt',
        ifNullValue: AppToken.empty,
      ),
      type: ifNullPrintErrAndSet(
        data: type,
        functionName: 'TransactionsDataDto.toDomain',
        variableName: 'type',
        ifNullValue: Consts.invalidIntValue,
      ),
      isRisky: ifNullPrintErrAndSet(
        data: isRisky,
        functionName: 'TransactionsDataDto.toDomain',
        variableName: 'isRisky',
        ifNullValue: false,
      ),
    );
  }
}
