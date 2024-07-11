part of 'provider.cg.dart';

/// RestClient
@RestApi()
abstract interface class _AccountClient {
  /// RestClient
  factory _AccountClient(Dio dio) = __AccountClient;

  /// 3.1. Account
  @GET('some_api_link')
  Future<AccountDto> getAccount();

  /// 3.2. Set Currency
  @POST('some_api_link')
  Future<AccountDto> setCurrency({
    @Field('currency_id') required String currencyId,
  });

  /// 3.3. Destroy
  @DELETE('some_api_link')
  Future<AccountDto> destroyAccount();
}
