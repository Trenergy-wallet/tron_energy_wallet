import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/data/config/app_config.dart';
import 'package:trenergy_wallet/data/dto/empty_dto.cg.dart';
import 'package:trenergy_wallet/data/dto/transactions/transactions.cg.dart';
import 'package:trenergy_wallet/data/repo/remote/dio_provider.cg.dart';
import 'package:trenergy_wallet/domain/empty_data.cg.dart';
import 'package:trenergy_wallet/logic/repo/transactions/repo/transactions_repo_base.dart';

part 'gen/provider.cg.g.dart';

part 'client.cg.dart';

/// Провайдер репозитория кошельков
@riverpod
TransactionsRepo transactions(TransactionsRef ref) =>
    RemoteTransactionsImpl(ref);

/// Имплементация удаленного репозитария.
final class RemoteTransactionsImpl implements TransactionsRepo {
  /// Имплементация удаленного репозитария.
  RemoteTransactionsImpl(this.ref)
      : _client = _TransactionsClient(
          ref.read(dioProvider(AppConfig.apiEndpoint)),
        );

  ///
  final Ref ref;

  final _TransactionsClient _client;

  @override
  Future<ErrOrTransactions> getTransactions({
    int? perPage,
    int? page,
  }) {
    return safeFunc(() async {
      final dto = await _client.getTransactions(
        page: page,
        perPage: perPage ?? Consts.perPage,
      );
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrEmptyData> postTransaction({
    required String hex,
  }) {
    return safeFunc(() async {
      final dto = await _client.postTransaction(
        hex: hex,
      );
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrTransactions> getTokenTransactions({
    required int walletId,
    required int tokenId,
    int? perPage,
  }) {
    return safeFunc(() async {
      final dto = await _client.getTokenTransactions(
        walletId: walletId,
        tokenId: tokenId,
        perPage: perPage ?? Consts.perPage,
      );
      final domain = dto.toDomain();
      return domain;
    });
  }
}
