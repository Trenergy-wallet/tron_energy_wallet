part of 'provider.cg.dart';

/// RestClient
@RestApi()
abstract interface class _FavoritesClient {
  /// RestClient
  factory _FavoritesClient(Dio dio) = __FavoritesClient;

  ///  Favorites
  @GET('some_api_link')
  Future<FavoritesDto> getFavorites();

  /// Post Favorites
  @POST('some_api_link')
  Future<EmptyDataDto> postFavorites({
    @Field('address') required String address,
    @Field('name') String? name,
  });

  /// Patch Favorites
  @PATCH('some_api_link')
  Future<EmptyDataDto> patchFavorites({
    @Path(':favorite:id') required int favoriteId,
    @Field('name') required String name,
    @Field('address') required String address,
  });

  /// Destroy Favorites
  @DELETE('some_api_link')
  Future<EmptyDataDto> destroyFavorites({
    @Path(':favorite:id') required int favoriteId,
  });
}
