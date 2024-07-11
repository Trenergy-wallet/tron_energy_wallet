import 'package:freezed_annotation/freezed_annotation.dart';

part 'gen/acc_tr_energy.cg.f.dart';

/// Домен ендпойнта 9.1
///
/// Обе даты пришлось сделать nullable, так как по коду удобно иметь
/// константный конструктор, но у DateTime его нет.
@freezed
class AccountTrEnergy with _$AccountTrEnergy {
  /// Домен ендпойнта 9.1
  const factory AccountTrEnergy({
    required double balance,
  }) = _AccountTrEnergy;

  /// константный синглтон для семантики "Отсутствие данных"
  static const AccountTrEnergy empty = AccountTrEnergy(
    balance: 0,
  );
}
