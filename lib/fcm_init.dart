part of 'main.dart';

Future<void> _fcmInit() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
}

/// Обработчик мессаджей в бекграунде.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage msg) async {
  await Firebase.initializeApp();
  // Сохраним uuid последнего сообщения, чтобы можно было его открыть
  // после обновления списка нотификаций от бэка
}
