import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trenergy_wallet/core/extended_errors.cg.dart';
import 'package:trenergy_wallet/core/safe_coding/safe_coding.dart';

part 'gen/notification.cg.f.dart';

/// Первичный тип для нотификации.
///
/// Как только будет известна структура - тип подредактируется.
@freezed
sealed class Notification with _$Notification {
  /// Нотификация о платеже.
  const factory Notification.payment({
    required String id,
    required NotificationType type,
    required DateTime? createdAt,
    required DateTime? readAt,
    required double amount,
    // --------------------
    required double balance,
    required String unit,
  }) = NotificationPayment;

  /// Нотификация об энергии.
  const factory Notification.energy({
    required String id,
    required NotificationType type,
    required DateTime? createdAt,
    required DateTime? readAt,
    required String? amount,
  }) = NotificationEnergy;

  /// Нам по-прежнему пока нужен пустой тип.
  static const Notification empty = Notification.energy(
    id: '',
    type: NotificationType.unknown,
    createdAt: null,
    readAt: null,
    amount: '',
  );
}

///
typedef ErrOrNotifications = Either<ExtendedErrors, List<Notification>>;

/// Варианты нотификации.
///
/// - [unknown] - неизвестная нотификация, для заполнения.
/// - [incoming] - нотификация о входящем платеже.
/// - [outgoing] - нотификация об исходящем платеже.
/// - [energy] - нотификация о потреблении.
///
enum NotificationType {
  /// Неизвестная нотификация, для заполнения.
  unknown,

  /// Нотификация о платеже.
  incoming,

  /// Нотификация о платеже.
  outgoing,

  /// Нотификация о потреблении.
  energy,
}
