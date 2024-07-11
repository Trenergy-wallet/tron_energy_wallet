import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/data/config/app_config.dart';
import 'package:trenergy_wallet/data/dto/empty_dto.cg.dart';
import 'package:trenergy_wallet/data/dto/remote_message/notification.cg.dart';
import 'package:trenergy_wallet/data/repo/remote/dio_provider.cg.dart';
import 'package:trenergy_wallet/domain/empty_data.cg.dart';
import 'package:trenergy_wallet/domain/notification/notification.cg.dart';
import 'package:trenergy_wallet/logic/repo/notifications/notifications.dart';

part 'gen/provider.cg.g.dart';

part 'client.cg.dart';

/// Провайдер репозитория кошельков
@riverpod
NotificationsRepo notifications(NotificationsRef ref) => NotificationsImpl(ref);

/// Имплементация удаленного репозитария.
final class NotificationsImpl implements NotificationsRepo {
  /// Имплементация удаленного репозитария.
  NotificationsImpl(this.ref)
      : _client =
            _NotificationsClient(ref.read(dioProvider(AppConfig.apiEndpoint)));

  ///
  final Ref ref;

  final _NotificationsClient _client;

  @override
  Future<ErrOrNotifications> fetch() {
    return safeFunc(() async {
      final dto = await _client.fetch();
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrEmptyData> storeToken(String token) {
    return safeFunc(() async {
      final dto = await _client.storeToken(token);
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrEmptyData> read(String notificationId) {
    return safeFunc(() async {
      final dto = await _client.read(notificationId);
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrEmptyData> unread(String notificationId) {
    return safeFunc(() async {
      final dto = await _client.unread(notificationId);
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrEmptyData> readAll() {
    return safeFunc(() async {
      final dto = await _client.readAll();
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrEmptyData> delete(String notificationId) {
    return safeFunc(() async {
      final dto = await _client.delete(notificationId);
      final domain = dto.toDomain();
      return domain;
    });
  }

  @override
  Future<ErrOrEmptyData> deleteAll() {
    return safeFunc(() async {
      final dto = await _client.deleteAll();

      final domain = dto.toDomain();
      return domain;
    });
  }
}
