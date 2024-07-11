part of 'provider.cg.dart';

/// RestClient
@RestApi()
abstract interface class _TransactionsClient {
  /// RestClient
  factory _TransactionsClient(Dio dio) = __TransactionsClient;

  /// 6.1. All Wallets Transactions
  @GET('some_api_link')
  Future<TransactionsDto> getTransactions({
    @Path('per_page') int? perPage,
    @Path('page') int? page,
  });

  /// Store (Broadcast)
  @POST('some_api_link')
  Future<EmptyDataDto> postTransaction({
    @Query('hex') required String hex,
  });

  /// Wallet Token Transactions
  @GET('some_api_link')
  Future<TransactionsDto> getTokenTransactions({
    @Path(':wallet_id') required int walletId,
    @Path(':token_id') required int tokenId,
    @Path('per_page') required int perPage,
  });
}
