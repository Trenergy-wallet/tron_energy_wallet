import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/utils.dart';
import 'package:trenergy_wallet/data/dto/remote_message/remote_message.dart';
import 'package:trenergy_wallet/logic/providers/inapp_logger.dart';
import 'package:trenergy_wallet/logic/providers/push_messages_provider.cg.dart';
import 'package:trenergy_wallet/logic/providers/push_notifications_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/account/account_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/repo.cg.dart';
import 'package:trenergy_wallet/logic/repo/transactions/transactions_provider.cg.dart';
import 'package:trenergy_wallet/logic/repo/tron_energy_pipe/tron_energy_pipe_provider.cg.dart';
// ignore_for_file: unnecessary_statements

part 'gen/fcm_provider.cg.g.dart';

/// Контроллер для Firebase CloudMessaging
///
/// НЕТ поддержки web (согласовано с ПМ)
@Riverpod(keepAlive: true)
class Fcm extends _$Fcm {
  FirebaseMessaging get _firebaseMessaging => FirebaseMessaging.instance;

  InAppLogger get _logger => InAppLogger.instance;

  /// Подписка на обновление токена
  late final StreamSubscription<String> _onTokenRefresh;

  /// Подписка для обработки сообщений from a background state
  late final StreamSubscription<RemoteMessage> _onMessageOpenedApp;

  /// Подписка для обработки сообщений в активном состоянии
  late final StreamSubscription<RemoteMessage> _onMessage;

  final _name = 'FcmProvider';

  // RepoBase get _repo => ref.read(repoProvider);

  /// Активна ли подписка на common topic
  bool commonTopicSubscriptionActive = true;

  /// Проинициализирован ли провайдер.
  ///
  /// Избегаем повторной инициализации.
  bool notInitYet = true;

  @override
  String? build() {
    ref.listen(pushNotificationsProvider, (previous, next) {
      if (next & notInitYet) {
        _initMessaging();
      }
      return;
    });

    final ok = ref.read(pushNotificationsProvider);
    if (notInitYet && ok) {
      _initMessaging();
    }

    // Этот null нас не должен беспокоить, тк он возвращается ДО того как
    // отработает initMessaging
    return null;
  }

  Future<void> _initMessaging() async {
    notInitYet = false;
    // Проверяем и, при необходимости, запрашиваем нужные разрешения
    final authorizationStatus =
        (await _firebaseMessaging.requestPermission()).authorizationStatus;
    // Если текущего статуса нет в разрешенных, ничего больше не обрабатываем
    final noPermission = ![
      AuthorizationStatus.authorized,
      AuthorizationStatus.provisional,
    ].contains(authorizationStatus);
    if (noPermission) {
      _logger.logError(
        _name,
        '❌️NO Permission for push notifications. CloudMessaging is disabled',
      );
    } else {
      try {
        // Получаем и обрабатываем первый токен
        final token = await _firebaseMessaging.getToken();

        _handleNewToken(token);

        // Обработка возможного события по обновлению токена
        _onTokenRefresh =
            _firebaseMessaging.onTokenRefresh.listen(_handleNewToken);
        _onTokenRefresh.onError(_handleMessagingError);
        ref.onDispose(_onTokenRefresh.cancel);

        // Обработка сообщений, когда приложение активно
        _onMessage = FirebaseMessaging.onMessage.listen(_handleMessage);
        _onMessage.onError(_handleMessagingError);
        ref.onDispose(_onMessage.cancel);

        // Обработка получения сообщений initialMessage - сообщение получаем
        // когда приложение запускается from a terminated state
        // Once consumed, the RemoteMessage will be removed
        final initialMessage = await _firebaseMessaging.getInitialMessage();
        if (initialMessage != null) _handleInitialMessage(initialMessage);

        // Обработка сообщений, приходящих, когда приложение свернуто
        _onMessageOpenedApp =
            FirebaseMessaging.onMessageOpenedApp.listen(_handleInitialMessage);
        _onMessageOpenedApp.onError(_handleMessagingError);
        ref.onDispose(_onMessageOpenedApp.cancel);

        if (token != null) {
          // _logger.addToLog(_name, '✅ Init: CloudMessaging is enabled');
          await _subscribeTopics();
        } else {
          // _logger.addToLog(
          //     _name,
          //     '❌️NO valid token for push notifications. '
          //     'CloudMessaging is disabled');
        }
      } catch (e) {
        _handleMessagingError(e);
        // _logger.addToLog(_name, '❌️ CloudMessaging is disabled');
      }
    }
  }

  void _handleMessagingError(Object error) {
    // showError(
    //     ExtendedErrors.simple(error.toString()),
    //     prefixForLog: '_firebaseMessaging.onError',
    //   );
  }

  void _handleMessage(RemoteMessage msg) {
    _logger.logWarning(
      'CloudMessagingController] [❕New Message❕',
      msg.asString(),
    );

    ref
      ..invalidate(pushMessagesControllerProvider)
      ..invalidate(transactionsServiceProvider)
      ..invalidate(tronEnergyPipeServiceProvider)
      ..read(accountServiceProvider.notifier).getAccount();

    // msg.toDomain().then((v) {
    //   v.fold(
    //     (l) => showError(l, prefixForLog: '$_name._handleMessage'),
    //     // при получении нового сообщения обновляем список от бэка
    //     (r) => ref.invalidate(pushMessagesControllerProvider),
    //   );
    // });
  }

  void _handleInitialMessage(RemoteMessage msg) {
    // msg.toDomain().then((v) {
    //   v.fold(
    //     (l) => showError(l, prefixForLog: '$_name._handleInitnialMessage'),
    //     (r) {
    //       _repo.local.saveLastNotificationID(msgId: r.data.uuid);
    //       ref.invalidate(pushMessagesControllerProvider);
    //     },
    //   );
    // });
  }

  void _handleNewToken(String? newToken) {
    if (state != newToken) {
      // _logger.logInfoMessage(_name, 'GotToken: $newToken');
      state = newToken;
    }
    if (newToken == null) {
      _logger.logError(
          _name,
          '❌️NO valid token for push notifications. '
          'CloudMessaging is disabled');
    } else {
      ref.read(repoProvider).notifications.storeToken(newToken);
    }
  }

  Future<void> _subscribeTopics() async {
    // final topics =
    //     SubscribeTopic.values.where((e) => e != SubscribeTopic.error)
    //     .toList();
    // final res = await _repo.places
    //     .subscribeTopics(topicIds: topics.map((e) => e.id).toList());
    // res.fold(
    //   (l) => showError(l, prefixForLog: '_subscribeTopics',
    //   showToast: false),
    //   (r) => InAppLogger.instance.addToLog(
    //     _name,
    //     '_subscribeTopics: ${topics.map((e) => e.name).toList().join(',')}
    //     🆗',
    //   ),
    // );
  }
}
