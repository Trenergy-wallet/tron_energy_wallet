import 'package:trenergy_wallet/core/extended_errors.cg.dart';
import 'package:trenergy_wallet/core/safe_coding/src/either.dart';
import 'package:trenergy_wallet/domain/empty_data.cg.dart';
import 'package:trenergy_wallet/domain/favorites/favorites.cg.dart';

/// Интерфейс Favorites репозитория
abstract interface class FavoritesRepo {
  ///  Favorites
  Future<ErrOrFavorites> getFavorites();

  /// Post Favorites
  Future<ErrOrEmptyData> postFavorites({
    required String address,
    String? name,
  });

  /// Patch Favorites
  Future<ErrOrEmptyData> patchFavorites({
    required int favoriteId,
    required String name,
    required String address,
  });

  /// Destroy Favorites
  Future<ErrOrEmptyData> destroyFavorites({
    required int favoriteId,
  });
}

///
typedef ErrOrFavorites = Either<ExtendedErrors, List<Favorites>>;
