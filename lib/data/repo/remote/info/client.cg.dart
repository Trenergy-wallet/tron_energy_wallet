part of 'provider.cg.dart';

/// RestClient
@RestApi()
abstract interface class _InfoClient {
  /// RestClient
  factory _InfoClient(Dio dio) = __InfoClient;

  /// 2.1 Blockchain List
  @GET('some_api_link')
  Future<BlockchainsDto> getListBlockchains();

  /// 2.3. Currency List
  @GET('some_api_link')
  Future<CurrenciesDto> getListCurrency();

  /// 2.3. Validate Tron Address
  @GET('some_api_link')
  Future<WalletTypeCheckDto> walletTypeCheck({
    @Query('address') required String address,
  });

  /// 2.4. Estimate Tx Energy Fee
  @GET('some_api_link')
  Future<EstimateFeeDto> estimateFee();
}
