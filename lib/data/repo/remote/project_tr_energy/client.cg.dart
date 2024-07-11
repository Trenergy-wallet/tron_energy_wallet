part of 'provider.cg.dart';

/// RestClient
@RestApi()
abstract interface class _TronEnergyProjectClient {
  /// RestClient
  factory _TronEnergyProjectClient(Dio dio) = __TronEnergyProjectClient;

  /// 9.1. Show Account from Tron Energy Project
  @GET('some_api_link')
  Future<AccountTrEnergyDto> fetchAccount();

  /// 9.3. Get Address For Top Up адрес для пополнения
  @GET('some_api_link')
  Future<WalletTopUpDto> fetchWalletTopUp();

  /// 5.10. Store
  @POST('some_api_link')
  Future<ConsumersStoreDto> postConsumers(@Body() ConsumersBody body);

  /// 5.4. Activate
  @POST('some_api_link')
  Future<EmptyDataDto> activate({
    @Path('consumer_id') required int consumerId,
  });
}
