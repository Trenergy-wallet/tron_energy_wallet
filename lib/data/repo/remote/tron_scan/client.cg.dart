part of 'provider.cg.dart';

/// RestClient
@RestApi()
abstract interface class _TronScanClient {
  /// RestClient
  factory _TronScanClient(Dio dio) = __TronScanClient;

  /// 7.1. Get Tron Scan Info
  @GET('some_api_link')
  Future<TronScanDto> getTronScan({
    @Path('hash') required String hash,
  });
}
