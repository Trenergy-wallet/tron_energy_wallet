import 'package:firebase_messaging/firebase_messaging.dart';

/// Для разборка в домен сообщения из пуша
extension RemoteMessageX on RemoteMessage {
  /// аналог toString суперкласса
  String asString() => 'id: $messageId, \nfrom: $from,\n'
      ' notification: title:${notification?.title}, '
      'body:${notification?.body} \n'
      ' data: $data';
}
