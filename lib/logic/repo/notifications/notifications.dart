import 'package:trenergy_wallet/domain/empty_data.cg.dart';
import 'package:trenergy_wallet/domain/notification/notification.cg.dart';

/// Интерфейс notifications репозитория
abstract interface class NotificationsRepo {
  /// 9.1. Store Token - Store FCM token
  Future<ErrOrEmptyData> storeToken(String token);

  /// 8.1. Get list of notifications
  Future<ErrOrNotifications> fetch();

  /// Отметить как прочтенный
  Future<ErrOrEmptyData> read(String notificationId);

  /// Сброс флага прочтенного.
  /// Используется в-основном для тестового восстановления флага.
  Future<ErrOrEmptyData> unread(String notificationId);

  /// Отметить все как прочтенные
  Future<ErrOrEmptyData> readAll();

  /// Удалить
  Future<ErrOrEmptyData> delete(String notificationId);

  /// Удалить все
  Future<ErrOrEmptyData> deleteAll();
}
