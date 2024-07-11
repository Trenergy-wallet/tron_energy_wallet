import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/consts.dart';
import 'package:trenergy_wallet/core/ext.dart';
import 'package:trenergy_wallet/core/helpers.dart';
import 'package:trenergy_wallet/core/safe_coding/safe_coding.dart';
import 'package:trenergy_wallet/domain/notification/notification.cg.dart';

part 'gen/notification.cg.f.dart';

part 'gen/notification.cg.g.dart';

/// DTO для уведомлений
@freezed
class NotificationDto with _$NotificationDto {
  /// DTO для уведомлений
  const factory NotificationDto({
    required bool status,
    Map<String, dynamic>? errors,
    List<NotificationDataDto>? data,
  }) = _NotificationDto;

  /// Конвертация в доменный тип.
  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);

  const NotificationDto._();

  /// Защищенное конвертирование в доменный тип.
  ErrOrNotifications toDomain() {
    return safeToDomain(
      () => Right(
        data?.map((e) => e.toDomain()).toList() ?? [],
      ),
      status: status,
      errors: errors,
      response: data,
    );
  }
}

/// DTO для уведомлений
@freezed
class NotificationDataDto with _$NotificationDataDto {
  /// DTO для уведомлений
  const factory NotificationDataDto({
    String? id,
    int? type,
    String? createdAt,
    String? readAt,
    Map<String, dynamic>? data,
    // double? amount,
    // double? balance,
    // String? unit,
  }) = _NotificationDataDto;

  /// Конвертация в доменный тип.
  factory NotificationDataDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataDtoFromJson(json);

  const NotificationDataDto._();

  ///
  Notification toDomain() {
    final type = switch (this.type ?? Consts.invalidIntValue) {
      1 => NotificationType.incoming,
      2 => NotificationType.outgoing,
      3 => NotificationType.energy,
      _ => NotificationType.unknown,
    };

    return switch (type) {
      NotificationType.incoming ||
      NotificationType.outgoing =>
        Notification.payment(
          id: id ?? '',
          type: type,
          createdAt: createdAt?.dateTimeWithTimeFromBackend,
          readAt: readAt?.dateTimeWithTimeFromBackend,
          amount: BackendGuard.tryParseDouble(data?['amount']) ??
              Consts.invalidDoubleValue,
          balance: BackendGuard.tryParseDouble(data?['balance']) ??
              Consts.invalidDoubleValue,
          unit: data?['unit'] as String? ?? '',
        ),
      NotificationType.energy => Notification.energy(
          id: id ?? '',
          type: type,
          createdAt: createdAt?.dateTimeWithTimeFromBackend,
          readAt: readAt?.dateTimeWithTimeFromBackend,
          amount: data?['amount'] as String? ?? '',
        ),
      _ => Notification.empty,
    };
  }
}
