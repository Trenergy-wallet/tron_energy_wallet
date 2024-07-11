import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/data/config/app_config.dart';
import 'package:trenergy_wallet/data/dto/empty_dto.cg.dart';
import 'package:trenergy_wallet/data/repo/remote/dio_provider.cg.dart';
import 'package:trenergy_wallet/domain/empty_data.cg.dart';
import 'package:trenergy_wallet/logic/repo/assets/repo/assets_repo_base.dart';

part 'gen/provider.cg.g.dart';

part 'client.cg.dart';

/// Провайдер репозитория currency
@riverpod
AssetsRepo assets(AssetsRef ref) => RemoteAssetsImpl(ref);

/// Имплементация удаленного репозитария.
final class RemoteAssetsImpl implements AssetsRepo {
  /// Имплементация удаленного репозитария.
  RemoteAssetsImpl(this.ref)
      : _client = _AssetsClient(ref.read(dioProvider(AppConfig.apiEndpoint)));

  ///
  final Ref ref;

  final _AssetsClient _client;

  @override
  Future<ErrOrEmptyData> addAssets({
    required int walletId,
    required List<int> tokensId,
  }) {
    return safeFunc(() async {
      final dto = await _client.addAssets(
        walletId: walletId,
        tokensId: tokensId,
      );
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrEmptyData> removeAssets({
    required int walletId,
    required List<int> tokensId,
  }) {
    return safeFunc(() async {
      final dto = await _client.removeAssets(
        walletId: walletId,
        tokensId: tokensId,
      );
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrEmptyData> refreshAsset({
    required int walletId,
    required int assetId,
  }) {
    return safeFunc(() async {
      final dto = await _client.refreshAsset(
        walletId: walletId,
        assetId: assetId,
      );
      final domain = dto.toDomain();
      return domain;
    });
  }
}
