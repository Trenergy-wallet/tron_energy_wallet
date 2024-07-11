import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/data/config/app_config.dart';
import 'package:trenergy_wallet/data/dto/empty_dto.cg.dart';
import 'package:trenergy_wallet/data/dto/favorites/favorites.cg.dart';
import 'package:trenergy_wallet/data/repo/remote/dio_provider.cg.dart';
import 'package:trenergy_wallet/domain/empty_data.cg.dart';
import 'package:trenergy_wallet/logic/repo/favorites/repo/favorites_repo_base.dart';

part 'gen/provider.cg.g.dart';

part 'client.cg.dart';

/// Провайдер репозитория избранных адресов.
@riverpod
FavoritesRepo favorites(FavoritesRef ref) => RemoteFavoritesImpl(ref);

/// Имплементация удаленного репозитария.
final class RemoteFavoritesImpl implements FavoritesRepo {
  /// Имплементация удаленного репозитария.
  RemoteFavoritesImpl(this.ref)
      : _client =
            _FavoritesClient(ref.read(dioProvider(AppConfig.apiEndpoint)));

  ///
  final Ref ref;

  final _FavoritesClient _client;

  @override
  Future<ErrOrFavorites> getFavorites() {
    return safeFunc(() async {
      final dto = await _client.getFavorites();
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrEmptyData> postFavorites({
    required String address,
    String? name,
  }) {
    return safeFunc(() async {
      final dto = await _client.postFavorites(
        address: address,
        name: name,
      );
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrEmptyData> patchFavorites({
    required int favoriteId,
    required String name,
    required String address,
  }) {
    return safeFunc(() async {
      final dto = await _client.patchFavorites(
        favoriteId: favoriteId,
        name: name,
        address: address,
      );
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrEmptyData> destroyFavorites({required int favoriteId}) {
    return safeFunc(() async {
      final dto = await _client.destroyFavorites(
        favoriteId: favoriteId,
      );
      final domain = dto.toDomain();
      return domain;
    });
  }
}
