part of 'provider.cg.dart';

/// RestClient
@RestApi()
abstract interface class _NotificationsClient {
  /// RestClient
  factory _NotificationsClient(Dio dio) = __NotificationsClient;

  /// 9.2 Store Token
  @POST('some_api_link')
  Future<EmptyDataDto> storeToken(@Field('token') String token);

  /// 8.1. Index (Fetch notifications)
  @GET('some_api_link')
  Future<NotificationDto> fetch();

  /// 8.2. Mark As Read
  @PATCH('some_api_link')
  Future<EmptyDataDto> read(@Path('notification_id') String notificationId);

  /// 8.3. Mark As UnRead
  @PATCH('some_api_link')
  Future<EmptyDataDto> unread(@Path('notification_id') String notificationId);

  /// 8.3.x Mark All As Read
  @PATCH('some_api_link')
  Future<EmptyDataDto> readAll();

  /// 8.4. Destroy
  @DELETE('some_api_link')
  Future<EmptyDataDto> delete(@Path('notification_id') String notificationId);

  /// 8.5. Destroy All
  @DELETE('some_api_link')
  Future<EmptyDataDto> deleteAll();
}
