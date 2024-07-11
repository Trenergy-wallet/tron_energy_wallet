part of 'provider.cg.dart';

/// RestClient
@RestApi()
abstract interface class _AuthClient {
  /// RestClient
  factory _AuthClient(Dio dio) = __AuthClient;

  /// 1.1 Get Auth Message
  @GET('some_api_link')
  Future<AuthDto> fetchAuthMessage();

  /// 1.1 Post Auth Message
  @POST('some_api_link')
  Future<TokenDto> authMessage({
    @Field('address') required String address,
    @Field('signature') required String signature,
    @Field('message') required String message,
  });
}
