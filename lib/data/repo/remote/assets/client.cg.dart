part of 'provider.cg.dart';

/// RestClient
@RestApi()
abstract interface class _AssetsClient {
  /// RestClient
  factory _AssetsClient(Dio dio) = __AssetsClient;

  /// 4 Refresh Asset Balance
  @GET('some_api_link')
  Future<EmptyDataDto> refreshAsset({
    @Path('wallet_id') required int walletId,
    @Path('asset_id') required int assetId,
  });

  /// 4 Add Assets
  @POST('some_api_link')
  Future<EmptyDataDto> addAssets({
    @Path('wallet_id') required int walletId,
    @Query('tokens[]') required List<int> tokensId,
  });

  /// 4 remove Assets
  @POST('some_api_link')
  Future<EmptyDataDto> removeAssets({
    @Path('wallet_id') required int walletId,
    @Query('tokens[]') required List<int> tokensId,
  });
}
