part of 'provider.cg.dart';

/// RestClient
@RestApi()
abstract interface class _TronEnergyPipeClient {
  /// RestClient
  factory _TronEnergyPipeClient(Dio dio) = __TronEnergyPipeClient;

  /// 7.1. Get Tron Energy Info
  @GET('some_api_link')
  Future<TronEnergyPipeDto> getTronEnergyPipe();
}
