part of 'provider.cg.dart';

/// RestClient
@RestApi()
abstract interface class _ChartClient {
  /// RestClient
  factory _ChartClient(Dio dio) = __ChartClient;

  /// Get Chart
  @GET('some_api_link')
  Future<ChartHistoricalDto> getChart({
    @Path('currency') required String currency,
  });

  /// Get Chart intraday
  @GET('some_api_link')
  Future<List<HistoricalDto>> getIntraDay({
    @Path('currency') required String currency,
    @Path('from') required String from,
    @Path('to') required String to,
    @Path('timeIntraday') required String timeIntraday,
  });
}
