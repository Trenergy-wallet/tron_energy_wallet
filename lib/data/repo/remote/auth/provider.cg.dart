import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/data/config/app_config.dart';
import 'package:trenergy_wallet/data/dto/auth/auth.cg.dart';
import 'package:trenergy_wallet/data/dto/auth/token.cg.dart';
import 'package:trenergy_wallet/data/repo/remote/dio_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/auth/repo/auth_repo_base.dart';

part 'gen/provider.cg.g.dart';

part 'client.cg.dart';

/// Провайдер репозитория кошельков
@riverpod
AuthRepo auth(AuthRef ref) => RemoteAuthImpl(ref);

/// Имплементация удаленного репозитария.
final class RemoteAuthImpl implements AuthRepo {
  /// Имплементация удаленного репозитария.
  RemoteAuthImpl(this.ref)
      : _client = _AuthClient(ref.read(dioProvider(AppConfig.apiEndpoint)));

  ///
  final Ref ref;

  final _AuthClient _client;

  @override
  Future<ErrOrAuth> fetchAuthMessage() {
    return safeFunc(() async {
      final dto = await _client.fetchAuthMessage();
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrToken> authMessage({
    required String address,
    required String signature,
    required String message,
  }) {
    return safeFunc(() async {
      final dto = await _client.authMessage(
        address: address,
        signature: signature,
        message: message,
      );
      final domain = dto.toDomain();
      return domain;
    });
  }
}
