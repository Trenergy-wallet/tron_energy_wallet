import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/data/config/app_config.dart';
import 'package:trenergy_wallet/data/dto/account/account.cg.dart';
import 'package:trenergy_wallet/data/repo/remote/dio_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/account/repo/account_repo_base.dart';

part 'gen/provider.cg.g.dart';

part 'client.cg.dart';

/// Провайдер репозитория кошельков
@riverpod
AccountRepo account(AccountRef ref) => RemoteAccountImpl(ref);

/// Имплементация удаленного репозитария.
final class RemoteAccountImpl implements AccountRepo {
  /// Имплементация удаленного репозитария.
  RemoteAccountImpl(this.ref)
      : _client = _AccountClient(ref.read(dioProvider(AppConfig.apiEndpoint)));

  ///
  final Ref ref;

  final _AccountClient _client;

  @override
  Future<ErrOrAccount> getAccount() {
    return safeFunc(() async {
      final dto = await _client.getAccount();
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrAccount> setCurrency({required String currencyId}) {
    return safeFunc(() async {
      final dto = await _client.setCurrency(currencyId: currencyId);
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrAccount> destroyAccount() {
    return safeFunc(() async {
      final dto = await _client.destroyAccount();
      final domain = dto.toDomain();
      return domain;
    });
  }
}
